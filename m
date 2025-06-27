Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14975C7EE2A
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Jun 2025 15:15:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uVAmu-0005LM-32; Fri, 27 Jun 2025 11:14:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akrowiak@linux.ibm.com>)
 id 1uVAmr-0005KL-WB; Fri, 27 Jun 2025 11:14:46 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akrowiak@linux.ibm.com>)
 id 1uVAmq-0005ym-FD; Fri, 27 Jun 2025 11:14:45 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55R997XF030939;
 Fri, 27 Jun 2025 15:14:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=qSX/Yb
 j2D9FyI8U9bPSoGmKByk+lqEmr0DGtsFnnwfI=; b=EygMisI6KiM4KtrcpLFCLd
 Ko80UoDVdpaAUIfgFsHn0S0NuRVjyeakySnnuQ1a9scyN4BrS3X9tyyhM1egaQax
 /R3SfJ6tfpimUAy67kAL1xcocm0Bej9cXhbBxSE/R37XnhdyA1PYPqr9lHpu0/pM
 cxV55knK6tZjezf6zmdEDtl2KXyTt02W+VywLcsJOZ+UCbsnYH6YavPHmSJo1gjo
 R/sq35td+v7hVqUPPQ+CffP43NRhDYMo61Zg4G6pd6si+EywtvvROLm7QgJpwit1
 tWtoMxIXVaYhxPrINty5n6j8WFcngQ7amBqtg/sD52MPuNtD7DQp+B8PBpDE9Kcw
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47dk64ds4h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 27 Jun 2025 15:14:42 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55RESOfU014710;
 Fri, 27 Jun 2025 15:14:41 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 47e9s2vd91-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 27 Jun 2025 15:14:41 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 55RFEeIX21889734
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 27 Jun 2025 15:14:41 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A4D1658065;
 Fri, 27 Jun 2025 15:14:40 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 517A45805B;
 Fri, 27 Jun 2025 15:14:39 +0000 (GMT)
Received: from [9.61.82.48] (unknown [9.61.82.48])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 27 Jun 2025 15:14:39 +0000 (GMT)
Message-ID: <8f916eb7-cbce-49b5-bace-711de9121b1d@linux.ibm.com>
Date: Fri, 27 Jun 2025 11:14:38 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v13 4/4] s390: implementing CHSC SEI for AP config
 change
To: Matthew Rosato <mjrosato@linux.ibm.com>,
 Rorie Reyes <rreyes@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Cc: pbonzini@redhat.com, cohuck@redhat.com, pasic@linux.ibm.com,
 jjherne@linux.ibm.com, borntraeger@linux.ibm.com,
 alex.williamson@redhat.com, clg@redhat.com, thuth@redhat.com
References: <20250609164418.17585-1-rreyes@linux.ibm.com>
 <20250609164418.17585-5-rreyes@linux.ibm.com>
 <5c6f7f80-cfa3-432f-9ff3-ae57f8b4cf5a@linux.ibm.com>
 <0f172637-0cd8-4b98-a095-9542c9a551fc@linux.ibm.com>
 <732ff972-ad09-4ce1-bbf2-0b39f436e8c5@linux.ibm.com>
Content-Language: en-US
From: Anthony Krowiak <akrowiak@linux.ibm.com>
In-Reply-To: <732ff972-ad09-4ce1-bbf2-0b39f436e8c5@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI3MDEyMCBTYWx0ZWRfX0qF2IEQX1Lv4
 V7/2SCQqzZM2WQnX45uhqG3IErLe34YxDfwBJJ7nxz0uUZgP1H7jV1a8s0a+nkeqRe3AqkaDRNL
 UtrtZKfCft3wF3no86vMlFuJRCJK80YMw3iG7facI8nrOYudkZft5AiIQRXB/1+sf5kJxhHhWFX
 UKOZP4SM4W3kvEokQSTftw2d6WTh4iRY0zqg2eVkj86wC1fI2rYqYQOkFplNV5UhjIootNZ5Eho
 UkL6yPlxJjC5H+hZGyYgRh252laKd3K93LMBAOT6bEd/T/8jgC30bPN0gcBNagNpBsYg9xXcLld
 p9pbsvX/Lj4DqItvYDDJiR1ZXeyEvrgEgm4ntkkCiBrmF7YWrYDKUFf9KbmoS8svBkoxR7hORy+
 zNCcmx9bnEOZTc+dJ9/LaM7TIhOzRUzNkC5IUQOlepcg1dlmg/Oh8ldWZ6U7ZjtT4205tKWO
X-Proofpoint-ORIG-GUID: yFAQ4WwHQ_G8id79AuSIzbWdVGDBC4WB
X-Proofpoint-GUID: yFAQ4WwHQ_G8id79AuSIzbWdVGDBC4WB
X-Authority-Analysis: v=2.4 cv=BfvY0qt2 c=1 sm=1 tr=0 ts=685eb562 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=k4c_didN9VAgbBhQ5cIA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-27_04,2025-06-26_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 suspectscore=0 adultscore=0 spamscore=0
 impostorscore=0 mlxlogscore=999 malwarescore=0 phishscore=0 bulkscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506270120
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=akrowiak@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
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

Sure

On 6/27/25 11:12 AM, Matthew Rosato wrote:
>>> AFAICT this portion of the handler including mutex should be moved out of ap.c into chsc_sei_nt0_get_event().  When vfio_ap is not in use, we can't call into it.  Can't you also build without VFIO_AP?  I didn't try it but that sure seems like it would cause issues too.
>> If that were the case, I think the checks I mentioned above would be sufficient because
>> the S390_FEAT_AP feature could not be set.
>>
> OK, I tested it quick (remove VFIO_AP from config) and that appears to be the case; this also restores zPCI hotplug capability since we won't call info hw/vfio/ap.c/.
>
>> What about moving lock initialization to the vfio_ap_class_init() function?
>>
> I tried a quick hack of that too and it appears to work, at least for the zPCI regression (note: I did not test the AP portion).
>
> This approach is probably not the way I would have designed it initially...  But it does seem to be the simplest thing to do from a fix perspective.
>
> Can you or Rorie prepare a proper patch w/ a fixes tag and send (please add me to CC). Also please test the change against the vfio-ap environment; you can also test zPCI but I would also like to run some tests.


