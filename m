Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C768EC54E65
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 08:37:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHewS-00009o-BX; Wed, 21 May 2025 04:36:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1uHewN-00009B-DO; Wed, 21 May 2025 04:36:43 -0400
Received: from mail-pl1-f175.google.com ([209.85.214.175])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1uHewK-0002ef-Pw; Wed, 21 May 2025 04:36:42 -0400
Received: by mail-pl1-f175.google.com with SMTP id
 d9443c01a7336-22e033a3a07so66542165ad.0; 
 Wed, 21 May 2025 01:36:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747816597; x=1748421397;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zhM6HwJw8T5AoaPZdLrn4eXNCke3sEFS3fuQCBPDh1I=;
 b=TdJ1ec9V/W3LSStcGNEUVPvQhBVSzS/JrYCSDlVP3qzpEaNxrNmLqvpUcEaFcm57t0
 D6uM8YxIfwGTPnSjuTh8JplzyEIoEVluXpbFgIb4skH48N5FvAzJGiK727t7FkaMA9E4
 BcguLQEhQ4r/DpTfVkO3QOeEwGGADEVlVyYMP7rgYjNxEeYQH8GIxN33JEZoAWW6/9s2
 kj5TSXZf/oG0ppKkU/i49xw+0+ltKDjyPUaBTqtnIODjrTX6UHE+bd+YkylCuxrJ5o2k
 FKjdZByOEp/2aRyg3hTytEBElKRUdHsWO/sDHHKbQL8WA0Cx0fq+JC1tNlGgZgd9fmvD
 7ysg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVgPASmdiWjUVvWbwAFYrNucJfiNnG7ZDmX6BqOO/hoNQB+bTE2hz2qPXuH5R8nYqpURcn0WYOF9BA=@nongnu.org
X-Gm-Message-State: AOJu0YxvFiZMA1H9cYi7TGYZlwZKPPc0xSy3FGTfRNOAdb+hIgob9VtK
 sUCLjXJJHY529WrybgfSZ0XcIw5/1jlzXQf0JuvISTQMfLClLXyhNXLBNf3uQcSVSnWheB7aQuK
 sMp0M0JS1NEpfD2iE4dCbfDJ4G49JHF8=
X-Gm-Gg: ASbGncsp67gnuytVygZnCjIAXIRhjN2QhA6dvCf+V82ieSTlgGXITTkgs+lRqWI/TaO
 c8EipLkomzJv+jQvp+L2ktA9mYRlAZWMEmv3P1yWxVr09Z8tk/eDhrpPQLKUQnsUgU95v5h5TX1
 QZToVowfPHgQwi2Lu4lzOM76RNOCsQHfI=
X-Google-Smtp-Source: AGHT+IGJjLrXcnS1zXceeJTmu2+GPz0yQnSqHUmmiiGT+bLpXqZq4/l5a0S2IqNcTI0DS+rgb/8F0WndXA9DtQFJF80=
X-Received: by 2002:a17:902:c951:b0:220:c4e8:3b9f with SMTP id
 d9443c01a7336-231d3536065mr264584425ad.0.1747816597194; Wed, 21 May 2025
 01:36:37 -0700 (PDT)
MIME-Version: 1.0
References: <d3d1944e-2482-4aa7-b621-596246a08107@gnu.org>
 <aCysct2L8Bosqy0N@intel.com>
 <abe683f2-e679-4579-b68a-38a11d41e00b@gnu.org> <aC2R4BOR2tsYgEFI@intel.com>
In-Reply-To: <aC2R4BOR2tsYgEFI@intel.com>
From: Paolo Bonzini <bonzini@gnu.org>
Date: Wed, 21 May 2025 10:36:26 +0200
X-Gm-Features: AX0GCFuLYcGrEu1DgI1RAfj-T_0HOFQrvSsd2lqp3vdHgRUMLLzGwsCBHG-T7Kk
Message-ID: <CAHFMJ7vsgPtfkpBkjvh_-NqKszEDj5UpWThU3rPjN9N4X5s0tA@mail.gmail.com>
Subject: Re: Rust in QEMU update, April 2025
To: Zhao Liu <zhao1.liu@intel.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-rust@nongnu.org, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Daniel Berrange <berrange@redhat.com>, Kevin Wolf <kwolf@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000688f3a0635a143bb"
Received-SPF: pass client-ip=209.85.214.175;
 envelope-from=paolo.bonzini@gmail.com; helo=mail-pl1-f175.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--000000000000688f3a0635a143bb
Content-Type: text/plain; charset="UTF-8"

Il mer 21 mag 2025, 10:21 Zhao Liu <zhao1.liu@intel.com> ha scritto:

> I also realize that once FlatRange/FlatView is associated with
> GuestMemoryRegion/
> GuestMemory, it changes the usual practice in QEMU, where most memory
> operations
> are built around MemoryRegion/AddressSpace.
>

That shouldn't be a problem. In QEMU and vm-memory DMA always starts from
Address space/GuestAddressSpace, not from MemoryRegion, so if QEMU
implements GuestAddressSpace in qemu_api::AddressSpace everything matches
well. The only difference is that Rust code will do something like

  AddressSpace::MEMORY::memory().read(...)

(which retrieves the FlatView) instead of

  address_space_read(&address_space_memory, ...)

But that's just how the API is defined. It seems good to me. The mismatch
between MemoryRegion and GuestMemoryRegion is confusing, but will be mostly
hidden behind the prelude because Guest* are traits not structs.

> So... not sure what to do there.  It seems like vm-memory is very close to
> > being usable by QEMU, but maybe not completely. :(
>
> Is it possible or necessary for vm-memory to support overlap? Because I
> feel that if it is possible, the problem might be simplified. (As a
> beginner, I have yet to understand exactly how difficult it is.)
>

I don't think that's necessary. Just like in QEMU C code we have
AddressSpace for DMA and MemoryRegion for hierarchy, in Rust code you have
qemu_api::{AddressSpace,MemoryRegion}. FlatView, FlatRange,
MemoryRegionSection are hidden in both cases, and users don't care much
about which type implements GuestMemoryRegion because all they see is
AddressSpace. Again, it's all hidden behind the prelude.

The real problem is how hard it is to remove the references from the
vm-memory API... Maybe not much.

Paolo


> Thanks,
> Zhao
>
>
>

--000000000000688f3a0635a143bb
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">Il mer 21 mag 2025, 10:21 Zhao L=
iu &lt;<a href=3D"mailto:zhao1.liu@intel.com">zhao1.liu@intel.com</a>&gt; h=
a scritto:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0=
 .8ex;border-left:1px #ccc solid;padding-left:1ex">I also realize that once=
 FlatRange/FlatView is associated with GuestMemoryRegion/<br>
GuestMemory, it changes the usual practice in QEMU, where most memory opera=
tions<br>
are built around MemoryRegion/AddressSpace.<br></blockquote></div></div><di=
v dir=3D"auto"><br></div><div dir=3D"auto">That shouldn&#39;t be a problem.=
 In QEMU and vm-memory DMA always starts from Address space/GuestAddressSpa=
ce, not from MemoryRegion, so if QEMU implements GuestAddressSpace in qemu_=
api::AddressSpace everything matches well. The only difference is that Rust=
 code will do something like</div><div dir=3D"auto"><br></div><div dir=3D"a=
uto">=C2=A0 AddressSpace::MEMORY::memory().read(...)</div><div dir=3D"auto"=
><br></div><div dir=3D"auto">(which retrieves the FlatView) instead of</div=
><div dir=3D"auto"><br></div><div dir=3D"auto">=C2=A0 address_space_read(&a=
mp;address_space_memory, ...)</div><div dir=3D"auto"><br></div><div dir=3D"=
auto">But that&#39;s just how the API is defined. It seems good to me. The =
mismatch between MemoryRegion and GuestMemoryRegion is confusing, but will =
be mostly hidden behind the prelude because Guest* are traits not structs.<=
/div><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quot=
e gmail_quote_container"><blockquote class=3D"gmail_quote" style=3D"margin:=
0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
&gt; So... not sure what to do there.=C2=A0 It seems like vm-memory is very=
 close to<br>
&gt; being usable by QEMU, but maybe not completely. :(<br>
<br>
Is it possible or necessary for vm-memory to support overlap? Because I<br>
feel that if it is possible, the problem might be simplified. (As a<br>
beginner, I have yet to understand exactly how difficult it is.)<br></block=
quote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">I don&#39;t=
 think that&#39;s necessary. Just like in QEMU C code we have AddressSpace =
for DMA and MemoryRegion for hierarchy, in Rust code you have qemu_api::{Ad=
dressSpace,MemoryRegion}. FlatView, FlatRange, MemoryRegionSection are hidd=
en in both cases, and users don&#39;t care much about which type implements=
 GuestMemoryRegion because all they see is AddressSpace. Again, it&#39;s al=
l hidden behind the prelude.</div><div dir=3D"auto"><br></div><div dir=3D"a=
uto">The real problem is how hard it is to remove the references from the v=
m-memory API... Maybe not much.</div><div dir=3D"auto"><br></div><div dir=
=3D"auto">Paolo</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div cla=
ss=3D"gmail_quote gmail_quote_container"><blockquote class=3D"gmail_quote" =
style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
Thanks,<br>
Zhao<br>
<br>
<br>
</blockquote></div></div></div>

--000000000000688f3a0635a143bb--

