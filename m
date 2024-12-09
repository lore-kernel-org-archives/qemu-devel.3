Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 042F4E7717D
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2024 20:56:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKknk-0007AI-MB; Mon, 09 Dec 2024 15:56:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tKkni-00072s-UI
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 15:56:18 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tKknh-00056b-G9
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 15:56:18 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 001B621160;
 Mon,  9 Dec 2024 20:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1733777776; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PIxO94mbL+2zIie3MWQXfyi9U4gIDYk6LId1H78G+WA=;
 b=Sa0+OyHFGtNPoOM0nbgTtkKS6b90nHa/GxRr7/6utglUsPzN5EjgXTvgDsz6JWvMBiUal2
 oDrSFzpawEgOdW36RYRg8hrx1QFx8eW5w7Du81T7pBxkJzBcMXD5Asac3cFYY1sRDulwwm
 uuKGn+TI7w8N/eJKQD370skVyRYf8DE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1733777776;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PIxO94mbL+2zIie3MWQXfyi9U4gIDYk6LId1H78G+WA=;
 b=AukuxWYc+G0GVa/I+DqmNF3ACDgM6pRUONT6xD7bgTI1gmg2qQVQUtYSJuetuMgnLZD1jX
 KYzVQ/6YYudG6gCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1733777776; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PIxO94mbL+2zIie3MWQXfyi9U4gIDYk6LId1H78G+WA=;
 b=Sa0+OyHFGtNPoOM0nbgTtkKS6b90nHa/GxRr7/6utglUsPzN5EjgXTvgDsz6JWvMBiUal2
 oDrSFzpawEgOdW36RYRg8hrx1QFx8eW5w7Du81T7pBxkJzBcMXD5Asac3cFYY1sRDulwwm
 uuKGn+TI7w8N/eJKQD370skVyRYf8DE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1733777776;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PIxO94mbL+2zIie3MWQXfyi9U4gIDYk6LId1H78G+WA=;
 b=AukuxWYc+G0GVa/I+DqmNF3ACDgM6pRUONT6xD7bgTI1gmg2qQVQUtYSJuetuMgnLZD1jX
 KYzVQ/6YYudG6gCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7969B138D2;
 Mon,  9 Dec 2024 20:56:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id PYioD29ZV2dtcgAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 09 Dec 2024 20:56:15 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Prasad Pandit <ppandit@redhat.com>, "Maciej S . Szmigiero"
 <mail@maciej.szmigiero.name>, =?utf-8?Q?C=C3=A9dric?= Le Goater
 <clg@redhat.com>, Alex
 Williamson <alex.williamson@redhat.com>, peterx@redhat.com, Avihai Horon
 <avihaih@nvidia.com>
Subject: Re: [PATCH v3 7/7] migration/multifd: Document the reason to sync
 for save_setup()
In-Reply-To: <20241206224755.1108686-8-peterx@redhat.com>
References: <20241206224755.1108686-1-peterx@redhat.com>
 <20241206224755.1108686-8-peterx@redhat.com>
Date: Mon, 09 Dec 2024 17:56:12 -0300
Message-ID: <87r06ga843.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_SEVEN(0.00)[8]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

> It's not straightforward to see why src QEMU needs to sync multifd during
> setup() phase.  After all, there's no page queued at that point.
>
> For old QEMUs, there's a solid reason: EOS requires it to work.  While it's
> clueless on the new QEMUs which do not take EOS message as sync requests.
>
> One will figure that out only when this is conditionally removed.  In fact,
> the author did try it out.  Logically we could still avoid doing this on
> new machine types, however that needs a separate compat field and that can
> be an overkill in some trivial overhead in setup() phase.
>
> Let's instead document it completely, to avoid someone else tries this
> again and do the debug one more time, or anyone confused on why this ever
> existed.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Fabiano Rosas <farosas@suse.de>

