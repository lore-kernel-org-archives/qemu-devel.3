Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DF8DCD8CB2
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 16:31:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXLp0-0005VZ-0d; Wed, 10 Jun 2026 12:30:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wXLoy-0005TO-1C
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 12:30:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wXLou-000519-0U
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 12:30:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781109016;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=ffQMrrIeEw+Z4qPbjB7+M8+ng5hnGuoNl7GHirLXJ9M=;
 b=bCEzBiw0pwgeHr666FzFhrymkViwzRx/+9VZQl3DmbJn3BFRjeh2WffDO9ynH5s2WcVv7L
 ZyqPwqQgSuOXVgzxEtUWGwMf9ApGo4NPXqTjn90DYyzRfdYIOpKiQGZZCijDVzgibHtDhS
 QHCQa73M595EIBt2psfe9PhIF9fBOhA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-363-mQCUOurRPcW7HJ7ae6pw5Q-1; Wed,
 10 Jun 2026 12:30:12 -0400
X-MC-Unique: mQCUOurRPcW7HJ7ae6pw5Q-1
X-Mimecast-MFC-AGG-ID: mQCUOurRPcW7HJ7ae6pw5Q_1781109010
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AE989193F041; Wed, 10 Jun 2026 16:30:09 +0000 (UTC)
Received: from redhat.com (unknown [10.44.50.112])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C2CD93008DC3; Wed, 10 Jun 2026 16:30:02 +0000 (UTC)
Date: Wed, 10 Jun 2026 17:29:59 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Fabiano Rosas <farosas@suse.de>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Sana Sharma <sansshar@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Juraj Marcin <jmarcin@redhat.com>, qemu-rust@nongnu.org,
 Markus Armbruster <armbru@redhat.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>
Subject: Re: [PATCH v2 10/10] migration: Switch to TYPE_OBJECT with object
 properties
Message-ID: <aimRB5Uv2XtTE4Xy@redhat.com>
References: <20260609172514.2037645-1-peterx@redhat.com>
 <20260609172514.2037645-11-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260609172514.2037645-11-peterx@redhat.com>
User-Agent: Mutt/2.3.2 (2026-04-26)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, Jun 09, 2026 at 01:25:14PM -0400, Peter Xu wrote:
> The migration object used to depend on TYPE_DEVICE due to:
> 
> - Usage of qdev properties
> - Apply compat properties and global properties
> 
> This patch re-based the object to TYPE_OBJECT with the changes:
> 
> - Switch to object properties API
> - Manually apply both compat and global properties in post_init()
> 
> Note that to avoid too many property getter/setter helpers, this patch used
> the object_property_add_*_ptr_def() APIs so that an pointer is passed to
> bind to the property.  Such API is used for most of the conversions.
> 
> After patch, the migration object initializes instance properties within
> its instance_init() callback, in migrate_params_init().
> 
> One side effect of this change is, since we switched to a loop to add all
> capabilities, the name of the properties representing a migration
> capability may chance from previously hard-coded ones (many with x-).  It's
> fine since it's only used in -global so it's only for debugging.
> 
> Similarly, I removed "x-" from other properites that used to start with
> "x-" but actually are not experimental.
> 
> After the whole conversion, we don't need migration_properties or the count
> anymore, hence can be removed.  While at it, we can also remove two
> DEFINE_PROP*() API that only migration uses (DEFINE_PROP_STR_OR_NULL, and
> DEFINE_PROP_MIG_CAP).
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  migration/options.h   |   8 +-
>  migration/migration.c |  35 ++-
>  migration/options.c   | 526 ++++++++++++++++++++++++++----------------
>  3 files changed, 351 insertions(+), 218 deletions(-)

> +static void migration_instance_post_init(Object *obj)
> +{
>      /*
> -     * NOTE: TYPE_MIGRATION is not really a device, as the object is
> -     * not created using qdev_new(), it is not attached to the qdev
> -     * device tree, and it is never realized.
> +     * Apply these properties on top of default values:
> +     *
> +     * (1) machine compat properties
> +     * (2) -global settings in cmdlines
>       *
> -     * TODO: Make this TYPE_OBJECT once QOM provides something like
> -     * TYPE_DEVICE's "-global" properties.
> +     * Need to be applied in order so (2) takes precedence over (1).
>       */
> -    .parent = TYPE_DEVICE,
> -    .class_init = migration_class_init,
> +    object_apply_compat_props(obj);
> +    object_apply_global_props(obj, global_props(), &error_fatal);

-global is/was intended for devices, primarily those which
are created by default as part of the machine. For dynamically
created devices the docs recommend use of -device instead
of -global.

I get that -global was exposed for migration via the inappropriate
use of TYPE_DEVICE as a parent for TYPE_MIGRATION, but I don't
think we should be prolonging that misuse by exposing use of
-global for things which are QOM rather than QDev.

If we want todo that for the sake of backcompat, IMHO it should
be deprecated so it only lives for a short while after the
conversion to QOM.

This makes me realize that this does not implement the UserCreatable
interface on TYPE_MIGRATION, so I'm presuming the MigrationState is
still created internally. Perhaps we should switch to making it a
full UserCreatable, such that -object can be used to set all migration
parameters on the command line and -global won't be required ? 

> +}
> +
> +static const TypeInfo migration_type = {
> +    .name = TYPE_MIGRATION,
> +    .parent = TYPE_OBJECT,
>      .instance_size = sizeof(MigrationState),
>      .instance_init = migration_instance_init,
> +    .instance_post_init = migration_instance_post_init,
>      .instance_finalize = migration_instance_finalize,
>  };

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


