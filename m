Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B009C83F1B
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 06:51:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucIS5-0006xK-6G; Thu, 17 Jul 2025 02:50:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <oenhan@gmail.com>)
 id 1ucIR3-0005SZ-P5; Thu, 17 Jul 2025 02:49:42 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <oenhan@gmail.com>)
 id 1ucIR0-0002fp-Ck; Thu, 17 Jul 2025 02:49:41 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-3122368d7c4so612931a91.1; 
 Wed, 16 Jul 2025 23:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1752734975; x=1753339775; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ixrurWayV8+XR7IlXDsNMVgZieg0itryHEbYoWpM6Q0=;
 b=CqjizoIrLh/UdJazEtmqbqLgMmYfrPVtHt+Qj+CYPLhsx/yaumdIjytLwpTrHvsyfk
 8Bbg9KrY3BQ3kIkba0DMBV6bpFydceuLznfhDq0YkwiO7VzkkFcshNHaTk17MvWxikxo
 l/c8RlT6oLY8IusiiqSivQA1/E+hovZyYc7xkEFQCW0U9xa/HyAgVn7WF64yp3VIYwEa
 7zyp0Fk1DkElTM2k/0yrGie79V8sxyAjUT+frK45iRCU8j52USnI8q1uZ0SkBGOXRf2K
 Cs8lqf/99UHsVlrPXHC2cTrX56TPpk/VqdaeRyLSQR8X6yKTh/BUjKbuGXHwe0g2PzKJ
 Pxtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752734975; x=1753339775;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ixrurWayV8+XR7IlXDsNMVgZieg0itryHEbYoWpM6Q0=;
 b=KKjQ0EjA6IWtE1z+oYKsR+OTJ0d1p4oNxM8w/5q0a25iT3ltPRTbUrFIdq2LngVBzh
 YwWIm/y9NUiNOS/DT45kz/fjkcmTSdcdAt8SIIRhmXb6rdb8SlsTpGIjHbvQBIre6p2I
 pupoj0qzoCIZI3QFNtwbCAkw0cs33wB5/EBt5eoxKIJ9FLDUYnfgMWKtNlv1HiikA3ZA
 Fwuof1bFW6oRXzzWbwMoBJy6V4x4ll+scFcC/ZuacBmLAJYl7RH9HZKuhBzIc/7JG5Xm
 ey/pVhXgGe+MUhNkBPKaXzmEC1U7hz2ym+xl9ZYBk3dagncV1Xw4inGN4fXC6bCm9XeQ
 CDBA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVIFWNvUnJj+RL2bdf+QRs41xIBOWZUs81Nt4IgIM4oryYhpl6pREc108iFkDuvp/cTIx1+EDXNkg==@nongnu.org,
 AJvYcCWNrrWCJ4xjw9EdwXnjTVRjPvxR7OPeDmxsCSAQlweGpa6iymZS6tExPj4LPvzaNvbi5Tq3a2SSeDLAPQ==@nongnu.org,
 AJvYcCXrpxwH8z9/v9he1xQiq9H3jQkgTYTJLU0XeXHx4fAWnZQkxp93rzd2yHkKSHtVD+jhTwUDOs0woQilH/c=@nongnu.org
X-Gm-Message-State: AOJu0YwXrKGJ0c6/P6e1MQu3B3+SdIG9vgs53tC/wWFrBosYnd5HnARK
 QCMet1v+sZfBQh9p1n+13gb3pWgCyNNBDfDscEgvN/ARs3+CCd5vxiVzJ/aWS+YQzolEOVqluNP
 7qTlpkxWTfZpysL2IH7KXm92UoUar/eU=
X-Gm-Gg: ASbGncuo3LOHceF+dFO78KDghLaEG3cCxWKYLSrCta9v8KRTkByZ3SjpwP9UB3reESy
 dQUXZ1a6a+Lh/kb1opX/6Oz9qgnxV0juuX676gYQ3x4BYXLW9M8AgPf+I1xfQJRMVIkCp494Rtq
 v5rrjBE1sjL22VOVvzHZpGN6zHDBsOmXn7anaXHAKiM06QsFeLJg39/B+jP1dujaQ7iotIlrRn8
 iaRSR0=
X-Google-Smtp-Source: AGHT+IGiD0m+EJOTpp1XVyKnLczb6rMXChjjC81NzorMzAwWRsFPEsxbd7jzvwt/iiuO8Q85+yxU7IW+vwopPs2LP3E=
X-Received: by 2002:a17:90b:2747:b0:2ff:58c7:a71f with SMTP id
 98e67ed59e1d1-31c9e799ca0mr6785302a91.32.1752734974500; Wed, 16 Jul 2025
 23:49:34 -0700 (PDT)
MIME-Version: 1.0
References: <20250605083338.1845911-1-chenhgs@chinatelecom.cn>
 <238cce11-3050-4ec8-acbd-b1605f9dc4a1@tls.msk.ru>
 <CAAuJbe+dNpdA62CjfQfGq0Ph72w+Nooyax=WdRuYCRTPRngvxg@mail.gmail.com>
 <ef3f739d-5cda-4078-a5eb-ca6632d5e92e@redhat.com>
In-Reply-To: <ef3f739d-5cda-4078-a5eb-ca6632d5e92e@redhat.com>
From: Huaitong Han <oenhan@gmail.com>
Date: Thu, 17 Jul 2025 14:49:22 +0800
X-Gm-Features: Ac12FXyy6gnHOQxDUuTJmknhDDnaOybEv6qb10Q6fd9nOEQeOAbLUClgDD2r4IY
Message-ID: <CAAuJbeKgX7iQqswXBK2jFKmFKRKMUM1vigK_o9iL-UU6-y6YDQ@mail.gmail.com>
Subject: Re: [PATCH] vfio, migration: save device parent pci config
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Cc: mst@redhat.com, mjt@tls.msk.ru, qemu-devel@nongnu.org, 
 qemu-stable@nongnu.org, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Peter Maydell <peter.maydell@linaro.org>, John Levon <john.levon@nutanix.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=oenhan@gmail.com; helo=mail-pj1-x1029.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

C=C3=A9dric Le Goater <clg@redhat.com> =E4=BA=8E2025=E5=B9=B47=E6=9C=8815=
=E6=97=A5=E5=91=A8=E4=BA=8C 14:25=E5=86=99=E9=81=93=EF=BC=9A
>
> On 7/14/25 04:37, Huaitong Han wrote:
> > Hi, mst, clg
> >
> > Any comments?
>
>
> Since this seems to be a GIC issue on the aarch64 virt platform, you
> should cc: the virt-arm people for more insights.
>
> Also, the vfio-user devices have been merged very recently, ~1w ago,
> and, AFAICT, migration is not supported. Are you testing against the
> master QEMU branch ? Adding John in cc: nevertheless.

Yes, this is a problem with vfio and vgic working together on the
arm64 platform.
The test did not use qemu master, it uses our own backport branch.
However, this issue is essentially unrelated to vfio-user,  It is essential=
ly
an arm64 vfio device live migration issue. vfio-user only provides a test
case that support vfio device live migration. other devices that support
vfio live migration will also trigger the issue on the arm4 platform.

>
> Thanks,
>
> C.
>
>
>
> > Thanks.
> > Huaitong Han
> >
> > Michael Tokarev <mjt@tls.msk.ru> =E4=BA=8E2025=E5=B9=B47=E6=9C=8813=E6=
=97=A5=E5=91=A8=E6=97=A5 17:12=E5=86=99=E9=81=93=EF=BC=9A
> >
> >>
> >> Ping?  Has this been forgotten?
> >>
> >> Thanks,
> >>
> >> /mjt
> >>
> >> On 05.06.2025 11:33, oenhan@gmail.com wrote:
> >>> From: Huguanshen Chen <chenhgs@chinatelecom.cn>
> >>>
> >>> On arm64 virtualization platform, vfio-user devices lose their interr=
upts after
> >>> migration to the destination. This issue occurs because qemu fails to=
 deliver
> >>> the msi device id to the vGIC. The error device id is calculated base=
d on the
> >>> device's parent bus, so it is essential to save the parent pci config=
 to
> >>> prevent this issue.
> >>>
> >>> Backtrace:
> >>> QEMU:
> >>>    #0 qdev_get_parent_bus
> >>>    #1 pci_dev_bus_num
> >>>    #2 pci_req_id_cache_extract
> >>>    #3 pci_requester_id
> >>>    #4 kvm_irqchip_update_msi_route delivers 0(error id) to vGIC
> >>>
> >>> KVM:
> >>>    #0 find_its_device returns error
> >>>    #1 find_ite
> >>>    #2 vgic_its_resolve_lpi
> >>>    #3 vgic_its_trigger_msi
> >>>    #4 vgic_its_inject_msi
> >>>    #5 kvm_set_msi
> >>>    #6 kvm_send_userspace_msi
> >>>
> >>> Reported-by: Heng Zhang <zhangh121@chinatelecom.cn>
> >>> Signed-off-by: Huguanshen Chen <chenhgs@chinatelecom.cn>
> >>> Signed-off-by: Huaitong Han <hanht2@chinatelecom.cn>
> >>> ---
> >>>    hw/vfio/pci.c | 11 +++++++++++
> >>>    1 file changed, 11 insertions(+)
> >>>
> >>> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> >>> index a1bfdfe375..442113d0b7 100644
> >> ...
> >
>

