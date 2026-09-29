Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA378CA5FA1
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 10:04:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBUfA-0007QS-KE; Tue, 29 Sep 2026 06:02:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xBUf6-0007DZ-0Y
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 06:02:12 -0400
Received: from mail-wr2-x0f.google.com ([2a00:1450:4864:30::f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xBUf4-0008DD-C9
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 06:02:11 -0400
Received: by mail-wr2-x0f.google.com with SMTP id
 ffacd0b85a97d-4888129c46eso2222998f8f.1
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 03:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790676129; x=1791280929; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=3E1j13XxexociUAT7fIrLPdI7KyK/OVHkL2j46CvOVs=;
 b=zlMHhfHtoiWUVDw9sfVOzaqUppN4ZBPE2+ZCXPNaiuZ+3Xv0GKjub4a1YgnJQfauZa
 XQXNCbm9zjaiFweK6jqSasd+8+MywXarEYnpqTLm/eU2aBMQyWbMN5mpnCJ0fzJFD79V
 Xrf+zHiykottazKBf4y50lg07DEyRy/q/EUKFQ5hWnONhd00tUfB+M+OOGpLHeVJKt2Z
 XpCGvcKXBppelxSDd+DqYKJX5vZQd5aczdrsADZdJb8yRjRR5NAoneqT0LCjpbJS+N9B
 W5l49I+qr7G0PCh9USjQE1Sur6jn0qbVCr0x49usYEllZqjO/iragNgAMJbXwSNx4zOE
 b0Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790676129; x=1791280929;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=3E1j13XxexociUAT7fIrLPdI7KyK/OVHkL2j46CvOVs=;
 b=rJDiOET1QBGBkmzaRqSny3JmeBvDgsuoy0ZM0k8QChtLk3nuiF2g7bu672ZibnASMs
 TsGkNlsnHoLCNC7nAj4V1lz3o8nGH1EH7skQwoW/sxggr5NiDSNBBnqlU4htqm41hjge
 JKqZCIo+LhNnQWIUOwXDIpzuM6mv4BzPf+lMe9leqMAF8XXw+I6SmAqEyLY5RZQ82NT3
 wT7PhYv+CdFprljsp6siHd/UxYfnvEBG3mmg0+CpFh5Qxo/xorvLcshsqRfBMz/SFfiv
 E4Gbegf2Q8Z6y5uXcgF9z0KbcVyqEKei6LUsREOtD+9nWCniUn2NHWq9nNuZudyE2MSr
 cm/w==
X-Gm-Message-State: AFq9FYJdwQuQoiTuQDWToTxLBXIY+UPYqCr0KZXZ3NjEVkvAVzkGzxHZ
 J3ZJ3XZnL9BJJmAHYZnmrmKeBXFB3DhLXn0qv6DlAsDi9MIIOLD7JixaWbao2aMWYI6oYLzEifN
 x6Bee
X-Gm-Gg: AYBFou0rAnSrEiHk5gjgZ4Ypn1RmxTEyYwFRWH9QgJFw+WKCgZZxtdrPAcrWffoc/Bg
 aysTv3K9m3dVDDrJBHKp0TS7fRvGWv9dtUDjRYM8HAnl0QKnhT5iqQ0v4mZGmYtk40hboGWofWy
 OdUjoRSUzNCmE8V5lvkpCorPVPKMUTomXvyZelYWDSK2nhYPJg3RH6eMqJcdKQ8oxfLmvW4zxZk
 QTd725CJS2dfv/AFTmeAYjdhcMfaZceb55W8Pf+0qPQbvOPupfGK2C/pIqqgzeG8VFUAemaDlNZ
 jnKljGPvHBdP+qWkXyaCLKI1ks+vZmnlIR424yZQm2KFyFAW5BMxqbyLBnhxZF1Ts9tF/80yBPI
 tNA7NstrcW7Ejd2H6ECmH0mTkr4jgoT9Z3jtKxl8F0f0Jo5jqIRwlcV520Z1z530Ec5FeO8behy
 MfTgQLiOr6fOz4fgF//V03Y71f7+gXpUJANVASU5wgXFpa/eiTIWSWx5JqIe6j5x7wKNK1peDgp
 6QAw07lUUZFUYp/RJCPo4EucTk3SNv/m/eZwKW/6xZIDH2/nXqYI3g4FQwHYH+S+pelHworiFes
 eFwS
X-Received: by 2002:a05:6000:4021:b0:482:fd9c:3740 with SMTP id
 ffacd0b85a97d-48871678f1amr28210411f8f.22.1790676128438; 
 Tue, 29 Sep 2026 03:02:08 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48af4f88b37sm3091412f8f.5.2026.09.29.03.02.06
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 03:02:07 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 21/37] target/arm: Fix PMSAv8 shareability decode for R-profile
 MPU regions
Date: Tue, 29 Sep 2026 11:01:16 +0100
Message-ID: <20260929100133.2598676-22-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260929100133.2598676-1-peter.maydell@linaro.org>
References: <20260929100133.2598676-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:30::f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr2-x0f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

From: Jean-Francois Bortolotti <jeff@borto.fr>

In Armv8-R AArch32 the shareability field of an MPU region lives in
PRBAR, not PRLAR:

  PRBAR: [31:6] BASE  [5] RES0  [4:3] SH  [2:1] AP  [0] XN
  PRLAR: [31:6] LIMIT [5:4] RES0  [3:1] AttrIndx  [0] EN

(Arm Cortex-R52 TRM 100026_0103_00_en: Tables 3-80 and 3-83 for
HPRBAR/HPRLAR, Tables 3-124 and 3-127 for PRBAR/PRLAR.)

Without this fix, address translation instructions like ATS1HR
will return wrong value for PAR.SH.

Cc: qemu-stable@nongnu.org
Fixes: fca45e3467f7 ("target/arm: Add PMSAv8r functionality")
Signed-off-by: Jean-Francois Bortolotti <jeff@borto.fr>
Message-id: 20260925234136.1182108-1-jeff@borto.fr
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/ptw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index f537502d3b1..de0435a58b8 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -3092,7 +3092,7 @@ bool pmsav8_mpu_lookup(CPUARMState *env, uint32_t address,
         if (!arm_feature(env, ARM_FEATURE_M)) {
             uint8_t attrindx = extract32(matched_rlar, 1, 3);
             uint64_t mair = env->cp15.mair_el[regime_el(mmu_idx)];
-            uint8_t sh = extract32(matched_rlar, 3, 2);
+            uint8_t sh = extract32(matched_rbar, 3, 2);
 
             if (regime_sctlr(env, mmu_idx) & SCTLR_WXN &&
                 result->f.prot & PAGE_WRITE && mmu_idx != ARMMMUIdx_Stage2) {
-- 
2.43.0


