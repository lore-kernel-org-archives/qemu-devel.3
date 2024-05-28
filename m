Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5210C25B7C
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 13:54:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBxHW-00051R-UW; Tue, 28 May 2024 09:54:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sBxHT-00050Z-N2
 for qemu-devel@nongnu.org; Tue, 28 May 2024 09:54:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sBxHS-0004ad-9p
 for qemu-devel@nongnu.org; Tue, 28 May 2024 09:54:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716904461;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZzHRFdSoJwcsy3kELiTOQvcnuuigAZsc+tDUlyJuTGw=;
 b=Nbk2baMSBVZDK/AzbeW2LfgNWvzcWcWmUVQlQltJ3C7eRL3LmuLT9jtUjjyeQ+lcU1ucJ2
 LdBaIzPOt6xxNNqNRtz0gRW4Sf3SdBa3MMf4aujARdmp06KH1gua3mO4PRCg0bAXXchf71
 nG3PCzkHzSvq8u7uJ2JMai8sTMu0nk0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-436-HVkyCk3SPTKgw0qjNp3YrA-1; Tue, 28 May 2024 09:54:19 -0400
X-MC-Unique: HVkyCk3SPTKgw0qjNp3YrA-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-35507e4c41dso1902325f8f.1
 for <qemu-devel@nongnu.org>; Tue, 28 May 2024 06:54:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716904458; x=1717509258;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZzHRFdSoJwcsy3kELiTOQvcnuuigAZsc+tDUlyJuTGw=;
 b=HYVhoA2ZWt6AKng4Zb3St2kZtVnw7COfus27/OuT+1c3SnDV+gwjDoob9E85Tcj7zQ
 5zcdNZwgsex4lxlLtFRwAM/RlsAmURULHxPQsTQ8DEhWDcbVxou7wLRIHxoSFgpanJ3n
 LpeDEha8eqpxSdeUqxwryX7kQ8/tpCaQNcNhHSdm6qaY6CON7ukTCgxaXRU/90L2TPgT
 PBL1fKnlbWKgw1hRlIEiK8nlb79vubzXD2V0INpBayzS+UWQrrNQz5hsRXs50JM4jciY
 cdhj8CZtImZRybR0wXUrwvIhO+qVry/KuQB72eIhzMnSpOxvOnjk1GNY8m5dfsjaq3Rl
 /i9Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVZHWFGK498kkwhwhVVuVyVk1ZuU8BGzPo9055DLzYvbh+ooSZxL9nhCqzxJxZbDCMG3XrFiP6wHaVMDvoVLQprdKP8xXI=
X-Gm-Message-State: AOJu0YyQJlUXqUpPqmEtBCgBpPR+pOeWS1ylFimgGV1JPuoLGSf3zNPb
 IjkhgJpRDr9GsoXR0WsZlAACtgWtWKhhzjeDl+P2dsc5hjZKc5MWRxeSo3KYfOFWOEyxRY5alvK
 DwnQMc1hX0cdEeGHMHEZJlJE0e2kRgTGJcTwAxtXnu/F9xUMrFROXpHVobKF9eaBxtqEHvMMCc4
 tiFh6tf1+4eCtCp37V0cK0ytQ160w=
X-Received: by 2002:adf:fa02:0:b0:354:c330:5d2a with SMTP id
 ffacd0b85a97d-35506e04debmr8782249f8f.35.1716904458465; 
 Tue, 28 May 2024 06:54:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF3V9sQzsOiZ1MQph+1L4Q3Kt9irVCo8EqCKgjBQ0gHXQ5bWDME/XXukOR0j35sRyTEpoEYkdkKzQeVUtRApJQ=
X-Received: by 2002:adf:fa02:0:b0:354:c330:5d2a with SMTP id
 ffacd0b85a97d-35506e04debmr8782230f8f.35.1716904458056; Tue, 28 May 2024
 06:54:18 -0700 (PDT)
MIME-Version: 1.0
References: <20240528095459.896594-1-kraxel@redhat.com>
 <20240528095459.896594-4-kraxel@redhat.com>
 <8fa84896-f534-4d2e-8b00-057514a7de03@redhat.com>
In-Reply-To: <8fa84896-f534-4d2e-8b00-057514a7de03@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 28 May 2024 15:54:05 +0200
Message-ID: <CABgObfZQpAf1nohpbxtDrwWKc2oyOoxf73iND4FnZNQCp0xSRw@mail.gmail.com>
Subject: Re: [PATCH 3/4] usb/ohci-pci: deprecate, don't build by default
To: Thomas Huth <thuth@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org, 
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, 
 "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>,
 Nicholas Piggin <npiggin@gmail.com>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Helge Deller <deller@gmx.de>,
 Huacai Chen <chenhuacai@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.034,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Tue, May 28, 2024 at 12:35=E2=80=AFPM Thomas Huth <thuth@redhat.com> wro=
te:
> > diff --git a/hw/usb/Kconfig b/hw/usb/Kconfig
> > index 84bc7fbe36cd..c4a6ea5a687f 100644
> > --- a/hw/usb/Kconfig
> > +++ b/hw/usb/Kconfig
> > @@ -17,7 +17,6 @@ config USB_OHCI_SYSBUS
> >
> >   config USB_OHCI_PCI
> >       bool
> > -    default y if PCI_DEVICES
> >       depends on PCI
> >       select USB_OHCI
>
> Not sure whether we should disable it by default just because it is
> deprecated. We don't do that for any other devices as far as I know.
> Anyway, you should add the device to docs/about/deprecated.rst to really
> mark it as deprecated, since that's our official list (AFAIK).

That would mean removing it, but that's a bad idea. It's not like the
device is blocking improvements elsewhere (in fact it's not even
removing any code because the sysbus OHCI is still there).

> Also, there are still some machines that use this device:
>
> $ grep -r USB_OHCI_PCI *
> hw/hppa/Kconfig:    imply USB_OHCI_PCI
> hw/mips/Kconfig:    imply USB_OHCI_PCI
> hw/ppc/Kconfig:    imply USB_OHCI_PCI
> hw/ppc/Kconfig:    imply USB_OHCI_PCI
>
> pseries could certainly continue without OHCI AFAICT, but the others?

Yeah, this needs to be a per-machine type choice to warn about
discouraged devices. Some, such as Cirrus, can probably be
unconditional, but still I wouldn't remove them.


Paolo


