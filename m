Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5A2FC83F1B
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 08:01:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubx4Q-0004pN-9I; Wed, 16 Jul 2025 04:00:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1ubx2o-0002pR-9C; Wed, 16 Jul 2025 03:59:15 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1ubx2m-0006FG-4y; Wed, 16 Jul 2025 03:59:14 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56FKklIw028640;
 Wed, 16 Jul 2025 07:59:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=ukfKa1
 iT4hL1qsyz+xCd+6rLrePLr+7wYtJoY8FIgEU=; b=oz0a68Ulyv+tAMnD3HiuQA
 1OumAR0K6NKSprWC+OAbI60on6IIwFSZPmJZvYVqyJBlujVw72svYq4jo4gfo2zF
 Hv3EI9GtHvFusTXlE/QN8L16scWwuLbWDC1GCMKLnqPRoVtzx5FRp7ol9TTMXSsS
 y2vb5F+3DwJ1ys473++i3tpLVF3tx63ntPzN4EavPtH9UQzjY762DpxpcpBzovom
 PkanZPcSIqlg2wJTygAPlODruDBT0Rv1FAccEZ6D92xm9vooIOn2wegoWe5L+NEg
 0DaozpA76ottAdfpnmxBiEHAEGT5UuKB8Aj0HedtfxQhtmQIUAX/qgt93S9YKTbw
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47ue4u3mva-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 16 Jul 2025 07:59:07 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 56G7kljV027183;
 Wed, 16 Jul 2025 07:59:07 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47ue4u3mv7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 16 Jul 2025 07:59:07 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56G6oLlP008988;
 Wed, 16 Jul 2025 07:59:06 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47v3hmp845-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 16 Jul 2025 07:59:06 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 56G7x5Rf58982868
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 16 Jul 2025 07:59:05 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1E6E959572;
 Wed, 16 Jul 2025 07:59:05 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 353165956E;
 Wed, 16 Jul 2025 07:58:34 +0000 (GMT)
Received: from [9.39.30.73] (unknown [9.39.30.73])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 16 Jul 2025 07:58:33 +0000 (GMT)
Message-ID: <ab24bf11-9caa-4cc3-b73a-c73c4806e3b7@linux.ibm.com>
Date: Wed, 16 Jul 2025 13:28:31 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/22] ppc/spapr_pci_vfio.c: use QOM casts where
 appropriate
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>, npiggin@gmail.com,
 danielhb413@gmail.com, mjrosato@linux.ibm.com, farman@linux.ibm.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, thuth@redhat.com,
 richard.henderson@linaro.org, david@redhat.com, iii@linux.ibm.com,
 john.levon@nutanix.com, thanos.makatos@nutanix.com,
 alex.williamson@redhat.com, clg@redhat.com, steven.sistare@oracle.com,
 tomitamoeko@gmail.com, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
References: <20250715093110.107317-1-mark.caveayland@nutanix.com>
 <20250715093110.107317-6-mark.caveayland@nutanix.com>
Content-Language: en-US
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <20250715093110.107317-6-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=baBrUPPB c=1 sm=1 tr=0 ts=68775bcc cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=f7IdgyKtn90A:10 a=64Cc0HZtAAAA:8
 a=VnNF1IyMAAAA:8 a=pZxzsNv_FdmNLOEf19IA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: HLuZIN2-cYg8UnjPpdXUSUr5vRcbNdmM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE2MDA2OSBTYWx0ZWRfXwuEiJ95N88SL
 3n2oQe/3XuH62sntlPUA6UavUsIUCh0XRCWfU5vF0QJpIf80cztn4PUXkSgRDRSr5f2dbuU31v/
 2ohGS4Gc5l7PwkXl790ZYTVVOnf0iq8+qEoiSQbZQT+wzepMw+V6VHbvPzwKMTevwol0pwJLI2o
 FGcdYRzs9BGbwumuhnJ85Ez16m7KkTAL2KoRqd+SFG0jMTBRujUqodNB/8kRb0uwIVGDJJnmZg9
 vhfrlQZrwQwTK7UEaoz73e9fNBK4cH89ZbZqIVmf4WwVQECSzgFnS4V3b8Vn94luzrgwVYSdahi
 l8vv1tpDVOpvIdzSzIti22kj2FxIAdzIwDe+y2oPtL6dsoStwbtCU8HFnez6i//5W9g3AXkohWa
 7dXRmBSIVEre5MLrHtjPxv9siLvLAEpzEuaR7MeImk6HDLygzr02agw2eWIZUNtEcos6frwa
X-Proofpoint-ORIG-GUID: WY8clEZpJqf2vGQYw8uubWjjLetibSBs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-16_01,2025-07-15_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 mlxlogscore=910
 suspectscore=0 adultscore=0 impostorscore=0 phishscore=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1011 mlxscore=0
 malwarescore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507160069
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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



On 7/15/25 14:55, Mark Cave-Ayland wrote:
> Use a QOM cast to convert to VFIOContainer instead of accessing bcontainer
> directly.
> 
> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>

Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>

> ---
>   hw/ppc/spapr_pci_vfio.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/ppc/spapr_pci_vfio.c b/hw/ppc/spapr_pci_vfio.c
> index e318d0d912..7e1c71ef59 100644
> --- a/hw/ppc/spapr_pci_vfio.c
> +++ b/hw/ppc/spapr_pci_vfio.c
> @@ -106,7 +106,7 @@ static VFIOContainer *vfio_eeh_as_container(AddressSpace *as)
>   
>   out:
>       vfio_address_space_put(space);
> -    return container_of(bcontainer, VFIOContainer, bcontainer);
> +    return VFIO_IOMMU_LEGACY(bcontainer);
>   }
>   
>   static bool vfio_eeh_as_ok(AddressSpace *as)

