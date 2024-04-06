Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C68FACD1292
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Apr 2024 05:38:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsykH-0002pg-74; Sat, 06 Apr 2024 01:37:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rsykF-0002pL-ON
 for qemu-devel@nongnu.org; Sat, 06 Apr 2024 01:37:39 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rsykD-0006Hz-T6
 for qemu-devel@nongnu.org; Sat, 06 Apr 2024 01:37:39 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1e2a2d5f0b7so21283965ad.1
 for <qemu-devel@nongnu.org>; Fri, 05 Apr 2024 22:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712381856; x=1712986656; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=AfC+CrtVv6s+6WL4tMlOGaII2HG0midNw6Tg7rrdhf8=;
 b=FKEws2BDh5UWAErZjMbSF7QNs8VuN7W16412Iyxxt0z07YJDJodfQxPRBo8sFH/ecD
 JPKKcti4dWE/rorOxtpY33JKmd4BhjqbFwPE99SalsEaXADyx8K/0a48msN3VJQ0yqQF
 /5KCR8ZIZgz0PcUZxhr6iKX4/vaffkuhJoRZ+Vs6OFlfVJEIhmoMWmVIFuOGvkXTFBDu
 fYYQ3v2LiKVcJaZ4eoiJ1+IVRirB31gX2at3OVoD7U1kwGXYde2INn9gsLI5/RyiNEjm
 BtpdyhyxH7NS4fgSa1lohk0rqHdYygKopsy2PuC3uwfiyb+QL77+CsHE/jDDkDfjK859
 JxRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712381856; x=1712986656;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AfC+CrtVv6s+6WL4tMlOGaII2HG0midNw6Tg7rrdhf8=;
 b=JDiICpKOwf9vInD1QGT2lh5GghVpI2oXHOhY7egdA9BpGsgZ3nrTOrtRt54+UIJpzm
 GS2stig8DawdR+faKs48+ZMrE5IaHxzFo54U63+6CqKA08oy+zO6S3BsvqEUYQWn/3GT
 N2YaKcYhB5Pprok/XRe2PIFxNPbO65oQWsxJXusN1XOewbLAnC7zlQDmCdJVe8Vo3alE
 WyYQP2ac/n9Oe+4K9o6fyjhUWXRZ2AXgNs6ngtwn0cEQL2EpHfX1XqTQ7pgx9jfDWyYP
 MjI8jDEphsWnV9WsH8RetKnOB4/GE+6bCbDkkyDwVL8X/NmxHN9TQF/qWMRLgAoQNLmj
 EUUw==
X-Gm-Message-State: AOJu0YxXp1QA99IScKtAw2ZHddHg80/+kCDKB0CoLzNcyEMx0/yOz+MH
 r5RMppSuX2iA+9YD5ytXr2aVxGCwkNKtAix5FqZS5dDQhg25a1saaabZYxaUhsYQJyKmSO6YU6y
 B
X-Google-Smtp-Source: AGHT+IGHuPH08950rQC5/rrgaxcMqqCPEVbmgrxI3VK+ninRs1JCYvvts9boY7W3/6SZTURWkJ+FGw==
X-Received: by 2002:a17:902:c40d:b0:1e2:307f:d283 with SMTP id
 k13-20020a170902c40d00b001e2307fd283mr3558644plk.1.1712381855820; 
 Fri, 05 Apr 2024 22:37:35 -0700 (PDT)
Received: from stoup.. (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 u12-20020a170903124c00b001dc05535632sm2589378plh.170.2024.04.05.22.37.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Apr 2024 22:37:35 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: zack@buhman.org,
	peter.maydell@linaro.org,
	ysato@users.sourceforge.jp
Subject: [PATCH for-9.0 v3 0/4] target/sh4: Fix mac.[lw]
Date: Fri,  5 Apr 2024 19:37:28 -1000
Message-Id: <20240406053732.191398-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Zack's recent patches, tidied a little bit, and with
test cases added.

r~


Richard Henderson (1):
  target/sh4: Merge mach and macl into a union

Zack Buhman (3):
  target/sh4: mac.w: memory accesses are 16-bit words
  target/sh4: Fix mac.l with saturation enabled
  target/sh4: Fix mac.w with saturation enabled

 target/sh4/cpu.h              | 14 ++++++--
 target/sh4/helper.h           |  4 +--
 target/sh4/op_helper.c        | 51 +++++++++++++++-----------
 target/sh4/translate.c        |  4 +--
 tests/tcg/sh4/test-macl.c     | 67 +++++++++++++++++++++++++++++++++++
 tests/tcg/sh4/test-macw.c     | 61 +++++++++++++++++++++++++++++++
 tests/tcg/sh4/Makefile.target |  8 +++++
 7 files changed, 182 insertions(+), 27 deletions(-)
 create mode 100644 tests/tcg/sh4/test-macl.c
 create mode 100644 tests/tcg/sh4/test-macw.c

-- 
2.34.1


