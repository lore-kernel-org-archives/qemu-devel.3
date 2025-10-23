Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65DBCCCD193
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 08:45:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBqwv-0006wQ-C4; Thu, 23 Oct 2025 04:45:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vBqwh-0006vZ-W6; Thu, 23 Oct 2025 04:45:20 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vBqwf-00023O-JU; Thu, 23 Oct 2025 04:45:19 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59N3lUkm027999;
 Thu, 23 Oct 2025 08:45:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=vvtvKS
 DDg12TR54quXLVVns2KlYZLB7SZKs0n0Bbi0s=; b=qV7cAHTS3CL75b52HryEb1
 kJqK0MrvoX46W8fgGiPowUE3PNlkUgel4d2G8fmODZpQWPUvBGCGVNUUMe47AwJt
 W59UyahUyGV04fT1XWGX1qsOsW0lR/3R7NiB5MFQFCIHZIhDNzzrZRqLF7uKDOlv
 HaCyweoNCXFiaFUCrTDM7OuYH90tS+v4VgBkXJ7vPdx/1MX6a9yExYMiac1jGesI
 nDm3gMWEwls8VLQG7154ANDcVeKd0MbG6bftY8pfG/PYVjIopRorxfYJzBpy9fBs
 6Wrfnm9GuLIYLNpc7YCuf76eTR626b/7YipvbFOxI1xsBGm39vMU/MA9CZWJs+Hg
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v327177f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Oct 2025 08:45:11 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59N8hTcv027689;
 Thu, 23 Oct 2025 08:45:11 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v327177b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Oct 2025 08:45:10 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59N65Qv1024690;
 Thu, 23 Oct 2025 08:45:09 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49vpqk4s5u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Oct 2025 08:45:09 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59N8j94e25297460
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 23 Oct 2025 08:45:09 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 266B058059;
 Thu, 23 Oct 2025 08:45:09 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 22D4258063;
 Thu, 23 Oct 2025 08:45:07 +0000 (GMT)
Received: from [9.124.221.73] (unknown [9.124.221.73])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 23 Oct 2025 08:45:06 +0000 (GMT)
Message-ID: <0b12701a-827f-4f17-969b-5da124cd2e36@linux.ibm.com>
Date: Thu, 23 Oct 2025 14:15:05 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 08/12] hw/ppc/pegasos2: Move hardware specific parts
 out of machine reset
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Markus Armbruster <armbru@redhat.com>
References: <cover.1761176219.git.balaton@eik.bme.hu>
 <f6633a68a72aad4fefb8d2373b52561f8ca8d41d.1761176219.git.balaton@eik.bme.hu>
 <ee9b01ab-fd91-453e-b1d3-1a91d9447a2a@linaro.org>
Content-Language: en-US
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <ee9b01ab-fd91-453e-b1d3-1a91d9447a2a@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=EJELElZC c=1 sm=1 tr=0 ts=68f9eb17 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=f7IdgyKtn90A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=YMFv762I7AkAACKW-JIA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
 a=cPQSjfK2_nFv0Q5t_7PE:22 a=oH34dK2VZjykjzsv8OSz:22 a=Z5ABNNGmrOfJ6cZ5bIyy:22
 a=jd6J4Gguk5HxikPWLKER:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfXzIIyXmFxSC8d
 AfjDUbi3G0ajS8baAX9y8Ssu/WIQAgG4gQu8kYJ7L9jf+5PVP/bdWCk9WvkgIOXo05ki4HOZbhl
 kbEWzzhtJm22O1w3OdyV973atW7QHEYDf1u69AQb0nJiezrEzAB17cG7HM6h+2ATMcOR+zKGGkO
 xWPdgV/syuOb8xfPGoShvObHaCiSSCP8C3cNATqEJ01mhUMzveVxwDJoIrqIBabLV5SwhEI1JMe
 jJv/YOC6RLNxAZeJJ12vwrbiGYsJHCfeNiGzK9PLVakOAmsW9sWX4dC8owhMYYH3diALDM5iRTX
 kWW0ndHWB0TmlsQlklBEeYX81jOqS/ByRVgYEdYvMWHThYhbuMInNlxAb2bBauDBBkbtwr15atA
 v80FAjwEI92JlLF1RbSmL1NdO+d3qg==
X-Proofpoint-GUID: yy2GzmSr5kvlJaXpru2dqWPwHyZZYYSy
X-Proofpoint-ORIG-GUID: MS8mv9RuZzLimWVS0SjM3dTdTIAxykIe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 spamscore=0
 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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



On 10/23/25 12:16, Philippe Mathieu-Daudé wrote:
> On 23/10/25 02:06, BALATON Zoltan wrote:
>> Move the pegasos2 specific chipset reset out from machine reset to a
>> separate function and move generic parts that are not pegasos2
>> specific from build_fdt to machine reset so now build_fdt only
>> contains pegasos2 specific parts and can be renamed accordingly.
>>
>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>> ---
>>   hw/ppc/pegasos2.c | 79 ++++++++++++++++++++++++-----------------------
>>   1 file changed, 41 insertions(+), 38 deletions(-)
> 
> 
>> -#define PCI1_IO_BASE  0xfe000000
> 
> Can't we keep such definition?
> 
>> @@ -308,23 +307,12 @@ static void 
>> pegasos2_pci_config_write(Pegasos2MachineState *pm, int bus,
>>   static void pegasos2_superio_write(uint8_t addr, uint8_t val)
>>   {
>> -    cpu_physical_memory_write(PCI1_IO_BASE + 0x3f0, &addr, 1);
>> -    cpu_physical_memory_write(PCI1_IO_BASE + 0x3f1, &val, 1);
>> +    cpu_physical_memory_write(0xfe0003f0, &addr, 1);
>> +    cpu_physical_memory_write(0xfe0003f1, &val, 1);
> 
> Otherwise it is harder to notice we are accessing the MMIO mapped ISA 
> space.
> 
>>   }
> Consider renaming as pegasos_superio_write() since this method becomes
> common to PegasOS I and II.

Thanks Philippe for reviewing the series.

Hi BALATON,
Would you mind addressing the above (and other?) review comments or I 
can queue it in the interest of time if you can send a follow-up patch 
later?

Thanks
Harsh

> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 

