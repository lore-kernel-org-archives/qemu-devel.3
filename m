Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3970CD4F5E
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 10:00:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQ0C0-0001v9-B2; Thu, 21 May 2026 05:59:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joshualant@gmail.com>)
 id 1wQ0Bz-0001v1-AV
 for qemu-devel@nongnu.org; Thu, 21 May 2026 05:59:51 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joshualant@gmail.com>)
 id 1wQ0Bw-0007ZK-Al
 for qemu-devel@nongnu.org; Thu, 21 May 2026 05:59:49 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-488a9033b2cso47982675e9.2
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 02:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779357587; x=1779962387; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=dzTLRpollRQBLkOpPiNx8RHjAt/9M8rw+2H6kzCL280=;
 b=UMC12huPE1tMJjHdC/W9HdE6uB1bl4hlYbwIHYlBLzNimgq1RqL5doe5CVq4j3bIk3
 WdYMx78Q7Jm5MSgrYMBqZzl6mCOuBbgxRexBKIpMYmpLI38b/NmqVSLTroZCTecw8HCf
 va6w8j0qQM9zQ7sSOddI3+sIJyvBmTyEvbVG2rK+vNauRT5RfUwCWPF5KlKGpJlTpEK0
 I75r/osaQGuvniN3r108yu24FesnnJ5m9DIUWEqZrP7F4mnWAZ5dXPuNvy9uw8TBqCFD
 W3V6SfSJz5peUcr7adocrQu6zEjzye26bmdTcYoMoUD+8mLrNZMKcXjCSOFFoRC6Aq4s
 nmVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779357587; x=1779962387;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dzTLRpollRQBLkOpPiNx8RHjAt/9M8rw+2H6kzCL280=;
 b=JDnQ8xw8A4JcK3HCSABKhzJo89741I0l/h+JgsoKMGAxqYXG5VFIOCzX8pkLCR3UBW
 LmpBmr41aEGgmwa/+HkmUyV6T/VrzUI2A2B/repf6I6qLkL811Kc3YURDOoZ5EHog0eM
 KAi9ZJX3/Q+RpXhmpjBCkQGW20P1ErLCHzBHjFEt2vkHRAdXE8xKX9a6Nkcv+Pn8WOI5
 BJNhIsqkQmqQHE6Kkmn/wk/HfVyB0hQkiJjUPfdSEv/ADb4rf/0uocnSfutx4ZJD74kg
 Q9lh94nPnWgQPD+vmp5quEQocNPo58rER/HQGl+MYdq6KQ8W6FVGQ6Akhh+mKmJUHV9c
 mnBQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/G7QMaz3BTW5PCMDz7TcKTsmTv7ht2ExtCM5jmQ0YSTbVSnUcHYXE5B4tOOqpPZStpKbE3laytxe0b@nongnu.org
X-Gm-Message-State: AOJu0YzSB0UCaIxut7cMIGbtzn5sCBXZ8F5IFdQTimeQOyZVRBcwcFIr
 vO0KKMkqzaqHDqnVTDuFSNHD0hO9lj3QrnRgBICtkK+tIenND6iZy6tF5BugPrtS
X-Gm-Gg: Acq92OFMgruVaP3JeAZbZqtHRgoW2+zpN/Ndda/TzMdt/Ls1m+24aiwItBR579hqA+Y
 170KFUmK4RBxn/2J8MHB8pXDqtEY4aR5Qn01mxxCtFuWkPGB3AV4VZx9d2zHLtOPeOX6s5taobG
 XAokBw4wYhncVIvFLmYm6hCEslJLqdSJ1bz/AE83Pc64GDULycgsotV6mvIbpFQgixKNGgsnk0a
 O1ZwHbnIXNaYy8D7T/T9A6Qzbe6ir8yExWpNB1TW1wmsb/i0WF0vhzS44G507HlSHyvai7/yZKw
 KCrdwIaLl9ouDYnF5rX8z8F5hz82jdTfwQ0oWlFp2txkI+xBzWB6Uig8sQ1yM9x/T4qkZ0uPIu/
 Arq5bTTb8z+nFz7Fl2UuCAf2VWGhMK3i53zOCuBPpu+S3Gi89wiJANwlhNRg9sFAvYRl70OW20g
 SdFaulSa76fWKlppFSOulBn7ra1JHes9aP90I3kSBEddxBijDLkLaswOvtlSJW0VlTMkGJxkMo9
 g==
X-Received: by 2002:a05:600d:8:b0:490:778:4fe3 with SMTP id
 5b1f17b1804b1-490360ee151mr26933195e9.32.1779357586536; 
 Thu, 21 May 2026 02:59:46 -0700 (PDT)
Received: from thinkpc (shef-16-b2-v4wan-175958-cust4.vm3.cable.virginm.net.
 [80.193.46.5]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49035c72c78sm17817195e9.3.2026.05.21.02.59.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 02:59:45 -0700 (PDT)
Date: Thu, 21 May 2026 10:59:44 +0100
From: Joshua Lant <joshualant@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-cxl@vger.kernel.org, qemu-devel@nongnu.org,
 Jonathan.Cameron@huawei.com, arpit1.kumar@samsung.com
Subject: Re: [RFC QEMU PATCH 02/10] qdev/qbus: Allow hidden devices to be
 busless on QEMU startup
Message-ID: <ag7XkPS0ylFSeIGO@thinkpc>
References: <20260429135717.3048713-1-joshualant@gmail.com>
 <20260429135717.3048713-3-joshualant@gmail.com>
 <20260520110205.428d0395@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260520110205.428d0395@jic23-huawei>
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=joshualant@gmail.com; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

> On Wed, 29 Apr 2026 14:48:36 +0100
> Joshua Lant <joshualant@gmail.com> wrote:
> 
> > Extend the capability for hiding devices, introduced for virtio-net
> > device in:
> > 
> > commit f3a8505656935cde32e28c1c6317f725084da1e0
> > Author: Jens Freimann <jfreimann@redhat.com>
> > Date:   Tue Oct 29 12:48:55 2019 +0100
> > qdev/qbus: add hidden device support
> > 
> > Currently only endpoint devices can be hidden with a primary device
> > and failover (known static configuration). However, looking at future
> > composable systems, we see a need for hidden devices which have no associated
> > bus upon boot. Move the check for hidden devices to before the bus
> > search, and if it is hidden ignore the case where the device was
> > described on the CLI without the "bus=" field.
> > 
> > This is motivated by a specific use-case: implementing the VCS
> > command set, part of the CXL specification (CXL r3.2 Section 7.1.3). In
> > this scenario a switch controlled by a Fabric Manager is able to change the
> > virtual hierarchy of devices seen by a guest within a fixed physical system
> > topology. The connecting bus is not known until runtime when
> > a bind command is issued by the Fabric Manager.
> 
> So this comes back to the earlier comment on whether they are completely
> hidden from a guest.  They aren't quite - we need to be able to
> get to them via the MCTP or cxl-switch-cci (in band mailbox) paths.
> 
> Maybe we can solve that later without any compatibility problems
> or by cheating and just searching hidden devices. I'm not sure.

Funnily enough I had something like this when I was originally writing
this series. I scrapped it becasue I ran into issues. I was storing
as a tree the QDicts of hidden busses and devices below them, but then realised
I couldnt hotplug into the USP and abandoned it. I was doing this with the
aim of eventual support for cascaded switches.

There was another issue I cant fully remember... That the searching was easy
when it was referring to unrealized devices with QDicts from the CLI, but it
became much more difficult to get proper reference to some structures I needed
from the devices inside the qdev/qbus code when they were realized...

> > 
> > Signed-off-by: Joshua Lant <joshualant@gmail.com>
> > ---
> >  system/qdev-monitor.c | 10 ++++++++--
> >  1 file changed, 8 insertions(+), 2 deletions(-)
> > 
> > diff --git a/system/qdev-monitor.c b/system/qdev-monitor.c
> > index f2aa400a77..b51dfe0645 100644
> > --- a/system/qdev-monitor.c
> > +++ b/system/qdev-monitor.c
> > @@ -650,6 +650,7 @@ DeviceState *qdev_device_add_from_qdict(const QDict *opts,
> >      DeviceState *dev;
> >      BusState *bus = NULL;
> >      QDict *properties;
> > +    bool hide_device;
> >  
> >      driver = qdict_get_try_str(opts, "driver");
> >      if (!driver) {
> > @@ -663,6 +664,11 @@ DeviceState *qdev_device_add_from_qdict(const QDict *opts,
> >          return NULL;
> >      }
> >  
> > +    /* Is the device hidden from the guest?
> > +     * If yes, no need to find a default bus if none given...
> > +     * Bus could be provided at runtime (i.e. in a switch)*/
> > +    hide_device = qdev_should_hide_device(opts, from_json, errp);
> > +
> >      /* find bus */
> >      path = qdict_get_try_str(opts, "bus");
> >      if (path != NULL) {
> > @@ -675,14 +681,14 @@ DeviceState *qdev_device_add_from_qdict(const QDict *opts,
> >                         driver, object_get_typename(OBJECT(bus)));
> >              return NULL;
> >          }
> > -    } else if (dc->bus_type != NULL) {
> > +    } else if (dc->bus_type != NULL && !hide_device) {
> >          bus = qdev_find_default_bus(dc, errp);
> >          if (!bus) {
> >              return NULL;
> >          }
> >      }
> >  
> > -    if (qdev_should_hide_device(opts, from_json, errp)) {
> > +    if (hide_device) {
> >          if (bus && !qbus_is_hotpluggable(bus)) {
> >              error_setg(errp, "Bus '%s' does not support hotplugging",
> >                         bus->name);
> 

