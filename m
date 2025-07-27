Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6AF7C87FCC
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Jul 2025 08:10:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufwPp-0004DX-5o; Sun, 27 Jul 2025 04:07:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ufwPL-0001Nv-Hb
 for qemu-devel@nongnu.org; Sun, 27 Jul 2025 04:06:59 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ufwPJ-0004je-Jt
 for qemu-devel@nongnu.org; Sun, 27 Jul 2025 04:06:59 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-313bb9b2f5bso3156519a91.3
 for <qemu-devel@nongnu.org>; Sun, 27 Jul 2025 01:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753603616; x=1754208416; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aph0ZkYCjiTweukUbhlaS2yrRTHeOV9Z1zDO+YdfHoU=;
 b=BFCO8noJ4CwkJvMxwu/GP0B4Lmym+xhCe08Ak0NfH0j9pz8Dsk2qTyYuylvzqvMwtj
 Ed2i0XHdldpN3v1HQdH2Fgm/pEVs3y4Lyn4ofOAyUntsYouYWPTY7yElHZakfY0UlMsO
 zAegL0PWcTbwz8caiIdAwwvGPS3deVGfV0ZE8tPf6BVkB/xtBMBllDoB+6NetgHIKVoK
 koOD3iVpGc1+9wSdYYREPAr+Bhh/jIQC1gBcUNipuNTeztCXqld9JeQ22A44kLfzfaRe
 kXtqCvR2Jt++al4jilkgyAA7tCcky1t6USVD2AO3ssOQ6yOPaHXYFPkwsYCg8iGlS/iU
 GSjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753603616; x=1754208416;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aph0ZkYCjiTweukUbhlaS2yrRTHeOV9Z1zDO+YdfHoU=;
 b=Ujd4xrucQcKg6NROP04iBWAYywWwzxqS44DmXIEgHcStmNLTYiyiWkeVd9q4t7HQpw
 QXL2/0ubTjfnfPdSSXFWJQWEOn6W6xkcRfujd8iXUyxYLBxcEaHTx4ZfoLyioPfPk0Td
 zMCkodBYPeR1prZqLUW4IAFC4F/nQncyeq8R1+8GKYDuozJKsFungjA7IGr+kKYQxIe/
 zPAsZcp5qcpm3toOmBwR7miFdTgyuKuXA2G00KPCdnTy17S9T4wPCxS+sbRgdZ8kkJFk
 gBJlYmsiRtZxR9ICMazPih6BX6Yj5i6E4z4+ToFZqpNNk1GV4glpC9WXC+fcvp/gIxvy
 XPfQ==
X-Gm-Message-State: AOJu0YzpqIqD1DnMKm7cxSKqQ8qPZdDTKWQfL6ZT83cpdNd4Yy7+BzGu
 E7Pz69NyOCYwAmmE1wz5J98Qp9DXf2oPpvZMmd0KsjhdOTsOzg0YtlHYXRbPT6+KV84BMavhNqo
 tmC0i
X-Gm-Gg: ASbGncs+ZeS/CIRV8w9opPYHNl+Og7QuqcsxNDRoZwhH3jflIXPukMs1PQfIKjtv22J
 pxxCcVpdmS7ZrCLVh2ovZASgJVxJxC0zHCXoXIsNSuNnmNv72XInzcSgp/v0v1F4f2sfCk5nYB8
 3BeCp140qMFCxgxAhlvtvsruxJGkAeliv7LJnP/QqbV/TjcSDGKYauApHQzbK/0uepfh4gW8PH9
 njMI4g4g2XxGDgJh3ve00ek7qwu4lctf90g8MLhDgqzpfo1SGTy0UXg3vSG0cQGl7o3InNTIruF
 JCvk0jEGM0yk7AbtjlVsTnUWRKSf8sNsjrVvSiOmcikR47TA0U838ZgBPgO0rT1xYhH2zuiiQPZ
 2C6aJYthIh3qGsjauPzDLNGPHlUV0TmvWP4Py92N9y/uRtJnKTTwyplE3+JdQPAFPvTMg21W2pa
 iJdWsnABjm3Q==
X-Google-Smtp-Source: AGHT+IF4jJzoNuOyW8ulnmLiKYz/LJK+i9Ip9ny6z5DTY/riG2Jv1c1+UFMaXIyIhtjobnSOAgEyTg==
X-Received: by 2002:a17:90a:c888:b0:311:9c1f:8516 with SMTP id
 98e67ed59e1d1-31e77879820mr10750158a91.15.1753603615935; 
 Sun, 27 Jul 2025 01:06:55 -0700 (PDT)
Received: from localhost.localdomain (syn-098-150-199-049.res.spectrum.com.
 [98.150.199.49]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-24011d5bcbesm3908065ad.10.2025.07.27.01.06.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Jul 2025 01:06:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 48/82] target/arm: Add syndrome data for EC_GCS
Date: Sat, 26 Jul 2025 22:02:20 -1000
Message-ID: <20250727080254.83840-49-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250727080254.83840-1-richard.henderson@linaro.org>
References: <20250727080254.83840-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102e.google.com
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


