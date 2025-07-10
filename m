Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8345CC83F1B
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Jul 2025 14:35:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZsMi-0007GM-74; Thu, 10 Jul 2025 10:35:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uZsEB-0006bz-JV
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 10:26:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uZsE5-00016i-T9
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 10:26:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752157576;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OMhGL/vuYOQ/mTLFpG0ZAX+4A1VXOGLiQClWfQZ1aIs=;
 b=GR/CYuQj1UOX6kMFUGj1lO4amB/vEjVGCjj8kj/idY9jckT4qloe8G0pEALPE3+qFO5giY
 QBqRAUJCANPwCNcEKT8flZy+XyvJ98vPmgHqXxGCXHUpFYd4pYHpAQb1QZCXKcswrfgUvo
 NmzQ/Q+SktNc6ku/svAtcAY/fseffRw=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-213-wljENY2zMEm0xE7Z2K_iWw-1; Thu, 10 Jul 2025 10:26:14 -0400
X-MC-Unique: wljENY2zMEm0xE7Z2K_iWw-1
X-Mimecast-MFC-AGG-ID: wljENY2zMEm0xE7Z2K_iWw_1752157572
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-b115fb801bcso1260557a12.3
 for <qemu-devel@nongnu.org>; Thu, 10 Jul 2025 07:26:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752157572; x=1752762372;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OMhGL/vuYOQ/mTLFpG0ZAX+4A1VXOGLiQClWfQZ1aIs=;
 b=Xp2BYeyDq9oel6WZfoy+uYDjC/aikcZ01zeJdgX9jUHCMd19svd8nZE5npZDwQzpkF
 w0VfrTHhiLEX2sr6HCzfWbdtq1E3JaRNcBMktyHQXh8WiHlN8pMPCclMkPz2PdFE5hB4
 j8G6sNi2OriyEBm7Ud/oGihoFaNA9+tXGbyWP/HgxtoyTTkTyyPNL6Ya5ySZj/DHe8lK
 wAaM4pH5OHZHOQdnuo8H33HXfAneFHANFmlbPa0wSXzimEelGnyJGppC/5W7rflbnn7M
 rpXSPxY4NjW3ncTsNsMAIwtsGCWH0tAZS+Fa/zYSdDjag+cIbtwIyTX/txQnoJNzIDK2
 +4jA==
X-Gm-Message-State: AOJu0YyKHY5DrTnNYfrGTTc8yv/1wMLT/NgbV3QeJkSraNb9S2mourwM
 ssyP9nHQFq5/xrrIkHB8DdjXFJiW66NI+eMfBscljt6k1WVYh/15qYZ5bmOBzAvjsHY2HPaCUQY
 EBcGdtmKEig0smZqDxEzbyfiAQT2dssEx3mpvaURYX5v046Mj0vFtrkNLW6uREMXBDf0u1dHTY+
 0tesef/XPEv2yR9npwPmU+VkAaq26zxMw=
X-Gm-Gg: ASbGncuFxm5SE/UqA1l0x/ByzcnVP/0MqrqIA1gf64mNDjN2MuDE9AMEdSp2t4viQvP
 +ii0+mWUxWkuzam6gejlB7itPNFYdd+EdqKXc3YJXrswje7+7eQn60tKvFV8WGYdpQ72VpNehC0
 MHzQXp
X-Received: by 2002:a17:90b:3844:b0:313:23ed:701 with SMTP id
 98e67ed59e1d1-31c2fcc49b5mr10711259a91.4.1752157571878; 
 Thu, 10 Jul 2025 07:26:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFBnGTNKXdMh3rvrTih1z7cubLdmeSOwckFB2X2tX1wfIscaHMC0wYGgPs92JW3kKcShOyuG4hzMgGtWGvwGBU=
X-Received: by 2002:a17:90b:3844:b0:313:23ed:701 with SMTP id
 98e67ed59e1d1-31c2fcc49b5mr10711204a91.4.1752157571370; Thu, 10 Jul 2025
 07:26:11 -0700 (PDT)
MIME-Version: 1.0
References: <20250703-rust-qdev-properties-v2-1-d4afac766e94@linaro.org>
 <63edd7ca-02b3-416c-ae28-38bd5386aa89@redhat.com>
 <CAAjaMXbdA51QOR0tx4OnbSnWdx9=cjR_GsaMFdAvrVHy9a-XQQ@mail.gmail.com>
In-Reply-To: <CAAjaMXbdA51QOR0tx4OnbSnWdx9=cjR_GsaMFdAvrVHy9a-XQQ@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 10 Jul 2025 16:25:58 +0200
X-Gm-Features: Ac12FXyjuWi_HGng0Nsq5uQa7-3ebJJG4QsLWgAfrJwHtxiANMlFSfiPFsv04ls
Message-ID: <CABgObfaiM6-n_O-jD5NkT8iD05a-+jfs33hVkb-UsuG8D_TAvQ@mail.gmail.com>
Subject: Re: [PATCH RFC v2] rust: add qdev DeviceProperties derive macro
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Zhao Liu <zhao1.liu@intel.com>
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

On Thu, Jul 10, 2025 at 11:41=E2=80=AFAM Manos Pitsidianakis
<manos.pitsidianakis@linaro.org> wrote:
> > Aside from that, I actually liked using Device for the macro name in
> > your earlier versions.  Yes, it's just for properties in practice, but
> > it's nice and small to just say Device; and it mimics Object.  It's you=
r
> > choice anyway.
>
> I was thinking of making a `Device` derive macro that lets you also
> define `DeviceImpl::REALIZE` and `DeviceImpl::vmsd` as macro
> attributes on the struct definition, then merge DeviceProperties into
> that. WDYT?

Like #[derive(Device(realize =3D PL011State::realize))]? I kind of like
having traits for classes (the "const" does look a bit ugly/foreign,
but Linux has some other ideas using a #[vtable] procedural macro).

For vmsd yes, you could pass it as a VMStateDescription const's name
in the same style, like #[derive(Device(vmsd =3D
device_class::VMSTATE_PL011))].

WRT naming, I was thinking the other way round: call it Device
already, and then add functionality without having to change the name.
Your choice; naming suggestions are risky :) but I wasn't afraid of
making this suggestion because you had that name before.

> Hm, isn't it redundant if the trait is marked as `unsafe`? Or maybe I
> misunderstood your point.

Yes, you're right - just wanted something not too tied to properties
in case the derive macro is extended later. Maybe DeviceDerive, or
DeviceImplDerive? But any name is fine, just keep it consistent
between macro and trait.

> > > +/// It is the implementer's responsibility to provide a valid [`bind=
ings::PropertyInfo`] pointer
> > > +/// for the trait implementation to be safe.
> > > +pub unsafe trait QDevProp {
> > > +    const VALUE: *const bindings::PropertyInfo;
> >
> > "*const" or "&"?
>
> This is the thing I mentioned to you over IRC: Unfortunately even with
> const refs for statics we get this because the static is extern:

Ah okay - I just wasn't sure, which is why I wrote it as a question.
It worked in vmstate because there the const is a VMStateField which
has a *const inside. So yes, definitely a *const.

Paolo


