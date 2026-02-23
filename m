Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E937E98E0F
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 09:29:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuSFK-00051U-42; Mon, 23 Feb 2026 04:28:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1vuSFG-0004yw-HA
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 04:28:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1vuSFE-0003A3-NF
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 04:28:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771838927;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3j1Kf3wdHdUxG4jChM+QvY+3gM/v+54Pu2DXZbHWEm4=;
 b=FFJpQtgxSVRSHI4H50vk2Jl3Ny0FQWTk1M0q4fnKNpdVFd6N8FeIxUYQxqsljIeCT9/DqT
 zisO7J/HCFL8qYNgZeUTHN89bCH+sw3i0Z+MoesUwetCZ1RhiUJOnFlvYu3cFTd2p4xFsx
 CA49vFfhEpOoNQUP5MRGxqCiYPFAQ2U=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-8d7Jhd4UN0Ozre-3OYxMbw-1; Mon, 23 Feb 2026 04:28:44 -0500
X-MC-Unique: 8d7Jhd4UN0Ozre-3OYxMbw-1
X-Mimecast-MFC-AGG-ID: 8d7Jhd4UN0Ozre-3OYxMbw_1771838924
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4806cfffca6so38069495e9.2
 for <qemu-devel@nongnu.org>; Mon, 23 Feb 2026 01:28:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771838923; x=1772443723; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3j1Kf3wdHdUxG4jChM+QvY+3gM/v+54Pu2DXZbHWEm4=;
 b=sVuIikIjNXd2Va6mBvzkakbmQjoO4EHl4UQ7LksPKz5+kS0N6184s772uFKqhyxea3
 BWvB/judoj+wdVgqGuvId4s6rrHuPd07MAkNfeLt7NVSm7CFXzEG4F8QXtMHIfcNrDUR
 c2V7wc5A3dFhw2o8OZnBIgypyg8cv4G+9jL88nQXXp5NJVY2VY5+b6QnZCbChmo4aFlL
 SZ51Shv13llIE/5L++QIirLPcBuJbf/9s7aqTRL5MaEn0RscfDo7DXzaIvPn3mVyLgm6
 2WkdSsvL/znTGqS+A25HYhFho4rUeORkaK2vQHY9tWdo1GQiBhQwvz4tBL/wDG+ZKK3c
 pDVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771838923; x=1772443723;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3j1Kf3wdHdUxG4jChM+QvY+3gM/v+54Pu2DXZbHWEm4=;
 b=U7ylAPb1oRekOsmJqTn/WpWSJDDd9jLG61ma8+yTOYqA6x855kOTH0OibcqVLcnlys
 cUXvVWtWzX6fSkBOleKbXWf1/UIhhlK/FpKf5xqZFlCulpc7q7teTwOVICGf9Musz5an
 4kVfBT839vMBNgjQN4QR7IWkdoF64EcaiCHLBtHD6jM28YUjWlR/bmn5qxMd9nO0NtPU
 ldnmgsBVA2mhdm0FmFjaAak6xYBXA43kIqtko491FzT2cQBKtuc2xVdCgaDCpGo4IGY7
 jPdwqMzq3BiYDwImoCo8z/xEGWUD5Xnv4gEkthmU/qHrPeVsdgajzhr4DapRiT5/FPdm
 qebg==
X-Gm-Message-State: AOJu0Yx1SGsvL/o2HOLF1s6Byz2zXcGKDf32D0M1iapnEbGh1ZdhaTJY
 Ui0WTY1YBVQityT8zCu8YcwKhL6mtskrMlAiRyLjl2r1ua7SGdruBUNiYl4T6SRI1Ypq83hVAy2
 8gsnbIpZmOSDj7lUqet/7GO3EoyRvnthKT3HP4zGFzuGTYri2X1h3SxAo
X-Gm-Gg: AZuq6aIJgqHKATDK6M0ftKJkJWbYPH61rn9X7iCQ8MMdi9gy58J07GzLbWkKWRuDXvl
 2+nja/JSScGFQnAR8uv0SbL2oVx/vAz5bX62MF5kUXoyexp39U767bOUAXjmrGupY96Ip140J2p
 nt7+/Cc3eKKXDUR9Tdic/xNY4bLjyZD0ojl+toGqMlwOplFTrk2AvuVqsDLDXfVQkIaBjSXDt7w
 VD6j4TMGqgsgznP6vtCOLK+bRG4WMoxmJFmvjvJLa3c1nF8AVtVFaQziY0JZSFmhsy2wvnjFOnz
 6wi6rrj9vcXNI5PJOIemVwxqJiy9Htyn5CCmMn0hOXZSnAhRFArW5RSklF1IcZADwx1TCWo/lqh
 61CNwxA==
X-Received: by 2002:a05:600c:470f:b0:482:eec4:758 with SMTP id
 5b1f17b1804b1-483a95eaa50mr100292675e9.26.1771838923344; 
 Mon, 23 Feb 2026 01:28:43 -0800 (PST)
X-Received: by 2002:a05:600c:470f:b0:482:eec4:758 with SMTP id
 5b1f17b1804b1-483a95eaa50mr100292415e9.26.1771838922865; 
 Mon, 23 Feb 2026 01:28:42 -0800 (PST)
Received: from imammedo ([213.175.46.86]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483a3dd3391sm163013065e9.1.2026.02.23.01.28.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Feb 2026 01:28:42 -0800 (PST)
Date: Mon, 23 Feb 2026 10:28:40 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, mst@redhat.com, anisinha@redhat.com,
 pbonzini@redhat.com, shannon.zhaosl@gmail.com, philmd@linaro.org,
 zhao1.liu@intel.com, rad@semihalf.com, leif.lindholm@oss.qualcomm.com,
 "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>
Subject: Re: [PATCH 08/11] arm: virt: create GWDT watchdog paired with WDAT
 ACPI table
Message-ID: <20260223102840.45ddd17e@imammedo>
In-Reply-To: <CAFEAcA_v4Y5NEiYZsTyQPt=orc8gxGJ_PWu55T_0mAt+iY4OQA@mail.gmail.com>
References: <20260206131438.1857182-1-imammedo@redhat.com>
 <20260206131438.1857182-9-imammedo@redhat.com>
 <CAFEAcA_QO_Pm5qKy2xOer+VmyMZ6KZ1KdUpf_ETV9fQu4YmaHg@mail.gmail.com>
 <20260219131751.4e4e4e0e@imammedo>
 <CAFEAcA-qaSRM9MJDk2nhDQKWoP7odcou2DXff-fuYPNEE=g6vg@mail.gmail.com>
 <20260219155538.6e0b5a4f@imammedo>
 <CAFEAcA_v4Y5NEiYZsTyQPt=orc8gxGJ_PWu55T_0mAt+iY4OQA@mail.gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.798, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.79,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, 19 Feb 2026 16:04:37 +0000
Peter Maydell <peter.maydell@linaro.org> wrote:

> On Thu, 19 Feb 2026 at 14:55, Igor Mammedov <imammedo@redhat.com> wrote:
> >
> > On Thu, 19 Feb 2026 13:00:13 +0000
> > Peter Maydell <peter.maydell@linaro.org> wrote:
> >  
> > > On Thu, 19 Feb 2026 at 12:17, Igor Mammedov <imammedo@redhat.com> wrote:  
> > > >
> > > > On Wed, 18 Feb 2026 19:08:36 +0000
> > > > Peter Maydell <peter.maydell@linaro.org> wrote:  
> > >  
> > > > > Please can you also add support for exposing this device
> > > > > in the device tree ?  
> > > >
> > > > It's possible,
> > > > but we probably should not enable it if acpi variant was requested,
> > > > to avoid confusion on guest side.  
> > >
> > > Why? Almost every other device on this board we advertise
> > > via DTB for device tree guests and via ACPI for ACPI guests.  
> 
> > If we expose both guest may try to load both drivers causing conflict or misbehavior.  
> 
> Huh? A guest will do one of:
>  1 read the ACPI tables, and load the driver based on the ACPI data
>  2 read the DTB, and load the driver based on the DTB
> 
> Nothing tries to read both at once, or it would get totally
> confused.
> 
> > I can try and see what arm kernel would do in presence if both
> > but that's not the point.  
> 
> We know already that this works fine, because almost every
> piece of hardware in the virt board is described in both
> the dtb and the ACPI tables.
> 
> > One should consider plain GWDT whatchdog as a different device
> > when compared to WDAT one.
> > The later one is basically an synthetic watchdog with it's own driver.
> > From guest pov they are different devices (using the same registers/irqs).  
> 
> But there is only one piece of hardware here, right?

To some degree only (GWDT is wired to use different frequency
depending if it's configured for native or WDAT usecase)

> I don't have an opinion on what the best way to tell the
> guest about that in the ACPI tables is. I just want us
> to report the presence of the watchdog in both DTB and ACPI,
> so that it is usable whichever the guest is using.

correct way would be for QEMU to ship following:
  1. DTB + watchdog descriptor in GTDT ACPI table for native watchdog
      for that one, GWDT is wired at 1GHz resolution (same as SBSA one)
      for current amr/virt machine type

 or alternatively
      
  2. WDAT table describing abstract watchdog
      for this one GWDT is wired to 1KHz resolution (limitation if MS spec)

     watchdog in GTDT is likely to cause conflict with WDAT watchdog timer.

Also given that DTB/GTDT spec doesn't provide explicit timer resolution,
native driver is not going to work correctly with 1Kz gwdt variant,
since it assumes wdt resolution is at 'System Counter clock frequency'
according to linux driver.

On top of current WADT impl, I can add #1 option on respin
if that is what you are asking for
(or just a DTB variant if that is sufficient for acceptance).

> > > > > Can we have a command line option name that isn't ACPI
> > > > > specific, please? There's nothing inherent to ACPI about
> > > > > "I would like a watchdog device".  
> > > >
> > > > that is specifically asking for ACPI flavor being used/configured.
> > > > acpi specific option conflates 2 things:
> > > >    1. watchdog device creation (of the board choice) with properties tuned for WDAT usage
> > > >    2. how to expose it on firmware level (in this case ACPI WDAT table)  
> > >
> > > Right, and I think that's the wrong way to approach this,
> > > at least for the virt board. We should either always create
> > > or allow the user to ask us to create a watchdog device.
> > > And then we should do what we do for all the other devices,
> > > which is expose it via both the mechanisms that we have
> > > for telling the guest about hardware (ACPI and DTB).  
> >
> > Looks like I wasn't clear, WDAT is not a description
> > of the hardware watchdog. It's a 'abstract watchdog device',
> > that uses a set IO/MMIO operations from WDAT table to manage
> > whatever hardware watchdog board provides. Guest uses WDAT
> > specific driver to manage it.  
> 
> Does the user need to care about how we report the hardware in
> the ACPI tables? Is there not a way we can report it that works
> for all guests?

it's more about letting user to pick what 'hardware' to use,
this is usually done in firmware setup GUI on bare metal.
In this case QEMU is playing the role of firmware knob.

I don't see how it would work for any guest without changing
guest behavior/configuration.

supported cases would be:
  q35:
    - off: not supported
    - native: default
         - Linux: present and in use by TCO driver but not running unless guest enables service,
         - on Windows, present but not in use)
    - wdat:
         - Linux: same as 'native' but in use by different driver (wdat_wdt)
         - Windows: present/in use by inbox driver, and armed/running by default on OS startup
                    not manageable by user on guest side.
  arm/virt:
    - off: default
    - native: DTB/GTDT pair exposed
       - Linux/Windows: I need to check what both would do with it.
    - wdat:
       - should be the same as q35 above

So far WDAT the only known way to start watchdog in Windows without having
install native drivers (or in absence of such also write/maintain them),
this series describes watchdog as an abstract one and helps in an effort
to avoid writing/maintaining multitude of drivers Windows drivers and
a means to manage them on guest side. It also lets us to change underlying
hardware transparently without breaking guest if we decide to change
used watchdog hw later on. 

That's what VMWare lets users to configure and this series tries to close
this feature gap.

> thanks
> -- PMM
> 


