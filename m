Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55A58C83F26
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Jul 2025 10:11:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uesuo-0000A2-Ua; Thu, 24 Jul 2025 06:11:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1uesun-00008N-Ct; Thu, 24 Jul 2025 06:11:05 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1uesul-00086G-Ap; Thu, 24 Jul 2025 06:11:04 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56O1Faap027672;
 Thu, 24 Jul 2025 10:11:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=AYxf+a
 IdvNhCXdqGI0fbJffqc90s5vYsWyrTT996rn8=; b=nJM6auTUyEnMilAQkukN7t
 1/fgSn94YgdE8N4mEg5nlb11wijlhg+Y3kNr5110euvTEmI1f9sxBCro2Z7tKIZH
 vHvidfdGskcaxG3yxhu4lvKCgyc5+GKX0/KmmKqqGppICSCWbv3GFk6ODfW36IE4
 NjiTOsa3hhyMig9yPAHyveyYW/6ra6Q/q7PGPmP/nSLBVZ8zkn5r7Jz/z8D8CFvt
 f0xkHOAU8wL1J/towbQzNxoP0W8BUB/NDc+MPHesxLkDhtWzMWsEfzIdXUDxgSid
 iLzxIRG/lfAOPvBS7f+QgkfyobRi+OI4Tnu2D2RekDY+CeS0AJmhypkGpvVgfY2Q
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 482ff5syqh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 24 Jul 2025 10:11:00 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 56OA6515013232;
 Thu, 24 Jul 2025 10:11:00 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 482ff5syqg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 24 Jul 2025 10:11:00 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56O6W2oe025138;
 Thu, 24 Jul 2025 10:10:59 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 480nptv79n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 24 Jul 2025 10:10:59 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 56OAAv0U54198682
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 24 Jul 2025 10:10:58 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DF00358053;
 Thu, 24 Jul 2025 10:10:57 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C691658043;
 Thu, 24 Jul 2025 10:10:54 +0000 (GMT)
Received: from [9.109.242.24] (unknown [9.109.242.24])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 24 Jul 2025 10:10:54 +0000 (GMT)
Message-ID: <ef797725-b03f-4e40-b31b-877ccb478acb@linux.ibm.com>
Date: Thu, 24 Jul 2025 15:40:53 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] MAINTAINERS updates for ppc/spapr/pnv/xive
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, npiggin@gmail.com,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: danielhb413@gmail.com, fbarrat@linux.ibm.com, rathc@linux.ibm.com,
 adityag@linux.ibm.com, gautam@linux.ibm.com
References: <20250724063623.3038984-1-harshpb@linux.ibm.com>
 <642a5b59-a306-4fbd-a55c-008b9fd8ace0@redhat.com>
 <74e8e729-3bae-4315-9519-5bd0b6f08731@linux.ibm.com>
 <d14c7e44-14fe-430e-96eb-0d1325953612@redhat.com>
Content-Language: en-US
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <d14c7e44-14fe-430e-96eb-0d1325953612@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI0MDA3NSBTYWx0ZWRfX43I394NRcgqk
 NWzRebyT6myGgiTFSFyT5VX15aFkG6eL/NyB0sftZbnPP7E5GiAg7sBTxx6+rpGpGfMlJV3qhcd
 yFI+nzdtObWPlK4j31rJnwG92SybFOW/WCTgJ9FyIZJiDGsOzai7h/8rti/Rkg9fP4H+RA6gIXX
 jVxjF6hvem9Y/5pWcrtvX40ThwqWWO+dhtgZfC2/sTxqWpuAaD8r6SNaYgtp05DlHHQ6PUJx1gW
 KukZfyCr7qQAg+f73LLyJjV1azou8OgzAiyVe091ibsqRlJ7xeUzIQj+jVJP+9CpGmrWeSsSmOV
 2nZkV5ATu6GMN4Vnxzh1VwiOQPsk0CWRHnObLLAVC15td2YcSXhHjdojrzCTQZC1fzTcrbavpCl
 ZyVM3i69MFCuSfnptTjJ1vfAXWDQxWzlAfZZf3WhF3PkUR6Qu+EP0/o1z0miQUCZZvfA3gpL
X-Authority-Analysis: v=2.4 cv=evLfzppX c=1 sm=1 tr=0 ts=688206b4 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=f7IdgyKtn90A:10 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8 a=1LzfJVe2DS0ENudrwGMA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 87LlnkHajs9QlR0JmkRoUYnyzvFjSlA3
X-Proofpoint-ORIG-GUID: 2K6EgGDPE0y0HSwYZIYKoVpLnpt33XUp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-24_01,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 malwarescore=0 spamscore=0 adultscore=0
 lowpriorityscore=0 bulkscore=0 mlxscore=0 suspectscore=0 phishscore=0
 priorityscore=1501 mlxlogscore=637 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507240075
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



On 7/24/25 15:17, Cédric Le Goater wrote:
> On 7/24/25 11:12, Harsh Prateek Bora wrote:
>>
>>
>> On 7/24/25 13:10, Cédric Le Goater wrote:
>>> On 7/24/25 08:36, Harsh Prateek Bora wrote:
>>>> Some of us at IBM have been actively working/contributing in
>>>> ppc/spapr/pnv/xive and would like to step up to help with
>>>> reviews and co-maintainer activities. I have also included proposal
>>>> patches from Chinmay and Aditya in this patchset which had already
>>>> been posted to list earlier to request for merge.
>>>>
>>>> Thanks
>>>> Harsh
>>>>
>>>> Aditya Gupta (1):
>>>>    MAINTAINERS: Add myself as a reviewer of PowerNV emulation
>>>>
>>>> Chinmay Rath (1):
>>>>    MAINTAINERS: Add myself as reviewer for PowerPC TCG CPUs
>>>>
>>>> Gautam Menghani (1):
>>>>    MAINTAINERS: Add myself as a reviewer for XIVE
>>>>
>>>> Harsh Prateek Bora (2):
>>>>    MAINTAINERS: Adding myself as a co-maintainer for ppc/spapr
>>>>    MAINTAINERS: Adding myself as reviewer for PPC KVM cpus.
>>>>
>>>>   MAINTAINERS | 5 +++++
>>>>   1 file changed, 5 insertions(+)
>>>>
>>>
>>> I can merge these changes through the vfio queue.
>>>
>>> Reviewed-by: Cédric Le Goater <clg@redhat.com>
>>
>> Thanks Cedric !
> Would you mind resending a v2 with all S-o-b fixed please ?

I have posted v2 with all S-o-b fixed here:
https://lore.kernel.org/qemu-devel/20250724100623.3071131-1-harshpb@linux.ibm.com/


Thanks
Harsh

> 
> Thanks,
> 
> C.
> 
> 
> 
> 

