Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01817C00A94
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2024 21:40:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rv28z-0003Ne-6N; Thu, 11 Apr 2024 17:39:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rv28y-0003NQ-0K
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 17:39:40 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rv28w-0004lg-BY
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 17:39:39 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-343cfa6faf0so196568f8f.0
 for <qemu-devel@nongnu.org>; Thu, 11 Apr 2024 14:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712871575; x=1713476375; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=93mtXvxGFvM//wmGQr1Q48G9ihTnEyNtUapW7uSn2HY=;
 b=iK+SaXZcTKSMvlZYWUDTEo0n0K9v7F3+k6QcpeNTBsSsqcjd0OeYjzWYZYZV1oOn3A
 MNnIdlzo67AmABHJ3dN9aD/lsK4cgCM0PGDBZnQg75koB6YGszTotXOGYrY7hJkaC2Xn
 bdvB9wpIBeIl38YtadhWyk8LIY8xpcnFJ6SVeYYM1nw65vGzpPxcbBlv9PJflVgouoZ9
 RsVINK76+p2em/wDqY7ZLpmdMSjYcJkkk1JyQC9w62vc4vQYKdcLKfsHxYenLa8jSpyE
 j5fWs1Lan5rs/y0Ceu9tOPzfN1REfy87dSM6s3xevi/0fKb/p7I5qXl+Fjz2kvd3ojW+
 lZqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712871575; x=1713476375;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=93mtXvxGFvM//wmGQr1Q48G9ihTnEyNtUapW7uSn2HY=;
 b=E79hkcv2f2WPN62bEuXBnqrdtZxFChwGIGdfOJtGRERSziefHO8lN8LCCk+gAPaG4p
 YhDddpCiB8C18P2b49kCJJUmUdqJh6Pj1TBR29wA7tSM2b3bULZqYqol9c8B5hw+k1Aw
 XTfoxDZEBmsgwP2nlBOTxUsZP/vEP1qdYmJlfabRVrHQBwSj+gQxV7sKc19TRm/SHT1W
 O3vSYm71cFasEksZiTV2QnE8QxMXcandPcbmrjdmcwd2hFhDEvce0CF6XCp7LjGZaQjW
 CILkDWdEFQvDj5wbFbuujuxoRCsvkclDIXqmdrKjK2CiYcwJoG2IQzOB2VrDkRqjyYgt
 mlpw==
X-Gm-Message-State: AOJu0Yz36cDabmQEyeJ/JI+laBAKpQ1eKy5ukrQ8UweXf4DSFmkQP3X6
 PWq1YezhD5rBivl4EFul3WQYdryUSlekI2xWtZlZYm0s9DNgx9PwanIuvPlG8S1LYnO+z+noQoY
 TCj4=
X-Google-Smtp-Source: AGHT+IH0W7k7oKGauY1FWpngodBa+NuIEKy4Th5oBeXEWesc1/crSLzhUyVfVV0TD/e1PK0LOB0itw==
X-Received: by 2002:adf:f352:0:b0:343:81ea:c539 with SMTP id
 e18-20020adff352000000b0034381eac539mr531155wrp.28.1712871575602; 
 Thu, 11 Apr 2024 14:39:35 -0700 (PDT)
Received: from m1.home (lfbn-bay-1-170-196.w83-193.abo.wanadoo.fr.
 [83.193.250.196]) by smtp.gmail.com with ESMTPSA id
 bl40-20020adfe268000000b00346d886f3d8sm1578837wrb.16.2024.04.11.14.39.34
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 11 Apr 2024 14:39:34 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
 Philippe =?unknown-8bit?q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/2] m68k: Remove sprintf() calls due to macOS deprecation
Date: Thu, 11 Apr 2024 23:39:31 +0200
Message-ID: <20240411213933.36548-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

Continuation of:
https://lore.kernel.org/qemu-devel/20240411101550.99392-1-philmd@linaro.org/

Philippe Mathieu-Daudé (2):
  disas/m68k: Replace sprintf() by snprintf()
  target/m68k: Remove sprintf() calls

 include/disas/dis-asm.h |  2 --
 disas/m68k.c            |  4 ++--
 target/m68k/translate.c | 27 +++++++++++++++------------
 3 files changed, 17 insertions(+), 16 deletions(-)

-- 
2.41.0


