Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5396BE77170
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 03:20:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJOsp-0006GC-Me; Thu, 05 Dec 2024 22:19:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tJOsn-0006FT-QN
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 22:19:57 -0500
Received: from mail-ot1-x330.google.com ([2607:f8b0:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tJOsm-0006Ae-9s
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 22:19:57 -0500
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-71d4032b3e9so1415886a34.1
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2024 19:19:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733455195; x=1734059995; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=9N64e/pgYn1nLyblM4Tcpb97CAaIRtiZkD+VUNH0Gl4=;
 b=XnPd//klYcvi7MGkUGT394ZB1HqCSaAIuPJ/DMi2LXRIURPt0ZJiPVp1TTfQhRJDjP
 mQBQjUA69UCAZFS6JPF/YnJ+JpAliFC2vdjtDFqfQvlmIPiA317rKtZ7ZWe6dAMuU5ME
 /zgu0NeXlakd9qgJ5TviTAAB+s+Jx18Qb5v414uMz34VSMJQV0EZaFvqeHIlVXUXJwzT
 4mpuvR+SKEKUCd3ZdAq5Ak3AG57cdjL35I6IDbfmJZmhsmYqGoj2rt5w+nUZm0r8XQCq
 ehdZyiZBVFyLbvvXepewp0TmpRYkb/rJXWYTQSxdT5M0KB0/n3o4tRQyNXk5IHIFUBAd
 Fq6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733455195; x=1734059995;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9N64e/pgYn1nLyblM4Tcpb97CAaIRtiZkD+VUNH0Gl4=;
 b=Hnw3+3wSq7qqLtWuYZM0g8TDUeULI+kuH3ZHCaQ2q/f3/p9jRpoCCYQO9ZCyAtsyDn
 aExGrM+kww2z7w4ndFs+mMRyzWGmjv9RAbBErairv1Ib4v773r5nkKQsWYrHLgN0iWUy
 QgK2q0dG1/175/KOnda0BpR+81Qpkh6+Ki99hH5H8b1Gw+7uGYWizNsg04CiQekBxOUq
 V0JvwG7mzDh1kNoXqTNrjZKGRif/rf+obtH/17uyq4s47LrKbah+K+Qlci7NgnKMy5T/
 Y18CmE+aXpJLh8wimqsafctEe0H2+DPLKHt9VnFqP4FAUUjgrZ0h5kPq3EUARPAU1eNV
 PfkQ==
X-Gm-Message-State: AOJu0Yz0sZQA9/XTbC7RUaGXknSlHUjteEH3SJ6jhM5H9ioTWRYym5iC
 S9SaU+KSUErgQYncHc0pxvNAJX9u7wQ2Klz8s9DBjXXc039+usuJqdNQTGbetZoUTzC0Y2FJBsN
 IWM+OGtIp
X-Gm-Gg: ASbGncvPsZ3uh0iP9BrxvvQUlFyXrq96c95kdJVsVX1r6Ep0mSAm5U9h4q1GL8CFITZ
 i8Y7t9aZE1LLeEFlc+XgolTXfN4GMgO7HA1TJM1IaZwCWckO25dL5iO4R1HRCCW8r7wBtjULPsi
 A4DjYuBvg1crWS3KaDvTL3Gm3rPWe4+jhquxhQ564loDbOMM5FG600k5HTsnU/rNbrxWqrHUpGm
 Y1sCNcZeMjjUdpVcoxl8E/CHoGktGIfjJ/NxoRVlw9Y8TFy7mftCVluIjKB+k7zL6NIsu2YZEsF
 Ay9H8hJvTVO9Xtjw4Nlq6uENEvVlwHpxj3wY
X-Google-Smtp-Source: AGHT+IGdTjt2EOWXZCX5uR4YlHzx4NQtw+8N2yyoCFQxhFNVQp8rJXCsD0rsftKOjVEjZn6fnjHWmg==
X-Received: by 2002:a9d:5ccc:0:b0:71d:53b6:ef5a with SMTP id
 46e09a7af769-71dc2c64885mr2443693a34.6.1733455194894; 
 Thu, 05 Dec 2024 19:19:54 -0800 (PST)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5f2793255bbsm541045eaf.40.2024.12.05.19.19.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Dec 2024 19:19:54 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 0/2] target/arm: Two more float_status conversions
Date: Thu,  5 Dec 2024 21:19:50 -0600
Message-ID: <20241206031952.78776-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::330;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Peter,

You probably have something like this in your AFP tree already,
but while I'm sending all of the other float_status patches, I
thought I might as well send these two.

Based-on: 20241206031224.78525-1-richard.henderson@linaro.org
(target/arm: Helper type cleanups)

r~

Richard Henderson (2):
  target/arm: Use float_status in helper_fcvtx_f64_to_f32
  target/arm: Use float_status in helper_vfp_fcvt{ds,sd}

 target/arm/helper.h            |  4 ++--
 target/arm/tcg/helper-a64.h    |  2 +-
 target/arm/tcg/helper-a64.c    |  3 +--
 target/arm/tcg/translate-a64.c | 17 +++++++++++------
 target/arm/tcg/translate-vfp.c |  4 ++--
 target/arm/vfp_helper.c        |  8 ++++----
 6 files changed, 21 insertions(+), 17 deletions(-)

-- 
2.43.0


