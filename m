Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56238C87FCA
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Jul 2025 21:26:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhalR-0001og-BD; Thu, 31 Jul 2025 17:24:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uhaQC-000090-Me
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 17:02:43 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uhaQ9-0003cB-GN
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 17:02:39 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 69D571F7ED;
 Thu, 31 Jul 2025 21:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1753995747; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=frnGCCkGxm83TmN58QAzuLmNetXVOfr5cHOSW2/PLvM=;
 b=NhOwDlY6GxBE2gj7iVzGdCZDKYRmgL2J4QXHXJazyP2NZz2UN7LtuTpWFFou6UujF2AXKf
 tJjfqk6QG/onKj4irOADe1rJOups8QZZr/ld4NkSFtiLTg4icwTZModXr91uLjfyIs978o
 6+2KdeXWCGYZRUx+Eu7nvHIeSlAzY0k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1753995747;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=frnGCCkGxm83TmN58QAzuLmNetXVOfr5cHOSW2/PLvM=;
 b=B3K3SvWGkEczTjZBTejV2t2blURXz3eDr76wrE2Bv2j7fpFBt5kXMpfPE+88PeowdEzICC
 QUaTguci+L7mz9Cw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=NhOwDlY6;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=B3K3SvWG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1753995747; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=frnGCCkGxm83TmN58QAzuLmNetXVOfr5cHOSW2/PLvM=;
 b=NhOwDlY6GxBE2gj7iVzGdCZDKYRmgL2J4QXHXJazyP2NZz2UN7LtuTpWFFou6UujF2AXKf
 tJjfqk6QG/onKj4irOADe1rJOups8QZZr/ld4NkSFtiLTg4icwTZModXr91uLjfyIs978o
 6+2KdeXWCGYZRUx+Eu7nvHIeSlAzY0k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1753995747;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=frnGCCkGxm83TmN58QAzuLmNetXVOfr5cHOSW2/PLvM=;
 b=B3K3SvWGkEczTjZBTejV2t2blURXz3eDr76wrE2Bv2j7fpFBt5kXMpfPE+88PeowdEzICC
 QUaTguci+L7mz9Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DFB9313876;
 Thu, 31 Jul 2025 21:02:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id kAU8KOLZi2h8bgAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 31 Jul 2025 21:02:26 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Subject: Re: [PATCH for-10.1] target/arm: Reinstate bogus AArch32 DBGDTRTX
 register for migration compat
In-Reply-To: <20250731134338.250203-1-peter.maydell@linaro.org>
References: <20250731134338.250203-1-peter.maydell@linaro.org>
Date: Thu, 31 Jul 2025 18:02:23 -0300
Message-ID: <87zfck2hwg.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 69D571F7ED
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
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

Peter Maydell <peter.maydell@linaro.org> writes:

> In commit 655659a74a we fixed some bugs in the encoding of the
> Debug Communications Channel registers, including that we were
> incorrectly exposing an AArch32 register at p14, 3, c0, c5, 0.
>
> Unfortunately removing a register is a break of forwards migration
> compatibility for TCG, because we will fail the migration if the
> source QEMU passes us a cpreg which the destination QEMU does not
> have.  We don't have a mechanism for saying "it's OK to ignore this
> sysreg in the inbound data", so for the 10.1 release reinstate the
> incorrect AArch32 register.
>
> (We probably have had other cases in the past of breaking migration
> compatibility like this, but we didn't notice because we didn't test
> and in any case not that many people care about TCG migration
> compatibility.  KVM migration compat is not affected because for KVM
> we treat the kernel as the source of truth for what system registers
> are present.)
>
> Fixes: 655659a74a36b ("target/arm: Correct encoding of Debug Communications Channel registers")
> Reported-by: Fabiano Rosas <farosas@suse.de>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Fabiano Rosas <farosas@suse.de>

