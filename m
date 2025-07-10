Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24207C83F17
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Jul 2025 14:56:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZsgS-0006M6-HM; Thu, 10 Jul 2025 10:55:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uZsZO-00084x-Pj
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 10:48:22 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uZsZK-0008FP-4F
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 10:48:15 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-60c4f796446so1626420a12.1
 for <qemu-devel@nongnu.org>; Thu, 10 Jul 2025 07:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752158892; x=1752763692; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Syd2hLex+/9IYla7n/kVYhD0VKPS4nIq7p0b0wmaMBA=;
 b=MbWoYe9OeuU8/cN4YHg1hMfTffYNlMElCahHXf1v9WZJV+RehjGtr/eMUW2OnUsIVB
 4kmH90M5B0xlud9/Qkl0wkNad+BhUx42N68Ui5rFxScc9tAV9wVw3ZoZZPujF8inpHiE
 bJgpteyErhTvecEhDKKcCfZUEHW6TKLtsHQAZRp8KM+Sg769uYDiwecCScJksfJGM8ah
 oZdUJDywqjz+Vo1S7db2YP8LYQemVPK1jrTnoGQL7YqEo02e8AJU+O+6khFgWAqYIYNS
 8mSv6YG3eIvWgdUGWCYboUD/r/VnOYdl50hVBMqgXHoxzTHJIMBbjRbmesCAviHIiM3H
 4A7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752158892; x=1752763692;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Syd2hLex+/9IYla7n/kVYhD0VKPS4nIq7p0b0wmaMBA=;
 b=bo6cANurg4cNDpP7oEUZD0csfO7mP6TkRjlyRlIF4PO4IKBz5H6JP+U8VZjDh18Bo0
 4Lg+c1lQVWX+YrzEBGdumpj3iAUphs53x4BFGFGeC588yqe0sEa9mJkNOBuGUjQiIbDF
 dNvGJy0NdUp88ztpFQfU2YkGRy6jA+XTZAahHFjRKN/vAIvBWA4rSOhOXRTmNaFHfLFC
 2SLZqWpinBTgD36s5uqrh43VjzTJJl6KTZJWoXf+6S+p+MuXC0dayXl+6JrbMpmlgLYS
 FacPuwwOw8U3S1bT1OsWNcIU0JjV3kmRwMnrW3XvAjK02J8mZB6RaIUjL8n3srVY/R35
 CZeQ==
X-Gm-Message-State: AOJu0YzIS5i3FZ4B5nVfSvtYoSRBQXgyfr3LnKzNsc3d/E8DlqvmGrWZ
 YgrqMguZqk0bv2++XBKrDmmTL0wBUkZ200UosrZDWEeaCp3S0hQGV3vNv0t+MUjaSvzAuureY+4
 FresVsxGikxkwAkPTmXGs/+oNcYL7JpMHBq3eb/xwCQ==
X-Gm-Gg: ASbGncvHh5Q1/V5g9bsbQUY3TYy3LbKt6frrVDciJOqec0jkEZoUVWQ0DqEXFqF4Kq+
 8llYHgGAqUdPo5mqeJt/FYEeOBPwkBJ5nT7s5zsJ+UPXL7bgY0oFuQeUW14Y7eU2aIEsuMz1sty
 ZqTd4z2mghc917BiN15kMIxTIx2ogJiYMZLiyOllsIdwQ=
X-Google-Smtp-Source: AGHT+IE31XVbzGgBMG36VPp6oKguQl7msjhAZu6FTzzhd2b/38TOeJZm0X1BWOIHNsLLeTS9LF/RFlMcZSl/8KTbJ6Q=
X-Received: by 2002:a05:6402:1ece:b0:607:2a09:38dd with SMTP id
 4fb4d7f45d1cf-611a6e20b74mr7083143a12.18.1752158892076; Thu, 10 Jul 2025
 07:48:12 -0700 (PDT)
MIME-Version: 1.0
References: <20250703-rust-qdev-properties-v2-1-d4afac766e94@linaro.org>
 <63edd7ca-02b3-416c-ae28-38bd5386aa89@redhat.com>
 <CAAjaMXbdA51QOR0tx4OnbSnWdx9=cjR_GsaMFdAvrVHy9a-XQQ@mail.gmail.com>
 <CABgObfaiM6-n_O-jD5NkT8iD05a-+jfs33hVkb-UsuG8D_TAvQ@mail.gmail.com>
In-Reply-To: <CABgObfaiM6-n_O-jD5NkT8iD05a-+jfs33hVkb-UsuG8D_TAvQ@mail.gmail.com>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Thu, 10 Jul 2025 17:47:46 +0300
X-Gm-Features: Ac12FXyGqTNYDTrv38AZIItvTRk_ANtil9tzJ47HLUBFNU9tNr7fuf6MWnNHViI
Message-ID: <CAAjaMXaHVSg7cmV8q5Jazfiw_o=pu6KmHj7SnSeoJzzStNd+4g@mail.gmail.com>
Subject: Re: [PATCH RFC v2] rust: add qdev DeviceProperties derive macro
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Zhao Liu <zhao1.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x52b.google.com
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

On Thu, Jul 10, 2025 at 5:26=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com>=
 wrote:
>
> On Thu, Jul 10, 2025 at 11:41=E2=80=AFAM Manos Pitsidianakis
> <manos.pitsidianakis@linaro.org> wrote:
> > > Aside from that, I actually liked using Device for the macro name in
> > > your earlier versions.  Yes, it's just for properties in practice, bu=
t
> > > it's nice and small to just say Device; and it mimics Object.  It's y=
our
> > > choice anyway.
> >
> > I was thinking of making a `Device` derive macro that lets you also
> > define `DeviceImpl::REALIZE` and `DeviceImpl::vmsd` as macro
> > attributes on the struct definition, then merge DeviceProperties into
> > that. WDYT?
>
> Like #[derive(Device(realize =3D PL011State::realize))]? I kind of like
> having traits for classes (the "const" does look a bit ugly/foreign,
> but Linux has some other ideas using a #[vtable] procedural macro).

I was thinking:

#[repr(C)]
#[derive(Device)]
#[device(realize =3D PL011State::realize, vmsd =3D VMSTATE_PL011)]
pub struct PL011State {
  ..
}

I agree about traits for class methods, it's definitely cleaner. The
lines blur here because we have REALIZE as a constant in order to make
it nullable from the C side =F0=9F=A4=94

> For vmsd yes, you could pass it as a VMStateDescription const's name
> in the same style, like #[derive(Device(vmsd =3D
> device_class::VMSTATE_PL011))].
>
> WRT naming, I was thinking the other way round: call it Device
> already, and then add functionality without having to change the name.
> Your choice; naming suggestions are risky :) but I wasn't afraid of
> making this suggestion because you had that name before.
>
> > Hm, isn't it redundant if the trait is marked as `unsafe`? Or maybe I
> > misunderstood your point.
>
> Yes, you're right - just wanted something not too tied to properties
> in case the derive macro is extended later. Maybe DeviceDerive, or
> DeviceImplDerive? But any name is fine, just keep it consistent
> between macro and trait.
>
> > > > +/// It is the implementer's responsibility to provide a valid [`bi=
ndings::PropertyInfo`] pointer
> > > > +/// for the trait implementation to be safe.
> > > > +pub unsafe trait QDevProp {
> > > > +    const VALUE: *const bindings::PropertyInfo;
> > >
> > > "*const" or "&"?
> >
> > This is the thing I mentioned to you over IRC: Unfortunately even with
> > const refs for statics we get this because the static is extern:
>
> Ah okay - I just wasn't sure, which is why I wrote it as a question.
> It worked in vmstate because there the const is a VMStateField which
> has a *const inside. So yes, definitely a *const.
>
> Paolo
>

Thanks!

--=20
Manos Pitsidianakis
Emulation and Virtualization Engineer at Linaro Ltd

