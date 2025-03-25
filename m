Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4161EC35FFC
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 12:40:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tx3ZT-00012c-VG; Tue, 25 Mar 2025 08:39:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tx3ZJ-000120-EH
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 08:39:45 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tx3ZB-0005I8-I1
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 08:39:44 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-43d2d952eb1so41548575e9.1
 for <qemu-devel@nongnu.org>; Tue, 25 Mar 2025 05:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742906375; x=1743511175; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NRiDNSfza2GYouIqjVX2heKQgBy/qgPHwE2OCmqBWtw=;
 b=FwP4QE6eTeYH+Dbks2rNP0MLSU+IakD3qMMpp9Rj8f1OVIarMwqCCTjcejwZ8o+cqp
 BxPUMe2jsGqSkHahcHABkq96K5GARJXpuxq3TVKpS6df9coC7Xh0rTqqaBnQFOzUh5W2
 Tqwl0ky8qw2iCgke5GcUJ1DAwrw9eDAbsczxDcTqFT+QRPeLE/UAg6RibNg0E0fzkyF/
 //in0fk6JcjoTl/YokLAT6EyYaMYDs3PSmljeLBAvIYJeoHLi/jrrHnsKlO1usOyNh++
 6YMvNWLXl+TOEJHgg/wI6bLsJ3OD4ITy7y5x9IlZzccas4DKUtGsIg1c1fLaUIRpiJbJ
 ElaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742906375; x=1743511175;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NRiDNSfza2GYouIqjVX2heKQgBy/qgPHwE2OCmqBWtw=;
 b=plmc8GYIM3QX39El9kP9lsdShYPj5B9VhptE0udhBmunjS7XV6G7R4+m2pL9VquM4S
 rpWipmJj+lAflCnuOl5LsGnHEjW8ORlHBCCJyHa80qQOfFomkurclWddcNZPJvSakgkl
 7of5lmb4nLJXw111QK6x6g/NQY0VkC83BSRlr119tkkzIDe1ip+FBicBijwF6S4WBMiC
 XWkKhNSianAuoY76yF1+rt5q6EDXT0bJ7m1mQgUVP2SjcevP6A/bawWzHNrGqnXD/InC
 xjjQvFrTbIssI6/DJUys33/jK1yVOppnkofDaNcnRclHh65fWRxNSG0hoLWchOqtZcdF
 YvXQ==
X-Gm-Message-State: AOJu0Yzc7wcLAWmk/qPFMzBcaavYCsKwGKJrR6g0DQOex7Tvqxe32LRQ
 654eIJhJenhskzQXgXfVUHLusnQV90aW/kVEi6Sj+0C+866sRweLluQNzw04nXO6TAZCcKFHjxG
 G
X-Gm-Gg: ASbGncuuduGDjBLXLOLS1agrkXChHwgIsVzmq9gMuGTIQ3P/h9rT49Z0fo8q8+VirvJ
 aa8tbMRBF3rAednTjWRvPrUnfQCElTlXsZuVaOg6xvPQ+G11XiwKbbHusDygRJ5QmKnPK4aWpYl
 WCxlOPQPEAKuxaaymG5m7l+OsSviaqjAyBrz7OIk4pJNEWD/gzD5HLX/YUHVk8A19X90AD/rtnL
 XjnB6eG3741oQkJvEj/gRgfGyl8cEOsTwbBV+1MeAUv1sr0YXNgWdCf5/2WVNmFVwoditkn6DqQ
 hbHy56+YceFxxWlS/NbNJirXqScJZPzK7lSuBBrv69MA/h9uWB+Mig71dyZCSxrO4RyfrdChfmT
 HBkqMYFuivWJS9A/AYxE=
X-Google-Smtp-Source: AGHT+IGkR0G5jetXxrJEiY19iSavAKopIU7YGwPotlmAKPc+GqQ11WPVtrBgTS4ZJUlMxtpmE42NpQ==
X-Received: by 2002:a05:600c:4e94:b0:43c:f16a:641e with SMTP id
 5b1f17b1804b1-43d509e2e7bmr122857925e9.6.1742906374865; 
 Tue, 25 Mar 2025 05:39:34 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d4fdbd0a9sm151230465e9.38.2025.03.25.05.39.33
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 25 Mar 2025 05:39:34 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Frederic Konrad <konrad.frederic@yahoo.fr>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.1 1/4] target/sparc: Expose more CPU features
Date: Tue, 25 Mar 2025 13:39:24 +0100
Message-ID: <20250325123927.74939-2-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250325123927.74939-1-philmd@linaro.org>
References: <20250325123927.74939-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Various features were not displayed or settable from command line.

Diff of 'qemu-system-sparc -cpu help':

 ...
   TI-SuperSparc-60     (IU 40000000 FPU 00000000 MMU 01000800 NWINS 8)
   TI-SuperSparc-61     (IU 44000000 FPU 00000000 MMU 01000000 NWINS 8)
   TI-SuperSparc-II     (IU 40000000 FPU 00000000 MMU 08000000 NWINS 8)
 - LEON2                (IU f2000000 FPU 00080000 MMU f2000000 NWINS 8)
 - LEON3                (IU f3000000 FPU 00080000 MMU f3000000 NWINS 8)
 + LEON2                (IU f2000000 FPU 00080000 MMU f2000000 NWINS 8) +shutdown
 + LEON3                (IU f3000000 FPU 00080000 MMU f3000000 NWINS 8) +shutdown +asr17 +cachectrl +powerdown +casa
  Default CPU feature flags (use '-' to remove): mul div fsmuld
 -Available CPU feature flags (use '+' to add): float128
 +Available CPU feature flags (use '+' to add): shutdown asr17 cachectrl powerdown casa float128
  Numerical features (use '=' to set): iu_version fpu_version mmu_version nwindows

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/sparc/cpu.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index 57161201173..37406227cb7 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -548,6 +548,11 @@ static const sparc_def_t sparc_defs[] = {
 /* This must match sparc_cpu_properties[]. */
 static const char * const feature_name[] = {
     [CPU_FEATURE_BIT_FLOAT128] = "float128",
+    [CPU_FEATURE_BIT_TA0_SHUTDOWN] = "shutdown",
+    [CPU_FEATURE_BIT_POWERDOWN] = "powerdown",
+    [CPU_FEATURE_BIT_CACHE_CTRL] = "cachectrl",
+    [CPU_FEATURE_BIT_ASR17] = "asr17",
+    [CPU_FEATURE_BIT_CASA] = "casa",
 #ifdef TARGET_SPARC64
     [CPU_FEATURE_BIT_CMT] = "cmt",
     [CPU_FEATURE_BIT_GL] = "gl",
-- 
2.47.1


