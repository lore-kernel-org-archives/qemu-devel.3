Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2634CCA476
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 08:55:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v78sq-0007lp-Fe; Fri, 10 Oct 2025 04:53:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_mburton@quicinc.com>)
 id 1v78sk-0007la-62
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 04:53:47 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_mburton@quicinc.com>)
 id 1v78sZ-0003Wi-FZ
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 04:53:44 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59A6XSGi002623;
 Fri, 10 Oct 2025 08:53:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 NR6MzFR9Oqdjhh/ozqZ5iwCwzhoHfTocoLQPXNlazrM=; b=Y2ZY0rhgly3yWweq
 q793BWBUWPAGJFy1+IwDDcfXnowYs8gDO3ojNbYRAbCVYUJBPIoowhv5oPQ9Xvp/
 yyHACrfVweynC9EA31FTiAAlzswaH/ei6G721h9bKxAFPQVngBZA6wS7reH+XE2z
 3b9TS3/h/ahsj65uG8vRBzj6EhlrdvfVx/cKJYwmtZKIP81k8RgpwZt7ke1rlsrO
 ll8WzGrEssnXNF/f12R0nMcW7TWROIcMU+aEC88XtSOBOK3rK5RMapeKv1IpIi1q
 CNukEv2L5bYh5Mv1KIleFyVdmVZA31pQKyUcybD2t/Axf9Ae5J1ueUWKYQpvG3Ek
 7TFPDg==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49nv4u5qrk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 10 Oct 2025 08:53:17 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com
 [10.46.141.250])
 by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 59A8rG1u010680
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 10 Oct 2025 08:53:16 GMT
Received: from smtpclient.apple (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.24; Fri, 10 Oct
 2025 01:53:13 -0700
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: MMIO through IOMMU from a TCG processor
From: Mark Burton <quic_mburton@quicinc.com>
In-Reply-To: <0138de27-04af-4ec6-83bd-db917f867aa5@linaro.org>
Date: Fri, 10 Oct 2025 10:53:00 +0200
CC: Mark Cave-Ayland <mark.caveayland@nutanix.com>, QEMU Developers
 <qemu-devel@nongnu.org>, <peterx@redhat.com>,
 <eric.auger@redhat.com>, <zhenzhong.duan@intel.com>,
 <alejandro.j.jimenez@oracle.com>, <peter.maydell@linaro.org>,
 <jasowang@redhat.com>, <pbonzini@redhat.com>, <tjeznach@rivosinc.com>,
 <steven.sistare@oracle.com>, <clement.mathieu--drif@eviden.com>,
 <joao.m.martins@oracle.com>, <ean-philippe@linaro.org>,
 <jean-philippe@linaro.org>, <sarunkod@amd.com>,
 =?utf-8?Q?Phil_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Content-Transfer-Encoding: quoted-printable
Message-ID: <BEC4381C-416E-4B0C-BD5F-62631B6E3B58@quicinc.com>
References: <1C343F6E-05E2-4EA0-A338-0C48A97FF263@quicinc.com>
 <db2ca904-5d1c-4c96-8950-d3d943940d64@nutanix.com>
 <D7DA7B85-2439-4CC2-A852-604154ABDC99@quicinc.com>
 <0138de27-04af-4ec6-83bd-db917f867aa5@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
X-Mailer: Apple Mail (2.3826.700.81)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Authority-Analysis: v=2.4 cv=Vrcuwu2n c=1 sm=1 tr=0 ts=68e8c97d cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=p0WdMEafAAAA:8
 a=NEAV23lmAAAA:8 a=KKAkSRfTAAAA:8 a=COk6AnOGAAAA:8 a=64Cc0HZtAAAA:8
 a=Q27kJiE5y1NktgXucs4A:9 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
 a=TjNXssC_j7lpFel5tvFf:22 a=poXaRoVlC6wW9_mwW8W4:22 a=cPQSjfK2_nFv0Q5t_7PE:22
 a=Z5ABNNGmrOfJ6cZ5bIyy:22 a=jd6J4Gguk5HxikPWLKER:22
X-Proofpoint-GUID: SdVs-WPDi9sXcmZMQ4oYseGMSOt1mWrU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfX2hcu/qHXro41
 7ywh5oQfPVwYh3hRS45ntvx1mOddvAVkX1ZkogvKfKBcmaJA8rGcCxD2/2zo+kAATwcdEYoe8k4
 /Ccx9jXzJBUQvDQTKHcWX7lF0KtUXf4h213yEydHLlBwhZasjqJ7Dow34xOEvTjuEZMnv7MgQzR
 6IKBkG435GBleUjhplLIjfTChDWP3YnnEdzAWCjSe7pq6yDrmg1OSo4iXqCm9WJ634NIMaR9RU/
 2Op3GHQYMsGdjrino2R5F/kcWwDSXYJlbbClmJfEbLFil+9nDzw53M6Qv+B5+t7V0mpZHJYCZDu
 r2B2r5HKUthrneV0CHuVQ0InoFl3SZjZlUMkO1nqIQO/RinfKD6Dq9WmZIVD4J+gixB1kTCQr3/
 YEB55vQ/qhZYA/VN9Ecd4ByBdGr7Eg==
X-Proofpoint-ORIG-GUID: SdVs-WPDi9sXcmZMQ4oYseGMSOt1mWrU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-10_01,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 impostorscore=0 clxscore=1015 adultscore=0
 bulkscore=0 spamscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510080121
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=quic_mburton@quicinc.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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



> On 9 Oct 2025, at 20:07, Pierrick Bouvier =
<pierrick.bouvier@linaro.org> wrote:
>=20
> Hi Mark,
>=20
> "recorded section therefore seems to be incorrect".
> do you observe a crash, or on assert failing at execution?

I guess it would depend on the exact simulation, in my case I get a =
random memory region, instead of the device I=E2=80=99m looking for.


I no longer believe this is a race condition - to be clear on my setup =
(which I think is about to become more common, hence it=E2=80=99s worth =
fixing)

I have

CPU =E2=80=94>=E2=80=9DSMMU=E2=80=9D=E2=80=94> MMIO

This is modelled as

CPU-> cpuas   -> MR Memory (1)
-> IOMMU MR (2)  =E2=80=94> IO Address space =E2=80=94> MMIO Device MR =
(1)

What happens is that we =E2=80=9Cprepare the IO=E2=80=9D, and the =
translation in the IOMMU returns the IO address space, and we then =
(correctly IMHO) calculate the correct MR from that address space =
(I=E2=80=99ve labeled that (1))
However, when the CPU finally does the actual access, using the fully =
populated TLB entry, we now use the CPU=E2=80=99s address space. MR (1) =
now relates to some random memory.

(BTW, not that if the Device was actually memory, we would then pick up =
the memory ptr, and all (I think) would work correctly).

I believe the solution is to carry the address space (pointer) in the =
Full TLB entry. I have a patch for this which seems to fix the issue, =
and allows MMIO to be accessed through IOMMU, but it=E2=80=99s a bit =
messy and currently based on an old 9. I=E2=80=99ll try and modernise =
it, but it might take a little while. Meanwhile, the general jist of it =
is below, but this won=E2=80=99t apply to upstream cleanly (and I=E2=80=99=
ve taken the liberty to add some of your patch here too, but - as I say =
- I am working on a stale branch)

Cheers
Mark.

Signed-off-by: Mark Burton <mburton@quicinc.com>
---
accel/tcg/cputlb.c | 21 +++++++++++++--------
include/exec/exec-all.h | 7 ++++---
system/physmem.c | 27 +++++++++++----------------
3 files changed, 28 insertions(+), 27 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 5138d6c1e0..7018665465 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1087,7 +1087,8 @@ void tlb_set_page_full(CPUState *cpu, int mmu_idx,
prot =3D full->prot;
asidx =3D cpu_asidx_from_attrs(cpu, full->attrs);
section =3D address_space_translate_for_iotlb(cpu, asidx, paddr_page,
- &xlat, &sz, full->attrs, &prot);
+ &xlat, &sz, &full->attrs,
+ &full->as, &prot);
assert(sz >=3D TARGET_PAGE_SIZE);
tlb_debug("vaddr=3D%016" VADDR_PRIx " paddr=3D0x" HWADDR_FMT_plx
@@ -1272,13 +1273,13 @@ static inline void cpu_unaligned_access(CPUState =
*cpu, vaddr addr,
}
static MemoryRegionSection *
-io_prepare(hwaddr *out_offset, CPUState *cpu, hwaddr xlat,
+io_prepare(hwaddr *out_offset, CPUState *cpu, AddressSpace *as, hwaddr =
xlat,
MemTxAttrs attrs, vaddr addr, uintptr_t retaddr)
{
MemoryRegionSection *section;
hwaddr mr_offset;
- section =3D iotlb_to_section(cpu, xlat, attrs);
+ section =3D iotlb_to_section(as, xlat, attrs);
mr_offset =3D (xlat & TARGET_PAGE_MASK) + addr;
cpu->mem_io_pc =3D retaddr;
if (!cpu->neg.can_do_io) {
@@ -1596,7 +1597,7 @@ bool tlb_plugin_lookup(CPUState *cpu, vaddr addr, =
int mmu_idx,
/* We must have an iotlb entry for MMIO */
if (tlb_addr & TLB_MMIO) {
MemoryRegionSection *section =3D
- iotlb_to_section(cpu, full->xlat_section & ~TARGET_PAGE_MASK,
+ iotlb_to_section(full->as, full->xlat_section & ~TARGET_PAGE_MASK,
full->attrs);
data->is_io =3D true;
data->mr =3D section->mr;
@@ -2008,7 +2009,8 @@ static uint64_t do_ld_mmio_beN(CPUState *cpu, =
CPUTLBEntryFull *full,
tcg_debug_assert(size > 0 && size <=3D 8);
attrs =3D full->attrs;
- section =3D io_prepare(&mr_offset, cpu, full->xlat_section, attrs, =
addr, ra);
+ section =3D io_prepare(&mr_offset, cpu, full->as,
+ full->xlat_section, attrs, addr, ra);
mr =3D section->mr;
BQL_LOCK_GUARD();
@@ -2029,7 +2031,8 @@ static Int128 do_ld16_mmio_beN(CPUState *cpu, =
CPUTLBEntryFull *full,
tcg_debug_assert(size > 8 && size <=3D 16);
attrs =3D full->attrs;
- section =3D io_prepare(&mr_offset, cpu, full->xlat_section, attrs, =
addr, ra);
+ section =3D io_prepare(&mr_offset, cpu, full->as,
+ full->xlat_section, attrs, addr, ra);
mr =3D section->mr;
BQL_LOCK_GUARD();
@@ -2573,7 +2576,8 @@ static uint64_t do_st_mmio_leN(CPUState *cpu, =
CPUTLBEntryFull *full,
tcg_debug_assert(size > 0 && size <=3D 8);
attrs =3D full->attrs;
- section =3D io_prepare(&mr_offset, cpu, full->xlat_section, attrs, =
addr, ra);
+ section =3D io_prepare(&mr_offset, cpu, full->as,
+ full->xlat_section, attrs, addr, ra);
mr =3D section->mr;
BQL_LOCK_GUARD();
@@ -2593,7 +2597,8 @@ static uint64_t do_st16_mmio_leN(CPUState *cpu, =
CPUTLBEntryFull *full,
tcg_debug_assert(size > 8 && size <=3D 16);
attrs =3D full->attrs;
- section =3D io_prepare(&mr_offset, cpu, full->xlat_section, attrs, =
addr, ra);
+ section =3D io_prepare(&mr_offset, cpu, full->as,
+ full->xlat_section, attrs, addr, ra);
mr =3D section->mr;
BQL_LOCK_GUARD();
diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index 72240ef426..305323caff 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -475,14 +475,14 @@ extern __thread uintptr_t tci_tb_ptr;
/**
* iotlb_to_section:
- * @cpu: CPU performing the access
+ * @as: Address space to access
* @index: TCG CPU IOTLB entry
*
* Given a TCG CPU IOTLB entry, return the MemoryRegionSection that
* it refers to. @index will have been initially created and returned
* by memory_region_section_get_iotlb().
*/
-struct MemoryRegionSection *iotlb_to_section(CPUState *cpu,
+struct MemoryRegionSection *iotlb_to_section(AddressSpace *as,
hwaddr index, MemTxAttrs attrs);
#endif
@@ -596,7 +596,8 @@ void tlb_reset_dirty_range_all(ram_addr_t start, =
ram_addr_t length);
MemoryRegionSection *
address_space_translate_for_iotlb(CPUState *cpu, int asidx, hwaddr addr,
hwaddr *xlat, hwaddr *plen,
- MemTxAttrs attrs, int *prot);
+ MemTxAttrs *attrs, AddressSpace **,
+ int *prot);
hwaddr memory_region_section_get_iotlb(CPUState *cpu,
MemoryRegionSection *section);
#endif
diff --git a/system/physmem.c b/system/physmem.c
index 8fbb8407de..8aec2f2131 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -164,7 +164,6 @@ static void tcg_commit(MemoryListener *listener);
typedef struct CPUAddressSpace {
CPUState *cpu;
AddressSpace *as;
- struct AddressSpaceDispatch *memory_dispatch;
MemoryListener tcg_as_listener;
} CPUAddressSpace;
@@ -679,7 +678,8 @@ void tcg_iommu_init_notifier_list(CPUState *cpu)
MemoryRegionSection *
address_space_translate_for_iotlb(CPUState *cpu, int asidx, hwaddr =
orig_addr,
hwaddr *xlat, hwaddr *plen,
- MemTxAttrs attrs, int *prot)
+ MemTxAttrs *attrs, AddressSpace **as,
+ int *prot)
{
MemoryRegionSection *section;
IOMMUMemoryRegion *iommu_mr;
@@ -687,7 +687,8 @@ address_space_translate_for_iotlb(CPUState *cpu, int =
asidx, hwaddr orig_addr,
IOMMUTLBEntry iotlb;
int iommu_idx;
hwaddr addr =3D orig_addr;
- AddressSpaceDispatch *d =3D cpu->cpu_ases[asidx].memory_dispatch;
+ *as =3D cpu->cpu_ases[asidx].as;
+ AddressSpaceDispatch *d =3D address_space_to_dispatch(*as);
for (;;) {
section =3D address_space_translate_internal(d, addr, &addr, plen, =
false);
@@ -699,13 +700,13 @@ address_space_translate_for_iotlb(CPUState *cpu, =
int asidx, hwaddr orig_addr,
imrc =3D memory_region_get_iommu_class_nocheck(iommu_mr);
- iommu_idx =3D imrc->attrs_to_index(iommu_mr, attrs);
+ iommu_idx =3D imrc->attrs_to_index(iommu_mr, *attrs);
tcg_register_iommu_notifier(cpu, iommu_mr, iommu_idx);
/* We need all the permissions, so pass IOMMU_NONE so the IOMMU
* doesn't short-cut its translation table walk.
*/
if (imrc->translate_attr) {
- iotlb =3D imrc->translate_attr(iommu_mr, addr, IOMMU_NONE, &attrs);
+ iotlb =3D imrc->translate_attr(iommu_mr, addr, IOMMU_NONE, attrs);
} else {
iotlb =3D imrc->translate(iommu_mr, addr, IOMMU_NONE, iommu_idx);
}
@@ -726,7 +727,8 @@ address_space_translate_for_iotlb(CPUState *cpu, int =
asidx, hwaddr orig_addr,
goto translate_fail;
}
- d =3D =
flatview_to_dispatch(address_space_to_flatview(iotlb.target_as));
+ *as =3D iotlb.target_as;
+ d =3D flatview_to_dispatch(address_space_to_flatview(*as));
}
assert(!memory_region_is_iommu(section->mr));
@@ -2529,12 +2531,11 @@ static uint16_t dummy_section(PhysPageMap *map, =
FlatView *fv, MemoryRegion *mr)
return phys_section_add(map, &section);
}
-MemoryRegionSection *iotlb_to_section(CPUState *cpu,
+MemoryRegionSection *iotlb_to_section(AddressSpace *as,
hwaddr index, MemTxAttrs attrs)
{
- int asidx =3D cpu_asidx_from_attrs(cpu, attrs);
- CPUAddressSpace *cpuas =3D &cpu->cpu_ases[asidx];
- AddressSpaceDispatch *d =3D cpuas->memory_dispatch;
+ assert(as);
+ AddressSpaceDispatch *d =3D address_space_to_dispatch(as);
int section_index =3D index & ~TARGET_PAGE_MASK;
MemoryRegionSection *ret;
@@ -2611,9 +2612,6 @@ static void =
tcg_log_global_after_sync(MemoryListener *listener)
static void tcg_commit_cpu(CPUState *cpu, run_on_cpu_data data)
{
- CPUAddressSpace *cpuas =3D data.host_ptr;
-
- cpuas->memory_dispatch =3D address_space_to_dispatch(cpuas->as);
tlb_flush(cpu);
}
@@ -2669,10 +2667,7 @@ static void tcg_commit(MemoryListener *listener)
* That said, the listener is also called during realize, before
* all of the tcg machinery for run-on is initialized: thus halt_cond.
*/
- AddressSpaceDispatch *d;
cpu_reloading_memory_map();
- d =3D address_space_to_dispatch(cpuas->as);
- qatomic_rcu_set(&cpuas->memory_dispatch, d);
tlb_flush(cpuas->cpu);
if (cpu->halt_cond) {
async_run_on_cpu(cpu, tcg_commit_cpu, RUN_ON_CPU_HOST_PTR(cpuas));
--=20
2.51.0





>=20
> I don't know in details the code you mention, but after investigating =
and fixing https://gitlab.com/qemu-project/qemu/-/issues/3040, I can =
share a few things.
>=20
> Overall, what you describe looks like a race condition exposing a =
lifetime issue, especially when saying "we 'loose' the address space =
that has been returned by the translate function".
> A value was not updated as expected and is out of sync, or was freed =
too early. Memory regions lifetime is something definitely tricky in =
QEMU, and when you mix that with RCU, things can become very obscure in =
multithreaded scenarios.
>=20
> In the bug above, the solution was to stop duplicating this =
information, and get it from the same source. The overhead to read such =
atomic data is quite small, thanks to use of RCU.
> At KVM Forum, Paolo told me he introduced this copy precisely to avoid =
issues, but the opposite happened in reality, which we both found was =
quite funny.
>=20
> Additional questions:
> - At which time of execution does it happen? Is it during pci devices =
initialization, or when remapping specific memory sections?
> - Is the bug deterministic or random? If random, does increasing the =
number of pci devices attached increase the probably to meet it?
>=20
> Additional tools:
> - If you observe a crash, build with asan. If you get a use-after-free =
error, it's probably an issue with RCU cleaning up things before you =
expect. This is what I had in the bug mentioned above.
> - If your assert fail, I can recommend you capture execution through =
rr (https://github.com/rr-debugger/rr), using chaos mode rr record =
--chaos, which will randomize scheduling of threads. I don't know if =
you're familiar with it, but it allows you to debug your execution =
"backward".
> Once you captured the faulty execution, you can reach the crash or =
faulty assert, then execute backward (reverse-continue) with a =
watchpoint set on the (correct) value that was updated meanwhile. This =
way, you'll find which sequence led to desynchronization, and then =
you'll have a good start to deduce what the root cause is.
> - Spend some time making the crash/assert almost deterministic, it =
will save you time later, especially when implementing a possible fix =
and prove it works.
>=20
> I hope it helps.
>=20
> Regards,
> Pierrick
>=20
> On 10/9/25 2:10 AM, Mark Burton wrote:
>> (Adding Pierrick)
>> Thanks for getting back to me Mark.
>> I initially thought the same, and I think I have seen that issue, I =
have also taken that patch, However =E2=80=A6..
>> For MMIO access, as best I can tell, the initial calculation of the =
despatch is based on the iotlb reported by the translate function =
(correct), while the subsequent use of the section number uses the =
dispatch table from the CPU=E2=80=99s address space=E2=80=A6.. which =
gives you the wrong section.
>> I would very happily do a live debug with you (or anybody) if it =
would help=E2=80=A6 I=E2=80=99m more than willing to believe I=E2=80=99ve =
made a mistake, but I just don=E2=80=99t see how it=E2=80=99s supposed =
to work.
>> I have been looking at solutions, and right now, I don=E2=80=99t see =
anything obvious. As best I can tell, we =E2=80=9Cloose=E2=80=9D the =
address space that has been returned by the translate function - so, =
either we would need a way to hold onto that, or, we would have to =
re-call the function, or=E2=80=A6.
>> All of those options look really really nasty to me.
>> The issue is going to be systems where SMMU=E2=80=99s are used all =
over the place, specifically, in front of MMIO. (Memory works OK because =
we get the memory pointer itself, all is fine, the issue seems only be =
with MMIO accesses through IOMMU regions).
>> Cheers
>> Mark.
>>> On 9 Oct 2025, at 10:43, Mark Cave-Ayland =
<mark.caveayland@nutanix.com> wrote:
>>>=20
>>> On 08/10/2025 13:38, Mark Burton wrote:
>>>=20
>>>> All, sorry for the wide CC, I=E2=80=99m trying to find somebody who =
understands this corder of the code=E2=80=A6. This is perhaps a obscure, =
but I think it should work.
>>>> I am trying to access an MMIO region through an IOMMU, from TCG.
>>>> The IOMMU translation has provided an address space that is =
different from the CPU=E2=80=99s own address space.
>>>> In address_space_translate_for_iotlb the section is calculated =
using the address space provide by the IOMMU translation.
>>>>> d =3D =
flatview_to_dispatch(address_space_to_flatview(iotlb.target_as));
>>>>>=20
>>>> Later, we come to do the actual access (via e.g. do_st_mmio_leN), =
and at this point we pick up the cpu=E2=80=99s address spaces in =
iotlb_to_section, which is different, and the recorded section therefore =
seems to be incorrect.
>>>>> CPUAddressSpace *cpuas =3D &cpu->cpu_ases[asidx];
>>>>> AddressSpaceDispatch *d =3D cpuas->memory_dispatch;
>>>>> int section_index =3D index & ~TARGET_PAGE_MASK;
>>>>> MemoryRegionSection *ret;
>>>>>=20
>>>>> assert(section_index < d->map.sections_nb);
>>>>> ret =3D d->map.sections + section_index;
>>>> What I don=E2=80=99t fully understand is how this is supposed to =
work=E2=80=A6.?
>>>> Have I missed something obvious?
>>>> Cheers
>>>> Mark.
>>>=20
>>> What version of QEMU are you using? I'm wondering if you're getting =
caught out by a variant of this: =
https://gitlab.com/qemu-project/qemu/-/issues/3040.
>>>=20
>>>=20
>>> ATB,
>>>=20
>>> Mark.
>>>=20
>=20


