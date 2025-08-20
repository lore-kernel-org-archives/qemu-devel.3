Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45197CA0EE4
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Aug 2025 15:03:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uokKj-0000g6-1V; Wed, 20 Aug 2025 11:02:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jjherne@linux.ibm.com>)
 id 1uokKg-0000fd-85; Wed, 20 Aug 2025 11:02:34 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jjherne@linux.ibm.com>)
 id 1uokKd-0003n6-V5; Wed, 20 Aug 2025 11:02:33 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57KD1ZVT002714;
 Wed, 20 Aug 2025 15:01:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=L7pmuD
 loL7QiNuvhA1RIK1MW0iKKwLd7FADqtCZ8FYo=; b=RjGe3d0jHsKPaKOufoq7bp
 I9//Pbczi8vdtciHtPq5RK6EHITy4Bj++lm09EPcC88/qRyFjq4N2zwFdQGI6DHM
 hhvVYpV9zqBDYfJ3hOR8vpt2p1OWhEDxAAfjyj7tFooWiNYrTEsTlyLz94+B5Qnc
 Da2fVHKtRrK5LwunYGCVBcpdF1naRCwX72HJEiiGPnGt+MxhdrHMoMNecp2zo9Op
 pkMcqY9eiStM8RdlpcR50ftVNRs05xkMJbLj1nqdnzx1aPVeCSjG033nNUJgCQQY
 9YS/jLAxJWhCN2l4koRXnQICoafVGtsGma/Pkvt2A6MpviOlmraa0pvCmJWdlPHw
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48n38w3j7b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 20 Aug 2025 15:01:21 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 57KEwlJr009991;
 Wed, 20 Aug 2025 15:01:21 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48n38w3j77-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 20 Aug 2025 15:01:20 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57KDiN3L016030;
 Wed, 20 Aug 2025 15:01:19 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 48my423u4n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 20 Aug 2025 15:01:19 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 57KF1IWs10486570
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 20 Aug 2025 15:01:18 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9456F58056;
 Wed, 20 Aug 2025 15:01:18 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D7CC358052;
 Wed, 20 Aug 2025 15:01:15 +0000 (GMT)
Received: from [9.67.56.11] (unknown [9.67.56.11])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 20 Aug 2025 15:01:15 +0000 (GMT)
Message-ID: <2d7317bc-e2cd-4f92-8956-4122f0860a49@linux.ibm.com>
Date: Wed, 20 Aug 2025 11:01:13 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/8] add cpu_test_interrupt()/cpu_set_interrupt()
 helpers and use them tree wide
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, mtosatti@redhat.com,
 richard.henderson@linaro.org, riku.voipio@iki.fi, thuth@redhat.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, david@redhat.com,
 shorne@gmail.com, eduardo@habkost.net, marcel.apfelbaum@gmail.com,
 philmd@linaro.org, wangyanan55@huawei.com, zhao1.liu@intel.com,
 peter.maydell@linaro.org, agraf@csgraf.de, mads@ynddal.dk,
 mrolnik@gmail.com, deller@gmx.de, dirty@apple.com, rbolshakov@ddn.com,
 phil@philjordan.eu, reinoud@netbsd.org, sunilmut@microsoft.com,
 gaosong@loongson.cn, laurent@vivier.eu, edgar.iglesias@gmail.com,
 aurelien@aurel32.net, jiaxun.yang@flygoat.com, arikalo@gmail.com,
 chenhuacai@kernel.org, npiggin@gmail.com, rathc@linux.ibm.com,
 harshpb@linux.ibm.com, yoshinori.sato@nifty.com, iii@linux.ibm.com,
 mark.cave-ayland@ilande.co.uk, atar4qemu@gmail.com,
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org
References: <20250814160600.2327672-1-imammedo@redhat.com>
 <20250814160600.2327672-7-imammedo@redhat.com>
Content-Language: en-US
From: "Jason J. Herne" <jjherne@linux.ibm.com>
In-Reply-To: <20250814160600.2327672-7-imammedo@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE5MDIyMiBTYWx0ZWRfXxLVhDEEK8Gcx
 DY1O/Rp+ajCx+NeZtNPUpOlZOSq0Lj91plrBXO51Fwzc9PZ/46UsTAUeLEeDnH9yCDs4/R5P8dO
 IoBC/MSejvZ39PoHIrvL66BQX7z5VflKSGZ6z9poFka1NPlF0Qs0X8KupXoi6jAx7IbkJDvto20
 yrqbfVlaNIcUYFRQiMR6YRpTkoOzS2FMrT8/9xLMQXd4bnd/fl+jDRKMQRPP2oxo7B5xLKQC6qk
 ohBu5vlUnezUegqfJ+3gfVCqznBN6fBRmOBIr1fdnlCiYBumcG5m8fLz+gN/T5yeMefzjBJecCY
 RbOx9Fxm7y/rAymQR1Vd7MIqK+Jzjwjib2Ed/Rg/POjY+d8+5cK9GxBaQc0GaHJn5wthOlPwpEI
 8zDhPIBIlmc63HGZR7UfoMLu4GlJYA==
X-Authority-Analysis: v=2.4 cv=H62CA+Yi c=1 sm=1 tr=0 ts=68a5e341 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8
 a=zre5T78YCiVeWXPNGbMA:9 a=QEXdDO2ut3YA:10 a=DXsff8QfwkrTrK3sU8N1:22
 a=Z5ABNNGmrOfJ6cZ5bIyy:22 a=bWyr8ysk75zN3GCy5bjg:22
X-Proofpoint-ORIG-GUID: l_-5ExWbyp6IuZ7oB36suJHYHedP5R3n
X-Proofpoint-GUID: S8361Dw_ohTqAb-Vc8F7VouHiGFdXfoY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-20_04,2025-08-20_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 suspectscore=0 bulkscore=0 adultscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2508110000
 definitions=main-2508190222
Received-SPF: pass client-ip=148.163.158.5; envelope-from=jjherne@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 8/14/25 12:05 PM, Igor Mammedov wrote:
> the helpers form load-acquire/store-release pair and use them to replace
> open-coded checkers/setters consistently across the code, which
> ensures that appropriate barriers are in place in case checks happen
> outside of BQL.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
> v4:
>     add cpu_set_interrupt() and merge helpers patch with
>     patches that use them (v3 6-7,9/10).
>         Peter Xu <peterx@redhat.com>
> 
> CC: mst@redhat.com
> ...
> 
> diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
> index 5eaf41a566..3e233ff6de 100644
> --- a/include/hw/core/cpu.h
> +++ b/include/hw/core/cpu.h
> @@ -942,6 +942,31 @@ CPUState *cpu_by_arch_id(int64_t id);
>   
>   void cpu_interrupt(CPUState *cpu, int mask);
>   
> +/**
> + * cpu_test_interrupt:
> + * @cpu: The CPU to check interrupt(s) on.
> + * @mask: The interrupts to check.
> + *
> + * Checks if any of interrupts in @mask are pending on @cpu.
> + */
> +static inline bool cpu_test_interrupt(CPUState *cpu, int mask)
> +{
> +    return qatomic_load_acquire(&cpu->interrupt_request) & mask;
> +}
> +
> +/**
> + * cpu_set_interrupt:
> + * @cpu: The CPU to set pending interrupt(s) on.
> + * @mask: The interrupts to set.
> + *
> + * Checks if any of interrupts in @mask are pending on @cpu.
> + */

Copy paste error, comment description for 'set' appears to be for the 
'test' variant. :)

> ...
>   
> diff --git a/hw/intc/s390_flic.c b/hw/intc/s390_flic.c
> index 8f4c9fd52e..1eed5125d1 100644
> --- a/hw/intc/s390_flic.c
> +++ b/hw/intc/s390_flic.c
> @@ -190,7 +190,7 @@ static void qemu_s390_flic_notify(uint32_t type)
>       CPU_FOREACH(cs) {
>           S390CPU *cpu = S390_CPU(cs);
>   
> -        cs->interrupt_request |= CPU_INTERRUPT_HARD;
> +        cpu_set_interrupt(cs, CPU_INTERRUPT_HARD);
>   
>           /* ignore CPUs that are not sleeping */
>           if (s390_cpu_get_state(cpu) != S390_CPU_STATE_OPERATING &&

Looks good wrt s390-flic.

Reviewed-by: Jason J. Herne <jjherne@linux.ibm.com>

