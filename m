Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40421CAC598
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 14:32:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyWcr-0000IH-HN; Tue, 16 Sep 2025 10:25:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uyWam-0006BI-Vd
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 10:23:37 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uyWaU-0008NE-H8
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 10:23:30 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2677a4d4ce3so21204795ad.0
 for <qemu-devel@nongnu.org>; Tue, 16 Sep 2025 07:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758032581; x=1758637381; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hg2xV4nRaM7n2VIoSbN3KehS3wFi1JQVp0YcyiarUG8=;
 b=YP1IejkqUTkDdKes6iR03Wi59QwgIQ20Ip1Z4rkmZFq2McIu1Zkj/88mSRvIH4ly24
 jAkgwCqNno6VSYFPgFOtav0lZ0iMyODgwOkq43S9ZHB0FvolCF19KZ6hDQfde6f0B0Vu
 ZGfa0517RF9aQmFFNXjgjTdONOjWryOgqsvhAFE400eDggaN2iL4cDvneYL2TQ9BfEVz
 9heUatPbvzXAjP8CYMxopFGCucy+jDQNVw0Q4hoAilDV0vqR9qAwXt+bSGUiG3Isdhzj
 K/Vs7OjehWG3wu2QXiHH53K6HX9nRGhOAtJ+v0clo1O6ScWydixvCFlSYZUKZYp7Y53X
 riNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758032581; x=1758637381;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hg2xV4nRaM7n2VIoSbN3KehS3wFi1JQVp0YcyiarUG8=;
 b=h69Xg4Yzrvda5V+sIhwghkaHbMSOXS6IQnNXjF6D6ADzDC+oAkh+yXvZ/trzPou4BN
 xBFVf8uqQSdTP7p1Ae8B8+H4C3B1zXM358ays7vfNbEuPF3OaqGYgrDqvE18eQgf6ZKh
 RoxRM0++hfisp/MVcHC+FEWpKhYHtzWh+CXvyGpCH7bEfFLIQz6yMHV82A05k479FaVU
 WI8EbNETDZH+utWgFtTtriK7Jx0VHo8gXid5Vl5SgdDqEAvyLi44biaTTdqJub993DR5
 qoHz36V/Khuuziu72IneiSrw3rcZFb6MEWurMFBi5wvOS69wkfSMkbz7Yz5G9Wtn1vsm
 bQ6w==
X-Gm-Message-State: AOJu0YwH8IoOTqstLzARIjgGfSkOpCjEJvkrFBMWAJZZZCU8KZGxH5xf
 n1vJ26CpiSh4Vn6Hp5YMUtTInAiNuTyTm7y8HLhX5Weq0u/PLbxKQGSb0Rgmd00pSQRAOvAWMMf
 n+MGd
X-Gm-Gg: ASbGnctgePf58Uq5DXQuVo+1hvlRE0bJzcZEBHqGddDxjGsItwpf5uRopP/1O14p5Vp
 u2LBjeQ/HC1z4wRxXTLI145WRQPFZJ3cE/BeZR1AZv0cCzxTRQ1bP0vzP9+de44ltpls09W54Fb
 OqZpCmwVnrlC6tUBoJcv94C54t/7sA2+M7e/3DkiIZiQFbZMTp6RT9k7zETaokAG1w1Y8dhvaMm
 mXdHrSRUx32zsjik/upObUfSIk/2m6kHC2R/itrBLYZDwuIXra+O+aA2KYgQXtefjbH4ljE35bu
 uKHYYFh+tbqLVKwzo443Wu9RiTHQd+p4N9vTmHnT2zsyzu/uew6zhwMA6/ZOyJ8Ft947x7s6a6A
 7cMGB0snNU1hiHQmQFv5mQ4UPt9Q0
X-Google-Smtp-Source: AGHT+IGPpZrUMRb7VyZtwEqPUXOvvyc9FIxx7TNhRTr1GvaneXPY5/aKjU2uh2HQ7eIfkAFQoCijXw==
X-Received: by 2002:a17:903:2f0f:b0:24b:1589:5054 with SMTP id
 d9443c01a7336-25d250961b0mr203823045ad.23.1758032580737; 
 Tue, 16 Sep 2025 07:23:00 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2651d2df15esm73459905ad.45.2025.09.16.07.22.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Sep 2025 07:23:00 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	peter.maydell@linaro.org
Subject: [PATCH v2 27/36] target/arm: Remove name argument to alloc_cpreg
Date: Tue, 16 Sep 2025 07:22:28 -0700
Message-ID: <20250916142238.664316-28-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250916142238.664316-1-richard.henderson@linaro.org>
References: <20250916142238.664316-1-richard.henderson@linaro.org>
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

All callers now pass in->name, so take the value from there.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 71dd094fac..da3dd073d3 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -7421,9 +7421,9 @@ void register_cp_regs_for_features(ARMCPU *cpu)
  * Copy a ARMCPRegInfo structure, allocating it along with the name
  * and an optional suffix to the name.
  */
-static ARMCPRegInfo *alloc_cpreg(const ARMCPRegInfo *in,
-                                 const char *name, const char *suffix)
+static ARMCPRegInfo *alloc_cpreg(const ARMCPRegInfo *in, const char *suffix)
 {
+    const char *name = in->name;
     size_t name_len = strlen(name);
     size_t suff_len = suffix ? strlen(suffix) : 0;
     ARMCPRegInfo *out = g_malloc(sizeof(*in) + name_len + suff_len + 1);
@@ -7563,7 +7563,7 @@ static void add_cpreg_to_hashtable_aa32(ARMCPU *cpu, ARMCPRegInfo *r,
                                cp, crm, opc1, opc2, key);
         break;
     case ARM_CP_SECSTATE_BOTH:
-        r_s = alloc_cpreg(r, r->name, "_S");
+        r_s = alloc_cpreg(r, "_S");
         add_cpreg_to_hashtable(cpu, r_s, ARM_CP_STATE_AA32, ARM_CP_SECSTATE_S,
                                cp, crm, opc1, opc2, key);
 
@@ -7593,7 +7593,7 @@ static void add_cpreg_to_hashtable_aa64(ARMCPU *cpu, ARMCPRegInfo *r,
          * and name that it is passed, so it's OK to use
          * a local struct here.
          */
-        ARMCPRegInfo *nxs_ri = alloc_cpreg(r, r->name, "NXS");
+        ARMCPRegInfo *nxs_ri = alloc_cpreg(r, "NXS");
         uint32_t nxs_key;
 
         assert(nxs_ri->crn < 0xf);
@@ -7816,7 +7816,7 @@ void define_one_arm_cp_reg(ARMCPU *cpu, const ARMCPRegInfo *r)
     for (int crm = crmmin; crm <= crmmax; crm++) {
         for (int opc1 = opc1min; opc1 <= opc1max; opc1++) {
             for (int opc2 = opc2min; opc2 <= opc2max; opc2++) {
-                ARMCPRegInfo *r2 = alloc_cpreg(r, r->name, NULL);
+                ARMCPRegInfo *r2 = alloc_cpreg(r, NULL);
                 ARMCPRegInfo *r3;
 
                 switch (r->state) {
@@ -7827,7 +7827,7 @@ void define_one_arm_cp_reg(ARMCPU *cpu, const ARMCPRegInfo *r)
                     add_cpreg_to_hashtable_aa64(cpu, r2, crm, opc1, opc2);
                     break;
                 case ARM_CP_STATE_BOTH:
-                    r3 = alloc_cpreg(r2, r2->name, NULL);
+                    r3 = alloc_cpreg(r2, NULL);
                     add_cpreg_to_hashtable_aa32(cpu, r2, cp, crm, opc1, opc2);
                     add_cpreg_to_hashtable_aa64(cpu, r3, crm, opc1, opc2);
                     break;
-- 
2.43.0


