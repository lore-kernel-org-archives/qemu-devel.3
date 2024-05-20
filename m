Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3E84C04FFE
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2024 07:49:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s8xl4-0007i2-5m; Mon, 20 May 2024 03:48:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1s8xin-0007Zf-EE; Mon, 20 May 2024 03:46:17 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1s8xiR-0001MX-Pt; Mon, 20 May 2024 03:45:54 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 44K684BO008783; Mon, 20 May 2024 07:45:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=wBIvWsaepa1p2+9tCxUutohzmFRMvefe5SF1brLdbks=;
 b=YaifVjXm2X5IbqWDUAwLzdsZL4B0JresNGNWnk7THBBtkazqvLHPSl4SzfDwxIxVLH0J
 5+dKbAo52+w+NDudDDsW+fDDQRfS/uBzg0D3A1xz15Tj61gShD8iMPwn5P0DTTwvkMhf
 yD6zBNjZlnJ53FmIggUwJc+MT4oibqrtCC37KASCXIWFb+ID3LNkQaGIrdc9OrY29Wll
 MnUatV/t1Xtekw38cl5wAGi87THxbLuFlz6qHIG3va4c98rZtyDG7eZLohQbEueRP0eI
 vctJ3sVExiVGsg2J1uduM2AhEPQK9K+jpP95jDs0j3vvn+MZQ7UwHUjzXGojEBLRbvvY jg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3y80ypg68s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 20 May 2024 07:45:40 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44K7jeWF025395;
 Mon, 20 May 2024 07:45:40 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3y80ypg68q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 20 May 2024 07:45:40 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 44K7Oh9u008216; Mon, 20 May 2024 07:45:39 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3y78vkp85a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 20 May 2024 07:45:39 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 44K7jaCI24969826
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 20 May 2024 07:45:38 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6107858069;
 Mon, 20 May 2024 07:45:34 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A73B15805D;
 Mon, 20 May 2024 07:45:30 +0000 (GMT)
Received: from [9.124.209.219] (unknown [9.124.209.219])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 20 May 2024 07:45:30 +0000 (GMT)
Message-ID: <f0ad2844-eccd-4bb2-9aa9-42bd2f08e1c2@linux.ibm.com>
Date: Mon, 20 May 2024 13:15:29 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ppc/spapr: Add ibm,pi-features
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>, qemu-devel@nongnu.org
References: <20240518095641.408598-1-npiggin@gmail.com>
Content-Language: en-US
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <20240518095641.408598-1-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: kLTfGdLuXi1Iusw_puDH5wdgyWrdaWab
X-Proofpoint-ORIG-GUID: vioNq-4lTWanEwayck5fcfjID6jcwRH_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-20_04,2024-05-17_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 mlxlogscore=960 clxscore=1015 bulkscore=0 suspectscore=0 adultscore=0
 malwarescore=0 spamscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2405010000 definitions=main-2405200063
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=-0.01,
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



On 5/18/24 15:26, Nicholas Piggin wrote:
> The ibm,pi-features property has a bit to say whether or not
> msgsndp should be used. Linux checks if it is being run under
> KVM and avoids msgsndp anyway, but it would be preferable to
> rely on this bit.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>

> ---
>   hw/ppc/spapr.c | 27 +++++++++++++++++++++++++++
>   1 file changed, 27 insertions(+)
> 
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 611a9e5184..6891d91e6e 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -353,6 +353,31 @@ static void spapr_dt_pa_features(SpaprMachineState *spapr,
>       _FDT((fdt_setprop(fdt, offset, "ibm,pa-features", pa_features, pa_size)));
>   }
>   
> +static void spapr_dt_pi_features(SpaprMachineState *spapr,
> +                                 PowerPCCPU *cpu,
> +                                 void *fdt, int offset)
> +{
> +    uint8_t pi_features[] = { 1, 0,
> +        0x00 };
> +
> +    if (kvm_enabled() && ppc_check_compat(cpu, CPU_POWERPC_LOGICAL_3_00,
> +                                          0, cpu->compat_pvr)) {
> +        /*
> +         * POWER9 and later CPUs with KVM run in LPAR-per-thread mode where
> +         * all threads are essentially independent CPUs, and msgsndp does not
> +         * work (because it is physically-addressed) and therefore is
> +         * emulated by KVM, so disable it here to ensure XIVE will be used.
> +         * This is both KVM and CPU implementation-specific behaviour so a KVM
> +         * cap would be cleanest, but for now this works. If KVM ever permits
> +         * native msgsndp execution by guests, a cap could be added at that
> +         * time.
> +         */
> +        pi_features[2] |= 0x08; /* 4: No msgsndp */
> +    }
> +
> +    _FDT((fdt_setprop(fdt, offset, "ibm,pi-features", pi_features, sizeof(pi_features))));
> +}
> +
>   static hwaddr spapr_node0_size(MachineState *machine)
>   {
>       if (machine->numa_state->num_nodes) {
> @@ -815,6 +840,8 @@ static void spapr_dt_cpu(CPUState *cs, void *fdt, int offset,
>   
>       spapr_dt_pa_features(spapr, cpu, fdt, offset);
>   
> +    spapr_dt_pi_features(spapr, cpu, fdt, offset);
> +
>       _FDT((fdt_setprop_cell(fdt, offset, "ibm,chip-id",
>                              cs->cpu_index / vcpus_per_socket)));
>   

