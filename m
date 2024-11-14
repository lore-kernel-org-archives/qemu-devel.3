Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7219AD637D5
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 01:19:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBOTH-0003EK-MD; Wed, 13 Nov 2024 20:16:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tBOSh-00029N-3q
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 20:15:56 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tBOSd-0002tV-Nz
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 20:15:54 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-37d518f9abcso61274f8f.2
 for <qemu-devel@nongnu.org>; Wed, 13 Nov 2024 17:15:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731546948; x=1732151748; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=47l8bIL01QRkGakpDpfE8XrYcUIw9iQZ4Ki9frTlDYk=;
 b=s5/aTpNAmeil+gjc7YoRh7MPXiSUW5WGmY4z8RPHHIuDVNlqd6098snIXdMuBMzumb
 wVpgcUxHU/KeIPP0SOatdQ1Xnb2BfjarYUuaEYF944px6CvGUm+ffS5IDE4cdKYdS7c+
 CUcnRnuqkiGBXvgVjm0ytM3P00JflsJfeBLu0oX+FDBiKEfMAksZYl0lOXcbYnXLnYqh
 Kf1hiSb6Blnd0tYM5mL2to/DFLLP2lhy6Aw/IP/aH3P8IF1N3v4QneYn9YkPuDmT0l3o
 MMHT2zYlS0gN0nz2vGKbq23UsG9h+gXMNceFI8Q3/QRmQSSatUHfpHMU4uFMqedgLGi+
 mK5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731546948; x=1732151748;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=47l8bIL01QRkGakpDpfE8XrYcUIw9iQZ4Ki9frTlDYk=;
 b=NBMFTnqecbOAU5tfP8bWekmHPLh/bC81jlfZJHbtmwFX976X2QZUGkb4f+nKgO2HFu
 /M/DP33131QOsRob5dkuPXNGLZlz5BuW3v7i6gAq4BbWmz+BtdisOwSJzbjR5AqPZ+em
 TdaKRcSr2KTo4AapVNQFPcDdrZKkFXgAu9vY4ftZuGP7LbchaysK236Op+Hf/mJyu+K1
 BVNRGT/BPfesecfdCUjtKjvtmEGdUwCLQG9kIy7Z8+I0X11dtMfMDMIzu9UgoIfeI5/R
 qkAyEf4tX40TdkoyJ29NS4fQ/UBf+f9DZZGlMBsqAmuuRkERlolwrMc+/0R2t9tCyBrr
 Oeyg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWY8FQ6WP9EHMiFijhfo4yk/tIcOFR+LTcL8ILHkoI4ZWgwfv29MbGdT5IkOV53S7CAT/Dk1UqXJ3mm@nongnu.org
X-Gm-Message-State: AOJu0YzaZ8On7vJJmF+51WjYgLAD1kJvHw1tDdVNtQcLyRdPBRDZVAFW
 IHDain8x4RPNGsQSC5ffX1YOpY3k+F6/k/ZLGh3SuIfA7Wuc1tq+5oSdv5ueHBk=
X-Google-Smtp-Source: AGHT+IGm4IkujNwbvXU0PfthP+KilYpmsFGPbZN2Ec16W6AxewEFOjqxxAMvc9mYtsMmC6kajJV0Dg==
X-Received: by 2002:a05:6000:1868:b0:374:c3e4:d6de with SMTP id
 ffacd0b85a97d-381f1885dd9mr19331385f8f.41.1731546947775; 
 Wed, 13 Nov 2024 17:15:47 -0800 (PST)
Received: from localhost.localdomain ([176.187.209.238])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381ed9719easm20201050f8f.9.2024.11.13.17.15.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 13 Nov 2024 17:15:46 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org,
 Peter Xu <peterx@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-riscv@nongnu.org,
 David Hildenbrand <david@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-s390x@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 19/24] exec: Declare tlb_hit*() in 'exec/cputlb.h'
Date: Thu, 14 Nov 2024 02:13:04 +0100
Message-ID: <20241114011310.3615-20-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241114011310.3615-1-philmd@linaro.org>
References: <20241114011310.3615-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

Move CPU TLB related methods to "exec/cputlb.h".

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/exec/cpu-all.h | 23 -----------------------
 accel/tcg/cputlb.c     | 23 +++++++++++++++++++++++
 2 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index 1c8e0446d0..ccaa650b19 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -323,29 +323,6 @@ static inline int cpu_mmu_index(CPUState *cs, bool ifetch)
 /* The two sets of flags must not overlap. */
 QEMU_BUILD_BUG_ON(TLB_FLAGS_MASK & TLB_SLOW_FLAGS_MASK);
 
-/**
- * tlb_hit_page: return true if page aligned @addr is a hit against the
- * TLB entry @tlb_addr
- *
- * @addr: virtual address to test (must be page aligned)
- * @tlb_addr: TLB entry address (a CPUTLBEntry addr_read/write/code value)
- */
-static inline bool tlb_hit_page(uint64_t tlb_addr, vaddr addr)
-{
-    return addr == (tlb_addr & (TARGET_PAGE_MASK | TLB_INVALID_MASK));
-}
-
-/**
- * tlb_hit: return true if @addr is a hit against the TLB entry @tlb_addr
- *
- * @addr: virtual address to test (need not be page aligned)
- * @tlb_addr: TLB entry address (a CPUTLBEntry addr_read/write/code value)
- */
-static inline bool tlb_hit(uint64_t tlb_addr, vaddr addr)
-{
-    return tlb_hit_page(tlb_addr, addr & TARGET_PAGE_MASK);
-}
-
 #endif /* !CONFIG_USER_ONLY */
 
 /* Validate correct placement of CPUArchState. */
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 080cbcb34d..dba4831cd1 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1220,6 +1220,29 @@ void tlb_set_page(CPUState *cpu, vaddr addr,
                             prot, mmu_idx, size);
 }
 
+/**
+ * tlb_hit_page: return true if page aligned @addr is a hit against the
+ * TLB entry @tlb_addr
+ *
+ * @addr: virtual address to test (must be page aligned)
+ * @tlb_addr: TLB entry address (a CPUTLBEntry addr_read/write/code value)
+ */
+static inline bool tlb_hit_page(uint64_t tlb_addr, vaddr addr)
+{
+    return addr == (tlb_addr & (TARGET_PAGE_MASK | TLB_INVALID_MASK));
+}
+
+/**
+ * tlb_hit: return true if @addr is a hit against the TLB entry @tlb_addr
+ *
+ * @addr: virtual address to test (need not be page aligned)
+ * @tlb_addr: TLB entry address (a CPUTLBEntry addr_read/write/code value)
+ */
+static inline bool tlb_hit(uint64_t tlb_addr, vaddr addr)
+{
+    return tlb_hit_page(tlb_addr, addr & TARGET_PAGE_MASK);
+}
+
 /*
  * Note: tlb_fill_align() can trigger a resize of the TLB.
  * This means that all of the caller's prior references to the TLB table
-- 
2.45.2


