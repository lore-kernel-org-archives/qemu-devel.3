Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A7EAC4453A
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2026 09:31:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmTHr-0002Nm-MA; Wed, 22 Jul 2026 05:30:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <freude@linux.ibm.com>)
 id 1wmTHp-0002Hh-HS; Wed, 22 Jul 2026 05:30:45 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <freude@linux.ibm.com>)
 id 1wmTHn-00068Y-Ex; Wed, 22 Jul 2026 05:30:45 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66M9CMNZ3672791; Wed, 22 Jul 2026 09:30:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=hK4lvS/eGvsFDNHxzzMPSM81TFxBfsX/YW67RrJBjA4=; b=QB7d7qEvt/Rd
 hxqb03/7PEzrgM8kDnJBeZk3AGzphbC2LgEb/AZJP3/pZmxFAXoynu4lJN0YT0JY
 wnyrWPIfWt1emOAm1F50wmatWMaqeBFw71mK1vXum4ApLRNhOBojLbbSLPmtZ1zq
 7uJEbt4hdRWIlHEgD/IjcCwqcM+2ZOf60SWqKrrzW4mChDNQ2P7DpS8bvNsQI0aK
 F18qiwFka+Hqp5zryzLV5eUYOPXkiKIj1sbj2TprudwHIy04qtR2fAl2JvzWHKAs
 xGaC0uMC+sJ6sKTYXF1Rw4h8S/9me1drIRJ7Ev6hbo8tuAnFMas6wOfIDIDnJWUG
 ttaSEZALhA==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg7ah8wbv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 22 Jul 2026 09:30:31 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66M9Jhxw016054;
 Wed, 22 Jul 2026 09:30:31 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgmtjxmjw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 22 Jul 2026 09:30:31 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66M9UUGx57016702
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 22 Jul 2026 09:30:30 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F32545805F;
 Wed, 22 Jul 2026 09:30:29 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7648D58051;
 Wed, 22 Jul 2026 09:30:29 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 22 Jul 2026 09:30:29 +0000 (GMT)
MIME-Version: 1.0
Date: Wed, 22 Jul 2026 11:30:29 +0200
From: Harald Freudenberger <freude@linux.ibm.com>
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Richard Henderson <richard.henderson@linaro.org>, Cornelia Huck
 <cohuck@redhat.com>, Eric Farman <farman@linux.ibm.com>, Matthew Rosato
 <mjrosato@linux.ibm.com>,
 David Hildenbrand <david@kernel.org>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@linux.ibm.com>,
 qemu-stable@nongnu.org
Subject: Re: [PATCH v2 1/2] target/s390x: Make PRNO TRNG interruptible
Mail-Reply-To: freude@linux.ibm.com
In-Reply-To: <20260714191948.342204-2-iii@linux.ibm.com>
References: <20260714191948.342204-1-iii@linux.ibm.com>
 <20260714191948.342204-2-iii@linux.ibm.com>
Message-ID: <f605eaefb4d014b4bed5551c6a1980b6@linux.ibm.com>
X-Sender: freude@linux.ibm.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 3g1Tg3kM86sionZqogh46cmEU87y7iPx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDA4NyBTYWx0ZWRfX1FSe8XI6Kln6
 4dnAgplGmGFhP+hRPoC1dvj4qhC1ov6qwRWgwFzuCOwxclF7NztdSCj9vfgEkfDsqgOXPVtHW4p
 YP7MoCn3f15EOngmUbqvuulOcWwMYmtXRHdH7eb+PYFMlTo//rE6DlQ6qNjGZ2QnNyE1CHsco6d
 0dOVO+YTYdWfO0ZFrBkJwt4WwiCeIVBcuV/EXay01/vaZWa6QfdH+q8+TEVbLgBPW2pQyQbrPvI
 ldFmbuZkj3W2dqsrrJQlt5e6W3ehMv1gvvrSrmTK6dWUtC/f40gYI4JGIPV2bSVyquQnkoz5W+A
 V+OOtznpk0k6llupK9hAs31TuNLWcY7U2ULqd0VwaDeijF4dUYHGjbTPLWjIunZatcqdIUninIL
 mK1ipUroew/c2phs+nFSANtz95zFT5e9KCD7Z4IZ9IX3msNpC6OQ7HF8rhQYUX59AHqVQNKpnY8
 l+MD1d4f67TOLD2ztRA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDA4NyBTYWx0ZWRfXxe7uaNjObl9r
 xhfIQp/UyDhnLrxNQW2VVuHOd8iFxr2a47Pc7gBttjYQxcReru4GbQeSfYC67u9ypU/xoNhuh+j
 J5zZ63iqnuwZc8FNZ5tjHOlU/PfF9xw=
X-Proofpoint-GUID: 3g1Tg3kM86sionZqogh46cmEU87y7iPx
X-Authority-Analysis: v=2.4 cv=SM5ykuvH c=1 sm=1 tr=0 ts=6a608db7 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=69wJf7TsAAAA:8 a=KKAkSRfTAAAA:8 a=j-UDTZna37xY2s4fqbMA:9 a=CjuIK1q_8ugA:10
 a=Fg1AiH1G6rFz08G2ETeA:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_03,2026-07-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0
 spamscore=0 malwarescore=0 priorityscore=1501 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607220087
Received-SPF: pass client-ip=148.163.158.5; envelope-from=freude@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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

On 2026-07-14 21:17, Ilya Leoshkevich wrote:
> fill_buf_random() writes the entire guest-requested amount of random
> bytes in one go. Since the length is a full 64-bit value, a guest can
> request several gigabytes and keep the vCPU spinning inside the helper,
> without a chance to react to interrupts.
> 
> Do the same thing as HELPER(mvcl): check cpu_loop_exit_requested() at 
> the
> bottom of the loop, and when a return to the main loop is pending, stop
> and report partial completion with condition code 3.
> 
> Reported-by: Christian Borntraeger <borntraeger@linux.ibm.com>
> Fixes: 3dbc5fdacb5a ("target/s390x: support PRNO_TRNG instruction")
> Cc: qemu-stable@nongnu.org
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>  target/s390x/tcg/crypto_helper.c | 22 +++++++++++++++++-----
>  1 file changed, 17 insertions(+), 5 deletions(-)
> 
> diff --git a/target/s390x/tcg/crypto_helper.c 
> b/target/s390x/tcg/crypto_helper.c
> index 8fe0a222198..6a5dbe1cafa 100644
> --- a/target/s390x/tcg/crypto_helper.c
> +++ b/target/s390x/tcg/crypto_helper.c
> @@ -16,6 +16,7 @@
>  #include "qemu/guest-random.h"
>  #include "s390x-internal.h"
>  #include "tcg_s390x.h"
> +#include "exec/cpu-common.h"
>  #include "exec/helper-proto.h"
>  #include "accel/tcg/cpu-ldst-common.h"
>  #include "accel/tcg/cpu-mmu-index.h"
> @@ -242,8 +243,8 @@ static int cpacf_sha512(CPUS390XState *env, const
> int mmu_idx, uintptr_t ra,
>      return !len ? 0 : 3;
>  }
> 
> -static void fill_buf_random(CPUS390XState *env, const int mmu_idx,
> uintptr_t ra,
> -                            uint64_t *buf_reg, uint64_t *len_reg)
> +static int fill_buf_random(CPUS390XState *env, const int mmu_idx, 
> uintptr_t ra,
> +                           uint64_t *buf_reg, uint64_t *len_reg)
>  {
>      const MemOpIdx oi = make_memop_idx(MO_8, mmu_idx);
>      uint8_t tmp[256];
> @@ -265,7 +266,13 @@ static void fill_buf_random(CPUS390XState *env,
> const int mmu_idx, uintptr_t ra,
>              --*len_reg;
>          }
>          len -= block;
> +
> +        if (cpu_loop_exit_requested(env_cpu(env))) {
> +            break;
> +        }
>      }
> +
> +    return len == 0 ? 0 : 3;
>  }
> 
>  uint32_t HELPER(msa)(CPUS390XState *env, uint32_t r1, uint32_t r2, 
> uint32_t r3,
> @@ -278,6 +285,7 @@ uint32_t HELPER(msa)(CPUS390XState *env, uint32_t
> r1, uint32_t r2, uint32_t r3,
>      uint8_t subfunc[16] = { 0 };
>      uint64_t param_addr;
>      MemOpIdx oi;
> +    int cc;
> 
>      switch (type) {
>      case S390_FEAT_TYPE_KMAC:
> @@ -308,9 +316,13 @@ uint32_t HELPER(msa)(CPUS390XState *env, uint32_t
> r1, uint32_t r2, uint32_t r3,
>          return cpacf_sha512(env, mmu_idx, ra, env->regs[1], 
> &env->regs[r2],
>                              &env->regs[r2 + 1], type);
>      case 114: /* CPACF_PRNO_TRNG */
> -        fill_buf_random(env, mmu_idx, ra, &env->regs[r1], 
> &env->regs[r1 + 1]);
> -        fill_buf_random(env, mmu_idx, ra, &env->regs[r2], 
> &env->regs[r2 + 1]);
> -        break;
> +        cc = fill_buf_random(env, mmu_idx, ra,
> +                             &env->regs[r1], &env->regs[r1 + 1]);
> +        if (cc == 0) {
> +            cc = fill_buf_random(env, mmu_idx, ra,
> +                                 &env->regs[r2], &env->regs[r2 + 1]);
> +        }
> +        return cc;
>      default:
>          /* we don't implement any other subfunction yet */
>          g_assert_not_reached();

Reviewed-by: Harald Freudenberger <freude@linux.ibm.com>

