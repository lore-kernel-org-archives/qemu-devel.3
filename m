Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 440E2E66880
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Dec 2025 17:32:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWeK3-0003V1-M8; Fri, 19 Dec 2025 12:31:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1vWeJt-0003Tv-5c; Fri, 19 Dec 2025 12:31:13 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1vWeJo-0006V5-Ev; Fri, 19 Dec 2025 12:31:11 -0500
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BJAJKgC004104;
 Fri, 19 Dec 2025 17:31:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=2P6ISm
 dTBPMIM6LTrhH0Hh58wCcW9dGrj1POvEwDyxo=; b=KWoyKnA0GbaPmBOAo19CUE
 osXp43A1g4nemfGSsUjINox/Ds7N9hj7AFkp1jKxifVt13cHYOQQL6fJ/XCd3p1x
 p29oW/izlpXRAp+CuN4cTapkM21P8UbwhVBExo3zJ3DCnOgKJeE42/S4ER+TREDp
 rDDuMllnEzfZQyOaA3lxccEdhsazMo3CUQ88ST1Y3sKn12hWx47EWrQVL44AbGJx
 g6nQAAanfM1LrK/RhcNpYmO4L2qoGVNaSNaOBV5spn+m3XtyFyMBVUY8LeJS7F0o
 pa5XWjezecsEC4/RDwttrRIj4JeW5ftDsmcOHo8aenpj5FjHVYyRT26N0O4HnCQg
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b4r3amwn7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 19 Dec 2025 17:31:02 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5BJFUKts003187;
 Fri, 19 Dec 2025 17:31:01 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4b4qvumyag-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 19 Dec 2025 17:31:01 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5BJHV1rV61604302
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 19 Dec 2025 17:31:01 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 489505804E;
 Fri, 19 Dec 2025 17:31:01 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2BB8E5803F;
 Fri, 19 Dec 2025 17:31:00 +0000 (GMT)
Received: from [9.61.253.47] (unknown [9.61.253.47])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 19 Dec 2025 17:31:00 +0000 (GMT)
Message-ID: <f23ec136-5b6f-45b2-a6f1-1668e58a4030@linux.ibm.com>
Date: Fri, 19 Dec 2025 09:30:58 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] util/vfio-helper: Fix endianess when enabling Bus
 Master
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: mjrosato@linux.ibm.com, thuth@redhat.com, stefanha@redhat.com,
 kwolf@redhat.com, fam@euphon.net, alex@shazbot.org
References: <20251217184253.1520-1-alifm@linux.ibm.com>
 <4d7e4040-349e-4772-bdf9-43d4f8a6f771@redhat.com>
 <0c3e13e1-0aeb-47f9-9c44-5af8f3f47055@linaro.org>
 <970d3a1a-408f-4bf3-b6da-784f8e6bd66a@redhat.com>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <970d3a1a-408f-4bf3-b6da-784f8e6bd66a@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: TalnviYTL3OzB-7t0YzSihHqXdrUfd9L
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE5MDE0MCBTYWx0ZWRfX5NkilTqspOAh
 5oM+PFIiVngKKlPhSM8CRtYmYG2CJ/gQU6VNAEW9Dqx3o7gk9BjaBQ+hIu/RmfxfDif3M8qzewe
 nhNuBz/fiBwnLANLf+TcUW3HaFJxxeKhLsFxgu1tpILTA6GIGVj4TrSFbQvOAK6TA2wGAYvo2n6
 VvFv88hY0Nrr0lr2i/deVEX8bPjc8+A9AU+9z7lOsGBpEOqM8vVspQdCXPbvngQvniE6MI88ozm
 2gy/oeDp3OXfG5kd6fBBz/TFov828V+s8i58ZLg7ujJIlkH78VtCl8fxtDE89RWNnOZfV+6uRHF
 KwCLJJzfxS3m0G6RsYuMxePk7Gh1LAtvUqEfmmlCN4rE/LDWgNhJkZbd13ZfOny0xH/mQCPqXlZ
 /MGyBXdNX99WoWpQeAbnVM0blAZS+rLRrmzszySLX04E6NcVma+eOn8bzGhXTb/6c6w48XUv/xH
 +dT06mhfH8yB+c5NGeQ==
X-Authority-Analysis: v=2.4 cv=XuX3+FF9 c=1 sm=1 tr=0 ts=69458bd6 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=Z8QH3jyO5qCctVNkEbgA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: TalnviYTL3OzB-7t0YzSihHqXdrUfd9L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-19_06,2025-12-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015
 malwarescore=0 bulkscore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2512120000 definitions=main-2512190140
Received-SPF: pass client-ip=148.163.156.1; envelope-from=alifm@linux.ibm.com;
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


On 12/19/2025 8:30 AM, Cédric Le Goater wrote:
> On 12/19/25 17:21, Philippe Mathieu-Daudé wrote:
>> On 19/12/25 15:51, Cédric Le Goater wrote:
>>> Hello,
>>>
>>> On 12/17/25 19:42, Farhan Ali wrote:
>>>> The VFIO pread/pwrite functions use little-endian data format.
>>>> When enabling the Bus Master bit, the value must be correctly 
>>>> converted
>>>> from the CPU's native endianess to little-endian format.
>>>
>>> How did you find the issue ?
>>
>> I presumed using VFIO on s390x hosts...
>
> yes. I have been using a nvme drive for over 2y in an s390x VM and never
> saw any issue.
>
> C.
>
Hi Cedric,

I have recently been experimenting with QEMU NVMe userspace driver and 
PCI instructions from userspace [1]. On some of our test systems I 
noticed the driver being hung. After some investigation we realized it 
was due to this issue.

[1] https://lore.kernel.org/all/20250430185012.2303-1-alifm@linux.ibm.com/

Thanks

Farhan


>>
>>>
>>> Thanks,
>>>
>>> C.
>>>
>>>
>>>> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
>>>> ---
>>>>   util/vfio-helpers.c | 2 +-
>>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/util/vfio-helpers.c b/util/vfio-helpers.c
>>>> index fdff042ab4..3c8284284f 100644
>>>> --- a/util/vfio-helpers.c
>>>> +++ b/util/vfio-helpers.c
>>>> @@ -443,7 +443,7 @@ static int qemu_vfio_init_pci(QEMUVFIOState *s, 
>>>> const char *device,
>>>>       if (ret) {
>>>>           goto fail;
>>>>       }
>>>> -    pci_cmd |= PCI_COMMAND_MASTER;
>>>> +    pci_cmd = cpu_to_le16(le16_to_cpu(pci_cmd) | PCI_COMMAND_MASTER);
>>>>       ret = qemu_vfio_pci_write_config(s, &pci_cmd, 
>>>> sizeof(pci_cmd), PCI_COMMAND);
>>>>       if (ret) {
>>>>           goto fail;
>>>
>>>
>>>
>>
>
>

