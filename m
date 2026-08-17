Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F101BC5DF66
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 15:56:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvzgr-0005us-QP; Mon, 17 Aug 2026 11:55:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <freude@linux.ibm.com>)
 id 1wvzgo-0005uX-6U; Mon, 17 Aug 2026 11:55:54 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <freude@linux.ibm.com>)
 id 1wvzgm-0005JN-DT; Mon, 17 Aug 2026 11:55:53 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67HFgGZq1710889; Mon, 17 Aug 2026 15:55:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=xFMep0RtzeDjWv2TtVbiS1SYI4AQNbpUrLYPsJRUbGA=; b=pWi0jiIPJA5s
 ATkAwgtVizhNIOGjSUaihGg/mh38MyMhPMKB7WoAdqLlb0sTflNK3qDfjxWoUv/+
 Jtnf5A2K5pdW884mKbKetU1K30qDi6ir6NsR2cTATVAFPR2jE6zMMt1mZtlR5FsL
 zvwRglyJd1E9zqT4RHMOMecN7/4uXONfX4JDn8ldifRuFjdBA8Ed97TWWAr6reIO
 G2f3oSGCjWW7QMOKgFA5pPYFU3j59/utJzYQRgMh/pszJKaydiCvF8IXu5xCIIrk
 BJlc19oB0g8U1dUvw2YClyyRSaVk5meNgI+jgKNfFu0YxPdDXNr8nR7ZF3gIPPrR
 AhYUpE5w7g==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2dhku1yp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 17 Aug 2026 15:55:46 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67HFgWlw013735;
 Mon, 17 Aug 2026 15:55:45 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g34ng6f01-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 17 Aug 2026 15:55:45 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67HFthUQ19661564
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 17 Aug 2026 15:55:44 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8F77158056;
 Mon, 17 Aug 2026 15:55:43 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E1E455805D;
 Mon, 17 Aug 2026 15:55:42 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 17 Aug 2026 15:55:42 +0000 (GMT)
MIME-Version: 1.0
Date: Mon, 17 Aug 2026 17:55:42 +0200
From: Harald Freudenberger <freude@linux.ibm.com>
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: richard.henderson@linaro.org, david@kernel.org, thuth@redhat.com,
 berrange@redhat.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 linux-s390@vger.kernel.org, dengler@linux.ibm.com,
 borntraeger@linux.ibm.com, fcallies@linux.ibm.com, cohuck@redhat.com
Subject: Re: [PATCH v14 07/19] target/s390x: Support AES ECB for cpacf km
 instruction
Mail-Reply-To: freude@linux.ibm.com
In-Reply-To: <6621b094-e536-4f47-8b69-c9c0ad4132f8@linux.ibm.com>
References: <20260806151302.26846-1-freude@linux.ibm.com>
 <20260806151302.26846-8-freude@linux.ibm.com>
 <6621b094-e536-4f47-8b69-c9c0ad4132f8@linux.ibm.com>
Message-ID: <cded574a75e8bec52fd9492d60cc1c6d@linux.ibm.com>
X-Sender: freude@linux.ibm.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDExOSBTYWx0ZWRfX0DVqaglQp3mO
 6olyqifWk6rLsL7wfwMZJMvXDs5c5+7zgUhbqlVPHcxEqkAeIwrRtJuXCOF28J2LAxxpbMtvska
 qc/lcRlVGgN+GbanQr/rmybOg/dTFVXSdqrXahwJ3WW8UGX7xeAxAvC1jb5yXy7k8U8ESz8Qdkd
 swOT/ZQQF6OHjnqeiQJTfZFe0g/4uEgE92O/hcE0hO5XuI9DAnBTxvKWOPmBS0y0xU3y2uW2Zst
 JbKv4rFO17cdzTU2CleSY7r60VNRduIKCCNticBXmM0e9WFBI93A5rSyECf23CC2vyCnLq/TKQk
 Cad4OsmV6LAzOA5jvHRDuSIsyKDp8lM1jjZmH2NYmPOFfURQyccMxGr4fTrSKOTRdrC+x8xFyiN
 Ck9SQAiLysn+1Aw7te7RbUBSP4sw+L1uwoB+iSTcehGfKsYgf9de+O8UE+8LTMjXTDE+4cAvrlQ
 efMNSQcmlmkLMdmsrRA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDExOSBTYWx0ZWRfX263v+zMLmp8U
 ZFBv0JmEmg5XhCvMayo4NQo3lI0Dj55DlBwHbiX67agvx7xnmTvWoAbOcSuTuetBZCeo7xMi21K
 0Sd54h2tBoZyVk5MUUPbozIZDyi+3Mo=
X-Authority-Analysis: v=2.4 cv=JKkLdcKb c=1 sm=1 tr=0 ts=6a832f02 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=JjYLn2Euo6Dm9lQ10GIA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: riwJVFEIdle0HAZMZS3wwlWB1EH9YwZK
X-Proofpoint-GUID: riwJVFEIdle0HAZMZS3wwlWB1EH9YwZK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_02,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 adultscore=0 impostorscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608170119
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

On 2026-08-17 10:11, Ilya Leoshkevich wrote:
> On 8/6/26 17:12, Harald Freudenberger wrote:
>> Support the subfunctions CPACF_KM_AES_128, CPACF_KM_AES_192
>> and CPACF_KM_AES_256 for the cpacf km instruction.
>> 
>> Tested-by: Holger Dengler <dengler@linux.ibm.com>
>> Reviewed-by: Finn Callies <fcallies@linux.ibm.com>
>> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
>> ---
>>   target/s390x/gen-features.c      |   3 +
>>   target/s390x/tcg/cpacf.h         |   6 ++
>>   target/s390x/tcg/cpacf_aes.c     | 107 
>> +++++++++++++++++++++++++++++++
>>   target/s390x/tcg/crypto_helper.c |  24 +++++++
>>   target/s390x/tcg/meson.build     |   1 +
>>   5 files changed, 141 insertions(+)
>>   create mode 100644 target/s390x/tcg/cpacf_aes.c
>> 
> 
> [...]
> 
>> +/*
>> + * read exactly one AES block from guest memory into a local buffer
>> + */
>> +static inline void aes_read_block(CPUS390XState *env, const int 
>> mmu_idx,
>> +                                  const uintptr_t ra, uint64_t 
>> guest_addr,
>> +                                  uint8_t *buf)
>> +{
>> +    read_guest_wrap_u8(env, mmu_idx, ra, guest_addr, buf, 
>> AES_BLOCK_SIZE);
>> +}
>> +
>> +/*
>> + * write exactly one AES block from local buffer to guest memory
>> + */
>> +static void aes_write_block(CPUS390XState *env, const int mmu_idx,
>> +                            const uintptr_t ra, uint64_t guest_addr,
>> +                            uint8_t *buf)
>> +{
>> +    write_guest_wrap_u8(env, mmu_idx, ra, guest_addr, buf, 
>> AES_BLOCK_SIZE);
>> +}
> 
> nit: I would these two functions, I don't think they deserve a wrapper.
> 

I'd like to keep these two wrappers: The code is much more readable (for 
my
feeling) and the compiler hopefully does his job and replace it anyway.

>> +
>> +int cpacf_aes_ecb(CPUS390XState *env, const int mmu_idx, uintptr_t 
>> ra,
>> +                  uint64_t param_addr, uint64_t *dst_ptr_reg,
>> +                  uint64_t *src_ptr_reg, uint64_t *src_len_reg,
>> +                  uint32_t type, uint8_t fc, uint8_t mod)
>> +{
>> +    enum { MAX_BLOCKS_PER_RUN = 8192 / AES_BLOCK_SIZE };
>> +    uint8_t in[AES_BLOCK_SIZE], out[AES_BLOCK_SIZE];
>> +    uint64_t len = *src_len_reg, done = 0;
>> +    int i, keysize, addr_reg_size = 64;
>> +    uint8_t key[32];
>> +    AES_KEY exkey;
>> +
>> +    g_assert(type == S390_FEAT_TYPE_KM);
>> +    switch (fc) {
>> +    case CPACF_KM_AES_128:
>> +        keysize = 16;
>> +        break;
>> +    case CPACF_KM_AES_192:
>> +        keysize = 24;
>> +        break;
>> +    case CPACF_KM_AES_256:
>> +        keysize = 32;
>> +        break;
>> +    default:
>> +        g_assert_not_reached();
>> +    }
>> +
>> +    if (!(env->psw.mask & PSW_MASK_64)) {
>> +        len = (uint32_t)len;
>> +        addr_reg_size = (env->psw.mask & PSW_MASK_32) ? 32 : 24;
>> +    }
>> +
>> +    /* length has to be properly aligned. */
>> +    if (!QEMU_IS_ALIGNED(len, AES_BLOCK_SIZE)) {
>> +        tcg_s390_program_interrupt(env, PGM_SPECIFICATION, ra);
>> +    }
>> +
>> +    /* fetch key from param block */
>> +    read_guest_wrap_u8(env, mmu_idx, ra, param_addr, key, keysize);
>> +
>> +    /* expand key */
>> +    if (mod) {
>> +        AES_set_decrypt_key(key, keysize * 8, &exkey);
>> +    } else {
>> +        AES_set_encrypt_key(key, keysize * 8, &exkey);
>> +    }
>> +
>> +    /* process up to MAX_BLOCKS_PER_RUN aes blocks */
>> +    for (i = 0; i < MAX_BLOCKS_PER_RUN && len >= AES_BLOCK_SIZE; i++) 
>> {
>> +        aes_read_block(env, mmu_idx, ra, *src_ptr_reg + done, in);
>> +        if (mod) {
>> +            AES_decrypt(in, out, &exkey);
>> +        } else {
>> +            AES_encrypt(in, out, &exkey);
>> +        }
>> +        aes_write_block(env, mmu_idx, ra, *dst_ptr_reg + done, out);
>> +        len -= AES_BLOCK_SIZE;
>> +        done += AES_BLOCK_SIZE;
>> +    }
>> +
>> +    *src_ptr_reg = deposit64(*src_ptr_reg, 0, addr_reg_size,
>> +                             *src_ptr_reg + done);
>> +    *dst_ptr_reg = deposit64(*dst_ptr_reg, 0, addr_reg_size,
>> +                             *dst_ptr_reg + done);
>> +    *src_len_reg -= done;
>> +
>> +    return !len ? 0 : 3;
>> +}
> 
> The issue with writing memory, but not registers, on fault is still
> there, but I think today's behavior is good enough for emulating real
> sane code.
> 

I have opened up bugzilla 
https://bugzilla.linux.ibm.com/show_bug.cgi?id=221910 to track this.
But it will not be part of this patch series.

> 
> With our without the above addressed:
> 
> Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>

