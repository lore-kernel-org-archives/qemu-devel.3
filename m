Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5A91CF45D2
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 21:44:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfPhG-0007Qu-Ix; Mon, 12 Jan 2026 16:43:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1vfPh5-0007D9-71; Mon, 12 Jan 2026 16:43:23 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1vfPh3-0001Aa-HX; Mon, 12 Jan 2026 16:43:22 -0500
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60CKGMqW026893;
 Mon, 12 Jan 2026 21:43:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=mGG5ZE
 DKXQPc4NM/fXs5wOfgNlCqhKkS0nnyvYb4DF4=; b=VFBYzOiH9bnJ5ERn3hB/qc
 HZ1BN63/VtSwXbbYcA6bwhBBApAsW3hX/7P/9iPoWU7clvV7ghkDMXP/almjPm27
 OGiUUdNikpfO9U3rRTh7VSJlSBSBa8D1X2O8kmqcr06szmd8bu2wMkqbwDVCo7ci
 ZbKz2jwnkobFL12crsmuej+iggUtvQKyuhexKyrdWZP6CFOL7CnTnkik5ARS5IVf
 8t7e1epVQWvVjLGlqlhkxmkxm10FkDVx20bQ8nqHco2PgXoASxDFzIy9Ua/+ZAIE
 7WwzPpdu/22OH8S8IEzktCZuDlZoysb94DMxKjaEAuuH8GlFd1rkHu1+cww6Rx8g
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bkc6h17wf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 12 Jan 2026 21:43:17 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60CJ9cOp002505;
 Mon, 12 Jan 2026 21:43:17 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4bm13sgks4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 12 Jan 2026 21:43:17 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 60CLhFfe34668804
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 12 Jan 2026 21:43:15 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8147258050;
 Mon, 12 Jan 2026 21:43:15 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D869F58045;
 Mon, 12 Jan 2026 21:43:13 +0000 (GMT)
Received: from [9.61.120.128] (unknown [9.61.120.128])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 12 Jan 2026 21:43:13 +0000 (GMT)
Message-ID: <cdca39d1-3f81-4cac-bc6e-b9486d98fe94@linux.ibm.com>
Date: Mon, 12 Jan 2026 16:43:13 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Zhuoying Cai <zycai@linux.ibm.com>
Subject: Re: [PATCH v7 08/29] crypto/x509-utils: Add helper functions for DIAG
 320 subcode 2
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>
Cc: richard.henderson@linaro.org, david@redhat.com, jrossi@linux.ibm.com,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org, brueckner@linux.ibm.com,
 walling@linux.ibm.com, jjherne@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com, alifm@linux.ibm.com
References: <20251208213247.702569-1-zycai@linux.ibm.com>
 <20251208213247.702569-9-zycai@linux.ibm.com>
 <9f622221-5012-4f12-8fc2-3a721a0ce111@redhat.com>
 <aWDi7gh4uiwA7JOA@redhat.com>
 <53a6f846-2a65-49d4-aabb-021e9c2f590f@redhat.com>
 <aWDovtQX2IEwg-NA@redhat.com>
Content-Language: en-US
In-Reply-To: <aWDovtQX2IEwg-NA@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: pmv0ptsqme7POHxbvHOQ4IgS4VAN1iuE
X-Proofpoint-ORIG-GUID: pmv0ptsqme7POHxbvHOQ4IgS4VAN1iuE
X-Authority-Analysis: v=2.4 cv=TaibdBQh c=1 sm=1 tr=0 ts=69656af6 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=SuukmJpiibHSEBbCo-wA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEyMDE3NyBTYWx0ZWRfX6MpqVfCAeOrg
 H51+SEVmGNNhnoNx49WjxK3bSfPu9M1jnZCNq4GrO43A98GYrBJ1w+Uw/Tnko0dkWQBuSQPbKLw
 m0Daa7fW8NboXpYpsg8GSmcUSEbwTVa539Jn4GJ5l8eA/VXol7PdSPahkemGPzHMrSueifeo6c4
 Hb40iAndfRlPldqkL07mfPyVugOp7pdslbmlT0M5GvIonG7IeDS6yxv/OL9JeTdcni7nZa2DZvF
 2ld0WVY3cN7z0VkvqxcuyXAGHYH/dXuMKwLEoe4QBX9+guLmuEz8r9SOFgKKpwkru8ysAC5uAR4
 XIOhdlUuVd72Q86iifSx2cGdmrao6wAEg/ll1Dk1lNPA65p8DYihWG9nmIh5NYzhLrRIKGqVCe8
 nWBpxRmgafkLUMo9BeNNMTt9jSNtrfb3hoI1tgtKL049UnijjqxEYSN23zQRffH46+MZB1LsXpD
 VmT+pGnwDvUcia30ziQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-12_06,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 impostorscore=0 bulkscore=0 clxscore=1015
 suspectscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2512120000
 definitions=main-2601120177
Received-SPF: pass client-ip=148.163.158.5; envelope-from=zycai@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 1/9/26 6:38 AM, Daniel P. Berrangé wrote:
> On Fri, Jan 09, 2026 at 12:24:32PM +0100, Thomas Huth wrote:
>> On 09/01/2026 12.13, Daniel P. Berrangé wrote:
>>> On Fri, Jan 09, 2026 at 12:06:25PM +0100, Thomas Huth wrote:
>>>> On 08/12/2025 22.32, Zhuoying Cai wrote:
>>>>> Introduce new helper functions to extract certificate metadata:
>>>>>
>>>>> qcrypto_x509_check_cert_times() - validates the certificate's validity period against the current time
>>>>> qcrypto_x509_get_pk_algorithm() - returns the public key algorithm used in the certificate
>>>>> qcrypto_x509_get_cert_key_id() - extracts the key ID from the certificate
>>>>> qcrypto_x509_is_ecc_curve_p521() - determines the ECC public key algorithm uses P-521 curve
>>>>>
>>>>> These functions provide support for metadata extraction and validity checking
>>>>> for X.509 certificates.
>>>>>
>>>>> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
>>>>> ---
>>>>>    crypto/x509-utils.c         | 248 ++++++++++++++++++++++++++++++++++++
>>>>>    include/crypto/x509-utils.h |  73 +++++++++++
>>>>>    2 files changed, 321 insertions(+)
>>>>>
>>>>> diff --git a/crypto/x509-utils.c b/crypto/x509-utils.c
>>>>> index 2696d48155..f91fa56563 100644
>>>>> --- a/crypto/x509-utils.c
>>>>> +++ b/crypto/x509-utils.c
>>>>> @@ -27,6 +27,25 @@ static const int qcrypto_to_gnutls_hash_alg_map[QCRYPTO_HASH_ALGO__MAX] = {
>>>>>        [QCRYPTO_HASH_ALGO_RIPEMD160] = GNUTLS_DIG_RMD160,
>>>>>    };
>>>>> +static const int gnutls_to_qcrypto_pk_alg_map[] = {
>>>>
>>>> Could you do me a favour and add a line like this at the beginning of this
>>>> array:
>>>>
>>>>   [GNUTLS_PK_UNKNOWN] = QCRYPTO_PK_ALGO_UNKNOWN,
>>>>
>>>> and then also set QCRYPTO_PK_ALGO_UNKNOWN = 0 in the enum in the header?
>>>> That way we can be sure that zero values are not accidentally mapped to a
>>>> valid algorithm.
>>>
>>> That would be special casing just one enum type in the crypto subsystem
>>> to have this special unknown value. We've got 1000's of enums across
>>> QEMU and don't generally add such a special zeroth constant, so I don't
>>> find this suggested change to be desirable.
>>
>> I came up with this idea when reviewing the qcrypto_x509_get_pk_algorithm()
>> function in this patch which is basically doing:
>>
>>    ret = gnutls_to_qcrypto_pk_alg_map[rc];
>>
>> My concern is that if someone ever extends the QCryptoPkAlgo in the header,
>> but forgets to fill in as much entries to gnutls_to_qcrypto_pk_alg_map as
>> there are entries in the enum, we're in trouble, since the wholes in the
>> array will be padded with zeros that then get mapped to QCRYPTO_PK_ALGO_RSA.
>> Having a clearly invalid meaning of 0 would help in such cases.
> 
> Hmm, looking at the usage of qcrypto_x509_get_pk_algorithm(), I think
> the method and the QCryptoPkAlgo enums should be deleted entirely.
> 
> In the next patch, the caller does
> 
> 
>     /* public key algorithm */
>     algo = qcrypto_x509_get_pk_algorithm(cert.raw, cert.size, &err);
>     if (algo < 0) {
>         error_report_err(err);
>         return -1;
>     }
> 
>     if (algo == QCRYPTO_PK_ALGO_ECDSA) {
>         rc = qcrypto_x509_check_ecc_curve_p521(cert.raw, cert.size, &err);
>         if (rc == -1) {
>             error_report_err(err);
>             return -1;
>         }
> 
>         return (rc == 1) ? DIAG_320_VCE_KEYTYPE_ECDSA_P521 :
>                            DIAG_320_VCE_KEYTYPE_SELF_DESCRIBING;
>     }
> 
>     return DIAG_320_VCE_KEYTYPE_SELF_DESCRIBING;
> 
> 
> so the caller doesn't actually care about anything other than
> PK_ALGO_ECDSA, so IMHO going to the trouble of defining an enum
> and mapping gnutls enums is pointless.
> 
> This caller should unconditionally call
> 
>  qcrypto_x509_check_ecc_curve_p521()
> 
> and then then qcrypto_x509_check_ecc_curve_p521() method should
> check whether the pk algorithm is GNUTLS_PK_ECDSA internally
> and just return 0 if not.
> 
> 
> With regards,
> Daniel

Thanks for the comments. I agree with your suggestion. Given the
current usage, the caller only needs to know whether the key is ECDSA
P-521 or not.

I had a similar concern to Thomas about the QCryptoPkAlgo enum and its
mapping, since the gnutls_pk_algorithm_t enum includes many values.
Moving the algorithm check into qcrypto_x509_check_ecc_curve_p521()
addresses this. I'll rework the patch accordingly.

Thanks again for all the helpful feedback!





