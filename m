Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2276D0BB78
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2024 09:04:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3tlV-0003my-24; Thu, 24 Oct 2024 05:04:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t3tlT-0003ml-Rw
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 05:04:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t3tlS-0005WC-6b
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 05:04:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729760657;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r81toaLlHIPkHKpatfyI48GYJtpXioH4chCW+MojXmM=;
 b=fOkzHtE8hndyW3Uaae5Eq3kTAvT+3O/4g7Lr/QZmP+QeSwCUkiSVu5f7Ew/6j9f3/+JPqD
 Nrpf9gE+ZI5TVG5AumUvGsj9wJoxPbxWCBNNC4nRQUwBHA25XSwapbghreWOfyVID8S6iA
 lApLirStQpFgf0raHIsifisxeLGWiz8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-159-xVwcFYQOM-GnWh5EMbkKBw-1; Thu, 24 Oct 2024 05:04:14 -0400
X-MC-Unique: xVwcFYQOM-GnWh5EMbkKBw-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-37d4cf04bcfso395557f8f.2
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2024 02:04:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729760653; x=1730365453;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r81toaLlHIPkHKpatfyI48GYJtpXioH4chCW+MojXmM=;
 b=iWimZTS2FQC2O365IBMob71QLKdjE1DHnEg6bh86xeJ9XS7Y4tHO4/cqtH38DQxd1p
 wqBkVWiq+gIgT9/CxQj8pg1C88TYkm+whoNNz6G82QrGafn/89UH2pnuN4SsaGCBxTzA
 WNmvLGULWsft7pXHL57Dm21ZnLJGNIbrclDxkvnxWdfKPqnr/su9fRQeCLZjLXkem7ND
 aU+/1mkq4xU25wMhH5Me7gLyLwM5uxNmEdnZgn3wkoQKb6IAAEHc+ZHIEITJZ3E9PNZ8
 ICx9nDblx4iv1fbzMNNNhDzPkTuc2zmNh2DA7bAh6PfAO88neMMY+vktfYnYuu3bKo4L
 Rjlw==
X-Gm-Message-State: AOJu0YzxF/xOGaeucu6O77p9qj1gR1cbTTGTzeMEMihQJR5YDrQoh6Uu
 rRJmCk4oi+51pL4g/1gF3TpPDriwpI4Wp0z2Zhz9RnzAO/y2+X5YXw+RupnLpZsZZWbpMsodHVE
 G5KyEQiHm/PsC5YrHMM7oboLc4i5teA0YOShNNC9hcmnv2gR9GXTfgPmOVcM54wbw+w+CDxH5he
 IvWRKmkgxeX8Ocy0PXIzkZC0F6B+0=
X-Received: by 2002:a5d:6707:0:b0:37e:d2b7:acd5 with SMTP id
 ffacd0b85a97d-37efceedf6cmr3292691f8f.8.1729760653452; 
 Thu, 24 Oct 2024 02:04:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEDl7hSI3IEtAN2+5IPDqPlBJgkyDxuZwcoYiSCURWiAPT0be85Pt3tK7NG39eQEFI1nmfwCmebIRRZolGPukM=
X-Received: by 2002:a5d:6707:0:b0:37e:d2b7:acd5 with SMTP id
 ffacd0b85a97d-37efceedf6cmr3292668f8f.8.1729760653084; Thu, 24 Oct 2024
 02:04:13 -0700 (PDT)
MIME-Version: 1.0
References: <20241022100956.196657-1-pbonzini@redhat.com>
 <20241022100956.196657-7-pbonzini@redhat.com>
 <SY0P300MB1026AD4676BFD368DC51CA04954E2@SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM>
In-Reply-To: <SY0P300MB1026AD4676BFD368DC51CA04954E2@SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 24 Oct 2024 11:04:01 +0200
Message-ID: <CABgObfY_8EYEV9pdHWs16dwzQMnW8TbUoTryHmo-+97UD3gCyw@mail.gmail.com>
Subject: Re: [PATCH v2 06/14] rust: synchronize dependencies between
 subprojects and Cargo.lock
To: Junjie Mao <junjie.mao@hotmail.com>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, kwolf@redhat.com, 
 manos.pitsidianakis@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.263,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.697,
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

On Thu, Oct 24, 2024 at 5:01=E2=80=AFAM Junjie Mao <junjie.mao@hotmail.com>=
 wrote:
>
>
> Paolo Bonzini <pbonzini@redhat.com> writes:
>
> > The next commit will introduce a new build dependency for rust/qemu-api=
,
> > version_check.  Before adding it, ensure that all dependencies are
> > synchronized between the Meson- and cargo-based build systems.
> >
> > Note that it's not clear whether in the long term we'll use Cargo for
> > anything; it seems that the three main uses (clippy, rustfmt, rustdoc)
>
> Here's a fourth use case: "cargo expand" for debugging Rust macros.
>
> > can all be invoked manually---either via glue code in QEMU, or by
> > extending Meson to gain the relevant functionality.  However, for
> > the time being we're stuck with Cargo so it should at least look at
> > the same code as the rest of the build system.
> >
> > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > ---
> >  rust/hw/char/pl011/Cargo.lock   |  5 +++-
> >  rust/qemu-api-macros/Cargo.lock | 11 ++++----
> >  rust/qemu-api/Cargo.lock        | 49 ++++++++++++++++++++++++++++++++-
> >  rust/qemu-api/Cargo.toml        |  1 +
> >  4 files changed, 59 insertions(+), 7 deletions(-)
> >
> > diff --git a/rust/hw/char/pl011/Cargo.lock b/rust/hw/char/pl011/Cargo.l=
ock
> > index b58cebb186e..82028ddf793 100644
> > --- a/rust/hw/char/pl011/Cargo.lock
> > +++ b/rust/hw/char/pl011/Cargo.lock
> > @@ -1,6 +1,6 @@
> >  # This file is automatically @generated by Cargo.
> >  # It is not intended for manual editing.
> > -version =3D 3
> > +version =3D 4
>
> V4 was introduced in Rust 1.78. Should we stick to V3 as the MSRV is 1.63=
.0?

Good point.

> I would suggest adding those dependencies and version constraints in
> Cargo.toml, not Cargo.lock. Future devices in Rust will have their
> Cargo.lock derived from Cargo.toml of qemu-api and qemu-api-macro, so
> missing version info there will force device writers to manually tweak
> their Cargo.lock.

Ok, will do.

Paolo


