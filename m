Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A2D2C27C79
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2024 19:45:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJIHx-0005VZ-0a; Mon, 17 Jun 2024 15:45:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sJIHv-0005V4-Se
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 15:45:11 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sJIHt-0004eD-Qy
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 15:45:11 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C8EA71F383;
 Mon, 17 Jun 2024 19:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1718653508; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=na+v7GzHv9CB+uHVKxWcbDUrFlZkARMVBXvbdIhhgIQ=;
 b=PruPkPktB4sa7BVqV/pJMCX6izfEGpu+syGAH8OeF4foXmYJVOz16tAuky0q6rCtGG3x/4
 LGWGVWKdSUhMKpDv5wdbqcZv09FB+mqNNtlJpkQTqXve7QerpiwoTWDgTZ7oV2/+7orPb6
 ic2iDCqKDtDuHAeZM88dIx7YI++3btU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1718653508;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=na+v7GzHv9CB+uHVKxWcbDUrFlZkARMVBXvbdIhhgIQ=;
 b=9C//5uoDisLNhT7xgfI6cTZmmS3/JLMLeUECPjGtIackyLpwS46+u0ytjvryaEyx8Dsmmz
 TVkhZP8QTGKv/SCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1718653507; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=na+v7GzHv9CB+uHVKxWcbDUrFlZkARMVBXvbdIhhgIQ=;
 b=fMU32GdkZRubmbvFBFQOmhcZJaweo5JXVjiVLaGC1TpbT9DVLVvhCTRs9QK/xo7kZ6b/rD
 0xsOxBC7gPKOsTLmBUEhbymjj3n0/zZy6Ed5gZ1FAwxI/zxOpSUVLefrQU0QQULZSeGfU+
 tf62CwCuzJCi92BksvgrgkSIbNdSfNo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1718653507;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=na+v7GzHv9CB+uHVKxWcbDUrFlZkARMVBXvbdIhhgIQ=;
 b=0gIykHaprHxTsJf/ft1OhSP1VGXYNHfCBQdQBTpgVmfffFjVcGevxyVVmXtTDulCdmcYGO
 1r1RTn6Sn7RSK1Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4F4C413AAA;
 Mon, 17 Jun 2024 19:45:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id VpMDBkOScGbnNAAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 17 Jun 2024 19:45:07 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Eric Blake <eblake@redhat.com>,
 Prasad Pandit <ppandit@redhat.com>, peterx@redhat.com, Jiri Denemark
 <jdenemar@redhat.com>, Bandan Das <bdas@redhat.com>
Subject: Re: [PATCH v2 05/10] migration/postcopy: Add postcopy-recover-setup
 phase
In-Reply-To: <20240617181534.1425179-6-peterx@redhat.com>
References: <20240617181534.1425179-1-peterx@redhat.com>
 <20240617181534.1425179-6-peterx@redhat.com>
Date: Mon, 17 Jun 2024 16:45:04 -0300
Message-ID: <87iky7bbgf.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.997]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_SEVEN(0.00)[10]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

> This patch adds a migration state on src called "postcopy-recover-setup".
> The new state will describe the intermediate step starting from when the
> src QEMU received a postcopy recovery request, until the migration channels
> are properly established, but before the recovery process take place.
>
> The request came from Libvirt where Libvirt currently rely on the migration
> state events to detect migration state changes.  That works for most of the
> migration process but except postcopy recovery failures at the beginning.
>
> Currently postcopy recovery only has two major states:
>
>   - postcopy-paused: this is the state that both sides of QEMU will be in
>     for a long time as long as the migration channel was interrupted.
>
>   - postcopy-recover: this is the state where both sides of QEMU handshake
>     with each other, preparing for a continuation of postcopy which used to
>     be interrupted.
>
> The issue here is when the recovery port is invalid, the src QEMU will take
> the URI/channels, noticing the ports are not valid, and it'll silently keep
> in the postcopy-paused state, with no event sent to Libvirt.  In this case,
> the only thing Libvirt can do is to poll the migration status with a proper
> interval, however that's less optimal.
>
> Considering that this is the only case where Libvirt won't get a
> notification from QEMU on such events, let's add postcopy-recover-setup
> state to mimic what we have with the "setup" state of a newly initialized
> migration, describing the phase of connection establishment.
>
> With that, postcopy recovery will have two paths to go now, and either path
> will guarantee an event generated.  Now the events will look like this
> during a recovery process on src QEMU:
>
>   - Initially when the recovery is initiated on src, QEMU will go from
>     "postcopy-paused" -> "postcopy-recover-setup".  Old QEMUs don't have
>     this event.
>
>   - Depending on whether the channel re-establishment is succeeded:
>
>     - In succeeded case, src QEMU will move from "postcopy-recover-setup"
>       to "postcopy-recover".  Old QEMUs also have this event.
>
>     - In failure case, src QEMU will move from "postcopy-recover-setup" to
>       "postcopy-paused" again.  Old QEMUs don't have this event.
>
> This guarantees that Libvirt will always receive a notification for
> recovery process properly.
>
> One thing to mention is, such new status is only needed on src QEMU not
> both.  On dest QEMU, the state machine doesn't change.  Hence the events
> don't change either.  It's done like so because dest QEMU may not have an
> explicit point of setup start.  E.g., it can happen that when dest QEMUs
> doesn't use migrate-recover command to use a new URI/channel, but the old
> URI/channels can be reused in recovery, in which case the old ports simply
> can work again after the network routes are fixed up.
>
> Add a new helper postcopy_is_paused() detecting whether postcopy is still
> paused, taking RECOVER_SETUP into account too.  When using it on both
> src/dst, a slight change is done altogether to always wait for the
> semaphore before checking the status, because for both sides a sem_post()
> will be required for a recovery.
>
> Cc: Jiri Denemark <jdenemar@redhat.com>
> Cc: Fabiano Rosas <farosas@suse.de>
> Cc: Prasad Pandit <ppandit@redhat.com>
> Buglink: https://issues.redhat.com/browse/RHEL-38485
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Fabiano Rosas <farosas@suse.de>

