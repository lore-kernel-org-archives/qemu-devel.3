Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BA76CCD193
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Oct 2025 06:08:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vA06b-00018k-L7; Sat, 18 Oct 2025 02:07:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vA06Z-00018Y-Tu; Sat, 18 Oct 2025 02:07:52 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vA06X-0001E6-9n; Sat, 18 Oct 2025 02:07:51 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59I3YgDb022483;
 Sat, 18 Oct 2025 06:07:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=QKHhfA
 ezuA2Zbm7y3+O1PYwlqcz4rKl/boiDKjlu8Dg=; b=lSoxjUjxytKZYsHZttCB6D
 uZjVUfZaTVjuGEKC57JRnpXNzjvQWe3tAbSIUnV1G3BctOzyrO6wyavZSBwk/f4P
 3+FQH6cePUQktG97yQfUUdom4dzg2h8GpooWYhRLScz+Hn1fyMym5ZiJvRXQIdix
 4/w73KV/hZXJT0A9Olxq6KY6Rjy8KXKvwlwSPdIbfg4EdzlO6/DqVRd0MqXv2v2K
 DHKr2y0AqReYk8Aq8gdS56FDgbQTqGVHca0NxuIxtHUD2il9n85DVtHEOIDh2Gml
 O8r3/XidwPmZQB21G2o7ggFPGq2M81c4E71tFJzcdQkd1qjQo/35sY3SV5vDnU5A
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v33ereh9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 18 Oct 2025 06:07:38 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59I67cML004137;
 Sat, 18 Oct 2025 06:07:38 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v33ereh6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 18 Oct 2025 06:07:38 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59I5OBsX015002;
 Sat, 18 Oct 2025 06:07:37 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 49r3sk0qhk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 18 Oct 2025 06:07:37 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59I67bEW26804884
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 18 Oct 2025 06:07:37 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 025F35805A;
 Sat, 18 Oct 2025 06:07:37 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F3C175803F;
 Sat, 18 Oct 2025 06:07:34 +0000 (GMT)
Received: from [9.39.26.64] (unknown [9.39.26.64])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Sat, 18 Oct 2025 06:07:34 +0000 (GMT)
Message-ID: <a69c0e62-1cfa-474d-abe1-151df0caf234@linux.ibm.com>
Date: Sat, 18 Oct 2025 11:37:32 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] target/ppc: Remove the unusable e200 CPUs
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Thomas Huth <thuth@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Chinmay Rath <rathc@linux.ibm.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org
References: <20251017144504.563594-1-thuth@redhat.com>
 <295be472-7778-49f7-9ede-e5ef51dd908e@linux.ibm.com>
 <3c2d1838-0fc9-46e3-a6b4-382ecc4d4ff8@kaod.org>
Content-Language: en-US
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <3c2d1838-0fc9-46e3-a6b4-382ecc4d4ff8@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=FMYWBuos c=1 sm=1 tr=0 ts=68f32eaa cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=f7IdgyKtn90A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8
 a=qqAnmVY_W5D1_cK4rDQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=oH34dK2VZjykjzsv8OSz:22 a=pHzHmUro8NiASowvMSCR:22 a=n87TN5wuljxrRezIQYnT:22
X-Proofpoint-GUID: J6JDAVvsj6pSGvAxfF-dOn5-em9pS8oF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfX98n8mBRmmtQr
 s/8y9dTG/B8XJliS49uk9ks6lMGVYKokNjaUHw4sId4JvoQQXizjHKbFb0ol1rl9hbVPxZ0SNBK
 k116OrVZCiJoiSXvACkGsIKSLW7wTfDteHGCAbsiINIhTEUDC4ToJaNWm+4YDbMw86Jw0tHSjtC
 yEiha1FTbp5vnmMqKFvBSS9uZvs8n5atHegIJjQvnnU/Z4UQGuxtvJ7J666A66LTUnN3J10zcEt
 oShEjwLj27CyZ53vBz3m2jLXCyLwVAeVEDbRdBXxKXKPGQd89jC0EdxH/YUZoDzKV/rlnG3yNoy
 zJ+J29e6PcQxa4bHwKXHLl841Yik7zI8DvJRW1Ido/TDqARFvGRLeb7d5/u2YzbFU7AqUmx29M7
 b3Dmmm2iSe75AUgV3q9rIJk9rgumyg==
X-Proofpoint-ORIG-GUID: di9WmfFtrFCWnOEGRKensBmlWy6-mq1t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-18_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 spamscore=0 malwarescore=0
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



On 10/18/25 11:31, Cédric Le Goater wrote:
> On 10/17/25 17:50, Harsh Prateek Bora wrote:
>>
>>
>> On 10/17/25 20:15, Thomas Huth wrote:
>>> From: Thomas Huth <thuth@redhat.com>
>>>
>>> There is currently no machine in QEMU (except the "none" machine)
>>> that can be run with one of the e200 ppc CPUs - all machines either
>>> complain about an invalid CPU type or crash QEMU immediatly.
>>>
>>> Looking at the history of this CPU type, it seems like it has never
>>> been used in QEMU and only implemented as a placeholder (see e.g. the
>>> comment about unimplemented instructions in the POWERPC_FAMILY(e200)
>>> section of cpu_init.c). Being completely unused and unusable since
>>> such a long time, let's just remove it now.
>>>
>>> Note: The init_excp_e200() is used by the e500 CPUs, too, so we
>>> rename this function to init_excp_e500() instead of removing it.
>>>
>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>> ---
>>>   target/ppc/cpu-models.h |   4 --
>>>   target/ppc/cpu-models.c |   5 --
>>>   target/ppc/cpu_init.c   | 147 +---------------------------------------
>>>   3 files changed, 2 insertions(+), 154 deletions(-)
>>>
>>> diff --git a/target/ppc/cpu-models.h b/target/ppc/cpu-models.h
>>> index c6cd27f390e..a439eb37ee4 100644
>>> --- a/target/ppc/cpu-models.h
>>> +++ b/target/ppc/cpu-models.h
>>> @@ -120,10 +120,6 @@ enum {
>>>   #define CPU_POWERPC_MPC5200_v12      CPU_POWERPC_G2LEgp1
>>>   #define CPU_POWERPC_MPC5200B_v20     CPU_POWERPC_G2LEgp1
>>>   #define CPU_POWERPC_MPC5200B_v21     CPU_POWERPC_G2LEgp1
>>> -    /* e200 family */
>>> -    /* e200 cores */
>>> -    CPU_POWERPC_e200z5             = 0x81000000,
>>> -    CPU_POWERPC_e200z6             = 0x81120000,
>>>       /* e300 family */
>>>       /* e300 cores */
>>>       CPU_POWERPC_e300c1             = 0x00830010,
>>> diff --git a/target/ppc/cpu-models.c b/target/ppc/cpu-models.c
>>> index 89ae763c7f6..26b6debcfc9 100644
>>> --- a/target/ppc/cpu-models.c
>>> +++ b/target/ppc/cpu-models.c
>>> @@ -244,11 +244,6 @@
>>>                       CPU_POWERPC_MPC5200B_v20, 
>>> POWERPC_SVR_5200B_v20, G2LE)
>>>       POWERPC_DEF_SVR("mpc5200b_v21", "MPC5200B v2.1",
>>>                       CPU_POWERPC_MPC5200B_v21, 
>>> POWERPC_SVR_5200B_v21, G2LE)
>>> -    /* e200 
>>> family                                                           */
>>> -    POWERPC_DEF("e200z5",        CPU_POWERPC_e200z5,                 
>>> e200,
>>> -                "PowerPC e200z5 core")
>>> -    POWERPC_DEF("e200z6",        CPU_POWERPC_e200z6,                 
>>> e200,
>>> -                "PowerPC e200z6 core")
>>
>> While I hope removal of e200 should be fine, I am thinking if we want to
>> deprecate it in this cycle and remove it in next ?
> 
> Since it was never usable (I don't remember of any tests for these
> CPUs), I agree with Thomas to bypass the deprecation process.
> 

Sure, reasonable.

Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>

> 
> 
> Thanks,
> 
> C.
> 

