Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACE1DCF3942
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2024 13:50:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1srHXh-0007A1-W4; Thu, 19 Sep 2024 09:49:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaoshiyuan@baidu.com>)
 id 1srHXg-000748-2t
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 09:49:56 -0400
Received: from mx24.baidu.com ([111.206.215.185] helo=baidu.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaoshiyuan@baidu.com>)
 id 1srHXc-0006Mi-8X
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 09:49:55 -0400
To: David Hildenbrand <david@redhat.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, Jason Wang
 <jasowang@redhat.com>, "Zuo,Boqun" <zuoboqun@baidu.com>, "alxndr@bu.edu"
 <alxndr@bu.edu>, "thuth@redhat.com" <thuth@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Gao,Shiyuan"
 <gaoshiyuan@baidu.com>
Subject: Re: [PATCH v3 1/1] virtio-pci: Add lookup subregion of
 VirtIOPCIRegion MR
Thread-Topic: [PATCH v3 1/1] virtio-pci: Add lookup subregion of
 VirtIOPCIRegion MR
Thread-Index: AQHbCpq+8JD0HFaZskiEbYf/lnfsEg==
Date: Thu, 19 Sep 2024 13:49:26 +0000
Message-ID: <33842f6145ba42c5a9b021ba31054a7f@baidu.com>
References: <20240903120304.97833-1-gaoshiyuan@baidu.com>,
 <b7f9dad2-29d9-42e6-97b0-32be6c077391@redhat.com>
In-Reply-To: <b7f9dad2-29d9-42e6-97b0-32be6c077391@redhat.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.22.192.143]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-FEAS-Client-IP: 172.31.51.44
X-FE-Last-Public-Client-IP: 100.100.100.60
X-FE-Policy-ID: 52:10:53:SYSTEM
Received-SPF: pass client-ip=111.206.215.185;
 envelope-from=gaoshiyuan@baidu.com; helo=baidu.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Reply-to:  "Gao,Shiyuan" <gaoshiyuan@baidu.com>
From:  "Gao,Shiyuan" via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

>> Now virtio_address_space_lookup only lookup common/isr/device/notify
>> MR and exclude their subregions.
>>
>> When VHOST_USER_PROTOCOL_F_HOST_NOTIFIER enable, the notify MR has
>> host-notifier subregions and we need use host-notifier MR to
>> notify the hardware accelerator directly instead of eventfd notify.
>>
>> Further more, maybe common/isr/device MR also has subregions in
>> the future, so need memory_region_find for each MR incluing
>> their subregions.
>>
>> Add lookup subregion of VirtIOPCIRegion MR instead of only lookup contai=
ner MR.
>>
>> Fixes: a93c8d8 ("virtio-pci: Replace modern_as with direct access to mod=
ern_bar")
>>
>> Co-developed-by: Zuo Boqun <zuoboqun@baidu.com>
>> Signed-off-by: Gao Shiyuan <gaoshiyuan@baidu.com>
>> Signed-off-by: Zuo Boqun <zuoboqun@baidu.com>
>> ---
>>=A0=A0 hw/virtio/virtio-pci.c | 8 ++++++--
>>=A0=A0 1 file changed, 6 insertions(+), 2 deletions(-)
>>
>> ---
>> v2 -> v3:
>> * modify commit message
>> * remove unused variable and move mrs to the inner block
>> * replace error_report with assert
>>
>> v1 -> v2:
>> * modify commit message
>> * replace direct iteration over subregions with memory_region_find.
>>
>> diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
>> index 524b63e5c7..4d832fe845 100644
>> --- a/hw/virtio/virtio-pci.c
>> +++ b/hw/virtio/virtio-pci.c
>> @@ -615,8 +615,12 @@ static MemoryRegion *virtio_address_space_lookup(Vi=
rtIOPCIProxy *proxy,
>>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 reg =3D &proxy->regs[i];
>>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (*off >=3D reg->offset &&
>>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 *off + len <=3D reg->offset + =
reg->size) {
>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 *off -=3D reg->offset;
>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return &reg->mr;
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 MemoryRegionSection mrs =3D memory_re=
gion_find(&reg->mr,
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 *off - reg->offset, len);
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 assert(mrs.mr);
>
>We are able to trigger that assert:
>
>https://gitlab.com/qemu-project/qemu/-/issues/2576
>
>Can you take a look and send a fix?
>
>--
>Cheers,
>
>David / dhildenb

This problem is caused by the incorrect usage of the `memory_region_find` f=
unction.
`memory_region_find` need find address_space of the search MR, howerver the
VirtIOPCIRegion->regs[i].mr cann't find address_space, such as

memory-region: pci_bridge_pci
  0000000000000000-ffffffffffffffff (prio 0, i/o): pci_bridge_pci
    000000a000000000-000000a000003fff (prio 1, i/o): virtio-pci
      000000a000000000-000000a000000fff (prio 0, i/o): virtio-pci-common-vi=
rtio-balloon
      000000a000001000-000000a000001fff (prio 0, i/o): virtio-pci-isr-virti=
o-balloon
      000000a000002000-000000a000002fff (prio 0, i/o): virtio-pci-device-vi=
rtio-balloon
      000000a000003000-000000a000003fff (prio 0, i/o): virtio-pci-notify-vi=
rtio-balloon

memory_region_find
  --> memory_region_find_rcu
    --> memory_region_to_address_space
      --> return NULL

So memory_region_find cann't find these MR that not under address_space, Is=
 this as expected?

There are two ways to solve this problem.

* One is direct iteration over subregions of search MR instead of memory_re=
gion_find.
If use this method, we will make it more general to handle multi-level
subregion scenarios, even though they do not currently exist.

@@ -610,13 +610,22 @@ static MemoryRegion
*virtio_address_space_lookup(VirtIOPCIProxy *proxy,
 {
     int i;
     VirtIOPCIRegion *reg;
+    MemoryRegion *mr, *submr;

     for (i =3D 0; i < ARRAY_SIZE(proxy->regs); ++i) {
         reg =3D &proxy->regs[i];
         if (*off >=3D reg->offset &&
             *off + len <=3D reg->offset + reg->size) {
             *off -=3D reg->offset;
-            return &reg->mr;
+            mr =3D &reg->mr;
+            QTAILQ_FOREACH(submr, &mr->subregions, subregions_link) {
+                if (*off >=3D submr->addr &&
+                    *off + len < submr->addr + submr->size) {
+                    *off -=3D submr->addr;
+                    return submr;
+                }
+            }
+            return mr;
         }
     }

* Another is add address_space for VirtIOPCIProxy and PCIBridge, so memory_=
region_find
will find the address_space of the search MR.

diff --git a/hw/pci/pci_bridge.c b/hw/pci/pci_bridge.c
index 6a4e38856d..07873c478f 100644
--- a/hw/pci/pci_bridge.c
+++ b/hw/pci/pci_bridge.c
@@ -380,6 +380,7 @@ void pci_bridge_initfn(PCIDevice *dev, const char *type=
name)
     sec_bus->map_irq =3D br->map_irq ? br->map_irq : pci_swizzle_map_irq_f=
n;
     sec_bus->address_space_mem =3D &br->address_space_mem;
     memory_region_init(&br->address_space_mem, OBJECT(br), "pci_bridge_pci=
", UINT64_MAX);
+    address_space_init(&br->as_mem, &br->address_space_mem, "pci_bridge_pc=
i");
     sec_bus->address_space_io =3D &br->address_space_io;
     memory_region_init(&br->address_space_io, OBJECT(br), "pci_bridge_io",
                        4 * GiB);
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index 4d832fe845..83e020c0f6 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -2180,6 +2180,8 @@ static void virtio_pci_realize(PCIDevice *pci_dev, Er=
ror **errp)
                        /* PCI BAR regions must be powers of 2 */
                        pow2ceil(proxy->notify.offset + proxy->notify.size)=
);

+    address_space_init(&proxy->modern_as, &proxy->modern_bar, "virtio-pci"=
);
+
     if (proxy->disable_legacy =3D=3D ON_OFF_AUTO_AUTO) {
         proxy->disable_legacy =3D pcie_port ? ON_OFF_AUTO_ON : ON_OFF_AUTO=
_OFF;
     }
diff --git a/include/hw/pci/pci_bridge.h b/include/hw/pci/pci_bridge.h
index 5cd452115a..2e807760e4 100644
--- a/include/hw/pci/pci_bridge.h
+++ b/include/hw/pci/pci_bridge.h
@@ -72,6 +72,7 @@ struct PCIBridge {
      */
     MemoryRegion address_space_mem;
     MemoryRegion address_space_io;
+    AddressSpace as_mem;

     PCIBridgeWindows windows;

diff --git a/include/hw/virtio/virtio-pci.h b/include/hw/virtio/virtio-pci.=
h
index 9e67ba38c7..fddceaaa47 100644
--- a/include/hw/virtio/virtio-pci.h
+++ b/include/hw/virtio/virtio-pci.h
@@ -147,6 +147,7 @@ struct VirtIOPCIProxy {
     };
     MemoryRegion modern_bar;
     MemoryRegion io_bar;
+    AddressSpace modern_as;
     uint32_t legacy_io_bar_idx;
     uint32_t msix_bar_idx;
     uint32_t modern_io_bar_idx;
Maybe revert 1f881ea4a444ef36a8b6907b0b82be4b3af253a2 can also solve this a=
nd the
orignal problem.

Does anyone have any suggestions?=

