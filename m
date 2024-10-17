Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28705D3C526
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2024 18:03:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1Uph-0003eF-5v; Thu, 17 Oct 2024 14:02:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1t1Upd-0003ds-0J
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 14:02:42 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1t1Upb-0004vI-IJ
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 14:02:40 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id BB2C721E06;
 Thu, 17 Oct 2024 18:02:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1729188157; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JzwzkWC4FGJQoVej38IZNuWycD/RZB7k355/DhYg7V4=;
 b=OYpaHmk0/xeKh3KdmlFQCm2QYw6NbVgxV07VA1hXZlWX6dOa1OXx8Cqa3tyfaSeb/7mFkU
 QPESZ4SnJbi+I50gsEjR66a6pwVj6IAwS7JTisi4CqiuhA6Hnqz783N7V/1TtjfRY/PThf
 FmEUbJMbQg1Kf3UZmCRMt2Jiuxfc9E0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1729188157;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JzwzkWC4FGJQoVej38IZNuWycD/RZB7k355/DhYg7V4=;
 b=1PQ5n572m9sDe+8LIfcrWf6LCXWCfYld8wu2UdD5iPi/lxcw0HypMIu/w29ZWWgcruZ4HT
 7CBesYlquLhkuiDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1729188157; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JzwzkWC4FGJQoVej38IZNuWycD/RZB7k355/DhYg7V4=;
 b=OYpaHmk0/xeKh3KdmlFQCm2QYw6NbVgxV07VA1hXZlWX6dOa1OXx8Cqa3tyfaSeb/7mFkU
 QPESZ4SnJbi+I50gsEjR66a6pwVj6IAwS7JTisi4CqiuhA6Hnqz783N7V/1TtjfRY/PThf
 FmEUbJMbQg1Kf3UZmCRMt2Jiuxfc9E0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1729188157;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JzwzkWC4FGJQoVej38IZNuWycD/RZB7k355/DhYg7V4=;
 b=1PQ5n572m9sDe+8LIfcrWf6LCXWCfYld8wu2UdD5iPi/lxcw0HypMIu/w29ZWWgcruZ4HT
 7CBesYlquLhkuiDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4723813A53;
 Thu, 17 Oct 2024 18:02:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id qIv4Az1REWcsZAAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 17 Oct 2024 18:02:37 +0000
From: Fabiano Rosas <farosas@suse.de>
To: yong.huang@smartx.com, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>,
 yong.huang@smartx.com
Subject: Re: [PATCH v4 2/6] migration: Stop CPU throttling conditionally
In-Reply-To: <f0c787080bb9ab0c37952f0ca5bfaa525d5ddd14.1729146786.git.yong.huang@smartx.com>
References: <cover.1729146786.git.yong.huang@smartx.com>
 <f0c787080bb9ab0c37952f0ca5bfaa525d5ddd14.1729146786.git.yong.huang@smartx.com>
Date: Thu, 17 Oct 2024 15:02:34 -0300
Message-ID: <87ldym38w5.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_HAS_DN(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MISSING_XM_UA(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCPT_COUNT_FIVE(0.00)[6]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid]
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

yong.huang@smartx.com writes:

> From: Hyman Huang <yong.huang@smartx.com>
>
> Since CPU throttling only occurs when auto-converge
> is on, stop it conditionally.
>
> Signed-off-by: Hyman Huang <yong.huang@smartx.com>
> ---
>  migration/migration.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/migration/migration.c b/migration/migration.c
> index 021faee2f3..37a200a177 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -3289,7 +3289,9 @@ static MigIterateState migration_iteration_run(MigrationState *s)
>  static void migration_iteration_finish(MigrationState *s)
>  {
>      /* If we enabled cpu throttling for auto-converge, turn it off. */
> -    cpu_throttle_stop();
> +    if (migrate_auto_converge()) {
> +        cpu_throttle_stop();
> +    }
>  
>      bql_lock();
>      switch (s->state) {

Reviewed-by: Fabiano Rosas <farosas@suse.de>

