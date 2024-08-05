Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F2BCC3DA7F
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2024 14:06:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sayKW-0005Kv-CL; Mon, 05 Aug 2024 10:04:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sayKU-0005KH-HQ
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 10:04:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sayKR-00014C-EC
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 10:04:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722866687;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R+AVzWWReouMoN7zruePSuW9jT4ReN30A6YfedCpgFI=;
 b=DU07lIZrxgj07jiAJ2oOwK3dj1AuNQR66AtyfpVXAKZc2yCta0TE3FkUdMIjbNUHzNT6RM
 73nc4eFD4ySNveoztccgJqpjZtSutNhJKU00vOrfta6rgrFfXmoolhGmkbempdCXCBid4/
 zTANVohbPhJoLm4sJURqnSGdz6lIV24=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618-BmQholBXOOiGNxGfFTklCw-1; Mon, 05 Aug 2024 10:04:46 -0400
X-MC-Unique: BmQholBXOOiGNxGfFTklCw-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-367990b4beeso5421123f8f.2
 for <qemu-devel@nongnu.org>; Mon, 05 Aug 2024 07:04:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722866684; x=1723471484;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R+AVzWWReouMoN7zruePSuW9jT4ReN30A6YfedCpgFI=;
 b=EqXg/vVwEn3iyMH1XlM99bchNrUgZqqgScCdk6sg3iPhwb8FdHCFLatEWlYRcr/d8M
 WfTLaGsgBsygh7WrR/sCHwy1y2L7KZYIr3/4N6C4Wc0MMVdWTTzdQHarwl+fxafpsddA
 bg3LSL3xeMVU16gh8rQZtE1pv1ErBoRhVWLu6yGJmwkTHPpzcuXUyrnt5MiCbJBMQ9Z7
 MrjmlgWS1/FMobAwLFsSp41I7kzlSsSy7vEJVlL7y2ffFgAYaiEaPe5YKK6YA2Pq7MJg
 7gRsrudADada+9oOvxqJhse7DQ3OKVXNefUFgpzwobumyarY2LDMv+t0xtpgxt9a2wDx
 RVqg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWKsGIHjRDRDkXWoXVVTHnIKQTsdHKLmr5XG9zgkXh91xH11JeJEsIEVlPrVyNcpJtoG3cHiPy0yZn8@nongnu.org
X-Gm-Message-State: AOJu0YzxEhU5RiSFMwfwGJgDiXd9LtqTls+FPsfqtteTsXVtA+/p5VmQ
 Yd6Gva/giiiGfxa17KJfqWuFIOzm5vb0w49fYQJLosvHmd4Qv0fpcNvL7B7Tqrv2K/1MFTAzNXX
 BEcycoKzbIsRFEYszitUvIJf4YmPqJoL73XsKAHDyYtoogKtv5ziB8d4/1NT5
X-Received: by 2002:adf:e84b:0:b0:368:48b1:803 with SMTP id
 ffacd0b85a97d-36bbc0a7516mr7666471f8f.12.1722866683804; 
 Mon, 05 Aug 2024 07:04:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHqMOWFKU9XiHMC7qZcwwpmZWNzT4B2DcK1et3m5b0MIWcN/Gs6j/xwsCEBWBB3P7GaUOmicw==
X-Received: by 2002:adf:e84b:0:b0:368:48b1:803 with SMTP id
 ffacd0b85a97d-36bbc0a7516mr7666448f8f.12.1722866683267; 
 Mon, 05 Aug 2024 07:04:43 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36bbd01b5c4sm9894503f8f.42.2024.08.05.07.04.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Aug 2024 07:04:42 -0700 (PDT)
Date: Mon, 5 Aug 2024 16:04:39 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Shiju Jose <shiju.jose@huawei.com>, "Michael
 S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>, Shannon Zhao
 <shannon.zhaosl@gmail.com>, linux-kernel@vger.kernel.org,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v3 1/7] arm/virt: place power button pin number on a define
Message-ID: <20240805160439.0bafb58d@imammedo.users.ipa.redhat.com>
In-Reply-To: <20240801151544.2f315598@foz.lan>
References: <cover.1721630625.git.mchehab+huawei@kernel.org>
 <bf8367bddfdc95e378b5725c732533c3ba20d388.1721630625.git.mchehab+huawei@kernel.org>
 <20240730092549.6898ff3c@imammedo.users.ipa.redhat.com>
 <CAFEAcA8VWc3eQZqfJP9k5LYF-9aLChHQ+uS9UBfGV6nvybDxqQ@mail.gmail.com>
 <20240730132620.46cca4ce@imammedo.users.ipa.redhat.com>
 <20240801151544.2f315598@foz.lan>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, 1 Aug 2024 15:15:44 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Em Tue, 30 Jul 2024 13:26:20 +0200
> Igor Mammedov <imammedo@redhat.com> escreveu:
> 
> > On Tue, 30 Jul 2024 09:29:37 +0100
> > Peter Maydell <peter.maydell@linaro.org> wrote:
> >   
> > > On Tue, 30 Jul 2024 at 08:26, Igor Mammedov <imammedo@redhat.com> wrote:    
> > > >
> > > > On Mon, 22 Jul 2024 08:45:53 +0200
> > > > Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> > > >      
> > > > > Having magic numbers inside the code is not a good idea, as it
> > > > > is error-prone. So, instead, create a macro with the number
> > > > > definition.
> > > > >
> > > > > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > > > > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>      
> > >     
> > > > > diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> > > > > index b0c68d66a345..c99c8b1713c6 100644
> > > > > --- a/hw/arm/virt.c
> > > > > +++ b/hw/arm/virt.c
> > > > > @@ -1004,7 +1004,7 @@ static void virt_powerdown_req(Notifier *n, void *opaque)
> > > > >      if (s->acpi_dev) {
> > > > >          acpi_send_event(s->acpi_dev, ACPI_POWER_DOWN_STATUS);
> > > > >      } else {
> > > > > -        /* use gpio Pin 3 for power button event */
> > > > > +        /* use gpio Pin for power button event */
> > > > >          qemu_set_irq(qdev_get_gpio_in(gpio_key_dev, 0), 1);      
> > > >
> > > > /me confused, it was saying Pin 3 but is passing 0 as argument where as elsewhere
> > > > you are passing 3. Is this a bug?      
> > > 
> > > No. The gpio_key_dev is a gpio-key device which has one
> > > input (which you assert to "press the key") and one output,
> > > which goes high when the key is pressed and then falls
> > > 100ms later. The virt board wires up the output of the
> > > gpio-key device to input 3 on the PL061 GPIO controller.
> > > (This happens in create_gpio_keys().) So the code is correct
> > > to assert input 0 on the gpio-key device and the comment
> > > isn't wrong that this results in GPIO pin 3 being asserted:
> > > the link is just indirect.    
> > 
> > it's likely obvious to ARM folks, but maybe comment should
> > clarify above for unaware.  
> 
> Not sure if a comment here with the pin number is a good idea.
> After all, this patch was originated because we were using
> Pin 6 for GPIO error, while the comment was outdated (stating
> that it was pin 8 instead) :-)
> 
> After this series, there will be two GPIO pins used inside arm/virt,
> both defined at arm/virt.h:
> 
> 	/* GPIO pins */
> 	#define GPIO_PIN_POWER_BUTTON  3
> 	#define GPIO_PIN_GENERIC_ERROR 6
> 
> Those macros are used when GPIOs are created:
> 
> 	static void create_gpio_keys(char *fdt, DeviceState *pl061_dev,
> 	                             uint32_t phandle)
> 	{
> 	    gpio_key_dev = sysbus_create_simple("gpio-key", -1,
> 	                                        qdev_get_gpio_in(pl061_dev,
>                                                          GPIO_PIN_POWER_BUTTON));
> 	    gpio_error_dev = sysbus_create_simple("gpio-key", -1,
> 	                                          qdev_get_gpio_in(pl061_dev,
> 	                                                           GPIO_PIN_GENERIC_ERROR));
> So, at least for me, it is clear that gpio_key_dev is using pin 3.

if you switch to using already existing GED device,
then this patch will go away since event will be delivered by GED
instead of GPIO + _AEI.

> 
> Thanks,
> Mauro
> 


