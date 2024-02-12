Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7305CC4829B
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Feb 2024 09:24:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZSXZ-0003np-VL; Mon, 12 Feb 2024 04:23:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rZSXX-0003nS-Fi
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 04:23:51 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rZSXU-0005Ty-Bd
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 04:23:51 -0500
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TYJp43PXlz67mnJ;
 Mon, 12 Feb 2024 17:20:12 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id 8B6E3140B73;
 Mon, 12 Feb 2024 17:23:35 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 12 Feb
 2024 09:23:35 +0000
Date: Mon, 12 Feb 2024 09:23:35 +0000
To: Mattias Nissler <mnissler@rivosinc.com>
CC: <qemu-devel@nongnu.org>, <jag.raman@oracle.com>, <peterx@redhat.com>,
 <stefanha@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 <john.levon@nutanix.com>, David Hildenbrand <david@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Richard
 Henderson" <richard.henderson@linaro.org>, Elena Ufimtseva
 <elena.ufimtseva@oracle.com>
Subject: Re: [PATCH v7 1/5] softmmu: Per-AddressSpace bounce buffering
Message-ID: <20240212092335.000029b6@Huawei.com>
In-Reply-To: <20240212080617.2559498-2-mnissler@rivosinc.com>
References: <20240212080617.2559498-1-mnissler@rivosinc.com>
 <20240212080617.2559498-2-mnissler@rivosinc.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@Huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, 12 Feb 2024 00:06:13 -0800
Mattias Nissler <mnissler@rivosinc.com> wrote:

> Instead of using a single global bounce buffer, give each AddressSpace
> its own bounce buffer. The MapClient callback mechanism moves to
> AddressSpace accordingly.
> 
> This is in preparation for generalizing bounce buffer handling further
> to allow multiple bounce buffers, with a total allocation limit
> configured per AddressSpace.
> 
> Signed-off-by: Mattias Nissler <mnissler@rivosinc.com>

Been using this for CXL testing (due to interleave everything needs
to be bounced) with virtio-blk-pci.
That needs an additional change as it doesn't use the pci address
space and I'm chasing down one other issue that I think is unrelated
to this patch (spurious huge transfer on power down).

On basis this works for me.

Tested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  include/exec/cpu-common.h |   2 -
>  include/exec/memory.h     |  45 ++++++++++++++++-
>  system/dma-helpers.c      |   4 +-
>  system/memory.c           |   7 +++
>  system/physmem.c          | 101 ++++++++++++++++----------------------
>  5 files changed, 93 insertions(+), 66 deletions(-)
> 
> diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
> index 9ead1be100..bd6999fa35 100644
> --- a/include/exec/cpu-common.h
> +++ b/include/exec/cpu-common.h
> @@ -148,8 +148,6 @@ void *cpu_physical_memory_map(hwaddr addr,
>                                bool is_write);
>  void cpu_physical_memory_unmap(void *buffer, hwaddr len,
>                                 bool is_write, hwaddr access_len);
> -void cpu_register_map_client(QEMUBH *bh);
> -void cpu_unregister_map_client(QEMUBH *bh);
>  
>  bool cpu_physical_memory_is_io(hwaddr phys_addr);
>  
> diff --git a/include/exec/memory.h b/include/exec/memory.h
> index 177be23db7..6995a443d3 100644
> --- a/include/exec/memory.h
> +++ b/include/exec/memory.h
> @@ -1106,6 +1106,19 @@ struct MemoryListener {
>      QTAILQ_ENTRY(MemoryListener) link_as;
>  };
>  
> +typedef struct AddressSpaceMapClient {
> +    QEMUBH *bh;
> +    QLIST_ENTRY(AddressSpaceMapClient) link;
> +} AddressSpaceMapClient;
> +
> +typedef struct {
> +    MemoryRegion *mr;
> +    void *buffer;
> +    hwaddr addr;
> +    hwaddr len;
> +    bool in_use;
> +} BounceBuffer;
> +
>  /**
>   * struct AddressSpace: describes a mapping of addresses to #MemoryRegion objects
>   */
> @@ -1123,6 +1136,12 @@ struct AddressSpace {
>      struct MemoryRegionIoeventfd *ioeventfds;
>      QTAILQ_HEAD(, MemoryListener) listeners;
>      QTAILQ_ENTRY(AddressSpace) address_spaces_link;
> +
> +    /* Bounce buffer to use for this address space. */
> +    BounceBuffer bounce;
> +    /* List of callbacks to invoke when buffers free up */
> +    QemuMutex map_client_list_lock;
> +    QLIST_HEAD(, AddressSpaceMapClient) map_client_list;
>  };
>  
>  typedef struct AddressSpaceDispatch AddressSpaceDispatch;
> @@ -2926,8 +2945,8 @@ bool address_space_access_valid(AddressSpace *as, hwaddr addr, hwaddr len,
>   * May return %NULL and set *@plen to zero(0), if resources needed to perform
>   * the mapping are exhausted.
>   * Use only for reads OR writes - not for read-modify-write operations.
> - * Use cpu_register_map_client() to know when retrying the map operation is
> - * likely to succeed.
> + * Use address_space_register_map_client() to know when retrying the map
> + * operation is likely to succeed.
>   *
>   * @as: #AddressSpace to be accessed
>   * @addr: address within that address space
> @@ -2952,6 +2971,28 @@ void *address_space_map(AddressSpace *as, hwaddr addr,
>  void address_space_unmap(AddressSpace *as, void *buffer, hwaddr len,
>                           bool is_write, hwaddr access_len);
>  
> +/*
> + * address_space_register_map_client: Register a callback to invoke when
> + * resources for address_space_map() are available again.
> + *
> + * address_space_map may fail when there are not enough resources available,
> + * such as when bounce buffer memory would exceed the limit. The callback can
> + * be used to retry the address_space_map operation. Note that the callback
> + * gets automatically removed after firing.
> + *
> + * @as: #AddressSpace to be accessed
> + * @bh: callback to invoke when address_space_map() retry is appropriate
> + */
> +void address_space_register_map_client(AddressSpace *as, QEMUBH *bh);
> +
> +/*
> + * address_space_unregister_map_client: Unregister a callback that has
> + * previously been registered and not fired yet.
> + *
> + * @as: #AddressSpace to be accessed
> + * @bh: callback to unregister
> + */
> +void address_space_unregister_map_client(AddressSpace *as, QEMUBH *bh);
>  
>  /* Internal functions, part of the implementation of address_space_read.  */
>  MemTxResult address_space_read_full(AddressSpace *as, hwaddr addr,
> diff --git a/system/dma-helpers.c b/system/dma-helpers.c
> index 9b221cf94e..74013308f5 100644
> --- a/system/dma-helpers.c
> +++ b/system/dma-helpers.c
> @@ -169,7 +169,7 @@ static void dma_blk_cb(void *opaque, int ret)
>      if (dbs->iov.size == 0) {
>          trace_dma_map_wait(dbs);
>          dbs->bh = aio_bh_new(ctx, reschedule_dma, dbs);
> -        cpu_register_map_client(dbs->bh);
> +        address_space_register_map_client(dbs->sg->as, dbs->bh);
>          return;
>      }
>  
> @@ -197,7 +197,7 @@ static void dma_aio_cancel(BlockAIOCB *acb)
>      }
>  
>      if (dbs->bh) {
> -        cpu_unregister_map_client(dbs->bh);
> +        address_space_unregister_map_client(dbs->sg->as, dbs->bh);
>          qemu_bh_delete(dbs->bh);
>          dbs->bh = NULL;
>      }
> diff --git a/system/memory.c b/system/memory.c
> index a229a79988..ad0caef1b8 100644
> --- a/system/memory.c
> +++ b/system/memory.c
> @@ -3133,6 +3133,9 @@ void address_space_init(AddressSpace *as, MemoryRegion *root, const char *name)
>      as->ioeventfds = NULL;
>      QTAILQ_INIT(&as->listeners);
>      QTAILQ_INSERT_TAIL(&address_spaces, as, address_spaces_link);
> +    as->bounce.in_use = false;
> +    qemu_mutex_init(&as->map_client_list_lock);
> +    QLIST_INIT(&as->map_client_list);
>      as->name = g_strdup(name ? name : "anonymous");
>      address_space_update_topology(as);
>      address_space_update_ioeventfds(as);
> @@ -3140,6 +3143,10 @@ void address_space_init(AddressSpace *as, MemoryRegion *root, const char *name)
>  
>  static void do_address_space_destroy(AddressSpace *as)
>  {
> +    assert(!qatomic_read(&as->bounce.in_use));
> +    assert(QLIST_EMPTY(&as->map_client_list));
> +    qemu_mutex_destroy(&as->map_client_list_lock);
> +
>      assert(QTAILQ_EMPTY(&as->listeners));
>  
>      flatview_unref(as->current_map);
> diff --git a/system/physmem.c b/system/physmem.c
> index 5e66d9ae36..7170e3473f 100644
> --- a/system/physmem.c
> +++ b/system/physmem.c
> @@ -2974,55 +2974,37 @@ void cpu_flush_icache_range(hwaddr start, hwaddr len)
>                                       NULL, len, FLUSH_CACHE);
>  }
>  
> -typedef struct {
> -    MemoryRegion *mr;
> -    void *buffer;
> -    hwaddr addr;
> -    hwaddr len;
> -    bool in_use;
> -} BounceBuffer;
> -
> -static BounceBuffer bounce;
> -
> -typedef struct MapClient {
> -    QEMUBH *bh;
> -    QLIST_ENTRY(MapClient) link;
> -} MapClient;
> -
> -QemuMutex map_client_list_lock;
> -static QLIST_HEAD(, MapClient) map_client_list
> -    = QLIST_HEAD_INITIALIZER(map_client_list);
> -
> -static void cpu_unregister_map_client_do(MapClient *client)
> +static void
> +address_space_unregister_map_client_do(AddressSpaceMapClient *client)
>  {
>      QLIST_REMOVE(client, link);
>      g_free(client);
>  }
>  
> -static void cpu_notify_map_clients_locked(void)
> +static void address_space_notify_map_clients_locked(AddressSpace *as)
>  {
> -    MapClient *client;
> +    AddressSpaceMapClient *client;
>  
> -    while (!QLIST_EMPTY(&map_client_list)) {
> -        client = QLIST_FIRST(&map_client_list);
> +    while (!QLIST_EMPTY(&as->map_client_list)) {
> +        client = QLIST_FIRST(&as->map_client_list);
>          qemu_bh_schedule(client->bh);
> -        cpu_unregister_map_client_do(client);
> +        address_space_unregister_map_client_do(client);
>      }
>  }
>  
> -void cpu_register_map_client(QEMUBH *bh)
> +void address_space_register_map_client(AddressSpace *as, QEMUBH *bh)
>  {
> -    MapClient *client = g_malloc(sizeof(*client));
> +    AddressSpaceMapClient *client = g_malloc(sizeof(*client));
>  
> -    qemu_mutex_lock(&map_client_list_lock);
> +    qemu_mutex_lock(&as->map_client_list_lock);
>      client->bh = bh;
> -    QLIST_INSERT_HEAD(&map_client_list, client, link);
> +    QLIST_INSERT_HEAD(&as->map_client_list, client, link);
>      /* Write map_client_list before reading in_use.  */
>      smp_mb();
> -    if (!qatomic_read(&bounce.in_use)) {
> -        cpu_notify_map_clients_locked();
> +    if (!qatomic_read(&as->bounce.in_use)) {
> +        address_space_notify_map_clients_locked(as);
>      }
> -    qemu_mutex_unlock(&map_client_list_lock);
> +    qemu_mutex_unlock(&as->map_client_list_lock);
>  }
>  
>  void cpu_exec_init_all(void)
> @@ -3038,28 +3020,27 @@ void cpu_exec_init_all(void)
>      finalize_target_page_bits();
>      io_mem_init();
>      memory_map_init();
> -    qemu_mutex_init(&map_client_list_lock);
>  }
>  
> -void cpu_unregister_map_client(QEMUBH *bh)
> +void address_space_unregister_map_client(AddressSpace *as, QEMUBH *bh)
>  {
> -    MapClient *client;
> +    AddressSpaceMapClient *client;
>  
> -    qemu_mutex_lock(&map_client_list_lock);
> -    QLIST_FOREACH(client, &map_client_list, link) {
> +    qemu_mutex_lock(&as->map_client_list_lock);
> +    QLIST_FOREACH(client, &as->map_client_list, link) {
>          if (client->bh == bh) {
> -            cpu_unregister_map_client_do(client);
> +            address_space_unregister_map_client_do(client);
>              break;
>          }
>      }
> -    qemu_mutex_unlock(&map_client_list_lock);
> +    qemu_mutex_unlock(&as->map_client_list_lock);
>  }
>  
> -static void cpu_notify_map_clients(void)
> +static void address_space_notify_map_clients(AddressSpace *as)
>  {
> -    qemu_mutex_lock(&map_client_list_lock);
> -    cpu_notify_map_clients_locked();
> -    qemu_mutex_unlock(&map_client_list_lock);
> +    qemu_mutex_lock(&as->map_client_list_lock);
> +    address_space_notify_map_clients_locked(as);
> +    qemu_mutex_unlock(&as->map_client_list_lock);
>  }
>  
>  static bool flatview_access_valid(FlatView *fv, hwaddr addr, hwaddr len,
> @@ -3126,8 +3107,8 @@ flatview_extend_translation(FlatView *fv, hwaddr addr,
>   * May map a subset of the requested range, given by and returned in *plen.
>   * May return NULL if resources needed to perform the mapping are exhausted.
>   * Use only for reads OR writes - not for read-modify-write operations.
> - * Use cpu_register_map_client() to know when retrying the map operation is
> - * likely to succeed.
> + * Use address_space_register_map_client() to know when retrying the map
> + * operation is likely to succeed.
>   */
>  void *address_space_map(AddressSpace *as,
>                          hwaddr addr,
> @@ -3150,25 +3131,25 @@ void *address_space_map(AddressSpace *as,
>      mr = flatview_translate(fv, addr, &xlat, &l, is_write, attrs);
>  
>      if (!memory_access_is_direct(mr, is_write)) {
> -        if (qatomic_xchg(&bounce.in_use, true)) {
> +        if (qatomic_xchg(&as->bounce.in_use, true)) {
>              *plen = 0;
>              return NULL;
>          }
>          /* Avoid unbounded allocations */
>          l = MIN(l, TARGET_PAGE_SIZE);
> -        bounce.buffer = qemu_memalign(TARGET_PAGE_SIZE, l);
> -        bounce.addr = addr;
> -        bounce.len = l;
> +        as->bounce.buffer = qemu_memalign(TARGET_PAGE_SIZE, l);
> +        as->bounce.addr = addr;
> +        as->bounce.len = l;
>  
>          memory_region_ref(mr);
> -        bounce.mr = mr;
> +        as->bounce.mr = mr;
>          if (!is_write) {
>              flatview_read(fv, addr, MEMTXATTRS_UNSPECIFIED,
> -                               bounce.buffer, l);
> +                          as->bounce.buffer, l);
>          }
>  
>          *plen = l;
> -        return bounce.buffer;
> +        return as->bounce.buffer;
>      }
>  
>  
> @@ -3186,7 +3167,7 @@ void *address_space_map(AddressSpace *as,
>  void address_space_unmap(AddressSpace *as, void *buffer, hwaddr len,
>                           bool is_write, hwaddr access_len)
>  {
> -    if (buffer != bounce.buffer) {
> +    if (buffer != as->bounce.buffer) {
>          MemoryRegion *mr;
>          ram_addr_t addr1;
>  
> @@ -3202,15 +3183,15 @@ void address_space_unmap(AddressSpace *as, void *buffer, hwaddr len,
>          return;
>      }
>      if (is_write) {
> -        address_space_write(as, bounce.addr, MEMTXATTRS_UNSPECIFIED,
> -                            bounce.buffer, access_len);
> +        address_space_write(as, as->bounce.addr, MEMTXATTRS_UNSPECIFIED,
> +                            as->bounce.buffer, access_len);
>      }
> -    qemu_vfree(bounce.buffer);
> -    bounce.buffer = NULL;
> -    memory_region_unref(bounce.mr);
> +    qemu_vfree(as->bounce.buffer);
> +    as->bounce.buffer = NULL;
> +    memory_region_unref(as->bounce.mr);
>      /* Clear in_use before reading map_client_list.  */
> -    qatomic_set_mb(&bounce.in_use, false);
> -    cpu_notify_map_clients();
> +    qatomic_set_mb(&as->bounce.in_use, false);
> +    address_space_notify_map_clients(as);
>  }
>  
>  void *cpu_physical_memory_map(hwaddr addr,


