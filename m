Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 487C4EE57C0
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 16:20:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soQ40-0002qu-V8; Wed, 11 Sep 2024 12:19:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>)
 id 1soQ3z-0002nR-3c; Wed, 11 Sep 2024 12:19:27 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>)
 id 1soQ3x-0000By-IN; Wed, 11 Sep 2024 12:19:26 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 10494219FF;
 Wed, 11 Sep 2024 16:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1726071561; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=e9LuzNDtu2K6Opgc75jW7oNdYAG7rqG7pyi5wKo0v1k=;
 b=obpmQKpFORXR1emw7y4W5OSqupZsLo9WQQd/xstZ7SV4yU1nNs4MtN2mdyzwD+LmfBZoru
 piuz/6KicQhavgrGAqCMQOIcuZz8FtqSSlq+uFU41fPVTjs1hvzLlGvpxik0zoT2LTnIPr
 lvsxVjYHNukp8DRTOVQuUOoT5NsmeoA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1726071561;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=e9LuzNDtu2K6Opgc75jW7oNdYAG7rqG7pyi5wKo0v1k=;
 b=FM6ij/8B2uIQs21LGHlQRefgqhBG9eSTKT+u85WUwmHEFaPDxu6MIxecX7QJ+uiBWIUlBL
 sX8Skj/tluGuAoAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1726071561; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=e9LuzNDtu2K6Opgc75jW7oNdYAG7rqG7pyi5wKo0v1k=;
 b=obpmQKpFORXR1emw7y4W5OSqupZsLo9WQQd/xstZ7SV4yU1nNs4MtN2mdyzwD+LmfBZoru
 piuz/6KicQhavgrGAqCMQOIcuZz8FtqSSlq+uFU41fPVTjs1hvzLlGvpxik0zoT2LTnIPr
 lvsxVjYHNukp8DRTOVQuUOoT5NsmeoA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1726071561;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=e9LuzNDtu2K6Opgc75jW7oNdYAG7rqG7pyi5wKo0v1k=;
 b=FM6ij/8B2uIQs21LGHlQRefgqhBG9eSTKT+u85WUwmHEFaPDxu6MIxecX7QJ+uiBWIUlBL
 sX8Skj/tluGuAoAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D8E3613A7C;
 Wed, 11 Sep 2024 16:19:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id psN9MwjD4WYUfwAAD6G6ig
 (envelope-from <cfontana@suse.de>); Wed, 11 Sep 2024 16:19:20 +0000
Message-ID: <9e6212ca-5c2f-459c-a59d-11fbdb796c07@suse.de>
Date: Wed, 11 Sep 2024 18:19:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/ppc: Fix lxvx/stxvx facility check
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
References: <20240911141651.6914-1-farosas@suse.de>
Content-Language: en-US
From: Claudio Fontana <cfontana@suse.de>
In-Reply-To: <20240911141651.6914-1-farosas@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-6.61 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-1.31)[90.17%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MIME_TRACE(0.00)[0:+]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 FREEMAIL_CC(0.00)[nongnu.org,gmail.com]; RCVD_TLS_ALL(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.de:email,
 suse.de:mid]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=cfontana@suse.de; helo=smtp-out1.suse.de
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

On 9/11/24 16:16, Fabiano Rosas wrote:
> The XT check for the lxvx/stxvx instructions is currently
> inverted. This was introduced during the move to decodetree.
> 
> From the ISA:
>   Chapter 7. Vector-Scalar Extension Facility
>   Load VSX Vector Indexed X-form
> 
>   lxvx XT,RA,RB
>   if TX=0 & MSR.VSX=0 then VSX_Unavailable()
>   if TX=1 & MSR.VEC=0 then Vector_Unavailable()
>   ...
>   Let XT be the value 32×TX + T.
> 
> The code currently does the opposite:
> 
>     if (paired || a->rt >= 32) {
>         REQUIRE_VSX(ctx);
>     } else {
>         REQUIRE_VECTOR(ctx);
>     }
> 
> This was already fixed for lxv/stxv at commit "2cc0e449d1 (target/ppc:
> Fix lxv/stxv MSR facility check)", but the indexed forms were missed.
> 
> Cc: qemu-stable@nongnu.org
> Fixes: 70426b5bb7 ("target/ppc: moved stxvx and lxvx from legacy to decodtree")
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  target/ppc/translate/vsx-impl.c.inc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/ppc/translate/vsx-impl.c.inc b/target/ppc/translate/vsx-impl.c.inc
> index 40a87ddc4a..a869f30e86 100644
> --- a/target/ppc/translate/vsx-impl.c.inc
> +++ b/target/ppc/translate/vsx-impl.c.inc
> @@ -2244,7 +2244,7 @@ static bool do_lstxv_PLS_D(DisasContext *ctx, arg_PLS_D *a,
>  
>  static bool do_lstxv_X(DisasContext *ctx, arg_X *a, bool store, bool paired)
>  {
> -    if (paired || a->rt >= 32) {
> +    if (paired || a->rt < 32) {
>          REQUIRE_VSX(ctx);
>      } else {
>          REQUIRE_VECTOR(ctx);

Reviewed-by: Claudio Fontana <cfontana@suse.de>

