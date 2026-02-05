Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1E71ECD9A6
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 21:24:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vo6pS-00024k-25; Thu, 05 Feb 2026 16:23:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1vo6pP-00020C-0o; Thu, 05 Feb 2026 16:23:55 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1vo6pM-0001kx-Kh; Thu, 05 Feb 2026 16:23:54 -0500
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 615IZ0oO011190;
 Thu, 5 Feb 2026 21:23:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=8/18Kq
 fyrDcf/SiqebtyqP7VL1SKETGpPa+aWFBaaio=; b=KqJcQ//Cp7Qv4faPJeiOuy
 YC36Sb8z2YJMZXiyBM9B2WXaJieimWxMf04WRdgYJQr7qVD7fVcgHTshRZnVepys
 euPnVMTgIBqBgT/8WkbVbjbKAljux2ZRMqcyZ36fFbQxJiww3SDc2W+1o264ahpK
 Q20Jnh+9L4OeUUk5C1G4XO19HtlZuNCSUpb0GK5/i+ih4ssWlHAeKSluGrW8uZXy
 ZzUm8Ynf4fxI98Ql7CRHVBXrCoZCeINQlM36yxFjXVprVUKF/6E67zK/09qN7Boi
 2KhRgfKoTfwXCebPw0ICa6M/HWSFAf2NtdbHXVVnJEKUrjiUKV9rAJKMWmcR7tcQ
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c19f6rwc2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 05 Feb 2026 21:23:43 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 615K0Lsc029047;
 Thu, 5 Feb 2026 21:23:42 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4c1v2skmwd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 05 Feb 2026 21:23:42 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 615LNeOI19071550
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 5 Feb 2026 21:23:41 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E42F35804E;
 Thu,  5 Feb 2026 21:23:40 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F0A975803F;
 Thu,  5 Feb 2026 21:23:37 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com (unknown
 [9.61.132.67]) by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  5 Feb 2026 21:23:37 +0000 (GMT)
Message-ID: <2827f8b28c4a654cb1b37eaf1313a1d63fb58f05.camel@linux.ibm.com>
Subject: Re: [PATCH v2 3/9] target/s390x: Replace %target_ulong -> %vaddr
 where appropriate
From: Eric Farman <farman@linux.ibm.com>
To: Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>, Matthew Rosato	
 <mjrosato@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, David
 Hildenbrand	 <david@kernel.org>, Thomas Huth <thuth@redhat.com>,
 qemu-s390x@nongnu.org, Anton Johansson	 <anjo@rev.ng>, Richard Henderson
 <richard.henderson@linaro.org>, Christian Borntraeger
 <borntraeger@linux.ibm.com>, Ilya Leoshkevich <iii@linux.ibm.com>
Date: Thu, 05 Feb 2026 16:23:36 -0500
In-Reply-To: <20260204182722.44062-4-philmd@linaro.org>
References: <20260204182722.44062-1-philmd@linaro.org>
 <20260204182722.44062-4-philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Dyq_BTA1UDqH3xq5AjOZORklcXstyCP_
X-Authority-Analysis: v=2.4 cv=drTWylg4 c=1 sm=1 tr=0 ts=69850a5f cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KKAkSRfTAAAA:8 a=mCI5erPtfxGQ4REXV-wA:9 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: Dyq_BTA1UDqH3xq5AjOZORklcXstyCP_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA1MDE2MyBTYWx0ZWRfX2+aexFbocjoD
 ffOBEmEEOTZOxlmvczyF5dV3Ww9LEHDrhDAwVy2na5ACOoes4jNH9fhKIIjym/1bY/BOT1rxI8R
 mUVy4eVgufsnILixGhlwo+XvZzHtfI6zsWmCag7xGoMDE0Dgvh7nj3lTHRjWG71ZmlAJLqLpIP5
 6EZ2P29bUYI2vxVRfUPCfwfdTguaVT5I/eMZT/z0K2SBtGIWYBz5H24wY2D/hPHGHXckpm1lWIx
 gm/+jw/gfV1C3jDF+SBkW6ZJp4GO8Wvi5GYXVb9xh1EEEgH2Iup/rjjZsKBQmbhD7095JBZgH3O
 Kw4eU2RelCXy4/Cl0dNLC88jMZ0sOXMN8loQfSxT0jSiIHTFNpzy8gVFwfJiBWVhOS8omUrzwQR
 e1T2YIMvx8ThrcG3pg/1A2wOdCJ7u2Cu2ku0nr2AGzeYG98Fja1dr7qVzPx5UbzhUv4H+wehFtH
 2GZ5LQ8MtlUeXdt8Fqw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-05_05,2026-02-05_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 spamscore=0 malwarescore=0 bulkscore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2601150000
 definitions=main-2602050163
Received-SPF: pass client-ip=148.163.156.1; envelope-from=farman@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, 2026-02-04 at 19:27 +0100, Philippe Mathieu-Daud=C3=A9 wrote:
> Use the %vaddr type for virtual addresses.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  target/s390x/s390x-internal.h  | 5 +++--
>  target/s390x/helper.c          | 2 +-
>  target/s390x/mmu_helper.c      | 6 +++---
>  target/s390x/tcg/excp_helper.c | 3 ++-
>  4 files changed, 9 insertions(+), 7 deletions(-)
>=20
> diff --git a/target/s390x/s390x-internal.h b/target/s390x/s390x-internal.=
h
> index a4b54dc441c..f0f7bb5cb11 100644
> --- a/target/s390x/s390x-internal.h
> +++ b/target/s390x/s390x-internal.h
> @@ -10,6 +10,7 @@
>  #ifndef S390X_INTERNAL_H
>  #define S390X_INTERNAL_H
> =20
> +#include "exec/vaddr.h"
>  #include "cpu.h"
>  #include "fpu/softfloat.h"
> =20
> @@ -376,9 +377,9 @@ void probe_write_access(CPUS390XState *env, uint64_t =
addr, uint64_t len,
>  bool mmu_absolute_addr_valid(target_ulong addr, bool is_write);
>  /* Special access mode only valid for mmu_translate() */
>  #define MMU_S390_LRA        -1
> -int mmu_translate(CPUS390XState *env, target_ulong vaddr, int rw, uint64=
_t asc,
> +int mmu_translate(CPUS390XState *env, vaddr vaddr, int rw, uint64_t asc,
>                    target_ulong *raddr, int *flags, uint64_t *tec);
> -int mmu_translate_real(CPUS390XState *env, target_ulong raddr, int rw,
> +int mmu_translate_real(CPUS390XState *env, vaddr raddr, int rw,

I think this one should remain target_ulong, and become hwaddr in the next =
patch, no?

>                         target_ulong *addr, int *flags, uint64_t *tec);
> =20
> =20
> diff --git a/target/s390x/helper.c b/target/s390x/helper.c
> index d0c36d4a537..5002eebd4c8 100644
> --- a/target/s390x/helper.c
> +++ b/target/s390x/helper.c
> @@ -71,7 +71,7 @@ hwaddr s390_cpu_get_phys_page_debug(CPUState *cs, vaddr=
 vaddr)
>  hwaddr s390_cpu_get_phys_addr_debug(CPUState *cs, vaddr v_addr)
>  {
>      hwaddr phys_addr;
> -    target_ulong page;
> +    vaddr page;
> =20
>      page =3D v_addr & TARGET_PAGE_MASK;
>      phys_addr =3D cpu_get_phys_page_debug(cs, page);
> diff --git a/target/s390x/mmu_helper.c b/target/s390x/mmu_helper.c
> index 30f09ec3de4..3313487b41d 100644
> --- a/target/s390x/mmu_helper.c
> +++ b/target/s390x/mmu_helper.c
> @@ -122,7 +122,7 @@ static inline bool read_table_entry(CPUS390XState *en=
v, hwaddr gaddr,
>      return ret =3D=3D MEMTX_OK;
>  }
> =20
> -static int mmu_translate_asce(CPUS390XState *env, target_ulong vaddr,
> +static int mmu_translate_asce(CPUS390XState *env, vaddr vaddr,
>                                uint64_t asc, uint64_t asce, target_ulong =
*raddr,
>                                int *flags)
>  {
> @@ -381,7 +381,7 @@ static void mmu_handle_skey(target_ulong addr, int rw=
, int *flags)
>   *               there is an exception to raise
>   * @return       0 =3D success, !=3D 0, the exception to raise
>   */
> -int mmu_translate(CPUS390XState *env, target_ulong vaddr, int rw, uint64=
_t asc,
> +int mmu_translate(CPUS390XState *env, vaddr vaddr, int rw, uint64_t asc,
>                    target_ulong *raddr, int *flags, uint64_t *tec)
>  {
>      uint64_t asce;
> @@ -584,7 +584,7 @@ void s390_cpu_virt_mem_handle_exc(S390CPU *cpu, uintp=
tr_t ra)
>   * @param flags  the PAGE_READ/WRITE/EXEC flags are stored to this point=
er
>   * @return       0 =3D success, !=3D 0, the exception to raise
>   */
> -int mmu_translate_real(CPUS390XState *env, target_ulong raddr, int rw,
> +int mmu_translate_real(CPUS390XState *env, vaddr raddr, int rw,
>                         target_ulong *addr, int *flags, uint64_t *tec)
>  {
>      const bool lowprot_enabled =3D env->cregs[0] & CR0_LOWPROT;
> diff --git a/target/s390x/tcg/excp_helper.c b/target/s390x/tcg/excp_helpe=
r.c
> index 019eb4fba1f..292d130d03e 100644
> --- a/target/s390x/tcg/excp_helper.c
> +++ b/target/s390x/tcg/excp_helper.c
> @@ -147,7 +147,8 @@ bool s390_cpu_tlb_fill(CPUState *cs, vaddr address, i=
nt size,
>                         bool probe, uintptr_t retaddr)
>  {
>      CPUS390XState *env =3D cpu_env(cs);
> -    target_ulong vaddr, raddr;
> +    vaddr vaddr;
> +    target_ulong raddr;
>      uint64_t asc, tec;
>      int prot, excp;
> =20

