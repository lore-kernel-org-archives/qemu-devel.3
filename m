Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8894CDE002
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 17:14:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcRAF-0007ae-UH; Wed, 24 Jun 2026 13:13:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1wcRAE-0007a8-57; Wed, 24 Jun 2026 13:13:26 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1wcRAC-00071z-AW; Wed, 24 Jun 2026 13:13:25 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65OEmF9R1276592; Wed, 24 Jun 2026 17:13:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=K3I0hA
 0KfNh94E0dzxyBY0SWSwtmut0shYZrKTSLDgQ=; b=CqweEDJr8daXg09Q45L3l/
 mubpHNSQeHDvAhSpwV1KmsikwgAyLjmEynA0x+CEXqZlPQ9pglvgljClHc6bff/a
 B8ZBmaQCK5Cf7Bkh65oZTBAeYTGN2tq885lX9rbvz9G20YrbLCm6yrjdte7Ilvvy
 Xg6lySZJkSq64+ZL5GkJBh9lF4J90vAuKK448eD5tin3Q6MbX82sm9atUVEII3eb
 bTiHgg6bpPLP1gdEDyaZXABXgJJQ4B/1S6fkmPNRz2s10XaY3G5l2O3VZtzdj2RP
 GHqbV3o/zASRylEs3ueNf5ZktnwVxwIN3oz/rmSGWcTf1VK6rBRvgCUFSSMesaFA
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewjk4ngss-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 24 Jun 2026 17:13:19 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65OH4eWF032039;
 Wed, 24 Jun 2026 17:13:19 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ex7vysfxt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 24 Jun 2026 17:13:18 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65OHDE8F45482368
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 24 Jun 2026 17:13:14 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B0D3320043;
 Wed, 24 Jun 2026 17:13:14 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1AD3220040;
 Wed, 24 Jun 2026 17:13:14 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.87.142.129])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 24 Jun 2026 17:13:14 +0000 (GMT)
Message-ID: <0f77d321-dc84-4a57-8c5c-264973f5dac1@linux.ibm.com>
Date: Wed, 24 Jun 2026 19:13:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 05/18] target/s390x: Support AES ECB for cpacf km
 instruction
To: Harald Freudenberger <freude@linux.ibm.com>, richard.henderson@linaro.org, 
 david@kernel.org, thuth@redhat.com, berrange@redhat.com
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 linux390-list@tuxmaker.boeblingen.de.ibm.com,
 linux-s390@vger.kernel.org, dengler@linux.ibm.com,
 borntraeger@linux.ibm.com, fcallies@linux.ibm.com, cohuck@redhat.com
References: <20260624081029.23815-1-freude@linux.ibm.com>
 <20260624081029.23815-6-freude@linux.ibm.com>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <20260624081029.23815-6-freude@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI0MDE0MSBTYWx0ZWRfX/av+JkqB5JYp
 RuUXWtVuqq4ehtMp5oU5xa5h6u8+VukvvlPgl+6sf/89gbtLBYeHq0rhM5+Rf7p/KtS2YBbV89b
 /pc029+R5vKKuGmU2k5A1LAE+68NTcg=
X-Proofpoint-ORIG-GUID: fPbfWlTzJol0Tmw5ItOhglDTN4XR0eIZ
X-Authority-Analysis: v=2.4 cv=Oph/DS/t c=1 sm=1 tr=0 ts=6a3c1030 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=QgfHRvl5YYpBVYqF5jIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI0MDE0MSBTYWx0ZWRfX5i1Z668n7Hve
 aF8EFBLHwIQAacgKcJYU1KoHGzVovWmY9iABg3OvkXvVsoC6dwaiAXvnyLJJu13cKtC5dLrhIq7
 L211kMdPBWQSsHak6t+Vlz/CygIxiQpLvNPFrcUgD+aMgKdzcWlx+59cetxTLfgT7dedzK0xiWM
 TQ8gaII+CIT8PtI+6AMU0uCaH1HBdNTvvfBbTpwC/6OCMrEX+XEoc65hLjmktKbWycAdpvPpcXn
 hIF0EIfMOiVZo+WaE1ou435BKuBQefBJ7DC8WvxESOZsrjeI2cK764YjdGF8Z+LcdkVXmdDaGF0
 6VR7ZtL6n614ScyJQ36Ot/BPtZixRFs+jNunOhUA4QMTYihWvWq/esrjY+9F66BQWywV5ir08hq
 8KDzrFH6YILPP8UtaRGZPWhDV0Vx3ruS6Tu/T523oMuIIx8OLt7gzzuE2jhsl+e8Sia4PmYcc8w
 TCigCj1MBoCYNnPY8ig==
X-Proofpoint-GUID: fPbfWlTzJol0Tmw5ItOhglDTN4XR0eIZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-24_03,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 clxscore=1011 impostorscore=0 malwarescore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606240141
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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



On 6/24/26 10:10, Harald Freudenberger wrote:
> Support the subfunctions CPACF_KM_AES_128, CPACF_KM_AES_192
> and CPACF_KM_AES_256 for the cpacf km instruction.
> 
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
> Tested-by: Holger Dengler <dengler@linux.ibm.com>
> Reviewed-by: Finn Callies <fcallies@linux.ibm.com>
> ---
>   target/s390x/gen-features.c      |   3 +
>   target/s390x/tcg/cpacf.h         |   6 ++
>   target/s390x/tcg/cpacf_aes.c     | 113 +++++++++++++++++++++++++++++++
>   target/s390x/tcg/crypto_helper.c |  24 +++++++
>   target/s390x/tcg/meson.build     |   1 +
>   5 files changed, 147 insertions(+)
>   create mode 100644 target/s390x/tcg/cpacf_aes.c

[...]

> diff --git a/target/s390x/tcg/cpacf_aes.c b/target/s390x/tcg/cpacf_aes.c
> new file mode 100644
> index 0000000000..ba836f1473
> --- /dev/null
> +++ b/target/s390x/tcg/cpacf_aes.c
> @@ -0,0 +1,113 @@
> +/*
> + *  s390 cpacf aes
> + *
> + *  Authors:
> + *   Harald Freudenberger <freude@linux.ibm.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "s390x-internal.h"
> +#include "tcg_s390x.h"
> +#include "accel/tcg/cpu-ldst-common.h"
> +#include "accel/tcg/cpu-mmu-index.h"
> +#include "crypto/aes.h"
> +#include "cpacf.h"
> +
> +static void aes_read_block(CPUS390XState *env, const int mmu_idx,
> +                           uint64_t addr, uint8_t *a, uintptr_t ra)
> +{
> +    const MemOpIdx oi = make_memop_idx(MO_8, mmu_idx);
> +    uint64_t _addr;
> +
> +    for (int i = 0; i < AES_BLOCK_SIZE; i++, addr += 1) {
> +        _addr = wrap_address(env, addr);
> +        a[i] = cpu_ldb_mmu(env, _addr, oi, ra);
> +    }
> +}

This is very similar to sha256_read_mbl_be32().
Would it make sense to factor this out as copy_from_guest_wrap() or
something along these lines?

[...]

