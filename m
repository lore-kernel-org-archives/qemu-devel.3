Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EB2EC02196
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 08:47:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfxXY-0007Sf-Dx; Thu, 06 Feb 2025 03:47:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tfxXW-0007Ru-GI
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 03:47:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tfxXU-0001BK-26
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 03:47:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738831629;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EcWn8gSOffuGG6xc/qk0gAVlgO1wnVL90OnmFr38kqo=;
 b=LcYRkOPir4VjoRtm20ed3OzvnDTqk02aIhTkDZYqx4hakE60bfKqTyJkUqtLhML8SuYryh
 LqWCu7+yLuUKQ2R5nf7eVB7+5890t/6CG9sWXFvh521zfKLWQVyLi8sY82LIdGTD0nUQkE
 2VFQ++PljcN9UaTlqnnbvQyFNklyJmc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-kouPnx08NCmtXHBVuxyNrQ-1; Thu, 06 Feb 2025 03:47:08 -0500
X-MC-Unique: kouPnx08NCmtXHBVuxyNrQ-1
X-Mimecast-MFC-AGG-ID: kouPnx08NCmtXHBVuxyNrQ
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-38dafe1699cso356950f8f.3
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 00:47:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738831627; x=1739436427;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EcWn8gSOffuGG6xc/qk0gAVlgO1wnVL90OnmFr38kqo=;
 b=saeKL4twqOfz5z31SRe+gtKYN9sSagK9rfoCiWbONFlWdfk8IK68QvBdUzCkDzhibI
 MMTC0GEie6FnHXIqMsiKBQkLlci2o51/vD/RNe+8B0Z1kyJKc38Ah84KDvo366hVw49h
 Wyq3x2L84wQnmZ1Hpe+93i8wxrdnho8NwXC6+vjFYLdBPJGi5o0LcCKN93TBEW5mU9+a
 9qvsMz9UMF6y5SBGIeK001wKIvkk6+r9JJfE/fobSFotUwHRiHciRed9CuNlsGenL/pT
 tgOpMyaDTu39K1OZKlJzZwIiqhbjpe+W9vYri/+h74mg1Xrgkp/qoMNCSYFP1FCOTGP9
 TAFA==
X-Gm-Message-State: AOJu0YwGfH3Xi6SqYiI1uqGPlb4lg9XbYiQlLRo/8tdXC3EUsPxE8YHe
 9u87nYmniaC1d1ruqgKSRfTPkE0l2fvDiPKoGnUcmpDJT4YN95UAlwpSXXkWL2bAZqKF87SILm+
 jsXlK1A0xNvMFpASKebmjl60+VqNUiRIe3A6Je6fEJNlVjacZIBN+dXIqGsB4683Ag8f2rGijQ6
 /fjC90iSKht7Gu5BX7yUVfAC95QDA=
X-Gm-Gg: ASbGnctInyEHsYulowEgrO2zSjDF6SYEXf6CVBd/uuWnyz3S9YGwobQib/Jz1hW7UDm
 /yNW0VCO/5wziDiYIdYNVBnu5OvLMsHEQHdU4o7HdwhWgpVbkASiYCwuRTrjk
X-Received: by 2002:adf:ef89:0:b0:38d:a883:b95b with SMTP id
 ffacd0b85a97d-38db48a42f8mr5028509f8f.28.1738831626951; 
 Thu, 06 Feb 2025 00:47:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFlxdf4q9l9eLa8gvhUvQS1NxRxxKh+gU5zLlUtK7r/0iHxQr3yjDcucAXdBkr+sCnb84nyiLgU65nathbfMiA=
X-Received: by 2002:adf:ef89:0:b0:38d:a883:b95b with SMTP id
 ffacd0b85a97d-38db48a42f8mr5028479f8f.28.1738831626400; Thu, 06 Feb 2025
 00:47:06 -0800 (PST)
MIME-Version: 1.0
References: <20250117194003.1173231-1-pbonzini@redhat.com>
 <20250117194003.1173231-11-pbonzini@redhat.com>
 <7e35b5b6-01dd-457b-b36f-507a85300b45@linaro.org>
In-Reply-To: <7e35b5b6-01dd-457b-b36f-507a85300b45@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 6 Feb 2025 09:46:55 +0100
X-Gm-Features: AWEUYZlB2pxLs7Dq_G9DR4KiTmGwj1YsmeJEeWxJBc3ObuUMho9e6UPAfANYJU8
Message-ID: <CABgObfbr4yHBJxCVtOk9rQau3Z8M-QUy0+OqTnjecTsKTXrH0Q@mail.gmail.com>
Subject: Re: [PATCH 10/10] rust: bindings for MemoryRegionOps
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, Feb 6, 2025 at 9:40=E2=80=AFAM Philippe Mathieu-Daud=C3=A9 <philmd@=
linaro.org> wrote:
>
> Hi Paolo,
>
> On 17/1/25 20:40, Paolo Bonzini wrote:
> > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > ---
> >   rust/hw/char/pl011/src/device.rs     |  43 +++---
> >   rust/hw/char/pl011/src/lib.rs        |   1 -
> >   rust/hw/char/pl011/src/memory_ops.rs |  36 -----
> >   rust/qemu-api/meson.build            |   1 +
> >   rust/qemu-api/src/lib.rs             |   1 +
> >   rust/qemu-api/src/memory.rs          | 191 ++++++++++++++++++++++++++=
+
> >   rust/qemu-api/src/sysbus.rs          |   7 +-
> >   rust/qemu-api/src/zeroable.rs        |  12 ++
> >   8 files changed, 234 insertions(+), 58 deletions(-)
> >   delete mode 100644 rust/hw/char/pl011/src/memory_ops.rs
> >   create mode 100644 rust/qemu-api/src/memory.rs
> >
> > diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/=
device.rs
> > index 259efacb046..294394c6e82 100644
> > --- a/rust/hw/char/pl011/src/device.rs
> > +++ b/rust/hw/char/pl011/src/device.rs
> > @@ -2,7 +2,7 @@
> >   // Author(s): Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> >   // SPDX-License-Identifier: GPL-2.0-or-later
> >
> > -use core::ptr::{addr_of_mut, NonNull};
> > +use core::ptr::{addr_of, addr_of_mut, NonNull};
> >   use std::{
> >       ffi::CStr,
> >       os::raw::{c_int, c_void},
> > @@ -12,14 +12,14 @@
> >       bindings::{self, *},
> >       c_str, impl_vmstate_forward,
> >       irq::InterruptSource,
> > +    memory::{hwaddr, MemoryRegion, MemoryRegionOps, MemoryRegionOpsBui=
lder},
> >       prelude::*,
> > -    qdev::{Clock, ClockEvent, DeviceImpl, ResettablePhasesImpl, ResetT=
ype},
> > +    qdev::{Clock, ClockEvent, DeviceImpl, ResetType, ResettablePhasesI=
mpl},
> >       qom::{ClassInitImpl, ObjectImpl, Owned, ParentField},
> >   };
> >
> >   use crate::{
> >       device_class,
> > -    memory_ops::PL011_OPS,
> >       registers::{self, Interrupt},
> >       RegisterOffset,
> >   };
> > @@ -490,20 +490,24 @@ impl PL011State {
> >       /// location/instance. All its fields are expected to hold unitia=
lized
> >       /// values with the sole exception of `parent_obj`.
> >       unsafe fn init(&mut self) {
> > +        static PL011_OPS: MemoryRegionOps<PL011State> =3D MemoryRegion=
OpsBuilder::<PL011State>::new()
> > +            .read(&PL011State::read)
> > +            .write(&PL011State::write)
> > +            .native_endian()
>
> Could we always make .valid_sizes() explicit?

Yes (for example build() could even fail to compile if you don't have
impl_sizes/valid_sizes set), but why do you want that? I'm not even
sure that all cases of .valid.max_access_size=3D4 are correct...

Paolo


