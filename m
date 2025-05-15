Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D420C2D0CD
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 10:41:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFVol-0007Ar-AC; Thu, 15 May 2025 06:27:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uFVnI-0004zW-C9
 for qemu-devel@nongnu.org; Thu, 15 May 2025 06:26:29 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uFVnG-0008CV-Jk
 for qemu-devel@nongnu.org; Thu, 15 May 2025 06:26:28 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43d0618746bso5768175e9.2
 for <qemu-devel@nongnu.org>; Thu, 15 May 2025 03:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747304785; x=1747909585; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=8mOBWal8tapVRsN7QEnlZ5FeGan5WVEqLLtIcBB22dI=;
 b=gpMkYvWPY+PKu6gIV2ekHtOpll2kWSKxVOGk4GaocfQbqfPNpymaEInUqy2CwYZiS5
 8Od473kF2RKGBikE4VmgY3RO6LVwkqhJa8OGCtyzAq0HXxIsK3gwsf5vuCyWHdfbjnvx
 2MxnAKNXtUPJ0/zkAekg3MSIObuO7srYaRPryx52yM41+gL5Sanv6btQ8VVRnteDbuEd
 qlM7s2sON0IUu8764j0hxu2PGAtCQiyLJW5agHalgpGLhsv+teLKJFKXmxLGr6gUAyJi
 ETAKqPHMajVTRsA6qH2rssR5vIW/LkMi8kYHZKqsVRaZI1zRWNGpX7I4rDFjRt/HQoda
 TjBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747304785; x=1747909585;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8mOBWal8tapVRsN7QEnlZ5FeGan5WVEqLLtIcBB22dI=;
 b=QDjj35sSqBWRgqWOnZwkmOlnmX5mBhLPJDux76rS8Xu0ttN7uzpHFv826kltJPMxHV
 vQGlfhen2uZKwE7Ii/6JLjm2M9jiKLVugN4bQ6zgPytCvYn54595v9ZUaBaU5vkWe2LP
 UARNZfKAhVV4MAYH1la9rLiPsOb9ElWJPB4fF72pvMf8bsAK7XnEfJXSP9kOylR2KEj5
 /wxDe+ZL7O+U4k5gVgNGYBm6zO9xjwRPJhv1FbAZi3c8Lrw2ckGt+nzpYINWooT5dpbX
 DKvVOEgNEfEtX+wmanz784UjPDTh0fu8v0CXaDaZh9sLBpXP02ntqRZFlY/2bBgUXzGw
 BEmg==
X-Gm-Message-State: AOJu0YwxfPvdqe1C3oyPI/Dq3Q29LA4gXy2UsoO/gcCntZMM4EJ8I1Qj
 lDB+oFX172hlRBSoUht+xki87ksj+LVQDpcZ4RHZeZhFWRzcvYhlqrUlUuNLx/ALiSwJgeKhF82
 UzlQ=
X-Gm-Gg: ASbGncuR7nQtncLViU99PBUxQOdMYHXu/j9L/u4DtvP9aLj9R0BWpUFuWLbgm6uJPw4
 sRGgPF2dIgr16Wuxm54aASNkVnR+VnBFVz8wzWFpyCqHJx2SBeEqjSpfAERaMrVpSZmFBLUhvDb
 UKb/Dv0vrfxBuWJ3cEmDjYy+RnYXb63JVhCIXa8g/FUOjJS39SLRpoikEk43s25haoSFuYQGt26
 KJX1g3K+aFZBdMksxkpv0hlFcqnoD1pvErfnhiBDeKgNN1WpkVksEdXHwaCqgn19I61+FDU4M5g
 fHJcryLoDJeVSefeIkJ/BZMfbHLwDp0Mm9bSi4D7t3e+XNR0HwG9iaZeAw==
X-Google-Smtp-Source: AGHT+IHE5BwsV+1T8YFnJhSqBX62+ixQJOIxvkaLmI2UWN3Ol1qEib7xvaQ4wgUmR6q3WoLvFAwvBQ==
X-Received: by 2002:a05:600c:3c8f:b0:43d:8ea:8d80 with SMTP id
 5b1f17b1804b1-442f96e5264mr18091015e9.5.1747304785062; 
 Thu, 15 May 2025 03:26:25 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442f396c3a4sm65657855e9.26.2025.05.15.03.26.24
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 May 2025 03:26:24 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 28/58] target/arm/debug_helper: compile file twice (user,
 system)
Date: Thu, 15 May 2025 11:25:16 +0100
Message-ID: <20250515102546.2149601-29-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250515102546.2149601-1-peter.maydell@linaro.org>
References: <20250515102546.2149601-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-id: 20250512180502.2395029-19-pierrick.bouvier@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/meson.build | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/target/arm/meson.build b/target/arm/meson.build
index de214fe5d56..48a6bf59353 100644
--- a/target/arm/meson.build
+++ b/target/arm/meson.build
@@ -1,7 +1,6 @@
 arm_ss = ss.source_set()
 arm_common_ss = ss.source_set()
 arm_ss.add(files(
-  'debug_helper.c',
   'gdbstub.c',
   'helper.c',
   'vfp_fpscr.c',
@@ -29,11 +28,18 @@ arm_system_ss.add(files(
 arm_user_ss = ss.source_set()
 arm_user_ss.add(files('cpu.c'))
 arm_user_ss.add(when: 'TARGET_AARCH64', if_false: files(
-  'cpu32-stubs.c'))
+  'cpu32-stubs.c',
+))
+arm_user_ss.add(files(
+  'debug_helper.c',
+))
 
 arm_common_system_ss.add(files('cpu.c'), capstone)
 arm_common_system_ss.add(when: 'TARGET_AARCH64', if_false: files(
   'cpu32-stubs.c'))
+arm_common_system_ss.add(files(
+  'debug_helper.c',
+))
 
 subdir('hvf')
 
-- 
2.43.0


