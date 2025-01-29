Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C430C0218D
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2025 16:13:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdAWC-00042A-TE; Wed, 29 Jan 2025 11:02:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tdAVK-0003GI-NG
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 11:01:26 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tdAVI-0005EF-6f
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 11:01:25 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1FD5521109;
 Wed, 29 Jan 2025 16:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1738166481; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tyQ8iNi8nTPP5FzNwsYboT5UyLB4GDl+YnTjn8T3EEs=;
 b=h5+NFBYhE7yJDOhCaHmabaBELM4NdNNBfIeEv+25JMGCVLd6su2Q/8wUklq6Nau3O3Q082
 D5XQTqlKS6RrnfCcC6ExdKXSoVlAYakaG6pzir5EZYEoxUapDYLz1TRFNwwj95lFgIrJkg
 FJR7vuAytqCJwaaCesEB+uISFlzH7So=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1738166481;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tyQ8iNi8nTPP5FzNwsYboT5UyLB4GDl+YnTjn8T3EEs=;
 b=nIi07LzbjqE88M6PV/8L+DXQlzDzAFe3XTjUfem7cDc6ZxkMMPD/ctT1Y5ZPOffjm7pVks
 T3eL66Tsh2mj82AQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1738166481; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tyQ8iNi8nTPP5FzNwsYboT5UyLB4GDl+YnTjn8T3EEs=;
 b=h5+NFBYhE7yJDOhCaHmabaBELM4NdNNBfIeEv+25JMGCVLd6su2Q/8wUklq6Nau3O3Q082
 D5XQTqlKS6RrnfCcC6ExdKXSoVlAYakaG6pzir5EZYEoxUapDYLz1TRFNwwj95lFgIrJkg
 FJR7vuAytqCJwaaCesEB+uISFlzH7So=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1738166481;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tyQ8iNi8nTPP5FzNwsYboT5UyLB4GDl+YnTjn8T3EEs=;
 b=nIi07LzbjqE88M6PV/8L+DXQlzDzAFe3XTjUfem7cDc6ZxkMMPD/ctT1Y5ZPOffjm7pVks
 T3eL66Tsh2mj82AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CE13A137DB;
 Wed, 29 Jan 2025 16:01:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id uEwyI89QmmffPAAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 29 Jan 2025 16:01:19 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
	Steve Sistare <steven.sistare@oracle.com>
Subject: [PULL 06/42] memory: add RAM_PRIVATE
Date: Wed, 29 Jan 2025 13:00:23 -0300
Message-Id: <20250129160059.6987-7-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250129160059.6987-1-farosas@suse.de>
References: <20250129160059.6987-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; FUZZY_BLOCKED(0.00)[rspamd.com];
 MIME_TRACE(0.00)[0:+]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,oracle.com:email]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_FILL_THIS_FORM_SHORT=0.01 autolearn=ham autolearn_force=no
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

From: Steve Sistare <steven.sistare@oracle.com>

Define the RAM_PRIVATE flag.

In RAMBlock creation functions, if MAP_SHARED is 0 in the flags parameter,
in a subsequent patch the implementation may still create a shared mapping
if other conditions require it.  Callers who specifically want a private
mapping, eg for objects specified by the user, must pass RAM_PRIVATE.

After RAMBlock creation, MAP_SHARED in the block's flags indicates whether
the block is shared or private, and MAP_PRIVATE is omitted.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Link: https://lore.kernel.org/r/1736967650-129648-6-git-send-email-steven.sistare@oracle.com
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 backends/hostmem-epc.c   |  2 +-
 backends/hostmem-file.c  |  2 +-
 backends/hostmem-memfd.c |  2 +-
 backends/hostmem-ram.c   |  2 +-
 include/exec/memory.h    | 10 ++++++++++
 system/physmem.c         | 15 ++++++++++++---
 6 files changed, 26 insertions(+), 7 deletions(-)

diff --git a/backends/hostmem-epc.c b/backends/hostmem-epc.c
index eb4b95dfd7..1fa2d031e4 100644
--- a/backends/hostmem-epc.c
+++ b/backends/hostmem-epc.c
@@ -36,7 +36,7 @@ sgx_epc_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
 
     backend->aligned = true;
     name = object_get_canonical_path(OBJECT(backend));
-    ram_flags = (backend->share ? RAM_SHARED : 0) | RAM_PROTECTED;
+    ram_flags = (backend->share ? RAM_SHARED : RAM_PRIVATE) | RAM_PROTECTED;
     return memory_region_init_ram_from_fd(&backend->mr, OBJECT(backend), name,
                                           backend->size, ram_flags, fd, 0, errp);
 }
diff --git a/backends/hostmem-file.c b/backends/hostmem-file.c
index 46321fda84..691a827819 100644
--- a/backends/hostmem-file.c
+++ b/backends/hostmem-file.c
@@ -82,7 +82,7 @@ file_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
 
     backend->aligned = true;
     name = host_memory_backend_get_name(backend);
-    ram_flags = backend->share ? RAM_SHARED : 0;
+    ram_flags = backend->share ? RAM_SHARED : RAM_PRIVATE;
     ram_flags |= fb->readonly ? RAM_READONLY_FD : 0;
     ram_flags |= fb->rom == ON_OFF_AUTO_ON ? RAM_READONLY : 0;
     ram_flags |= backend->reserve ? 0 : RAM_NORESERVE;
diff --git a/backends/hostmem-memfd.c b/backends/hostmem-memfd.c
index d4d0620e6c..1672da9e30 100644
--- a/backends/hostmem-memfd.c
+++ b/backends/hostmem-memfd.c
@@ -52,7 +52,7 @@ memfd_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
 
     backend->aligned = true;
     name = host_memory_backend_get_name(backend);
-    ram_flags = backend->share ? RAM_SHARED : 0;
+    ram_flags = backend->share ? RAM_SHARED : RAM_PRIVATE;
     ram_flags |= backend->reserve ? 0 : RAM_NORESERVE;
     ram_flags |= backend->guest_memfd ? RAM_GUEST_MEMFD : 0;
     return memory_region_init_ram_from_fd(&backend->mr, OBJECT(backend), name,
diff --git a/backends/hostmem-ram.c b/backends/hostmem-ram.c
index 39aac6bf35..868ae6ca80 100644
--- a/backends/hostmem-ram.c
+++ b/backends/hostmem-ram.c
@@ -28,7 +28,7 @@ ram_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
     }
 
     name = host_memory_backend_get_name(backend);
-    ram_flags = backend->share ? RAM_SHARED : 0;
+    ram_flags = backend->share ? RAM_SHARED : RAM_PRIVATE;
     ram_flags |= backend->reserve ? 0 : RAM_NORESERVE;
     ram_flags |= backend->guest_memfd ? RAM_GUEST_MEMFD : 0;
     return memory_region_init_ram_flags_nomigrate(&backend->mr, OBJECT(backend),
diff --git a/include/exec/memory.h b/include/exec/memory.h
index 3ee1901b52..9f73b59867 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -246,6 +246,16 @@ typedef struct IOMMUTLBEvent {
 /* RAM can be private that has kvm guest memfd backend */
 #define RAM_GUEST_MEMFD   (1 << 12)
 
+/*
+ * In RAMBlock creation functions, if MAP_SHARED is 0 in the flags parameter,
+ * the implementation may still create a shared mapping if other conditions
+ * require it.  Callers who specifically want a private mapping, eg objects
+ * specified by the user, must pass RAM_PRIVATE.
+ * After RAMBlock creation, MAP_SHARED in the block's flags indicates whether
+ * the block is shared or private, and MAP_PRIVATE is omitted.
+ */
+#define RAM_PRIVATE (1 << 13)
+
 static inline void iommu_notifier_init(IOMMUNotifier *n, IOMMUNotify fn,
                                        IOMMUNotifierFlag flags,
                                        hwaddr start, hwaddr end,
diff --git a/system/physmem.c b/system/physmem.c
index e4355649e9..03fac0a64f 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -1952,7 +1952,11 @@ RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, ram_addr_t max_size,
     ERRP_GUARD();
     RAMBlock *new_block;
     Error *local_err = NULL;
-    int64_t file_size, file_align;
+    int64_t file_size, file_align, share_flags;
+
+    share_flags = ram_flags & (RAM_PRIVATE | RAM_SHARED);
+    assert(share_flags != (RAM_SHARED | RAM_PRIVATE));
+    ram_flags &= ~RAM_PRIVATE;
 
     /* Just support these ram flags by now. */
     assert((ram_flags & ~(RAM_SHARED | RAM_PMEM | RAM_NORESERVE |
@@ -2097,7 +2101,11 @@ RAMBlock *qemu_ram_alloc_internal(ram_addr_t size, ram_addr_t max_size,
 {
     RAMBlock *new_block;
     Error *local_err = NULL;
-    int align;
+    int align, share_flags;
+
+    share_flags = ram_flags & (RAM_PRIVATE | RAM_SHARED);
+    assert(share_flags != (RAM_SHARED | RAM_PRIVATE));
+    ram_flags &= ~RAM_PRIVATE;
 
     assert((ram_flags & ~(RAM_SHARED | RAM_RESIZEABLE | RAM_PREALLOC |
                           RAM_NORESERVE | RAM_GUEST_MEMFD)) == 0);
@@ -2172,7 +2180,8 @@ RAMBlock *qemu_ram_alloc_from_ptr(ram_addr_t size, void *host,
 RAMBlock *qemu_ram_alloc(ram_addr_t size, uint32_t ram_flags,
                          MemoryRegion *mr, Error **errp)
 {
-    assert((ram_flags & ~(RAM_SHARED | RAM_NORESERVE | RAM_GUEST_MEMFD)) == 0);
+    assert((ram_flags & ~(RAM_SHARED | RAM_NORESERVE | RAM_GUEST_MEMFD |
+                          RAM_PRIVATE)) == 0);
     return qemu_ram_alloc_internal(size, size, NULL, NULL, ram_flags, mr, errp);
 }
 
-- 
2.35.3


