Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0825CDB466
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 07:19:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wceM4-0002s4-Er; Thu, 25 Jun 2026 03:18:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <freude@linux.ibm.com>)
 id 1wceLi-0002pm-6D; Thu, 25 Jun 2026 03:18:11 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <freude@linux.ibm.com>)
 id 1wceLg-0004xL-96; Thu, 25 Jun 2026 03:18:09 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65P3md9E2927899; Thu, 25 Jun 2026 07:17:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=sEEdxNZSBJNJmGv9wYj4QSSkaFgOHTj0yQ4s0M1facU=; b=Dz9LAaTDW3JS
 YaWTS7AyvdmS/pj3l5xGauztHUmE7YMhRTUwJ5hA4vJ2xnCaZYdjN7/BFzZNQ7kL
 exlhqJ70GRhxB0ovXEmEwyq0wh4FzawJGbg3Xx8z2RsqgCPduZO7WqpYrvGKUMH2
 oG0Unux8nlt40RcpD3VTOxsUe16oB7Bt3dDPCF1Uwq3R5YPVJuYbQHy4Kh6SIFKk
 VDXtQDh5Ax4hX/NPPsBmBoiHQFS4OHHUPQsRs35/szvD6MKx3rd4QLZmAuVubVea
 GEuC1w3sXUByEH7loQneUFopv1F6FxDq5C4Ppa0idSlXriNc9DDxV4HOiSsfPSs7
 fKsjdrlcNQ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewh9gr8j6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 25 Jun 2026 07:17:57 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65P6nfvK007978;
 Thu, 25 Jun 2026 07:17:56 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ex56qn5yb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 25 Jun 2026 07:17:56 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65P7Htgu33161972
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 25 Jun 2026 07:17:55 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7A4875805D;
 Thu, 25 Jun 2026 07:17:55 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8345F58052;
 Thu, 25 Jun 2026 07:17:54 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 25 Jun 2026 07:17:54 +0000 (GMT)
MIME-Version: 1.0
Date: Thu, 25 Jun 2026 09:17:54 +0200
From: Harald Freudenberger <freude@linux.ibm.com>
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: richard.henderson@linaro.org, david@kernel.org, thuth@redhat.com,
 berrange@redhat.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 linux390-list@tuxmaker.boeblingen.de.ibm.com,
 linux-s390@vger.kernel.org, dengler@linux.ibm.com,
 borntraeger@linux.ibm.com, fcallies@linux.ibm.com, cohuck@redhat.com
Subject: Re: [PATCH v8 07/18] target/s390x: Support AES CTR for cpacf kmctr
 instruction
Mail-Reply-To: freude@linux.ibm.com
In-Reply-To: <a948d24d-f9cb-4d67-bf46-007d6de3c523@linux.ibm.com>
References: <20260624081029.23815-1-freude@linux.ibm.com>
 <20260624081029.23815-8-freude@linux.ibm.com>
 <a948d24d-f9cb-4d67-bf46-007d6de3c523@linux.ibm.com>
Message-ID: <e6a894618afbc5e45e66fafb3373de74@linux.ibm.com>
X-Sender: freude@linux.ibm.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: bS9YgefBNZ6Tvm91IRGUITunABBfl7Ho
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI1MDA1NyBTYWx0ZWRfXyI0FBARY3hEw
 BBJ93Aw+iOQjwmVfnsia/NmreHR+qcE1PGYkaspgK1ro7tvOT2cqV/KGt2kIceyKpWH73fxFDUR
 6C6z7RymoVgHsgcY+rg5ljR9PfEsIqM=
X-Authority-Analysis: v=2.4 cv=c62bhx9l c=1 sm=1 tr=0 ts=6a3cd625 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=LTUHX7r_CpFhJwewSl8A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI1MDA1NyBTYWx0ZWRfXzDTc5WLNZj4x
 9M6ejh3mDwTScyetiUaxwUuBlenrov8QS+9up+N7w5NrygWyU0pMfmgTtQ/eoX6sYmNQBDgvJRY
 IW41tM+8SFk5vufXfs3nQ8/S+U8ayBkgLy2Nl5G+TT5h8I5YHrcK2jhfTGg+YO4A8nhndRUTSsa
 /AO2e4cuqNB3RWpg7odGPr7AHoklr9rL3j+0V00S7vZxJDoAJaagTkENo7TKKXTVJ8rB/PDFsZ3
 Wvjc1fE6Uy9+UhRTL6x4AuDoam7W3SrA4sqTsDrNxBuJMfkERJTq8Mb2UPs+7Rnns7co/IJudDh
 6PrDJeaODSIBC9lpafHcFL05F5P7Vn8UPnUzEltO5p3lhUOdVxoaXXrdSaL79wFiHqkhPCewzav
 ZWycG4N172i5fn9uUGTl9nMXUKz03ywLOFiy44glTXFAlc7PRNPiHpnJzVyemJohgBO+zu074G/
 K5ozg3632GGAoNGKExA==
X-Proofpoint-ORIG-GUID: bS9YgefBNZ6Tvm91IRGUITunABBfl7Ho
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-25_01,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 adultscore=0 clxscore=1015 suspectscore=0
 priorityscore=1501 phishscore=0 spamscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606250057
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

On 2026-06-24 19:26, Ilya Leoshkevich wrote:
> On 6/24/26 10:10, Harald Freudenberger wrote:
>> Support the subfunctions CPACF_KMCTR_AES_128, CPACF_KMCTR_AES_192
>> and CPACF_KMCTR_AES_256 for the cpacf kmctr instruction.
>> 
>> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
>> Reviewed-by: Finn Callies <fcallies@linux.ibm.com>
>> ---
>>   target/s390x/gen-features.c      |  3 ++
>>   target/s390x/tcg/cpacf.h         |  5 +++
>>   target/s390x/tcg/cpacf_aes.c     | 76 
>> ++++++++++++++++++++++++++++++++
>>   target/s390x/tcg/crypto_helper.c | 24 ++++++++++
>>   4 files changed, 108 insertions(+)
> 
> [...]
> 
>> --- a/target/s390x/tcg/cpacf_aes.c
>> +++ b/target/s390x/tcg/cpacf_aes.c
>> @@ -213,3 +213,79 @@ int cpacf_aes_cbc(CPUS390XState *env, const int 
>> mmu_idx, uintptr_t ra,
>>         return !len ? 0 : 3;
>>   }
>> +
>> +int cpacf_aes_ctr(CPUS390XState *env, const int mmu_idx, uintptr_t 
>> ra,
>> +                  uint64_t param_addr, uint64_t *dst_ptr_reg,
>> +                  uint64_t *src_ptr_reg, uint64_t *src_len_reg,
>> +                  uint64_t *ctr_ptr_reg, uint32_t type,
>> +                  uint8_t fc, uint8_t mod)
>> +{
>> +    enum { MAX_BLOCKS_PER_RUN = 8192 / AES_BLOCK_SIZE };
>> +    const MemOpIdx oi = make_memop_idx(MO_8, mmu_idx);
>> +    uint8_t ctr[AES_BLOCK_SIZE], buf[AES_BLOCK_SIZE];
>> +    uint8_t in[AES_BLOCK_SIZE], out[AES_BLOCK_SIZE];
>> +    uint64_t addr, len = *src_len_reg, done = 0;
>> +    int i, keysize, addr_reg_size = 64;
>> +    uint8_t key[32];
>> +    AES_KEY exkey;
>> +
>> +    g_assert(type == S390_FEAT_TYPE_KMCTR);
>> +
>> +    switch (fc) {
>> +    case 0x12: /* CPACF_KMCTR_AES_128 */
>> +        keysize = 16;
>> +        break;
>> +    case 0x13: /* CPACF_KMCTR_AES_192 */
>> +        keysize = 24;
>> +        break;
>> +    case 0x14: /* CPACF_KMCTR_AES_256 */
>> +        keysize = 32;
>> +        break;
>> +    default:
>> +        g_assert_not_reached();
>> +    }
> 
> A general comment; I think I've seen this in previous patches as well.
> Would it make sense to properly define constants like
> CPACF_KMCTR_AES_128 and drop comments? Or, if the goal is easier
> cross-checking with POp, hardcode decimal numbers, since POp specifies
> them in decimal?
> 

As I am about to write some tests for all this CPACF support there would
be a benefit in having all this as constants or defines in a header file
instead of hardcoded values on every switch statement. So I am about to
introduce a some cpacf.h with all these values for the next version.

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
>> +    for (i = 0; i < keysize; i++) {
>> +        addr = wrap_address(env, param_addr + i);
>> +        key[i] = cpu_ldb_mmu(env, addr, oi, ra);
>> +    }
>> +
>> +    /* expand key */
>> +    AES_set_encrypt_key(key, keysize * 8, &exkey);
>> +
>> +    /* process up to MAX_BLOCKS_PER_RUN aes blocks */
>> +    for (i = 0; i < MAX_BLOCKS_PER_RUN && len >= AES_BLOCK_SIZE; i++) 
>> {
>> +        /* read in nonce/ctr => ctr */
>> +        aes_read_block(env, mmu_idx, *ctr_ptr_reg + done, ctr, ra);
>> +        /* encrypt ctr => buf */
>> +        AES_encrypt(ctr, buf, &exkey);
>> +        /* read in one block of input data => in */
>> +        aes_read_block(env, mmu_idx, *src_ptr_reg + done, in, ra);
>> +        /* xor input data with encrypted ctr => out */
>> +        aes_xor(in, buf, out);
>> +        /* write out the processed block */
>> +        aes_write_block(env, mmu_idx, *dst_ptr_reg + done, out, ra);
>> +        len -= AES_BLOCK_SIZE, done += AES_BLOCK_SIZE;
> 
> Same comment as in the previous patch.
> 
> 
> Otherwise:
> 
> Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
> 
> [...]

