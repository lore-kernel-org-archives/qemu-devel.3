Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F21A3C0218A
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 14:28:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcmZ7-0006Uh-CV; Tue, 28 Jan 2025 09:27:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tcmZ4-0006U2-3w
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 09:27:42 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tcmZ1-0002zo-P1
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 09:27:41 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7C9EF210F8;
 Tue, 28 Jan 2025 14:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1738074456; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZHh2LntsDy1HJCYBeSyUm239Dvkdr8KtlmAUYs4lGPU=;
 b=KJ7KeduA0KTUEDxeXF6yGuL0zKItfQabz1x95mpmLHDZWWZNFrxP7ZoPLhHmgtDhu4JkqS
 +rv/3tbN2LtLZyiVhJV4afmK3nIKpHGA92tpqLaTHt8J4yH2BvJG4GF4H2ht9uYGYATFhQ
 SBEo5sYz3izo0CGFet3+jgjgoKqy1/Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1738074456;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZHh2LntsDy1HJCYBeSyUm239Dvkdr8KtlmAUYs4lGPU=;
 b=FPezol4cIqSKIlBLr+AIxb1giDuq28ZxSxOOpSRWT8KuecruRERSuRR12QZrRgR6qtAYBH
 s7Bv8+tBbKNlyvAQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=KJ7KeduA;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=FPezol4c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1738074456; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZHh2LntsDy1HJCYBeSyUm239Dvkdr8KtlmAUYs4lGPU=;
 b=KJ7KeduA0KTUEDxeXF6yGuL0zKItfQabz1x95mpmLHDZWWZNFrxP7ZoPLhHmgtDhu4JkqS
 +rv/3tbN2LtLZyiVhJV4afmK3nIKpHGA92tpqLaTHt8J4yH2BvJG4GF4H2ht9uYGYATFhQ
 SBEo5sYz3izo0CGFet3+jgjgoKqy1/Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1738074456;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZHh2LntsDy1HJCYBeSyUm239Dvkdr8KtlmAUYs4lGPU=;
 b=FPezol4cIqSKIlBLr+AIxb1giDuq28ZxSxOOpSRWT8KuecruRERSuRR12QZrRgR6qtAYBH
 s7Bv8+tBbKNlyvAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DC99A13715;
 Tue, 28 Jan 2025 14:27:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 1vIzJlfpmGekDAAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 28 Jan 2025 14:27:35 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier
 <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>, Hyman Huang
 <yong.huang@smartx.com>, Phil Dennis-Jordan <phil@philjordan.eu>, Peter Xu
 <peterx@redhat.com>, Akihiko Odaki <akihiko.odaki@daynix.com>, Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH 1/7] migration/dirtyrate: Do not unlock cpu_list lock twice
In-Reply-To: <20250128135429.8500-2-philmd@linaro.org>
References: <20250128135429.8500-1-philmd@linaro.org>
 <20250128135429.8500-2-philmd@linaro.org>
Date: Tue, 28 Jan 2025 11:27:01 -0300
Message-ID: <87y0yvt3nu.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 7C9EF210F8
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.98%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MISSING_XM_UA(0.00)[]; RCPT_COUNT_SEVEN(0.00)[10];
 MIME_TRACE(0.00)[0:+]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,linaro.org:email];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> &qemu_cpu_list_lock is locked within the WITH_QEMU_LOCK_GUARD()
> context, then unlocked. No need to manually unlock it.
>
> Fixes: 370ed600296 ("cpu: expose qemu_cpu_list_lock for lock-guard use")
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  migration/dirtyrate.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/migration/dirtyrate.c b/migration/dirtyrate.c
> index 7c955894e47..4b94dd7c500 100644
> --- a/migration/dirtyrate.c
> +++ b/migration/dirtyrate.c
> @@ -174,7 +174,6 @@ retry:
>          if (gen_id !=3D cpu_list_generation_id_get()) {
>              g_free(records);
>              g_free(stat->rates);
> -            cpu_list_unlock();
>              goto retry;
>          }
>          vcpu_dirty_stat_collect(records, false);

Reviewed-by: Fabiano Rosas <farosas@suse.de>

