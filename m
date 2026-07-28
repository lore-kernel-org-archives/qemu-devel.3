Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF517C53219
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 19:54:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wonsu-0005Ht-Jx; Tue, 28 Jul 2026 15:54:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wonsl-0005FX-I7
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 15:54:33 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wonsj-0007l2-Im
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 15:54:31 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1F5233E09;
 Tue, 28 Jul 2026 19:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1785268461; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=t8spdf91S/Bg/lDyUcq7/NFQuyLSz3UPebvGfNPC4do=;
 b=dmdGSS1ja/797I4Yiv4CUybEj3gVkITeG3ZVKL6ZMO9targ5vQHbfIylf6he16fC3dMhCE
 gdvWSbhdSzlmFlg92g2yrHZ/yYEAZi5Els6AzoF7fjb3YBGKHGOikIiZw0bJY88TBtjhhU
 WVA85RYkbOTldW1Gm4Xtcex6nztMvSA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1785268461;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=t8spdf91S/Bg/lDyUcq7/NFQuyLSz3UPebvGfNPC4do=;
 b=AjVhY74wAIhfJ9IR+9zUM1AZwjx0G9iBJ9sClZzmYQmDwpC+BmTVSebJorS0RNKynYTIQq
 PqzH8Zb00Rpr9AAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1785268457; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=t8spdf91S/Bg/lDyUcq7/NFQuyLSz3UPebvGfNPC4do=;
 b=tEI4vYILM9gbKj+MOsbghhih6SQ+pgzZUIUO/ktKWnA3CdBvnl+rShYAh0XXai/8q5jd/K
 an2JpHFX5+9xhL4CBTOqaxKRYhbmgFH5sYTTWsp65dxV2csJv6iGnMHCp58Hkw7t0Fmv6/
 k9xT3zQRsg8OyDn/040kxq/14SpCmww=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1785268457;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=t8spdf91S/Bg/lDyUcq7/NFQuyLSz3UPebvGfNPC4do=;
 b=EQwesQxmF8MQJHNLwhaO3XD6EwLkkPstPOjAOrBgpM5vy2L4D5oQkoi41W/9UH0t03NJuV
 pxqbcpTYocUTUUAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AD7EF779B1;
 Tue, 28 Jul 2026 19:54:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id oJvbHugIaWpzTAAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 28 Jul 2026 19:54:16 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: peterx@redhat.com, Juraj Marcin <jmarcin@redhat.com>, Tristan Madani
 <tristan@talencesecurity.com>
Subject: Re: [PATCH 5/5] migration/ram: Check for RAMBlock size mismatch
 when parsing
In-Reply-To: <20260728155247.1894355-6-peterx@redhat.com>
References: <20260728155247.1894355-1-peterx@redhat.com>
 <20260728155247.1894355-6-peterx@redhat.com>
Date: Tue, 28 Jul 2026 16:54:14 -0300
Message-ID: <87qzkmopp5.fsf@suse.de>
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
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[gitlab.com:url, talencesecurity.com:email,
 suse.de:email, suse.de:mid, imap1.dmz-prg2.suse.org:helo]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
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

Peter Xu <peterx@redhat.com> writes:

> Add an underflow check for the subtract of total RAMBlock size to make sure
> it won't underflow.  It should not happen in production systems but only if
> the migration stream was hijacked, which is not a real concern since
> migration channel is trusted.  Still protect against it.
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4013
> Reported-by: Tristan Madani <tristan@talencesecurity.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  migration/ram.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/migration/ram.c b/migration/ram.c
> index 8918b2f03b..85feff578c 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -4268,7 +4268,7 @@ static int parse_ramblocks(QEMUFile *f, ram_addr_t total_ram_bytes)
>      int ret = 0;
>  
>      /* Synchronize RAM block list */
> -    while (!ret && total_ram_bytes) {
> +    while (total_ram_bytes) {
>          RAMBlock *block;
>          char id[256];
>          ram_addr_t length;
> @@ -4285,8 +4285,15 @@ static int parse_ramblocks(QEMUFile *f, ram_addr_t total_ram_bytes)
>              error_report("Unknown ramblock \"%s\", cannot accept "
>                           "migration", id);
>              ret = -EINVAL;
> +            break;
> +        }
> +
> +        if (usub64_overflow(total_ram_bytes, length, &total_ram_bytes)) {
> +            error_report("%s: RAMBlock '%s' size underflow total RAM size",
> +                         __func__, block->idstr);
> +            ret = -EFAULT;
> +            break;
>          }
> -        total_ram_bytes -= length;
>      }
>  
>      return ret;

Reviewed-by: Fabiano Rosas <farosas@suse.de>

