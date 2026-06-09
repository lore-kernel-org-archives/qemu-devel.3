Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F1BBCD8CB2
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 22:56:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wX5ME-000839-5R; Tue, 09 Jun 2026 18:55:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wX5MB-0007wn-O6
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 18:55:40 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wX5M9-00077Z-2t
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 18:55:39 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0DF8C75941;
 Tue,  9 Jun 2026 22:55:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1781045735; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AK0lAI/L7KWeLpXZikL7802IriIE8OcDhU1wXKiEUL4=;
 b=pYP6OQY9bXMtW7PJhfH1BqaxrkiuzlKIMf87fIKHHKjD0e5E0VAKdGgSG1ASteCW0IULrO
 0op5DUUTYVRpmr310L67gvYXWpOyt7U1s/8iPQNE4u6Cmh2xQNJrR3QvXzKffUaAQx9ZfO
 zwO7Dy9+8dFHXt028/n4SRTKkxV63lY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1781045735;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AK0lAI/L7KWeLpXZikL7802IriIE8OcDhU1wXKiEUL4=;
 b=Z02bPHrjQNcsfb0pxdLGccp9Mu44+YAW5x9zAT6Pm3CttYRGOmd1uUrZkgwv5t2XIHMEaC
 0+jOKNPEirzMAvAw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=dyC+XZMv;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="agY/04OQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1781045734; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AK0lAI/L7KWeLpXZikL7802IriIE8OcDhU1wXKiEUL4=;
 b=dyC+XZMvzzWM+/GSnVAKCwOB0zIwyuABOuVsZua8XnVktJucHeLx7fo7WQFD1lodQzIcxY
 GXmEp5aPCOnw9An875Jz/i+9aNrgjoF9IuWSBdWlaY7xj86mFan2PKCxt+1dvb0HVXsh5S
 ONLK5o/aB1JT2ZkFh/SiY0OSBMfe/9Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1781045734;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AK0lAI/L7KWeLpXZikL7802IriIE8OcDhU1wXKiEUL4=;
 b=agY/04OQKzSUGADywm3OypPyEpod+YI9khjxfo669RvTCojoXLQFj/nQgwkimMlNt5hcqS
 84Da+ZMrkFyyHICA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A2117779A7;
 Tue,  9 Jun 2026 22:55:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id PzZKHOWZKGqROAAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 09 Jun 2026 22:55:33 +0000
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
Subject: Re: [PATCH v2 01/10] migration: Use OBJECT_DECLARE_SIMPLE_TYPE
In-Reply-To: <20260609172514.2037645-2-peterx@redhat.com>
References: <20260609172514.2037645-1-peterx@redhat.com>
 <20260609172514.2037645-2-peterx@redhat.com>
Date: Tue, 09 Jun 2026 19:55:31 -0300
Message-ID: <87h5nb5noc.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_TLS_ALL(0.00)[]; MISSING_XM_UA(0.00)[];
 RCPT_COUNT_TWELVE(0.00)[20]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 MID_RHS_MATCH_FROM(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 0DF8C75941
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

> Migration object's class has nothing special, switch to the newly
> introduced macro.
>
> Suggested-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  migration/migration.h | 9 +--------
>  migration/migration.c | 7 +++----
>  2 files changed, 4 insertions(+), 12 deletions(-)
>
> diff --git a/migration/migration.h b/migration/migration.h
> index 841f49b215..293ad60e07 100644
> --- a/migration/migration.h
> +++ b/migration/migration.h
> @@ -263,14 +263,7 @@ void fill_destination_postcopy_migration_info(Migrat=
ionInfo *info);
>=20=20
>  #define TYPE_MIGRATION "migration"
>=20=20
> -typedef struct MigrationClass MigrationClass;
> -DECLARE_OBJ_CHECKERS(MigrationState, MigrationClass,
> -                     MIGRATION_OBJ, TYPE_MIGRATION)
> -
> -struct MigrationClass {
> -    /*< private >*/
> -    DeviceClass parent_class;
> -};
> +OBJECT_DECLARE_SIMPLE_TYPE(MigrationState, MIGRATION);
>=20=20
>  struct MigrationState {
>      /*< private >*/
> diff --git a/migration/migration.c b/migration/migration.c
> index 074d3f2c69..278cad502a 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -297,7 +297,7 @@ void migration_object_init(void)
>  {
>      /* This can only be called once. */
>      assert(!current_migration);
> -    current_migration =3D MIGRATION_OBJ(object_new(TYPE_MIGRATION));
> +    current_migration =3D MIGRATION(object_new(TYPE_MIGRATION));
>=20=20
>      /*
>       * Init the migrate incoming object as well no matter whether
> @@ -3975,7 +3975,7 @@ static void migration_class_init(ObjectClass *klass=
, const void *data)
>=20=20
>  static void migration_instance_finalize(Object *obj)
>  {
> -    MigrationState *ms =3D MIGRATION_OBJ(obj);
> +    MigrationState *ms =3D MIGRATION(obj);
>=20=20
>      qapi_free_BitmapMigrationNodeAliasList(ms->parameters.block_bitmap_m=
apping);
>      qapi_free_strList(ms->parameters.cpr_exec_command);
> @@ -3993,7 +3993,7 @@ static void migration_instance_finalize(Object *obj)
>=20=20
>  static void migration_instance_init(Object *obj)
>  {
> -    MigrationState *ms =3D MIGRATION_OBJ(obj);
> +    MigrationState *ms =3D MIGRATION(obj);
>=20=20
>      ms->state =3D MIGRATION_STATUS_NONE;
>      ms->mbps =3D -1;
> @@ -4040,7 +4040,6 @@ static const TypeInfo migration_type =3D {
>       */
>      .parent =3D TYPE_DEVICE,
>      .class_init =3D migration_class_init,
> -    .class_size =3D sizeof(MigrationClass),
>      .instance_size =3D sizeof(MigrationState),
>      .instance_init =3D migration_instance_init,
>      .instance_finalize =3D migration_instance_finalize,

Reviewed-by: Fabiano Rosas <farosas@suse.de>

