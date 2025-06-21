Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36131C71157
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Jun 2025 23:55:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uT7z6-00057U-L0; Sat, 21 Jun 2025 19:50:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT7z3-00055W-3j
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 19:50:53 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT7z0-0004T6-N2
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 19:50:52 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-747e41d5469so3128665b3a.3
 for <qemu-devel@nongnu.org>; Sat, 21 Jun 2025 16:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750549849; x=1751154649; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=TzQwMdaC2f0TIl2lwe12HdG9hZiKzE5709XOOuQijrs=;
 b=q/KJkkLOLK0dlTtUvjO6mtkGlUPrwZ6XWUJ4M6aqa4wxkD5OfFbCTiXd+KdCFmF9uJ
 MvTwS5VEwhTvegrkLpEGHVcGyqv9JkkE+6nX0Dht9LT2EtjBdB70eelyfn0GIpU9wn81
 UeUvKUt+frENQoC7zW+4ZjrsXzNrhsRX1Cl1YyRxbS2rW5lBqDwTWdjQFqW2jb3lqcf/
 6gWJz9B5N3T1dmgIll9l099cigOsc+heseVsae5pQFl1ZN7CSay8s1cpdFSvGTkDwloQ
 KKJDmx/igxsvfd0gaMOCWyxLw6+Yp5b4A13mQYJ+sOeT2EzSLMdG7L+9jYKKtsuz7E3Q
 BiKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750549849; x=1751154649;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TzQwMdaC2f0TIl2lwe12HdG9hZiKzE5709XOOuQijrs=;
 b=l/hm4nKFwUsjz9g2WMoJ4RvZ6aU72gKYmju6WP/taG3ou/8gmmJxTLZxsfLsk94/Sj
 ST3zoefJvUt2EPcz5w0ba/LtwsPUp8/iRSoli3U1MQhHaGFxXj/aTp0ECnOp3gDPbF6A
 HU/wDZH5ceApmk0QqbM9QzoMdhykk2iMVt8immBGhDr8qMLzs8wOq6IfKQveVSPiqOTC
 ClGTVYz93zY05tUJ7fE52eOADQ8X+ElbSCT6KMNpP8ht5rVwFDSUw7ShpIKWLfUzOqoT
 q/TujUcnp8w/cHKyAXgtlMfQqq1bKszClvjmdKQXmdlDGQr3DcPjWEQCyetahxFT/0N8
 oKng==
X-Gm-Message-State: AOJu0YzU93kDFKLNnDCmXjgQRU2uU9H37HGrMJLr3+nR/sa73WM5zok1
 GS4FFsAN2PkJDnFP6+I9aO2vshNzenlOTBNOkKIMiKDMalkTTQfyEA5JFF51O0daHpKDWnIlxE5
 tSFZN
X-Gm-Gg: ASbGncsTW7Nrbb1zdNLswDgHFWASjEH5oOnX1ifKNKwnrVDXk2LsG48dt/aEXV8gm6M
 q65ivx2xuESsQEmLglDirPzmHGdnkyOnw5LBG0jB8nMU+tikGyUtjszEdPclev/A0N4rBx39OEv
 watVBMyEaf8/Qpa2ffd9toUGrur4tYO85E1GYXvNQTb0jFSeB1SCVTQOasWlJDXXrKXEnHPkzYy
 efK3eYQSTDTBmoPpTLtc1mPIi3bq/06OSrHNtoE//DW+g/ufUGm3ntg3brpWiu5BUnA58uvmxhM
 sqOmHSeJNWurYLZ+3Y9fS6v8aVJY3DBKstz+IUidNVzByJJsXO5Ek4vB4vt7ctk16U+Ht8sFBoF
 4uBalkT29dLSvw77y6icuOOfRt8zWQ/w=
X-Google-Smtp-Source: AGHT+IFjJh5pvq/kaKiI8/tf+RbfZhccpUrI8EhSRyQrJX4EVxTNvsM0G8r/FQXpURwpJCpPcom8Lw==
X-Received: by 2002:a05:6a00:2d8c:b0:748:ed51:1305 with SMTP id
 d2e1a72fcca58-7490d4f4be1mr9075226b3a.5.1750549849452; 
 Sat, 21 Jun 2025 16:50:49 -0700 (PDT)
Received: from stoup.. (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7490a49ebd0sm5073744b3a.55.2025.06.21.16.50.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Jun 2025 16:50:49 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 016/101] target/arm: Add ZT0
Date: Sat, 21 Jun 2025 16:49:12 -0700
Message-ID: <20250621235037.74091-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250621235037.74091-1-richard.henderson@linaro.org>
References: <20250621235037.74091-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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

This is a 512-bit array introduced with SME2.
Save it only when ZA is in use.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h     |  3 +++
 target/arm/machine.c | 20 ++++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 052ca20283..465fc188d0 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -715,6 +715,9 @@ typedef struct CPUArchState {
     uint64_t scxtnum_el[4];
 
     struct {
+        /* SME2 ZT0 -- 512 bit array, with data ordered like ARMVectorReg. */
+        uint64_t zt0[512 / 64] QEMU_ALIGNED(16);
+
         /*
          * SME ZA storage -- 256 x 256 byte array, with bytes in host
          * word order, as we do with vfp.zregs[].  This corresponds to
diff --git a/target/arm/machine.c b/target/arm/machine.c
index 6e73368ef9..6986915bee 100644
--- a/target/arm/machine.c
+++ b/target/arm/machine.c
@@ -321,6 +321,25 @@ static const VMStateDescription vmstate_za = {
     }
 };
 
+static bool zt0_needed(void *opaque)
+{
+    ARMCPU *cpu = opaque;
+
+    return za_needed(cpu) && cpu_isar_feature(aa64_sme2, cpu);
+}
+
+static const VMStateDescription vmstate_zt0 = {
+    .name = "cpu/zt0",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = zt0_needed,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT64_ARRAY(env.za_state.zt0, ARMCPU,
+                             ARRAY_SIZE(((CPUARMState *)0)->za_state.zt0)),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static bool serror_needed(void *opaque)
 {
     ARMCPU *cpu = opaque;
@@ -1096,6 +1115,7 @@ const VMStateDescription vmstate_arm_cpu = {
         &vmstate_m_security,
         &vmstate_sve,
         &vmstate_za,
+        &vmstate_zt0,
         &vmstate_serror,
         &vmstate_irq_line_state,
         &vmstate_wfxt_timer,
-- 
2.43.0


