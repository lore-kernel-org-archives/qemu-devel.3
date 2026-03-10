Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D58CEB1076
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 15:51:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzzMG-0001c5-L1; Tue, 10 Mar 2026 11:50:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vzzMF-0001bF-Aq
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 11:50:55 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vzzMD-0003T9-Rl
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 11:50:55 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 485F64D2E3;
 Tue, 10 Mar 2026 15:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1773157852; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lyLJekTUDaO1ztdoifHrRi47lmpG5XvPBeskNYJnPWE=;
 b=C9GXpieii7M4NZ0nrlt4orSEL7quqDURrRCgFa1MgwOz4F2balZKlzKltCQtUDSDZc+HNQ
 1LeDsR7txFGNfbJQkkmZyT7h20miXb6HJIJJQ0lB8XYuL0RDGBFTpNMvTGTRov9nJqmKkR
 AqhXIyKyDQNVXnu9eX5OepcJzv3svNE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1773157852;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lyLJekTUDaO1ztdoifHrRi47lmpG5XvPBeskNYJnPWE=;
 b=dtJu4Ia+rDgebS1QHNMKVhGslRpE9i1+HVutyhvNDy6o8nv6DGNQnhRuTYmQMt5v3X4DIW
 oUVvmHjzoIvpBaDA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=C9GXpiei;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=dtJu4Ia+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1773157852; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lyLJekTUDaO1ztdoifHrRi47lmpG5XvPBeskNYJnPWE=;
 b=C9GXpieii7M4NZ0nrlt4orSEL7quqDURrRCgFa1MgwOz4F2balZKlzKltCQtUDSDZc+HNQ
 1LeDsR7txFGNfbJQkkmZyT7h20miXb6HJIJJQ0lB8XYuL0RDGBFTpNMvTGTRov9nJqmKkR
 AqhXIyKyDQNVXnu9eX5OepcJzv3svNE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1773157852;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lyLJekTUDaO1ztdoifHrRi47lmpG5XvPBeskNYJnPWE=;
 b=dtJu4Ia+rDgebS1QHNMKVhGslRpE9i1+HVutyhvNDy6o8nv6DGNQnhRuTYmQMt5v3X4DIW
 oUVvmHjzoIvpBaDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BE0963F527;
 Tue, 10 Mar 2026 15:50:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id VEQvHts9sGmgbQAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 10 Mar 2026 15:50:51 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>, Steven Lee
 <steven_lee@aspeedtech.com>,
 Troy Lee <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew
 Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>
Subject: Re: [PATCH 0/2] tests/qtest: Avoid char arrays in more Arm tests
In-Reply-To: <20260310153334.3063224-1-peter.maydell@linaro.org>
References: <20260310153334.3063224-1-peter.maydell@linaro.org>
Date: Tue, 10 Mar 2026 12:50:49 -0300
Message-ID: <875x731y5i.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 URIBL_BLOCKED(0.00)[linaro.org:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:mid,suse.de:dkim,suse.de:email];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 ARC_NA(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 MIME_TRACE(0.00)[0:+];
 FREEMAIL_CC(0.00)[kaod.org,aspeedtech.com,gmail.com,codeconstruct.com.au,jms.id.au];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCPT_COUNT_SEVEN(0.00)[9]; MISSING_XM_UA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid, suse.de:dkim, suse.de:email,
 imap1.dmz-prg2.suse.org:helo, imap1.dmz-prg2.suse.org:rdns, linaro.org:email]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 485F64D2E3
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Peter Maydell <peter.maydell@linaro.org> writes:

> This patchset fixes a couple more -Wformat-overflow=2 warnings with
> gcc 7.5.0. Same issue as this other series I just posted, but two
> different files:
>
> https://lore.kernel.org/qemu-devel/20260310151507.2973843-1-peter.maydell@linaro.org/
>
> Since there's no dependency between the two sets of patches I sent
> this out as a separate series rather than a v2 with those others
> folded in.
>
> thanks
> -- PMM
>
> Peter Maydell (2):
>   tests/qtest/ast2700-gpio-test: Use g_strdup_printf() instead of char
>     arrays
>   tests/qtest/aspeed_gpio-test: Use g_strdup_printf() instead of char
>     arrays
>
>  tests/qtest/aspeed_gpio-test.c  | 4 ++--
>  tests/qtest/ast2700-gpio-test.c | 3 +--
>  2 files changed, 3 insertions(+), 4 deletions(-)

Series:

Tested-by: Fabiano Rosas <farosas@suse.de>

