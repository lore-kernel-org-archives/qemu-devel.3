Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 507F7C02183
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 09:41:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYiqG-0006KU-DB; Fri, 17 Jan 2025 04:40:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tYiq5-0006Is-5r
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 04:40:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tYiq1-0005q4-I0
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 04:40:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737106823;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j4NAqgi38LYT3oNbCaFz5kq8bGXKXTd/Mkrfbxdb2Lg=;
 b=Lk0tGEBhTv22FF8qom72DGYg9ez5VJfFOcVKDGTDZ92Iuenn/bNQwBsh/sCCQ4PRQtJ1IS
 muGW8H2B4BAT+6sgDKuMhJ5C92eHI/62A+XTTbe8UaZU5V82hwElhk0Y6MLdLqn/fCqbyW
 1kKNcCy/GLHYBWbfvTQvxngqmWXiNmQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-106-aeifTFv2M7Sf1ySxAbuzRA-1; Fri, 17 Jan 2025 04:40:22 -0500
X-MC-Unique: aeifTFv2M7Sf1ySxAbuzRA-1
X-Mimecast-MFC-AGG-ID: aeifTFv2M7Sf1ySxAbuzRA
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43624b08181so9711355e9.0
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 01:40:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737106821; x=1737711621;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=j4NAqgi38LYT3oNbCaFz5kq8bGXKXTd/Mkrfbxdb2Lg=;
 b=hFXtLGjc9iFDH5GRpQIuEyg6qQjbLU4Z3Q/qIGLsTAccyftGnHQ1CpYxPEk5px9Tcy
 SvSZCrtt6aZuiXO6b9EDAyEwjN3ZVooOJV0zu0p7MkzQDxt+4ZOkcs8rWNpwMvaFs55E
 UO249M6A8k7i4HqJtInzFEclJa0qm1KjxbXKUkpGG4j0UzraM31lT+IUlr2gnnUaq4VE
 VnM5OZ3qeCZJYSUx5iNMTh8X6YtvhPgsqiu4cLXcQEdvXGDXenmsleahOro+V6/z3Xt+
 2TWz4b81QzSWY9YsV3Fwk7S88g2Ksq3vEDhlQ3BfvEGJEhCUw93h/TCuTYcoH8pf0DLB
 sqFA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWgQhg1fyG4Kl/mqW/sY3MiLoMOInty3zfI/hqla5F6mcu5GVWIbelEB/snDVrecrefZ85IXrqUtw8v@nongnu.org
X-Gm-Message-State: AOJu0YwJFdB9wKFM89TYd3vTXQWDbPym9iOoA7yiMWBLWYzTheJW32Qe
 c12wVPj1D6LwQVF0wVCupHtMLuXUWALBo/0M1eSTC0X04B2zCQMs35hUJAl4EAKYerTyTBwTS6Q
 79L/9fTfeGTT3l2G1iMisnJ0TBAX2EupWNwEZSxCLk75MqB1sj7yllZmgF8ENN6725mInOXNjeP
 R8PvzLHppsSUkZ35LBM4ifh9Uq4js=
X-Gm-Gg: ASbGncu3MLeAep9w+mqQiHsYT+nvUJVHRRb3W/9QoAUNSik8oo8EFXoSH1K4f6PPqo6
 JRbOiASy+rngQdC2965dk1MVgVkOuiEV3BVQArmg=
X-Received: by 2002:a05:600c:1c21:b0:434:f3d8:62db with SMTP id
 5b1f17b1804b1-438918b9b23mr15736725e9.2.1737106820896; 
 Fri, 17 Jan 2025 01:40:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEUoiYTSdqDZzGsD5/Mr+0+Tg3ZnFftZ99f8c8smHy3LfjA2Q8Dq02AxpdQ91/x4RZt/VWZbBNfPgkELJMfJQc=
X-Received: by 2002:a05:600c:1c21:b0:434:f3d8:62db with SMTP id
 5b1f17b1804b1-438918b9b23mr15736545e9.2.1737106820532; Fri, 17 Jan 2025
 01:40:20 -0800 (PST)
MIME-Version: 1.0
References: <20241205060714.256270-1-zhao1.liu@intel.com>
 <20241205060714.256270-5-zhao1.liu@intel.com>
 <6108dfe6-f629-431c-be91-51abff338e85@redhat.com> <Z1XJBJp+l92+OrY9@intel.com>
 <CABgObfaeoLociD5rzptg4Uj4anMonc0M8iP_TK3qa-17FecR2A@mail.gmail.com>
 <Z4h3Q/JBxtWxi+bK@intel.com>
In-Reply-To: <Z4h3Q/JBxtWxi+bK@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 17 Jan 2025 10:40:08 +0100
X-Gm-Features: AbW1kvb2PCtCgUiJzEKlxZs3QajGac2825Y6_WF0gndo7Kebo2kQ1iYm5H4pTOU
Message-ID: <CABgObfYeRASh3oao6fpKBcijnhGaMKdAWsAQbrya7rwwOJfE1g@mail.gmail.com>
Subject: Re: [RFC 04/13] rust: add bindings for gpio_{in|out} initialization
To: Zhao Liu <zhao1.liu@intel.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, 
 Junjie Mao <junjie.mao@hotmail.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 qemu-rust@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.093,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.797,
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

Like timer there are just a couple nits here.

On Thu, Jan 16, 2025 at 3:45=E2=80=AFAM Zhao Liu <zhao1.liu@intel.com> wrot=
e:
> * gpio_in and gpio_out:
>
> /// Trait for methods of [`DeviceState`] and its subclasses.
> pub trait DeviceMethods: ObjectDeref
> where
>     Self::Target: IsA<DeviceState>,
> {
>     fn init_gpio_in<F>(&self, lines_num: u32, _f: F)

num_lines :)

>     where
>         F: for<'a> FnCall<(&'a Self::Target, u32, u32)>,
>     {
>         unsafe extern "C" fn rust_irq_handler<T, F: for<'a> FnCall<(&'a T=
, u32, u32)>>(
>             opaque: *mut c_void,
>             lines_num: c_int,

"line" instead of lines_num.
>         unsafe {
>             qdev_init_gpio_in(
>                 self.upcast::<DeviceState>() as *const DeviceState as *mu=
t DeviceState,

I think you can use self.as_mut_ptr::<DeviceState>() or something like that=
.

>         assert!(pins.len() > 0);

!pins.is_empty(). But I am not sure it's needed...
>
>         unsafe {
>             qdev_init_gpio_out(
>                 self.upcast::<DeviceState>() as *const DeviceState as *mu=
t DeviceState,
>                 pins[0].as_ptr(),
>                 pins.len() as c_int,

... if you use instead pins.as_ptr() without the initial dereference.

> impl HPETState {
>     ...
>
>     fn handle_legacy_irq(&self, irq: u32, level: u32) {
>         if irq =3D=3D HPET_LEGACY_PIT_INT {
>             if !self.is_legacy_mode() {
>                 self.irqs[0].set(level !=3D 0);
>             }
>         } else {
>             self.rtc_irq_level.set(level as u8);

Any reason why you defined rtc_irq_level as InterruptSource<u8>
instead of InterruptSource<u32>?

>     fn realize(&self) {
>         ...
>         self.init_gpio_in(2, HPETState::handle_legacy_irq);
>         self.init_gpio_out(from_ref(&self.pit_enabled));
>     }
> }
>
> ---
>
> I made the handler accept the inmuttable reference, but init_gpio_in()
> is called in realize(), which now accepts the `&mut self`.
>
> I think init_gpio_in() should be called in realize() so that realize()
> needs to become safe in advance (before your plan).
>
> The safe realize() mainly affects pl011, and before you formally
> introduce char binding, if you don't mind, I can make this change to
> pl011:
>
> -    pub fn realize(&mut self) {
> +    pub fn realize(&self) {
>          // SAFETY: self.char_backend has the correct size and alignment =
for a
>          // CharBackend object, and its callbacks are of the correct type=
s.
>          unsafe {
>              qemu_chr_fe_set_handlers(
> -                addr_of_mut!(self.char_backend),
> +                addr_of!(self.char_backend) as *mut CharBackend,
>                  Some(pl011_can_receive),
>                  Some(pl011_receive),
>                  Some(pl011_event),
>                  None,
> -                addr_of_mut!(*self).cast::<c_void>(),
> +                addr_of!(*self).cast::<c_void>() as *mut c_void,
>                  core::ptr::null_mut(),
>                  true,
>              );

That's fine, yes.

Paolo


