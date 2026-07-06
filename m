Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 079FCC43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 16:59:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgmf2-0002As-CV; Mon, 06 Jul 2026 12:59:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1wgmer-0002A5-D5; Mon, 06 Jul 2026 12:59:02 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1wgmep-0003uZ-4z; Mon, 06 Jul 2026 12:59:00 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 666FIKEl4049958; Mon, 6 Jul 2026 16:58:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=FU47t6
 qHFKE7f5sjxdUD9NOkHhMxqMmv/RJZv2Wiml0=; b=rWQSuTEZJwigXxfsWW1sdq
 K0Y9vWjyJ35aP+7qFHe8CV3+bEjapUCsscka3A2j0M5PkvYyogJhIxNDEdNtbR2h
 FeHUmrdZoPQViQAJUY/yDr+wyXAboGykMAceNq9Tq996rarlS5VRKrYcSe3tNc5g
 ZL6kafNlBAK6v4iPuTszhzcQY//HQdvsv2vHtoj7cKICDntThHYfzwqAPmEnCFct
 AFg3exlpdSoWhWW/Pv135zKujBOnX7V7qDJzypTrWmQqYSJkhKQVwfBlhC05CP4q
 Azc/x5KgbUEmNcKPZEXaB2YXDAjT6+c+HPd4MXZCOUQEz6UTIUizl1qjfFIrV8Kw
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6stsk0xd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 06 Jul 2026 16:58:55 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 666Gnn36027017;
 Mon, 6 Jul 2026 16:58:54 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7eqfx7pw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 06 Jul 2026 16:58:54 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 666GwqYp51577188
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 6 Jul 2026 16:58:52 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 77A0920043;
 Mon,  6 Jul 2026 16:58:52 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 25B0C20040;
 Mon,  6 Jul 2026 16:58:52 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.111.23.52])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  6 Jul 2026 16:58:52 +0000 (GMT)
Message-ID: <5bed6bb7-0648-40a0-8afc-7360bc662e01@linux.ibm.com>
Date: Mon, 6 Jul 2026 18:58:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] accel/tcg: Make PageFlagsNodes' start and last
 immutable
To: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Alex Crichton <alex@alexcrichton.com>,
 Ulrich Weigand <ulrich.weigand@de.ibm.com>, qemu-stable@nongnu.org
References: <20260706165445.57418-1-iii@linux.ibm.com>
 <20260706165445.57418-2-iii@linux.ibm.com>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <20260706165445.57418-2-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: _nZ_URZzVssv5B19yy22GajMBChaQH_4
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDE3MCBTYWx0ZWRfXzC1pl+AnWR7j
 a3tlHHoZa4g+HSC99+gu84t94P6aVFN5n6Rf6dDGdrcUx2NngnYbVsJN395kfuiv5F4MmUCOXbR
 q62vSP3Qj8tQRqFGzvnPaOEQ/M/VmrE=
X-Authority-Analysis: v=2.4 cv=DKW/JSNb c=1 sm=1 tr=0 ts=6a4bdecf cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=NEAV23lmAAAA:8
 a=VnNF1IyMAAAA:8 a=vjliLWF1AAAA:8 a=69wJf7TsAAAA:8 a=-4y--ymCcz8KILmWNH4A:9
 a=QEXdDO2ut3YA:10 a=3erKlr7R_9HjozMBkBTY:22 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-GUID: _nZ_URZzVssv5B19yy22GajMBChaQH_4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDE3MCBTYWx0ZWRfXxxfUcX7XHD0f
 t7oBNIF3EhNXfYftmIORaDEY9RIvKxMpdrp5w+ofDq9WGkGeYGaqDRgPeF2/d5mNrdZxCCGL11l
 THtht2jd9MjLmza6+lIH9LJMa54u+v1DL0iWIGoAFjeODy1Nst8GppbaMfbk2nqn91EJ8TDMX5s
 W3FgQpzDCOD+f63qpaIxf3vU+xOKRQtc1BTl0xKYcZIygCPJE+SR8rHwBJY/zak8lvnUEu7yX3r
 gRKC/yp00eElxT5duz4oOLnUXX+6zIahOUldBP/jTj5MfJrkwEPenhE5vzi2+PqU/D/hCRZZtvp
 042LBMHrM/3TLDzD3amMLqBLs94oHLHEe+bnE9UbuLP+FW1QbpUFwWdKoByrV9lDkqol1uyGhaS
 VNcj+ZGsZS2uNUi6J7VJx8aLjcEilk2nz0zZl8DawZ1hNcC5n/NNOMdgNNO5X35RUg801ZMhaLx
 1aafVnPzVl9Tsm47New==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_02,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1015 phishscore=0 impostorscore=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607060170
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 7/6/26 18:51, Ilya Leoshkevich wrote:
> page_check_range() may race with pageflags_set_clear() as follows:
> 
>      T1                                     T2
>      -------------------------------------  --------------------------------
>                                             p = pageflags_find(start, last);
>      interval_tree_remove(&p->itree, ...);
>      p->itree.start = last + 1;
>                                             if (start < p->itree.start) {
>                                                 ret = false;
>      interval_tree_insert(&p->itree, ...);
> 
> leading to errors like
> 
>      fail indirect write 0x72f0a659aff0 (Bad address)
> 
> in vma-pthread test. I am able to reliably reproduce this on a machine
> with 32 SMT threads as follows in about 25 seconds:
> 
>      jobs=32; \
>      seq "$jobs" | \
>          time -p parallel \
>              --jobs="$jobs" \
>              --halt=now,done=1 \
>              --ungroup \
>              '
>                  _={};
>                  while ./qemu-s390x tests/tcg/s390x-linux-user/vma-pthread; do
>                      printf .;
>                  done
>              '
> 
> Also wasmtime project reported a similar failure pattern in their CI [1]
> with a similar reproducer [2].
> 
> There are other races like this. In general, region bounds mutating
> underneath the reader are very hard to reason about. So fix this by
> preventing mutations and creating copies instead. Use RCU guards in
> readers to avoid uses-after-frees.
> 
> Now, when the reader finds a node, it may fearlessly access its fields
> and be certain that at some point in time the respective region had the
> respective bounds and permissions. The downside is slightly more
> expensive mprotect(), but complexity reduction is worth it.
> 
> Lockless field accesses should probably be wrapped in qatomic_read(),
> but this is a pre-existing issue, so do not change it here.
> 
> [1] https://github.com/bytecodealliance/wasmtime/issues/10000
> [2] https://gist.github.com/alexcrichton/f14f23a892ffb9df2522754572d51b1c
> 
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>   accel/tcg/user-exec.c | 37 +++++++++++++++++++++----------------
>   1 file changed, 21 insertions(+), 16 deletions(-)
> 
> diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
> index 7704e4017dd..55761cacf65 100644
> --- a/accel/tcg/user-exec.c
> +++ b/accel/tcg/user-exec.c
> @@ -239,13 +239,16 @@ void page_dump(FILE *f)
>   
>   int page_get_flags(vaddr address)
>   {
> -    PageFlagsNode *p = pageflags_find(address, address);
> +    PageFlagsNode *p;
> +
> +    RCU_READ_LOCK_GUARD();
>   
>       /*
>        * See util/interval-tree.c re lockless lookups: no false positives but
>        * there are false negatives.  If we find nothing, retry with the mmap
>        * lock acquired.
>        */
> +    p = pageflags_find(address, address);
>       if (p) {
>           return p->flags;
>       }
> @@ -301,15 +304,15 @@ static void pageflags_create_merge(vaddr start, vaddr last, int flags)
>   
>       if (prev) {
>           if (next) {
> -            prev->itree.last = next->itree.last;
> +            pageflags_create(prev->itree.start, next->itree.last, flags);
>               g_free_rcu(next, rcu);
>           } else {
> -            prev->itree.last = last;
> +            pageflags_create(prev->itree.start, last, flags);
>           }
> -        interval_tree_insert(&prev->itree, &pageflags_root);
> +        g_free_rcu(prev, rcu);
>       } else if (next) {
> -        next->itree.start = start;
> -        interval_tree_insert(&next->itree, &pageflags_root);
> +        pageflags_create(start, next->itree.last, flags);
> +        g_free_rcu(next, rcu);
>       } else {
>           pageflags_create(start, last, flags);
>       }
> @@ -371,8 +374,8 @@ static bool pageflags_set_clear(vaddr start, vaddr last,
>       if (set_flags != merge_flags) {
>           if (p_start < start) {
>               interval_tree_remove(&p->itree, &pageflags_root);
> -            p->itree.last = start - 1;
> -            interval_tree_insert(&p->itree, &pageflags_root);
> +            pageflags_create(p_start, start - 1, p_flags);
> +            g_free_rcu(p, rcu);
>   
>               if (last < p_last) {
>                   if (merge_flags & PAGE_VALID) {
> @@ -394,11 +397,11 @@ static bool pageflags_set_clear(vaddr start, vaddr last,
>               }
>               if (last < p_last) {
>                   interval_tree_remove(&p->itree, &pageflags_root);
> -                p->itree.start = last + 1;
> -                interval_tree_insert(&p->itree, &pageflags_root);
> +                pageflags_create(last + 1, p_last, p_flags);
>                   if (merge_flags & PAGE_VALID) {
>                       pageflags_create(start, last, merge_flags);
>                   }
> +                g_free_rcu(p, rcu);
>               } else {
>                   if (merge_flags & PAGE_VALID) {
>                       p->flags = merge_flags;
> @@ -419,8 +422,8 @@ static bool pageflags_set_clear(vaddr start, vaddr last,
>       if (set_flags == p_flags) {
>           if (start < p_start) {
>               interval_tree_remove(&p->itree, &pageflags_root);
> -            p->itree.start = start;
> -            interval_tree_insert(&p->itree, &pageflags_root);
> +            pageflags_create(start, p_last, p_flags);
> +            g_free_rcu(p, rcu);
>           }
>           if (p_last < last) {
>               start = p_last + 1;
> @@ -432,8 +435,8 @@ static bool pageflags_set_clear(vaddr start, vaddr last,
>       /* Maybe split out head and/or tail ranges with the original flags. */
>       interval_tree_remove(&p->itree, &pageflags_root);
>       if (p_start < start) {
> -        p->itree.last = start - 1;
> -        interval_tree_insert(&p->itree, &pageflags_root);
> +        pageflags_create(p_start, start - 1, p_flags);
> +        g_free_rcu(p, rcu);
>   
>           if (p_last < last) {
>               goto restart;
> @@ -442,8 +445,8 @@ static bool pageflags_set_clear(vaddr start, vaddr last,
>               pageflags_create(last + 1, p_last, p_flags);
>           }
>       } else if (last < p_last) {
> -        p->itree.start = last + 1;
> -        interval_tree_insert(&p->itree, &pageflags_root);
> +        pageflags_create(last + 1, p_last, p_flags);
> +        g_free_rcu(p, rcu);
>       } else {
>           g_free_rcu(p, rcu);
>           goto restart;
> @@ -505,6 +508,8 @@ bool page_check_range(vaddr start, vaddr len, int flags)
>           return false; /* wrap around */
>       }
>   
> +    RCU_READ_LOCK_GUARD();
> +
>       locked = have_mmap_lock();
>       while (true) {
>           PageFlagsNode *p = pageflags_find(start, last);

Sorry, I forgot to include the tags:

Reported-by: Alex Crichton <alex@alexcrichton.com>
Reported-by: Ulrich Weigand <ulrich.weigand@de.ibm.com>
Fixes: 67ff2186b0a4 ("accel/tcg: Use interval tree for user-only page 
tracking")
Cc: qemu-stable@nongnu.org


