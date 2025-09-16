Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61B12CAC599
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 14:23:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyWaZ-0005wJ-2u; Tue, 16 Sep 2025 10:23:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uyWaC-0005lP-P2
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 10:23:07 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uyWa3-0008JV-UQ
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 10:22:57 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-24c8ef94e5dso44815505ad.1
 for <qemu-devel@nongnu.org>; Tue, 16 Sep 2025 07:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758032569; x=1758637369; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BYeHdzgqxopt1Gh2oK2nmvzJnOBU1f7KAls9HRaywqQ=;
 b=PWlzF3zqt7VRBpqfd7Pmvyk0prNmZ1potWL3eEe9qmxbiLmKJ2vNqGZqaRdbNQ2xyU
 wb0yv0gbn0g4kVqTWbneGm5Edl4oBEsm3CugI7atbIUCTE8vE9rcUYw6hELkCeX6b9ef
 h7TwpaF0VT0s1BAlMOrSAdTLw0dWSsvLe+n8C5K+D7Mc6lmUaoHRqkPW+gxuhxGEMtI0
 kivwMaLr7/n28KuzAMqFtxTLmJAlAdJ4Rd81lGsXI2blzgCiJB6qN7+YOtnROJU+wrYw
 X6v4BQ2hhl+PbuB9x5P6vj2W2us7LDWMeNZXm7TUTy4sZOH6wzb1He3VmgEILt61wZmd
 dTWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758032569; x=1758637369;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BYeHdzgqxopt1Gh2oK2nmvzJnOBU1f7KAls9HRaywqQ=;
 b=iZAaknnpcn0NykekgD80DnZtjrNOJ2mNRbA4eCCdcvifnV5LhKT/7MbL/aa/CuK9XZ
 foipK1IsMSKYidEZks3RKvEpJkHQSorGaOVqBhUe8RPynZT+fR9HZArYHABgEUnnoqxN
 zVC8hCHrKufjtxuUIA0AU5tCzG7xY/poePzz5Ck/D3RXOKIx+Fw8KXdUYyA0cF4Ym+9p
 flV02l/sua2+KPE+TfeanTGJIkf4j90YQ0VTQTZxM621oetxlxvS6qrYl4WrN+wiO38X
 vasqDbhPirMhmYIryg+FwdO4tWoCOEvJ7AotrAlEnhtnMdHb+vnkbO4gei02zkk5epMx
 lYkA==
X-Gm-Message-State: AOJu0YwncG5CrXpgNQ1fLGvPiHnqLx4diCkxZqbh/1NW+My6jut8xgrY
 9zcov6Q+jAY/FRs1jZJsPTNUW/aZ0iQqrNeb66XV/aF1zKfJVDbhaAgJ17O6zeY5xsE+A2UcXs9
 KiTy+
X-Gm-Gg: ASbGncscpR6tUBX6g0KvbJ9gn4O2lWyzv6ItZ09fpeIZ2nyWZaTf6USBny8KX0/Ox5k
 PtIZjv9/TGJYWcT338pWTAkAgTRlQ5cPg4X6KaU/hY3r7eDX7Pqnkpm8jGGuhAaJjGW1qh2qpJR
 3IHvUMfzp0OB0/BQNQNM55OMdRAJtCxmJ9HpqK2oubj+isdA1FMCx1SqNfWgw3SGyp/WRMX2EQM
 uKg3hLwEpJ/qBe08lCx95St8vvYCRIjCVCG0VFtVjnEf+a2/GleMx9AZ/YCrVcTwhp4GilR0d5w
 IM/04vuo4KpmGewDQI0q/mvhhs5MmoieSzQ6ctP2GcpuaxQfHFnXk1tHuFjz01TOUW06Rl9XjxE
 hacAUOV3DdNKGZ1RmefTLnO3DE3iK
X-Google-Smtp-Source: AGHT+IE/n0rkogzIMqt7yinLBP3MltOfxIb+FqpDb1LH5vRquOq/wP5uUqwz/X2Sv7pnSJHiGkzF+w==
X-Received: by 2002:a17:903:2b10:b0:266:49eb:45cc with SMTP id
 d9443c01a7336-267d15efb43mr32448395ad.19.1758032568694; 
 Tue, 16 Sep 2025 07:22:48 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2651d2df15esm73459905ad.45.2025.09.16.07.22.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Sep 2025 07:22:48 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PATCH v2 11/36] target/arm: Rename all ARMCPRegInfo from opaque to ri
Date: Tue, 16 Sep 2025 07:22:12 -0700
Message-ID: <20250916142238.664316-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250916142238.664316-1-richard.henderson@linaro.org>
References: <20250916142238.664316-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

These pointers are no opaque, they have a specific type.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpregs.h | 10 +++++-----
 target/arm/helper.c |  6 +++---
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/target/arm/cpregs.h b/target/arm/cpregs.h
index c9506aa6d5..3344a02bd3 100644
--- a/target/arm/cpregs.h
+++ b/target/arm/cpregs.h
@@ -841,15 +841,15 @@ typedef struct ARMCPRegInfo ARMCPRegInfo;
  * Access functions for coprocessor registers. These cannot fail and
  * may not raise exceptions.
  */
-typedef uint64_t CPReadFn(CPUARMState *env, const ARMCPRegInfo *opaque);
-typedef void CPWriteFn(CPUARMState *env, const ARMCPRegInfo *opaque,
+typedef uint64_t CPReadFn(CPUARMState *env, const ARMCPRegInfo *ri);
+typedef void CPWriteFn(CPUARMState *env, const ARMCPRegInfo *ri,
                        uint64_t value);
 /* Access permission check functions for coprocessor registers. */
 typedef CPAccessResult CPAccessFn(CPUARMState *env,
-                                  const ARMCPRegInfo *opaque,
+                                  const ARMCPRegInfo *ri,
                                   bool isread);
 /* Hook function for register reset */
-typedef void CPResetFn(CPUARMState *env, const ARMCPRegInfo *opaque);
+typedef void CPResetFn(CPUARMState *env, const ARMCPRegInfo *ri);
 
 #define CP_ANY 0xff
 
@@ -1075,7 +1075,7 @@ void raw_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value);
  * CPResetFn that does nothing, for use if no reset is required even
  * if fieldoffset is non zero.
  */
-void arm_cp_reset_ignore(CPUARMState *env, const ARMCPRegInfo *opaque);
+void arm_cp_reset_ignore(CPUARMState *env, const ARMCPRegInfo *ri);
 
 /*
  * Return true if this reginfo struct's field in the cpu state struct
diff --git a/target/arm/helper.c b/target/arm/helper.c
index df9e0c7bca..4ba76c80b1 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -1073,7 +1073,7 @@ static const ARMCPRegInfo v6k_cp_reginfo[] = {
       .resetvalue = 0 },
 };
 
-static void arm_gt_cntfrq_reset(CPUARMState *env, const ARMCPRegInfo *opaque)
+static void arm_gt_cntfrq_reset(CPUARMState *env, const ARMCPRegInfo *ri)
 {
     ARMCPU *cpu = env_archcpu(env);
 
@@ -5426,7 +5426,7 @@ static const ARMCPRegInfo rndr_reginfo[] = {
       .access = PL0_R, .readfn = rndr_readfn },
 };
 
-static void dccvap_writefn(CPUARMState *env, const ARMCPRegInfo *opaque,
+static void dccvap_writefn(CPUARMState *env, const ARMCPRegInfo *ri,
                           uint64_t value)
 {
 #ifdef CONFIG_TCG
@@ -7884,7 +7884,7 @@ uint64_t arm_cp_read_zero(CPUARMState *env, const ARMCPRegInfo *ri)
     return 0;
 }
 
-void arm_cp_reset_ignore(CPUARMState *env, const ARMCPRegInfo *opaque)
+void arm_cp_reset_ignore(CPUARMState *env, const ARMCPRegInfo *ri)
 {
     /* Helper coprocessor reset function for do-nothing-on-reset registers */
 }
-- 
2.43.0


