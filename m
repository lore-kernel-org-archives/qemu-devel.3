Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44476C3DA5D
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2024 15:41:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sX0Zp-0003Kn-5j; Thu, 25 Jul 2024 11:40:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sX0Zm-0003IZ-FF; Thu, 25 Jul 2024 11:40:18 -0400
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sX0Zk-0008E1-HR; Thu, 25 Jul 2024 11:40:18 -0400
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-3d9c4887533so662673b6e.2; 
 Thu, 25 Jul 2024 08:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721922014; x=1722526814; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=5puEPBKf+rK31Y6OLnJJN/a3ntQ27I2J4CiRWM4wMMo=;
 b=aG7cWwl1eQKVDS+YxQEIWgJUiFzdnvFdC0ZnTzAG+E029EylSZ4LvpUnwd+w/dgitr
 hSYuKW+5LSxbjaaAqd5wnJ0my7IZGJN+cV7fXtySjTskqhstR72hyZ4oxvdSxN3CCG0o
 FpYo8v4e1uNj4lgDZlsY6c8+hbYXEHd2JAADM/v8nOGF4wodZUh3M446HXfV6D1t0R06
 /6KpYnvXtlcamdyLxt2bu1yr1F9rWT1HlJfvT5yCmH2z88vrJkmVlo974z4o75HAc219
 Vd0fq8atUj6c+EZJverqOjHDr1jjIaiOSikN2V6cL8qxUCPG+cqtWKwiJgHrrlTQRg8I
 O/0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721922014; x=1722526814;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5puEPBKf+rK31Y6OLnJJN/a3ntQ27I2J4CiRWM4wMMo=;
 b=ovHvukwQnf6dSFDk44JAslEGHAPziQgd5JTlMejnayA1hYP0RkxXVN2dem64quS7W3
 ljmgRuYfKLACPiAQm4Q2YFWKxpkFTPb7iWDFnAgb69nf6RQ92IFIPtrHOEZEayKuySUA
 WOxP1LrrKYJ7gVdTeDGPmIaWDEEQr4OLGiicjlr5kg9ZrgUdO/knJGLgV3w1ZFS9APct
 juMmGyuRnUD6CnpcQt4H1H/Uh3hGkVvT2tZsNd3u5L7bT3H6NkCPmI1prgK9B+3Vz7NR
 DDJTzhkw6Nw9tWZA+5p9aLdZ0SznBUZ1EKS8kOiFe0WnRfygBhRCN8ulDqWjAiTFUFVy
 v44w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUkpQvIj/E0O9ghRphXub5k0esFl2NIwR35WHdljRX/jhtV5QVP37usf4vUHD9o90jkgge8XVDwyjEddjze01VESKg1
X-Gm-Message-State: AOJu0Yw9V6LN2P6owNdRsE3eIcmwgR9iMQ+W4szEpQdj0spn0tT+18qq
 JoYT5yF93jfAPqKrlXZZbed4tsEPcI6kJ+ARGERnVhgD2iiVDcoDnzEdpw==
X-Google-Smtp-Source: AGHT+IHdu54uIrJZZ2LWElmCa582Hr5Hl3RPVUn/OEHy0x/K8swns8pkcinCbWQpMIMb7LtE3xzPcA==
X-Received: by 2002:a05:6808:3007:b0:3d9:245c:4225 with SMTP id
 5614622812f47-3db10f2686fmr3139468b6e.6.1721922013755; 
 Thu, 25 Jul 2024 08:40:13 -0700 (PDT)
Received: from wheely.local0.net ([203.220.44.216])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7a9f9ec7acdsm1319576a12.66.2024.07.25.08.40.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 08:40:13 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2] tests/tcg: Skip failing ppc64 multi-threaded tests
Date: Fri, 26 Jul 2024 01:40:01 +1000
Message-ID: <20240725154003.428065-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::230;
 envelope-from=npiggin@gmail.com; helo=mail-oi1-x230.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

In Gitlab CI, some ppc64 multi-threaded tcg tests crash when run in the
clang-user job with an assertion failure in glibc that seems to
indicate corruption:

  signals: allocatestack.c:223: allocate_stack:
    Assertion `powerof2 (pagesize_m1 + 1)' failed.

Disable these tests for now.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 tests/tcg/ppc64/Makefile.target | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tests/tcg/ppc64/Makefile.target b/tests/tcg/ppc64/Makefile.target
index 8c3e4e4038..509a20be2b 100644
--- a/tests/tcg/ppc64/Makefile.target
+++ b/tests/tcg/ppc64/Makefile.target
@@ -11,6 +11,18 @@ config-cc.mak: Makefile
 
 -include config-cc.mak
 
+# multi-threaded tests are known to fail (e.g., clang-user CI job)
+# See: https://gitlab.com/qemu-project/qemu/-/issues/2456
+run-signals: signals
+	$(call skip-test, $<, "BROKEN (flaky with clang) ")
+run-plugin-signals-with-%:
+	$(call skip-test, $<, "BROKEN (flaky with clang) ")
+
+run-threadcount: threadcount
+	$(call skip-test, $<, "BROKEN (flaky with clang) ")
+run-plugin-threadcount-with-%:
+	$(call skip-test, $<, "BROKEN (flaky with clang) ")
+
 ifneq ($(CROSS_CC_HAS_POWER8_VECTOR),)
 PPC64_TESTS=bcdsub non_signalling_xscv
 endif
-- 
2.45.2


