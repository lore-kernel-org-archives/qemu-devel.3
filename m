Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC764C54E65
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 21:01:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHqYO-0002dM-5F; Wed, 21 May 2025 17:00:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uHqYC-0002cZ-Tm
 for qemu-devel@nongnu.org; Wed, 21 May 2025 17:00:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uHqYA-0002rA-4a
 for qemu-devel@nongnu.org; Wed, 21 May 2025 17:00:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747861228;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tPM8Q8KC2jlJZCIfPNHU2X9UqxtpMbIyJNccZNCX5oo=;
 b=JDu5vy4ReY3wvZhAXMfDP6CBF5DFYLZtGsb638dadWuPnFg6GhtYdlWEih/qdEETVkimkQ
 mJMy3eMpR9+IanopuycCLrIpdwuhyaylqrVPC3I4awWJvImTXkFRKn9tcaY8d10hRjHSlY
 axYG/NDgRpIAnj/qEqm+IHxd8+wfScM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-66-rmp_wK93OWeVmZVSYyE6Pg-1; Wed, 21 May 2025 17:00:26 -0400
X-MC-Unique: rmp_wK93OWeVmZVSYyE6Pg-1
X-Mimecast-MFC-AGG-ID: rmp_wK93OWeVmZVSYyE6Pg_1747861225
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3a35c8a7fd9so3083422f8f.1
 for <qemu-devel@nongnu.org>; Wed, 21 May 2025 14:00:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747861225; x=1748466025;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tPM8Q8KC2jlJZCIfPNHU2X9UqxtpMbIyJNccZNCX5oo=;
 b=JdZEdGTibWLg1dhY50oViy/tz3QG1piX0Oh+tCAHaE0rGb/gKwSDiYLAazvR1++ifs
 mSSMmy3XWFxIhkMGX/CmCY6PNN+tKaNADgyZrB57AKttNIxyZEbyap830OzDxs9iVdB/
 9v2tAkj7wyxonWoduCz7iBYD1fZX6BMrCNkyxdIx5sEelO+OG7Ctwfq8Pc0w0MhYITUO
 1nEdqgrSqGyX7MPv/kjIQi+o99kd5qju4awz/w7cZ2pkPr96AMBiqUjzE/GQ2be5CeN2
 TuRIx/ztbwS/kxlURhGNB4zZGQpJvwcWyvdwVaNJiI6xwks/NylQcHus7z7L5JbqyaaR
 PoRQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX5MzpleQr24uSFvbW9gtOYEyNkhYYy9Ydy7du7we0XYUbFggDk+yfkWRJ53gruUXCCF9VzXGWHzcak@nongnu.org
X-Gm-Message-State: AOJu0YyOLNZraRzQUq1Ns1x2Tvt3GHHOJZaXxHaQh8ZdFY6T2dzgW46H
 u5rGb7UgQow2cfZyY6vc8241MLFKswqH2oL2JVSBjk7T1LYQq6x4zgSaReYnTdR+YsUhirN+PBn
 8Um5+xw2cJNm1eCjUGV0eqou636wxH96Dov1JCIeEmTjxmI1soCUu/1GwWaK+utzJqy1bLijZK8
 FrSKomXl9JyO4xgupx/lp00JY9Td+KWk8=
X-Gm-Gg: ASbGncve5zsCdlE+tlgw0Fp929xTWIT3kTgoExQN1o3GIz5htKYGZOCPpS6XpeE86UB
 3K0HddxZFj8yxOmAiiFtGJjMAsLAgEY+YscxZrIb759H40jAEtXRXm7oWGRAk5RklDFA=
X-Received: by 2002:a05:6000:240e:b0:3a3:7117:1bba with SMTP id
 ffacd0b85a97d-3a371171d64mr12815029f8f.24.1747861224731; 
 Wed, 21 May 2025 14:00:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHvJyhHk+YBHa6LMZpm9YPQmXQddzQ+ukFlB9UmX0AIiueHd0HBpB7CvuEUU88Pk3J5tYypU9z46zAIl8wpCYs=
X-Received: by 2002:a05:6000:240e:b0:3a3:7117:1bba with SMTP id
 ffacd0b85a97d-3a371171d64mr12815000f8f.24.1747861224316; Wed, 21 May 2025
 14:00:24 -0700 (PDT)
MIME-Version: 1.0
References: <d3d1944e-2482-4aa7-b621-596246a08107@gnu.org>
 <aCysct2L8Bosqy0N@intel.com>
 <abe683f2-e679-4579-b68a-38a11d41e00b@gnu.org> <aC2R4BOR2tsYgEFI@intel.com>
 <CAHFMJ7vsgPtfkpBkjvh_-NqKszEDj5UpWThU3rPjN9N4X5s0tA@mail.gmail.com>
In-Reply-To: <CAHFMJ7vsgPtfkpBkjvh_-NqKszEDj5UpWThU3rPjN9N4X5s0tA@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 21 May 2025 23:00:11 +0200
X-Gm-Features: AX0GCFsTpOh5YtxtjZMKD_WAiop2q5DVcqeWDYswI3lila-8LHW2og-gyJDTgbI
Message-ID: <CABgObfYye21gpU=6btq3vT-7uj81qp7eWiuxb9Ztw2D7vWguJQ@mail.gmail.com>
Subject: Re: Rust in QEMU update, April 2025
To: Paolo Bonzini <bonzini@gnu.org>
Cc: Zhao Liu <zhao1.liu@intel.com>, qemu-devel <qemu-devel@nongnu.org>,
 qemu-rust@nongnu.org, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Daniel Berrange <berrange@redhat.com>, Kevin Wolf <kwolf@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>
Content-Type: multipart/alternative; boundary="0000000000006478990635aba7cb"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.184,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

--0000000000006478990635aba7cb
Content-Type: text/plain; charset="UTF-8"

Il mer 21 mag 2025, 10:37 Paolo Bonzini <bonzini@gnu.org> ha scritto:

> > So... not sure what to do there.  It seems like vm-memory is very close
> to
>
>> > being usable by QEMU, but maybe not completely. :(
>>
>> Is it possible or necessary for vm-memory to support overlap? Because I
>> feel that if it is possible, the problem might be simplified. (As a
>> beginner, I have yet to understand exactly how difficult it is.)
>>
>
> I don't think that's necessary. Just like in QEMU C code we have
> AddressSpace for DMA and MemoryRegion for hierarchy, in Rust code you have
> qemu_api::{AddressSpace,MemoryRegion}. FlatView, FlatRange,
> MemoryRegionSection are hidden in both cases, and users don't care much
> about which type implements GuestMemoryRegion because all they see is
> AddressSpace. Again, it's all hidden behind the prelude.
>
> The real problem is how hard it is to remove the references from the
> vm-memory API... Maybe not much.
>

Brain dump ahead! AddressSpaceDispatch is already storing
MemoryRegionSections. Therefore it should be possible to make
GuestMemory::R equal to MemoryRegionSection, or rather its Opaque wrapper.

Then one needs to implement Bytes<MemoryRegionAddress> in
MemoryRegionSection like
https://github.com/rust-vmm/vm-memory/blob/3f2fd80b11/src/mmap/mod.rs#L171,
use address_space_lookup_region() to implement find_region(), and (except
for IOMMU) everything should work.

To implement IOMMUs later, it's probably possible to call
flatview_translate() from the try_access() method, which is intended to be
internal but comes in handy here. try_access() is a bit complicated, but
we'll just have to copy some code from the default implementation at
https://github.com/rust-vmm/vm-memory/blob/main/src/guest_memory.rs, in
order to replace the call to find_region(). Notice how
address_space_lookup_region() returns MemoryRegionSection*, which
translates to Option<&Self::R>; while flatview_translate() returns a
MemoryRegionSection by value, that can become a local variable in
try_access() and everything is fine. Hopefully. The compiler will certainly
prove me wrong.

Another thing that will be needed later is support for MemTxAttrs. Maybe
squeeze those into the address, i.e. implement Bytes<(GuestAddress,
MemTxAttrs)> and Bytes<(MemoryRegionAddress, MemTxAttrs)>?

The dirty bitmap does need some changes in vm-memory, but it's pretty small
compared to the mess that I foreshadowed in order to change find_region().

Paolo

--0000000000006478990635aba7cb
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il mer 21 mag 2025, 10:37 Paolo Bonzini &lt;<a href=3D=
"mailto:bonzini@gnu.org" rel=3D"noreferrer noreferrer noreferrer noreferrer=
" target=3D"_blank">bonzini@gnu.org</a>&gt; ha scritto:<br></div><blockquot=
e class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px s=
olid rgb(204,204,204);padding-left:1ex"><div dir=3D"auto"><div>&gt; So... n=
ot sure what to do there.=C2=A0 It seems like vm-memory is very close to</d=
iv><div dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"gmail_=
quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,=
204);padding-left:1ex">
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
m-memory API... Maybe not much.</div></div></blockquote></div></div><div di=
r=3D"auto"><br></div><div dir=3D"auto">Brain dump ahead! AddressSpaceDispat=
ch is already storing MemoryRegionSections. Therefore it should be possible=
 to make GuestMemory::R equal to MemoryRegionSection, or rather its Opaque =
wrapper.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Then one needs =
to implement Bytes&lt;MemoryRegionAddress&gt; in MemoryRegionSection like <=
a href=3D"https://github.com/rust-vmm/vm-memory/blob/3f2fd80b11/src/mmap/mo=
d.rs#L171" rel=3D"noreferrer noreferrer" target=3D"_blank">https://github.c=
om/rust-vmm/vm-memory/blob/3f2fd80b11/src/mmap/mod.rs#L171</a>, use address=
_space_lookup_region() to implement find_region(), and (except for IOMMU) e=
verything should work.=C2=A0</div><div dir=3D"auto"><br></div><div dir=3D"a=
uto">To implement IOMMUs later, it&#39;s probably possible to call flatview=
_translate() from the try_access() method, which is intended to be internal=
 but comes in handy here. try_access() is a bit complicated, but we&#39;ll =
just have to copy some code from the default implementation at <a href=3D"h=
ttps://github.com/rust-vmm/vm-memory/blob/main/src/guest_memory.rs" rel=3D"=
noreferrer noreferrer noreferrer" target=3D"_blank">https://github.com/rust=
-vmm/vm-memory/blob/main/src/guest_memory.rs</a>, in order to replace the c=
all to find_region(). Notice how address_space_lookup_region() returns Memo=
ryRegionSection*, which translates to Option&lt;&amp;Self::R&gt;; while fla=
tview_translate() returns a MemoryRegionSection by value, that can become a=
 local variable in try_access() and everything is fine. Hopefully. The comp=
iler will certainly prove me wrong.</div><div dir=3D"auto"><br></div><div d=
ir=3D"auto">Another thing that will be needed later is support for MemTxAtt=
rs. Maybe squeeze those into the address, i.e. implement Bytes&lt;(GuestAdd=
ress, MemTxAttrs)&gt; and Bytes&lt;(MemoryRegionAddress, MemTxAttrs)&gt;?</=
div><div dir=3D"auto"><br></div><div dir=3D"auto">The dirty bitmap does nee=
d some changes in vm-memory, but it&#39;s pretty small compared to the mess=
 that I foreshadowed in order to change find_region().</div><div dir=3D"aut=
o"><br></div><div dir=3D"auto">Paolo</div></div>

--0000000000006478990635aba7cb--


