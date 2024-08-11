Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0069C52D7C
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Aug 2024 14:14:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sd9KW-0005Ye-CM; Sun, 11 Aug 2024 10:13:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joe@pf.is.s.u-tokyo.ac.jp>)
 id 1sd1N9-0007T2-To
 for qemu-devel@nongnu.org; Sun, 11 Aug 2024 01:44:07 -0400
Received: from mail-io1-xd33.google.com ([2607:f8b0:4864:20::d33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joe@pf.is.s.u-tokyo.ac.jp>)
 id 1sd1N7-0000k7-10
 for qemu-devel@nongnu.org; Sun, 11 Aug 2024 01:44:07 -0400
Received: by mail-io1-xd33.google.com with SMTP id
 ca18e2360f4ac-81f921c40f2so131649739f.0
 for <qemu-devel@nongnu.org>; Sat, 10 Aug 2024 22:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com; s=20230601; t=1723355042;
 x=1723959842; darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=b3ni80TmcfFPDDy+2o1RhH8opiDXCpzTFuSue7Ko/ys=;
 b=tdHeBWHMzYvEtvyKOeUx17tgUZSXCyxX2rvFPlxBJMMzo1R5wIXhaHsaNp1h5RLEf6
 /Mupu42WSgcssgo5YAaIStFDTHityNfGj7r5rKSFZYv/AtiV6zZUCnHxtUFRgJUzDvI2
 LDFfnH9BN+g2+sRbnjKP9pmDxgTlSlRPG27NqzWPMCX9c1N4bmeooVA9C3qiccZWJc4m
 OdmveWWEwe8gkOJ21g7R22rEle3+0U85e1g+K/J1cwgG1ENPdHNkuxkFHR9ZpSLfutNI
 OhCvTQP6r2IJS+DY5VUJ7qleW6LHw/6+gMaTsCv1NfUKORlOakPSgrf1f5w6cvI/qQCo
 lSGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723355042; x=1723959842;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=b3ni80TmcfFPDDy+2o1RhH8opiDXCpzTFuSue7Ko/ys=;
 b=Y0fAeFWyeEFNutA4t8qnbJ3J8dxrh9LbDyZ0Df9E6IhtM03sdV+rI1O79T6aD+fsYL
 5NOhCy8OyG6KmZoOVzU31PtbdfQDWx2fBcjiioUO5TBuW4eqp5uF/iOAy/xsAiOm2dSl
 5mWg/NIeK3gxCTSklp2b0rwL6jMu8VYaOXY9A3VJ1zv6zZimfDh0H05+SjM+jNE7fKbj
 GDD0/aspBMWAJpk1sOFDNmYEXPI3utvPK0NsG5Pn/09Iy1hlC+O3+TEE5Mc+megahHGF
 uDf3+Xzfnxt8md7ocNvKfKblW5FmX1qHPB+IKC/rvd039CHfMa1P//Q543u1dyXPXrDt
 i38w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWg5tUXMK1cqPKMba6tIZr5HrLSQ58DJKLXI67oMOfNJzB+KYMtEHh5F7faC9bm9NMhhXKMe9m0W38t@nongnu.org
X-Gm-Message-State: AOJu0YzIDajqSdlTTzVpqtNbgqvfdwJ+7jleg3P3clDLpoHst56kdwGe
 mr8jrj0Lb9mtNsl4GQxB1H1IOhx7fd6poHniqCBzacnl52a9M5q7IYHvoAR07s4=
X-Google-Smtp-Source: AGHT+IFBdJAHaaSBvMVD6UtjsiKHYLPAkLKDi4yHKSw/uqzAXlPRX/bC7lQkFzvZdc3dVx2ZspczBQ==
X-Received: by 2002:a92:ca4e:0:b0:39b:324a:d381 with SMTP id
 e9e14a558f8ab-39b748538fdmr87605725ab.2.1723355041948; 
 Sat, 10 Aug 2024 22:44:01 -0700 (PDT)
Received: from localhost.localdomain ([2001:f70:2520:9500:9236:bb5d:265b:266a])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-200bb9b210asm18385035ad.134.2024.08.10.22.44.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 Aug 2024 22:44:01 -0700 (PDT)
From: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
To: peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
Subject: [PATCH] target/arm/tcg: Fix overflow in matrix-multiply accumulate
Date: Sun, 11 Aug 2024 14:43:41 +0900
Message-Id: <20240811054341.745674-1-joe@pf.is.s.u-tokyo.ac.jp>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::d33;
 envelope-from=joe@pf.is.s.u-tokyo.ac.jp; helo=mail-io1-xd33.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sun, 11 Aug 2024 10:13:47 -0400
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

Arm's intrinsic matrix multiply accumulate instructions take two 8-bit
vector and add up a 32-bit vector. Current emulation causes overflow
when large 8-bit integers are used. This commit fixes the issue by
casting the 8-bit integers to 32-bit integers before multiplication.

Fixes: 2323c5ffd4b5 ("target/arm: Implement integer matrix multiply accumulate")
Signed-off-by: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
---
 target/arm/tcg/vec_helper.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/arm/tcg/vec_helper.c b/target/arm/tcg/vec_helper.c
index 98604d170fd3..e9c33520232a 100644
--- a/target/arm/tcg/vec_helper.c
+++ b/target/arm/tcg/vec_helper.c
@@ -2718,7 +2718,7 @@ static uint32_t do_smmla_b(uint32_t sum, void *vn, void *vm)
     int8_t *n = vn, *m = vm;
 
     for (intptr_t k = 0; k < 8; ++k) {
-        sum += n[H1(k)] * m[H1(k)];
+        sum += (uint32_t)n[H1(k)] * (uint32_t)m[H1(k)];
     }
     return sum;
 }
@@ -2728,7 +2728,7 @@ static uint32_t do_ummla_b(uint32_t sum, void *vn, void *vm)
     uint8_t *n = vn, *m = vm;
 
     for (intptr_t k = 0; k < 8; ++k) {
-        sum += n[H1(k)] * m[H1(k)];
+        sum += (uint32_t)n[H1(k)] * (uint32_t)m[H1(k)];
     }
     return sum;
 }
@@ -2739,7 +2739,7 @@ static uint32_t do_usmmla_b(uint32_t sum, void *vn, void *vm)
     int8_t *m = vm;
 
     for (intptr_t k = 0; k < 8; ++k) {
-        sum += n[H1(k)] * m[H1(k)];
+        sum += (uint32_t)n[H1(k)] * (uint32_t)m[H1(k)];
     }
     return sum;
 }
-- 
2.34.1


