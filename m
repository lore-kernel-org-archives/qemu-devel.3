Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F616E69165
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Dec 2025 20:18:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vXmLP-00027A-6D; Mon, 22 Dec 2025 15:17:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1vXmLM-00025u-58; Mon, 22 Dec 2025 15:17:24 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1vXmLK-0002jI-GZ; Mon, 22 Dec 2025 15:17:23 -0500
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BMEPSac009936;
 Mon, 22 Dec 2025 20:17:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=ps0x1N
 Wu2c4GGZoS7LYa/VBR2ictiYbpf510siCUbQ4=; b=peQljh2MdglUa3ItS6cVdG
 JlBfgkJbKuqwAHsusT989PqkCaSBIk99lu/WGGaHaFlxM/RfOICxIZYTmko9NFE9
 igyptXTBm+XWMJBESYIZtjqrpCNOQ/mc+Lna3h+vrngS9ii7UdINWxBswbaH32Yx
 T6gKNmD7+dEiz3Bqq4QMnFKPTveoT9u+WttpmrZKUcNd9VNy9bn0G1w62J1QWpNU
 4tte7YOzHNT0IqYhcMmOpVj4Ejhx8oHZBtXExAym9LAYerzeS5aNBVViUyPaTqDw
 kLkmisWlEBiUADIHqTbHjTloJ3AFCMPQjYNWrnTdwuKfplBAkK2O0+MkAgAYsV0w
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b5ketsgvt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 22 Dec 2025 20:17:17 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5BMHFhmU027076;
 Mon, 22 Dec 2025 20:17:16 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4b6r9350qg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 22 Dec 2025 20:17:16 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5BMKHFXu18678506
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 22 Dec 2025 20:17:15 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6E03A58056;
 Mon, 22 Dec 2025 20:17:15 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BAFDC58052;
 Mon, 22 Dec 2025 20:17:14 +0000 (GMT)
Received: from [9.61.253.27] (unknown [9.61.253.27])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 22 Dec 2025 20:17:14 +0000 (GMT)
Message-ID: <dc8049a1-0d6c-428c-934d-f8b70065aa3c@linux.ibm.com>
Date: Mon, 22 Dec 2025 12:17:14 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] util/vfio-helper: Fix endianess when enabling Bus
 Master
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: mjrosato@linux.ibm.com, thuth@redhat.com, stefanha@redhat.com,
 kwolf@redhat.com, fam@euphon.net, alex@shazbot.org
References: <20251217184253.1520-1-alifm@linux.ibm.com>
 <4d7e4040-349e-4772-bdf9-43d4f8a6f771@redhat.com>
 <0c3e13e1-0aeb-47f9-9c44-5af8f3f47055@linaro.org>
 <970d3a1a-408f-4bf3-b6da-784f8e6bd66a@redhat.com>
 <f23ec136-5b6f-45b2-a6f1-1668e58a4030@linux.ibm.com>
 <e219df64-1712-4ace-8358-d825de26fc1a@redhat.com>
 <9e07d4e0-c407-448c-ac5c-10d153a1a11a@linaro.org>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <9e07d4e0-c407-448c-ac5c-10d153a1a11a@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: VukOtR1LW8iCzlHUvYcxCKfNZ4R6Mf7B
X-Authority-Analysis: v=2.4 cv=Qdxrf8bv c=1 sm=1 tr=0 ts=6949a74d cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=YO1ib721botBd7ZNm6oA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: VukOtR1LW8iCzlHUvYcxCKfNZ4R6Mf7B
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjIyMDE4MiBTYWx0ZWRfX3iq8/3Rwkqh6
 r8/5Uvbu/5bvp7UGQPeA+U6FrHWcWoYnsVCQEy6TAi0Xz9rCwu6/ZGqD4rlNztDhjlT5Yu3fIQn
 i9yHfOOM5kqT7RqoX4Hme51ApdGxUTifhj/4S2TUjrUvNE2ezMUCzqOvbq8ugB5g0YyCRZkrcdm
 lkhpyHehpj19j3X57kA+WMAX8+tFGECNT5dZLJ7PGd9jSlhmN/BiVvw3NlJjORiVxswt3HrDi3y
 py1SV5iXaP4sjPlG41HVByr9AeHB0GyLtZCDL9Xl4jXlvT1+9sp7qQbaLvlVKZ37XCDhOv4/PMk
 Iwxcdrs7lAs7E0oIYEET7hSccgKst1wpEVP4TlgkOF5cpHjFyzsk8IhOJ67xv2heRY9HWjdLCJY
 4VQcNO59QPR47oqcuS0Ballyj36YIRi7eWKRKkicHfC05osI52krfgYx9P4ld6GUemy70vsxO26
 ZqTVvAF3wvHf9GBj6hQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-22_03,2025-12-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015
 priorityscore=1501 phishscore=0 impostorscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2512120000 definitions=main-2512220182
Received-SPF: pass client-ip=148.163.158.5; envelope-from=alifm@linux.ibm.com;
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


On 12/22/2025 12:35 AM, Philippe Mathieu-Daudé wrote:
> On 22/12/25 09:17, Cédric Le Goater wrote:
>> Hello Farhan,
>>
>> On 12/19/25 18:30, Farhan Ali wrote:
>>>
>>> On 12/19/2025 8:30 AM, Cédric Le Goater wrote:
>>>> On 12/19/25 17:21, Philippe Mathieu-Daudé wrote:
>>>>> On 19/12/25 15:51, Cédric Le Goater wrote:
>>>>>> Hello,
>>>>>>
>>>>>> On 12/17/25 19:42, Farhan Ali wrote:
>>>>>>> The VFIO pread/pwrite functions use little-endian data format.
>>>>>>> When enabling the Bus Master bit, the value must be correctly 
>>>>>>> converted
>>>>>>> from the CPU's native endianess to little-endian format.
>>>>>>
>>>>>> How did you find the issue ?
>>>>>
>>>>> I presumed using VFIO on s390x hosts...
>>>>
>>>> yes. I have been using a nvme drive for over 2y in an s390x VM and 
>>>> never
>>>> saw any issue.
>>>>
>>>> C.
>>>>
>>> Hi Cedric,
>>>
>>> I have recently been experimenting with QEMU NVMe userspace driver 
>>> and PCI instructions from userspace [1]. On some of our test systems 
>>> I noticed the driver being hung. After some investigation we 
>>> realized it was due to this issue.
>>
>> Do you think you could provide a test case for it ?

@Cedric,

Just wanted to understand what you had in mind here? The test case would 
use VFIO and would need an NVMe device, looking through QEMU testcases I 
couldn't find an example of using VFIO. If there are examples or other 
frameworks that is used to test this could you point me to them?

>>
>> Also, I think the LE conversion should be done in routines
>> qemu_vfio_pci_read_config() and qemu_vfio_pci_write_config().
>
> These config routines take a void buffer, so have no clue of endianness
> size.
>
Yup, exactly.

> Maybe we want intermediary qemu_vfio_pci_ld16_config() and
> qemu_vfio_pci_st16_config() helpers?
>
I did think of adding in additional helper functions. But 
since qemu_vfio_pci_read_config()/qemu_vfio_pci_write_config() is only 
called in this one place, wasn't sure if it made sense in adding them.

Another approach I thought of was limiting reads/writes to 32 bit 
similar to vfio_pci_write_config()/vfio_pci_read_config() does today. 
Can we do this here as well?

Thanks

Farhan


