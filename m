Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA040C5DF7D
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 11:02:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxN0J-00061X-JT; Fri, 21 Aug 2026 07:01:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wxN04-00060V-My
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 07:01:29 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wxN03-0007DN-2E
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 07:01:28 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-495437bb891so4354105e9.1
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2026 04:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787310085; x=1787914885; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=M8ntjgm7jIcw+9TY3XDn9SgfpMJGB29k63pL7C9Qq9o=;
 b=i/IeYJ5vBv0iOw/6EBK6fOZCJiuYOfwodId8xX28wtQ2kiTkkwvkz5LmG4UTdcVji2
 WLl14KmBzl5D0QUROjFdSLWR4N7vizgvkSHrB3ipOT3Mo/b2KC5iZd3sRdL8GXXXNyUi
 zTetLBHfjJMS3l3Iv32Hm5y/3P8fl5AMsaOPNpRjHdu6+6kEL3UCUAvCLDyLIc0r7Ie6
 2gYRzL08tNWvpP8p+dy/DvaLCYJsNVo+ZNZ4Xmiip29tKCrkQrzBMDSs0sW03/xNtGiN
 L4MvMrqzt+rRfb+qK5o3pAh62JeoYg4m4ap60vhAdestZ9hP0raeOIqBAJLdddOklo3u
 bQ7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787310085; x=1787914885;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=M8ntjgm7jIcw+9TY3XDn9SgfpMJGB29k63pL7C9Qq9o=;
 b=jP/PhxjMwpjRyEH3g48dWVra/p8t6/sITiXjcmjyrzzf1YDQCXNmDNrTpt4scm24L+
 CBDJwMGwClLqeSEqrtPcz7iMgG8xcbHdnct8xXBDhAZlHfDz+Qygtvv1Rl+PEV5Xx7pU
 7QOTWVoD1SbkME+vbKDBllXOHlNY5sX0sEAibv+amZ1c0rFj5v0imEDog1/u1dA7bDl9
 29SR+wOzMSdkJe1KmhAKX5j8eTapsoit76G4RlDyVhSEialSuRxBSey6bhPq6tKiRH6H
 wgOZHfrmsTSme6sSfhgTryJqAbOZ23usOrm69OR9xgYTnHiC5PRVRz6v3x/Gv43jNIHO
 lJrg==
X-Gm-Message-State: AOJu0Yzk3Jh961nUHTA7rvTycwc5pxQCLxHq2vjtKKtXJK3bf1Endlf5
 CBRoiK8KJdabpAaG2G5Jd2RgxUgLFvjL31rxnN1fWhRzHSwdpmrV/V7RgCwP1OCb8WEx/AJiv/K
 nsp/F
X-Gm-Gg: AR+sD12ZCf8iNWJKtgyLxP/upZe26rW1iddsCF1/81cbets5K7Mhl0l0zM2b3ShJRoL
 sQATTCXXtc1TH5WOah71gzM3bihkKG0axVud7hp22+8NJUtKheQfGKt5JzYk11MhBsfplS9VKSZ
 liMtLilZefa9zQ2uQBpRYi9Li7djdbrT0CkyDFnOQpL6rbzRpO9Td7YmKg4SSGojmblYiaZl6XF
 sDMDrBSmR6OZCKKNYW9yli7di3LNahH3K/KXb2ahFOnT+ej+50KaduKTwdD1CQHbq6WWkbZ/bsp
 o/oMy84b5QifF2gXlPe4/RkseSiaWsDkpr7AS+pxFB3mBv8A1Dei2EUjE7hoaulxyFX7fAG3K/r
 fpNh8vuF8TGIYv2NsCga15SqOveJzWnP6MVfAzT2va8njGoTH1BSeeq2wLXGNy7iHzoS0jpWFZH
 JpAmLLQZoyoeVYuGxu6O9ivI7hvtcP5uHs/d8YQcUY9T1aKmgVUP994mbhMbWMCE3/TavkVMa4Q
 7yf5dNt99ELAiULINDZ8CV1w5e8bGr6UWi65Wzjc8KBU9jeTLSNAeS7E7Jxs9JDwIrwDw==
X-Received: by 2002:a05:600c:4688:b0:499:5f80:83ac with SMTP id
 5b1f17b1804b1-499b91ad940mr43550835e9.7.1787310085569; 
 Fri, 21 Aug 2026 04:01:25 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499b90e7e20sm22875985e9.5.2026.08.21.04.01.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 04:01:23 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 04/43] target/arm: Tidy cpu_max_initfn
Date: Fri, 21 Aug 2026 12:00:22 +0100
Message-ID: <20260821110101.3971391-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260821110101.3971391-1-peter.maydell@linaro.org>
References: <20260821110101.3971391-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x335.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Richard Henderson <richard.henderson@linaro.org>

Once we have eliminated hwaccel_enabled, only tcg and qtest remain.
Separate tcg from qtest initialization.  Remove an assert on
aarch64_enabled that is directly protected by a preceding if.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-id: 20260812204435.295067-2-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu-max.c | 39 +++++++++++++++++++++------------------
 1 file changed, 21 insertions(+), 18 deletions(-)

diff --git a/target/arm/cpu-max.c b/target/arm/cpu-max.c
index 88b7c046333..0a310d1b15d 100644
--- a/target/arm/cpu-max.c
+++ b/target/arm/cpu-max.c
@@ -203,29 +203,32 @@ static void cpu_max_initfn(Object *obj)
         return;
     }
 
-    if (tcg_enabled() || qtest_enabled()) {
-        aarch64_aa32_a57_init(obj, !aarch64_enabled);
-    }
-
-    if (!aarch64_enabled) {
-        aa32_max_features(cpu);
-#ifdef CONFIG_USER_ONLY
-        /*
-         * Break with true ARMv8 and add back old-style VFP short-vector
-         * support. Only do this for user-mode, where -cpu max is the default,
-         * so that older v6 and v7 programs are more likely to work without
-         * adjustment.
-         */
-        cpu->isar.mvfr0 = FIELD_DP32(cpu->isar.mvfr0, MVFR0, FPSHVEC, 1);
-#endif
-    } else if (tcg_enabled()) {
-        assert(aarch64_enabled);
+    if (tcg_enabled()) {
         /*
          * '-cpu max' for TCG: we currently do this as
          * "A57 with extra things"
          */
-        aarch64_max_tcg_initfn(obj);
+        aarch64_aa32_a57_init(obj, !aarch64_enabled);
+        if (!aarch64_enabled) {
+            aa32_max_features(cpu);
+#ifdef CONFIG_USER_ONLY
+            /*
+             * Break with true ARMv8 and add back old-style VFP short-vector
+             * support. Only do this for user-mode, where -cpu max is the default,
+             * so that older v6 and v7 programs are more likely to work without
+             * adjustment.
+             */
+            cpu->isar.mvfr0 = FIELD_DP32(cpu->isar.mvfr0, MVFR0, FPSHVEC, 1);
+#endif
+        } else {
+            aarch64_max_tcg_initfn(obj);
+        }
+        return;
     }
+
+    /* Ultimate fallback: -cpu max as cortex-a57. */
+    assert(qtest_enabled());
+    aarch64_aa32_a57_init(obj, !aarch64_enabled);
 }
 
 static const ARMCPUInfo arm_max_cpu = {
-- 
2.43.0


