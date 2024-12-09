Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFA18E7717D
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2024 19:43:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKjeF-0001bh-76; Mon, 09 Dec 2024 14:42:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tKjeB-0001bN-Gd
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 14:42:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tKje9-0005ll-2J
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 14:42:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733773337;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zaDD/bidHkn6kacfPqN5r9ZxWV8HWOrMOHYvgrcMIOE=;
 b=ciels6bElDqIDFR2HVjVKAg1qY+zOYqfB6b8bK1TSE13+7GlgB0jLLNS0Gi6CfKCtDoSHM
 G0ghFDWS6oKStpLVl4zeEnny9cu3RV7QNhRWRCX2jfdgf7/lDpPtk6n8XJRAnuCoNPG7F1
 XlLFyQZx7LZl0yh/ll8pyatJnpWon90=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-217-5sCTDF9nOk277-t8IzGTZQ-1; Mon, 09 Dec 2024 14:42:13 -0500
X-MC-Unique: 5sCTDF9nOk277-t8IzGTZQ-1
X-Mimecast-MFC-AGG-ID: 5sCTDF9nOk277-t8IzGTZQ
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-6d8f14fc179so15568386d6.2
 for <qemu-devel@nongnu.org>; Mon, 09 Dec 2024 11:42:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733773333; x=1734378133;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zaDD/bidHkn6kacfPqN5r9ZxWV8HWOrMOHYvgrcMIOE=;
 b=OKH8unl6YI6UAsarq6Uib0cCdyIzK+BbgYytLbVWAG0pPf7X2ps4LYlYEtQMMefNLg
 uaaaz7q2dcWyyXhQXOT8VvX8vVqMDZONoeWH5uxZpU8vvysrkWVHnfHLDXx9RSUcF0o0
 ffs9AAaxt1STk9RqxQLYZY0URIzr6Tqxb0AmTJojJ5PQU33Yn7Gk6i5/LTdVf2s4DfEb
 f8mexKm12cE/hqyOCulCCe1B0oF5LAYWkjWp7WXOhe7FCNPxwLEpLK6eAD/Xk/YV9xEP
 g9FEAxck2BrzVjeIdwRsvfo1o+D3O+NobQFV49clNoN0ddbcQwroyeAYhtdKsdAj7cxj
 XCug==
X-Gm-Message-State: AOJu0Yy3SowRtNJOZOUagTxZe1CzcPGum3iAp0LO0ztRDccF7fNtmAUX
 N5LqWnA3JkIIRVAmClTrE8dLYwij/sYEDRTjV0V9RnglWvhup4ElMhEJm7SGG28PbpsR/fgl6Yu
 P+N899x2nJr2vFXUIjT9EKekTzLamkz3SaK5D7QRLFiKb5FgFo9ad
X-Gm-Gg: ASbGncuRgLFuP1ERAJ4R3ZGnef2Bm5TOOdis6qRqCB6NUS9QuQOpOtQ5jzKURZZa9Ui
 wCYqcb2N7xaUUN2+WSc0cXtssaCxOHsolOqYHS6N3LdCZ1bciFTXS4CSu59bglMXloh8P1EPjFT
 3w9sWHnXLkMJo3isvY8/5eozjcATlcHF+SPkZkjfHld7KH4j/sMwd7Fb8H8LjZfqG2NkrmWFHL9
 59xma0INd+bFE9oOg2AnPRHRUKSr/gtGjTtH6SNJJOcIlZY5YcmCMqybp9TNVJ8Zl3kldO4JSZe
 qux6xTmGbQQ=
X-Received: by 2002:a05:6214:c4f:b0:6d4:c6d:17fe with SMTP id
 6a1803df08f44-6d91e388c46mr30311726d6.25.1733773332972; 
 Mon, 09 Dec 2024 11:42:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFwGWgg0KdvJkfM3N7ovbieA8OBbvJHeOEsx16OVwJPyGCtiXzsx7q9AqGTx1iVaqJA2oFxaQ==
X-Received: by 2002:a05:6214:c4f:b0:6d4:c6d:17fe with SMTP id
 6a1803df08f44-6d91e388c46mr30311376d6.25.1733773332663; 
 Mon, 09 Dec 2024 11:42:12 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d9004a6264sm25674056d6.87.2024.12.09.11.42.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Dec 2024 11:42:12 -0800 (PST)
Date: Mon, 9 Dec 2024 14:42:09 -0500
From: Peter Xu <peterx@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH V4 02/19] physmem: fd-based shared memory
Message-ID: <Z1dIEUcSrI1aROSp@x1n>
References: <1733145611-62315-1-git-send-email-steven.sistare@oracle.com>
 <1733145611-62315-3-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1733145611-62315-3-git-send-email-steven.sistare@oracle.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.489,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Dec 02, 2024 at 05:19:54AM -0800, Steve Sistare wrote:
> @@ -2089,13 +2154,23 @@ RAMBlock *qemu_ram_alloc_internal(ram_addr_t size, ram_addr_t max_size,
>      new_block->page_size = qemu_real_host_page_size();
>      new_block->host = host;
>      new_block->flags = ram_flags;
> +
> +    if (!host && !xen_enabled()) {

Adding one more xen check is unnecessary.  This patch needed it could mean
that the patch can be refactored.. because we have xen checks in both
ram_block_add() and also in the fd allocation path.

At the meantime, see:

qemu_ram_alloc_from_fd():
    if (kvm_enabled() && !kvm_has_sync_mmu()) {
        error_setg(errp,
                   "host lacks kvm mmu notifiers, -mem-path unsupported");
        return NULL;
    }

I don't think any decent kernel could hit this, but that could be another
sign that this patch duplicated some file allocations.

> +        if ((new_block->flags & RAM_SHARED) &&
> +            !qemu_ram_alloc_shared(new_block, &local_err)) {
> +            goto err;
> +        }
> +    }
> +
>      ram_block_add(new_block, &local_err);
> -    if (local_err) {
> -        g_free(new_block);
> -        error_propagate(errp, local_err);
> -        return NULL;
> +    if (!local_err) {
> +        return new_block;
>      }
> -    return new_block;
> +
> +err:
> +    g_free(new_block);
> +    error_propagate(errp, local_err);
> +    return NULL;
>  }

IIUC we only need to conditionally convert an anon-allocation into an
fd-allocation, and then we don't need to mostly duplicate
qemu_ram_alloc_from_fd(), instead we reuse it.

I do have a few other comments elsewhere, but when I was trying to comment.
E.g., we either shouldn't need to bother caching qemu_memfd_check()
results, or do it in qemu_memfd_check() directly.. and some more.

Then I think it's easier I provide a patch, and also show that it can be
also smaller changes to do the same thing, with everything fixed up
(e.g. addressing above mmu notifier missing issue).  What do you think as
below?

===8<===
From a90119131a972b0b4f15770fe0b431770456e447 Mon Sep 17 00:00:00 2001
From: Peter Xu <peterx@redhat.com>
Date: Mon, 9 Dec 2024 13:38:06 -0500
Subject: [PATCH] physmem: Try to always allocate anon and shared memory with
 fd

qemu_ram_alloc_internal() is the memory API QEMU uses to allocate anonymous
memory.  It allows RAM_SHARED too on top of anonymous.

It might be always beneficial to allocate memory with fd attached whenever
possible because fd is normally more flexible comparing to the virtual
mapping alone.  For example, CPR can use it to pass over fds between
processes to share memory, especially useful when the memory can be pinned.

Since there's no harm when it's possible, do it unconditionally for all
such anonymous & shared memory allocations where the memory is to be
allocated.  Provide fallbacks when it can fail, e.g., when none of the
memory attached fd is available.

Two extra ERRP_GUARD()s are needed in the used functions, as we will not
care about error even if it happened, so it's easier to allow passing NULL
into them.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 system/physmem.c   | 38 ++++++++++++++++++++++++++++++++++++++
 util/memfd.c       |  2 ++
 util/oslib-posix.c |  2 ++
 3 files changed, 42 insertions(+)

diff --git a/system/physmem.c b/system/physmem.c
index dc1db3a384..4e795aefa0 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -47,6 +47,7 @@
 #include "qemu/qemu-print.h"
 #include "qemu/log.h"
 #include "qemu/memalign.h"
+#include "qemu/memfd.h"
 #include "exec/memory.h"
 #include "exec/ioport.h"
 #include "sysemu/dma.h"
@@ -2057,6 +2058,24 @@ RAMBlock *qemu_ram_alloc_from_file(ram_addr_t size, MemoryRegion *mr,
 }
 #endif
 
+/*
+ * Try to allocate a zero-sized anonymous fd for shared memory allocations.
+ * Returns >=0 if succeeded, <0 otherwise.
+ *
+ * Prioritize memfd, as it doesn't have the same /dev/shm size limitation
+ * v.s. POSIX shm_open().
+ */
+static int qemu_ram_alloc_anonymous_fd(void)
+{
+    if (qemu_memfd_check(0)) {
+        return qemu_memfd_create("anon-memfd", 0, 0, 0, 0, NULL);
+    } else if (qemu_shm_available()) {
+        return qemu_shm_alloc(0, NULL);
+    } else {
+        return -1;
+    }
+}
+
 static
 RAMBlock *qemu_ram_alloc_internal(ram_addr_t size, ram_addr_t max_size,
                                   void (*resized)(const char*,
@@ -2073,6 +2092,25 @@ RAMBlock *qemu_ram_alloc_internal(ram_addr_t size, ram_addr_t max_size,
                           RAM_NORESERVE | RAM_GUEST_MEMFD)) == 0);
     assert(!host ^ (ram_flags & RAM_PREALLOC));
 
+    /*
+     * Try to use fd-based allocation for anonymous and shared memory,
+     * because fd is normally more flexible (e.g. on memory sharing between
+     * processes).  We can still fallback to old ways if it fails.
+     */
+    if (!host && (ram_flags & RAM_SHARED)) {
+        int fd = qemu_ram_alloc_anonymous_fd();
+
+        if (fd >= 0) {
+            new_block = qemu_ram_alloc_from_fd(size, mr, ram_flags,
+                                               fd, 0, errp);
+            if (new_block) {
+                return new_block;
+            }
+            close(fd);
+        }
+        /* Either fd or ramblock allocation failed, fallback */
+    }
+
     align = qemu_real_host_page_size();
     align = MAX(align, TARGET_PAGE_SIZE);
     size = ROUND_UP(size, align);
diff --git a/util/memfd.c b/util/memfd.c
index 8a2e906962..0dc15b2f44 100644
--- a/util/memfd.c
+++ b/util/memfd.c
@@ -52,6 +52,8 @@ int qemu_memfd_create(const char *name, size_t size, bool hugetlb,
 {
     int htsize = hugetlbsize ? ctz64(hugetlbsize) : 0;
 
+    ERRP_GUARD();
+
     if (htsize && 1ULL << htsize != hugetlbsize) {
         error_setg(errp, "Hugepage size must be a power of 2");
         return -1;
diff --git a/util/oslib-posix.c b/util/oslib-posix.c
index f8c3724e68..6ca3e994fc 100644
--- a/util/oslib-posix.c
+++ b/util/oslib-posix.c
@@ -944,6 +944,8 @@ int qemu_shm_alloc(size_t size, Error **errp)
     static int sequence;
     mode_t mode;
 
+    ERRP_GUARD();
+
     cur_sequence = qatomic_fetch_inc(&sequence);
 
     /*
-- 
2.47.0



-- 
Peter Xu


