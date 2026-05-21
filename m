Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB7B0CD5BAC
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 10:24:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQ0Yy-0006QP-2w; Thu, 21 May 2026 06:23:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joshualant@gmail.com>)
 id 1wQ0Yv-0006Q9-Qa
 for qemu-devel@nongnu.org; Thu, 21 May 2026 06:23:33 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joshualant@gmail.com>)
 id 1wQ0Yt-0001CA-Ng
 for qemu-devel@nongnu.org; Thu, 21 May 2026 06:23:33 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-44e1ebb3122so3604646f8f.2
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 03:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779359010; x=1779963810; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=QMYdl/jcyRx/rzoqCLEOyD78Cx4h4XXTE2K9BVYo1K0=;
 b=ZtpdtdSwYE2xiVjV27eQQFnQ8KOVViUxtV99SysJDdLKGM+KxQwDWnN/Yy1LnnGNIz
 QqFXZzp9kG4OY7eu15dzfzeeSpSKwJPhaK2b+NkymsAOQCK1Gl3fdeOPR9/c0gNvLp4y
 jKPmBkvTOtlDfeczeG9lM+SvRoYkKbIovRlezghs3lcy+LwKRESWJoqz1mpj695jsRxk
 V+W5pPGYOqatl7WiIrf03qePuk4dNk+cc7uFDX723EPumN66ofVA2yp6g1Fmaud0ve+x
 q9X0thgdQkOli9ikijRBI7Dad7hy6jN6C3EYUb+xc1qGWZR0nK+DBpsHcY5KS9HynRl1
 StDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779359010; x=1779963810;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QMYdl/jcyRx/rzoqCLEOyD78Cx4h4XXTE2K9BVYo1K0=;
 b=d+uw6RG79Aj+GmzMSFO29sISX0O64crnXqrp/B0bqQBtRVl9a/N+XYNP6TvRw3SOwf
 xMl+9867UUe5zTG2wuDP1wCgKoceZRtsaoXOk/iJoBYkVUNAFkpAbUa7xQTzjP8k5i42
 7h+w5iQxqBeKhUfN/A9iW/FOLvJCAOKzWDJKOwSuShlF3oNHrQjQ2GYADCcsq87j3Sxv
 FVTkS9cddBDERQtKoT3EypI21FmyGFKdS6SQ2SgzNfaMxeFsVkrRkLESPiV8ncXzCWcN
 3z3aoE5FisJITlBSUjj/z3QLtpKU0OzWBy0exkFNvdGPwvFttyDDNErMZ4uyU9g+qEeD
 yJ9g==
X-Forwarded-Encrypted: i=1;
 AFNElJ/wZpwObVdMTAf6/TX76RgGIlPQpw4yelbAqGGiyBhbgaaU1UmhzRPiZ50CvOIpDmRNtmwtuAN+tIGc@nongnu.org
X-Gm-Message-State: AOJu0YwX8lMWgWH7WEOvrM13PIlp9Z9CQTcQLy3V/mnR3D/Inw61tWEi
 fJSpw3Ty5zn4kSP51v8Ta9vhjtXcp92yRYwZG8I7gJXSr/AE4OQISiRk
X-Gm-Gg: Acq92OG4NZamMK6zHojCo4baYk5Ix0el9Pe8Lryb6eVTFQwPXOPh41lS9Allt8qnoQL
 suXKBQQw8YjS1DPnaZlueAG2t2EqmhsNoKGpBRnYDkCjAQ/r+gKBTyeYAZPwltm9PLAc7CQAW8O
 Ff+KJPJSaF1jj/ZzpcbxR54+sID/zvbeQ4lmgK4OjgghLawF0RnR/lehSC5YxtSDOQUY5W/e6jf
 CYrQJ4EMa0akMreOq+cdKeHeAHNoBXF/j9p6rKSC8h4TmKYRs8eYV9gesM82EQ+v9DLVkVsCBEH
 DW908XhN02IxGKTkUJBC5qKpDaFETc3uwkb5VeEeWnLLmoruPmv4sweSQtJtHRvwkIXsBb1a1Rs
 qdGOJbfxP01BIr/f1ykD7ISeGeiBOggLaEYJHN36l4MlzJCc0YfGyH0zUFZDU593vVwDRDUOsrL
 FPjkp7EGRfnFger3rqAA3Utg4YpuoCmHK0y4IfVcJUpRjGgAF4K+zduKCI+oXtoOokPJk8BOFGZ
 WT0nJ9+aHYq
X-Received: by 2002:a05:6000:240b:b0:45e:8526:7dc8 with SMTP id
 ffacd0b85a97d-45ea3ff7b2emr3512157f8f.25.1779359010014; 
 Thu, 21 May 2026 03:23:30 -0700 (PDT)
Received: from thinkpc (shef-16-b2-v4wan-175958-cust4.vm3.cable.virginm.net.
 [80.193.46.5]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eaa7d0a36sm1700715f8f.2.2026.05.21.03.23.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 03:23:28 -0700 (PDT)
Date: Thu, 21 May 2026 11:23:27 +0100
From: Joshua Lant <joshualant@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-cxl@vger.kernel.org, qemu-devel@nongnu.org,
 Jonathan.Cameron@huawei.com, arpit1.kumar@samsung.com
Subject: Re: [RFC QEMU PATCH 02/10] qdev/qbus: Allow hidden devices to be
 busless on QEMU startup
Message-ID: <ag7dHwNXS/qGnEJD@thinkpc>
References: <20260429135717.3048713-1-joshualant@gmail.com>
 <20260429135717.3048713-3-joshualant@gmail.com>
 <20260520110205.428d0395@jic23-huawei> <ag7XkPS0ylFSeIGO@thinkpc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ag7XkPS0ylFSeIGO@thinkpc>
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=joshualant@gmail.com; helo=mail-wr1-x42f.google.com
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

> > On Wed, 29 Apr 2026 14:48:36 +0100
> > Joshua Lant <joshualant@gmail.com> wrote:
> > 
> > > Extend the capability for hiding devices, introduced for virtio-net
> > > device in:
> > > 
> > > commit f3a8505656935cde32e28c1c6317f725084da1e0
> > > Author: Jens Freimann <jfreimann@redhat.com>
> > > Date:   Tue Oct 29 12:48:55 2019 +0100
> > > qdev/qbus: add hidden device support
> > > 
> > > Currently only endpoint devices can be hidden with a primary device
> > > and failover (known static configuration). However, looking at future
> > > composable systems, we see a need for hidden devices which have no associated
> > > bus upon boot. Move the check for hidden devices to before the bus
> > > search, and if it is hidden ignore the case where the device was
> > > described on the CLI without the "bus=" field.
> > > 
> > > This is motivated by a specific use-case: implementing the VCS
> > > command set, part of the CXL specification (CXL r3.2 Section 7.1.3). In
> > > this scenario a switch controlled by a Fabric Manager is able to change the
> > > virtual hierarchy of devices seen by a guest within a fixed physical system
> > > topology. The connecting bus is not known until runtime when
> > > a bind command is issued by the Fabric Manager.
> > 
> > So this comes back to the earlier comment on whether they are completely
> > hidden from a guest.  They aren't quite - we need to be able to
> > get to them via the MCTP or cxl-switch-cci (in band mailbox) paths.
> > 
> > Maybe we can solve that later without any compatibility problems
> > or by cheating and just searching hidden devices. I'm not sure.
> 
> Funnily enough I had something like this when I was originally writing
> this series. I scrapped it becasue I ran into issues. I was storing
> as a tree the QDicts of hidden busses and devices below them, but then realised
> I couldnt hotplug into the USP and abandoned it. I was doing this with the
> aim of eventual support for cascaded switches.
> 
> There was another issue I cant fully remember... That the searching was easy
> when it was referring to unrealized devices with QDicts from the CLI, but it
> became much more difficult to get proper reference to some structures I needed
> from the devices inside the qdev/qbus code when they were realized...
> 

I just remembered... I was having to introduce cxl specific code into the qdev
code... I'm sure it could be separated but would require a fair bit more work.

> > > 
> > > Signed-off-by: Joshua Lant <joshualant@gmail.com>
> > > ---
> > >  system/qdev-monitor.c | 10 ++++++++--
> > >  1 file changed, 8 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/system/qdev-monitor.c b/system/qdev-monitor.c
> > > index f2aa400a77..b51dfe0645 100644
> > > --- a/system/qdev-monitor.c
> > > +++ b/system/qdev-monitor.c
> > > @@ -650,6 +650,7 @@ DeviceState *qdev_device_add_from_qdict(const QDict *opts,
> > >      DeviceState *dev;
> > >      BusState *bus = NULL;
> > >      QDict *properties;
> > > +    bool hide_device;
> > >  
> > >      driver = qdict_get_try_str(opts, "driver");
> > >      if (!driver) {
> > > @@ -663,6 +664,11 @@ DeviceState *qdev_device_add_from_qdict(const QDict *opts,
> > >          return NULL;
> > >      }
> > >  
> > > +    /* Is the device hidden from the guest?
> > > +     * If yes, no need to find a default bus if none given...
> > > +     * Bus could be provided at runtime (i.e. in a switch)*/
> > > +    hide_device = qdev_should_hide_device(opts, from_json, errp);
> > > +
> > >      /* find bus */
> > >      path = qdict_get_try_str(opts, "bus");
> > >      if (path != NULL) {
> > > @@ -675,14 +681,14 @@ DeviceState *qdev_device_add_from_qdict(const QDict *opts,
> > >                         driver, object_get_typename(OBJECT(bus)));
> > >              return NULL;
> > >          }
> > > -    } else if (dc->bus_type != NULL) {
> > > +    } else if (dc->bus_type != NULL && !hide_device) {
> > >          bus = qdev_find_default_bus(dc, errp);
> > >          if (!bus) {
> > >              return NULL;
> > >          }
> > >      }
> > >  
> > > -    if (qdev_should_hide_device(opts, from_json, errp)) {
> > > +    if (hide_device) {
> > >          if (bus && !qbus_is_hotpluggable(bus)) {
> > >              error_setg(errp, "Bus '%s' does not support hotplugging",
> > >                         bus->name);
> > 

