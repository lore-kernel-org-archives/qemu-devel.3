Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03DCDC624D3
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 14:41:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1Pfv-0003pl-2Q; Tue, 01 Sep 2026 10:41:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x1Pfn-0003eu-C4
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 10:41:16 -0400
Received: from mail-yw1-x1134.google.com ([2607:f8b0:4864:20::1134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x1Pfl-00061n-NK
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 10:41:15 -0400
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-85aa9c1308dso48474467b3.3
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 07:41:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788273672; cv=none;
 d=google.com; s=arc-20260327;
 b=smD6CC+qd/qclVLD+aA/x2cGOLh6Sgqdp5b8tUxAdpgc9T5iNlvH7M5W+cl0tvb7HP
 DvZn5Ef9SqfGnDQIqVc5TVvisVOuFtXle7jVsxXupsIJohrISEoYNNbI62/OVzEwANBF
 QoMX7osApEcVkaxIX6Zv6GMhHFdBzFyDRP1TwpwG44kxuxfxA24We9Yw9MiyALXRAf9R
 nemfdJ/4pwho/wNpu877QJofsKUKS2wyUz1XidtuLVj4dpTuIZDCto9cS+vX45bOa4vt
 Sts02PABPQplllsvx44mx+Lg5+g7eY8dUqSjM25nnwXAoFTw4K41pG7V52bJoNB2v+yq
 fbJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Ss9lVa1WoFp5SLkXNTCKE7ZQJZkcyYo5+kKKXmMUTkM=;
 fh=vx6WqBV7ZkFr5+0c5croOznQhRJT596ekVEWV1sovE8=;
 b=OmrLt3YNAc50KfGR+ZEwcmyNqkagO+Dn87dB6ox0hR2aY1QE6quukClChceMbHBpcR
 n3gbI9EBgcbDHON/jZEhOqKp/vXnTO1UzjxyJ/tDPUcts+KO3U/2W8t6mhDiN3WHuQ2/
 c/nvSZEj9lgMx/DoASXXVT7DApyuDzBo9V8pylEmylr48VtKLNFt1ltUDuCOAiEzfgKZ
 +Xg1wdhclGS3SWmm9rxl+a/5MF3SB2Lxe1tbW5QxYdwxnVOsVY/DiVpgkFk9YlV/VJXk
 sqrnysGsY8zSF8ShHWSRpFtxCrP44bTs/Cgk/OkvPFuKNty1JM84javg0IpiKReFOpVR
 XuvA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788273672; x=1788878472; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Ss9lVa1WoFp5SLkXNTCKE7ZQJZkcyYo5+kKKXmMUTkM=;
 b=X4b3SGutYgN0aym2fMqlH8C7I0v1dl37gL/CTfn9Ld5BdpB0SaD//D54jebpWf2XU0
 w6CsA7USB+I/iuz2iQO7lJsNyhM5h4CB42TdhG/zKgI+dptAHCK3gJM3udog9ScDhNg7
 sBmaRyFG0p/4ybEhBuVf/S8DYd3ejHnTFrX3P+jPLPQy/UDpJny6HeG5/K8QkPNsyv2r
 EvvE+clBFkBsYvIzPijevOB8kLryiAecZgntuI8IjhqTOuj0E35FGvAA8heCPiJUAY8n
 h1zIa8ugG4q0szJeHE4pPCZovmVaIDBosPPS2UXfYlfNVxAob//DNeiNSMlQNhwl0t8G
 31dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788273672; x=1788878472;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Ss9lVa1WoFp5SLkXNTCKE7ZQJZkcyYo5+kKKXmMUTkM=;
 b=NL7IGraVhIgB176yZvG75QIdgoywBaOLvz9CYs09q4wMPpc5auBIODOrrDi3szrElB
 dMCoKq/O5omlb8IAW+OjUMBCezHqwhhVh6o5tblR0nEYu6TeDnaNmh1qYzEBk1dU4Ls4
 ewXqujgDPUNFMAcl6vwqciIa9UoWAWBF7Rb4fIxvAkv3PEEv1cUD9cOxFl/THFIxH8Y5
 skdLujN5JDa09mZmxz1+Cd3uvj25+0QoVaYhxCv4knvM7rnfG4vghg/psVSzx92oaquE
 UbpUEqk1bfmTGZ2cOnqG22IysUQoHdK2F8kIGuxtZ9F4Gegq1wnpe4tWEdKuz9b6UDCa
 vi/w==
X-Gm-Message-State: AFuF++kr8yLimSeOJWR2BLroFPOna06GpwSukq627sYoFI2EK5Ig4zy4
 W9ZnHkpcTgAesWFklakhlSUHJu4WfgTrHFa6ZI2IzRhte1FCwnAbmVGQM86LrGWoPSgVn3TXVm0
 i5j6atQJDsZefR6WneksZwc+tAKgDWuhx9K4gJ0fMtQ==
X-Gm-Gg: AYBFou2IBNpEQDqm4QNwVJ87WgxTrk1IAbnhhfar6YfL1HXeBNsCPnbT1pLQLrKwctz
 KKBAb1KvmQvQZxrq6/NmHeagf8yws+XfCBN4WohCBPbjz3Nk/kqasOLG/spDIHbAOvpQUBkOPtF
 0yx8+yOKx5u6RGT8l5EWVLf/wVm6rQYHEljmlVK9zohTIdWJqMgD86EgIr50yJXzh8/y2KOcdhC
 jgI4Z4JHfdc3yiDI8IQijtBJBKMXIKPy2lAJzn1kLct+K8f3j5UDD+lS2WMvO4x4VXB0a5RC6oI
 IVUfFKOV2I+N72+M3zJ69aJqvSa+24S+6IM/U1+mOZcOkoNQnmq0cDpH8PIRtowIEc9Rd/Z6KTL
 UUDZrxhAYD3oTm1j0dAXuMJRNP24F
X-Received: by 2002:a05:690c:4017:b0:859:9c98:b8b4 with SMTP id
 00721157ae682-86875b7b5a6mr39126547b3.31.1788273672159; Tue, 01 Sep 2026
 07:41:12 -0700 (PDT)
MIME-Version: 1.0
References: <20260815203730.1468365-1-richard.henderson@linaro.org>
 <20260815203730.1468365-5-richard.henderson@linaro.org>
In-Reply-To: <20260815203730.1468365-5-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 1 Sep 2026 15:41:00 +0100
X-Gm-Features: AcwNN1UJKfZbjKh2bd_FuMYds1GxfgSxuJBFRTy6fyi2zfdUtM1DbjjX0Ul-b4I
Message-ID: <CAFEAcA90XrBA4EzTY_jQd0MtyXSpFn7tGy-jvRDwAe=HHmgdjg@mail.gmail.com>
Subject: Re: [RFC PATCH 04/18] target/arm: Generalize probe argument to
 allocation_tag_mem_internal
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-riscv@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1134;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1134.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Sat, 15 Aug 2026 at 21:39, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> We had a confusing relationship between 'probe' and 'ra == 0'.
> Make this explicit via an enumeration.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/mte_helper.c | 130 ++++++++++++++++++++++--------------
>  1 file changed, 80 insertions(+), 50 deletions(-)
>
> diff --git a/target/arm/tcg/mte_helper.c b/target/arm/tcg/mte_helper.c
> index dd4c10ef4f..31bf58c937 100644
> --- a/target/arm/tcg/mte_helper.c
> +++ b/target/arm/tcg/mte_helper.c
> @@ -87,28 +87,48 @@ typedef struct AllocationTagMem {
>      MemTxAttrs attrs;
>  } AllocationTagMem;
>
> +typedef enum {
> +    /* Trap on missing pages, invalid tag access, or watchpoints. */
> +    ATM_NORMAL,
> +    /* Gracefully return no tag memory for invalid pages. */
> +    ATM_PROBE_PAGES,
> +    /*
> +     * Basic page access has already been checked,
> +     * so a missing tlb entry is some sort of bug.
> +     * Assert the tlb entry is present, but gracefully fail if tag
> +     * access is not permitted to the page.
> +     */
> +    ATM_ASSERT_PAGES,
> +} AllocationTagMemKind;
> +
>  static AllocationTagMem
>  allocation_tag_mem_internal(CPUARMState *env, int ptr_mmu_idx,
>                              vaddr ptr, MMUAccessType ptr_access,
>                              int ptr_size, MMUAccessType tag_access,
> -                            bool probe, uintptr_t ra)
> +                            uintptr_t ra, AllocationTagMemKind atm_kind)

I think we generally prefer to make 'uintptr_t ra' the final argument
to a function call (though we don't 100% follow that convention).

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

