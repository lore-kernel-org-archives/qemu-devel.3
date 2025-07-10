Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75398C83F1B
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Jul 2025 16:53:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZuW6-0002qN-VE; Thu, 10 Jul 2025 12:53:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uZu9Y-0002uc-IS
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 12:29:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uZu9S-0003ol-0J
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 12:29:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752164976;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZC7zdxlSsFyQWVgmh3dGZUfDCyjhxzt7G1eaJyMKXXA=;
 b=g3IUp+RONv8uawsg3SOwQbnx9x9BxfDxvJKRtFgrslTiwRbccdSOKkMEEpRws4ESHCwbuV
 VSNEnGjS3DoCVMU/3pyIsSRM9M8rM84/TZQgti5Y0D3mybAf6DBx99ZOGF6wsiojEnLSSl
 gUWaCPoxUi130OYXzdhPfyY0ak1mHQM=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-385-F2gyaPsJMz-ddr9UKSnc2g-1; Thu, 10 Jul 2025 12:29:34 -0400
X-MC-Unique: F2gyaPsJMz-ddr9UKSnc2g-1
X-Mimecast-MFC-AGG-ID: F2gyaPsJMz-ddr9UKSnc2g_1752164973
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-311ef4fb5fdso1489264a91.1
 for <qemu-devel@nongnu.org>; Thu, 10 Jul 2025 09:29:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752164973; x=1752769773;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZC7zdxlSsFyQWVgmh3dGZUfDCyjhxzt7G1eaJyMKXXA=;
 b=diEeXt+AeSAXTvO6Q0twdOP1FQZEEEocbIvUJhWGJa0+Y+XI8MAJjTqNE+Sh68jlb0
 tq/XJTujKXcrdBO+rWNbXccobpATYP/CPT3v7qB6wZu8O1C5aVZ4si3yw2DBzgAbLh4c
 qIbJ7fRflPzc+aU+MrnkVLu5d7dGLxop1NhS793suakOgULCZ82s8C8pxHfX0PGRzHhF
 pKUGTLBLiNCOG/OReRq8M/jK4WXbJicEMIX+5dkGRMevZR8fZjexLoyKNE50dvq4JOf5
 YgpVu9E1nulrs/xmHDPjhV9xXCqF+VJEepVXPnHs+fPA+dgSfZDf4izLS9g1YH61YJzV
 LwoQ==
X-Gm-Message-State: AOJu0YwJg/gXvC1nEtREOkw6v28r4vwrxZS6oXK939TAVOsp/NbTVc7k
 7BecBcaQyn2/T7WgfM4RUNSgicb52yyXIyJxFiWPelQdbKw70EwcN3axyYdgT+KQ5vmpLblm5XM
 HVNaAQQcLpCdCuB+M20wdDlQ2TUTs2JZt7+vOrPublHzQxMlAyLhdBHnsC7nOxYMGhYWoQ+GaUt
 K65v49HbuVKkr5mPubFDh9rkh5RE9Jme4=
X-Gm-Gg: ASbGncsnM7ddurqoLeeqID/LnGGsHNTmVWge55vQHRB4fDYoAqWmfZr8fBBnKfjNewl
 euG8GMUktOOlb48de793J+VjtCKBytoAGAu9H2VLQ+9AXYoVBFfcfGr3q4YG2iG2fTCAZsSsrDn
 jR35g3
X-Received: by 2002:a17:90b:4cc5:b0:312:39c1:c9cf with SMTP id
 98e67ed59e1d1-31c4cca45a1mr241993a91.7.1752164972185; 
 Thu, 10 Jul 2025 09:29:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEVmPtsEW5+DofQTShJiHBp0Lg0MUabQ7Mdvq7qOKFdsC6qicHzW/f8lRi/ctXN/0RGV7IIbZlcqw0ObX52VXk=
X-Received: by 2002:a17:90b:4cc5:b0:312:39c1:c9cf with SMTP id
 98e67ed59e1d1-31c4cca45a1mr241946a91.7.1752164971757; Thu, 10 Jul 2025
 09:29:31 -0700 (PDT)
MIME-Version: 1.0
References: <20250703-rust-qdev-properties-v2-1-d4afac766e94@linaro.org>
 <63edd7ca-02b3-416c-ae28-38bd5386aa89@redhat.com>
 <CAAjaMXbdA51QOR0tx4OnbSnWdx9=cjR_GsaMFdAvrVHy9a-XQQ@mail.gmail.com>
 <CABgObfaiM6-n_O-jD5NkT8iD05a-+jfs33hVkb-UsuG8D_TAvQ@mail.gmail.com>
 <CAAjaMXaHVSg7cmV8q5Jazfiw_o=pu6KmHj7SnSeoJzzStNd+4g@mail.gmail.com>
In-Reply-To: <CAAjaMXaHVSg7cmV8q5Jazfiw_o=pu6KmHj7SnSeoJzzStNd+4g@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 10 Jul 2025 18:29:19 +0200
X-Gm-Features: Ac12FXx6Lmfq38n4o5mMTKl1elWXxv6VVq1nJgTuuX20q3KGmCfIqGMJVmBmIv0
Message-ID: <CABgObfYoqFkzgurUvt0aG4RFp=-h_pirYiaaWU9ybtU8GrD-bQ@mail.gmail.com>
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

On Thu, Jul 10, 2025 at 4:48=E2=80=AFPM Manos Pitsidianakis
<manos.pitsidianakis@linaro.org> wrote:
>
> On Thu, Jul 10, 2025 at 5:26=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.co=
m> wrote:
> >
> > On Thu, Jul 10, 2025 at 11:41=E2=80=AFAM Manos Pitsidianakis
> > <manos.pitsidianakis@linaro.org> wrote:
> > > > Aside from that, I actually liked using Device for the macro name i=
n
> > > > your earlier versions.  Yes, it's just for properties in practice, =
but
> > > > it's nice and small to just say Device; and it mimics Object.  It's=
 your
> > > > choice anyway.
> > >
> > > I was thinking of making a `Device` derive macro that lets you also
> > > define `DeviceImpl::REALIZE` and `DeviceImpl::vmsd` as macro
> > > attributes on the struct definition, then merge DeviceProperties into
> > > that. WDYT?
> >
> > Like #[derive(Device(realize =3D PL011State::realize))]? I kind of like
> > having traits for classes (the "const" does look a bit ugly/foreign,
> > but Linux has some other ideas using a #[vtable] procedural macro).
>
> I was thinking:
>
> #[repr(C)]
> #[derive(Device)]
> #[device(realize =3D PL011State::realize, vmsd =3D VMSTATE_PL011)]
> pub struct PL011State {
>   ..
> }
>
> I agree about traits for class methods, it's definitely cleaner. The
> lines blur here because we have REALIZE as a constant in order to make
> it nullable from the C side =F0=9F=A4=94

Yes, I agree. Another factor to consider is the quality of error messages.

For what it's worth, this is the solution they use in Linux:
https://rust-for-linux.github.io/docs/macros/attr.vtable.html. In
short, they generate a HAS_REALIZE boolean const, and compute the
function pointer with something like
  if Self::HAS_REALIZE { Some(Self::realize) } else { None }

Forgetting the #[vtable] attribute on the "impl" produces a decent
error message, too.

And here is the source:
https://rust-for-linux.github.io/docs/src/macros/vtable.rs.html. Linux
doesn't use proc_macro2 or quote so probably it would have to be
rewritten for QEMU, but it's small and easy to understand.

Even if it's *also* not the nicest, it may be worth adopting this
convention just for consistency among mixed C/Rust programs.

Paolo


Paolo


