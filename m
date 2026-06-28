Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5652CC43327
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jun 2026 12:13:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wdoNt-0008Qp-1U; Sun, 28 Jun 2026 08:13:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vaibhav@linux.ibm.com>)
 id 1wdoNe-0008Oe-Dy; Sun, 28 Jun 2026 08:12:59 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vaibhav@linux.ibm.com>)
 id 1wdoNb-0001q8-KP; Sun, 28 Jun 2026 08:12:58 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65S9mNKY4170220; Sun, 28 Jun 2026 12:12:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=C/SMHYSm+wnOsMbz6RuGr1mSg+bZ51
 TdvKZHO/yhFdk=; b=DvlVHOVRXoAKSzbBk0AzAP1fS765cP2Cl1E4cMb5ZIHJPr
 VPWCpYwqN2W2d44e+lbK8oh7btKQ1Q2E9tS6m4L7dbwaCGUzEJC0FFRayJchKYZu
 cC7t4hYoIJ0vNS1NXQ9i0Opb/tuTwbgNoikkeFUwsBaSM+bQUxAzE7HwqJ2pELjH
 254Ag5JFoq3eznLX8Q9zk+peFpoea80ljmwpwzKVyiKvu/OvvuSH5TmUCctfUhjj
 AO0YElHmZZoz8+sTrC+8WmfavSiwjCjA2ypIa3/WFnfgXXJTf0co40sAS+9bJK3H
 +xfLxeozkILtUjQztmEEJG26EMkVG8GUMlXnurUA==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26remue3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 28 Jun 2026 12:12:50 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65SC4ftr029534;
 Sun, 28 Jun 2026 12:12:50 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f2tbh1c7u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 28 Jun 2026 12:12:50 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65SCCGlr27984458
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 28 Jun 2026 12:12:16 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CD65F5805A;
 Sun, 28 Jun 2026 12:12:48 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C97B558054;
 Sun, 28 Jun 2026 12:12:44 +0000 (GMT)
Received: from vaibhav?linux.ibm.com (unknown [9.39.21.125])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with SMTP;
 Sun, 28 Jun 2026 12:12:44 +0000 (GMT)
Received: by vaibhav@linux.ibm.com (sSMTP sendmail emulation);
 Sun, 28 Jun 2026 17:42:42 +0530
From: Vaibhav Jain <vaibhav@linux.ibm.com>
To: Gautam Menghani <gautam@linux.ibm.com>, harshpb@linux.ibm.com,
 rathc@linux.ibm.com, milesg@linux.ibm.com, npiggin@gmail.com
Cc: Gautam Menghani <gautam@linux.ibm.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v2] target/ppc: Expose the TB offset of the guest in
 QEMU monitor
In-Reply-To: <20260626093554.69966-1-gautam@linux.ibm.com>
References: <20260626093554.69966-1-gautam@linux.ibm.com>
Date: Sun, 28 Jun 2026 17:42:42 +0530
Message-ID: <87zf0ex3r9.fsf@vajain21.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=a4kAM0SF c=1 sm=1 tr=0 ts=6a410fc3 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=pSTbB7s77_JVs2PdU3YA:9
X-Proofpoint-ORIG-GUID: AgOgshIaic2HTdosUVSaRk4AO9Kqd86g
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI4MDEwMyBTYWx0ZWRfX5sDeiXMLt8/n
 qkcUMs/6LGJRsAVN4rnQEvgXOwNq7XpA73YDUUyy5//cKk/u2q9/ILrMYyuQ94ucgHJk5Sd4z8s
 RhlM9Semxw11EP3WTDKaGWcyIh/YITDvdxxj53EvNQ/CdDh+6ci1MNe4DdrrY7vkLOp4uOM0QMh
 Upvg5LhArBk6S8Jm1TI/2aA74ZttLLIs5g+hlkHG/5l+sJyMvpFZhfVGshn5EgoMMZB+cWyTgLs
 BNDZV4+GfPmWBMCTje0c29pdy468lu97yNsuXHnjJ/doPEg7VzQxAnb+h9QnDInfksCperRKUwO
 NHPR8Fvd9xxKScp8CQg3pWRdTPds9JkBDvqaRu2eZSSNH8gm8lgsAqEQxiggzld0Yqt1N7t2upN
 5/KmQoLoOaKvxsaSX83/j6q+jPuV66NkLrCkCHVKo2tQTYyvULL706wY0yJ6xZulRBocFPEoofY
 E8DjnnvO4MGBbMkCKYw==
X-Proofpoint-GUID: sb-vexTQcdJyChI1CJ_X76bdSwvTE-Zr
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI4MDEwMyBTYWx0ZWRfX5Ins6IKIfQ/F
 rZ+Xjt9qP4MoB/hVXSdAIzmZ+CngC1DPZjDoBpxxhYLE2UvhxHOByObwyJxEg+wIvsGaLrBrn96
 H61CjispaQRVtV+GQ02b67n5WAq+QXI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-28_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0
 spamscore=0 priorityscore=1501 adultscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606280103
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
Thanks Gautam from addressing V1 review comments. With this feel free to
add

Reviewed-by: Vaibhav Jain<vaibhav@linux.ibm.com>

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
>      }
>  #else
>      qemu_fprintf(f, "TB %08" PRIu32 " %08" PRIu64 "\n", cpu_ppc_load_tbu(env),
> -- 
> 2.54.0
>

-- 
Cheers
~ Vaibhav

