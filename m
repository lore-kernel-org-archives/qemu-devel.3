Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90F61CCF9E0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 11:29:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDhsu-0002qZ-7w; Tue, 28 Oct 2025 07:29:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vDhss-0002q7-96
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 07:29:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vDhsl-0003jt-Rf
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 07:29:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761650933;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uHIkPmibtwStN22OEjXI0V2cNbpyBUXkzByUfMmxahc=;
 b=DVqivU1t1Vh49IjKfJhB28uhupGcNcJIxHHWBC/r6GXZshS95bynXwRF9ikZhQyKk5JvfS
 hgBDO5LHEFlYvBkvk+3FqafTB8dEYoU9pEK8G7f7EsbIjLhjqoVVYc1uWplxddypqQ3cSj
 nPnheeHEQ/ZzPcLgiz7LFvnYHP/eDrc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-428-o9K-eTMrO0q2xjLofsMFzA-1; Tue, 28 Oct 2025 07:28:52 -0400
X-MC-Unique: o9K-eTMrO0q2xjLofsMFzA-1
X-Mimecast-MFC-AGG-ID: o9K-eTMrO0q2xjLofsMFzA_1761650931
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-429893e2905so6201349f8f.3
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 04:28:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761650930; x=1762255730;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uHIkPmibtwStN22OEjXI0V2cNbpyBUXkzByUfMmxahc=;
 b=CkCFHcWGsfpZP9yRpam35TsubtG5Cx+gszulpPV691qTJsMhcVkDnXqiMc3a1SjnuX
 +nLMJgENCEm2/dsF2pDFyxmUSJ7XQWdqIVg+USU17zYtIlEVBrmpXt3+UdoRXHmjs9tn
 thhWt5O6VmzbCEB3qzSVugmH9Daz+ZytUFGa4bTwqcKVaUxUCty812VNRsj4X4Ydjt2K
 Jw0IABpdi7W8JapraCqIV7yUnjBxMj1lIcnaP4G1SpN6lxYdv6R/eq4H5cL207l8LJ6o
 xx24TBO9PM6NxwXkzwINIY813Ol6EN5RhFE2HEc0W5O2kdUbCDIK3c5KrvT+qLgq1b0f
 xyIw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVy13CgNbieGM4kjjBBUHdXbsDREBv87tVZ9spDP9VyQgstdPdW4ZX7qnTnDFFUy48Zrv53tbC6ObUR@nongnu.org
X-Gm-Message-State: AOJu0Yz4tOanh3Kty+LW7JtENnUdwSDaIWTzEFOOVqvuTdXSKGY8b+Ly
 a527edG8UZ8bWg1Cf7tzrlx8O0zazPk6TziFPY7tdD9HxBMcA1Rb0IssLW6B+ZzTqcpwdzaT43j
 lj/akCmMxv+2NRkxpDTAj20T3dbvIwnCGUmtgMEQX001H+wOlAxrB5zB1o1s6cKxTLYVrlD46oP
 s8/2bDTvAkh6Kk1CC7tZ1CQhaTy42ny24SgDmEKrk=
X-Gm-Gg: ASbGncu8h51N7C8f7FheDyo1DGnG3EdfDueC6Rkd5dV/wCGuk4RxiRuTIyojRAXlm77
 H3KJ4Lx79GLqlnE0aT4Qyva3CnzqtiTZ+JlVmzhfQurhXLA44JkL1iun5Fb7lWQKqhw1C6EO1Bc
 HNG+MqoeURvhDrXMwMiUySXvHnWT8k7mn7ZuPmYjvfV0QXMCQLVsBTCvlel70nWhSfGqCuywF3N
 9aWCItoisOHAi8RfdKPSBvnNYzgt49Rs42dausby9bJNUe337zT4Sgc4xo2
X-Received: by 2002:a5d:5f94:0:b0:425:7406:d298 with SMTP id
 ffacd0b85a97d-429a7e35cf6mr3344367f8f.5.1761650929904; 
 Tue, 28 Oct 2025 04:28:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGuLhOoG7p7dNcptWEv8psw5Y9KKpqGHu0MMUmgiLFzkj/7E/dVHul0xgQAU9S8SOvuI20rHlavxHoouTbzFM0=
X-Received: by 2002:a5d:5f94:0:b0:425:7406:d298 with SMTP id
 ffacd0b85a97d-429a7e35cf6mr3344337f8f.5.1761650929519; Tue, 28 Oct 2025
 04:28:49 -0700 (PDT)
MIME-Version: 1.0
References: <db9abfc03f0dbc953ef314ff7f13ff19298efa7d.1761644606.git.chenmiao@openatom.club>
 <CABgObfaBbf9Hq7RRLkhsa5n0-J+boe1T4guEakOEXDHFrc=4AQ@mail.gmail.com>
 <c1d55488-71e2-498f-a845-d8a336c46f07@openatom.club>
In-Reply-To: <c1d55488-71e2-498f-a845-d8a336c46f07@openatom.club>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 28 Oct 2025 12:28:35 +0100
X-Gm-Features: AWmQ_bmKe4jB2VpFgrvi05USuxtVXHc_MRiuBnzhwWqFITPGp6L5PeM1JFNI-W4
Message-ID: <CABgObfYbJ0jmnRkM=R9JN_SYZx1ybYxt3Y7dxDx0oJFG5BNf6Q@mail.gmail.com>
Subject: Re: [RFC PATCH v2 2/5] rust/hw/core: Add rust bindings/funcs for i2c
 bus
To: Chen Miao <chenmiao@openatom.club>
Cc: zhao1.liu@intel.com, manos.pitsidianakis@linaro.org, 
 richard.henderson@linaro.org, philmd@linaro.org, chao.liu@openatom.club, 
 qemu-rust@nongnu.org, qemu-devel@nongnu.org, 
 hust-os-kernel-patches@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
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

On Tue, Oct 28, 2025 at 12:18=E2=80=AFPM Chen Miao <chenmiao@openatom.club>=
 wrote:
>
> On 10/28/2025 6:45 PM, Paolo Bonzini wrote:
> > On Tue, Oct 28, 2025 at 11:18=E2=80=AFAM chenmiao <chenmiao@openatom.cl=
ub> wrote:
> >> During the implementation process, we found that the current two parad=
igms in
> >> Rust =E2=80=94 bindings and impl =E2=80=94 are extremely complex and l=
ack comprehensive
> >> documentation. There is no clear explanation as to why Bus and Device =
models
> >> need to be implemented using different approaches.
> > I don't think they need to be implemented using different approaches.
> > The difference between the two is that:
> >
> > - the currently implemented devices do not expose any bus, they stay
> > on a bus. This means the bus is never a child of the device
> >
> > - the currently implemented buses are all in C code, whereas there are
> > devices implemented in Rust.
> >
> > I agree that the Rust-to-C bridge code is complex, but it does have
> > documentation, much more so than the C versions in fact.  If there are
> > specific aspects of the documentation that you would like to see
> > improved, you can help by explaining what problems and sources of
> > confusion you encountered.
>
> That makes sense to me. Since buses are mainly implemented in C, the curr=
ent
> focus of Rust is on porting the device layer. Rust-implemented devices ar=
e
> consumers and do not create any child objects.
>
> I think our previous confusion stemmed from the assumption that Rust was
> porting the entire hierarchy, when in fact Rust is currently only impleme=
nting
> the device layer.
>
> >> +/// A safe wrapper around [`bindings::I2CBus`].
> >> +#[repr(transparent)]
> >> +#[derive(Debug, common::Wrapper)]
> >> +pub struct I2CBus(Opaque<bindings::I2CBus>);
> >> +
> >> +unsafe impl Send for I2CBus {}
> >> +unsafe impl Sync for I2CBus {}
> >> +
> >> +unsafe impl ObjectType for I2CBus {
> >> +    type Class =3D BusClass;
> >> +    const TYPE_NAME: &'static CStr =3D
> >> +        unsafe { CStr::from_bytes_with_nul_unchecked(bindings::TYPE_I=
2C_BUS) };
> >> +}
> >> +
> >> +qom_isa!(I2CBus: BusState, Object);
> >> +
> >> +// TODO: add virtual methods
> >> +pub trait I2CBusImpl: DeviceImpl + IsA<I2CBus> {}
> >> +/// Trait for methods of [`I2CBus`] and its subclasses.
> >> +pub trait I2CBusMethods: ObjectDeref
> >> +where
> >> +    Self::Target: IsA<I2CBus>
> >
> > There are no virtual methods, and therefore I2CBus does not have
> > subclasses.  Therefore you don't need these traits and you can
> > implement the functions directly on I2CBus.
>
> For this part, we directly referred to the implementation of SysBus.

I see. The difference is that:

- in sysbus there are virtual methods, but Rust does not let you override t=
hem

- in I2C there are no virtual methods added (and in fact you have
"type Class =3D BusClass").

> I'll revise all the points you have raised later.

Thank you!

Paolo


