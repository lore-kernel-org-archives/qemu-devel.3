Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E11DEC0218A
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2025 16:36:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcS4i-00059L-9Z; Mon, 27 Jan 2025 11:35:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <schnelle@linux.ibm.com>)
 id 1tcS4M-00058A-68; Mon, 27 Jan 2025 11:34:38 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <schnelle@linux.ibm.com>)
 id 1tcS4H-0005EY-Sb; Mon, 27 Jan 2025 11:34:37 -0500
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50RFvMVY005610;
 Mon, 27 Jan 2025 16:34:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=wtLkVy
 l/ViJWEkrSaQMSN5W2Go6jHzrvJfgETe2ljIQ=; b=FnKpIErqpAOTD3cHSANZn0
 70UHpuYABHV0H4kLBVoGmywVDyu7qsPv/mpQE40oW+u6ebxdW9klvI7qGAYGxGaV
 B6EXMKzm5KMNNeFW+XuwW5mqvhSZ0Rt/ZEn/fKyLDy4OCyziKF2ns0Stst3Kx61h
 2iVsfkIeaRwjQc3DhEmsDt0UkkT741LneJfo5mndxpZ2fGhRWBKVihJYRY2r8AFG
 kXOfHYWmWrQx3cg8VGI4K6wWcNzbKmXoCHUcWraJvVUPFQMBzSHZs4Q2H02mOtsJ
 6bveeqqnNh0EUXr5gYKv+dMGDuYRx2ljFYRwGuB+jarCu7+p6fxo2Unpym7KhlDQ
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44e5unag5a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 27 Jan 2025 16:34:29 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50RFtoBU003948;
 Mon, 27 Jan 2025 16:34:29 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 44da9s79v9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 27 Jan 2025 16:34:29 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 50RGYRGM17432920
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 27 Jan 2025 16:34:27 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 85FA85805E;
 Mon, 27 Jan 2025 16:34:27 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4C44458050;
 Mon, 27 Jan 2025 16:34:25 +0000 (GMT)
Received: from [9.171.60.50] (unknown [9.171.60.50])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 27 Jan 2025 16:34:25 +0000 (GMT)
Message-ID: <c965e6300a0f93f764fbb69a52e8ee0d8414d5aa.camel@linux.ibm.com>
Subject: Re: [PATCH v3 1/2] s390x/pci: add support for guests that request
 direct mapping
From: Niklas Schnelle <schnelle@linux.ibm.com>
To: Matthew Rosato <mjrosato@linux.ibm.com>, qemu-s390x@nongnu.org
Cc: farman@linux.ibm.com, thuth@redhat.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, richard.henderson@linaro.org,
 david@redhat.com, iii@linux.ibm.com, clegoate@redhat.com,
 qemu-devel@nongnu.org
Date: Mon, 27 Jan 2025 17:34:24 +0100
In-Reply-To: <20250124202115.349386-2-mjrosato@linux.ibm.com>
References: <20250124202115.349386-1-mjrosato@linux.ibm.com>
 <20250124202115.349386-2-mjrosato@linux.ibm.com>
Autocrypt: addr=schnelle@linux.ibm.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: BfZAr4YP_kiROIG5e3dQYILpoHlpZRZQ
X-Proofpoint-ORIG-GUID: BfZAr4YP_kiROIG5e3dQYILpoHlpZRZQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-27_08,2025-01-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 adultscore=0 mlxscore=0 spamscore=0
 clxscore=1011 mlxlogscore=999 bulkscore=0 phishscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501270131
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=schnelle@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Fri, 2025-01-24 at 15:21 -0500, Matthew Rosato wrote:
> When receiving a guest mpcifc(4) or mpcifc(6) instruction without the T
> bit set, treat this as a request to perform direct mapping instead of
> address translation.  In order to facilitate this, pin the entirety of
> guest memory into the host iommu.
>=20
> Pinning for the direct mapping case is handled via vfio and its memory
> listener.  Additionally, ram discard settings are inherited from vfio:
> coordinated discards (e.g. virtio-mem) are allowed while uncoordinated
> discards (e.g. virtio-balloon) are disabled.
>=20
> Subsequent guest DMA operations are all expected to be of the format
> guest_phys+sdma, allowing them to be used as lookup into the host
> iommu table.
>=20
> Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
> ---
>  hw/s390x/s390-pci-bus.c         | 36 +++++++++++++++++++++++++++++++--
>  hw/s390x/s390-pci-inst.c        | 13 ++++++++++--
>  hw/s390x/s390-pci-vfio.c        | 15 ++++++++++----
>  hw/s390x/s390-virtio-ccw.c      |  5 +++++
>  include/hw/s390x/s390-pci-bus.h |  4 ++++
>  5 files changed, 65 insertions(+), 8 deletions(-)
>=20
> diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
> index eead269cc2..8cf5aec1a2 100644
> --- a/hw/s390x/s390-pci-bus.c
> +++ b/hw/s390x/s390-pci-bus.c
> @@ -18,6 +18,8 @@
>  #include "hw/s390x/s390-pci-inst.h"
>  #include "hw/s390x/s390-pci-kvm.h"
>  #include "hw/s390x/s390-pci-vfio.h"
> +#include "hw/s390x/s390-virtio-ccw.h"
> +#include "hw/boards.h"
>  #include "hw/pci/pci_bus.h"
>  #include "hw/qdev-properties.h"
>  #include "hw/pci/pci_bridge.h"
> @@ -720,16 +722,44 @@ void s390_pci_iommu_enable(S390PCIIOMMU *iommu)
>                               TYPE_S390_IOMMU_MEMORY_REGION, OBJECT(&iomm=
u->mr),
>                               name, iommu->pal + 1);
>      iommu->enabled =3D true;
> +    iommu->direct_map =3D false;
>      memory_region_add_subregion(&iommu->mr, 0, MEMORY_REGION(&iommu->iom=
mu_mr));
>      g_free(name);
>  }
> =20
> +void s390_pci_iommu_dm_enable(S390PCIIOMMU *iommu)
> +{
> +    MachineState *ms =3D MACHINE(qdev_get_machine());
> +    S390CcwMachineState *s390ms =3D S390_CCW_MACHINE(ms);
> +
> +    /*
> +     * For direct-mapping we must map the entire guest address space.  R=
ather
> +     * than using an iommu, create a memory region alias that maps GPA X=
 to
> +     * iova X + SDMA.  VFIO will handle pinning via its memory listener.

Nit: I'd capitalize IOVA to match GPA.

> +     */
> +    g_autofree char *name =3D g_strdup_printf("iommu-dm-s390-%04x",
> +                                            iommu->pbdev->uid);
> +    memory_region_init_alias(&iommu->dm_mr, OBJECT(&iommu->mr), name, ms=
->ram,
> +                             0, s390_get_memory_limit(s390ms));
> +    iommu->enabled =3D true;
> +    iommu->direct_map =3D true;
> +    memory_region_add_subregion(&iommu->mr, iommu->pbdev->zpci_fn.sdma,
> +                                &iommu->dm_mr);
> +}
> +
>  void s390_pci_iommu_disable(S390PCIIOMMU *iommu)
>  {
>      iommu->enabled =3D false;
>      g_hash_table_remove_all(iommu->iotlb);
> -    memory_region_del_subregion(&iommu->mr, MEMORY_REGION(&iommu->iommu_=
mr));
> -    object_unparent(OBJECT(&iommu->iommu_mr));
> +    if (iommu->direct_map) {
> +        memory_region_del_subregion(&iommu->mr, &iommu->dm_mr);
> +        iommu->direct_map =3D false;
> +        object_unparent(OBJECT(&iommu->dm_mr));
> +    } else {
> +        memory_region_del_subregion(&iommu->mr,
> +                                    MEMORY_REGION(&iommu->iommu_mr));
> +        object_unparent(OBJECT(&iommu->iommu_mr));
> +    }
>  }
> =20
>  static void s390_pci_iommu_free(S390pciState *s, PCIBus *bus, int32_t de=
vfn)
> @@ -1488,6 +1518,8 @@ static const Property s390_pci_device_properties[] =
=3D {
>      DEFINE_PROP_BOOL("interpret", S390PCIBusDevice, interp, true),
>      DEFINE_PROP_BOOL("forwarding-assist", S390PCIBusDevice, forwarding_a=
ssist,
>                       true),
> +    DEFINE_PROP_BOOL("relaxed-translation", S390PCIBusDevice, rtr_allowe=
d,
> +                     true),

Question: Do we maybe want to default rtr_allowed to false for ISM
devices? Performance wise it doesn't matter much since they keep their
mappings fairly static and it would help us catch bugs in the handling
of rtr_allowed =3D=3D false devices, the ISM driver and increase security.

>  };
> =20
>  static const VMStateDescription s390_pci_device_vmstate =3D {
> diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
> index e386d75d58..4c108fa8c4 100644
> --- a/hw/s390x/s390-pci-inst.c
> +++ b/hw/s390x/s390-pci-inst.c
> @@ -16,6 +16,7 @@
>  #include "exec/memory.h"
>  #include "qemu/error-report.h"
>  #include "system/hw_accel.h"
> +#include "hw/boards.h"
>  #include "hw/pci/pci_device.h"
>  #include "hw/s390x/s390-pci-inst.h"
>  #include "hw/s390x/s390-pci-bus.h"
> @@ -1008,17 +1009,25 @@ static int reg_ioat(CPUS390XState *env, S390PCIBu=
sDevice *pbdev, ZpciFib fib,
>      }
> =20
>      /* currently we only support designation type 1 with translation */
> -    if (!(dt =3D=3D ZPCI_IOTA_RTTO && t)) {
> +    if (t && !(dt =3D=3D ZPCI_IOTA_RTTO)) {

What Thomas said ;-)

>          error_report("unsupported ioat dt %d t %d", dt, t);
>          s390_program_interrupt(env, PGM_OPERAND, ra);
>          return -EINVAL;
> +    } else if (!t && !pbdev->rtr_allowed) {
> +        error_report("relaxed translation not allowed");
> +        s390_program_interrupt(env, PGM_OPERAND, ra);
> +        return -EINVAL;
>      }
> =20
>      iommu->pba =3D pba;
>      iommu->pal =3D pal;
>      iommu->g_iota =3D g_iota;
> =20
> -    s390_pci_iommu_enable(iommu);
> +    if (t) {
> +        s390_pci_iommu_enable(iommu);
> +    } else {
> +        s390_pci_iommu_dm_enable(iommu);
> +    }
> =20
>      return 0;
>  }
> diff --git a/hw/s390x/s390-pci-vfio.c b/hw/s390x/s390-pci-vfio.c
> index 7dbbc76823..dad525c81c 100644
> --- a/hw/s390x/s390-pci-vfio.c
> +++ b/hw/s390x/s390-pci-vfio.c
> @@ -133,11 +133,18 @@ static void s390_pci_read_base(S390PCIBusDevice *pb=
dev,
> =20
>      /*
>       * If appropriate, reduce the size of the supported DMA aperture rep=
orted
> -     * to the guest based upon the vfio DMA limit.
> +     * to the guest based upon the vfio DMA limit.  This is applicable f=
or
> +     * devices that are guaranteed to not use relaxed translation.  If t=
he
> +     * device is capable of relaxed translation then we must advertise t=
he
> +     * full aperture.  In this case, if translation is used then we will
> +     * rely on the vfio DMA limit counting and use RPCIT CC1 / status 16
> +     * to request the guest free DMA mappings when necessary.

Not a native speaker but I think there is a "to" missing in the last
sentence and I'd have used "as necessary".

>       */
> -    vfio_size =3D pbdev->iommu->max_dma_limit << TARGET_PAGE_BITS;
> -    if (vfio_size > 0 && vfio_size < cap->end_dma - cap->start_dma + 1) =
{
> -        pbdev->zpci_fn.edma =3D cap->start_dma + vfio_size - 1;
> +    if (!pbdev->rtr_allowed) {
> +        vfio_size =3D pbdev->iommu->max_dma_limit << TARGET_PAGE_BITS;
> +        if (vfio_size > 0 && vfio_size < cap->end_dma - cap->start_dma +=
 1) {
> +            pbdev->zpci_fn.edma =3D cap->start_dma + vfio_size - 1;
> +        }
>      }
>  }
> =20
> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> index 3af613d4e9..c96cd0d4bb 100644
> --- a/hw/s390x/s390-virtio-ccw.c
> +++ b/hw/s390x/s390-virtio-ccw.c
> @@ -907,8 +907,13 @@ static void ccw_machine_9_2_instance_options(Machine=
State *machine)
> =20
>  static void ccw_machine_9_2_class_options(MachineClass *mc)
>  {
> +    static GlobalProperty compat[] =3D {
> +        { TYPE_S390_PCI_DEVICE, "relaxed-translation", "off", },
> +    };
> +
>      ccw_machine_10_0_class_options(mc);
>      compat_props_add(mc->compat_props, hw_compat_9_2, hw_compat_9_2_len)=
;
> +    compat_props_add(mc->compat_props, compat, G_N_ELEMENTS(compat));
>  }
>  DEFINE_CCW_MACHINE(9, 2);
> =20
> diff --git a/include/hw/s390x/s390-pci-bus.h b/include/hw/s390x/s390-pci-=
bus.h
> index 2c43ea123f..27732247cf 100644
> --- a/include/hw/s390x/s390-pci-bus.h
> +++ b/include/hw/s390x/s390-pci-bus.h
> @@ -277,7 +277,9 @@ struct S390PCIIOMMU {
>      AddressSpace as;
>      MemoryRegion mr;
>      IOMMUMemoryRegion iommu_mr;
> +    MemoryRegion dm_mr;
>      bool enabled;
> +    bool direct_map;
>      uint64_t g_iota;
>      uint64_t pba;
>      uint64_t pal;
> @@ -362,6 +364,7 @@ struct S390PCIBusDevice {
>      bool interp;
>      bool forwarding_assist;
>      bool aif;
> +    bool rtr_allowed;

Nit: In the kernel in struct zpci_dev you used rtr_avail but "allowed"
in the comment, just for gerppability I'd prefer the names to match.

>      QTAILQ_ENTRY(S390PCIBusDevice) link;
>  };
> =20
> @@ -389,6 +392,7 @@ int pci_chsc_sei_nt2_have_event(void);
>  void s390_pci_sclp_configure(SCCB *sccb);
>  void s390_pci_sclp_deconfigure(SCCB *sccb);
>  void s390_pci_iommu_enable(S390PCIIOMMU *iommu);
> +void s390_pci_iommu_dm_enable(S390PCIIOMMU *iommu);

Nit: I find "_dm_" a bit hard to map to "direct map". If you want two
letters I'd go for "_pt_" for "_iommu_pass_through_" or maybe
"_direct_map_".

>  void s390_pci_iommu_disable(S390PCIIOMMU *iommu);
>  void s390_pci_generate_error_event(uint16_t pec, uint32_t fh, uint32_t f=
id,
>                                     uint64_t faddr, uint32_t e);


