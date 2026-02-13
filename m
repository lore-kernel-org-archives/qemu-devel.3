Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56E01EF48F9
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Feb 2026 09:10:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqpBa-0006Re-5y; Fri, 13 Feb 2026 04:10:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vqpBZ-0006RF-5r
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 04:10:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vqpBX-00067O-H0
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 04:10:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770973798;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=laVYpGrke8Zzqw6xOnom2CgAbYlQ9QFBRUDcMaxp5IE=;
 b=W41jInTBohc/wwyw5EWmX/LsJHeDHcSYBYnYg5l6fwnzA0V4nVcq0xUaWaBOYVDcfg4yEo
 8eUP8qnBt0BOJEzLwjSRro5XdB8PXwYtfaSYHoxSYS+hkJw0NHGKCQb86txGYt50djxTB0
 nB9VbmDYsttJSqMeMSF//aGA4dMcnww=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-422-w-UTZsqXMrORl-IA9icifw-1; Fri,
 13 Feb 2026 04:09:54 -0500
X-MC-Unique: w-UTZsqXMrORl-IA9icifw-1
X-Mimecast-MFC-AGG-ID: w-UTZsqXMrORl-IA9icifw_1770973793
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F00FD180057E; Fri, 13 Feb 2026 09:09:52 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.15])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7D49618004AD; Fri, 13 Feb 2026 09:09:52 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 195E621E692D; Fri, 13 Feb 2026 10:09:50 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,  peterx@redhat.com,  ppandit@redhat.com,  Peter
 Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v2] migration/options: Fix leaks in StrOrNull qdev
 accessors
In-Reply-To: <20260127150916.23329-1-farosas@suse.de> (Fabiano Rosas's message
 of "Tue, 27 Jan 2026 12:09:16 -0300")
References: <20260127150916.23329-1-farosas@suse.de>
Date: Fri, 13 Feb 2026 10:09:50 +0100
Message-ID: <875x813t7l.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

> Fix a couple of leaks detected by Coverity. Both are currently
> harmless.

Details?  See below.

> - set_StrOrNull: the visitor should never fail unless there's a
> programming error and a property of different type has been passed in.

Really?  See below.

> Change it to only allocate memory after the visit call has returned
> successfully.
>
> - get_StrOrNull: the whole of the getter is unused, it's only purpose at
> the moment is to provide a complete implementation of the StrOrNull
> property. If it were used, it would always receive a non-NULL pointer
> because this property is part of s->parameters and always initialized
> by the setter.

Which "received" pointer exactly would always be non-null?  See below.

> Assert non-NULL instead of allocating a new object.
>
> Fixes: CID 1643919
> Fixes: CID 1643920
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  migration/options.c | 32 ++++++++++++++++----------------
>  1 file changed, 16 insertions(+), 16 deletions(-)
>
> diff --git a/migration/options.c b/migration/options.c
> index 1ffe85a2d8..93d11bba60 100644
> --- a/migration/options.c
> +++ b/migration/options.c
> @@ -216,36 +216,36 @@ const size_t migration_properties_count = ARRAY_SIZE(migration_properties);
>  static void get_StrOrNull(Object *obj, Visitor *v, const char *name,
>                            void *opaque, Error **errp)
>  {
> -    const Property *prop = opaque;

Yes, we don't actually need the variable.  However, it serves as
documentation of what @opaque is supposed to be.

For what it's worth, the property accessors defined in hw/core all
declare the variable

> -    StrOrNull **ptr = object_field_prop_ptr(obj, prop);
> +    StrOrNull **ptr = object_field_prop_ptr(obj, opaque);
>      StrOrNull *str_or_null = *ptr;
>  
> -    if (!str_or_null) {
> -        str_or_null = g_new0(StrOrNull, 1);
> -        str_or_null->type = QTYPE_QSTRING;
> -        str_or_null->u.s = g_strdup("");

The memory allocated here is never freed.  Harmless, because the code is
unreachable.

> -    } else {
> -        /* the setter doesn't allow QNULL */
> -        assert(str_or_null->type != QTYPE_QNULL);
> -    }
> +    /*
> +     * The property should never be NULL because it's part of
> +     * s->parameters and a default value is always set. It should also
> +     * never be QNULL as the setter doesn't allow it.
> +     */
> +    assert(str_or_null && str_or_null->type != QTYPE_QNULL);

Actually, @str_or_null cannot be null, because @obj isn't null, and
object_field_prop_ptr(obj, prop) returns a pointer into @obj.

>      visit_type_str(v, name, &str_or_null->u.s, errp);
>  }
>  
>  static void set_StrOrNull(Object *obj, Visitor *v, const char *name,
>                            void *opaque, Error **errp)
>  {
> -    const Property *prop = opaque;
> -    StrOrNull **ptr = object_field_prop_ptr(obj, prop);
> -    StrOrNull *str_or_null = g_new0(StrOrNull, 1);
> +    StrOrNull **ptr = object_field_prop_ptr(obj, opaque);
> +    StrOrNull *str_or_null;
> +    char *str;
> +
> +    if (!visit_type_str(v, name, &str, errp)) {
> +        return;
> +    }
>  
>      /*
>       * Only str to keep compatibility, QNULL was never used via
>       * command line.
>       */

This comment is from Fabiano's recent commit be346eb6673 (migration: Add
a qdev property for StrOrNull).  Fabiano, did you mean to write "Only
StrOrNull to keep compatibility"?

> +    str_or_null = g_new0(StrOrNull, 1);
>      str_or_null->type = QTYPE_QSTRING;
> -    if (!visit_type_str(v, name, &str_or_null->u.s, errp)) {

We leak @str_or_null here.  You plug the leak by delaying the allocation
until after visit_type_str().  Good.

> -        return;
> -    }
> +    str_or_null->u.s = str;
>  
>      qapi_free_StrOrNull(*ptr);
>      *ptr = str_or_null;

The function fails only when visit_type_str() fails, and
visit_type_str() fails only when v->type_str() fails.

Why are you certain it won't?


