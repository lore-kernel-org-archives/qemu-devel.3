Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 502EDCF887C
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2024 21:02:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxurG-0006qu-KD; Mon, 07 Oct 2024 17:01:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>)
 id 1sxurB-0006qR-R5; Mon, 07 Oct 2024 17:01:31 -0400
Received: from mout.gmx.net ([212.227.17.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>)
 id 1sxur9-000758-Qe; Mon, 07 Oct 2024 17:01:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1728334885; x=1728939685; i=deller@gmx.de;
 bh=gbXUcqECTYm5JGx/YDix/NjPhsYJDm4Zi1/kMrB6RKo=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=uZsHQ5vaa5X/+3+2tBA61/UEYqG6ZtO/Xmr55dX3vbBZsqYqhDwaPoTzFFk7VIG4
 GJNkDyZbNljc7US10qvCoDYsv2WQRsWnOef9Scs3rfm7ah6WBEW+f3Dvwl8GcaIm/
 HxVnjspcb6B6DDic5y+xXVoSgK4T8LxTtEmmE7cJaI8mE9c0scrCRChFoK9SmFPEZ
 XhgnBkZLkTtjErnfE1sZ5+dkkB01zjXWbWzEMiiQtVl2riCLQjYxaoNdw9Ho5sTbE
 X1ggj9l29A1UdUbP3+fcVO4zZFCS3iVnsKsx4HWWxK6pG2KidPhECOhRdCwvLm85i
 ekHxSXFdn98nJwkzSA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([109.250.63.79]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1McY8T-1tYcBd3N9R-00gYvN; Mon, 07
 Oct 2024 23:01:24 +0200
Message-ID: <c9bf746f-d4db-43f4-a7ad-628ffd9669f6@gmx.de>
Date: Mon, 7 Oct 2024 23:01:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/21] accel/tcg: Expand tlb_fill for 3 callers
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: deller@kernel.org, peter.maydell@linaro.org, alex.bennee@linaro.org,
 linux-parisc@vger.kernel.org, qemu-arm@nongnu.org
References: <20241005200600.493604-1-richard.henderson@linaro.org>
 <20241005200600.493604-3-richard.henderson@linaro.org>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20241005200600.493604-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vKbC5LAECUGMqJYj4QMon4AgKT61oeyNhmHaMGxAH+o2IuMC5of
 XNekivMRP8fTlKGXb2ZuvLgrF7pkczrV5rtDHKWQBIDYl2EheijpmTNqArL8Tqasp7OVgbw
 D/GKqrzHjK7VWDNgz6QmIyVXc2Lmg4ONA4k3Cwd1St05eSUifxG32mnEf2NnoF7jV4E8Nd1
 s93HNAF991YWBKQufevRw==
UI-OutboundReport: notjunk:1;M01:P0:muAlPIwNScU=;uEARVxfZKLW/cnaDVIB9m95DdN7
 yNcN0sUP4AHSZC8eTmdX/9HzBLtJWPoL6lvRtuUCColXZrtMfBAkVEyjPYsJyB+Uqc+DwniC1
 /XUE8jrkSw/h6K11u0ERWfUI5RgKjRjiX/zg/7mlG2289VHtlEeG+1wIWx5qo55PIarjs6D5p
 M2vPWG2NTz/BVKP3mcmnAiHE9iBnfrYgeeadMfWoHSW0pFFTxLfz5bSbgMytau/KlEXqz+2H8
 2mzo4t47oUBcO7IEkCymGm+g3MKIuGSlgM51sfCZYAAFgadLujeOZbbVHgVmeiIMZPgPjsw1v
 sDR/RYjSTIFyh8lT3fBQ4Ub5gKPJjpne4Y3b2NxaTpzXk1qRJP7Dy8j2XecDoGwxTQG12VVER
 Sd1q1IAlWeT2C5ZPt3WCfgfuOtOkrePY0iyMbl0eD++JX3N173icscFyJpkVFsv+isIxO4DjE
 da0lR0g6f916AIpcGW1/vlrbXQuJDGpHKho1W4YujWNgCYSc74tudplJVyBPFw3QsLUg5d0AV
 ZuEcPg8KKeDe6//N/m4MZ3yFU9lVhgZTUmxTSL8KsrV4MHRDggR0cOzu8/xOQnior5+olZaKx
 KweGTPJwzYwuvcgFQC2v4TpSqoUtbxHjECSU1eRrSFk8s8budnXn6MnYI7XxOauSIMRiGHJsp
 G/RgoT1u+JJ7fbDM2LSHPqPLPvXVF/538P+gG1G/4we+amtUqmQJ43/9oKwmypJNLsTiY2O8M
 rAyUcz3pkcAWMg+b3H8AkAI0nwB/SQFVWkk0h9WY9ComqKJBIq235gH5ntZkECGir4pAhdaIj
 4eH7TEXgeESZONkGCkL1qIpg==
Received-SPF: pass client-ip=212.227.17.21; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 10/5/24 22:05, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>


Reviewed-by: Helge Deller <deller@gmx.de>

> ---
>   accel/tcg/cputlb.c | 33 ++++++++++-----------------------
>   1 file changed, 10 insertions(+), 23 deletions(-)
>
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index fd6459b695..58960969f4 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -1220,25 +1220,6 @@ void tlb_set_page(CPUState *cpu, vaddr addr,
>                               prot, mmu_idx, size);
>   }
>
> -/*
> - * Note: tlb_fill() can trigger a resize of the TLB. This means that al=
l of the
> - * caller's prior references to the TLB table (e.g. CPUTLBEntry pointer=
s) must
> - * be discarded and looked up again (e.g. via tlb_entry()).
> - */
> -static void tlb_fill(CPUState *cpu, vaddr addr, int size,
> -                     MMUAccessType access_type, int mmu_idx, uintptr_t =
retaddr)
> -{
> -    bool ok;
> -
> -    /*
> -     * This is not a probe, so only valid return is success; failure
> -     * should result in exception + longjmp to the cpu loop.
> -     */
> -    ok =3D cpu->cc->tcg_ops->tlb_fill(cpu, addr, size,
> -                                    access_type, mmu_idx, false, retadd=
r);
> -    assert(ok);
> -}
> -
>   static inline void cpu_unaligned_access(CPUState *cpu, vaddr addr,
>                                           MMUAccessType access_type,
>                                           int mmu_idx, uintptr_t retaddr=
)
> @@ -1631,7 +1612,10 @@ static bool mmu_lookup1(CPUState *cpu, MMULookupP=
ageData *data,
>       if (!tlb_hit(tlb_addr, addr)) {
>           if (!victim_tlb_hit(cpu, mmu_idx, index, access_type,
>                               addr & TARGET_PAGE_MASK)) {
> -            tlb_fill(cpu, addr, data->size, access_type, mmu_idx, ra);
> +            bool ok =3D cpu->cc->tcg_ops->tlb_fill(cpu, addr, data->siz=
e,
> +                                                 access_type, mmu_idx,
> +                                                 false, ra);
> +            assert(ok);
>               maybe_resized =3D true;
>               index =3D tlb_index(cpu, mmu_idx, addr);
>               entry =3D tlb_entry(cpu, mmu_idx, addr);
> @@ -1833,8 +1817,10 @@ static void *atomic_mmu_lookup(CPUState *cpu, vad=
dr addr, MemOpIdx oi,
>       if (!tlb_hit(tlb_addr, addr)) {
>           if (!victim_tlb_hit(cpu, mmu_idx, index, MMU_DATA_STORE,
>                               addr & TARGET_PAGE_MASK)) {
> -            tlb_fill(cpu, addr, size,
> -                     MMU_DATA_STORE, mmu_idx, retaddr);
> +            bool ok =3D cpu->cc->tcg_ops->tlb_fill(cpu, addr, size,
> +                                                 MMU_DATA_STORE, mmu_id=
x,
> +                                                 false, retaddr);
> +            assert(ok);
>               index =3D tlb_index(cpu, mmu_idx, addr);
>               tlbe =3D tlb_entry(cpu, mmu_idx, addr);
>           }
> @@ -1848,7 +1834,8 @@ static void *atomic_mmu_lookup(CPUState *cpu, vadd=
r addr, MemOpIdx oi,
>        * but addr_read will only be -1 if PAGE_READ was unset.
>        */
>       if (unlikely(tlbe->addr_read =3D=3D -1)) {
> -        tlb_fill(cpu, addr, size, MMU_DATA_LOAD, mmu_idx, retaddr);
> +        cpu->cc->tcg_ops->tlb_fill(cpu, addr, size, MMU_DATA_LOAD,
> +                                   mmu_idx, false, retaddr);
>           /*
>            * Since we don't support reads and writes to different
>            * addresses, and we do have the proper page loaded for


