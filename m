Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D00DCD98F2
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 13:21:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wc13q-0004zr-2t; Tue, 23 Jun 2026 09:21:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <freude@linux.ibm.com>)
 id 1wc13o-0004zG-Df; Tue, 23 Jun 2026 09:21:04 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <freude@linux.ibm.com>)
 id 1wc13m-0008Fd-9J; Tue, 23 Jun 2026 09:21:04 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65NBmxOC1806344; Tue, 23 Jun 2026 13:20:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=a/d7M8mwrf5sar+WVGOUJKCk7xvbINo8FHmMndJWuBs=; b=TGLFbu0Ie7Ra
 6/lv0dZjxH8Ff0x0TWzO1NEVdAwYQrU/NK35K0jzeDyWftWk+fhY+ME6W1+Ij4Bo
 WME2GRZhWB7WqvuqZSh9uXfllOaiGXT2QTBah4wO2IbnEVbEuBD58Wwa95wzx6Z1
 C228z8BsGtN/jMx1ug1i6C0FfnWbiJk8xH++ZMfch9DZtjZ68V8fd4vOtT24k4DH
 YLntsGf6e9bfk92jEkv/eVCjWAcMNrei6fr+JKxRWM1oV/cVETmavxYOOx4iIsXr
 HWlR0SonLoYXoKJbMekO+0U1G410V6B+uq6vK+e6O0LE8/2WgyD/wFTREckbS3nC
 cgZ390JLGw==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewh9genej-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 Jun 2026 13:20:57 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65NDJiC5022174;
 Tue, 23 Jun 2026 13:20:57 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ex5jwbh9u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 Jun 2026 13:20:57 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65NDKtVp30999262
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 23 Jun 2026 13:20:56 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BC67558054;
 Tue, 23 Jun 2026 13:20:55 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5D00F58052;
 Tue, 23 Jun 2026 13:20:54 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 23 Jun 2026 13:20:54 +0000 (GMT)
MIME-Version: 1.0
Date: Tue, 23 Jun 2026 15:20:53 +0200
From: Harald Freudenberger <freude@linux.ibm.com>
To: Finn Callies <fcallies@linux.ibm.com>
Cc: richard.henderson@linaro.org, iii@linux.ibm.com, david@kernel.org,
 thuth@redhat.com, berrange@redhat.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, linux390-list@tuxmaker.boeblingen.de.ibm.com,
 linux-s390@vger.kernel.org, dengler@linux.ibm.com,
 borntraeger@linux.ibm.com, cohuck@redhat.com
Subject: Re: [PATCH v7 15/17] docs/s390: Document CPACF instructions support
Mail-Reply-To: freude@linux.ibm.com
In-Reply-To: <b2dd136a-828a-4771-9f9d-5da8a4f6634e@linux.ibm.com>
References: <20260617094820.34402-1-freude@linux.ibm.com>
 <20260617094820.34402-16-freude@linux.ibm.com>
 <b2dd136a-828a-4771-9f9d-5da8a4f6634e@linux.ibm.com>
Message-ID: <e24743de41855903880667f0f12f66bd@linux.ibm.com>
X-Sender: freude@linux.ibm.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ZOqn88ECOxjzKVnnen5mFBf5NQxqY5pW
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDEwOSBTYWx0ZWRfXykK4Z00c6twJ
 ESVZVDtcZDmcu1OLWHTyLbvuk4NiPXdbDooNFj0T43bb82OgSJKpmTpDxEmjjm1pnYV/XX83DRX
 q3SGvPqGaMjaB24JQ63GZroL7pT1RQ4=
X-Authority-Analysis: v=2.4 cv=c62bhx9l c=1 sm=1 tr=0 ts=6a3a883a cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=JWg8YiNvps0iREzOQCoA:9 a=5wi_FRADO1KgGG3s:21 a=CjuIK1q_8ugA:10
 a=O8hF6Hzn-FEA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDEwOSBTYWx0ZWRfX3GSFo8/vYn8K
 6xU1nOpBGmWoRYTfU3C0GkS+m6oo9aNpqfw6wYg6PplZBebGeRCFLeFPGUUp378UK/4/6Y4NkQT
 Jr14IBYNf5eoD6qNHr1L9Y8DNDUTQlxdCQt8LtwDiYty4zS3ZEtdZG4KqqjbdRiRfkNALS1itno
 1mTM7LhtKFoEv8JV9fY3fXzChN0VbXV2QLSHJZUQyrVHCkARtDicUE9dweZOxIm3pb/5RU7I9FS
 W9ITWmWLXvKTgfN5ERcRYrzu9AZK0YKx0FNIZyftgCFYWjDuhwFvqC7vkymTE6XYZr88lmi8Rb0
 tyZW84T+MmQ4z7IzhgPasuJ3oApeLuRF1dZn3+2KKpGLQX9eNAJCdT2PN909PiNQPSREE3Ty2rK
 iXof7bnJefkvKa5Q9WStiwEA17VS/ROabE2+BzOuelkXJsY8W4LelIsm4Cfido6S/LI9Xo87xX9
 Ql0/Ekd8xVvqqaxR3yQ==
X-Proofpoint-ORIG-GUID: ZOqn88ECOxjzKVnnen5mFBf5NQxqY5pW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_03,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 adultscore=0 clxscore=1015 suspectscore=0
 priorityscore=1501 phishscore=0 spamscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606230109
Received-SPF: pass client-ip=148.163.158.5; envelope-from=freude@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: freude@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 2026-06-18 08:28, Finn Callies wrote:
> On 17.06.26 11:48, Harald Freudenberger wrote:
>> Add a first document covering the Qemu s390 CPACF instructions
>> and functions supported.
>> 
>> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
> 
> With the one comment applied:
> 
> Reviewed-by: Finn Callies <fcallies@linux.ibm.com>
> 
>> ---
>>   docs/system/s390x/cpacf.rst  | 116 
>> +++++++++++++++++++++++++++++++++++
>>   docs/system/target-s390x.rst |   1 +
>>   2 files changed, 117 insertions(+)
>>   create mode 100644 docs/system/s390x/cpacf.rst
>> 
>> diff --git a/docs/system/s390x/cpacf.rst b/docs/system/s390x/cpacf.rst
>> new file mode 100644
>> index 0000000000..85f35b4e9c
>> --- /dev/null
>> +++ b/docs/system/s390x/cpacf.rst
>> @@ -0,0 +1,116 @@
>> +CPACF Support
>> +=============
>> +
>> +CPACF
>> +-----
>> +
>> +CP Assist for Cryptographic Function (CPACF) is a hardware-integrated
>> +coprocessor feature built into every  processor core of IBM Z and
>> +LinuxONE mainframes (s390x architecture). It provides high-speed,
>> +hardware-accelerated encryption and hashing directly on the CPU.
>> +
>> +CPACF provides a set of z/Architecture instructions (known as Message
>> +Security Assist or MSA) that execute cryptographic operations
>> +synchronously with the main processor.
>> +
>> +- Symmetric Encryption: Support for AES (128, 192, 256-bit), DES, and
>> +  Triple-DES (TDES).
>> +- Hashing: Acceleration for SHA-1, SHA-2 (up to SHA-512), SHA-3 and
>> +  SHAKE.
>> +- Random Number Generation: Pseudo Random Number Generator (PRNG) and
>> +  a hardware-based True Random Number Generator (TRNG).
>> +- Asymmetric Support: Elliptic Curve Cryptography (ECC) primitives
>> +  P-256, P-384, P-521, Montgomery/Edwards curves (e.g., Ed25519).
>> +
>> +Documentation about CPACF instructions is public available and
>> +can be found in the "z/Architecture Principles of Operation"
>> +accessible at the IBM documentation hub https://www.ibm.com/docs/en.
>> +For example the latest version as a pdf is available here:
>> +https://www.ibm.com/support/pages/zvm/library/other/22783214.pdf
>> +
>> +
>> +CPACF instructions
>> +------------------
>> +
>> +Here is a list of implemented CPACF instructions and the supported
>> +functions for each instruction:
>> +
>> +KDSA (COMPUTE DIGITAL SIGNATURE AUTHENTICATION)
>> +- Function code 0x00 - Function Query
>> +
>> +KIMD (COMPUTE INTERMEDIATE MESSAGE DIGEST)
>> +- Function code 0x00 - Function Query
>> +- Function code 0x02 - CPACF_KIMD_SHA_256
>> +- Function code 0x03 - CPACF_KIMD_SHA_512
>> +
>> +KLMD (COMPUTE LAST MESSAGE DIGEST)
>> +- Function code 0x00 - Function Query
>> +- Function code 0x02 - CPACF_KLMD_SHA_256
>> +- Function code 0x03 - CPACF_KLMD_SHA_512
>> +
>> +KM (CIPHER MESSAGE)
>> +- Function code 0x00 - Function Query
>> +- Function code 0x12 - CPACF_KM_AES_128
>> +- Function code 0x13 - CPACF_KM_AES_192
>> +- Function code 0x14 - CPACF_KM_AES_256
>> +- Function code 0x1a - CPACF_KM_PAES_128
>> +- Function code 0x1b - CPACF_KM_PAES_192
>> +- Function code 0x1c - CPACF_KM_PAES_256
>> +- Function code 0x32 - CPACF_KM_XTS_128
>> +- Function code 0x34 - CPACF_KM_XTS_256
>> +- Function code 0x3a - CPACF_KM_PXTS_128
>> +- Function code 0x3c - CPACF_KM_PXTS_256
>> +
>> +KMAC (COMPUTE MESSAGE AUTHENTICATION CODE)
>> +- Function code 0x00 - Function Query
>> +
>> +KMC (CIPHER MESSAGE WITH CHAINING)
>> +- Function code 0x00 - Function Query
>> +- Function code 0x12 - CPACF_KMC_AES_128
>> +- Function code 0x13 - CPACF_KMC_AES_192
>> +- Function code 0x14 - CPACF_KMC_AES_256
>> +- Function code 0x1a - CPACF_KMC_PAES_128
>> +- Function code 0x1b - CPACF_KMC_PAES_192
>> +- Function code 0x1c - CPACF_KMC_PAES_256
>> +
>> +KMCTR (CIPHER MESSAGE WITH COUNTER)
>> +- Function code 0x00 - Function Query
>> +- Function code 0x12 - CPACF_KMCTR_AES_128
>> +- Function code 0x13 - CPACF_KMCTR_AES_192
>> +- Function code 0x14 - CPACF_KMCTR_AES_256
>> +- Function code 0x1a - CPACF_KMCTR_PAES_128
>> +- Function code 0x1b - CPACF_KMCTR_PAES_192
>> +- Function code 0x1c - CPACF_KMCTR_PAES_256
>> +
>> +KMF (CIPHER MESSAGE WITH CIPHER FEEDBACK)
>> +- not supported
>> +
>> +KMO (CIPHER MESSAGE WITH OUTPUT FEEDBACK)
>> +- not supported
> 
> You list these as unsupported but KMA is missing completely. At least
> mention it as unsupported as well as you do so for KMO and KMF or
> leave the unsupported ones out completely.
> 

KMA is MSA 8. I am not sure if qemu even has configured some MSA 8.
I'll check this - but as of now all unknown instructions (and KMA is
one of this) would result in a Operation Exception. However, at least
KMA shold be listed then below. I'll check this maybe add KMA query
support or at least document it here.

Update: MSA 8 is listed in qemu. So i added KMA to the docu.

>> +
>> +PCC (PERFORM CRYPTOGRAPHIC COMPUTATION)
>> +- Function code 0x00 - Function Query
>> +- Function code 0x32 - compute XTS param AES-128
>> +- Function code 0x34 - compute XTS param AES-256
>> +- Function code 0x3a - compute XTS param Encrypted AES-128
>> +- Function code 0x3c - compute XTS param Encrypted AES-256
>> +
>> +PCKMO (PERFORM CRYPTOGRAPHIC KEY MANAGEMENT OPERATION)
>> +- Function code 0x00 - Function Query
>> +- Function code 0x12 - CPACF_PCKMO_ENC_AES_128_KEY
>> +- Function code 0x13 - CPACF_PCKMO_ENC_AES_192_KEY
>> +- Function code 0x14 - CPACF_PCKMO_ENC_AES_256_KEY
>> +
>> +PRNO (PERFORM RANDOM NUMBER OPERATION)
>> +- Function code 0x00 - Function Query
>> +- Function code 0x72 - CPACF_PRNO_TRNG
>> +
>> +Note that the use of a not supported CPACF instruction (KMF and KMO)
>> +or invocation of a not listed function will result in a Specification
>> +Exception.
>> +
>> +Not listed CPACF instructions (KMF, KMO) cause an Operation Exception

                                    ^^^ here I added KMA

>> +when used. Not listed functions cause a Specification Exception when
>> +called. If only the query function is listed (KDSA), then the query
>> +function will return a function status word with all but the query
>> +function bit set to 0.
>> diff --git a/docs/system/target-s390x.rst 
>> b/docs/system/target-s390x.rst
>> index 94c981e732..49159826eb 100644
>> --- a/docs/system/target-s390x.rst
>> +++ b/docs/system/target-s390x.rst
>> @@ -35,3 +35,4 @@ Architectural features
>>      s390x/bootdevices
>>      s390x/protvirt
>>      s390x/cpu-topology
>> +   s390x/cpacf

