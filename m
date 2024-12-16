Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 849C0E77180
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2024 15:18:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNCrm-0002lC-8O; Mon, 16 Dec 2024 10:18:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1tNCrT-0002Qu-7Y; Mon, 16 Dec 2024 10:18:22 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1tNCrR-0008Vq-1M; Mon, 16 Dec 2024 10:18:18 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id CD1531F37E;
 Mon, 16 Dec 2024 15:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1734362293; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dx3JBNtCpRwXxS+mFpWYWIGisgzHMGnWpej4M5ZGcvs=;
 b=wqt1mWr31UMVlJJuCSqJRdaM5Kl1buz34eI0lmoZbWOXKqy5YISBx47O/TWcSPtnIL+DOT
 XheJ5hsGK2exu/6ukVGcYIZskU606Zwf1R4P3/GKOXF+sM9bUxbD0S8zXUtIl4NuhSc2dc
 +ilj29PM9BA8McKCVbDBurW56skXKLQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1734362293;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dx3JBNtCpRwXxS+mFpWYWIGisgzHMGnWpej4M5ZGcvs=;
 b=adpJgkw+/f5zSM8Q+lFdP8+ZLjbD9qIPjHcueKoBiQ4Wr4B0CMXO+kL982u4yjzAygnak/
 Y2VBzpA7Pdh8xdBg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=qbjSvQBj;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=x5zumDXC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1734362292; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dx3JBNtCpRwXxS+mFpWYWIGisgzHMGnWpej4M5ZGcvs=;
 b=qbjSvQBjqhp/IDF/GbIIOukLTsCwQLPGvu1sYEP9W+Yp003WKcgQsV4UzDBjEVd8LknWXC
 1LfEb6q9RU/hBhxytDQ1ulBRDoEsffHE3PgS8JjrCZ5TDGuBX3w89vPWREJbxuTRhHQHYO
 b7yzw38XlAmWNN68QOIPNkJRJow2crs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1734362292;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dx3JBNtCpRwXxS+mFpWYWIGisgzHMGnWpej4M5ZGcvs=;
 b=x5zumDXCTxwHW7vBPXsRwMWU+oz2Hhh6A/aunAdkqz/5iFHq0T560nCuVhGPVv7aC0u7eQ
 lwM3DI6jJJafpMDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 543A313418;
 Mon, 16 Dec 2024 15:18:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id qNqrBrREYGcCEwAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 16 Dec 2024 15:18:12 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: peterx@redhat.com, qemu-block@nongnu.org, Vladimir Sementsov-Ogievskiy
 <vsementsov@yandex-team.ru>, Stefan Hajnoczi <stefanha@redhat.com>, Andrey
 Drobyshev <andrey.drobyshev@virtuozzo.com>, Eric Blake
 <eblake@redhat.com>, "Dr . David Alan Gilbert" <dave@treblig.org>, Kevin
 Wolf <kwolf@redhat.com>, =?utf-8?Q?Daniel_P_=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
Subject: Re: [PATCH v2 5/6] migration/block: Fix possible race with
 block_inactive
In-Reply-To: <20241206230838.1111496-6-peterx@redhat.com>
References: <20241206230838.1111496-1-peterx@redhat.com>
 <20241206230838.1111496-6-peterx@redhat.com>
Date: Mon, 16 Dec 2024 12:18:09 -0300
Message-ID: <87y10fwtam.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: CD1531F37E
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.00 / 50.00]; BAYES_HAM(-2.99)[99.94%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+]; FROM_HAS_DN(0.00)[];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCPT_COUNT_SEVEN(0.00)[11]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,
 imap1.dmz-prg2.suse.org:helo, suse.de:dkim, suse.de:mid, suse.de:email]
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

Peter Xu <peterx@redhat.com> writes:

> Src QEMU sets block_inactive=true very early before the invalidation takes
> place.  It means if something wrong happened during setting the flag but
> before reaching qemu_savevm_state_complete_precopy_non_iterable() where it
> did the invalidation work, it'll make block_inactive flag inconsistent.
>
> For example, think about when qemu_savevm_state_complete_precopy_iterable()
> can fail: it will have block_inactive set to true even if all block drives
> are active.
>
> Fix that by only update the flag after the invalidation is done.
>
> No Fixes for any commit, because it's not an issue if bdrv_activate_all()
> is re-entrant upon all-active disks - false positive block_inactive can
> bring nothing more than "trying to active the blocks but they're already
> active".  However let's still do it right to avoid the inconsistent flag
> v.s. reality.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Fabiano Rosas <farosas@suse.de>

