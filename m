Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03C71C5DF7D
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 10:26:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxMRf-0004U7-0Y; Fri, 21 Aug 2026 06:25:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wxMRb-0004TH-FB
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 06:25:51 -0400
Received: from mail-yx1-xb12c.google.com ([2607:f8b0:4864:20::b12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wxMRZ-0004iC-OK
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 06:25:51 -0400
Received: by mail-yx1-xb12c.google.com with SMTP id
 956f58d0204a3-66c744a00edso608066d50.2
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2026 03:25:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787307948; cv=none;
 d=google.com; s=arc-20260327;
 b=qoDkW14g05Ucq5W914UEK4UlrLLwn1Bjy3O6LAfJeyh3+AWjlXzpsW7ThjJ4YWBfMK
 eAdUB3MmwxkRBYOkpJpQyFElEon2N5UUuDqtmpQA5AzBInY/rOZ1m9g7EuEq7m2zvbOP
 zbO3qSLyW7Eb2zwv5YbsBt7nvf/BX2ucWiJfBlBiRI6UpdLz1MpASu6oxzPYAnot1OBp
 8yJjiYabgz8Nvd4iKw/0T1cjvUu1OVsf3Qq2J/YNQH4a0rGtIVuLF0ITuFXUaOlSwfrZ
 8wJeQRn6BVirquR1Fh4UWf3SKF9PsuI2q1ipWpuz4Zou5nOi+D4XrTJZrzozQtcTnqvz
 Al0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=3o78JfE9OExPjzGEuqFNkZ/A4M9iTCSLkp4tYlnVieM=;
 fh=ok4TTumf1b7Zi7X7/hN0JBsvqNrVrPGltnNNWQdL1wI=;
 b=A9ogdgj1AyR9pPeEeLD3B6yOvCEWJL88ZBvw7ZoWXlcuaQwMb52YpJo437XT9E8VLP
 XGTUmDG46bK96T8/XI21vndqcdCtM43aZcAQ7USo5quBLW5GT6993aW8TKmsIzIT/TOR
 YRBOZ4z+d3qPrDxbkqJXLRmMPNvS5fEov7H5A0vQRzm8dvjQv5vLtgTqyVvaupUHealL
 wDrxT1uN94U4Otgokl7RgGSPAcdl3FZ1Rb/giva4uhFNmjhP1xttUYlyMRedqu3mTThH
 J6ZtXfXBB3cCWspxnZk1xIYUb2/7Z5bjDZpwdKixLkQzcKaiBSVUY1n+OciDX4AZ/+UZ
 Hjww==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787307948; x=1787912748; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=3o78JfE9OExPjzGEuqFNkZ/A4M9iTCSLkp4tYlnVieM=;
 b=XtXnKaHpHh4fOXaRx+ops0WOowY4VU2crsh65SjKD23+o9hNZtmANGOIqJiFOxtoz9
 PyAbFmlomE3jMOCA83PZbfEXMf9trc3jgR1+b+8LVAEV5KtG3JvLjBn4UjtueN1jVneX
 U5yTCsu3Vte0Yp5/Nyx/NkB9zIgevd3U3nHUyyk9suBe+G6ovqU6/+fr8gF/cwNZgLtQ
 UJcp7c4Q1MrA2zvl2Ui0qKnxA8W/KjTMKxM2l+HxPBInAm5br4IohkTv6BPS5R/yNacs
 LZ+lzFUxDv4uArMUdtO1vrQtm7lIsVf4cWtiMO+5kfiKEVVbZ5VmSGSuLrWIbinp+QLI
 zoxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787307948; x=1787912748;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3o78JfE9OExPjzGEuqFNkZ/A4M9iTCSLkp4tYlnVieM=;
 b=F4oyetQdZIgDX+GsLiLBqDHTIsEmgS7QjDNRI346wadFfgRe8hT6grTy9zxVuALNAZ
 O/+I7Zv4vvW8WKKy3wS/A2PTbtfH1Q2bbdYPFo3N6hWefyHP9HC2LvT+SVqrJwgrfJUi
 KnSPJYM8pakMNlNCYjzFMWSE2qxR2aPn9RO0HDd5mY2r2aRlhCqIg72edU0cTcGRvCJH
 KWtX0Wvs+QyFaap3NpnDz+pUIN1O5TedIZ+4yWWCUfmIlL4s8K1NopMRMA4ue3pyi9Q5
 iRpp9MX9L92Ke95jlgZTFN6tEoYIDUjfxZq0x7L2F4w1uMH8IagBgUCbRs2PnwEDsI6Y
 Kq3A==
X-Forwarded-Encrypted: i=1;
 AHgh+RqLV+rQnHJS9869GJ6DLYFeDTlAR+YoRmO/U7I6TlOh5opHgdSmQYpUF5GewOBc1W9i3WWIrZ9jfWKu@nongnu.org
X-Gm-Message-State: AFuF++kBVH8Kz/q9I9rfyuwCvts+Cx0msiv/qEhMGyQXggMQEEhU3yff
 yipYUwkKWJ4m9xKS47iMhsmMtrAay6ejienupLlhfx8T66f02K7wXIw24QNlEk5Nq6e+gHNwcPe
 r+cPrgXrtQiGKX6VysnxYRtVPP8p+Dr1nt8kBl9jZrw==
X-Gm-Gg: AR+sD100Q+y7aKi6WR1SB3AaXBAjMshILo4dQAWBMI1dZfMDLoA88l+jrr4WFk+UtFn
 shiqDatGUbDJRqIbXl94atIQwJOyXIoXaHS9ZaveO9eZgKEzamxXxvCh9q+rbUvFyPHhXWuC3UO
 Dfx1GypD8adpQqnmLPDJFRr/tep7VCDjODDF2+mO8YNYR70uFaLaXuFHyLNbE5rcoyYLqAdeOMN
 OBpyElKu78L1ISH6RNN0p7ShMddWIdmSyuBtOUntgHYNoDcS1pmIDhzysPTtDqkW+Ic/asSkbx0
 Wr0kOw9iPxB4jizJlBBnwPIJJONImAr8ip0UL7tyP/MuM2dzD938VkhvgxX31a1xeCLq2AqrRdf
 x4xM+99z/4Qi6Xc0xuKkGBuK+D4jT
X-Received: by 2002:a05:690e:4803:b0:668:8dc0:bcc3 with SMTP id
 956f58d0204a3-66ce48cc5ccmr1430004d50.0.1787307947994; Fri, 21 Aug 2026
 03:25:47 -0700 (PDT)
MIME-Version: 1.0
References: <20260821100856.1794011-1-xiangwencheng@lanxincomputing.com>
In-Reply-To: <20260821100856.1794011-1-xiangwencheng@lanxincomputing.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 21 Aug 2026 11:25:34 +0100
X-Gm-Features: AcwNN1WsxR0Tsde0YrCDQ2ot39uCPnn52QQ8RBdoUEQ3DAqME8oy7f3nuBGkwX8
Message-ID: <CAFEAcA_kLpaz0UQi3Q315kLVqvDtxKh77kU2meN9G1_evfKBeQ@mail.gmail.com>
Subject: Re: [PATCH v2] virtio: Add aligned ld/st accessors for vring
To: BillXiang <xiangwencheng@lanxincomputing.com>
Cc: mst@redhat.com, pbonzini@redhat.com, peterx@redhat.com, philmd@mailo.com, 
 qemu-devel@nongnu.org, qemu-riscv@nongnu.org, richard.henderson@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12c.google.com
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

On Fri, 21 Aug 2026 at 11:10, BillXiang
<xiangwencheng@lanxincomputing.com> wrote:
>
> The generic ld/st*_p() pointer helpers lower to __builtin_memcpy,
> which on RISC-V will be expanded to multiple byte-access instructions
> rather than a single aligned access by the compiler because it
> cannot prove alignment at the call site.

It is very unfortunate that your host doesn't have working
unaligned accesses. This puts you into the same bucket as
SPARC (i.e. a rare and not very well tested corner case) and
you're likely to find you have a lot of annoying cases
you need to track down to get things working.

> Each cached 16-bit access of a vring field therefore performs several
> distinct byte ld/st, which is a memory-tearing hazard for fields that
> the guest may access concurrently =E2=80=94 most notably avail->idx, wher=
e we
> find the guest can write a new value between the individual byte loads
> and produce a torn read that never existed in memory, as seen in logs
> like:
>   "Guest moved used index from 49417 to 49919"
> Here, 49919 (binary 1100 0010-1111 1111) is incorrectly assembled from
> the lower byte of 49663 (1100 0001-1111 1111) and the upper byte of
> 49664 (1100 0010-0000 0000).
>
> Add a parallel set of _aligned cached accessors so the fast (RAM) path
> emits a single aligned load instruction, eliminating the tearing window.
>
> Callers MUST ensure @addr is naturally aligned to the access size before
> invoking the _aligned helpers; the virtio vring layout guarantees this
> for avail->idx and other naturally-aligned fields.
>
> This patch fixes the memory-tearing hazard while also improves performanc=
e.
>
> Signed-off-by: BillXiang <xiangwencheng@lanxincomputing.com>

> diff --git a/include/qemu/bswap.h b/include/qemu/bswap.h
> index 387d65c..be9913c 100644
> --- a/include/qemu/bswap.h
> +++ b/include/qemu/bswap.h
> @@ -301,6 +301,11 @@ static inline int lduw_le_p(const void *ptr)
>      return (uint16_t)le_bswap(lduw_he_p(ptr), 16);
>  }
>
> +static inline int lduw_le_p_aligned(const void *ptr)
> +{
> +    return le16_to_cpu(*(uint16_t *)ptr);

If the pointer passed in must be a validly aligned one for a uint16_t,
we can make the argument be 'uint16_t*', not void*. Then the compiler
can give us some assistance about not passing the wrong type.

> +#define ADDRESS_SPACE_LD_CACHED_ALIGNED(size) \
> +    glue(glue(address_space_ld, size), glue(ENDIANNESS, _cached_aligned)=
)
> +#define ADDRESS_SPACE_LD_CACHED_SLOW(size) \
> +    glue(glue(address_space_ld, size), glue(ENDIANNESS, _cached_slow))
> +#define LD_P_ALIGNED(size) \
> +    glue(glue(ld, size), glue(ENDIANNESS, _p_aligned))
> +#define LD_PHYS_CACHED_ALIGNED(size) \
> +    glue(glue(ld, size), glue(ENDIANNESS, glue(_phys, _cached_aligned)))
> +
> +static inline uint16_t ADDRESS_SPACE_LD_CACHED_ALIGNED(uw)(MemoryRegionC=
ache *cache,
> +    hwaddr addr, MemTxAttrs attrs, MemTxResult *result)
> +{
> +    assert(addr < cache->len && 2 <=3D cache->len - addr);
> +    fuzz_dma_read_cb(cache->xlat + addr, 2, cache->mrs.mr);
> +    if (likely(cache->ptr)) {
> +        return LD_P_ALIGNED(uw)(cache->ptr + addr);
> +    } else {
> +        return ADDRESS_SPACE_LD_CACHED_SLOW(uw)(cache, addr, attrs, resu=
lt);
> +    }
> +}

I'm tempted to suggest some kind of "if pointer is aligned take
aligned path, otherwise take slow path" either here or actually
in lduw_le_p(), but maybe that's a bad idea. Richard ?

(I have a suspicion that other places than this one will assume
that an aligned ldl_he_p() is not going to tear.)

-- PMM

