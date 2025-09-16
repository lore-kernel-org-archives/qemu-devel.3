Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 658E8CAC598
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 21:42:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uydQb-0001Ac-Je; Tue, 16 Sep 2025 17:41:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uydQX-00019x-NR
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 17:41:29 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uydQV-0004sl-Rr
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 17:41:29 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B964422613;
 Tue, 16 Sep 2025 21:41:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1758058885; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oGvlNjFcKQmbKeqXFm9dM5KNuNfCvA53fpfgx+6c4Bs=;
 b=jQOjhXIoMdNipgvLBl6yCBcDopbqjx0KN4l0ccrq3LcGXPU5EJ0cWDt8MuogJGlQ4DQsRL
 Qou6CPpvoM6rbUj1cYXcVuR+ZMX3ksFt6WDkdF9aMkd14+AahOkHwUlqAmukJjJgHWCp9Q
 QFNCOMF7nsUgABg1+QvjFUi+K2ccAYI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1758058885;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oGvlNjFcKQmbKeqXFm9dM5KNuNfCvA53fpfgx+6c4Bs=;
 b=CiOOfPbdpy6UqAY4ICVpnVBfQtgc4G5vk5+wLXrOqx3lbjpqhw7yX4EBfK6k3hpmZ1SYPg
 H0uPhObSCuLLkHAw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=jQOjhXIo;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=CiOOfPbd
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1758058885; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oGvlNjFcKQmbKeqXFm9dM5KNuNfCvA53fpfgx+6c4Bs=;
 b=jQOjhXIoMdNipgvLBl6yCBcDopbqjx0KN4l0ccrq3LcGXPU5EJ0cWDt8MuogJGlQ4DQsRL
 Qou6CPpvoM6rbUj1cYXcVuR+ZMX3ksFt6WDkdF9aMkd14+AahOkHwUlqAmukJjJgHWCp9Q
 QFNCOMF7nsUgABg1+QvjFUi+K2ccAYI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1758058885;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oGvlNjFcKQmbKeqXFm9dM5KNuNfCvA53fpfgx+6c4Bs=;
 b=CiOOfPbdpy6UqAY4ICVpnVBfQtgc4G5vk5+wLXrOqx3lbjpqhw7yX4EBfK6k3hpmZ1SYPg
 H0uPhObSCuLLkHAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 20827139CB;
 Tue, 16 Sep 2025 21:41:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 8lVBM4TZyWhWUQAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 16 Sep 2025 21:41:24 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: "Dr . David Alan Gilbert" <dave@treblig.org>, peterx@redhat.com, Kevin
 Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?utf-8?Q?D?=
 =?utf-8?Q?aniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, Hailiang Zhang
 <zhanghailiang@xfusion.com>, Yury Kotov <yury-kotov@yandex-team.ru>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>, Prasad Pandit
 <ppandit@redhat.com>, Zhang Chen <zhangckid@gmail.com>, Li Zhijian
 <lizhijian@fujitsu.com>, Juraj Marcin <jmarcin@redhat.com>, Lidong Chen
 <jemmy858585@gmail.com>
Subject: Re: [PATCH RFC 2/9] migration/rdma: Fix wrong context in
 qio_channel_rdma_shutdown()
In-Reply-To: <20250827205949.364606-3-peterx@redhat.com>
References: <20250827205949.364606-1-peterx@redhat.com>
 <20250827205949.364606-3-peterx@redhat.com>
Date: Tue, 16 Sep 2025 18:41:22 -0300
Message-ID: <87tt12vzwd.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCPT_COUNT_TWELVE(0.00)[15]; ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 MIME_TRACE(0.00)[0:+]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; RCVD_TLS_ALL(0.00)[];
 TO_DN_SOME(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[treblig.org,redhat.com,xfusion.com,yandex-team.ru,gmail.com,fujitsu.com];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]; DKIM_TRACE(0.00)[suse.de:+];
 MISSING_XM_UA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns, suse.de:mid, suse.de:dkim, suse.de:email]
X-Rspamd-Queue-Id: B964422613
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

> The rdmaout should be a cache of rioc->rdmaout, not rioc->rdmain.
>
> Cc: Zhijian Li (Fujitsu) <lizhijian@fujitsu.com>
> Cc: Lidong Chen <jemmy858585@gmail.com>
> Fixes: 54db882f07 ("migration: implement the shutdown for RDMA QIOChannel")
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  migration/rdma.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/migration/rdma.c b/migration/rdma.c
> index 2d839fce6c..e6837184c8 100644
> --- a/migration/rdma.c
> +++ b/migration/rdma.c
> @@ -2986,7 +2986,7 @@ qio_channel_rdma_shutdown(QIOChannel *ioc,
>      RCU_READ_LOCK_GUARD();
>  
>      rdmain = qatomic_rcu_read(&rioc->rdmain);
> -    rdmaout = qatomic_rcu_read(&rioc->rdmain);
> +    rdmaout = qatomic_rcu_read(&rioc->rdmaout);
>  
>      switch (how) {
>      case QIO_CHANNEL_SHUTDOWN_READ:

Reviewed-by: Fabiano Rosas <farosas@suse.de>

