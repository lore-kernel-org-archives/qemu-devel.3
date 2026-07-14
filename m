Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EA95C43458
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 11:50:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjbe9-00068j-Tl; Tue, 14 Jul 2026 07:49:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1wjbe7-00068U-PK; Tue, 14 Jul 2026 07:49:55 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1wjbe6-0005To-1i; Tue, 14 Jul 2026 07:49:55 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66EBgrDx3513996; Tue, 14 Jul 2026 11:49:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=mM0Qhi
 OZytn47K2jocjlsS4mdcr7tsw6yMNcqfPcag8=; b=OGIFuPHCanr5mHsKH6ZZL4
 KJ+RfaRNi22jDdnRjOeWS+A0sascM08t0C9/wwJ3/z7sAH6Ag7ofxeVBnoCMc7he
 TvNuDm0gKg8tZiGx7i59OLXHj/s2RPtehlRAk5Cph7LCiu9XJRQiCTKlDw/kGLcS
 ER0az2e0k+2rF9YriNi4bzqIg0iGE7t9cvtckB7Dfm1mm2pSWIVnVveWVSsUS4xM
 vj8aXEPRqY6nqIQbdgaG6mr1ok798h4rvcbFZAyQELQ1qcttwfq0xvRNvTCHs0Mt
 OYDi848T44mOclhLDFD6Evn41wpK4dpcp4qn6NH4CiJrfPF1gaUWSCwgDloUav0w
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fcv336end-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 14 Jul 2026 11:49:49 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66EBnmGW025244;
 Tue, 14 Jul 2026 11:49:48 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fc0hw2pwr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 14 Jul 2026 11:49:48 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66EBniE148824694
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 14 Jul 2026 11:49:44 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B2DBE2004E;
 Tue, 14 Jul 2026 11:49:44 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 59A762004B;
 Tue, 14 Jul 2026 11:49:44 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.111.75.242])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 14 Jul 2026 11:49:44 +0000 (GMT)
Message-ID: <44325b6e-702d-4ccc-ace6-229fc2269ad8@linux.ibm.com>
Date: Tue, 14 Jul 2026 13:49:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 05/17] target/s390x: Support AES ECB for cpacf km
 instruction
To: Harald Freudenberger <freude@linux.ibm.com>, richard.henderson@linaro.org, 
 david@kernel.org, thuth@redhat.com, berrange@redhat.com
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, linux-s390@vger.kernel.org, 
 dengler@linux.ibm.com, borntraeger@linux.ibm.com,
 fcallies@linux.ibm.com, cohuck@redhat.com
References: <20260710152906.80207-1-freude@linux.ibm.com>
 <20260710152906.80207-6-freude@linux.ibm.com>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <20260710152906.80207-6-freude@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDEyMiBTYWx0ZWRfX7P/6vyv73dwx
 s1UAwzRXr60/Pn0WMXCWJMnx1sYdpx21YZ4GY8B400HFjMOwy/ZIJ1MvYWQNDdQsOa/oQ415KjW
 Kg3BWXLcnjuKF/gQzr/eIgVnAH30feU=
X-Authority-Analysis: v=2.4 cv=Mp1iLWae c=1 sm=1 tr=0 ts=6a56225e cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=BMbQIPxVKhEvVYEsMDsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: Qd6s6vnHVyJtw8RIazFf407vBO5mqClI
X-Proofpoint-ORIG-GUID: Qd6s6vnHVyJtw8RIazFf407vBO5mqClI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDEyMiBTYWx0ZWRfX/1xpcmS12jME
 Ad547Ax9d2pWVSGO6XVVi5yjUKgLY6yjsjKzO1csXwJzdX97cVvnrkpP/f0vDegfuaBEdU4utmq
 YRlaCIEDK8qjNUUGC0SAMPoxo1s0nnLfZge4Yt9PnMtciSLEMJJu9sWubL1QbM3gpH0hlCTBGPU
 W+knzjdYK7mm+Rumu6zYp4z77dJ7rye2p8xbUHYhvGw61BbydPNlriw5AiXsW9XiwRRAhGlLzUG
 /VE5pO8PI9+rqgVBoGioElxaw74BSAwLEog6YBHKENW0R1aAiPqzRDEWMnAc6fUnpspo5T/rYHy
 R40Y0Ix5clozMqR8s4EUbOMKFiT1XrIXXRWKU9ujeSUX+Yol0RtVoH+kGaAINiVOnc/+tRPNL3c
 6tRJvfD75nw2ld8KnMfTsYIl6Crn130S8mMpmi4O8xPQyizNswcGQVN5i4ijTZeon+pxhRkghea
 gVfYbvkFvT/T/MfvQpg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_03,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 suspectscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607140122
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 7/10/26 17:28, Harald Freudenberger wrote:
> Support the subfunctions CPACF_KM_AES_128, CPACF_KM_AES_192
> and CPACF_KM_AES_256 for the cpacf km instruction.
> 
> Tested-by: Holger Dengler <dengler@linux.ibm.com>
> Reviewed-by: Finn Callies <fcallies@linux.ibm.com>
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
> ---
>   target/s390x/gen-features.c      |   3 +
>   target/s390x/tcg/cpacf.h         |   6 ++
>   target/s390x/tcg/cpacf_aes.c     | 136 +++++++++++++++++++++++++++++++
>   target/s390x/tcg/crypto_helper.c |  24 ++++++
>   target/s390x/tcg/meson.build     |   1 +
>   5 files changed, 170 insertions(+)
>   create mode 100644 target/s390x/tcg/cpacf_aes.c
> 
> diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
> index 78f71c6c7b..c8ba5107d7 100644
> --- a/target/s390x/gen-features.c
> +++ b/target/s390x/gen-features.c
> @@ -922,6 +922,9 @@ static uint16_t qemu_MAX[] = {
>       S390_FEAT_KLMD_SHA_256,
>       S390_FEAT_KLMD_SHA_512,
>       S390_FEAT_PRNO_TRNG,
> +    S390_FEAT_KM_AES_128,
> +    S390_FEAT_KM_AES_192,
> +    S390_FEAT_KM_AES_256,
>   };
>   
>   /****** END FEATURE DEFS ******/
> diff --git a/target/s390x/tcg/cpacf.h b/target/s390x/tcg/cpacf.h
> index 94e9de5b23..cee393cdc0 100644
> --- a/target/s390x/tcg/cpacf.h
> +++ b/target/s390x/tcg/cpacf.h
> @@ -233,4 +233,10 @@ int cpacf_sha512(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
>                    uint64_t param_addr, uint64_t *message_reg, uint64_t *len_reg,
>                    uint32_t type);
>   
> +/* from cpacf_aes.c */
> +int cpacf_aes_ecb(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
> +                  uint64_t param_addr, uint64_t *dst_ptr_reg,
> +                  uint64_t *src_ptr_reg, uint64_t *src_len_reg,
> +                  uint32_t type, uint8_t fc, uint8_t mod);
> +
>   #endif /* S390X_CPACF_H */
> diff --git a/target/s390x/tcg/cpacf_aes.c b/target/s390x/tcg/cpacf_aes.c
> new file mode 100644
> index 0000000000..5357d099c4
> --- /dev/null
> +++ b/target/s390x/tcg/cpacf_aes.c
> @@ -0,0 +1,136 @@
> +/*
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * s390 cpacf aes
> + *
> + * Authors:
> + *   Harald Freudenberger <freude@linux.ibm.com>
> + */
> +
> +#include "qemu/osdep.h"
> +#include "s390x-internal.h"
> +#include "tcg_s390x.h"
> +#include "accel/tcg/cpu-ldst-common.h"
> +#include "accel/tcg/cpu-mmu-index.h"
> +#include "crypto/aes.h"
> +#include "crypto/aes-helpers.h"
> +#include "target/s390x/tcg/cpacf.h"
> +
> +/*
> + * helper function to copy some memory from guest to a local buffer
> + */
> +static inline void copy_from_guest_wrap(CPUS390XState *env, const int mmu_idx,
> +                                        const uintptr_t ra, uint64_t guest_addr,
> +                                        uint8_t *dest, size_t len)
> +{
> +    const MemOpIdx oi = make_memop_idx(MO_8, mmu_idx);
> +
> +    for (size_t i = 0; i < len; i++, guest_addr++) {
> +        uint64_t waddr = wrap_address(env, guest_addr);
> +        dest[i] = cpu_ldb_mmu(env, waddr, oi, ra);
> +    }
> +}
> +
> +/*
> + * helper function to copy from a local buffer to guest memory
> + */
> +static inline void copy_to_guest_wrap(CPUS390XState *env, const int mmu_idx,
> +                                      const uintptr_t ra, uint64_t guest_addr,
> +                                      const uint8_t *src, size_t len)
> +{
> +    const MemOpIdx oi = make_memop_idx(MO_8, mmu_idx);
> +
> +    for (size_t i = 0; i < len; i++, guest_addr++) {
> +        uint64_t waddr = wrap_address(env, guest_addr);
> +        cpu_stb_mmu(env, waddr, src[i], oi, ra);
> +    }
> +}

Can we reuse these in other crypto code, e.g., sha256, sha512,
HELPER(msa), etc?

