Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E14DE87834
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 14:28:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnHNl-00024y-Bc; Tue, 03 Feb 2026 09:27:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1vnHNb-00022w-9M
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 09:27:49 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1vnHNZ-0004TJ-BY
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 09:27:46 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2a7b47a5460so4918455ad.1
 for <qemu-devel@nongnu.org>; Tue, 03 Feb 2026 06:27:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1770128863; x=1770733663; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=EY5/KuiOfvcMKeQZ+xWmMS6eu1tk3Y1JEDJHIS04iLs=;
 b=iS4rlL8g2NqUe9XBmAHelldxEpL7zPcMgxruLgy/yb32i/yCNaNxkLMIh7W2IJ5yZl
 qmkALNJqXR1qhLIaC0ELs6Pql6ZhF+EgLveaJ8t+FHxKbJE6NvySCd7hlRu3gbR7l0gR
 gtxJHbi01ptkNAmcyt/nkGot7OmW6BFtT5ovLVmbfELishAQjdYU5QZ0ujE1C13KGznf
 FPoAFZYc9PQMDYDf207avxoUApVP3OrHcB7V2xvP37LKZuXNnX7XCw05/r3iZ7yEzI7h
 0uSt3xN9qvn0jWJPUFAj5RLgemoR5dCesiOtHN2mIK+wjk67dkFgxtCYQdpKe3Pw1WTf
 rn8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770128863; x=1770733663;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EY5/KuiOfvcMKeQZ+xWmMS6eu1tk3Y1JEDJHIS04iLs=;
 b=F5ZwMBg3fDDHauKt/nI1Ri6AVHLeSfRrE6LC5SzpeitGZOCG0k4JWzSWaoZAYTAq3F
 5+G5KkfdhnaQXupGA/F666HM9xmAVLyGQfdw2Q3dxXBIX1K49ZRSFRd/mVrXtvMmhQXw
 fVs7QU+4tpch8Od4z6eb0mClNhfBUplS2AfIrhnatbtVm+3g8FRFR4xoovVFFKiH+QGv
 znSBqCk7rBauAPUclZi8caivI9mrQ04btn1v3KvQQBmG/HZw3enTFeMrmPfsUHZHdAxU
 pES00VbnFcpH0WsismjNjNFfSMvNjTHLxShbQKSTOdit/Oup5UjQwQltJKolHmV+/l8m
 yLWw==
X-Gm-Message-State: AOJu0YwC0pnDAYkk1fD7ljatC1qFbZMR4HRKYUOTWlX2RlprBxzqraF6
 ClCnB0Qb+i3FsvN3zZoZMeQuoCaJxNXwucrzXWN1JZp6YVZbTpJzd5ppbj987SKe21AOZn2LViH
 6reyGqErZFmEGZZZrnKlf8DEnIHnkjUDC5j+uU8yOeXi3my3bfRo52PMr25cNK/ujYHXqBhs/Ow
 ardw7vMgXIqAT25R+6ng7S9h0fWWGaAaUMwtmxa9PK
X-Gm-Gg: AZuq6aIH+/IGp/3o6g7s5z5O5BDZP/y4TEw3RFzW7LCniCVDqMh9+drYVKvNwCLcCo/
 +7tWZGqgfAr9mFSNgoZszHBDX8TSQkH6VILWYWqUOQj4C7M9XtKceAEnA9S83q+QC+MfiDCYVIP
 oF9UGWkg62oiHC77i/OKk+PuJ7+VzxLr85oC7qSz5lT8iGszg8uYYXXS5D2eRX3jUVIOOCkkQYO
 v/Ff6uzz1UGenIqZjdVSWnkoN6jrZyzS91SHXOPMecZdN79dL470uPshOifo91wci/Zpc/WMHmd
 uykoUtJ+VpQLUstF70KsmDUnVuu238XXQFVqHwbfSZOPP/YlO69TtKJFPWjtvsh+rGDYXhIxzMM
 8KUziYwD5MBMk7J0Pd1bIuhCj3NBfdApLgH0OqNeKQOMnNNuoQO7mNAuAJywmszQEkgzsswFvGv
 4QxSid5gf1JLIemdv1U9BCv1MVWS5ldZQE
X-Received: by 2002:a17:903:1103:b0:294:f6e5:b91a with SMTP id
 d9443c01a7336-2a9245fc03emr29263705ad.13.1770128862726; 
 Tue, 03 Feb 2026 06:27:42 -0800 (PST)
Received: from hsinchu26.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a88b413c1asm160515685ad.28.2026.02.03.06.27.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Feb 2026 06:27:42 -0800 (PST)
From: Jim Shu <jim.shu@sifive.com>
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Jim Shu <jim.shu@sifive.com>
Subject: [PATCH] accel/tcg: Remove a redundant argument attrs in io_prepare()
Date: Tue,  3 Feb 2026 22:27:37 +0800
Message-ID: <20260203142737.2164763-1-jim.shu@sifive.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=jim.shu@sifive.com; helo=mail-pl1-x62f.google.com
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

attrs is already in CPUTLBEntryFull, so this argument is redundant.
Just remove it.

Clean up commit 94c6e9cf04409e38563080348d6136879f91ffee

Signed-off-by: Jim Shu <jim.shu@sifive.com>
---
 accel/tcg/cputlb.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 76546c66515..15ee29e7524 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1271,7 +1271,7 @@ static inline void cpu_unaligned_access(CPUState *cpu, vaddr addr,
 
 static MemoryRegionSection *
 io_prepare(hwaddr *out_offset, CPUState *cpu, CPUTLBEntryFull *full,
-           MemTxAttrs attrs, vaddr addr, uintptr_t retaddr)
+           vaddr addr, uintptr_t retaddr)
 {
     MemoryRegionSection *section;
     hwaddr mr_offset;
@@ -1974,12 +1974,10 @@ static uint64_t do_ld_mmio_beN(CPUState *cpu, CPUTLBEntryFull *full,
     MemoryRegionSection *section;
     MemoryRegion *mr;
     hwaddr mr_offset;
-    MemTxAttrs attrs;
 
     tcg_debug_assert(size > 0 && size <= 8);
 
-    attrs = full->attrs;
-    section = io_prepare(&mr_offset, cpu, full, attrs, addr, ra);
+    section = io_prepare(&mr_offset, cpu, full, addr, ra);
     mr = section->mr;
 
     BQL_LOCK_GUARD();
@@ -1994,13 +1992,11 @@ static Int128 do_ld16_mmio_beN(CPUState *cpu, CPUTLBEntryFull *full,
     MemoryRegionSection *section;
     MemoryRegion *mr;
     hwaddr mr_offset;
-    MemTxAttrs attrs;
     uint64_t a, b;
 
     tcg_debug_assert(size > 8 && size <= 16);
 
-    attrs = full->attrs;
-    section = io_prepare(&mr_offset, cpu, full, attrs, addr, ra);
+    section = io_prepare(&mr_offset, cpu, full, addr, ra);
     mr = section->mr;
 
     BQL_LOCK_GUARD();
@@ -2492,12 +2488,10 @@ static uint64_t do_st_mmio_leN(CPUState *cpu, CPUTLBEntryFull *full,
     MemoryRegionSection *section;
     hwaddr mr_offset;
     MemoryRegion *mr;
-    MemTxAttrs attrs;
 
     tcg_debug_assert(size > 0 && size <= 8);
 
-    attrs = full->attrs;
-    section = io_prepare(&mr_offset, cpu, full, attrs, addr, ra);
+    section = io_prepare(&mr_offset, cpu, full, addr, ra);
     mr = section->mr;
 
     BQL_LOCK_GUARD();
@@ -2512,12 +2506,10 @@ static uint64_t do_st16_mmio_leN(CPUState *cpu, CPUTLBEntryFull *full,
     MemoryRegionSection *section;
     MemoryRegion *mr;
     hwaddr mr_offset;
-    MemTxAttrs attrs;
 
     tcg_debug_assert(size > 8 && size <= 16);
 
-    attrs = full->attrs;
-    section = io_prepare(&mr_offset, cpu, full, attrs, addr, ra);
+    section = io_prepare(&mr_offset, cpu, full, addr, ra);
     mr = section->mr;
 
     BQL_LOCK_GUARD();
-- 
2.43.0


