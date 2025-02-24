Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 422F0C021A4
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2025 19:04:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmdjo-0003BF-IT; Mon, 24 Feb 2025 14:03:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1tmdjm-0003Au-4S
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 14:03:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1tmdjj-00037U-Bu
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 14:03:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740423804;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2N+OXapaV/iIw7aA4hfb4LeXnJWlMoZHF/LETRx9QtE=;
 b=La1kgwAn2BquTqq1W8UmgX+XhMZm42+h0s9P5tERgv/EnMz7D5lxhr0NCI0QbG9aRkzr5D
 2/2kzhn6CMK06Dn4A2rQRmr1XKTCXpcxu/mFGAehiy3vqgUvzGY2yrtpXCj12ApoYNF2tB
 dkqM/HoN4HMxjymTaYspkHdZYWU0kkk=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-UPQGWfFmNkOuv36Ti8xoGQ-1; Mon, 24 Feb 2025 14:03:20 -0500
X-MC-Unique: UPQGWfFmNkOuv36Ti8xoGQ-1
X-Mimecast-MFC-AGG-ID: UPQGWfFmNkOuv36Ti8xoGQ_1740423800
Received: by mail-io1-f70.google.com with SMTP id
 ca18e2360f4ac-855959904c5so44720839f.2
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2025 11:03:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740423800; x=1741028600;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2N+OXapaV/iIw7aA4hfb4LeXnJWlMoZHF/LETRx9QtE=;
 b=W/qyXxlpo29WjXVMbbznQDbPJCVlqrvb+QutgJDGuFIJdILIlV7iIEt2fxZw6lfdYj
 QK19NjRIWWa6sfcRWn27E87CtlU/pFqBkPyv0mSqW1y5qT3U+AY34ExAuO1ivE/mIM+9
 w597lcyWS2vr6KmaNBPk4gKrjnh/p9QlSH4mahytv9jq7i3eStX316Kbk8U3iv6LHMxO
 y9lFsTLbhAbTfgMFVvExkHUcRfBJelaI9js48Ke03EwPBXZB27l9eSvy58G2idSUZGMD
 p+kN5S2YvqmzlX/g+4xaY1SO329mJOpadPhPSHmcwRjAgEaDJVFdG91y4flKW9yf+VRk
 y+XQ==
X-Gm-Message-State: AOJu0Yyt/k51zqdwlg6ELBt0eEnntfgTSz9dkbBj7gXjVoiu1joaWTC/
 slgOV0NZ7yXAqEcnnFbxcKdMVHf/NZ68fuCGnp3aY+we+9yvU5+nziYiWpKcfb6cpqiZL5TR4Q/
 QN607QOdd+99yJnZffS//hmiF9zuuC21TWFI/alPpLfaqFvKj3VoK
X-Gm-Gg: ASbGncuH35rfMV0cz7UZI1m8g0PGPLEx6ad1PmQj6rQdbJVA3Z3RJE5/8m04PhIItWm
 +qyQeeJ80fWMI3tB2hNyg0VSp/EldwzYD7C+J9J+m4dJa3z1w95roVeEszcEuLkpkXeFEpUNf6h
 3haKq2mKosH+/2ofujq7sLBbB2zDAJqUjxZdqeCDJGsHb/8pGxg+U2XjwTqzvkDGUPA4WBVa+/w
 rQnWfkUaapxgOsbzW9o/X46Q8i7X2EsDqYRd0ldlXACNeKLHlZu5aFBLiq5hryVFTcl0ShNiMAn
 ImZ2y/RyETE8Ezp7ukA=
X-Received: by 2002:a05:6e02:1986:b0:3d1:8bf1:46f9 with SMTP id
 e9e14a558f8ab-3d2caf2e202mr36585025ab.7.1740423800029; 
 Mon, 24 Feb 2025 11:03:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEAGy4yFA84YbWJO8ilulY5ONcL6hpAHmuViTzMh6aWR03q5krdwQBiX0FeXYKm0wnxHZC7cQ==
X-Received: by 2002:a05:6e02:1986:b0:3d1:8bf1:46f9 with SMTP id
 e9e14a558f8ab-3d2caf2e202mr36584825ab.7.1740423799685; 
 Mon, 24 Feb 2025 11:03:19 -0800 (PST)
Received: from redhat.com ([38.15.36.11]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f0474985a9sm25481173.68.2025.02.24.11.03.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2025 11:03:18 -0800 (PST)
Date: Mon, 24 Feb 2025 12:03:16 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Cc: qemu-devel@nongnu.org, eric.auger.pro@gmail.com, clg@redhat.com,
 zhenzhong.duan@intel.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>, Akihiko Odaki
 <akihiko.odaki@daynix.com>, Jason Wang <jasowang@redhat.com>, Stefan Weil
 <sw@weilnetz.de>, Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, Keith
 Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>, Jesper
 Devantier <foss@defmacro.it>
Subject: Re: [PATCH 2/5] pci: Use PCI PM capability initializer
Message-ID: <20250224120316.36415fee.alex.williamson@redhat.com>
In-Reply-To: <5604e46b-da22-46df-9d6e-2a163df62881@redhat.com>
References: <20250220224918.2520417-1-alex.williamson@redhat.com>
 <20250220224918.2520417-3-alex.williamson@redhat.com>
 <5604e46b-da22-46df-9d6e-2a163df62881@redhat.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
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

On Mon, 24 Feb 2025 19:37:03 +0100
Eric Auger <eric.auger@redhat.com> wrote:

> Hi Alex,
>=20
> On 2/20/25 11:48 PM, Alex Williamson wrote:
> > Switch callers directly initializing the PCI PM capability with
> > pci_add_capability() to use pci_pm_init().
> >
> > Cc: Dmitry Fleytman <dmitry.fleytman@gmail.com>
> > Cc: Akihiko Odaki <akihiko.odaki@daynix.com>
> > Cc: Jason Wang <jasowang@redhat.com>
> > Cc: Stefan Weil <sw@weilnetz.de>
> > Cc: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
> > Cc: Keith Busch <kbusch@kernel.org>
> > Cc: Klaus Jensen <its@irrelevant.dk>
> > Cc: Jesper Devantier <foss@defmacro.it>
> > Cc: Michael S. Tsirkin <mst@redhat.com>
> > Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> > Cc: C=C3=A9dric Le Goater <clg@redhat.com>
> > Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> > ---
> >  hw/net/e1000e.c                 | 3 +--
> >  hw/net/eepro100.c               | 4 +---
> >  hw/net/igb.c                    | 3 +--
> >  hw/nvme/ctrl.c                  | 3 +--
> >  hw/pci-bridge/pcie_pci_bridge.c | 2 +-
> >  hw/vfio/pci.c                   | 2 +-
> >  hw/virtio/virtio-pci.c          | 3 +--
> >  7 files changed, 7 insertions(+), 13 deletions(-)
> >
> > diff --git a/hw/net/e1000e.c b/hw/net/e1000e.c
> > index f637853073e2..b72cbab7e889 100644
> > --- a/hw/net/e1000e.c
> > +++ b/hw/net/e1000e.c
> > @@ -372,8 +372,7 @@ static int
> >  e1000e_add_pm_capability(PCIDevice *pdev, uint8_t offset, uint16_t pmc)
> >  {
> >      Error *local_err =3D NULL;
> > -    int ret =3D pci_add_capability(pdev, PCI_CAP_ID_PM, offset,
> > -                                 PCI_PM_SIZEOF, &local_err);
> > +    int ret =3D pci_pm_init(pdev, offset, &local_err);
> > =20
> >      if (local_err) {
> >          error_report_err(local_err);
> > diff --git a/hw/net/eepro100.c b/hw/net/eepro100.c
> > index 6d853229aec2..29a39865a608 100644
> > --- a/hw/net/eepro100.c
> > +++ b/hw/net/eepro100.c
> > @@ -551,9 +551,7 @@ static void e100_pci_reset(EEPRO100State *s, Error =
**errp)
> >      if (info->power_management) {
> >          /* Power Management Capabilities */
> >          int cfg_offset =3D 0xdc;
> > -        int r =3D pci_add_capability(&s->dev, PCI_CAP_ID_PM,
> > -                                   cfg_offset, PCI_PM_SIZEOF,
> > -                                   errp);
> > +        int r =3D pci_pm_init(&s->dev, cfg_offset, errp);
> >          if (r < 0) {
> >              return;
> >          }
> > diff --git a/hw/net/igb.c b/hw/net/igb.c
> > index 4d93ce629f95..700dbc746d3d 100644
> > --- a/hw/net/igb.c
> > +++ b/hw/net/igb.c
> > @@ -356,8 +356,7 @@ static int
> >  igb_add_pm_capability(PCIDevice *pdev, uint8_t offset, uint16_t pmc)
> >  {
> >      Error *local_err =3D NULL;
> > -    int ret =3D pci_add_capability(pdev, PCI_CAP_ID_PM, offset,
> > -                                 PCI_PM_SIZEOF, &local_err);
> > +    int ret =3D pci_pm_init(pdev, offset, &local_err);
> > =20
> >      if (local_err) {
> >          error_report_err(local_err);
> > diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
> > index 68903d1d7067..1faea3d2b85b 100644
> > --- a/hw/nvme/ctrl.c
> > +++ b/hw/nvme/ctrl.c
> > @@ -8503,8 +8503,7 @@ static int nvme_add_pm_capability(PCIDevice *pci_=
dev, uint8_t offset)
> >      Error *err =3D NULL;
> >      int ret;
> > =20
> > -    ret =3D pci_add_capability(pci_dev, PCI_CAP_ID_PM, offset,
> > -                             PCI_PM_SIZEOF, &err);
> > +    ret =3D pci_pm_init(pci_dev, offset, &err);
> >      if (err) {
> >          error_report_err(err);
> >          return ret; =20
> nit: below there is a redundant
> =C2=A0=C2=A0=C2=A0 pci_set_word(pci_dev->wmask + offset + PCI_PM_CTRL,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 PCI_PM_CTRL_STATE_MASK);

Indeed there is, thanks for spotting that!  I'll fix it in the next
spin.  Thanks,

Alex


