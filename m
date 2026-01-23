Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00D82D74EC4
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Jan 2026 13:03:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjGoj-000301-9P; Fri, 23 Jan 2026 08:03:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vjGlf-0001NI-Ks
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 08:00:03 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vjGld-0005V4-DQ
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 08:00:03 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 49CE3337DA;
 Fri, 23 Jan 2026 12:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1769173199; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Exong+Y8lv1NOMInXHhO7h1T/ob7kWUsKvsd0KlyZbE=;
 b=cldjyOKuasSvego5c2jjjSiRasKTobH7yi7+o4z8c7CULm/WT0QcZV5f3byO/ZnfVYa+xv
 j64YhZft/u2sntqcdtgGQBrEc2pADnzb4Rbst/KOR8HGZfSNyAvCLPsjcpOBH9lB3Lm36+
 MvQIDnVe11LsCEQgfbv+jQRfES6qNQA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1769173199;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Exong+Y8lv1NOMInXHhO7h1T/ob7kWUsKvsd0KlyZbE=;
 b=FREXxlIBmoYeDSxB93k6zpyT0NSvA6l5/TmBBf0ML+GkktdWQirxc3835CfruaGCoORTYL
 m06lCdAnBXLv1MDQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=cldjyOKu;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=FREXxlIB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1769173199; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Exong+Y8lv1NOMInXHhO7h1T/ob7kWUsKvsd0KlyZbE=;
 b=cldjyOKuasSvego5c2jjjSiRasKTobH7yi7+o4z8c7CULm/WT0QcZV5f3byO/ZnfVYa+xv
 j64YhZft/u2sntqcdtgGQBrEc2pADnzb4Rbst/KOR8HGZfSNyAvCLPsjcpOBH9lB3Lm36+
 MvQIDnVe11LsCEQgfbv+jQRfES6qNQA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1769173199;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Exong+Y8lv1NOMInXHhO7h1T/ob7kWUsKvsd0KlyZbE=;
 b=FREXxlIBmoYeDSxB93k6zpyT0NSvA6l5/TmBBf0ML+GkktdWQirxc3835CfruaGCoORTYL
 m06lCdAnBXLv1MDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 92D05136AA;
 Fri, 23 Jan 2026 12:59:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id gznBFM5wc2ndTQAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 23 Jan 2026 12:59:58 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Juraj Marcin <jmarcin@redhat.com>, Stefan Hajnoczi
 <stefanha@redhat.com>, Prasad Pandit <ppandit@redhat.com>,
 peterx@redhat.com
Subject: Re: [PATCH 4/5] migration: Drop explicit block activation in
 postcopy fail path
In-Reply-To: <20260122230331.3543312-5-peterx@redhat.com>
References: <20260122230331.3543312-1-peterx@redhat.com>
 <20260122230331.3543312-5-peterx@redhat.com>
Date: Fri, 23 Jan 2026 09:59:55 -0300
Message-ID: <871pjgjxh0.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[6]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: 49CE3337DA
X-Rspamd-Action: no action
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

Peter Xu <peterx@redhat.com> writes:

> Postcopy (in failure path) should share with precopy on disk reactivations.
> Explicit activiation should used to be fine even if called twice, but after
> 26f65c01ed ("migration: Do not try to start VM if disk activation fails")
> we may want to avoid it and always capture failure when reactivation
> happens (even if we do not expect the failure to happen).  Remove this
> redundant call.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  migration/migration.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/migration/migration.c b/migration/migration.c
> index 1d9a2fc068..5bef14ea99 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -2910,7 +2910,6 @@ fail:
>      if (ms->state != MIGRATION_STATUS_CANCELLING) {
>          migrate_set_state(&ms->state, ms->state, MIGRATION_STATUS_FAILED);
>      }
> -    migration_block_activate(NULL);
>      bql_unlock();
>      return -1;
>  }

Reviewed-by: Fabiano Rosas <farosas@suse.de>

