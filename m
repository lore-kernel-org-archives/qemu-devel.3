Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B857EDF159
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Feb 2026 12:40:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqsSD-0008Ee-MI; Fri, 13 Feb 2026 07:39:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vqsS8-0008EE-Fl
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 07:39:20 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vqsS6-0002M8-IG
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 07:39:20 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5D46B3E6F8;
 Fri, 13 Feb 2026 12:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1770986355; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GlLP2V6CzNvCrxRg6N8gPAMbxlCRJHWYOETnS6pDzy4=;
 b=l7NB5imGlSryqy2OOJQFnfMMOVNJ5WRv7/IL9g4Wa/Fy+y6v//0G9u9Hn6/RTs20ylezrm
 VfSWajSlh+OtkZajqYW0KyNrrNN2UIefaILetj8vMtUV8Trm3DU18zWqjT9jSEV/Q5w8pF
 f7pg+aC+cLmM/0MHZAwlY9MIhBysac0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1770986355;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GlLP2V6CzNvCrxRg6N8gPAMbxlCRJHWYOETnS6pDzy4=;
 b=INrm1nB/pQnY5EiX8WWFfzWs0ehKUf8AaqQbWCek7CMztaRnzl5dblzSIYsy+6rtIS3niP
 YsZBb3xQXQaZCbDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1770986355; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GlLP2V6CzNvCrxRg6N8gPAMbxlCRJHWYOETnS6pDzy4=;
 b=l7NB5imGlSryqy2OOJQFnfMMOVNJ5WRv7/IL9g4Wa/Fy+y6v//0G9u9Hn6/RTs20ylezrm
 VfSWajSlh+OtkZajqYW0KyNrrNN2UIefaILetj8vMtUV8Trm3DU18zWqjT9jSEV/Q5w8pF
 f7pg+aC+cLmM/0MHZAwlY9MIhBysac0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1770986355;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GlLP2V6CzNvCrxRg6N8gPAMbxlCRJHWYOETnS6pDzy4=;
 b=INrm1nB/pQnY5EiX8WWFfzWs0ehKUf8AaqQbWCek7CMztaRnzl5dblzSIYsy+6rtIS3niP
 YsZBb3xQXQaZCbDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C8B0A3EA62;
 Fri, 13 Feb 2026 12:39:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id B3VTInIbj2kMJwAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 13 Feb 2026 12:39:14 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, ppandit@redhat.com, Peter
 Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v2] migration/options: Fix leaks in StrOrNull qdev
 accessors
In-Reply-To: <875x813t7l.fsf@pond.sub.org>
References: <20260127150916.23329-1-farosas@suse.de>
 <875x813t7l.fsf@pond.sub.org>
Date: Fri, 13 Feb 2026 09:39:12 -0300
Message-ID: <87jywgn7gv.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; MISSING_XM_UA(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5]; RCVD_COUNT_TWO(0.00)[2];
 URIBL_BLOCKED(0.00)[linaro.org:email,imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
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

Markus Armbruster <armbru@redhat.com> writes:

> Fabiano Rosas <farosas@suse.de> writes:
>
>> Fix a couple of leaks detected by Coverity. Both are currently
>> harmless.
>
> Details?  See below.
>
>> - set_StrOrNull: the visitor should never fail unless there's a
>> programming error and a property of different type has been passed in.
>
> Really?  See below.
>
>> Change it to only allocate memory after the visit call has returned
>> successfully.
>>
>> - get_StrOrNull: the whole of the getter is unused, it's only purpose at
>> the moment is to provide a complete implementation of the StrOrNull
>> property. If it were used, it would always receive a non-NULL pointer
>> because this property is part of s->parameters and always initialized
>> by the setter.
>
> Which "received" pointer exactly would always be non-null?  See below.
>

Not technically "received", but derived from what has been received.

>> Assert non-NULL instead of allocating a new object.
>>
>> Fixes: CID 1643919
>> Fixes: CID 1643920
>> Reported-by: Peter Maydell <peter.maydell@linaro.org>
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> ---
>>  migration/options.c | 32 ++++++++++++++++----------------
>>  1 file changed, 16 insertions(+), 16 deletions(-)
>>
>> diff --git a/migration/options.c b/migration/options.c
>> index 1ffe85a2d8..93d11bba60 100644
>> --- a/migration/options.c
>> +++ b/migration/options.c
>> @@ -216,36 +216,36 @@ const size_t migration_properties_count = ARRAY_SIZE(migration_properties);
>>  static void get_StrOrNull(Object *obj, Visitor *v, const char *name,
>>                            void *opaque, Error **errp)
>>  {
>> -    const Property *prop = opaque;
>
> Yes, we don't actually need the variable.  However, it serves as
> documentation of what @opaque is supposed to be.
>
> For what it's worth, the property accessors defined in hw/core all
> declare the variable
>
>> -    StrOrNull **ptr = object_field_prop_ptr(obj, prop);
>> +    StrOrNull **ptr = object_field_prop_ptr(obj, opaque);
>>      StrOrNull *str_or_null = *ptr;
>>  
>> -    if (!str_or_null) {
>> -        str_or_null = g_new0(StrOrNull, 1);
>> -        str_or_null->type = QTYPE_QSTRING;
>> -        str_or_null->u.s = g_strdup("");
>
> The memory allocated here is never freed.  Harmless, because the code is
> unreachable.
>
>> -    } else {
>> -        /* the setter doesn't allow QNULL */
>> -        assert(str_or_null->type != QTYPE_QNULL);
>> -    }
>> +    /*
>> +     * The property should never be NULL because it's part of
>> +     * s->parameters and a default value is always set. It should also
>> +     * never be QNULL as the setter doesn't allow it.
>> +     */
>> +    assert(str_or_null && str_or_null->type != QTYPE_QNULL);
>
> Actually, @str_or_null cannot be null, because @obj isn't null, and
> object_field_prop_ptr(obj, prop) returns a pointer into @obj.
>

And that pointer must point to zeroes at some time. It cannot be that it
comes pre-set with the property value. I'm describing that it won't
point to zeroes anymore because the setter called from
.set_default_value will have already set that memory to some meaningful
value.

>>      visit_type_str(v, name, &str_or_null->u.s, errp);
>>  }
>>  
>>  static void set_StrOrNull(Object *obj, Visitor *v, const char *name,
>>                            void *opaque, Error **errp)
>>  {
>> -    const Property *prop = opaque;
>> -    StrOrNull **ptr = object_field_prop_ptr(obj, prop);
>> -    StrOrNull *str_or_null = g_new0(StrOrNull, 1);
>> +    StrOrNull **ptr = object_field_prop_ptr(obj, opaque);
>> +    StrOrNull *str_or_null;
>> +    char *str;
>> +
>> +    if (!visit_type_str(v, name, &str, errp)) {
>> +        return;
>> +    }
>>  
>>      /*
>>       * Only str to keep compatibility, QNULL was never used via
>>       * command line.
>>       */
>
> This comment is from Fabiano's recent commit be346eb6673 (migration: Add
> a qdev property for StrOrNull).  Fabiano, did you mean to write "Only
> StrOrNull to keep compatibility"?
>

No, it's "only str" indeed. The point is that -global tls-creds NULL was
never supported, so now that we have a property, this setter will never
create a QNULL to avoid ever passing a QNULL to code that used to
consume tls-creds and doesn't expect a QNULL value (the "compatibility"
part).

>> +    str_or_null = g_new0(StrOrNull, 1);
>>      str_or_null->type = QTYPE_QSTRING;
>> -    if (!visit_type_str(v, name, &str_or_null->u.s, errp)) {
>
> We leak @str_or_null here.  You plug the leak by delaying the allocation
> until after visit_type_str().  Good.
>
>> -        return;
>> -    }
>> +    str_or_null->u.s = str;
>>  
>>      qapi_free_StrOrNull(*ptr);
>>      *ptr = str_or_null;
>
> The function fails only when visit_type_str() fails, and
> visit_type_str() fails only when v->type_str() fails.
>
> Why are you certain it won't?

By inspection, I only see the failure points at qobject_input_type_str:

    QObject *qobj = qobject_input_get_object(qiv, name, true, errp);
    ...
    if (!qobj) {
        return false;
    }

    qstr = qobject_to(QString, qobj);
    if (!qstr) {
        error_setg(errp, "Invalid parameter type for '%s', expected: string",
                   full_name(qiv, name));
        return false;
    }

I'm relying on qdev's boilerplate not allowing incorrect invocations
from the user. If code has been written that allows the .set function to
be reached with a wrong type or a incorrect member name inside of a
struct, for instance, then I'm calling it a programming error.

