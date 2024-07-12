Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6C91C3DA45
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2024 02:07:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sS5gh-0002iK-RZ; Thu, 11 Jul 2024 22:07:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stevensd@chromium.org>)
 id 1sS5gf-0002ha-SU
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 22:07:05 -0400
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stevensd@chromium.org>)
 id 1sS5gd-0002OL-MO
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 22:07:05 -0400
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-52ea16b429dso2073515e87.1
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2024 19:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1720750021; x=1721354821; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L1wiotKe7HCDQB9FsVX+8qxtS4dfQhX4k1w4EolP20I=;
 b=H8zVlSnE3eLxv8BnU4hD+K9diLdeGeXK4lzs2G8hyKn7SEuJzJMy5WXCwDveXwSJEJ
 /hSNX8Joy71d3EE4vBPP8nGKHNzP52KcCU1qXegdEAoAE12I3fHbuvvZHbLeZTWNMQWA
 QansCrinEe/78yeR4kwJbAV161XS/63IhMGmg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720750021; x=1721354821;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=L1wiotKe7HCDQB9FsVX+8qxtS4dfQhX4k1w4EolP20I=;
 b=BWv4AhjH/TbTdR5dvGxLElMEN/I1CgyAGlzwzq/HNie29Oy4QZ5Qg+JLpyutxm8iYA
 hUlZOoeoB7bSJs1U9h6SsP5ksL1L4e78+LDFHWVQxlbgOTnaTxCpArDDCECin5ip8IaA
 iHbLiToc4H1aJWJOO+918e8qDbnXrzz/ZdRQjczvm3ROrPZp8ZCFBMbrw5bFKphCpN8m
 LSwTl7kIMNxeTB1sdottEnnNq/1kgIe/HswV8KQm0AFfZywL2vjSqSz3CDNah/7IYGEI
 X54LRBPVXXT5cdBArvndo6szWBUM0rt+Lp6CGCAcFTPmCcLRnegki0pY9vxT7xgmBdlP
 js5g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVaZ3Sv/JfLg1NnaXVKRX6QBhCIKsF5qFmf6Spw6YIvh5e6jtjyuCt3Hizt8Ii4gcMlzs3DV2RQ/2e4BW0BjWG8vYvpgog=
X-Gm-Message-State: AOJu0YxBr/j/R4m05hH7QViLt+yrcXDOqdGkpDb976NIj+LgJBVApoum
 WHrV0G9S6MgPpf9vOXpCRIQiBjSW5s2tAmco8RRAQqYGT/UMzjzUoR9XS0C9aDi4osxzretrV3V
 ewUEJYatuGVFKEdfc5KOvOd7yGn3Vk9Rgh5JT
X-Google-Smtp-Source: AGHT+IEHDn4GguTvYL3PXSIMYmiwFuysznehbkhMSAxmzPnjZIcKxeXWsdGcgDXJuvcYeUVXtTS6i3ueAEAgpglD/+A=
X-Received: by 2002:a05:6512:1246:b0:52e:9376:83aa with SMTP id
 2adb3069b0e04-52ecb6359c3mr328399e87.19.1720750020974; Thu, 11 Jul 2024
 19:07:00 -0700 (PDT)
MIME-Version: 1.0
References: <20240628145710.1516121-1-aesteve@redhat.com>
 <87bk34i4dy.fsf@alyssa.is>
In-Reply-To: <87bk34i4dy.fsf@alyssa.is>
From: David Stevens <stevensd@chromium.org>
Date: Fri, 12 Jul 2024 11:06:49 +0900
Message-ID: <CAD=HUj7av_8Epkd0Fe0eWR7Z4bZMTuvTNgqzYoQcOzFQ82wvOg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/5] vhost-user: Add SHMEM_MAP/UNMAP requests
To: Alyssa Ross <hi@alyssa.is>
Cc: Albert Esteve <aesteve@redhat.com>, qemu-devel@nongnu.org,
 jasowang@redhat.com, david@redhat.com, slp@redhat.com,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 stefanha@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::12d;
 envelope-from=stevensd@chromium.org; helo=mail-lf1-x12d.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Thu, Jul 11, 2024 at 7:56=E2=80=AFPM Alyssa Ross <hi@alyssa.is> wrote:
>
> Adding David Stevens, who implemented SHMEM_MAP and SHMEM_UNMAP in
> crosvm a couple of years ago.
>
> David, I'd be particularly interested for your thoughts on the MEM_READ
> and MEM_WRITE commands, since as far as I know crosvm doesn't implement
> anything like that.  The discussion leading to those being added starts
> here:
>
> https://lore.kernel.org/qemu-devel/20240604185416.GB90471@fedora.redhat.c=
om/
>
> It would be great if this could be standardised between QEMU and crosvm
> (and therefore have a clearer path toward being implemented in other VMMs=
)!

Setting aside vhost-user for a moment, the DAX example given by Stefan
won't work in crosvm today.

Is universal access to virtio shared memory regions actually mandated
by the virtio spec? Copying from virtiofs DAX to virtiofs sharing
seems reasonable enough, but what about virtio-pmem to virtio-blk?
What about screenshotting a framebuffer in virtio-gpu shared memory to
virtio-scsi? I guess with some plumbing in the VMM, it's solvable in a
virtualized environment. But what about when you have real hardware
that speaks virtio involved? That's outside my wheelhouse, but it
doesn't seem like that would be easy to solve.

For what it's worth, my interpretation of the target scenario:

> Other backends don't see these mappings. If the guest submits a vring
> descriptor referencing a mapping to another backend, then that backend
> won't be able to access this memory

is that it's omitting how the implementation is reconciled with
section 2.10.1 of v1.3 of the virtio spec, which states that:

> References into shared memory regions are represented as offsets from
> the beginning of the region instead of absolute memory addresses. Offsets
> are used both for references between structures stored within shared
> memory and for requests placed in virtqueues that refer to shared memory.

My interpretation of that statement is that putting raw guest physical
addresses corresponding to virtio shared memory regions into a vring
is a driver spec violation.

-David

