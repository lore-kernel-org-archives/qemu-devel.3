Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C430CD8CAD
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 23:18:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wX5i4-00077W-Pq; Tue, 09 Jun 2026 19:18:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wX5i3-00076i-Ds
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 19:18:15 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wX5i0-00068E-6r
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 19:18:14 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id AD9186AC88;
 Tue,  9 Jun 2026 23:18:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1781047089; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EOT2AH3JyT5143g21kxjfJlHLKZvETvFVsLCXIA1eBc=;
 b=wEHB6qHBaL3QE4vRC6kIrtPehzpK2KtNYL3zrJwMi1QXEwME8R0iTHctbu9nIf7z8EmCYj
 Qu/Jre4KAsbOq5TY8J0/k7VfEZy1FRDMwKECF3WccViWoP/rt1WKq5ubdR9g3RpqEK/3lB
 rldat+Ovi4lwWFfziZqm7ecLNvnxvmo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1781047089;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EOT2AH3JyT5143g21kxjfJlHLKZvETvFVsLCXIA1eBc=;
 b=CNzQ6hEkxtoTxHhxTgMVAlQp23T+RCSN9mDHvIYPntvusu/gN0nGj0iHiajv1dvXGCGy8t
 12k4O+FHtg21FTAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1781047087; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EOT2AH3JyT5143g21kxjfJlHLKZvETvFVsLCXIA1eBc=;
 b=IPDjTzG5h+tRSQxfmzm/AzJBCkQGI5H4Y0zPU53ZNeauEcK2+W6eiyNYnEUtt8eCd/D1AT
 YJT4iSR6LSNP/E2p50Z8c4mrt87WQ5QSaCRuqqL4qksS2w1saGd28qAaoxl3tytPfztuPk
 ZedLImDk5ReHc+8Gkra8xc3aZVZnwZw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1781047087;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EOT2AH3JyT5143g21kxjfJlHLKZvETvFVsLCXIA1eBc=;
 b=jV2nsHMgd9uqMDTXE3IYJ6dF5OdX17bE1OGwzyCeGxKOhWn9a64VM0ogOTB5VPNTi7mQfb
 24ab/IbVfxvgZgCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 45B6C779A7;
 Tue,  9 Jun 2026 23:18:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id tl6lBS+fKGouTQAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 09 Jun 2026 23:18:07 +0000
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
Subject: Re: [PATCH v2 06/10] qom: Add object_property_add_bool_ptr()
In-Reply-To: <20260609172514.2037645-7-peterx@redhat.com>
References: <20260609172514.2037645-1-peterx@redhat.com>
 <20260609172514.2037645-7-peterx@redhat.com>
Date: Tue, 09 Jun 2026 20:18:05 -0300
Message-ID: <87bjdj5mmq.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCPT_COUNT_TWELVE(0.00)[20]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; MISSING_XM_UA(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 URIBL_BLOCKED(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email, suse.de:mid,
 imap1.dmz-prg2.suse.org:helo]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
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

> Add a helper to set qom property via a bool pointer.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Fabiano Rosas <farosas@suse.de>

> ---
>  include/qom/object-property-ptr.h | 15 ++++++++++++
>  qom/object-property-ptr.c         | 39 +++++++++++++++++++++++++++++++
>  2 files changed, 54 insertions(+)
>
> diff --git a/include/qom/object-property-ptr.h b/include/qom/object-property-ptr.h
> index 6066c377fb..9cd8600094 100644
> --- a/include/qom/object-property-ptr.h
> +++ b/include/qom/object-property-ptr.h
> @@ -16,6 +16,21 @@ typedef enum {
>      OBJ_PROP_FLAG_READWRITE = (OBJ_PROP_FLAG_READ | OBJ_PROP_FLAG_WRITE),
>  } ObjectPropertyFlags;
>  
> +/**
> + * object_property_add_bool_ptr:
> + * @obj: the object to add a property to
> + * @name: the name of the property
> + * @v: pointer to value
> + * @flags: bitwise-or'd ObjectPropertyFlags
> + *
> + * Add a property of type 'bool' to the object.
> + *
> + * Returns: The newly added property on success, or %NULL on failure.
> + */
> +ObjectProperty *
> +object_property_add_bool_ptr(Object *obj, const char *name, const bool *v,
> +                             ObjectPropertyFlags flags);
> +
>  /**
>   * object_property_add_uint8_ptr:
>   * @obj: the object to add a property to
> diff --git a/qom/object-property-ptr.c b/qom/object-property-ptr.c
> index 02c01ed7f0..49f223da7b 100644
> --- a/qom/object-property-ptr.c
> +++ b/qom/object-property-ptr.c
> @@ -7,6 +7,26 @@
>  #include "qom/object.h"
>  #include "qapi/visitor.h"
>  
> +static void property_get_bool_ptr(Object *obj, Visitor *v, const char *name,
> +                                  void *opaque, Error **errp)
> +{
> +    bool value = *(bool *)opaque;
> +    visit_type_bool(v, name, &value, errp);
> +}
> +
> +static void property_set_bool_ptr(Object *obj, Visitor *v, const char *name,
> +                                  void *opaque, Error **errp)
> +{
> +    bool *field = opaque;
> +    bool value;
> +
> +    if (!visit_type_bool(v, name, &value, errp)) {
> +        return;
> +    }
> +
> +    *field = value;
> +}
> +
>  static void property_get_uint8_ptr(Object *obj, Visitor *v, const char *name,
>                                     void *opaque, Error **errp)
>  {
> @@ -87,6 +107,25 @@ static void property_set_uint64_ptr(Object *obj, Visitor *v, const char *name,
>      *field = value;
>  }
>  
> +ObjectProperty *
> +object_property_add_bool_ptr(Object *obj, const char *name,
> +                             const bool *v, ObjectPropertyFlags flags)
> +{
> +    ObjectPropertyAccessor *getter = NULL;
> +    ObjectPropertyAccessor *setter = NULL;
> +
> +    if ((flags & OBJ_PROP_FLAG_READ) == OBJ_PROP_FLAG_READ) {
> +        getter = property_get_bool_ptr;
> +    }
> +
> +    if ((flags & OBJ_PROP_FLAG_WRITE) == OBJ_PROP_FLAG_WRITE) {
> +        setter = property_set_bool_ptr;
> +    }
> +
> +    return object_property_add(obj, name, "bool",
> +                               getter, setter, NULL, (void *)v);
> +}
> +
>  ObjectProperty *
>  object_property_add_uint8_ptr(Object *obj, const char *name,
>                                const uint8_t *v,

