Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22583CCD1AB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 09:59:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBVbK-0006gQ-Ks; Wed, 22 Oct 2025 05:57:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vishalc@linux.ibm.com>)
 id 1vBVbI-0006fo-OO; Wed, 22 Oct 2025 05:57:48 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vishalc@linux.ibm.com>)
 id 1vBVbF-0007C2-PN; Wed, 22 Oct 2025 05:57:48 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59M8W4ei011630;
 Wed, 22 Oct 2025 09:57:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=sglHjd
 0MbegJDGZMVSZwxgjI0sstG9jvH8zxs7DqlQA=; b=HyudFv3aKJcvI6ki8ThzWA
 eQCULpqd4oC7b4/XHEV7A4bM00ExoggqcCBPxlMxPlF4gLcOuXI2aRY8hNKAU/dl
 f0ed1vDWJxKUpaTII0CT2Q1RipPch10ojdtEB5aNsWHs5iCLWkvFGXt/jcUuCo/K
 CuUWBr9/J2YV/fY1veH84wcHl2fbQhML+PfJXDIehrlVK47mPFm3ujQgZi/CYymH
 76P2kwnz8X2Saz2pJQiMxfPn4nCx8AFc+YYxYgCL1zMbxOssGv+EUwq9IXip69Oh
 Iafx2X6LhI4eVozL7ZSSjfEPkrCOIZ/IQtZJP3wDst5+aj3877B/6HqJIqP4pz9A
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v31camjd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 22 Oct 2025 09:57:38 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59M9Vr7X028750;
 Wed, 22 Oct 2025 09:57:38 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v31camj9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 22 Oct 2025 09:57:38 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59M8M4et011066;
 Wed, 22 Oct 2025 09:57:37 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 49vqx17awu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 22 Oct 2025 09:57:37 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59M9vXhd56033566
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 22 Oct 2025 09:57:33 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A0BA2200DE;
 Wed, 22 Oct 2025 09:57:33 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 722C4200DC;
 Wed, 22 Oct 2025 09:57:31 +0000 (GMT)
Received: from [9.39.25.31] (unknown [9.39.25.31])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 22 Oct 2025 09:57:31 +0000 (GMT)
Message-ID: <5696ab54-e3d7-447e-9b06-52df38bf3b73@linux.ibm.com>
Date: Wed, 22 Oct 2025 15:27:30 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v5 6/6] hw/ppc: Pass errp to load_image_targphys() and
 report errors
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: adityag@linux.ibm.com, harshpb@linux.ibm.com, milesg@linux.ibm.com,
 npiggin@gmail.com, peter.maydell@linaro.org, alistair23@gmail.com,
 qemu-devel@nongnu.org, qemu-ppc@nongnu.org, berrange@redhat.com,
 hpoussin@reactos.org
References: <20251021105442.1474602-2-vishalc@linux.ibm.com>
 <20251021105442.1474602-11-vishalc@linux.ibm.com>
 <86222acd-6ccd-b833-84da-8851f5cb29f2@eik.bme.hu>
Content-Language: en-US, en-IN
From: Vishal Chourasia <vishalc@linux.ibm.com>
In-Reply-To: <86222acd-6ccd-b833-84da-8851f5cb29f2@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: QRU40eVR8zwy_Sy-GkdAF3MAlnVw69Pu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfX+4HrkhtObt9R
 ss7CIb7h2dd0Ay8+N7pf9YjEMOSHokJ76YXX2NAjAAmgW6sN3j0i+v3OEcWvyhGE15DSn62RMYE
 cJDyBTCM2Eon4VgqwS4P1j6gTMQcGy63Fpa1wVzcaOWCkNErevBSVos4tics1jOeaDLkud+U+Gs
 vp2SZ3DE4xhPcai0Mh/NEx251Cqu/x0SMsPU7Bh7XbyJ+Aa0jpYS9bdF54PfzRIeOB0fsOAOheV
 Y6Xq7zm8BDSS2txehvHLr64ThE8B4XtE3eERk6ySQmUaCPMckz9j6uB2+odOmxiwH6CxIoXZjrQ
 S3LjUGltLr5qbJcOt1xWPg55Q1U2UWBtr+HoG2xi+Dnpqwp50ipuRLjZmPVRVxFjzjyfqf+IjFg
 eEcPU+DCWstDFtOWrbf6/nrbF4tLPg==
X-Proofpoint-GUID: XEC17EAurzlF0czbGT-ww5jwtQbRhXOd
X-Authority-Analysis: v=2.4 cv=SKNPlevH c=1 sm=1 tr=0 ts=68f8aa92 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=hSTLkurHX-YfEhOL52UA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 spamscore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022
Received-SPF: pass client-ip=148.163.158.5; envelope-from=vishalc@linux.ibm.com;
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


On 21/10/25 18:09, BALATON Zoltan wrote:
> On Tue, 21 Oct 2025, Vishal Chourasia wrote:
>> Pass errp to load_image_targphys() calls in ppc machine initialization
>> to capture detailed error information when loading firmware, kernel,
>> and initrd images.
>>
>> Use error_reportf_err() instead of error_report() to print the
>> underlying error details along with context about which image failed
>> to load.
>>
>> Signed-off-by: Vishal Chourasia <vishalc@linux.ibm.com>
>> ---
>> hw/ppc/amigaone.c      | 15 ++++++++-------
>> hw/ppc/e500.c          | 17 +++++++++--------
>> hw/ppc/mac_newworld.c  | 25 +++++++++++++++----------
>> hw/ppc/mac_oldworld.c  | 25 +++++++++++++++----------
>> hw/ppc/pegasos2.c      | 17 +++++++++++------
>> hw/ppc/pnv.c           | 31 ++++++++++++++-----------------
>> hw/ppc/ppc440_bamboo.c |  9 +++++----
>> hw/ppc/prep.c          | 25 +++++++++++++++----------
>> hw/ppc/sam460ex.c      |  9 +++++----
>> hw/ppc/spapr.c         | 15 ++++++++-------
>> hw/ppc/virtex_ml507.c  | 17 +++++++++++------
>> 11 files changed, 116 insertions(+), 89 deletions(-)
>>
>> diff --git a/hw/ppc/amigaone.c b/hw/ppc/amigaone.c
>> index 5c5acc9872..bd14bed243 100644
>> --- a/hw/ppc/amigaone.c
>> +++ b/hw/ppc/amigaone.c
>> @@ -276,6 +276,7 @@ static void amigaone_init(MachineState *machine)
>>     DriveInfo *di;
>>     hwaddr loadaddr;
>>     struct boot_info *bi = NULL;
>> +    Error *errp = NULL;
>>
>>     /* init CPU */
>>     cpu = POWERPC_CPU(cpu_create(machine->cpu_type));
>> @@ -324,9 +325,9 @@ static void amigaone_init(MachineState *machine)
>>             error_report("Could not find firmware '%s'", 
>> machine->firmware);
>>             exit(1);
>>         }
>> -        sz = load_image_targphys(filename, PROM_ADDR, PROM_SIZE, NULL);
>> -        if (sz <= 0 || sz > PROM_SIZE) {
>> -            error_report("Could not load firmware '%s'", filename);
>> +        sz = load_image_targphys(filename, PROM_ADDR, PROM_SIZE, 
>> &errp);
>> +        if (errp) {
>> +            error_reportf_err(errp, "Could not load firmware '%s': 
>> ", filename);
>>             exit(1);
>
> If all that's done with an errp is checking for error, printing it and 
> then exit then isn't that what passing &error_fatal is for? So these 
> should all just do that instead of open coding it, don't they? This 
> would lose the general local error messages and those would be 
> replaced by the more specific ones from the load functions that should 
> be enough. (I'm always unsure how to correctly use error and errp so 
> some more expert opinion could be useful but otherwise this series 
> does not seem to simplify things much.)

I am planning to add filename information inside the 
load_image_targphys() so that we won't need additional error reporting 
regarding the file type in the caller.
We can use error_fatal where ever we are just exiting after printing the 
error. However, in some cases, it may proceed for different reasons in 
which case errp would be more appropriate.

> If you don't want to convert all these other machines I'm also OK with 
> leaving these passing NULL to load_image_targphys for now and keep 
> current error handling which can then be converted later so 
> alternatively you can drop this patch if you can't finish it before 
> the freeze. 

I will try to improve at least for the PPC boards and see if that would 
work better.

Thanks,
Vishal

>
> Regards,
> BALATON Zoltan

