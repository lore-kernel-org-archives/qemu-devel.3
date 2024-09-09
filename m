Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF1DFECE58C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 23:07:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snnT8-0005EW-NC; Mon, 09 Sep 2024 19:06:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1snnT7-0005Cp-Bv; Mon, 09 Sep 2024 19:06:49 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1snnT5-0004lP-I9; Mon, 09 Sep 2024 19:06:49 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A7D5721999;
 Mon,  9 Sep 2024 23:06:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1725923204; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=S4Jg6L9U7hez0VFizdwWKuWh8ZCs0M5yCBZj9vPuU9k=;
 b=pfsIMfCdzeSb+6dlQrv7+b3U3S5JqTd8vwzLn7YDsfNFwjMgD7vZ0PV243XsODAwpB0Gzv
 CMvca9vQ9EuYPrKBBlDnFSTFmRluCkNDJLHKNF80y40nxJBGqG4V24cp/0chMqlWN2C/CE
 MpebMnzZYNB86x3LCBv6sTIWD0i+YP4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1725923204;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=S4Jg6L9U7hez0VFizdwWKuWh8ZCs0M5yCBZj9vPuU9k=;
 b=iWW45E0i3gO+p4UUeTWXvFdXgYUy/eveWbDKNCaa3SV2bj3FLZ5HyqRcq1Lrhy0e5J9ga8
 LAX7S8S+xKivh4BQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1725923204; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=S4Jg6L9U7hez0VFizdwWKuWh8ZCs0M5yCBZj9vPuU9k=;
 b=pfsIMfCdzeSb+6dlQrv7+b3U3S5JqTd8vwzLn7YDsfNFwjMgD7vZ0PV243XsODAwpB0Gzv
 CMvca9vQ9EuYPrKBBlDnFSTFmRluCkNDJLHKNF80y40nxJBGqG4V24cp/0chMqlWN2C/CE
 MpebMnzZYNB86x3LCBv6sTIWD0i+YP4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1725923204;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=S4Jg6L9U7hez0VFizdwWKuWh8ZCs0M5yCBZj9vPuU9k=;
 b=iWW45E0i3gO+p4UUeTWXvFdXgYUy/eveWbDKNCaa3SV2bj3FLZ5HyqRcq1Lrhy0e5J9ga8
 LAX7S8S+xKivh4BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2B49E13A3A;
 Mon,  9 Sep 2024 23:06:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id QG6NOIN/32bGJQAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 09 Sep 2024 23:06:43 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Daniel Henrique Barboza
 <danielhb413@gmail.com>, =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
 Lucas Mateus Castro <lucas.castro@eldorado.org.br>, qemu-devel@nongnu.org,
 qemu-stable@nongnu.org, Joel Stanley <joel@jms.id.au>, Harsh Prateek Bora
 <harshpb@linux.ibm.com>
Subject: Re: [PATCH] target/ppc: Fix lxv/stxv MSR facility check
In-Reply-To: <20240213083933.718881-1-npiggin@gmail.com>
References: <20240213083933.718881-1-npiggin@gmail.com>
Date: Mon, 09 Sep 2024 20:06:41 -0300
Message-ID: <87cylcl94u.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-1.42 / 50.00]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; BAYES_HAM(-0.12)[66.87%];
 MIME_GOOD(-0.10)[text/plain];
 FREEMAIL_TO(0.00)[gmail.com,nongnu.org];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 FREEMAIL_CC(0.00)[gmail.com,kaod.org,eldorado.org.br,nongnu.org,jms.id.au,linux.ibm.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 MISSING_XM_UA(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; RCPT_COUNT_SEVEN(0.00)[10];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
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

Nicholas Piggin <npiggin@gmail.com> writes:

> The move to decodetree flipped the inequality test for the VEC / VSX
> MSR facility check.
>
> This caused application crashes under Linux, where these facility
> unavailable interrupts are used for lazy-switching of VEC/VSX register
> sets. Getting the incorrect interrupt would result in wrong registers
> being loaded, potentially overwriting live values and/or exposing
> stale ones.
>
> Cc: qemu-stable@nongnu.org
> Reported-by: Joel Stanley <joel@jms.id.au>
> Fixes: 70426b5bb738 ("target/ppc: moved stxvx and lxvx from legacy to decodtree")
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1769
> Tested-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  target/ppc/translate/vsx-impl.c.inc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/target/ppc/translate/vsx-impl.c.inc b/target/ppc/translate/vsx-impl.c.inc
> index 6db87ab336..0266f09119 100644
> --- a/target/ppc/translate/vsx-impl.c.inc
> +++ b/target/ppc/translate/vsx-impl.c.inc
> @@ -2268,7 +2268,7 @@ static bool do_lstxv(DisasContext *ctx, int ra, TCGv displ,
>  
>  static bool do_lstxv_D(DisasContext *ctx, arg_D *a, bool store, bool paired)
>  {
> -    if (paired || a->rt >= 32) {
> +    if (paired || a->rt < 32) {
>          REQUIRE_VSX(ctx);
>      } else {
>          REQUIRE_VECTOR(ctx);

What about the X-form down below?

static bool do_lstxv_X(DisasContext *ctx, arg_X *a, bool store, bool paired)
{
    if (paired || a->rt >= 32) {
        REQUIRE_VSX(ctx);
    } else {
        REQUIRE_VECTOR(ctx);
    }

    return do_lstxv(ctx, a->ra, cpu_gpr[a->rb], a->rt, store, paired);
}

