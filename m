Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 784FEEED609
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 14:29:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sokoE-0003gj-UH; Thu, 12 Sep 2024 10:28:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sokns-0003Qd-96
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 10:28:15 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1soknp-0005l8-Sm
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 10:28:12 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5bef295a45bso580191a12.0
 for <qemu-devel@nongnu.org>; Thu, 12 Sep 2024 07:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726151288; x=1726756088; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XFZGkWmcdUAJu1BIOh4B6rVCtq63JMjYOuTjP/B4fh8=;
 b=v+FEdNNSF6o+JBIhdmbCQ6G86HOEERNPN2q9H//80uQ31lFwqKISxIDvMhBGaaaJqO
 mkgSQyRuWpVrGh3/3f+CxToOD3s9xQCr898IigRIX3nIHmlRp5DzPsBKpVg1Y5lcq8od
 ITUPEuLSn2rNR/ZeDXMgtTNC9qWv5RqY0rKVxeGBe16RqN9neiQ2sLuY9aLV+iJRdj7d
 CUaHIcuWIPalm13CFt+t07RIRPSCwTnfMTXqVpbKokXccc2D3gXK4h8VhRLiuaHxHfj8
 G5fDmeXuV2uAtOxNmFGAKsH6niEbRGzjblM8bB5Rf0aUzv+1CbIHKnu4In9+C7XAIOqv
 3gWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726151288; x=1726756088;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XFZGkWmcdUAJu1BIOh4B6rVCtq63JMjYOuTjP/B4fh8=;
 b=WZfFzgM+il6lky8cpdlEf4KfPfW5RxIk7eY3gAjgCjCkQrhz8r1g5C6j2/b0ZMRyzk
 hMEukBlNQwWSgS70Y/GCMqKbjhEG6P7eOFI/sRVd78q5GPXd/Y1boc0qIeMz89zq+V1r
 7uvgMTKn+4LgUf1899nAjjaeS1v1PEzYp+n75ZG2r7P9zoxQpNC7/RaXFDJD2sMs5+67
 vMsWU7fR47wlQG85YJ3DYxvDWazMe5QO8OABfH2DenAknZVymRwuHCjIFy0+oymc6ohP
 VG6e4DehgdR0RXLULTQwFh/7k76PSgX9LZB2Vzbhfz+18ORb6aVcUCJKv0RbPgEZpkzd
 KFAQ==
X-Gm-Message-State: AOJu0YwfJ3db7MdujXnFpdZNUiKojsKkTq8ySat0WKmKwqdMEhf3Bp3o
 A7snJdByceQbqZaXThFl3R/GTAJ3XtAzvtLa+EHzlgniRDqV4JtP2IkEQyG3O2P3plRi6ocMJEJ
 9NiZ6OQ8/1/BP3kZX28cf0rZd9yr6DNWvyApBqHhYOS3Z9ASP
X-Google-Smtp-Source: AGHT+IEdzCOFVrEU6flzf5WLA8wBqbaUeUvRM2B21EvHgllq4IbyL0ixKk7kbvR+BMmPYfAq6RxEj+uELib943fA774=
X-Received: by 2002:a05:6402:40cb:b0:5c4:14b7:b3bf with SMTP id
 4fb4d7f45d1cf-5c414b7b7e6mr2708204a12.8.1726151287701; Thu, 12 Sep 2024
 07:28:07 -0700 (PDT)
MIME-Version: 1.0
References: <20240819135455.2957406-1-mnissler@rivosinc.com>
In-Reply-To: <20240819135455.2957406-1-mnissler@rivosinc.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 12 Sep 2024 15:27:55 +0100
Message-ID: <CAFEAcA-pVJozMoPnUU9TO=0KKH3iR95rf7XLj9EuaM7+Q-VZoQ@mail.gmail.com>
Subject: Re: [PATCH] softmmu: Support concurrent bounce buffers
To: Mattias Nissler <mnissler@rivosinc.com>
Cc: qemu-devel@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 stefanha@redhat.com, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52b.google.com
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

On Mon, 19 Aug 2024 at 14:56, Mattias Nissler <mnissler@rivosinc.com> wrote=
:
>
> When DMA memory can't be directly accessed, as is the case when
> running the device model in a separate process without shareable DMA
> file descriptors, bounce buffering is used.
>
> It is not uncommon for device models to request mapping of several DMA
> regions at the same time. Examples include:
>  * net devices, e.g. when transmitting a packet that is split across
>    several TX descriptors (observed with igb)
>  * USB host controllers, when handling a packet with multiple data TRBs
>    (observed with xhci)
>
> Previously, qemu only provided a single bounce buffer per AddressSpace
> and would fail DMA map requests while the buffer was already in use. In
> turn, this would cause DMA failures that ultimately manifest as hardware
> errors from the guest perspective.
>
> This change allocates DMA bounce buffers dynamically instead of
> supporting only a single buffer. Thus, multiple DMA mappings work
> correctly also when RAM can't be mmap()-ed.
>
> The total bounce buffer allocation size is limited individually for each
> AddressSpace. The default limit is 4096 bytes, matching the previous
> maximum buffer size. A new x-max-bounce-buffer-size parameter is
> provided to configure the limit for PCI devices.
>
> Signed-off-by: Mattias Nissler <mnissler@rivosinc.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Acked-by: Peter Xu <peterx@redhat.com>
> ---

> @@ -3251,28 +3265,40 @@ void *address_space_map(AddressSpace *as,
>      mr =3D flatview_translate(fv, addr, &xlat, &l, is_write, attrs);
>
>      if (!memory_access_is_direct(mr, is_write)) {
> -        if (qatomic_xchg(&as->bounce.in_use, true)) {
> +        size_t used =3D qatomic_read(&as->bounce_buffer_size);
> +        for (;;) {
> +            hwaddr alloc =3D MIN(as->max_bounce_buffer_size - used, l);
> +            size_t new_size =3D used + alloc;
> +            size_t actual =3D
> +                qatomic_cmpxchg(&as->bounce_buffer_size, used, new_size)=
;
> +            if (actual =3D=3D used) {
> +                l =3D alloc;
> +                break;
> +            }
> +            used =3D actual;
> +        }
> +
> +        if (l =3D=3D 0) {
>              *plen =3D 0;
>              return NULL;
>          }
> -        /* Avoid unbounded allocations */
> -        l =3D MIN(l, TARGET_PAGE_SIZE);
> -        as->bounce.buffer =3D qemu_memalign(TARGET_PAGE_SIZE, l);
> -        as->bounce.addr =3D addr;
> -        as->bounce.len =3D l;
>
> +        BounceBuffer *bounce =3D g_malloc0(l + sizeof(BounceBuffer));
> +        bounce->magic =3D BOUNCE_BUFFER_MAGIC;
>          memory_region_ref(mr);
> -        as->bounce.mr =3D mr;
> +        bounce->mr =3D mr;
> +        bounce->addr =3D addr;
> +        bounce->len =3D l;
> +
>          if (!is_write) {
>              flatview_read(fv, addr, MEMTXATTRS_UNSPECIFIED,
> -                          as->bounce.buffer, l);
> +                          bounce->buffer, l);
>          }
>
>          *plen =3D l;
> -        return as->bounce.buffer;
> +        return bounce->buffer;

Coverity is pretty unhappy about this trick, because it isn't able
to recognise that we can figure out the address of 'bounce'
from the address of 'bounce->buffer' and free it in the
address_space_unmap() code, so it thinks that every use
of address_space_map(), pci_dma_map(), etc, is a memory leak.
We can mark all those as false positives, of course, but it got
me wondering whether maybe we should have this function return
a struct that has all the information address_space_unmap()
needs rather than relying on it being able to figure it out
from the host memory pointer...

-- PMM

