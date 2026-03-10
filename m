Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61EB9EB1074
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 15:50:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzzLp-0001Fi-Rb; Tue, 10 Mar 2026 11:50:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vzzLi-00019i-02
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 11:50:23 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vzzLf-0003Kn-Mt
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 11:50:21 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id BA5AF5BCEA;
 Tue, 10 Mar 2026 15:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1773157817; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KqGw1FkWQgMlmSu6lIptcV8ac5mwdhBuMaOYvVh/hbI=;
 b=bhq4QOHPhvpHwQPLogqFmM73/jtPU+70jqZmdmJ33LHS/3E1BBel6a+XlwjQ5lxdKtdfXX
 vIR2l8VpF4LqJA6TpGnlDsGwkBsoHsQqkNQ8DRN7gLcLvzQPXGeWIiN3QkoSWIXpsPLcnv
 sZyzfd5lSBWdf4Nbwa/IZS9yWr0kRPY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1773157817;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KqGw1FkWQgMlmSu6lIptcV8ac5mwdhBuMaOYvVh/hbI=;
 b=EWHc4GJm/5yTQ6S/kLQClnDlrQmMZzx0bI1MdXSDQd2jAEfoezeig9cKqw0qE5tPXJq6n7
 7kVGJrKAIiKjfqCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1773157817; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KqGw1FkWQgMlmSu6lIptcV8ac5mwdhBuMaOYvVh/hbI=;
 b=bhq4QOHPhvpHwQPLogqFmM73/jtPU+70jqZmdmJ33LHS/3E1BBel6a+XlwjQ5lxdKtdfXX
 vIR2l8VpF4LqJA6TpGnlDsGwkBsoHsQqkNQ8DRN7gLcLvzQPXGeWIiN3QkoSWIXpsPLcnv
 sZyzfd5lSBWdf4Nbwa/IZS9yWr0kRPY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1773157817;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KqGw1FkWQgMlmSu6lIptcV8ac5mwdhBuMaOYvVh/hbI=;
 b=EWHc4GJm/5yTQ6S/kLQClnDlrQmMZzx0bI1MdXSDQd2jAEfoezeig9cKqw0qE5tPXJq6n7
 7kVGJrKAIiKjfqCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 44AD53F526;
 Tue, 10 Mar 2026 15:50:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id fcRYA7k9sGncbAAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 10 Mar 2026 15:50:17 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>, Steven Lee
 <steven_lee@aspeedtech.com>,
 Troy Lee <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew
 Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>
Subject: Re: [PATCH 0/2] tests/qtest: Avoid char arrays in some Arm tests
In-Reply-To: <20260310151507.2973843-1-peter.maydell@linaro.org>
References: <20260310151507.2973843-1-peter.maydell@linaro.org>
Date: Tue, 10 Mar 2026 12:50:14 -0300
Message-ID: <878qbz1y6h.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[]; MIME_TRACE(0.00)[0:+];
 MISSING_XM_UA(0.00)[]; RCPT_COUNT_SEVEN(0.00)[9];
 MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[kaod.org,aspeedtech.com,gmail.com,codeconstruct.com.au,jms.id.au];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.de:mid,
 suse.de:email, linaro.org:email]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
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

Peter Maydell <peter.maydell@linaro.org> writes:

> This patchset fixes a couple of problems reported by Fabiano Rosas
> with gcc 7.5.0 now we have turned on -Wformat-overflow=2. In both
> cases the test is using sprintf() into a fixed-size char array, and
> it can't actually overflow but gcc doesn't realize that. We prefer
> to use g_strdup_printf() for this kind of thing anyway, as it is
> much less error-prone, so switch to that.
>
> thanks
> -- PMM
>
> Peter Maydell (2):
>   tests/qtest/ast2700-sgpio-test: Use g_strdup_printf() instead of char
>     arrays
>   tests/qtest/arm-cpu-features: Use g_strdup_printf() instead of char
>     arrays
>
>  tests/qtest/arm-cpu-features.c   | 24 +++++++++++++++---------
>  tests/qtest/ast2700-sgpio-test.c | 24 ++++++++++++------------
>  2 files changed, 27 insertions(+), 21 deletions(-)

Series:

Tested-by: Fabiano Rosas <farosas@suse.de>

