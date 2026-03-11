Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B8E11125824
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 13:59:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0K5J-0006s4-0f; Wed, 11 Mar 2026 09:58:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1w0K5D-0006nG-NG
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 09:58:45 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1w0K5C-0004bS-2e
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 09:58:43 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id BED1D5BD3F;
 Wed, 11 Mar 2026 13:58:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1773237519; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IQ7id+/4i1C5XSADsXn06ma7seuXx7smNJyjE+bwhmQ=;
 b=ajT9MWoW79nnxXwkcVUt7jbzWTgB1CeCblR63BgxKdyvddVUi0y45qWovHLeRkYjn7/LoM
 0eYYiYKuxRkHNVwigG86aQtAOh3Kxw+HkXRH+n7k3C9aguwfJNAbnFIS/zYeXn+gzB+Xhd
 TYo+i5yfbrtXWdAshe8kFjR3i7hdGcw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1773237519;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IQ7id+/4i1C5XSADsXn06ma7seuXx7smNJyjE+bwhmQ=;
 b=xdUJ6CtE8uXQ4pMCIwYkN1W/UPi+Hdz+MPIx6rhlSKd8QnaApTcDezkhOw8i4AEOQF3OJX
 uFMwSOxU2AFJ8oCQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=njQMMOKy;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=JNoh2PKx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1773237518; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IQ7id+/4i1C5XSADsXn06ma7seuXx7smNJyjE+bwhmQ=;
 b=njQMMOKy53pR+nxnYwoNJHqrsnBtHqSmx9Z2J0APMKfZ7VcqL9r8yWguutm2UREr/J7pR8
 G/v6xcKXVjrRdn2qSlRHD16WqiAFNUxMha16sUlm/cis4K+hlxv6YOQUBU/ifjfF2YPlyc
 WPLL8g+nBBkEr8Wh+eGn+7n/QsFnGsg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1773237518;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IQ7id+/4i1C5XSADsXn06ma7seuXx7smNJyjE+bwhmQ=;
 b=JNoh2PKxLAmoyV4sWAGl4AqRxwkG8gAZA6xDLFUGC310IBh5gtrp1afqNy+3ZjlgyOYvmz
 1d3sMSyj/0zemzDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 49B103FA55;
 Wed, 11 Mar 2026 13:58:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id koSoBA51sWl1eAAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 11 Mar 2026 13:58:38 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Sergei Heifetz <heifetz@yandex-team.com>, qemu-devel@nongnu.org
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Paolo
 Bonzini <pbonzini@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Peter
 Xu <peterx@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 qemu-trivial@nongnu.org, Laurent Vivier <laurent@vivier.eu>
Subject: Re: [PATCH v4 1/4] migration/savevm.c: reorder usage and assertion
 of mis->from_src_file
In-Reply-To: <20260311131522.58600-2-heifetz@yandex-team.com>
References: <20260311131522.58600-1-heifetz@yandex-team.com>
 <20260311131522.58600-2-heifetz@yandex-team.com>
Date: Wed, 11 Mar 2026 10:58:35 -0300
Message-ID: <87fr66zcvo.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MISSING_XM_UA(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_TLS_ALL(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_SEVEN(0.00)[9]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[yandex-team.com:email,suse.de:dkim,suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,vivier.eu:email];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: BED1D5BD3F
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
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

Sergei Heifetz <heifetz@yandex-team.com> writes:

> Reorder the code so the assertion of mis->from_src_file occurs before
> the call to migration_ioc_unregister_yank_from_file, which dereferences
> it in qemu_file_get_ioc.
>
> Fixes: 39675ffffb3394 ("migration: Move the yank unregister of channel_close out")
> Signed-off-by: Sergei Heifetz <heifetz@yandex-team.com>
> Reviewed-by: Laurent Vivier <laurent@vivier.eu>
> ---
>  migration/savevm.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/migration/savevm.c b/migration/savevm.c
> index 3dc812a7bbb..930a3391e35 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -2885,13 +2885,14 @@ static bool postcopy_pause_incoming(MigrationIncomingState *mis)
>  
>      assert(migrate_postcopy_ram());
>  
> +    assert(mis->from_src_file);
> +
>      /*
>       * Unregister yank with either from/to src would work, since ioc behind it
>       * is the same
>       */
>      migration_ioc_unregister_yank_from_file(mis->from_src_file);
>  
> -    assert(mis->from_src_file);
>      qemu_file_shutdown(mis->from_src_file);
>      qemu_fclose(mis->from_src_file);
>      mis->from_src_file = NULL;

Acked-by: Fabiano Rosas <farosas@suse.de>

