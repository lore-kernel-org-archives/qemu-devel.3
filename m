Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64AE1E77188
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Dec 2024 17:19:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQ8YN-00056h-W3; Tue, 24 Dec 2024 12:18:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tQ8YM-00056U-5V
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 12:18:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tQ8YJ-0001bx-Tk
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 12:18:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1735060717;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=h89+gd01L7u9JKcyI1FnUcrNi9Esg0/O3cQQXb47Ql8=;
 b=XrlmeUzp8QDBZXE0Dpzgrcl8o0ar4JIdPs+0/7DRes34SGNGkWL4U4z2swW/nZ0Mbdqp8A
 9Xb5Bd5MSQy3jyXI8OtvBAwoQpX3SaM1z+WMED2bpP4FXbaOPPnNT688u2igIr8cbqJkXF
 NICVLxMHvnUBLMyrdz9rOhxOF6GMVuE=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-3-GedNp19bPROHL_3gaO-UNA-1; Tue, 24 Dec 2024 12:18:31 -0500
X-MC-Unique: GedNp19bPROHL_3gaO-UNA-1
X-Mimecast-MFC-AGG-ID: GedNp19bPROHL_3gaO-UNA
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-467b19b55d6so66563661cf.2
 for <qemu-devel@nongnu.org>; Tue, 24 Dec 2024 09:18:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735060710; x=1735665510;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h89+gd01L7u9JKcyI1FnUcrNi9Esg0/O3cQQXb47Ql8=;
 b=knQ00sSoA6akicuqb1BZN3vHPBnIGmKVp8hZSA92sEVa8iBoCdQPEopZ1a/x1q/ZRW
 8HTHNb9HglvnZITxRI+MhfB/67pobkvJ/trrkabYvZEt0iyTOm+zu3VQexSJlao9imRp
 otyI+jdy0mePJQELQShQrZGsgGYbsk68cLfCnMPupCgFdWcdW7hB6zjkNDzX6dKSRaTA
 PYKZLIhFhoXoRMAKQ6RP5wkAcGhZqQL5DyBPW2kdcCxFwPd1SdQh9zPOvxQLXpLYif+n
 JzBDS09Yjg0kIP0FJEKWAfe2YvOz7MryfB4ibxPuFuUpDjjQDyLfTciN3AauUzRFXRNW
 80Zw==
X-Gm-Message-State: AOJu0YwfanigWdANJ+VoqOyb3CeUHqxShQ/52iaf4Zs9c0+iHu4zANoy
 PYsTAtz9tpSTOW7wslP26AWy9zWQE0e/2jvXp0bMdffCahzyMCQzOwzahwiffdA5YmVFKePoEM6
 sJe8ab97ag50rva9r9xol8LM6oj6gk7ddg6sLXmKAFVehhDltKHKQ
X-Gm-Gg: ASbGncvvDvPCxGoRqv0Om2ZsZ7ByQyJlHBCZU3V4VOQ+m1cqxBhjYVpYztmtMGMMrur
 4Wj3ctKsd5XwyIoeAEqDtgwX8dCjS777HmbwHKK792sMVabupJt6eudR1vokseJ5qIoIyK0wccx
 AL4hdBmJdSOGnCy1HfNz8+i9joGARTjc6/aqAHiUq67xOeOUEbE1y/hhOyMVhIQMXGmcTZB9Unm
 EKV0kLgq8S0pFQJjaer6Sar8SgPn0hbK8HWwfLVFqNr5yHNrkuN2YB1eLgrelkx7bXWGPxQRTAE
 aUtjGrEaeHO6wMh6VA==
X-Received: by 2002:a05:622a:588:b0:467:86a9:f7d4 with SMTP id
 d75a77b69052e-46a4a8cc950mr300470411cf.16.1735060710478; 
 Tue, 24 Dec 2024 09:18:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGeT86JpAO7DiIrordB27UgWaQjNeUddJHWs9tpIzZ3abGcerXNKhofCB5NRvl8owoUCT/T4g==
X-Received: by 2002:a05:622a:588:b0:467:86a9:f7d4 with SMTP id
 d75a77b69052e-46a4a8cc950mr300469931cf.16.1735060710050; 
 Tue, 24 Dec 2024 09:18:30 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b9ac2e827dsm485305385a.49.2024.12.24.09.18.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Dec 2024 09:18:28 -0800 (PST)
Date: Tue, 24 Dec 2024 12:18:26 -0500
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
Subject: Re: [PATCH V5 02/23] physmem: qemu_ram_alloc_from_fd extensions
Message-ID: <Z2rs4nYtuXfFW4sT@x1n>
References: <1735057028-308595-1-git-send-email-steven.sistare@oracle.com>
 <1735057028-308595-3-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1735057028-308595-3-git-send-email-steven.sistare@oracle.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Dec 24, 2024 at 08:16:47AM -0800, Steve Sistare wrote:
> Extend qemu_ram_alloc_from_fd to support resizable ram, and define
> qemu_ram_resize_cb to clean up the API.
> 
> Add a grow parameter to extend the file if necessary.  However, if
> grow is false, a zero-sized file is always extended.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>  include/exec/ram_addr.h | 13 +++++++++----
>  system/memory.c         |  4 ++--
>  system/physmem.c        | 35 ++++++++++++++++++++---------------
>  3 files changed, 31 insertions(+), 21 deletions(-)
> 
> diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
> index ff157c1..94bb3cc 100644
> --- a/include/exec/ram_addr.h
> +++ b/include/exec/ram_addr.h
> @@ -111,23 +111,30 @@ long qemu_maxrampagesize(void);
>   *
>   * Parameters:
>   *  @size: the size in bytes of the ram block
> + *  @max_size: the maximum size of the block after resizing
>   *  @mr: the memory region where the ram block is
> + *  @resized: callback after calls to qemu_ram_resize
>   *  @ram_flags: RamBlock flags. Supported flags: RAM_SHARED, RAM_PMEM,
>   *              RAM_NORESERVE, RAM_PROTECTED, RAM_NAMED_FILE, RAM_READONLY,
>   *              RAM_READONLY_FD, RAM_GUEST_MEMFD
>   *  @mem_path or @fd: specify the backing file or device
>   *  @offset: Offset into target file
> + *  @grow: extend file if necessary (but an empty file is always extended).
>   *  @errp: pointer to Error*, to store an error if it happens
>   *
>   * Return:
>   *  On success, return a pointer to the ram block.
>   *  On failure, return NULL.
>   */
> +typedef void (*qemu_ram_resize_cb)(const char *, uint64_t length, void *host);
> +
>  RAMBlock *qemu_ram_alloc_from_file(ram_addr_t size, MemoryRegion *mr,
>                                     uint32_t ram_flags, const char *mem_path,
>                                     off_t offset, Error **errp);
> -RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, MemoryRegion *mr,
> +RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, ram_addr_t max_size,
> +                                 qemu_ram_resize_cb resized, MemoryRegion *mr,
>                                   uint32_t ram_flags, int fd, off_t offset,
> +                                 bool grow,
>                                   Error **errp);
>  
>  RAMBlock *qemu_ram_alloc_from_ptr(ram_addr_t size, void *host,
> @@ -135,9 +142,7 @@ RAMBlock *qemu_ram_alloc_from_ptr(ram_addr_t size, void *host,
>  RAMBlock *qemu_ram_alloc(ram_addr_t size, uint32_t ram_flags, MemoryRegion *mr,
>                           Error **errp);
>  RAMBlock *qemu_ram_alloc_resizeable(ram_addr_t size, ram_addr_t max_size,
> -                                    void (*resized)(const char*,
> -                                                    uint64_t length,
> -                                                    void *host),
> +                                    qemu_ram_resize_cb resized,
>                                      MemoryRegion *mr, Error **errp);
>  void qemu_ram_free(RAMBlock *block);
>  
> diff --git a/system/memory.c b/system/memory.c
> index 78e17e0..290c522 100644
> --- a/system/memory.c
> +++ b/system/memory.c
> @@ -1680,8 +1680,8 @@ bool memory_region_init_ram_from_fd(MemoryRegion *mr,
>      mr->readonly = !!(ram_flags & RAM_READONLY);
>      mr->terminates = true;
>      mr->destructor = memory_region_destructor_ram;
> -    mr->ram_block = qemu_ram_alloc_from_fd(size, mr, ram_flags, fd, offset,
> -                                           &err);
> +    mr->ram_block = qemu_ram_alloc_from_fd(size, size, NULL, mr, ram_flags, fd,
> +                                           offset, false, &err);
>      if (err) {
>          mr->size = int128_zero();
>          object_unparent(OBJECT(mr));
> diff --git a/system/physmem.c b/system/physmem.c
> index c76503a..48c544f 100644
> --- a/system/physmem.c
> +++ b/system/physmem.c
> @@ -1942,8 +1942,10 @@ out_free:
>  }
>  
>  #ifdef CONFIG_POSIX
> -RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, MemoryRegion *mr,
> +RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, ram_addr_t max_size,
> +                                 qemu_ram_resize_cb resized, MemoryRegion *mr,
>                                   uint32_t ram_flags, int fd, off_t offset,
> +                                 bool grow,
>                                   Error **errp)
>  {
>      RAMBlock *new_block;
> @@ -1953,7 +1955,9 @@ RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, MemoryRegion *mr,
>      /* Just support these ram flags by now. */
>      assert((ram_flags & ~(RAM_SHARED | RAM_PMEM | RAM_NORESERVE |
>                            RAM_PROTECTED | RAM_NAMED_FILE | RAM_READONLY |
> -                          RAM_READONLY_FD | RAM_GUEST_MEMFD)) == 0);
> +                          RAM_READONLY_FD | RAM_GUEST_MEMFD |
> +                          RAM_RESIZEABLE)) == 0);
> +    assert(max_size >= size);
>  
>      if (xen_enabled()) {
>          error_setg(errp, "-mem-path not supported with Xen");
> @@ -1968,12 +1972,14 @@ RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, MemoryRegion *mr,
>  
>      size = TARGET_PAGE_ALIGN(size);
>      size = REAL_HOST_PAGE_ALIGN(size);
> +    max_size = TARGET_PAGE_ALIGN(max_size);
> +    max_size = REAL_HOST_PAGE_ALIGN(max_size);
>  
>      file_size = get_file_size(fd);
> -    if (file_size > offset && file_size < (offset + size)) {
> +    if (file_size && file_size < offset + max_size && !grow) {

Is this a bugfix for the case offset < fsize?  If so, better make it a
small patch and copy stable..

$ touch ramfile
$ truncate -s 64M ramfile
$ ./qemu-system-x86_64 -object memory-backend-file,mem-path=./ramfile,offset=128M,size=128M,id=mem1,prealloc=on
qemu-system-x86_64: qemu_prealloc_mem: preallocating memory failed: Bad address

So yes, it's a bug..

>          error_setg(errp, "backing store size 0x%" PRIx64
>                     " does not match 'size' option 0x" RAM_ADDR_FMT,
> -                   file_size, size);
> +                   file_size, max_size);
>          return NULL;
>      }
>  
> @@ -1988,11 +1994,13 @@ RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, MemoryRegion *mr,
>      new_block = g_malloc0(sizeof(*new_block));
>      new_block->mr = mr;
>      new_block->used_length = size;
> -    new_block->max_length = size;
> +    new_block->max_length = max_size;
> +    new_block->resized = resized;
>      new_block->flags = ram_flags;
>      new_block->guest_memfd = -1;
> -    new_block->host = file_ram_alloc(new_block, size, fd, !file_size, offset,
> -                                     errp);
> +    new_block->host = file_ram_alloc(new_block, max_size, fd,
> +                                     file_size < offset + max_size,

Same here, looks like relevant to above.

In general, we want to either fail properly detecting wrong-sized files, or
making sure qemu can boot correctly with the fd.  I confess pretty corner
cases.. but still.

So the whole patch looks correct, but maybe need a split.

> +                                     offset, errp);
>      if (!new_block->host) {
>          g_free(new_block);
>          return NULL;
> @@ -2044,7 +2052,8 @@ RAMBlock *qemu_ram_alloc_from_file(ram_addr_t size, MemoryRegion *mr,
>          return NULL;
>      }
>  
> -    block = qemu_ram_alloc_from_fd(size, mr, ram_flags, fd, offset, errp);
> +    block = qemu_ram_alloc_from_fd(size, size, NULL, mr, ram_flags, fd, offset,
> +                                   false, errp);
>      if (!block) {
>          if (created) {
>              unlink(mem_path);
> @@ -2059,9 +2068,7 @@ RAMBlock *qemu_ram_alloc_from_file(ram_addr_t size, MemoryRegion *mr,
>  
>  static
>  RAMBlock *qemu_ram_alloc_internal(ram_addr_t size, ram_addr_t max_size,
> -                                  void (*resized)(const char*,
> -                                                  uint64_t length,
> -                                                  void *host),
> +                                  qemu_ram_resize_cb resized,
>                                    void *host, uint32_t ram_flags,
>                                    MemoryRegion *mr, Error **errp)
>  {
> @@ -2113,10 +2120,8 @@ RAMBlock *qemu_ram_alloc(ram_addr_t size, uint32_t ram_flags,
>  }
>  
>  RAMBlock *qemu_ram_alloc_resizeable(ram_addr_t size, ram_addr_t maxsz,
> -                                     void (*resized)(const char*,
> -                                                     uint64_t length,
> -                                                     void *host),
> -                                     MemoryRegion *mr, Error **errp)
> +                                    qemu_ram_resize_cb resized,
> +                                    MemoryRegion *mr, Error **errp)
>  {
>      return qemu_ram_alloc_internal(size, maxsz, resized, NULL,
>                                     RAM_RESIZEABLE, mr, errp);
> -- 
> 1.8.3.1
> 

-- 
Peter Xu


