Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 459C7CA5FED
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2026 07:43:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xF5Fm-0004MM-2V; Fri, 09 Oct 2026 03:42:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <freude@linux.ibm.com>)
 id 1xF5Fd-0004Ls-5F; Fri, 09 Oct 2026 03:42:45 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <freude@linux.ibm.com>)
 id 1xF5Fa-0001NL-JW; Fri, 09 Oct 2026 03:42:44 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6993ZWHU3271654; Fri, 9 Oct 2026 07:42:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=K/5SFwMZCT0oPIEX2uAkn0fIdaK/syzNB48Il8q4qzI=; b=eXWNwTCJ4bAr
 3PHeii9/6QlF8Rs6QvKgf6ej8OdOwqCI+b/YhoDCoXETBDQxTfWfKWJ9l0w/liqz
 +HByjjXumnDhCxdkRvzX9UyMtS++l1L+pc1SjcOZPiOy27jXmAzLiYKflT6wAojB
 OafL1ENwO+kidf3LwtytTcOwOe+nJtMeXiBKPKPxB2Dtc8H9sSUHsttN//eTUQ9V
 Kyw3ioK9GAgYquEJO+pPKDunmUOJDwNfIGMsubYVnF+0nKyWrVm5/FpbGGmOev8d
 8yJjNvj0gmhql+QHRdKbK8mlqEUYABS7ttGsgHcCWe3B87TDK+Me/93m19EbBrKQ
 U+m1O+po+g==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h5xjw16e0-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 09 Oct 2026 07:42:35 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 6993HXfr249309; Fri, 9 Oct 2026 07:42:34 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h58ekb72g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 09 Oct 2026 07:42:34 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6997gXwu17040088
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 9 Oct 2026 07:42:34 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AE0D758050;
 Fri,  9 Oct 2026 07:42:33 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0FB7558056;
 Fri,  9 Oct 2026 07:42:33 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  9 Oct 2026 07:42:32 +0000 (GMT)
MIME-Version: 1.0
Date: Fri, 09 Oct 2026 09:42:32 +0200
From: Harald Freudenberger <freude@linux.ibm.com>
To: Andrew Holden <andy0x48@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, iii@linux.ibm.com,
 richard.henderson@linaro.org, david@kernel.org, cohuck@redhat.com
Subject: Re: [PATCH] target/s390x/tcg: fix register update on guest memory
 fault in cpacf_aes_ecb
Mail-Reply-To: freude@linux.ibm.com
In-Reply-To: <20261008154455.369004-1-andy0x48@linux.ibm.com>
References: <20261008154455.369004-1-andy0x48@linux.ibm.com>
Message-ID: <354513f2ac7e565cd22362db4aa5459e@linux.ibm.com>
X-Sender: freude@linux.ibm.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: YlB0-I2QJUynXNahgUD5XqWo2M9IYvhs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDAzMCBTYWx0ZWRfX7Kiwiw0dCNJj
 TtSZFDLaVuevA50sCGDzMbFmn6/+gXQiKTg5WPF6gyeF3jIEuhtP6fhfTPGejFX+i9iGCmSFwYb
 bXcdwTn/zGGvwrxJPTUUIdz7KkUBHhVkWU0aEjLfLk7epTqBkxzP5DtW4L0PS7AjxQfivPXkBL6
 Vihc8PpdRJvJatHuAiIul9u4br2IJ383cbT2+ePR+q0BF8sPTIeyHfTdqxZZFXEINm0YTZmOYBq
 yamxtqow/jpA0CdQ7dPkeDVEDWe5mpUyomoZkS8Cfmp4Ie/i+OeKt8GaU/0dHEwN9xBqwcU2VcD
 c38SnDkLGYsuH4rbk64gIvEqCGe/1cjaD/6ygcb04m7TGeDD2rr54DVlR47mlxuJficfNVK0qdH
 ft00GrKIOa989nJfyvvdRH++hCmdPN9iprdzCABOIeIqV2d0eucWYOtjOUI0DGuW5l4xkxXe9PM
 OKtrY9uMKwSsqkXdWHA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDAzMCBTYWx0ZWRfX0i6mDGTZkVt1
 Lk04o8apqM55OZRFpYpgvcOMwtMsYPsgSI0kWbpS2Ovc6nDGNBfAFq/u8ScE/ErJi6UfX2Rj4nM
 eNbkZokSIjWVdnGSIK/ZMttuLnkf2l0=
X-Proofpoint-GUID: YlB0-I2QJUynXNahgUD5XqWo2M9IYvhs
X-Authority-Analysis: v=2.4 cv=FLCOVOos c=1 sm=1 tr=0 ts=6ac89aeb cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=G-j9Ta9vk90QWaM03-wA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_02,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 clxscore=1015 bulkscore=0 spamscore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610090030
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

On 2026-10-08 17:44, Andrew Holden wrote:
> The KM instruction loop in cpacf_aes_ecb() updated the source pointer,
> destination pointer, and length registers only after the entire loop
> completed, using a 'done' accumulator. If a guest memory access fault
> fires mid-loop, siglongjmp unwinds the C stack before the register
> update is reached. The registers then reflect block 0 rather than the
> block being processed, causing the instruction to restart from the
> beginning on every fault. This results in quadratic reprocessing and
> violates the PoP requirement that registers reflect partial completion
> per block processed.
> 
> Fix this by updating the registers inside the loop body after each
> successfully processed block, and removing the 'done' accumulator.
> 
> Signed-off-by: Andrew Holden <andy0x48@linux.ibm.com>
> ---
>  target/s390x/tcg/cpacf_aes.c | 18 ++++++++----------
>  1 file changed, 8 insertions(+), 10 deletions(-)
> 
> diff --git a/target/s390x/tcg/cpacf_aes.c 
> b/target/s390x/tcg/cpacf_aes.c
> index 92884c4120..41ebc57087 100644
> --- a/target/s390x/tcg/cpacf_aes.c
> +++ b/target/s390x/tcg/cpacf_aes.c
> @@ -62,7 +62,7 @@ int cpacf_aes_ecb(CPUS390XState *env, const int
> mmu_idx, uintptr_t ra,
>  {
>      enum { MAX_BLOCKS_PER_RUN = 8192 / AES_BLOCK_SIZE };
>      uint8_t in[AES_BLOCK_SIZE], out[AES_BLOCK_SIZE];
> -    uint64_t len = *src_len_reg, done = 0;
> +    uint64_t len = *src_len_reg;
>      int i, keysize, addr_reg_size;
>      uint8_t key[32];
>      AES_KEY exkey;

Try to hold this bunch of variable declarations as a
"reverse Christmas tree". I am not sure if this is a strong
coding guideline for qemu but there are a lot of open source
projects insisting on this.

> @@ -116,23 +116,21 @@ int cpacf_aes_ecb(CPUS390XState *env, const int
> mmu_idx, uintptr_t ra,
> 
>      /* process up to MAX_BLOCKS_PER_RUN aes blocks */
>      for (i = 0; i < MAX_BLOCKS_PER_RUN && len >= AES_BLOCK_SIZE; i++) 
> {
> -        aes_read_block(env, mmu_idx, ra, *src_ptr_reg + done, in);
> +        aes_read_block(env, mmu_idx, ra, *src_ptr_reg, in);
>          if (mod) {
>              AES_decrypt(in, out, &exkey);
>          } else {
>              AES_encrypt(in, out, &exkey);
>          }
> -        aes_write_block(env, mmu_idx, ra, *dst_ptr_reg + done, out);
> +        aes_write_block(env, mmu_idx, ra, *dst_ptr_reg, out);

A comment here like
   /* update registers at end of each loop */
or so would be nice.

> +        *src_ptr_reg = deposit64(*src_ptr_reg, 0, addr_reg_size,
> +                                 *src_ptr_reg + AES_BLOCK_SIZE);
> +        *dst_ptr_reg = deposit64(*dst_ptr_reg, 0, addr_reg_size,
> +                                 *dst_ptr_reg + AES_BLOCK_SIZE);
> +        *src_len_reg -= AES_BLOCK_SIZE;
>          len -= AES_BLOCK_SIZE;
> -        done += AES_BLOCK_SIZE;
>      }
> 
> -    *src_ptr_reg = deposit64(*src_ptr_reg, 0, addr_reg_size,
> -                             *src_ptr_reg + done);
> -    *dst_ptr_reg = deposit64(*dst_ptr_reg, 0, addr_reg_size,
> -                             *dst_ptr_reg + done);
> -    *src_len_reg -= done;
> -
>      return !len ? 0 : 3;
>  }

Nice starting point.
Reviewed-by: Harald Freudenberger <freude@linux.ibm.com>

