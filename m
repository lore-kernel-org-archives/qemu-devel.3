Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7FA8CD8CB2
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 23:21:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wX5lD-0000dC-CN; Tue, 09 Jun 2026 19:21:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wX5lC-0000ae-3c
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 19:21:30 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wX5l9-00023o-U0
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 19:21:29 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1A9346A932;
 Tue,  9 Jun 2026 23:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1781047286; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JiQT306ZsYyNGqJaI9bEIqWY1UM6yQRkTaUZ21idcrI=;
 b=uZUMebOz6fmuBtGm4beGVRFsWS35xiPAbgK2cXLG+Mx/vGxpeQSLKLo+mIj1j/fo0DclS5
 EZHST8MfIGz9tyA4LqGsmC1QOajSNUbFmPHSHi944y8iBcVXsR3Y96vVpg9wCbvm+6Mm2f
 1pFBzIS90NOjD/V+s0xpPT0aI4qCdnM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1781047286;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JiQT306ZsYyNGqJaI9bEIqWY1UM6yQRkTaUZ21idcrI=;
 b=dUAVzg8XNicLTL76NYd8UGWBxn7tT52ReSh/PUsfp0lbQWpOdhWGV8uin6E+aJsH6UKyYx
 sBTVqne3dU+SR4DA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Qz+TqjoA;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="NwJX/2NT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1781047285; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JiQT306ZsYyNGqJaI9bEIqWY1UM6yQRkTaUZ21idcrI=;
 b=Qz+TqjoAjNVDjlSqpeKBz2g5oJIcy3joY/Vk4y7GaKxBoo6yYt09txahPu2XWL0QbkI17y
 +L44wCp8SjwAA2uWMK7yj/CKVgShQbw+fvEJYfCKkU7Otr0lRYnHM8YRLuH98veKcuG3WC
 HDjiOlZ/R+A3Q4U6FJbLNf0MSNrpzUE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1781047285;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JiQT306ZsYyNGqJaI9bEIqWY1UM6yQRkTaUZ21idcrI=;
 b=NwJX/2NT2TV3d1bL++Ya8/Epc6ihOPUUL1Mro1PrXYsZ/GsRRmQexP8p3mLjMT+MkbGRrb
 rpJrYgFTZMVZH4Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AACA1779A7;
 Tue,  9 Jun 2026 23:21:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 2AEoHvSfKGoMUAAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 09 Jun 2026 23:21:24 +0000
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
Subject: Re: [PATCH v2 08/10] qom: Add object_property_add_*_ptr_def()
In-Reply-To: <20260609172514.2037645-9-peterx@redhat.com>
References: <20260609172514.2037645-1-peterx@redhat.com>
 <20260609172514.2037645-9-peterx@redhat.com>
Date: Tue, 09 Jun 2026 20:21:18 -0300
Message-ID: <875x3r5mhd.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_TLS_ALL(0.00)[]; MISSING_XM_UA(0.00)[];
 RCPT_COUNT_TWELVE(0.00)[20]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 MID_RHS_MATCH_FROM(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:email,suse.de:dkim,suse.de:mid];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 1A9346A932
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
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

> Add sister functions for existing pointer versions, to make it even easier
> to use by:
>
> - always make properties to be rw-able
> - allowing to specify default values
> - no retcode needed (assert on failure, always)
>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  include/qom/object-property-ptr.h | 28 +++++++++++++
>  qom/object-property-ptr.c         | 67 +++++++++++++++++++++++++++++++
>  2 files changed, 95 insertions(+)
>
> diff --git a/include/qom/object-property-ptr.h b/include/qom/object-property-ptr.h
> index be467c64af..ecd6f7819b 100644
> --- a/include/qom/object-property-ptr.h
> +++ b/include/qom/object-property-ptr.h
> @@ -131,4 +131,32 @@ object_property_add_size_ptr(Object *obj, const char *name,
>                               const uint64_t *v,
>                               ObjectPropertyFlags flags);
>  
> +/*
> + * Below are sister helpers of above, except that:
> + *
> + * (1) nothing is returned
> + * (2) always make the property to be both readable and writeable
> + * (3) allow setting default value
> + *
> + * Please refer to the sister functions for the documentation.
> + */
> +void
> +object_property_add_bool_ptr_def(Object *obj, const char *name,
> +                                 const bool *v, bool def);
> +void
> +object_property_add_uint8_ptr_def(Object *obj, const char *name,
> +                                  const uint8_t *v, uint8_t def);
> +void
> +object_property_add_uint16_ptr_def(Object *obj, const char *name,
> +                                   const uint16_t *v, uint16_t def);
> +void
> +object_property_add_uint32_ptr_def(Object *obj, const char *name,
> +                                   const uint32_t *v, uint32_t def);
> +void
> +object_property_add_uint64_ptr_def(Object *obj, const char *name,
> +                                   const uint64_t *v, uint64_t def);
> +void
> +object_property_add_size_ptr_def(Object *obj, const char *name,
> +                                 const uint64_t *v, uint64_t def);
> +
>  #endif
> diff --git a/qom/object-property-ptr.c b/qom/object-property-ptr.c
> index 21ceb2510d..ae9081d2d8 100644
> --- a/qom/object-property-ptr.c
> +++ b/qom/object-property-ptr.c
> @@ -325,3 +325,70 @@ object_property_add_size_ptr(Object *obj, const char *name,
>      return object_property_add(obj, name, "size",
>                                 getter, setter, NULL, (void *)v);
>  }
> +
> +void
> +object_property_add_bool_ptr_def(Object *obj, const char *name,
> +                                 const bool *v, bool def)
> +{
> +    ObjectProperty *prop;
> +
> +    prop = object_property_add_bool_ptr(obj, name, v,
> +                                        OBJ_PROP_FLAG_READWRITE);
> +    object_property_set_default_bool(prop, def);
> +}
> +
> +
> +void
> +object_property_add_uint8_ptr_def(Object *obj, const char *name,
> +                                  const uint8_t *v, uint8_t def)
> +{
> +    ObjectProperty *prop;
> +
> +    prop = object_property_add_uint8_ptr(obj, name, v,
> +                                         OBJ_PROP_FLAG_READWRITE);
> +    object_property_set_default_uint(prop, def);
> +}
> +
> +void
> +object_property_add_uint16_ptr_def(Object *obj, const char *name,
> +                                   const uint16_t *v, uint16_t def)
> +{
> +    ObjectProperty *prop;
> +
> +    prop = object_property_add_uint16_ptr(obj, name, v,
> +                                          OBJ_PROP_FLAG_READWRITE);
> +    object_property_set_default_uint(prop, def);
> +}
> +
> +void
> +object_property_add_uint32_ptr_def(Object *obj, const char *name,
> +                                   const uint32_t *v, uint32_t def)
> +{
> +    ObjectProperty *prop;
> +
> +    prop = object_property_add_uint32_ptr(obj, name, v,
> +                                          OBJ_PROP_FLAG_READWRITE);
> +    object_property_set_default_uint(prop, def);
> +}
> +
> +void
> +object_property_add_uint64_ptr_def(Object *obj, const char *name,
> +                                   const uint64_t *v, uint64_t def)
> +{
> +    ObjectProperty *prop;
> +
> +    prop = object_property_add_uint64_ptr(obj, name, v,
> +                                          OBJ_PROP_FLAG_READWRITE);
> +    object_property_set_default_uint(prop, def);
> +}
> +
> +void
> +object_property_add_size_ptr_def(Object *obj, const char *name,
> +                                 const uint64_t *v, uint64_t def)
> +{
> +    ObjectProperty *prop;
> +
> +    prop = object_property_add_size_ptr(obj, name, v,
> +                                        OBJ_PROP_FLAG_READWRITE);
> +    object_property_set_default_uint(prop, def);
> +}

Reviewed-by: Fabiano Rosas <farosas@suse.de>

