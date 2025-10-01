Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B83FECCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 08:27:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3s7Z-0001I1-80; Wed, 01 Oct 2025 04:23:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3s6y-0000uL-7b
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 04:22:57 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3s6R-0005iR-IF
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 04:22:55 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-46e34bd8eb2so24754005e9.3
 for <qemu-devel@nongnu.org>; Wed, 01 Oct 2025 01:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759306933; x=1759911733; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TyFBjzM/ZIChvPqFREhzkAXzAXG+v6/MNIDOu8ypqSQ=;
 b=AIzCNjo89gkmL0U0LwmN2e5qOVYoqYo+RhntUgS9mpDWJRdV6Cax504bfvAxuG2Pr5
 4js/0vf9QOxZJuGHoSsKd2Ft/6KNBZcNB4KqDx83iWiZn9kyUGoKa/qktfJrikPXbhqR
 6eAEtuXhuRhkS5FwAHD1x7hq1l9Hhc+cM257xQ6b9QfokttxqMZ3/3Xa0zXCA4Pymxul
 O5bXvKhl5/wUVPqmIfwToK6TM8jbabmtLE8rSBhIb8MDItlT4wDrKr+NPNZs6OTOwFyf
 QeuNyTus7OkQZ3YCl7/AEgzZ1+RiMCCfHfjZe7Qi0UIw0zS9SvRvnwLQ8BPe79MfeLtW
 2ouA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759306933; x=1759911733;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TyFBjzM/ZIChvPqFREhzkAXzAXG+v6/MNIDOu8ypqSQ=;
 b=dYVksU9+kJVazkztnqL8QRgAgk7t6uGFQTP7vBmIsS1ESd1a0iMCK+R9XuqpxNS60n
 0T9conqRREMTqp8Htm+St0qfDEH0yuUAYl/0DR6wh+VQ7XQNlsnOqIjfsxO0xq3yEkA2
 ZBoDdsxKI2CLZ3yyjmkwUEaiokyPNwMJAyvBkZa/x3GU5N21+UiQqh6OZYkHCA2f0TA0
 zBmdtgdD+gEuWpCYO+EQokVuWtMBoFWLEP1i9jGm5GlZkiFZ2mJs0W/h7LQdcvw4omJA
 y8xn+cMoLyVFmsMGd0ikAcaoYj4bPuEXcghOfinOFlQnwPMUtVh4fnsA7EhGCfIDxzZE
 lzgQ==
X-Gm-Message-State: AOJu0YyhisZQgVT1nJ3fCjL6qLNBV6Cx52qqADIqLT5RgeFO3am14g/t
 BoRevv1vxv/3ItZUcDRf0KKDRtav29taIoA3wOd0uAggPWZjIrwW6S3aGDwmaCSZ5EQ540jjTjZ
 8ddpNOoL4vA==
X-Gm-Gg: ASbGnct1cUrUd2mJW5PbhsOoB38rUEDzVKtMkX9LI9dAwkSXorTqT1YCk9qyD/61iJl
 7fAsuvrQ7sdMjev3Rt49x/t8EJ9FveJ8QSCMDHY3rP1gdTQtY8svM6e3jy6hsFie0IjyUTeB/Py
 SwHLr1mBqje6PiXSW3WKnChjP7uDcaQesJRL5NY5cAnRvzD4T2H4Hlde2IbtJrQb3P+RrXZmhqS
 qmWqG0FfNUzG5zcV3VvW5pvNC6Yb+jH8NHTBNj2ucAl7QLY/eCCk5khwmEnpJPWOsPfnur8501d
 Ba22QskVRkzxAv712Ubr+LdQePTWryFyKwJf920pllXtpDRaleFoAsh5kP7YxR7YMmdTfzEdqcc
 DrYvMxpvwP7UvDKxe/G0NUNmMVpkZofKnTyR2bgoMHGDwtT3mtVI7bCfKhRkmIadk1KYdyhpCTn
 GumOdAQjzmr+ozb6ERAgeV
X-Google-Smtp-Source: AGHT+IE/PTpfa6W1FpPoDRcE8hMigdDVrnIWWOSLLneA/kKTQFtjZB0qqjhW1MeuCmZZ2K1WESJ2+Q==
X-Received: by 2002:a05:600d:41eb:b0:46e:45d3:82fa with SMTP id
 5b1f17b1804b1-46e6127a2c9mr22144885e9.10.1759306932959; 
 Wed, 01 Oct 2025 01:22:12 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e6199f186sm27339275e9.7.2025.10.01.01.22.11
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 01 Oct 2025 01:22:12 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>, qemu-arm@nongnu.org,
 Jagannathan Raman <jag.raman@oracle.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Jason Herne <jjherne@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 kvm@vger.kernel.org, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-ppc@nongnu.org,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Fabiano Rosas <farosas@suse.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-s390x@nongnu.org,
 Peter Xu <peterx@redhat.com>
Subject: [PATCH 08/25] accel/tcg: Rename @start argument of tlb_reset_dirty*()
Date: Wed,  1 Oct 2025 10:21:08 +0200
Message-ID: <20251001082127.65741-9-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251001082127.65741-1-philmd@linaro.org>
References: <20251001082127.65741-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

Generally we want to clarify terminology and avoid confusions,
prefering @start with (exclusive) @end, and base @addr with
@length (for inclusive range).

Here as tlb_reset_dirty() and tlb_reset_dirty_range_all()
operate on a range, rename @start as @addr.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/exec/cputlb.h | 4 ++--
 accel/tcg/cputlb.c    | 6 +++---
 system/physmem.c      | 8 ++++----
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/include/exec/cputlb.h b/include/exec/cputlb.h
index db7cbf97826..995fe31ef75 100644
--- a/include/exec/cputlb.h
+++ b/include/exec/cputlb.h
@@ -32,8 +32,8 @@ void tlb_unprotect_code(ram_addr_t ram_addr);
 
 #ifndef CONFIG_USER_ONLY
 /* Called with rcu_read_lock held. */
-void tlb_reset_dirty(CPUState *cpu, uintptr_t start, uintptr_t length);
-void tlb_reset_dirty_range_all(ram_addr_t start, ram_addr_t length);
+void tlb_reset_dirty(CPUState *cpu, uintptr_t addr, uintptr_t length);
+void tlb_reset_dirty_range_all(ram_addr_t addr, ram_addr_t length);
 #endif
 
 /**
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 2a6aa01c57c..6807328df82 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -916,7 +916,7 @@ static inline void copy_tlb_helper_locked(CPUTLBEntry *d, const CPUTLBEntry *s)
  * We must take tlb_c.lock to avoid racing with another vCPU update. The only
  * thing actually updated is the target TLB entry ->addr_write flags.
  */
-void tlb_reset_dirty(CPUState *cpu, uintptr_t start, uintptr_t length)
+void tlb_reset_dirty(CPUState *cpu, uintptr_t addr, uintptr_t length)
 {
     int mmu_idx;
 
@@ -929,12 +929,12 @@ void tlb_reset_dirty(CPUState *cpu, uintptr_t start, uintptr_t length)
 
         for (i = 0; i < n; i++) {
             tlb_reset_dirty_range_locked(&desc->fulltlb[i], &fast->table[i],
-                                         start, length);
+                                         addr, length);
         }
 
         for (i = 0; i < CPU_VTLB_SIZE; i++) {
             tlb_reset_dirty_range_locked(&desc->vfulltlb[i], &desc->vtable[i],
-                                         start, length);
+                                         addr, length);
         }
     }
     qemu_spin_unlock(&cpu->neg.tlb.c.lock);
diff --git a/system/physmem.c b/system/physmem.c
index 000bde90c2e..098824ad1d2 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -882,16 +882,16 @@ found:
     return block;
 }
 
-void tlb_reset_dirty_range_all(ram_addr_t start, ram_addr_t length)
+void tlb_reset_dirty_range_all(ram_addr_t addr, ram_addr_t length)
 {
     CPUState *cpu;
-    ram_addr_t start1;
+    ram_addr_t start, start1;
     RAMBlock *block;
     ram_addr_t end;
 
     assert(tcg_enabled());
-    end = TARGET_PAGE_ALIGN(start + length);
-    start &= TARGET_PAGE_MASK;
+    end = TARGET_PAGE_ALIGN(addr + length);
+    start = addr & TARGET_PAGE_MASK;
 
     RCU_READ_LOCK_GUARD();
     block = qemu_get_ram_block(start);
-- 
2.51.0


