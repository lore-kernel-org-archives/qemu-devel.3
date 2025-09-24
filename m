Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E237CAC5A5
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 12:15:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1OOq-0003OG-VV; Wed, 24 Sep 2025 08:15:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ganeshgr@linux.ibm.com>)
 id 1v1OOW-0003BM-H8; Wed, 24 Sep 2025 08:14:52 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ganeshgr@linux.ibm.com>)
 id 1v1OOM-0007H5-5T; Wed, 24 Sep 2025 08:14:45 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58O4q0Pq015979;
 Wed, 24 Sep 2025 12:14:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=bmFSH5
 gKLeJ0ECRwMAaw601S78Ne37KqaOCKIp0XjnY=; b=XT/PLngfQ/zzmFFC3sCH2+
 D3e9HQe7dX/pMDKwGdwYPvpwtALrl5v759Pg+lYp7iaXVGbqCL9TrDi3ivJL3Uzw
 zrYpyhC0WIV/ux32CNSb+5PkuyByeFVpiaAysa64wj3S20q/L+E+eI+5IXdH77Jr
 7NqwOOJsJVrr8eUqk9bpcbvdHU82ggfRWdDXK17FXgyKzxn4WBjbVZBJRXSM7P61
 bqa6cVJD47ovY4U93jB3STQ6p4E3Qz+HDpP65OOV8YP30t9N58jZLUgyvq3HX0Mu
 pTpZMpcvR6sEhsb7RwBZhM9fVzcbgoL/zU5+BEkAxCEg/kWPKYnPLzZVKGckjaDA
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 499ky67bbb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 24 Sep 2025 12:14:25 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58OCEOLl014614;
 Wed, 24 Sep 2025 12:14:24 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 499ky67bb6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 24 Sep 2025 12:14:24 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58O9up9J013592;
 Wed, 24 Sep 2025 12:14:23 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 49a8tjg8tb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 24 Sep 2025 12:14:23 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 58OCEKK760621116
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 24 Sep 2025 12:14:20 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2192020049;
 Wed, 24 Sep 2025 12:14:20 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2261020040;
 Wed, 24 Sep 2025 12:14:18 +0000 (GMT)
Received: from [9.98.111.232] (unknown [9.98.111.232])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 24 Sep 2025 12:14:17 +0000 (GMT)
Message-ID: <f22953e3-5e87-4c86-844a-aba5c35ca3ca@linux.ibm.com>
Date: Wed, 24 Sep 2025 17:44:16 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Access to remote XIVE2 units (was Re: [PATCH v9 0/7] Power11
 support for QEMU [PowerNV])
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Aditya Gupta <adityag@linux.ibm.com>
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, Glenn Miles <milesg@linux.ibm.com>,
 gautam@linux.ibm.com
References: <20250808115929.1073910-1-adityag@linux.ibm.com>
 <baf6c854-832b-4a2e-922f-d34e6dadf821@redhat.com>
 <yo6uk5z6dlq4jlk5hsaoyhymozdpo6ijpq5bz4fipkf5ftws4b@um57vsttgf65>
 <wdkarichs5jrmpz3k4gxosw42dt6qxwodnc6t6tcuecsmxgqcd@km4q644fiixb>
 <04eb08b6-b787-47f3-86b7-b2d3a0f50ed6@redhat.com>
 <utzcz3bpixqmviolacg7qv2f526tedqovvx6wcrl6ypk3v4v7w@nmjtwot6lhjs>
 <3456f764-616b-412c-839c-aaef4bf1e47c@redhat.com>
Content-Language: en-US
From: Ganesh G R <ganeshgr@linux.ibm.com>
In-Reply-To: <3456f764-616b-412c-839c-aaef4bf1e47c@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: WTJGjx1hSaOeEox7RwgUiJDHUS274_r6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAyMCBTYWx0ZWRfX8xiUXweA+Q8x
 szCwtETowPpwcuE9Oj1BvYlOgqS4DU1mOAiRDn6lzApBErQnAgpqj8dBkkCDP65Sj9wie+H7ydZ
 wv0tp6pafG87Ecyj2XxqxplNIDwt6WHTTEI24TAE1z5wmOsDyzSbY62BMhloat0o4jzZT1pfodv
 4kkY9y9xXCGnrl0/nLNbc/eO9B3yP6Y2mg64Ohp2CqHlJtFgdfBuHLbZNMjAqNCM/sLd5c6V1WK
 ynlKEIt/8NVIFNHliuX8x/evNAaRQaM1S7pACAhdJ35prhV6oXPXIRJvKEM1IlRmcXt1m4RD0/+
 R/HT4e4y+0vetI7eUst5me2LMjPIWVRAawuINHroLn8VPIpJf3vGDM6b2B3us8+YqYWlxhp2wpW
 OGtst2Gi
X-Authority-Analysis: v=2.4 cv=XYGJzJ55 c=1 sm=1 tr=0 ts=68d3e0a1 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=8Su4eGmFbs7b5p4w14gA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 7o-bU4dZfr8FFvplpu0sb0vLUM7rHADg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_03,2025-09-22_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 clxscore=1011 adultscore=0 malwarescore=0
 suspectscore=0 impostorscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200020
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=ganeshgr@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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


On 8/29/25 3:19 AM, Cédric Le Goater wrote:
> On 8/28/25 14:04, Aditya Gupta wrote:
>> + Ganesh
>>
>> On 25/08/10 02:46PM, Cédric Le Goater wrote:
>>> + Glenn
>>> + Gautam
>>>
>>> On 8/10/25 12:45, Aditya Gupta wrote:
>>>> On 25/08/10 12:26PM, Aditya Gupta wrote:
>>>>>> <...snip...>
>>>>>
>>>>> About the error, seems xive2 always expecting powernv10 chip, I will
>>>>> have to rethink how should I use the same xive2 for powernv11.
>>>>>
>>>>
>>>> There's a type cast to Pnv10Chip in 'pnv_xive2_get_remote'.
>>>> The cast is only temporarily used to get the 'PnvXive2' object in the
>>>> Pnv10Chip.
>>>> It's the only place in hw/intc/pnv_xive2.c assuming Pnv10Chip object.
>>>>
>>>> Thinking to have a helper function to just return the 'PnvXive2' object
>>>> inside the chip, given a 'PnvChip'.
>>>>
>>>> Or the below change where we are adding another pointer in 
>>>> PnvChipClass:
>>>>
>>>>       diff --git a/hw/intc/pnv_xive2.c b/hw/intc/pnv_xive2.c
>>>>       index e019cad5c14c..9832be5fd297 100644
>>>>       --- a/hw/intc/pnv_xive2.c
>>>>       +++ b/hw/intc/pnv_xive2.c
>>>>       @@ -110,8 +110,8 @@ static PnvXive2 
>>>> *pnv_xive2_get_remote(uint32_t vsd_type, hwaddr fwd_addr)
>>>>            int i;
>>>>            for (i = 0; i < pnv->num_chips; i++) {
>>>>       -        Pnv10Chip *chip10 = PNV10_CHIP(pnv->chips[i]);
>>>>       -        PnvXive2 *xive = &chip10->xive;
>>>>       +        PnvChipClass *k = PNV_CHIP_GET_CLASS(pnv->chips[i]);
>>>>       +        PnvXive2 *xive = k->intc_get(pnv->chips[i]);
>>>>                /*
>>>>                 * Is this the XIVE matching the forwarded VSD 
>>>> address is for this
>>>>
>>>> Which one do you suggest ? Or should I look for another way ?
>>>>
>>>> I am preferring the first way to have a helper, but both ways look 
>>>> hacky.
>>>
>>> Any call to qdev_get_machine() in device model is at best
>>> a modeling shortcut, most likely it is a hack :
>>>
>>>    /*
>>>     * Remote access to INT controllers. HW uses MMIOs(?). For now, a 
>>> simple
>>>     * scan of all the chips INT controller is good enough.
>>>     */
>>>
>>> So all these calls are suspicious :
>>>
>>>    $ git grep qdev_get_machine hw/*/*pnv*
>>>    hw/intc/pnv_xive2.c:    PnvMachineState *pnv = 
>>> PNV_MACHINE(qdev_get_machine());
>>>    hw/pci-host/pnv_phb.c:    PnvMachineState *pnv = 
>>> PNV_MACHINE(qdev_get_machine());
>>>    hw/pci-host/pnv_phb3.c:    PnvMachineState *pnv = 
>>> PNV_MACHINE(qdev_get_machine());
>>>    hw/ppc/pnv.c:    PnvMachineState *pnv = 
>>> PNV_MACHINE(qdev_get_machine());
>>>    hw/ppc/pnv.c:    PnvMachineState *pnv = 
>>> PNV_MACHINE(qdev_get_machine());
>>>    hw/ppc/pnv_chiptod.c:    PnvMachineState *pnv = 
>>> PNV_MACHINE(qdev_get_machine());
>>>    hw/ppc/pnv_chiptod.c:    PnvMachineState *pnv = 
>>> PNV_MACHINE(qdev_get_machine());
>>>    hw/ppc/pnv_lpc.c:    PnvMachineState *pnv = 
>>> PNV_MACHINE(qdev_get_machine());
>>>
>>> In the particular case of XIVE2, the solution is to rework
>>> pnv_xive2_get_remote() like it was for P9. See b68147b7a5bf
>>> ("ppc/xive: Add support for the PC MMIOs").
>>>
>>
>> Hi Cedric,
>>
>> While I am working with XIVE engineers to get the pnv_xive2_get_remote()
>> reworked as suggested (since it's a bit more work due to multiple cases
>> of indirect/direct vst, nvg/nvc types in case of XIVE2), I would like
>> to propose below patch to have as an interim solution to unblock
>> the PowerNV11 support patches.
> 
> pHyp is an unknown FW implementation for opensource. Until an image
> is released somewhere (please think about it), QEMU has nothing to
> worry about other than supporting OPAL.
> 
> For now, let's forget about the grouping aspect of XIVE2, simply
> rework pnv_xive2_get_remote() as it was done in b68147b7a5bf for
> XIVE. This shouldn't take long. And, for the nvg/nvc types, report
> an error of some sort and add a TODO in the code.
> 
A similar change cannot be done to XIVE2, because Fredric’s commit 
(96a2132ce95) has introduced modifications to the NVPG and NVC MMIO 
callbacks in order to support backlog counter operations.
>>
>> Please let me know if it looks good to you.
> 
> It's a hack. So please try the above first.
> 
> 
> Thanks,
> 
> C.
> 


