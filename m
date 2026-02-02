Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48A25E7315F
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 12:38:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmtBZ-0001sy-Kd; Mon, 02 Feb 2026 07:37:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frankja@linux.ibm.com>)
 id 1vmtBS-0001s3-4b; Mon, 02 Feb 2026 07:37:38 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frankja@linux.ibm.com>)
 id 1vmtBQ-0007QV-F0; Mon, 02 Feb 2026 07:37:37 -0500
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 6124ElSM015583;
 Mon, 2 Feb 2026 12:37:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=HaFeDH
 Tyzp4PWzpqW+nSuxMnmkX/zlOiIKRCFhB40qY=; b=I8sBnmbJ2wD3SCQ+rvBluj
 eMZEc+4d9ODWqHkRCUtH2O6kN/275lVZLYEvcWjYqYwPykUzCcKvnIhyCDM3/inF
 3wy9UObjsR/JenH32oF/lzXWV4e76QhA8c2pMIyigTe88ZTZgyraYCTYnpWJ20uc
 v9VzMbd2XPKOnYFR5U9nrj8pBXQADPRWWx9lXwHB6DyshsaatJbz+grz2VNUs7Q9
 TsXmf65pi7uVEGMod5w17hwCf4+rSdi0j64/kFrLTQJlDBMfHA3w29Xp2SBHLOln
 gMXxteRWQdLzRR1fqXaSfPFd4pvZBVxLIKIbJ2F5AbLzDtrInUw98aZHWQ6I17SQ
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c175mq24k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 02 Feb 2026 12:37:33 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 6128KEkG029053;
 Mon, 2 Feb 2026 12:37:32 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4c1v2s54ch-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 02 Feb 2026 12:37:32 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 612CbS5s40894968
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 2 Feb 2026 12:37:28 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CDC8620040;
 Mon,  2 Feb 2026 12:37:28 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8AB8E2004B;
 Mon,  2 Feb 2026 12:37:28 +0000 (GMT)
Received: from [9.111.35.143] (unknown [9.111.35.143])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  2 Feb 2026 12:37:28 +0000 (GMT)
Message-ID: <105fff1c-5c2f-4441-bc13-2fff5c4a9766@linux.ibm.com>
Date: Mon, 2 Feb 2026 13:37:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/14] target/s390x: Support AES ECB for cpacf km
 instruction
To: Harald Freudenberger <freude@linux.ibm.com>, pbonzini@redhat.com
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, borntraeger@linux.ibm.com
References: <20260123114308.19401-1-freude@linux.ibm.com>
 <20260123114308.19401-5-freude@linux.ibm.com>
Content-Language: en-US
From: Janosch Frank <frankja@linux.ibm.com>
Autocrypt: addr=frankja@linux.ibm.com; keydata=
 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
In-Reply-To: <20260123114308.19401-5-freude@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 2bZRSoNVp2gWwSjZt6FUIYvMPEvxX5Mc
X-Authority-Analysis: v=2.4 cv=VcX6/Vp9 c=1 sm=1 tr=0 ts=69809a8d cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=BMbQIPxVKhEvVYEsMDsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 2bZRSoNVp2gWwSjZt6FUIYvMPEvxX5Mc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAyMDA5NyBTYWx0ZWRfXx9QrbAyApjSd
 oIwMfL2oIXBOGa42xW1xTfdH/XkBNJFEtrp2woNPYvj9+f99hQZ2LoKOFWbeAKZ1PFZC8toiHk5
 +N4R/hyRKWB9uojxC1dVan4o29+teXiSLDRHzjVyddHO/uMMzlIzJIwZINrODm4sbdbFurWZOvZ
 MBu0Yh97wC7QkM1NyS9BzyYgqjcPin2pahzrQOaVDGutlnO+w9SSZVNhRkZuDInGl/pWrQ18U75
 SokP5lnQ44MyRJ5iruQbdBdJ3o0343STSuLh/hhbmH5CMn1gENijS82XTw28BqlHWD7HvqElWzc
 WSK7tnqQ70f/y20oD/7m5ZzDcCw1vjUkGldlGUs/YC21FCjk9EcKYwPdypbHHWVDPjbXBzxZpLs
 VbckSHHUXLpCUPnE3l4ermwn2TmFUmTmRX4ItnpEIHfzUeKA4eSg/5LpD77+IK2m0dht/1DDap8
 ZFNlAFSoA3qqJruklww==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-02_04,2026-01-30_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0
 bulkscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2601150000 definitions=main-2602020097
Received-SPF: pass client-ip=148.163.158.5; envelope-from=frankja@linux.ibm.com;
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

On 1/23/26 12:42, Harald Freudenberger wrote:
> Support the subfunctions CPACF_KM_AES_128, CPACF_KM_AES_192
> and CPACF_KM_AES_256 for the cpacf km instruction.
> 
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
> ---

[...]

> +int cpacf_aes_ecb(CPUS390XState *env, uintptr_t ra, uint64_t param_addr,
> +                  uint64_t *dst_ptr, uint64_t *src_ptr, uint64_t *src_len,

You're passing registers as pointers with names that sound like they 
aren't registers. I had to look at this a couple of times until I 
understood why you're seemingly not touching registers in this function.

Additionally you don't even need to pass them because you have "env" as 
the first parameter anyway.


> +                  uint32_t type, uint8_t fc, uint8_t mod)
> +{
> +    enum { MAX_BLOCKS_PER_RUN = 8192 / AES_BLOCK_SIZE };
> +    uint8_t in[AES_BLOCK_SIZE], out[AES_BLOCK_SIZE];
> +    uint64_t addr, len = *src_len, processed = 0;
> +    int i, keysize, data_reg_len = 64;
> +    uint8_t key[32];
> +    AES_KEY exkey;
> +
> +    g_assert(type == S390_FEAT_TYPE_KM);
> +    switch (fc) {
> +    case 0x12: /* CPACF_KM_AES_128 */
> +        keysize = 16;
> +        break;
> +    case 0x13: /* CPACF_KM_AES_192 */
> +        keysize = 24;
> +        break;
> +    case 0x14: /* CPACF_KM_AES_256 */
> +        keysize = 32;
> +        break;
> +    default:
> +        g_assert_not_reached();
> +    }
> +
> +    if (!(env->psw.mask & PSW_MASK_64)) {
> +        len = (uint32_t)len;
> +        data_reg_len = (env->psw.mask & PSW_MASK_32) ? 32 : 24;

You're NOT working on data registers, you're handling address registers 
and hence you have to determine addressing size. The naming is very 
misleading.

> +    }
> +
> +    /* length has to be properly aligned. */
> +    if (!QEMU_IS_ALIGNED(len, AES_BLOCK_SIZE)) {
> +        tcg_s390_program_interrupt(env, PGM_SPECIFICATION, ra);
> +    }
> +
> +    /* fetch key from param block */
> +    for (i = 0; i < keysize; i++) {
> +        addr = wrap_address(env, param_addr + i);
> +        key[i] = cpu_ldub_data_ra(env, addr, ra);
> +    }
> +
> +    /* expand key */
> +    if (mod) {
> +        AES_set_decrypt_key(key, keysize * 8, &exkey);
> +    } else {
> +        AES_set_encrypt_key(key, keysize * 8, &exkey);
> +    }
> +
> +    /* process up to MAX_BLOCKS_PER_RUN aes blocks */
> +    for (i = 0; i < MAX_BLOCKS_PER_RUN && len >= AES_BLOCK_SIZE; i++) {
> +        aes_read_block(env, *src_ptr + processed, in, ra);

Yeah, you effectively have a double pointer since you're pointing to a 
register in memory that contains an address.

> +        if (mod) {
> +            AES_decrypt(in, out, &exkey);
> +        } else {
> +            AES_encrypt(in, out, &exkey);
> +        }
> +        aes_write_block(env, *dst_ptr + processed, out, ra);
> +        len -= AES_BLOCK_SIZE, processed += AES_BLOCK_SIZE;
> +    }
> +
> +    *src_ptr = deposit64(*src_ptr, 0, data_reg_len, *src_ptr + processed);
> +    *dst_ptr = deposit64(*dst_ptr, 0, data_reg_len, *dst_ptr + processed);
> +    *src_len -= processed;
> +
> +    return !len ? 0 : 3;

I'm fine with adding variables to avoid having to index env->regs[].
But please improve the naming and make it clear where you have a 
register backing it.

