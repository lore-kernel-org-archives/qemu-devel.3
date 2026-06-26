Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE4EBC43458
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 20:12:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wdCuW-0002by-2u; Fri, 26 Jun 2026 16:12:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amachhiw@linux.ibm.com>)
 id 1wdCuD-0002Y4-T9; Fri, 26 Jun 2026 16:12:06 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amachhiw@linux.ibm.com>)
 id 1wdCuB-0004Ad-SO; Fri, 26 Jun 2026 16:12:05 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65QJJ0Cq3805795; Fri, 26 Jun 2026 20:12:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=Bj+ynO
 bxCxt6aBEQLiLOIPDO5BXiaAVtyTaSe81w4+E=; b=lEJ+4sYHQCysUNZgDlzrjY
 fMyKwUFmP/t3TADVCs8KCUdHypPnnhYo+BsUVBx6c6CQCbKXpy4vkZZvnp/JD0EH
 8X7WVXVaCloa22RZ4/Ej2hRxfn21jRwn7SD2rBngycm5/TNKaqzt+lvpMRNx7tbA
 bttwjofmMfYT8OsUjwkpncS56G35w/jMh8gMcEvUFkDAOP1yOoimpN2knJ7fyRnV
 Y32snt9NavwLVnsbwAFnz3M5BOOUdAMX/Uh67tw/bNBGrZi0fEYWoG42gMx4xAnf
 QJ87omKRCenqJKAbu1DEXHolfaYrWsHFk6iulSrKhJndDPUwuzQkEYtRAV/sgOWg
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewg9j8rf4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 26 Jun 2026 20:11:59 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65QK4jSc028260;
 Fri, 26 Jun 2026 20:11:58 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ex7dgmgca-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 26 Jun 2026 20:11:58 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65QKBsDM43319710
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 26 Jun 2026 20:11:54 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C221120049;
 Fri, 26 Jun 2026 20:11:54 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1A98120040;
 Fri, 26 Jun 2026 20:11:53 +0000 (GMT)
Received: from fedora (unknown [9.5.7.39])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Fri, 26 Jun 2026 20:11:52 +0000 (GMT)
Date: Sat, 27 Jun 2026 01:42:00 +0530
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: Gautam Menghani <gautam@linux.ibm.com>
Cc: harshpb@linux.ibm.com, rathc@linux.ibm.com, milesg@linux.ibm.com,
 npiggin@gmail.com, vaibhav@linux.ibm.com, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v2] target/ppc: Expose the TB offset of the guest in QEMU
 monitor
Message-ID: <20260627013019.0128e447-77-amachhiw@linux.ibm.com>
Mail-Followup-To: Gautam Menghani <gautam@linux.ibm.com>, 
 harshpb@linux.ibm.com, rathc@linux.ibm.com, milesg@linux.ibm.com,
 npiggin@gmail.com, 
 vaibhav@linux.ibm.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org
References: <20260626093554.69966-1-gautam@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260626093554.69966-1-gautam@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: MAC0G25miIpB4JAGOksiceUyA5lCbWVT
X-Proofpoint-GUID: Ab4RhcbZf2-E3Mge3OvdFK0sife3gK1k
X-Authority-Analysis: v=2.4 cv=Y4XIdBeN c=1 sm=1 tr=0 ts=6a3edd0f cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=60gL5IOrpHXuJ75AM_sA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI2MDE2NCBTYWx0ZWRfXzlIeIfF8xghh
 2yrjTiE/Ddhj7J+ZH2cAok6pI0LdB5l1C3SnBVcijDpdqoT8RaLJM1cdfQrTzwc8PEAgcQRm3eR
 TE50cHGkyRTekuDF2tfDqqsbd/m+jQFVS/BbtAy971LH13vPs4yRZIlwtFKjjIJ7YnUu1VDjeKM
 2R3ZZzO5gX9aegk4Sdcn8QHIRH4RYDO+vauG9Oo2lZpvMKybg+sZSpIiLLHO3Q8nHem0OBuLlM6
 2RPX8atRq7TcogEWNgCI1wycwXWJqmbyhbRh1jp6kdP14engqKYNOn6rdcBzk0iceGvhPRxmxQY
 d7BaBJj2JoBWZGqwvIXYU4foIzfyToXrC6zWq97fGXaw8FSFI+22Y+t6VT/1Ziu501gIx3UR8Ja
 i+/U3h5dwny81TEo8OytWrZa3dZfeTBGHZS0ICzo+jG9g4yH9DMAAardXcSE9fGahPpbJoBQGBg
 fiaaWfz+TcSIzATuS4g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI2MDE2NCBTYWx0ZWRfX9ME+6LVxG8Uw
 lVSPV7/BbQk+EBvXs28DI4X4brPnufjyik2612xodWKeStuzEjFa1KWKxadLQgmtQPHBDSnXcyQ
 0z4Kl3WSXjrBaRolS6IhBDTccn5IbKM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-26_05,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0 spamscore=0
 clxscore=1015 suspectscore=0 impostorscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606260164
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=amachhiw@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
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

Hi Gautam,

Thanks for the patch. Please find my review comments below:

On 2026/06/26 03:05 PM, Gautam Menghani wrote:
> When debugging issues in KVM guests, it is sometimes helpful to have a
> unified trace log of both guest and host to see where things are going
> wrong. Expose the TB (timebase) offset through QEMU monitor to enable
> capturing of unified log.

Thanks for working on it. This is useful.

> 
> The below steps can be then used to get a unified log:
> 1. In host
> trace-cmd record -e kvm_hv:kvm_guest_enter -e kvm_hv:kvm_guest_exit \
>     -C ppc-tb -o trace_host.dat
> 
> 2. In guest
> trace-cmd record -e powerpc:hcall_entry -e powerpc:hcall_exit -C ppc-tb \
>     --ts-offset <TB offset from QEMU monitor> -o trace_guest.dat
> 
>   NOTE: The TB offset would be reported as a negative number in QEMU
>   monitor. For this step, the minus sign must be ignored.
> 
> 3. Transfer the guest logs to the host with scp/rsync
> 
> 4. Unify the logs
> trace-cmd report -i trace_host.dat -i trace_guest.dat > combined_log
> 
> Signed-off-by: Gautam Menghani <gautam@linux.ibm.com>
> ---
> v1 -> v2:
> 1. Remove extra deref and ref code (Vaibhav)
> 2. Fix the QEMU monitor output to add the new field at the end (Vaibhav)
> 
>  hw/ppc/ppc.c          | 5 +++++
>  target/ppc/cpu.h      | 1 +
>  target/ppc/cpu_init.c | 5 +++--
>  3 files changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
> index a512d4fa64..b123b4cc1c 100644
> --- a/hw/ppc/ppc.c
> +++ b/hw/ppc/ppc.c
> @@ -515,6 +515,11 @@ uint64_t cpu_ppc_get_tb(ppc_tb_t *tb_env, uint64_t vmclk, int64_t tb_offset)
>      return ns_to_tb(tb_env->tb_freq, vmclk) + tb_offset;
>  }
>  
> +int64_t cpu_ppc_load_tb_offset(CPUPPCState *env)
> +{
> +    return env->tb_env->tb_offset;
> +}
> +
>  uint64_t cpu_ppc_load_tbl (CPUPPCState *env)
>  {
>      ppc_tb_t *tb_env = env->tb_env;
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index 057c54bbb8..cbd5964b1a 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -1693,6 +1693,7 @@ void cpu_ppc_store_hdecr(CPUPPCState *env, target_ulong value);
>  void cpu_ppc_store_tbu40(CPUPPCState *env, uint64_t value);
>  uint64_t cpu_ppc_load_purr(CPUPPCState *env);
>  void cpu_ppc_store_purr(CPUPPCState *env, uint64_t value);
> +int64_t cpu_ppc_load_tb_offset(CPUPPCState *env);
>  #if !defined(CONFIG_USER_ONLY)
>  target_ulong load_40x_pit(CPUPPCState *env);
>  void store_40x_pit(CPUPPCState *env, target_ulong val);
> diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
> index a02187ce5a..8cab5e12b6 100644
> --- a/target/ppc/cpu_init.c
> +++ b/target/ppc/cpu_init.c
> @@ -7620,8 +7620,9 @@ void ppc_cpu_dump_state(CPUState *cs, FILE *f, int flags)
>  #if !defined(CONFIG_USER_ONLY)
>      if (env->tb_env) {
>          qemu_fprintf(f, "TB %08" PRIu32 " %08" PRIu64
> -                     " DECR " TARGET_FMT_lu "\n", cpu_ppc_load_tbu(env),
> -                     cpu_ppc_load_tbl(env), cpu_ppc_load_decr(env));
> +                     " DECR " TARGET_FMT_lu " TB_OFFSET %016" PRId64 "\n",
> +                     cpu_ppc_load_tbu(env), cpu_ppc_load_tbl(env),
> +                     cpu_ppc_load_decr(env), cpu_ppc_load_tb_offset(env));

I tested the patch on P10 LPAR and host and the patch works as expected.

 Without patch:
 --------------
 [...]
 TB 00000000 00000000 DECR 0


 With patch:
 -----------
 [...]
 TB 00000000 00000000 DECR 0 TB_OFFSET -5980196012294144

Hence,

Tested-by: Amit Machhiwal <amachhiw@linux.ibm.com>


Minor observation: the TB_OFFSET field will always print
0000000000000000 for a TCG guest — tb_offset is zero-initialised in
cpu_ppc_tb_init() and never updated as I think in the TCG path
QEMU_CLOCK_VIRTUAL starts from 0 at VM start, requiring no offset
correction.

  TB 00000113 488874479567 DECR 1265321 TB_OFFSET 0000000000000000

The commit message correctly scopes this to KVM guests, so this isn't a
bug. But since TB_OFFSET appears unconditionally in info registers for
all guests, a user running a TCG guest might find the zero value
confusing. Worth either guarding it with kvm_enabled() or adding a brief
code comment and as well as in the commit log noting it is only
meaningful under KVM.

With above change, please free to add:

Reviewed-by: Amit Machhiwal <amachhiw@linux.ibm.com>

Thanks,
Amit

>      }
>  #else
>      qemu_fprintf(f, "TB %08" PRIu32 " %08" PRIu64 "\n", cpu_ppc_load_tbu(env),
> -- 
> 2.54.0
> 
> 

