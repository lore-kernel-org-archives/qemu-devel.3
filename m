Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA046C87FCF
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Aug 2025 05:26:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujt8X-0002U6-Ki; Thu, 07 Aug 2025 01:25:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1ujt8N-0002T4-25; Thu, 07 Aug 2025 01:25:48 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1ujt8K-0002fx-19; Thu, 07 Aug 2025 01:25:45 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 576Nrv7r023502;
 Thu, 7 Aug 2025 05:25:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=ug9YVX
 aeJsZKBsZijvodkd5AaWmbi1t3VeJINTUMJK0=; b=n6jLerppu1MzTZGxVeyoVU
 LVaaciibjjPTVtZJi9f6lyY66obwRhkgKoD9pj/GxVIPrHLFHY1Segy83RSP3da3
 ZU4zQffbOJoylSXSzxx8YwwyAzuZz6nfWTIuRdGBEScxuPI7UCfM3Z29D0D6fyeU
 yreJM7K2Yv0pBAJGQZpaisvzuj1cjYYRLQexTk6QFKaQu12AHa+IlKBAOqOMgLwW
 i1OWOw/lKDNK9ZH0Rp0wIn5FPHqhRUuz4on1xigjvFa/Vdk09LDGCAZSaxordcl/
 wn1GtIvA5dj+UIIC+2uQyB4AtCZ2+AGLX2UNNn2finZC5Tu9/ZkSXjfYoUUr8GHQ
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48bq6383r7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 07 Aug 2025 05:25:40 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5775KEB7028874;
 Thu, 7 Aug 2025 05:25:39 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48bq6383r5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 07 Aug 2025 05:25:39 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5775AcdB031307;
 Thu, 7 Aug 2025 05:25:39 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 48bpwnf2u2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 07 Aug 2025 05:25:39 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5775PcZ19110268
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 7 Aug 2025 05:25:38 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 03B715805C;
 Thu,  7 Aug 2025 05:25:38 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 761635805A;
 Thu,  7 Aug 2025 05:25:35 +0000 (GMT)
Received: from [9.109.242.24] (unknown [9.109.242.24])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  7 Aug 2025 05:25:35 +0000 (GMT)
Message-ID: <7038f65f-bd4b-4cb5-b2ef-4398c2bacc5b@linux.ibm.com>
Date: Thu, 7 Aug 2025 10:55:33 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/pci-host: PowerNV PCIe Device On Small PHB Seg Faults
To: milesg@linux.ibm.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Cc: kowal@linux.ibm.com, saif.abrar@linux.ibm.com, npiggin@gmail.com,
 Aditya Gupta <adityag@linux.ibm.com>, Gautam Menghani
 <gautam@linux.ibm.com>, "sbhat@linux.ibm.com" <sbhat@linux.ibm.com>
References: <20250716165017.2770845-1-milesg@linux.ibm.com>
 <957b82100001831432cd29fc3af5f022c14018c7.camel@linux.ibm.com>
 <901dc082099e720001d852ec34943bf4149db759.camel@linux.ibm.com>
Content-Language: en-US
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <901dc082099e720001d852ec34943bf4149db759.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA3MDAzNCBTYWx0ZWRfXz7YjF3ZngnHQ
 XaAn/ediWukblot3M6zl9nSMlrnQXFyuCgbohY+7pEwRmxxGAuJiktL1ucR/NQzPMJxcvukpBPj
 IRYcNI+xqs6evMezl1+qjLJsFFXUAqHe3P9WKE4gW2juPwjvRE4HDqTwADa2aGLqjkKpH0WOM/M
 fztT4/bUKLNlK8t3ZwbEHLo/MrMCqYp+PeS277wQhGTrKz+PnOb8+B3ovsQXbBmppNq7H+aMQLW
 PoIoHXZzPKLG/dazN0y66wlAMC6ABEecvTI0Hw7oKxFrJHjAJk8C619Efbv3aTUocDM4T5++emR
 9DF7wl/T6Tulesm9MufVO2JkQI5xfgVL2/cgrDCl87GvhilQBSr2Mni9UWWrA437rTfpit15cPY
 Q1XfpU7i/gZuSGCH7PLnqjR9qmLEKHBOcIEqjgywQb+sTDMIo//iesc7xt6Ha+dwcOujI59j
X-Proofpoint-GUID: gPlJjkhz98UMRr1xcL3go-N7brxAA1xy
X-Authority-Analysis: v=2.4 cv=PoCTbxM3 c=1 sm=1 tr=0 ts=689438d4 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=f7IdgyKtn90A:10 a=69wJf7TsAAAA:8
 a=VnNF1IyMAAAA:8 a=e5cm_O2kpKgzDTzN5h4A:9 a=QEXdDO2ut3YA:10
 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-ORIG-GUID: CxUhmUup9lnp9pnjTDf4Ny8wnQ4N8Ddn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-06_05,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 adultscore=0 clxscore=1015 bulkscore=0
 priorityscore=1501 impostorscore=0 mlxlogscore=999 mlxscore=0 phishscore=0
 lowpriorityscore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2507300000
 definitions=main-2508070034
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
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

+ adding folks working in this area to help with review.

On 8/7/25 02:31, Miles Glenn wrote:
> +harsh
> 
> On Wed, 2025-07-16 at 12:24 -0500, Miles Glenn wrote:
>> +qemu-ppc@nongnu.org
>>
>> On Wed, 2025-07-16 at 11:50 -0500, Glenn Miles wrote:
>>> The PowerNV PCI Host Bridge (PHB) supports a large and small
>>> configuration where the small configuration supports only
>>> half the number of interrupts supported by the large configuration.
>>>
>>> Since the PCIe LSIs are allocated at the end of the PHB IRQ list,
>>> when calculating the LSI IRQ number, the code must take into
>>> consideration the number of IRQ's supported by the PHB.  This
>>> was not happening and was resulting in a QEMU segmentation fault
>>> when a PCI device was added to a PHB with the small configuration.
>>>
>>> Signed-off-by: Glenn Miles <milesg@linux.ibm.com>
>>> ---
>>>   hw/pci-host/pnv_phb4.c | 2 ++
>>>   1 file changed, 2 insertions(+)
>>>
>>> diff --git a/hw/pci-host/pnv_phb4.c b/hw/pci-host/pnv_phb4.c
>>> index 18992054e8..aeb2a45b4b 100644
>>> --- a/hw/pci-host/pnv_phb4.c
>>> +++ b/hw/pci-host/pnv_phb4.c
>>> @@ -1167,6 +1167,7 @@ static int pnv_phb4_map_irq(PCIDevice *pci_dev, int irq_num)
>>>   static void pnv_phb4_set_irq(void *opaque, int irq_num, int level)
>>>   {
>>>       PnvPHB4 *phb = PNV_PHB4(opaque);
>>> +    XiveSource *xsrc = &phb->xsrc;
>>>       uint32_t lsi_base;
>>>   
>>>       /* LSI only ... */
>>> @@ -1175,6 +1176,7 @@ static void pnv_phb4_set_irq(void *opaque, int irq_num, int level)
>>>       }
>>>       lsi_base = GETFIELD(PHB_LSI_SRC_ID, phb->regs[PHB_LSI_SOURCE_ID >> 3]);
>>>       lsi_base <<= 3;
>>> +    lsi_base &= xsrc->nr_irqs - 1;
>>>       qemu_set_irq(phb->qirqs[lsi_base + irq_num], level);
>>>   }
>>>   
> 

