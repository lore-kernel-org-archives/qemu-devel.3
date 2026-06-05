Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 519EFCD6E7D
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2026 15:22:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVWN8-0006AL-4l; Fri, 05 Jun 2026 11:22:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wVWN6-00069r-Hp
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 11:22:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wVWMy-0006fr-LM
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 11:22:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780672900;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4BusPpGTOpupd6cAkoKrqKwmO1c3evx1pEzcSOVk6M8=;
 b=fhoIQxR6zmbAZZqbKYKgQMoXXlgYdJN11qOO8BbkCpgv9NzuoY8qjH0HjZnVKrtaHjteB2
 J+bUQ9zRUTSGxGUhHxCKXyLEkoF4p5i9H6r5LJ/6ftltFkBkJRqYJ8rAWzcjGBvv3mXpR0
 4CxhOlWkZfmylzcSPPkmYRG+X0JpOlQ=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-43-ruMVR1uiORWnhqg5Rrcfbw-1; Fri, 05 Jun 2026 11:21:39 -0400
X-MC-Unique: ruMVR1uiORWnhqg5Rrcfbw-1
X-Mimecast-MFC-AGG-ID: ruMVR1uiORWnhqg5Rrcfbw_1780672898
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-bf381078ac8so136496766b.3
 for <qemu-devel@nongnu.org>; Fri, 05 Jun 2026 08:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1780672898; x=1781277698; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=4BusPpGTOpupd6cAkoKrqKwmO1c3evx1pEzcSOVk6M8=;
 b=S53ZPvgJYoBB/KCLkmMFJma/Qa9dUIz9pe+iYRxMUNQA0Q0KJIsW1YjVqZpnUPfo5q
 BrQXuI14gxvzrgWR0EMkCNenAXN6m3uJpX9yslzBz5m/vkbMUh6YdD2O1TfArJHzJ2R7
 YKARzKdTWs4MgLKDNG9FTb9gr4/vbnFXgWtNnDfyYmTVI7skBzUTb+lPiBQUaXDH/bNd
 3sOpx3WePKAZ/e19+N5gpvpyFVkOrGzB8hLCA9Gxt+Z9nMrPk92hP02BYH3sk47Ezni3
 p4rjqMtJxeNp1p+mFb7uRx8WwlJycYV+JGMIvfQ1zhuWA7CIjuI5ZKc5tg7B1nN1QRZX
 mH0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780672898; x=1781277698;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4BusPpGTOpupd6cAkoKrqKwmO1c3evx1pEzcSOVk6M8=;
 b=Y4YnAs1f9DGKij6PdQl81gescgQkQoBosua0A5Kd27rYkdJC2MRXfHKQ6fBWwWd4yQ
 E6MwOMBV5yu9pQLR3/BiD9pBFaeW8J/KqRQp7UbDplikOA9XdQUneSWlMVblGWLzJo/n
 mcobyqdqcb3cnDQf8xi6NMAqds9nA1k7NpaJk2Se1h2VvR5HTG7hbj/XpmcGT7bW56iI
 3GL3O70SKuanrnqoA6RX6UQJ1QG4lodR1SYkOOSGFnLqeS0WDtXJcCEl4S01FpdqFjju
 0zd4sRQhi2Duqj2iZsj4mgGT9g4lYGPEMEr3DdnR95euH9ZuO9Y2X0bDgCXdXTKaY+Uh
 afrA==
X-Gm-Message-State: AOJu0Yy0uEiIj4CuS4vtf8RIxF3A5U37ya2w3PMwy84oxZ63q7VtJjOb
 2Ptdzt7V7CEGMrFj58KLKZQzT3oP/LM2HBbr7TH65a3pAXGctrWelwFkVf20Ul97xajcwnGzAfq
 I3gPbKigZ5OQ1di7WWY0qnU9R+e4JS3rBlY1EFwgFpmP6T1RWS1rtT0QI7+gb1Btx
X-Gm-Gg: Acq92OGM0+Whr9NQ27TI9Frtw8QgOhldM3ZpcWXzCuw+vI2g1AOHUIszm+uHBPow3d2
 OnO+MQGZapSNzekoWSlwpV7OszMS850Q01Fbz/nm5ZoJWJovYuVQxcp7kisMjP43TiLzaioaiaT
 GlP6liconajTW7PAwoU5LQ8wbOplBBOtklJOAJMGf3avL8JzOfz7NiS+IPtToE9lu6ezuJKXy7C
 vstV2PycChfQNKwgGodhq5OHuclt8sTij8KxKzeHrqVibRMaNj+vyIqYtUcBpRPpQg4D93rH15j
 lPAOuDXiWOYViiNb7J0ezIogd7rcZfwXSrQb0mOJFuDJB12vc32YAUfTI1wNY4u89BCMrtKj2On
 HyjJBemcBPC+0baZVUQ5878Pk4w==
X-Received: by 2002:a17:906:dc8b:b0:bec:64c3:9ac0 with SMTP id
 a640c23a62f3a-bf371e4e3aamr217080466b.14.1780672897540; 
 Fri, 05 Jun 2026 08:21:37 -0700 (PDT)
X-Received: by 2002:a17:906:dc8b:b0:bec:64c3:9ac0 with SMTP id
 a640c23a62f3a-bf371e4e3aamr217067566b.14.1780672895959; 
 Fri, 05 Jun 2026 08:21:35 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bf054e05199sm459633866b.29.2026.06.05.08.21.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2026 08:21:34 -0700 (PDT)
Date: Fri, 5 Jun 2026 11:21:31 -0400
From: Peter Xu <peterx@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Juraj Marcin <jmarcin@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Sana Sharma <sansshar@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>
Subject: Re: [PATCH 3/4] qdev: Refactor and rename of qdev_class_add_property()
Message-ID: <aiLpe0L6GTEZMwqP@x1.local>
References: <20260604231118.1584889-1-peterx@redhat.com>
 <20260604231118.1584889-4-peterx@redhat.com>
 <aiKMMMNrL97b3YzN@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aiKMMMNrL97b3YzN@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Jun 05, 2026 at 09:43:28AM +0100, Daniel P. Berrangé wrote:
> On Thu, Jun 04, 2026 at 07:11:17PM -0400, Peter Xu wrote:
> > Firstly, qdev_class_add_property() function almost has nothing to do with
> > DeviceClass, it's a bridge between Property and object properties.
> > 
> > Change the 1st parameter of it, so that it can be used without DeviceClass
> > context at all. When at it, remove the "name" field because it's always
> > prop->name.
> > 
> > Export it for non-qdev use cases.
> > 
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  include/hw/core/qdev-properties.h | 10 ++++++++++
> >  hw/core/qdev-properties.c         |  7 +++----
> >  2 files changed, 13 insertions(+), 4 deletions(-)
> > 
> > diff --git a/include/hw/core/qdev-properties.h b/include/hw/core/qdev-properties.h
> > index 779acb31b6..fec2aaac4d 100644
> > --- a/include/hw/core/qdev-properties.h
> > +++ b/include/hw/core/qdev-properties.h
> > @@ -283,6 +283,16 @@ void error_set_from_qdev_prop_error(Error **errp, int ret, Object *obj,
> >   */
> >  void qdev_property_add_static(DeviceState *dev, const Property *prop);
> >  
> > +/**
> > + * object_class_add_property:
> > + * @oc: Object class to operate on.
> > + * @prop: The qdev property definition.
> > + *
> > + * Add a Property to @oc.  This is the bridge to convert a Property into
> > + * an object class property (as in ObjectClass.properties).
> > + */
> > +void object_class_add_property(ObjectClass *oc, const Property *prop);
> 
> I'm really not a fan of this.
> 
> Having both object_class_add_property and object_class_property_add
> methods is horrendous naming.
> 
> Methods named with an "object_class_" prefix must live in qom/object.c &
> include/qom/object.h not in qdev. If doing that though, then the entire
> "Property" concept would need to live in QOM code too, but I don't think
> that is either desirable or neccessary.
> 
> AFAICT, the MigrationState class init method could just call the
> existing object_class_property_add methods as any other non-qdev
> Object impl does.

I think I somehow missed the fact that qom does actually support
setters/getters for some default types too.. with default val API:

object_property_add_uint64_ptr()
object_property_set_default_uint()
...

I'll give it a shot.

-- 
Peter Xu


