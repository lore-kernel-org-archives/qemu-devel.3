Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7765CE7DEF1
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 14:50:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmvG3-0006VU-C0; Mon, 02 Feb 2026 09:50:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vmvG2-0006VL-8M
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 09:50:30 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vmvG0-0003kr-M8
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 09:50:30 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 7E71C5BCEC;
 Mon,  2 Feb 2026 14:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1770043827; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UKvqQTjfaw/qQwXRSG6hT6VWSniQV/Oh9TJgAeDgjS8=;
 b=Xzuhb4QsGNFxk9GP7DdnJWFKPIzzrelKHrs8vJPP4T/hkmit5whV74Jb3PYByQcbTWRtmD
 E0lxhlX9Ovu6q26GXxhj1O1YNhKNZlxjgQz80xwTuFwecvs2q+vswYHiOCMaSIDhatyfHQ
 D2pzCNHzrDsCz7CDcHhusOou2KOBAnY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1770043827;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UKvqQTjfaw/qQwXRSG6hT6VWSniQV/Oh9TJgAeDgjS8=;
 b=Yj3YrlyOzmr65+SQ2G3uMK4SDfViiDni+MBpLcodVp6x/TW2YNpFp01ajdyLOPmPfSslkM
 VUEgTevjnz+pi1Bg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Xzuhb4Qs;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Yj3YrlyO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1770043827; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UKvqQTjfaw/qQwXRSG6hT6VWSniQV/Oh9TJgAeDgjS8=;
 b=Xzuhb4QsGNFxk9GP7DdnJWFKPIzzrelKHrs8vJPP4T/hkmit5whV74Jb3PYByQcbTWRtmD
 E0lxhlX9Ovu6q26GXxhj1O1YNhKNZlxjgQz80xwTuFwecvs2q+vswYHiOCMaSIDhatyfHQ
 D2pzCNHzrDsCz7CDcHhusOou2KOBAnY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1770043827;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UKvqQTjfaw/qQwXRSG6hT6VWSniQV/Oh9TJgAeDgjS8=;
 b=Yj3YrlyOzmr65+SQ2G3uMK4SDfViiDni+MBpLcodVp6x/TW2YNpFp01ajdyLOPmPfSslkM
 VUEgTevjnz+pi1Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E7C073EA62;
 Mon,  2 Feb 2026 14:50:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id RWXiKbK5gGkBQAAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 02 Feb 2026 14:50:26 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Lukas Straub <lukasstraub2@web.de>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Paolo
 Bonzini <pbonzini@redhat.com>, Zhang Chen <zhangckid@gmail.com>, Hailiang
 Zhang <zhanghailiang@xfusion.com>, Markus Armbruster <armbru@redhat.com>,
 Li Zhijian <lizhijian@fujitsu.com>, "Dr. David Alan Gilbert"
 <dave@treblig.org>, Lukas Straub <lukasstraub2@web.de>
Subject: Re: [PATCH v4 10/16] Call colo_release_ram_cache() after multifd
 threads terminate
In-Reply-To: <20260130-colo_unit_test_multifd-v4-10-7115ab6f0e77@web.de>
References: <20260130-colo_unit_test_multifd-v4-0-7115ab6f0e77@web.de>
 <20260130-colo_unit_test_multifd-v4-10-7115ab6f0e77@web.de>
Date: Mon, 02 Feb 2026 11:50:24 -0300
Message-ID: <87a4xrryhb.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FREEMAIL_TO(0.00)[web.de,nongnu.org];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com,web.de];
 FREEMAIL_CC(0.00)[redhat.com,gmail.com,xfusion.com,fujitsu.com,treblig.org,web.de];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCPT_COUNT_SEVEN(0.00)[11]; DKIM_TRACE(0.00)[suse.de:+];
 MISSING_XM_UA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns, suse.de:mid, suse.de:dkim, suse.de:email]
X-Rspamd-Queue-Id: 7E71C5BCEC
X-Rspamd-Action: no action
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

Lukas Straub <lukasstraub2@web.de> writes:

> The multifd threads still may access the colo cache, so release it
> only after they terminate.
>
> Signed-off-by: Lukas Straub <lukasstraub2@web.de>
> ---
>  migration/colo.c      | 3 ---
>  migration/migration.c | 3 +++
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/migration/colo.c b/migration/colo.c
> index 8dfd39b035c48590fcebeb20459f01fb37fb67d1..d3534d1a32ad82f02101ac092ebf818a0caee6f2 100644
> --- a/migration/colo.c
> +++ b/migration/colo.c
> @@ -947,7 +947,4 @@ void coroutine_fn colo_incoming_co(void)
>      /* Wait checkpoint incoming thread exit before free resource */
>      qemu_thread_join(&th);
>      bql_lock();
> -
> -    /* We hold the global BQL, so it is safe here */
> -    colo_release_ram_cache();
>  }
> diff --git a/migration/migration.c b/migration/migration.c
> index 5515be1bf305b40ba0b590136df18a53451872c5..9e3f73f27766196ea8673bf9a58c97d5b8b1672f 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -454,6 +454,9 @@ void migration_incoming_state_destroy(void)
>       * BQL and retake unconditionally.
>       */
>      assert(bql_locked());
> +    if (migrate_colo()) {
> +        colo_release_ram_cache();
> +    }
>      qemu_loadvm_state_cleanup(mis);
>  
>      if (mis->to_src_file) {

Reviewed-by: Fabiano Rosas <farosas@suse.de>

