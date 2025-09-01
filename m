Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84F63CA0FFF
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 17:22:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ut8E3-0005Xs-1q; Mon, 01 Sep 2025 13:21:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ut8Di-0005QQ-E2
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 13:21:30 -0400
Received: from mail-yw1-x1134.google.com ([2607:f8b0:4864:20::1134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ut8De-0001Po-QL
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 13:21:30 -0400
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-71d60593000so33493947b3.3
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 10:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756747285; x=1757352085; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=RTyD0Fn6bbjlULr96B4sZT8TrLBKaOXaASlNy+KFpbY=;
 b=i4RnK0YRDvMmOjBJ33LIKL7yj5QU0tuccfzCoNKf+RrfMyqcas0ZZ1Px2oQVQAVZdq
 dWWQ9x3Maxjuj6EmNQSVC1NKOHYI7cUQ33cBGDJcfvuCMjo924e1lEOTwYKQ+In9Bpn2
 Xu3fZE/HRH0XxjQxBWFQamLWsTvZWbCuyT5i3aaJaC4wdCOH1hlMb/Hrl9yIbqJOWgnu
 W6xN7CRklnKGFxk+ZMOpC/mvplFu2Sg4SJtZ1Z/Zakb8IRtpBf2kUIPUwL7pLfz8he4z
 IG6iIYki40HJYO3m48GIKuIWo3em5WStgPClAfVn5m3AbUdDM+nhbJnol1d6U5Qb74WN
 KHAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756747285; x=1757352085;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RTyD0Fn6bbjlULr96B4sZT8TrLBKaOXaASlNy+KFpbY=;
 b=rUIFEUIWwseas4yvh6pjirzjPfslm7gcVl7JMFl7F0DKHOY08vGnrTLG/lqFriiJ71
 g6AMmMLRZeYjxPGXxWOYWZuX1SBSC/HNxwO+cQsk3xJuiShS6nQUR1zTEpwOV4gBlCk+
 t5CXd5lwvDCPSsU0+ZrlWTpKfInohRruy9yslKeG1+SA9ux+S82vf4RsDG5IE2ZdDMuR
 1joXhT5wnTUK9zuLTM+GbIPB/kltg7zDv+lkdEYa71bYJHtuGsTSx81ArWfblw68Yqwb
 BaNTpob/su/0DvQV9apvvP3m+pSrE/RB/wfWR/bsAlv9UcYmkDcK+TlRaPCBQitYeG1h
 +nQg==
X-Gm-Message-State: AOJu0YwXMchvqQ1a3o/mXidLF206sIy8YlYi/v0ZKZykrvFZD92+yHHb
 Oy5AlR3kC7s2ZxdjYaglWDE2mwIPsI3Livh3WA+CS1+WLTSx5S0qrEDQAQSvzlx0yXnpxx/3z7T
 MQ7ApOHlS5M1cy97z9T/afqAYyTcWBWH0fGyNWJ1WIg==
X-Gm-Gg: ASbGnctztKMqJ+zfeuSdRfWrlfT76y91xfmT+Md4+7F5cpmqPNp89az7wfNVD3bqpeI
 /siOxQNfowMWDJaGG9gqaaQYXjRz8s+knEuov5or8/ikdJ/sx9a5XBPmujQDgcadCV2uS/5GYHB
 MGSwA0oN45IxKZUtMeDHFKV0Zj9xaOZtFR3R3znUlHpUb2Y5IoZDdj65TN75pKFpbx1oIO8W1uj
 sHIk/Nx
X-Google-Smtp-Source: AGHT+IEM4LWO9XF6/p6tzvHWtlI8xKRmDaB562+uYVGjDHh5dpBaivNV/mUAMAFq97Wwnjtgjw2hBy1S+SFWm73u5+s=
X-Received: by 2002:a05:690c:7088:b0:71f:f3bc:3b9 with SMTP id
 00721157ae682-722764aca8cmr93519497b3.29.1756747285163; Mon, 01 Sep 2025
 10:21:25 -0700 (PDT)
MIME-Version: 1.0
References: <20250822092410.25833-1-cjchen@igel.co.jp>
 <20250822092410.25833-6-cjchen@igel.co.jp>
In-Reply-To: <20250822092410.25833-6-cjchen@igel.co.jp>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 1 Sep 2025 18:21:13 +0100
X-Gm-Features: Ac12FXyJI2XnjPtE5F4YxZ1Q2oPpPsqvK45yYj6G0ijTh80jOYqdxYimZXMihn8
Message-ID: <CAFEAcA9EgODY_wR2j9Bsy66P-CRfdTBPRSfYeJ1MGTGyEUDouw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 5/9] system/memory: support unaligned access
To: CJ Chen <cjchen@igel.co.jp>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, qemu-riscv@nongnu.org, 
 qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Keith Busch <kbusch@kernel.org>, 
 Klaus Jensen <its@irrelevant.dk>, Jesper Devantier <foss@defmacro.it>, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Tyrone Ting <kfting@nuvoton.com>, 
 Hao Wu <wuhaotsh@google.com>, Max Filippov <jcmvbkbc@gmail.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Tomoyuki Hirose <hrstmyk811m@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1134;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1134.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Fri, 22 Aug 2025 at 10:25, CJ Chen <cjchen@igel.co.jp> wrote:
>
> From: Tomoyuki Hirose <hrstmyk811m@gmail.com>
>
> The previous code ignored 'impl.unaligned' and handled unaligned
> accesses as-is. But this implementation could not emulate specific
> registers of some devices that allow unaligned access such as xHCI
> Host Controller Capability Registers.
>
> This commit emulates an unaligned access with multiple aligned
> accesses. Additionally, the overwriting of the max access size is
> removed to retrieve the actual max access size.
>
> Based-on-a-patch-by: Tomoyuki Hirose <hrstmyk811m@gmail.com>
> Signed-off-by: CJ Chen <cjchen@igel.co.jp>
> Tested-by: CJ Chen <cjchen@igel.co.jp>
> Reported-by: Tomoyuki Hirose <hrstmyk811m@gmail.com>
> ---
>  system/memory.c  | 147 ++++++++++++++++++++++++++++++++++++++---------
>  system/physmem.c |   8 ---
>  2 files changed, 119 insertions(+), 36 deletions(-)
>
> diff --git a/system/memory.c b/system/memory.c
> index 63b983efcd..d6071b4414 100644
> --- a/system/memory.c
> +++ b/system/memory.c
> @@ -509,27 +509,118 @@ static MemTxResult memory_region_write_with_attrs_accessor(MemoryRegion *mr,
>      return mr->ops->write_with_attrs(mr->opaque, addr, tmp, size, attrs);
>  }
>
> +typedef MemTxResult (*MemoryRegionAccessFn)(MemoryRegion *mr,
> +                                            hwaddr addr,
> +                                            uint64_t *value,
> +                                            unsigned size,
> +                                            signed shift,
> +                                            uint64_t mask,
> +                                            MemTxAttrs attrs);

So we now have access_emulation and access_fastpath and
the function is_access_fastpath() to select between them.
Can we have a comment please that says what the two are
doing and what the criterion is that lets us pick the fast path ?

> +
> +static MemTxResult access_emulation(hwaddr addr,
> +                                    uint64_t *value,
> +                                    unsigned int size,
> +                                    unsigned int access_size_min,
> +                                    unsigned int access_size_max,
> +                                    MemoryRegion *mr,
> +                                    MemTxAttrs attrs,
> +                                    MemoryRegionAccessFn access_fn_read,
> +                                    MemoryRegionAccessFn access_fn_write,
> +                                    bool is_write)
> +{
> +    hwaddr a;
> +    uint8_t *d;
> +    uint64_t v;
> +    MemTxResult r = MEMTX_OK;
> +    bool is_big_endian = devend_big_endian(mr->ops->endianness);
> +    void (*store)(void *, int, uint64_t) = is_big_endian ? stn_be_p : stn_le_p;
> +    uint64_t (*load)(const void *, int) = is_big_endian ? ldn_be_p : ldn_le_p;

Please use a typedef for all function pointers: it makes it
much easier to read.

> +    size_t access_size = MAX(MIN(size, access_size_max), access_size_min);
> +    uint64_t access_mask = MAKE_64BIT_MASK(0, access_size * 8);
> +    hwaddr round_down = mr->ops->impl.unaligned && addr + size <= mr->size ?
> +        0 : addr % access_size;
> +    hwaddr start = addr - round_down;
> +    hwaddr tail = addr + size <= mr->size ? addr + size : mr->size;
> +    uint8_t data[16] = {0};
> +    g_assert(size <= 8);

There should be a blank line after the last variable definition
and before the g_assert() here.

> +
> +    for (a = start, d = data, v = 0; a < tail;
> +         a += access_size, d += access_size, v = 0) {
> +        r |= access_fn_read(mr, a, &v, access_size, 0, access_mask,
> +                            attrs);
> +        store(d, access_size, v);
> +    }
> +    if (is_write) {
> +        stn_he_p(&data[round_down], size, load(value, size));
> +        for (a = start, d = data; a < tail;
> +             a += access_size, d += access_size) {
> +            v = load(d, access_size);
> +            r |= access_fn_write(mr, a, &v, access_size, 0, access_mask,
> +                                 attrs);
> +        }
> +    } else {
> +        store(value, size, ldn_he_p(&data[round_down], size));
> +    }

This would be much easier to review if there were comments
that said what the intention/design of the code was.

> +
> +    return r;
> +}
> +
> +static bool is_access_fastpath(hwaddr addr,
> +                               unsigned int size,
> +                               unsigned int access_size_min,
> +                               unsigned int access_size_max,
> +                               MemoryRegion *mr)
> +{
> +    size_t access_size = MAX(MIN(size, access_size_max), access_size_min);
> +    hwaddr round_down = mr->ops->impl.unaligned && addr + size <= mr->size ?
> +        0 : addr % access_size;
> +
> +    return round_down == 0 && access_size <= size;
> +}
> +
> +static MemTxResult access_fastpath(hwaddr addr,
> +                                   uint64_t *value,
> +                                   unsigned int size,
> +                                   unsigned int access_size_min,
> +                                   unsigned int access_size_max,
> +                                   MemoryRegion *mr,
> +                                   MemTxAttrs attrs,
> +                                   MemoryRegionAccessFn fastpath)
> +{
> +    MemTxResult r = MEMTX_OK;
> +    size_t access_size = MAX(MIN(size, access_size_max), access_size_min);
> +    uint64_t access_mask = MAKE_64BIT_MASK(0, access_size * 8);
> +
> +    if (devend_big_endian(mr->ops->endianness)) {
> +        for (size_t i = 0; i < size; i += access_size) {
> +            r |= fastpath(mr, addr + i, value, access_size,
> +                          (size - access_size - i) * 8, access_mask, attrs);
> +        }
> +    } else {
> +        for (size_t i = 0; i < size; i += access_size) {
> +            r |= fastpath(mr, addr + i, value, access_size,
> +                          i * 8, access_mask, attrs);
> +        }
> +    }
> +
> +    return r;
> +}
> +
>  static MemTxResult access_with_adjusted_size(hwaddr addr,
>                                        uint64_t *value,
>                                        unsigned size,
>                                        unsigned access_size_min,
>                                        unsigned access_size_max,
> -                                      MemTxResult (*access_fn)
> -                                                  (MemoryRegion *mr,
> -                                                   hwaddr addr,
> -                                                   uint64_t *value,
> -                                                   unsigned size,
> -                                                   signed shift,
> -                                                   uint64_t mask,
> -                                                   MemTxAttrs attrs),
> +                                      MemoryRegionAccessFn access_fn_read,
> +                                      MemoryRegionAccessFn access_fn_write,
> +                                      bool is_write,
>                                        MemoryRegion *mr,
>                                        MemTxAttrs attrs)
>  {
> -    uint64_t access_mask;
> -    unsigned access_size;
> -    unsigned i;
>      MemTxResult r = MEMTX_OK;
>      bool reentrancy_guard_applied = false;
> +    MemoryRegionAccessFn access_fn_fastpath =
> +        is_write ? access_fn_write : access_fn_read;
>
>      if (!access_size_min) {
>          access_size_min = 1;
> @@ -551,20 +642,16 @@ static MemTxResult access_with_adjusted_size(hwaddr addr,
>          reentrancy_guard_applied = true;
>      }
>
> -    /* FIXME: support unaligned access? */
> -    access_size = MAX(MIN(size, access_size_max), access_size_min);
> -    access_mask = MAKE_64BIT_MASK(0, access_size * 8);
> -    if (devend_big_endian(mr->ops->endianness)) {
> -        for (i = 0; i < size; i += access_size) {
> -            r |= access_fn(mr, addr + i, value, access_size,
> -                        (size - access_size - i) * 8, access_mask, attrs);
> -        }
> +    if (is_access_fastpath(addr, size, access_size_min, access_size_max, mr)) {
> +        r |= access_fastpath(addr, value, size,
> +                             access_size_min, access_size_max, mr, attrs,
> +                             access_fn_fastpath);
>      } else {
> -        for (i = 0; i < size; i += access_size) {
> -            r |= access_fn(mr, addr + i, value, access_size, i * 8,
> -                        access_mask, attrs);
> -        }
> +        r |= access_emulation(addr, value, size,
> +                              access_size_min, access_size_max, mr, attrs,
> +                              access_fn_read, access_fn_write, is_write);
>      }

Because you've removed the loops from this function, we don't
any longer need to set r to MEMTX_OK and then OR in the
return value from access_whatever; we can just set r = ...

> +
>      if (mr->dev && reentrancy_guard_applied) {
>          mr->dev->mem_reentrancy_guard.engaged_in_io = false;
>      }

thanks
-- PMM

