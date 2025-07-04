Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06C9FC83F03
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 12:59:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXfzx-00016v-RB; Fri, 04 Jul 2025 08:58:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uXfzr-000162-U9
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 08:58:33 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uXfzn-0006ij-M3
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 08:58:31 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8BE87211A1;
 Fri,  4 Jul 2025 12:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1751633905; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/phf1KLxfLWyO0PBh88IE5Km1ukcO/Gkib1l3mCP+FU=;
 b=MEXhHun1fEGBfZf851yclfYzIRLowqvbyRkUJ2VR2IzEGzGxQViOoPj+NXTbzi9+s33MGF
 NAs6O+bq3WQlGyhcOjBiRRVO9uQTmacLiBaOWcxzY7AzNwSqIR6wrzkB4ewZKOJL4gGY0I
 H7l+B9zIsX+c+dJy0W6ePc4iWtyj4UE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1751633905;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/phf1KLxfLWyO0PBh88IE5Km1ukcO/Gkib1l3mCP+FU=;
 b=SIVwkQ6Q2ZyNVvsM1z+Q5s33z19yGxwhKxxmW1fGMleQ3FE4MZJKJEDgE7jihlJRRbFJy9
 isfbqLtElVuIjDBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1751633905; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/phf1KLxfLWyO0PBh88IE5Km1ukcO/Gkib1l3mCP+FU=;
 b=MEXhHun1fEGBfZf851yclfYzIRLowqvbyRkUJ2VR2IzEGzGxQViOoPj+NXTbzi9+s33MGF
 NAs6O+bq3WQlGyhcOjBiRRVO9uQTmacLiBaOWcxzY7AzNwSqIR6wrzkB4ewZKOJL4gGY0I
 H7l+B9zIsX+c+dJy0W6ePc4iWtyj4UE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1751633905;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/phf1KLxfLWyO0PBh88IE5Km1ukcO/Gkib1l3mCP+FU=;
 b=SIVwkQ6Q2ZyNVvsM1z+Q5s33z19yGxwhKxxmW1fGMleQ3FE4MZJKJEDgE7jihlJRRbFJy9
 isfbqLtElVuIjDBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0FB1C13A71;
 Fri,  4 Jul 2025 12:58:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id mHq8MvDPZ2jhXAAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 04 Jul 2025 12:58:24 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, berrange@redhat.com
Subject: Re: [PATCH v2 02/24] migration: Add a qdev property for StrOrNull
In-Reply-To: <aGcE6Av_IBOGBNvD@x1.local>
References: <20250630195913.28033-1-farosas@suse.de>
 <20250630195913.28033-3-farosas@suse.de> <87a55o4dr8.fsf@pond.sub.org>
 <aGcE6Av_IBOGBNvD@x1.local>
Date: Fri, 04 Jul 2025 09:58:22 -0300
Message-ID: <87ms9k3yfl.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid, suse.de:email,
 imap1.dmz-prg2.suse.org:helo]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Peter Xu <peterx@redhat.com> writes:

> On Tue, Jul 01, 2025 at 08:38:19AM +0200, Markus Armbruster wrote:
>> Fabiano Rosas <farosas@suse.de> writes:
>> 
>> > The MigrationState is a QOM object with TYPE_DEVICE as a parent. This
>> > was done about eight years ago so the migration code could make use of
>> > qdev properties to define the defaults for the migration parameters
>> > and to be able to expose migration knobs for debugging via the
>> > '-global migration' command line option.
>> >
>> > Due to unrelated historical reasons, three of the migration parameters
>> > (TLS options) received different types when used via the
>> > query-migrate-parameters QMP command than with the
>> > migrate-set-parameters command. This has created a lot of duplication
>> > in the migration code and in the QAPI documentation because the whole
>> > of MigrationParameters had to be duplicated as well.
>> >
>> > The migration code is now being fixed to remove the duplication and
>> > for that to happen the offending fields need to be reconciled into a
>> > single type. The StrOrNull type is going to be used.
>> >
>> > To keep the command line compatibility, the parameters need to
>> > continue being exposed via qdev properties accessible from the command
>> > line. Introduce a qdev property StrOrNull just for that.
>> >
>> > Note that this code is being kept in migration/options.c because this
>> > version of StrOrNull doesn't need to handle QNULL because it was never
>> > a valid option in the previous command line, which took a string.
>> >
>> > Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> > ---
>> >  migration/options.c | 47 +++++++++++++++++++++++++++++++++++++++++++++
>> >  1 file changed, 47 insertions(+)
>> >
>> > diff --git a/migration/options.c b/migration/options.c
>> > index 162c72cda4..384ef9e421 100644
>> > --- a/migration/options.c
>> > +++ b/migration/options.c
>> > @@ -83,6 +83,11 @@
>> >  #define DEFINE_PROP_MIG_CAP(name, x)             \
>> >      DEFINE_PROP_BOOL(name, MigrationState, capabilities[x], false)
>> >  
>> > +const PropertyInfo qdev_prop_StrOrNull;
>> > +#define DEFINE_PROP_STR_OR_NULL(_name, _state, _field)                  \
>> > +    DEFINE_PROP(_name, _state, _field, qdev_prop_StrOrNull, StrOrNull *, \
>> > +                .set_default = true)
>> > +
>> >  #define DEFAULT_MIGRATE_VCPU_DIRTY_LIMIT_PERIOD     1000    /* milliseconds */
>> >  #define DEFAULT_MIGRATE_VCPU_DIRTY_LIMIT            1       /* MB/s */
>> >  
>> > @@ -204,6 +209,48 @@ const Property migration_properties[] = {
>> >  };
>> >  const size_t migration_properties_count = ARRAY_SIZE(migration_properties);
>> >  
>> > +/*
>> > + * qdev property for TLS options handling via '-global migration'
>> > + * command line.
>> > + */
>> 
>> Looks like this was a function comment.  It's not, it applies to the
>> PropertyInfo and its method.  Move it to the PropertyInfo?
>> 
>> Maybe
>> 
>>    /*
>>     * String property like qdev_prop_string, except it's backed by a
>>     * StrOrNull * instead of a char *.  This is intended for
>>     * TYPE_MIGRATION's TLS options.
>>     */
>> 
>> > +static void set_StrOrNull(Object *obj, Visitor *v, const char *name,
>> > +                          void *opaque, Error **errp)
>> > +{
>> > +    const Property *prop = opaque;
>> > +    StrOrNull **ptr = object_field_prop_ptr(obj, prop);
>> > +    StrOrNull *str_or_null = g_new0(StrOrNull, 1);
>> > +
>> > +    /*
>> > +     * Only str to keep compatibility, QNULL was never used via
>> > +     * command line.
>> > +     */
>> > +    str_or_null->type = QTYPE_QSTRING;
>> > +    if (!visit_type_str(v, name, &str_or_null->u.s, errp)) {
>> > +        return;
>> > +    }
>> > +
>> > +    qapi_free_StrOrNull(*ptr);
>> > +    *ptr = str_or_null;
>> > +}
>> > +
>> > +static void release_StrOrNull(Object *obj, const char *name, void *opaque)
>> > +{
>> > +    const Property *prop = opaque;
>> > +    qapi_free_StrOrNull(*(StrOrNull **)object_field_prop_ptr(obj, prop));
>> > +}
>> > +
>> > +static void set_default_value_tls_opt(ObjectProperty *op, const Property *prop)
>> > +{
>> > +    object_property_set_default_str(op, "");
>> > +}
>> > +
>> > +const PropertyInfo qdev_prop_StrOrNull = {
>> > +    .type  = "StrOrNull",
>> > +    .set = set_StrOrNull,
>> > +    .release = release_StrOrNull,
>> > +    .set_default_value = set_default_value_tls_opt,
>> > +};
>> 
>> No getter, i.e. properties will be write-only.  This is unusual.  Is it
>> safe?
>
> Fair question..
>
> I had a quick look, device_class_set_props_n() will try to register the
> prop with legacy mode first then modern mode.  Legacy mode is decided by
> [1] below:
>
> static void qdev_class_add_legacy_property(DeviceClass *dc, const Property *prop)
> {
>     g_autofree char *name = NULL;
>
>     /* Register pointer properties as legacy properties */
>     if (!prop->info->print && prop->info->get) { <------------------ [1]
>         return;
>     }
>
>     name = g_strdup_printf("legacy-%s", prop->name);
>     object_class_property_add(OBJECT_CLASS(dc), name, "str",
>         prop->info->print ? qdev_get_legacy_property : prop->info->get,
>         NULL, NULL, (Property *)prop);
> }
>
> When with no get(), it seems it'll be wrongly treated as legacy property..
> which further means whoever tries to get() on the property will invoke
> qdev_get_legacy_property(), and likely crash on accessing info->print()..
>
> The other issue is legacy property doesn't look like to provide a setter
> function.. as it's passing NULL to object_class_property_add(set=XXX).
>
> Likely we'll need to provide get() if without changing qdev code.
>

Peter, thank you for the analysis and sorry all for not commenting on
this earlier. I have reached the same conclusions and have implemented
the .get method.

>> 
>> > +
>> >  bool migrate_auto_converge(void)
>> >  {
>> >      MigrationState *s = migrate_get_current();
>> 

