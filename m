Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07F96CAC5AE
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 14:17:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v299z-0000mt-JG; Fri, 26 Sep 2025 10:10:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v2995-0008Ip-61
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 10:10:00 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v298U-0005k8-Hp
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 10:09:54 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-46cb53c5900so24401025e9.3
 for <qemu-devel@nongnu.org>; Fri, 26 Sep 2025 07:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758895756; x=1759500556; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=EHT5aieK++hY09AXJRzSJMjJlTqqjIrNE0E91jZWOnU=;
 b=k3h+ezv8cGAF8VMTKNhXzbZGuJZwqKO3GMflT3qu60Tn5IOUzmOgEjgjyLeLgG4MzD
 6E//d34Tolj+HHgszK9TkDveuLWYoHjB83QN8MA3joHPllr8XmJm6eNHopsZnRcjGyUg
 qk2BVSCMaVYU0fBMp3YqWnnJElruWn++0Bzp4xQlAt4sQGE3Ic7JAmeJgIuld4ETxbVT
 Xs+iP321lursVciomGoZrT6k/VVnWGEY2bQBzGwHWM79xarvbh1chqk9AoPkrxhi5DsV
 Rewl7qWbMmzsFEqWEh0n3gSK0Vi4zIL+4iU+P2LN1sFE3Dza1gIJDiMX3YKPvOvPl9Q3
 Y26Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758895756; x=1759500556;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EHT5aieK++hY09AXJRzSJMjJlTqqjIrNE0E91jZWOnU=;
 b=KEH++EeuuJJ7w/6fdS6Cxj+pd37/6pHrNaLL5iKAtEPnuC3vliBwtTQtxJTEHaRB78
 O4RFT/nkV4r4eHKZzTB4f7W184X6hOId2mc8CX8RD5MFC8EdZHBnz9qi6VOWufvKH7H4
 qkOnZaZSI3PkP76gLfUOEoj+Q74zGuvP1k4w8IwuXP2DysD+2wvqCj3Oyiyg0i0CZwP+
 xPyGc/Qk/WMuKjZs12upRi62aAAEZqU+tXW6pUEi5+UUTyVp+2X3md+JtDw+gxDZS08P
 E33v1x3Cj6PcCOlLSnU7KCjP/H/hQhVOp0cu7+FC+zu5c9YJE6EjGVlJEbP+k4ypWWU+
 i1GQ==
X-Gm-Message-State: AOJu0YxMKvGfbi00ukJzVCbgcnuTxtSqc5PWh5DFR28wq7Q1o4VZ7YOa
 fN9SPLNJc5l/DNc95wLuCe2u4bkfkmVvyI+lW5/mRM7sukUd2FJ6DNOjIJ+jCAxVxgd+jtsOFKK
 N7HQF
X-Gm-Gg: ASbGnctYg4ZTEqdPduO6RSuSd6tAzoyphkwuMh2SE+gFpUdS6macImbGTdivFPm2WGc
 kij5DgcJJvvY3msbcl7pfzwkDh8MZFt8f6sKVIfkUMF4BmcePkXPpPot3hMBPhoX5IL3h2Ac9/X
 b90fWx6L/t7JIczZ2WBgzwFETIbvbSm22p3vLDD9ithVop1SBIymyivo2O8du0JAebxftg9MwM5
 vzzbpv9Y0W1GZ+tpq4u95i3Ko0uUFtXOmO7Gml4uKouFVOBiBjCzqYhLNRqNSfBbMdKQ2YhQRfI
 UcdmCJW/0dFTLwUqCMgvcZyieWKmxmj7qY3pE0fBW86uUvH2WS3FB5BDBE9rBMNy1rjEoB97Pib
 z0tGBsJNjwx0dvUYvWxStjettPozOJ7cQ8Pv+zcs=
X-Google-Smtp-Source: AGHT+IGvq0kJ/TJjv26NaVeMufVVCbtQ2B4xt62kq1dWQKP58KFNCUHfC6CtVr3RnjmbMCzC8UGIGA==
X-Received: by 2002:a5d:5889:0:b0:3ec:98fb:d767 with SMTP id
 ffacd0b85a97d-40e4d9c9f15mr7510691f8f.58.1758895756215; 
 Fri, 26 Sep 2025 07:09:16 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-410f2007372sm6338315f8f.16.2025.09.26.07.09.15
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Sep 2025 07:09:15 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 29/44] target/arm: Remove name argument to alloc_cpreg
Date: Fri, 26 Sep 2025 15:08:29 +0100
Message-ID: <20250926140844.1493020-30-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250926140844.1493020-1-peter.maydell@linaro.org>
References: <20250926140844.1493020-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

All callers now pass in->name, so take the value from there.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 88b5ec1a5a2..a199320f140 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -7366,9 +7366,9 @@ void register_cp_regs_for_features(ARMCPU *cpu)
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
@@ -7508,7 +7508,7 @@ static void add_cpreg_to_hashtable_aa32(ARMCPU *cpu, ARMCPRegInfo *r,
                                cp, crm, opc1, opc2, key);
         break;
     case ARM_CP_SECSTATE_BOTH:
-        r_s = alloc_cpreg(r, r->name, "_S");
+        r_s = alloc_cpreg(r, "_S");
         add_cpreg_to_hashtable(cpu, r_s, ARM_CP_STATE_AA32, ARM_CP_SECSTATE_S,
                                cp, crm, opc1, opc2, key);
 
@@ -7538,7 +7538,7 @@ static void add_cpreg_to_hashtable_aa64(ARMCPU *cpu, ARMCPRegInfo *r,
          * and name that it is passed, so it's OK to use
          * a local struct here.
          */
-        ARMCPRegInfo *nxs_ri = alloc_cpreg(r, r->name, "NXS");
+        ARMCPRegInfo *nxs_ri = alloc_cpreg(r, "NXS");
         uint32_t nxs_key;
 
         assert(nxs_ri->crn < 0xf);
@@ -7762,7 +7762,7 @@ void define_one_arm_cp_reg(ARMCPU *cpu, const ARMCPRegInfo *r)
     for (int crm = crmmin; crm <= crmmax; crm++) {
         for (int opc1 = opc1min; opc1 <= opc1max; opc1++) {
             for (int opc2 = opc2min; opc2 <= opc2max; opc2++) {
-                ARMCPRegInfo *r2 = alloc_cpreg(r, r->name, NULL);
+                ARMCPRegInfo *r2 = alloc_cpreg(r, NULL);
                 ARMCPRegInfo *r3;
 
                 switch (r->state) {
@@ -7773,7 +7773,7 @@ void define_one_arm_cp_reg(ARMCPU *cpu, const ARMCPRegInfo *r)
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


