Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98523CD4F48
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 14:27:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNtUN-0005zx-HC; Fri, 15 May 2026 10:26:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wNtUD-0005qn-Np
 for qemu-devel@nongnu.org; Fri, 15 May 2026 10:25:57 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wNtU9-0000xH-7G
 for qemu-devel@nongnu.org; Fri, 15 May 2026 10:25:55 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-48909558b3aso89053765e9.0
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 07:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778855150; x=1779459950; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=t0rq5jO3cSf426ienLyFOb1GQ8eVJAFyUw3y8YOuBwE=;
 b=r+QUfeeYhkdlwbtvEJTuR2tJwPoluPNI7xgfmWkCLK1QHluR3vGUzgyaJ9IyFgrNkw
 9eJGDm12+zEjGdrsOAl2hlqYpkxjgCGMI/HFJ4Ad/1OXqquShY4CU6m/qckulM5BrWDn
 9poKibNEEC+eLXO49FjqytiQNid1gq4WzT+bwGQUTn4eSyC4DEGNVm/Yi954YcoSyAJR
 aUiOerHt1v/rsIC8nDBx39r9z+1wfI8Xvmfo/nadHSotEhqyK8tei52ANGPXib+Epj+r
 e4zWlkLd3Zvv1qETNACf8OrlbMvmrYPZvYl2FDFQ5xZEgpyVwex1a51v9Muu+sqruM8t
 d5vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778855150; x=1779459950;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=t0rq5jO3cSf426ienLyFOb1GQ8eVJAFyUw3y8YOuBwE=;
 b=qsY9tqaDfpygJimm89qOoanOFaLFLQfT9BSecAIObWZeb7SyMYS+CITA5qjJH/gYc4
 gLJV7WqvV79wZ1Elx2lBP4cABxc+LP7I0Q6Xgj5Kip6krBQB1Mae3eZwfn2HBPNVc1KR
 KmDcH81Jn0LPfltslLTekRrESjEWM4tUe5X9P9I0JALQ3dEOjoYEF9regjUpbhJ5rUXO
 EDF7QbNqQ52VoEXyGrkpe9LOZCBUGJvmm/UtkQfKOgCb/mrgZHWkJH54Lq4Ap3YNIQQt
 wr+9Oqv/Go8mqDDBev1QRpixmSryzhGfZjmjg354V6zTSLcn6bsxOKIuhsdRcWp84kzq
 jy3w==
X-Forwarded-Encrypted: i=1;
 AFNElJ/S0pMJcTigd9UfCfFD8K3KBV8/nmwRFdKEsDKWFBDk/U16uQiHaD6ImcRaRfGClJRvyg6PnxAJ06fD@nongnu.org
X-Gm-Message-State: AOJu0Yy9BD15jpYGdNcb3xH20ptVOdWGHmwuv1/grp9nH4LC/miGDghQ
 p9aX8y3C1HJ7QsLldAdWHm5EAFtQzoLUSwMn85jK4RnS2DEozVJcsNpAYZSXjPT/1Us=
X-Gm-Gg: Acq92OFmsL3Vavlgmwk4B10xoKS8hFtRDncE3HDTn8uDni9ty+k1PE95VJCmq2tpLwt
 7Dc7n9XGPct2Px0h5g8w3KicZx/wOdT1NRl5UzFD3lkpRM9zdqdV61s7OC4HnKtBjxrJdiOr0e6
 erlsrSouberB11/mgBZg/rrPeK66NHNrsB52Lg78Ug1TmQLaw3TldHaCdJg5LF9HOoSASjTBmEw
 YJUiyp2AdjqEDQZt5HHtxmlXhvnkiZ3tBrKUC76v5zhVmMRJjXas5Hi0ZTPUs2uKV+FkfmVb+vp
 uO5VjNBJ76VlKyjlDbdKsWinJjVvcmFP3XXn4PKBC4DDRF8aUpNXHIT8CRi5DMZ+PV9ObzLfXFi
 +3oMcX/K0fSQvt8lajqbTBG9gkYsAEmpXzA+sP0V2NOFIAVQs9DWF0knEHxdFDmQcgTBGokJAvS
 xhjQQsrObl5kGhaa3lJGDSvz/okRmoQCG5Pi3gAg/tBDaaPdhcZt3Mbz/QVcSmyRjNYy+w+x6Rl
 NaPhYWJdo87S6GMdKrt83aFrlQ5qaQ=
X-Received: by 2002:a05:600c:c116:b0:48f:e230:2a22 with SMTP id
 5b1f17b1804b1-48fe6632e84mr45739435e9.33.1778855150544; 
 Fri, 15 May 2026 07:25:50 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45da15a666fsm13560603f8f.36.2026.05.15.07.25.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 07:25:49 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [RFC PATCH 07/14] target/arm/ptw: Flip sense of get_phys_addr_pmsav8
 return value
Date: Fri, 15 May 2026 15:25:34 +0100
Message-ID: <20260515142541.571911-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260515142541.571911-1-peter.maydell@linaro.org>
References: <20260515142541.571911-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/ptw.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 12e700fe07..9e5a7e77c0 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -3191,7 +3191,7 @@ static bool get_phys_addr_pmsav8(CPUARMState *env,
                 result->f.lg_page_size = sattrs.subpage ? 0 : TARGET_PAGE_BITS;
                 result->f.phys_addr = address;
                 result->f.prot = 0;
-                return true;
+                return false;
             }
         } else {
             /*
@@ -3217,12 +3217,12 @@ static bool get_phys_addr_pmsav8(CPUARMState *env,
                 result->f.lg_page_size = sattrs.subpage ? 0 : TARGET_PAGE_BITS;
                 result->f.phys_addr = address;
                 result->f.prot = 0;
-                return true;
+                return false;
             }
         }
     }
 
-    ret = pmsav8_mpu_lookup(env, address, access_type, ptw->in_prot_check,
+    ret = !pmsav8_mpu_lookup(env, address, access_type, ptw->in_prot_check,
                             mmu_idx, secure, result, fi, NULL);
     /*
      * For two-stage PMSA translations, s2prot holds the stage 2
@@ -3755,7 +3755,7 @@ static bool get_phys_addr_nogpc(CPUARMState *env, S1Translate *ptw,
 
         if (arm_feature(env, ARM_FEATURE_V8)) {
             /* PMSAv8 */
-            ret = get_phys_addr_pmsav8(env, ptw, address, access_type,
+            ret = !get_phys_addr_pmsav8(env, ptw, address, access_type,
                                        result, fi);
         } else if (arm_feature(env, ARM_FEATURE_V7)) {
             /* PMSAv7 */
-- 
2.43.0


