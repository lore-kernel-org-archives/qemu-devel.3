Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78B87C83F17
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Jul 2025 14:36:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucmCD-0006lW-00; Fri, 18 Jul 2025 10:36:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yvugenfi@redhat.com>)
 id 1ucmBz-0006ej-Fz
 for qemu-devel@nongnu.org; Fri, 18 Jul 2025 10:36:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yvugenfi@redhat.com>)
 id 1ucmBx-0007LB-Ef
 for qemu-devel@nongnu.org; Fri, 18 Jul 2025 10:36:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752849364;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/7mXpn6xvDYVa4/hgVoaIhiFdYrOWIfdw5OqPsoMzqY=;
 b=D+X9Y93PePc+JHaqgapRoyPKSa7Loh8JBMV8Wd289PLyULtnqNRgCkPOp8BWYvz7d0YQ38
 e4TsDTkMmMXblrCeRf5LcXNYLH0sywoE/WCJB1r4tqHrO//IL9Ju895XtHpq4cKgR+W8Hv
 EAH9JzNsl0Lh8CUNWwH1dD7yLW2+6oc=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-212-G7EHHN4CM9K3dQvXkRsOzA-1; Fri, 18 Jul 2025 10:36:02 -0400
X-MC-Unique: G7EHHN4CM9K3dQvXkRsOzA-1
X-Mimecast-MFC-AGG-ID: G7EHHN4CM9K3dQvXkRsOzA_1752849360
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-7194c6b0892so16433437b3.1
 for <qemu-devel@nongnu.org>; Fri, 18 Jul 2025 07:36:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752849360; x=1753454160;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/7mXpn6xvDYVa4/hgVoaIhiFdYrOWIfdw5OqPsoMzqY=;
 b=rpMqBowaYxexSdrfeJy/ARoY8nwJrD52Fcdfc5sxYqlZZiwB1M0IZu5+vZ06wY0WZC
 fqwgQ+X6aa8rbdndAYY2ElpaAHoBt+Sqq+qGoYuX1bAvBcHDEgt19CFXPe2IexQZk0UR
 oWjxWTL6/uXHYcVokKVP2QnkGeaKbS1QBz5ddSnw7pH47tify1f5uKlsOzSRO2oPlqZ7
 LyE4X87axtoNrH+eLiLQZPSD76iT2p9iKOjKrt41+piG0MLpfm+DdIUA+jBpcNn2ZV4c
 L6APHxBGuIleudqGgC1swdBoSctLEj7DWLURKns3PA6JxpnNy/5zHaZHZspBtMsaTmY1
 cwgQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVDrPZl3M8kwy8+aVbBgUbSd6kx9TDm1GaSBIUHhHLeBQlCYY4Q0jlrTqp6KNBcUs4mUSRnfuexRXWF@nongnu.org
X-Gm-Message-State: AOJu0Yx3SOKUoTRA/fVH/j1QQi17JhmZxZhiD04A186J7FaHNNA2aEhz
 7AexALqh88Um4K16VuXQjp8DCFwX7kareYDrWWoLxz8ynegvXNYzleO8j59GmEtqht+sa+Sxf4S
 EuuWhQ2aUhWDrzrEKvCsfAhM5ZQdb4VKrrFP1MmLspH1QeIWuc3IgMJSyJWQ7Fiff3KBudcKSLX
 RxZ08ZgFy3zzsJlrFVa29JbWnEVaf/3ss=
X-Gm-Gg: ASbGncuTjzltnN5NfiWwO1QQkT+3KZGCjIUpYQsAZh4oRCyOiKC/qqew9Ni2RzB7ujx
 Omn5gpBmqwKhcCHmaozqpudG7f2MDaTcKCMEoBYOm3rxJe4WrC0SWJGnO9lP38KlYLGrDZX/B4b
 E/zPh3yYlHd6A4jsNorVo=
X-Received: by 2002:a05:690c:4c10:b0:70d:ed5d:b4cd with SMTP id
 00721157ae682-718374f0e8dmr155609817b3.17.1752849359806; 
 Fri, 18 Jul 2025 07:35:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHLmB0TGvM7DPbc8JGsoF9emG1gUoz5meiT0pBj1WgeRND6u/bcTbyWPfL1xaHtIngrHLWea5R3pGTg3hagcN8=
X-Received: by 2002:a05:690c:4c10:b0:70d:ed5d:b4cd with SMTP id
 00721157ae682-718374f0e8dmr155609407b3.17.1752849359320; Fri, 18 Jul 2025
 07:35:59 -0700 (PDT)
MIME-Version: 1.0
References: <20250610143259.1056400-1-cohuck@redhat.com>
 <20250610143259.1056400-3-cohuck@redhat.com>
 <aEhnbN1pSYgdi4EZ@redhat.com>
 <CABJz62O3FKYfUOyCLMotgYgckWV1frSUb=MtTW2J4fDTEg_==g@mail.gmail.com>
 <877c09792e.fsf@redhat.com> <aHZ7rpYFMWai-7RL@redhat.com>
 <CABJz62P+p_uYiatXroauLkG2AH2TnjS8drbHxLPsgY+=QSB8Lw@mail.gmail.com>
 <aHaC6_2vdXJqdxLo@redhat.com> <874iva7so9.fsf@redhat.com>
In-Reply-To: <874iva7so9.fsf@redhat.com>
From: Yan Vugenfirer <yvugenfi@redhat.com>
Date: Fri, 18 Jul 2025 17:35:48 +0300
X-Gm-Features: Ac12FXweEF0cPlcLIfY6V4nT-cNG__C-B_slcMKqhSnanEZ5xXjFRwnGtg0WHDk
Message-ID: <CAGoVJZxGO05QSE20x7=F4ne4Hf4DOf2oMsWoo=2SQi8FumJ+7g@mail.gmail.com>
Subject: Re: [PATCH 2/2] watchdog: generic name for i6300esb
To: Cornelia Huck <cohuck@redhat.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Andrea Bolognani <abologna@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Eric Auger <eauger@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=yvugenfi@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Jul 17, 2025 at 9:14=E2=80=AFPM Cornelia Huck <cohuck@redhat.com> w=
rote:
>
> On Tue, Jul 15 2025, Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:
>
> > On Tue, Jul 15, 2025 at 09:16:24AM -0700, Andrea Bolognani wrote:
> >> On Tue, Jul 15, 2025 at 05:02:54PM +0100, Daniel P. Berrang=C3=A9 wrot=
e:
> >> > On Tue, Jul 15, 2025 at 05:44:25PM +0200, Cornelia Huck wrote:
> >> > > Hmm. So
> >> > > - request a new PCI id (probably in the PCI_DEVICE_ID_REDHAT_* spa=
ce)
> >> > > - restructure to have two devices base off the same core functiona=
lity
> >> > > - teach guest operating systems about the new device
> >> > > - teach management software like libvirt about the new device
> >> > >
> >> > > Not sure how fast we can get an ID (or even how to go about it.) T=
he
> >> > > second step should be reasonably easy. The third step is the most
> >> > > complex one, but at least teaching Linux should hopefully be easy
> >> > > enough, and existing guest operating systems could continue to use=
 the
> >> > > existing device. The last step is probably not that bad.
> >> > >
> >> > > I can start down that path, if we have some consensus that this is=
 the
> >> > > right way to handle this.
> >> > >
> >> > > I'd still argue that patch 1 should be applied regardless :)
> >> >
> >> > This sounds like a hell of alot of busy work to fix a problem that, =
IIUC,
> >> > does not actually exist from a functional POV - it is merely a perce=
ption
> >> > issue that people might be put off by the "Intel 6300ESB" names.
> >> >
> >> > IMHO a better use of time is to expand documentation to clarify this=
 is
> >> > just fine for all PCI architectures, and change nothing in either QE=
MU
> >> > or guest kernels.
> >>
> >> Agreed that it's not the most high-reward endeavor, but IIRC users
> >> were getting genuinely confused and annoyed by the string "Intel"
> >> showing up in their aarch64 guests.
> >
> > So be it, that's far from the only wierd thing in virt.
>
> So I'm wondering what the general sentiment is towards having an "Intel"
> device show up in your non-Intel guest. This device is generic enough to
> be included in PCI_DEVICES, and should be usable on any of those
> platforms.
>
> Linux treats this as a generic PCI driver as well. Do we know what
> Windows on non-x86 expects? The *BSDs? Others?

Eric just asked me about the i6300ESB on ARM and Windows.
Windows has i6300ESB device PNP ID in machine.inf:
%WatchdogTimer_Desc% =3D NO_DRV, PCI\VEN_8086&DEV_25AB
NO_DRV means that there is no device driver installed for the device,
but the device will have some "Friendly Name" in the device manager
and will be treated as installed device. Users could then install
Intel's driver.

Changing the device ID, will make this device as not-installed from
Windows perspective. If such device will be included by default for
some machine types, those machine types will not be able to pass
Microsoft SVVP certification because the OS will have a device without
a driver. The mitigation is to keep and certify our own dummy INF,
which is a grey zone as Intel should have their own driver certified
with MS.
This is very similar to the discussion we had about AMD IOMMU PCIe
endpoint PNP Id.

Best regards,
Yan.

>
> >
> >> You can point them to documentation over and over again, or you can
> >> work to prevent the confusion/annoyance from showing up in the first
> >> place. Which of the two approaches is a better use of anyone's time
> >> is up for debate.
> >>
> >> I for one am grateful that someone put the time in all those years
> >> ago and, as a result, PCI and USB controllers don't suffer from the
> >> problem today. Ultimately it's up to Connie though.
> >
> > The PCI/USB controller situation is not the same tradeoff though.
> > Those guest kernel drivers will identify and attach to these two
> > controllers regardless of their PCI vendor/product, via the PCI
> > class property. In that case changing the PCI ID and other device
> > metadata in QEMU is cheap as it has no negative impact on guest OS
> > driver compibility.
> >
> > In the case of 6300ESB though the guest driver is tied directly to
> > the currently used PCI device product/vendor ID.
> >
> > If we change this then we have actually created new functional
> > problems with guest/QEMU compatibility, in order to placate a
> > non-functional problem. That is not a good thing.
>
> I don't think the suggestion was to disable the existing driver on
> non-Intel setups, but to add a more generic one. Still, more work to get
> this actually propagated into guests than doing the change in
> QEMU. Before I start down that route, I'd like to know whether the issue
> is actually big enough to make investing time there worth it.
>
>


