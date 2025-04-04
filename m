Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34554C36010
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 13:05:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0gj4-0001ye-Gj; Fri, 04 Apr 2025 09:04:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <corey@minyard.net>) id 1u0gj2-0001y2-OD
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 09:04:48 -0400
Received: from mail-ot1-x32a.google.com ([2607:f8b0:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <corey@minyard.net>) id 1u0gir-0003YC-Rq
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 09:04:48 -0400
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-72bd5f25ea6so552038a34.1
 for <qemu-devel@nongnu.org>; Fri, 04 Apr 2025 06:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=minyard-net.20230601.gappssmtp.com; s=20230601; t=1743771875; x=1744376675;
 darn=nongnu.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:reply-to:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=COWaDmWYVkXuWLud74Qy8icbSOvWeyROngucf7VTnFw=;
 b=idZB5qpPgyAHHhb3tm5Ht9njqJtZoVghj9VMMAdnUEycDXkYGPUwyFxMWcnY1Ckl+X
 G87MYWECKbsuB554Luna5TpO2OFLOvvFrv58mvVvthNAFggoCISDHTvPJndlj1xhuuAg
 V0Lb82fgHMydLCYm4W83xSyeRNmAU777mcjcKfWQMe/f9f08jYoJpXGjseNBzJPxgCtI
 KRsJ1PCSa/C4tu9iVz7XxctyGcaxAQ/ubOe17aaJT8JqqNv9aBECsXG/7Esug6nKn6g+
 i/rHnQS/uv3UrjCsY4VSLsylKpSTnent0Szmt0weiA8om67oS4P3H0Z2SsdhHHCR43QH
 VoLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743771875; x=1744376675;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:reply-to:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=COWaDmWYVkXuWLud74Qy8icbSOvWeyROngucf7VTnFw=;
 b=p7GOUMfw2ZicCwMmibn2Z42GrZWi6e1f8+zfed4O0Xcoo3YlrP3AIpXviuH5z7252Q
 ax45fbg+u8FuEM3YI1BzvIIGXtwDfD+IM3n9eNEzjZ1rTg4M5nQDNu/kRP9xfAJooMmr
 2syJH6m6jCFmyf9gFCuL9qgzaAhd90J8U0JdcZJdFPeNFHWWRljNpXQ/wjfsraHa0twX
 5XDhCrRiD8kIPERrDyOL4kS8mgjJeKgJ0kiVW+YLNQ+94uT53Nh5W6rv+JEJVP6I/d1Y
 SxAehbGjNNzv4SZm7QVMtWRgF0pwWZIJSGm1datx3kW1A/iDBI/3x638kSVjtH2yKtlA
 NA6w==
X-Gm-Message-State: AOJu0Yy8dLeiO3YlvUb/9bBh0+hGLiW1TTmUV75sm7wUe383JZVTs+HC
 5P3i84q6IAuMLTmx+VYq5oKu5DPa6F00Dq7nqE4KAUT4XCXRN52BO9ZEhvij74M=
X-Gm-Gg: ASbGncv8DK32sJ7k4IK7D5yvRWIfkOjmDvPl431Ij8e5sYG9VURhoXFNeQ/d+6fBpAB
 0hUub359+lyXohxonc2D+MBO4lbjacnQ7uT61FeA88WbT3+18w8njSA1mf2HrCah6sF71ajYMPy
 +w0yMbeYfRBwypRUCsIUCjBiJApMPAIRnUgCHpyZ40SMk7AxL6Cy0h3mWIcwohQ7qvWIf9eooqA
 sPtBKJJo/cRXZ6ML5y+eR71/j+XKrAswAgopAxrXNfZTppF5tDd+RDac+T54P0pnmXklEq1J0TI
 oG5kuJgB+YsqyY1208RaQqh3c+UyRABMtXQWFgD3TvfiVNZj
X-Google-Smtp-Source: AGHT+IGqy7n785DMH7elMfe5pQlwW2ggSnXMvXewL6XOA+WhCWZI+YiWOOoV/9p6YIxKxInUI29ubw==
X-Received: by 2002:a05:6830:670c:b0:72b:a61c:cbb2 with SMTP id
 46e09a7af769-72e366693e1mr2458331a34.10.1743771875386; 
 Fri, 04 Apr 2025 06:04:35 -0700 (PDT)
Received: from mail.minyard.net ([2001:470:b8f6:1b:5413:2ba6:c80b:5b46])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-72e3050177fsm648160a34.9.2025.04.04.06.04.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Apr 2025 06:04:34 -0700 (PDT)
Date: Fri, 4 Apr 2025 08:04:29 -0500
From: Corey Minyard <corey@minyard.net>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH] hw/ipmi: Allow multiple BMC instances
Message-ID: <Z-_Y3VJ49yYyZmE4@mail.minyard.net>
References: <Z-8ujYWA8yBATtYK@mail.minyard.net>
 <438cb87a-cfa2-4392-92f4-bbb05f7a2ec2@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <438cb87a-cfa2-4392-92f4-bbb05f7a2ec2@linaro.org>
Received-SPF: none client-ip=2607:f8b0:4864:20::32a;
 envelope-from=corey@minyard.net; helo=mail-ot1-x32a.google.com
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

On Fri, Apr 04, 2025 at 02:41:46PM +0200, Philippe Mathieu-Daudé wrote:
> Hi Corey,
> 
> On 4/4/25 02:57, Corey Minyard wrote:
> > Allow a system to have multiple BMC connections to the same BMC and
> > multiple different BMCs.  This can happen on real systems, and is
> > useful for testing the IPMI driver on Linux.
> > 
> > Signed-off-by: Corey Minyard <corey@minyard.net>
> > ---
> > I'm working on a fairly extensive test suite for IPMI, the Linux
> > driver and qemu, and this is necessary for some driver tests.
> > 
> >   hw/ipmi/ipmi.c            | 1 +
> >   hw/ipmi/ipmi_bmc_extern.c | 5 +++--
> >   hw/ipmi/ipmi_bmc_sim.c    | 2 +-
> >   include/hw/ipmi/ipmi.h    | 1 +
> >   qemu-options.hx           | 9 ++++++++-
> >   5 files changed, 14 insertions(+), 4 deletions(-)
> > 
> > diff --git a/hw/ipmi/ipmi.c b/hw/ipmi/ipmi.c
> > index fdeaa5269f..ffd972f78b 100644
> > --- a/hw/ipmi/ipmi.c
> > +++ b/hw/ipmi/ipmi.c
> > @@ -110,6 +110,7 @@ void ipmi_bmc_find_and_link(Object *obj, Object **bmc)
> >   static const Property ipmi_bmc_properties[] = {
> >       DEFINE_PROP_UINT8("slave_addr",  IPMIBmc, slave_addr, 0x20),
> > +    DEFINE_PROP_UINT8("instance",    IPMIBmc, instance, 0),
> 
> Can we use "id" instead of "instance"? The latter confuses me, but
> maybe a matter of taste.

"id" means "identifier", not "instance".  The error log mentions
"instance", that that is what is passed to vmstate_register().

Maybe it's better to just have a global variable that increments and not
pass it in?  That way it would work automatically.

-corey

> 
> Preferably s/instance/id/:
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
> >   };
> >   static void bmc_class_init(ObjectClass *oc, void *data)
> > diff --git a/hw/ipmi/ipmi_bmc_extern.c b/hw/ipmi/ipmi_bmc_extern.c
> > index d015500254..11c28d03ab 100644
> > --- a/hw/ipmi/ipmi_bmc_extern.c
> > +++ b/hw/ipmi/ipmi_bmc_extern.c
> > @@ -488,7 +488,8 @@ static const VMStateDescription vmstate_ipmi_bmc_extern = {
> >   static void ipmi_bmc_extern_realize(DeviceState *dev, Error **errp)
> >   {
> > -    IPMIBmcExtern *ibe = IPMI_BMC_EXTERN(dev);
> > +    IPMIBmc *b = IPMI_BMC(dev);
> > +    IPMIBmcExtern *ibe = IPMI_BMC_EXTERN(b);
> >       if (!qemu_chr_fe_backend_connected(&ibe->chr)) {
> >           error_setg(errp, "IPMI external bmc requires chardev attribute");
> > @@ -498,7 +499,7 @@ static void ipmi_bmc_extern_realize(DeviceState *dev, Error **errp)
> >       qemu_chr_fe_set_handlers(&ibe->chr, can_receive, receive,
> >                                chr_event, NULL, ibe, NULL, true);
> > -    vmstate_register(NULL, 0, &vmstate_ipmi_bmc_extern, ibe);
> > +    vmstate_register(NULL, b->instance, &vmstate_ipmi_bmc_extern, ibe);
> >   }
> >   static void ipmi_bmc_extern_init(Object *obj)
> > diff --git a/hw/ipmi/ipmi_bmc_sim.c b/hw/ipmi/ipmi_bmc_sim.c
> > index 6157ac7120..c1b39dbdc5 100644
> > --- a/hw/ipmi/ipmi_bmc_sim.c
> > +++ b/hw/ipmi/ipmi_bmc_sim.c
> > @@ -2188,7 +2188,7 @@ static void ipmi_sim_realize(DeviceState *dev, Error **errp)
> >       ibs->timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, ipmi_timeout, ibs);
> > -    vmstate_register(NULL, 0, &vmstate_ipmi_sim, ibs);
> > +    vmstate_register(NULL, b->instance, &vmstate_ipmi_sim, ibs);
> >   }
> >   static const Property ipmi_sim_properties[] = {
> > diff --git a/include/hw/ipmi/ipmi.h b/include/hw/ipmi/ipmi.h
> > index 77a7213ed9..4436d70842 100644
> > --- a/include/hw/ipmi/ipmi.h
> > +++ b/include/hw/ipmi/ipmi.h
> > @@ -183,6 +183,7 @@ struct IPMIBmc {
> >       DeviceState parent;
> >       uint8_t slave_addr;
> > +    uint8_t instance;
> >       IPMIInterface *intf;
> >   };
> > diff --git a/qemu-options.hx b/qemu-options.hx
> > index dc694a99a3..186433ac13 100644
> > --- a/qemu-options.hx
> > +++ b/qemu-options.hx
> > @@ -1120,6 +1120,10 @@ SRST
> >       ``slave_addr=val``
> >           Define slave address to use for the BMC. The default is 0x20.
> > +    ``instance=val``
> > +        For more than one BMC on the same system, each instance needs
> > +	a unique number.  The default is 0.
> > +
> >       ``sdrfile=file``
> >           file containing raw Sensor Data Records (SDR) data. The default
> >           is none.
> > @@ -1137,7 +1141,7 @@ SRST
> >           is set, get "Get GUID" command to the BMC will return it.
> >           Otherwise "Get GUID" will return an error.
> > -``-device ipmi-bmc-extern,id=id,chardev=id[,slave_addr=val]``
> > +``-device ipmi-bmc-extern,id=id,chardev=id[,slave_addr=val][,instance=id]``
> >       Add a connection to an external IPMI BMC simulator. Instead of
> >       locally emulating the BMC like the above item, instead connect to an
> >       external entity that provides the IPMI services.
> > @@ -1151,6 +1155,9 @@ SRST
> >       simulator running on a secure port on localhost, so neither the
> >       simulator nor QEMU is exposed to any outside network.
> > +    You can have more than one external BMC connection with this, but
> > +    you must set a unique instance for each BMC.
> > +
> >       See the "lanserv/README.vm" file in the OpenIPMI library for more
> >       details on the external interface.
> 

