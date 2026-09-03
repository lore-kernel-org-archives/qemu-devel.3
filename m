Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAC77C624A4
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 17:42:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2BRs-0004XZ-VB; Thu, 03 Sep 2026 13:42:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1x2BRr-0004XR-4Q
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 13:42:03 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1x2BRp-0004WJ-NU
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 13:42:02 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E2FAF2209B;
 Thu,  3 Sep 2026 17:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788457316; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4h3sycDbC6rsj8GZmJ/dIlXp733IZUbqlKCEuJMlSdc=;
 b=wllFdeWDzt5MqDxvGr/VcfLtfdMwbnlvoUwq9BsFZCVHo82pWCg8xglp6CU0UGjSjpCxKH
 03ko03/5XjgUq+SxhFWCME4QU8Yte/3unp6GKQQPH0CBVeFnkzgEaa9wUhVCYyGKsrU65e
 wJgs0Zq6tK/lQ7RU6oWLUFnoNscL43I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788457316;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4h3sycDbC6rsj8GZmJ/dIlXp733IZUbqlKCEuJMlSdc=;
 b=RKqyeZA+7haoCb49rs7yUF56/j61LKv0hNFLTa1UcD+/cQlRLQzSgktT6j8ZNlwrYiII76
 caEB0glSK040C7CQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788457311; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4h3sycDbC6rsj8GZmJ/dIlXp733IZUbqlKCEuJMlSdc=;
 b=qgersQAVeRQqBJuQyz7w0pleJqdhrQ2vh2We8reS81ZJHcSJLpkwHsc+gV1/sKPLrAPs6l
 K5c/7kD8J65sWZR0eIhRzdjVaM7BDe+Yi76rzRF+2zMTznzcrb5AQ4h8mQq/PpYu8V//4v
 3qy19k1BKxS0GedXDkZ0RDkxHWyUShk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788457311;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4h3sycDbC6rsj8GZmJ/dIlXp733IZUbqlKCEuJMlSdc=;
 b=Y2h/i8FGnZPFyXIWrJg8x/D7thtD9igW7oahwjIlx+GaD5EzYo0U2+Sow5YCjhRKm0drHv
 OXG5LI63QGwzokCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6C7B3136E6;
 Thu,  3 Sep 2026 17:41:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id qLW/D1+xmWqBVAAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 03 Sep 2026 17:41:51 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>, peterx@redhat.com
Cc: qemu-devel@nongnu.org, vsementsov@yandex-team.ru
Subject: Re: [PATCH 28/30] migration/vmstate-types: convert
 vmstate_info_g_byte_array to new APIs
In-Reply-To: <20260825213811.3725682-29-vsementsov@yandex-team.ru>
References: <20260825213811.3725682-1-vsementsov@yandex-team.ru>
 <20260825213811.3725682-29-vsementsov@yandex-team.ru>
Date: Thu, 03 Sep 2026 14:41:48 -0300
Message-ID: <87ecfa8c6b.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email, suse.de:mid,
 imap1.dmz-prg2.suse.org:helo, yandex-team.ru:email]
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

Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:

> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>  migration/vmstate-types.c | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
>
> diff --git a/migration/vmstate-types.c b/migration/vmstate-types.c
> index 8c01215c251..c2d4645f317 100644
> --- a/migration/vmstate-types.c
> +++ b/migration/vmstate-types.c
> @@ -925,30 +925,31 @@ const VMStateInfo vmstate_info_qlist = {
>      .save = save_qlist,
>  };
>  
> -static int get_g_byte_array(QEMUFile *f, void *pv, size_t size,
> -                            const VMStateField *field)
> +static bool load_g_byte_array(QEMUFile *f, void *pv, size_t size,
> +                              const VMStateField *field, Error **errp)
>  {
>      GByteArray *byte_array = *(GByteArray **)pv;
>      uint32_t len = qemu_get_be32(f);
>  
>      g_byte_array_set_size(byte_array, len);
>      qemu_get_buffer(f, byte_array->data, len);
> -    return 0;
> +    return true;
>  }
>  
> -static int put_g_byte_array(QEMUFile *f, void *pv, size_t size,
> -                            const VMStateField *field, JSONWriter *vmdesc)
> +static bool save_g_byte_array(QEMUFile *f, void *pv, size_t size,
> +                              const VMStateField *field, JSONWriter *vmdesc,
> +                              Error **errp)
>  {
>      GByteArray *byte_array = *(GByteArray **)pv;
>  
>      qemu_put_be32(f, byte_array->len);
>      qemu_put_buffer(f, byte_array->data, byte_array->len);
>  
> -    return 0;
> +    return true;
>  }
>  
>  const VMStateInfo vmstate_info_g_byte_array = {
>      .name = "GByteArray",
> -    .get  = get_g_byte_array,
> -    .put  = put_g_byte_array,
> +    .load = load_g_byte_array,
> +    .save = save_g_byte_array,
>  };

Reviewed-by: Fabiano Rosas <farosas@suse.de>

