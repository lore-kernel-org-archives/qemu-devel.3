Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 932E9C36008
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Mar 2025 17:23:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txUTC-0002ML-1d; Wed, 26 Mar 2025 13:23:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1txUTA-0002Lu-DC; Wed, 26 Mar 2025 13:23:12 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1txUT8-0003Ao-Gq; Wed, 26 Mar 2025 13:23:12 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52QFvNEr032156;
 Wed, 26 Mar 2025 17:23:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=Wgjt40
 wIIlKObQrfb7GVq4l5s+GiGOOMxmVWA1++7wg=; b=sVf+Jvke+uWRTt689GEbCU
 sTPIZ4UhQmTm8E4bc4fwWMdYlLWL3NCTQmT3HTX0XOr/sTHpaLZB1J0eAG+RbAMk
 sMxDTt5nlFbTseUTh0varnITqIHfimjKKGaHjdGWz8Jd4pnrYdJ7HGDTdov/3iql
 n9SNPcR1X21UyBVkknPzZkVK+kNiAIsMQ44zZunaAidEiPRE7Jp7BMTgRJKa2E1w
 pbETap2rb+x0JA2cDjZFED+mlyTFnVydVr71MIrlL+SvTR5EGsFHnfN99XXfk5Mh
 EmCZ4h1XfFBZPbk6nr4nJ00IqZ56hp6qBOU/km+zR0k/9KdxzEWNdGnngeQw/OMA
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45m3q0n8r6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Mar 2025 17:23:01 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 52QHIaE5007214;
 Wed, 26 Mar 2025 17:23:01 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45m3q0n8r4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Mar 2025 17:23:01 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52QEOX9i020105;
 Wed, 26 Mar 2025 17:23:00 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45j8hp1e96-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Mar 2025 17:23:00 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 52QHMu4520775276
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 26 Mar 2025 17:22:56 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5D5C32004B;
 Wed, 26 Mar 2025 17:22:56 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7BA6620040;
 Wed, 26 Mar 2025 17:22:54 +0000 (GMT)
Received: from [9.39.30.126] (unknown [9.39.30.126])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 26 Mar 2025 17:22:54 +0000 (GMT)
Message-ID: <1b46fa60-6460-42fb-b77b-fe03cb9ea591@linux.ibm.com>
Date: Wed, 26 Mar 2025 22:52:53 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 07/10] ppc/pnv: Introduce Power11 PowerNV machine
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?=
 <fbarrat@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
References: <20250325112319.927190-1-adityag@linux.ibm.com>
 <20250325112319.927190-8-adityag@linux.ibm.com>
 <952b3afa-dc63-4230-bdff-5decabc8c25c@kaod.org>
 <8567b41e-f2b8-413c-93b8-15c74788c171@linux.ibm.com>
 <5a08e139-a18d-4aae-836f-0ec0bb8fadc9@kaod.org>
 <6d610966-cdc0-42c2-abb8-e80b4be1178d@linux.ibm.com>
 <6e830dd1-88c1-4029-bae7-d2817d95262f@kaod.org>
 <2ffb5a70-be51-45e9-82a1-b71362221577@kaod.org>
Content-Language: en-US
From: Aditya Gupta <adityag@linux.ibm.com>
In-Reply-To: <2ffb5a70-be51-45e9-82a1-b71362221577@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: TCZKdsONKzjgGzCyG8GROf62nbRf4uiv
X-Proofpoint-GUID: haOQjwJYd5ZWE9YLLicDnfwUHzyVmJzg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-26_08,2025-03-26_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 malwarescore=0
 suspectscore=0 clxscore=1015 spamscore=0 lowpriorityscore=0 phishscore=0
 mlxlogscore=999 priorityscore=1501 adultscore=0 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503260104
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

On 26/03/25 16:12, Cédric Le Goater wrote:

> [ ... ]
>
>> You could use a buildroot image instead. :
>>
>> https://github.com/buildroot/buildroot/blob/master/configs/qemu_ppc64le_powernv8_defconfig
>
> Images pushed here :
>
> https://github.com/legoater/qemu-ppc-boot/tree/main/buildroot/qemu_ppc64le_powernv8-2025.02
>
>   qemu-system-ppc64 -m 1G -M powernv10 \
>     -kernel ./buildroot/qemu_ppc64le_powernv8-2025.02/vmlinux \
>     -append root=/dev/nvme0n1 \
>     -device nvme,bus=pcie.2,addr=0x0,drive=drive0,serial=1234 \
>     -drive 
> file=./buildroot/qemu_ppc64le_powernv8-2025.02/rootfs.ext2,if=none,id=drive0,format=raw,cache=none 
> \
>     -device e1000e,bus=pcie.1,addr=0x0,netdev=net0 \
>     -netdev user,id=net0 \
>     -serial mon:stdio -nographic -snapshot
>
>   [    0.010515922,5] OPAL v7.1-106-g785a5e307 starting...
>   ...
>   [    0.000000][    T0] Linux version 6.12.9 (legoater@ryzen) 
> (powerpc64le-buildroot-linux-gnu-gcc.br_real (Buildroot 2025.02) 
> 13.3.0, GNU ld (GNU Binutils) 2.43.1) #1 SMP Wed Mar 26 11:11:35 CET 2025
>   ...
>
> Please use these images or the opbuild image which should also work but
> the CPU won't be recognized as a POWER11.

Thank you, will use those images then.

opbuild image boots but since it doesn't "print" p11 in its dmesg log, the
powernv test fails with it. Will use your images.


Thanks,

- Aditya Gupta

>
> Thanks,
>
> C.
>

