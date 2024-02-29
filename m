Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32D8DC48BF6
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 10:35:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfdkL-0002gS-LU; Thu, 29 Feb 2024 05:34:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heinrich.schuchardt@canonical.com>)
 id 1rfdkJ-0002gG-R1
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 05:34:35 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heinrich.schuchardt@canonical.com>)
 id 1rfdkF-0000GL-DK
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 05:34:34 -0500
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id C82A840706
 for <qemu-devel@nongnu.org>; Thu, 29 Feb 2024 10:34:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1709202867;
 bh=+nRw0gGPohGNITbFCbhqxyAAg/baX43qmplBru8MQIE=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=OXsJoqF41VxYMRzA60+RiULqG4vgKOJ0R/FXmlt7owjVLSTPSyGQYUFRHyA2ymuE7
 xDfzvZ5m0yE7rv5T8KYxdSuYPm6GjA3anSab2AAa3WMAk45qzmxRAjHiJpvIJ5TUUu
 3MGWmCigZ+VsNvbAAamr+GUbLufW+S/ePZO1jtvgjxcsN1coQ6d/Lky2JeXVi5KmSO
 zK/dYThNhu1QU74L/6gklclbYhlrLo3EQREpSbIzcVvjwm5mSyPiY0Gs1UMnIgYJCe
 iAHg0yqBcvy1fjXmIXTG3woyaAjvEKhaZqK1pEYcqR8ecsGF1IX1JX2D8MbhydqxWz
 764t6tcFwHJQQ==
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a3fc1f1805bso49476566b.2
 for <qemu-devel@nongnu.org>; Thu, 29 Feb 2024 02:34:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709202867; x=1709807667;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+nRw0gGPohGNITbFCbhqxyAAg/baX43qmplBru8MQIE=;
 b=W3DJlQpdAFMxdnVYJXKWCsGEGPGpIwC8nJuvnSfoK0YMVsIYTyKkjhB+OAVk2GDpAl
 Rtiu0zoL+lo5+Ao50z19boItfchrm3V7EmnA2gCuIKqcgPHJmuqqU/PzlJP39uot1ecr
 YyPkMF/nifZ7Xuu0zGr9tUBwMZwevfVzwlPf7tPZDJ+I04ZHUduCXK4fLLe5wYVSm+Xc
 LksS/WjV4eJKsumcFwMgt81KYpY0m94uHWqO994iRADt/10TTCVO2DaTmZmSWokFVvqV
 YcQIEMGRoQYXucICG9Tlo9rDJRt50JcteThfgfCfnDuCoV2f+hqmRMelFHINpII6n8+y
 bupw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUBoINM+jYOq0R3Aymr0bYnngXX6up6JnFwEjuQ2QS/SCLZVvvExCBEMZ/87hiC4io0LqrXByZzH2Hak4CrhE7X52J2rnM=
X-Gm-Message-State: AOJu0Yw+kHeA308qN+VQ/0vTdVAS4IY+Z7aOkQ5jMUW9N3L3WMeUUzaT
 S9rkdYIku8pIYA1lZL6SylG6ju0RiRWlCugvQYnvWvMHPH9Ftt3+vXDCEVAS0tHIaqDNUkuavm7
 lwla81QMZ6jlnWD6wATiwgTobK6ri3T+6AFkm7mqYHoIy4br1+1CYoOS9DHaFMrvQQ6nN
X-Received: by 2002:a17:906:44d:b0:a3e:b523:3a66 with SMTP id
 e13-20020a170906044d00b00a3eb5233a66mr1209684eja.62.1709202867348; 
 Thu, 29 Feb 2024 02:34:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGVsmO6Cx6iMZsxfnEY0VelhOhejdvxJ64oKSDSN7gXPJYHgg9OzGpvfRZibnY9WU9weNCFJA==
X-Received: by 2002:a17:906:44d:b0:a3e:b523:3a66 with SMTP id
 e13-20020a170906044d00b00a3eb5233a66mr1209666eja.62.1709202866880; 
 Thu, 29 Feb 2024 02:34:26 -0800 (PST)
Received: from ?IPV6:2a00:20:10:8f6:23ea:cac0:4a99:bcbf?
 ([2a00:20:10:8f6:23ea:cac0:4a99:bcbf])
 by smtp.gmail.com with ESMTPSA id
 h15-20020a170906718f00b00a443b138020sm543451ejk.72.2024.02.29.02.34.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Feb 2024 02:34:26 -0800 (PST)
Message-ID: <4cb0c0a8-179a-45b5-9165-003d5662a2f4@canonical.com>
Date: Thu, 29 Feb 2024 11:34:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/5] softmmu: Support concurrent bounce buffers
Content-Language: en-US
To: Mattias Nissler <mnissler@rivosinc.com>, peterx@redhat.com
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 john.levon@nutanix.com, David Hildenbrand <david@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>, qemu-devel@nongnu.org,
 jag.raman@oracle.com, stefanha@redhat.com
References: <20240212080617.2559498-1-mnissler@rivosinc.com>
 <20240212080617.2559498-3-mnissler@rivosinc.com>
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20240212080617.2559498-3-mnissler@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=185.125.188.122;
 envelope-from=heinrich.schuchardt@canonical.com;
 helo=smtp-relay-internal-0.canonical.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.102,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 12.02.24 09:06, Mattias Nissler wrote:
> When DMA memory can't be directly accessed, as is the case when
> running the device model in a separate process without shareable DMA
> file descriptors, bounce buffering is used.
> 
> It is not uncommon for device models to request mapping of several DMA
> regions at the same time. Examples include:
>   * net devices, e.g. when transmitting a packet that is split across
>     several TX descriptors (observed with igb)
>   * USB host controllers, when handling a packet with multiple data TRBs
>     (observed with xhci)
> 
> Previously, qemu only provided a single bounce buffer per AddressSpace
> and would fail DMA map requests while the buffer was already in use. In
> turn, this would cause DMA failures that ultimately manifest as hardware
> errors from the guest perspective.
> 
> This change allocates DMA bounce buffers dynamically instead of
> supporting only a single buffer. Thus, multiple DMA mappings work
> correctly also when RAM can't be mmap()-ed.
> 
> The total bounce buffer allocation size is limited individually for each
> AddressSpace. The default limit is 4096 bytes, matching the previous
> maximum buffer size. A new x-max-bounce-buffer-size parameter is
> provided to configure the limit for PCI devices.
> 
> Signed-off-by: Mattias Nissler <mnissler@rivosinc.com>
> ---
>   hw/pci/pci.c                |  8 ++++
>   include/exec/memory.h       | 14 +++----
>   include/hw/pci/pci_device.h |  3 ++
>   system/memory.c             |  5 ++-
>   system/physmem.c            | 80 +++++++++++++++++++++++++------------
>   5 files changed, 74 insertions(+), 36 deletions(-)
> 
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index 6496d027ca..036b3ff822 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -85,6 +85,8 @@ static Property pci_props[] = {
>                       QEMU_PCIE_ERR_UNC_MASK_BITNR, true),
>       DEFINE_PROP_BIT("x-pcie-ari-nextfn-1", PCIDevice, cap_present,
>                       QEMU_PCIE_ARI_NEXTFN_1_BITNR, false),
> +    DEFINE_PROP_SIZE("x-max-bounce-buffer-size", PCIDevice,
> +                     max_bounce_buffer_size, DEFAULT_MAX_BOUNCE_BUFFER_SIZE),
>       DEFINE_PROP_END_OF_LIST()
>   };
>   
> @@ -1203,6 +1205,8 @@ static PCIDevice *do_pci_register_device(PCIDevice *pci_dev,
>                          "bus master container", UINT64_MAX);
>       address_space_init(&pci_dev->bus_master_as,
>                          &pci_dev->bus_master_container_region, pci_dev->name);
> +    pci_dev->bus_master_as.max_bounce_buffer_size =
> +        pci_dev->max_bounce_buffer_size;
>   
>       if (phase_check(PHASE_MACHINE_READY)) {
>           pci_init_bus_master(pci_dev);
> @@ -2632,6 +2636,10 @@ static void pci_device_class_init(ObjectClass *klass, void *data)
>       k->unrealize = pci_qdev_unrealize;
>       k->bus_type = TYPE_PCI_BUS;
>       device_class_set_props(k, pci_props);
> +    object_class_property_set_description(
> +        klass, "x-max-bounce-buffer-size",
> +        "Maximum buffer size allocated for bounce buffers used for mapped "
> +        "access to indirect DMA memory");
>   }
>   
>   static void pci_device_class_base_init(ObjectClass *klass, void *data)
> diff --git a/include/exec/memory.h b/include/exec/memory.h
> index 6995a443d3..e7bc4717ea 100644
> --- a/include/exec/memory.h
> +++ b/include/exec/memory.h
> @@ -1111,13 +1111,7 @@ typedef struct AddressSpaceMapClient {
>       QLIST_ENTRY(AddressSpaceMapClient) link;
>   } AddressSpaceMapClient;
>   
> -typedef struct {
> -    MemoryRegion *mr;
> -    void *buffer;
> -    hwaddr addr;
> -    hwaddr len;
> -    bool in_use;
> -} BounceBuffer;
> +#define DEFAULT_MAX_BOUNCE_BUFFER_SIZE (4096)
>   
>   /**
>    * struct AddressSpace: describes a mapping of addresses to #MemoryRegion objects
> @@ -1137,8 +1131,10 @@ struct AddressSpace {
>       QTAILQ_HEAD(, MemoryListener) listeners;
>       QTAILQ_ENTRY(AddressSpace) address_spaces_link;
>   
> -    /* Bounce buffer to use for this address space. */
> -    BounceBuffer bounce;
> +    /* Maximum DMA bounce buffer size used for indirect memory map requests */
> +    uint64_t max_bounce_buffer_size;
> +    /* Total size of bounce buffers currently allocated, atomically accessed */
> +    uint64_t bounce_buffer_size;
>       /* List of callbacks to invoke when buffers free up */
>       QemuMutex map_client_list_lock;
>       QLIST_HEAD(, AddressSpaceMapClient) map_client_list;
> diff --git a/include/hw/pci/pci_device.h b/include/hw/pci/pci_device.h
> index d3dd0f64b2..f4027c5379 100644
> --- a/include/hw/pci/pci_device.h
> +++ b/include/hw/pci/pci_device.h
> @@ -160,6 +160,9 @@ struct PCIDevice {
>       /* ID of standby device in net_failover pair */
>       char *failover_pair_id;
>       uint32_t acpi_index;
> +
> +    /* Maximum DMA bounce buffer size used for indirect memory map requests */
> +    uint64_t max_bounce_buffer_size;
>   };
>   
>   static inline int pci_intx(PCIDevice *pci_dev)
> diff --git a/system/memory.c b/system/memory.c
> index ad0caef1b8..1cf89654a1 100644
> --- a/system/memory.c
> +++ b/system/memory.c
> @@ -3133,7 +3133,8 @@ void address_space_init(AddressSpace *as, MemoryRegion *root, const char *name)
>       as->ioeventfds = NULL;
>       QTAILQ_INIT(&as->listeners);
>       QTAILQ_INSERT_TAIL(&address_spaces, as, address_spaces_link);
> -    as->bounce.in_use = false;
> +    as->max_bounce_buffer_size = DEFAULT_MAX_BOUNCE_BUFFER_SIZE;

4096 as bounce_buffer_size per AddressSpace is much too low. See 
https://gitlab.com/qemu-project/qemu/-/issues/2014.

Why do we need the limit at all?

Best regards

Heinrich


> +    as->bounce_buffer_size = 0;
>       qemu_mutex_init(&as->map_client_list_lock);
>       QLIST_INIT(&as->map_client_list);
>       as->name = g_strdup(name ? name : "anonymous");
> @@ -3143,7 +3144,7 @@ void address_space_init(AddressSpace *as, MemoryRegion *root, const char *name)
>   
>   static void do_address_space_destroy(AddressSpace *as)
>   {
> -    assert(!qatomic_read(&as->bounce.in_use));
> +    assert(qatomic_read(&as->bounce_buffer_size) == 0);
>       assert(QLIST_EMPTY(&as->map_client_list));
>       qemu_mutex_destroy(&as->map_client_list_lock);
>   
> diff --git a/system/physmem.c b/system/physmem.c
> index 7170e3473f..6a3c9de512 100644
> --- a/system/physmem.c
> +++ b/system/physmem.c
> @@ -2974,6 +2974,20 @@ void cpu_flush_icache_range(hwaddr start, hwaddr len)
>                                        NULL, len, FLUSH_CACHE);
>   }
>   
> +/*
> + * A magic value stored in the first 8 bytes of the bounce buffer struct. Used
> + * to detect illegal pointers passed to address_space_unmap.
> + */
> +#define BOUNCE_BUFFER_MAGIC 0xb4017ceb4ffe12ed
> +
> +typedef struct {
> +    uint64_t magic;
> +    MemoryRegion *mr;
> +    hwaddr addr;
> +    size_t len;
> +    uint8_t buffer[];
> +} BounceBuffer;
> +
>   static void
>   address_space_unregister_map_client_do(AddressSpaceMapClient *client)
>   {
> @@ -2999,9 +3013,9 @@ void address_space_register_map_client(AddressSpace *as, QEMUBH *bh)
>       qemu_mutex_lock(&as->map_client_list_lock);
>       client->bh = bh;
>       QLIST_INSERT_HEAD(&as->map_client_list, client, link);
> -    /* Write map_client_list before reading in_use.  */
> +    /* Write map_client_list before reading bounce_buffer_size. */
>       smp_mb();
> -    if (!qatomic_read(&as->bounce.in_use)) {
> +    if (qatomic_read(&as->bounce_buffer_size) < as->max_bounce_buffer_size) {
>           address_space_notify_map_clients_locked(as);
>       }
>       qemu_mutex_unlock(&as->map_client_list_lock);
> @@ -3131,28 +3145,38 @@ void *address_space_map(AddressSpace *as,
>       mr = flatview_translate(fv, addr, &xlat, &l, is_write, attrs);
>   
>       if (!memory_access_is_direct(mr, is_write)) {
> -        if (qatomic_xchg(&as->bounce.in_use, true)) {
> +        size_t size = qatomic_add_fetch(&as->bounce_buffer_size, l);
> +        if (size > as->max_bounce_buffer_size) {
> +            /*
> +             * Note that the overshot might be larger than l if threads are
> +             * racing and bump bounce_buffer_size at the same time.
> +             */
> +            size_t excess = MIN(size - as->max_bounce_buffer_size, l);
> +            l -= excess;
> +            qatomic_sub(&as->bounce_buffer_size, excess);
> +        }
> +
> +        if (l == 0) {
>               *plen = 0;
>               return NULL;
>           }
> -        /* Avoid unbounded allocations */
> -        l = MIN(l, TARGET_PAGE_SIZE);
> -        as->bounce.buffer = qemu_memalign(TARGET_PAGE_SIZE, l);
> -        as->bounce.addr = addr;
> -        as->bounce.len = l;
>   
> +        BounceBuffer *bounce = g_malloc0(l + sizeof(BounceBuffer));
> +        bounce->magic = BOUNCE_BUFFER_MAGIC;
>           memory_region_ref(mr);
> -        as->bounce.mr = mr;
> +        bounce->mr = mr;
> +        bounce->addr = addr;
> +        bounce->len = l;
> +
>           if (!is_write) {
>               flatview_read(fv, addr, MEMTXATTRS_UNSPECIFIED,
> -                          as->bounce.buffer, l);
> +                          bounce->buffer, l);
>           }
>   
>           *plen = l;
> -        return as->bounce.buffer;
> +        return bounce->buffer;
>       }
>   
> -
>       memory_region_ref(mr);
>       *plen = flatview_extend_translation(fv, addr, len, mr, xlat,
>                                           l, is_write, attrs);
> @@ -3167,12 +3191,11 @@ void *address_space_map(AddressSpace *as,
>   void address_space_unmap(AddressSpace *as, void *buffer, hwaddr len,
>                            bool is_write, hwaddr access_len)
>   {
> -    if (buffer != as->bounce.buffer) {
> -        MemoryRegion *mr;
> -        ram_addr_t addr1;
> +    MemoryRegion *mr;
> +    ram_addr_t addr1;
>   
> -        mr = memory_region_from_host(buffer, &addr1);
> -        assert(mr != NULL);
> +    mr = memory_region_from_host(buffer, &addr1);
> +    if (mr != NULL) {
>           if (is_write) {
>               invalidate_and_set_dirty(mr, addr1, access_len);
>           }
> @@ -3182,15 +3205,22 @@ void address_space_unmap(AddressSpace *as, void *buffer, hwaddr len,
>           memory_region_unref(mr);
>           return;
>       }
> +
> +
> +    BounceBuffer *bounce = container_of(buffer, BounceBuffer, buffer);
> +    assert(bounce->magic == BOUNCE_BUFFER_MAGIC);
> +
>       if (is_write) {
> -        address_space_write(as, as->bounce.addr, MEMTXATTRS_UNSPECIFIED,
> -                            as->bounce.buffer, access_len);
> -    }
> -    qemu_vfree(as->bounce.buffer);
> -    as->bounce.buffer = NULL;
> -    memory_region_unref(as->bounce.mr);
> -    /* Clear in_use before reading map_client_list.  */
> -    qatomic_set_mb(&as->bounce.in_use, false);
> +        address_space_write(as, bounce->addr, MEMTXATTRS_UNSPECIFIED,
> +                            bounce->buffer, access_len);
> +    }
> +
> +    qatomic_sub(&as->bounce_buffer_size, bounce->len);
> +    bounce->magic = ~BOUNCE_BUFFER_MAGIC;
> +    memory_region_unref(bounce->mr);
> +    g_free(bounce);
> +    /* Write bounce_buffer_size before reading map_client_list. */
> +    smp_mb();
>       address_space_notify_map_clients(as);
>   }
>   


