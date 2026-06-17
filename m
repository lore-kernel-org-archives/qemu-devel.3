Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D5CFCD98F0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 12:13:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZp8h-0000yn-BZ; Wed, 17 Jun 2026 08:13:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1wZp8f-0000yA-4f; Wed, 17 Jun 2026 08:13:01 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1wZp8d-0005pa-3k; Wed, 17 Jun 2026 08:13:00 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65H8mMOd4041122; Wed, 17 Jun 2026 12:12:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=w5ty5j
 xYeSQDH6/BY4G6HcWMN7oIkYu+/WEhUVffZqU=; b=EqkO7Z4xs9byX6FL3sxUFW
 jiIvYilyshLKv/oo6auv3gOYvKtBnHd4XVxEIWhTV7aqugKSPnpzltwmfB+Lsupy
 h8EmI/JDeoB0TOcUzhtVHhFk0yxUV44aj7cj3uKzSDWnZqw/8TMg9EBzlphZgNKJ
 GJX2GGJE2gydna/hRNzpZt2W01ag1XQvFR4q72xhKb8VlPB+wLZS9yOdq6g5tYAl
 +w77FmOnYFyCUus6TUNeo1OuY7UgjtB3PrEw9riumOC1k0gQv19raCb7XeLvsBQW
 kS+Uj+g7NeeszafdMRRBLy5jR94Qb1C4h2e7TXvMI5Xdi29HBID0QwH5AzB7yf7A
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eueqxaqw8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 17 Jun 2026 12:12:54 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65HC4vUT024160;
 Wed, 17 Jun 2026 12:12:53 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4eudvab1sk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 17 Jun 2026 12:12:53 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65HCCq2s29491816
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 17 Jun 2026 12:12:52 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 969A658052;
 Wed, 17 Jun 2026 12:12:52 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C51CE58056;
 Wed, 17 Jun 2026 12:12:51 +0000 (GMT)
Received: from [9.61.108.75] (unknown [9.61.108.75])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTPS;
 Wed, 17 Jun 2026 12:12:51 +0000 (GMT)
Message-ID: <df2467a9-d3e1-4547-a01f-03c0170872be@linux.ibm.com>
Date: Wed, 17 Jun 2026 08:12:49 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hw/s390x/ipl: Remove TCG dependency in
 handle_diag_308()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Halil Pasic <pasic@linux.ibm.com>, Zhuoying Cai <zycai@linux.ibm.com>,
 Jason Herne <jjherne@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 qemu-s390x@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>,
 David Hildenbrand <david@kernel.org>, Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>
References: <20260616021654.22892-1-philmd@oss.qualcomm.com>
Content-Language: en-US
From: Jared Rossi <jrossi@linux.ibm.com>
In-Reply-To: <20260616021654.22892-1-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=OcSoyBTY c=1 sm=1 tr=0 ts=6a328f46 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=EUspDBNiAAAA:8
 a=gn6Bm2kASdjQS4ozRLcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE3MDExMiBTYWx0ZWRfX7kmOrd/jrVWH
 2dcOzg3CSfkjFiWotiicQzqu0p7r1Z5RcCcsAeVWS36AHV7pQIaHOr2Q6ZK6CqKM9FdDGZtGYeO
 EYS2YKAU/uBLWlxo+ZZbii8E45TuUXyK0I14R7D+0caQ+RpAP1H3yuE08s/eUj1ywYQeZxTvBCb
 C8s5x/BVbNXdD074QE5d6oE5pBKQwBH82KcGyBf+ZZmDy/QIS2t7GvxGiXLfJfYCaN8UwexKqbN
 NrJGw7hWslVeMFwCaC2zU9PWZEsXr3a2Xg45mqTF/pH2aAGBB3vd1MqRj/gkTa5+TglilNVY2UL
 qUpPlQYX7PC/ygs+Tnj1WTNbOMQuJ1Pbd4qQQ/FMbaVCWIipWkFyY1iqtisavEqdqhR1VLcgkTR
 7ql1iDLNexep3geM7ZCyI5bgNbpXNXBw8lISEvs4H7y58qkkckREz1agCIpSN/OraXSZbHqGFlj
 wJy0UA0kVeETGlmmlYQ==
X-Proofpoint-GUID: IP0Igyh51QAsfRwLDNMShgJldsw-wJ8P
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE3MDExMiBTYWx0ZWRfX8E3Oy8h0Atmc
 ib6uqTopdLCKxodwEB8dJisF4KZiGj3Ca2Hx/yEta6X+7VRhnDXrkgk5VaS9o1jaLd5H5xyh13t
 CgSNZaXiGicGM/6n81FOir22spjh94o=
X-Proofpoint-ORIG-GUID: IP0Igyh51QAsfRwLDNMShgJldsw-wJ8P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_01,2026-06-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 impostorscore=0 malwarescore=0 spamscore=0 adultscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606170112
Received-SPF: pass client-ip=148.163.158.5; envelope-from=jrossi@linux.ibm.com;
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

Hi Philippe,

This patch does not apply for me.  Is there any prerequisite for this?

On my side it fails to match the existing includes in hw/s390x/ipl.c because
system/physmem.h is not currently there, but is expected by this patch.

Also in target/s390x/diag.c the s390_ipl_write() function is not present.

Taking a quick look, it seems like you added that function in a different
series, specifically in:

[PATCH v2 4/6] target/s390x: Factor common s390_ipl_read/write() helpers

Sorry if I've missed something, but is this meant to be part of a series?

Thanks,
Jared Rossi

On 6/15/26 10:16 PM, Philippe Mathieu-Daudé wrote:
> Rather than calling a TCG specific method in s390_ipl_reset_request(),
> have handle_diag_308() return whether a vCPU reset is pending, and use
> that in the TCG DIAG helper to return to the main loop.
>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---
>   target/s390x/s390x-internal.h  |  3 ++-
>   hw/s390x/ipl.c                 |  5 -----
>   target/s390x/diag.c            | 30 +++++++++++++++++++-----------
>   target/s390x/tcg/misc_helper.c |  5 ++++-
>   4 files changed, 25 insertions(+), 18 deletions(-)
>
> diff --git a/target/s390x/s390x-internal.h b/target/s390x/s390x-internal.h
> index e7e4f2b45d4..35d1e34ef4d 100644
> --- a/target/s390x/s390x-internal.h
> +++ b/target/s390x/s390x-internal.h
> @@ -385,7 +385,8 @@ int mmu_translate_real(CPUS390XState *env, hwaddr raddr, int rw,
>   
>   /* misc_helper.c */
>   int handle_diag_288(CPUS390XState *env, uint64_t r1, uint64_t r3);
> -void handle_diag_308(CPUS390XState *env, uint64_t r1, uint64_t r3,
> +/* Return whether a CPU reset is pending */
> +bool handle_diag_308(CPUS390XState *env, uint64_t r1, uint64_t r3,
>                        uintptr_t ra);
>   
>   
> diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
> index fa50749a7d3..4cca21c6217 100644
> --- a/hw/s390x/ipl.c
> +++ b/hw/s390x/ipl.c
> @@ -18,7 +18,6 @@
>   #include "system/physmem.h"
>   #include "system/reset.h"
>   #include "system/runstate.h"
> -#include "system/tcg.h"
>   #include "elf.h"
>   #include "hw/core/loader.h"
>   #include "hw/core/qdev-properties.h"
> @@ -690,10 +689,6 @@ void s390_ipl_reset_request(CPUState *cs, enum s390_reset reset_type)
>       } else {
>           qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
>       }
> -    /* as this is triggered by a CPU, make sure to exit the loop */
> -    if (tcg_enabled()) {
> -        cpu_loop_exit(cs);
> -    }
>   }
>   
>   void s390_ipl_get_reset_request(CPUState **cs, enum s390_reset *reset_type)
> diff --git a/target/s390x/diag.c b/target/s390x/diag.c
> index 01cc802eaed..618ae41289b 100644
> --- a/target/s390x/diag.c
> +++ b/target/s390x/diag.c
> @@ -95,44 +95,49 @@ static void s390_ipl_write(CPUS390XState *env, uint64_t addr,
>       }
>   }
>   
> -void handle_diag_308(CPUS390XState *env, uint64_t r1, uint64_t r3, uintptr_t ra)
> +bool handle_diag_308(CPUS390XState *env, uint64_t r1, uint64_t r3, uintptr_t ra)
>   {
>       bool valid;
>       CPUState *cs = env_cpu(env);
>       uint64_t addr =  env->regs[r1];
>       uint64_t subcode = env->regs[r3];
>       IplParameterBlock *iplb;
> +    bool reset_requested;
>   
>       if (env->psw.mask & PSW_MASK_PSTATE) {
>           s390_program_interrupt(env, PGM_PRIVILEGED, ra);
> -        return;
> +        return false;
>       }
>   
>       if (subcode & ~0x0ffffULL) {
>           s390_program_interrupt(env, PGM_SPECIFICATION, ra);
> -        return;
> +        return false;
>       }
>   
>       if (subcode >= DIAG308_PV_SET && !s390_has_feat(S390_FEAT_UNPACK)) {
>           s390_program_interrupt(env, PGM_SPECIFICATION, ra);
> -        return;
> +        return false;
>       }
>   
> +    reset_requested = false;
>       switch (subcode) {
>       case DIAG308_RESET_MOD_CLR:
>           s390_ipl_reset_request(cs, S390_RESET_MODIFIED_CLEAR);
> +        reset_requested = true;
>           break;
>       case DIAG308_RESET_LOAD_NORM:
>           s390_ipl_reset_request(cs, S390_RESET_LOAD_NORMAL);
> +        reset_requested = true;
>           break;
>       case DIAG308_LOAD_CLEAR:
>           /* Well we still lack the clearing bit... */
>           s390_ipl_reset_request(cs, S390_RESET_REIPL);
> +        reset_requested = true;
>           break;
>       case DIAG308_SET:
>       case DIAG308_PV_SET:
>           if (diag308_parm_check(env, r1, addr, ra, false)) {
> -            return;
> +            break;
>           }
>           iplb = g_new0(IplParameterBlock, 1);
>           s390_ipl_read(env, addr, iplb, sizeof(iplb->len));
> @@ -159,11 +164,11 @@ void handle_diag_308(CPUS390XState *env, uint64_t r1, uint64_t r3, uintptr_t ra)
>           env->regs[r1 + 1] = DIAG_308_RC_OK;
>   out:
>           g_free(iplb);
> -        return;
> +        break;
>       case DIAG308_STORE:
>       case DIAG308_PV_STORE:
>           if (diag308_parm_check(env, r1, addr, ra, true)) {
> -            return;
> +            break;
>           }
>           if (subcode == DIAG308_PV_STORE) {
>               iplb = s390_ipl_get_iplb_pv();
> @@ -172,30 +177,33 @@ out:
>           }
>           if (!iplb) {
>               env->regs[r1 + 1] = DIAG_308_RC_NO_CONF;
> -            return;
> +            break;
>           }
>   
>           s390_ipl_write(env, addr, iplb, be32_to_cpu(iplb->len));
>           env->regs[r1 + 1] = DIAG_308_RC_OK;
> -        return;
> +        break;
>       case DIAG308_PV_START:
>           iplb = s390_ipl_get_iplb_pv();
>           if (!iplb) {
>               env->regs[r1 + 1] = DIAG_308_RC_NO_PV_CONF;
> -            return;
> +            break;
>           }
>   
>           if (kvm_enabled() && kvm_s390_get_hpage_1m()) {
>               error_report("Protected VMs can currently not be backed with "
>                            "huge pages");
>               env->regs[r1 + 1] = DIAG_308_RC_INVAL_FOR_PV;
> -            return;
> +            break;
>           }
>   
>           s390_ipl_reset_request(cs, S390_RESET_PV);
> +        reset_requested = true;
>           break;
>       default:
>           s390_program_interrupt(env, PGM_SPECIFICATION, ra);
>           break;
>       }
> +
> +    return reset_requested;
>   }
> diff --git a/target/s390x/tcg/misc_helper.c b/target/s390x/tcg/misc_helper.c
> index 3d13c8bd8ea..036be93fb32 100644
> --- a/target/s390x/tcg/misc_helper.c
> +++ b/target/s390x/tcg/misc_helper.c
> @@ -135,7 +135,10 @@ void HELPER(diag)(CPUS390XState *env, uint32_t r1, uint32_t r3, uint32_t num)
>       case 0x308:
>           /* ipl */
>           bql_lock();
> -        handle_diag_308(env, r1, r3, GETPC());
> +        if (handle_diag_308(env, r1, r3, GETPC())) {
> +            /* As reset is triggered by the CPU, make sure to exit the loop */
> +            cpu_loop_exit(CPU(env_archcpu(env)));
> +        }
>           bql_unlock();
>           r = 0;
>           break;


