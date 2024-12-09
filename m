Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B4E2E77181
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2024 20:52:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKkk2-0004xB-Vf; Mon, 09 Dec 2024 15:52:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tKkjw-0004wy-8N
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 15:52:24 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tKkju-0004k6-Ir
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 15:52:24 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id EEBF91F460;
 Mon,  9 Dec 2024 20:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1733777541; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1mnRHP2NZ74ehVZbdSQnRl8A7DdYpSlNGrjI19WQcyc=;
 b=A34RHFNOjzcTJadxFlJft9jQO63xuedcsF45H5tU0oTzmg0rTmkgEIgWFnlFuPaKY0rw8g
 tEl02RULDmTLiSJ7UuupS07Ah1tCAsHV1bJJrepggWmw0bVFffIF99gm+5K9JicnpZAGzs
 6+ghES68jPh6OPYZ9IPaWwpKxluRymU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1733777541;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1mnRHP2NZ74ehVZbdSQnRl8A7DdYpSlNGrjI19WQcyc=;
 b=jO/oLNI7Qt+WR+dkek1nZReZ6ucn4AxpztN5YhQfYvBi778ZjbQZkyROwHLCZzc8TYV1O9
 Zz1agd3EZYBfdBCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1733777540; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1mnRHP2NZ74ehVZbdSQnRl8A7DdYpSlNGrjI19WQcyc=;
 b=LkyCH8JfckZVqdRmFrKKcNLdgRj50JX1RDrKlwr8Hjd4d903sh1Z/TrwEw5PonEwfX6A1f
 D+rWPC+bMGj15uAS7XRPshEOcsGa3fq7uC8vqo+rZZBIygEbSezrvjg2VURmuk6/pyrVqy
 vrhxRaDLdvQe4qmZl9Qy4sXFlurL78Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1733777540;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1mnRHP2NZ74ehVZbdSQnRl8A7DdYpSlNGrjI19WQcyc=;
 b=p4RgcYLyXO38exBUvkLL+fZQBeYsLxfNo5eBrGAcakmJn7zMSfjNmzF5HwxI3FmjK/eYvZ
 oE1174QA6pQKeqCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6870A138D2;
 Mon,  9 Dec 2024 20:52:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id zzjCC4RYV2d6cQAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 09 Dec 2024 20:52:20 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Prasad Pandit <ppandit@redhat.com>, "Maciej S . Szmigiero"
 <mail@maciej.szmigiero.name>, =?utf-8?Q?C=C3=A9dric?= Le Goater
 <clg@redhat.com>, Alex
 Williamson <alex.williamson@redhat.com>, peterx@redhat.com, Avihai Horon
 <avihaih@nvidia.com>
Subject: Re: [PATCH v3 2/7] migration/multifd: Allow to sync with sender
 threads only
In-Reply-To: <20241206224755.1108686-3-peterx@redhat.com>
References: <20241206224755.1108686-1-peterx@redhat.com>
 <20241206224755.1108686-3-peterx@redhat.com>
Date: Mon, 09 Dec 2024 17:52:13 -0300
Message-ID: <87wmg8a8aq.fsf@suse.de>
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
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
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

> Teach multifd_send_sync_main() to sync with threads only.
>
> We already have such requests, which is when mapped-ram is enabled with
> multifd.  In that case, no SYNC messages will be pushed to the stream when
> multifd syncs the sender threads because there's no destination threads
> waiting for that.  The whole point of the sync is to make sure all threads
> finished their jobs.
>
> So fundamentally we have a request to do the sync in different ways:
>
>   - Either to sync the threads only,
>   - Or to sync the threads but also with the destination side.
>
> Mapped-ram did it already because of the use_packet check in the sync
> handler of the sender thread.  It works.
>
> However it may stop working when e.g. VFIO may start to reuse multifd
> channels to push device states.  In that case VFIO has similar request on
> "thread-only sync" however we can't check a flag because such sync request
> can still come from RAM which needs the on-wire notifications.
>
> Paving way for that by allowing the multifd_send_sync_main() to specify
> what kind of sync the caller needs.  We can use it for mapped-ram already.
>
> No functional change intended.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Fabiano Rosas <farosas@suse.de>

