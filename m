Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2B68C25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2024 07:11:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCZvc-0000pf-9K; Thu, 30 May 2024 03:10:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1sCZvW-0000oV-Kf; Thu, 30 May 2024 03:10:20 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1sCZvT-00048p-DE; Thu, 30 May 2024 03:10:17 -0400
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 44U6YS9R009688; Thu, 30 May 2024 07:10:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc :
 content-transfer-encoding : content-type : date : from : in-reply-to :
 message-id : mime-version : references : subject : to; s=pp1;
 bh=Fn/s79XWa+s8/h5/8r8DOhGUZZQ6a18PMbVPAMPLJ3Y=;
 b=bP5jxDTSWbmM4j8GNdXBoGpDvkfA5VJYCTlzLO/rU3Wl8c9c5Zk/ehP6xNfPoRtwmrug
 38Oz7sjO5z9I7RGtlBB540npkR1CQm2N72Own5AF/+GIqX5DbEGWoSh4F9f/kEC+zDy7
 aL15A3wmZbJxW/I4a5VmT+yLYTdc9pJIwY9s5OpGp4qAqd3AXw3xke0z/KpwoJnPUyab
 RLobsVIzwfZBn+Q12Vn/Y64LCSpypfckBIueR8oN3kVqniPDmWhfbjh+SlIlInSL3IH6
 PV4RxPjxXH55GK79S6M4w3LtfHUejGv3SEVHehd5GH12ogWqbiZ/FDyxH/mJ9kagipyo RA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yejnhga9x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 30 May 2024 07:10:02 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44U7A2HC001007;
 Thu, 30 May 2024 07:10:02 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yejnhga7x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 30 May 2024 07:10:01 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 44U4nwAC002437; Thu, 30 May 2024 07:07:07 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3ydpb0rhr8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 30 May 2024 07:07:07 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 44U773A727329086
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 30 May 2024 07:07:06 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9C2AA58059;
 Thu, 30 May 2024 07:07:03 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 99F6A5805D;
 Thu, 30 May 2024 07:07:00 +0000 (GMT)
Received: from [9.109.242.165] (unknown [9.109.242.165])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 30 May 2024 07:07:00 +0000 (GMT)
Message-ID: <d584063b-a30e-46f0-a69e-4737c8d6d46a@linux.ibm.com>
Date: Thu, 30 May 2024 12:36:59 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/11] ppc/pseries: Add Power11 cpu type
To: Aditya Gupta <adityag@linux.ibm.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?= <fbarrat@linux.ibm.com>
References: <20240528070515.117160-1-adityag@linux.ibm.com>
 <20240528070515.117160-3-adityag@linux.ibm.com>
Content-Language: en-US
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <20240528070515.117160-3-adityag@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: VWwmW1Eb2Fe50FZ6YqbIlGEEO74enbjw
X-Proofpoint-ORIG-GUID: vhfuWYaPWEG10lxpJ9xXbW7MRHZ4pr3P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-30_04,2024-05-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0
 impostorscore=0 bulkscore=0 phishscore=0 mlxscore=0 adultscore=0
 priorityscore=1501 clxscore=1015 suspectscore=0 lowpriorityscore=0
 spamscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2405010000 definitions=main-2405300051
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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



On 5/28/24 12:35, Aditya Gupta wrote:
> Add sPAPR CPU Core definition for Power11
> 
> Cc: David Gibson <david@gibson.dropbear.id.au> (reviewer:sPAPR (pseries))
> Cc: Harsh Prateek Bora <harshpb@linux.ibm.com> (reviewer:sPAPR (pseries))
> Cc: Cédric Le Goater <clg@kaod.org>
> Cc: Daniel Henrique Barboza <danielhb413@gmail.com>
> Cc: Frédéric Barrat <fbarrat@linux.ibm.com>
> Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>
> Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
> ---
>   docs/system/ppc/pseries.rst | 6 +++---
>   hw/ppc/spapr_cpu_core.c     | 1 +
>   2 files changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/docs/system/ppc/pseries.rst b/docs/system/ppc/pseries.rst
> index a876d897b6e4..3277564b34c2 100644
> --- a/docs/system/ppc/pseries.rst
> +++ b/docs/system/ppc/pseries.rst
> @@ -15,9 +15,9 @@ Supported devices
>   =================
>   
>    * Multi processor support for many Power processors generations: POWER7,
> -   POWER7+, POWER8, POWER8NVL, POWER9, and Power10. Support for POWER5+ exists,
> -   but its state is unknown.
> - * Interrupt Controller, XICS (POWER8) and XIVE (POWER9 and Power10)
> +   POWER7+, POWER8, POWER8NVL, POWER9, Power10 and Power11. Support for POWER5+
> +   exists, but its state is unknown.
> + * Interrupt Controller, XICS (POWER8) and XIVE (POWER9, Power10, Power11)

I think it would look more cleaner to rephrase as below:

  * Multi processor support for many Power processors generations:
    - POWER7, POWER7+
    - POWER8, POWER8NVL
    - POWER9
    - Power10
    - Power11.
    - Support for POWER5+ exists, but its state is unknown.
  * Interrupt Controller
     - XICS (POWER8)
     - XIVE (Supported by below:)
         - POWER9
         - Power10
         - Power11

So, that every next platform just need to add one line for itself.

With that,
Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>

Thanks
Harsh
>    * vPHB PCIe Host bridge.
>    * vscsi and vnet devices, compatible with the same devices available on a
>      PowerVM hypervisor with VIOS managing LPARs.
> diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
> index e7c9edd033c8..62416b7e0a7e 100644
> --- a/hw/ppc/spapr_cpu_core.c
> +++ b/hw/ppc/spapr_cpu_core.c
> @@ -401,6 +401,7 @@ static const TypeInfo spapr_cpu_core_type_infos[] = {
>       DEFINE_SPAPR_CPU_CORE_TYPE("power9_v2.0"),
>       DEFINE_SPAPR_CPU_CORE_TYPE("power9_v2.2"),
>       DEFINE_SPAPR_CPU_CORE_TYPE("power10_v2.0"),
> +    DEFINE_SPAPR_CPU_CORE_TYPE("power11_v2.0"),
>   #ifdef CONFIG_KVM
>       DEFINE_SPAPR_CPU_CORE_TYPE("host"),
>   #endif

