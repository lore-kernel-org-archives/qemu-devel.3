Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD999CCFA1E
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Nov 2025 12:34:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vI4bu-00041r-1H; Sun, 09 Nov 2025 07:33:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vI4bs-00041X-LN; Sun, 09 Nov 2025 07:33:32 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vI4bq-0003uX-Hh; Sun, 09 Nov 2025 07:33:32 -0500
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A9BNCLN024397;
 Sun, 9 Nov 2025 12:33:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=QZqQun
 wrBlU9rMT1pJ4J+98wBhQPoOskst/3ayw2aAE=; b=GX++CT36JBrz/bhi6yZNrJ
 lLlPvtN2Vh7F8qs0mynoh/WnQSRw9NGiF0Ekq1U9NkC2ugWJSTBTy4VmDPCgNlxJ
 la9+qG7iZS7FM1yBW+GNRTzrjV/oB+lFNJmlMhQ2ma1sm+EnGTymTyxquTOUF/vO
 GtWu7lcpkJS64ampnFK1LKwQBUJ7yFZlhUyaWRaWybpigPpjW842mzcdz7YdSsBY
 2dThH9+Tvxbdnetd0V9VSHMsdpWwbZheX+zcHbXQgLr6DJCBgdMgeCxaqivWp0+L
 Va1IMrTog4MgqpvCf/jnP6/u+orbSFnoHy0eZHcVkVriuKgXOZm5J456ETsmls+w
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a9wgwkjru-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 09 Nov 2025 12:33:23 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5A9CXNRP014443;
 Sun, 9 Nov 2025 12:33:23 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a9wgwkjrs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 09 Nov 2025 12:33:23 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5A96feYJ015685;
 Sun, 9 Nov 2025 12:33:22 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4aag6s1n6v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 09 Nov 2025 12:33:22 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5A9CXLVJ6685662
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 9 Nov 2025 12:33:22 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E1C7958059;
 Sun,  9 Nov 2025 12:33:21 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0436858058;
 Sun,  9 Nov 2025 12:33:20 +0000 (GMT)
Received: from [9.124.217.7] (unknown [9.124.217.7])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Sun,  9 Nov 2025 12:33:19 +0000 (GMT)
Message-ID: <63b6e52e-2eb1-4d11-bfda-7048848bcba8@linux.ibm.com>
Date: Sun, 9 Nov 2025 18:03:17 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/ppc/pegasos: Fix memory leak
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20251101165236.76E8B5972E3@zero.eik.bme.hu>
 <078c2da0-ac1e-4f07-a777-d8615a4456bd@linux.ibm.com>
 <5cabe3a8-77a0-b21d-8b73-bbbea049930c@eik.bme.hu>
Content-Language: en-US
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <5cabe3a8-77a0-b21d-8b73-bbbea049930c@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: CFM443oYlkQl6qjBe82CwzjDIQ66ieFj
X-Proofpoint-ORIG-GUID: ew3JCPkUe4LFam1J6f4TFJMk67rIx-t_
X-Authority-Analysis: v=2.4 cv=VMPQXtPX c=1 sm=1 tr=0 ts=69108a14 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=f7IdgyKtn90A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=qR2lUGp8mXKy_qIG50gA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
 a=oH34dK2VZjykjzsv8OSz:22 a=pHzHmUro8NiASowvMSCR:22 a=n87TN5wuljxrRezIQYnT:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA4MDAyMiBTYWx0ZWRfX0OnvDbsWDHez
 iOdNfbFUeDISOG767n8EsTsDV8Rsn+McfgIbM9iQgPdy9WtcHxPviAOd8dIBvbC1KGl3oAfUFHt
 jVHg0iWW7hHlhCTel33TyI0eEEycohuBw3WWG4n8SEyExRFxgf13+QZAjPLTGfub3eo9PhWyRxp
 8N3nXVEvpawRJY4UtE8lMD2yvlyqe3tuIbnhCejw03BKYghZVnFN1PAJbRR2k68oqaXGpLeoa0f
 cx+3Nf00cZGZTGOH1huUTgLMqogBOJ04Lv859K1ObjPAPYwjaZSoSkN/nzQwZdTznZ8qc/jhuG1
 eA+iwKqnGpO7pVemZkqmvbEM8gzXYEmm3Nn2DcdyfqARWlYsGomoDuDEijQsjAflDczemf5G8em
 3V+sCURw8ruxNvY0wmMHMRd1KZTicg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-09_05,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 clxscore=1015 phishscore=0 spamscore=0 malwarescore=0 adultscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2511080022
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



On 11/3/25 18:03, BALATON Zoltan wrote:
> On Mon, 3 Nov 2025, Harsh Prateek Bora wrote:
>> Hi Balaton,
>>
>> Thanks for taking care of this ...
>>
>> On 11/1/25 22:22, BALATON Zoltan wrote:
>>> Commit 9099b430a4 introduced an early return that caused a leak of a
>>> GString. Allocate it later to avoid the leak.
>>>
>>
>> I think we also want to mention:
>>
>> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> 
> You can add it on merge.
> 
>>> Fixes: 9099b430a4 (hw/ppc/pegasos2: Change device tree generation)
>>> Resolves: Coverity CID 1642027
>>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>>> ---
>>>   hw/ppc/pegasos.c | 3 ++-
>>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/hw/ppc/pegasos.c b/hw/ppc/pegasos.c
>>> index 3a498edd16..8ce185de3e 100644
>>> --- a/hw/ppc/pegasos.c
>>> +++ b/hw/ppc/pegasos.c
>>> @@ -847,7 +847,7 @@ static struct {
>>>   static void add_pci_device(PCIBus *bus, PCIDevice *d, void *opaque)
>>>   {
>>>       FDTInfo *fi = opaque;
>>> -    GString *node = g_string_new(NULL);
>>> +    GString *node;
>>
>> Curious to know if there were any technical reasons for not using 
>> g_autoptr which Peter initially suggested ?
> 
> Just thought it's simpler and more straight forward this way and saves a 
> bit of unnecessary complication. We don't even allocate the string now 
> when we exit, with g_autoptr it might do some additional operations 
> unnecessarily. As this function otherwise does not have multiple exit 
> points just one free at the end works.

Queued, thanks.

