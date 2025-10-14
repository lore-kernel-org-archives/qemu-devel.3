Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04B86CCD190
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 20:14:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8lKQ-00032S-NQ; Tue, 14 Oct 2025 16:09:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v8lK9-0002mS-G1
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 16:08:46 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v8lJC-0005QT-B6
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 16:08:45 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-27ee41e074dso66629435ad.1
 for <qemu-devel@nongnu.org>; Tue, 14 Oct 2025 13:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760472463; x=1761077263; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eOldzdPHQhf3YrWEbwVnS4C8lSFLiSxsaEnJBfZTIIY=;
 b=re2tZL8ZAMwCcUhKseL058b7/OTWSD2mUnKYk128QFObGLKu4DLVfT6kMWOx4LNjep
 /DmRnRG3x4ezLg+dD/X+ZpGOTXBu2aXCcsaxjBxkosifXUYOqT8QC0l3BNLFw13VCK8H
 n5mJzosTeeXUMsJvrZ+BuiwMzu+CxLfBrWMGI7TueMQTLyr0GKZpEVkdajGR83Vp6F6d
 XdCujM8JAN4N/rWbMxYpCTKcGpEyVOwgV/hzosCOaU7+u9Jn07NABsx514/jvwTEsn9C
 dPQm4yt+2X6tZ0/BSAXCHWNZgPqJV23HiayQUBT8enOSRrOzPshPkraSICNz+E8s2CIq
 YnMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760472463; x=1761077263;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eOldzdPHQhf3YrWEbwVnS4C8lSFLiSxsaEnJBfZTIIY=;
 b=EoYbWQvLi66mQQk9ozXNenuerU/wf6P1xt4tZtnejNK2Jt74amaPbhcgvU4rpLuevV
 xUxo6G7C3CcTglwVaCNIjhPFRUFpBIeZ/sZRH5sy+EHUe6j+5kMf/7Ykbxm7eVTDVx4D
 UcHkKANfi6c2KZhB8h/VS7Pr/RrwMeC1KZWsioxnV5IkD2P4L2CFYUKHSgskCZPnf3PG
 JZhLFPgQ4Zm4wThwJxF6lr9l/ACAeGp0y4Ow8k/ip9JJPQheB39p94UDgXB9z5gH+BPe
 /mM9kj7KjeJAQIyGRulA688ZKa9xThSeZY9I4z+j0a1IwM4j2AmqXrXWST/9cHszz1cd
 JNvQ==
X-Gm-Message-State: AOJu0YwuT1K2bcRAar7K43DWtfs9MG11Bf+VUnDj5zwTr/W4xtYWYK0D
 hg5rumkiFIk7wC5WNx3cHWMhFEesmyHriAkZjlCMbO9CLcDsB2j5DVJSyqTwB0AXpge5jUd5MYh
 jXlrXzqc=
X-Gm-Gg: ASbGncuuN9GPF2gEW4n4t8w856/w29llTLYD4WxDGz22QzBr/a2zQX49uNCvoJOJLBK
 qP5yuKp96bFSbUcJXq/5/FWIH4mujHUlmWOJRIf57hp1xoB8NEmJW3tLvZ1IAs4iwkDP2ct5cCL
 0hpVEgxP0D6+1amM4qR/A0XLTHNWkJBMzhdUQAyjb+/UIVx3XPvfvV3A3MgNAgfcjjfOWD5GmBv
 R6rpaBnD7+wCKoEWI3TFeO/bPyVjYLNgjWrC3OPAeRpHD+ZACKu1MQicn9ci4wNClMGpbqQy2+o
 W7vGrFwo7Z3v1um1+dzRqwEXxuR7uz11wT54V6WSzwBCgaewQYFxM6JH/4qVSFXyzIA4ET81IbD
 uToMvG4sSv189Oy2XhSU3YR/hCP4NHa6kmkU4k44F4AfBVkYJ/iFIbg+16pJ+b/NcsiM5BG6q
X-Google-Smtp-Source: AGHT+IGD6FVJaWr03FcKRamX2KIpwQhOOouZePc/7JlrPWm9U3hw58LS2Bt51Q6sN5pI/812ApoljA==
X-Received: by 2002:a17:903:2a87:b0:269:aba0:f0a7 with SMTP id
 d9443c01a7336-29027212f47mr352915605ad.2.1760472462677; 
 Tue, 14 Oct 2025 13:07:42 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29034f93ea2sm172100975ad.126.2025.10.14.13.07.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Oct 2025 13:07:42 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v2 33/37] target/arm: Implement TLBIP VAE2, VALE2
Date: Tue, 14 Oct 2025 13:07:14 -0700
Message-ID: <20251014200718.422022-34-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251014200718.422022-1-richard.henderson@linaro.org>
References: <20251014200718.422022-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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
 target/arm/tcg/tlb-insns.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/target/arm/tcg/tlb-insns.c b/target/arm/tcg/tlb-insns.c
index beacb92f32..f99559e4a7 100644
--- a/target/arm/tcg/tlb-insns.c
+++ b/target/arm/tcg/tlb-insns.c
@@ -416,6 +416,17 @@ static void tlbi_aa64_vae2_write(CPUARMState *env, const ARMCPRegInfo *ri,
     tlb_flush_page_bits_by_mmuidx(cs, pageaddr, mask, bits);
 }
 
+static void tlbi_aa64_vae2_write128(CPUARMState *env, const ARMCPRegInfo *ri,
+                                    uint64_t vallo, uint64_t valhi)
+{
+    CPUState *cs = env_cpu(env);
+    int mask = vae2_tlbmask(env);
+    uint64_t pageaddr = sextract64(valhi << 12, 0, 56);
+    int bits = vae2_tlbbits(env, pageaddr);
+
+    tlb_flush_page_bits_by_mmuidx(cs, pageaddr, mask, bits);
+}
+
 static void tlbi_aa64_vae3_write(CPUARMState *env, const ARMCPRegInfo *ri,
                                  uint64_t value)
 {
@@ -831,13 +842,17 @@ static const ARMCPRegInfo tlbi_el2_cp_reginfo[] = {
     { .name = "TLBI_VAE2", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 4, .crn = 8, .crm = 7, .opc2 = 1,
       .access = PL2_W,
-      .type = ARM_CP_NO_RAW | ARM_CP_ADD_TLBI_NXS | ARM_CP_EL3_NO_EL2_UNDEF,
-      .writefn = tlbi_aa64_vae2_write },
+      .type = ARM_CP_NO_RAW | ARM_CP_ADD_TLBI_NXS |
+              ARM_CP_EL3_NO_EL2_UNDEF | ARM_CP_128BIT,
+      .writefn = tlbi_aa64_vae2_write,
+      .write128fn = tlbi_aa64_vae2_write128 },
     { .name = "TLBI_VALE2", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 4, .crn = 8, .crm = 7, .opc2 = 5,
       .access = PL2_W,
-      .type = ARM_CP_NO_RAW | ARM_CP_ADD_TLBI_NXS | ARM_CP_EL3_NO_EL2_UNDEF,
-      .writefn = tlbi_aa64_vae2_write },
+      .type = ARM_CP_NO_RAW | ARM_CP_ADD_TLBI_NXS |
+              ARM_CP_EL3_NO_EL2_UNDEF | ARM_CP_128BIT,
+      .writefn = tlbi_aa64_vae2_write,
+      .write128fn = tlbi_aa64_vae2_write128 },
     { .name = "TLBI_ALLE2IS", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 4, .crn = 8, .crm = 3, .opc2 = 0,
       .access = PL2_W,
-- 
2.43.0


