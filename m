Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D08ED3CC88
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Jan 2026 23:07:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vg9wY-0007QG-2Y; Wed, 14 Jan 2026 18:06:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1vg9wS-0007Ky-Dj; Wed, 14 Jan 2026 18:06:20 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1vg9wQ-0005k7-Bh; Wed, 14 Jan 2026 18:06:20 -0500
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60EGSCrX029996;
 Wed, 14 Jan 2026 23:06:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=Y4uVhE
 PyPSF8meL+m06mcxBlQwcfw7TTP1hcePzmIuI=; b=Y3MM0uZ2DYz6j9lYsQkfDL
 kics/d7Ph76LKjE8MnXn+bh+GddjJpDXzIsShujkb6R9rKZ12UrnY8z7GWz5VQm0
 VE1PSg83C/xXDljiBm5ZwnKzMyPt+XTeJm/jUinb25yshKqdrDitUfy/QozI1j5D
 py7n2YH3ycpsTMXJ89iYdto2dBNG871GUPljHuTILUEEqtXE7WNxRuYkqGmAJNiW
 /jMx6arBfmnrEI04mApylGrAfOaLSnWVY3NTbbPJ4/60ogc9pXkSbVwuLL470jAt
 uwsIJxYHilxftPyP8wXXmP9ZGFAVpatNH50tofu4Rd9/O5Z+Wdj72ETX0wRbHvsA
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bkedt3fp8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 Jan 2026 23:06:14 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60EKKvs9025552;
 Wed, 14 Jan 2026 23:06:13 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4bm23ncweu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 Jan 2026 23:06:13 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 60EN5sdo59572696
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 14 Jan 2026 23:05:54 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7875C58062;
 Wed, 14 Jan 2026 23:06:12 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AC2AC5805C;
 Wed, 14 Jan 2026 23:06:10 +0000 (GMT)
Received: from [9.61.242.147] (unknown [9.61.242.147])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 14 Jan 2026 23:06:10 +0000 (GMT)
Message-ID: <63047cd8-76da-41e7-bd71-ea569f158234@linux.ibm.com>
Date: Wed, 14 Jan 2026 15:06:09 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 09/29] s390x/diag: Implement DIAG 320 subcode 2
To: Zhuoying Cai <zycai@linux.ibm.com>, thuth@redhat.com, berrange@redhat.com, 
 richard.henderson@linaro.org, david@redhat.com, jrossi@linux.ibm.com,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org, brueckner@linux.ibm.com
Cc: walling@linux.ibm.com, jjherne@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com
References: <20251208213247.702569-1-zycai@linux.ibm.com>
 <20251208213247.702569-10-zycai@linux.ibm.com>
 <b3a03c68-c011-43e8-8c85-e14fb7f39399@linux.ibm.com>
 <d31a747f-d2b3-429a-9ee1-924e55ea3aea@linux.ibm.com>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <d31a747f-d2b3-429a-9ee1-924e55ea3aea@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE0MDE4OCBTYWx0ZWRfX0X1g+yB4h4kl
 LRyPQsXSO14HVQtfZp/R49uk3au3gGSHlpLmN3b4s5rUTN+nxWakx8c85GgRMBB/o9A/rLAFqoW
 ovLDRyO7ISuAs8U1KSmo/L62jOefPbTvMjpqKbHiR5eN2J3Qw9gUeSrs9Kck8Ufz0zDVFoaFO1L
 4nhlqxB7/JU37rt6/zcvmQ8vdYBGa68zzv2RP2d234YfMx6MF52R/HFvJYk+ulBVjM3Jc7009GK
 c5wGhZX6ZzW6Kl17c1X5BtnkaORcd9DTwdCk8Vk8J6rQMXfwd88cZSu0m8EqEFtJkQ8c6eQ6+PU
 WQT9sFF/1KUgBpPBUZl3TTgFqqV9w9z7YhHOcPoj9QCJXVsKH9MnseYEqVsDw4OaNtLsxH37eCc
 vxrPvolMscG2Bkupt6HxhsKIz/ZPoGRlareluemfBj2/86M1BGDOt81whZanr/6kZ8qDbIR2/To
 u+fbecrg2/pCm4ZQQMQ==
X-Proofpoint-GUID: X0ammDnbx_07ilIpCbuKYJhpllB2mw72
X-Authority-Analysis: v=2.4 cv=WLJyn3sR c=1 sm=1 tr=0 ts=69682166 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=aEYFNzm1kHEYm9MAukUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: X0ammDnbx_07ilIpCbuKYJhpllB2mw72
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-14_07,2026-01-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 malwarescore=0 phishscore=0 suspectscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2512120000
 definitions=main-2601140188
Received-SPF: pass client-ip=148.163.158.5; envelope-from=alifm@linux.ibm.com;
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


On 1/14/2026 1:54 PM, Zhuoying Cai wrote:
> On 1/8/26 5:54 PM, Farhan Ali wrote:
>> <..snip...>
>>
>> On 12/8/2025 1:32 PM, Zhuoying Cai wrote:
>>> +static int build_vce_data(VCEntry *vce, S390IPLCertificate cert)
>>> +{
>>> +    uint16_t keyid_field_len;
>>> +    uint16_t hash_field_len;
>>> +    uint32_t cert_field_len;
>>> +    uint32_t vce_len;
>>> +    int rc;
>>> +
>>> +    handle_key_id(vce, cert);
>>> +    /* vce key id field length - can be 0 if failed to retrieve */
>>> +    keyid_field_len = ROUND_UP(be16_to_cpu(vce->keyid_len), 4);
>> If we fail to retrieve the key, does it makes sense to build the VCE? I
>> think we need the key to verify the signature of the certificate, so why
>> not mark the certificate as invalid?
>>
>>
> The key ID is used to identify the public key in the certificate, but
> it is not utilized in the current patch series. Therefore, I thought it
> would be acceptable to continue building the VCE without this field,
> though I am open to other ideas or suggestions on how to handle it.

I looked at the kernel code again and it doesn't look like the kernel 
uses the key information today(arch/s390/kernel/cert_store.c). So maybe 
its fine to continue building the vce today. But IMHO it's a little odd 
that we are marking a certificate as valid even though we have an 
invalid key field.

>>> +
>>> +    rc = handle_hash(vce, cert, keyid_field_len);
>>> +    if (rc) {
>>> +        return -1;
>>> +    }
>>> +    hash_field_len = ROUND_UP(be16_to_cpu(vce->hash_len), 4);
>>> +
>>> +    rc = handle_cert(vce, cert, hash_field_len);
>>> +    if (rc || !is_cert_valid(cert)) {
>>> +        return -1;
>>> +    }
>>> +    /* vce certificate field length */
>>> +    cert_field_len = ROUND_UP(be32_to_cpu(vce->cert_len), 4);
>>> +
>>> +    vce_len = VCE_HEADER_LEN + keyid_field_len + hash_field_len + cert_field_len;
>>> +    if (vce_len > be32_to_cpu(vce->len)) {
>>> +        return -1;
>>> +    }
>>> +
>>> +    /* The certificate is valid and VCE contains the certificate */
>>> +    vce->flags |= DIAG_320_VCE_FLAGS_VALID;
>>> +
>>> +    /* Update vce length to reflect the actual size used by vce */
>>> +    vce->len = cpu_to_be32(vce_len);
>>> +
>>> +    return 0;
>>> +}
>>> +
>> <...snip...>
>>

