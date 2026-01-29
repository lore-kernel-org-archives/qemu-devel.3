Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D37ED73E87
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 23:28:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlbQr-0005ar-A5; Thu, 29 Jan 2026 18:28:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1vlbQn-0005Zm-Jx; Thu, 29 Jan 2026 18:28:09 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1vlbQl-0007jh-Ey; Thu, 29 Jan 2026 18:28:08 -0500
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60TF3Jnl012162;
 Thu, 29 Jan 2026 23:28:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=quMs9A
 bM7vYiWTpKZytB/mliZ3Wslhx+dt1J+r0V9is=; b=ka0qHadmKVw7whx//kC2YA
 MCpa+io1jHbhoa/dketSiTszgsakOZm8vok+j85oQnIN3SEJj/Hr29nDllBJWP88
 PFj0GWGdKDkkgCgN5UBdZKWhQI3gtZGyZsCo/a0chBLHJ/gxaVmQcNXRK/hu0hqr
 O4tYXx1D6yrqsza/8lOMfFuAuByjxvh1+9PWbO0vivV825Lzz0q0iyVvaZWcqLq/
 1vRnBQEialDb+MbqYI8f6a8ycwgHuwZ1TnD1YFOqj2J6C3QJkKhCFF0TxYpUNJjk
 f64WooLXmUN7U/mQneRNbvBDf608JmsB45rG9G2m7r0jVGjK/7wZsh2PkK99wRMg
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bvnr6ge7f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 29 Jan 2026 23:28:03 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60TKWdEY018394;
 Thu, 29 Jan 2026 23:28:02 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4bwb423uuy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 29 Jan 2026 23:28:02 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 60TNS1E534538178
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 29 Jan 2026 23:28:01 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 58D1658056;
 Thu, 29 Jan 2026 23:28:01 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0B0B758052;
 Thu, 29 Jan 2026 23:28:01 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 29 Jan 2026 23:28:00 +0000 (GMT)
MIME-Version: 1.0
Date: Fri, 30 Jan 2026 00:28:00 +0100
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Thomas Huth <thuth@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>
Cc: David Hildenbrand <david@kernel.org>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v3 4/5] target/s390x: Implement DIVIDE TO INTEGER
In-Reply-To: <20260129190902.196262-5-iii@linux.ibm.com>
References: <20260129190902.196262-1-iii@linux.ibm.com>
 <20260129190902.196262-5-iii@linux.ibm.com>
Message-ID: <3ffcd87fad77fa09811ae8ea8dbac25f@linux.ibm.com>
X-Sender: iii@linux.ibm.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI5MDE3MiBTYWx0ZWRfX0CFJRa2T7Ri4
 +2In4Cu944GOpNdb7vu764bsnOSVeUS2Zx8bE+yWoiLkcd+6LyOqG/JNGrwoI9KNicb0QHAfbE/
 KziblEcUECNl6xcvRq63AWJSDSZI1+iCzW55v3FZJduxD6WwqLPMjTI9+S+D0yTg2CPVMheXsI0
 tNKF4/kpcmGOk9YaZTBVAnDfoQ+qRbp/X+bVKrmH0CqQiaF30xgPfEmMvPjqS4XUEAgjHPWGMio
 Af7A7J7riK7bDYdr83J6+AAZCKMJ00jxxKqd6HXbcWYHxcyV2+Owt5r3KUbTJUVUk5szt7E/66C
 yll1fD0P6Fju8kxkgmaOeMBb8M3bdE1AxyBAhb7YkxS4e/qehoiucxbGZguHEk+2M40cTM4fqlx
 T3H91y/hF28klxbSb7Th7OGyH55cWzlokZK6SZYT2Z/0Y6VB6qtxwYcWz+CQGVE9UPSXqKjkX23
 ZwIJtPMy8VWfFk7y3pg==
X-Proofpoint-GUID: lMH_64qh0SZ_BjGpxLvAZ-WAKz1Imcoo
X-Proofpoint-ORIG-GUID: lMH_64qh0SZ_BjGpxLvAZ-WAKz1Imcoo
X-Authority-Analysis: v=2.4 cv=X+Vf6WTe c=1 sm=1 tr=0 ts=697bed03 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=jwhYoYNhkcTQYmz5Q34A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-29_03,2026-01-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 impostorscore=0 lowpriorityscore=0
 clxscore=1015 spamscore=0 adultscore=0 malwarescore=0 bulkscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2601150000
 definitions=main-2601290172
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

On 2026-01-29 19:57, Ilya Leoshkevich wrote:
> DIVIDE TO INTEGER computes floating point remainder and is used by
> LuaJIT, so add it to QEMU.
> 
> Put the main logic into fpu/, because it is way more convenient to
> operate on FloatParts than to convert floats back-and-forth.
> 
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>  fpu/softfloat.c                  | 144 +++++++++++++++++++++++++++++++
>  include/fpu/softfloat.h          |  11 +++
>  target/s390x/helper.h            |   1 +
>  target/s390x/tcg/fpu_helper.c    |  56 ++++++++++++
>  target/s390x/tcg/insn-data.h.inc |   5 +-
>  target/s390x/tcg/translate.c     |  26 ++++++
>  6 files changed, 242 insertions(+), 1 deletion(-)

I've taken a fresh look and I think I can improve one small thing.
I will change this alongside other feedback (if any) in v4.

[...]

> +
> +        /*
> +         * Final quotient is rounded using final-quotient-rounding 
> method, and
> +         * partial quotient is rounded toward zero.
> +         *
> +         * Rounding of partial quotient may be inexact. This is the 
> whole point
> +         * of distinguishing partial quotients, so ignore the 
> exception.
> +         */
> +        *n = *q;
> +        saved_flags = status->float_exception_flags;
> +        parts_round_to_int(n,
> +                           is_q_smallish ? 
> final_quotient_rounding_mode :
> +                                           float_round_to_zero,
> +                           0, status, fmt);
> +        float_exception_flags = saved_flags;

saved_flags can probably be eliminated; I can assign directly to 
float_exception_flags.
I think I can also use parts_round_to_int_normal(), because all the 
other cases are taken care of above.

[...]

