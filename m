Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D849D132A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 10:46:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7uaP-0007fH-K3; Mon, 04 Nov 2024 05:45:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1t7uaO-0007f9-QI
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 05:45:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1t7uaL-0002tX-EG
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 05:45:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730717124;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=23FvaOExOR+oCVOclEjygmTFAAnzySvRiUYgSbFVcXk=;
 b=h/J2cL+3qHhO3nMnhENMQXseM0hZWzH3DcX4UDpFRFjpTMa3jAshst9TRpLZtGpyNP+r9n
 SeeQwzTLnlpo4Py1xsD271DojK4YxqdfRhsLW/XlFO2qj1Ty+FJlDS6K5e/CL45Ch4s1mO
 pyPo0w1ufYI33XRov4zqAxnntoMsCy0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-GH8c7M1MOFic_yPQW0Nuqw-1; Mon, 04 Nov 2024 05:45:23 -0500
X-MC-Unique: GH8c7M1MOFic_yPQW0Nuqw-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4327bd6bd60so27555095e9.1
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 02:45:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730717122; x=1731321922;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:from:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=23FvaOExOR+oCVOclEjygmTFAAnzySvRiUYgSbFVcXk=;
 b=WyX+0L4uJO6O0f8Ot2YMw6LJ9GjIGvuWZJhugMI5SffnBVSsjodP3HbXl0UpiRaykF
 Ly4a0bT8beqgdDT3j2sf0kIzT6OBLvSYw1Cayo4jlF6OquB2oGP1d/nSEiMt64L24OUI
 X26FLlppvwkCr+BNyo1mYRBnM9wetsXNbx5P1v00l91xElOyPaWhj8SiiW4dGdWG/RkV
 khSMRNNMYE6G9S5ZTP5xcxjiwCQu6xZFbtTrx1Cq2UWaoU8tk6bDBCgJe2GpwUehWxSB
 SIlXiGG8lKoo7ybXRljpiSPXTmJlbpfnxOBMAq5jXY2mjdajsnB+CmOgjDUGkxw1o6t3
 QMMQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVld1axev0FgXHOODujw0EDlYH4tfJLUn9hgceTr8IbQaXGNnf4UBnubRQT0gT7rjAJbDbg159SIq6h@nongnu.org
X-Gm-Message-State: AOJu0YzcwLIvYZgZoeiqgii23YYs0I9szcih5XyUqeET3OOk/OlI7F/S
 nJQy5VD0a7f0PIiHysVbdaYiTDC3rh6tQmrJm+HY4zMRlb01LI4ZZpx3p5YDs2g+X2qn0z9CuuV
 EYNiHCjWTTDeMJTLhB2s1lmrgwqWNcQAmsAO252VE3RudgNiH+7NZ
X-Received: by 2002:a05:600c:1e03:b0:431:5df7:b337 with SMTP id
 5b1f17b1804b1-4319ac9a703mr278013325e9.8.1730717122008; 
 Mon, 04 Nov 2024 02:45:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGEFeeEYLhGkOaL4p8+4cImSXACa4BdpGlNBeDOIAhheTSvkcZOzm/Wve8AL81yuRFxIoSOqw==
X-Received: by 2002:a05:600c:1e03:b0:431:5df7:b337 with SMTP id
 5b1f17b1804b1-4319ac9a703mr278013065e9.8.1730717121562; 
 Mon, 04 Nov 2024 02:45:21 -0800 (PST)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7?
 ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-431bd74f132sm184444555e9.0.2024.11.04.02.45.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Nov 2024 02:45:21 -0800 (PST)
Message-ID: <a1b51e4c-76db-41bf-b145-471869216589@redhat.com>
Date: Mon, 4 Nov 2024 11:45:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 01/16] machine: anon-alloc option
From: David Hildenbrand <david@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <1730468875-249970-1-git-send-email-steven.sistare@oracle.com>
 <1730468875-249970-2-git-send-email-steven.sistare@oracle.com>
 <78fa25f1-03dc-400c-a604-998c53e4fbce@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <78fa25f1-03dc-400c-a604-998c53e4fbce@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
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

On 04.11.24 11:39, David Hildenbrand wrote:
> On 01.11.24 14:47, Steve Sistare wrote:
>> Allocate anonymous memory using mmap MAP_ANON or memfd_create depending
>> on the value of the anon-alloc machine property.  This option applies to
>> memory allocated as a side effect of creating various devices. It does
>> not apply to memory-backend-objects, whether explicitly specified on
>> the command line, or implicitly created by the -m command line option.
>>
>> The memfd option is intended to support new migration modes, in which the
>> memory region can be transferred in place to a new QEMU process, by sending
>> the memfd file descriptor to the process.  Memory contents are preserved,
>> and if the mode also transfers device descriptors, then pages that are
>> locked in memory for DMA remain locked.  This behavior is a pre-requisite
>> for supporting vfio, vdpa, and iommufd devices with the new modes.
> 
> A more portable, non-Linux specific variant of this will be using shm,
> similar to backends/hostmem-shm.c.
> 
> Likely we should be using that instead of memfd, or try hiding the
> details. See below.
> 
> [...]
> 
>> @@ -69,6 +70,8 @@
>>    
>>    #include "qemu/pmem.h"
>>    
>> +#include "qapi/qapi-types-migration.h"
>> +#include "migration/options.h"
>>    #include "migration/vmstate.h"
>>    
>>    #include "qemu/range.h"
>> @@ -1849,6 +1852,35 @@ static void ram_block_add(RAMBlock *new_block, Error **errp)
>>                    qemu_mutex_unlock_ramlist();
>>                    return;
>>                }
>> +
>> +        } else if (current_machine->anon_alloc == ANON_ALLOC_OPTION_MEMFD &&
>> +                   !object_dynamic_cast(new_block->mr->parent_obj.parent,
>> +                                        TYPE_MEMORY_BACKEND)) {
> 
> This looks a bit and hackish, and I don't think ram_block_add() is the right
> place where this should be. It should likely happen in the caller.
> 
> We already do have two ways of allocating "shared anonymous memory":
> 
> (1) memory-backend-ram,share=on
> (2) memory-backend-shm
> 
> (2) gives us an fd as it uses shm_open(), (1) doesn't give us an fd as it
> uses MAP_ANON|MAP_SHARED. (1) is really only a corner case use case [1].
> 
> [there is also Linux specific memfd, which gives us more flexibility with
> hugetlb etc, but for the purpose here shm should likely be sufficient?]
> 
> So why not make (1) behave like (2) and move that handling into
> qemu_ram_alloc_internal(), from where we can easily enable it using a
> new RMA_SHARED flag? So as a first step, something like:
> 
>   From 4b7b760c6e54cf05addca6728edc19adbec1588a Mon Sep 17 00:00:00 2001
> From: David Hildenbrand <david@redhat.com>
> Date: Mon, 4 Nov 2024 11:29:22 +0100
> Subject: [PATCH] tmp
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>    backends/hostmem-shm.c | 56 ++++----------------------------
>    system/physmem.c       | 73 ++++++++++++++++++++++++++++++++++++++++--
>    2 files changed, 76 insertions(+), 53 deletions(-)
> 
> diff --git a/backends/hostmem-shm.c b/backends/hostmem-shm.c
> index 374edc3db8..0f33b35e9c 100644
> --- a/backends/hostmem-shm.c
> +++ b/backends/hostmem-shm.c
> @@ -25,11 +25,8 @@ struct HostMemoryBackendShm {
>    static bool
>    shm_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
>    {
> -    g_autoptr(GString) shm_name = g_string_new(NULL);
> -    g_autofree char *backend_name = NULL;
> +    g_autofree char *name = NULL;
>        uint32_t ram_flags;
> -    int fd, oflag;
> -    mode_t mode;
>    
>        if (!backend->size) {
>            error_setg(errp, "can't create shm backend with size 0");
> @@ -41,54 +38,13 @@ shm_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
>            return false;
>        }
>    
> -    /*
> -     * Let's use `mode = 0` because we don't want other processes to open our
> -     * memory unless we share the file descriptor with them.
> -     */
> -    mode = 0;
> -    oflag = O_RDWR | O_CREAT | O_EXCL;
> -    backend_name = host_memory_backend_get_name(backend);
> -
> -    /*
> -     * Some operating systems allow creating anonymous POSIX shared memory
> -     * objects (e.g. FreeBSD provides the SHM_ANON constant), but this is not
> -     * defined by POSIX, so let's create a unique name.
> -     *
> -     * From Linux's shm_open(3) man-page:
> -     *   For  portable  use,  a shared  memory  object should be identified
> -     *   by a name of the form /somename;"
> -     */
> -    g_string_printf(shm_name, "/qemu-" FMT_pid "-shm-%s", getpid(),
> -                    backend_name);
> -
> -    fd = shm_open(shm_name->str, oflag, mode);
> -    if (fd < 0) {
> -        error_setg_errno(errp, errno,
> -                         "failed to create POSIX shared memory");
> -        return false;
> -    }
> -
> -    /*
> -     * We have the file descriptor, so we no longer need to expose the
> -     * POSIX shared memory object. However it will remain allocated as long as
> -     * there are file descriptors pointing to it.
> -     */
> -    shm_unlink(shm_name->str);
> -
> -    if (ftruncate(fd, backend->size) == -1) {
> -        error_setg_errno(errp, errno,
> -                         "failed to resize POSIX shared memory to %" PRIu64,
> -                         backend->size);
> -        close(fd);
> -        return false;
> -    }
> -
> +    /* Let's do the same as memory-backend-ram,share=on would do. */
> +    name = host_memory_backend_get_name(backend);
>        ram_flags = RAM_SHARED;
>        ram_flags |= backend->reserve ? 0 : RAM_NORESERVE;
> -
> -    return memory_region_init_ram_from_fd(&backend->mr, OBJECT(backend),
> -                                              backend_name, backend->size,
> -                                              ram_flags, fd, 0, errp);
> +    return memory_region_init_ram_flags_nomigrate(&backend->mr, OBJECT(backend),
> +                                                  name, backend->size,
> +                                                  ram_flags, errp);
>    }
>    
>    static void
> diff --git a/system/physmem.c b/system/physmem.c
> index dc1db3a384..4d331b3828 100644
> --- a/system/physmem.c
> +++ b/system/physmem.c
> @@ -2057,6 +2057,59 @@ RAMBlock *qemu_ram_alloc_from_file(ram_addr_t size, MemoryRegion *mr,
>    }
>    #endif
>    
> +static int qemu_shm_alloc(size_t size, Error **errp)
> +{
> +    g_autoptr(GString) shm_name = g_string_new(NULL);
> +    int fd, oflag, cur_sequence;
> +    static int sequence;
> +    mode_t mode;
> +
> +    cur_sequence = qatomic_fetch_inc(&sequence);
> +
> +    /*
> +     * Let's use `mode = 0` because we don't want other processes to open our
> +     * memory unless we share the file descriptor with them.
> +     */
> +    mode = 0;
> +    oflag = O_RDWR | O_CREAT | O_EXCL;
> +
> +    /*
> +     * Some operating systems allow creating anonymous POSIX shared memory
> +     * objects (e.g. FreeBSD provides the SHM_ANON constant), but this is not
> +     * defined by POSIX, so let's create a unique name.
> +     *
> +     * From Linux's shm_open(3) man-page:
> +     *   For  portable  use,  a shared  memory  object should be identified
> +     *   by a name of the form /somename;"
> +     */
> +    g_string_printf(shm_name, "/qemu-" FMT_pid "-shm-%d", getpid(),
> +                    cur_sequence);
> +
> +    fd = shm_open(shm_name->str, oflag, mode);
> +    if (fd < 0) {
> +        error_setg_errno(errp, errno,
> +                         "failed to create POSIX shared memory");
> +        return false;
> +    }
> +
> +    /*
> +     * We have the file descriptor, so we no longer need to expose the
> +     * POSIX shared memory object. However it will remain allocated as long as
> +     * there are file descriptors pointing to it.
> +     */
> +    shm_unlink(shm_name->str);
> +
> +    if (ftruncate(fd, size) == -1) {
> +        error_setg_errno(errp, errno,
> +                         "failed to resize POSIX shared memory to %" PRIu64,
> +                         size);
> +        close(fd);
> +        return false;
> +    }
> +
> +    return fd;
> +}
> +
>    static
>    RAMBlock *qemu_ram_alloc_internal(ram_addr_t size, ram_addr_t max_size,
>                                      void (*resized)(const char*,
> @@ -2084,12 +2137,26 @@ RAMBlock *qemu_ram_alloc_internal(ram_addr_t size, ram_addr_t max_size,
>        new_block->used_length = size;
>        new_block->max_length = max_size;
>        assert(max_size >= size);
> -    new_block->fd = -1;
> +
>        new_block->guest_memfd = -1;
>        new_block->page_size = qemu_real_host_page_size();
> -    new_block->host = host;
>        new_block->flags = ram_flags;
> -    ram_block_add(new_block, &local_err);
> +        new_block->host = host;
> +
> +    if ((ram_flags & RAM_PREALLOC) || !(ram_flags & RAM_SHARED)) {
> +        new_block->fd = -1;
> +    } else {
> +        /*
> +         * We want anonymous shared memory, similar to MAP_SHARED|MAP_ANON; but
> +         * some users want the fd. So let's allocate shm explicitly, which will
> +         * give us the fd.
> +         */
> +        assert(!host);
> +        new_block->fd = qemu_shm_alloc(new_block->max_length, &local_err);

Note: completely untested.

Likely a file_ram_alloc() call is missing here.

-- 
Cheers,

David / dhildenb


