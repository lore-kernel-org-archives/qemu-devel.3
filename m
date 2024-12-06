Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2A2BE77173
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 13:18:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJYDJ-0001hc-Uu; Fri, 06 Dec 2024 08:17:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tJYD8-0001ex-P1
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 08:17:36 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tJYD6-0007tL-UG
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 08:17:34 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id DBFCC21193;
 Fri,  6 Dec 2024 13:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1733491046; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wmRRNW334KZqiV+PVxxYQCtkHi/ootEuCElP8GJyh10=;
 b=0oJUKh8Wy3+ZeGmRHRUdHEdNxc5eNaxJ87Kw29ki+0dQ1nYo+75aAr+alE4E0EoI/iZ9ip
 bOZ1s/mI8I09rb+aaRTHPXMZAEyEIXnrFskYsZbMwN3zek7qE1ZoB35cvHBRglNO2S416/
 WjygTBreUeShvArUziDBn5RpQOeYc50=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1733491046;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wmRRNW334KZqiV+PVxxYQCtkHi/ootEuCElP8GJyh10=;
 b=Rlm/FQjLkYt/R1wS5Q6Fx25b9xT+AoT13geadbyzoSQMSBAtRhbDa9INICl5+3X9E9guzL
 Kz6d+8A+ri1P1XAw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=yRIyfoTG;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=N6nsYdb2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1733491045; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wmRRNW334KZqiV+PVxxYQCtkHi/ootEuCElP8GJyh10=;
 b=yRIyfoTGaOPieJ4/ICDVtMug/gxSo7k325SVdfSDwSjml76VwDzaJ7P/FYpO2gbBBaPgUk
 f3Hv9UXyiwcs01+vloZDcpfFlVA+QK07bPznJBeXz7ZGkLz465Twil48afyq+3nsbekCwm
 5HHmmR/ZlHHRXYkNv0S6vMca6jv/FSE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1733491045;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wmRRNW334KZqiV+PVxxYQCtkHi/ootEuCElP8GJyh10=;
 b=N6nsYdb2WCXEnbxHdue3AIHbt3nRVrk9bHydSUApfP5IqND/HC2PMlJuQ7Dy3ijilU4cV+
 aabpRDXs68EQ1sBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5893713647;
 Fri,  6 Dec 2024 13:17:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id U1DGB2X5UmeiUwAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 06 Dec 2024 13:17:25 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>, peterx@redhat.com,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>, Avihai Horon
 <avihaih@nvidia.com>, Alex
 Williamson <alex.williamson@redhat.com>, Prasad Pandit <ppandit@redhat.com>
Subject: Re: [PATCH v2 1/7] migration/multifd: Further remove the SYNC on
 complete
In-Reply-To: <20241206005834.1050905-2-peterx@redhat.com>
References: <20241206005834.1050905-1-peterx@redhat.com>
 <20241206005834.1050905-2-peterx@redhat.com>
Date: Fri, 06 Dec 2024 10:17:22 -0300
Message-ID: <87a5d9c5nh.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: DBFCC21193
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MISSING_XM_UA(0.00)[]; RCPT_COUNT_SEVEN(0.00)[8];
 MIME_TRACE(0.00)[0:+]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,suse.de:mid];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
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

> Commit 637280aeb2 ("migration/multifd: Avoid the final FLUSH in
> complete()") removed the FLUSH operation on complete() which should avoid
> one global sync on destination side, because it's not needed.
>
> However that commit overlooked multifd_ram_flush_and_sync() part of things,
> as that's always used together with the FLUSH message on the main channel.
>
> For very old binaries (multifd_flush_after_each_section==true), that's
> still needed because each EOS received on destination will enforce
> all-channel sync once.
>
> For new binaries (multifd_flush_after_each_section==false), the flush and
> sync shouldn't be needed just like the FLUSH, with the same reasoning.
>
> Currently, on new binaries we'll still send SYNC messages on multifd
> channels, even if FLUSH is omitted at the end.  It'll make all recv threads
> hang at SYNC message.
>
> Multifd is still all working fine because luckily recv side cleanup
> code (mostly multifd_recv_sync_main()) is smart enough to make sure even if
> recv threads are stuck at SYNC it'll get kicked out.  And since this is the
> completion phase of migration, nothing else will be sent after the SYNCs.
>
> This may be needed for VFIO in the future because VFIO can have data to
> push after ram_save_complete(), hence we don't want the recv thread to be
> stuck in SYNC message. Remove this limitation will make src even slightly
> faster too to avoid some more code.
>
> Stable branches do not need this patch, as no real bug I can think of that
> will go wrong there.. so not attaching Fixes to be clear on the backport
> not needed.

You forgot my comments on the commit message, so here's a brand-new one
with some things spelt out more explicitly:

--
Commit 637280aeb2 ("migration/multifd: Avoid the final FLUSH in
complete()") stopped sending the RAM_SAVE_FLAG_MULTIFD_FLUSH flag at
ram_save_complete(), because the sync on the destination side is not
needed due to the last iteration of find_dirty_block() having already
done it.

However, that commit overlooked that multifd_ram_flush_and_sync() on the
source side is also not needed at ram_save_complete(), for the same
reason.

Moreover, removing the RAM_SAVE_FLAG_MULTIFD_FLUSH but keeping the
multifd_ram_flush_and_sync() means that currently the recv threads will
hang when receiving the MULTIFD_FLAG_SYNC message, waiting for the
destination sync which only happens when RAM_SAVE_FLAG_MULTIFD_FLUSH is
received.

Luckily, multifd is still all working fine because recv side cleanup
code (mostly multifd_recv_sync_main()) is smart enough to make sure even
if recv threads are stuck at SYNC it'll get kicked out. And since this
is the completion phase of migration, nothing else will be sent after
the SYNCs.

This needs to be fixed because in the future VFIO will have data to push
after ram_save_complete() and we don't want the recv thread to be stuck
in the MULTIFD_FLAG_SYNC message.

Remove the unnecessary (and buggy) invocation of
multifd_ram_flush_and_sync().

For very old binaries (multifd_flush_after_each_section==true), the
flush_and_sync is still needed because each EOS received on destination
will enforce all-channel sync once.

Stable branches do not need this patch, as no real bug I can think of
that will go wrong there.. so not attaching Fixes to be clear on the
backport not needed.

Signed-off-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>

> ---
>  migration/ram.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
>
> diff --git a/migration/ram.c b/migration/ram.c
> index 05ff9eb328..7284c34bd8 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -3283,9 +3283,16 @@ static int ram_save_complete(QEMUFile *f, void *opaque)
>          }
>      }
>  
> -    ret = multifd_ram_flush_and_sync();
> -    if (ret < 0) {
> -        return ret;
> +    if (migrate_multifd() &&
> +        migrate_multifd_flush_after_each_section()) {
> +        /*
> +         * Only the old dest QEMU will need this sync, because each EOS
> +         * will require one SYNC message on each channel.
> +         */
> +        ret = multifd_ram_flush_and_sync();
> +        if (ret < 0) {
> +            return ret;
> +        }
>      }
>  
>      if (migrate_mapped_ram()) {

