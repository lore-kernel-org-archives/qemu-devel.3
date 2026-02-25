Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D645FD377E
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 18:38:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvJlr-000219-Mx; Wed, 25 Feb 2026 13:38:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vvJlq-000211-JH
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 13:38:02 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vvJlo-00084J-Rv
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 13:38:02 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 5711A5C236;
 Wed, 25 Feb 2026 18:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1772044674; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1euMDP8A44lA/oYDLZBrTkE1nc3WUd+vo6n3V4QQ12A=;
 b=2TEmJhBZrXILM81Hi8xLTcmQSbsbpnU1KO1qBvI6VLilIxzlRUnvdyJuyKFtHEqVe8wfLR
 viHvv7+tmC94lMZ5fwj81tXmMS4PxmM9yn2pccHlEklAjyTMaA6PCNwkisempKipuHJgML
 MdH4wcTQJRQBb7Ifflr/SpId7RvIH5Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1772044674;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1euMDP8A44lA/oYDLZBrTkE1nc3WUd+vo6n3V4QQ12A=;
 b=QbMg4pDFHD99hVoGI3Iotxe6T7cc0Z2OLy9z/9mew7BPPCMTl9J8C1GOQ7+jKN856e4D8N
 hR0oQkPo4cXXFPCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1772044674; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1euMDP8A44lA/oYDLZBrTkE1nc3WUd+vo6n3V4QQ12A=;
 b=2TEmJhBZrXILM81Hi8xLTcmQSbsbpnU1KO1qBvI6VLilIxzlRUnvdyJuyKFtHEqVe8wfLR
 viHvv7+tmC94lMZ5fwj81tXmMS4PxmM9yn2pccHlEklAjyTMaA6PCNwkisempKipuHJgML
 MdH4wcTQJRQBb7Ifflr/SpId7RvIH5Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1772044674;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1euMDP8A44lA/oYDLZBrTkE1nc3WUd+vo6n3V4QQ12A=;
 b=QbMg4pDFHD99hVoGI3Iotxe6T7cc0Z2OLy9z/9mew7BPPCMTl9J8C1GOQ7+jKN856e4D8N
 hR0oQkPo4cXXFPCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C51313EA65;
 Wed, 25 Feb 2026 18:37:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id OOEXIoFBn2lzXAAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 25 Feb 2026 18:37:53 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, "Edgar E.
 Iglesias" <edgar.iglesias@gmail.com>
Cc: devel@lists.libvirt.org, Alex =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Eric Blake
 <eblake@redhat.com>, Zhao
 Liu <zhao1.liu@intel.com>, Eduardo Habkost <eduardo@habkost.net>, Markus
 Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Mahmoud Mandour
 <ma.mandourr@gmail.com>, Djordje Todorovic
 <Djordje.Todorovic@htecgroup.com>
Subject: Re: [PATCH 2/4] tests/qtest: Remove the microblazeel target from
 the qtests
In-Reply-To: <20260225161823.1438850-3-thuth@redhat.com>
References: <20260225161823.1438850-1-thuth@redhat.com>
 <20260225161823.1438850-3-thuth@redhat.com>
Date: Wed, 25 Feb 2026 15:37:50 -0300
Message-ID: <878qcg3c01.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_TLS_ALL(0.00)[]; ARC_NA(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; MISSING_XM_UA(0.00)[];
 RCPT_COUNT_TWELVE(0.00)[14]; MIME_TRACE(0.00)[0:+];
 TAGGED_RCPT(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[lists.libvirt.org,linaro.org,redhat.com,intel.com,habkost.net,crans.org,gmail.com,htecgroup.com];
 FREEMAIL_TO(0.00)[redhat.com,nongnu.org,gmail.com];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
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

Thomas Huth <thuth@redhat.com> writes:

> From: Thomas Huth <thuth@redhat.com>
>
> The "petalogix-ml605" boot-serial-test can be run with the
> "microblaze" target. The remaining tests can simply be dropped
> now that we are going to remove the "microblazeel" target.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  tests/qtest/boot-serial-test.c  | 2 +-
>  tests/qtest/machine-none-test.c | 1 -
>  tests/qtest/meson.build         | 2 --
>  3 files changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/tests/qtest/boot-serial-test.c b/tests/qtest/boot-serial-test.c
> index a05d26ee996..bcd0a9c50e7 100644
> --- a/tests/qtest/boot-serial-test.c
> +++ b/tests/qtest/boot-serial-test.c
> @@ -186,7 +186,7 @@ static const testdef_t tests[] = {
>      { "m68k", "next-cube", "", "TT", sizeof(bios_nextcube), 0, bios_nextcube },
>      { "microblaze", "petalogix-s3adsp1800", "", "TT",
>        sizeof(kernel_pls3adsp1800), kernel_pls3adsp1800 },
> -    { "microblazeel", "petalogix-ml605", "", "TT",
> +    { "microblaze", "petalogix-ml605", "", "TT",
>        sizeof(kernel_plml605), kernel_plml605 },
>      { "arm", "raspi2b", "", "TT", sizeof(bios_raspi2), 0, bios_raspi2 },
>      { "aarch64", "virt", "-cpu max", "TT", sizeof(kernel_aarch64),
> diff --git a/tests/qtest/machine-none-test.c b/tests/qtest/machine-none-test.c
> index b6a87d27edb..c1e22dcecc7 100644
> --- a/tests/qtest/machine-none-test.c
> +++ b/tests/qtest/machine-none-test.c
> @@ -32,7 +32,6 @@ static struct arch2cpu cpus_map[] = {
>      { "alpha", "ev67" },
>      { "m68k", "m5206" },
>      { "microblaze", "any" },
> -    { "microblazeel", "any" },
>      { "mips", "4Kc" },
>      { "mipsel", "I7200" },
>      { "mips64", "20Kc" },
> diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
> index 25fdbc79801..ba9f59d2f8f 100644
> --- a/tests/qtest/meson.build
> +++ b/tests/qtest/meson.build
> @@ -159,8 +159,6 @@ qtests_m68k = ['boot-serial-test'] + \
>  qtests_microblaze = ['boot-serial-test'] + \
>    qtests_filter
>  
> -qtests_microblazeel = qtests_microblaze
> -
>  qtests_mips = \
>    qtests_filter + \
>    (config_all_devices.has_key('CONFIG_ISA_TESTDEV') ? ['endianness-test'] : []) +            \

Reviewed-by: Fabiano Rosas <farosas@suse.de>

