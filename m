Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E41ABE77184
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 17:20:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNbEz-00080T-LQ; Tue, 17 Dec 2024 12:20:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tNbEw-0007z4-95
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 12:20:10 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tNbEi-0006Dc-8f
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 12:20:09 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4361f796586so62296505e9.3
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2024 09:19:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734455993; x=1735060793; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=hC9M0XpdNJx8hwrzBQKl1ZaJYPNdEGDotHyFjhLEqJ4=;
 b=vQQdfec977TCsgpPW124Y72axHemMyeW7ZDzj0ZhkqzRofpEih2tAExGvIZR7jFkyO
 atbACmMSvNTCceCaeV2FPHLNcY0r79VowgyvPYKA8ntwRS2ng8rAMvpR1gpmv/6T/tXu
 U/lv7/4oiw9ZgM1CUWAgD/M0tRJIws2V86bVdxysoyZzhAIr1kKgjHzStVYb6m5DbblK
 KtV1pUXiwEmPTROqlg0AvsckW/d0P8u4sqis8bAMvX7EKTv/T36u4YeWMd05xJC1DJYo
 eVBiukz8pXbgfud5DqnqtFN4O+h6MOPY0ucYofPx2B3uulLYCei1U46dUQcEeBSjeKxS
 qj1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734455993; x=1735060793;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hC9M0XpdNJx8hwrzBQKl1ZaJYPNdEGDotHyFjhLEqJ4=;
 b=qruboN+2VvTTDnxq3gssYkKKHciut4iDkOkdwTFQidlJ8DDA5OhTNN7jr4l2sN1yiP
 7uIWIB7/p8VtlS0RCTPviYVWApDETfCCf4ewiaRqwVmWRwZrL7KLLO0vthNRVoOzLMuS
 /JZbXzQBkjXbZPutPeIcvNSTxub5stsUhzF3+738Rtw38DeQn+U3oZTuI+0i9O0mcLFK
 v6duTjXDeD+iYnrP18RR3phlurTCkSpd2lYLw0KWqlxOMGPyywxPpVwYFkKf2DAG6abP
 FvkThUrSvljGpLLeS17a35wvthWUcp0S/nrAkuZPmZqbwsylOl4vW+zTowx92FdKteUM
 7Dmg==
X-Gm-Message-State: AOJu0Yzep6hGakRleuBiTNsaiyBEQY29NGTOZoP8x5pnWpb4ag4lh1xq
 8TSBLMpZ3C3l95dxqHDXqmZUVF7D4tXRDo1Jcn6Rqj51glBXb2CMQc1ILAfKZJZzz/4RqssGRn6
 Z
X-Gm-Gg: ASbGncseXsbCqRHkBXofXmUFPbWLC63UY701e56f9Lv6bPZG+db63Y2Lo4YW5r65L7v
 iLb8E+PFECl+6DWvN7LQwBAW/uO+Cxp0l6UBRr9dhcewW9tzdielinpmAZMXe1DdYrErJ1HPKNs
 pdo5dDIqtH4Tz7p9fqvEGHqVlerVIFQaRI5H+A1f2JlSic17gEKSFgXzYWJNzKYSdL1+bg8DzTf
 /cB8Ewh8zpynrwCQ1JzwHh1/649UMammlt6TlWbbzc0TbKbJ1ywjBhDS+zuA6Y=
X-Google-Smtp-Source: AGHT+IE9glgKAMtf/ySxxi40oKwnxGiLQkUfJTDm9SpaIl4PvjILtamL9DzJchF//22DdKFUSV/BCw==
X-Received: by 2002:a5d:648b:0:b0:385:f17b:de5a with SMTP id
 ffacd0b85a97d-38880ae13c4mr17519610f8f.28.1734455993089; 
 Tue, 17 Dec 2024 09:19:53 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-388c8016389sm11569728f8f.32.2024.12.17.09.19.52
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Dec 2024 09:19:52 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 13/19] target/arm: Add ARM_CP_ADD_TLBI_NXS type flag for NXS
 insns
Date: Tue, 17 Dec 2024 17:19:31 +0000
Message-Id: <20241217171937.3899947-14-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241217171937.3899947-1-peter.maydell@linaro.org>
References: <20241217171937.3899947-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20241211144440.2700268-3-peter.maydell@linaro.org
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


