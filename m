Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F9FED25B5A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Jan 2026 13:20:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vl5SO-0002L2-7w; Wed, 28 Jan 2026 08:19:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1vl5SL-0002Dy-BX; Wed, 28 Jan 2026 08:19:37 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1vl5SJ-0000Qx-LZ; Wed, 28 Jan 2026 08:19:37 -0500
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60S8qOP2005338;
 Wed, 28 Jan 2026 13:19:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=XInXHJ
 IJDJ2Zi4ut4KqWakb0CPk+GLLjd074RM7qkkw=; b=AC6d5Muz/kEkySzppBrmIO
 3QvCEYgnqfz5aXFST5u2FW7DKX5YKa7bV7UfbQ4OgIBs01gv6dfn5x7jNNTNHiRg
 Bxf1OviGdlEt4PbGiIUOdc2g0ni/0r2GEYNkBJ0VqSwCYll1JfkcUJixWfeusz0V
 YPLMEpNPfNuVd3E65c+nda1IK0dlzKA5KNEgjdnOp28g/r/xwvbjPC4hrp1IdMns
 prqDlpgQmxpklQKqT16yo/4O1lVDbd6VOOxLm1dArQ1VSywO54pjtr27+0Qa6R1T
 qDMHqLigOjv6m90hI/ngfe/NdvdmPWFIpyozim4CD+tdOBnvSojPs+FWc7VW8cCw
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bvnr690v5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 28 Jan 2026 13:19:31 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60SDGm0e023641;
 Wed, 28 Jan 2026 13:19:30 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4bwamjw95w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 28 Jan 2026 13:19:30 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 60SDJSJd16122262
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 28 Jan 2026 13:19:28 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8940B20043;
 Wed, 28 Jan 2026 13:19:28 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3AFE920040;
 Wed, 28 Jan 2026 13:19:28 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.87.137.78])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 28 Jan 2026 13:19:28 +0000 (GMT)
Message-ID: <17cd88ba-52b1-46c4-9280-977bd50ac060@linux.ibm.com>
Date: Wed, 28 Jan 2026 14:19:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] target/s390x: Implement DIVIDE TO INTEGER
To: Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Cc: David Hildenbrand <david@kernel.org>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
References: <20260127153736.62730-1-iii@linux.ibm.com>
 <20260127153736.62730-4-iii@linux.ibm.com>
 <66027136-d91b-478c-becc-0aa41b40c445@linaro.org>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <66027136-d91b-478c-becc-0aa41b40c445@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI4MDEwOSBTYWx0ZWRfXyoXk18hsFITK
 aCj95Eie1eXjYRErOVX98ShdYptxL4kzQxN6duHuWjt5o3OuYG2G7q3KhA4E5rC6r+8PCf7/NSJ
 73MpHrIHqdFiGe/AvKH/x9sXHCrRFPSWhxdQB8xR96i1h5QiJ0CsbNA4W67POK5n9wZN4POlAI8
 2oJP/H6Ahu/8lNyDMvxC1WRypbuw0lG7Jbe/oqpda/sMXUapJWY90x0+zGbv1VTCekfxNVAsFNU
 uzKnRV/jos32kpvReuAM+B8RPHEz/vtoXOAx6QK8nySPePnOR1f4BcE7DtvJ/f86O0TPut4cEzM
 qEPKvFt9enPzTHCRKzieQfTuSjMkic89l0dvDWgV8HVhSkgEGVKTgTfJ3pQijVC+j3XtGs7XkL6
 XMD1iXkdHGdwW2TOWXohnIvnwbzgPUoBJN/wYocP8NlteDCllJo4NX01KJ/E34OQJlR8KGtrSEL
 3llRWg+TcKWeqO0opMA==
X-Proofpoint-GUID: KHADWYGko4rtaxVzM4OxaMjuO40wB2VC
X-Proofpoint-ORIG-GUID: KHADWYGko4rtaxVzM4OxaMjuO40wB2VC
X-Authority-Analysis: v=2.4 cv=X+Vf6WTe c=1 sm=1 tr=0 ts=697a0ce3 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=_1fSBCJRomgnOcfFcCgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-28_02,2026-01-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 impostorscore=0 lowpriorityscore=0
 clxscore=1015 spamscore=0 adultscore=0 malwarescore=0 bulkscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2601150000
 definitions=main-2601280109
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 1/28/26 06:50, Richard Henderson wrote:
> On 1/28/26 02:31, Ilya Leoshkevich wrote:
>> +        FloatParts128 a128, b128, *m128, m128_buf, n128, *q128, 
>> q128_buf,
>> +                      r128, *r128_precise;
>> +        int float_exception_flags = 0;
>> +        bool is_q128_smallish;
>> +        uint32_t r_flags;
>> +        int saved_flags;
>> +
>> +        /* Compute precise quotient */
>> +        parts_float_to_float_widen(&a128, a, status);
>> +        parts_float_to_float_widen(&b128, b, status);
>> +        q128_buf = a128;
>> +        q128 = parts_div(&q128_buf, &b128, status);
>
> Why do you need FloatParts128?
> You can see an inexact result from float64 with just FloatParts64.
> C.f. soft_f64_div.


I thought I needed this extra precision, but turns out that in reality I 
needed it to mask an issue with parts_round_to_int() - see below.


>> +
>> +        /* Final or partial case? */
>> +        is_q128_smallish = q128->exp < (fmt->frac_size + 1);
>> +
>> +        /*
>> +         * Final quotient is rounded using final-quotient-rounding 
>> method, and
>> +         * partial quotient is rounded toward zero.
>> +         *
>> +         * Rounding of partial quotient may be inexact. This is the 
>> whole point
>> +         * of distinguishing partial quotients, so ignore the 
>> exception.
>> +         */
>> +        n128 = *q128;
>> +        saved_flags = status->float_exception_flags;
>> +        parts_round_to_int(&n128,
>> +                           is_q128_smallish ? 
>> final_quotient_rounding_mode :
>> + float_round_to_zero,
>> +                           0, status, &float128_params);
>
> float128_params is definitely wrong.  The rounding is supposed to be 
> to the target format.


Hmm, yes, nothing in this code is about float128, that can't be right.


With some testcases I hit this condition in parts_round_to_int_normal():

     if (a->exp >= frac_size) {
         /* All integral */
         return false;
     }

which makes it a no-op.

I think the code assumes that FloatParts have just been unpacked and all 
low fraction bits are zero, which is not the case for quotient here.

>> +        float_exception_flags = saved_flags;
>> +        parts_s390_precision_round_normal(&n128, fmt);
>
> parts_round_to_int_normal already takes a rounding mode and frac_size.
> It also returns whether or not the rounding was exact.
> This appears to be trying to reinvent the wheel.


Apparently I use this to paper over the above issue, which is not great.

I guess improving parts_round_to_int() to work with non-zero low 
fraction bits would be better.

What do you think?


> There's still "... the two integers closest to this precise quotient 
> cannot be both be represented exactly in the precision of the quotent 
> ..." to contend with.  Is that your "smallish" test?  If so, the 
> comment could use some improvement.


Ok.


>> +
>> +        /* Compute precise remainder */
>> +        m128_buf = b128;
>> +        m128 = parts_mul(&m128_buf, &n128, status);
>> +        m128->sign = !m128->sign;
>> +        status->float_exception_flags = 0;
>> +        r128_precise = parts_addsub(m128, &a128, status, false);
>
> Surely parts_muladd_scalbn (with scale 0).


This works and is much shorter, thanks.


> r~

