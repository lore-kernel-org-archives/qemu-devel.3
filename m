Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AAB7CD4F3C
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 07:17:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPEhd-0000yu-90; Tue, 19 May 2026 03:17:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wPEhU-0000xt-6P
 for qemu-devel@nongnu.org; Tue, 19 May 2026 03:17:12 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wPEhS-0003oL-GV
 for qemu-devel@nongnu.org; Tue, 19 May 2026 03:17:11 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5AF006C34A;
 Tue, 19 May 2026 07:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1779175026; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=71yO/STRNS+uea78gG/fMUwUZQvBFNSfZkyhhOhezdU=;
 b=OHQR7NAuyO4WoNhD3mucvcF9/a6MXeEvyVduK3olbhWVoEEFGHBEiPPsGtgzBfrYXzrNuQ
 20D6ebZJqkVBtjCi73GDCRLNT9vrzVjLJJdYp8DHfbwLnLVEvBgXzPU8xwRNz5Hq13xuzR
 lD/9bq1DNPtT87twYPCgg+pjQQTTWZk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1779175026;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=71yO/STRNS+uea78gG/fMUwUZQvBFNSfZkyhhOhezdU=;
 b=47C3Dr3PD26rlLZzHqvelmvC3SXo6Zi+DqgTCc+YnVltqem92lJ8IrzLbY/vqOY5VZ8ipG
 ss+o+qU2YP4dIvBg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=OHQR7NAu;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=47C3Dr3P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1779175026; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=71yO/STRNS+uea78gG/fMUwUZQvBFNSfZkyhhOhezdU=;
 b=OHQR7NAuyO4WoNhD3mucvcF9/a6MXeEvyVduK3olbhWVoEEFGHBEiPPsGtgzBfrYXzrNuQ
 20D6ebZJqkVBtjCi73GDCRLNT9vrzVjLJJdYp8DHfbwLnLVEvBgXzPU8xwRNz5Hq13xuzR
 lD/9bq1DNPtT87twYPCgg+pjQQTTWZk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1779175026;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=71yO/STRNS+uea78gG/fMUwUZQvBFNSfZkyhhOhezdU=;
 b=47C3Dr3PD26rlLZzHqvelmvC3SXo6Zi+DqgTCc+YnVltqem92lJ8IrzLbY/vqOY5VZ8ipG
 ss+o+qU2YP4dIvBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F04E6593A8;
 Tue, 19 May 2026 07:17:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id YnTLL3EODGoqRQAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 19 May 2026 07:17:05 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Bin Guo <guobin@linux.alibaba.com>, qemu-devel@nongnu.org
Cc: peterx@redhat.com
Subject: Re: [PATCH 8/8] migration/multifd: cache channel count in
 multifd_send_sync_main
In-Reply-To: <20260518110112.21395-9-guobin@linux.alibaba.com>
References: <20260518110112.21395-1-guobin@linux.alibaba.com>
 <20260518110112.21395-9-guobin@linux.alibaba.com>
Date: Tue, 19 May 2026 04:17:03 -0300
Message-ID: <87v7cj3m34.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_TLS_ALL(0.00)[]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: 5AF006C34A
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
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

Bin Guo <guobin@linux.alibaba.com> writes:

> multifd_send_sync_main() is called once per RAM synchronization round
> during live migration.  It iterates over all multifd channels twice
> (signal loop + wait loop), calling migrate_multifd_channels()
> independently in each loop header.
>
> Cache migrate_multifd_channels() in a local thread_count variable at
> function entry, matching the pattern already used in
> multifd_send_setup() and multifd_recv_setup().  This eliminates 2
> redundant config lookups per sync call.
>
> Signed-off-by: Bin Guo <guobin@linux.alibaba.com>
> ---
>  migration/multifd.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/migration/multifd.c b/migration/multifd.c
> index cc2fa90204..bc8aacd660 100644
> --- a/migration/multifd.c
> +++ b/migration/multifd.c
> @@ -611,13 +611,15 @@ static int multifd_zero_copy_flush(QIOChannel *c)
>  int multifd_send_sync_main(MultiFDSyncReq req)
>  {
>      int i;
> +    int thread_count;
>      bool flush_zero_copy;
>  
>      assert(req != MULTIFD_SYNC_NONE);
>  
> +    thread_count = migrate_multifd_channels();
>      flush_zero_copy = migrate_zero_copy_send();
>  
> -    for (i = 0; i < migrate_multifd_channels(); i++) {
> +    for (i = 0; i < thread_count; i++) {
>          MultiFDSendParams *p = &multifd_send_state->params[i];
>  
>          if (multifd_send_should_exit()) {
> @@ -634,7 +636,7 @@ int multifd_send_sync_main(MultiFDSyncReq req)
>          qatomic_set(&p->pending_sync, req);
>          qemu_sem_post(&p->sem);
>      }
> -    for (i = 0; i < migrate_multifd_channels(); i++) {
> +    for (i = 0; i < thread_count; i++) {
>          MultiFDSendParams *p = &multifd_send_state->params[i];
>  
>          if (multifd_send_should_exit()) {

Reviewed-by: Fabiano Rosas <farosas@suse.de>

