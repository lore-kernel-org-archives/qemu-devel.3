Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78DB9CD6E7D
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2026 14:47:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVVpo-0006dm-Gt; Fri, 05 Jun 2026 10:47:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wVVpe-0006cq-FK
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 10:47:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wVVpc-0000gF-Cl
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 10:47:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780670851;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gYmZIh1k8QTcJY9abYc4MCsFW/Ze+meV28qzEGhmLsU=;
 b=AadEY5FSfapVrDEWXXeocEQjbLG9Ll94nJQRHvAdwbahOwCkSE2IEgHMpO3G/WrMYxmdF3
 7zXKbIT6ADP51vV9FkY6FPilHOmSvsTqpyTmQlJIzK998926i1lzyolvNaWk1O/x0nmvMi
 JdV5cOqaryVQowkY1iykUW62oLtqHew=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-449-xEAyMEWmPE-LsVt6o1UIYA-1; Fri,
 05 Jun 2026 10:47:28 -0400
X-MC-Unique: xEAyMEWmPE-LsVt6o1UIYA-1
X-Mimecast-MFC-AGG-ID: xEAyMEWmPE-LsVt6o1UIYA_1780670846
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E61B51956095; Fri,  5 Jun 2026 14:47:25 +0000 (UTC)
Received: from redhat.com (unknown [10.44.50.34])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6F8C21955D87; Fri,  5 Jun 2026 14:47:17 +0000 (UTC)
Date: Fri, 5 Jun 2026 15:47:13 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Juraj Marcin <jmarcin@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Sana Sharma <sansshar@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>
Subject: Re: [PATCH 2/4] qdev: Introduce helper object_apply_globals()
Message-ID: <aiLhcXUxVQ1K_6xA@redhat.com>
References: <20260604231118.1584889-1-peterx@redhat.com>
 <20260604231118.1584889-3-peterx@redhat.com>
 <aiKOalYvribeaiqw@redhat.com> <87cxy56o80.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87cxy56o80.fsf@suse.de>
User-Agent: Mutt/2.3.2 (2026-04-26)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Jun 05, 2026 at 11:44:47AM -0300, Fabiano Rosas wrote:
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
> > On Thu, Jun 04, 2026 at 07:11:16PM -0400, Peter Xu wrote:
> >> The helper allows one object to apply anything from -global command lines
> >> to an object.
> >> 
> >> Signed-off-by: Peter Xu <peterx@redhat.com>
> >> ---
> >>  include/hw/core/qdev-properties.h | 1 +
> >>  hw/core/qdev-properties.c         | 5 +++++
> >>  2 files changed, 6 insertions(+)
> >> 
> >> diff --git a/include/hw/core/qdev-properties.h b/include/hw/core/qdev-properties.h
> >> index eba5436e53..779acb31b6 100644
> >> --- a/include/hw/core/qdev-properties.h
> >> +++ b/include/hw/core/qdev-properties.h
> >> @@ -268,6 +268,7 @@ const GlobalProperty *qdev_find_global_prop(Object *obj,
> >>                                              const char *name);
> >>  int qdev_prop_check_globals(void);
> >>  void qdev_prop_set_globals(DeviceState *dev);
> >> +void object_apply_globals(Object *obj);
> >>  void error_set_from_qdev_prop_error(Error **errp, int ret, Object *obj,
> >>                                      const char *name, const char *value);
> >>  
> >> diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
> >> index 8f870c85fc..a91c2ad101 100644
> >> --- a/hw/core/qdev-properties.c
> >> +++ b/hw/core/qdev-properties.c
> >> @@ -1045,6 +1045,11 @@ void qdev_prop_set_globals(DeviceState *dev)
> >>                                dev->hotplugged ? NULL : &error_fatal);
> >>  }
> >>  
> >> +void object_apply_globals(Object *obj)
> >> +{
> >> +    object_apply_global_props(obj, global_props(), &error_fatal);
> >> +}
> >
> > If a method has the "object_" prefix and takex "Object *" as its
> > instance, then it needs to live in qom/object.c / include/qom/object.h
> > but this again has the complexity of relying on the qdev Property
> > struct.  This is really mixing qdev & qom layers together which I
> > find pretty unpleasant.
> >
> 
> True, but code like qdev_property_add_static() already mixes things up
> quite a bit. Not that this is justification to mix it even more, of
> course.

That's not the same scenario as it is exclusively qdev code, using
qdev_ name prefix and taking "Device *" not "Object *".

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


