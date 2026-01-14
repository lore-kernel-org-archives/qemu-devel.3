Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0CB8D29FF7
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Jan 2026 12:33:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vg047-0007PP-0b; Wed, 14 Jan 2026 07:33:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vg03i-0007DA-I7
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 07:33:16 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vg03g-00043X-QO
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 07:33:10 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 2F3AC5C5CB;
 Wed, 14 Jan 2026 12:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1768393987; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=T+bEQW588LGPPmIIvqpMNUdCDuDK7AVUk23vz5XhzIE=;
 b=TvBpw3HwdMrJICMeD8WFwfRbyvLKN2siZwvdz4JoKFpJb9lkSVRMyt589AHAQaC7/XWhUB
 sKzFdW6VJmQNz779Img00e9bG+4Hd59+LXhAVW97qa7MZt0f4Um5WEU1c4L5nrUVxkrR9s
 0yEA8dzVhV7xxoGpS5ZX8woq3aN+dfg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1768393987;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=T+bEQW588LGPPmIIvqpMNUdCDuDK7AVUk23vz5XhzIE=;
 b=AH2/T4TqMqKVW9zK+0okzJlacN7jTtTyh4M7h2nlWxIltgg6ycEYEgeNjm2F8mCOICz8EI
 ASMaX4I1H/oLmiDA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=TvBpw3Hw;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="AH2/T4Tq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1768393987; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=T+bEQW588LGPPmIIvqpMNUdCDuDK7AVUk23vz5XhzIE=;
 b=TvBpw3HwdMrJICMeD8WFwfRbyvLKN2siZwvdz4JoKFpJb9lkSVRMyt589AHAQaC7/XWhUB
 sKzFdW6VJmQNz779Img00e9bG+4Hd59+LXhAVW97qa7MZt0f4Um5WEU1c4L5nrUVxkrR9s
 0yEA8dzVhV7xxoGpS5ZX8woq3aN+dfg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1768393987;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=T+bEQW588LGPPmIIvqpMNUdCDuDK7AVUk23vz5XhzIE=;
 b=AH2/T4TqMqKVW9zK+0okzJlacN7jTtTyh4M7h2nlWxIltgg6ycEYEgeNjm2F8mCOICz8EI
 ASMaX4I1H/oLmiDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A13923EA63;
 Wed, 14 Jan 2026 12:33:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 7hw2GAKNZ2neUAAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 14 Jan 2026 12:33:06 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>, peterx@redhat.com
Cc: qemu-devel@nongnu.org, dtalexundeer@yandex-team.ru,
 vsementsov@yandex-team.ru, yc-core@yandex-team.ru,
 d-tatianin@yandex-team.ru
Subject: Re: [PATCH 4/5] qemu-file: qemu_file_get_fd(): check service byte
 itself
In-Reply-To: <20260114064710.176268-5-vsementsov@yandex-team.ru>
References: <20260114064710.176268-1-vsementsov@yandex-team.ru>
 <20260114064710.176268-5-vsementsov@yandex-team.ru>
Date: Wed, 14 Jan 2026 09:33:03 -0300
Message-ID: <87pl7cnzls.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 RCPT_COUNT_SEVEN(0.00)[7]; RCVD_TLS_ALL(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 2F3AC5C5CB
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

> We can check it, so, why not.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>  migration/qemu-file.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/migration/qemu-file.c b/migration/qemu-file.c
> index 3a9a0a49d4..da701d40e4 100644
> --- a/migration/qemu-file.c
> +++ b/migration/qemu-file.c
> @@ -390,13 +390,19 @@ int qemu_file_get_fd(QEMUFile *f)
>      int fd = -1;
>      FdEntry *fde;
>      Error *err = NULL;
> +    int service_byte;
>  
>      if (!f->can_pass_fd) {
>          error_setg(&err, "%s does not support fd passing", f->ioc->name);
>          goto fail;
>      }
>  
> -    qemu_get_byte(f);
> +    service_byte = qemu_get_byte(f);
> +    if (service_byte != ' ') {
> +        error_setg(&err, "%s unexpected service byte: %d(%c)", f->ioc->name,
> +                   service_byte, service_byte);
> +        goto fail;
> +    }
>  
>      fde = QTAILQ_FIRST(&f->fds);
>      if (!fde) {

Reviewed-by: Fabiano Rosas <farosas@suse.de>

