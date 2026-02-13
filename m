Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 334A0EDF172
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Feb 2026 14:58:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqucX-0002na-OQ; Fri, 13 Feb 2026 09:58:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vqucS-0002fH-83
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 09:58:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vqucP-00036k-Np
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 09:58:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770994680;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=h2adJGsqTjd7pClxtCa9UnBhNKRL+/Mpg9BLq9H8xKI=;
 b=SKkwK3RcYdeQCFGAF7dVZbzf3h0ckg4b1TyLSnbNdyG2tLJ4xqjS+ZG3SKU30w5AUoIzzP
 cYci5diKU5VstyHGkpEcZFF9O+MKO3oPRg9nETgAH/ITaT/p/yQ8xGKlHuMxczsl0vzYUI
 aKEr8/hJIXMMvrLJnvBo6rpju7sKq5I=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-126-9kc_LXg0NpW4-_jbtOl2Vg-1; Fri,
 13 Feb 2026 09:57:58 -0500
X-MC-Unique: 9kc_LXg0NpW4-_jbtOl2Vg-1
X-Mimecast-MFC-AGG-ID: 9kc_LXg0NpW4-_jbtOl2Vg_1770994678
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A362E18004AD; Fri, 13 Feb 2026 14:57:57 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.15])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C29C21955D85; Fri, 13 Feb 2026 14:57:56 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5AA5521E692D; Fri, 13 Feb 2026 15:57:54 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,  peterx@redhat.com,  ppandit@redhat.com,  Michael
 Roth <michael.roth@amd.com>
Subject: Re: [PATCH v2 5/9] qapi: Add QAPI_MERGE
In-Reply-To: <20260202224101.20568-6-farosas@suse.de> (Fabiano Rosas's message
 of "Mon, 2 Feb 2026 19:40:57 -0300")
References: <20260202224101.20568-1-farosas@suse.de>
 <20260202224101.20568-6-farosas@suse.de>
Date: Fri, 13 Feb 2026 15:57:54 +0100
Message-ID: <871pio3d3h.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
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

> The migration subsystem currently has code to merge two objects of the
> same type. It does so by checking which fields are present in a source
> object and overwriting the corresponding fields on the destination
> object. This leads to a lot of open-coded lines such as:
>
>     if (src->has_foobar) {
>         dst->foobar = src->foobar;
>     }

It does this to update configuration.  Both the configuration and the
update is a struct MigrationParameters.  To enable update, not just
complete overwrite, the struct's members are all optional.  If update's
member is present, it replaces the configuration's member.

Note that this is a *shallow* operation.  There's no recursion.

MigrationParameters is almost flat: two members are arrays.  These
members are updated wholesale, i.e. an array is either not touched or
replaced completely.  We don't look at array elements.

> This pattern could be replaced by a copy using visitors. Implement a
> macro that extracts elements from a source object using an output
> visitor and merges it with a destination object using an input
> visitor.
>
> Acked-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  include/qapi/type-helpers.h | 40 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
>
> diff --git a/include/qapi/type-helpers.h b/include/qapi/type-helpers.h
> index fc8352cdec..f22d7b7139 100644
> --- a/include/qapi/type-helpers.h
> +++ b/include/qapi/type-helpers.h
> @@ -10,6 +10,9 @@
>   */
>  
>  #include "qapi/qapi-types-common.h"
> +#include "qapi/qobject-input-visitor.h"
> +#include "qapi/qobject-output-visitor.h"
> +#include "qapi/dealloc-visitor.h"
>  
>  HumanReadableText *human_readable_text_from_str(GString *str);
>  
> @@ -20,3 +23,40 @@ HumanReadableText *human_readable_text_from_str(GString *str);
>   * cleanup.
>   */
>  char **strv_from_str_list(const strList *list);
> +
> +/*
> + * Merge @src over @dst by copying deep clones of the present members
> + * from @src to @dst. Non-present on @src are left untouched on
> + * @dst. Pointer members that are overwritten are also freed.
> + */
> +#define QAPI_MERGE(type, dst_, src_)                                    \

The comment uses @dst and @src, the code uses dst_ and src_.  Make them
consistent, please.

> +    ({                                                                  \
> +        QObject *out_ = NULL;                                           \
> +        Visitor *v_;                                                    \
> +        /* read in from src */                                          \
> +        v_ = qobject_output_visitor_new(&out_);                         \
> +        visit_type_ ## type(v_, NULL, &src_, &error_abort);             \
> +        visit_complete(v_, &out_);                                      \
> +        visit_free(v_);                                                 \

This serializes @src_ to @out_.

> +        /*                                                              \
> +         * Free the memory for which the pointers will be overwritten   \
> +         * in the next step.                                            \
> +         */                                                             \
> +        v_ = qapi_dealloc_present_visitor_new(out_);                    \
> +        visit_start_struct(v_, NULL, NULL, 0, &error_abort);            \
> +        visit_type_ ## type ## _members(v_, dst_, &error_abort);        \
> +        visit_end_struct(v_, NULL);                                     \
> +        visit_free(v_);                                                 \

This frees members of @dst_ that are about to be overwritten, using the
dealloc present visitor from the previous patch.  Which I haven't
reviewed, yet.

> +        /*                                                              \
> +         * Write to dst but leave existing fields intact (except for    \
> +         * has_* which will be updated according to their presence in   \
> +         * src).                                                        \
> +         */                                                             \
> +        v_ = qobject_input_visitor_new(out_);                           \
> +        visit_start_struct(v_, NULL, NULL, 0, &error_abort);            \
> +        visit_type_ ## type ## _members(v_, dst_, &error_abort);        \
> +        visit_check_struct(v_, &error_abort);                           \
> +        visit_end_struct(v_, NULL);                                     \
> +        visit_free(v_);                                                 \

This deserializes @out_ into @dst_, but in an unusual way.  The usual
way would be like

           visit_start_struct(v, name, (void **)&dst_, sizeof(type),
                              &error_abort);
           visit_type_ ## type ## _members(v, dst_, &error_abort);
           visit_check_struct(v, &error_abort);
           visit_end_struct(v, (void **)&dst_);

This is code from generated visit_type_TYPE() with @obj replaced by
&dst_, @errp replaced by &error_abort, and handling now impossible
errors deleted.

There's a a small difference that doesn't actually matter:
visit_start_struct() argument @name.  visit_start_struct() ignores this
argument when visiting the root of a tree (again, see the big comment in
qapi/visitor.h).

The difference that matters follows.

The usual way passes &dst_ to visit_start_struct(), visit_end_struct(),
and dst_ to visit_type_TYPE_members().

The other usual way passes NULL to all three.  That's a virtual walk.
See also the big comment in qapi/visitor.h.

Your QAPI_MERGE() mixes the two.  Hmm.

Input visitors create new objects / work on zero-initialized objects:
visit_type_TYPE_members() with an input visitor takes a TYPE *obj
pointing to zero-initialized memory.

QAPI_MERGE() does not zero-initialize the memory it passes to the input
visitor.  It merely frees objects the input visitor is going to
overwrite.  

Memory the input visitor doesn't overwrite remains as it is.  As long as
the input visitor overwrite exactly all the member memory for each
member it actually visits, this results in a merge operation.

At this point, I have a queasy feeling in my stomach: we're upending
design assumptions.  I can't point to anything wrong, but this is risky
business.

Another observation: visitors are deep, not shallow.  What happens when
@src isn't flat?  Say it contains an array member.  The input visitor
will first replace @dst's array wholesale by @src's.  Then it'll duly
recurse into the array, and replace each of its members by itself.  I
think.  Does that work?  I hope.  Is it weird and surprising?  Yes!

> +        qobject_unref(out_);                                            \
> +    })

Could we do this in a simpler and cleaner way?

In handwritten code, we'd simply walk source and destination
simultaneously.  The visitor infrastructure doesn't let us do that; it
fundamentally walks a single object.  Perhaps we could somehow cajole it
into letting us do it.  Can't tell offhand.

We could have an input visitor that updates an existing object.  No need
for a dealloc present visitor then.  It should take care to avoid the
recursive update I called weird and surprising.

We could serialize both objects to be merged, shallowly merge the
resulting QDicts, deserialize.  One more serialize, which is expensive,
but if two expensive expensive serialize / deserialize is fine, three
should be fine, too.  No need for a dealloc present visitor then.

Thoughts?


