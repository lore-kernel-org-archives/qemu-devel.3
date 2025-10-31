Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DBE0CCF9F8
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 18:38:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEtwK-0004DU-7S; Fri, 31 Oct 2025 14:33:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vEtwI-0004CX-Pu
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 14:33:30 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vEtw9-0006B2-TN
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 14:33:30 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-427007b1fe5so1949576f8f.1
 for <qemu-devel@nongnu.org>; Fri, 31 Oct 2025 11:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761935596; x=1762540396; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=DbjOgOkfCwrBdURCcMUb2IkYqGbbFToEjPFT+iXympU=;
 b=xEatXUGgHUjGFnLBLuGMz1wIyOLdLb99qJOLzEhxuoRG43fUzsouM3Koyy2zuqdevW
 DbU4o0dzfFVsLOg9g47rqb/A7BtI9GNn2vtY88tKsF/hGzTjG18YRKyu1752wQO115eF
 O0LpmuGsdb8PJ5crp6Dpw9h7F/A5EJX+Yybo+KWKNh2JFnY7jhQWZZUW7WANdo520xi+
 hmckkyT65TJmQyrJwFIMWgOu3TkSB4G68oq2jpSv1zxslanXME99QswTk2BX0v/JuDBs
 DpL8p8eWwUZ4+hl6m2wD3GKs8ejLJojIATYZF0vpBih1VU1aEDX2t7JH5/kHLJ1Fg67j
 P5Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761935596; x=1762540396;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DbjOgOkfCwrBdURCcMUb2IkYqGbbFToEjPFT+iXympU=;
 b=Bm9lBFewZCKCwr0ByIHHlklaYnBFwjpO06AWSG9D1V5+CRMIivFCMIL42K+sUfvqe+
 8FWKBkJ5iGl32Rjrsx3XV6QKzetD80Qt4Rd8XYw+UN1QJ757AuTVp7ns8eGEh5myTiam
 c7OtjdgOsj2gzPc8qM4YnjXXlhXTACZV88q0hVri1tN5MmFUqo57lth+8SuX7mqOeHKG
 WMMotA0m2++aWRV+5oQtdI7f7Dx2R2BIsVStDmuboddgfv5kFXddxMvzsHX0ZP7cF3BG
 t2yiEyKoNCKb/EbTKmIakAcWvJu6HT39LIzw6C8B95rOiQmLPeXgRZ4qR2uD62byDMty
 oVcg==
X-Gm-Message-State: AOJu0YzFRVeeykbjXnnCrpFFVVsn2hdXWaSW/wCWvK1qeKtlWU0txDmb
 zjFl1l0gDZTopdmxf7RT4N5d2MTYYlyQ37zNDn/5gP7PVlEWPfwVE1vc5QwN9HN45InLP0yCB+c
 g1ix7
X-Gm-Gg: ASbGnctVgoZTuocXM1ZiQ06bTOwLnWB3vfx7DwE0NHvEuo/+l9BEDMZ673FTmct30oe
 ze7dj9exZSN9cpPu2ZtQZh7R46sbzBnk3GWNN6gwANaSGDvi3fIfAKcAj5noKSjhrl2Ud1kgJn5
 BzRGeuju1Lwjalg2NBRSAT3x6dfvmsPof8jIoPmjDIHDxEk3UnaUUbmZPpYb2tykjRBCrwQ1+mC
 VBwLVKJKXdiHwaYZjIp3exlWzKGreFchPdVdTPdBViJVSun8hKJyHwwwcG3awha8054MnljvKJY
 jc4dbFRq5xET1Gw2NWnDudqCHKoYSXxglSSsJATULvQ8wjCprigXjb+9PN1mKTLN/xLSyPXfmvD
 wHH/lbczTXmTeAIZXA5MoTRhUMho+IRX59UB+X/HTQ2YOD4rcnHf87fyL3y55l1+tnOYqUaMkiw
 UtF5ksEnLJ48n6tCsF
X-Google-Smtp-Source: AGHT+IFPCX5wqeU2TGO0V9X7is8dNJFVDpvQSM+8edbEqwHJi/v5dyS2Safv7gnx/lhkMC1fhaWIhQ==
X-Received: by 2002:a05:6000:4387:b0:429:b1e4:1f74 with SMTP id
 ffacd0b85a97d-429bd683753mr4358098f8f.20.1761935595757; 
 Fri, 31 Oct 2025 11:33:15 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429c114c944sm4859142f8f.20.2025.10.31.11.33.15
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Oct 2025 11:33:15 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 04/38] target/arm: Add assert to arm_to_core_mmu_idx()
Date: Fri, 31 Oct 2025 18:32:36 +0000
Message-ID: <20251031183310.3778349-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251031183310.3778349-1-peter.maydell@linaro.org>
References: <20251031183310.3778349-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42f.google.com
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

Before commit f76cee647c ("target/arm: Introduce mmu indexes for
GCS") it was impossible for arm_to_core_mmu_idx() to return an
invalid core MMU index, because NB_MMU_MODES was 16 and
ARM_MMU_IDX_COREIDX_MASK was 0xf.

That commit raises ARM_MMU_IDX_COREIDX_MASK to 0x1f and NB_MMU_MODES
to 22, so it's now possible for a bogus Arm mmu index to result in an
out of range core mmu index (which can then get used as an array
index in the CPUTLB struct arrays). Coverity complains that this
might result in an out-of-bounds access.

The out-of-bounds access can't happen because we construct all the
ARMMMUIdx values we will use for TLBs to have valid core MMU indexes
in the COREIDX field.  But we can add an assert() so that if we ever
do end up operating on a corrupted or wrong ARMMMUIdx value we get an
assert rather than silently indexing off the end of an array. This
should also make Coverity happier.

Coverity: CID 1641404
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20251023101339.1983809-1-peter.maydell@linaro.org
---
 target/arm/internals.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 6fbf7e1ca49..4c0fa28ef84 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -969,7 +969,9 @@ bool arm_cpu_tlb_fill_align(CPUState *cs, CPUTLBEntryFull *out, vaddr addr,
 
 static inline int arm_to_core_mmu_idx(ARMMMUIdx mmu_idx)
 {
-    return mmu_idx & ARM_MMU_IDX_COREIDX_MASK;
+    int coreidx = mmu_idx & ARM_MMU_IDX_COREIDX_MASK;
+    assert(coreidx < NB_MMU_MODES);
+    return coreidx;
 }
 
 static inline ARMMMUIdx core_to_arm_mmu_idx(CPUARMState *env, int mmu_idx)
-- 
2.43.0


