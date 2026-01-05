Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B83AC2A07C
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Jan 2026 09:25:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vcgqL-0005pg-W7; Mon, 05 Jan 2026 04:25:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1vcgqK-0005pF-Bq; Mon, 05 Jan 2026 04:25:40 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1vcgqH-0004Sr-Eg; Mon, 05 Jan 2026 04:25:40 -0500
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 604NGZC2002431;
 Mon, 5 Jan 2026 09:25:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=69cgyD
 13Ji3OT9/f8FnxwpO9XE0c404evQnspeu2DiQ=; b=nz+PQ1Qic9HVcLnfNSpOqO
 8G1i1sgD2+rkq4c/C2qN85HQHrOyX43yDgjEJTkaWq3II6DUm3xKMHdzdURJ4Vux
 xEjgC74KkEWgPDBvhglaNf0m5OJmpIDCCanPlmnQteohkAfvaeYshNy0zYXPKFGa
 2v41X/bkAdXhypyrzwlo6bvDE2QUHxSMa9J5xuN1EMv/8Ie1OY4htg8dlpM+iG1P
 EEIRbzxqX5Ka/mCGmfAFSOByMlzsq0Pv01rURaj5+wKwxS+oQ2/PKcXR/hZEBMyo
 hH+c8mpyiEH4Ci4In3qX5TZMdD0rNnNzDV9fnIHPHBVyHEx+AaHn2QnEk70WzJWA
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4betspxfsw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 05 Jan 2026 09:25:34 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 6058tYP4000607;
 Mon, 5 Jan 2026 09:25:34 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4betspxfss-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 05 Jan 2026 09:25:33 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 6056G3us023501;
 Mon, 5 Jan 2026 09:25:32 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4bg3rm1jgn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 05 Jan 2026 09:25:32 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6059PSWZ42533236
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 5 Jan 2026 09:25:28 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 523EA2004B;
 Mon,  5 Jan 2026 09:25:28 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6D24420040;
 Mon,  5 Jan 2026 09:25:26 +0000 (GMT)
Received: from [9.109.199.210] (unknown [9.109.199.210])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  5 Jan 2026 09:25:26 +0000 (GMT)
Message-ID: <ba5e9f54-568d-4058-8209-0578747dad61@linux.ibm.com>
Date: Mon, 5 Jan 2026 14:55:25 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ppc/pnv: Add dummy MMIO support for OCMB chips
To: Caleb Schlossin <calebs@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, npiggin@gmail.com, milesg@linux.ibm.com,
 rathc@linux.ibm.com, chalapathi.v@linux.ibm.com
References: <20251224142249.1356424-1-calebs@linux.ibm.com>
 <41ece6d5-e211-4b32-ab87-d1fe5f359228@linux.ibm.com>
 <9006fe79-1065-464d-bfba-3b9bf5a422b4@linux.ibm.com>
Content-Language: en-US
From: Aditya Gupta <adityag@linux.ibm.com>
In-Reply-To: <9006fe79-1065-464d-bfba-3b9bf5a422b4@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: OqD4rZfJAfvPDAeqTgTLTKM4F9Rlo387
X-Authority-Analysis: v=2.4 cv=Jvf8bc4C c=1 sm=1 tr=0 ts=695b838e cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=D4yLe6ciAAAA:8 a=VnNF1IyMAAAA:8 a=6bc-nPlps480dDLd2gsA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=RJBimmv2CioV9QQA5JKZ:22
X-Proofpoint-ORIG-GUID: VAVRsOiOWchMyqxtPuv4R4qe9WhOkmtx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA1MDA4MiBTYWx0ZWRfX3uCnXC0fKD+H
 OJmOmCXumZ+PBfkf/bkH3nQ4Nlo2a28b51W6lFxc9wmxELwVrl7lvrdJTqpHdgM/2DViYNyf03W
 SLnaAthIsEMo5COcABRQvqyB0tszNGaqCybPAdv72sQQ86tb+K/EAtq66v2ecYCIoHyNfHPdQBF
 HC2NG7rh+gvGtkEVBUIiguVocgDF7u7cRHl1RDF0h6bulerPkXygGKERu45wxdN3K31tHTGNMAY
 vBLOk+ojUeCW3fcdBmLfbWGeaAQImVbU0qIix/mSr2mkKrsyA5PEddAqCoEAApYDxsjxWMiepJv
 dhTX7Kd7WVXVI3HPm7xTqZ3EB851tTB3L7PsAU+lSzcF3uD8vxE/KNraBOyxslepsflXi6J4CSN
 3i7i5ng8RKv7wlPH3EVOrHtCFkDlrkC/FunJ+RIAzZYEUcjuKz/HNBxnwMLsou3aVxAZl+GVKef
 plDw471umkOVXp+8MYw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-05_01,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 adultscore=0 spamscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2512120000
 definitions=main-2601050082
Received-SPF: pass client-ip=148.163.156.1; envelope-from=adityag@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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


On 02/01/26 21:31, Caleb Schlossin wrote:
>
> On 1/1/26 12:45 AM, Aditya Gupta wrote:
>> On 24/12/25 19:52, Caleb Schlossin wrote:
>>
>>> The Power Hypervisor for P10 expects to be able to access certain
>>> Open CAPI Memory Buffer (OCMB) chip registers.  Since QEMU does not
>>> currently support these registers, several access errors are being
>>> posted.  The hypervisor is able to progress despite these errors,
>>> but it does create unwanted noise on the console.  Adding some
>>> dummy MMIO support for this IO region in order to suppress the
>>> error messages.
>> Hi Caleb,
>>
>> If there any public document/spec available that documents these registers ? Can you please point me to it.
>>
>> I don't find any 'ocmb' mention in any docs here: https://computeexpresslink.org/resource/opencapi-specification-archive/
>>
>> Since a new TODO is getting introduced here to implement those register accesses, it can only be done if some public information is available.
>>
>>
>> Thanks,
>> - Aditya G
> Aditya,
> I did some searching and couldn't seem to find the registers used in any of the public OpenCAPI documentation. I think the registers being accessed are Vendor-specific and likely not publicly defined. If that is a new requirement, we don't have to proceed with upstreaming of this patch and can keep it private.

Yes makes sense.

Having TODOs which cannot be implemented, until information is made 
public, won't be good.

Thanks for clarifying Caleb.


- Aditya G


>
> Thanks,
> Caleb
>
>>
>>> Signed-off-by: Glenn Miles <milesg@linux.ibm.com>
>>> Signed-off-by: Caleb Schlossin <calebs@linux.ibm.com>
>>> ---
>>>    hw/ppc/meson.build        |   1 +
>>>    hw/ppc/pnv.c              |  10 ++++
>>>    hw/ppc/pnv_ocmb.c         | 103 ++++++++++++++++++++++++++++++++++++++
>>>    include/hw/ppc/pnv.h      |   3 ++
>>>    include/hw/ppc/pnv_chip.h |   2 +
>>>    include/hw/ppc/pnv_ocmb.h |  38 ++++++++++++++
>>>    6 files changed, 157 insertions(+)
>>>    create mode 100644 hw/ppc/pnv_ocmb.c
>>>    create mode 100644 include/hw/ppc/pnv_ocmb.h
>>>

