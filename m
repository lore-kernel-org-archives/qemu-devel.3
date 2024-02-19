Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD42AC48BC3
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Feb 2024 06:18:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rbwyK-0005Zy-LV; Mon, 19 Feb 2024 01:17:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1rbwyH-0005Zj-La
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 01:17:45 -0500
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1rbwyF-0004qo-At
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 01:17:45 -0500
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-2909978624eso2342852a91.1
 for <qemu-devel@nongnu.org>; Sun, 18 Feb 2024 22:17:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708323461; x=1708928261; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=M2JiKOhT0ZnMl4rfxWGDnpy/QAgVh65hoBrA7WMYiWI=;
 b=EiNY3zEryQVjgmkR+Wt8YlzoYEPm/EOyOYEeF3agEx/pJdnlyWUeq0hppcmFj8jq2W
 6VQA5S6sdwzGpuRhCnIrt85AKORgpNK8LwAhZFcvtsyNx6DQ5qo82vH8NL3wrg9PF3VL
 KiwvGZV+Hfs/Pdr5MICap2s2vguwlFXrspoVP7SVn13DOXeaEHH2oXb3/dw1kk7skzvI
 VjERMXYZ4JyoBoc3C4P8lso/FjEREiNlgd+Mv95cCi3vh6oP5Nvq1s2ENoIaORv2hFED
 QCbEB4Wwwu1mmWFCJa3+FR4tPL/JBjhqq/R1Rzj0vQcU6qEHQHtY1YYkNHU2UPRG0upe
 5/1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708323461; x=1708928261;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=M2JiKOhT0ZnMl4rfxWGDnpy/QAgVh65hoBrA7WMYiWI=;
 b=NXUGyvnJY2r87Ye82bwEw9Q9oUp8jDzFJ4iR/GmjGUUScu5CoEPkzEvkdkYXcYLzFO
 Wvb6H0qyf2AFNUTiF88/Gq73R00FVb5Et0c5GEXKnkA9yYQiTWjgLbDUrw11kjIhw+UP
 pQVz9/hrA40CvvU1FL9f5+sWPcRG7AkuagO6puPz8C3AVSQZRn8awm9pAeOjWlVXVsgF
 og/F/eRS7/m80bYvWiWjDVq3117JSuYbudAJ5fwFRDG1f27AQdnthQ5GsJCqPWPDj9bn
 mPUY5uOSCVq+aAMSTm9vpXjE4SBl2gtTsFH2v4V7cOy0kOwM5uvGOJ799iisgCtvYiRu
 XdbQ==
X-Gm-Message-State: AOJu0Yw95wMN0uD/r01mxUKV+GDHPe9vOkLMTh184kEPdtAcjUVEWHbn
 CGrs8W0d6l6qDBir0fm3JTGrJy20+5nHk+YM7vauemdVAlhkCJNCWjxJL3uV
X-Google-Smtp-Source: AGHT+IEIwQ+UztfULyw1YWTqIWOGPjN5aY6JItW9mavsFhsY9xDn6pflYG/QerKAyQLl3sxSU+xyzw==
X-Received: by 2002:a17:90b:4016:b0:299:6717:e1d6 with SMTP id
 ie22-20020a17090b401600b002996717e1d6mr2114232pjb.15.1708323461013; 
 Sun, 18 Feb 2024 22:17:41 -0800 (PST)
Received: from wheely.local0.net ([1.146.10.36])
 by smtp.gmail.com with ESMTPSA id
 sb5-20020a17090b50c500b0029724370ea9sm4316595pjb.47.2024.02.18.22.17.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Feb 2024 22:17:40 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Juan Quintela <quintela@redhat.com>
Subject: [PATCH] system/physmem: Fix migration dirty bitmap coherency with TCG
 memory access
Date: Mon, 19 Feb 2024 16:17:31 +1000
Message-ID: <20240219061731.232570-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x102a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The fastpath in cpu_physical_memory_sync_dirty_bitmap() to test large
aligned ranges forgot to bring the TCG TLB up to date after clearing
some of the dirty memory bitmap bits. This can result in stores though
the TCG TLB not setting the dirty memory bitmap and ultimately causes
memory corruption / lost updates during migration from a TCG host.

Fix this by exporting an abstracted function to call when dirty bits
have been cleared.

Fixes: aa8dc044772 ("migration: synchronize memory bitmap 64bits at a time")
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---

I reproduced this with a kvm-unit-tests migration stress tester I'm
working on. Tree here with reproduce instructions in latest commit.

https://github.com/npiggin/kvm-unit-tests/tree/qemu-tcg-migration-bug

Thanks,
Nick

 include/exec/ram_addr.h | 13 +++++++++++++
 system/physmem.c        | 14 +++++++++-----
 2 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
index 90676093f5..dadb2deb11 100644
--- a/include/exec/ram_addr.h
+++ b/include/exec/ram_addr.h
@@ -443,6 +443,16 @@ uint64_t cpu_physical_memory_set_dirty_lebitmap(unsigned long *bitmap,
 }
 #endif /* not _WIN32 */
 
+void tcg_cpu_physical_memory_dirty_bits_cleared(ram_addr_t start,
+                                                ram_addr_t length);
+static inline void cpu_physical_memory_dirty_bits_cleared(ram_addr_t start,
+                                                          ram_addr_t length)
+{
+    if (tcg_enabled()) {
+        tcg_cpu_physical_memory_dirty_bits_cleared(start, length);
+    }
+
+}
 bool cpu_physical_memory_test_and_clear_dirty(ram_addr_t start,
                                               ram_addr_t length,
                                               unsigned client);
@@ -504,6 +514,9 @@ uint64_t cpu_physical_memory_sync_dirty_bitmap(RAMBlock *rb,
                 idx++;
             }
         }
+        if (num_dirty) {
+            cpu_physical_memory_dirty_bits_cleared(start, length);
+        }
 
         if (rb->clear_bmap) {
             /*
diff --git a/system/physmem.c b/system/physmem.c
index 5e66d9ae36..dc0d8b16aa 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -839,6 +839,12 @@ static void tlb_reset_dirty_range_all(ram_addr_t start, ram_addr_t length)
     }
 }
 
+void tcg_cpu_physical_memory_dirty_bits_cleared(ram_addr_t start,
+                                                ram_addr_t length)
+{
+    tlb_reset_dirty_range_all(start, length);
+}
+
 /* Note: start and end must be within the same ram block.  */
 bool cpu_physical_memory_test_and_clear_dirty(ram_addr_t start,
                                               ram_addr_t length,
@@ -881,8 +887,8 @@ bool cpu_physical_memory_test_and_clear_dirty(ram_addr_t start,
         memory_region_clear_dirty_bitmap(ramblock->mr, mr_offset, mr_size);
     }
 
-    if (dirty && tcg_enabled()) {
-        tlb_reset_dirty_range_all(start, length);
+    if (dirty) {
+        cpu_physical_memory_dirty_bits_cleared(start, length);
     }
 
     return dirty;
@@ -929,9 +935,7 @@ DirtyBitmapSnapshot *cpu_physical_memory_snapshot_and_clear_dirty
         }
     }
 
-    if (tcg_enabled()) {
-        tlb_reset_dirty_range_all(start, length);
-    }
+    cpu_physical_memory_dirty_bits_cleared(start, length);
 
     memory_region_clear_dirty_bitmap(mr, offset, length);
 
-- 
2.42.0


