Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D04A8C48BC3
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Feb 2024 17:14:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rc7Di-0007fQ-Ac; Mon, 19 Feb 2024 12:14:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tcminyard@gmail.com>)
 id 1rc7Dg-0007ey-6p
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 12:14:20 -0500
Received: from mail-oi1-x22a.google.com ([2607:f8b0:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tcminyard@gmail.com>)
 id 1rc7Dd-00012T-0G
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 12:14:19 -0500
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-3c0485fc8b8so3779884b6e.3
 for <qemu-devel@nongnu.org>; Mon, 19 Feb 2024 09:14:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708362855; x=1708967655; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:reply-to:message-id:subject:cc:to:from:date
 :sender:from:to:cc:subject:date:message-id:reply-to;
 bh=VjO+NRF2yeSlWx4LFLrUd3DIA1I5O5/FtmMqal0ZqC0=;
 b=Ve9bN/haXmGAaTtjSCDNK0+Zq61OW6S9MTt2MTMkGMezTWuFZvI69RSkQ1rK022jHs
 U0rQkHFfmIDsUo2QSYZusf7BhY6gN+lesaHn+QfFBvPZkjUq+0ikF0GW7uSTOl9sFYCZ
 raBstvuVngT9iTjYFM8lYJpyUW5Jq9IatxTAYjgyN5hJakvC7Z+pD3xQf8S8Vofo8ZXs
 Am4UDL7xaH2pTRYGz6fF2jZyODTPSC/i2+sJnxjOAlefy8QtGw1hNEOUUyFGc782WywW
 zkj8yr3dE1HI/TIDlh+bPAyaVbue0BRrw3iI04STawC5kqH83ymEo5VAjdbwsuTL/dzc
 beUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708362855; x=1708967655;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:reply-to:message-id:subject:cc:to:from:date
 :sender:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VjO+NRF2yeSlWx4LFLrUd3DIA1I5O5/FtmMqal0ZqC0=;
 b=DmWpiBDBMACXLFhzYtHXDgr09e10T7rpGKyCMJbnyEihccqUFxNuRfXZ9vRJbPB0x9
 wkhVctW9J3EGMlULvl2izw1WvGKeDnAcQVIThic1MF96sbZT33TCt8GKPac26aWGiOIL
 QVqhaCE5P0j0qlxmqqIGJuo8zNUHbMSeAdzoSTm1cAwZrEstcikRPEwyRcco8a3FglTO
 giBOPYs+VLwUrIUgqXr8cDw8HB17KPRQYTnPECrTJFJUd/oFFeqbt3gtL9bbDDX0V2vT
 uN7wbEhp+wHSdA3fbRoK9sIKQIvsIU2pmk7pt6G91l808sy42GV/+uh8whMjKkkfKwJD
 T/eA==
X-Gm-Message-State: AOJu0Yz5lEY8ngntczz8vxWjYJrdUSUzBmtHRGzumocOXNZlgTIwnrNa
 98u1mAVTVhVMLRdoNDO32lE6JcQh/hGHhhd3sujP5Kb6a3Z11eh3JTUVvto=
X-Google-Smtp-Source: AGHT+IFTh/HUnAm0dJ2IIb9F3M0bxi0FD2beD0fiKf4ujUF6yDMzX61j4CKKxFsnYlUbL1TjIQsaiA==
X-Received: by 2002:a05:6808:1b1f:b0:3c1:604c:39e1 with SMTP id
 bx31-20020a0568081b1f00b003c1604c39e1mr1852951oib.10.1708362855220; 
 Mon, 19 Feb 2024 09:14:15 -0800 (PST)
Received: from serve.minyard.net ([47.184.181.2])
 by smtp.gmail.com with ESMTPSA id
 c15-20020a544e8f000000b003c15b756f3fsm337663oiy.13.2024.02.19.09.14.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Feb 2024 09:14:14 -0800 (PST)
Received: from mail.minyard.net (unknown [172.59.123.64])
 by serve.minyard.net (Postfix) with ESMTPSA id 08CD71800B8;
 Mon, 19 Feb 2024 17:14:13 +0000 (UTC)
Date: Mon, 19 Feb 2024 11:14:12 -0600
From: Corey Minyard <minyard@acm.org>
To: Paz Offer <poffer@nvidia.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: Trying to write data to i2c bus
Message-ID: <ZdOMZKTd+tZqVpcC@mail.minyard.net>
References: <MW4PR12MB6997A0A111FB6999ACF87F26A0512@MW4PR12MB6997.namprd12.prod.outlook.com>
 <ZdOCkeotwf3EF11u@mail.minyard.net>
 <MW4PR12MB69972BEDF8771C29A1E27C05A0512@MW4PR12MB6997.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <MW4PR12MB69972BEDF8771C29A1E27C05A0512@MW4PR12MB6997.namprd12.prod.outlook.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::22a;
 envelope-from=tcminyard@gmail.com; helo=mail-oi1-x22a.google.com
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

On Mon, Feb 19, 2024 at 04:53:47PM +0000, Paz Offer wrote:
> Thank you very much Corey,
> 
> I am simulating an external module that wants to communicate with the board management controller (BMC).
> The real device will be connected to the board using i2c bus, and could initiate communication at any time, by sending bytes over the bus.

And you have a simulated BMC that can do this?  Or is the system running
in qemu the BMC.

> 
> I am not sure whether the 'Master-side' (the side the initiating communication) needs to simulate a full i2c-master device, or whether my code could 'simply' write directly to the appropriate registers of the guest OS.
> Are there some examples or documentation on how to implement something like this?

The aspeed i2c controller is capable of having another bus master on an
I2C but, but it is the only host that can currently do it.

It is doable, the code is ther for multiple bus masters, but there is no
device currently that does it.  I assume that is coming at some point,
but no documentation exists on how to do it.

You can look at the git commits in hw/i2c around 37fa5ca42623 "hw/i2c:
support multiple masters" for the changes that were done to support
this.

I haven't done it, and I don't remember exactly how it works.

> 
> Sorry for my lacking knowledge on this, but I am quite new to QEMU...

You have a lot more to learn than this to make a qemu device.  And i2c
bus mastering in qemu is pretty esoteric, not many people know anything
about it.

-corey

> 
> Thanks again,
> Paz
> 
> 
> 
> 
> ________________________________
> From: Corey Minyard <tcminyard@gmail.com> on behalf of Corey Minyard <minyard@acm.org>
> Sent: Monday, February 19, 2024 6:32 PM
> To: Paz Offer <poffer@nvidia.com>
> Cc: qemu-devel@nongnu.org <qemu-devel@nongnu.org>
> Subject: Re: Trying to write data to i2c bus
> 
> External email: Use caution opening links or attachments
> 
> 
> On Mon, Feb 19, 2024 at 01:49:44PM +0000, Paz Offer wrote:
> > Hi,
> >
> > I am new to QEMU development, so please excuse if I my direction here is wrong:
> >
> > I am trying to implement an i2c slave device.
> > My device should be able to read/write data from its i2c bus.
> >
> > I defined my device-state object like so:
> >
> >     typedef struct {
> >           I2CSlave i2c;
> >           void     *my_data;
> >
> >     }   MyI2CSlave;
> >
> >
> > In my implementation occasionally I may have to send data on the bus, due to an internal event on my side.
> > For this I implemented the following code:
> >
> >     //  Get bus pointer:
> >     BusState *parentBus = qdev_get_parent_bus(DEVICE(&obj->i2c));
> >     I2CBus   *i2cBus    = I2C_BUS(parentBus);
> >       
> >     //  Try to send data on bus:  
> >     if (i2c_start_send(i2cBus, address)) {
> >         //  error?
> >         return;
> >     }
> >     for (int i = 0; i < size; i++) {
> >         i2c_send(i2cBus, data[i]);
> >     }
> >     i2c_end_transfer(i2cBus);
> >
> >       
> > The problem is that 'i2c_start_send()' always fails here:
> >
> >     if (QLIST_EMPTY(&bus->current_devs)) {
> >         return 1;
> >     }
> >
> > The member 'i2cBus->current_devs.lh_first' is always null.
> >
> > I will add that in my QEMU execution I specify the bus 'aspeed.i2c.bus.0' to be used with my device.
> > In my 'realize' method I can see that a bus is connected to my device, as 'qdev_get_parent_bus()' does return a valid pointer.
> >
> > My question:
> > 1. Am I missing some initialization for the bus?
> > 2. Is there other way to send data on the i2c bus, assuming it can happen anytime due to an internal event on my device side?
> 
> You are missing a lot of stuff, but let's start with basics...
> 
> First of all, this is not how i2c generally works.  Generally you have a
> bus master, the host, that reads and writes to slave devices on the bus.
> The devices on the bus don't asynchronously send data to the host.
> 
> That said, you can have multiple bus masters on the bus.  If that's what
> you are doing, what are you sending your data to?  You have to have
> something that will receive it.
> 
> If you have some slave device that has data it's holding for the host,
> the host has to fetch it.  You could have an interrupt that comes from
> the slave device saying it has data, and there's something called SMBus
> alert that can consolidate interrupts (though it's not implemented in
> QEMU at the moment).
> 
> Are you simulating some real device here?
> 
> -corey
> 
> >
> > Thanks for any tip,
> > Pazo  

