Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8943CCD98C5
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 20:19:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXPNf-0007ut-5t; Wed, 10 Jun 2026 16:18:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wXPNa-0007tt-Al
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 16:18:26 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wXPNX-00028r-36
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 16:18:26 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 650486AEBF;
 Wed, 10 Jun 2026 20:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1781122700; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Xyw7J8BaGkiSyoi79X/n196HIYajNaJcCsfPQM3rM+E=;
 b=2P+wURW/qwmXHm997xJabX/BuFQ9ks8un1hTjNV8dycOTD4aqMvDMyTRmSshHo5UucBXs7
 pFwVcy8t+1OurqM1/Xrs0byY1+OiFaPEIe7+CmwSoG/mZRbXOheOFHFuvMR37hfOl72dL1
 bqELA1em9ujLyJqqvY/wiOnkK6WOErs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1781122700;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Xyw7J8BaGkiSyoi79X/n196HIYajNaJcCsfPQM3rM+E=;
 b=SkxyMDQdGuLA8XLvzmuetVoAbJ09DFS1gh/xTgvYyI4268hP2Ok6AHckLsueybRD8zizlJ
 suPqHpbf4xgcbXCg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=DmPm5huJ;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=kUx4kg22
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1781122699; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Xyw7J8BaGkiSyoi79X/n196HIYajNaJcCsfPQM3rM+E=;
 b=DmPm5huJ4sFBKew9yZqp3cMDvCoL9fCK80Ukj4OkEfS4rLKiUgzd3PPueScShQnPIYBdEH
 pGF8+YwB6uvFCPIwh+rz3ovMXrkzlkIfiCRR5NTyYBC2UBkPwKj5Y1xTkK6GMpobuQSPUF
 QVC8pwdyjqJW8OAgLqbWPNl1owfvI5Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1781122699;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Xyw7J8BaGkiSyoi79X/n196HIYajNaJcCsfPQM3rM+E=;
 b=kUx4kg22FrsfYzMQVpsjcfBgcktbrABvBfnooPpMnD4arESN+PUwMarWD6p7x/BY76j9vU
 /fJaU+r64LSSaBDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C963D779A7;
 Wed, 10 Jun 2026 20:18:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id WGrCIorGKWrlNAAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 10 Jun 2026 20:18:18 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, =?utf-8?Q?C=C3=A9dric?= Le
 Goater <clg@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@mailo.com>, Vladimir
 Sementsov-Ogievskiy <vsementsov@yandex-team.ru>, Peter Maydell
 <peter.maydell@linaro.org>, "Dr . David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>, Akihiko Odaki
 <odaki@rsg.ci.i.u-tokyo.ac.jp>, Paolo Bonzini <pbonzini@redhat.com>, Kevin
 Wolf <kwolf@redhat.com>, Sana Sharma <sansshar@redhat.com>, =?utf-8?Q?Mar?=
 =?utf-8?Q?c-Andr=C3=A9?=
 Lureau <marcandre.lureau@redhat.com>, Juraj Marcin <jmarcin@redhat.com>,
 qemu-rust@nongnu.org, Markus Armbruster <armbru@redhat.com>, Mark
 Cave-Ayland <mark.caveayland@nutanix.com>
Subject: Re: [PATCH v2 10/10] migration: Switch to TYPE_OBJECT with object
 properties
In-Reply-To: <87wlw641f3.fsf@suse.de>
References: <20260609172514.2037645-1-peterx@redhat.com>
 <20260609172514.2037645-11-peterx@redhat.com>
 <aimNOxqrmmXPQTfS@redhat.com> <aimxFsY_B0-slXjC@x1.local>
 <87wlw641f3.fsf@suse.de>
Date: Wed, 10 Jun 2026 17:18:15 -0300
Message-ID: <87se6u40ag.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 DWL_DNSWL_LOW(-1.00)[suse.de:dkim];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCPT_COUNT_TWELVE(0.00)[19]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]; TO_DN_SOME(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_TLS_ALL(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email, suse.de:dkim, suse.de:mid,
 imap1.dmz-prg2.suse.org:helo, imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 650486AEBF
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

Fabiano Rosas <farosas@suse.de> writes:

> Peter Xu <peterx@redhat.com> writes:
>
>> On Wed, Jun 10, 2026 at 05:13:47PM +0100, Daniel P. Berrang=C3=A9 wrote:
>>> On Tue, Jun 09, 2026 at 01:25:14PM -0400, Peter Xu wrote:
>>> > The migration object used to depend on TYPE_DEVICE due to:
>>> >=20
>>> > - Usage of qdev properties
>>> > - Apply compat properties and global properties
>>> >=20
>>> > This patch re-based the object to TYPE_OBJECT with the changes:
>>> >=20
>>> > - Switch to object properties API
>>> > - Manually apply both compat and global properties in post_init()
>>> >=20
>>> > Note that to avoid too many property getter/setter helpers, this patc=
h used
>>> > the object_property_add_*_ptr_def() APIs so that an pointer is passed=
 to
>>> > bind to the property.  Such API is used for most of the conversions.
>>> >=20
>>> > After patch, the migration object initializes instance properties wit=
hin
>>> > its instance_init() callback, in migrate_params_init().
>>> >=20
>>> > One side effect of this change is, since we switched to a loop to add=
 all
>>> > capabilities, the name of the properties representing a migration
>>> > capability may chance from previously hard-coded ones (many with x-).=
  It's
>>> > fine since it's only used in -global so it's only for debugging.
>>> >=20
>>> > Similarly, I removed "x-" from other properites that used to start wi=
th
>>> > "x-" but actually are not experimental.
>>>=20
>>> Mixing such a change into a refactoring commit is bad practice,
>>> can you keep property changes separated.
>>
>> Sure.
>>
>>>=20
>>> > After the whole conversion, we don't need migration_properties or the=
 count
>>> > anymore, hence can be removed.  While at it, we can also remove two
>>> > DEFINE_PROP*() API that only migration uses (DEFINE_PROP_STR_OR_NULL,=
 and
>>> > DEFINE_PROP_MIG_CAP).
>>> >=20
>>> > Signed-off-by: Peter Xu <peterx@redhat.com>
>>> > ---
>>> >  migration/options.h   |   8 +-
>>> >  migration/migration.c |  35 ++-
>>> >  migration/options.c   | 526 ++++++++++++++++++++++++++--------------=
--
>>> >  3 files changed, 351 insertions(+), 218 deletions(-)
>>>=20
>>>=20
>>> > diff --git a/migration/options.c b/migration/options.c
>>> > index 5cbfd29099..1cc99382d3 100644
>>> > --- a/migration/options.c
>>> > +++ b/migration/options.c
>>> > @@ -54,7 +54,7 @@
>>>=20
>>>=20
>>> > +static void migration_object_init_props_bool(MigrationState *s)
>>> >  {
>>> > -    const Property *prop =3D opaque;
>>> > -    StrOrNull **ptr =3D object_field_prop_ptr(obj, prop);
>>> > -    StrOrNull *str_or_null =3D *ptr;
>>> > +    Object *obj =3D OBJECT(s);
>>> > +    int i;
>>> >=20=20
>>> > -    /*
>>> > -     * The property should never be NULL because it's part of
>>> > -     * s->parameters and a default value is always set by qdev. It
>>> > -     * should also never be QNULL as the setter doesn't allow it.
>>> > -     */
>>> > -    assert(str_or_null && str_or_null->type !=3D QTYPE_QNULL);
>>> > -    visit_type_str(v, name, &str_or_null->u.s, errp);
>>> > +    struct MigPropBool {
>>> > +        const char *name;
>>> > +        void *ptr;
>>> > +        bool defvar;
>>> > +    } bool_list[] =3D {
>>> > +        {
>>> > +            "store-global-state",
>>> > +            &s->store_global_state,
>>> > +            true,
>>> > +        },
>>> > +        {
>>> > +            "send-configuration",
>>> > +            &s->send_configuration,
>>> > +            true,
>>> > +        },
>>> > +        {
>>> > +            "send-section-footer",
>>> > +            &s->send_section_footer,
>>> > +            true,
>>> > +        },
>>> > +        {
>>> > +            "send-switchover-start",
>>> > +            &s->send_switchover_start,
>>> > +            true,
>>> > +        },
>>> > +        {
>>> > +            "x-preempt-pre-7-2",
>>> > +            &s->preempt_pre_7_2,
>>> > +            false,
>>> > +        },
>>> > +        {
>>> > +            "x-cpu-throttle-tailslow",
>>> > +            &s->parameters.cpu_throttle_tailslow,
>>> > +            false,
>>> > +        },
>>> > +        {
>>> > +            "multifd-clean-tls-termination",
>>> > +            &s->multifd_clean_tls_termination,
>>> > +            true,
>>> > +        },
>>> > +        {
>>> > +            "multifd-flush-after-each-section",
>>> > +            &s->multifd_flush_after_each_section,
>>> > +            false,
>>> > +        },
>>> > +    };
>>> > +    struct MigPropBool *prop;
>>>=20
>>> This approach to declaring properties is pretty unpleasant
>>> to follow IMHO. Being a custom different approach from every
>>> other object impl is not a good thing.
>>
>> [I asked this question elsewhere, I'll keep the discussion there]
>>
>>>=20
>>> > +
>>> > +    for (i =3D 0; i < ARRAY_SIZE(bool_list); i++) {
>>> > +        prop =3D &bool_list[i];
>>> > +        object_property_add_bool_ptr_def(obj, prop->name,
>>> > +                                         prop->ptr, prop->defvar);
>>> > +    }
>>>=20
>>> Using instance level properties is the old way to do things,
>>> it is preferred to use class level properties instead.
>>>=20
>>> This means you can't use the "ptr" concept to directly reference
>>> the instance fields and have to provide setters / getters explicitly
>>> instead, but as you've shown with the TLS properties,  a macro can
>>> make it simple to define the repetitive getters/setters.
>>
>> If pointer is unwanted, I can switch to some more macro magic.  But since
>> this series got rewrote the 3rd time..  I'll make sure it's extremely
>> required before doing it..
>>
>>> > +static void migration_object_init_props_enum(MigrationState *s)
>>> > +{
>>> > +    Object *obj =3D OBJECT(s);
>>> > +    ObjectProperty *prop;
>>> > +
>>> > +    prop =3D object_property_add_enum(obj, "multifd-compression",
>>> > +                                    "MultiFDCompression",
>>> > +                                    &MultiFDCompression_lookup,
>>> > +                                    mig_prop_multifd_compression_get,
>>> > +                                    mig_prop_multifd_compression_set=
);
>>> > +    object_property_set_default_str(prop, DEFAULT_MIGRATE_MULTIFD_CO=
MPRESSION);
>>> > +
>>> > +    prop =3D object_property_add_enum(obj, "mode", "MigMode", &MigMo=
de_lookup,
>>> > +                                    mig_prop_mode_get, mig_prop_mode=
_set);
>>> > +    object_property_set_default_str(prop, "normal");
>>> > +
>>> > +    prop =3D object_property_add_enum(obj, "zero-page-detection",
>>> > +                                    "ZeroPageDetection",
>>> > +                                    &ZeroPageDetection_lookup,
>>> > +                                    mig_prop_zero_page_detection_get,
>>> > +                                    mig_prop_zero_page_detection_set=
);
>>> > +    object_property_set_default_str(prop, "multifd");
>>> > +}
>>>=20
>>> Perhaps I'm missing something, but I'm not seeing the point in
>>> using the set_default methods - in fact I'm not really sure why
>>> they exist in QOM at all.
>>>=20
>>> I'd expect all defaults to be set in the instance _init method.
>>> ie why isn't this done as:
>>>=20
>>>    void migrate_params_init(MigrationState *s)
>>>    {
>>>       s->parameters.mode =3D MIG_MODE_NORMAL;
>>>       s->parameters.zero_page_detection =3D ZERO_PAGE_DETECTION_MULTIFD;
>>>       .... all other defaults...
>>>    }
>>
>> Yes frankly I asked myself the same question when looking at this.
>>
>> I still saw quite some defvar references, type_print_class_properties() =
can
>> be one example where we dump help message with default values but without
>> the need to apply.  I didn't check the rest.  If the concept exists and =
if
>> we will be using qobj props, IMHO sticking with it is defintely safer so
>> that all qom future defvar changes will apply and it'll just work there.
>>
>>>=20
>>>=20
>>> > +
>>> > +static void migration_object_init_properties(MigrationState *s)
>>> > +{
>>> > +    migration_object_init_props_bool(s);
>>> > +    migration_object_init_props_uint8(s);
>>> > +    migration_object_init_props_uint32(s);
>>> > +    migration_object_init_props_uint64(s);
>>> > +    migration_object_init_props_size(s);
>>> > +    migration_object_init_props_caps(s);
>>> > +    migration_object_init_props_tls(s);
>>> > +    migration_object_init_props_enum(s);
>>> > +}
>>>=20
>>> ...and class properties be registered in migrate_params_class_init()
>>> and the grouping per type isn't helpful IMHO, just put all the
>>> object_class_property_add calls inline in one place.
>>
>> I still want to avoid long functions, one way or another.
>>
>> Hopefully it makes sense when I have those arrays to init different type=
 of
>> props it makes sense to split with this, but I'm open to other way to
>> split.  I still want to not make it a extremely long function.
>>
>
> I see why you did it that way, it's mostly a limitation of the object
> code in that it requires the type of the default value only to convert
> it to a QObject internally. IMO, this is backwards, the object.c code
> should take the QObject and let the caller do the conversion.
>
> I rewrote this part of the code using a ObjectProperties object as
> intermediary, instead of MigProp*. I think this looks easier to parse,
> although it's longer.
>
> -->8--
> From a6529d119d25ecc00f92686e2cddf1d81dc43183 Mon Sep 17 00:00:00 2001
> From: Fabiano Rosas <farosas@suse.de>
> Date: Wed, 10 Jun 2026 16:49:52 -0300
> Subject: [PATCH] poc
>
> ---
>  migration/options.c | 114 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 114 insertions(+)
>
> diff --git a/migration/options.c b/migration/options.c
> index 5a74aef0ad..7ab1079284 100644
> --- a/migration/options.c
> +++ b/migration/options.c
> @@ -90,6 +90,120 @@
>  #define DEFAULT_MIGRATE_VCPU_DIRTY_LIMIT            1       /* MB/s */
>  #define DEFAULT_MIGRATE_X_RDMA_CHUNK_SIZE           MiB
>=20=20
> +#define defstr(def) QOBJECT(qstring_from_str((const char *)def))
> +#define defbool(def) QOBJECT(qbool_from_bool((bool)def))
> +#define defint(def) QOBJECT(qnum_from_int((int64_t)def))
> +#define defuint(def) QOBJECT(qnum_from_uint(def))
> +
> +#define defuint8 defuint
> +#define defuint16 defuint
> +#define defuint32 defuint
> +#define defuint64 defuint
> +#define defenum defstr
> +#define defStrOrNull defstr
> +#define defMigMode defenum
> +#define defMultiFDCompression defenum
> +#define defZeroPageDetection defenum
> +
> +#define DEFPROP_PTR_ACCESSOR(_t)                                        \
> +    static void property_visit_type_##_t(Object *obj, Visitor *v,       \
> +                                         const char *name, void *opaque,=
 \
> +                                         Error **errp)                  \
> +    {                                                                   \
> +        visit_type_##_t(v, name, opaque, errp);                         \
> +    }                                                                   \

I'm trying to convert this Object to a QDict here. Then we could pass
the name of the struct field as the opaque and set/get via dict
operations and this function could be generic for all parameters.

> +                                                                        \
> +    static inline ObjectProperty prop_##_t(const char *name, void *opaqu=
e, \
> +                                           uint64_t def)                \
> +    {                                                                   \
> +        return (ObjectProperty) {                                       \
> +            .name =3D (char *)name,                                     =
  \
> +            .type =3D (char *)"##_t",                                   =
  \
> +            .opaque =3D opaque,                                         =
  \
> +            .get =3D property_visit_type_##_t,                          =
  \
> +            .set =3D property_visit_type_##_t,                          =
  \
> +            .defval =3D def##_t(def),                                   =
  \
> +        };                                                              \
> +    }                                                                   \
> +
> +DEFPROP_PTR_ACCESSOR(str);
> +DEFPROP_PTR_ACCESSOR(bool);
> +DEFPROP_PTR_ACCESSOR(int);
> +DEFPROP_PTR_ACCESSOR(uint8);
> +DEFPROP_PTR_ACCESSOR(uint16);
> +DEFPROP_PTR_ACCESSOR(uint32);
> +DEFPROP_PTR_ACCESSOR(uint64);
> +DEFPROP_PTR_ACCESSOR(StrOrNull);
> +DEFPROP_PTR_ACCESSOR(MigMode);
> +DEFPROP_PTR_ACCESSOR(MultiFDCompression);
> +DEFPROP_PTR_ACCESSOR(ZeroPageDetection);
> +
> +static void migration_object_init_properties(MigrationState *s)
> +{
> +    Object *obj =3D OBJECT(s);
> +    ObjectProperty props_list[] =3D {
> +        prop_bool("store-global-state", &s->store_global_state, true),
> +        prop_bool("send-configuration", &s->send_configuration, true),
> +        prop_bool("send-section-footer", &s->send_section_footer, true),
> +        prop_bool("send-switchover-start", &s->send_switchover_start, tr=
ue),
> +        prop_bool("x-preempt-pre-7-2", &s->preempt_pre_7_2, false),
> +        prop_bool("x-cpu-throttle-tailslow", &s->parameters.cpu_throttle=
_tailslow, false),
> +        prop_bool("multifd-clean-tls-termination", &s->multifd_clean_tls=
_termination, true),
> +        prop_bool("multifd-flush-after-each-section", &s->multifd_flush_=
after_each_section, false),
> +
> +        prop_uint8("clear-bitmap-shift", &s->clear_bitmap_shift, CLEAR_B=
ITMAP_SHIFT_DEFAULT),
> +        prop_uint8("throttle-trigger-threshold", &s->parameters.throttle=
_trigger_threshold, DEFAULT_MIGRATE_THROTTLE_TRIGGER_THRESHOLD),
> +        prop_uint8("cpu-throttle-initial", &s->parameters.cpu_throttle_i=
nitial, DEFAULT_MIGRATE_CPU_THROTTLE_INITIAL),
> +        prop_uint8("cpu-throttle-increment", &s->parameters.cpu_throttle=
_increment, DEFAULT_MIGRATE_CPU_THROTTLE_INCREMENT),
> +        prop_uint8("multifd-channels", &s->parameters.multifd_channels, =
DEFAULT_MIGRATE_MULTIFD_CHANNELS),
> +        prop_uint8("multifd-zlib-level", &s->parameters.multifd_zlib_lev=
el, DEFAULT_MIGRATE_MULTIFD_ZLIB_LEVEL),
> +        prop_uint8("multifd-qatzip-level", &s->parameters.multifd_qatzip=
_level, DEFAULT_MIGRATE_MULTIFD_QATZIP_LEVEL),
> +        prop_uint8("multifd-zstd-level", &s->parameters.multifd_zstd_lev=
el, DEFAULT_MIGRATE_MULTIFD_ZSTD_LEVEL),
> +        prop_uint8("max-cpu-throttle", &s->parameters.max_cpu_throttle, =
DEFAULT_MIGRATE_MAX_CPU_THROTTLE),
> +
> +        prop_uint32("x-checkpoint-delay", &s->parameters.x_checkpoint_de=
lay, DEFAULT_MIGRATE_X_CHECKPOINT_DELAY),
> +
> +        prop_uint64("downtime-limit", &s->parameters.downtime_limit, DEF=
AULT_MIGRATE_SET_DOWNTIME),
> +        prop_uint64("x-vcpu-dirty-limit-period", &s->parameters.x_vcpu_d=
irty_limit_period, DEFAULT_MIGRATE_VCPU_DIRTY_LIMIT_PERIOD),
> +        prop_uint64("vcpu-dirty-limit", &s->parameters.vcpu_dirty_limit,=
 DEFAULT_MIGRATE_VCPU_DIRTY_LIMIT),
> +        prop_uint64("x-rdma-chunk-size", &s->parameters.x_rdma_chunk_siz=
e, DEFAULT_MIGRATE_X_RDMA_CHUNK_SIZE),
> +        prop_uint64("xbzrle-cache-size", &s->parameters.xbzrle_cache_siz=
e, DEFAULT_MIGRATE_XBZRLE_CACHE_SIZE),
> +        prop_uint64("max-postcopy-bandwidth", &s->parameters.max_postcop=
y_bandwidth, DEFAULT_MIGRATE_MAX_POSTCOPY_BANDWIDTH),
> +        prop_uint64("announce-initial", &s->parameters.announce_initial,=
 DEFAULT_MIGRATE_ANNOUNCE_INITIAL),
> +        prop_uint64("announce-max", &s->parameters.announce_max, DEFAULT=
_MIGRATE_ANNOUNCE_MAX),
> +        prop_uint64("announce-rounds", &s->parameters.announce_rounds, D=
EFAULT_MIGRATE_ANNOUNCE_ROUNDS),
> +        prop_uint64("announce-step", &s->parameters.announce_step, DEFAU=
LT_MIGRATE_ANNOUNCE_STEP),
> +        prop_uint64("max-bandwidth", &s->parameters.max_bandwidth, MAX_T=
HROTTLE),
> +        prop_uint64("avail-switchover-bandwidth", &s->parameters.avail_s=
witchover_bandwidth, 0),
> +
> +        prop_StrOrNull("tls-creds", &s->parameters.tls_creds, (uint64_t)=
""),
> +        prop_StrOrNull("tls-hostname", &s->parameters.tls_hostname, (uin=
t64_t)""),
> +        prop_StrOrNull("tls-authz", &s->parameters.tls_authz, (uint64_t)=
""),
> +
> +        prop_MigMode("mode", &s->parameters.mode, (uint64_t)"normal"),
> +        prop_MultiFDCompression("multifd-compression", &s->parameters.mu=
ltifd_compression, (uint64_t)DEFAULT_MIGRATE_MULTIFD_COMPRESSION),
> +        prop_ZeroPageDetection("zero-page-detection", &s->parameters.zer=
o_page_detection, (uint64_t)"multifd"),
> +    };
> +
> +    for (int i =3D 0; i < ARRAY_SIZE(props_list); i++) {
> +        ObjectProperty *new;
> +        ObjectProperty *in =3D &props_list[i];
> +
> +        new =3D object_property_add(obj, in->name, in->type, in->get, in=
->set,
> +                                  in->release, in->opaque);
> +        object_property_set_default(new, in->defval);
> +    }
> +
> +    /* Migration capabilities are always turned off by default */
> +    for (int i =3D 0; i < MIGRATION_CAPABILITY__MAX; i++) {
> +        ObjectProperty prop, *new;
> +
> +        prop =3D prop_bool(MigrationCapability_str(i), &s->capabilities[=
i], false);
> +        new =3D object_property_add(obj, prop.name, prop.type, prop.get,=
 prop.set,
> +                                  NULL, prop.opaque);
> +        object_property_set_default(new, prop.defval);
> +    }
> +}
>=20=20
>  bool migrate_auto_converge(void)
>  {

