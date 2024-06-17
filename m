Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9D4DC27C79
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2024 10:30:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJ9ci-0004Io-FG; Mon, 17 Jun 2024 06:30:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1sJ9cg-0004Ht-M4; Mon, 17 Jun 2024 06:30:02 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1sJ9ce-0000t9-Ko; Mon, 17 Jun 2024 06:30:02 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45H9T6Hn005800;
 Mon, 17 Jun 2024 10:29:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 message-id:date:mime-version:subject:from:to:cc:references
 :in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=H
 bg16WI04v47UKfFFp0AX2POCDpT6QzGGOT9Hi+14JA=; b=abeMjo2p/zIyqHNci
 wNPtpbCFgPHv2zrcJXap8MjbUyK4KuE48eOQbAKJ0uwNx36Q25+xXpup07BdK0WT
 jFZuxHGXeFT3kPW55nroiKqKz9yJLjBquS2/q2dLl5YrBPm1EX2QCD2IGTIIvvYv
 d6szAxfWiYZLacttHB36RNpN/8MoBAFk7wGHnxkPYVFEaKpyCluVBwVbqqTlB7OW
 BABMbEPRc/8FgpREKklellvgkgonN0QlROustmq+HkZDgLOmpIXHe+UX7M0txHwa
 IwCncvXB52VU7R1W6TEoFafOCT8iYQ8q+LnJHwiBmW8p1dKNZUbpUej2W11OZbVe
 vtiNQ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ytjj305jh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 17 Jun 2024 10:29:47 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45HAP1Nc030722;
 Mon, 17 Jun 2024 10:29:46 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ytjj305jd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 17 Jun 2024 10:29:46 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 45H9DWPV019500; Mon, 17 Jun 2024 10:29:45 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3ysnp0s9a5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 17 Jun 2024 10:29:45 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 45HATgNK30343702
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 17 Jun 2024 10:29:45 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AE68158063;
 Mon, 17 Jun 2024 10:29:42 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1AA145803F;
 Mon, 17 Jun 2024 10:29:39 +0000 (GMT)
Received: from [9.124.223.158] (unknown [9.124.223.158])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 17 Jun 2024 10:29:38 +0000 (GMT)
Message-ID: <3563b5bc-3af3-4235-9373-29712b79b3da@linux.ibm.com>
Date: Mon, 17 Jun 2024 15:59:37 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/26] hw/ppc: Avoid using Monitor in
 pnv_phb3_msi_pic_print_info()
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?= <fbarrat@linux.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
References: <20240610062105.49848-1-philmd@linaro.org>
 <20240610062105.49848-2-philmd@linaro.org>
 <81d3ec2b-2fec-4412-843a-159952dcd79d@linux.ibm.com>
 <5fa7e414-efc6-4051-8472-a4f90263b106@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <5fa7e414-efc6-4051-8472-a4f90263b106@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Ufm-BHyaHO6eDIkuYzPzBI1BmbKbRhp5
X-Proofpoint-ORIG-GUID: XNUXS2zFge9Nrk9uhRHHVNLljSjxH5D4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-17_08,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 lowpriorityscore=0 spamscore=0 clxscore=1015 bulkscore=0 mlxscore=0
 impostorscore=0 adultscore=0 malwarescore=0 mlxlogscore=999 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406170080
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H3=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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



On 6/17/24 15:49, Harsh Prateek Bora wrote:
> Hi Phillipe,
> 
> One query below:
> 
> On 6/17/24 15:41, Harsh Prateek Bora wrote:
>>
>>
>> On 6/10/24 11:50, Philippe Mathieu-Daudé wrote:
>>> Replace Monitor API by HumanReadableText one.
>>>
>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>
>> Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
>>
>>> ---
>>>   include/hw/pci-host/pnv_phb3.h |  2 +-
>>>   hw/pci-host/pnv_phb3_msi.c     | 21 ++++++++++-----------
>>>   hw/ppc/pnv.c                   |  8 +++++++-
>>>   3 files changed, 18 insertions(+), 13 deletions(-)
>>>
> 
> <snip>
> 
>>> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
>>> index 6e3a5ccdec..5356a4e295 100644
>>> --- a/hw/ppc/pnv.c
>>> +++ b/hw/ppc/pnv.c
>>> @@ -38,6 +38,7 @@
>>>   #include "hw/loader.h"
>>>   #include "hw/nmi.h"
>>>   #include "qapi/visitor.h"
>>> +#include "qapi/type-helpers.h"
>>>   #include "monitor/monitor.h"
>>>   #include "hw/intc/intc.h"
>>>   #include "hw/ipmi/ipmi.h"
>>> @@ -774,8 +775,13 @@ static void 
>>> pnv_chip_power8_pic_print_info(PnvChip *chip, Monitor *mon)
>>>       for (i = 0; i < chip8->num_phbs; i++) {
>>>           PnvPHB *phb = chip8->phbs[i];
>>>           PnvPHB3 *phb3 = PNV_PHB3(phb->backend);
>>> +        g_autoptr(GString) buf = g_string_new("");
>>> +        g_autoptr(HumanReadableText) info = NULL;
>>> +
>>> +        pnv_phb3_msi_pic_print_info(&phb3->msis, buf);
>>> +        info = human_readable_text_from_str(buf);
>>> +        monitor_puts(mon, info->human_readable_text);
>>> -        pnv_phb3_msi_pic_print_info(&phb3->msis, mon);
>>>           ics_pic_print_info(&phb3->lsis, mon);
> 
> How is the memory allocated to info in human_readable_text_from_str 
> being reclaimed here? Isnt it a mem leak ?
> 
Ok, I see, g_autoptr takes care of auto cleanup. Please ignore.

> Thanks
> Harsh
> 
>>>       }
>>>   }
>>

