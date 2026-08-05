Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBEDCC55822
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2026 08:29:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrWzf-0002xg-Q3; Wed, 05 Aug 2026 04:28:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <freude@linux.ibm.com>)
 id 1wrWzd-0002wt-PC; Wed, 05 Aug 2026 04:28:53 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <freude@linux.ibm.com>)
 id 1wrWzc-0001Xk-6F; Wed, 05 Aug 2026 04:28:53 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6755mRts2910531; Wed, 5 Aug 2026 08:28:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=alg1YjVLtGBWfFPF/Pm+hP1hZ+FTw1gYt0MnZDIV/JE=; b=aJMnzSWviVdo
 FKu0QzqxfNeKbMXrdS7IUU53vLhjziR3ywxu9qWPF3GR/n1JkIWUnuCEhrjUu0df
 6QbVM644NcC8MTsCSPthT+YacpqbwAmYORwXzH+Mn2hLeGddKgrzFXIXF/JG2gKi
 x+ddrLxbvVoe/GpNKKM46qfVBxd6kyo6B1Rq2zAK66oRwCQD5L5AiRecciviMzj0
 n3bqmahzgHLEOaxaqnm2jRVbIYOvUrUzSToUHBNT97sENq/+8b3zMOoiSMl/xqi1
 ghcEF+ZukYDhMH2R96/RuD5hMISo2OwucU6sn7D/j0SQcFVzjHKVq+d6OkZQ6dnf
 9rXS9rCRYg==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs77g9r86-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 05 Aug 2026 08:28:48 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6758QR5R032128;
 Wed, 5 Aug 2026 08:28:47 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsvmhdnak-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 05 Aug 2026 08:28:47 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6758SkbB24052378
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 5 Aug 2026 08:28:46 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EF7B558059;
 Wed,  5 Aug 2026 08:28:45 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5016858062;
 Wed,  5 Aug 2026 08:28:45 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  5 Aug 2026 08:28:45 +0000 (GMT)
MIME-Version: 1.0
Date: Wed, 05 Aug 2026 10:28:45 +0200
From: Harald Freudenberger <freude@linux.ibm.com>
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: richard.henderson@linaro.org, david@kernel.org, thuth@redhat.com,
 berrange@redhat.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 linux-s390@vger.kernel.org, dengler@linux.ibm.com,
 borntraeger@linux.ibm.com, fcallies@linux.ibm.com, cohuck@redhat.com
Subject: Re: [PATCH v13 12/18] target/s390x: Support protected key AES ECB for
 cpacf km instruction
Mail-Reply-To: freude@linux.ibm.com
In-Reply-To: <69f53a7c-83dd-46bf-81a1-7941f4b6c5f5@linux.ibm.com>
References: <20260803161235.228704-1-freude@linux.ibm.com>
 <20260803161235.228704-13-freude@linux.ibm.com>
 <69f53a7c-83dd-46bf-81a1-7941f4b6c5f5@linux.ibm.com>
Message-ID: <fd5d369e27953708bdbd43620aa73957@linux.ibm.com>
X-Sender: freude@linux.ibm.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDA2NCBTYWx0ZWRfXzSVtKoeRaPCA
 X64owdntsKYA8SSuQoFw25od8cUvMUQAtbiRjspRna2Nm8s5DHxFiSp3G7cvjMkCygr4hQRgNuf
 zvVVgW39XXAibF0oYHPTgG4KKFrjKkXrrNYTflR+rU49o1X0WJemBC6JJRE1HtCNlS8ZsuUSQc0
 zk/3auaiGJGRASPwMC1s7wEhOCN4U5WV41jl+xYa62uoe01BEjuwWm1ST1GruRstC3JRQ90yoPH
 bCNWerRiBD4mOsm7nfxCconj489O5DWkQADrtpHICrRZBZnYrgwIkkQh77NnEBombFXBLj0x2PX
 YlX3OvaB8efEA34LpWMcNJ8wmLc0xsZaURsLmqGpWHM1HPyo3SElvebtvpBWmMHAffqr/Y3Hgc3
 2vYjIn8jzi4OODcWXx0qU2CcFZvNtw8Gb67q7Ujvd06jkmVSlH7JGpbWYCuTsTnJvBewoaL7a9w
 c5aPWt4zKekbvLLBASw==
X-Authority-Analysis: v=2.4 cv=WIFPmHsR c=1 sm=1 tr=0 ts=6a72f440 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=QzTdLlRJxZAzEcj93u8A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: WOVxFtLSs22AGwVkhxrid-hHSi9-kuUm
X-Proofpoint-ORIG-GUID: WOVxFtLSs22AGwVkhxrid-hHSi9-kuUm
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDA2NCBTYWx0ZWRfX97HjIJ7xWj5x
 Fwd10jObjr/u/MWz8sJasAvHyenG6Eh/WvSmQYInE13W+IFt4EbE06zRiP/+qTkbarM3Oi/nZJd
 fiLcm1JDLEiWsbioWS+O0G5/5Pszik0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_02,2026-08-04_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 suspectscore=0 clxscore=1015 impostorscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608050064
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

On 2026-08-05 00:48, Ilya Leoshkevich wrote:
> On 8/3/26 18:12, Harald Freudenberger wrote:
>> Support the subfunctions CPACF_KM_PAES_128, CPACF_KM_PAES_192
>> and CPACF_KM_PAES_256 for the cpacf km instruction.
>> 
>> Tested-by: Holger Dengler <dengler@linux.ibm.com>
>> Reviewed-by: Finn Callies <fcallies@linux.ibm.com>
>> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
>> ---
>>   target/s390x/gen-features.c      |  3 ++
>>   target/s390x/tcg/cpacf.h         |  4 ++
>>   target/s390x/tcg/cpacf_aes.c     | 91 
>> ++++++++++++++++++++++++++++++++
>>   target/s390x/tcg/crypto_helper.c |  7 +++
>>   4 files changed, 105 insertions(+)
> 
> [...]
> 
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
> 
> Should we update registers after each iteration?
> Otherwise there may be interesting effects due to swapped out pages 
> when
> running in system emulation.

I don't get this. Swapping and interruption of this code should not 
affect
the encrypted/decrypted result in memory and also not the register 
content.
But I assume that a CPACF instruction itself is some atomic operation. 
So
there needs to be a consistent state before and after the instruction. 
But
"while" the instruction is executed does not need to be consistent all 
the
time. Otherwise for example here the memory write and the update of the
registers should be atomic.

> Blocks crossing the page boundary is a similar issue, not sure if it's
> that easy to solve.

Well yes. This is a clear issue hanging around in all the memory 
read/write
crypto code here. I have no idea on how this could be solved. However, 
sounds
like there will participate a new guy in the Qemu cpacf area soon. So 
maybe
he has some ideas to work this out.

> 
> [...]

