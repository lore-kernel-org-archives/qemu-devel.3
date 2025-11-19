Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99E87CF58C1
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Nov 2025 17:30:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLlzx-00033k-V1; Wed, 19 Nov 2025 12:29:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vLlzn-00031S-PE
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 12:29:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vLlzl-0004Pf-MK
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 12:29:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763573368;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZCO99HltQYka+mV4Zl2jwDQO4MyhCZa7p2lWRxsiyeA=;
 b=dYgE3Pf76K/10qBKiWae9LGhSzcq1v4XeEyuXi9PmiCtVrELJCu6ahcJcv/gUPmbkrt+4t
 D1PeGlBHvtPbWW76XX5lk4g/c19d7TypIHbkBFzyjTJLqFhit59InQhBW3MVlalN3UhPXt
 l85pf0t9dUfrBGcX0BhxeWkCucwp2Pg=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-bs9vcGruNr208jAqxS782Q-1; Wed, 19 Nov 2025 12:29:27 -0500
X-MC-Unique: bs9vcGruNr208jAqxS782Q-1
X-Mimecast-MFC-AGG-ID: bs9vcGruNr208jAqxS782Q_1763573364
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-8b26bc4984bso1317420185a.1
 for <qemu-devel@nongnu.org>; Wed, 19 Nov 2025 09:29:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763573363; x=1764178163; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZCO99HltQYka+mV4Zl2jwDQO4MyhCZa7p2lWRxsiyeA=;
 b=Pq1bEFUDldCblrb2bb5DN7kpNxG0DpEgW9P3CIbBq27CsRh90/mD8Y4O+alxYXRljs
 KRfM59cWELSV3QovjEJx3UWbBwtseyoPZO4Qc5S4wnJgrURPFT7nH7fqpev+XS/yFihL
 rgZK5I6pLBc9VebNOZKazrgZwDVk6OZt6RTZg9sBMaVaUgVpXGVQ8c0b6cXUR+06HHBr
 6Oi7Qni5A5mZe/gn0Al8OR+lwZGgXzU7qnJMyMF2yyYVdumSo14/+bTyU3cJQMpTm7w6
 0NpNPnPuVtNFH2RICtZCwJmUGZXE0Q9o++zaOqbOVA3jA8JMjLiRMH1eGhUkmNpgwURO
 dg2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763573363; x=1764178163;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZCO99HltQYka+mV4Zl2jwDQO4MyhCZa7p2lWRxsiyeA=;
 b=C27CKZa0p+zMeJt3x5Y6gSo8iEWtzQ2OiDXJ+o3rK2BBBmearbryrY/eQX13V664nc
 1+kzKmHP1RIq1wFcBpcBoYz+1nN/blERrfEEI/SlvK8x4TP3t0NzoCC0zI9ZqbA9iOfZ
 i/fhonq+IdztJgTkyq0HwTd7ZqkMh55SWMlBdKYBXPfWugB/Cji8VdaZm51we/aeUD65
 mbIoNpGdNmyHnSzLxIE1EMGxbT7lz81W2ETjjzWBDpkG2sq1T2nzhDWONcwZCaY5WQMQ
 BAEM2AmyYmyX3JRsBmZqdG4WOgT5k+D4tkYRrE1iTjjJFzWDcb42t4Ud4XhSR2wEN14j
 F/Yw==
X-Gm-Message-State: AOJu0YxzdZxLGT0fRBJkCWRhWzxr9VZcsBmSTqHY8OiRZr7cRvzQca0R
 LOZUY+CpcdNMOWeH8ivSlzWyzU2F1G2UKspcihMRoGqdL+u5M/Wg7ET17sDwoF7HfsCvJiWPs98
 0h3P3/HHSYKoU8x9ooSFiE30fHDvZVJdWIuqmtAWNn60P9sEnxE1Uf6YMt3yhLOdlrynVpa5FIP
 z2KdB3hMpXgvHlVJPBhUXglGXLutMW35PS0civHg==
X-Gm-Gg: ASbGnctVjR5cSG7yN3jjSsA/yxGVGqsD6X6+rbOII9361WAqaNHkyR/QIAbvWb/7cSw
 ZZC7gZrf7vwHpelp2XWUXaJRaAFO9M2b7eN3OoDcqVwch+vmEBfFmHX2P28yl5FmIvfP2X3qGlE
 C+zcuf0l11YCyISWge3jm4SR3fzJuCjAScpZeuaH0k3cGhepvRVCxf6UkXl9+pw/Mrx7ePHue6+
 TTCuV8A1ZOjEhI/JFOjpn0cFp/aCd5L2t9VQPO1fCFI3PwqQkNL5+FDXpnweDvB24++KdmAwlE1
 ocA/uG2LQNEXwlxNPnW4tF/q98Oac3Hme0/DmKp4dvKIn9fVJRiCDGIdOJipHZiN4JcvCSOsR4j
 t
X-Received: by 2002:a05:620a:191c:b0:8b2:6251:64f9 with SMTP id
 af79cd13be357-8b32737594emr22731985a.58.1763573363463; 
 Wed, 19 Nov 2025 09:29:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHaLfiXPwF0B+4rN0sSmDRr8joTXvVQMV5x3HZejv2uLMsMQj1cWNvdnmWxsEd6YDXvOAa5ew==
X-Received: by 2002:a05:620a:191c:b0:8b2:6251:64f9 with SMTP id
 af79cd13be357-8b32737594emr22725985a.58.1763573362757; 
 Wed, 19 Nov 2025 09:29:22 -0800 (PST)
Received: from x1.com ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8b2af042c9csm1444759485a.46.2025.11.19.09.29.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Nov 2025 09:29:22 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>,
 Alexey Kardashevskiy <aik@amd.com>, peterx@redhat.com,
 Chenyi Qiang <chenyi.qiang@intel.com>, Juraj Marcin <jmarcin@redhat.com>,
 Li Xiaoyao <xiaoyao.li@intel.com>, Fabiano Rosas <farosas@suse.de>
Subject: [PATCH v2 6/9] hostmem: Rename guest_memfd to guest_memfd_private
Date: Wed, 19 Nov 2025 12:29:10 -0500
Message-ID: <20251119172913.577392-7-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251119172913.577392-1-peterx@redhat.com>
References: <20251119172913.577392-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Rename the HostMemoryBackend.guest_memfd field to reflect what it really
means, on whether it needs guest_memfd to back its private portion of
mapping.  This will help on clearance when we introduce in-place
guest_memfd for hostmem.

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
index 1f20cd8fd6..0e4cfd6dc6 100644
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
index 3f3e485709..ea93f034e4 100644
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
index 35734d6f4d..70450733db 100644
--- a/backends/hostmem.c
+++ b/backends/hostmem.c
@@ -288,7 +288,7 @@ static void host_memory_backend_init(Object *obj)
     /* TODO: convert access to globals to compat properties */
     backend->merge = machine_mem_merge(machine);
     backend->dump = machine_dump_guest_core(machine);
-    backend->guest_memfd = machine_require_guest_memfd(machine);
+    backend->guest_memfd_private = machine_require_guest_memfd(machine);
     backend->reserve = true;
     backend->prealloc_threads = machine->smp.cpus;
 }
-- 
2.50.1


