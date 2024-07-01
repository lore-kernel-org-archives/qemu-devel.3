Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 135DEC2BD09
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 16:08:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOJa5-00039D-6i; Mon, 01 Jul 2024 12:08:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sOJZE-0000p8-CT
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 12:07:50 -0400
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sOJZ9-0005Tk-FW
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 12:07:47 -0400
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-52cdd03d6aaso3693883e87.0
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 09:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719850061; x=1720454861; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Z7/IHdKKubpCBk70PI2w/9BtCaXUhcMHm9wylsLvrK0=;
 b=t4Vv6MG/Ev1n4mQvvepF5jZt5E4VCYefyvdVVKkuXavoGXywKe6OvzEKO0Lw0yP/vb
 S31GHSyJLUJg+lWw2q5QoOpxZPnBAaJF/gSEHpT7WvaeeznlRdo2vOPmbUYCBrbIVyPN
 iDhMRcFWKGOyaWgnHmZdhxRHkKHmZqVP5gTUROj0BLOtDOxQG3VqO/8bL4DrISCpmxGb
 p/+pccX+AH/m8f3lJOBLnF53B5z09dVWgI3RBeyZWI3utw05box/C8hqOjrbOKUvmUuB
 uxvidJccgCyLlkUkdq+DnMfewqWPt4i19VUKLpLm+xuq2V7nCP/EkdXvbaDnpgxEbJct
 LyKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719850061; x=1720454861;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z7/IHdKKubpCBk70PI2w/9BtCaXUhcMHm9wylsLvrK0=;
 b=B80JVFtK1Pob5JtyW7xPCFyG+BKzr4b71gSJnvlEfVn/3z4GGJEip/X8bcDWsBR8nw
 omkQSHhxgLmOeT5ddcj2tN29je/KAiTm3a+zcZCzXVPfxTqcEnA3qgV/qtwYBkhoZzYQ
 tlgccAkmDvmCnHq5wLK8zoqHES3+JEbwtSJzoscZC4D9vrzfwD5pqB/8LVeoNh4BoqJ/
 DtS90DfBfa8wRvfaFQZOaQjMerrOkNsglR7NhK2KhfJ3xh9W3t5tyIF9sWNxRttmdI+5
 NNPTA0gjir3D8NRfHpDbpnqXOnvq0o4UzsUnWGpP3PPp9fnOREnTrgSi2CeLDbg2Xatf
 a/OQ==
X-Gm-Message-State: AOJu0Yz4AEDPqNO0QF8xPPr14bvmIWC3fF9NZjDvSMkJgiZTb8tHAgjM
 BYBZjdI77A/CdPkBgdQq8gYCPBEQYbc0UU+yNggZBG3HkJ4vVyC011cRBBSFgr5CUu2q5ENZfsR
 1up8=
X-Google-Smtp-Source: AGHT+IF1ie5reIAVKJ1o/hX9n4sX6FmpisZLZG/tSXtmR6d10zI8oAcUsbg0oYnBRji8r4sEG7AEVA==
X-Received: by 2002:a05:6512:10d1:b0:52c:c6a0:575c with SMTP id
 2adb3069b0e04-52e82687f07mr4438791e87.33.1719850061673; 
 Mon, 01 Jul 2024 09:07:41 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256af557fesm161952135e9.11.2024.07.01.09.07.41
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jul 2024 09:07:41 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 22/29] target/arm: Enable FEAT_Debugv8p8 for -cpu max
Date: Mon,  1 Jul 2024 17:07:22 +0100
Message-Id: <20240701160729.1910763-23-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240701160729.1910763-1-peter.maydell@linaro.org>
References: <20240701160729.1910763-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12b;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12b.google.com
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

From: Gustavo Romero <gustavo.romero@linaro.org>

Enable FEAT_Debugv8p8 for max CPU. This feature is out of scope for QEMU
since it concerns the external debug interface for JTAG, but is
mandatory in Armv8.8 implementations, hence it is reported as supported
in the ID registers.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20240624180915.4528-4-gustavo.romero@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/system/arm/emulation.rst | 1 +
 target/arm/tcg/cpu32.c        | 6 +++---
 target/arm/tcg/cpu64.c        | 2 +-
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index 1a06a5feb6e..3ab6e726679 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -41,6 +41,7 @@ the following architecture extensions:
 - FEAT_Debugv8p1 (Debug with VHE)
 - FEAT_Debugv8p2 (Debug changes for v8.2)
 - FEAT_Debugv8p4 (Debug changes for v8.4)
+- FEAT_Debugv8p8 (Debug changes for v8.8)
 - FEAT_DotProd (Advanced SIMD dot product instructions)
 - FEAT_DoubleFault (Double Fault Extension)
 - FEAT_E0PD (Preventing EL0 access to halves of address maps)
diff --git a/target/arm/tcg/cpu32.c b/target/arm/tcg/cpu32.c
index 28a5c033bb9..20c2737f17b 100644
--- a/target/arm/tcg/cpu32.c
+++ b/target/arm/tcg/cpu32.c
@@ -82,8 +82,8 @@ void aa32_max_features(ARMCPU *cpu)
     cpu->isar.id_pfr2 = t;
 
     t = cpu->isar.id_dfr0;
-    t = FIELD_DP32(t, ID_DFR0, COPDBG, 9);        /* FEAT_Debugv8p4 */
-    t = FIELD_DP32(t, ID_DFR0, COPSDBG, 9);       /* FEAT_Debugv8p4 */
+    t = FIELD_DP32(t, ID_DFR0, COPDBG, 10);       /* FEAT_Debugv8p8 */
+    t = FIELD_DP32(t, ID_DFR0, COPSDBG, 10);      /* FEAT_Debugv8p8 */
     t = FIELD_DP32(t, ID_DFR0, PERFMON, 6);       /* FEAT_PMUv3p5 */
     cpu->isar.id_dfr0 = t;
 
@@ -93,7 +93,7 @@ void aa32_max_features(ARMCPU *cpu)
     t = 0x00008000;
     t = FIELD_DP32(t, DBGDIDR, SE_IMP, 1);
     t = FIELD_DP32(t, DBGDIDR, NSUHD_IMP, 1);
-    t = FIELD_DP32(t, DBGDIDR, VERSION, 6);       /* Armv8 debug */
+    t = FIELD_DP32(t, DBGDIDR, VERSION, 10);      /* FEAT_Debugv8p8 */
     t = FIELD_DP32(t, DBGDIDR, CTX_CMPS, 1);
     t = FIELD_DP32(t, DBGDIDR, BRPS, 5);
     t = FIELD_DP32(t, DBGDIDR, WRPS, 3);
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index 71e1bfcd4ee..fe232eb3069 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1253,7 +1253,7 @@ void aarch64_max_tcg_initfn(Object *obj)
     cpu->isar.id_aa64zfr0 = t;
 
     t = cpu->isar.id_aa64dfr0;
-    t = FIELD_DP64(t, ID_AA64DFR0, DEBUGVER, 9);  /* FEAT_Debugv8p4 */
+    t = FIELD_DP64(t, ID_AA64DFR0, DEBUGVER, 10); /* FEAT_Debugv8p8 */
     t = FIELD_DP64(t, ID_AA64DFR0, PMUVER, 6);    /* FEAT_PMUv3p5 */
     t = FIELD_DP64(t, ID_AA64DFR0, HPMN0, 1);     /* FEAT_HPMN0 */
     cpu->isar.id_aa64dfr0 = t;
-- 
2.34.1


