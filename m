Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79D0BCD4F4A
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 20:23:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wP4UK-0006eZ-Hv; Mon, 18 May 2026 16:22:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wP4UF-0006aL-Ay
 for qemu-devel@nongnu.org; Mon, 18 May 2026 16:22:53 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wP4UD-0002gu-LF
 for qemu-devel@nongnu.org; Mon, 18 May 2026 16:22:50 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1A82864165;
 Mon, 18 May 2026 20:22:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1779135768; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ywS0Ynz4m8v/HwsRxMYHumetiduNNU0s5T0bDfhclkk=;
 b=PC8X9dgZ1faEWdhwR3ixW8TqAOhZS0poILxmVoY8wuWkjZvwty+Zne/+JR+coFtxnAj3Mr
 n8msH0+gj8nhclgxXRFxjhR9RCrJVhob7M09aeZwhZIPXwz2KUW1ht4EwqcCkMFwKpTQng
 xImzpGZ/vxgIf0tVQRdI1jdOjViUp6M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1779135768;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ywS0Ynz4m8v/HwsRxMYHumetiduNNU0s5T0bDfhclkk=;
 b=zl6xlaLuLlTWxD0eWl3gX4tweW8CofcrukVSh0XqWHv7jSsNjwdAlVDhz8h5ewrzstMc7P
 AH23Mq5RceaESgCA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=vVFJBHBK;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=0QKh9qXE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1779135767; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ywS0Ynz4m8v/HwsRxMYHumetiduNNU0s5T0bDfhclkk=;
 b=vVFJBHBKdzVQ8kmVl667aCcX8S7pq6fEt+rGILxm5hXzYGToia6bITCKG079PWXV1lEd9r
 zL1eTvlxU6zCxaX0nQM3T7vIQ6a3iHw6iONMNRmueVjM1ZCKPqKk2/IKb3GBMgV9VQD/QE
 NYYwTS4+ciGj4onViQWHUhPMgIbE77M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1779135767;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ywS0Ynz4m8v/HwsRxMYHumetiduNNU0s5T0bDfhclkk=;
 b=0QKh9qXEyS5e1qvlQ39G7W2uEHSX59NENdwhLa05miF6xMVpW7UySsguqdtrpp6JHGXioP
 Nq5Fz7ELvmfv7yBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AED78593A8;
 Mon, 18 May 2026 20:22:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id MhHWHxZ1C2oVWwAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 18 May 2026 20:22:46 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Bin Guo <guobin@linux.alibaba.com>, qemu-devel@nongnu.org
Cc: peterx@redhat.com
Subject: Re: [PATCH 1/8] migration/fd: collapse migration_fd_valid into
 single boolean expression
In-Reply-To: <20260518110112.21395-2-guobin@linux.alibaba.com>
References: <20260518110112.21395-1-guobin@linux.alibaba.com>
 <20260518110112.21395-2-guobin@linux.alibaba.com>
Date: Mon, 18 May 2026 17:22:40 -0300
Message-ID: <878q9g4gdr.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+]; FROM_HAS_DN(0.00)[];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 MID_RHS_MATCH_FROM(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,
 imap1.dmz-prg2.suse.org:helo, alibaba.com:email, suse.de:mid, suse.de:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 1A82864165
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

> Two if/return-true blocks followed by a final return false
> are equivalent to a single OR-expression and easier to scan.
>
> Signed-off-by: Bin Guo <guobin@linux.alibaba.com>
> ---
>  migration/fd.c | 10 +---------
>  1 file changed, 1 insertion(+), 9 deletions(-)
>
> diff --git a/migration/fd.c b/migration/fd.c
> index f05f95992f..939cdda4e1 100644
> --- a/migration/fd.c
> +++ b/migration/fd.c
> @@ -39,15 +39,7 @@ static bool fd_is_pipe(int fd)
>  
>  static bool migration_fd_valid(int fd)
>  {
> -    if (fd_is_socket(fd)) {
> -        return true;
> -    }
> -
> -    if (fd_is_pipe(fd)) {
> -        return true;
> -    }
> -
> -    return false;
> +    return fd_is_socket(fd) || fd_is_pipe(fd);
>  }
>  
>  QIOChannel *fd_connect_outgoing(MigrationState *s, const char *fdname,

Let's not invest effort in replacing perfectly good code.

