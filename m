Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0033D73E80
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 18:26:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlWhJ-0006P4-JI; Thu, 29 Jan 2026 13:24:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1vlWh4-0006NV-QX; Thu, 29 Jan 2026 13:24:42 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1vlWh1-0001hr-2e; Thu, 29 Jan 2026 13:24:37 -0500
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60TEuLvl012093;
 Thu, 29 Jan 2026 18:24:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=rkjH2D
 h3QNP5SwyBnKPgM8uFrP/jSxPOcr1fke2asdk=; b=iqHyQ6vw7SS84egJ5qisNJ
 PAepGRVirGzhNDRudv9YERseYtF+Kqf60q+yeLp+lpQLaXb/jakMILnvC/nGn23N
 PSLS1HmqqWiyJ+pwAaSvFXeDdUboY0plYF+uS0r1hiWwvevKDz2xUm/6mfql8SWo
 xIFASw2/RSZ9gE2y/Ci7xfCUL9vAhd0+x4SM1Pnl04DnuHS9vzvMsmZcZQCw0Zdr
 KwdoffV747+1WvSK0rM/z/iCCZG8UflkNFlUknxTvHYGShJ5gxzPq2F9mc2xSJ/l
 EWKq1czkpal7FCNZ4h+YuVgef3hSaofV9aQu2RRQ9gd7lRQHQ3/syezf+++OgyNQ
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bvnr6fbrv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 29 Jan 2026 18:24:29 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60TGk6Mh026333;
 Thu, 29 Jan 2026 18:24:28 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4bw9wkk092-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 29 Jan 2026 18:24:28 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 60TIOSce60359152
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 29 Jan 2026 18:24:28 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 13D7158052;
 Thu, 29 Jan 2026 18:24:28 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7EB5C58050;
 Thu, 29 Jan 2026 18:24:27 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 29 Jan 2026 18:24:27 +0000 (GMT)
MIME-Version: 1.0
Date: Thu, 29 Jan 2026 19:24:27 +0100
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@kernel.org>,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 3/4] target/s390x: Implement DIVIDE TO INTEGER
In-Reply-To: <e4e159f1-63f9-4486-9dcc-710675018fb1@linaro.org>
References: <20260127153736.62730-1-iii@linux.ibm.com>
 <20260127153736.62730-4-iii@linux.ibm.com>
 <66027136-d91b-478c-becc-0aa41b40c445@linaro.org>
 <17cd88ba-52b1-46c4-9280-977bd50ac060@linux.ibm.com>
 <e4e159f1-63f9-4486-9dcc-710675018fb1@linaro.org>
Message-ID: <ac9e64f4dcf1184b1e647da8c5fbaeac@linux.ibm.com>
X-Sender: iii@linux.ibm.com
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI5MDEzMCBTYWx0ZWRfX4c2Bm9yji6/4
 cef0b7MoNTIxirCXBG+a6Fe/vxTWnbMA+VTvmfg7IlT+0ZyI3XqSjfqdDRErRaBImzii3jo2o93
 zzNTCFVOXPH2jheiPCOmocbH21GDhgOOldsvcwsVN4hmYK2aZsWz5Kbne5eB11GBkhCCOE6Dofh
 6HZW0824QQ4rm2tkyAL4PNJuvCS6h0Qp0yp3+vcgfPiVFmI5deJtqifAptBVGkIXWNhC9NjEUqj
 mbESluok2gQENeGBk4+nnZERxVuOAs+H6AL1fCBq7TxRmsoGumCXOUb1Uio7gyorgvuMjgS/DGd
 5PNtXJE4v/mTl9g/Vg3mQsfevs4rWHvtCbwXWGN27dn5BwJtFyNC5hnyUSWg8cS7i3u89BtUVfL
 WvSKQkzOmIDsGC/aVbQ5l/lW4u7gbje9WwmkwZeuaEDwIJh8D77oRuobBafnah28c1my8yYnuHg
 Yh7p+gTx1x2Ns2JgoBQ==
X-Proofpoint-GUID: 4Wa8x-SnJWSJw0HqpyHO2SupaTFScHPU
X-Proofpoint-ORIG-GUID: 4Wa8x-SnJWSJw0HqpyHO2SupaTFScHPU
X-Authority-Analysis: v=2.4 cv=X+Vf6WTe c=1 sm=1 tr=0 ts=697ba5dd cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=DWnexSkmKnlDbcgnN4sA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-29_02,2026-01-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 impostorscore=0 lowpriorityscore=0
 clxscore=1015 spamscore=0 adultscore=0 malwarescore=0 bulkscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2601150000
 definitions=main-2601290130
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
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

On 2026-01-28 21:38, Richard Henderson wrote:
> On 1/29/26 00:19, Ilya Leoshkevich wrote:
>> With some testcases I hit this condition in 
>> parts_round_to_int_normal():
>> 
>>      if (a->exp >= frac_size) {
>>          /* All integral */
>>          return false;
>>      }
>> 
>> which makes it a no-op.
>> 
>> I think the code assumes that FloatParts have just been unpacked and 
>> all low fraction bits are zero, which is not the case for quotient 
>> here.
>> 
>>>> +        float_exception_flags = saved_flags;
>>>> +        parts_s390_precision_round_normal(&n128, fmt);
>>> 
>>> parts_round_to_int_normal already takes a rounding mode and 
>>> frac_size.
>>> It also returns whether or not the rounding was exact.
>>> This appears to be trying to reinvent the wheel.
>> 
>> 
>> Apparently I use this to paper over the above issue, which is not 
>> great.
>> 
>> I guess improving parts_round_to_int() to work with non-zero low 
>> fraction bits would be better.
>> 
>> What do you think?
> 
> Yes indeed.  I think (a->exp >= N) should be sufficient?

Seems like this does not work for really large quotients, because we 
still need to trim the fraction bits.
So I'm currently evaluating the following, which looks promising so far:

--- a/fpu/softfloat-parts.c.inc
+++ b/fpu/softfloat-parts.c.inc
@@ -1118,11 +1118,6 @@ static bool 
partsN(round_to_int_normal)(FloatPartsN *a, FloatRoundMode rmode,
          return true;
      }

-    if (a->exp >= frac_size) {
-        /* All integral */
-        return false;
-    }
-
      if (N > 64 && a->exp < N - 64) {
          /*
           * Rounding is not in the low word -- shift lsb to bit 2,
@@ -1133,7 +1128,7 @@ static bool 
partsN(round_to_int_normal)(FloatPartsN *a, FloatRoundMode rmode,
          frac_lsb = 1 << 2;
      } else {
          shift_adj = 0;
-        frac_lsb = DECOMPOSED_IMPLICIT_BIT >> (a->exp & 63);
+        frac_lsb = DECOMPOSED_IMPLICIT_BIT >> MIN(a->exp, frac_size);
      }

> r~

