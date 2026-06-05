Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 780A7CD6E6B
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2026 08:50:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVQFl-00024h-MV; Fri, 05 Jun 2026 04:50:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wVQFc-0001wm-15
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 04:50:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wVQFZ-0004qI-Uh
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 04:49:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780649395;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Pl50uRfl08+6r4dBaujDjyH6nq9O8oD7ScsvMMkJFdg=;
 b=TZ8lIRLpUt1wpJbJXerdjL0DrV/2DzQqkIllS9XW8E2VcowRc6yMkGAm98Y7qMm2oFq1Yt
 HqyU0Tfo64VoKEyOgedBv6L0PyYKOYlV0lOPgAVQiiiGzVQAl+x5T2W0L5QLvChcuiLR3G
 7rOhR2NJdfVMztHNhDRHs8B5mBWkfZs=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-631-l_0jwDi9PzCLC35YfH-aOA-1; Fri,
 05 Jun 2026 04:49:52 -0400
X-MC-Unique: l_0jwDi9PzCLC35YfH-aOA-1
X-Mimecast-MFC-AGG-ID: l_0jwDi9PzCLC35YfH-aOA_1780649391
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 69F931956089; Fri,  5 Jun 2026 08:49:50 +0000 (UTC)
Received: from redhat.com (unknown [10.44.50.34])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5E151180049F; Fri,  5 Jun 2026 08:49:31 +0000 (UTC)
Date: Fri, 5 Jun 2026 09:49:20 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org,
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
Subject: Re: [PATCH 4/4] migration: Remove dependency to TYPE_DEVICE
Message-ID: <aiKNkDvO0cx92zz-@redhat.com>
References: <20260604231118.1584889-1-peterx@redhat.com>
 <20260604231118.1584889-5-peterx@redhat.com>
 <CAJ+F1CLLOd0YUkaQifbzn5vDDh28UAv2=8Z3vpb9BNRYd-JYaQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ+F1CLLOd0YUkaQifbzn5vDDh28UAv2=8Z3vpb9BNRYd-JYaQ@mail.gmail.com>
User-Agent: Mutt/2.3.2 (2026-04-26)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
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

On Fri, Jun 05, 2026 at 12:30:01PM +0400, Marc-André Lureau wrote:
> Hi
> 
> On Fri, Jun 5, 2026 at 3:12 AM Peter Xu <peterx@redhat.com> wrote:
> >
> > While doing that, we still want to keep the Property list that migration
> > object used to use.  Apply them directly to ObjectClass instead of setting
> > them with a DeviceClass.
> >
> > Manually apply the two extra properties (compat properties, global
> > settings) in an instance_post_init() hook, just like most of the rest
> > users, see callers of object_apply_compat_props().
> >
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  migration/migration.h |  2 +-
> >  migration/migration.c | 33 +++++++++++++++++++--------------
> >  2 files changed, 20 insertions(+), 15 deletions(-)
> >
> > diff --git a/migration/migration.h b/migration/migration.h
> > index 841f49b215..8bdb8e8e6b 100644
> > --- a/migration/migration.h
> > +++ b/migration/migration.h
> > @@ -274,7 +274,7 @@ struct MigrationClass {
> >
> >  struct MigrationState {
> >      /*< private >*/
> > -    DeviceState parent_obj;
> > +    Object parent_obj;
> >
> 
> You need to change MigrationClass.parent_class too

Do we even need a MigrationClass struct ? It has nothing except
the parent_class field, so feels redundant. Could the code just
use  OBJECT_DECLARE_SIMPLE_TYPE instead.

> 
> >      /*< public >*/
> >      QemuThread thread;
> > diff --git a/migration/migration.c b/migration/migration.c
> > index 074d3f2c69..f9f102e78a 100644
> > --- a/migration/migration.c
> > +++ b/migration/migration.c
> > @@ -3966,11 +3966,9 @@ fail:
> >
> >  static void migration_class_init(ObjectClass *klass, const void *data)
> >  {
> > -    DeviceClass *dc = DEVICE_CLASS(klass);
> > -
> > -    dc->user_creatable = false;
> > -    device_class_set_props_n(dc, migration_properties,
> > -                             migration_properties_count);
> > +    for (int i = 0; i < migration_properties_count; i++) {
> > +        object_class_add_property(klass, &migration_properties[i]);
> > +    }

This could get rid of migration_properties array indirection and call
object_class_property_add directly, avoiding the need for the previous
patch.

> > +static const TypeInfo migration_type = {
> > +    .name = TYPE_MIGRATION,
> > +    .parent = TYPE_OBJECT,
> >      .class_init = migration_class_init,
> > -    .class_size = sizeof(MigrationClass),
> > +    .class_size = sizeof(ObjectClass),
> 
> and this should still be MigrationClass

Not if we use OBJECT_DECLARE_SIMPLE_TYPE

> 
> >      .instance_size = sizeof(MigrationState),
> >      .instance_init = migration_instance_init,
> > +    .instance_post_init = migration_instance_post_init,
> >      .instance_finalize = migration_instance_finalize,
> >  };
> >
> > --
> > 2.53.0
> >
> >
> 
> Otherwise, the series is good to me!
> 

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


