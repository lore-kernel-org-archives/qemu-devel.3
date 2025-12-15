Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BD8BD5B854
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Dec 2025 16:56:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVBra-0005KH-93; Mon, 15 Dec 2025 11:55:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vVBrY-0005J2-BP
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 11:55:56 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vVBrV-0002tY-A8
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 11:55:56 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id CDA1133779;
 Mon, 15 Dec 2025 16:55:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1765817749; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OFx5Yv18boTD5jupFtTGf5ZCHMwFSe+FiEPGzRmX7y0=;
 b=tTXFHZkMKhakudj6I3kWgoVMh4r3lmxeKUqnm7dESr4Wl8uMZ/l41rDTGZX0ZJYBi6Pu+f
 oJMAUe5svSmP3+yq9AlOMyt5Wyux564hO3WmE7MymsgypizOKpZwl7yJcnSiQW3GYUxNpo
 Pto/8xciQ2IA/WuiNns4jxKBQZD5DOg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1765817749;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OFx5Yv18boTD5jupFtTGf5ZCHMwFSe+FiEPGzRmX7y0=;
 b=I1kwHfEJ7ljaLer9qR1ht0PNNdqIBPhPWWzlSf3RfOcyc09FZ3CIHVKUMQMQMJbRZj0Mgl
 zvWIX7Cr7XaBSwBg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="Z/1DHDGg";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=xv7uNCnP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1765817747; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OFx5Yv18boTD5jupFtTGf5ZCHMwFSe+FiEPGzRmX7y0=;
 b=Z/1DHDGgJA29T2CbhxvjCq7tcy0N4ks1d0qJln6cqaVTLf8xOMrD15EM+eXycKcaS3HZyi
 XSQJc4Ky/+W9waXVRA5UzTKsWXtOpQhFDXnj/fvLc/hA0taUim3f4IV7o1pKPJj3GPLvsM
 mchDmZht8yq4VHv9IFk2nMMPe+RYYTk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1765817747;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OFx5Yv18boTD5jupFtTGf5ZCHMwFSe+FiEPGzRmX7y0=;
 b=xv7uNCnP+Lf5otSGAk9hhS6NAQ8rwzJhLIrlPksenPs+Pfe6rDlU1stuQnSuokRWMj0xSY
 f49q+fqFHh4Ot+Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 44B573EA63;
 Mon, 15 Dec 2025 16:55:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id d0s0AZM9QGnoJgAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 15 Dec 2025 16:55:47 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: kwolf@redhat.com, thuth@redhat.com, stefanha@redhat.com,
 peterx@redhat.com, qemu-devel@nongnu.org, qemu-stable@nongnu.org
Subject: Re: [PATCH] block: Fix BDS use after free during shutdown
In-Reply-To: <20251215150714.130214-1-kwolf@redhat.com>
References: <20251215150714.130214-1-kwolf@redhat.com>
Date: Mon, 15 Dec 2025 13:55:44 -0300
Message-ID: <87h5trvg4v.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: CDA1133779
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+]; FROM_HAS_DN(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_TLS_ALL(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
 RCPT_COUNT_SEVEN(0.00)[8]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid, suse.de:dkim, suse.de:email,
 imap1.dmz-prg2.suse.org:rdns, imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Kevin Wolf <kwolf@redhat.com> writes:

> During shutdown, blockdev_close_all_bdrv_states() drops any block node
> references that are still owned by the monitor (i.e. the user). However,
> in doing so, it forgot to also remove the node from monitor_bdrv_states
> (which qmp_blockdev_del() correctly does), which means that later calls
> of bdrv_first()/bdrv_next() will still return the (now stale) pointer to
> the node.
>
> Usually there is no such call after this point, but in some cases it can
> happen. In the reported case, there was an ongoing migration, and the
> migration thread wasn't shut down yet: migration_shutdown() called by
> qemu_cleanup() doesn't actually wait for the migration to be shut down,
> but may just move it to MIGRATION_STATUS_CANCELLING. The next time
> migration_iteration_finish() runs, it sees the status and tries to
> re-activate all block devices that migration may have previously
> inactivated. This is where bdrv_first()/bdrv_next() get called and the
> access to the already freed node happens.
>
> It is debatable if migration_shutdown() should really return before
> migration has settled, but leaving a dangling pointer in the list of
> monitor-owned block nodes is clearly a bug either way and fixing it
> solves the immediate problem, so fix it.
>
> Cc: qemu-stable@nongnu.org
> Reported-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>

Reviewed-by: Fabiano Rosas <farosas@suse.de>

