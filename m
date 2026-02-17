Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E613E68157
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Feb 2026 09:52:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsHkV-0002kh-CS; Tue, 17 Feb 2026 04:52:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vsHju-0002L2-Ta
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 04:51:37 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vsHjm-00063r-Jc
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 04:51:24 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2aae4816912so28072915ad.2
 for <qemu-devel@nongnu.org>; Tue, 17 Feb 2026 01:51:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771321877; x=1771926677; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cUYJz053QLtjvsiz/bO4c3UYZbOjR/48eIpI+h985bg=;
 b=KsgyRHQgI//XrzHsmwA8os3MlmElFsLaNEBJBUFtYyyLcaYVXGKEdo2GO4MnZ5Mo5l
 eHjXSsv4j79Rt1Uk/3we9C3pmyeTexW36NaaNos+myVlEMRQwDQ1rYA22BbxqWS+rEZx
 gXy22uzxDBlkPlEYyQ21pAmpkL+qkvLgapOIaFcNfa/vkSareQcIaz7J5+CN2UfuinwA
 JLmlz3jk/Qk1iifQb3dpnxcEDvsRFBmRate+djQ/4g6dpK15i/V0o6t085linfdpRDll
 MMg8p1tD9kpu5v8qKRRnlqHkcdEU+QSfdmJ9QFFWtq6H7M9ZRHBm17QvYMCbnt7RxGjK
 qL1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771321877; x=1771926677;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cUYJz053QLtjvsiz/bO4c3UYZbOjR/48eIpI+h985bg=;
 b=uTdFAPio5Ognn5AEdwmp0VjXPviKtmSJR9PDpFptGjCXlDckMobwOlSNnkGggwjXuv
 BkAcPG+2EipmuYWlkhCDMeFh+DrG1oJavTiyeWmkkZqQWD3Svfd1gvJHoXZG7ekrn1Ls
 i65BKzfe1DljmGoDN/8dXONo6gUVlYJ89Nmb3H/l33jWrwxzLNwX3jDaS8CUcTdNSiVX
 drqF6UEC4tOe+PWyfy3xndBt03D58pfEGjvWsdYWJiZhLH1JzwzkAn/KWz0BysQPGWlI
 UjUbt84rw2r++fGabiTBWuxjU7miM+RJdOHhChVNX1LChCmtDbNQFDDh45KYT02iPLnA
 Ds2g==
X-Gm-Message-State: AOJu0YwVrztFnRyyGR5wEOhXwdYq4KZQVuYKtcUyUkUF5xVvspSG2zXJ
 5XXxDZnnTIIvYoat634QRTsZvlF5z0+OiH1WWowMoHUvfJBYgs5+O1vwlhm6OclW0/2pk1oZYwD
 Qm77W5KA=
X-Gm-Gg: AZuq6aIplemkpAshEBkSlSwVE0sZRMMDr3MId/etEcBw+jzxxt9qI17bdQdcsWAvnWE
 p4ih4GEmCME3+ZvcXdDyMS6bPfm3gnLZXnL5PGHrcol2i37bS8fUvs9S+P4PkEWWiLNkYg+tqZN
 R4f2PQ+DKj4aoMKMjoTffte+ZGyOkflSDdsSIp26maqoWtQjHISaAoSspcTYDbXcZOxer1Ydl1G
 EnalAgNzA4ZGjaVgHd8MlJXbkxhfCV67I0p57V4tFc1IsUybecxSv06YzXAelRFoSzbDtYtxFoX
 RhuHIcB7pF9+bWeQJ1rzxSNWrtOLbu0CR1dpca8Uun6SuLI0+VvlHXBzNGWWur3HxZ1N4x/S4Dm
 2H4fAAKXq2IFI57FCRdOwWXWfY8crU5aqM4xWIimrRhRIF4vi3NNwCr+qMhVqBw2DCb4161Iml6
 8bBIXPKRx4+sr+5JrK+n7uYAzwac74MtWu9SfErUjuTt+wYg13u7ydBvsxiUXzY+0cqZv896bsG
 32pq6kLn2IpK8U3I8xuzZwMqHertwUjkY/+Jm8=
X-Received: by 2002:a17:902:eb83:b0:2aa:d5ea:4e6e with SMTP id
 d9443c01a7336-2ad17457785mr90582025ad.13.1771321877268; 
 Tue, 17 Feb 2026 01:51:17 -0800 (PST)
Received: from localhost.localdomain
 (2403-580b-742d-0-10a2-dce1-aa4a-dd32.ip6.aussiebb.net.
 [2403:580b:742d:0:10a2:dce1:aa4a:dd32])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ad1a6fa33esm99108675ad.13.2026.02.17.01.51.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Feb 2026 01:51:16 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org
Subject: [PATCH v2 2/7] target-info: Add page_bits_{init,vary}
Date: Tue, 17 Feb 2026 19:51:01 +1000
Message-ID: <20260217095106.598486-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260217095106.598486-1-richard.henderson@linaro.org>
References: <20260217095106.598486-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

Add two fields that will hold TARGET_PAGE_BITS,
TARGET_PAGE_BITS_VARY, TARGET_PAGE_BITS_LEGACY.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/qemu/target-info-impl.h   | 7 +++++++
 configs/targets/aarch64-softmmu.c | 3 +++
 configs/targets/arm-softmmu.c     | 3 +++
 target-info-stub.c                | 9 +++++++++
 4 files changed, 22 insertions(+)

diff --git a/include/qemu/target-info-impl.h b/include/qemu/target-info-impl.h
index e446585bf5..c917d546ea 100644
--- a/include/qemu/target-info-impl.h
+++ b/include/qemu/target-info-impl.h
@@ -25,6 +25,13 @@ typedef struct TargetInfo {
     const char *machine_typename;
     /* related to TARGET_BIG_ENDIAN definition */
     EndianMode endianness;
+    /*
+     * runtime equivalent of
+     *   TARGET_PAGE_BITS_VARY ? TARGET_PAGE_BITS_LEGACY : TARGET_PAGE_BITS
+     */
+    unsigned page_bits_init;
+    /* runtime equivalent of TARGET_PAGE_BITS_VARY definition */
+    bool page_bits_vary;
 } TargetInfo;
 
 /**
diff --git a/configs/targets/aarch64-softmmu.c b/configs/targets/aarch64-softmmu.c
index 4e1e2f64da..82ccb57575 100644
--- a/configs/targets/aarch64-softmmu.c
+++ b/configs/targets/aarch64-softmmu.c
@@ -10,6 +10,7 @@
 #include "qemu/target-info-impl.h"
 #include "hw/arm/machines-qom.h"
 #include "target/arm/cpu-qom.h"
+#include "target/arm/cpu-param.h"
 
 static const TargetInfo target_info_aarch64_system = {
     .target_name = "aarch64",
@@ -18,6 +19,8 @@ static const TargetInfo target_info_aarch64_system = {
     .cpu_type = TYPE_ARM_CPU,
     .machine_typename = TYPE_TARGET_AARCH64_MACHINE,
     .endianness = ENDIAN_MODE_LITTLE,
+    .page_bits_vary = true,
+    .page_bits_init = TARGET_PAGE_BITS_LEGACY,
 };
 
 const TargetInfo *target_info(void)
diff --git a/configs/targets/arm-softmmu.c b/configs/targets/arm-softmmu.c
index 9b3fdd2854..18940e51e5 100644
--- a/configs/targets/arm-softmmu.c
+++ b/configs/targets/arm-softmmu.c
@@ -10,6 +10,7 @@
 #include "qemu/target-info-impl.h"
 #include "hw/arm/machines-qom.h"
 #include "target/arm/cpu-qom.h"
+#include "target/arm/cpu-param.h"
 
 static const TargetInfo target_info_arm_system = {
     .target_name = "arm",
@@ -18,6 +19,8 @@ static const TargetInfo target_info_arm_system = {
     .cpu_type = TYPE_ARM_CPU,
     .machine_typename = TYPE_TARGET_ARM_MACHINE,
     .endianness = ENDIAN_MODE_LITTLE,
+    .page_bits_vary = true,
+    .page_bits_init = TARGET_PAGE_BITS_LEGACY,
 };
 
 const TargetInfo *target_info(void)
diff --git a/target-info-stub.c b/target-info-stub.c
index 65220cc782..896f16e582 100644
--- a/target-info-stub.c
+++ b/target-info-stub.c
@@ -23,6 +23,15 @@ static const TargetInfo target_info_stub = {
     .cpu_type = CPU_RESOLVING_TYPE,
     .machine_typename = TYPE_MACHINE,
     .endianness = TARGET_BIG_ENDIAN ? ENDIAN_MODE_BIG : ENDIAN_MODE_LITTLE,
+#ifdef TARGET_PAGE_BITS_VARY
+    .page_bits_vary = true,
+# ifdef TARGET_PAGE_BITS_LEGACY
+    .page_bits_init = TARGET_PAGE_BITS_LEGACY,
+# endif
+#else
+    .page_bits_vary = false,
+    .page_bits_init = TARGET_PAGE_BITS,
+#endif
 };
 
 const TargetInfo *target_info(void)
-- 
2.43.0


