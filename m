Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE0BEE748F7
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Dec 2025 21:53:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vYAJY-0006GE-LR; Tue, 23 Dec 2025 16:53:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vYAJN-0006F9-3z
 for qemu-devel@nongnu.org; Tue, 23 Dec 2025 16:52:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vYAJL-0008ID-Pb
 for qemu-devel@nongnu.org; Tue, 23 Dec 2025 16:52:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766526773;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u547TcdkTveH8UcxNeSFqP27P9eZkQZdciclgSu+rd4=;
 b=Wtou3mVFqizRB7K0157fU0gWJNkSUUAgIu+h/HLMGN5+aIjH921mVn89377UipxeSsK9nU
 fgrYU/+SLfbUAto8ILj2il55YBDbans2IH+acrU811zKdjbi93fTVmP5hs7i+m/jv7xOK9
 dm8374ebqc6LyzgFnCrchY8RPDvZqc4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-330-ojlVbTNBMhiz51Ao7RM0Tg-1; Tue, 23 Dec 2025 16:52:50 -0500
X-MC-Unique: ojlVbTNBMhiz51Ao7RM0Tg-1
X-Mimecast-MFC-AGG-ID: ojlVbTNBMhiz51Ao7RM0Tg_1766526769
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-430f8866932so4146938f8f.1
 for <qemu-devel@nongnu.org>; Tue, 23 Dec 2025 13:52:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766526769; x=1767131569; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=u547TcdkTveH8UcxNeSFqP27P9eZkQZdciclgSu+rd4=;
 b=SQnAthtmS07sRea6KicoHIztCTZ/lJaSrZrxOjzOeQK35iD8Q/ADkC9DbXUFLQzP/U
 sAqVAGevvvKgv6/keXMCvaVxTqkGLhj5jooIcD4aaRzaJZNrx+ReFll72hfuPL6YWT4E
 S/5gUoCuJEN6jSl1Rbw9dU4k25EhCLCXMZ6bU53f7Vz9t54F2PGQ3+CBaLAZ8iVXexfu
 5fIlD8Wyt7xsUmBtsAd4GqCjga+Q7SMpnHaV01v9+jTC3EA/hQ5dQ4/wsOgy/wHkvQW9
 XuvGrRODN8qk/SgnmP1Bx9t1E7Tzjl3bpO+mFqhXebCN3OjrIKEcOybrbWvFC8Ko/1mW
 BBvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766526769; x=1767131569;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=u547TcdkTveH8UcxNeSFqP27P9eZkQZdciclgSu+rd4=;
 b=lD15q/RbHdwmKUmt8WC5uRVtiARTmbhzd4lxhiUWZGHLEIl8Q0DugdAQ5ctSxvtXIt
 /R0J7haoW1z+CAmkGyqcCL/hkKn9GxIfyYFbBIirFK6pSCTJHI+w2ugg+RmQwo/c9Qa+
 uF0CE1TpwDxogR+qrMS2VFBiyUhUOMTA/df0d21drm0be8xwxlNKL/N3y8te1p+sHzvF
 iUteGzWMiA4OuZJdSbucLWjyjIeuWPxZZOIsE5UYHMupNilkcjRGQYGP1ITQE1SNVV+v
 3cz/EFCP0Vk9T9T7n0rDgwBqCRaA9PYvm5/G/0ZiVhxooPk5Ob163P4rshn/Ipzvc59l
 BZZA==
X-Gm-Message-State: AOJu0Yzupz9FGXzDpmzzxvMi2fihFiZdFyfq5XDDZQgQs06D4UCajONV
 RN+FTisFk+fT5wbY27jQP9XQgaiNt2BKo1TsudKT/4wQq3A5I55tgB6K3HG0pU7V/qu3lMbUbhK
 iX9RXh0JZIg6jH/U/JKwmwYuZQBTWuEhCtO9NLUy4VpKCnspxCqj3CLHJ
X-Gm-Gg: AY/fxX7nVeLsYReV2eP1AyjFhBLitIy2d6nigiByv3I2wBP5naw12Co7RpkArGOLVGH
 2LdK49PH9WtFVpWIqTL1t+wq9hp0+afjbJ1WDrohE9C6ZxkLN2bTNFs7yOTto3mBHvC/R0eOqzI
 A6aCvBjCjcK9icPkWge/9scq53CEJHoP+DfWtR8k0nKmS4zxajPLjiiqnSdSZpKPtMKbm0+wCV6
 PXkSSxTCMQxQxrOsDbzRDEHqQuLX+2TUhrOP3a0Z+5OCq4qhhCQT+jWd3TkCMGdbUltVZY3XhKU
 aBzKdaiu+odRgAuqE3Sp0K9clMnx5YQFMcf9pTjGt91yDV3HMFjd2R0KzIB1g+sj+d536IMGnv2
 NNdZ/Q+oPC0IdPPmtlLCQND2wa8Jq3Mb1Pw==
X-Received: by 2002:a05:6000:4202:b0:430:f5ed:83fc with SMTP id
 ffacd0b85a97d-4324e4c7127mr19145616f8f.11.1766526769076; 
 Tue, 23 Dec 2025 13:52:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF/eM6UG6mS9OXbmj1K7TVf8i4iBV9YcKi44JVUZ7vE0lJ9WQGtgougu7R0pEaDEw9wcsyhLw==
X-Received: by 2002:a05:6000:4202:b0:430:f5ed:83fc with SMTP id
 ffacd0b85a97d-4324e4c7127mr19145608f8f.11.1766526768657; 
 Tue, 23 Dec 2025 13:52:48 -0800 (PST)
Received: from redhat.com (IGLD-80-230-31-118.inter.net.il. [80.230.31.118])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324ea1aee5sm30694419f8f.4.2025.12.23.13.52.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Dec 2025 13:52:48 -0800 (PST)
Date: Tue, 23 Dec 2025 16:52:45 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Jason Wang <jasowang@redhat.com>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: Re: [PATCH] hw/pci: Use correct bus aperture for device container size
Message-ID: <20251223165236-mutt-send-email-mst@kernel.org>
References: <20251124114754.79831-1-philmd@linaro.org>
 <3d5a30fd-fb49-42a1-ba1e-e2c4bfc58f83@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3d5a30fd-fb49-42a1-ba1e-e2c4bfc58f83@linaro.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Dec 23, 2025 at 02:52:20PM +0100, Philippe Mathieu-Daudé wrote:
> ping?


picked it up.

> On 24/11/25 12:47, Philippe Mathieu-Daudé wrote:
> > Before commit 3716d5902d7 ("pci: introduce a bus master container")
> > device view of the bus address space was correctly sized to the
> > bus aperture, but then it always used a 64-bit aperture. Restore
> > the previous behavior, so devices on 32-bit PCI only see 32-bit
> > address space.
> > 
> > Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> > ---
> >   hw/pci/pci.c | 3 ++-
> >   1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> > index b1eba348e06..64f33b9de04 100644
> > --- a/hw/pci/pci.c
> > +++ b/hw/pci/pci.c
> > @@ -1375,7 +1375,8 @@ static PCIDevice *do_pci_register_device(PCIDevice *pci_dev,
> >       pstrcpy(pci_dev->name, sizeof(pci_dev->name), name);
> >       memory_region_init(&pci_dev->bus_master_container_region, OBJECT(pci_dev),
> > -                       "bus master container", UINT64_MAX);
> > +                       "bus master container",
> > +                       memory_region_size(bus->address_space_mem));
> >       address_space_init(&pci_dev->bus_master_as,
> >                          &pci_dev->bus_master_container_region, pci_dev->name);
> >       pci_dev->bus_master_as.max_bounce_buffer_size =


