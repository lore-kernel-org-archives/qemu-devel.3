Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4BAECCD1BE
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 07:04:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBSsj-0002yl-W1; Wed, 22 Oct 2025 03:03:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1vBSsT-0002Vw-UU; Wed, 22 Oct 2025 03:03:24 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1vBSsR-0000b8-RX; Wed, 22 Oct 2025 03:03:21 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59LMeLlV016406;
 Wed, 22 Oct 2025 07:03:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=QOLj5V
 QaUwHOEH8RL6jeG0xU7RG3kgqnclCQRhLvZMc=; b=V1899jEURJMolk++yByj1/
 tuj7iY/aO4sQ1fdjYMVjvE1ZI5KTTy9/B35iBeg7n/90jj/j16hDvTae/kjzfX3T
 A2Wbqc9sGM4ZrTXmONNwZVYDNZD9ApPr/2VUXd1j1NuFOlNzK0Zp8dzys7pUiSQ/
 NyvT0GFqWqMzB0uTtoCH2ZTugwkP94tQGUu0A1K5IGRJ58PFuHPYqhfRKQwJcuPH
 suR70FPuL+wElnV1PzwDg8PSTj9bXuobPTzkFv+Xneuiw83fByZbwMG3Y/llhaz/
 WsGvVDrJCecXPxco4y3rNrLAbDZSXg50vAjP/zXhpL0Y4UqAZyrUS7dCy9ixLMVw
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v32hhrn0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 22 Oct 2025 07:03:17 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59M73Dt8024333;
 Wed, 22 Oct 2025 07:03:17 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v32hhrmw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 22 Oct 2025 07:03:17 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59M6gI4c017058;
 Wed, 22 Oct 2025 07:03:16 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49vnkxy383-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 22 Oct 2025 07:03:16 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59M73FLY26804774
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 22 Oct 2025 07:03:15 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7D7F658063;
 Wed, 22 Oct 2025 07:03:15 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B6C9D58043;
 Wed, 22 Oct 2025 07:03:12 +0000 (GMT)
Received: from [9.79.201.141] (unknown [9.79.201.141])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
 Wed, 22 Oct 2025 07:03:12 +0000 (GMT)
Message-ID: <27da22c4-6212-4ff9-8f11-e04b35039a2b@linux.ibm.com>
Date: Wed, 22 Oct 2025 12:33:09 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/11] hw/ppc/spapr: Inline spapr_dtb_needed()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
References: <20251021084346.73671-1-philmd@linaro.org>
 <20251021084346.73671-5-philmd@linaro.org>
 <602c19bc-bed9-43c2-b98c-491b75921604@linux.ibm.com>
 <d264c81b-119e-439f-a4c2-68a7336d6ba6@linaro.org>
Content-Language: en-US
From: Chinmay Rath <rathc@linux.ibm.com>
In-Reply-To: <d264c81b-119e-439f-a4c2-68a7336d6ba6@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfX2I0X0TmC3bRo
 k9dU7S0E50pNSj4qkxHWC4ACpm5oesDmxtRaoLDzueUN44XDV7bM2dsLuMadGH1c9eCBIXHywpZ
 XGcmDrbB/1R1gC31nN/t06TNaNxDCW91b0QrjM5JkjfttMAPspikEuf0uEkKr8Io9QVS2RWeZtq
 29Gg8rIswTFaHLTueXrRerGQSoKM8RLjamp/5qrbIeKfMX9C4EUrAZQ0NS9+NGUjwNj8e2ik3V/
 QGNeaY1OSsQk7RQpYskCuOqoMqhtEiDK+RNyDY/lWHpH45t34izljkRLsQd5V5B5gL/sTO2Q9sn
 AU9Zd7H25ATXYl1m3cassb//sYg226wMG50sXBiZxBkVYmirAXo8OVNAIXcxafNvouxoQFUfHrn
 d85DbodhKkV0cXJx6L/OoytZgIYtag==
X-Authority-Analysis: v=2.4 cv=OrVCCi/t c=1 sm=1 tr=0 ts=68f881b5 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KKAkSRfTAAAA:8 a=MvvTU35B-mzZJSykrPEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: swkTMFdgntB-3iu97LvVOF7k4NDyeK2l
X-Proofpoint-ORIG-GUID: LC3uRKAJMFZE3SgYcC_85cXVAQLOsIDl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 priorityscore=1501 spamscore=0 phishscore=0
 clxscore=1015 bulkscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022
Received-SPF: pass client-ip=148.163.158.5; envelope-from=rathc@linux.ibm.com;
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


On 10/21/25 19:51, Philippe Mathieu-Daudé wrote:
> On 21/10/25 15:25, Chinmay Rath wrote:
>> Hey Philippe,
>> The commit message says that this commit is inline-ing 
>> spapr_dtb_needed(), but it is actually removing it. I think it's 
>> better to convey that in the commit message.
>> Or did I miss something ?
>>
>> On 10/21/25 14:13, Philippe Mathieu-Daudé wrote:
>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>> ---
>>>   hw/ppc/spapr.c | 6 ------
>>>   1 file changed, 6 deletions(-)
>>>
>>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
>>> index 458d1c29b4d..ad9fc61c299 100644
>>> --- a/hw/ppc/spapr.c
>>> +++ b/hw/ppc/spapr.c
>>> @@ -2053,11 +2053,6 @@ static const VMStateDescription 
>>> vmstate_spapr_irq_map = {
>>>       },
>>>   };
>>> -static bool spapr_dtb_needed(void *opaque)
>>> -{
>>> -    return true; /* backward migration compat */
>>> -}
>>> -
>>>   static int spapr_dtb_pre_load(void *opaque)
>>>   {
>>>       SpaprMachineState *spapr = (SpaprMachineState *)opaque;
>>> @@ -2073,7 +2068,6 @@ static const VMStateDescription 
>>> vmstate_spapr_dtb = {
>>>       .name = "spapr_dtb",
>>>       .version_id = 1,
>>
>> Does this version number need to be incremented ?
>
> No, this is a no-op.
>
>>
>> Regards,
>> Chinmay
>>
>>>       .minimum_version_id = 1,
>>> -    .needed = spapr_dtb_needed,
>
> Here is the inlining, as '.needed = true' is the default.
Ahh I see.
> Would "Inline and remove spapr_dtb_needed()" be clearer?
Yeah that'd be nice.

Thanks,
Chinmay
>
>>>       .pre_load = spapr_dtb_pre_load,
>>>       .fields = (const VMStateField[]) {
>>>           VMSTATE_UINT32(fdt_initial_size, SpaprMachineState),
>
>

