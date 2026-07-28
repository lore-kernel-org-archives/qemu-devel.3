Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8072C54F4C
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 14:22:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woigU-0000O2-Lk; Tue, 28 Jul 2026 10:21:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1woigT-0000Nf-90
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 10:21:29 -0400
Received: from mail-yx1-xb12f.google.com ([2607:f8b0:4864:20::b12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1woigP-0005v4-08
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 10:21:26 -0400
Received: by mail-yx1-xb12f.google.com with SMTP id
 956f58d0204a3-66825847b2cso3980746d50.3
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 07:21:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785248483; cv=none;
 d=google.com; s=arc-20260327;
 b=VzclnSZvhs7YMWwFf06R95Bni8njqYQO6vxeKgFgBJ10MZE6Z3gnGJ3WUqlXgbFsBL
 vKJr61ZbTIle/fp2VrV9rIHS+paCF6BtxJPc/l3DTO7FDrxbW/XeOj8S1z66ajLYIjbk
 70+9h1WpY/mNEvFBovQSZxAxAeTR9CJ5yhxrawLXu7n2A4MtWAsjywmRxaF88DOoUlGV
 kHyKv+EOwF2j2MNtg/0UpXAxlWQ/Otni6WmZ6UxBt9E2luJMS+6+BsJsDfiWNUlS6RYL
 1jPcw+L1ICGEU/0i5dEHbolbCGpKpzG7meB9ZCBIQTJ/PdHsCEsi5g9WUr3VXV3GQtl2
 +JZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=fzin/IsM5OqsI6fmAfgIVjv6Niy4XQcWkpkLsHG64os=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=m2rNOaiKKqBmAwYnDmP0sXUXK5R3e+7qd4Pus3V/sObsyY5J63QTxIJCvQpkexq4o0
 BnIp6m282Na/hdDwIVIixn3j6rY9u0ODOfiWOZqKPjmY8Qbdps9NuWaPie4oZk1XgJih
 1L2j3hYIUMauyHa3/CuMf8UJcwGKIBmcPUvfxvPUcAtKsrwKE0qrS8Rj2V0VtETG0PJ9
 r36KUrraclWs/OOiKc8rqZ3o5LdayQDLNNqVP+R8rwfbLbE2lzNwT+zSFC9+g2vRv9iP
 lXeoT7Zk1VN4zoAExQXVWQMLUKHePgqWAxYreuJewh/fHXi/2oWam6sjMmDX4bMxMZRM
 y/dQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785248483; x=1785853283; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=fzin/IsM5OqsI6fmAfgIVjv6Niy4XQcWkpkLsHG64os=;
 b=lPyR6rF4kfJQkax1KPw+9SXROOAobQHwjf0uCjuY18S6Q9xSXdypsha6tL2mZah3mU
 rclG1dU05CAGFEAYuw/zI7kl5rOOEX0Gnb+fSOeLoLdshJdM8q1wtF07xke79ZfrzmNk
 lreSOFazlHmL5qCld9hixvxg3RCsU8irNwn6bpNbVxjFFhO5F0+hv1wijwHNXS9PS7BV
 Sv7/TLTRMdvDMOaHmw24hwWK6FNWE7rH9pqh4lhN+ji0vhDa4fHYgKwr+oeDZcRFNjTd
 n0eC0BJ4uldys/AVWb6LAgBOatsF+ku1nGL5qj5YFn5govKvCdhpIuarCWbLz50JYJ3a
 cWwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785248483; x=1785853283;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=fzin/IsM5OqsI6fmAfgIVjv6Niy4XQcWkpkLsHG64os=;
 b=U+xgpxqZtTqZw6W2tl0avO1OTI+wsdn1KuPsXqUGXUZ6/hhzTbJ0Gw5MYGUbfmIRLf
 URGo7Dkkyb2e9sAd4k7L9fQyECJdnRhzykJGeQYkaaRJxGlsvMbbMOF61kcHMaBDgO4F
 NpzM7BILeDWPz5Vd3msrhyV9te2SKbXqLL/QWTi1UTqrq6+g69VEP5GB6hp14fX4e2rU
 hJ4nhaCxCEfv7kZEDzbtrdP4LrlQ6K8O4dUBAKdgI7f92TNB3qVdvHq6oG1m/RA+jkll
 CIc64rv0Cl2M5GQW7l/y79Hf+CTDpkWfulX820aZfMhxo7+VFbcHUyj1L4W2XV5jFi27
 /KDA==
X-Gm-Message-State: AOJu0YwB35RWB3pfvrtDKLesCLTgZYON3h+DhsNoEHLBWUisZutln0Zk
 6TB0fOyDjmftH1BnUOzh8i48PF1VTbuINY1j/pktcoAcKNGRhvbazBnianm34IVY/L6RWzVYAMN
 wvZr73yYwwrxWldRj5Cye6hr719SmNVdd2m0Ls7ff9Q==
X-Gm-Gg: AR+sD10G2u51If9Z0LZhw8TMSib8Wyb66bnjvzsAQB3+r3eOzavnbeTiT9RppQiCMOx
 8kmW/0QsAocNxijtHw5oL+Fgpp3VoqU/zcsTgNWPDHSrvvj7V8yiRM0vvslP5XT+W04m/PHsUWg
 OKR4lAiN/wXVRV76AIrM0+93a21j/tg+QME3+dHN+PqGNQn4c02ffHqHpJHFzqXVXDLlA2c8GWR
 XiTAGPv+uznbzPGDDCxZ3mCYo0zjPc8GX/DMJySBbuh9zzOj0xYpSCsX1FiFunTLQAYJF0NVQxT
 8Dw0d9k4YGJ8S0TkcyO34tBHqLonm8nGA7mQsN9kwL0a1L7NqanYP8g0
X-Received: by 2002:a05:690e:445:b0:664:ae68:33a2 with SMTP id
 956f58d0204a3-669057ff3f3mr822938d50.67.1785248483333; Tue, 28 Jul 2026
 07:21:23 -0700 (PDT)
MIME-Version: 1.0
References: <20260717232306.378988-1-richard.henderson@linaro.org>
 <20260717232306.378988-6-richard.henderson@linaro.org>
In-Reply-To: <20260717232306.378988-6-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 Jul 2026 15:21:12 +0100
X-Gm-Features: AUfX_myd12dQglp4aAEys021uKQB23XelQ60QlFJReHpqRr0E6hGcv3l9S4m20M
Message-ID: <CAFEAcA9gNvMD5YVTy2Zj51riyY9j+eCurQpH8M-ymb4yaf4-Kw@mail.gmail.com>
Subject: Re: [PATCH 04/17] target/arm: Raise alignment fault for DC_ZVA on
 Device memory
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12f.google.com
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

On Sat, 18 Jul 2026 at 00:26, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Raise alignment fault when DC_ZVA targets Device memory, as required
> by the architecture.  With MTE, an alignment exception is not always
> correctly ordered vs a tag check fail exception -- to be fixed in
> followup patches.
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3005
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

>
> +void HELPER(dc_zva)(CPUARMState *env, uint64_t addr)
> +{
> +    uintptr_t ra = GETPC();
> +    size_t len = (size_t)4 << get_dczid_bs(env_archcpu(env));
> +    int mmu_idx = arm_env_mmu_index(env);
> +    MemTxAttrs attrs = MEMTXATTRS_UNSPECIFIED;

I feel like some static analyzer or compiler is going to complain
that this assignment is pointless in the !CONFIG_USER_ONLY case.
Maybe better to set attrs = MEMTXATTRS_UNSPECIFIED inside the
#ifdef CONFIG_USER_ONLY block ?

> +    int flags;
> +    void *mem;
> +
> +    /* DC_ZVA requires that we supply the original pointer for traps. */
> +#ifdef CONFIG_USER_ONLY
> +    flags = probe_access_flags(env, addr, 0, MMU_DATA_STORE, mmu_idx,
> +                               false, &mem, ra);
> +#else
> +    CPUTLBEntryFull *full;
> +    flags = probe_access_full(env, addr, 0, MMU_DATA_STORE, mmu_idx,
> +                              false, &mem, &full, ra);

Is 0 really the right size to pass in here? Looking at
probe_access_full(), if you pass in a 0 size then it will
call notdirty_write() with a dirtysize parameter of 1,
which will then not invalidate or set the VGA/migration
dirty bits on the full range of memory we're about to clear.
This would be OK if we then went through the slowpath and
did a set of byte accesses, but probe_access_full() will
clear TLB_NOTDIRTY from the flags it returns to us if it
called notdirty_write(), so we will take the fastpath if
that was the only flag set.

Maybe probe_access_full(), probe_access_full_mmu() and
probe_access_flags() should not call notdirty_write() and
clear TLB_NOTDIRTY from the flags they return if the passed
in size is 0 ?

The notdirty_write() API also wants the base address of the
DC ZVA block (since that's where we will be writing from),
not the address from the guest.

(We may be getting away with some of this because of various
functions rounding up/down to full page addresses, but none
of these functions seem to document that, so we shouldn't
rely on it.)

> +    attrs = full->attrs;
> +#endif
> +
> +    flags = do_dcxva_traps(env, addr, len, mmu_idx, flags, attrs, ra);
> +
> +    /* After traps, treat as aligned blocks. */
> +    addr = addr & -len;
> +    mem = (void *)((uintptr_t)mem & -len);
> +
> +    do_dczva_0(env, addr, len, mem, mmu_idx, flags, ra);
> +}
> +
>  /*
>   * Perform an MTE checked access for DC_ZVA.
>   */
> --

-- PMM

