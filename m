Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AE3EEB4917
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 12:47:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqW5V-0002fI-My; Thu, 12 Feb 2026 07:46:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vqW5Q-0002eX-QF
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 07:46:26 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vqW5P-0004JY-6y
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 07:46:24 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id AE78C5BD9B;
 Thu, 12 Feb 2026 12:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1770900379; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=j0bX4jdpdGzLJ/a34OtGooFkPfvDTfhUjrtlGaUgqak=;
 b=gZEjYwz3mn3h/ePJaAsvEf52hsLal2kGTYYAdThmpfZLIM2B7mfgfgpxDFbHWFQ3K5J3xl
 3jZ4/9oJOj7K/yURIWsvOMI+u6o+bd6tRnmKKiJo82xXaGjA1A+3Rxp8FD9JrIuxqOWFgM
 QNkhriYiLseWaJk6837frbPCeDvMVzs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1770900379;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=j0bX4jdpdGzLJ/a34OtGooFkPfvDTfhUjrtlGaUgqak=;
 b=fIuqVT9VIE5BUcpYZgFXbh3POJ7pbz9MBGvs0V3s9FAaawK7qED0/HjXK6AkOLQKwwYNrw
 q30xbIZvO5d82nDw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=gZEjYwz3;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=fIuqVT9V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1770900379; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=j0bX4jdpdGzLJ/a34OtGooFkPfvDTfhUjrtlGaUgqak=;
 b=gZEjYwz3mn3h/ePJaAsvEf52hsLal2kGTYYAdThmpfZLIM2B7mfgfgpxDFbHWFQ3K5J3xl
 3jZ4/9oJOj7K/yURIWsvOMI+u6o+bd6tRnmKKiJo82xXaGjA1A+3Rxp8FD9JrIuxqOWFgM
 QNkhriYiLseWaJk6837frbPCeDvMVzs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1770900379;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=j0bX4jdpdGzLJ/a34OtGooFkPfvDTfhUjrtlGaUgqak=;
 b=fIuqVT9VIE5BUcpYZgFXbh3POJ7pbz9MBGvs0V3s9FAaawK7qED0/HjXK6AkOLQKwwYNrw
 q30xbIZvO5d82nDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 259783EA62;
 Thu, 12 Feb 2026 12:46:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id egwXNprLjWkwVAAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 12 Feb 2026 12:46:18 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH] tests/qtest/migration/tls-tests.c: Don't use tls_psk
 end hook for no_tls tests
In-Reply-To: <20260212114747.1103466-1-peter.maydell@linaro.org>
References: <20260212114747.1103466-1-peter.maydell@linaro.org>
Date: Thu, 12 Feb 2026 09:46:16 -0300
Message-ID: <87v7g2m8o7.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_HAS_DN(0.00)[]; DKIM_TRACE(0.00)[suse.de:+];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email, suse.de:dkim, suse.de:mid,
 suse.de:email]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: AE78C5BD9B
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
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

Peter Maydell <peter.maydell@linaro.org> writes:

> If you run the TLS tests under a clang undefined-behaviour sanitizer build
> it will fall over like this:
>
> ../../tests/unit/crypto-tls-psk-helpers.c:53:12: runtime error: null pointer passed as argument 1, which is declared to never be null
> /usr/include/unistd.h:858:48: note: nonnull attribute specified here
>     #0 0x62bd810762ee in test_tls_psk_cleanup /home/pm215/qemu/build/clang/../../tests/unit/crypto-tls-psk-helpers.c:53:5
>     #1 0x62bd81073f89 in migrate_hook_end_tls_psk /home/pm215/qemu/build/clang/../../tests/qtest/migration/tls-tests.c:101:5
>     #2 0x62bd81062ef0 in test_precopy_common /home/pm215/qemu/build/clang/../../tests/qtest/migration/framework.c:947:9
>
> This happens because test_precopy_tcp_no_tls() uses a custom start_hook
> that only sets a couple of parameters, but reuses the tsk_psk end_hook.
> However, the end_hook runs cleanup that assumes that the data was set
> up by migrate_hook_start_tls_psk_common(). In particular, it will
> unconditionally call test_tls_psk_cleanup(data->pskfile), and
> test_tls_psk_cleanup() will unconditionally unlink() the filename it
> is passed, which is undefined behaviour if you pass it a NULL pointer.
>
> Instead of creating a TestMigrateTLSPSKData struct which we never set
> any fields in and requiring the migrate_hook_end_tls_psk() hook to
> cope with that, don't allocate the struct in the start_hook. Then
> there is nothing we need to clean up, and we can set the end_hook
> to NULL (which the test framework will interpret as "don't call
> any end_hook").
>

Thanks! My pull-request script should have caught this. I recently
excluded the TLS tests because they break ASAN in weird ways.

Reviewed-by: Fabiano Rosas <farosas@suse.de>

> Cc: qemu-stable@nongnu.org
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> Not sure when this would have appeared, so cc'ing stable as it
> seems safe enough to backport just in case.

It's from this devel cycle.



