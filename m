Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78E23C28B2E
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 04:45:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trrUh-0007T1-5L; Tue, 11 Mar 2025 00:45:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1trrUb-0007Nf-EC; Tue, 11 Mar 2025 00:45:25 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1trrUZ-0003tW-0p; Tue, 11 Mar 2025 00:45:24 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52AKFaZA015904;
 Tue, 11 Mar 2025 04:45:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=LajnrS
 /1Wa3grPNup+fHgHi1uhPVm1ZDfF/l5qszRPo=; b=NIgDxzrmgz7/PGWS8XwZCI
 GDpkaOVsnRir6+d1SWKtEQkfnPRfGAcWRuacAQEsuIdzrei50SpE7XkrYJhV0S6R
 URPh6kDMcMeLIcGn3b9FLBiE/bHHyqPbuqKLX6MNbOL3HZYHAzIcqKLwTZuI2BUp
 GaOy0f/eoSEA9nT72LqeCS6heFjGlmA44/sfa1FDnBAGoTPH2hgQ4DR0Ww00JhIy
 HKvWsIO5K2Ji9tmFXBFICqTcwRi3Zvh3ip6mgcRf3P0om4iX+rZDNzJoimJCZ1iS
 /cl+oNh8h+VRZdlL/vtDdTyqtG/xZvNTK8Ri7NPCYEsN0Z3kjqk2d3wiUFXcAotA
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45a1gp3pjn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 11 Mar 2025 04:45:20 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 52B4jJvC029760;
 Tue, 11 Mar 2025 04:45:20 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45a1gp3pjj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 11 Mar 2025 04:45:19 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52B3F63S014921;
 Tue, 11 Mar 2025 04:45:19 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4592ek9y85-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 11 Mar 2025 04:45:19 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 52B4jH2112517948
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 11 Mar 2025 04:45:17 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7614458063;
 Tue, 11 Mar 2025 04:45:17 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C68BC58059;
 Tue, 11 Mar 2025 04:45:14 +0000 (GMT)
Received: from [9.109.242.165] (unknown [9.109.242.165])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 11 Mar 2025 04:45:14 +0000 (GMT)
Message-ID: <2ef62054-7362-42a6-82c9-6fe7c3225a52@linux.ibm.com>
Date: Tue, 11 Mar 2025 10:15:13 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] hw/ppc: Implement S0 SBE interrupt as cpu_pause then
 host reset
To: Aditya Gupta <adityag@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?= <fbarrat@linux.ibm.com>,
 Sourabh Jain <sourabhjain@linux.ibm.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Hari Bathini <hbathini@linux.ibm.com>
References: <20250217071934.86131-1-adityag@linux.ibm.com>
 <20250217071934.86131-3-adityag@linux.ibm.com>
Content-Language: en-US
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <20250217071934.86131-3-adityag@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: NK-C4JVEINC9wsrFGlmcEXCWY-C16ISI
X-Proofpoint-ORIG-GUID: sQPRqeyMME1Mn2qHs-q9sJ9FkmBpVQ_W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-11_01,2025-03-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 clxscore=1015
 mlxlogscore=999 suspectscore=0 spamscore=0 impostorscore=0 bulkscore=0
 phishscore=0 malwarescore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503110028
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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



On 2/17/25 12:49, Aditya Gupta wrote:
> SBE's implementation of S0 seems to be basically "stop all clocks" and
> then "host reset"
> 
> Nearest equivalent to the stop clocks seems to be 'pause_all_vcpus' in
> QEMU,
> 
> Then reset the host, which is 'SHUTDOWN_CAUSE_GUEST_RESET' in QEMU.
> 
> Implement the S0 interrupt as pause_vcpus + guest_reset
> 
> See 'stopClocksS0' in SBE source code for more information.
> 
> Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
> ---
>   hw/ppc/pnv_sbe.c | 50 +++++++++++++++++++++++++++++++++++++++---------
>   1 file changed, 41 insertions(+), 9 deletions(-)
> 
> diff --git a/hw/ppc/pnv_sbe.c b/hw/ppc/pnv_sbe.c
> index 62c94a04a2df..a6bf13650f2d 100644
> --- a/hw/ppc/pnv_sbe.c
> +++ b/hw/ppc/pnv_sbe.c
> @@ -21,6 +21,8 @@
>   #include "qapi/error.h"
>   #include "qemu/log.h"
>   #include "qemu/module.h"
> +#include "system/cpus.h"
> +#include "system/runstate.h"
>   #include "hw/irq.h"
>   #include "hw/qdev-properties.h"
>   #include "hw/ppc/pnv.h"
> @@ -80,6 +82,15 @@
>   #define SBE_CONTROL_REG_S0              PPC_BIT(14)
>   #define SBE_CONTROL_REG_S1              PPC_BIT(15)
>   
> +static void pnv_sbe_set_host_doorbell(PnvSBE *sbe, uint64_t val)
> +{
> +    val &= SBE_HOST_RESPONSE_MASK; /* Is this right? What does HW do? */
> +    sbe->host_doorbell = val;
> +
> +    trace_pnv_sbe_reg_set_host_doorbell(val);
> +    qemu_set_irq(sbe->psi_irq, !!val);
> +}
> +
>   struct sbe_msg {
>       uint64_t reg[4];
>   };
> @@ -104,6 +115,7 @@ static uint64_t pnv_sbe_power9_xscom_ctrl_read(void *opaque, hwaddr addr,
>   static void pnv_sbe_power9_xscom_ctrl_write(void *opaque, hwaddr addr,
>                                          uint64_t val, unsigned size)
>   {
> +    PnvSBE *sbe = opaque;
>       uint32_t offset = addr >> 3;
>   
>       trace_pnv_sbe_xscom_ctrl_write(addr, val);
> @@ -113,6 +125,35 @@ static void pnv_sbe_power9_xscom_ctrl_write(void *opaque, hwaddr addr,
>           switch (val) {
>           case SBE_CONTROL_REG_S0:
>               qemu_log_mask(LOG_UNIMP, "SBE: S0 Interrupt triggered\n");
> +
> +            pnv_sbe_set_host_doorbell(sbe, sbe->host_doorbell | SBE_HOST_RESPONSE_MASK);
> +
> +            /*
> +             * Looks like, SBE stops clocks for all cores in S0.
> +             * See 'stopClocksS0' in SBE source code.
> +             * Nearest equivalent in QEMU seems to be 'pause_all_vcpus'
> +             */
> +            pause_all_vcpus();
> +
> +            /*
> +             * TODO: Pass `mpipl` node in device tree to signify next
> +             * boot is an MPIPL boot
> +             */
> +
> +            /* Then do a guest reset */
> +            /*
> +             * Requirement:
> +             * This guest reset should not clear the memory (which is
> +             * the case when this is merged)

This comment may need a rephrase. Also, if we are keeping an assumption 
that SHUTDOWN_CAUSE_GUEST_RESET should not clear the memory, it may be 
better to put a comment about this wherever it is handled as well.

> +             */
> +            qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
> +
> +            /*
> +             * XXX: Does SBE really do system reset or only stop
> +             * clocks ? OPAL seems to think that control will not come
> +             * to it after it has triggered S0 interrupt.
> +             */
> +
>               break;
>           case SBE_CONTROL_REG_S1:
>               qemu_log_mask(LOG_UNIMP, "SBE: S1 Interrupt triggered\n");
> @@ -138,15 +179,6 @@ static const MemoryRegionOps pnv_sbe_power9_xscom_ctrl_ops = {
>       .endianness = DEVICE_BIG_ENDIAN,
>   };
>   
> -static void pnv_sbe_set_host_doorbell(PnvSBE *sbe, uint64_t val)
> -{
> -    val &= SBE_HOST_RESPONSE_MASK; /* Is this right? What does HW do? */
> -    sbe->host_doorbell = val;
> -
> -    trace_pnv_sbe_reg_set_host_doorbell(val);
> -    qemu_set_irq(sbe->psi_irq, !!val);
> -}
> -

Code movement like above could be a separate patch, not necessary though.
Patch 1 can be squashed with this one.

Thanks
Harsh
>   /* SBE Target Type */
>   #define SBE_TARGET_TYPE_PROC            0x00
>   #define SBE_TARGET_TYPE_EX              0x01

