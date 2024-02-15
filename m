Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0179EC48BC4
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 16:12:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raeKt-0006pP-LG; Thu, 15 Feb 2024 11:11:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1raeKr-0006oQ-Q2
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 11:11:41 -0500
Received: from mail-lf1-x131.google.com ([2a00:1450:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1raeKp-0004LE-TK
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 11:11:41 -0500
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-511ac701428so1200913e87.2
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 08:11:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708013498; x=1708618298; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5Fn5ZQ9hR3dFuJ1cIpjAX6afBOd6OOkdtrAk/5JKrWU=;
 b=SZtyCkFcvZXsI97JwWoe5fYK3XgbdxnXHpNiYPUK1N8vYiJf/ieR+v9jcOK/o7XDb/
 uzsACTTvurvzdwDU8PUenBu0ysmaYXDrU2uLCpXzfh1MYZkC4AgoMTgJj/SYtC1xBx1k
 EG3V5eD61ufzpXdyr0j7+jALL0n5VJLAAkE/lTSBzSMYBktDGV0pCxLp5Ei8+EKIkiSO
 mahX0vuba4YSaXfW13KRzAPxgGUVJPhhnIFMNOiIUGp6lALk1vPCqhWnl1voZF8ghaaW
 ZMwG2+qylrEUasj+10VplKjWv0xvxN2IQ4KljJMp9g6vjo9yhVLj/Vs7X1EIIg3BTRk1
 F+6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708013498; x=1708618298;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5Fn5ZQ9hR3dFuJ1cIpjAX6afBOd6OOkdtrAk/5JKrWU=;
 b=TxnBjhv4ZLKBHw1jYSAloVSPixW2kfVn+fgmFK4WpkvNxYCEiFCye+AFzHyOYhInDx
 NNRyyYkOtHOB0OHwUY+o3ghAqR8aktXz/G2O0kXHNJPjvxfvOl60fNyPd41vDS8vBh7I
 6WJIh8BGPjvM5peNGgiJ0hdn+hrxWwnyTeE5/vk6UHMHtI171wQTNzXaLZ8GcJ0MnA1x
 i4C2YvigyuZ5ctB+Yx6KLMaDVoRCAj34dsFe3W+3ivZbUrrxb+UkM9NetfFiVyomJJVo
 PdCAphfqdz6re80d/zKjhaPYoPb32tw/fPyTOAnCWF01ietcxQx+sFrNxElouNEI5jgb
 kSkA==
X-Gm-Message-State: AOJu0YzpN+pqBweDJH6AJzqGPNXaH3pqFDo0TK0qt6apoBBibEtOMU8l
 VVOEJ5V6jC3+8xELeeKbYUl7kCcrifaVzuCTNXO04QcxJ4121l7z+oF/Pmgsb0uQ+XISDp3Gdbr
 mVDnmjANVNIDm7ZFOYevxVav1U6oI+vljQmT/+Q==
X-Google-Smtp-Source: AGHT+IERr5I7htGEr8UA+gNpG/sTntWC/BQBg8IPHN9wPHsWxZlTST5LEK+8EVHLVOydJ68IJXjdhTnh+DIPcb/nmdY=
X-Received: by 2002:a19:7618:0:b0:512:44c9:fb76 with SMTP id
 c24-20020a197618000000b0051244c9fb76mr1394958lff.22.1708013497871; Thu, 15
 Feb 2024 08:11:37 -0800 (PST)
MIME-Version: 1.0
References: <20240215150133.2088-1-Jonathan.Cameron@huawei.com>
 <20240215150133.2088-4-Jonathan.Cameron@huawei.com>
In-Reply-To: <20240215150133.2088-4-Jonathan.Cameron@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 15 Feb 2024 16:11:26 +0000
Message-ID: <CAFEAcA-rHZe2xF9anKxYFm0zHYc6gV=g9JiXxeZ4E_LoQ7DhSA@mail.gmail.com>
Subject: Re: [PATCH 3/3] tcg: Avoid double lock if page tables happen to be in
 mmio memory.
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: qemu-devel@nongnu.org, Gregory Price <gregory.price@memverge.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Sajjan Rao <sajjanr@gmail.com>,
 Dimitrios Palyvos <dimitrios.palyvos@zptcorp.com>, 
 richard.henderson@linaro.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, linux-cxl@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::131;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x131.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Thu, 15 Feb 2024 at 15:03, Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On i386, after fixing the page walking code to work with pages in
> MMIO memory (specifically CXL emulated interleaved memory),
> a crash was seen in an interrupt handling path.
>
> Useful part of bt

Did you intend to put in a backtrace here?

>
> Peter identified this as being due to the BQL already being
> held when the page table walker encounters MMIO memory and attempts
> to take the lock again.  There are other examples of similar paths
> TCG, so this follows the approach taken in those of simply checking
> if the lock is already held and if it is, don't take it again.
>
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  accel/tcg/cputlb.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index 047cd2cc0a..3b8d178707 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -2019,6 +2019,7 @@ static uint64_t do_ld_mmio_beN(CPUState *cpu, CPUTLBEntryFull *full,
>                                 int mmu_idx, MMUAccessType type, uintptr_t ra)
>  {
>      MemoryRegionSection *section;
> +    bool locked = bql_locked();
>      MemoryRegion *mr;
>      hwaddr mr_offset;
>      MemTxAttrs attrs;
> @@ -2030,10 +2031,14 @@ static uint64_t do_ld_mmio_beN(CPUState *cpu, CPUTLBEntryFull *full,
>      section = io_prepare(&mr_offset, cpu, full->xlat_section, attrs, addr, ra);
>      mr = section->mr;
>
> -    bql_lock();
> +    if (!locked) {
> +        bql_lock();
> +    }
>      ret = int_ld_mmio_beN(cpu, full, ret_be, addr, size, mmu_idx,
>                            type, ra, mr, mr_offset);
> -    bql_unlock();
> +    if (!locked) {
> +        bql_unlock();
> +    }
>
>      return ret;
>  }

Can we do this consistently across all four functions
do_ld_mmio_beN, do_ld16_mmio_beN, do_st_mmio_leN,
do_st16_mmio_leN, please ? It happens that your workload
only needs to do an 8-byte load but conceptually the same
thing applies in all these cases.

thanks
-- PMM

