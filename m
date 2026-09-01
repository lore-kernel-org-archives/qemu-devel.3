Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8315BC624D5
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 15:33:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1QU3-0000VP-Qc; Tue, 01 Sep 2026 11:33:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x1QU0-0000UI-12
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 11:33:08 -0400
Received: from mail-yw1-x112d.google.com ([2607:f8b0:4864:20::112d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x1QTx-0002hL-On
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 11:33:07 -0400
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-864cd11a932so14459927b3.0
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 08:33:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788276784; cv=none;
 d=google.com; s=arc-20260327;
 b=VRIN1EYyVm1t7bN9Nl39xzG2rmXvqJ5BZMODL5tuY5n85xY1hMFe16dEr37y4wQc93
 rjGRPNZ/aAY/9N6SGQrzSfkxb1JK/O1BpgX/9dh6KBwjkD9TdivGHXprg/vLT8f2kMUA
 7S4DBKRb6ztftlfKiUV+wGF+/bWtCa1Bqym27PthaRvMkXZm/R1p/z97SfQ6jmxc9KLI
 IcHArS0ujWDpEkTKRushsYav/9nIqm8wUiQJ5WTqyMWsK7TZLr65xH9GUccI5J4EZBaM
 gTe0vS75VKGtPjg1m38KyNxcRRwDTrVKBrg/C4d6nugaa24QDrVdVBaupT+wNnELCTHW
 6Q2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=TfsYZWGUp3JEz46SYJF6kaNN+w8kJcJepqqETpNYZOw=;
 fh=vx6WqBV7ZkFr5+0c5croOznQhRJT596ekVEWV1sovE8=;
 b=Zzz1Ypqug4DCi5zbY+SztqM01J2mOsFPW3DPBSgLBvZxvSbzqzVGYFhB8WmPRPW4iw
 +imUW8lKVpDYKsuL1HuTFMBPOs3mNX+5M8fuHDWqy/l4wgr0rJu1756rmO6G/B34kQx9
 6iQhA7mM1yyCd1cjW3v9bc0euMsE5G8iFO+91WvMc81jP7ZVuR8BY7DhtO6frKG/FHR1
 EEmMfwXc44BQww2cHDuGmLdpo4TOqcBylXJNvW6Iqq6mnRleICMcfB4CFwws+egYdGMn
 tWxb/QXmk2ze3qyufJUJp+2RlP4bhzEUrDoVFcYbBVANbckuSkFJ3kQwp+oL67deQcm6
 4AzQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788276784; x=1788881584; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=TfsYZWGUp3JEz46SYJF6kaNN+w8kJcJepqqETpNYZOw=;
 b=GIgNi2qjpdKeeKU/zUTyG8MGQB+b/f/kF1xnUD7B19vRw3vw67eea1Nayb3gnAMM8c
 OT9RgnLuFHUz6Vkqe2hbnGTnSy6sB+KchPW7pkpRkjtfDiFI0ifDiBqnBGenyKGKVCgK
 opFss+hmEEJTSMxuDAllSqt766Hc0u5VjtG0cTf0n/qwTk3v4XhhU9m/KfzU4QujvlWL
 i4FD11eMiM8A/iUFTf4BiqWLGoSnvNl4vEGxaeB1tPnKjFZGztX+vUN28/LzAocYsib2
 LQC6tHtcqJJmK30H691PcxQHhIxkXwnKH7dOyIK/0QEu0p9FmukyiBrtxfhHvaoiAebl
 M/Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788276784; x=1788881584;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=TfsYZWGUp3JEz46SYJF6kaNN+w8kJcJepqqETpNYZOw=;
 b=CCyhCGedGoiygtXyXA6L0q7/lT3pzXp0JCxRxjRjYf7yZo0/y63kh5sY/vZA1/xiY3
 Np0nvDnAYE5F1zeQoVegR6/BefvJ8r/PucerVaYdnJrvIXFb8FYw053llMMpp1jjpsjE
 xLNTrn4SaUyGTY3XIrRsUpzVDxkTqXJd3d++FkDuPlqHHfxAcbuP8pUNDxQZ6wvQ6kEv
 8inbw6aHT/rtbBYAppZCbl9CZbTOn+1bhDgbnstdOiQxGnQdrZAOvhaVr1rdS7M/jNkd
 J9xDZqSbajMlvzt19CjATYg+TyfoeZjAkX04/3EkitYa583r95G+8eRWGa6I4hOrrRwy
 0MsA==
X-Gm-Message-State: AFuF++llKfk2RKYThzB+KUAULTymoAAX9QvbeGkRgzfCfSjLRX3v+Agm
 PN80AUTN7DYgNC9yfhXGUbEW5a/ISJxv6dyEdtEPCBLNOewBe2sx+zoWit9QjD2Xn5Byl0gODW4
 abYQK29vRGnTczErDi9lB8kgu49K2fO09uwzNLfA1lQ==
X-Gm-Gg: AYBFou1JdXl2xyw5fIy5pTATJHckSFV2MPUiPCz9eN0awyUEDekz+lUBNINqREtMgVp
 nCnT5hfKuppi1+h3u8M8euUS3EfUB4tNlfvwv5oXJuCuRRzud4H95Tg1GqrsCiZ/kwyuzBZbQmV
 41YO196Vkkh+Yk90E4C8/IlqZWsbXqzy2GZU1hxpiLkNKM0AG200cCJcDWOk3zk3U1yA4QPNo11
 QHRFULZAEcJsG4wmX0qg+IA3BV/VYVyGJZ8HOlJdTkoAXUbZj4ePIKchkr2lwcnB6T1NyVvnd85
 CGbLr2GQx20KHoM/f6XIuaxsmtVf8FVD53VGf6N+Pg+E6YWEH0+o3Fooadjna8Aggge0M5GFCCi
 zIZyKaF8KIaFq+O+t5Cic+uXhDHb+QKkkt91eSho=
X-Received: by 2002:a05:690c:6612:b0:82d:8dc0:9cf with SMTP id
 00721157ae682-8694d8b47dfmr27793407b3.13.1788276784411; Tue, 01 Sep 2026
 08:33:04 -0700 (PDT)
MIME-Version: 1.0
References: <20260815203730.1468365-1-richard.henderson@linaro.org>
 <20260815203730.1468365-12-richard.henderson@linaro.org>
In-Reply-To: <20260815203730.1468365-12-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 1 Sep 2026 16:32:52 +0100
X-Gm-Features: AcwNN1VaWNaLBvJzUz4ncwiHukBE1sGNIdi--zfmzWUHZDkOOjWrXqjsU6ZrGdw
Message-ID: <CAFEAcA_SLOJ9HufYt5B88S5LwCKo1Cmj8EqcvRn1Ym0jCFc_WA@mail.gmail.com>
Subject: Re: [RFC PATCH 11/18] accel/tcg: Replace size with first/last in
 tlb_fill_align
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-riscv@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112d.google.com
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
> Propagate the API change down one step further within cputlb.c.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>


> @@ -1664,8 +1665,8 @@ static bool mmu_lookup1(CPUState *cpu, MMULookupPageData *data, MemOp memop,
>      if (!tlb_hit(tlb_addr, addr)) {
>          if (!victim_tlb_hit(cpu, mmu_idx, index, access_type,
>                              addr & TARGET_PAGE_MASK)) {
> -            tlb_fill_align(cpu, addr, access_type, mmu_idx,
> -                           memop, data->size, false, ra);
> +            tlb_fill_align(cpu, addr, addr, addr + data->size - 1,
> +                           access_type, mmu_idx, memop, false, ra);

Can the "addr + data->size - 1" in these mmu lookup functions overflow?

>              maybe_resized = true;
>              index = tlb_index(cpu, mmu_idx, addr);
>              entry = tlb_entry(cpu, mmu_idx, addr);
> @@ -1833,8 +1834,8 @@ static void *atomic_mmu_lookup(CPUState *cpu, vaddr addr, MemOpIdx oi,
>      if (!tlb_hit(tlb_addr, addr)) {
>          if (!victim_tlb_hit(cpu, mmu_idx, index, MMU_DATA_STORE,
>                              addr & TARGET_PAGE_MASK)) {
> -            tlb_fill_align(cpu, addr, MMU_DATA_STORE, mmu_idx,
> -                           mop, size, false, retaddr);
> +            tlb_fill_align(cpu, addr, addr, addr + size - 1,
> +                           MMU_DATA_STORE, mmu_idx, mop, false, retaddr);
>              did_tlb_fill = true;
>              index = tlb_index(cpu, mmu_idx, addr);
>              tlbe = tlb_entry(cpu, mmu_idx, addr);
> @@ -1849,8 +1850,8 @@ static void *atomic_mmu_lookup(CPUState *cpu, vaddr addr, MemOpIdx oi,
>       * but addr_read will only be -1 if PAGE_READ was unset.
>       */
>      if (unlikely(tlbe->addr_read == -1)) {
> -        tlb_fill_align(cpu, addr, MMU_DATA_LOAD, mmu_idx,
> -                       0, size, false, retaddr);
> +        tlb_fill_align(cpu, addr, addr, addr + size - 1,
> +                       MMU_DATA_LOAD, mmu_idx, 0, false, retaddr);

thanks
-- PMM

