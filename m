Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0C4AC2D0CD
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 09:36:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHfrQ-00084a-98; Wed, 21 May 2025 05:35:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uHfrP-00084S-6y
 for qemu-devel@nongnu.org; Wed, 21 May 2025 05:35:39 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uHfrL-0000y4-Ro
 for qemu-devel@nongnu.org; Wed, 21 May 2025 05:35:38 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-ad216a5a59cso925277866b.3
 for <qemu-devel@nongnu.org>; Wed, 21 May 2025 02:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747820133; x=1748424933; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AWBAKfnqZycymN3WJWS0hkWG8MSAZGAaCy5DopdBUIs=;
 b=Smq99zMCpLXX6b/PHWFLqSOdxDmg/PZGKzgo3gXlwkHZ1w0IRiJWNOkrBhZZ5e6Usd
 UEWcZAx7RlgUtidfI9SAjHm1Xw3MQJYj/Wa6U6qp97h8CmpXPzGwbMMofOhLYIVAPOA0
 5AwagxRpR97ahs8Qrq53A4HhT9NBVsMx12vL48C+gtXYqxtXBaNP9z6b7B8bGlBiOR/q
 ZD4INB6UIiGjxal0bAYmyUTLsE7jl6O60dMBiiHiOSUPfKWWhcA7ihooRdqEgQoOz1rg
 7GnkSCRe1Ned4eRx+8L5unpU36SXDN938Lcq6gMNhYEmnmyJZ8yfR+az0fb/RIG+yxcz
 dcYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747820133; x=1748424933;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AWBAKfnqZycymN3WJWS0hkWG8MSAZGAaCy5DopdBUIs=;
 b=i4HNsviC19WU08BBNCuOXyQFLTqrNPAg/RfqooHxJqcJj///ry7F+x2A+IA1ZdQn6d
 4D9ADmBS6yB7t3RG4SPYyblteWirnFOBEzJmPtJarZGDci7NyPZ6yxaNPhrs2G2Tjk34
 37c9LcXonbWAE7TXjoTgHeiVz/cc6E3fgLzQRg3vCRMTj182bPDwODxifblBii3ZyUUx
 W35hOZkFQw3WaztvhyhZhu1nZsbnyKArVXSiCcrpJ4aiKALIoWWzjfdcScGHNpXadu4Y
 OKb9K9X8w6VVSM9MYvkfFF6dEKpsNV7/j81VdWM8igHiXAtS6kHtKBJboxDkZvIaePPb
 +p7A==
X-Forwarded-Encrypted: i=1;
 AJvYcCV/muqD3JUxtckcFhQQLCC4t7flwkGub349JbRgVWlfPuRI874OP32XEM7zFqXSYttuTHxFaMkNUUZB@nongnu.org
X-Gm-Message-State: AOJu0YwUN/b9ziC7i5P009ZpnFI7KU2MlWH5NDlYwKvGGw2ud/rz7LBx
 aWuKyacJ+52YOqKMgmLA6q40eTB35eozCmagd41fkGzW5BgmzMnvgv52Vsk5Y6qMFdIFF17fRwg
 YV4sUdXcmcWIbXET9Rb+4V/gZKGrh49o9lZdTSpQebQ==
X-Gm-Gg: ASbGncvUP2+riEbicap1y9HkB5iggIv2tpgip+sWUi9DKTnI639RBlBMR77UH4sxmNq
 y6udLZeN40T36FNaEvzdy7xh4WKMIhfHRoD9k7xeRZiIuY4eaNJdr4Y4g68uIgnpLU40tzD2TrF
 vXYOz8RUfDm3v9X0Nrx4Czk+rW6J1ygFKhCx9gkjg=
X-Google-Smtp-Source: AGHT+IHF9LH01an0iC3l0lzCYZnI+jsjds66HFA1ceOas2GWN/PTYemUEapZO9OmTMVWNgWwwDhESId088qOd2H7W1k=
X-Received: by 2002:a17:907:3d11:b0:ad2:35db:a727 with SMTP id
 a640c23a62f3a-ad52d4ce22cmr1746038766b.19.1747820133086; Wed, 21 May 2025
 02:35:33 -0700 (PDT)
MIME-Version: 1.0
References: <d3d1944e-2482-4aa7-b621-596246a08107@gnu.org>
 <aCysct2L8Bosqy0N@intel.com>
 <abe683f2-e679-4579-b68a-38a11d41e00b@gnu.org> <aC2R4BOR2tsYgEFI@intel.com>
 <CAHFMJ7vsgPtfkpBkjvh_-NqKszEDj5UpWThU3rPjN9N4X5s0tA@mail.gmail.com>
In-Reply-To: <CAHFMJ7vsgPtfkpBkjvh_-NqKszEDj5UpWThU3rPjN9N4X5s0tA@mail.gmail.com>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Wed, 21 May 2025 12:35:06 +0300
X-Gm-Features: AX0GCFvOlyMEhDT6bjmixXQ4M3gY5B9KXrKZvlcMcIErp3GVIO3_-Gp59oRl6M8
Message-ID: <CAAjaMXb01Y3qoH56j4GsfJLQMRkA067mHjiWS86cr95akh4ckg@mail.gmail.com>
Subject: Re: Rust in QEMU update, April 2025
To: Paolo Bonzini <bonzini@gnu.org>
Cc: Zhao Liu <zhao1.liu@intel.com>, qemu-devel <qemu-devel@nongnu.org>,
 qemu-rust@nongnu.org, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Daniel Berrange <berrange@redhat.com>, Kevin Wolf <kwolf@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x629.google.com
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

On Wed, May 21, 2025 at 11:36=E2=80=AFAM Paolo Bonzini <bonzini@gnu.org> wr=
ote:
>
>
>
> Il mer 21 mag 2025, 10:21 Zhao Liu <zhao1.liu@intel.com> ha scritto:
>>
>> I also realize that once FlatRange/FlatView is associated with GuestMemo=
ryRegion/
>> GuestMemory, it changes the usual practice in QEMU, where most memory op=
erations
>> are built around MemoryRegion/AddressSpace.
>
>
> That shouldn't be a problem. In QEMU and vm-memory DMA always starts from=
 Address space/GuestAddressSpace, not from MemoryRegion, so if QEMU impleme=
nts GuestAddressSpace in qemu_api::AddressSpace everything matches well. Th=
e only difference is that Rust code will do something like
>
>   AddressSpace::MEMORY::memory().read(...)
>
> (which retrieves the FlatView) instead of
>
>   address_space_read(&address_space_memory, ...)
>
> But that's just how the API is defined. It seems good to me. The mismatch=
 between MemoryRegion and GuestMemoryRegion is confusing, but will be mostl=
y hidden behind the prelude because Guest* are traits not structs.
>
>> > So... not sure what to do there.  It seems like vm-memory is very clos=
e to
>> > being usable by QEMU, but maybe not completely. :(
>>
>> Is it possible or necessary for vm-memory to support overlap? Because I
>> feel that if it is possible, the problem might be simplified. (As a
>> beginner, I have yet to understand exactly how difficult it is.)
>
>
> I don't think that's necessary. Just like in QEMU C code we have AddressS=
pace for DMA and MemoryRegion for hierarchy, in Rust code you have qemu_api=
::{AddressSpace,MemoryRegion}. FlatView, FlatRange, MemoryRegionSection are=
 hidden in both cases, and users don't care much about which type implement=
s GuestMemoryRegion because all they see is AddressSpace. Again, it's all h=
idden behind the prelude.
>
> The real problem is how hard it is to remove the references from the vm-m=
emory API... Maybe not much.
>
> Paolo
>
>>
>> Thanks,
>> Zhao
>>
>>

vm-memory is a very rigid API unfortunately. It's excellent for
rust-vmm purposes. I presume it's possible to figure out a clever
solution to satisfy both rust-vmm and QEMU use needs but I'm not sure
it's worth it. It's really hard to retrofit other projects into
vm-memory if they don't use rust-vmm crates API design and it might
make both rust-vmm code and QEMU code more complex. QEMU would depend
on rust-vmm architectural decisions and vice-versa. The thing I'm
fearing most is needing to refactor memory APIs in QEMU in the future
and turn the vm-memory dependency into technical debt.

Perhaps it's more sensible to not use external dependencies to wrap
over our APIs but we can surely design our Rust bindings inspired by
them. I think it's an inescapable consequence of QEMU's internals
being fluid over time and "private"/unstable.

Personal anecdote: I tried using vm-memory on a personal TCG-like
emulator I am writing for fun, and I found it a daunting task as new
rust-vmm concepts appeared into my codebase as "scope creep". And I
wasn't even adapting an existing API to vm-memory, but designing a new
one based on it. I gave it up after a few days.

--=20
Manos Pitsidianakis
Emulation and Virtualization Engineer at Linaro Ltd

