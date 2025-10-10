Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00C12CCD185
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 13:18:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7Cpm-0006Ss-KZ; Fri, 10 Oct 2025 09:06:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v7Cpe-0006Pz-OH
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 09:06:51 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v7Cp2-0003um-Lh
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 09:06:50 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3f2ae6fadb4so2384688f8f.1
 for <qemu-devel@nongnu.org>; Fri, 10 Oct 2025 06:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760101564; x=1760706364; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=292z2MU02er6ms83N6eXvrBWbKEHO79Jw5fbecSdDAQ=;
 b=sNRw7/ewvluQRCe/bRbcYF7+u/lZNCiD9AW0Cmpc9ZQ0n3a4Z1x8/BwwLHTC9rwfRQ
 IqOzHa9YgSIo05ShaYkQfsFQ7KOKjwY7srt4VdhtWj9Ze/Arl4iXKuC9hOaMg8mdrUcx
 +qZddBrQQxA6ilLTInQB29jDys5M4fD3DKsC0UgrW/DRpds59fs6il39bs+WL/04DfFF
 CoS/CI9uz03Z+p1CAq9It86hG6y9A/kYwwdfF1frWXvmcP1FE3iEtK4n9BKTc5NoGvHJ
 A1O2N8MIb8c+ihJsg5o4nrYiervYMfV8wJQnC40GzDMgh4UgyyWXuj+LCSoQdRQH88AZ
 O0iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760101564; x=1760706364;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=292z2MU02er6ms83N6eXvrBWbKEHO79Jw5fbecSdDAQ=;
 b=R8ocuitHwzkkx4TYTO29A0IvAADAEewn4mWA3/zLiKr53tOu1B8d7gHD+SfXDK5PKj
 XvJMWiw3BPLv6NZSDDn8Ls9tovscciLspSSuKAbFWvuMGTXIVQMz2V7ReDYjyVEHyLU+
 3WdEPTpW/zIWCtlGgKbWf2AFR5iPETmIzXHvw887QEpH1Rv7GfwnCe6WY22hYV7TINw0
 gPy4Dedqx80+VqVA5muEIshokddusTMxNxD2X2sv5um30V0Jcx5gV/KQgOZCujlh3PNF
 cKUPiwrnKhbrMNa0CwCyqCIFG00vd+ybht1OCX/5QInUj/jXhnIZe640DjPITSDLmTxE
 V05g==
X-Gm-Message-State: AOJu0Yz/4n1cWb7JZzqGKwZkum9P0P7xos8XgNtm0n69ijXLaCkrpw2c
 0iNGheA6XTI3fr+r45eUyvVgL714SgdLoCDm333qc4qzQxQPjllJn8gXOSVlu5FXUKCHtzTBFwI
 LU7Gg
X-Gm-Gg: ASbGncv7LtRnLXJgw4gQGBKoEqYsBFnSIsM32NVjGkrTHmsSkkv+j62Gvt//qPYtR3D
 fe2CCYeDo+Sz5pwOxCwo0+Y2d2gqH235sCJI0w6A2+R/IZxgQ3YItKtTuV5FMM2Slb3wdNrWYg3
 Te2pHqnmfazSRu6lIhDldfnCQ9xNhQijpW7W0ZSPCrqFhzZ8MHTZ0de4Ew+pP7mO1/GPCTSY/BA
 8OA2awbyVekNdMCKLn0McN/KxDte+FZYMUJOXjX9qAh0kxWa15LK641TQHQfHqvgciEY3PC2LUv
 sCpOTCqEsAWVr0B6B4r8kP+GEjvkct4HJ9zz3dnXRw4dqj4cmq/3RCDdZQd+WnxXWFePbpBYQ+3
 otchRpOHVggTluQATKy3gw9X+qtoGf1QxET+tysw6NZieV3y1gak=
X-Google-Smtp-Source: AGHT+IFhqH/MNW9tJ+1XU0ve0NGblBXTkKwG3mADVhovWZtQh+s4W1iKHNMFZvpB79DJNkSQTiHmjw==
X-Received: by 2002:a05:6000:2c11:b0:405:3028:1bce with SMTP id
 ffacd0b85a97d-4266e7dfffcmr7655260f8f.32.1760101564017; 
 Fri, 10 Oct 2025 06:06:04 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce583316sm4221657f8f.20.2025.10.10.06.06.03
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Oct 2025 06:06:03 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 30/76] target/arm: Implement gcs bit for data abort
Date: Fri, 10 Oct 2025 14:04:41 +0100
Message-ID: <20251010130527.3921602-31-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251010130527.3921602-1-peter.maydell@linaro.org>
References: <20251010130527.3921602-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20251008215613.300150-31-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/tlb_helper.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/target/arm/tcg/tlb_helper.c b/target/arm/tcg/tlb_helper.c
index ae2acd67276..f1983a5732e 100644
--- a/target/arm/tcg/tlb_helper.c
+++ b/target/arm/tcg/tlb_helper.c
@@ -28,7 +28,7 @@ static inline uint64_t merge_syn_data_abort(uint32_t template_syn,
                                             ARMMMUFaultInfo *fi,
                                             unsigned int target_el,
                                             bool same_el, bool is_write,
-                                            int fsc)
+                                            int fsc, bool gcs)
 {
     uint64_t syn;
 
@@ -78,6 +78,7 @@ static inline uint64_t merge_syn_data_abort(uint32_t template_syn,
 
     /* Form ISS2 at the top of the syndrome. */
     syn |= (uint64_t)fi->dirtybit << 37;
+    syn |= (uint64_t)gcs << 40;
 
     return syn;
 }
@@ -252,9 +253,10 @@ void arm_deliver_fault(ARMCPU *cpu, vaddr addr,
         syn = syn_insn_abort(same_el, fi->ea, fi->s1ptw, fsc);
         exc = EXCP_PREFETCH_ABORT;
     } else {
+        bool gcs = regime_is_gcs(core_to_arm_mmu_idx(env, mmu_idx));
         syn = merge_syn_data_abort(env->exception.syndrome, fi, target_el,
                                    same_el, access_type == MMU_DATA_STORE,
-                                   fsc);
+                                   fsc, gcs);
         if (access_type == MMU_DATA_STORE
             && arm_feature(env, ARM_FEATURE_V6)) {
             fsr |= (1 << 11);
-- 
2.43.0


