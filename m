Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29E18CF6D38
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2024 15:35:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sw1Nh-0003FY-Br; Wed, 02 Oct 2024 11:35:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sw1Ng-0003Et-Dw
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 11:35:12 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sw1Ne-0006rM-HC
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 11:35:12 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-42cc8782869so64190405e9.2
 for <qemu-devel@nongnu.org>; Wed, 02 Oct 2024 08:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727883308; x=1728488108; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Kv6D0fnNT3xGR1IIrR9rSYETvaIuEB74TGsumxGegAk=;
 b=ROJ5CFah+GFYsrcqg1NICSnUcr4ewKH0drOVipVCIGC5W2JsKrCA5hdXzfuQ9w8Lol
 zt0yLe7lHHQ1nJXrfnKxsAUAdvm5lAjTS4zqF+s9Q840igr2Se3CTmdAvPGXNggMKKUO
 IpL0Fhd7E7SVWSQCYUTwIl/LTjH/b+k4HvAqd5OJ4GbKbjzVJHvqyAVcQfyZrcY7r7ge
 coGlqhfQuQvg7S8v5mb35T72P8/r2nOwHGZ1ni7DYlZQl1oiGOs7BpjE8xxD0B2n6emI
 D196RVcLlGnyMAAWXuUzt8GcTOqgJfhC+BqdxroCL7oVUwynyrHhjY6qU8Jk4qp7GD5+
 psZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727883308; x=1728488108;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Kv6D0fnNT3xGR1IIrR9rSYETvaIuEB74TGsumxGegAk=;
 b=QgdTIxIpObwwGHFMZWOd5cOKi4khVKfnEgzeU6ZhqT0KWAtXVNcERlcpijjCGVI3bC
 0lES2PPnACaLiB0xBYuFoE+LweuiSmNIVIxj8Y7bG1WR/fhTlXv+FXlqOZo5ZO26TIfm
 TggrqkhQti696TEnLPjWUzpggY4mIP3GYs1gzQPODwfRRhj6KvJZlNwI6Lse8bpXxQWy
 ccN3t67yPbIM+0Jiy5DGfvuyQ0nQ98gpIboZsycW208UWk7hQJ1fJqiBs6/qZnp9sen0
 Pxmzi6PjM/P8gcTcAfv0dQbwj6oaXmCjGdopFCGOBcKsau/B9MznLf/zLSrYS+W1M/S2
 4VjA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVZwxxF3YscOzlgZgLG3/pOuKXpjxkeVXcib/nvyhUMFmHnT1jYuPiye/lXFP49PpKd0Eg79wboO+B4@nongnu.org
X-Gm-Message-State: AOJu0Yy2zKQnRyRL2cE34cuQxzO7Lpv74CZEe/gAmTBgd5ddUUsmv2eK
 f2e/V4I8yWK02WpITKPp+jp1QpjzD3gimF0hcaQIqB0RQTUjcyoOEnMsnpIfYyc=
X-Google-Smtp-Source: AGHT+IH1kXy/4tu8wtewLOUFrHEoFP/8lP+J1G+2LcEEnoqjITxckaRZVCvi+AMVzIy0KRPWogji6g==
X-Received: by 2002:a05:600c:4fc1:b0:42c:b950:680b with SMTP id
 5b1f17b1804b1-42f777c3830mr25786205e9.20.1727883308476; 
 Wed, 02 Oct 2024 08:35:08 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42f79d8d693sm21703755e9.2.2024.10.02.08.35.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Oct 2024 08:35:07 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id C55FE5F780;
 Wed,  2 Oct 2024 16:35:06 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Helge Deller <deller@kernel.org>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 qemu-devel@nongnu.org,  linux-parisc@vger.kernel.org
Subject: Re: {PATCH] accel/tcg: Fix CPU specific unaligned behaviour
In-Reply-To: <Zvyx1kM4JljbzxQW@p100> (Helge Deller's message of "Wed, 2 Oct
 2024 04:37:10 +0200")
References: <Zvyx1kM4JljbzxQW@p100>
User-Agent: mu4e 1.12.6; emacs 29.4
Date: Wed, 02 Oct 2024 16:35:06 +0100
Message-ID: <87cykimsb9.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x336.google.com
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

Helge Deller <deller@kernel.org> writes:

> When the emulated CPU reads or writes to a memory location
> a) for which no read/write permissions exists, *and*
> b) the access happens unaligned (non-natural alignment),
> then the CPU should either
> - trigger a permission fault, or
> - trigger an unalign access fault.
>
> In the current code the alignment check happens before the memory
> permission checks, so only unalignment faults will be triggered.
>
> This behaviour breaks the emulation of the PARISC architecture, where the=
 CPU
> does a memory verification first. The behaviour can be tested with the te=
stcase
> from the bugzilla report.
>
> Add the necessary code to allow PARISC and possibly other architectures to
> trigger a memory fault instead.
>
> Signed-off-by: Helge Deller <deller@gmx.de>
> Fixes: https://bugzilla.kernel.org/show_bug.cgi?id=3D219339
>
>
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index 117b516739..dd1da358fb 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -1684,6 +1684,26 @@ static void mmu_watch_or_dirty(CPUState *cpu, MMUL=
ookupPageData *data,
>      data->flags =3D flags;
>  }
>=20=20
> +/* when accessing unreadable memory unaligned, will the CPU issue
> + * a alignment trap or a memory access trap ? */
> +#ifdef TARGET_HPPA
> +# define CPU_ALIGNMENT_CHECK_AFTER_MEMCHECK  1
> +#else
> +# define CPU_ALIGNMENT_CHECK_AFTER_MEMCHECK  0
> +#endif

I'm pretty certain we don't want to be introducing per-guest hacks into
the core cputlb.c code when we are aiming to make it a compile once
object.

I guess the real question is where could we put this flag? My gut says
we should expand the MO_ALIGN bits in MemOp to express the precedence or
not of the alignment check in relation to permissions.

> +
> +static void mmu_check_alignment(CPUState *cpu, vaddr addr,
> +                       uintptr_t ra, MMUAccessType type, MMULookupLocals=
 *l)
> +{
> +    unsigned a_bits;
> +
> +    /* Handle CPU specific unaligned behaviour */
> +    a_bits =3D get_alignment_bits(l->memop);
> +    if (addr & ((1 << a_bits) - 1)) {
> +        cpu_unaligned_access(cpu, addr, type, l->mmu_idx, ra);
> +    }
> +}
> +
>  /**
>   * mmu_lookup: translate page(s)
>   * @cpu: generic cpu state
> @@ -1699,7 +1719,6 @@ static void mmu_watch_or_dirty(CPUState *cpu, MMULo=
okupPageData *data,
>  static bool mmu_lookup(CPUState *cpu, vaddr addr, MemOpIdx oi,
>                         uintptr_t ra, MMUAccessType type, MMULookupLocals=
 *l)
>  {
> -    unsigned a_bits;
>      bool crosspage;
>      int flags;
>=20=20
> @@ -1708,10 +1727,8 @@ static bool mmu_lookup(CPUState *cpu, vaddr addr, =
MemOpIdx oi,
>=20=20
>      tcg_debug_assert(l->mmu_idx < NB_MMU_MODES);
>=20=20
> -    /* Handle CPU specific unaligned behaviour */
> -    a_bits =3D get_alignment_bits(l->memop);
> -    if (addr & ((1 << a_bits) - 1)) {
> -        cpu_unaligned_access(cpu, addr, type, l->mmu_idx, ra);
> +    if (!CPU_ALIGNMENT_CHECK_AFTER_MEMCHECK) {

Then this would be something like:

  if (!(memop & MO_ALIGN_PP)) or something

> +        mmu_check_alignment(cpu, addr, ra, type, l);
>      }
>=20=20
>      l->page[0].addr =3D addr;
> @@ -1760,6 +1777,10 @@ static bool mmu_lookup(CPUState *cpu, vaddr addr, =
MemOpIdx oi,
>          tcg_debug_assert((flags & TLB_BSWAP) =3D=3D 0);
>      }
>=20=20
> +    if (CPU_ALIGNMENT_CHECK_AFTER_MEMCHECK) {
> +        mmu_check_alignment(cpu, addr, ra, type, l);
> +    }
> +
>      /*
>       * This alignment check differs from the one above, in that this is
>       * based on the atomicity of the operation. The intended use case is

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

