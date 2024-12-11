Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32780E7717D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 14:47:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLNxK-0006rz-J3; Wed, 11 Dec 2024 09:44:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tLNxI-0006r8-1Y
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 09:44:48 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tLNxG-0003r5-Bv
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 09:44:47 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-434ab938e37so44555355e9.0
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 06:44:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733928284; x=1734533084; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=G5JRzKrOBu8p2naVBHN4TEm9PW9soALL8/T3IRSujEg=;
 b=abqFYTQ9YeFcJKDz6JJjlSdTtrvT/s5hgPTLXgf5BgBVGB8zCtA8fGPoE8wuj/9Nte
 mE3EB5xehp+c5dJbfkEMqssxfTID9g6PrInBi8MriAWVK/NLU1D4lNXXA2DNkJBEEm3x
 3fXg0LzQdNSQY6pjr660HPX7d881pyr1XaKLslBOUPvzTEqg5Xpl4zu2e8+GY9gzF9T1
 nsHVo/4r+kvWrhEt+6snQUJ4Ve5uL8KYrCS+SrNhbfSEILVySV+sP/XtmnDjQ1nsq+5g
 kLYGfqKKu12ffMTqL/olmN2kd9fNS1yaxVT8tNxG+eeSsA1f1B5kS+7FUdSQXwW7v9Da
 POJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733928284; x=1734533084;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=G5JRzKrOBu8p2naVBHN4TEm9PW9soALL8/T3IRSujEg=;
 b=xTB60OZwENrQXw27gM7ker+8b3TQmc3+MUYftyyDgBJu8hSLpCLnAG0cae3ZE/yMwh
 9Z8Jo8mG9Vz1HaxxZGmV6DvlktHcdWTkOmCXpVw34WLLF/yBLNXVHB9ztSAKlLAARQym
 XTCwE1nsD6och6HPjfZV0TuLjklBKLQgGklrlQF6sEO2dBO3LvSXpaHorVYlpZAR+XIX
 7ctiUN2hOPyglbgbwGPa/Tlhy4J9uFPu0Jc4a/JXkeusNn6vKIOGwDtD5kSq7Inyz3kJ
 YeJ7ZV3wJUptX1bfSd84RNzuOySaTy4lWtiSSxaLJkGuvALCQlFzINqhrvFcN+3WdZbU
 uSDQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUru+qAHfCWGD8Zt0DL9iYOOkxM0OcydD81PGFfyOICpDtxvCQ2UXTZZP3bxzZuNeT+sAzihlagLpa+@nongnu.org
X-Gm-Message-State: AOJu0Yx4IPrSABCfQ/3QaHCmT5uhv66nZXgbPCps2yqUEgOtHGgQIlYw
 4ZV2I3HZ5uovvlnRawgk+G55nohIe/0UffaOv0CT7r9eIX/w1nYHrAUxcAteUzA=
X-Gm-Gg: ASbGncuyr4mLEgmWVsr3ky1s6Nt7zq1mvAjr+Q7ZPRnNSJfMr01mADwQProskvGYerW
 n20MWZG12vC2V+rlzIFaj5YU0aFX48p4A1oKntgysOXidIRe3PdyiCr0T0Nd/V1rHmt5t0MMCRb
 bwelMopfK+WkqmFy+fiV0LJxfQGcyubaMeZRSRT/FrB2uX/8ft7fFf8bUYajQJgD3DvXDi8zS8n
 1tXStOzY0bwMDmxxz+hFccluUgvAMaTcypTk3Dkln0vUHyeby253/F58+Gb
X-Google-Smtp-Source: AGHT+IEoA3LqXQuNmdPLYRGIs/HrUnX6ih3jA7UF7fpnfh/Jp/XaYAqcrb/YYEASxDeByg9qDZrXWg==
X-Received: by 2002:a05:600c:3109:b0:431:5044:e388 with SMTP id
 5b1f17b1804b1-4361c3f4ff1mr20807295e9.22.1733928284563; 
 Wed, 11 Dec 2024 06:44:44 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4361e54ef20sm19477685e9.5.2024.12.11.06.44.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 06:44:43 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 2/6] target/arm: Add ARM_CP_ADD_TLBI_NXS type flag for NXS
 insns
Date: Wed, 11 Dec 2024 14:44:36 +0000
Message-Id: <20241211144440.2700268-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241211144440.2700268-1-peter.maydell@linaro.org>
References: <20241211144440.2700268-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

All of the TLBI insns with an NXS variant put that variant at the
same encoding but with a CRn field that is one greater than for the
original TLBI insn.  To avoid having to define every TLBI insn
effectively twice, once in the normal way and once in a set of cpreg
arrays that are only registered when FEAT_XS is present, we define a
new ARM_CP_ADD_TLB_NXS type flag for cpregs.  When this flag is set
in a cpreg struct and FEAT_XS is present,
define_one_arm_cp_reg_with_opaque() will automatically add a second
cpreg to the hash table for the TLBI NXS insn with:
 * the crn+1 encoding
 * an FGT field that indicates that it should honour HCR_EL2.FGTnXS
 * a name with the "NXS" suffix

(If there are future TLBI NXS insns that don't use this same
encoding convention, it is also possible to define them manually.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpregs.h |  8 ++++++++
 target/arm/helper.c | 25 +++++++++++++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/target/arm/cpregs.h b/target/arm/cpregs.h
index 87704762ef9..1759d9defbe 100644
--- a/target/arm/cpregs.h
+++ b/target/arm/cpregs.h
@@ -126,6 +126,14 @@ enum {
      * equivalent EL1 register when FEAT_NV2 is enabled.
      */
     ARM_CP_NV2_REDIRECT          = 1 << 20,
+    /*
+     * Flag: this is a TLBI insn which (when FEAT_XS is present) also has
+     * an NXS variant at the same encoding except that crn is 1 greater,
+     * so when registering this cpreg automatically also register one
+     * for the TLBI NXS variant. (For QEMU the NXS variant behaves
+     * identically to the normal one, other than FGT trapping handling.)
+     */
+    ARM_CP_ADD_TLBI_NXS          = 1 << 21,
 };
 
 /*
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 8e62769ec0d..c2a70f8c053 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -9146,6 +9146,31 @@ void define_one_arm_cp_reg_with_opaque(ARMCPU *cpu,
                     if (r->state != state && r->state != ARM_CP_STATE_BOTH) {
                         continue;
                     }
+                    if ((r->type & ARM_CP_ADD_TLBI_NXS) &&
+                        cpu_isar_feature(aa64_xs, cpu)) {
+                        /*
+                         * This is a TLBI insn which has an NXS variant. The
+                         * NXS variant is at the same encoding except that
+                         * crn is +1, and has the same behaviour except for
+                         * fine-grained trapping. Add the NXS insn here and
+                         * then fall through to add the normal register.
+                         * add_cpreg_to_hashtable() copies the cpreg struct
+                         * and name that it is passed, so it's OK to use
+                         * a local struct here.
+                         */
+                        ARMCPRegInfo nxs_ri = *r;
+                        g_autofree char *name = g_strdup_printf("%sNXS", r->name);
+
+                        assert(state == ARM_CP_STATE_AA64);
+                        assert(nxs_ri.crn < 0xf);
+                        nxs_ri.crn++;
+                        if (nxs_ri.fgt) {
+                            nxs_ri.fgt |= R_FGT_NXS_MASK;
+                        }
+                        add_cpreg_to_hashtable(cpu, &nxs_ri, opaque, state,
+                                               ARM_CP_SECSTATE_NS,
+                                               crm, opc1, opc2, name);
+                    }
                     if (state == ARM_CP_STATE_AA32) {
                         /*
                          * Under AArch32 CP registers can be common
-- 
2.34.1


