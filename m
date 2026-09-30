Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7A7DCA5FC5
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 15:15:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBw0V-0002XO-F5; Wed, 30 Sep 2026 11:14:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xBw0N-0002U8-TK
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 11:14:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xBw0M-0000hf-2z
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 11:13:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790781237;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=94CrXL6cQbmTN7H2hegnOb8GVXr5vOIwKBuBKE6Q3T8=;
 b=OSfJUJxrfVBLGdQnTb3kaD2oFyhk/562K3y6dHsd+hDLLoQyIi50BmCg0tF/dKuszp1MIe
 1jdWP1X32C+/2lcdwvRrWamCFVNI0wor86PW2xv2PZzqWnBCzUvNTlQOnyODMQmk0LKGLX
 GAUmV1j1yymqEaQkNXDNzfW/l4qtAq8=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-660-KusSGb5rP3ut7tfhSZmhfw-1; Wed, 30 Sep 2026 11:13:55 -0400
X-MC-Unique: KusSGb5rP3ut7tfhSZmhfw-1
X-Mimecast-MFC-AGG-ID: KusSGb5rP3ut7tfhSZmhfw_1790781235
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93cafdbdb7cso67198885a.0
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 08:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1790781235; x=1791386035; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=94CrXL6cQbmTN7H2hegnOb8GVXr5vOIwKBuBKE6Q3T8=;
 b=ncyWFIY/3V2UVv5y5XvuRktSUeCoICcVvxuKO5BAVRmcHZenJkR+iI3m2QubdB8EVj
 6d356jVPhDtKdqBT/s5M7738XbyMk/B3wDbpmnURuy15gf8sogQ8C2LElwTmZUlhsY/6
 OxDS8LMeuVe6Jefo7wXD2g2cIS89fc4NXK/JSqwWD/qdm5w8bfizHGVkxXDe6gPGbXjM
 zjJL0ynsBW7kqQVJqqxlONIITHGXvmG8Ek1qqY//CspU6ZPgNVpBc9nTZek8Lmvfg6Go
 40VrELnnidZCYfPkpqsbluftklovzOar6ZMUhryO/HMI0k/JlzS6gmbxumCN3ox8fWFr
 nwRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790781235; x=1791386035;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=94CrXL6cQbmTN7H2hegnOb8GVXr5vOIwKBuBKE6Q3T8=;
 b=h3fMrlHlIOh4zG/PSF1IuzsXZ36pEMsdvUhF3rRh9L3jnUD5ymqgsiezbR9EiyPOu+
 vmwpjBLyvvWTC54qYBCImjkQZACY8MAfoUkm5V/YgqEBNMO8C2T1pRvcU18g29pCcZwV
 C8vRCw60aBChvefbYtVaBwAnqS5GT17IoNQqDSBFXX+SSQ1EHonhkbFILPSTHZ8tXQCh
 wejoSB/jQbIUeDmEUz0c6kZ+bu6zx2htE5yN8+ukRwRkwimSbCsRjN5KnLgGo5HDFcJW
 cCEz/go9nkEU9KPD+ro2wTo9A8OvUv329vuvQTAFtSh64B85G49/BVMEIQYST66v5NNy
 X7rw==
X-Gm-Message-State: AFuF++lHhUH/Z2FYwUaQf1J1p/k7XrAja3kIePRchSe6lgNe6tTAaSjk
 +rRbD5I72K7kLW1BCn0/6QwAh1s4LX2zNCWLWS1yUukslJ5FIx0FoZMKF+fYPTFC+cXtCaHGt2s
 dzrjWLb5NHyCLM7AHzAMNLk43i5YEHiNFrh1yEn/4KDJM+sXdRWOwpIjEwMOfVbrDn9lpCIIZD7
 a1i7lNN4jhHaoUUbI97Yv+Yta9JZu9q6Z4InH6XENJ
X-Gm-Gg: AYBFou0Bh5ms5PW+0BIojx9LjCQDOymovz06zpHlLtAIGqILIWeByAdgaRsxa6ydWEa
 RdjEnuzlePYu2FfXbqVYlU8Y/4chPPCAek0W6Mi5+gzugESIPtsR+vu4lgNzw8x7/EOgnyV6YKD
 Kpgjc6EdU9obpDXK3B75aUyfYXsx4nNJ20LXG2z8o4akP4f1KGV7aV4gql/HqX2HaHqZUPZUFU9
 2wmhOa1wpcscX870QCoooBJ/qEwI+2is4NnVATfzXzx2j0w/cRL1bkQr4IeIdIOuAd6MGvJgpnq
 /iBwo764VrhIdXLUW8YPkPEJbIEdjHlgyzIDihfLv7BnjoQzlDyxWcb15c8TLQGGkDqg7VQ=
X-Received: by 2002:a05:620a:c41:b0:93b:cb64:25a5 with SMTP id
 af79cd13be357-93ca96c929amr298262785a.12.1790781234481; 
 Wed, 30 Sep 2026 08:13:54 -0700 (PDT)
X-Received: by 2002:a05:620a:c41:b0:93b:cb64:25a5 with SMTP id
 af79cd13be357-93ca96c929amr298253985a.12.1790781233782; 
 Wed, 30 Sep 2026 08:13:53 -0700 (PDT)
Received: from localhost ([142.188.212.246]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93ca807dd0csm136663885a.15.2026.09.30.08.13.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 08:13:53 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>, Michael Roth <michael.roth@amd.com>,
 David Hildenbrand <david@kernel.org>
Subject: [PULL 07/12] hostmem: Rename guest_memfd to guest_memfd_private
Date: Wed, 30 Sep 2026 11:13:35 -0400
Message-ID: <20260930151340.2817042-8-peterx@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260930151340.2817042-1-peterx@redhat.com>
References: <20260930151340.2817042-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Rename the HostMemoryBackend.guest_memfd field to reflect what it really
means: whether it needs guest_memfd to back its private guest memory.
This will help avoid conflicts when we introduce supported for using
guest_memfd for shared guest memory via hostmem.

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: Michael Roth <michael.roth@amd.com>
Reviewed-by: David Hildenbrand <david@kernel.org>
Signed-off-by: Michael Roth <michael.roth@amd.com>
Link: https://lore.kernel.org/r/20260929235109.1398509-8-michael.roth@amd.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/system/hostmem.h | 2 +-
 backends/hostmem-file.c  | 2 +-
 backends/hostmem-memfd.c | 2 +-
 backends/hostmem-ram.c   | 2 +-
 backends/hostmem-shm.c   | 2 +-
 backends/hostmem.c       | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/system/hostmem.h b/include/system/hostmem.h
index 88fa791ac7..dcbf81aeae 100644
--- a/include/system/hostmem.h
+++ b/include/system/hostmem.h
@@ -76,7 +76,7 @@ struct HostMemoryBackend {
     uint64_t size;
     bool merge, dump, use_canonical_path;
     bool prealloc, is_mapped, share, reserve;
-    bool guest_memfd, aligned;
+    bool guest_memfd_private, aligned;
     uint32_t prealloc_threads;
     ThreadContext *prealloc_context;
     DECLARE_BITMAP(host_nodes, MAX_NODES + 1);
diff --git a/backends/hostmem-file.c b/backends/hostmem-file.c
index bb7323d2bf..7efecf71f5 100644
--- a/backends/hostmem-file.c
+++ b/backends/hostmem-file.c
@@ -86,7 +86,7 @@ file_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
     ram_flags |= fb->readonly ? RAM_READONLY_FD : 0;
     ram_flags |= fb->rom == ON_OFF_AUTO_ON ? RAM_READONLY : 0;
     ram_flags |= backend->reserve ? 0 : RAM_NORESERVE;
-    ram_flags |= backend->guest_memfd ? RAM_GUEST_MEMFD_PRIVATE : 0;
+    ram_flags |= backend->guest_memfd_private ? RAM_GUEST_MEMFD_PRIVATE : 0;
     ram_flags |= fb->is_pmem ? RAM_PMEM : 0;
     ram_flags |= RAM_NAMED_FILE;
     return memory_region_init_ram_from_file(&backend->mr, OBJECT(backend), name,
diff --git a/backends/hostmem-memfd.c b/backends/hostmem-memfd.c
index d917a94d73..7a7855aaab 100644
--- a/backends/hostmem-memfd.c
+++ b/backends/hostmem-memfd.c
@@ -60,7 +60,7 @@ have_fd:
     backend->aligned = true;
     ram_flags = backend->share ? RAM_SHARED : RAM_PRIVATE;
     ram_flags |= backend->reserve ? 0 : RAM_NORESERVE;
-    ram_flags |= backend->guest_memfd ? RAM_GUEST_MEMFD_PRIVATE : 0;
+    ram_flags |= backend->guest_memfd_private ? RAM_GUEST_MEMFD_PRIVATE : 0;
     return memory_region_init_ram_from_fd(&backend->mr, OBJECT(backend), name,
                                           backend->size, ram_flags, fd, 0, errp);
 }
diff --git a/backends/hostmem-ram.c b/backends/hostmem-ram.c
index 96ad29112d..6a507fad77 100644
--- a/backends/hostmem-ram.c
+++ b/backends/hostmem-ram.c
@@ -30,7 +30,7 @@ ram_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
     name = host_memory_backend_get_name(backend);
     ram_flags = backend->share ? RAM_SHARED : RAM_PRIVATE;
     ram_flags |= backend->reserve ? 0 : RAM_NORESERVE;
-    ram_flags |= backend->guest_memfd ? RAM_GUEST_MEMFD_PRIVATE : 0;
+    ram_flags |= backend->guest_memfd_private ? RAM_GUEST_MEMFD_PRIVATE : 0;
     return memory_region_init_ram_flags_nomigrate(&backend->mr, OBJECT(backend),
                                                   name, backend->size,
                                                   ram_flags, errp);
diff --git a/backends/hostmem-shm.c b/backends/hostmem-shm.c
index e86fb2e0aa..4766db6aad 100644
--- a/backends/hostmem-shm.c
+++ b/backends/hostmem-shm.c
@@ -54,7 +54,7 @@ have_fd:
     /* Let's do the same as memory-backend-ram,share=on would do. */
     ram_flags = RAM_SHARED;
     ram_flags |= backend->reserve ? 0 : RAM_NORESERVE;
-    ram_flags |= backend->guest_memfd ? RAM_GUEST_MEMFD_PRIVATE : 0;
+    ram_flags |= backend->guest_memfd_private ? RAM_GUEST_MEMFD_PRIVATE : 0;
 
     return memory_region_init_ram_from_fd(&backend->mr, OBJECT(backend),
                                               backend_name, backend->size,
diff --git a/backends/hostmem.c b/backends/hostmem.c
index 02846b597d..a41540d50d 100644
--- a/backends/hostmem.c
+++ b/backends/hostmem.c
@@ -290,7 +290,7 @@ static void host_memory_backend_init(Object *obj)
     /* TODO: convert access to globals to compat properties */
     backend->merge = machine_mem_merge(machine);
     backend->dump = machine_dump_guest_core(machine);
-    backend->guest_memfd = machine_require_guest_memfd(machine);
+    backend->guest_memfd_private = machine_require_guest_memfd(machine);
     backend->reserve = true;
     backend->prealloc_threads = machine->smp.cpus;
 }
-- 
2.55.0


