Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB457CD6E6B
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2026 08:44:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVQ9h-00061h-Qd; Fri, 05 Jun 2026 04:43:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wVQ9f-00060O-Rd
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 04:43:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wVQ9c-0002Tx-Du
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 04:43:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780649026;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=yK/7cTRlZCiLg9fn/+banki9TZrak7SMsoJgTnPxu6g=;
 b=QPTbWpFAm5ebYcvaCLcH5tHHCukotJcNQNw0PKs3zg6C+NzfuQxfC/4J1qdyEwdYUuBIyZ
 Uy6FGXbFk8m1Cc3IdtkiRk76XElgyVSyZy5cbfiTtUaXJ1UIU45gGLj42o1YcgkmERiaKW
 N8p8HY20SooVgiBw0FL7Cw5xN4fEN1g=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-668-ykU05EDaO3qWlEHtZXvwFA-1; Fri,
 05 Jun 2026 04:43:40 -0400
X-MC-Unique: ykU05EDaO3qWlEHtZXvwFA-1
X-Mimecast-MFC-AGG-ID: ykU05EDaO3qWlEHtZXvwFA_1780649019
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F0CDD19560A3; Fri,  5 Jun 2026 08:43:37 +0000 (UTC)
Received: from redhat.com (unknown [10.44.50.34])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 162AE3000210; Fri,  5 Jun 2026 08:43:31 +0000 (UTC)
Date: Fri, 5 Jun 2026 09:43:28 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Xu <peterx@redhat.com>
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
Message-ID: <aiKMMMNrL97b3YzN@redhat.com>
References: <20260604231118.1584889-1-peterx@redhat.com>
 <20260604231118.1584889-4-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260604231118.1584889-4-peterx@redhat.com>
User-Agent: Mutt/2.3.2 (2026-04-26)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Jun 04, 2026 at 07:11:17PM -0400, Peter Xu wrote:
> Firstly, qdev_class_add_property() function almost has nothing to do with
> DeviceClass, it's a bridge between Property and object properties.
> 
> Change the 1st parameter of it, so that it can be used without DeviceClass
> context at all. When at it, remove the "name" field because it's always
> prop->name.
> 
> Export it for non-qdev use cases.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  include/hw/core/qdev-properties.h | 10 ++++++++++
>  hw/core/qdev-properties.c         |  7 +++----
>  2 files changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/include/hw/core/qdev-properties.h b/include/hw/core/qdev-properties.h
> index 779acb31b6..fec2aaac4d 100644
> --- a/include/hw/core/qdev-properties.h
> +++ b/include/hw/core/qdev-properties.h
> @@ -283,6 +283,16 @@ void error_set_from_qdev_prop_error(Error **errp, int ret, Object *obj,
>   */
>  void qdev_property_add_static(DeviceState *dev, const Property *prop);
>  
> +/**
> + * object_class_add_property:
> + * @oc: Object class to operate on.
> + * @prop: The qdev property definition.
> + *
> + * Add a Property to @oc.  This is the bridge to convert a Property into
> + * an object class property (as in ObjectClass.properties).
> + */
> +void object_class_add_property(ObjectClass *oc, const Property *prop);

I'm really not a fan of this.

Having both object_class_add_property and object_class_property_add
methods is horrendous naming.

Methods named with an "object_class_" prefix must live in qom/object.c &
include/qom/object.h not in qdev. If doing that though, then the entire
"Property" concept would need to live in QOM code too, but I don't think
that is either desirable or neccessary.

AFAICT, the MigrationState class init method could just call the
existing object_class_property_add methods as any other non-qdev
Object impl does.


With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


