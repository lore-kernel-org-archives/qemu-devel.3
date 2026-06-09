Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 200A8CD8CB2
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 23:19:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wX5if-0007DX-8b; Tue, 09 Jun 2026 19:18:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wX5ia-0007BN-91
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 19:18:49 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wX5iV-0006bp-JQ
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 19:18:46 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6C37475C86;
 Tue,  9 Jun 2026 23:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1781047121; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pmMSLLZYKuSFrgW4y9eCQ2luBve/y4vsyHGWESuVdgQ=;
 b=O5JEzyzYvWuPwabBPqyaklQ1u+KVrHIEUIdM2A4UOWL3PsjwcevcFHe4EjVBDiI4kXnHFM
 xohGRG9BiVTbYpmxoosTJ3pC/7ef3XIAveJas2Vt14BUCv8mtCqufNREHq4kmZGtDK6FCV
 0QqSNgrdLjOkKxfQdx3LJQEh6YbZlYY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1781047121;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pmMSLLZYKuSFrgW4y9eCQ2luBve/y4vsyHGWESuVdgQ=;
 b=IBjOv3rB9PoUs+qcNJlp9pDgBQF/85olXUee8dnBFdR0llEnqmMESlcYgHbyqD6FMgbET6
 sFMc9SokSgI1YoAA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=O5JEzyzY;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=IBjOv3rB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1781047121; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pmMSLLZYKuSFrgW4y9eCQ2luBve/y4vsyHGWESuVdgQ=;
 b=O5JEzyzYvWuPwabBPqyaklQ1u+KVrHIEUIdM2A4UOWL3PsjwcevcFHe4EjVBDiI4kXnHFM
 xohGRG9BiVTbYpmxoosTJ3pC/7ef3XIAveJas2Vt14BUCv8mtCqufNREHq4kmZGtDK6FCV
 0QqSNgrdLjOkKxfQdx3LJQEh6YbZlYY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1781047121;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pmMSLLZYKuSFrgW4y9eCQ2luBve/y4vsyHGWESuVdgQ=;
 b=IBjOv3rB9PoUs+qcNJlp9pDgBQF/85olXUee8dnBFdR0llEnqmMESlcYgHbyqD6FMgbET6
 sFMc9SokSgI1YoAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0BC32779A7;
 Tue,  9 Jun 2026 23:18:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id JSiRM1CfKGrQTQAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 09 Jun 2026 23:18:40 +0000
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
Subject: Re: [PATCH v2 07/10] qom: Add object_property_add_size_ptr()
In-Reply-To: <20260609172514.2037645-8-peterx@redhat.com>
References: <20260609172514.2037645-1-peterx@redhat.com>
 <20260609172514.2037645-8-peterx@redhat.com>
Date: Tue, 09 Jun 2026 20:18:38 -0300
Message-ID: <878q8n5mlt.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 6C37475C86
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:email,suse.de:mid];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_TWELVE(0.00)[20];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim, suse.de:email, suse.de:mid,
 imap1.dmz-prg2.suse.org:rdns, imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

Peter Xu <peterx@redhat.com> writes:

> Add a helper to set qom property via a size pointer.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Fabiano Rosas <farosas@suse.de>

> ---
>  include/qom/object-property-ptr.h | 16 +++++++++++++
>  qom/object-property-ptr.c         | 40 +++++++++++++++++++++++++++++++
>  2 files changed, 56 insertions(+)
>
> diff --git a/include/qom/object-property-ptr.h b/include/qom/object-property-ptr.h
> index 9cd8600094..be467c64af 100644
> --- a/include/qom/object-property-ptr.h
> +++ b/include/qom/object-property-ptr.h
> @@ -115,4 +115,20 @@ ObjectProperty *object_class_property_add_uint64_ptr(ObjectClass *klass,
>                                            const uint64_t *v,
>                                            ObjectPropertyFlags flags);
>  
> +/**
> + * object_property_add_size_ptr:
> + * @obj: the object to add a property to
> + * @name: the name of the property
> + * @v: pointer to value
> + * @flags: bitwise-or'd ObjectPropertyFlags
> + *
> + * Add a property of type 'size' to the object.
> + *
> + * Returns: The newly added property on success, or %NULL on failure.
> + */
> +ObjectProperty *
> +object_property_add_size_ptr(Object *obj, const char *name,
> +                             const uint64_t *v,
> +                             ObjectPropertyFlags flags);
> +
>  #endif
> diff --git a/qom/object-property-ptr.c b/qom/object-property-ptr.c
> index 49f223da7b..21ceb2510d 100644
> --- a/qom/object-property-ptr.c
> +++ b/qom/object-property-ptr.c
> @@ -107,6 +107,26 @@ static void property_set_uint64_ptr(Object *obj, Visitor *v, const char *name,
>      *field = value;
>  }
>  
> +static void property_get_size_ptr(Object *obj, Visitor *v, const char *name,
> +                                  void *opaque, Error **errp)
> +{
> +    uint64_t value = *(uint64_t *)opaque;
> +    visit_type_size(v, name, &value, errp);
> +}
> +
> +static void property_set_size_ptr(Object *obj, Visitor *v, const char *name,
> +                                  void *opaque, Error **errp)
> +{
> +    uint64_t *field = opaque;
> +    uint64_t value;
> +
> +    if (!visit_type_size(v, name, &value, errp)) {
> +        return;
> +    }
> +
> +    *field = value;
> +}
> +
>  ObjectProperty *
>  object_property_add_bool_ptr(Object *obj, const char *name,
>                               const bool *v, ObjectPropertyFlags flags)
> @@ -285,3 +305,23 @@ object_class_property_add_uint64_ptr(ObjectClass *klass, const char *name,
>      return object_class_property_add(klass, name, "uint64",
>                                       getter, setter, NULL, (void *)v);
>  }
> +
> +ObjectProperty *
> +object_property_add_size_ptr(Object *obj, const char *name,
> +                             const uint64_t *v,
> +                             ObjectPropertyFlags flags)
> +{
> +    ObjectPropertyAccessor *getter = NULL;
> +    ObjectPropertyAccessor *setter = NULL;
> +
> +    if ((flags & OBJ_PROP_FLAG_READ) == OBJ_PROP_FLAG_READ) {
> +        getter = property_get_size_ptr;
> +    }
> +
> +    if ((flags & OBJ_PROP_FLAG_WRITE) == OBJ_PROP_FLAG_WRITE) {
> +        setter = property_set_size_ptr;
> +    }
> +
> +    return object_property_add(obj, name, "size",
> +                               getter, setter, NULL, (void *)v);
> +}

