Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EC99EE4995
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 11:24:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soLRj-0000wS-Bk; Wed, 11 Sep 2024 07:23:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1soLRh-0000vV-Uo
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 07:23:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1soLRf-0000Xh-Cz
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 07:23:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726053814;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cZFoPmPpuO2DfEM0+eD4RlAlvohcJa8kYLUAaptsotU=;
 b=jAQWNIQ1eQRc96KYRq49tbSc1o/bbkH0Xwp56rehQ6/lCrCGlXNH+GzU8ldFnH3PVr36w9
 Gry+EgAcTwpTwOUYXPfVmZ/OFowFcQUaL9pafoRnlqrv5400Dek0W9DXb6S6C5QR2pDcZ8
 Vqp8dr4C2/MwoxfcCBKZZxtDU5dBknU=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-50-cAkwD8V1O7KqTkBOFqjYpg-1; Wed, 11 Sep 2024 07:23:33 -0400
X-MC-Unique: cAkwD8V1O7KqTkBOFqjYpg-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2f75ec1ddb3so36939681fa.3
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 04:23:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726053811; x=1726658611;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cZFoPmPpuO2DfEM0+eD4RlAlvohcJa8kYLUAaptsotU=;
 b=nSqTcXtpm7cT8Qtj9gfai+UqcNhjHp5LfmYzXYXI1HxcRmcHd5t2STLqpDRfD2nQfT
 8V74PATaIActIF8Pmc2AhRq18L7foVsYt5lXw5JR1mFHhGe5GKowr8yboC5uzcMVwmov
 VYdMwXpo4in77moR6WlbBmXwMYUcvsddU81GPqWrONHH0zU/avfjU8nGJ6sUO2ydHz0y
 WCB4/ShncB+2CxVXwCF1H69GacIZLdMPIoQtM+zub2Oc6mQ2rKo8baGXIHBiwA4kM9JX
 iJ8hWAaxPgKlc653GtudbwNCdXW+K8yDyTx0lL2/HQIs1PswyvRiYZWL9e/GVILduPO8
 qQXg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUmSi1kpTPNa/96Sbg3JUxIZfC5V8UMAhxcTy6V6UKcqsnsAO75Zb3AWAXgJ51KA1SDLVl31ceRfVym@nongnu.org
X-Gm-Message-State: AOJu0YxZrqvOj9B82aX1OipYR5C3zBxpRQ5OBy4JmJG07RZuVaCJn+3q
 SRUUMa8jS6/84+JdPh/qmFpHdFO1xDRtRBIaxGv6IFRIkb6ventvUpjNsuec/vw25i4v+k+KlwH
 n9zfRttkeuvhrk7YDLX/g9z+lpd1WMimA+h+i9drnatATUbInITOh
X-Received: by 2002:ac2:4e08:0:b0:536:5509:8862 with SMTP id
 2adb3069b0e04-536587dba89mr12260809e87.36.1726053811265; 
 Wed, 11 Sep 2024 04:23:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFEE0yMEldjnbn8heTlngCRqSTG+S20kUlnROZvV7HxWQ87OJ+5H2yav9XcertmE+AFy5UUWw==
X-Received: by 2002:ac2:4e08:0:b0:536:5509:8862 with SMTP id
 2adb3069b0e04-536587dba89mr12260768e87.36.1726053810217; 
 Wed, 11 Sep 2024 04:23:30 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1ec:a3d1:80b4:b3a2:70bf:9d18])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d25d547e5sm603072366b.201.2024.09.11.04.23.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2024 04:23:29 -0700 (PDT)
Date: Wed, 11 Sep 2024 07:23:25 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>, Markus Armbruster <armbru@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
Subject: Re: [PATCH for-9.2 v15 04/11] s390x/pci: Check for multifunction
 after device realization
Message-ID: <20240911072301-mutt-send-email-mst@kernel.org>
References: <20240823-reuse-v15-0-eddcb960e289@daynix.com>
 <20240823-reuse-v15-4-eddcb960e289@daynix.com>
 <2b5d2fce-8a1e-4f50-a5d2-0c4aaa2880af@redhat.com>
 <eaebda7d-c61e-4ed8-a6b9-98e5f48f26ff@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <eaebda7d-c61e-4ed8-a6b9-98e5f48f26ff@daynix.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Sep 11, 2024 at 07:58:15PM +0900, Akihiko Odaki wrote:
> On 2024/09/11 18:38, Cédric Le Goater wrote:
> > +Matthew +Eric
> > 
> > Side note for the maintainers :
> > 
> > Before this change, the igb device, which is multifunction, was working
> > fine under Linux.
> > 
> > Was there a fix in Linux since :
> > 
> >    57da367b9ec4 ("s390x/pci: forbid multifunction pci device")
> >    6069bcdeacee ("s390x/pci: Move some hotplug checks to the pre_plug
> > handler")
> > 
> > ?
> > 
> > s390 PCI devices do not have extended capabilities, so the igb device
> > does not expose the SRIOV capability and only the PF is accessible but
> > it doesn't seem to be an issue. (Btw, CONFIG_PCI_IOV is set to y in the
> > default Linux config which is unexpected)
> 
> Doesn't s390x really see extended capabilities? hw/s390x/s390-pci-inst.c has
> a call pci_config_size() and pci_host_config_write_common(), which means it
> is exposing the whole PCI Express configuration space. Why can't s390x use
> extended capabilities then?
> 
> The best option for fix would be to replace the SR-IOV implementation with
> stub if s390x cannot use the SR-IOV capability. However I still need to know
> at what level I should change the implementation (e.g., is it fine to remove
> the entire capability, or should I keep the capability while writes to its
> registers no-op?)
> 
> Regards,
> Akihiko Odaki

Note changing caps needs compat hacks for cross version migration to work.

> > 
> > Thanks,
> > 
> > C.
> > 
> > 
> > 
> > On 8/23/24 07:00, Akihiko Odaki wrote:
> > > The SR-IOV PFs set the multifunction bits during device realization so
> > > check them after that. This forbids adding SR-IOV devices to s390x.
> > > 
> > > Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> > > ---
> > >   hw/s390x/s390-pci-bus.c | 14 ++++++--------
> > >   1 file changed, 6 insertions(+), 8 deletions(-)
> > > 
> > > diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
> > > index 3e57d5faca18..00b2c1f6157b 100644
> > > --- a/hw/s390x/s390-pci-bus.c
> > > +++ b/hw/s390x/s390-pci-bus.c
> > > @@ -971,14 +971,7 @@ static void
> > > s390_pcihost_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
> > >                       "this device");
> > >       }
> > > -    if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_DEVICE)) {
> > > -        PCIDevice *pdev = PCI_DEVICE(dev);
> > > -
> > > -        if (pdev->cap_present & QEMU_PCI_CAP_MULTIFUNCTION) {
> > > -            error_setg(errp, "multifunction not supported in s390");
> > > -            return;
> > > -        }
> > > -    } else if (object_dynamic_cast(OBJECT(dev), TYPE_S390_PCI_DEVICE)) {
> > > +    if (object_dynamic_cast(OBJECT(dev), TYPE_S390_PCI_DEVICE)) {
> > >           S390PCIBusDevice *pbdev = S390_PCI_DEVICE(dev);
> > >           if (!s390_pci_alloc_idx(s, pbdev)) {
> > > @@ -1069,6 +1062,11 @@ static void s390_pcihost_plug(HotplugHandler
> > > *hotplug_dev, DeviceState *dev,
> > >       } else if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_DEVICE)) {
> > >           pdev = PCI_DEVICE(dev);
> > > +        if (pdev->cap_present & QEMU_PCI_CAP_MULTIFUNCTION) {
> > > +            error_setg(errp, "multifunction not supported in s390");
> > > +            return;
> > > +        }
> > > +
> > >           if (!dev->id) {
> > >               /* In the case the PCI device does not define an id */
> > >               /* we generate one based on the PCI address         */
> > > 
> > 


