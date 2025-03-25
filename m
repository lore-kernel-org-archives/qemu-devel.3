Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB80DC36008
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 17:11:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tx7o6-0007RG-S2; Tue, 25 Mar 2025 13:11:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1tx7o4-0007Qe-FD; Tue, 25 Mar 2025 13:11:16 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1tx7o2-0007Ai-6U; Tue, 25 Mar 2025 13:11:16 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52PE3CG5026148;
 Tue, 25 Mar 2025 17:11:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=kb5+3r
 IUP+KNAvJtNjLGsMZp8ME6EbnXzrMT7RFSC9k=; b=McgTWV0nH28fSf7vXKAy+r
 STWn5nFSRCyrZmQ7PRSpT9YWkOjShzh0DCOLnYwSZ2ozzn667GK+s5wcWdv5897B
 kLzlqOVeJ9Jy2nOud1ZQcwqHv51k0c1y2c4W/o0IhxMyHCsQg0Lsm9ovN9nEEnJm
 dlju0BDS42914CxTGJ1ickG6Peb33dKs4TgxFaYCk9SM8EGLN1QPIvtXvbE5LkT8
 Abdqr5ahKZzyGcYOR/q6PEaC9mQ2dlpUhDgJsj8b29OOXCs0ICbEknMAE+/eu46p
 FmGBurIT7937nzmn1j0Mzwdk2R3t/LrV1SPkldeB328NUUvLP2dMp4hKskO37OaA
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45kwwq92ka-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 25 Mar 2025 17:11:09 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 52PGRaBL007536;
 Tue, 25 Mar 2025 17:11:09 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45kwwq92k4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 25 Mar 2025 17:11:09 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52PGdJns020029;
 Tue, 25 Mar 2025 17:11:07 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45j8hnvdmg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 25 Mar 2025 17:11:07 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 52PHB4wm39256486
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 25 Mar 2025 17:11:04 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F209220043;
 Tue, 25 Mar 2025 17:11:03 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8208F2004F;
 Tue, 25 Mar 2025 17:11:01 +0000 (GMT)
Received: from [9.39.16.55] (unknown [9.39.16.55])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 25 Mar 2025 17:11:01 +0000 (GMT)
Message-ID: <a536ed2c-c778-48e2-94e1-a42425aac7c9@linux.ibm.com>
Date: Tue, 25 Mar 2025 22:41:00 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/8] Power11 support for QEMU [PowerNV]
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?= <fbarrat@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
References: <20250308205141.3219333-1-adityag@linux.ibm.com>
 <57ce8d50-db92-44f0-96a9-e1297eea949f@kaod.org>
 <65c04078-e952-4806-bc3f-1f1130dc9683@linux.ibm.com>
 <a213cff4-5f03-4a5b-b146-eedb8fa88466@kaod.org>
Content-Language: en-US
From: Aditya Gupta <adityag@linux.ibm.com>
In-Reply-To: <a213cff4-5f03-4a5b-b146-eedb8fa88466@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 6zIt-D8wI6jwdARXahSWtG8eXl_8Kx9K
X-Proofpoint-ORIG-GUID: x5Lii0j2Og9INKLKqe4MlT3R4qQBLhfF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-25_07,2025-03-25_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0
 bulkscore=0 clxscore=1015 mlxlogscore=888 spamscore=0 lowpriorityscore=0
 malwarescore=0 impostorscore=0 mlxscore=0 priorityscore=1501
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503250115
Received-SPF: pass client-ip=148.163.156.1; envelope-from=adityag@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

>>> Could you please consider deprecating the POWER8NVL and POWER8E CPUs
>>> and associated chips and machines ? I think keeping POWER8 is fine
>>> since it has different HW implementation from the following 
>>> generations.
>>> However, the POWER8NVL and POWER8E variants don't add much to QEMU.
>>> They were practical at one point for bringup (2014). They are not
>>> anymore.
>>>
>>> This will remove some lpc peculiarities.
>>
>>
>> I don't know how we 'mark' something deprecated in qemu. Checked the 
>> git history.
>>
>> By deprecating, should I just mention it in deprecated section in 
>> documentation like done for PSeries in commit 0cac0f1b ?
>
> commit 1392617d3576 is an example.
>
> versioned machine types are special now and will be automatically
> deprecated and removed. powernv machines are not though.
>
>> Or directly remove it ?. 
>
> nope. See :
>
>     https://www.qemu.org/docs/master/about/deprecated.html.
>
>
Thanks Cédric !

I see we have .deprecation_reason and fields like that, will use those 
to mark the chips and machine deprecated.


- Aditya G

> Thanks,
>
> C.
>
>

