Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A632C48BC3
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Feb 2024 16:33:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rc6Z7-0007hr-WF; Mon, 19 Feb 2024 11:32:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tcminyard@gmail.com>)
 id 1rc6Z6-0007hW-4r
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 11:32:24 -0500
Received: from mail-oo1-xc30.google.com ([2607:f8b0:4864:20::c30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tcminyard@gmail.com>)
 id 1rc6Z4-0001fR-GJ
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 11:32:23 -0500
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-59fc2d22cfaso406811eaf.3
 for <qemu-devel@nongnu.org>; Mon, 19 Feb 2024 08:32:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708360340; x=1708965140; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:reply-to:message-id:subject:cc:to:from:date
 :sender:from:to:cc:subject:date:message-id:reply-to;
 bh=3b+2vls7OJnAJerYPXUw/3pwiXIfupUTxm4GLzDL49Y=;
 b=F/MTbV+RKU7JMSkLlLXV2BpdHveJQvPaLJf5I3bECe/IVjEvouFi9OiTQnBk5lanxf
 VRgpdXfmGsWEmgMthPIKo409s3+2sRHEpYxPck+ca/trcxNrTsMhl9RpBnwcD7ggtCjE
 GheW4q9q59PLeZzp4TflA+gaOHmavBJd6Ck6T4XPgDS5usuzJRPoK7s1NFCZYEpqhyC6
 v4n/YIF6rIwh2S6A/4aMnOe5H1O0yLk6rp1Q+1vRP8foagOGhCeqAsb6Kfba2g1Ar9CM
 GDrOf/pvoWsIMjjeh3M8bhfPfnOoWYxcZSAOrbMePEtiqdhgsfcHsdj2S1KpDxoYyywO
 YHpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708360340; x=1708965140;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:reply-to:message-id:subject:cc:to:from:date
 :sender:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3b+2vls7OJnAJerYPXUw/3pwiXIfupUTxm4GLzDL49Y=;
 b=A4OyGT2Zx6iWWe8LLZfcIUPkClIjgfvVztkknA7MDn+1YZ4LRa5YUziDmZO7DVtRB7
 n6b3Joj5PxT18qTd5XiuUPS2C8O3g0P6p7SevcSeVdmCohZ5FlwS/NaKIRTiSUgQERH5
 xMWmuvhxnwTX2SHPwbgaYjmDEeEQLrQFO04If+8iPknaSfJQ/nH9ddjI8Mx9J2vcGgKE
 sPXD6hyrua87Z8wycsKHjcKy/rnB3W562ZxXhuR3GNFDxw5xm9JMqF8FZybmDccVuSX6
 OAXCiXR+7hSI7pfQgiVevjUik4LYDvkDp2xkGGzM/3g29rAYoNQp+CwPatxfmyXibrJO
 nd5g==
X-Gm-Message-State: AOJu0YxJzZKYPSe2r8ogSZ5h71JAq1J+l350rGK2JP2Zk6cILZN02j3b
 Pndq7oNCHdLol72Jl+9xRNA7M1OOP/wXqrbctsi65rED/20Wxl1SrHbCzjs=
X-Google-Smtp-Source: AGHT+IGcyNRmSjfhH+wIOM8IhUQUrRoVKq5Ji1GeH2vpjlHHla60PF4U7h7qvb8iF6qlQPd71k5z8w==
X-Received: by 2002:a05:6820:b4b:b0:59f:efc9:fd63 with SMTP id
 dg11-20020a0568200b4b00b0059fefc9fd63mr1299178oob.7.1708360340509; 
 Mon, 19 Feb 2024 08:32:20 -0800 (PST)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
 by smtp.gmail.com with ESMTPSA id
 g17-20020a4a2511000000b0059d73a8454esm1091137ooa.24.2024.02.19.08.32.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Feb 2024 08:32:19 -0800 (PST)
Received: from mail.minyard.net (unknown [172.59.123.64])
 by serve.minyard.net (Postfix) with ESMTPSA id 3B9BD1800B8;
 Mon, 19 Feb 2024 16:32:19 +0000 (UTC)
Date: Mon, 19 Feb 2024 10:32:17 -0600
From: Corey Minyard <minyard@acm.org>
To: Paz Offer <poffer@nvidia.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: Trying to write data to i2c bus
Message-ID: <ZdOCkeotwf3EF11u@mail.minyard.net>
References: <MW4PR12MB6997A0A111FB6999ACF87F26A0512@MW4PR12MB6997.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <MW4PR12MB6997A0A111FB6999ACF87F26A0512@MW4PR12MB6997.namprd12.prod.outlook.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::c30;
 envelope-from=tcminyard@gmail.com; helo=mail-oo1-xc30.google.com
X-Spam_score_int: 18
X-Spam_score: 1.8
X-Spam_bar: +
X-Spam_report: (1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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
Reply-To: minyard@acm.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Feb 19, 2024 at 01:49:44PM +0000, Paz Offer wrote:
> Hi,
> 
> I am new to QEMU development, so please excuse if I my direction here is wrong:
> 
> I am trying to implement an i2c slave device.
> My device should be able to read/write data from its i2c bus.
> 
> I defined my device-state object like so:
> 
>     typedef struct {
>           I2CSlave i2c;
>           void     *my_data;
> 
>     }   MyI2CSlave;
> 
> 
> In my implementation occasionally I may have to send data on the bus, due to an internal event on my side.
> For this I implemented the following code:
> 
>     //  Get bus pointer:
>     BusState *parentBus = qdev_get_parent_bus(DEVICE(&obj->i2c));
>     I2CBus   *i2cBus    = I2C_BUS(parentBus);
>       
>     //  Try to send data on bus:  
>     if (i2c_start_send(i2cBus, address)) {
>         //  error?
>         return;
>     }
>     for (int i = 0; i < size; i++) {
>         i2c_send(i2cBus, data[i]);
>     }
>     i2c_end_transfer(i2cBus);
> 
>       
> The problem is that 'i2c_start_send()' always fails here:
> 
>     if (QLIST_EMPTY(&bus->current_devs)) {
>         return 1;
>     }
> 
> The member 'i2cBus->current_devs.lh_first' is always null.
> 
> I will add that in my QEMU execution I specify the bus 'aspeed.i2c.bus.0' to be used with my device.
> In my 'realize' method I can see that a bus is connected to my device, as 'qdev_get_parent_bus()' does return a valid pointer.
> 
> My question:
> 1. Am I missing some initialization for the bus?
> 2. Is there other way to send data on the i2c bus, assuming it can happen anytime due to an internal event on my device side?

You are missing a lot of stuff, but let's start with basics...

First of all, this is not how i2c generally works.  Generally you have a
bus master, the host, that reads and writes to slave devices on the bus.
The devices on the bus don't asynchronously send data to the host.

That said, you can have multiple bus masters on the bus.  If that's what
you are doing, what are you sending your data to?  You have to have
something that will receive it.

If you have some slave device that has data it's holding for the host,
the host has to fetch it.  You could have an interrupt that comes from
the slave device saying it has data, and there's something called SMBus
alert that can consolidate interrupts (though it's not implemented in
QEMU at the moment).

Are you simulating some real device here?

-corey

> 
> Thanks for any tip,
> Pazo  

