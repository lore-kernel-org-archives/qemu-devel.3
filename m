Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1FE7E7717D
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2024 20:56:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKkmy-0006IY-D7; Mon, 09 Dec 2024 15:55:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tKkmr-0006ID-UT
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 15:55:27 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tKkmq-00052S-0Y
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 15:55:25 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3C65A21157;
 Mon,  9 Dec 2024 20:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1733777722; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8RtO9ybN83q87r9PatYNUZ2QptimH6PcsJ4fcK+5mas=;
 b=j/xKJPmR1y4KXPmhO7zhuiXvYJ39efbWuNuK+4paEG06FVIS2STKAZ8svP/zgtjBhbrI8c
 LtgojAvTlco+lyXbLnp9/w7n+CqDRlxFCVW+tGtK29SGlzhY6gY6s4ZVP3ncBcESrPqbFv
 J3frzgvyLLWVfx8alPE0OvSwV4ybMcc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1733777722;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8RtO9ybN83q87r9PatYNUZ2QptimH6PcsJ4fcK+5mas=;
 b=RalaJbZLyI8q1fPoWIxXURmKpd14M3V9zWNPtKqmxp6SuxEG9n0KWGFj98MhplKZI/caRT
 oOK3Gx9dsrA9e6AQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="j/xKJPmR";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=RalaJbZL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1733777722; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8RtO9ybN83q87r9PatYNUZ2QptimH6PcsJ4fcK+5mas=;
 b=j/xKJPmR1y4KXPmhO7zhuiXvYJ39efbWuNuK+4paEG06FVIS2STKAZ8svP/zgtjBhbrI8c
 LtgojAvTlco+lyXbLnp9/w7n+CqDRlxFCVW+tGtK29SGlzhY6gY6s4ZVP3ncBcESrPqbFv
 J3frzgvyLLWVfx8alPE0OvSwV4ybMcc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1733777722;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8RtO9ybN83q87r9PatYNUZ2QptimH6PcsJ4fcK+5mas=;
 b=RalaJbZLyI8q1fPoWIxXURmKpd14M3V9zWNPtKqmxp6SuxEG9n0KWGFj98MhplKZI/caRT
 oOK3Gx9dsrA9e6AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B8B84138D2;
 Mon,  9 Dec 2024 20:55:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 7bZUHzlZV2c4cgAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 09 Dec 2024 20:55:21 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Prasad Pandit <ppandit@redhat.com>, "Maciej S . Szmigiero"
 <mail@maciej.szmigiero.name>, =?utf-8?Q?C=C3=A9dric?= Le Goater
 <clg@redhat.com>, Alex
 Williamson <alex.williamson@redhat.com>, peterx@redhat.com, Avihai Horon
 <avihaih@nvidia.com>
Subject: Re: [PATCH v3 6/7] migration/multifd: Cleanup src flushes on
 condition check
In-Reply-To: <20241206224755.1108686-7-peterx@redhat.com>
References: <20241206224755.1108686-1-peterx@redhat.com>
 <20241206224755.1108686-7-peterx@redhat.com>
Date: Mon, 09 Dec 2024 17:55:19 -0300
Message-ID: <87ttbca85k.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 3C65A21157
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+]; FROM_HAS_DN(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_SEVEN(0.00)[8]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

> The src flush condition check is over complicated, and it's getting more
> out of control if postcopy will be involved.
>
> In general, we have two modes to do the sync: legacy or modern ways.
> Legacy uses per-section flush, modern uses per-round flush.
>
> Mapped-ram always uses the modern, which is per-round.
>
> Introduce two helpers, which can greatly simplify the code, and hopefully
> make it readable again.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Fabiano Rosas <farosas@suse.de>

