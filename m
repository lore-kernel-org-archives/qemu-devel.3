Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7556FC8302F
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 06:38:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWUdS-0004YZ-Ei; Tue, 01 Jul 2025 02:38:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uWUdP-0004Y8-QV
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 02:38:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uWUdN-000331-Hu
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 02:38:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751351904;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3FNq4lMgYTrqwt7mPLW5sUjfowZ0T+hvYqhuv6RL6vA=;
 b=bzvNBGErDiWWYb+7pw3wHk6rxttc3VdjoGFi4lCtbq9juKqVoeFlytUK3bH792k6kbvt0H
 GAI6AVOsN9x57HylywnxVucIgg7G1Y8wQfqgXAGmsfsEA6M3CwmU3Y1DpGA80ZfiHaM+Hs
 jPNRzO6dOf+3dmpgrxeQWWuW2yQD/wg=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-237-kEdaOO0YMVq9udhJpGgkVw-1; Tue,
 01 Jul 2025 02:38:23 -0400
X-MC-Unique: kEdaOO0YMVq9udhJpGgkVw-1
X-Mimecast-MFC-AGG-ID: kEdaOO0YMVq9udhJpGgkVw_1751351902
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5BAE81955EC1; Tue,  1 Jul 2025 06:38:22 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.10])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DFD5218003FC; Tue,  1 Jul 2025 06:38:21 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 311A221E6A27; Tue, 01 Jul 2025 08:38:19 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH v2 02/24] migration: Add a qdev property for StrOrNull
In-Reply-To: <20250630195913.28033-3-farosas@suse.de> (Fabiano Rosas's message
 of "Mon, 30 Jun 2025 16:58:51 -0300")
References: <20250630195913.28033-1-farosas@suse.de>
 <20250630195913.28033-3-farosas@suse.de>
Date: Tue, 01 Jul 2025 08:38:19 +0200
Message-ID: <87a55o4dr8.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Fabiano Rosas <farosas@suse.de> writes:

> The MigrationState is a QOM object with TYPE_DEVICE as a parent. This
> was done about eight years ago so the migration code could make use of
> qdev properties to define the defaults for the migration parameters
> and to be able to expose migration knobs for debugging via the
> '-global migration' command line option.
>
> Due to unrelated historical reasons, three of the migration parameters
> (TLS options) received different types when used via the
> query-migrate-parameters QMP command than with the
> migrate-set-parameters command. This has created a lot of duplication
> in the migration code and in the QAPI documentation because the whole
> of MigrationParameters had to be duplicated as well.
>
> The migration code is now being fixed to remove the duplication and
> for that to happen the offending fields need to be reconciled into a
> single type. The StrOrNull type is going to be used.
>
> To keep the command line compatibility, the parameters need to
> continue being exposed via qdev properties accessible from the command
> line. Introduce a qdev property StrOrNull just for that.
>
> Note that this code is being kept in migration/options.c because this
> version of StrOrNull doesn't need to handle QNULL because it was never
> a valid option in the previous command line, which took a string.
>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  migration/options.c | 47 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 47 insertions(+)
>
> diff --git a/migration/options.c b/migration/options.c
> index 162c72cda4..384ef9e421 100644
> --- a/migration/options.c
> +++ b/migration/options.c
> @@ -83,6 +83,11 @@
>  #define DEFINE_PROP_MIG_CAP(name, x)             \
>      DEFINE_PROP_BOOL(name, MigrationState, capabilities[x], false)
>  
> +const PropertyInfo qdev_prop_StrOrNull;
> +#define DEFINE_PROP_STR_OR_NULL(_name, _state, _field)                  \
> +    DEFINE_PROP(_name, _state, _field, qdev_prop_StrOrNull, StrOrNull *, \
> +                .set_default = true)
> +
>  #define DEFAULT_MIGRATE_VCPU_DIRTY_LIMIT_PERIOD     1000    /* milliseconds */
>  #define DEFAULT_MIGRATE_VCPU_DIRTY_LIMIT            1       /* MB/s */
>  
> @@ -204,6 +209,48 @@ const Property migration_properties[] = {
>  };
>  const size_t migration_properties_count = ARRAY_SIZE(migration_properties);
>  
> +/*
> + * qdev property for TLS options handling via '-global migration'
> + * command line.
> + */

Looks like this was a function comment.  It's not, it applies to the
PropertyInfo and its method.  Move it to the PropertyInfo?

Maybe

   /*
    * String property like qdev_prop_string, except it's backed by a
    * StrOrNull * instead of a char *.  This is intended for
    * TYPE_MIGRATION's TLS options.
    */

> +static void set_StrOrNull(Object *obj, Visitor *v, const char *name,
> +                          void *opaque, Error **errp)
> +{
> +    const Property *prop = opaque;
> +    StrOrNull **ptr = object_field_prop_ptr(obj, prop);
> +    StrOrNull *str_or_null = g_new0(StrOrNull, 1);
> +
> +    /*
> +     * Only str to keep compatibility, QNULL was never used via
> +     * command line.
> +     */
> +    str_or_null->type = QTYPE_QSTRING;
> +    if (!visit_type_str(v, name, &str_or_null->u.s, errp)) {
> +        return;
> +    }
> +
> +    qapi_free_StrOrNull(*ptr);
> +    *ptr = str_or_null;
> +}
> +
> +static void release_StrOrNull(Object *obj, const char *name, void *opaque)
> +{
> +    const Property *prop = opaque;
> +    qapi_free_StrOrNull(*(StrOrNull **)object_field_prop_ptr(obj, prop));
> +}
> +
> +static void set_default_value_tls_opt(ObjectProperty *op, const Property *prop)
> +{
> +    object_property_set_default_str(op, "");
> +}
> +
> +const PropertyInfo qdev_prop_StrOrNull = {
> +    .type  = "StrOrNull",
> +    .set = set_StrOrNull,
> +    .release = release_StrOrNull,
> +    .set_default_value = set_default_value_tls_opt,
> +};

No getter, i.e. properties will be write-only.  This is unusual.  Is it
safe?

> +
>  bool migrate_auto_converge(void)
>  {
>      MigrationState *s = migrate_get_current();


