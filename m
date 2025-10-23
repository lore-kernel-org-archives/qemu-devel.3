Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 976A7CCD1BC
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 10:14:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBsKM-0002Jm-8f; Thu, 23 Oct 2025 06:13:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vBsKJ-0002Is-Hf
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 06:13:47 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vBsKF-0004TR-JZ
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 06:13:47 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3f0ae439b56so312997f8f.3
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 03:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761214421; x=1761819221; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=TJIxDlMye1hJhg/nMi1UknWnM2H2w8fSrILkmnP7nFA=;
 b=TZKn6Rmp66N7Je4OmKQKpXaps0j2VaKgAAcbq2FtGNXJYgcxLHRB5QxbMW8aN579TC
 8BaJM3KDSoNV4QMrj92aCRRtlcKE2sLTw4PVSNdIoBDQmlDS873Lh4OwNn7ydzBXutZy
 qaFg3+Pt8K+XlE+oYORAICaYHko//DJVuhbc3Pkk1Q7zXv2PIuDUWWorxfBb8AS8QjLF
 4SKyewdsCwNRRLpC51CXSCwD06R2vySbN3z28kflxF/74dxacbktgE8n7eHtdj8yvvOd
 CWk8E3ebfJzM3yQu6wbNDSKw70Xofd5IMUM6U3sUfVAH7LFeI0YxAok/ylAYL0mel7Hg
 n6wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761214421; x=1761819221;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TJIxDlMye1hJhg/nMi1UknWnM2H2w8fSrILkmnP7nFA=;
 b=YqnnDOe/a3g81LoB9O5AYqKRMmrcDmWCbrI8oziYoeNvL9ktf5HA1XVBzAkoe8BH9x
 aJwO14O1iFqte+FMvG5tn4GPiZNqkRa+ECIFOdBV5hWqbS0BY3kNSQ3y/tcpcyPOLRyV
 tFtLcj1IHFHPVVFyUOWoI5XTMDwyczx8iUHdvrw9okbtWqMkJtsmOboCSulQpSibfOop
 sAxdLgjnVHMMdZAMxaWMFzu/MoYvRP6oKgTr2AZ5cT0eZBlQIzbTulae+42YfLIxwY28
 JoGXfTkzU7HkvPLGbFKU+rXHXkjQN9T9C12w2JbGw27HmlQ7wt1idWb1fdi4GQ61fyc9
 BZbA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWQJuGCo8r8iGGMRcXxW2zz8uYrqt23xMhyP5BwrQ1Q+EUPGrWAr4avnYqz4lpNJ/RK0FVcG4b53Pbm@nongnu.org
X-Gm-Message-State: AOJu0YztXp8SRjcIeKk8SK8vAFrVoIMcWBLrDu7DaUBQ6UY0KGPz+AYL
 aM5huIr5DJ6G+xyEOHdzG6eFV3f+k/5x7KDg4n+9CGd0BF48eJhv5Ii6+EI+fBiC1fo=
X-Gm-Gg: ASbGncsPa3W4BPtC7LU9D8oOfuQSfdHBRDG0oetNVJjHjxYhbCX5DB/IxZefQZ/63fb
 JaHXcFRMKTNOKTlkpdGWSrVIlrLfs1IxW3j8ZiX0z49Fm5nVZXAiZJyIpHgzrNDSEDXpFRG/Wzd
 nrl1iPNAQRVfkbsd9QIZtBVcwBSXRwStgcXiy0KGGeW6h/YkuzxAcQ2vv/bxZXyzQpdV7zFF4mw
 VNtTIPJ39OE5irxeJI9/3FJkN4g1NXck1a4A1PW7+PjgQnlh+ezpjXESMUlm/VzaaFYajJY1EWC
 akHwfh0GNAkHoijWpctJMbQ+4Gg16huFhHAHObBrEEQ7tLgCp8DbFiXhdmZoJrhtawczfwjDHy5
 I5y7OdXAmylk8t9jj062nhw9AZtje5GeELtP+6noyB/juV+3n+dUQIELvOUnjf6C+rFzvK8ikNm
 Wy4bTaCw==
X-Google-Smtp-Source: AGHT+IHPaTFApidrptjzqYdH4DqNeY7rOv0DcQmfz6Tu8oSU/UhT2EKYKDj4f3BtVKiQnbcT1LuemQ==
X-Received: by 2002:a05:6000:310b:b0:3eb:8395:e2e0 with SMTP id
 ffacd0b85a97d-42704dab124mr15469424f8f.51.1761214421152; 
 Thu, 23 Oct 2025 03:13:41 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429897f57b7sm3126352f8f.16.2025.10.23.03.13.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Oct 2025 03:13:40 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH] target/arm: Add assert to arm_to_core_mmu_idx()
Date: Thu, 23 Oct 2025 11:13:39 +0100
Message-ID: <20251023101339.1983809-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x429.google.com
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
---
 target/arm/internals.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index f539bbe58e1..026548ec34f 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -968,7 +968,9 @@ bool arm_cpu_tlb_fill_align(CPUState *cs, CPUTLBEntryFull *out, vaddr addr,
 
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


