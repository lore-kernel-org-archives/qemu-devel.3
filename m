Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5E93C35FFA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 12:08:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tusD4-0001AI-1n; Wed, 19 Mar 2025 08:07:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tusCM-00017a-4c
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 08:07:03 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tusCH-0005eq-4S
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 08:07:01 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id AB68921A2F;
 Wed, 19 Mar 2025 12:06:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1742386014; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jWM7YfEqLmzE9x5pq+ouP5CaRuA3coi99kshrhr3x8I=;
 b=qhGOexx2Nt/Uj9ex5da/tRCWBgYKc7HCr8n561woE4T1eO+EtVlwTee57j9kaDKPC0wfwl
 v2vzDBd74Uh6caYHNJrDqK1gqLxKOvULN63fH0ed5RzQX3PAnTF+wIdbDXbj9zU+W9J+Zm
 jPFiq3jwUctFPUH8QdrADFPdW8dH2c0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1742386014;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jWM7YfEqLmzE9x5pq+ouP5CaRuA3coi99kshrhr3x8I=;
 b=1RLGf9KetkCj7lgoolHjoFAm8ZEa1iAmwuJOEwtfqDuaf1ZWYzZ5D490zGivXuf/q6btaQ
 Y6GUxpTJWApCE1DA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=qhGOexx2;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=1RLGf9Ke
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1742386014; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jWM7YfEqLmzE9x5pq+ouP5CaRuA3coi99kshrhr3x8I=;
 b=qhGOexx2Nt/Uj9ex5da/tRCWBgYKc7HCr8n561woE4T1eO+EtVlwTee57j9kaDKPC0wfwl
 v2vzDBd74Uh6caYHNJrDqK1gqLxKOvULN63fH0ed5RzQX3PAnTF+wIdbDXbj9zU+W9J+Zm
 jPFiq3jwUctFPUH8QdrADFPdW8dH2c0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1742386014;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jWM7YfEqLmzE9x5pq+ouP5CaRuA3coi99kshrhr3x8I=;
 b=1RLGf9KetkCj7lgoolHjoFAm8ZEa1iAmwuJOEwtfqDuaf1ZWYzZ5D490zGivXuf/q6btaQ
 Y6GUxpTJWApCE1DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2672F13726;
 Wed, 19 Mar 2025 12:06:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id tb7TNF2z2mejAwAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 19 Mar 2025 12:06:53 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Bibo Mao <maobibo@loongson.cn>, Laurent Vivier <lvivier@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov
 <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 6/6] tests/qtest: Enable bios-tables-test for LoongArch
In-Reply-To: <20250228092729.543097-7-maobibo@loongson.cn>
References: <20250228092729.543097-1-maobibo@loongson.cn>
 <20250228092729.543097-7-maobibo@loongson.cn>
Date: Wed, 19 Mar 2025 09:06:51 -0300
Message-ID: <8734f9b4x0.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: AB68921A2F
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MID_RHS_MATCH_FROM(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_SEVEN(0.00)[9];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:email,suse.de:dkim,suse.de:mid];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
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

Bibo Mao <maobibo@loongson.cn> writes:

> Enable bios-tables-test for LoongArch virt machine, it passes to run
> with command "make check-qtest-loongarch64".
>
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>  tests/qtest/meson.build | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
> index 8a6243382a..8628eebfbc 100644
> --- a/tests/qtest/meson.build
> +++ b/tests/qtest/meson.build
> @@ -149,7 +149,8 @@ qtests_hppa = \
>  
>  qtests_loongarch64 = qtests_filter + \
>    (config_all_devices.has_key('CONFIG_LOONGARCH_VIRT') ? ['numa-test'] : []) + \
> -  ['boot-serial-test']
> +  ['boot-serial-test'] + \
> +  (unpack_edk2_blobs ? ['bios-tables-test'] : [])
>  
>  qtests_m68k = ['boot-serial-test'] + \
>    qtests_filter

Reviewed-by: Fabiano Rosas <farosas@suse.de>

