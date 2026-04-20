Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC53DF557FE
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2026 09:52:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wElIR-0006ky-CA; Mon, 20 Apr 2026 05:52:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wElIH-0006k5-14
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 05:51:54 -0400
Received: from mail-yx1-xb133.google.com ([2607:f8b0:4864:20::b133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wElIE-0005YZ-QN
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 05:51:52 -0400
Received: by mail-yx1-xb133.google.com with SMTP id
 956f58d0204a3-651bc8f864fso1478113d50.1
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2026 02:51:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776678709; cv=none;
 d=google.com; s=arc-20240605;
 b=XJdEJufAfz8qISeoqmkAg5DRbbJQ6fPq86yGUyqyx2ihG6pdSYcW2hJCzZk9DSfigt
 Oygv2mjc7nkODJjSaBYj2lzoEt9DjodocZlcwjZc4A3R96+v/JpLFBxsZa/g/Y73NQuv
 6uEvZik7q2c88wFAO+CuFjUwiVotkXNoiDV/YWT3B19RFlxKv4j/jZgr5+fEiyyVwFCR
 8fHjOYwT1Cn+jVmFhXO+6Yw/wq/muuk6CiWwKAGIcFJAsUSZdSU8knt5ctIOSVnQmyp0
 Zx0rfLtoPCaay7pASkUd0Ci161AObkXbT8i6GepZcAsq73C9D38kjncV6YBUwe6rjWUI
 4+Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=CM248gn6ZX0X3LvYoKmqT1dJlvLJmbmpAU7NIAOnodo=;
 fh=N3dnZwB1bGIoIuwtamz7lHcb5DEaPuY10mwMPlmH8No=;
 b=DNCBKZ/aTxXUFmRVbvgNa6f/wn819Yy0L5jHroI/EXjumh1bK62vqvWrDnjHSeHGFi
 aiPJiKgbMMfA14fwnporXBrQQEFvwSKyRggnO9fKYh6BcQTVcGpn9D/8nzS9Pi+y/bNn
 dZjvu2oZZJrWoEWeljX/GSu7YdoOS75fdGpBBY1ud05HQP/PQw82u4FWAcgco26Aaa8S
 iglv1Mo39eeBxcNAU6HzAvqum4XZ926Isb6EnsVCMTDeL2+L09+89h5LAkNhLhr61C97
 vG4fvMP6+ftS4vFv43EFXB0y/ifXtA2FcOn22/1pfS7dglOS21hUDuA4AdCHV9KpX7eu
 aqKQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776678709; x=1777283509; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=CM248gn6ZX0X3LvYoKmqT1dJlvLJmbmpAU7NIAOnodo=;
 b=JJjW/yoVVHUiPcOYYiOL7ttJ0qZEU6GVNtXSoi7QIbncD3GJuo8oHbyNnKwHg6atv3
 6I+XBFJW+ksXdwN9Lmit5FaoR7hYlOPt5cyUUd1uMmr3zK8j2dzZK1sYGaVB5z7FPOcM
 JyKoO8aYxkllBa2uno48cB2xt7su15q1XZ8xHYal5yfnXKp+s4ZP1s5Fuu2PjUyILfdN
 MoW4d7ZByB6voE91TkbUwJrrb0oUmW5BynXvPYVW+bxGBPSjmMSToPGZz4FwplrHwjFC
 cawWp+2PwC2p3G6+FTNkhYhEsBurc/Y07HaBApmTOuAU0kV6jSXNI3d8/JW3B3VLCZz8
 uCjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776678709; x=1777283509;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CM248gn6ZX0X3LvYoKmqT1dJlvLJmbmpAU7NIAOnodo=;
 b=DYqBThqr4qDIi5Z4v9lh2N9viOxwodLILmRTK4YB6tkU9ISgFHtAE8soMZorO0Pl9W
 GX1TrUfwTng1mwr+u6AnAgnJ9ZbHfCacHskdR5hUGvpiGRz9BfU+AAkYjTtis+UmB592
 H4kQVd6UiGiFB2U3wkaRZWu1I/ri/MUgO9AFInIfGQBQrTyazjYZVZpz9r4iCVs0Gv89
 0Vx/7tq8KSbsQxBrB+xI24qFtlN14LF+s/o6V3Q8OlhGYk42KzwTTflXaHlRZ32AcWCd
 uLe+qI9sNVjUzgDMPZMvbLVnFV3CPf0shAw11r6Q8/9iHvtWHXNa7aqzDJWH2HWEFE7s
 rTSg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/ddcR3bw/E33aYjD03o+Imstc4Vt47TS+02B2MZrgtVoZQYPpu7CEuV639K422KCc/8bSzsDLbVaYy@nongnu.org
X-Gm-Message-State: AOJu0YzNbXRmRDIDGuMSevXofZuOMXhyxqBVtzTQzoh3CCt1Bt7Frhbs
 xUcvMjZxNHmkkjoXxGVq0iuCzBmTtnRyhx13l1ym15WAHzPAMYOgIfErXTUFfuN1qFlx7iSC2rT
 46rqeHM9OO8VWHxpytoZa1RtvWqFkgvd+HQmwf+0Vbg==
X-Gm-Gg: AeBDies91hPIaliWnNj/JQ98tOUwQZ36c2W+h6LVmRLKy63kmgBAS1xvchchl1lAPRx
 OnYK83QHSuBjo8JKsBA+06tUpIBrpn5Im+GyRtyhHZEtu/PUPsOk2MGj35LmunFa/b9Y3xddW5u
 ULwwE0E9NJZ9aG8eVJtXArvO4rEFnagmoaoFXNyTU/ZW4yN2F1Bry7TT2mokIwOpirJKDZKmRhg
 aWIOogx6uk3SkeLsnEfDtgxHhzjg4DfSTDMccSznnFBSSn+P3vpPuLnGwEF17FvAuQ6ygLcEsG9
 pxlm/pOZnvzn5wmFDH6986JTJIrGdjwMmOCcRhleJ6aftijkeTz0BKnC89lLMmkE+Wor1hXNI21
 6Sg==
X-Received: by 2002:a05:690e:585:b0:651:bcb6:888f with SMTP id
 956f58d0204a3-653108399a9mr8955591d50.15.1776678708741; Mon, 20 Apr 2026
 02:51:48 -0700 (PDT)
MIME-Version: 1.0
References: <20260420075159.106615-1-thuth@redhat.com>
In-Reply-To: <20260420075159.106615-1-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Apr 2026 10:51:37 +0100
X-Gm-Features: AQROBzBKDHz6c2PHgKACOKjC1CN5yOruVHatehWrcjGlNJl2CaW0Bhq2UEPJvbk
Message-ID: <CAFEAcA9=oLSEv89Y62kaVDjsdHXg00=yTnSt7W42aosm0B092w@mail.gmail.com>
Subject: Re: [PATCH] system/memory: Don't call MR handlers for bytes beyond
 the MR's size
To: Thomas Huth <thuth@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 qemu-devel@nongnu.org, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b133;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb133.google.com
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

On Mon, 20 Apr 2026 at 08:52, Thomas Huth <thuth@redhat.com> wrote:
>
> From: Thomas Huth <thuth@redhat.com>
>
> If a guest triggers a multi-byte read/write at the very end of a memory
> region, the code access_with_adjusted_size() still tries to access
> all bytes of the transfer, even if the final bytes are already beyond
> the memory region's size. If the device handler cannot cope with those
> accesses, bad things can happen, for example:
>
>  $ echo "writew 0x800064 0x4142" | \
>    ./qemu-system-avr -M mega2560 -display none -qtest stdio -accel qtest
>  [I 0.000001] OPENED
>  [R +0.001750] writew 0x800064 0x4142
>  qemu-system-avr: ../../devel/qemu/hw/misc/avr_power.c:58:
>   avr_mask_write: Assertion `offset == 0' failed.
>  Aborted                    (core dumped)
>
> We really should not call MR handlers for bytes that are beyond the
> MR's size, so let's add a check to limit the size in such cases.
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3393
> Signed-off-by: Thomas Huth <thuth@redhat.com>

The MR in question sets .impl.max_access_size to 1 but leaves
.valid.max_access_size at its default (which we treat as 4),
and is then registered with an MR size of 1. Perhaps we should
also assert on MR registration that
  .valid.max_access_size <= the MR size ?
Though there might I suppose be cases where the MR window can be
guest-configured to various sizes so it might in some silly setups
be smaller than the largest permitted access size on startup.

We should also set .valid.max_access_size on this specific
device to 1, though the fix to the core memory system is
definitely something we should have (and that I was under
the impression we already enforced...)

> ---
>  system/memory.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/system/memory.c b/system/memory.c
> index 56f3225b21a..2ff74c42e3f 100644
> --- a/system/memory.c
> +++ b/system/memory.c
> @@ -531,6 +531,7 @@ static MemTxResult access_with_adjusted_size(hwaddr addr,
>      uint64_t access_mask;
>      unsigned access_size;
>      unsigned i;
> +    unsigned int checked_size;
>      MemTxResult r = MEMTX_OK;
>      bool reentrancy_guard_applied = false;
>
> @@ -557,13 +558,21 @@ static MemTxResult access_with_adjusted_size(hwaddr addr,
>      /* FIXME: support unaligned access? */
>      access_size = MAX(MIN(size, access_size_max), access_size_min);
>      access_mask = MAKE_64BIT_MASK(0, access_size * 8);
> +
> +    if (addr + size > mr->size) {

mr->size is an Int128 -- you can't portably do direct
arithmetic on it like this. (We still support configs where
there is no working __int128_t and Int128 is a struct.
I think --enable-tcg-interpreter is one way to get that.)

There are also I think cases where addr + size might overflow.
(addr is the within-MR offset, but we permit MR sizes up to
and including 2^64.)

> +        assert(addr < mr->size);
> +        checked_size = mr->size - addr;
> +    } else {
> +        checked_size = size;
> +    }

I wonder if this is the right place to enforce this.
Another option would be to have memory_region_access_valid()
do the check and return false for accesses off the end.
The splitting of writes that we do here is only supposed to be
handling the case of "the implementation allows smaller chunks
than the device permits", not the "access overlaps between two
different MRs" case (which would need to be handled much further
up the callstack before we have identified the specific MR we
are accessing).

> +
>      if (devend_big_endian(mr->ops->endianness)) {
> -        for (i = 0; i < size; i += access_size) {
> +        for (i = 0; i < checked_size; i += access_size) {
>              r |= access_fn(mr, addr + i, value, access_size,
>                          (size - access_size - i) * 8, access_mask, attrs);
>          }
>      } else {
> -        for (i = 0; i < size; i += access_size) {
> +        for (i = 0; i < checked_size; i += access_size) {
>              r |= access_fn(mr, addr + i, value, access_size, i * 8,
>                          access_mask, attrs);
>          }

thanks
-- PMM

