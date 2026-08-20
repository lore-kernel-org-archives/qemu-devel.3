Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F491C5DF85
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 15:23:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx4bc-0007SC-JJ; Thu, 20 Aug 2026 11:23:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wx4ba-0007RK-A5
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 11:22:58 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wx4bX-0002rY-IM
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 11:22:58 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7B81885167;
 Thu, 20 Aug 2026 15:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787239369; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bny/hLnq/D5J+sf0TC+t+uAdUtdkUH6i0RBqtyUBVFE=;
 b=Qo1Y1Y4X+P+16tO0qbkVNJoWo1VFWDzH0tYds3tubfWMEnkKrTqDP3LBr1zJL4Kxa+1aNX
 GLHHAs8QAx6olxvnfEX13uPS/S13p0BUw+JZ2pabf4LPUlvWepmwKORK7WDhDvbBcaWbOd
 t6aF1wJTra2NB6c1UkCI0rkAmYsp18w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787239369;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bny/hLnq/D5J+sf0TC+t+uAdUtdkUH6i0RBqtyUBVFE=;
 b=ZSWdf2ttsJniuRjorMsLbx7+Xvend0emTxv3URc8GbXbRTA5p3rKk9TO9jciYR7e2BGcn8
 ddpXbphm3CLPIeAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787239365; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bny/hLnq/D5J+sf0TC+t+uAdUtdkUH6i0RBqtyUBVFE=;
 b=0ONAv4r+/QtJ5HlsTNIfuOJgIu3KccLwRc8Hy/v99SqRoQeelJQSNs2wHeqdAj+voecD26
 K1AjQJxmu/W8cLnWrXM7le0d9WdeigIFbVuLk43pHI/CgLADW+Rb4WMZ0scfBkdFzfv0oU
 4MWG2f2mJVmrLCol95wz2NJjPFV1lsE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787239365;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bny/hLnq/D5J+sf0TC+t+uAdUtdkUH6i0RBqtyUBVFE=;
 b=KX9pjO5XsKAfeO5pjpvx+2+N+rM4G2ZeIDzEOLl/CvVB9+QtVGKnAS2Vbb5RAxL8bAF7yZ
 jGBtTEW1MawvHlAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1CEE927A8;
 Thu, 20 Aug 2026 15:22:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id neLnN8Qbh2ofJAAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 20 Aug 2026 15:22:44 +0000
From: Fabiano Rosas <farosas@suse.de>
To: phind.uet@gmail.com, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Lukas Straub <lukasstraub2@web.de>, Peter Xu
 <peterx@redhat.com>, "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 Mark Kanda <mark.kanda@oracle.com>, Ben Chaney <bchaney@akamai.com>
Cc: Nguyen Dinh Phi <phind.uet@gmail.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH 0/3]  Support chain migration in test
In-Reply-To: <20260709130032.58667-1-phind.uet@gmail.com>
References: <20260709130032.58667-1-phind.uet@gmail.com>
Date: Thu, 20 Aug 2026 12:22:42 -0300
Message-ID: <87lda0lsu5.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FREEMAIL_ENVRCPT(0.00)[gmail.com,web.de]; RCVD_TLS_ALL(0.00)[];
 ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; TAGGED_RCPT(0.00)[];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 FREEMAIL_TO(0.00)[gmail.com,redhat.com,web.de,oracle.com,akamai.com];
 MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; FREEMAIL_CC(0.00)[gmail.com,nongnu.org];
 RCPT_COUNT_SEVEN(0.00)[10]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

phind.uet@gmail.com writes:

> From: Nguyen Dinh Phi <phind.uet@gmail.com>
>
> This series adds test infrastructure and test cases for multi-hop chain
> migration, where a VM migrates from host A to B and then from B to C.
>
> The migration test TODO list mentions ping-pong migration (A=E2=86=92B=E2=
=86=92A) as a
> desirable scenario; the true ping-pong (A=E2=86=92B=E2=86=92A) would requ=
ire the original
> source A to become a destination for the return leg.
> This is not possible: a QEMU process launched without -incoming cannot
> later accept an incoming migration stream. Instead, this series implements
> chain migration (A=E2=86=92B=E2=86=92C): B was already launched with -inc=
oming and can
> be re-wired as the source for the next hop, while a fresh QEMU instance C
> is started as the new destination.
>
> Nguyen Dinh Phi (3):
>   tests/migration: Factor out per-process launch and setup helpers
>   tests/migration: Retrieve serial path from QTestState
>   tests/migration: Add chain (A to B to C) precopy migration tests
>
>  tests/qtest/libqtest.c                |  16 +
>  tests/qtest/libqtest.h                |   8 +
>  tests/qtest/migration/colo-tests.c    |  14 +-
>  tests/qtest/migration/cpr-tests.c     |   8 +-
>  tests/qtest/migration/framework.c     | 475 ++++++++++++++++----------
>  tests/qtest/migration/framework.h     |  21 +-
>  tests/qtest/migration/misc-tests.c    |   4 +-
>  tests/qtest/migration/precopy-tests.c |  51 ++-
>  8 files changed, 389 insertions(+), 208 deletions(-)

This has been attempted before, but we ended up not continuing the work
for other reasons. I think your ideas on the first patch are a step in
the right direction. As for the serial work, I'm not so sure we should
be adding migration-specific data into QTestState, even though the
serial is not technically exclusive to migration. I need to give it a
bit more thought.

Here are the links to the previous work (for reference, I don't have
plans to carry it forward at the moment):

Cleanups and dealing with serial:=20
https://lore.kernel.org/all/20241125144612.16194-2-farosas@suse.de/
https://lore.kernel.org/all/20241125144612.16194-3-farosas@suse.de/
https://lore.kernel.org/all/20241125144612.16194-4-farosas@suse.de/

Ping-pong test:
https://lore.kernel.org/all/20241125144612.16194-6-farosas@suse.de/

