Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65E6AC83F1A
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Jul 2025 09:13:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ues01-0001V8-8b; Thu, 24 Jul 2025 05:12:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1uerzz-0001Tv-Ep; Thu, 24 Jul 2025 05:12:23 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1uerzw-0004c8-QK; Thu, 24 Jul 2025 05:12:23 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56O0QTBp021841;
 Thu, 24 Jul 2025 09:12:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=YWeN6P
 16hM/JJngI1E0NmB+bVhdOesRhZGIy+rGLZho=; b=J2W/hzTYesMig+6j8eySpn
 oIGE5lJHC/ilBE7osTzh/bYIzWoCt7HYluy0dygPXnQaMGSNhrXZz0sgEx/htLai
 Ip+Sf+F+dbpKh/DDEXhZisWgDP4Q8+7gu+g8jVsJoYXUWMlYUEd4u71gZU9BW4mf
 IYGGYly7VPOMBpTkciyJscr+/Dvuf1uz7Y06LIYU9ztCiiBRwUpOi1+WL9mBtVwr
 iFVgsG5mIvRNwVBgb8lcYQ/xdAntUSHwdU6j8GHpfET0AufagbX79+fao6knp85j
 yqA7Z1oSa+MDgdTlFCnkKDhGPl33z4reorzXJM8ba9nXBY9C0ewAx981uyHCHGWw
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 482ffbhq4t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 24 Jul 2025 09:12:16 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 56O9CGFG007628;
 Thu, 24 Jul 2025 09:12:16 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 482ffbhq4r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 24 Jul 2025 09:12:16 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56O6SxnE005457;
 Thu, 24 Jul 2025 09:12:15 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 480tvr30h8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 24 Jul 2025 09:12:15 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 56O9CDRQ41943318
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 24 Jul 2025 09:12:13 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9DED558061;
 Thu, 24 Jul 2025 09:12:13 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CA80B58053;
 Thu, 24 Jul 2025 09:12:10 +0000 (GMT)
Received: from [9.109.242.24] (unknown [9.109.242.24])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 24 Jul 2025 09:12:10 +0000 (GMT)
Message-ID: <74e8e729-3bae-4315-9519-5bd0b6f08731@linux.ibm.com>
Date: Thu, 24 Jul 2025 14:42:09 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] MAINTAINERS updates for ppc/spapr/pnv/xive
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, npiggin@gmail.com
Cc: danielhb413@gmail.com, fbarrat@linux.ibm.com, rathc@linux.ibm.com,
 adityag@linux.ibm.com, gautam@linux.ibm.com
References: <20250724063623.3038984-1-harshpb@linux.ibm.com>
 <642a5b59-a306-4fbd-a55c-008b9fd8ace0@redhat.com>
Content-Language: en-US
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <642a5b59-a306-4fbd-a55c-008b9fd8ace0@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: mzCmtn3EGKUdbjeluSTBeLSHLwvR_Xcz
X-Authority-Analysis: v=2.4 cv=De8XqutW c=1 sm=1 tr=0 ts=6881f8f0 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=f7IdgyKtn90A:10 a=20KFwNOVAAAA:8
 a=cwfGbltsdXE1nG5_tOEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: WxzgKJbpzVRh2RF9JKRlF89z4i2rxYoV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI0MDA2NyBTYWx0ZWRfX2F4AKuyXCk4f
 KCKLT/P1pwvwXEPV/hgxf0aTY2/yfEe86lqmq04kfsfpPBeARXfsPLnhVkcaQmJ9NfiPF0RjRib
 +QS4cRozqVRz0FgV63vxljny1/VEzrGG0lzHzftZv1hsNGzmNW4qmw5XR2rWNQtotQR/Tg+ildj
 1ERA4YKwGd0WGBwOb/Cnw7EEwOEjHT7r8CsLgxDIVDy9bP462tKczGm06l7xKiIPM916DG41rOA
 ffNGvMXAo/QucSCNWFee6I+Udw+FAuBcRsjcNG+WspnHm49f4pPR++LESJyg8oXK/qTzJh2uGAV
 sTFAqahLBNqxaRQtFyTQKk9EWILsj68vSnN03ujFhYlV9HiZekz+CNgV1T9y/lzrDnakHb/CU0V
 8sfbtF4j3Kjrh4J4BOXA5H3DsW6V6vvX1N7aLbmdWV4bj3PitxVqSa0S718QaHJTdvcVmygY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-24_01,2025-07-23_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 lowpriorityscore=0 mlxscore=0 mlxlogscore=663
 suspectscore=0 priorityscore=1501 clxscore=1015 phishscore=0 adultscore=0
 malwarescore=0 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507240067
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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



On 7/24/25 13:10, Cédric Le Goater wrote:
> On 7/24/25 08:36, Harsh Prateek Bora wrote:
>> Some of us at IBM have been actively working/contributing in
>> ppc/spapr/pnv/xive and would like to step up to help with
>> reviews and co-maintainer activities. I have also included proposal
>> patches from Chinmay and Aditya in this patchset which had already
>> been posted to list earlier to request for merge.
>>
>> Thanks
>> Harsh
>>
>> Aditya Gupta (1):
>>    MAINTAINERS: Add myself as a reviewer of PowerNV emulation
>>
>> Chinmay Rath (1):
>>    MAINTAINERS: Add myself as reviewer for PowerPC TCG CPUs
>>
>> Gautam Menghani (1):
>>    MAINTAINERS: Add myself as a reviewer for XIVE
>>
>> Harsh Prateek Bora (2):
>>    MAINTAINERS: Adding myself as a co-maintainer for ppc/spapr
>>    MAINTAINERS: Adding myself as reviewer for PPC KVM cpus.
>>
>>   MAINTAINERS | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
> 
> I can merge these changes through the vfio queue.
> 
> Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks Cedric !

regards,
Harsh

> 
> Thanks,
> 
> C.
> 
> 
> 

