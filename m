Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4884CDB471
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 12:46:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcMzm-0003W4-UE; Wed, 24 Jun 2026 08:46:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vaibhav@linux.ibm.com>)
 id 1wcMzj-0003Vv-Pz; Wed, 24 Jun 2026 08:46:19 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vaibhav@linux.ibm.com>)
 id 1wcMzi-0006Ru-4K; Wed, 24 Jun 2026 08:46:19 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65OAmkdW561869; Wed, 24 Jun 2026 12:46:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=YxDRNiMMO4zAzCcOhpCYmKhVHPd9Sm
 bllg8Vjqhg0pE=; b=e6w1aCdejKDS3eRSOqlMd0pVIRMpf1SMa3bsYBRM4Pp1G9
 FmA/pOnV2TaWtv0gdDD9xEJvbROSFbAqoxxwWYKHVBztewoWMXy2YOYmSpEOy5qt
 p1fW03PgqskmmQe3En4W1QKu8WDwtSLRQJQLQsACFqxxfeiPfJwTdC+bJziETnol
 F/vBoFhO2sm2vXTJo4X4ToCRlN0Em6Zg2b2XKUvJUUVRDEIjpijy13RI8X0TQZN/
 h5V05Q0kKVSdnt8l98WRjoxEnPeUz/JcS36Ab7UKQoORytZ7gmWj57lNkqM/JYr9
 YWb8TFj9992zZJEKYh7D9ICHcrX0j0SRcO64zv/w==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewjgsuuu7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 24 Jun 2026 12:46:14 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65OCYf1U031000;
 Wed, 24 Jun 2026 12:46:14 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ex66k8j5h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 24 Jun 2026 12:46:14 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65OCkCa411076134
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 24 Jun 2026 12:46:12 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B91285805A;
 Wed, 24 Jun 2026 12:46:12 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F077F58056;
 Wed, 24 Jun 2026 12:46:08 +0000 (GMT)
Received: from vaibhav?linux.ibm.com (unknown [9.39.19.156])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with SMTP;
 Wed, 24 Jun 2026 12:46:08 +0000 (GMT)
Received: by vaibhav@linux.ibm.com (sSMTP sendmail emulation);
 Wed, 24 Jun 2026 18:16:07 +0530
From: Vaibhav Jain <vaibhav@linux.ibm.com>
To: Gautam Menghani <gautam@linux.ibm.com>, npiggin@gmail.com,
 rathc@linux.ibm.com, milesg@linux.ibm.com, harshpb@linux.ibm.com
Cc: Gautam Menghani <gautam@linux.ibm.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Subject: Re: [PATCH] target/ppc: Expose the TB offset of the guest in QEMU
 monitor
In-Reply-To: <20260623052303.5274-1-gautam@linux.ibm.com>
References: <20260623052303.5274-1-gautam@linux.ibm.com>
Date: Wed, 24 Jun 2026 18:16:06 +0530
Message-ID: <87jyro14z5.fsf@vajain21.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI0MDEwMiBTYWx0ZWRfX4jC/P7BfDFNX
 xDzw/LnfCseAcFHyfbmT/8HL/k+a+biB7cY9LecdfJsnDkr3A3hTxYuNZoNc2jx6InsbfoC6AGL
 x1MY9F83r8OE0CzJJHyRveG6SzaU71Z93GB6xEyStqEBgXOhX7e8V6sAm+2x6n17zcvW5jQea1c
 OZZsO4WlHDhxUbzyvgeYXf6dPsq5IE5J6MEYGYN79PI16K9zDcoFlMohVn+s1fq9g+v8RnOqKb+
 SYkZAHSEkhJBoOl1+4avfCVgHK2G6rkClezuX+gJs2GajhXcB6i8WM0DyJPrneoNEAgEUGfGNq/
 UnLmv13O8B+33acw9wrnDFVKznbSdwiZAAMYvItuOHHh0fhVa6oNMH0g6mTkw11KTDJc1FCuK1D
 +Zf0FXlbhCeXLMOQ//uMN81GUmGlJG1uQ53g8xeShm7AA3Si5go3IOOV4wWcSzaCUgwADXKdKnL
 Bvv5zhO82df2cpcqZzg==
X-Proofpoint-GUID: 66SNV5q3ZfjWgUG4eojAndmqP1yifvwB
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI0MDEwMiBTYWx0ZWRfXzw+GEhHbFreB
 AiimDiyK+OfbqOud0QywrXpzKP/mu1jwJKy+xg1amG+/UJznEYNZlqkg1oKb7RHmr364oaWDvFI
 z1y/O9dfnouyeihg07bZRZPloa87RUI=
X-Authority-Analysis: v=2.4 cv=I/lVgtgg c=1 sm=1 tr=0 ts=6a3bd197 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=pSTbB7s77_JVs2PdU3YA:9
X-Proofpoint-ORIG-GUID: a1UzSgpnuufc3w_U4fF1OHCYZmY0UzeI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-24_03,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 adultscore=0 impostorscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606240102
Received-SPF: pass client-ip=148.163.158.5; envelope-from=vaibhav@linux.ibm.com;
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

Hi Gautam,

Thanks for the patch. My review comments inline below:

Gautam Menghani <gautam@linux.ibm.com> writes:

> When debugging issues in KVM guests, it is sometimes helpful to have a
> unified trace log of both guest and host to see where things are going
> wrong. Expose the TB (timebase) offset through QEMU monitor to enable
> capturing of unified log.
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
> 3. Transfer the guest logs to the host with scp/rsync
>
> 4. Unify the logs
> trace-cmd report -i trace_host.dat -i trace_guest.dat > combined_log
>
> Signed-off-by: Gautam Menghani <gautam@linux.ibm.com>
> ---
>  hw/ppc/ppc.c          | 5 +++++
>  target/ppc/cpu.h      | 1 +
>  target/ppc/cpu_init.c | 4 +++-
>  3 files changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
> index a512d4fa64..1e8eb0ceef 100644
> --- a/hw/ppc/ppc.c
> +++ b/hw/ppc/ppc.c
> @@ -515,6 +515,11 @@ uint64_t cpu_ppc_get_tb(ppc_tb_t *tb_env, uint64_t vmclk, int64_t tb_offset)
>      return ns_to_tb(tb_env->tb_freq, vmclk) + tb_offset;
>  }
>  
> +int64_t cpu_ppc_load_tb_offset(CPUPPCState *env)
> +{
> +    return llabs(*(&env->tb_env->tb_offset));
Why are you doing both pointer ref and deref ?
Also why llabs is needed for tb_offset. You are anyways returning signed
value and printing signed value later in ppc_cpu_dump_state.

I think you can just do

return env->tb_env->tb_offset;

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
> index a02187ce5a..a77adc3e62 100644
> --- a/target/ppc/cpu_init.c
> +++ b/target/ppc/cpu_init.c
> @@ -7620,8 +7620,10 @@ void ppc_cpu_dump_state(CPUState *cs, FILE *f, int flags)
>  #if !defined(CONFIG_USER_ONLY)
>      if (env->tb_env) {
>          qemu_fprintf(f, "TB %08" PRIu32 " %08" PRIu64
> +                     " TB_OFFSET %016" PRId64
Minor:
There might be some userspace tooling depending on this dump
format. Would prefer if you introduce the new field to the end of
string.

>                       " DECR " TARGET_FMT_lu "\n", cpu_ppc_load_tbu(env),
> -                     cpu_ppc_load_tbl(env), cpu_ppc_load_decr(env));
> +                     cpu_ppc_load_tbl(env), cpu_ppc_load_tb_offset(env),
> +                     cpu_ppc_load_decr(env));
>      }
>  #else
>      qemu_fprintf(f, "TB %08" PRIu32 " %08" PRIu64 "\n", cpu_ppc_load_tbu(env),
> -- 
> 2.54.0
>

-- 
Cheers
~ Vaibhav

