Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A351FD5D67D
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2024 17:34:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t96OD-0005bH-6d; Thu, 07 Nov 2024 12:33:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t96O9-0005b3-ET
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 12:33:45 -0500
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t96O7-0006Wt-IC
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 12:33:44 -0500
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5cf04f75e1aso1205091a12.1
 for <qemu-devel@nongnu.org>; Thu, 07 Nov 2024 09:33:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731000821; x=1731605621; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=01bhZPxKlAEu70DkjlmjtKMWDoHevXxVfWJzdjBUBqM=;
 b=T2Tlfs79tQLase0tNoz9zFwr9z2cNAa8pGwxvS2WlqM9iCfIZeysV/TrMn8k1m8M8q
 VOKbcspHYRzonDQph0unLDRu+J1mgz+a7j+8FLYoAjc1Ad3nA3bbkLRmb+CVmdGHIWQi
 tkZnYP9mvzjauZxzlA17P6lD1De9LqYfC6rG7n+ok+oTzRLBbBT6A+WZZTj9CofFvvc7
 XkFaEG+JCZQ/hDTvbtSZ6uMIDpLmkMe812omKn6BKKMY+h7GCAZPDsqVkFxLLuPgZ0+/
 V/KfM0syXPCnsnVbuTbsAyJGhtejwdIuXcc8XhNJYAI2CZxBSRgWPxOTEMKgEYx1iQbT
 4TNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731000821; x=1731605621;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=01bhZPxKlAEu70DkjlmjtKMWDoHevXxVfWJzdjBUBqM=;
 b=xGyfiejA8bdRVh1T8BhzMx4e0w+49gz2QfN4MNENLGKiUoEJKx1TOII1RNjRHaRAHf
 +ZHuVA+1nxc/BBy725gxaXX4+TjRzg7t+HGONWhl81pM+kMjcHbfSO92sQES2K71uBGn
 qxoYbkh2MYQNs71JkHbJkCn8fVKzOuioj1X2it4TsGUzutK0FEMGHnNYCjH8uzuzei5I
 ABOpUexbEhlIfkgJDXOyAIzHteDx75NH5DG7mBh5gHpEcE4fcbzMj+jd75l2HORyhr1V
 3zNTCnwKQmwY9+1kCnFRZr1MNn2o36ihWnTFcW4xQBJoFjMO4PvKt/2LXcoHtTikPKJY
 Lw6g==
X-Gm-Message-State: AOJu0YzEKdszLQVR5pLjW6nJoYkaSNqp4OsxoxmJluSnY5VshkiiwCsa
 BCDQkDPix1f8SgZ6pgsYM+Vwa5JNUnwClSlGws5WcAIviIRBv4gAp/ZYTGdKvvBdHQRe+1GFSYD
 cs70DbE+Bip0RXuRJ2Yzj1lstT/s5F8gkpFhAlQ==
X-Google-Smtp-Source: AGHT+IGJc2IwjmT1YrpnvFSUqidNo2B3PDZ3X6fMvz98LZ42WYKnFU5AmcF2g7apF+Q0YkSbpGcHjKNGFo7KhDN1AKk=
X-Received: by 2002:a05:6402:1d56:b0:5ce:d6a5:b7f0 with SMTP id
 4fb4d7f45d1cf-5cf0984c401mr180344a12.3.1731000821136; Thu, 07 Nov 2024
 09:33:41 -0800 (PST)
MIME-Version: 1.0
References: <20220606231450.448443-1-richard.henderson@linaro.org>
 <20220606231450.448443-28-richard.henderson@linaro.org>
In-Reply-To: <20220606231450.448443-28-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 7 Nov 2024 17:33:30 +0000
Message-ID: <CAFEAcA8ccgyLQPMykDQGjK5qc-etEBrsy0qGo+8mq-2_nCDDFg@mail.gmail.com>
Subject: Re: [PULL 27/43] target/loongarch: Add TLB instruction support
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, =gaosong@loongson.cn, yangxiaojuan@loongson.cn, 
 Song Gao <gaosong@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x531.google.com
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

On Tue, 7 Jun 2022 at 00:31, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> From: Xiaojuan Yang <yangxiaojuan@loongson.cn>
>
> This includes:
> - TLBSRCH
> - TLBRD
> - TLBWR
> - TLBFILL
> - TLBCLR
> - TLBFLUSH
> - INVTLB

Hi; running the loongarch functional tests on a build with
the clang undefined-behaviour sanitizer enabled reveals an
attempt to shift by an out-of-range amount in
helper_invtlb_page_asid_or_g():

../../target/loongarch/tcg/tlb_helper.c:470:31: runtime error: shift
exponent 244 is too large for 64-bit type 'uint64_t' (aka 'unsigned
long')
SUMMARY: UndefinedBehaviorSanitizer: undefined-behavior
../../target/loongarch/tcg/tlb_helper.c:470:31 in

> +void helper_invtlb_page_asid_or_g(CPULoongArchState *env,
> +                                  target_ulong info, target_ulong addr)
> +{
> +    uint16_t asid = info & 0x3ff;
> +
> +    for (int i = 0; i < LOONGARCH_TLB_MAX; i++) {
> +        LoongArchTLB *tlb = &env->tlb[i];
> +        uint8_t tlb_g = FIELD_EX64(tlb->tlb_entry0, TLBENTRY, G);
> +        uint16_t tlb_asid = FIELD_EX64(tlb->tlb_misc, TLB_MISC, ASID);
> +        uint64_t vpn, tlb_vppn;
> +        uint8_t tlb_ps, compare_shift;
> +
> +        if (i >= LOONGARCH_STLB) {
> +            tlb_ps = FIELD_EX64(tlb->tlb_misc, TLB_MISC, PS);
> +        } else {
> +            tlb_ps = FIELD_EX64(env->CSR_STLBPS, CSR_STLBPS, PS);
> +        }

We read here a field from the guest, which can be 0.

> +        tlb_vppn = FIELD_EX64(tlb->tlb_misc, TLB_MISC, VPPN);
> +        vpn = (addr & TARGET_VIRT_MASK) >> (tlb_ps + 1);
> +        compare_shift = tlb_ps + 1 - R_TLB_MISC_VPPN_SHIFT;

If tlb_ps is 0, then "tlb_ps + 1 - R_TLB_MISC_VPPN_SHIFT"
is tlb_ps + 1 - 13 == tlb_ps - 12. When converted back to
uint8_t this is 244.

> +
> +        if ((tlb_g || (tlb_asid == asid)) &&
> +            (vpn == (tlb_vppn >> compare_shift))) {

Here we shift tlb_vppn by 244, which is undefined behaviour
and triggers the sanitizer.

> +            tlb->tlb_misc = FIELD_DP64(tlb->tlb_misc, TLB_MISC, E, 0);
> +        }
> +    }
> +    tlb_flush(env_cpu(env));
> +}

What's the intended behaviour here?

This likely applies also to other similar functions; this
is just the one that I found.

thanks
-- PMM

