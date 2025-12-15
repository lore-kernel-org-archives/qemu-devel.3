Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E06FD5B86D
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Dec 2025 20:54:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVFYO-0006IL-6Q; Mon, 15 Dec 2025 15:52:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vVFYL-0006Cs-9P
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 15:52:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vVFYJ-0005m3-Ly
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 15:52:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765831939;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZCO99HltQYka+mV4Zl2jwDQO4MyhCZa7p2lWRxsiyeA=;
 b=KD4rDa+G5QLiGIR6ckGI45g7HmIHY1YWv4ig6dJJJSarEziU2wW5TnDl2Yj47FNav6LdcL
 bsqiT3j0mdWwe9a0IHW274MUu9BhZ8bxIcdSafwp6Nr/nDNcCmTa+ruw4M0UK39ScHLLcO
 G0b/W2U22GMs4KKE0L0eSkRFdYchRXQ=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-70-z-LqT0OaOviIZknDZkswKA-1; Mon, 15 Dec 2025 15:52:18 -0500
X-MC-Unique: z-LqT0OaOviIZknDZkswKA-1
X-Mimecast-MFC-AGG-ID: z-LqT0OaOviIZknDZkswKA_1765831937
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-88a3d3823e1so18536776d6.2
 for <qemu-devel@nongnu.org>; Mon, 15 Dec 2025 12:52:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765831937; x=1766436737; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZCO99HltQYka+mV4Zl2jwDQO4MyhCZa7p2lWRxsiyeA=;
 b=hV7aM6SNYygm21kXbzx2QJQKfVf4HFMzlfVI6wMlZt8lG9T6itfc2MiJrd1CfYGGsP
 WjTF044o7FZdeAjBJ1c8JaFEDwvlGEUNZDoC1kMuvKtMWzjvC4UNI3NiPFO9Pp1s+bNV
 ymuGYykpGY7qnehG8GbL1/kHTqnLvoTMet9Ug1sYxlbAlNJ2+ugiYTLUqluT7LtPNpax
 OqfmkXKZ5dT7M+mZfhOtlPpEbo9nVWw2osEeObJxbkH6GMA8iSlebyHN/Qfjz/NKBDOc
 n85mJxqdk5drkBqOtl9onZPaMYICAivMLazHzqqeRxeWjJCc+hQF3rFH7VNkq9OSKe+c
 ULkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765831937; x=1766436737;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZCO99HltQYka+mV4Zl2jwDQO4MyhCZa7p2lWRxsiyeA=;
 b=fPLdDtfMh9iGjW+TNKtjEenMfcP3J7oXmcHYZnVfWXCCnbAWZ5VKFQ+BJ9uqJMA0AM
 IMRTjWFqcxRljoGqun9+idO921vnu4J3k57puIdR1UVwK/PIRoDOYdnhMUno87bpgH2l
 53I9jtr/oHpDgCD26RKhLQ9tdrTRAkOD2NjH2EaZEytW14o7t/Obkw54daAMhilsnc5J
 eaB+CrKxCQbGz/Y1E5J1egdEru51vLvfDwqaqgB9wQ/BZFW5xFfWxCvGa/z9MSTi47ZF
 5MQ9j08x3p08jLToe8cy02uxL5a6PwkHFvHZ/zUEpmR21CGRfGDjuWB1Z1hVNWpm2n6M
 Y/cw==
X-Gm-Message-State: AOJu0Yyr0Z/1nfekL9Ag15KCeiaU14uaGfiZWi5vgjEB424jw565cCBs
 oCG0W5tFF6kUSX8KmpEYCXHUy1Q//bO0al4WmQT0RxgusoZM8F2UmKO5DmF+9Fc5LY7oMLNN55f
 fTZ81FNnbY95VjYs3o4KJ5kfMi3JpJSKKNMwUXqKgRyA61uzlMTcmg5fRo4EFEIqmFzPDCekApy
 oyNn1EsHRdFkzjwOX0kZ3pmd/z9S6TtY5P8CKtvA==
X-Gm-Gg: AY/fxX6xIVO1/df3iwAwKnMhmiILj1l6WTlFhgqg7UF6AP7ZhEu67y52j69THyszoYp
 jJ1rCWSXeNOxo+usYlbbcs7pzsNdkSJE9SVT9xpfkLGF1pBWBqAZcSvaaPeFu6LA+/Fl5uTLZvn
 0Mou0NZ+V+sVN9ioAH1UGzuDWUWYYvseAEZfrCkF3iwlmKOEqAS8Ip3MgqdnOXs2BzyaX1GPgXM
 /rIjNodB+bhjAa5NzZ63m+AZoDmj9o8Kqrua0d+Qxvu0EylgINIS/y1Wz/DSJk7oXh440QpxpoZ
 vVyN8fv1/lt5jtfdt1GyXH+xKeKZpNkYoH6veM6eXnQ8BWbAe1VWTjew6w1vmQYc4R+aK3JlAv3
 0
X-Received: by 2002:a05:6214:3203:b0:884:5e18:e91a with SMTP id
 6a1803df08f44-8887e16bc5dmr227582276d6.2.1765831937087; 
 Mon, 15 Dec 2025 12:52:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFv3wHa5SuWYP1LYyaUTSP2dqRTbegD/ZM+IzW8zefsj+KKO48yYLHrS3oX8wWwtbbS01OJ6A==
X-Received: by 2002:a05:6214:3203:b0:884:5e18:e91a with SMTP id
 6a1803df08f44-8887e16bc5dmr227581726d6.2.1765831936542; 
 Mon, 15 Dec 2025 12:52:16 -0800 (PST)
Received: from x1.com ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8899ea3621bsm58726236d6.36.2025.12.15.12.52.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Dec 2025 12:52:16 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Juraj Marcin <jmarcin@redhat.com>, David Hildenbrand <david@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Chenyi Qiang <chenyi.qiang@intel.com>,
 peterx@redhat.com, Fabiano Rosas <farosas@suse.de>,
 Alexey Kardashevskiy <aik@amd.com>, Li Xiaoyao <xiaoyao.li@intel.com>
Subject: [PATCH v3 07/12] hostmem: Rename guest_memfd to guest_memfd_private
Date: Mon, 15 Dec 2025 15:51:58 -0500
Message-ID: <20251215205203.1185099-8-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251215205203.1185099-1-peterx@redhat.com>
References: <20251215205203.1185099-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
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


