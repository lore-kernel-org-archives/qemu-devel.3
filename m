Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D38D8C36010
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 15:25:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0iv1-0005K0-5y; Fri, 04 Apr 2025 11:25:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <corey@minyard.net>) id 1u0iux-0005I2-Nn
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 11:25:17 -0400
Received: from mail-oa1-x2b.google.com ([2001:4860:4864:20::2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <corey@minyard.net>) id 1u0iut-0004lU-6V
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 11:25:14 -0400
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-2c759bf1b2eso1098092fac.1
 for <qemu-devel@nongnu.org>; Fri, 04 Apr 2025 08:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=minyard-net.20230601.gappssmtp.com; s=20230601; t=1743780308; x=1744385108;
 darn=nongnu.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:reply-to:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Er2owa73AAbJzPZLZwKwfyfris3zY/ZvnqeCESEqA4c=;
 b=ofNSUsRgW6kJZY+iECEJ50vSJvv8bSab+pLhzE+SkVUMLpHVK8zjQjvmTA7Uq78xf/
 FgETwcQTvXQuiBYTLuHYeGAAKCldkvugDadkmWZpYkMfhyqhu5Q3e5jHqCdLDac2WhVe
 fB0QQ8PQQrimM5obcQR+VHEZxbbSTdL4hmKxp/n4XtrGSGDfKKtLBLDmY6y3u+pXvIEN
 op9iDHqrlU7wy4gYiB6DiwuaXyJzAbjHjj8lpqjAPVBPb4/I24HHu6DQNpXw57cyUl9l
 2I4fwl+H/nEoZI9xI7G6qNA9pQrUWVOAHe4yJAwXbOxk8bY336BlHJLoM7jLZrF9ueIs
 +PZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743780308; x=1744385108;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:reply-to:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Er2owa73AAbJzPZLZwKwfyfris3zY/ZvnqeCESEqA4c=;
 b=YEluvDP6iyX4hPwO7STVzmq9cRyjtTZbvzOjigQhhbgZJps0eQDRdBv0n+pPZ0W1SB
 WDCqeyNB/K5ycOdNJC0S9gOcH0Oyprf7QawfdXQnEKOzhhlH+Dh7BK7T5Uwyi0788GKD
 REGJi/Zt/F+f6k6zi8vTMQ+fUFsyikDJbCbyVBNgV4vOwnuAnpLUAfNMhoCq3pxHh017
 6nQm7BhJa+TW516KREWj7ifkFvbRldx9zj5mYjT5deGhQX1YAkmvmdQfgRWjWU0xuaHf
 VGSbSpFjYHXAtebzeG6LroOZ+OKOe9mXdCiwQR1eoNPxk8PW9IC+kU3kYTvpPpMaZ24W
 t5Gw==
X-Gm-Message-State: AOJu0Yy+mDxqxy5wIpaIIApL3h64iYDCAIqCRDsRNW7iNNgHVRWfefRu
 SPTMGSxqS9KRF1TUQzEl0ApKAxXRzcfPPS0SwgAw1tU9Uvi8lonaMWEm/G3GbCI=
X-Gm-Gg: ASbGncvXuDZgQSwxNpaLK8tbyuO6NT6lEJEaIoO/NvvVvJuc6R0N79CtxDkcoPN0HZ3
 z8z9T/fO9le5oNL9RPIeo4AP9ZTGJWATHzCS6/a/7ilSzdtfjTLtWkLPePHXK1FZw9OMz6fCpL1
 Nmn9eIfnoDFz6Wh4hlAlwbHYUjWmvXD+lpdjoQjdkQeSJbHbQ2quZBqN2Og4glFltCfgS+munGr
 HPXsCR2/FKQ+0HdX8pNDtee6QWLo5ouoPsxoqUiQ5cooEclsbwuRnJcyXi0KKAjvo/d4fxWCG3E
 mf+EnGLRE40bL74HDLy99tZy3E/MaGtBOiGq2t0C9HWqNyFS
X-Google-Smtp-Source: AGHT+IFacTXBc26u3hJLH1NwaQs74yB4j/pUOSTfcqE+21Lx39Y78cElXzsVjRFfam/KI1j+GTjjbA==
X-Received: by 2002:a05:6870:4e09:b0:2c2:5be4:c01e with SMTP id
 586e51a60fabf-2cca1879bf6mr1706960fac.1.1743780308219; 
 Fri, 04 Apr 2025 08:25:08 -0700 (PDT)
Received: from mail.minyard.net ([2001:470:b8f6:1b:5413:2ba6:c80b:5b46])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-72e30529d0csm685500a34.37.2025.04.04.08.25.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Apr 2025 08:25:07 -0700 (PDT)
Date: Fri, 4 Apr 2025 10:25:02 -0500
From: Corey Minyard <corey@minyard.net>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH] hw/ipmi: Allow multiple BMC instances
Message-ID: <Z-_5zkNXOlDKLfFU@mail.minyard.net>
References: <Z-8ujYWA8yBATtYK@mail.minyard.net>
 <438cb87a-cfa2-4392-92f4-bbb05f7a2ec2@linaro.org>
 <Z-_Y3VJ49yYyZmE4@mail.minyard.net>
 <e4181e5f-5393-4345-9dab-8bf1a6dcdd91@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e4181e5f-5393-4345-9dab-8bf1a6dcdd91@linaro.org>
Received-SPF: none client-ip=2001:4860:4864:20::2b;
 envelope-from=corey@minyard.net; helo=mail-oa1-x2b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Reply-To: corey@minyard.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Apr 04, 2025 at 03:21:09PM +0200, Philippe Mathieu-Daudé wrote:
> On 4/4/25 15:04, Corey Minyard wrote:
> > On Fri, Apr 04, 2025 at 02:41:46PM +0200, Philippe Mathieu-Daudé wrote:
> > > Hi Corey,
> > > 
> > > On 4/4/25 02:57, Corey Minyard wrote:
> > > > Allow a system to have multiple BMC connections to the same BMC and
> > > > multiple different BMCs.  This can happen on real systems, and is
> > > > useful for testing the IPMI driver on Linux.
> > > > 
> > > > Signed-off-by: Corey Minyard <corey@minyard.net>
> > > > ---
> > > > I'm working on a fairly extensive test suite for IPMI, the Linux
> > > > driver and qemu, and this is necessary for some driver tests.
> > > > 
> > > >    hw/ipmi/ipmi.c            | 1 +
> > > >    hw/ipmi/ipmi_bmc_extern.c | 5 +++--
> > > >    hw/ipmi/ipmi_bmc_sim.c    | 2 +-
> > > >    include/hw/ipmi/ipmi.h    | 1 +
> > > >    qemu-options.hx           | 9 ++++++++-
> > > >    5 files changed, 14 insertions(+), 4 deletions(-)
> > > > 
> > > > diff --git a/hw/ipmi/ipmi.c b/hw/ipmi/ipmi.c
> > > > index fdeaa5269f..ffd972f78b 100644
> > > > --- a/hw/ipmi/ipmi.c
> > > > +++ b/hw/ipmi/ipmi.c
> > > > @@ -110,6 +110,7 @@ void ipmi_bmc_find_and_link(Object *obj, Object **bmc)
> > > >    static const Property ipmi_bmc_properties[] = {
> > > >        DEFINE_PROP_UINT8("slave_addr",  IPMIBmc, slave_addr, 0x20),
> > > > +    DEFINE_PROP_UINT8("instance",    IPMIBmc, instance, 0),
> > > 
> > > Can we use "id" instead of "instance"? The latter confuses me, but
> > > maybe a matter of taste.
> > 
> > "id" means "identifier", not "instance".  The error log mentions
> > "instance", that that is what is passed to vmstate_register().
> 
> Note, vmstate_register() is a legacy API, with only 20 cases left to
> update. See commit 6caf1571a97 ("include/migration: mark
> vmstate_register() as a legacy function"):
> 
>     /**
>      * vmstate_register() - legacy function to register state
>      * serialisation description
>      *
>      * New code shouldn't be using this function as QOM-ified devices
>      * have dc->vmsd to store the serialisation description.
>      *
>      * Returns: 0 on success, -1 on failure
>      */
> 
> > Maybe it's better to just have a global variable that increments and not
> > pass it in?  That way it would work automatically.
> 
> Global variables often hide suble problems. We have a list of some used
> in qdev / qbus / pci that we plan to remove, because it makes command
> line not reproducible.

Yeah, I was guessing that, and I also just found that the
vmstate_register() was deprecated.  I'll work on switching to the new
API.

Thanks,

-corey

> 
> See this thread:
> https://lore.kernel.org/qemu-devel/87czq0l2mn.fsf@dusky.pond.sub.org/
> 
> > 
> > -corey
> > 
> > > 
> > > Preferably s/instance/id/:
> > > Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> > > 
> > > >    };
> > > >    static void bmc_class_init(ObjectClass *oc, void *data)
> > > > diff --git a/hw/ipmi/ipmi_bmc_extern.c b/hw/ipmi/ipmi_bmc_extern.c
> > > > index d015500254..11c28d03ab 100644
> > > > --- a/hw/ipmi/ipmi_bmc_extern.c
> > > > +++ b/hw/ipmi/ipmi_bmc_extern.c
> > > > @@ -488,7 +488,8 @@ static const VMStateDescription vmstate_ipmi_bmc_extern = {
> > > >    static void ipmi_bmc_extern_realize(DeviceState *dev, Error **errp)
> > > >    {
> > > > -    IPMIBmcExtern *ibe = IPMI_BMC_EXTERN(dev);
> > > > +    IPMIBmc *b = IPMI_BMC(dev);
> > > > +    IPMIBmcExtern *ibe = IPMI_BMC_EXTERN(b);
> > > >        if (!qemu_chr_fe_backend_connected(&ibe->chr)) {
> > > >            error_setg(errp, "IPMI external bmc requires chardev attribute");
> > > > @@ -498,7 +499,7 @@ static void ipmi_bmc_extern_realize(DeviceState *dev, Error **errp)
> > > >        qemu_chr_fe_set_handlers(&ibe->chr, can_receive, receive,
> > > >                                 chr_event, NULL, ibe, NULL, true);
> > > > -    vmstate_register(NULL, 0, &vmstate_ipmi_bmc_extern, ibe);
> > > > +    vmstate_register(NULL, b->instance, &vmstate_ipmi_bmc_extern, ibe);
> > > >    }
> > > >    static void ipmi_bmc_extern_init(Object *obj)
> > > > diff --git a/hw/ipmi/ipmi_bmc_sim.c b/hw/ipmi/ipmi_bmc_sim.c
> > > > index 6157ac7120..c1b39dbdc5 100644
> > > > --- a/hw/ipmi/ipmi_bmc_sim.c
> > > > +++ b/hw/ipmi/ipmi_bmc_sim.c
> > > > @@ -2188,7 +2188,7 @@ static void ipmi_sim_realize(DeviceState *dev, Error **errp)
> > > >        ibs->timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, ipmi_timeout, ibs);
> > > > -    vmstate_register(NULL, 0, &vmstate_ipmi_sim, ibs);
> > > > +    vmstate_register(NULL, b->instance, &vmstate_ipmi_sim, ibs);
> > > >    }
> > > >    static const Property ipmi_sim_properties[] = {
> > > > diff --git a/include/hw/ipmi/ipmi.h b/include/hw/ipmi/ipmi.h
> > > > index 77a7213ed9..4436d70842 100644
> > > > --- a/include/hw/ipmi/ipmi.h
> > > > +++ b/include/hw/ipmi/ipmi.h
> > > > @@ -183,6 +183,7 @@ struct IPMIBmc {
> > > >        DeviceState parent;
> > > >        uint8_t slave_addr;
> > > > +    uint8_t instance;
> > > >        IPMIInterface *intf;
> > > >    };
> > > > diff --git a/qemu-options.hx b/qemu-options.hx
> > > > index dc694a99a3..186433ac13 100644
> > > > --- a/qemu-options.hx
> > > > +++ b/qemu-options.hx
> > > > @@ -1120,6 +1120,10 @@ SRST
> > > >        ``slave_addr=val``
> > > >            Define slave address to use for the BMC. The default is 0x20.
> > > > +    ``instance=val``
> > > > +        For more than one BMC on the same system, each instance needs
> > > > +	a unique number.  The default is 0.
> > > > +
> > > >        ``sdrfile=file``
> > > >            file containing raw Sensor Data Records (SDR) data. The default
> > > >            is none.
> > > > @@ -1137,7 +1141,7 @@ SRST
> > > >            is set, get "Get GUID" command to the BMC will return it.
> > > >            Otherwise "Get GUID" will return an error.
> > > > -``-device ipmi-bmc-extern,id=id,chardev=id[,slave_addr=val]``
> > > > +``-device ipmi-bmc-extern,id=id,chardev=id[,slave_addr=val][,instance=id]``
> > > >        Add a connection to an external IPMI BMC simulator. Instead of
> > > >        locally emulating the BMC like the above item, instead connect to an
> > > >        external entity that provides the IPMI services.
> > > > @@ -1151,6 +1155,9 @@ SRST
> > > >        simulator running on a secure port on localhost, so neither the
> > > >        simulator nor QEMU is exposed to any outside network.
> > > > +    You can have more than one external BMC connection with this, but
> > > > +    you must set a unique instance for each BMC.
> > > > +
> > > >        See the "lanserv/README.vm" file in the OpenIPMI library for more
> > > >        details on the external interface.
> > > 
> 

