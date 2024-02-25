Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6C2DC47DD9
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Feb 2024 22:10:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reMh7-00073u-Rk; Sun, 25 Feb 2024 17:10:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jandryuk@gmail.com>)
 id 1reMh5-00073V-0p
 for qemu-devel@nongnu.org; Sun, 25 Feb 2024 17:09:59 -0500
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jandryuk@gmail.com>)
 id 1reMh3-0002cW-Gq
 for qemu-devel@nongnu.org; Sun, 25 Feb 2024 17:09:58 -0500
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-563c0f13cabso3034325a12.3
 for <qemu-devel@nongnu.org>; Sun, 25 Feb 2024 14:09:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708898995; x=1709503795; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rpmwRK0QweucH9b9Rs/GnZrRDx/RfA9K31A46yAtE+M=;
 b=dgyxf0YA05Be66A+tKpGsc9+7RJDkzLWZpJrGCNcXKm9bYR5yNoteAWKSo5hkDlaRo
 hfCe1JD/rVJ1E6ffO2nFfnM/plHwMfMiCcbbAryJF3+zOv9AiPxK6JFx5W6eQY+JB2RB
 Y4ref8SXNcp2K46OyBKV8WCQroOG92gxYDorf926TbfNxrIIwH73ZVQjZgqjDzcXGvKd
 3mXfTETZcr5QYLFDhZOwjmjNe9V7vm6o0hwTnOcwiVweBGINjtkR7ex7fnZG6tIv5wc4
 QZSHUboQL52Drtj2SMp+fRszA70HJ/KD2SL1wdSIEXxTkGC7lJrLNU5zXMnaNw0I5l8/
 8hmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708898995; x=1709503795;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rpmwRK0QweucH9b9Rs/GnZrRDx/RfA9K31A46yAtE+M=;
 b=jlTEFIPYGjUKu/P3p+i9zokD78rr9VoEDaMMTUBcqvYifRycDmpM06N7MUlYUvGCtY
 ZSKHSJ0fMSVrNX1iW2lKIwkTeUymjRvR9IbvdfdfYnLHKvBmMO/3Co7Fy9RHkCYlmWNC
 UPOD5zWpcgVLXGBo4ww7KwpZMp9s1P57Oim8MGNq+IFFOJTZdj1/Wf/HZxOZrQF1avfp
 8DxqppFu0uXr61TYquw30CHUuMJHrNGplqrC6tNsjdmJKI4b8j3C0XFlw6v6PxpbRFuN
 VXXKvIWU8L5SsQQ3keyhEkKqIlV4c00PorY8d0Z8Vu4s4pP9R5xkuwzZ+69tkCFLliJs
 GkTQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVrjfIiACB8hwVzJID78rbngaL3bVciCSv/AO6cfrSJ4p2aTImyw9TtkDTEhcpOMyX3HJp/IJ0xKhgnl4xQl/aoOboZAcY=
X-Gm-Message-State: AOJu0Yxxh4XvYa6zUszxgeBkdgmCVd1GBE0D4iFCWOy7SoW7NjXlPkB/
 KXHBgmHC45CzWHsbAQ7Jq1GmJqW5Zd6Fy7agxqM3OmrGCUKrhhy8VbtddRFcQ0lrTb2aKwWx6wU
 lo+vevlbuOsNFlnSohPtMA6Q7/JQ=
X-Google-Smtp-Source: AGHT+IH5E3VRU8H5r8MxSJ69s61CROiFH/aDaz3qpmcnhpDcgzaqoQggtpdDq4fx2fyMmLEawOzXhXI2jdHbOujNZkE=
X-Received: by 2002:a05:6402:717:b0:565:cc2d:533 with SMTP id
 w23-20020a056402071700b00565cc2d0533mr1513727edx.1.1708898995198; Sun, 25 Feb
 2024 14:09:55 -0800 (PST)
MIME-Version: 1.0
References: <20240219181627.282097-1-marmarek@invisiblethingslab.com>
 <429a5a27-21b9-45bd-a1a6-a1c2ccc484c9@linaro.org>
In-Reply-To: <429a5a27-21b9-45bd-a1a6-a1c2ccc484c9@linaro.org>
From: Jason Andryuk <jandryuk@gmail.com>
Date: Sun, 25 Feb 2024 17:09:43 -0500
Message-ID: <CAKf6xpsG9bhRv9QPwhXtCoM+Zy+JCy+ceFEP2j-ZVVZC_yOe1w@mail.gmail.com>
Subject: Re: [PATCH 1/2] hw/xen: detect when running inside stubdomain
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: =?UTF-8?Q?Marek_Marczykowski=2DG=C3=B3recki?=
 <marmarek@invisiblethingslab.com>, 
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Claudio Fontana <cfontana@suse.de>, Stefano Stabellini <sstabellini@kernel.org>,
 Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>, 
 "open list:X86 Xen CPUs" <xen-devel@lists.xenproject.org>,
 David Woodhouse <dwmw2@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=jandryuk@gmail.com; helo=mail-ed1-x534.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, Feb 20, 2024 at 1:50=E2=80=AFAM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> On 19/2/24 19:16, Marek Marczykowski-G=C3=B3recki wrote:
> > Introduce global xen_is_stubdomain variable when qemu is running inside
> > a stubdomain instead of dom0. This will be relevant for subsequent
> > patches, as few things like accessing PCI config space need to be done
> > differently.
> >
> > Signed-off-by: Marek Marczykowski-G=C3=B3recki <marmarek@invisiblething=
slab.com>
> > ---
> >   hw/xen/xen-legacy-backend.c | 15 +++++++++++++++
> >   include/hw/xen/xen.h        |  1 +
> >   system/globals.c            |  1 +
> >   3 files changed, 17 insertions(+)
>
>
> > diff --git a/include/hw/xen/xen.h b/include/hw/xen/xen.h
> > index 37ecc91fc3..ecb89ecfc1 100644
> > --- a/include/hw/xen/xen.h
> > +++ b/include/hw/xen/xen.h
> > @@ -36,6 +36,7 @@ enum xen_mode {
> >   extern uint32_t xen_domid;
> >   extern enum xen_mode xen_mode;
> >   extern bool xen_domid_restrict;
> > +extern bool xen_is_stubdomain;
> >
> >   int xen_pci_slot_get_pirq(PCIDevice *pci_dev, int irq_num);
> >   int xen_set_pci_link_route(uint8_t link, uint8_t irq);
> > diff --git a/system/globals.c b/system/globals.c
> > index b6d4e72530..ac27d88bd4 100644
> > --- a/system/globals.c
> > +++ b/system/globals.c
> > @@ -62,6 +62,7 @@ bool qemu_uuid_set;
> >   uint32_t xen_domid;
> >   enum xen_mode xen_mode =3D XEN_DISABLED;
> >   bool xen_domid_restrict;
> > +bool xen_is_stubdomain;
>
> Note for myself, Paolo and Claudio, IIUC these fields belong
> to TYPE_XEN_ACCEL in accel/xen/xen-all.c. Maybe resulting in
> smth like:

I think some of these are used by the KVM Xen-emulation, so they can't
just be moved into the Xen accelerator.  David?

Regards,
Jason

