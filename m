Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A04CBCAC59A
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Sep 2025 18:32:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uywwd-00035c-5G; Wed, 17 Sep 2025 14:31:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uywwR-000315-Ua
 for qemu-devel@nongnu.org; Wed, 17 Sep 2025 14:31:47 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uywwJ-0005Cv-Vo
 for qemu-devel@nongnu.org; Wed, 17 Sep 2025 14:31:38 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1D58F3427E;
 Wed, 17 Sep 2025 18:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1758133894; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ok+ILGtRaumCT+NLFusAgWzw7fxcCYvfMn9TZoF1ha0=;
 b=vox++VdCITE5SJPc10uU4+BJH47o71FtPmRYIYSJ+DOdbsMn02yxbR2P9bj1ftFIQhAm3/
 a4hf3eZOAS3vGPByRa/T+ZdAI/UpgHlBqUWCEke2dJTRCSq2X4hLum/X53efSrCAq7DK8B
 9mn0SPidmGiTvrNZ84i3qEZHmonGgoU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1758133894;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ok+ILGtRaumCT+NLFusAgWzw7fxcCYvfMn9TZoF1ha0=;
 b=3sBu6+yJS12HYyi2GpJZwBMkLN0brbEQunXQkmlT9iT0aCNL8ELPFEKiOLMv+WTHoDK7rR
 7R0xgBwCLs7jBPDA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=jPy1uqnc;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=LBPD91Pu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1758133893; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ok+ILGtRaumCT+NLFusAgWzw7fxcCYvfMn9TZoF1ha0=;
 b=jPy1uqncA5GFsC6DRoniKYAOWezXre1lkOjAACS3FxMLUScMTLaIe98lBCc2jnDF4KQegQ
 iA4ORCh/C1eTR02xlewISkzetMx2pmlYOMOrMXhvGFJDCU3VrGdNYbmInItrN0MQu1maWR
 S3aAvK9/CgKI1v6Ch8A3qOz2MDciyoM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1758133893;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ok+ILGtRaumCT+NLFusAgWzw7fxcCYvfMn9TZoF1ha0=;
 b=LBPD91Puh4bBXlwkL6oMexFzYvs3oI1QLwb8EhBVkmI6NYgY8+PbmrPd7arJ391wclAH+N
 dPpdo/ZM/yXVHlAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7D7091368D;
 Wed, 17 Sep 2025 18:31:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id uHDZDoT+ymgqVQAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 17 Sep 2025 18:31:32 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: "Dr . David Alan Gilbert" <dave@treblig.org>, peterx@redhat.com, Kevin
 Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?utf-8?Q?D?=
 =?utf-8?Q?aniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, Hailiang Zhang
 <zhanghailiang@xfusion.com>, Yury Kotov <yury-kotov@yandex-team.ru>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>, Prasad Pandit
 <ppandit@redhat.com>, Zhang Chen <zhangckid@gmail.com>, Li Zhijian
 <lizhijian@fujitsu.com>, Juraj Marcin <jmarcin@redhat.com>
Subject: Re: [PATCH RFC 8/9] migration/ram: Remove workaround on ram yield
 during load
In-Reply-To: <20250827205949.364606-9-peterx@redhat.com>
References: <20250827205949.364606-1-peterx@redhat.com>
 <20250827205949.364606-9-peterx@redhat.com>
Date: Wed, 17 Sep 2025 15:31:29 -0300
Message-ID: <87a52tvsla.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; RCPT_COUNT_TWELVE(0.00)[14];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_TRACE(0.00)[0:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; RCVD_TLS_ALL(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[treblig.org,redhat.com,xfusion.com,yandex-team.ru,gmail.com,fujitsu.com];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DKIM_TRACE(0.00)[suse.de:+]; MISSING_XM_UA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid, suse.de:dkim, suse.de:email,
 imap1.dmz-prg2.suse.org:helo, imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Queue-Id: 1D58F3427E
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

> This reverts e65cec5e5d97927d22b39167d3e8edeffc771788.
>
> RAM load path had a hack in the past explicitly yield the thread to the
> main coroutine when RAM load spinning in a tight loop.  Not needed now
> because precopy RAM load now happens without the main thread.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  migration/ram.c | 13 +------------
>  1 file changed, 1 insertion(+), 12 deletions(-)
>
> diff --git a/migration/ram.c b/migration/ram.c
> index 7208bc114f..2d9a6d1095 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -4168,7 +4168,7 @@ static int parse_ramblocks(QEMUFile *f, ram_addr_t total_ram_bytes)
>  static int ram_load_precopy(QEMUFile *f)
>  {
>      MigrationIncomingState *mis = migration_incoming_get_current();
> -    int flags = 0, ret = 0, invalid_flags = 0, i = 0;
> +    int flags = 0, ret = 0, invalid_flags = 0;
>  
>      if (migrate_mapped_ram()) {
>          invalid_flags |= (RAM_SAVE_FLAG_HOOK | RAM_SAVE_FLAG_MULTIFD_FLUSH |
> @@ -4181,17 +4181,6 @@ static int ram_load_precopy(QEMUFile *f)
>          void *host = NULL, *host_bak = NULL;
>          uint8_t ch;
>  
> -        /*
> -         * Yield periodically to let main loop run, but an iteration of
> -         * the main loop is expensive, so do it each some iterations
> -         */
> -        if ((i & 32767) == 0 && qemu_in_coroutine()) {
> -            aio_co_schedule(qemu_get_current_aio_context(),
> -                            qemu_coroutine_self());
> -            qemu_coroutine_yield();
> -        }
> -        i++;
> -
>          addr = qemu_get_be64(f);
>          ret = qemu_file_get_error(f);
>          if (ret) {

Reviewed-by: Fabiano Rosas <farosas@suse.de>

