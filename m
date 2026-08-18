Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7337C5DF74
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 13:35:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwJyQ-0005xk-Cn; Tue, 18 Aug 2026 09:35:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1wwJyN-0005wp-1v; Tue, 18 Aug 2026 09:35:24 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1wwJyK-0000Z0-9T; Tue, 18 Aug 2026 09:35:22 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 132B284579;
 Tue, 18 Aug 2026 13:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787060113; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NPHBxzGr8Z4w1DCDZTmWkWmewlKbBhQ1sEyyt/4Zx9k=;
 b=i6+89oqkxZ0GnDf12wRlH4vtt3yM8ZtZJEo+MMoUxj2WssYx3DkQhZlWxWV5RDKOtRUEkt
 7Wvhdn0iu3qPH5hAOoFY9tl0E0b4FX9iQETVXiYgAcw+kYbjb1h07+dgbUEPJWPl+fPAFU
 FZNMRe/oK4TwoaQnZb8eim6twb+Hc6k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787060113;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NPHBxzGr8Z4w1DCDZTmWkWmewlKbBhQ1sEyyt/4Zx9k=;
 b=7UPDO8/2FLMlbD/R3Pd90DWvWHC1L2SP0DCdvzz03sl87t4gGSXG0tiReuFnuTAQJCMx+C
 p1g22Z1cm+spG4CA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787060109; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NPHBxzGr8Z4w1DCDZTmWkWmewlKbBhQ1sEyyt/4Zx9k=;
 b=EEzedlTNyXjaJtLPGOVYUE0gR7GWLmACsyU4j1tHXnCExAjDHvem+0VVSdOzMevqH9PfTY
 jF6T6nLz94Y1z2pas6UQW8UaO2zekBNsS9p4UQm9aQS2zgtzRZrcX6rLLmSL+4IJeOcvvt
 fvr6rzDQqoYtKbrWroFz8s2k4iYnE/Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787060109;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NPHBxzGr8Z4w1DCDZTmWkWmewlKbBhQ1sEyyt/4Zx9k=;
 b=2dScrU0zh16asqaY+1vk/0EJFveNqgPYC96GYoZuP0KbQvcP61RS0RKuXaM9JiYv8yLLml
 8eBtB7puEnKd1wCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A862722BA;
 Tue, 18 Aug 2026 13:35:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id cexMHoxfhGoGTAAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 18 Aug 2026 13:35:08 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] chardev: Don't unregister yank upon async path
 connection failure
In-Reply-To: <20260603141137.1108963-1-farosas@suse.de>
References: <20260603141137.1108963-1-farosas@suse.de>
Date: Tue, 18 Aug 2026 10:35:06 -0300
Message-ID: <87bjazmu0l.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[gitlab.com:url, suse.de:email, suse.de:mid,
 imap1.dmz-prg2.suse.org:helo, nongnu.org:email]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

Fabiano Rosas <farosas@suse.de> writes:

> Commit 5c102ac9 ("chardev: Consolidate yank registration") has moved
> yank registration in the tcp_chr_connect_client_async() path to after
> the connection is successful. If qio_channel_socket_connect_sync()
> fails early, there will be no yank registered to be unregistered in
> the error path, leading to assert.
>
> Remove the now-extraneous unregister.
>
> Cc: qemu-stable@nongnu.org
> Fixes: 5c102ac9 ("chardev: Consolidate yank registration")
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3528
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  chardev/char-socket.c | 5 -----
>  1 file changed, 5 deletions(-)
>
> diff --git a/chardev/char-socket.c b/chardev/char-socket.c
> index e064b105c5..99e01a4875 100644
> --- a/chardev/char-socket.c
> +++ b/chardev/char-socket.c
> @@ -1128,11 +1128,6 @@ static void qemu_chr_socket_connected(QIOTask *task, void *opaque)
>  
>      if (qio_task_propagate_error(task, &err)) {
>          tcp_chr_change_state(s, TCP_CHARDEV_STATE_DISCONNECTED);
> -        if (s->registered_yank) {
> -            yank_unregister_function(CHARDEV_YANK_INSTANCE(chr->label),
> -                                     char_socket_yank_iochannel,
> -                                     QIO_CHANNEL(sioc));
> -        }
>          check_report_connect_error(chr, err);
>          goto cleanup;
>      }

ping

