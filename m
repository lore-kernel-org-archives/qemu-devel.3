Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3578AC83F03
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 22:32:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXSTh-0000Er-Hq; Thu, 03 Jul 2025 18:32:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uXSTb-0000Dp-7g
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 18:32:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uXSTY-0002Bh-Hz
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 18:32:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751581934;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VeiHPCM48DpZdSTRv7QnyCh8VvBc3kwK700jLGOi4To=;
 b=QsoF8LpzyOwYnKbBZ1dPGQdWMFjbG8nDhug0+0d716bJ4jpyk6C6e6DwY9fYF5pDrB6udM
 Is6QVfBE4fUuWSb+yKlfk4mC15sUiarQ0QXOy8CAnzqVYrN/pipA4S6tK/tqUx5teZ900f
 y+eL9HdnIEo8nhpZeN4nvUVTBWJkd5w=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-206-poghMZ0rOjqHC3l1T_IHpA-1; Thu, 03 Jul 2025 18:32:13 -0400
X-MC-Unique: poghMZ0rOjqHC3l1T_IHpA-1
X-Mimecast-MFC-AGG-ID: poghMZ0rOjqHC3l1T_IHpA_1751581933
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-7d44a260e45so61211185a.1
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 15:32:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751581933; x=1752186733;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VeiHPCM48DpZdSTRv7QnyCh8VvBc3kwK700jLGOi4To=;
 b=kFpT8KCS4wwYlWQ4xaChPvWtwaISGNh+yTNxyf0K4xFrq1vOPpd3Gg0ocaKFsZTx2O
 WyVkrmwKah1ePROkE62ADY5ClDpclt5B30S1qMHvcocCV5YegiHPMzU1AVUAJRkQvt32
 EgEaH495jDXk+vhxLwdTf5ZSQJ/bJdYY2C10c91tPZYWWypDQETvRi3l//S+jGuTiI4M
 YxQef7mAkHKeHx6YSiQB/m0BhMzoEIKVukJxNLoMThZOuyOiIeLj0rF3NFkNivpYSMSM
 QcODxx5dpVGDOSb47DIBPcPNdeljnArUfZ1ZZm1UL6oCNVnlddrD2lQVGftJqP4iUrqu
 rpKA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV3hNw6KZCvMGJVC1UZq2D1hPXccc2EjMbClGf3YnhPrq5TfjZodIIkfBf2ZDV4TUwxepjEh7sQl0/Q@nongnu.org
X-Gm-Message-State: AOJu0YwoB3M4v/NEq+ZVAFZIv+qI/7fGUW8J54vMI8LZEZRozgVH0jyI
 9O5BvH7BwY7G8vQ2SPMySZtSdSOFkTVhbNvtEP2b/IygZBo5k4T3oa9UfO7VUw5Nq3QxmhbDRPR
 zvlaH7n2xa2+2asS8Qg+qhEL5nlYAoRS0zNcUA5YuxcLa5dsJz0sApLIV
X-Gm-Gg: ASbGnct0DiDxa2WmOYjYaXL/x4ObR/k6RshcTRRh2OSzXp+3Om0GJ7pZ4VBDVzrN1AO
 Q1zUYNABpNZEATiE4i9D99zRp4xdGGNZu5jNkZav70Xekuyst9P/6incomqM1/6Gz7i9o85Mz2g
 2YlCfdw6vhH+i8k+YmiktqQzMc2lGKzEoKf6RxEsd0vPCZ7gt7JZSlAujg71wxeUczXz8jGoF/J
 xgof0EhFCtnh0YNY3e1NTNwvRZXPEG06O9DkMs9l4OpsAjNLvp5bqQXD8VO//DtwsOunYkAVKpW
 UhIz+kFV443cxw==
X-Received: by 2002:a05:620a:438a:b0:7d5:d182:af44 with SMTP id
 af79cd13be357-7d5dc6b8cf2mr133649085a.17.1751581932558; 
 Thu, 03 Jul 2025 15:32:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEgI/pXj0yhZe2dsnqkKYqNymuO3/0140RBY4x1Mj6KinO+bdNdW1E69A+7iL5pLSsv3a73BA==
X-Received: by 2002:a05:620a:438a:b0:7d5:d182:af44 with SMTP id
 af79cd13be357-7d5dc6b8cf2mr133646385a.17.1751581932075; 
 Thu, 03 Jul 2025 15:32:12 -0700 (PDT)
Received: from x1.local ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-702c4d5111csm4115646d6.67.2025.07.03.15.32.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Jul 2025 15:32:11 -0700 (PDT)
Date: Thu, 3 Jul 2025 18:32:08 -0400
From: Peter Xu <peterx@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org, berrange@redhat.com
Subject: Re: [PATCH v2 02/24] migration: Add a qdev property for StrOrNull
Message-ID: <aGcE6Av_IBOGBNvD@x1.local>
References: <20250630195913.28033-1-farosas@suse.de>
 <20250630195913.28033-3-farosas@suse.de>
 <87a55o4dr8.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87a55o4dr8.fsf@pond.sub.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
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

On Tue, Jul 01, 2025 at 08:38:19AM +0200, Markus Armbruster wrote:
> Fabiano Rosas <farosas@suse.de> writes:
> 
> > The MigrationState is a QOM object with TYPE_DEVICE as a parent. This
> > was done about eight years ago so the migration code could make use of
> > qdev properties to define the defaults for the migration parameters
> > and to be able to expose migration knobs for debugging via the
> > '-global migration' command line option.
> >
> > Due to unrelated historical reasons, three of the migration parameters
> > (TLS options) received different types when used via the
> > query-migrate-parameters QMP command than with the
> > migrate-set-parameters command. This has created a lot of duplication
> > in the migration code and in the QAPI documentation because the whole
> > of MigrationParameters had to be duplicated as well.
> >
> > The migration code is now being fixed to remove the duplication and
> > for that to happen the offending fields need to be reconciled into a
> > single type. The StrOrNull type is going to be used.
> >
> > To keep the command line compatibility, the parameters need to
> > continue being exposed via qdev properties accessible from the command
> > line. Introduce a qdev property StrOrNull just for that.
> >
> > Note that this code is being kept in migration/options.c because this
> > version of StrOrNull doesn't need to handle QNULL because it was never
> > a valid option in the previous command line, which took a string.
> >
> > Signed-off-by: Fabiano Rosas <farosas@suse.de>
> > ---
> >  migration/options.c | 47 +++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 47 insertions(+)
> >
> > diff --git a/migration/options.c b/migration/options.c
> > index 162c72cda4..384ef9e421 100644
> > --- a/migration/options.c
> > +++ b/migration/options.c
> > @@ -83,6 +83,11 @@
> >  #define DEFINE_PROP_MIG_CAP(name, x)             \
> >      DEFINE_PROP_BOOL(name, MigrationState, capabilities[x], false)
> >  
> > +const PropertyInfo qdev_prop_StrOrNull;
> > +#define DEFINE_PROP_STR_OR_NULL(_name, _state, _field)                  \
> > +    DEFINE_PROP(_name, _state, _field, qdev_prop_StrOrNull, StrOrNull *, \
> > +                .set_default = true)
> > +
> >  #define DEFAULT_MIGRATE_VCPU_DIRTY_LIMIT_PERIOD     1000    /* milliseconds */
> >  #define DEFAULT_MIGRATE_VCPU_DIRTY_LIMIT            1       /* MB/s */
> >  
> > @@ -204,6 +209,48 @@ const Property migration_properties[] = {
> >  };
> >  const size_t migration_properties_count = ARRAY_SIZE(migration_properties);
> >  
> > +/*
> > + * qdev property for TLS options handling via '-global migration'
> > + * command line.
> > + */
> 
> Looks like this was a function comment.  It's not, it applies to the
> PropertyInfo and its method.  Move it to the PropertyInfo?
> 
> Maybe
> 
>    /*
>     * String property like qdev_prop_string, except it's backed by a
>     * StrOrNull * instead of a char *.  This is intended for
>     * TYPE_MIGRATION's TLS options.
>     */
> 
> > +static void set_StrOrNull(Object *obj, Visitor *v, const char *name,
> > +                          void *opaque, Error **errp)
> > +{
> > +    const Property *prop = opaque;
> > +    StrOrNull **ptr = object_field_prop_ptr(obj, prop);
> > +    StrOrNull *str_or_null = g_new0(StrOrNull, 1);
> > +
> > +    /*
> > +     * Only str to keep compatibility, QNULL was never used via
> > +     * command line.
> > +     */
> > +    str_or_null->type = QTYPE_QSTRING;
> > +    if (!visit_type_str(v, name, &str_or_null->u.s, errp)) {
> > +        return;
> > +    }
> > +
> > +    qapi_free_StrOrNull(*ptr);
> > +    *ptr = str_or_null;
> > +}
> > +
> > +static void release_StrOrNull(Object *obj, const char *name, void *opaque)
> > +{
> > +    const Property *prop = opaque;
> > +    qapi_free_StrOrNull(*(StrOrNull **)object_field_prop_ptr(obj, prop));
> > +}
> > +
> > +static void set_default_value_tls_opt(ObjectProperty *op, const Property *prop)
> > +{
> > +    object_property_set_default_str(op, "");
> > +}
> > +
> > +const PropertyInfo qdev_prop_StrOrNull = {
> > +    .type  = "StrOrNull",
> > +    .set = set_StrOrNull,
> > +    .release = release_StrOrNull,
> > +    .set_default_value = set_default_value_tls_opt,
> > +};
> 
> No getter, i.e. properties will be write-only.  This is unusual.  Is it
> safe?

Fair question..

I had a quick look, device_class_set_props_n() will try to register the
prop with legacy mode first then modern mode.  Legacy mode is decided by
[1] below:

static void qdev_class_add_legacy_property(DeviceClass *dc, const Property *prop)
{
    g_autofree char *name = NULL;

    /* Register pointer properties as legacy properties */
    if (!prop->info->print && prop->info->get) { <------------------ [1]
        return;
    }

    name = g_strdup_printf("legacy-%s", prop->name);
    object_class_property_add(OBJECT_CLASS(dc), name, "str",
        prop->info->print ? qdev_get_legacy_property : prop->info->get,
        NULL, NULL, (Property *)prop);
}

When with no get(), it seems it'll be wrongly treated as legacy property..
which further means whoever tries to get() on the property will invoke
qdev_get_legacy_property(), and likely crash on accessing info->print()..

The other issue is legacy property doesn't look like to provide a setter
function.. as it's passing NULL to object_class_property_add(set=XXX).

Likely we'll need to provide get() if without changing qdev code.

> 
> > +
> >  bool migrate_auto_converge(void)
> >  {
> >      MigrationState *s = migrate_get_current();
> 

-- 
Peter Xu


