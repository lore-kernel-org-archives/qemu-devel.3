Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33202CCD184
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 20:09:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8lK5-0002hq-3z; Tue, 14 Oct 2025 16:08:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v8lK4-0002hR-24
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 16:08:40 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v8lJ9-0005PP-Na
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 16:08:39 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2698384978dso40792705ad.0
 for <qemu-devel@nongnu.org>; Tue, 14 Oct 2025 13:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760472460; x=1761077260; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tKYajIIy5+4u2VD9lJPyAYB3arxlnnF2syyQrLyXqWg=;
 b=hfFB7JMxgmCjKCJMic11fAzIdhUA+oeAuksIobwCoguJU8WP+4CEWHmPTbaxxAk+kk
 KQN0dqslNsMxGc0F6K3OpGVuVyjBUyMN/RcxhW1b+TgCjJudZV+dfhG0Whb3wL+jMi8v
 WQQSdqUKBFBzYUPnd7/E0qOhGYiKGBDoNLoMWJReZfJhuUx5CTjAxWbKkPg6NxqsZob/
 eaXcUe2bhoMaZoDh5EPM9RNrHgxIk7GkY6gc9u1wdpqqKshRWbeH0ZVx+810Nkk1umPs
 3SxeIk2T5jSOm6Rf9XC/HW6QkRmd+/X2PsV+23pgT0BLPfMyaRDhUnuDhStWUAWryz2u
 FuYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760472460; x=1761077260;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tKYajIIy5+4u2VD9lJPyAYB3arxlnnF2syyQrLyXqWg=;
 b=KM5dG5YZGC52R0GKEjzAQYqagDqL5kgSqcj178IEgwEPt0gI9gGpqEU1JvH8Kquv2k
 t0KtCZisd2CaaZbr4PMnT2cSdoZywIJd6jyVJIOsSHrB8qcpg75yQHynKQzGct8hPZ3D
 oZsLOQePeZ4tDVdmcg5pZHbxsSqXVEtbb/4KFhFIfpqTXWJ+mpA9w6QzXfQL/smlLMQG
 Q4GCk32k9Zn1jQYqlY/KGn1xwKlaNvciPmsrxsYKpszdieAROeoFioOxDoPToifcNgj3
 efSzngoXH56Tsvmu+EHxYOx1x4RF+P/Mt+8Px6PEcD4ob7YuWmJTL4OzKbUqAKdte36t
 AXPA==
X-Gm-Message-State: AOJu0YzkgdEL5NgtlOd6yZ725ctKrLWIByaxeOEgRHanPaJ1pJ2vb+KB
 ro1rK/o+4SLGD72BVDiN+ybOMtKjt6TRQUAdZc9ZDa5D+PAMNtOhu8qGU9ud0RA3urqqx+pwYjE
 SRDtbOoI=
X-Gm-Gg: ASbGncs2lmiMQLsG1SXg2vayKc2NCcjqtMEgHWNgpB0sscZn8SKoM66yJXAvDBAcs/q
 f49d0fZNJOKIqOVeMbA3P7PyPkSP1774tC1zzaNS68c4dJVRvKhuCcONi3FvkvDnRHsYNBN6ash
 rZh2QExrmqmsK1bvAg5PF2QiuwDFIf6LuBb6+SXDkp/eiIbSFRITh4Z3Qhsj+qV/ecz6UX/SCQN
 sjk6LxlvxWXqbB6weaFdIk01eDerpK+JHiq+Cm8bw68U/pU+GOKgf6t8f/qCeMYxvZEj/GJo4wk
 0La8lAXriJuV16jMCdUFOQht66HRrmz3iHtXT/8MjRo9FANVQRfcASpqqVVn2wMp4pW3h04R28g
 YwPGNi5RmhHGkGEYfdQKjo9kmoyowJLNg1c8G8A2DWI9A9BnvbCw=
X-Google-Smtp-Source: AGHT+IFu2IWWBXtJDEDrEHwRRxE99Nfbeq14otUXkAvOdvRzlumPWHCEPqtGksbYPOuuTFsfJDZX/g==
X-Received: by 2002:a17:903:1b64:b0:240:9dd8:219b with SMTP id
 d9443c01a7336-290272e6eacmr344978785ad.49.1760472460227; 
 Tue, 14 Oct 2025 13:07:40 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29034f93ea2sm172100975ad.126.2025.10.14.13.07.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Oct 2025 13:07:39 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v2 29/37] target/arm: Implement TLBIP RIPAS1E1, RIPAS1LE1,
 RIPAS2E1IS, RIPAS2LE1IS
Date: Tue, 14 Oct 2025 13:07:10 -0700
Message-ID: <20251014200718.422022-30-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251014200718.422022-1-richard.henderson@linaro.org>
References: <20251014200718.422022-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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
 target/arm/tcg/tlb-insns.c | 39 ++++++++++++++++++++++++++++++--------
 1 file changed, 31 insertions(+), 8 deletions(-)

diff --git a/target/arm/tcg/tlb-insns.c b/target/arm/tcg/tlb-insns.c
index daadba7bfc..6c07839e3f 100644
--- a/target/arm/tcg/tlb-insns.c
+++ b/target/arm/tcg/tlb-insns.c
@@ -1088,6 +1088,14 @@ static void tlbi_aa64_ripas2e1_write(CPUARMState *env, const ARMCPRegInfo *ri,
                   tlb_force_broadcast(env));
 }
 
+static void tlbi_aa64_ripas2e1_write128(CPUARMState *env,
+                                        const ARMCPRegInfo *ri,
+                                        uint64_t vallo, uint64_t valhi)
+{
+    do_rvae_write128(env, vallo, valhi, ipas2e1_tlbmask(env, vallo),
+                     tlb_force_broadcast(env));
+}
+
 static void tlbi_aa64_ripas2e1is_write(CPUARMState *env,
                                        const ARMCPRegInfo *ri,
                                        uint64_t value)
@@ -1095,6 +1103,13 @@ static void tlbi_aa64_ripas2e1is_write(CPUARMState *env,
     do_rvae_write(env, value, ipas2e1_tlbmask(env, value), true);
 }
 
+static void tlbi_aa64_ripas2e1is_write128(CPUARMState *env,
+                                          const ARMCPRegInfo *ri,
+                                          uint64_t vallo, uint64_t valhi)
+{
+    do_rvae_write128(env, vallo, valhi, ipas2e1_tlbmask(env, vallo), true);
+}
+
 static const ARMCPRegInfo tlbirange_reginfo[] = {
     { .name = "TLBI_RVAE1IS", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 0, .crn = 8, .crm = 2, .opc2 = 1,
@@ -1174,12 +1189,16 @@ static const ARMCPRegInfo tlbirange_reginfo[] = {
       .write128fn = tlbi_aa64_rvae1_write128 },
     { .name = "TLBI_RIPAS2E1IS", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 4, .crn = 8, .crm = 0, .opc2 = 2,
-      .access = PL2_W, .type = ARM_CP_NO_RAW | ARM_CP_ADD_TLBI_NXS,
-      .writefn = tlbi_aa64_ripas2e1is_write },
+      .access = PL2_W,
+      .type = ARM_CP_NO_RAW | ARM_CP_ADD_TLBI_NXS | ARM_CP_128BIT,
+      .writefn = tlbi_aa64_ripas2e1is_write,
+      .write128fn = tlbi_aa64_ripas2e1is_write128 },
     { .name = "TLBI_RIPAS2LE1IS", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 4, .crn = 8, .crm = 0, .opc2 = 6,
-      .access = PL2_W, .type = ARM_CP_NO_RAW | ARM_CP_ADD_TLBI_NXS,
-      .writefn = tlbi_aa64_ripas2e1is_write },
+      .access = PL2_W,
+      .type = ARM_CP_NO_RAW | ARM_CP_ADD_TLBI_NXS | ARM_CP_128BIT,
+      .writefn = tlbi_aa64_ripas2e1is_write,
+      .write128fn = tlbi_aa64_ripas2e1is_write128 },
     { .name = "TLBI_RVAE2IS", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 4, .crn = 8, .crm = 2, .opc2 = 1,
       .access = PL2_W,
@@ -1192,12 +1211,16 @@ static const ARMCPRegInfo tlbirange_reginfo[] = {
       .writefn = tlbi_aa64_rvae2is_write },
     { .name = "TLBI_RIPAS2E1", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 4, .crn = 8, .crm = 4, .opc2 = 2,
-      .access = PL2_W, .type = ARM_CP_NO_RAW | ARM_CP_ADD_TLBI_NXS,
-      .writefn = tlbi_aa64_ripas2e1_write },
+      .access = PL2_W,
+      .type = ARM_CP_NO_RAW | ARM_CP_ADD_TLBI_NXS | ARM_CP_128BIT,
+      .writefn = tlbi_aa64_ripas2e1_write,
+      .write128fn = tlbi_aa64_ripas2e1_write128 },
     { .name = "TLBI_RIPAS2LE1", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 4, .crn = 8, .crm = 4, .opc2 = 6,
-      .access = PL2_W, .type = ARM_CP_NO_RAW | ARM_CP_ADD_TLBI_NXS,
-      .writefn = tlbi_aa64_ripas2e1_write },
+      .access = PL2_W,
+      .type = ARM_CP_NO_RAW | ARM_CP_ADD_TLBI_NXS | ARM_CP_128BIT,
+      .writefn = tlbi_aa64_ripas2e1_write,
+      .write128fn = tlbi_aa64_ripas2e1_write128 },
    { .name = "TLBI_RVAE2OS", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 4, .crn = 8, .crm = 5, .opc2 = 1,
       .access = PL2_W,
-- 
2.43.0


