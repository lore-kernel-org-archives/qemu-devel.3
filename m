Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5955BC53209
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 18:54:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woQSP-00012X-5C; Mon, 27 Jul 2026 14:53:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1woQSG-000127-Po; Mon, 27 Jul 2026 14:53:37 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1woQSE-0005X5-GG; Mon, 27 Jul 2026 14:53:36 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66RIHtvS2881532; Mon, 27 Jul 2026 18:53:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=J3fq6L
 gWWYdhpqZNFHAvGQHwoHelAX6HFsNTlwqY5PU=; b=U2Xcjfafbq6I/m/1TYE7tt
 H00xIQYzqBQenQl7SX5gYap5Pdcp9rf3GD12TA4d+syNRXyjdMl1c8ovE031dSa1
 0tqC2R3THyaanTYM829BQmkTx55x5Uo8dRlkDr/nE+WRVC0SNbYz4gvtT/OiBSGe
 zQoYfZmgDWAM/gpUJuwrfUSNrBYmjuU2buOIs0u+hcjcVxbZwtOeu8idgarz1qGo
 u+eod6vH5BciczzGnGWSFFwh9PZxLK6pRq2h6NTBMj1YQWA9K8CepGGeTPeVP/Kz
 q274MYP7UrGSFPV2Y3JXf2GejZDBqoKOxsH4b4hOSDVl5U/rACeGK78pVPqOclVw
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuyj15dk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 27 Jul 2026 18:53:28 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66RIfHUe014672;
 Mon, 27 Jul 2026 18:53:27 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8yh6hv2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 27 Jul 2026 18:53:27 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66RIrQHl20382238
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 27 Jul 2026 18:53:26 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8E19C5804E;
 Mon, 27 Jul 2026 18:53:26 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 781415803F;
 Mon, 27 Jul 2026 18:53:25 +0000 (GMT)
Received: from [9.61.252.168] (unknown [9.61.252.168])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 27 Jul 2026 18:53:25 +0000 (GMT)
Message-ID: <6390365c-018e-4ac9-96fd-7dba63736a2c@linux.ibm.com>
Date: Mon, 27 Jul 2026 11:53:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 14/15] s390x/pci: Implement migration for emulated
 devices
To: Konstantin Shkolnyy <kshk@linux.ibm.com>, mjrosato@linux.ibm.com
Cc: richard.henderson@linaro.org, iii@linux.ibm.com, david@kernel.org,
 cohuck@redhat.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org
References: <20260724030919.123733-1-kshk@linux.ibm.com>
 <20260724030919.123733-15-kshk@linux.ibm.com>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <20260724030919.123733-15-kshk@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDE3NCBTYWx0ZWRfX0+jZOzR1196u
 tNklvmMQPeq+g4vRDQ8sd7HxJkXmRreF/b6rzjVUXLyxxUG9TyRoDv6/5BqdkvrL0Vq/aOFN8Yl
 7gOxbPGcTD5nmz0/MIDIw2otWqLf1yk=
X-Proofpoint-GUID: J48XWzDOm3U7fVp58Ku_mzZ_ojMvU_uP
X-Proofpoint-ORIG-GUID: J48XWzDOm3U7fVp58Ku_mzZ_ojMvU_uP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDE3NCBTYWx0ZWRfX6d80S8SmuybP
 b8F7c4GWzrb7xfFfl4vp57aeAUW7uEOF81+poSaTUX2UM6YQH85POY9MnYGSKeXgEHRV8jXRSK3
 EpPayQBJ+1J8thjvRaRkQaLiuKCnQt01qWGzDWgiEKAxzO0yEpxShKSqGbzrXpm0ythnsc74vyq
 9SO6zoU1h/vcXJaiE1NfG1ecIedE4i8fGi4a/qXzMkpiVb5boCitL9Bm2Gp8Yx100lkrAe6RXQh
 Aa0wCL6h1Sv7fwkH1PNX8Nrddl+1F3O2fgsAKI7AhoPFlEiGyGhI0kSQ36VkmmnaWdv79MSzfF2
 vNXSaYMgnxwmVv2r82cftZovcEO0ASKG79fWwjL/Q2pS0eifDWiRKFzXmBxU/BIprJD596/mMOo
 1t8UmPlM+3eVlfh3KfFHdLuZBiMmoUZyO3uT9X5qOsW/LFldTNawPEYAMyh18JB6w6fq263WHpl
 AY2s/rwfL28r7mi2HNw==
X-Authority-Analysis: v=2.4 cv=X5Vi7mTe c=1 sm=1 tr=0 ts=6a67a928 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=H1c1Ftysvx-bX8i7MrIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_05,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607270174
Received-SPF: pass client-ip=148.163.158.5; envelope-from=alifm@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


On 7/23/2026 8:09 PM, Konstantin Shkolnyy wrote:
> Implement zPCI device state migration, consequently enabling migration
> of VMs that have emulated PCI devices, whether virtio or not.
> Migration is allowed for devices whose function handle has the
> FH_SHM_EMUL bit set. For these devices QEMU will save and restore the
> state of its zPCI emulator.
>
> This will enable emulated PCI migration starting with s390-ccw-virtio-11.1.
>
> Passthrough devices will continue to block migration.
>
> Signed-off-by: Konstantin Shkolnyy <kshk@linux.ibm.com>
> ---
>   hw/s390x/s390-pci-bus.c         | 187 +++++++++++++++++++++++++++++++-
>   hw/s390x/s390-pci-inst.c        |   2 +-
>   hw/s390x/s390-virtio-ccw.c      |   4 +
>   include/hw/s390x/s390-pci-bus.h |   4 +
>   4 files changed, 191 insertions(+), 6 deletions(-)
>
> diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
> index a94e24a2ac..655667482d 100644
> --- a/hw/s390x/s390-pci-bus.c
> +++ b/hw/s390x/s390-pci-bus.c
> @@ -26,6 +26,7 @@
>   #include "hw/pci/pci_bridge.h"
>   #include "hw/pci/msi.h"
>   #include "exec/cpu-common.h"
> +#include "migration/blocker.h"
>   #include "qemu/error-report.h"
>   #include "qemu/module.h"
>   #include "system/physmem.h"
> @@ -34,6 +35,11 @@
>   
>   #include "trace.h"
>   
> +static const Property phb_props[] = {
> +    DEFINE_PROP_BOOL("x-zpci-emul-dev-migr-enabled", S390pciState,
> +                     emul_dev_migr_enabled, true),
> +};
> +
>   S390pciState *s390_get_phb(void)
>   {
>       static S390pciState *phb;
> @@ -917,6 +923,23 @@ static void set_pbdev_info(S390PCIBusDevice *pbdev)
>       pbdev->pci_group = s390_group_find(ZPCI_DEFAULT_FN_GRP);
>   }
>   
> +static int s390_set_emul_dev_migration_blocker(S390pciState *s, Error **errp)
> +{
> +    if (s->emul_dev_migr_enabled) {
> +        return 0;
> +    }
> +    error_setg(&s->emul_dev_migr_blocker,
> +               "Migration disabled for emulated zPCI devices on this machine type");
> +    return migrate_add_blocker(&s->emul_dev_migr_blocker, errp);
> +}
> +
> +static void s390_clear_emul_dev_migration_blocker(S390pciState *s)
> +{
> +    if (s->emul_dev_migr_blocker) {
> +        migrate_del_blocker(&s->emul_dev_migr_blocker);
> +    }
> +}
> +
>   static void s390_pcihost_realize(DeviceState *dev, Error **errp)
>   {
>       PCIBus *b;
> @@ -952,6 +975,7 @@ static void s390_pcihost_realize(DeviceState *dev, Error **errp)
>       css_register_io_adapters(CSS_IO_ADAPTER_PCI, true, false,
>                                S390_ADAPTER_SUPPRESSIBLE, errp);
>       s390_pcihost_kvm_realize();
> +    s390_set_emul_dev_migration_blocker(s, errp);
>   }
>   
>   static void s390_pcihost_unrealize(DeviceState *dev)
> @@ -959,6 +983,8 @@ static void s390_pcihost_unrealize(DeviceState *dev)
>       S390PCIGroup *group;
>       S390pciState *s = S390_PCI_HOST_BRIDGE(dev);
>   
> +    s390_clear_emul_dev_migration_blocker(s);
> +
>       while (!QTAILQ_EMPTY(&s->zpci_groups)) {
>           group = QTAILQ_FIRST(&s->zpci_groups);
>           QTAILQ_REMOVE(&s->zpci_groups, group, link);
> @@ -1129,6 +1155,27 @@ static int s390_pci_interp_plug(S390pciState *s, S390PCIBusDevice *pbdev)
>       return 0;
>   }
>   
> +static int s390_set_passthrough_migration_blocker(S390PCIBusDevice *pbdev,
> +                                            Error **errp)
> +{
> +    pbdev->passthrough_migr_blocker = NULL;
> +
> +    if (pbdev->fh & FH_SHM_EMUL) {
> +        return 0;
> +    }
> +    error_setg(&pbdev->passthrough_migr_blocker,
> +               "Migration blocked by passthrough zPCI device "
> +               "fh 0x%x uid %d fid %d", pbdev->fh, pbdev->uid, pbdev->fid);
> +    return migrate_add_blocker(&pbdev->passthrough_migr_blocker, errp);
> +}
> +
> +static void s390_clear_passthrough_migration_blocker(S390PCIBusDevice *pbdev)
> +{
> +    if (pbdev->passthrough_migr_blocker) {
> +        migrate_del_blocker(&pbdev->passthrough_migr_blocker);
> +    }
> +}
> +
>   static void s390_pcihost_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
>                                 Error **errp)
>   {
> @@ -1248,6 +1295,11 @@ static void s390_pcihost_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
>               return;
>           }
>   
> +        if (s390_set_passthrough_migration_blocker(pbdev, errp)) {
> +            s390_pci_msix_free(pbdev);
> +            return;
> +        }

Just curious, does this need to be after s390_pci_msix_init()? That way 
on error we avoid setting up the msix and subsequently freeing here.


> +
>           if (dev->hotplugged) {
>               s390_pci_generate_plug_event(HP_EVENT_TO_CONFIGURED ,
>                                            pbdev->fh, pbdev->fid);
> @@ -1284,6 +1336,8 @@ static void s390_pcihost_unplug(HotplugHandler *hotplug_dev, DeviceState *dev,
>               return;
>           }
>   
> +        s390_clear_passthrough_migration_blocker(pbdev);
> +
>           s390_pci_generate_plug_event(HP_EVENT_STANDBY_TO_RESERVED,
>                                        pbdev->fh, pbdev->fid);
>           bus = pci_get_bus(pci_dev);
> @@ -1451,6 +1505,7 @@ static void s390_pcihost_class_init(ObjectClass *klass, const void *data)
>       hc->unplug_request = s390_pcihost_unplug_request;
>       hc->unplug = s390_pcihost_unplug;
>       msi_nonbroken = true;
> +    device_class_set_props(dc, phb_props);
>   }
>   
>   static const TypeInfo s390_pcihost_info = {
> @@ -1464,10 +1519,33 @@ static const TypeInfo s390_pcihost_info = {
>       }
>   };
>   
> +/* Return a unique bus "path" for zpci device */
> +static char *s390_pci_bus_get_dev_path(DeviceState *dev)
> +{
> +    S390PCIBusDevice *pbdev = S390_PCI_DEVICE(dev);
> +    return g_strdup_printf("uid-%04x", pbdev->uid);
> +}
> +
> +static void s390_pcibus_class_init(ObjectClass *oc, const void *data)
> +{
> +    BusClass *bc = BUS_CLASS(oc);
> +    bc->get_dev_path = s390_pci_bus_get_dev_path;
> +}
> +
>   static const TypeInfo s390_pcibus_info = {
>       .name = TYPE_S390_PCI_BUS,
>       .parent = TYPE_BUS,
>       .instance_size = sizeof(S390PCIBus),
> +    /*
> +     * Implement get_dev_path() to provide each zpci device with a unique
> +     * stable UID-based bus "path". The "path" is used as part of idstr in the
> +     ^ migration stream, making idstr unique and instance_id always 0.
Typo here with "^ migration stream"

> +     * For migration to succeed, (idstr+instance_id) must match those generated
> +     * during QEMU start. Without unique idstr, QEMU will generate variable
> +     * instance_id to distinquish devices, and that instance_id can change
Typo "distinquish" -> distinguished
> +     * if a device is unplugged and plugged back, preventing migration.
> +     */
> +    .class_init = s390_pcibus_class_init,
>   };
>   
>   static uint16_t s390_pci_generate_uid(S390pciState *s)
> @@ -1613,13 +1691,112 @@ static const Property s390_pci_device_properties[] = {
>                        true),
>   };
>   
> -static const VMStateDescription s390_pci_device_vmstate = {
> -    .name = TYPE_S390_PCI_DEVICE,
> +static int s390_pci_device_pre_load(void *opaque)
> +{
> +    S390PCIBusDevice *pbdev = S390_PCI_DEVICE(opaque);
> +    S390PCIBusDevice *found_pbdev;
> +
> +    /*
> +     * Make sure pbdev is removed from the table before state load. The change
> +     * of pbdev->idx means it needs to be moved to a different position anyway,
> +     * and is illegal while in the table. But be careful to not remove
> +     * instead another pbdev whose state might have been loaded earlier and

I think "instead" is not needed in the statement above.

Maybe I am missing something, but could you help me understand why do we 
need to remove the pbdev if we found at a particular idx? If there is a 
collision with idx, ie on destination we have a different device with 
the same idx, are we removing a valid device?

> +     * that has then replaced our pbdev. (post_load() will put our pbdev back.)
> +     */
> +    found_pbdev = g_hash_table_lookup(s390_get_phb()->zpci_table, &pbdev->idx);
> +    assert(found_pbdev);
> +    if (found_pbdev == pbdev) {
> +        g_hash_table_remove(s390_get_phb()->zpci_table, &pbdev->idx);
> +    }
> +
> +    return 0;
> +}
> +
> +static int s390_pci_device_post_load(void *opaque, int version_id)
> +{
> +    S390PCIBusDevice *pbdev = S390_PCI_DEVICE(opaque);
> +
>       /*
> -     * TODO: add state handling here, so migration works at least with
> -     * emulated pci devices on s390x
> +     * Now that pbdev->idx has been loaded, use it to place pbdev back into
> +     * the table. This may replace a different not-yet-state-loaded pbdev,
> +     * but pre_load() handles this case.
>        */
> -    .unmigratable = 1,
> +    g_hash_table_replace(s390_get_phb()->zpci_table, &pbdev->idx, pbdev);
> +
> +    /*
> +     * Regenerate IOMMU state, including IOTLB contents and QEMU memory regions.
> +     */
> +    if (pbdev->iommu_enabled) {
> +        assert(pbdev->iommu);
> +        if (s390_pci_is_translation_enabled(pbdev->g_iota)) {
> +            s390_pci_iommu_enable(pbdev);
> +            s390_pci_ioat_replay(pbdev);
> +        } else {
> +            s390_pci_iommu_direct_map_enable(pbdev);
> +        }
> +    }
> +
> +    /*
> +     * Guest sets fmb_addr by mpcifc.ZPCI_MOD_FC_SET_MEASURE instruction,
> +     * whose handler consequently starts fmb_timer. We may need to restart it.
> +     */
> +    if (pbdev->fmb_addr) {
> +        assert(!pbdev->fmb_timer);
> +        assert(pbdev->pci_group);
> +        pbdev->fmb_timer = timer_new_ms(QEMU_CLOCK_VIRTUAL,
> +                                        fmb_update, pbdev);
> +        timer_mod(pbdev->fmb_timer,
> +                  qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL) +
> +                                    pbdev->pci_group->zpci_group.mui);
> +    }
> +    return 0;
> +}
> +
> +static const VMStateDescription s390_pci_device_vmstate = {
> +    .name = TYPE_S390_PCI_DEVICE,
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .pre_load = s390_pci_device_pre_load,
> +    .post_load = s390_pci_device_post_load,
> +    .fields = (const VMStateField[]) {
> +        VMSTATE_UINT32(state, S390PCIBusDevice),
> +        VMSTATE_UINT16(uid, S390PCIBusDevice),
> +        VMSTATE_UINT32(idx, S390PCIBusDevice),
> +        VMSTATE_UINT32(fh, S390PCIBusDevice),
> +        VMSTATE_UINT32(fid, S390PCIBusDevice),
> +        VMSTATE_BOOL(fid_defined, S390PCIBusDevice),
> +        VMSTATE_UINT64(fmb_addr, S390PCIBusDevice),
> +        VMSTATE_UINT32(fmb.format, S390PCIBusDevice),
> +        VMSTATE_UINT32(fmb.sample, S390PCIBusDevice),
> +        VMSTATE_UINT64(fmb.last_update, S390PCIBusDevice),
> +        VMSTATE_UINT64_ARRAY(fmb.counter, S390PCIBusDevice,
> +                ARRAY_SIZE(((S390PCIBusDevice *)0)->fmb.counter)),
> +        VMSTATE_UINT64(fmb.fmt0.dma_rbytes, S390PCIBusDevice),
> +        VMSTATE_UINT64(fmb.fmt0.dma_wbytes, S390PCIBusDevice),
> +        VMSTATE_UINT8(isc, S390PCIBusDevice),
> +        VMSTATE_UINT16(noi, S390PCIBusDevice),
> +        VMSTATE_UINT8(sum, S390PCIBusDevice),
> +        VMSTATE_UINT8(pft, S390PCIBusDevice),
> +        VMSTATE_UINT64(routes.adapter.ind_addr, S390PCIBusDevice),
> +        VMSTATE_UINT64(routes.adapter.summary_addr, S390PCIBusDevice),
> +        VMSTATE_UINT64(routes.adapter.ind_offset, S390PCIBusDevice),
> +        VMSTATE_UINT32(routes.adapter.summary_offset, S390PCIBusDevice),
> +        VMSTATE_UINT32(routes.adapter.adapter_id, S390PCIBusDevice),
> +        VMSTATE_BOOL(iommu_enabled, S390PCIBusDevice),
> +        VMSTATE_UINT64(g_iota, S390PCIBusDevice),
> +        VMSTATE_UINT64(pba, S390PCIBusDevice),
> +        VMSTATE_UINT64(pal, S390PCIBusDevice),
> +        VMSTATE_UINT64(max_dma_limit, S390PCIBusDevice),
> +        VMSTATE_PTR_TO_IND_ADDR(summary_ind, S390PCIBusDevice),
> +        VMSTATE_PTR_TO_IND_ADDR(indicator, S390PCIBusDevice),
> +        VMSTATE_BOOL(pci_unplug_request_processed, S390PCIBusDevice),
> +        VMSTATE_BOOL(unplug_requested, S390PCIBusDevice),
> +        VMSTATE_BOOL(interp, S390PCIBusDevice),
> +        VMSTATE_BOOL(forwarding_assist, S390PCIBusDevice),
> +        VMSTATE_BOOL(aif, S390PCIBusDevice),
> +        VMSTATE_BOOL(rtr_avail, S390PCIBusDevice),
> +        VMSTATE_END_OF_LIST()
> +    }
>   };
>   
>   static void s390_pci_device_class_init(ObjectClass *klass, const void *data)
> diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
> index f93db10c81..6b0742d143 100644
> --- a/hw/s390x/s390-pci-inst.c
> +++ b/hw/s390x/s390-pci-inst.c
> @@ -1122,7 +1122,7 @@ static int fmb_do_update(S390PCIBusDevice *pbdev, int offset, uint64_t val,
>       return ret;
>   }
>   
> -static void fmb_update(void *opaque)
> +void fmb_update(void *opaque)
>   {
>       S390PCIBusDevice *pbdev = opaque;
>       int64_t t = qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL);
> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> index 25a9fa4955..d8975da4f1 100644
> --- a/hw/s390x/s390-virtio-ccw.c
> +++ b/hw/s390x/s390-virtio-ccw.c
> @@ -931,6 +931,10 @@ static void ccw_machine_11_1_instance_options(MachineState *machine)
>   
>   static void ccw_machine_11_1_class_options(MachineClass *mc)
>   {
> +    static GlobalProperty compat[] = {
> +        { TYPE_S390_PCI_HOST_BRIDGE, "x-zpci-emul-dev-migr-enabled", "off" },
> +    };
> +    compat_props_add(mc->compat_props, compat, G_N_ELEMENTS(compat));
>   }
>   DEFINE_CCW_MACHINE_AS_LATEST(11, 1);
>   
> diff --git a/include/hw/s390x/s390-pci-bus.h b/include/hw/s390x/s390-pci-bus.h
> index 17ecf3e0da..7386404ecc 100644
> --- a/include/hw/s390x/s390-pci-bus.h
> +++ b/include/hw/s390x/s390-pci-bus.h
> @@ -340,6 +340,7 @@ struct S390PCIBusDevice {
>       uint16_t uid;
>       uint32_t idx;
>       uint32_t fh;
> +    Error *passthrough_migr_blocker;
>       uint32_t fid;
>       bool fid_defined;
>       uint64_t fmb_addr;
> @@ -393,6 +394,8 @@ struct S390pciState {
>       QTAILQ_HEAD(, S390PCIDMACount) zpci_dma_limit;
>       QTAILQ_HEAD(, S390PCIGroup) zpci_groups;
>       uint8_t next_sim_grp;
> +    bool emul_dev_migr_enabled;
> +    Error *emul_dev_migr_blocker;

Nit: Maybe this should be renamed as emul_dev_migr_error?


>   };
>   
>   S390pciState *s390_get_phb(void);
> @@ -418,5 +421,6 @@ S390PCIBusDevice *s390_pci_find_dev_by_pci(S390pciState *s,
>   S390PCIBusDevice *s390_pci_find_next_avail_dev(S390pciState *s,
>                                                  S390PCIBusDevice *pbdev);
>   void s390_pci_ism_reset(void);
> +void fmb_update(void *opaque);
>   
>   #endif

