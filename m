Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6742C02182
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 13:51:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taEeS-0002ev-Oy; Tue, 21 Jan 2025 08:50:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1taEeQ-0002ds-1s; Tue, 21 Jan 2025 08:50:42 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1taEeN-0006Qw-OR; Tue, 21 Jan 2025 08:50:41 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 765C721168;
 Tue, 21 Jan 2025 13:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1737467436; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tRX5FUOxVzYMcXAG+qDCvvIrO+z1A6IDexczs7hrlVM=;
 b=ZO5MRIdmlQzXFGu0q0z8PLINmh1xKIjVE+0f8ez5cTu7B4ohH3Y46cW2w6OVKrZJTUvkS9
 mc1geweFpPsm7EAoIlcpty2EQlvQJqX/03NRhP9VdqW4pgd92OR1UFsVQrlFz0bjUr3WNb
 ioUOZcFXLxqhTEiNg/vxwbUL41+h0jo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1737467436;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tRX5FUOxVzYMcXAG+qDCvvIrO+z1A6IDexczs7hrlVM=;
 b=gXkkxhOVKRWLhUJbjddbAQLljGgXDCQwXemA0XCu7o1fXhfXLiCiNhsWgfbH+CcOLbCZOD
 k0VTlV5IuwpZFjAQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ZO5MRIdm;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=gXkkxhOV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1737467436; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tRX5FUOxVzYMcXAG+qDCvvIrO+z1A6IDexczs7hrlVM=;
 b=ZO5MRIdmlQzXFGu0q0z8PLINmh1xKIjVE+0f8ez5cTu7B4ohH3Y46cW2w6OVKrZJTUvkS9
 mc1geweFpPsm7EAoIlcpty2EQlvQJqX/03NRhP9VdqW4pgd92OR1UFsVQrlFz0bjUr3WNb
 ioUOZcFXLxqhTEiNg/vxwbUL41+h0jo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1737467436;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tRX5FUOxVzYMcXAG+qDCvvIrO+z1A6IDexczs7hrlVM=;
 b=gXkkxhOVKRWLhUJbjddbAQLljGgXDCQwXemA0XCu7o1fXhfXLiCiNhsWgfbH+CcOLbCZOD
 k0VTlV5IuwpZFjAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E3ED613963;
 Tue, 21 Jan 2025 13:50:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id MxvpJyumj2cOagAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 21 Jan 2025 13:50:35 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, qemu-arm@nongnu.org, Thomas Huth
 <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Alex
 =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH 0/7] testing/next (qtest timer stuff)
In-Reply-To: <20250120210212.3890255-1-alex.bennee@linaro.org>
References: <20250120210212.3890255-1-alex.bennee@linaro.org>
Date: Tue, 21 Jan 2025 10:50:33 -0300
Message-ID: <87y0z4e0nq.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 765C721168
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+]; FROM_HAS_DN(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_SEVEN(0.00)[7]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim, suse.de:mid, suse.de:email,
 imap1.dmz-prg2.suse.org:rdns, imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
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

Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> Hi,
>
> Thomas found that a number of tests fail under CFI and other exotic
> setups. The eventual realisation was that --enable-slirp masks a lot
> of timer misuse because it ensures there is always a timer and
> therefor things tend to move on (until the system is shutting down).
>
> It turns out that bc02be4508 wasn't the solution after all. The first
> few patches are clean-ups and various tightening of test expectations
> before we revert the patch.
>
> Please review:
>
>   Revert "util/timer: avoid deadlock when shutting down"
>   tests/qtest: tighten up the checks on clock_step
>   tests/qtest: rename qtest_send_prefix and roll-up into qtest_send
>   tests/qtest: simplify qtest_process_inbuf
>   tests/qtest: don't step clock at start of npcm7xx periodic IRQ test
>   tests/qtest: don't attempt to clock_step while waiting for virtio ISR
>   tests/docker: replicate the check-rust-tools-nightly CI job
>
> Alex.
>
> Alex Benn=C3=A9e (7):
>   tests/docker: replicate the check-rust-tools-nightly CI job
>   tests/qtest: don't attempt to clock_step while waiting for virtio ISR
>   tests/qtest: don't step clock at start of npcm7xx periodic IRQ test
>   tests/qtest: simplify qtest_process_inbuf
>   tests/qtest: rename qtest_send_prefix and roll-up into qtest_send
>   tests/qtest: tighten up the checks on clock_step
>   Revert "util/timer: avoid deadlock when shutting down"
>
>  include/system/qtest.h                 |  1 -
>  hw/ppc/spapr_rtas.c                    |  1 -
>  hw/riscv/riscv_hart.c                  |  1 -
>  system/qtest.c                         | 53 +++++++++-----------------
>  tests/qtest/libqos/virtio-pci-modern.c |  6 +--
>  tests/qtest/libqos/virtio-pci.c        |  6 +--
>  tests/qtest/npcm7xx_timer-test.c       |  1 -
>  util/qemu-timer.c                      | 16 ++------
>  tests/docker/Makefile.include          |  3 ++
>  tests/docker/test-rust                 | 21 ++++++++++
>  10 files changed, 48 insertions(+), 61 deletions(-)
>  create mode 100755 tests/docker/test-rust

Series:

Acked-by: Fabiano Rosas <farosas@suse.de>

