Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1198BFEFB7C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 18:59:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vw32L-0006L3-5I; Fri, 27 Feb 2026 13:58:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vw32I-0006K6-VM
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 13:58:02 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vw32H-0003fR-04
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 13:58:02 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id EC1003F834;
 Fri, 27 Feb 2026 18:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1772218679; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aWCZ9qBqV2k5e4A2hKTflr8hIwiOiaVsUjptDR5jARY=;
 b=RC7CFKSS2AiScByNZZX0kZ9n3xM/GvpFtFe1LQKFU355CEWVpm+ZbCawPTAkED+CWH7qYN
 oV4o4SexAyEAcp2Q4DcIRDi6jQHBAxj47sMpziGlIg+HwmZJ6Msf3duu6EjZL9/8TbY6tg
 lcEboOC1GK2q0BYvz80StOK91e7sJ4g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1772218679;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aWCZ9qBqV2k5e4A2hKTflr8hIwiOiaVsUjptDR5jARY=;
 b=XKD4RYhvTt9G0r2pa2zbbs7s1VvWDnt3lw/wxNT8U9amg46rMqb0seXyp556ckJUeDdxtY
 3zq+EonsjTl4PkDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1772218678; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aWCZ9qBqV2k5e4A2hKTflr8hIwiOiaVsUjptDR5jARY=;
 b=GXlTG0CpHYpQMjMSLhJL6fab7s/+7TZ6BRCfjmvVE3rpy8dCc3qmBVdpeUSYqNdNv4OoVM
 fjdi4I9+irGU7VEDx4GuDPNTRJUKcKWYdFQTSxHlSmC0qu7Aod1S4ZXpsErO72Jvx4w3yL
 7Xhc259qcvoH1idE8pbKCTfw/T9h9PE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1772218678;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aWCZ9qBqV2k5e4A2hKTflr8hIwiOiaVsUjptDR5jARY=;
 b=Z1pBQtGww3y/PGJC/NpcoTP2aQnufYvL1kCC2HQAQnJra9Lzk62nFVhSiB09myLuN21H2b
 7ACnIg59pq7kz5AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 72D303EA69;
 Fri, 27 Feb 2026 18:57:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id IWkLDjbpoWnsEQAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 27 Feb 2026 18:57:58 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH 2/4] scripts/lsan_suppressions.txt: Add more leaks
In-Reply-To: <20260227135736.2280161-3-peter.maydell@linaro.org>
References: <20260227135736.2280161-1-peter.maydell@linaro.org>
 <20260227135736.2280161-3-peter.maydell@linaro.org>
Date: Fri, 27 Feb 2026 15:57:55 -0300
Message-ID: <87ikbi580c.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_FIVE(0.00)[6];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid, suse.de:email,
 imap1.dmz-prg2.suse.org:helo, linaro.org:email]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

> Running "make check" with the clang leak sanitizer reveals some
> leak reports which are either not our problem or else not
> a leak which is worth our time to fix. Add some suppressions
> for these.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Fabiano Rosas <farosas@suse.de>

FYI, mine has these. The first one is on my list to fix once I find some
time. The last two seem to be part of the stack for the ones you added
here.

leak:qcrypto_tls_session_push
leak:gnutls_handshake
leak:memory_region_do_init
leak:qos_traverse_graph
leak:qdev_get_named_gpio_list

> ---
>  scripts/lsan_suppressions.txt | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>
> diff --git a/scripts/lsan_suppressions.txt b/scripts/lsan_suppressions.txt
> index ffade3ba5a..bd6ef07079 100644
> --- a/scripts/lsan_suppressions.txt
> +++ b/scripts/lsan_suppressions.txt
> @@ -9,3 +9,23 @@ leak:/lib64/libtcmalloc_minimal.so.4
>  
>  # libxkbcommon also leaks in qemu-keymap
>  leak:/lib64/libxkbcommon.so.0
> +
> +# g_set_user_dirs() deliberately leaks the previous cached g_get_user_*
> +# values. This is documented in upstream glib's valgrind-format
> +# suppression file:
> +# https://github.com/GNOME/glib/blob/main/tools/glib.supp
> +# This avoids false positive leak reports for the qga-ssh-test.
> +leak:g_set_user_dirs
> +
> +# The walk_path() function in qos-test does free its memory,
> +# but something about the setup with tests run in a subprocess
> +# seems to confuse the sanitizer. Suppress the errors.
> +leak:walk_path
> +
> +# qemu_irq_intercept_in is only used by the qtest harness, and
> +# its API inherently involves a leak.
> +# While we could keep track of the old IRQ data structure
> +# in order to free it, it doesn't seem very important to fix
> +# since it is only used by the qtest test harness.
> +# Just ignore the leak, at least for the moment.
> +leak:qemu_irq_intercept_in

