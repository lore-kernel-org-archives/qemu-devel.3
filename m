Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07262CCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 22:08:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6cBN-0005Qi-0g; Wed, 08 Oct 2025 17:58:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6cAW-0004TC-4W
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 17:57:58 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6c9J-0006l9-Ci
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 17:57:54 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-28a5b8b12a1so2983625ad.0
 for <qemu-devel@nongnu.org>; Wed, 08 Oct 2025 14:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759960598; x=1760565398; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QDW+HxP2J6pK8IxGshUeq+u65rBy5XdnKzmGA8gxmkE=;
 b=zYcVMHKO0nr/jQUN2AsIL5FNrgGEl9kv1q2hSGB/H88WIQaia/V0GLeYeOvIR3GcOT
 GbiS0tQWydWcJtacKyKDkjKDXMFfN7QBiblIeN0WZqu8bpzeCPQSW0bhp3qxe5mx8LB3
 JGDb6new5kGcaDMnKAstH2B76INcPF32c6zYZWw77sdore/h6fmqqLinuwRv3pXmGLT4
 mvYvWsC9iPoEyYg2oR3vLDMSRJG3g8r2dlD77hDhFyu/fwyurZNkHfOUJJMfDF20hkPF
 vdmaKGInWN2dUA1v/rLLeGQ2ALHiB65bEQNssZPfmtn4PRbsgXNQlZGJvemCSLOyr4QC
 67HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759960598; x=1760565398;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QDW+HxP2J6pK8IxGshUeq+u65rBy5XdnKzmGA8gxmkE=;
 b=WXTb5qSDmb5CSJrSo2pVV9zePstxFaHf3vcWIgz4ajMfXVQtU6QsE/dcI6KszHB7+u
 5EbdeK7VY8VxtRw6i6nMXUPVNXQoeH4C2sfvDevJOpErFjfpg5zOhif9IFrO++J+phPF
 V3f2blyBWzDOwFsRxwTOwYNFIH3i3Bqc+Pz7uNJ2Qj/08L4FxpfnlcPQbRyLyMd6hamv
 5+lBElsZSwRNmsiNKgnQlVlVmPJKtPeD3Iigae7W18uK4siaFcL2yj5FO+5CjucyA4m/
 +iQQJvimQhYoWHX9OQNHOX1r0rP2PeYx1gfa+ABOS+51JeZqlO2MDD+9RGaRrzXVojbE
 ISfw==
X-Gm-Message-State: AOJu0YxAfoMuga/wbNCjC4hfidTURGaRhgCm0ceDvicsRRftxTsupsdT
 0bEVGCZz2tqauNsB0EdwKuCYkAdZXHQQVtyCkH7EWjNJECXAB9Vii29y0aCwp1iu/NDVxswuNPy
 BByobd0k=
X-Gm-Gg: ASbGncvL/SczT8AtzsK07lFR/4MTFxL4tWyT1n2CKwAZI7Sytcj/BKCr9k0SykM66yM
 02yA0Xu3lskQqmCOPaowc6qnU1daa9T9k2yDaNttMKqxKp/wFdTCpAOufW7OfElb0B/wT5K6cgW
 dE4xsZie+XbuPjq1gs6uoEUFKLupj5MBk5xF3vOq2+iX+WzvdB/nN+kQ4doGHEltUg5rr+sM6AB
 9WLp1UtytdS5Ch28REZZLApGLPctu1fgQGJ4mTgDsyAtkLzgCM9f3WqGWghjftLEwziLsR/1d8d
 R96LoXg7vgZqNn3Yy8/ydSe1FSgtwdv8suaQZReiyz0nH4hOsPYOio++JHkiOsjCLV9qeKso+WL
 D0GF5zGbWkiJSqZPTGbzPDThXEoNUGO+bJkIyk2PD23bRncTm7IW5SkMh
X-Google-Smtp-Source: AGHT+IFNp323MT21XO0IoyeqNVm26rrx90X52pzFvdz0IPr/3c7M3vfwrS8lLHhR7bXD/fAwmBafyA==
X-Received: by 2002:a17:902:e785:b0:267:d2a9:eabb with SMTP id
 d9443c01a7336-2902739ad39mr62768875ad.25.1759960598326; 
 Wed, 08 Oct 2025 14:56:38 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29034e44ef9sm7354285ad.52.2025.10.08.14.56.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Oct 2025 14:56:38 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v7 37/73] target/arm: Add syndrome data for EC_GCS
Date: Wed,  8 Oct 2025 14:55:37 -0700
Message-ID: <20251008215613.300150-38-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251008215613.300150-1-richard.henderson@linaro.org>
References: <20251008215613.300150-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/syndrome.h | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/target/arm/syndrome.h b/target/arm/syndrome.h
index c48d3b8587..bff61f052c 100644
--- a/target/arm/syndrome.h
+++ b/target/arm/syndrome.h
@@ -63,6 +63,7 @@ enum arm_exception_class {
     EC_MOP                    = 0x27,
     EC_AA32_FPTRAP            = 0x28,
     EC_AA64_FPTRAP            = 0x2c,
+    EC_GCS                    = 0x2d,
     EC_SERROR                 = 0x2f,
     EC_BREAKPOINT             = 0x30,
     EC_BREAKPOINT_SAME_EL     = 0x31,
@@ -83,6 +84,23 @@ typedef enum {
     SME_ET_InaccessibleZT0,
 } SMEExceptionType;
 
+typedef enum {
+    GCS_ET_DataCheck,
+    GCS_ET_EXLOCK,
+    GCS_ET_GCSSTR_GCSSTTR,
+} GCSExceptionType;
+
+typedef enum {
+    GCS_IT_RET_nPauth = 0,
+    GCS_IT_GCSPOPM = 1,
+    GCS_IT_RET_PauthA = 2,
+    GCS_IT_RET_PauthB = 3,
+    GCS_IT_GCSSS1 = 4,
+    GCS_IT_GCSSS2 = 5,
+    GCS_IT_GCSPOPCX = 8,
+    GCS_IT_GCSPOPX = 9,
+} GCSInstructionType;
+
 #define ARM_EL_EC_LENGTH 6
 #define ARM_EL_EC_SHIFT 26
 #define ARM_EL_IL_SHIFT 25
@@ -351,6 +369,23 @@ static inline uint32_t syn_pcalignment(void)
     return (EC_PCALIGNMENT << ARM_EL_EC_SHIFT) | ARM_EL_IL;
 }
 
+static inline uint32_t syn_gcs_data_check(GCSInstructionType it, int rn)
+{
+    return ((EC_GCS << ARM_EL_EC_SHIFT) | ARM_EL_IL |
+            (GCS_ET_DataCheck << 20) | (rn << 5) | it);
+}
+
+static inline uint32_t syn_gcs_exlock(void)
+{
+    return (EC_GCS << ARM_EL_EC_SHIFT) | ARM_EL_IL | (GCS_ET_EXLOCK << 20);
+}
+
+static inline uint32_t syn_gcs_gcsstr(int ra, int rn)
+{
+    return ((EC_GCS << ARM_EL_EC_SHIFT) | ARM_EL_IL |
+            (GCS_ET_GCSSTR_GCSSTTR << 20) | (ra << 10) | (rn << 5));
+}
+
 static inline uint32_t syn_serror(uint32_t extra)
 {
     return (EC_SERROR << ARM_EL_EC_SHIFT) | ARM_EL_IL | extra;
-- 
2.43.0


