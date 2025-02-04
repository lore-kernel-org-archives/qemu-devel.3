Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98C56C02196
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 13:41:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfJ9u-0002wO-E6; Tue, 04 Feb 2025 08:40:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tfJ9s-0002w5-39
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 08:40:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tfJ9p-0001e4-BZ
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 08:40:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738676403;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Fpwi/uAGiZl2TO6E2msFPHs/wAJOGyBG92fvc8C3tmE=;
 b=d029y5Slf1Ji3D0XAgw68p9Wlcw5Yq6Dvmkw8HB12cQGI15qxwDRdDTReF3+rIVgy8URtz
 zDXaqV2uCxyrsfc2GMbo/uuARYlZtjypLvbasV7Lao6wGGxJ83EhasKegx2+2m2Y1EaWta
 JbP4aXkYmGF8HxCBpCKxA+urwAGs4k8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-477-xjqInKzXPXa-4SQgoMfxaw-1; Tue, 04 Feb 2025 08:39:58 -0500
X-MC-Unique: xjqInKzXPXa-4SQgoMfxaw-1
X-Mimecast-MFC-AGG-ID: xjqInKzXPXa-4SQgoMfxaw
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-38a2140a400so3814872f8f.0
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2025 05:39:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738676396; x=1739281196;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Fpwi/uAGiZl2TO6E2msFPHs/wAJOGyBG92fvc8C3tmE=;
 b=BXftwBI/69TzF7TiPXPxXRF88f2R3itK0a+MgSBw9oM2zemWuQ7A2yNqdWpNZp600F
 H9WyfSrH6Cqkns/sE92ezqsVhKvfZ1P341z4zLA3CW7LfO1S+pJbLw+WR4ari/iUIgH2
 5nW8e2NDWJPgrQ2AdS81bnP3FklXb81LIdsSzyRyC4vhjSYgSpvQDqnPqsjq8cBdgFFP
 w0ARLQ6Jdz31P5L597ravXw79dmd9M/utB+gdocuBa2T9V6hm4WuTgQQPKT6fFICpozj
 1YRLqoCl2gXHa9Z+fhLHHFR1v2uVRwGKsTvcpVdS9N2uBa0Z1oqtS5mpQSNOhPCHRTm0
 0mCw==
X-Forwarded-Encrypted: i=1;
 AJvYcCViCc4HhQacSSDxD5fp2v+RETFn8HL9JFf2SPaftNS4XpsYYNEyddK+g3HK4IFAJfnKNXmU10Of2P+c@nongnu.org
X-Gm-Message-State: AOJu0YwL8PFTWwaKHPwm+cXKBaRcY7oiDukwPewttdntYR2H72hKtsfb
 YpDmbmCV/8hUkZ0ePphqreiUofpJQhTEGKL7XCAeov2atQbbWYb3zamqMeXJOvDFRSRcnSHxl5T
 UPIvNEmtr/z5lcuHYeP6c87Z7kUI3NQOY97kZLPXdJ2Dj3uP00FD1jmU19gkT
X-Gm-Gg: ASbGncsEeK9ET0V1dihvjDNRvkXm+d5sdLoetPDpWaGZbEeWBQONxfIhLE7WqUB/wV4
 lUX8tWcsnfckln0W+yeeTAvTQbHpKV6Gn2K3Fv8gXyIsfeE7ZDQIj/3UVESd3tYwoAURy86ElUE
 5Ju0CiObl5MEKhHXk65PmE92mXTjq7hA+NN0Gq0z817GrpTqHvHM9jzNtQND1z5sV+J6MyLKJKq
 BYYCK00itbdYogL3jnuKkHCY6G+Ylt67dm1y/Tqfb/3wjuSDlfSsOAvcigiTq29pAoOkX2bBApn
 0gAAGxc8C5wDMZSGwReQ7tzKysd4rRo82wzWXBBm5ncEUdAu2qrF
X-Received: by 2002:a05:6000:1882:b0:38d:ac77:d7cb with SMTP id
 ffacd0b85a97d-38dac77e622mr1511607f8f.25.1738676396098; 
 Tue, 04 Feb 2025 05:39:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEWS06XkS4wfY87PLKsU5U+H33xduHzvci02Yyz8BZjsSU1w5EfjswfpK2x2K0vZhyJYXoDeg==
X-Received: by 2002:a05:6000:1882:b0:38d:ac77:d7cb with SMTP id
 ffacd0b85a97d-38dac77e622mr1511579f8f.25.1738676395601; 
 Tue, 04 Feb 2025 05:39:55 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438dcc1315esm221741005e9.6.2025.02.04.05.39.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Feb 2025 05:39:55 -0800 (PST)
Date: Tue, 4 Feb 2025 14:39:53 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Yanan Wang
 <wangyanan55@huawei.com>, Eduardo Habkost <eduardo@habkost.net>, Harsh
 Prateek Bora <harshpb@linux.ibm.com>, kvm@vger.kernel.org, Zhao Liu
 <zhao1.liu@intel.com>, "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?="
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>, Marcel
 Apfelbaum <marcel.apfelbaum@gmail.com>, Peter Xu <peterx@redhat.com>, Paolo
 Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC PATCH 4/9] hw/qdev: Introduce DeviceClass::[un]wire()
 handlers
Message-ID: <20250204143953.27430bc3@imammedo.users.ipa.redhat.com>
In-Reply-To: <b7646baf-a07d-4ded-804c-6809173c1f6b@linaro.org>
References: <20250128142152.9889-1-philmd@linaro.org>
 <20250128142152.9889-5-philmd@linaro.org>
 <b7646baf-a07d-4ded-804c-6809173c1f6b@linaro.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, 28 Jan 2025 12:52:39 -0800
Richard Henderson <richard.henderson@linaro.org> wrote:

> On 1/28/25 06:21, Philippe Mathieu-Daud=C3=A9 wrote:
> > We are trying to understand what means "a qdev is realized".
> > One explanation was "the device is guest visible"; however
> > many devices are realized before being mapped, thus are not
> > "guest visible". Some devices map / wire their IRQs before
> > being realized (such ISA devices). There is a need for devices
> > to be "automatically" mapped/wired (see [2]) such CLI-created
> > devices, but this apply generically to dynamic machines.
> >=20
> > Currently the device creation steps are expected to roughly be:
> >=20
> >    (external use)                (QDev core)                   (Device =
Impl)
> >     ~~~~~~~~~~~~                  ~~~~~~~~~                     ~~~~~~~=
~~~~
> >=20
> >                                 INIT enter =20
> >                     -----> =20
> >                           +----------------------+
> >                           |    Allocate state    |
> >                           +----------------------+ =20
> >                                                   -----> =20
> >                                                          +-------------=
--------+
> >                                                          | INIT childre=
n       |
> >                                                          |             =
        |
> >                                                          | Alias childr=
en properties
> >                                                          |             =
        |
> >                                                          | Expose prope=
rties   |
> >                                  INIT exit               +-------------=
--------+
> >                     <-----------------------------------
> >   +----------------+
> >   | set properties |
> >   |                |
> >   | set ClkIn      |
> >   +----------------+          REALIZE enter =20
> >                     ----------------------------------> =20
> >                                                         +--------------=
--------+
> >                                                         | Use config pr=
operties|
> >                                                         |              =
        |
> >                                                         | Realize child=
ren     |
> >                                                         |              =
        |
> >                                                         | Init GPIOs/IR=
Qs      |
> >                                                         |              =
        |
> >                                                         | Init MemoryRe=
gions   |
> >                                                         +--------------=
--------+
> >                                 REALIZE exit
> >                     <-----------------------------------               =
         ----  "realized" / "guest visible"
> > +-----------------+
> > | Explicit wiring:|
> > |   IRQs          |
> > |   I/O / Mem     |
> > |   ClkOut        |
> > +-----------------+             RESET enter =20
> >                      ---------------------------------> =20
> >                                                         +--------------=
--------+
> >                                                         | Reset default=
 values |
> >                                                         +--------------=
--------+
> >=20
> > But as mentioned, various devices "wire" parts before they exit
> > the "realize" step.
> > In order to clarify, I'm trying to enforce what can be done
> > *before* and *after* realization.
> >=20
> > *after* a device is expected to be stable (no more configurable)
> > and fully usable.
> >=20
> > To be able to use internal/auto wiring (such ISA devices) and
> > keep the current external/explicit wiring, I propose to add an
> > extra "internal wiring" step, happening after the REALIZE step

we partially have such wiring in place
  hotplug_handler_plug
'hotplug_' prefix is legacy remnant to confuse every, it really
should be renamed to just plug_handler or 'wire_foo'.

For bus-less CPUs it's used both on hot- and cold-plug paths.

It does take care of wiring after realize part is completed
(basically exposing device to the external users).

And I it also handles 'bus' based plug workflow
see qdev_get_hotplug_handler() assuming bus owner has provided a callback.
It's likely no-one had cared about ISA, as it was out of
hotplug scope when the interface was introduced.

Unplug part is however is not wired directly into unrealize() stage,
but rather to an external caller (mgmt or guest), which
essentially unwinds into the same hotplug_handler chain as plug,
to unwire device and then the same external caller does call unrealize
on device. (see:hotplug_handler_unplug() )

As for more direct hack, there is also DEVICE_LISTENER_CALL() callback,
which is more close to this approach (modulo users are hidden as
there is not explicit wiring).
Unrealize part is called too late (which probably is not right),
and realize part is called before subtree is realized (might work for
current users, but likely should be placed at the same site as wire() call.

Hence we should think if already existing methods could be reused/adapted t=
o,
before adding similar wire/unwire mechanism.


> > as:
> >=20
> >    (external use)                (QDev core)                   (Device =
Impl)
> >     ~~~~~~~~~~~~                  ~~~~~~~~~                     ~~~~~~~=
~~~~
> >=20
> >                                 INIT enter =20
> >                     -----> =20
> >                           +----------------------+
> >                           |    Allocate state    |
> >                           +----------------------+ =20
> >                                                   -----> =20
> >                                                          +-------------=
--------+
> >                                                          | INIT childre=
n       |
> >                                                          |             =
        |
> >                                                          | Alias childr=
en properties
> >                                                          |             =
        |
> >                                                          | Expose prope=
rties   |
> >                                  INIT exit               +-------------=
--------+
> >                     <-----------------------------------
> >   +----------------+
> >   | set properties |
> >   |                |
> >   | set ClkIn      |
> >   +----------------+          REALIZE enter =20
> >                     ----------------------------------> =20
> >                                                         +--------------=
--------+
> >                                                         | Use config pr=
operties|
> >                                                         |              =
        |
> >                                                         | Realize child=
ren     |
> >                                                         |              =
        |
> >                                                         | Init GPIOs/IR=
Qs      |
> >                                                         |              =
        |
> >                                                         | Init MemoryRe=
gions   |
> >                                                         +--------------=
--------+
> >                                 REALIZE exit       <---
> >                           +----------------------+
> >                           | Internal auto wiring |
> >                           |   IRQs               |  (i.e. ISA bus)
> >                           |   I/O / Mem          |
> >                           |   ClkOut             |
> >                           +----------------------+
> >                      <---                                              =
         ----  "realized"
> > +-----------------+
> > | External wiring:|
> > |   IRQs          |
> > |   I/O / Mem     |
> > |   ClkOut        |
> > +-----------------+             RESET enter                            =
        ----  "guest visible" =20
> >                      ---------------------------------> =20
> >                                                         +--------------=
--------+
> >                                                         | Reset default=
 values |
> >                                                         +--------------=
--------+
> >=20
> > The "realized" point is not changed. "guest visible" concept only
> > occurs *after* wiring, just before the reset phase.
> >=20
> > This change introduces the DeviceClass::wire handler within qdev
> > core realization code.
> >=20
> > Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> > ---
> >   include/hw/qdev-core.h |  7 +++++++
> >   hw/core/qdev.c         | 20 +++++++++++++++++++-
> >   2 files changed, 26 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
> > index 530f3da7021..021bb7afdc0 100644
> > --- a/include/hw/qdev-core.h
> > +++ b/include/hw/qdev-core.h
> > @@ -102,7 +102,12 @@ typedef int (*DeviceSyncConfig)(DeviceState *dev, =
Error **errp);
> >    * @props: Properties accessing state fields.
> >    * @realize: Callback function invoked when the #DeviceState:realized
> >    * property is changed to %true.
> > + * @wire: Callback function called after @realize to connect IRQs,
> > + * clocks and map memories. Can not fail.
> > + * @unwire: Callback function to undo @wire. Called before @unrealize.
> > + * Can not fail.
> >    * @unrealize: Callback function invoked when the #DeviceState:realiz=
ed
> > + * property is changed to %false. Can not fail.
> >    * property is changed to %false.
> >    * @sync_config: Callback function invoked when QMP command device-sy=
nc-config
> >    * is called. Should synchronize device configuration from host to gu=
est part
> > @@ -171,6 +176,8 @@ struct DeviceClass {
> >        */
> >       DeviceReset legacy_reset;
> >       DeviceRealize realize;
> > +    void (*wire)(DeviceState *dev);
> > +    void (*unwire)(DeviceState *dev);
> >       DeviceUnrealize unrealize;
> >       DeviceSyncConfig sync_config;
> >  =20
> > diff --git a/hw/core/qdev.c b/hw/core/qdev.c
> > index 82bbdcb654e..38449255365 100644
> > --- a/hw/core/qdev.c
> > +++ b/hw/core/qdev.c
> > @@ -554,6 +554,15 @@ static void device_set_realized(Object *obj, bool =
value, Error **errp)
> >               }
> >          }
> >  =20
> > +        if (dc->wire) {
> > +            if (!dc->unwire) {
> > +                warn_report_once("wire() without unwire() for type '%s=
'",
> > +                                 object_get_typename(OBJECT(dev)));
> > +            }
> > +            dc->wire(dev);
> > +        }
> > +
> > +        /* At this point the device is "guest visible". */
> >          qatomic_store_release(&dev->realized, value);
> >  =20
> >       } else if (!value && dev->realized) {
> > @@ -573,6 +582,15 @@ static void device_set_realized(Object *obj, bool =
value, Error **errp)
> >            */
> >           smp_wmb();
> >  =20
> > +        if (dc->unwire) {
> > +            if (!dc->wire) {
> > +                error_report("disconnect() without connect() for type =
'%s'",
> > +                             object_get_typename(OBJECT(dev)));
> > +                abort();
> > +            }
> > +            dc->unwire(dev);
> > +        } =20
>=20
> Mismatched error messages (wire vs connect).
> But, really, just check both directions properly at startup.
> There's probably lots of places where devices are never unrealized.
>=20
> Otherwise, this seems sane, having a kind of post_init on the realize pat=
h, running after=20
> all superclass realization is done.
>=20
>=20
> r~
>=20


