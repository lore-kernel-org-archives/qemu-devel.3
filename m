Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC5D0CCD1BF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 11:31:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDhul-0004XM-Rz; Tue, 28 Oct 2025 07:31:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vDhuY-0004SJ-W6
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 07:30:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vDhuV-00040V-1F
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 07:30:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761651038;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r5tJzDqyYqPpdP8MS7D19APAjZ5EN9NXPqDK713GW1k=;
 b=a6QQsi/xmPSh3swvK3Bdq0VZYfN4zPworpvTGC6IO66vjrHdG/ZsGzO7gE7eTSaI5TXMH2
 9W9lEdaQ40mkhRxVJ6JZnn6GwNL+VfvLJ+P2y1j3/+us8630qqSoUCIb4w3k6m0/2JcS4e
 3CWss1QvjOT4ItlBV5BRvdWmejRDCBg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-gRj3ErjtNoyI_YqrpBRyeQ-1; Tue, 28 Oct 2025 07:30:37 -0400
X-MC-Unique: gRj3ErjtNoyI_YqrpBRyeQ-1
X-Mimecast-MFC-AGG-ID: gRj3ErjtNoyI_YqrpBRyeQ_1761651036
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-42705afbf19so3020174f8f.1
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 04:30:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761651036; x=1762255836;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r5tJzDqyYqPpdP8MS7D19APAjZ5EN9NXPqDK713GW1k=;
 b=Gsgs8x2kEACt8ytJMblsZyfKjL7v7ug2CeqXe7i9vCR3O3KpiZ2YsGEZaZB3UnQQ1O
 uR9b+u2fUm8bljTUCpgfDo6TAIQbeJ9vGRTIZN/Kn97rplspdAm7ZzR8Ulx4WzOq9xTU
 UPkqnqHr2QMJslKDk4BnTVkrR7m4ZqY3FOG8JD+Yvj0munzRY1n0pwAPw85SIszmsN4C
 kZPYkBGIKjBKGyL8rhpUuuJDYLjt7wFRQkhjX5l1l9WQWS+yMzs4uL58VBZsBPcnfhSN
 plftG8FjHYYH3gEOHpSdqyaXWSaM2rPTXIiVEaPakDi2Y5illpAK95GVjNEPkAE0JVbv
 3utg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVCHfF65uABUpTHRlgrXmhd9vYde6d4k/O8s9ZI9fxRbE+R0yTFdojhjYOskLlTvFJXyVhZdM41vrdc@nongnu.org
X-Gm-Message-State: AOJu0YzYiPWk8gMzIZkDj58xcdov0Kctfbhj1P1UVUhppr1uxXYzUrV6
 GYLwGiv1XSZg8ciSQmCL5elEeCMGhuoehIdr+TEmJBG60GYdA++Ku3tbn284QTGEUv3c7U+8mMJ
 OtGaqq81bq010SXb70WMUeGN+VPVW/T5yX6IH3q2xhrJEp6d9R/jRfiO+tkPaytElk/gVLWv9CW
 /9uBUv72hhcm3N0BBT3OkKt/mfogKloro=
X-Gm-Gg: ASbGncupgJQDJlBMFa7yo1dYvjdX9kILSnsplDcsx/KsfvBd/ixM40UHXbCecAfMXob
 IouL/VItu76km/DIg7iichcwA/RZY597UsP6bGE/ZNxTZtjZjLIKoXxZ8FF/Ol1zd6D42Hns3Iy
 6XAb6AwcDbClpsbHZz3SyS+CIbA7dVB03aE1/80mFzVnyX4UGGF084UsQvGbQ6bJ/XbIc/9sGRL
 kfr4BTBi/9/Q5zrZZnd28I6qsyGOuJtbi43JtMCVYkgebkRwuwx6TtkdL4y
X-Received: by 2002:a5d:5d13:0:b0:427:67b:b385 with SMTP id
 ffacd0b85a97d-429a81b1402mr2373074f8f.11.1761651036064; 
 Tue, 28 Oct 2025 04:30:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF3ARsWCjklUC/YRtQHaz/aur1yYLEPGvhuA972e7EFaDfspTKTMLnZn4qA6U3aM45eAre9HITBnzxE3nndD2M=
X-Received: by 2002:a5d:5d13:0:b0:427:67b:b385 with SMTP id
 ffacd0b85a97d-429a81b1402mr2373038f8f.11.1761651035637; Tue, 28 Oct 2025
 04:30:35 -0700 (PDT)
MIME-Version: 1.0
References: <45032bb11a9006cb7a6e1c30ca6299d40cef614c.1761644606.git.chenmiao@openatom.club>
 <CABgObfbeka+fKixBH8F_Fkprvk8oi+dTss21Vn5kYgm4sY0A8g@mail.gmail.com>
 <f8ec1dad-2654-4db8-b994-0ecd2a1943e9@openatom.club>
In-Reply-To: <f8ec1dad-2654-4db8-b994-0ecd2a1943e9@openatom.club>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 28 Oct 2025 12:30:24 +0100
X-Gm-Features: AWmQ_blG_SqtHLFgMI88CtemEe8nP-PEPaE2hkmXAJGWqVWcejsHYri_dvXshQ8
Message-ID: <CABgObfbndBy++yt+Bp=3WuomprUEtJyWyKaJYQje6wWtjnb0Kg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 4/5] rust/hw/core: Provide some interfaces for the
 GPIO device
To: Chen Miao <chenmiao@openatom.club>
Cc: zhao1.liu@intel.com, manos.pitsidianakis@linaro.org, 
 richard.henderson@linaro.org, philmd@linaro.org, chao.liu@openatom.club, 
 qemu-rust@nongnu.org, qemu-devel@nongnu.org, 
 hust-os-kernel-patches@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, Oct 28, 2025 at 12:24=E2=80=AFPM Chen Miao <chenmiao@openatom.club>=
 wrote:
>
> On 10/28/2025 6:49 PM, Paolo Bonzini wrote:
> > On Tue, Oct 28, 2025 at 11:18=E2=80=AFAM chenmiao <chenmiao@openatom.cl=
ub> wrote:
> >> In irq.rs, we added a new get method for the InterruptSource type to d=
etermine
> >> whether an InterruptSource is null. This eliminates the need to repeat=
edly
> >> call self.cell.get().is_null() for null checks during comparisons.
> >> Additionally, we exposed the slice_as_ptrmethod to support external us=
age with
> >> the &[InterruptSource]type.
> >>
> >> In qdev.rs, we implemented the init_gpio_out_namedfunction, which corr=
esponds
> >> to the C function qdev_init_gpio_out_named. We also refactored the
> >> init_gpio_outfunction to reuse the init_gpio_out_namedinterface.
> >>
> >> Signed-off-by: chenmiao <chenmiao@openatom.club>
> >> ---
> >>   rust/hw/core/src/irq.rs  |  6 +++++-
> >>   rust/hw/core/src/qdev.rs | 12 +++++++++---
> >>   2 files changed, 14 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/rust/hw/core/src/irq.rs b/rust/hw/core/src/irq.rs
> >> index e0d7784d97..dd5d0cadbc 100644
> >> --- a/rust/hw/core/src/irq.rs
> >> +++ b/rust/hw/core/src/irq.rs
> >> @@ -71,6 +71,10 @@ pub fn pulse(&self) {
> >>       pub fn raise(&self) {
> >>           self.set(true);
> >>       }
> >> +
> >> +    pub fn get(&self) -> bool {
> >> +        !self.cell.get().is_null()
> >> +    }
> > This should not be get(), but "is_connected()". Also it should be
> > implemented for any T, therefore in the "impl<T> InterruptSource<T>"
> > block below.
> I'll fix it later.

You can drop it actually (see review of 5/5).

> >>   }
> >>
> >>   impl<T> InterruptSource<T>
> >> @@ -91,7 +95,7 @@ pub(crate) const fn as_ptr(&self) -> *mut *mut bindi=
ngs::IRQState {
> >>           self.cell.as_ptr()
> >>       }
> >>
> >> -    pub(crate) const fn slice_as_ptr(slice: &[Self]) -> *mut *mut bin=
dings::IRQState {
> >> +    pub const fn slice_as_ptr(slice: &[Self]) -> *mut *mut bindings::=
IRQState {
> >>           assert!(!slice.is_empty());
> >>           slice[0].as_ptr()
> >>       }
> > Since you are not using this, you don't need to expose it outside the c=
rate.
>
> I have used this function in the next patch.

Isn't it commented out? The code that is used is:

+        self.init_gpio_in(self.handler_size(), PCF8574State::gpio_set);
+        self.init_gpio_out(from_ref(&self.handler[0]));
+        self.init_gpio_out_named(from_ref(&self.intrq), "nINT", 1);


