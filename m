Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47C9BC87FCB
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Aug 2025 07:54:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujCUQ-0006bN-2r; Tue, 05 Aug 2025 03:53:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1ujCUN-0006WA-Lv; Tue, 05 Aug 2025 03:53:40 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1ujCUL-00064D-G6; Tue, 05 Aug 2025 03:53:39 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5754u4NZ001028;
 Tue, 5 Aug 2025 07:53:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=L92pbl
 VFtRU2qFjkoyYmSr3BvE3m43yhzumpvMuwa/s=; b=MQ/hPw4BddDvACZopZgVHM
 eax0o9+AcBFGhuXcK2zyOrWkjhLQVMKbWKMtbeWUdmvKtZkwJv9GKfF2dKimntWL
 +AHSreOlyMm27j9dhmv9uF0uqQwOdVUF9fdAU5TL5T2qrKjLq61ISlysGke2toNp
 qKekN7LCi/KmQm3eNwPOtEoZar846vQV/QrUgnwSGI7h51YjYWh+GVFJZcpz6ail
 oWn7OEGlbXnJw4EEeVUCSeObtsr0SK+pirTCKnWnBFaC3ZsEuG1GJDFf28a5Ly8I
 1eSTzlVldmtHyoiv2TE+aZ2dHxTbnEXtS4LoPCwP/R9mFx9FbX0P+985O0d9fmzg
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48bbbq0qcw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 05 Aug 2025 07:53:33 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5757e3VK012411;
 Tue, 5 Aug 2025 07:53:32 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48bbbq0qcu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 05 Aug 2025 07:53:32 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5755eBlQ004549;
 Tue, 5 Aug 2025 07:53:31 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 489yq2h7px-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 05 Aug 2025 07:53:31 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5757rTCw21168778
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 5 Aug 2025 07:53:30 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BF4AA5805A;
 Tue,  5 Aug 2025 07:53:29 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 65F915805C;
 Tue,  5 Aug 2025 07:53:26 +0000 (GMT)
Received: from [9.39.26.16] (unknown [9.39.26.16])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  5 Aug 2025 07:53:26 +0000 (GMT)
Message-ID: <f8412eeb-ee0b-4871-9ff0-e783d50f7de1@linux.ibm.com>
Date: Tue, 5 Aug 2025 13:23:24 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] MAINTAINERS updates for ppc/spapr/pnv/xive
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, clg@redhat.com
Cc: danielhb413@gmail.com, fbarrat@linux.ibm.com, rathc@linux.ibm.com,
 adityag@linux.ibm.com, gautam@linux.ibm.com, philmd@linaro.org
References: <20250724100623.3071131-1-harshpb@linux.ibm.com>
 <DBTNAC0PCPJN.9XCRXCPTLSC3@gmail.com>
Content-Language: en-US
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <DBTNAC0PCPJN.9XCRXCPTLSC3@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: GHpqnZeViwiLH_q0uePCfGJMgTyu34LF
X-Authority-Analysis: v=2.4 cv=M65NKzws c=1 sm=1 tr=0 ts=6891b87d cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=f7IdgyKtn90A:10
 a=xGINBAbUyfV-7GpS-M8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: UKwNS4h2ZHV7QvGCyPvldmYpEupJFtZq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA1MDA1NiBTYWx0ZWRfX8bwU5mPhr/yC
 FzG0svPJ8tflU+LyCfW/qjz7Sl9t25R8dJvC9Fr4Bb5Fcr25E7sEBVDvFBVjpbGdX9RzXiw6889
 aYvmaVFpm4XUCqI3wa8CoR1MJit26FvBp0Da6OutdZyrHqGL5F4D1RuGG9OvTIZo/7J/e1PTHif
 ScOz3qdfZ2H0t8jwnsvXIXv5x2Aahavhqe5806OvY5vSuyLxeQ98u0ba0wlQKv8WULpLNlp3Q6e
 u1U2gMLqcfHRB3jzux7y3Z4ZaqoZWJZZPDzqlzTJLRWHMdVH+e2byPGTScRZ/PGpAvry/jj1I4H
 RyiWSgdp6gKqGEz/GeJIDL8cync3DWPNsFbwLtoG8ZA0yo+1pQIN2Z0R56DXkoL4SFNwLT/jLkE
 Ol1mA052arsNgETkmRCqQfml9SdtSjPgX97aHjRmIXsk9Iy3qdhIH2DQyB1QMVsBRM25xorq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-05_02,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 suspectscore=0 clxscore=1015 mlxscore=0 phishscore=0 priorityscore=1501
 mlxlogscore=712 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2508050056
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
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

Hi Nick,

On 8/4/25 18:03, Nicholas Piggin wrote:
> Hey Harsh,
> 
> Sorry I dropped the ball on the merge window. Thanks to you and Cedric
> and others for picking it up and apologies to those I kept waiting. I
> let things overwhelm me a bit and got stressed about getting back to it
> :(

Some situations are inevitable and hope it happened earlier for good.
Thanks to you and Cedric for enabling us get on board to contribute better.

> 
> I would like to keep helping out with qemu/ppc as time permits, I'll
> try not to over promise though. Apologies again.

Your guidance on PPC and in general will certainly help us to make 
better decisions. Thanks very much for all your support!

regards,
Harsh

> 
> Thanks,
> Nick
> `
> On Thu Jul 24, 2025 at 8:06 PM AEST, Harsh Prateek Bora wrote:
>> Some of us at IBM have been actively working/contributing in
>> ppc/spapr/pnv/xive and would like to step up to help with
>> reviews and co-maintainer activities. I have also included proposal
>> patches from Chinmay and Aditya in this patchset which had already
>> been posted to list earlier to request for merge.
>>
>> Thanks
>> Harsh
>>
>> Changelog:
>> v2: Added my S-o-b as suggested by Philippe, Cedric
>> v1: Initial patchset
>>
>> Aditya Gupta (1):
>>    MAINTAINERS: Add myself as a reviewer of PowerNV emulation
>>
>> Chinmay Rath (1):
>>    MAINTAINERS: Add myself as reviewer for PowerPC TCG CPUs
>>
>> Gautam Menghani (1):
>>    MAINTAINERS: Add myself as a reviewer for XIVE
>>
>> Harsh Prateek Bora (2):
>>    MAINTAINERS: Adding myself as a co-maintainer for ppc/spapr
>>    MAINTAINERS: Adding myself as reviewer for PPC KVM cpus.
>>
>>   MAINTAINERS | 5 +++++
>>   1 file changed, 5 insertions(+)
> 

