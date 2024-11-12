Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 181C0D32D9F
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2024 12:58:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAqTI-0003dc-7E; Tue, 12 Nov 2024 07:58:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tAqTD-0003dI-Hd
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 07:58:11 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tAqTB-00026n-In
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 07:58:11 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9FF04215D0;
 Tue, 12 Nov 2024 12:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1731416287; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bcTd62WEdst5nlPFHXQY7URZL2t7JcXLDa6f4tgYUO0=;
 b=XSHok/FolImPn1wIMogdnZfTGL45FhpR4TQfJTFi/rQXRaeSWJc8Y1vXKLLhieBY5CDiFM
 mtZLvwUDHdn8UGr5LzXDIZEKG/mozsMl+ujYnQRgHPVwEKZ5v43iZDIG+b0COEPD4glL1K
 UDzh3B6jPm8Y4aVYkI4Wu8tHC78C070=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1731416287;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bcTd62WEdst5nlPFHXQY7URZL2t7JcXLDa6f4tgYUO0=;
 b=fiK7yOb+cmNp+79AgDWrswdL3PT5aWDNX4QIZe4ywoTHYH3zzcTwgVbOx1IogFJpIGQ6ts
 etZQ23nbp1PlorDg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="XSHok/Fo";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=fiK7yOb+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1731416287; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bcTd62WEdst5nlPFHXQY7URZL2t7JcXLDa6f4tgYUO0=;
 b=XSHok/FolImPn1wIMogdnZfTGL45FhpR4TQfJTFi/rQXRaeSWJc8Y1vXKLLhieBY5CDiFM
 mtZLvwUDHdn8UGr5LzXDIZEKG/mozsMl+ujYnQRgHPVwEKZ5v43iZDIG+b0COEPD4glL1K
 UDzh3B6jPm8Y4aVYkI4Wu8tHC78C070=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1731416287;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bcTd62WEdst5nlPFHXQY7URZL2t7JcXLDa6f4tgYUO0=;
 b=fiK7yOb+cmNp+79AgDWrswdL3PT5aWDNX4QIZe4ywoTHYH3zzcTwgVbOx1IogFJpIGQ6ts
 etZQ23nbp1PlorDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2AC4613301;
 Tue, 12 Nov 2024 12:58:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id skGRON5QM2f0YQAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 12 Nov 2024 12:58:06 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Dmitry Frolov <frolov@swemel.ru>, lvivier@redhat.com
Cc: sdl.qemu@linuxtesting.org, qemu-devel@nongnu.org, Dmitry Frolov
 <frolov@swemel.ru>
Subject: Re: [PATCH] tests/qtest: increase timeouts
In-Reply-To: <20241112120100.176492-2-frolov@swemel.ru>
References: <20241112120100.176492-2-frolov@swemel.ru>
Date: Tue, 12 Nov 2024 09:58:04 -0300
Message-ID: <87ed3gip7n.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 9FF04215D0
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim, suse.de:mid,
 imap1.dmz-prg2.suse.org:helo, imap1.dmz-prg2.suse.org:rdns]
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

Dmitry Frolov <frolov@swemel.ru> writes:

> More time for some tests needed when qemu is built with
> "--enable-asan --enable-ubsan"
>
> Signed-off-by: Dmitry Frolov <frolov@swemel.ru>
> ---
>  tests/qtest/meson.build | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
> index aa93e98418..ead2207f9c 100644
> --- a/tests/qtest/meson.build
> +++ b/tests/qtest/meson.build
> @@ -5,7 +5,7 @@ slow_qtests = {
>    'cdrom-test' : 610,
>    'device-introspect-test' : 720,
>    'ide-test' : 120,
> -  'migration-test' : 480,
> +  'migration-test' : 600,
>    'npcm7xx_pwm-test': 300,
>    'npcm7xx_watchdog_timer-test': 120,
>    'qmp-cmd-test' : 120,
> @@ -15,7 +15,7 @@ slow_qtests = {
>    'pxe-test': 610,
>    'prom-env-test': 360,
>    'boot-serial-test': 360,
> -  'qos-test': 120,
> +  'qos-test': 240,
>    'vmgenid-test': 610,
>  }

I'm not sure this is the right change to make. In my machine a different
set of tests times out when using asan. Besides, the timeouts are mostly
tailored for the CI environment.

Would it be possible to check whether the build has asan enabled and
just use a global timeout? I'm afraid tweaking individual tests timeouts
will hide real slowness issues when not using asan.

