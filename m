Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79E7BCAC59A
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Sep 2025 14:13:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzFNR-0004In-JL; Thu, 18 Sep 2025 10:12:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uzFNQ-0004IX-3V
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 10:12:48 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uzFNN-0008FE-5T
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 10:12:46 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 69F4B1F793;
 Thu, 18 Sep 2025 14:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1758204763; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=V3Pi6IHwfYfAdrdI+IVQ9HKYE1bRTYYjSpQ4IY7Ovtw=;
 b=Q71JnlF4QRph3cPEzMk9f+spTA+MVK9exh75Aqoi4XSaGL4JZzAwW1VQ0ZF2xDzDaqeubK
 pVUhjHfwyknampN7iOi5P4nuim7DH7UaqR5fp/Nffz2hWDG3GNGXaxni73+JcQ7Kza9W1Y
 1yQ1xblf9SQdyOn7+Dr+R3r6S0Kp30M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1758204763;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=V3Pi6IHwfYfAdrdI+IVQ9HKYE1bRTYYjSpQ4IY7Ovtw=;
 b=u1bRfZAU8H7MWvXIihS7UV/OcT36nRk9cGx7XOvIeoGbohpvvlpyO/1bTx712uCNSZaNmS
 Gpo+ssjLNscOWUCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1758204763; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=V3Pi6IHwfYfAdrdI+IVQ9HKYE1bRTYYjSpQ4IY7Ovtw=;
 b=Q71JnlF4QRph3cPEzMk9f+spTA+MVK9exh75Aqoi4XSaGL4JZzAwW1VQ0ZF2xDzDaqeubK
 pVUhjHfwyknampN7iOi5P4nuim7DH7UaqR5fp/Nffz2hWDG3GNGXaxni73+JcQ7Kza9W1Y
 1yQ1xblf9SQdyOn7+Dr+R3r6S0Kp30M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1758204763;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=V3Pi6IHwfYfAdrdI+IVQ9HKYE1bRTYYjSpQ4IY7Ovtw=;
 b=u1bRfZAU8H7MWvXIihS7UV/OcT36nRk9cGx7XOvIeoGbohpvvlpyO/1bTx712uCNSZaNmS
 Gpo+ssjLNscOWUCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D801913A51;
 Thu, 18 Sep 2025 14:12:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id MY7wJFoTzGggQAAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 18 Sep 2025 14:12:42 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Juraj Marcin <jmarcin@redhat.com>, =?utf-8?Q?Daniel_P_=2E_Berrang?=
 =?utf-8?Q?=C3=A9?= <berrange@redhat.com>, peterx@redhat.com
Subject: Re: [PATCH v2 1/3] io/crypto: Move tls premature termination
 handling into QIO layer
In-Reply-To: <20250911212355.1943494-2-peterx@redhat.com>
References: <20250911212355.1943494-1-peterx@redhat.com>
 <20250911212355.1943494-2-peterx@redhat.com>
Date: Thu, 18 Sep 2025 11:12:39 -0300
Message-ID: <87ecs3voh4.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Peter Xu <peterx@redhat.com> writes:

> QCryptoTLSSession allows TLS premature termination in two cases, one of the
> case is when the channel shutdown() is invoked on READ side.
>
> It's possible the shutdown() happened after the read thread blocked at
> gnutls_record_recv().  In this case, we should allow the premature
> termination to happen.
>
> The problem is by the time qcrypto_tls_session_read() was invoked,
> tioc->shutdown may not have been set, so this may instead be treated as an
> error if there is concurrent shutdown() calls.
>
> To allow the flag to reflect the latest status of tioc->shutdown, move the
> check upper into the QIOChannel level, so as to read the flag only after
> QEMU gets an GNUTLS_E_PREMATURE_TERMINATION.
>
> When at it, introduce qio_channel_tls_allow_premature_termination() helper
> to make the condition checks easier to read.
>
> This patch will fix a qemu qtest warning when running the preempt tls test,
> reporting premature termination:
>
> QTEST_QEMU_BINARY=./qemu-system-x86_64 ./tests/qtest/migration-test --full -r /x86_64/migration/postcopy/preempt/tls/psk
> ...
> qemu-kvm: Cannot read from TLS channel: The TLS connection was non-properly terminated.
> ...
>
> In this specific case, the error was set by postcopy_preempt_thread, which
> normally will be concurrently shutdown()ed by the main thread.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Fabiano Rosas <farosas@suse.de>

