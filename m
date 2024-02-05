Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96108C48291
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Feb 2024 05:51:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWrrg-0002Pq-Nm; Mon, 05 Feb 2024 00:49:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dantan@linux.vnet.ibm.com>)
 id 1rWrre-0002PY-NZ; Mon, 05 Feb 2024 00:49:54 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dantan@linux.vnet.ibm.com>)
 id 1rWrrc-000156-V5; Mon, 05 Feb 2024 00:49:54 -0500
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 4154rwZa028937; Mon, 5 Feb 2024 05:49:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : content-type :
 content-transfer-encoding : mime-version : subject : message-id : date :
 cc : to; s=pp1; bh=0vk/2FATO1088YCeni785gSaMfJtNQa4NWGnqlUs26Y=;
 b=KzgBfweQclcdu4hzcp0zS4bfoSodTSRYDxnB6icbHJweZX1VfkNINOqelxY6E2QDYEsh
 3jytRugXVDl8e5eLsh7rS/hbIYdZcUtSKK+JNmnckU8CrXyRNfbgkDQMYX0S99StEn5m
 L+w5msi+2bgTn1mXFoBx6oqmi4DlsoCme2Z9GwphbdBq8J0NHRTSyPSTe0uooWtXpQYI
 J1w4VwE7K8Y+/Fni5J5uuxuWs/DALu6bwLMrjKN/8JM3zZ2w3F4MJC6NDZ1qiNFc4HUR
 pCessXzqJpSX/tgctRsNW84LaCTRjBsdm0h48HVIecvfSEFRWXHRae4MXvhl9tX+JU23 pQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w2r7nspwn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 05 Feb 2024 05:49:43 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4155hpNX027999;
 Mon, 5 Feb 2024 05:49:43 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w2r7nspwf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 05 Feb 2024 05:49:43 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 4153lR6S014765; Mon, 5 Feb 2024 05:49:42 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3w20tnejvj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 05 Feb 2024 05:49:42 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 4155ngYw37880452
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 5 Feb 2024 05:49:42 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4899258053;
 Mon,  5 Feb 2024 05:49:42 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D775E58043;
 Mon,  5 Feb 2024 05:49:41 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.61.184.118])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
 Mon,  5 Feb 2024 05:49:41 +0000 (GMT)
From: dan tan <dantan@linux.vnet.ibm.com>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.300.61.1.2\))
Subject: Re: [PATCH] ppc/pnv: Add PowerPC Special Purpose Registers
Message-Id: <E3636156-51F1-4AC3-9417-62162DDFE643@linux.vnet.ibm.com>
Date: Sun, 4 Feb 2024 23:49:31 -0600
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?utf-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
To: Nicholas Piggin <npiggin@gmail.com>
X-Mailer: Apple Mail (2.3774.300.61.1.2)
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: pEWFlFiFNydbHGiMGNSBqypmqreHStT_
X-Proofpoint-ORIG-GUID: qv2lh2RAC3-6d8rVV6G-ak3CPJ_DcX8k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-05_01,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0
 priorityscore=1501 suspectscore=0 mlxscore=0 adultscore=0 bulkscore=0
 mlxlogscore=744 malwarescore=0 phishscore=0 lowpriorityscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402050043
Received-SPF: none client-ip=148.163.158.5;
 envelope-from=dantan@linux.vnet.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Thu, 18 Jan 2024 12:27:12 +1000, Nicholas Piggin wrote:
> On Thu Jan 18, 2024 at 8:34 AM AEST, dan tan wrote:
>>        The handling of the following two registers are added -
>>            DAWR1  (0x0bd, 189) - Data Address Watchpoint 1
>>            DAWRX1 (0x0b5, 181) - Data Address Watchpoint Extension 1
>>=20
>>      Signed-off-by: dan tan <dantan@linux.vnet.ibm.com>
>=20
> Small nit, but there's some extra whitespace on the left here and in
> Subject header which is normally not required.
>=20

I will fix that on the respin

>> ---
>> target/ppc/cpu.c         | 51
>> ++++++++++++++++++++++++++++++++++++++++++++++++
>> target/ppc/cpu.h         |  6 ++++++
>> target/ppc/cpu_init.c    | 10 ++++++++++
>> target/ppc/excp_helper.c | 11 ++++++++++-
>> target/ppc/helper.h      |  2 ++
>> target/ppc/machine.c     |  1 +
>> target/ppc/misc_helper.c | 10 ++++++++++
>> target/ppc/spr_common.h  |  2 ++
>> target/ppc/translate.c   | 12 ++++++++++++
>> 9 files changed, 104 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/target/ppc/cpu.c b/target/ppc/cpu.c
>> index e3ad8e0..8a77328 100644
>> --- a/target/ppc/cpu.c
>> +++ b/target/ppc/cpu.c
>> @@ -188,6 +188,57 @@ void ppc_store_dawrx0(CPUPPCState *env, uint32_t =
val)
>>     env->spr[SPR_DAWRX0] =3D val;
>>     ppc_update_daw0(env);
>> }
>> +
>> +void ppc_update_daw1(CPUPPCState *env)
>> +{
>> +    CPUState *cs =3D env_cpu(env);
>> +    target_ulong deaw =3D env->spr[SPR_DAWR1] & PPC_BITMASK(0, 60);
>> +    uint32_t dawrx =3D env->spr[SPR_DAWRX1];
>> +    int mrd =3D extract32(dawrx, PPC_BIT_NR(48), 54 - 48);
>> +    bool dw =3D extract32(dawrx, PPC_BIT_NR(57), 1);
>> +    bool dr =3D extract32(dawrx, PPC_BIT_NR(58), 1);
>> +    bool hv =3D extract32(dawrx, PPC_BIT_NR(61), 1);
>> +    bool sv =3D extract32(dawrx, PPC_BIT_NR(62), 1);
>> +    bool pr =3D extract32(dawrx, PPC_BIT_NR(62), 1);
>> +    vaddr len;
>> +    int flags;
>> +
>> +    if (env->dawr1_watchpoint) {
>> +        cpu_watchpoint_remove_by_ref(cs, env->dawr1_watchpoint);
>> +        env->dawr1_watchpoint =3D NULL;
>> +    }
>> +
>> +    if (!dr && !dw) {
>> +        return;
>> +    }
>> +
>> +    if (!hv && !sv && !pr) {
>> +        return;
>> +    }
>> +
>> +    len =3D (mrd + 1) * 8;
>> +    flags =3D BP_CPU | BP_STOP_BEFORE_ACCESS;
>> +    if (dr) {
>> +        flags |=3D BP_MEM_READ;
>> +    }
>> +    if (dw) {
>> +        flags |=3D BP_MEM_WRITE;
>> +    }
>> +
>> +    cpu_watchpoint_insert(cs, deaw, len, flags, =
&env->dawr1_watchpoint);
>> +}
>=20
> I would say this is just beyond the point where we should share
> code with daw0. You could make a function that takes DAWR(x) SPR
> numbers or values, and a pointer to the watchpoint to use.
>=20

Noted. Will make the change

>> +
>> +void ppc_store_dawr1(CPUPPCState *env, target_ulong val)
>> +{
>> +    env->spr[SPR_DAWR1] =3D val;
>> +    ppc_update_daw1(env);
>> +}
>> +
>> +void ppc_store_dawrx1(CPUPPCState *env, uint32_t val)
>> +{
>> +    env->spr[SPR_DAWRX1] =3D val;
>> +    ppc_update_daw1(env);
>> +}
>> #endif
>> #endif
>>=20
>> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
>> index f8101ff..ab34fc7 100644
>> --- a/target/ppc/cpu.h
>> +++ b/target/ppc/cpu.h
>> @@ -1237,6 +1237,7 @@ struct CPUArchState {
>>     ppc_slb_t slb[MAX_SLB_ENTRIES]; /* PowerPC 64 SLB area */
>>     struct CPUBreakpoint *ciabr_breakpoint;
>>     struct CPUWatchpoint *dawr0_watchpoint;
>> +    struct CPUWatchpoint *dawr1_watchpoint;
>> #endif
>>     target_ulong sr[32];   /* segment registers */
>>     uint32_t nb_BATs;      /* number of BATs */
>> @@ -1552,6 +1553,9 @@ void ppc_store_ciabr(CPUPPCState *env, =
target_ulong
>> value);
>> void ppc_update_daw0(CPUPPCState *env);
>> void ppc_store_dawr0(CPUPPCState *env, target_ulong value);
>> void ppc_store_dawrx0(CPUPPCState *env, uint32_t value);
>> +void ppc_update_daw1(CPUPPCState *env);
>> +void ppc_store_dawr1(CPUPPCState *env, target_ulong value);
>> +void ppc_store_dawrx1(CPUPPCState *env, uint32_t value);
>> #endif /* !defined(CONFIG_USER_ONLY) */
>> void ppc_store_msr(CPUPPCState *env, target_ulong value);
>>=20
>> @@ -1737,9 +1741,11 @@ void ppc_compat_add_property(Object *obj, =
const char
>> *name,
>> #define SPR_PSPB              (0x09F)
>> #define SPR_DPDES             (0x0B0)
>> #define SPR_DAWR0             (0x0B4)
>> +#define SPR_DAWR1             (0x0B5)
>> #define SPR_RPR               (0x0BA)
>> #define SPR_CIABR             (0x0BB)
>> #define SPR_DAWRX0            (0x0BC)
>> +#define SPR_DAWRX1            (0x0BD)
>> #define SPR_HFSCR             (0x0BE)
>> #define SPR_VRSAVE            (0x100)
>> #define SPR_USPRG0            (0x100)
>> diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
>> index 40fe14a..d75c359 100644
>> --- a/target/ppc/cpu_init.c
>> +++ b/target/ppc/cpu_init.c
>> @@ -5119,11 +5119,21 @@ static void =
register_book3s_207_dbg_sprs(CPUPPCState
>> *env)
>>                         SPR_NOACCESS, SPR_NOACCESS,
>>                         &spr_read_generic, &spr_write_dawr0,
>>                         KVM_REG_PPC_DAWR, 0x00000000);
>> +    spr_register_kvm_hv(env, SPR_DAWR1, "DAWR1",
>> +                        SPR_NOACCESS, SPR_NOACCESS,
>> +                        SPR_NOACCESS, SPR_NOACCESS,
>> +                        &spr_read_generic, &spr_write_dawr1,
>> +                        KVM_REG_PPC_DAWR, 0x00000000);
>>     spr_register_kvm_hv(env, SPR_DAWRX0, "DAWRX0",
>>                         SPR_NOACCESS, SPR_NOACCESS,
>>                         SPR_NOACCESS, SPR_NOACCESS,
>>                         &spr_read_generic, &spr_write_dawrx0,
>>                         KVM_REG_PPC_DAWRX, 0x00000000);
>> +    spr_register_kvm_hv(env, SPR_DAWRX1, "DAWRX1",
>> +                        SPR_NOACCESS, SPR_NOACCESS,
>> +                        SPR_NOACCESS, SPR_NOACCESS,
>> +                        &spr_read_generic, &spr_write_dawrx1,
>> +                        KVM_REG_PPC_DAWRX, 0x00000000);
>=20
> These are new for POWER10, no? This is adding them for P8/9 too.
>=20

I did not realize that. Will move these out to POWER10 only

> Thanks,
> Nick

Thanks,
/dan


