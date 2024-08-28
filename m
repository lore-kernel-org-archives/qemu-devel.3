Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B37F1C636F0
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2024 18:47:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjNh6-00026X-Sw; Wed, 28 Aug 2024 14:47:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sjNh6-000263-3u
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 14:47:00 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sjNh4-0003HR-Ay
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 14:46:59 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 70B8421B5B;
 Wed, 28 Aug 2024 18:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1724870814; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eIjv87Co9yZpg8IKQvGR+EyBKqMB+aVtTuPwyhRhEIU=;
 b=1c6ZI7Tldk8/dSgv1cYh4mGuBg5/Xsw9wZ8vQmkGA2crcWcJ1F9kqhWxkCrpCmU5F2+poK
 vv4oxqgSTZiSMfiOyb0Eaa/FPH/siuKdJTg3QxxJ52mH3CxUZpADxfChqynPKvRvKSjiar
 EwDVIVbDGSzmKgreqA9WhkKbxEe+GQI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1724870814;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eIjv87Co9yZpg8IKQvGR+EyBKqMB+aVtTuPwyhRhEIU=;
 b=SDEaaO1iJSuek06BN3GXY2xcNkpviLSA4W9cOdUvDLdtZW5TbMgZhlG264R9DguRr0b0Y2
 SnzGJQ5L7N49grCg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=1c6ZI7Tl;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=SDEaaO1i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1724870814; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eIjv87Co9yZpg8IKQvGR+EyBKqMB+aVtTuPwyhRhEIU=;
 b=1c6ZI7Tldk8/dSgv1cYh4mGuBg5/Xsw9wZ8vQmkGA2crcWcJ1F9kqhWxkCrpCmU5F2+poK
 vv4oxqgSTZiSMfiOyb0Eaa/FPH/siuKdJTg3QxxJ52mH3CxUZpADxfChqynPKvRvKSjiar
 EwDVIVbDGSzmKgreqA9WhkKbxEe+GQI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1724870814;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eIjv87Co9yZpg8IKQvGR+EyBKqMB+aVtTuPwyhRhEIU=;
 b=SDEaaO1iJSuek06BN3GXY2xcNkpviLSA4W9cOdUvDLdtZW5TbMgZhlG264R9DguRr0b0Y2
 SnzGJQ5L7N49grCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A4CF51398F;
 Wed, 28 Aug 2024 18:46:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id lbdjGp1wz2Y0DQAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 28 Aug 2024 18:46:53 +0000
From: Fabiano Rosas <farosas@suse.de>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>, Peter Xu
 <peterx@redhat.com>
Cc: Alex Williamson <alex.williamson@redhat.com>, =?utf-8?Q?C=C3=A9dric?= Le
 Goater <clg@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster
 <armbru@redhat.com>, =?utf-8?Q?Daniel_P_=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Avihai
 Horon <avihaih@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v2 02/17] migration/ram: Add load start trace event
In-Reply-To: <3e6af826a953ac88765064620d92b3797ea743f9.1724701542.git.maciej.szmigiero@oracle.com>
References: <cover.1724701542.git.maciej.szmigiero@oracle.com>
 <3e6af826a953ac88765064620d92b3797ea743f9.1724701542.git.maciej.szmigiero@oracle.com>
Date: Wed, 28 Aug 2024 15:44:35 -0300
Message-ID: <87ttf4o5bg.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 70B8421B5B
X-Spamd-Result: default: False [-4.35 / 50.00]; BAYES_HAM(-2.84)[99.32%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MISSING_XM_UA(0.00)[]; RCPT_COUNT_SEVEN(0.00)[10];
 MIME_TRACE(0.00)[0:+]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
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
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

"Maciej S. Szmigiero" <mail@maciej.szmigiero.name> writes:

> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
>
> There's a RAM load complete trace event but there wasn't its start equivalent.
>
> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
> ---
>  migration/ram.c        | 1 +
>  migration/trace-events | 1 +
>  2 files changed, 2 insertions(+)
>
> diff --git a/migration/ram.c b/migration/ram.c
> index 67ca3d5d51a1..7997bd830b9c 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -4127,6 +4127,7 @@ static int ram_load_precopy(QEMUFile *f)
>                            RAM_SAVE_FLAG_ZERO);
>      }
>  
> +    trace_ram_load_start();

This would fit better at ram_load() paired with trace_ram_load_complete(), no?

>      while (!ret && !(flags & RAM_SAVE_FLAG_EOS)) {
>          ram_addr_t addr;
>          void *host = NULL, *host_bak = NULL;
> diff --git a/migration/trace-events b/migration/trace-events
> index c65902f042bd..2a99a7baaea6 100644
> --- a/migration/trace-events
> +++ b/migration/trace-events
> @@ -115,6 +115,7 @@ colo_flush_ram_cache_end(void) ""
>  save_xbzrle_page_skipping(void) ""
>  save_xbzrle_page_overflow(void) ""
>  ram_save_iterate_big_wait(uint64_t milliconds, int iterations) "big wait: %" PRIu64 " milliseconds, %d iterations"
> +ram_load_start(void) ""
>  ram_load_complete(int ret, uint64_t seq_iter) "exit_code %d seq iteration %" PRIu64
>  ram_write_tracking_ramblock_start(const char *block_id, size_t page_size, void *addr, size_t length) "%s: page_size: %zu addr: %p length: %zu"
>  ram_write_tracking_ramblock_stop(const char *block_id, size_t page_size, void *addr, size_t length) "%s: page_size: %zu addr: %p length: %zu"

