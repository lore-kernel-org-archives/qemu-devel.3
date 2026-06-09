Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEA1CCD8CAD
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 22:55:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wX5Lj-0007X2-6a; Tue, 09 Jun 2026 18:55:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wX5Le-0007Vj-Ox
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 18:55:07 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wX5La-0006Xb-SW
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 18:55:06 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 910FA6AC61;
 Tue,  9 Jun 2026 22:54:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1781045699; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tmOmtU20WMisHai1MMUA/+8tbBa5Hfp+d5ToolWIypw=;
 b=GGex46HWkeDjiCQSNMhY6ecefhTRUV/iltU/4X/ReeM7sQWGa3tCRWxGqWJGyx8WyIv5lx
 OVqrHexuiiM3DChcs6xs1xis7Ez6xoX7o/B8IJhO6+YrUnSTJCaweRNPY/ofkg1DZEPijJ
 HDBl5mhVO78WM2xqTH8L6wjwTv/zwe0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1781045699;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tmOmtU20WMisHai1MMUA/+8tbBa5Hfp+d5ToolWIypw=;
 b=gS2rqV5BA9l0IwlAI8GAZgf0qvYjGDXBIL5yFmltVLtgH2/BDhGE+kjtb2CN9Yo42LeKbO
 hUgOE9PL0PpLvZBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1781045699; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tmOmtU20WMisHai1MMUA/+8tbBa5Hfp+d5ToolWIypw=;
 b=GGex46HWkeDjiCQSNMhY6ecefhTRUV/iltU/4X/ReeM7sQWGa3tCRWxGqWJGyx8WyIv5lx
 OVqrHexuiiM3DChcs6xs1xis7Ez6xoX7o/B8IJhO6+YrUnSTJCaweRNPY/ofkg1DZEPijJ
 HDBl5mhVO78WM2xqTH8L6wjwTv/zwe0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1781045699;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tmOmtU20WMisHai1MMUA/+8tbBa5Hfp+d5ToolWIypw=;
 b=gS2rqV5BA9l0IwlAI8GAZgf0qvYjGDXBIL5yFmltVLtgH2/BDhGE+kjtb2CN9Yo42LeKbO
 hUgOE9PL0PpLvZBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2637D779A7;
 Tue,  9 Jun 2026 22:54:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id X2nXOcKZKGppOAAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 09 Jun 2026 22:54:58 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>, =?utf-8?Q?Daniel_P_=2E?=
 =?utf-8?Q?_Berrang=C3=A9?=
 <berrange@redhat.com>, Vladimir Sementsov-Ogievskiy
 <vsementsov@yandex-team.ru>, Peter Maydell <peter.maydell@linaro.org>, "Dr
 . David Alan Gilbert" <dave@treblig.org>, Eric Blake <eblake@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, Peter Xu
 <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf
 <kwolf@redhat.com>, Sana Sharma <sansshar@redhat.com>, =?utf-8?Q?Marc-And?=
 =?utf-8?Q?r=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>, Juraj Marcin <jmarcin@redhat.com>,
 qemu-rust@nongnu.org, Markus Armbruster <armbru@redhat.com>, Mark
 Cave-Ayland <mark.caveayland@nutanix.com>
Subject: Re: [PATCH v2 00/10] migration/qom: Remove TYPE_DEVICE dependency
 on migration object
In-Reply-To: <20260609172514.2037645-1-peterx@redhat.com>
References: <20260609172514.2037645-1-peterx@redhat.com>
Date: Tue, 09 Jun 2026 19:54:56 -0300
Message-ID: <87jys75npb.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCPT_COUNT_TWELVE(0.00)[20];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[gitlab.com:url, suse.de:email, suse.de:mid,
 imap1.dmz-prg2.suse.org:helo]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Peter Xu <peterx@redhat.com> writes:

> CI: https://gitlab.com/peterx/qemu/-/pipelines/2588717620
>     (two irrelevant failures due to no runner)
>
> rfc: https://lore.kernel.org/r/20251209162857.857593-1-peterx@redhat.com
> v1:  https://lore.kernel.org/r/20260604231118.1584889-1-peterx@redhat.com
>
> This v2 is a full rewrite of v1, changelog doesn't apply.
>
> This version majorly addressed the concern in v1 having object API exported
> in qdev files. Instead of trying to expose qdev properties, this patchset
> switched migration object to use the object property API to add properties.
>
> Not all QOM facilities are ready for it, there're a few prior patches to
> improve QOM API to achieve it.
>
> The major concept that this series introduces that does not exist
> previously is the default value mechanisms for object properties (rather
> than object class properties).  Here migration object will rely on that to
> set default values.
>
> Patch 1:   A cleanup to use OBJECT_DECLARE_SIMPLE_TYPE for migration
> Patch 2-4: Qdev changes needed for the transition
> Patch 5-9: Improve QOM API to prepare for the property switch
> Patch 10:  Switch migration object to use TYPE_OBJECT and object props
>
> Comments welcomed, thanks.
>
> Peter Xu (10):
>   migration: Use OBJECT_DECLARE_SIMPLE_TYPE
>   qdev: Export global_props()
>   qdev: Introduce DEFINE_PROP_*_NODEFAULT for bool/uint32
>   hw/arm: Use nodefault version of qdev props when not needed
>   qom: Create object-property-ptr.[ch]
>   qom: Add object_property_add_bool_ptr()
>   qom: Add object_property_add_size_ptr()
>   qom: Add object_property_add_*_ptr_def()
>   qom: Allow default values for instance properties
>   migration: Switch to TYPE_OBJECT with object properties
>
>  include/hw/core/qdev-properties.h |   7 +
>  include/qom/object-property-ptr.h | 162 +++++++++
>  include/qom/object.h              |  99 +-----
>  migration/migration.h             |   9 +-
>  migration/options.h               |   8 +-
>  hw/arm/bcm2836.c                  |   3 +-
>  hw/core/qdev-properties.c         |   2 +-
>  migration/migration.c             |  42 ++-
>  migration/options.c               | 526 +++++++++++++++++++-----------
>  qom/object-property-ptr.c         | 394 ++++++++++++++++++++++
>  qom/object.c                      | 266 ++-------------
>  target/arm/cpu64.c                |   3 +-
>  qom/meson.build                   |   1 +
>  rust/bindings/hwcore-sys/lib.rs   |   2 +-
>  14 files changed, 957 insertions(+), 567 deletions(-)
>  create mode 100644 include/qom/object-property-ptr.h
>  create mode 100644 qom/object-property-ptr.c

Hi,

After we discussed your v1 I started playing with this in parallel and
stumbled into pretty much all of the issues this series resolves. Nice
work!

I applied a patch [0] on top of this series to allow using the
command-line to create the migration object. It can set all (most)
options with -object migration,id=mig1,key=val,...

 $ ~/qemu-system-x86_64 -nodefaults -nographic -S \
 -object migration,id=mig1,announce-initial=99,downtime-limit=99,multifd-channels=99,multifd-compression=zlib,multifd=on
 ...
 (qemu) info migrate_parameters
 (qemu) info migrate_capabilities
 ...
 announce-initial: 99 ms
 downtime-limit: 99 ms
 multifd-channels: 99
 multifd-compression: zlib
 multifd: on

I'm not saying we should do that now. I just want to check with you to
make sure we're not closing the door for future improvements:

1) It seems the "help" option is tied to the class. Setting options
work, but the help says otherwise:

 $ ~/qemu-system-x86_64 -nographic -object migration,id=mig1,help                                                                            
 There are no options for migration.

2) user_creatable_add_qapi

 The command line parsing goes through user_creatable_add_qapi() and
 instantiates an object. Since migrate_params_init runs from inside
 .instance_init, it cannot see any parameters that are set this way.

 Moreover, the migration_object_init() call from vl.c will init a
 second migration object.

 In the patch below I have hacked the current_migration assignment to
 first check if the object has already been created and use that
 instead of creating a new one.

 How does this work for normal objects? I suppose most of them have the
 TYPE_DEVICE as a parent, so they're not hanging in the "objects"
 container.

3) TLS (of course)

 With the patch below, setting TLS options from the cmdline asserts:
 visit_start_alternate: Assertion `!(v->type & VISITOR_INPUT)' failed.
 (just mentioning in case it can affect the design of this series)

[0]
-->8--
From 8c6c0743f1659d9df45e80334e8dc5f068ff984e Mon Sep 17 00:00:00 2001
From: Fabiano Rosas <farosas@suse.de>
Date: Tue, 9 Jun 2026 16:00:21 -0300
Subject: [PATCH] wip

---
 migration/migration.c | 11 ++++++++++-
 migration/options.c   |  1 +
 qapi/qom.json         | 29 +++++++++++++++++++++++++++++
 3 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/migration/migration.c b/migration/migration.c
index ae0c373549..22c8ced766 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -297,7 +297,16 @@ void migration_object_init(void)
 {
     /* This can only be called once. */
     assert(!current_migration);
-    current_migration = MIGRATION(object_new(TYPE_MIGRATION));
+
+    Object *root = object_get_objects_root();
+    ObjectProperty *prop = g_hash_table_lookup(root->properties, "mig1");
+
+    if (prop->opaque) {
+        current_migration = prop->opaque;
+        object_ref(current_migration);
+    } else {
+        current_migration = MIGRATION(object_new(TYPE_MIGRATION));
+    }
 
     /*
      * Init the migrate incoming object as well no matter whether
diff --git a/migration/options.c b/migration/options.c
index 1cc99382d3..88f02c45a1 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -21,6 +21,7 @@
 #include "qapi/qapi-visit-migration.h"
 #include "qapi/qmp/qerror.h"
 #include "qobject/qnull.h"
+#include "qom/object_interfaces.h"
 #include "system/runstate.h"
 #include "migration/colo.h"
 #include "migration/cpr.h"
diff --git a/qapi/qom.json b/qapi/qom.json
index dd45ac1087..fe7dd4673c 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -8,6 +8,11 @@
 { 'include': 'block-core.json' }
 { 'include': 'common.json' }
 { 'include': 'crypto.json' }
+# FIXME: this requires --disable-tools due to:
+# /usr/bin/ld.bfd: libqemuutil.a.p/meson-generated_.._qapi_qapi-commands-migration.c.o:
+# in function `qmp_marshal_query_migr: qemu/build/qapi/qapi-commands-migration.c:48:(.text+0x181c):
+# undefined reference to `qmp_query_migrate'
+{ 'include': 'migration.json' }
 
 ##
 # ***********************
@@ -1187,6 +1192,28 @@
   'data': { '*cpu-affinity': ['uint16'],
             '*node-affinity': ['uint16'] } }
 
+
+##
+# @MigProperties:
+#
+# Properties for migration objects.
+#
+# @multifd: this is a capability and therefore is not part of
+#     MigrationParameters yet (WIP).  (default: 0)
+#
+# @store-global-state: this is a compat property and therefore is not
+#     part of MigrationParameters.  It's probably best to keep it like
+#     this so we don't have to deal with previously impossible
+#     scenarios if the user tries to set it via set-migrate  (default:
+#     0)
+#
+# Since: 11.1
+##
+{ 'struct': 'MigProperties',
+  'base': 'MigrationParameters',
+  'data': { '*multifd': 'bool',
+            '*store-global-state': 'bool' } }
+
 ##
 # @ObjectType:
 #
@@ -1237,6 +1264,7 @@
     'memory-backend-ram',
     { 'name': 'memory-backend-shm',
       'if': 'CONFIG_POSIX' },
+    'migration',
     'pef-guest',
     { 'name': 'pr-manager-helper',
       'if': 'CONFIG_LINUX' },
@@ -1315,6 +1343,7 @@
       'memory-backend-ram':         'MemoryBackendProperties',
       'memory-backend-shm':         { 'type': 'MemoryBackendShmProperties',
                                       'if': 'CONFIG_POSIX' },
+      'migration':                    'MigProperties',
       'pr-manager-helper':          { 'type': 'PrManagerHelperProperties',
                                       'if': 'CONFIG_LINUX' },
       'qtest':                      'QtestProperties',
-- 
2.53.0



