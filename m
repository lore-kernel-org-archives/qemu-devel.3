Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2BDBCCA468
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 14:37:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3bSR-0005Rp-IL; Tue, 30 Sep 2025 10:35:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1v3bSK-0005Qv-E1
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 10:35:52 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1v3bSC-00071M-9W
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 10:35:51 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 37CB8220CD;
 Tue, 30 Sep 2025 14:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1759242939; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mkLRHYlb2dtbH0beZX4pS0JrcQgInwZjq3vv9IKVYEk=;
 b=w3DKL350YFE8Xr/VP1WNfRgAoUimG25Y0UJeDPvgMzQK1DemW5dhCl7tNgWuSeK5O5tfY7
 1v1eu/qtO25KjoYSBxZAAEyirk+aoSogwAOifgW2dNPFlREo67q6oPqHqSbztvFXTHq6hf
 PYjX98VHbnWi3WDuyQRja4oQXxnEjH4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1759242939;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mkLRHYlb2dtbH0beZX4pS0JrcQgInwZjq3vv9IKVYEk=;
 b=0e3mo6PdDaiZ++MtR0FTwmdS44MHevyBJLiZGEQ4MIv/LP8fslOpGgYcfb/d76zD3hLyQv
 6USp5PdH9oJUgpDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1759242939; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mkLRHYlb2dtbH0beZX4pS0JrcQgInwZjq3vv9IKVYEk=;
 b=w3DKL350YFE8Xr/VP1WNfRgAoUimG25Y0UJeDPvgMzQK1DemW5dhCl7tNgWuSeK5O5tfY7
 1v1eu/qtO25KjoYSBxZAAEyirk+aoSogwAOifgW2dNPFlREo67q6oPqHqSbztvFXTHq6hf
 PYjX98VHbnWi3WDuyQRja4oQXxnEjH4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1759242939;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mkLRHYlb2dtbH0beZX4pS0JrcQgInwZjq3vv9IKVYEk=;
 b=0e3mo6PdDaiZ++MtR0FTwmdS44MHevyBJLiZGEQ4MIv/LP8fslOpGgYcfb/d76zD3hLyQv
 6USp5PdH9oJUgpDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B1B5713A3F;
 Tue, 30 Sep 2025 14:35:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id IbZqHbrq22gaWgAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 30 Sep 2025 14:35:38 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Steve Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>, Steve Sistare
 <steven.sistare@oracle.com>
Subject: Re: [PATCH V1 00/11] cpr-exec test
In-Reply-To: <1758291153-349744-1-git-send-email-steven.sistare@oracle.com>
References: <1758291153-349744-1-git-send-email-steven.sistare@oracle.com>
Date: Tue, 30 Sep 2025 11:35:35 -0300
Message-ID: <87frc4uhxk.fsf@suse.de>
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
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_FIVE(0.00)[6];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid]
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

Steve Sistare <steven.sistare@oracle.com> writes:

> Add a migration test for cpr-exec mode.
> Depends on the patch series "Live update: cpr-exec".
>
> Steve Sistare (11):
>   tests/qtest: export qtest_qemu_binary
>   tests/qtest: qtest_qemu_args
>   tests/qtest: qtest_create_test_state
>   tests/qtest: qtest_qemu_spawn_func
>   tests/qtest: qtest_init_after_exec
>   migration-test: only_source option
>   migration-test: shm path accessor
>   migration-test: misc exports
>   migration-test: migrate_args
>   migration-test: strv parameter
>   migration-test: test cpr-exec
>
>  tests/qtest/libqtest.h                |  25 +++++++
>  tests/qtest/migration/bootfile.h      |   1 +
>  tests/qtest/migration/framework.h     |   8 +++
>  tests/qtest/migration/migration-qmp.h |   2 +
>  tests/qtest/libqtest.c                | 108 ++++++++++++++++++++----------
>  tests/qtest/migration/bootfile.c      |   5 ++
>  tests/qtest/migration/cpr-tests.c     | 120 ++++++++++++++++++++++++++++++++++
>  tests/qtest/migration/framework.c     | 102 ++++++++++++++++++-----------
>  tests/qtest/migration/migration-qmp.c |  16 +++++
>  9 files changed, 317 insertions(+), 70 deletions(-)

Queued up to patch 10 to qtest-next.

