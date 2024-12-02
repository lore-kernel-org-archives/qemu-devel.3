Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61A9AD78333
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 15:59:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tI8oN-0004SW-JC; Mon, 02 Dec 2024 10:58:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1tI8oM-0004SH-GI; Mon, 02 Dec 2024 10:58:10 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1tI8oK-0007br-Pj; Mon, 02 Dec 2024 10:58:10 -0500
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B2AcqmQ019533;
 Mon, 2 Dec 2024 15:58:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=xZQ69x
 aoMi3/lep/8B0Spc4dK/U0wslRbBIr2NlAxPQ=; b=QQVrv/FspMRWy2N6+o0I1e
 itt0mkuSPgPAQgj3XScTl/9F84F9kpJ8KfJ0oX42OdM+I1TjpYgxyqyeNuqXmEWN
 7mHtUqWdFf18DJqh3BW4cFOUF4nMPq15SFW8/3on+A64ls4Wwb08BfNb2NtcdXSF
 jJQ3WY5SYx3ELiC41VX7calvQLXJGxccjaGr/lWd79+tXetWaZr916EBz6Y9VYLA
 NStljwRZO1BiN23o47YSR+B7E2PzjpA/ZPOAGPkH46wshskpQTWEnLZFjr/E7u6v
 HlM7PzVrJl5Ol5/civw7NHtuFroXbj5fj9JEA4rOuJT+/ZDVvvufc+0kCXSzox1w
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 438kfge5kf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 02 Dec 2024 15:58:04 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4B26gxai023634;
 Mon, 2 Dec 2024 15:58:03 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 438e1mtkvh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 02 Dec 2024 15:58:03 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 4B2Fw29i51053028
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 2 Dec 2024 15:58:03 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DFC1758059;
 Mon,  2 Dec 2024 15:58:02 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 25BC75805C;
 Mon,  2 Dec 2024 15:58:02 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  2 Dec 2024 15:58:02 +0000 (GMT)
Message-ID: <d3d73795-3f59-490c-9e54-c6c358af62d0@linux.ibm.com>
Date: Mon, 2 Dec 2024 10:58:01 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 25/26] target/arm/kvm-rme: Add measurement log
To: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: peter.maydell@linaro.org, richard.henderson@linaro.org, philmd@linaro.org, 
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, alex.bennee@linaro.org,
 Stefan Berger <stefanb@linux.vnet.ibm.com>
References: <20241125195626.856992-2-jean-philippe@linaro.org>
 <20241125195626.856992-27-jean-philippe@linaro.org>
 <02b90518-2996-4231-bee9-43ce313669b0@linux.ibm.com>
 <Z0XREyMovNyB4s6t@redhat.com> <20241126162149.GC956991@myrica>
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20241126162149.GC956991@myrica>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: e_Dqq_xwypzIbdYGytPkyHoRdqonJ3CH
X-Proofpoint-GUID: e_Dqq_xwypzIbdYGytPkyHoRdqonJ3CH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 spamscore=0 clxscore=1011 malwarescore=0 bulkscore=0 adultscore=0
 priorityscore=1501 mlxlogscore=999 impostorscore=0 phishscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412020133
Received-SPF: pass client-ip=148.163.156.1; envelope-from=stefanb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
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



On 11/26/24 11:21 AM, Jean-Philippe Brucker wrote:
> On Tue, Nov 26, 2024 at 01:45:55PM +0000, Daniel P. Berrangé wrote:
>> On Mon, Nov 25, 2024 at 05:23:44PM -0500, Stefan Berger wrote:
>>>
>>>
>>> On 11/25/24 2:56 PM, Jean-Philippe Brucker wrote:
>>>> Create an event log, in the format defined by Trusted Computing Group
>>>> for TPM2. It contains information about the VMM, the Realm parameters,
>>>> any data loaded into guest memory before boot and the initial vCPU
>>>> state.
>>>>
>>>> The guest can access this log from RAM and send it to a verifier, to
>>>> help the verifier independently compute the Realm Initial Measurement,
>>>> and check that the data we load into guest RAM is known-good images.
>>>> Without this log, the verifier has to guess where everything is loaded>
>>> and in what order.
>>>
>>> Typically these logs are backed by extensions of TPM PCRs and when you send
>>> a log to a verifier you send a TPM quote along with it for the verifer to
>>> replay the log and check the TPM quote. Also, early code in the firmware is
>>> typically serving as a root of trust that starts the chain of measurements
>>> of code and data, first measuring itself and then other parts of the
>>> firmware before it jumps into the other parts. Now here you seem to just
>>> have a log and no PCR extensions and therefore no quote over PCRs can be
>>> used.
> 
> Indeed, in our case it's the trusted hypervisor (RMM) that provides the
> equivalent to TPM quote and PCRs. In more details:
> 
> 1. QEMU loads images into guest RAM by calling KVM, which calls RMM.
> 2. RMM calculates a hash of the image content, adds it to a rolling hash
>     the "Realm Initial Measurement" (RIM), which I believe is equivalent to
>     a PCR.

I am not familiar with RIM. A link to read more about it would be helpful.

> 3. During remote attestation, the guest sends evidence containing this RIM
>     signed by the root of trust, along with a signed token identifying the
>     platform (hardware, firmware, RMM).

Is this a well known manufacturer key that one would expect for 
signature verification or is it locally created?

> 4. The verifier checks the signature and the platform token, so it trusts
>     the RMM and the RIM.
> 
>>> Then what prevents anyone from faking this log and presenting a
>>> completely fake log to the verifier?
> 
> Absolutely, the verifier does not trust the content of the log, it only
> uses the log as helper to try to reconstruct the RIM. For example a log
> event says "I loaded image XYZ at address A", then the verifier searches
> image XYZ in its database of known-good images, calculates the hash that
> would result from loading that image at address A. Any malformed event in

Hopefully just calculating a hash over the image will do and the 
location an image was loaded to, like address A (relocation?), doesn't 
matter...


