Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91572C021BE
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 06:24:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnXJI-0003wV-68; Thu, 27 Feb 2025 01:23:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1tnXJF-0003p0-5B; Thu, 27 Feb 2025 01:23:49 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1tnXJD-000847-Ax; Thu, 27 Feb 2025 01:23:48 -0500
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51R2GYEJ005931;
 Thu, 27 Feb 2025 06:23:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=Kio/Of
 4pPfQQAte8swXeCaxVNhzbL9r/ZCf/CplA9w0=; b=QTwG1M59X+h+AU4ipUsf1V
 sIFLfIp6ZtS/A8vyQm3jEsdcH/Ap6ogA0iuqLMg6ydvk3Foi2NyzN3B006gkHvT2
 4nEMdb/VY/2acVPZowIMqUQN9lPwteVdUAKdjG1009+YNA+QfBw4AkCXB7scFsH0
 p5cZugzQ8RbuaSUAUvZMJGx/bMvXGVPFldjvvwUbmf37IWRYFo/BhCXYj1WYZ9nK
 nqXGAROH31mHugyPW7FTb1WSa6OFOfMj6MBXNYwOaDbt/HHyjcVt3pnodxETIVly
 VzPEpCg9ZJgWcSxW7CX70wdjm6w+TWzyzxllqTBJroXS23P2CFOO0GGTJyTuX/Rw
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 451xnp5q6v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 27 Feb 2025 06:23:35 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 51R6KIWd023887;
 Thu, 27 Feb 2025 06:23:35 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 451xnp5q6s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 27 Feb 2025 06:23:35 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51R2sBdu002551;
 Thu, 27 Feb 2025 06:23:34 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 44yu4jxrag-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 27 Feb 2025 06:23:34 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 51R6NVra58065314
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 27 Feb 2025 06:23:31 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F1A2520043;
 Thu, 27 Feb 2025 06:23:30 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 02A3E20040;
 Thu, 27 Feb 2025 06:23:27 +0000 (GMT)
Received: from [9.124.211.149] (unknown [9.124.211.149])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 27 Feb 2025 06:23:26 +0000 (GMT)
Message-ID: <171ee322-e41e-42b2-816d-b45fde796874@linux.ibm.com>
Date: Thu, 27 Feb 2025 11:53:25 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] Implement MPIPL for PowerNV
To: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?=
 <fbarrat@linux.ibm.com>, Sourabh Jain <sourabhjain@linux.ibm.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Hari Bathini <hbathini@linux.ibm.com>
References: <20250217071934.86131-1-adityag@linux.ibm.com>
 <D82WY0RYB30R.3M0B68UOLV0EK@gmail.com>
Content-Language: en-US
From: Aditya Gupta <adityag@linux.ibm.com>
In-Reply-To: <D82WY0RYB30R.3M0B68UOLV0EK@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: LWuYPPGMY3B5T8t0YOEM2_4mDzDP9fQf
X-Proofpoint-GUID: iVz2O--4zaKFKsM7JQfVrGQJYnm81KiD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-27_03,2025-02-26_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 priorityscore=1501 suspectscore=0 mlxlogscore=754 spamscore=0 phishscore=0
 mlxscore=0 adultscore=0 malwarescore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502270044
Received-SPF: pass client-ip=148.163.158.5; envelope-from=adityag@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Hi Nick,

On 27/02/25 09:07, Nicholas Piggin wrote:
> On Mon Feb 17, 2025 at 5:19 PM AEST, Aditya Gupta wrote:
>> Overview
>> =========
>>
>> Implemented MPIPL (Memory Preserving IPL, aka fadump) on PowerNV machine
>> in QEMU.
> Wow, that's a lot of effort.

Thanks Nick.


>> Note: It's okay if this isn't merged as there might be less users. Sending
>> for archieval purpose, as the patches can be referred for how fadump/mpipl
>> can be implemented in baremetal/PowerNV/any other arch QEMU.
> I would like to add it. It helps test a bunch of code that is in Linux
> and skiboot, so it would be quite useful. A functional test would be
> important to have.

Sure, it's not complete yet (didn't implement the CPU saving part) as I 
just wanted to do a experiment I did, will improve those things by v2 
then. It might take some time though.

Will look into the functional test thing also.

> I've had a glance through it, but better review might have to wait for
> until the next development cycle.

Sure, that's totally okay. Thank you for looking at it.


Thanks,

- Aditya G

> Thanks,
> Nick

