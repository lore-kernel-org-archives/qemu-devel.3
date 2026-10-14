Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAE1CCC6B2D
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 21:50:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xH6re-0007Me-3f; Wed, 14 Oct 2026 17:50:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1xH6rc-0007MO-3X
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 17:50:20 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1xH6rZ-0004gD-Om
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 17:50:19 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3D0701F7E4;
 Wed, 14 Oct 2026 21:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1792014616; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ys+jY6dnlbamF9CM88A8anIIEi9/fsNxo/PGu6EsOVQ=;
 b=e3R2unS9GkHccVYzj4wkjLBnHQLPxL+v+BhLkmS0SoWi1q/ymPmH7EiZs51IPeqzfbI6Lh
 c3Ro0gmotpOGI7Rm6ZlujdUtfe1PI6AnWRe4CfOMU1t+FPq4OMCFopA04i3KlxpbjIuTsm
 k4P7TmuGFdTwRza380ePvYAkig0L764=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1792014616;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ys+jY6dnlbamF9CM88A8anIIEi9/fsNxo/PGu6EsOVQ=;
 b=HQjkeegwd0LxKGKF1ej1YUBHHIqIh4aI400ov6cFOph5SQ0UmYsvBEsCXxtlcXOCIGuuSg
 Y09k2frk8iuLR1CA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=e3R2unS9;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=HQjkeegw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1792014616; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ys+jY6dnlbamF9CM88A8anIIEi9/fsNxo/PGu6EsOVQ=;
 b=e3R2unS9GkHccVYzj4wkjLBnHQLPxL+v+BhLkmS0SoWi1q/ymPmH7EiZs51IPeqzfbI6Lh
 c3Ro0gmotpOGI7Rm6ZlujdUtfe1PI6AnWRe4CfOMU1t+FPq4OMCFopA04i3KlxpbjIuTsm
 k4P7TmuGFdTwRza380ePvYAkig0L764=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1792014616;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ys+jY6dnlbamF9CM88A8anIIEi9/fsNxo/PGu6EsOVQ=;
 b=HQjkeegwd0LxKGKF1ej1YUBHHIqIh4aI400ov6cFOph5SQ0UmYsvBEsCXxtlcXOCIGuuSg
 Y09k2frk8iuLR1CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1D3A31368E;
 Wed, 14 Oct 2026 21:50:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 6KcFHxb5z2r8YAAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 14 Oct 2026 21:50:15 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: peterx@redhat.com, Akash Kulhalli <akulhall@redhat.com>, Juraj Marcin
 <jmarcin@redhat.com>
Subject: Re: [PATCH v2 2/7] migration: Add two more trace points for
 incoming channel mgmt
In-Reply-To: <20261006182046.3767283-3-peterx@redhat.com>
References: <20261006182046.3767283-1-peterx@redhat.com>
 <20261006182046.3767283-3-peterx@redhat.com>
Date: Wed, 14 Oct 2026 18:50:08 -0300
Message-ID: <87ecdslzov.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 TO_DN_SOME(0.00)[]; MISSING_XM_UA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:email,suse.de:dkim];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: 3D0701F7E4
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

> We have trace points for both multifd channel and preempt channel when a
> new channel is established on the destination, but no main channel.  We can
> normally deduce this by analyzing the socket channel tracepoints, but add
> one for debugging purpose so in a trace log we can see when all channels
> are established.
>
> Add one more for start / resume of incoming migration too.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  migration/migration.c  | 3 +++
>  migration/trace-events | 2 ++
>  2 files changed, 5 insertions(+)
>
> diff --git a/migration/migration.c b/migration/migration.c
> index fab7949fe1..3ffc0c2c6a 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -852,6 +852,7 @@ bool migration_incoming_setup(QIOChannel *ioc, uint8_t channel, Error **errp)
>          assert(!mis->from_src_file);
>          mis->from_src_file = f;
>          qemu_file_set_blocking(f, false, &error_abort);
> +        trace_migration_main_channel_received();
>          break;
>  
>      case CH_MULTIFD:
> @@ -918,6 +919,8 @@ static bool postcopy_try_recover(void)
>  
>  void migration_start_incoming(void)
>  {
> +    trace_migration_start_incoming();
> +
>      if (postcopy_try_recover()) {
>          return;
>      }
> diff --git a/migration/trace-events b/migration/trace-events
> index db911fe6f2..68bcf12dc7 100644
> --- a/migration/trace-events
> +++ b/migration/trace-events
> @@ -200,6 +200,8 @@ postcopy_preempt_enabled(bool value) "%d"
>  migration_precopy_complete(void) ""
>  migration_call_notifiers(int type) "type=%d"
>  migration_request_switchover_ack_legacy(const char *requester, unsigned int switchover_ack_pending_num_legacy) "Requester %s, switchover_ack_pending_num_legacy %u"
> +migration_main_channel_received(void) ""
> +migration_start_incoming(void) ""
>  
>  # migration-stats
>  migration_transferred_bytes(uint64_t qemu_file, uint64_t multifd, uint64_t rdma) "qemu_file %" PRIu64 " multifd %" PRIu64 " RDMA %" PRIu64

Reviewed-by: Fabiano Rosas <farosas@suse.de>

