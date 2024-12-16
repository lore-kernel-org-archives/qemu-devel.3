Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C915EE7717F
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2024 17:38:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNF2j-0006TE-5l; Mon, 16 Dec 2024 12:38:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1tNF2h-0006RH-K7; Mon, 16 Dec 2024 12:38:03 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1tNF2f-0003c5-QW; Mon, 16 Dec 2024 12:38:03 -0500
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BG85mFM027354;
 Mon, 16 Dec 2024 17:37:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=jvp6xz
 qYCnZ1GCvLgmFF89AfgJ984nTOuiYSR33fGa4=; b=H7IZBbkLTOjEPReMtKNT8+
 bcv9oFlYCe1IVuKALsVCi1nYADBCnxbGTzZG/ZoagYLpAiOoUCWgzbS70jKczRRJ
 Qq4+qgRpOsURR8O+4IZq9AzARcPjC7B7TsGIhsXTBBxfHqEZxV26SckrXRiMGVjc
 LVMnK+2o6kOhpuTLfoGf+PiLJjzWAtKkqN98bfdkiTQRevRyNR8B7wgq6TOsy9xK
 sVBMER4qzze4yGlcfOkaGuoXtloNZqu/gkwMNylHZUGnDTKKkZZ3VgCriP5MGVuf
 /qhw6aPgyfUB+j+Lm7gpswVCUgj4p3hVWR52L5AGkC2NWWw2ifD8neld7hhJtwdg
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43jgd2aq3g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 16 Dec 2024 17:37:56 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BGHJt63014961;
 Mon, 16 Dec 2024 17:37:55 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43hmqxy3wd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 16 Dec 2024 17:37:55 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 4BGHbsds25100872
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 16 Dec 2024 17:37:54 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8DF1958053;
 Mon, 16 Dec 2024 17:37:54 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 47E0358043;
 Mon, 16 Dec 2024 17:37:53 +0000 (GMT)
Received: from [9.61.117.46] (unknown [9.61.117.46])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 16 Dec 2024 17:37:53 +0000 (GMT)
Message-ID: <37918007-83ad-4422-ad7c-56ee95e0c206@linux.ibm.com>
Date: Mon, 16 Dec 2024 12:37:52 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] s390x/pci: add support for guests that request
 direct mapping
To: David Hildenbrand <david@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-s390x@nongnu.org
Cc: farman@linux.ibm.com, schnelle@linux.ibm.com, thuth@redhat.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 richard.henderson@linaro.org, iii@linux.ibm.com, clegoate@redhat.com,
 qemu-devel@nongnu.org
References: <20241213225440.571382-1-mjrosato@linux.ibm.com>
 <20241213225440.571382-2-mjrosato@linux.ibm.com>
 <7e07ef1e-4fa5-40d7-85f9-d7a199901b4f@linaro.org>
 <46acb391-154e-43a1-a459-1646dc27fb33@redhat.com>
 <f1cba8bd-b15a-456c-8640-7c0ed221b2d3@linux.ibm.com>
 <eb6b9c83-fedb-4765-a902-695fe889e45d@redhat.com>
 <625c8ade-f87f-4203-81ff-a4ea396f15ac@linux.ibm.com>
 <49ed5940-8995-42cd-9587-8a2a01461f43@redhat.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <49ed5940-8995-42cd-9587-8a2a01461f43@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 9znOwJYSU3nCjwg8DCVQjW0D2U7Z6lkP
X-Proofpoint-GUID: 9znOwJYSU3nCjwg8DCVQjW0D2U7Z6lkP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0
 suspectscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015
 mlxlogscore=999 priorityscore=1501 malwarescore=0 impostorscore=0
 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412160146
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-1.13, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 12/16/24 12:29 PM, David Hildenbrand wrote:
> On 16.12.24 18:26, Matthew Rosato wrote:
>>
>>>> Good point.  Using s390_get_memory_limit() sounds good to me; That will make v3 of this series dependent on the s390x virtio-mem series but sounds like you're sending that sometime this week anyway.
>>>
>>> If my testing is good and there are no further comments, I'll queue it directly (no change to v2) to send it upstream.
>>>
>>> So it's probably a good idea to wait with a new series her.
>>>
>>
>> OK
>>
>>>
>>> We discussed at some point maybe requiring disabling uncoordinated discarding of RAM (virtio-balloon), is that already done implicitly now?
>>>
>>
>> Yes, this should be handled via the call to ram_block_uncoordinated_discard_disable() in vfio_ram_block_discard_disable() - I just traced that now to double-check.
>>
> 
> Cool, can you briefly mention that in the patch description? Thanks!
> 

Sure, I'll add something like

Pinning for the direct mapping case is handled via vfio and its memory
listener.  Additionally, ram discard settings are inherited from vfio:
coordinated discards (e.g. virtio-mem) are allowed while uncoordinated
discards (e.g. virtio-balloon) are disabled.

