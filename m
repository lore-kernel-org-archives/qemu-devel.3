Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43ECDCD98F2
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 12:33:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wc0Ir-0007k1-1U; Tue, 23 Jun 2026 08:32:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <freude@linux.ibm.com>)
 id 1wc0Io-0007jX-Kq; Tue, 23 Jun 2026 08:32:30 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <freude@linux.ibm.com>)
 id 1wc0Im-0003va-Te; Tue, 23 Jun 2026 08:32:30 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65NBmbCY1914900; Tue, 23 Jun 2026 12:32:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=ii8ubBjO6avbIeg3OwBxjAIAKcfCiZ5n6bXgq00LlOE=; b=D8Ik3dAPfz3/
 SxGZpzJ9JL92LKMb3npEtEQMatoSBSYvBqRkU+ptSUsBHbt1i1PAu62nXXQvfjwi
 NZqR0ehyoG61Qzpfrcvfm/mqw5Nj3pUGZ1SnDAz9ZF3I78iIN5ocM6yD15zCLDYd
 KpKidFZMSNguFWuWG5IaKL2AhsQvAmF3C/K2gbuS70PCWbJCg5IeJgFv8wCBiA3z
 vz8Y4L8+506F1QQMu+ZYfjfWGTyQHki08xzZky6NCWdxuWRiyuIw2oAxVQRCx7Ry
 Vyiuy56KMvjij3mvtx9srlnEPtsJWfHd/uAx2fPypov3Xkkf0TT+3LIVALBNJ+U1
 OV2h/sMu5g==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewjk4edtx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 Jun 2026 12:32:24 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65NCJgBh017867;
 Tue, 23 Jun 2026 12:32:23 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ex5jwba9d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 Jun 2026 12:32:23 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65NCWMTd10551820
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 23 Jun 2026 12:32:22 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5867058061;
 Tue, 23 Jun 2026 12:32:22 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0682E5805D;
 Tue, 23 Jun 2026 12:32:21 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 23 Jun 2026 12:32:20 +0000 (GMT)
MIME-Version: 1.0
Date: Tue, 23 Jun 2026 14:32:20 +0200
From: Harald Freudenberger <freude@linux.ibm.com>
To: Finn Callies <fcallies@linux.ibm.com>
Cc: richard.henderson@linaro.org, iii@linux.ibm.com, david@kernel.org,
 thuth@redhat.com, berrange@redhat.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, linux390-list@tuxmaker.boeblingen.de.ibm.com,
 linux-s390@vger.kernel.org, dengler@linux.ibm.com,
 borntraeger@linux.ibm.com, cohuck@redhat.com
Subject: Re: [PATCH v7 12/17] target/s390x: Support protected key AES CTR for
 cpacf kmctr instruction
Mail-Reply-To: freude@linux.ibm.com
In-Reply-To: <1cf46c18-6b80-415a-bcb8-cb68dea6b69e@linux.ibm.com>
References: <20260617094820.34402-1-freude@linux.ibm.com>
 <20260617094820.34402-13-freude@linux.ibm.com>
 <1cf46c18-6b80-415a-bcb8-cb68dea6b69e@linux.ibm.com>
Message-ID: <f1877349fdf56b1d8d4f3e553ae320d9@linux.ibm.com>
X-Sender: freude@linux.ibm.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDEwMSBTYWx0ZWRfX/vqJxXgjo43T
 60YoQIyHzvFS83EcPDdVrAkzvCNhvmLQpFjqaHGHCeko/XIESxJiOB+rYzGYT0rnnQiGNuVne4F
 clDM/bx8wxrTPtV7dHcbNaPDh33LeWo=
X-Proofpoint-ORIG-GUID: fA9wYY68zGxqabxWQKTQhlpqw1drPoFA
X-Authority-Analysis: v=2.4 cv=Oph/DS/t c=1 sm=1 tr=0 ts=6a3a7cd8 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=rJUJxA7k1JXDQCIw7yMA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDEwMSBTYWx0ZWRfX2ZuKtRS36qOI
 pq2xN9F1Ermn5h95y2PssDIJ7vpxPR0gh736gPimTKt0AapvcY79733HYRGceyEE2hcJh/VWhaF
 uwZisUjwtKojwv6m5ZZF0mlmwzC0eru6C49pkmQBSw4MjnwYIaEb/on2BNSLTWjuGQJgKZxfMxO
 Q2pAu1LpT0e8G8oaNn4QCcDFQiKDXpoLUWa+NWC15ZzslWCspcLjAnajl/hH5z5Jk5RFmsDMgfz
 KJjsPs2aib04ObKY+S+azYsheahOpaYsG2G3ewz1/lea7GFzVeuBI5Odige8GMu2qQXYPyKpPCn
 5b+tubx7UbR9qisjUcEisVUMI4RJPP9FesZqvUcWSbdbbGV7iFdGlDYSwbCaDJdlcp4J/Bf4KPM
 GxnXtCC3QKFI91GQ28ArUFzTWAxGZv1VO9Lrq6Exj+OhLDkLlQRrmEzHVqpqjTBzRiTrfyeNbG1
 ef+cO0KM5tXECmffYBg==
X-Proofpoint-GUID: fA9wYY68zGxqabxWQKTQhlpqw1drPoFA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_03,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 clxscore=1015 impostorscore=0 malwarescore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606230101
Received-SPF: pass client-ip=148.163.156.1; envelope-from=freude@linux.ibm.com;
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
Reply-To: freude@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 2026-06-18 08:10, Finn Callies wrote:
> On 17.06.26 11:48, Harald Freudenberger wrote:
>> Support the subfunctions CPACF_KMCTR_PAES_128, CPACF_KMCTR_PAES_192
>> and CPACF_KMCTR_PAES_256 for the cpacf kmctr instruction.
>> 
>> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
>> ---
>>   target/s390x/gen-features.c      |  3 ++
>>   target/s390x/tcg/cpacf.h         |  5 ++
>>   target/s390x/tcg/cpacf_aes.c     | 90 
>> ++++++++++++++++++++++++++++++++
>>   target/s390x/tcg/crypto_helper.c |  7 +++
>>   4 files changed, 105 insertions(+)
>> 
>> diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
>> index 074c53aecd..4a131dc191 100644
>> --- a/target/s390x/gen-features.c
>> +++ b/target/s390x/gen-features.c
>> @@ -938,6 +938,9 @@ static uint16_t qemu_MAX[] = {
>>       S390_FEAT_KMCTR_AES_128,
>>       S390_FEAT_KMCTR_AES_192,
>>       S390_FEAT_KMCTR_AES_256,
>> +    S390_FEAT_KMCTR_EAES_128,
>> +    S390_FEAT_KMCTR_EAES_192,
>> +    S390_FEAT_KMCTR_EAES_256,
> 
> EAES -> PAES or EAES -> ENCRYPTED_AES
> 

Again - not in the scope of this patch series.

>>       S390_FEAT_PCC_XTS_AES_128,
>>       S390_FEAT_PCC_XTS_AES_256,
>>       S390_FEAT_PCKMO_AES_128,
> 
> [ snip ]
> 
>> diff --git a/target/s390x/tcg/cpacf_aes.c 
>> b/target/s390x/tcg/cpacf_aes.c
>> index a6487261e1..ffa286d422 100644
>> --- a/target/s390x/tcg/cpacf_aes.c
>> +++ b/target/s390x/tcg/cpacf_aes.c
>> @@ -729,3 +729,93 @@ int cpacf_paes_cbc(CPUS390XState *env, const int 
>> mmu_idx, uintptr_t ra,
>>         return !len ? 0 : 3;
>>   }
>> +
>> +int cpacf_paes_ctr(CPUS390XState *env, const int mmu_idx, uintptr_t 
>> ra,
>> +                   uint64_t param_addr, uint64_t *dst_ptr_reg,
>> +                   uint64_t *src_ptr_reg, uint64_t *src_len_reg,
>> +                   uint64_t *ctr_ptr_reg, uint32_t type,
>> +                   uint8_t fc, uint8_t mod)
>> +{
> 
> [ snip ]
> 
>> +    /* fetch protected key from param block */
>> +    for (i = 0; i < keysize; i++) {
>> +        addr = wrap_address(env, param_addr + i);
>> +        key[i] = cpu_ldb_mmu(env, addr, oi, ra);
>> +    }
>> +    /* 'decrypt' the protected key */
>> +    for (i = 0; i < keysize; i++) {
>> +        key[i] ^= protkey_xor_pattern[i];
> 
> Outsourcing if you see a benefit.
> 

Yep, done.

>> +    }
>> +
>> +    /* expand key */
>> +    AES_set_encrypt_key(key, keysize * 8, &exkey);
> 
> [ snip ]

