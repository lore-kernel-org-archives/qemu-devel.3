Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6081C04FFE
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 06:34:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4as6-0003oP-Kp; Wed, 08 May 2024 02:33:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mnissler@rivosinc.com>)
 id 1s4as2-0003ns-Le
 for qemu-devel@nongnu.org; Wed, 08 May 2024 02:33:43 -0400
Received: from mail-oi1-x233.google.com ([2607:f8b0:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mnissler@rivosinc.com>)
 id 1s4as0-00012b-Ed
 for qemu-devel@nongnu.org; Wed, 08 May 2024 02:33:42 -0400
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-3c96fef64b3so1495150b6e.3
 for <qemu-devel@nongnu.org>; Tue, 07 May 2024 23:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1715150018; x=1715754818;
 darn=nongnu.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fvILrFRForNTl8VXLWrJA1pxVkK9CSrUPLjvH+tJSUU=;
 b=WRkEMpJNzvBwR9sqAco3MnnnuM2KRqCshUNXboL3P+pyYLZ+wEgBDhWa2RSzU28iGG
 lquyZwmKb6QssxJoMglTD83i1X303Hb4yrHKFD+BVBvxbGHLftvW1GPwbvtRMWn677v3
 llJTCY6GASKP2zSXuLCxJMpSMJiOcyDcSyT9PwohG+KMCYi98SzUPMH41QnkXz8MPB87
 G1L2Y0wkbgvVEkf6x+fioJ3+Te/aPHJYg8+iLgZQZ4HF5tAE8iNUopOnZo6kMKzGyZ7X
 7hckq7i+J1wGrqxiUQgRLNtgY6sm6fzt9rHahQaVQf3Sqha1t1TwmakX1Cz+DZLjRqUm
 ym4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715150018; x=1715754818;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fvILrFRForNTl8VXLWrJA1pxVkK9CSrUPLjvH+tJSUU=;
 b=R80ZM5qr1OFT2P/hoGg241Vfhlz5lJ3RskvzcqfTNpzjKp64R6dE75wCdl12y1NS4/
 q2aqhP8ZBzBv/QSqeJSnhPvQVV1jKzfXoqW4dZpRA0DxPizp6wXSA6he2WoZBn8KtY6k
 12mStVUdilIaT02r6eCACLpv0S3AP6xoPZ2mvGCd0DAIjQj+j5r8xGuKxggxmuh+3u50
 ZzrMipIGvvoodrTTKyPDavC0uVG5gfEzN5p0Uup4rV3FoDFhahI8t9s4LxtGX6bDws5z
 KwSgdkz6jcJcVfkfmW+ygIZ/6pocRu9zJL1/vLprp08mB6XGNbVD/8wvhwxKk1qZxRy6
 XzMQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW6kU8NPeMvOiP2GZDQY9IWDBSJeAjczz2HGDfT5kR95tbEdNJhohQ1y0zU1++lDJyTQ2CfNlZXth+ELSNV7qfXDuj9uHA=
X-Gm-Message-State: AOJu0YyzP0qvq3QTXEhOZ8saSFecQduTRBTcbpIJRv+nz+7UhU0ET8VE
 PAZ1e0zPkysXW/w1FfS6RPZPyc478GfQ4Uku/l9z50dj1Bm817RzEy1HKt76QDAD66cxczwODgI
 271DAu5ucnq47YJd6QjVjrYAM0p9bqP2j+jcHvA==
X-Google-Smtp-Source: AGHT+IFMxlcbQCWHMSfRnSwVcwMwC/KprG5dUmLJDq+D7AvtwoDhjjgy9zzIfBwPfS1vzA/8X58OFOsanN5rQpKEWSw=
X-Received: by 2002:a05:6870:5246:b0:22e:b2da:af39 with SMTP id
 586e51a60fabf-2409892e77cmr1807775fac.47.1715150018119; Tue, 07 May 2024
 23:33:38 -0700 (PDT)
MIME-Version: 1.0
References: <20240507094210.300566-1-mnissler@rivosinc.com>
 <20240507094210.300566-3-mnissler@rivosinc.com>
 <447ddc5a-ae1e-4fd1-b03a-dd7e1faa46e9@linaro.org>
 <CAGNS4Tb1FVFmzVLvSZD84n0q80bwDiAMaSr752jb4nDwkGHSjA@mail.gmail.com>
 <b239ed9c-df6c-4785-91cc-fb7139997209@linaro.org>
In-Reply-To: <b239ed9c-df6c-4785-91cc-fb7139997209@linaro.org>
From: Mattias Nissler <mnissler@rivosinc.com>
Date: Wed, 8 May 2024 08:33:27 +0200
Message-ID: <CAGNS4TbG2=mqzfRjNsSueQCNGbBvPP0DdXLVO7Pg8YfpTmpwTA@mail.gmail.com>
Subject: Re: [PATCH v9 2/5] softmmu: Support concurrent bounce buffers
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: stefanha@redhat.com, qemu-devel@nongnu.org, peterx@redhat.com, 
 jag.raman@oracle.com, "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 David Hildenbrand <david@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Elena Ufimtseva <elena.ufimtseva@oracle.com>, john.levon@nutanix.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::233;
 envelope-from=mnissler@rivosinc.com; helo=mail-oi1-x233.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Tue, May 7, 2024 at 4:46=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 <philmd@=
linaro.org> wrote:
>
> On 7/5/24 16:04, Mattias Nissler wrote:
> > On Tue, May 7, 2024 at 2:57=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 <phi=
lmd@linaro.org> wrote:
> >>
> >> On 7/5/24 11:42, Mattias Nissler wrote:
> >>> When DMA memory can't be directly accessed, as is the case when
> >>> running the device model in a separate process without shareable DMA
> >>> file descriptors, bounce buffering is used.
> >>>
> >>> It is not uncommon for device models to request mapping of several DM=
A
> >>> regions at the same time. Examples include:
> >>>    * net devices, e.g. when transmitting a packet that is split acros=
s
> >>>      several TX descriptors (observed with igb)
> >>>    * USB host controllers, when handling a packet with multiple data =
TRBs
> >>>      (observed with xhci)
> >>>
> >>> Previously, qemu only provided a single bounce buffer per AddressSpac=
e
> >>> and would fail DMA map requests while the buffer was already in use. =
In
> >>> turn, this would cause DMA failures that ultimately manifest as hardw=
are
> >>> errors from the guest perspective.
> >>>
> >>> This change allocates DMA bounce buffers dynamically instead of
> >>> supporting only a single buffer. Thus, multiple DMA mappings work
> >>> correctly also when RAM can't be mmap()-ed.
> >>>
> >>> The total bounce buffer allocation size is limited individually for e=
ach
> >>> AddressSpace. The default limit is 4096 bytes, matching the previous
> >>> maximum buffer size. A new x-max-bounce-buffer-size parameter is
> >>> provided to configure the limit for PCI devices.
> >>>
> >>> Signed-off-by: Mattias Nissler <mnissler@rivosinc.com>
> >>> ---
> >>>    hw/pci/pci.c                |  8 ++++
> >>>    include/exec/memory.h       | 14 +++----
> >>>    include/hw/pci/pci_device.h |  3 ++
> >>>    system/memory.c             |  5 ++-
> >>>    system/physmem.c            | 82 ++++++++++++++++++++++++++-------=
----
> >>>    5 files changed, 76 insertions(+), 36 deletions(-)
>
>
> >>>    /**
> >>>     * struct AddressSpace: describes a mapping of addresses to #Memor=
yRegion objects
> >>> @@ -1143,8 +1137,10 @@ struct AddressSpace {
> >>>        QTAILQ_HEAD(, MemoryListener) listeners;
> >>>        QTAILQ_ENTRY(AddressSpace) address_spaces_link;
> >>>
> >>> -    /* Bounce buffer to use for this address space. */
> >>> -    BounceBuffer bounce;
> >>> +    /* Maximum DMA bounce buffer size used for indirect memory map r=
equests */
> >>> +    uint32_t max_bounce_buffer_size;
> >>
> >> Alternatively size_t.
> >
> > While switching things over, I was surprised to find that
> > DEFINE_PROP_SIZE wants a uint64_t field rather than a size_t field.
> > There is a DEFINE_PROP_SIZE32 variant for uint32_t though. Considering
> > my options, assuming that we want to use size_t for everything other
> > than the property:
> >
> > (1) Make PCIDevice::max_bounce_buffer_size size_t and have the
> > preprocessor select DEFINE_PROP_SIZE/DEFINE_PROP_SIZE32. This makes
> > the qdev property type depend on the host. Ugh.
> >
> > (2) Make PCIDevice::max_bounce_buffer_size uint64_t and clamp if
> > needed when used. Weird to allow larger values that are then clamped,
> > although it probably doesn't matter in practice since address space is
> > limited to 4GB anyways.
> >
> > (3) Make PCIDevice::max_bounce_buffer_size uint32_t and accept the
> > limitation that the largest bounce buffer limit is 4GB even on 64-bit
> > hosts.
> >
> > #3 seemed most pragmatic, so I'll go with that.
>
> LGTM, thanks for updating.

No problem, can I ask you to provide a formal R-B on the v10 #4 patch
[1] then, so the series will be ready to go in?

[1] https://lists.nongnu.org/archive/html/qemu-devel/2024-05/msg01382.html

>
> >
> >
> >>
> >>> +    /* Total size of bounce buffers currently allocated, atomically =
accessed */
> >>> +    uint32_t bounce_buffer_size;
> >>
> >> Ditto.
>

