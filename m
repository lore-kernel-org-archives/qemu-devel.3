Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79F0ECCF2DE
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 19:42:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhv8M-0006Lk-V2; Mon, 19 Jan 2026 14:41:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1vhv8E-0006Fg-L8
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 14:41:48 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1vhv8A-0006ds-KA
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 14:41:45 -0500
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60JFYP4X016761;
 Mon, 19 Jan 2026 19:41:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=GCq57I
 26L0decrZWvUdm15GSjpnzbvF7fci3eC/CS2U=; b=eCTKR80ebsID/oDkZD/uf7
 GHgg4S/NqMKWWL/Oj0vXC3pkRMS8e8MR/0iMVRAn3Wa6GzrG8oPRQeQI5hLPmYsW
 QMt3f2NvStiefvqcIgvMmttS1ISDz9Lqc8rApV224qS4WF+rriUfRTBOscvtG8UF
 K/5lx/4C4OUrkNDI5m99FMUsfGOqxG+1S1yRf6vIhj3swVOv14MZS6uz2MRCWPSL
 rgFl3psNQhNbF0Puo9Xxvq8JoTc1EyhmbB+UUoAJP5agAoblfHwzPuHHgOMIoUyz
 wjeF9hoWQfqqCpxv82Ftu1a3HC/QRQ+OOAaDPdrkAA1eq2eCqSzIIxWFQxxSGCVA
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4br22u9d62-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 19 Jan 2026 19:41:39 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60JJDYHb024640;
 Mon, 19 Jan 2026 19:41:38 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4brxarf4qs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 19 Jan 2026 19:41:38 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 60JJfbPH40763786
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 19 Jan 2026 19:41:37 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A789458059;
 Mon, 19 Jan 2026 19:41:37 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1507B58058;
 Mon, 19 Jan 2026 19:41:37 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 19 Jan 2026 19:41:36 +0000 (GMT)
Message-ID: <3ad5e5b3-d99c-46df-bd9b-a401c144dbfd@linux.ibm.com>
Date: Mon, 19 Jan 2026 14:41:36 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] follow-up for tpm_emulator errp story
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 stefanb@linux.vnet.ibm.com
Cc: qemu-devel@nongnu.org, armbru@redhat.com, peterx@redhat.com
References: <20251106194126.569037-1-vsementsov@yandex-team.ru>
 <5b4220cf-4537-4906-82a9-2213af7ee8a8@yandex-team.ru>
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <5b4220cf-4537-4906-82a9-2213af7ee8a8@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Q7Moo0TPE2uzm0RYkl4DEpJL1eRAPWfV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE5MDE2MSBTYWx0ZWRfX8dY02h4jNECS
 dsgoRa8yXK461ptqo0ljnWCxUvCCK7rPed+kJN+0Okji0Z60xsqE/B1ea1kk9gjfUoxzeJXe/YW
 psZzdIqdnr2694gCR0uPj+0XBN/o1phX1X3yyIidhTPD3FxvsVxw2KEOPOmq7uhwM8ik+8RqRFl
 9Loj7ecoo1TRBlCeKzgyuPsXEHl5FGCKogqV3IxuYmX3AbYchSnmuhI0jGp3VA0FoKAwOdZl5hQ
 hs1qTZSQ5MCA5dhB5dA+N16Kx4eGuBkRctYNlwRK4y74sZF7tVusU1o/tMuKFkqo8P6dcxp7l+Z
 6hT+5ovdKsDtleWt4PD3m/8q/lSHv82yfGEdW/hxr1uvxWnwYLUtJAjs8YDsP6uzOhJ3GiNpuR4
 jx/4zdabyfoZOlTQZjJl0cLLdZ6sF3RZmGxR7auf4wXEsnFeE7gYEVNNqOiH45C1zOkesVQS79u
 MlmHrbUuuUMpXY84Vsw==
X-Proofpoint-ORIG-GUID: Q7Moo0TPE2uzm0RYkl4DEpJL1eRAPWfV
X-Authority-Analysis: v=2.4 cv=Sp2dKfO0 c=1 sm=1 tr=0 ts=696e88f3 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=a9EG4t21K7k3w70_gsYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-19_04,2026-01-19_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 spamscore=0 adultscore=0 phishscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 suspectscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2601150000
 definitions=main-2601190161
Received-SPF: pass client-ip=148.163.158.5; envelope-from=stefanb@linux.ibm.com;
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 1/19/26 10:47 AM, Vladimir Sementsov-Ogievskiy wrote:
> ping. All patches reviewed, could they be merged?

Can you please rebase the changes on the latest master?

> 
> On 06.11.25 22:41, Vladimir Sementsov-Ogievskiy wrote:
>> Hi all!
>>
>> Here are fix and small enhancements, following comments on
>> already merged "tmp_emulator: improve and fix use of errp"
>> by Markus.
>>
>> Vladimir Sementsov-Ogievskiy (3):
>>    tpm_emulator: print error on error-ignore path
>>    tpm_emulator: drop direct use of errno variable
>>    tpm_emulator: tpm_emulator_set_state_blobs(): move to boolean return
>>
>>   backends/tpm/tpm_emulator.c | 61 +++++++++++++++----------------------
>>   1 file changed, 24 insertions(+), 37 deletions(-)
>>
> 
> 


