Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEEBBC2BD05
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 07:28:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLe7O-0003SE-1d; Mon, 24 Jun 2024 03:28:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1sLe7M-0003Qs-N1; Mon, 24 Jun 2024 03:28:00 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1sLe7K-0000iS-KU; Mon, 24 Jun 2024 03:28:00 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45O5TshA006195;
 Mon, 24 Jun 2024 07:27:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=o
 5eUvLJLf7rnvgOafZmBPyYbZxH8hq1yCtixkm7FE2Q=; b=hPDoGUOEeMSV/sm/z
 E7oESzdywoZ2qAf4nKifO6VRMAZVMImvMz/Vuup+6WLvBCVI+ni6Px1o2Ssm0GQi
 RZYWa2HfVQWGH6H+soa2DJDREPcrdULGizJ+46+GaWdSzZegxZvGf2cxacMbDXR2
 AZ4p2zb88EiwOLyPOBPpJxovlMWWPHNL8ZRX05WhIfmeTfor1tRCHIufFHxwvBdg
 t/27CqZY9kRsOWTeP69kxukImaGvll1788AehyS9W1/diDNzTodf+QyJndFNhr9N
 N+lROXWEtA4K/rL3dAYJvhi8V83pok16c6f/XfwtE7kU6zkpsdKZa40hjDhMbwdM
 IZSTw==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yy2pp8b62-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 24 Jun 2024 07:27:53 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45O7Qt4b024519;
 Mon, 24 Jun 2024 07:27:53 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yy2pp8b3w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 24 Jun 2024 07:27:52 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 45O7JP5c019548; Mon, 24 Jun 2024 07:23:09 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3yx9xpp73h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 24 Jun 2024 07:23:09 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 45O7N6t35374472
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 24 Jun 2024 07:23:09 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C2B8A58071;
 Mon, 24 Jun 2024 07:23:04 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 62ACA58082;
 Mon, 24 Jun 2024 07:23:01 +0000 (GMT)
Received: from [9.109.242.165] (unknown [9.109.242.165])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 24 Jun 2024 07:23:01 +0000 (GMT)
Message-ID: <d719e182-eff7-48d6-a6fe-618c784ed433@linux.ibm.com>
Date: Mon, 24 Jun 2024 12:52:59 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] target/ppc/arch_dump: set prstatus pid to cpuid
To: Omar Sandoval <osandov@osandov.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, qemu-ppc@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 linux-debuggers@vger.kernel.org
References: <cover.1718771802.git.osandov@osandov.com>
 <ac09da04c8e6dd777945219815d1c53b02291b5b.1718771802.git.osandov@osandov.com>
Content-Language: en-US
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <ac09da04c8e6dd777945219815d1c53b02291b5b.1718771802.git.osandov@osandov.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 4uvSc5ez22pzUqe8Ye740KIB_wl9HYjr
X-Proofpoint-ORIG-GUID: RgZiazhRHMw6P-pUTBLv24qg3kGQpUB0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-24_07,2024-06-21_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0
 spamscore=0 clxscore=1011 priorityscore=1501 mlxlogscore=962 mlxscore=0
 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2406140001
 definitions=main-2406240058
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H3=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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

Hi Omar,

On 6/19/24 10:30, Omar Sandoval wrote:
> Every other architecture does this, and debuggers need it to be able to
> identify which prstatus note corresponds to which CPU.
> 
> Signed-off-by: Omar Sandoval <osandov@osandov.com>
> ---
>   target/ppc/arch_dump.c | 21 ++++++++++++---------
>   1 file changed, 12 insertions(+), 9 deletions(-)
> 
> diff --git a/target/ppc/arch_dump.c b/target/ppc/arch_dump.c
> index a8315659d9..78b4205319 100644
> --- a/target/ppc/arch_dump.c
> +++ b/target/ppc/arch_dump.c
> @@ -47,9 +47,11 @@ struct PPCUserRegStruct {
>   } QEMU_PACKED;
>   
>   struct PPCElfPrstatus {
> -    char pad1[112];
> +    char pad1[32];
> +    uint32_t pid;
> +    uint8_t pad2[76];
>       struct PPCUserRegStruct pr_reg;
> -    char pad2[40];
> +    char pad3[40];
>   } QEMU_PACKED;
>   

Could you please add a comment above the struct providing reference to 
the spec being referred here for member position across the status bits?

With that,

Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>

>   
> @@ -96,7 +98,7 @@ typedef struct NoteFuncArg {
>       DumpState *state;
>   } NoteFuncArg;
>   
> -static void ppc_write_elf_prstatus(NoteFuncArg *arg, PowerPCCPU *cpu)
> +static void ppc_write_elf_prstatus(NoteFuncArg *arg, PowerPCCPU *cpu, int id)
>   {
>       int i;
>       reg_t cr;
> @@ -109,6 +111,7 @@ static void ppc_write_elf_prstatus(NoteFuncArg *arg, PowerPCCPU *cpu)
>   
>       prstatus = &note->contents.prstatus;
>       memset(prstatus, 0, sizeof(*prstatus));
> +    prstatus->pid = cpu_to_dump32(s, id);
>       reg = &prstatus->pr_reg;
>   
>       for (i = 0; i < 32; i++) {
> @@ -127,7 +130,7 @@ static void ppc_write_elf_prstatus(NoteFuncArg *arg, PowerPCCPU *cpu)
>       reg->ccr = cpu_to_dump_reg(s, cr);
>   }
>   
> -static void ppc_write_elf_fpregset(NoteFuncArg *arg, PowerPCCPU *cpu)
> +static void ppc_write_elf_fpregset(NoteFuncArg *arg, PowerPCCPU *cpu, int id)
>   {
>       int i;
>       struct PPCElfFpregset  *fpregset;
> @@ -146,7 +149,7 @@ static void ppc_write_elf_fpregset(NoteFuncArg *arg, PowerPCCPU *cpu)
>       fpregset->fpscr = cpu_to_dump_reg(s, cpu->env.fpscr);
>   }
>   
> -static void ppc_write_elf_vmxregset(NoteFuncArg *arg, PowerPCCPU *cpu)
> +static void ppc_write_elf_vmxregset(NoteFuncArg *arg, PowerPCCPU *cpu, int id)
>   {
>       int i;
>       struct PPCElfVmxregset *vmxregset;
> @@ -178,7 +181,7 @@ static void ppc_write_elf_vmxregset(NoteFuncArg *arg, PowerPCCPU *cpu)
>       vmxregset->vscr.u32[3] = cpu_to_dump32(s, ppc_get_vscr(&cpu->env));
>   }
>   
> -static void ppc_write_elf_vsxregset(NoteFuncArg *arg, PowerPCCPU *cpu)
> +static void ppc_write_elf_vsxregset(NoteFuncArg *arg, PowerPCCPU *cpu, int id)
>   {
>       int i;
>       struct PPCElfVsxregset *vsxregset;
> @@ -195,7 +198,7 @@ static void ppc_write_elf_vsxregset(NoteFuncArg *arg, PowerPCCPU *cpu)
>       }
>   }
>   
> -static void ppc_write_elf_speregset(NoteFuncArg *arg, PowerPCCPU *cpu)
> +static void ppc_write_elf_speregset(NoteFuncArg *arg, PowerPCCPU *cpu, int id)
>   {
>       struct PPCElfSperegset *speregset;
>       Note *note = &arg->note;
> @@ -211,7 +214,7 @@ static void ppc_write_elf_speregset(NoteFuncArg *arg, PowerPCCPU *cpu)
>   
>   static const struct NoteFuncDescStruct {
>       int contents_size;
> -    void (*note_contents_func)(NoteFuncArg *arg, PowerPCCPU *cpu);
> +    void (*note_contents_func)(NoteFuncArg *arg, PowerPCCPU *cpu, int id);
>   } note_func[] = {
>       {sizeof_field(Note, contents.prstatus),  ppc_write_elf_prstatus},
>       {sizeof_field(Note, contents.fpregset),  ppc_write_elf_fpregset},
> @@ -282,7 +285,7 @@ static int ppc_write_all_elf_notes(const char *note_name,
>           arg.note.hdr.n_descsz = cpu_to_dump32(s, nf->contents_size);
>           strncpy(arg.note.name, note_name, sizeof(arg.note.name));
>   
> -        (*nf->note_contents_func)(&arg, cpu);
> +        (*nf->note_contents_func)(&arg, cpu, id);
>   
>           note_size =
>               sizeof(arg.note) - sizeof(arg.note.contents) + nf->contents_size;

