Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9418C54798
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 18:12:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riID5-0002T0-F0; Thu, 07 Mar 2024 13:11:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1riID3-0002SG-Dl
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 13:11:13 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1riID0-0004SH-NQ
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 13:11:13 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-413131d40f4so161265e9.3
 for <qemu-devel@nongnu.org>; Thu, 07 Mar 2024 10:11:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709835069; x=1710439869; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3M3p0P+gb/3iG0ankC+FJRfdeFsceOte83WPS3Mcews=;
 b=iDLU831J3qFB5O41/mAa+XHq51RT6BCHv+AgumlH3F4bWe17aR5icyTSip0aZ+AE/r
 6VwGdXwOBRoScBgPzJ4t6LsVC49tg1vTteILEtVFRUcgMr0cY3p3z+2Iit78O2MYLGnA
 a0qrO96nEQFK1ShJWOLgYUFSnC2lYU0ZBZHDjA1eWPf+CVDA8Hf7OveN75l8K4QGchT7
 l4/Igkzih/B64l85uuqIMMI2GlUlpED7e4NucRcEdgVMbGDjNJrZXDv5QmQzfvK0WE87
 PsJs+TZ2sz1lwNKJgKXra9590Yd9Trw9sqxkbZDnN/YD2Wv5jvy3vNkWD6sY/HLuF8/Z
 v6ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709835069; x=1710439869;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3M3p0P+gb/3iG0ankC+FJRfdeFsceOte83WPS3Mcews=;
 b=Dxqp5l/GZ7S7gLrakra3DdJfERgghB2Y4TX0YRei3CzwbXTryHwBr/S5d+2AHUKJzk
 AlG/g7A1GT5vhxmZWIMPUNqtKomoF1bHR/A41qmEZOzF7rOxibO+uHdry41NpFIwMFz4
 y6rM6Z9QO+IRuYsFIy3iy+ZTAo9yMblEtXiszsbVUkJoqkhMJJJgiV2fLtN5x5VACya3
 OnZ840TypGqcuk39XNufK/cC5R8tW2rTAVY5huea0GY2Y0kB86/hfMfvZwqUKWFugZCz
 vygBKeJW4XEZtJ4/Eh7APhHfX3JZhadCVl5s8SxraHweRMIHBM2kJK22XQassT7DgCg4
 BWYA==
X-Gm-Message-State: AOJu0YyDFM5RwdsKFiYaW/59f1jG4GG2gvQgiaKgLpaSF6Lh461A6e2n
 5QiUuwzdV/i9W6S2wgvon+WWKHxY7D1npFoZmTIuPyAniMCFgALsis3imYWf3L0=
X-Google-Smtp-Source: AGHT+IGqP5PXg3pKTXPOZsTVCQ3j6vGx8hSawJOqsdzMIqK8m4AscsclnKTWVbesTaQ+qAPtdRhUcQ==
X-Received: by 2002:a05:600c:4e8e:b0:412:e70a:ab8a with SMTP id
 f14-20020a05600c4e8e00b00412e70aab8amr8121212wmq.25.1709835069247; 
 Thu, 07 Mar 2024 10:11:09 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 je13-20020a05600c1f8d00b00412fb4f5756sm3503948wmb.27.2024.03.07.10.11.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Mar 2024 10:11:06 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id A13075F94F;
 Thu,  7 Mar 2024 18:11:05 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 John G Johnson <john.g.johnson@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Peter Xu <peterx@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Juan Quintela <quintela@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, peter.maydell@linaro.org,
 David Hildenbrand <david@redhat.com>
Subject: [PATCH 2/5] docs: include ramblock.h in the memory API docs
Date: Thu,  7 Mar 2024 18:11:02 +0000
Message-Id: <20240307181105.4081793-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240307181105.4081793-1-alex.bennee@linaro.org>
References: <20240307181105.4081793-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

The RAMBlock concept is fairly central to RAM-like MemoryRegions so
lets update the structure documentation and include in the docs.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 docs/devel/memory.rst   |  1 +
 include/exec/ramblock.h | 76 +++++++++++++++++++++++++++--------------
 2 files changed, 52 insertions(+), 25 deletions(-)

diff --git a/docs/devel/memory.rst b/docs/devel/memory.rst
index 69c5e3f914a..ed24708fce3 100644
--- a/docs/devel/memory.rst
+++ b/docs/devel/memory.rst
@@ -369,4 +369,5 @@ callbacks are called:
 API Reference
 -------------
 
+.. kernel-doc:: include/exec/ramblock.h
 .. kernel-doc:: include/exec/memory.h
diff --git a/include/exec/ramblock.h b/include/exec/ramblock.h
index 848915ea5bf..eb2416b6f66 100644
--- a/include/exec/ramblock.h
+++ b/include/exec/ramblock.h
@@ -24,68 +24,94 @@
 #include "qemu/rcu.h"
 #include "exec/ramlist.h"
 
+/**
+ * struct RAMBlock - represents a chunk of RAM
+ *
+ * RAMBlocks can be backed by allocated RAM or a file-descriptor. See
+ * @flags for the details. For the purposes of migration various book
+ * keeping and dirty state tracking elements are also tracked in this
+ * structure.
+ */
 struct RAMBlock {
+    /** @rcu: used for lazy free under RCU */
     struct rcu_head rcu;
+    /** @mr: parent MemoryRegion the block belongs to */
     struct MemoryRegion *mr;
+    /** @host: pointer to host address of RAM */
     uint8_t *host;
-    uint8_t *colo_cache; /* For colo, VM's ram cache */
+    /** @colo_cache: For colo, VM's ram cache */
+    uint8_t *colo_cache;
+    /** @offset: offset into host backing store??? or guest address space? */
     ram_addr_t offset;
+    /** @used_length: amount of store used */
     ram_addr_t used_length;
+    /** @max_length: for blocks that can be resized the max possible */
     ram_addr_t max_length;
+    /** @resized: callback notifier when block resized  */
     void (*resized)(const char*, uint64_t length, void *host);
+    /** @flags: see RAM_* flags in memory.h  */
     uint32_t flags;
-    /* Protected by the BQL.  */
+    /** @idstr: Protected by the BQL.  */
     char idstr[256];
-    /* RCU-enabled, writes protected by the ramlist lock */
+    /**
+     * @next: next RAMBlock, RCU-enabled, writes protected by the
+     * ramlist lock
+     */
     QLIST_ENTRY(RAMBlock) next;
+    /** @ramblock_notifiers: list of RAMBlockNotifier notifiers */
     QLIST_HEAD(, RAMBlockNotifier) ramblock_notifiers;
+    /** @fd: fd of backing store if used */
     int fd;
+    /** @fd_offset: offset into the fd based backing store */
     uint64_t fd_offset;
+    /** @page_size: ideal page size of backing store*/
     size_t page_size;
-    /* dirty bitmap used during migration */
+    /** @bmap:  dirty bitmap used during migration */
     unsigned long *bmap;
 
     /*
      * Below fields are only used by mapped-ram migration
      */
-    /* bitmap of pages present in the migration file */
+
+    /** @file_bmap: bitmap of pages present in the migration file  */
     unsigned long *file_bmap;
-    /*
-     * offset in the file pages belonging to this ramblock are saved,
-     * used only during migration to a file.
-     */
+    /** @bitmap_offset: offset in the migration file of the bitmaps */
     off_t bitmap_offset;
+    /** @pages_offset: offset in the migration file of the pages */
     uint64_t pages_offset;
 
-    /* bitmap of already received pages in postcopy */
+    /** @receivedmap: bitmap of already received pages in postcopy */
     unsigned long *receivedmap;
 
-    /*
-     * bitmap to track already cleared dirty bitmap.  When the bit is
-     * set, it means the corresponding memory chunk needs a log-clear.
-     * Set this up to non-NULL to enable the capability to postpone
-     * and split clearing of dirty bitmap on the remote node (e.g.,
-     * KVM).  The bitmap will be set only when doing global sync.
+    /**
+     * @clear_bmap: bitmap to track already cleared dirty bitmap. When
+     * the bit is set, it means the corresponding memory chunk needs a
+     * log-clear. Set this up to non-NULL to enable the capability to
+     * postpone and split clearing of dirty bitmap on the remote node
+     * (e.g., KVM). The bitmap will be set only when doing global
+     * sync.
      *
      * It is only used during src side of ram migration, and it is
      * protected by the global ram_state.bitmap_mutex.
      *
      * NOTE: this bitmap is different comparing to the other bitmaps
      * in that one bit can represent multiple guest pages (which is
-     * decided by the `clear_bmap_shift' variable below).  On
+     * decided by the @clear_bmap_shift variable below).  On
      * destination side, this should always be NULL, and the variable
-     * `clear_bmap_shift' is meaningless.
+     * @clear_bmap_shift is meaningless.
      */
     unsigned long *clear_bmap;
+    /** @clear_bmap_shift: number pages each @clear_bmap bit represents */
     uint8_t clear_bmap_shift;
 
-    /*
-     * RAM block length that corresponds to the used_length on the migration
-     * source (after RAM block sizes were synchronized). Especially, after
-     * starting to run the guest, used_length and postcopy_length can differ.
-     * Used to register/unregister uffd handlers and as the size of the received
-     * bitmap. Receiving any page beyond this length will bail out, as it
-     * could not have been valid on the source.
+    /**
+     * @postcopy_length: RAM block length that corresponds to the
+     * @used_length on the migration source (after RAM block sizes
+     * were synchronized). Especially, after starting to run the
+     * guest, @used_length and @postcopy_length can differ. Used to
+     * register/unregister uffd handlers and as the size of the
+     * received bitmap. Receiving any page beyond this length will
+     * bail out, as it could not have been valid on the source.
      */
     ram_addr_t postcopy_length;
 };
-- 
2.39.2


