Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16FADC79FB9
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Jan 2026 19:08:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vcpvP-0007j1-Hr; Mon, 05 Jan 2026 14:07:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vcpuq-0007Zg-Jk
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 14:06:58 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vcpun-00054I-Mw
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 14:06:56 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 4C72533754;
 Mon,  5 Jan 2026 19:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1767640009; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=OCkys1HWa7nAW2llAVERGlOu+dUl8Xy9JXeMcmMbkCk=;
 b=Gbpej2+unrqHQ1INahkxG6w+2EszvjfatPoC+pSgcv1EtlcjHABvC+7xjjf9aHozzNN29O
 EOsVABL1kgTtR4xWF+OOMlklnxrlyiNgajjtU7wEscSA+mfOXc5LKJKYFhanBGEqffCcn3
 lVFaUPKowL230AytcVgzaBpIUSKjuKo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1767640009;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=OCkys1HWa7nAW2llAVERGlOu+dUl8Xy9JXeMcmMbkCk=;
 b=p3s1gs5YU33jeBtb80maCCfIRLgQdW/L7NXdb8eGunAC9o0qTMXh+xE4TXnjXncLyGyEw9
 oRsj+owwpvoxjbCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1767640009; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=OCkys1HWa7nAW2llAVERGlOu+dUl8Xy9JXeMcmMbkCk=;
 b=Gbpej2+unrqHQ1INahkxG6w+2EszvjfatPoC+pSgcv1EtlcjHABvC+7xjjf9aHozzNN29O
 EOsVABL1kgTtR4xWF+OOMlklnxrlyiNgajjtU7wEscSA+mfOXc5LKJKYFhanBGEqffCcn3
 lVFaUPKowL230AytcVgzaBpIUSKjuKo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1767640009;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=OCkys1HWa7nAW2llAVERGlOu+dUl8Xy9JXeMcmMbkCk=;
 b=p3s1gs5YU33jeBtb80maCCfIRLgQdW/L7NXdb8eGunAC9o0qTMXh+xE4TXnjXncLyGyEw9
 oRsj+owwpvoxjbCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EEE1E13964;
 Mon,  5 Jan 2026 19:06:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id mBdSK8cLXGmSOgAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 05 Jan 2026 19:06:47 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com,
	berrange@redhat.com
Subject: [PATCH v2 00/25] migration: Cleanup early connection code
Date: Mon,  5 Jan 2026 16:06:17 -0300
Message-ID: <20260105190644.14072-1-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.992];
 MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 RCVD_TLS_ALL(0.00)[]
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

Changes in v2:

Removed some extra changes that were not adding much to the series,
left multifd_recv_setup() call where it was; stopped merging the
connection code at the end of the series.

Added further cleanup to CPR code in qmp_migrate and moved it to
cpr-transfer.c.

Minor changes:

- patch 4: didn't add a new trace with the hostname, there's already
  one at qio_channel_tls_new_client()
- patch 6: changed other instances of s->parameters.mode to migrate_mode()
- patch 7: changed migrate_init() to also use migrate_error_free()
- patch 8: remove extra error_report_err
- patch 11: removed the extra cpr cleanup
- patch 12: stopped including migration_tls_channel_connect() in the
  async portion
- patches 13-15: split the removal of QEMUFile from channel.c and
  corrected the RDMA code
- patch 21: removed the comments about memory management

CI run: https://gitlab.com/farosas/qemu/-/pipelines/2245393469

v1 (rfc):
https://lore.kernel.org/r/20251226211930.27565-1-farosas@suse.de

Address some of the issues that make the early connection code a bit
too idiosyncratic. By "early connection" I mean from
qmp_migrate[_incoming] until the start of the migration
thread|coroutine.

(IOW, the whole dance of going into socket code, starting an async
routine, calling back to migration code, checking TLS, going back
again, coming back once more, etc. All while passing an error_in and
hostname string that eventually gets (maybe) ignored in tls code,
along with some is_resume checks along the way)

This series is mostly inspired by the work Markus and Peter did
recently in organizing some of the error handling code. The new
migration_connect_error_propagate() function seems like a good place
to centralize the error handling and call migration_cleanup() during
this early connection phase when everything is still fairly
linear. (apologies if I'm dirtying your design =)

Aside from the initial patches that are a bit disruptive, most of the
series is just refactoring to make the code easier to navigate, names
more consistent and some general cleanups.

- patches 1-8:

General cleanups, could be applied standalone, although they are
prerequisites for the rest of the series.

- patches 9-12:

Changes to allow calling migration_cleanup() from
migration_connect_error_propagate().

The idea here is to make sure error propagation and cleanup happen
when the error is detected, without calling into non-error-path
functions.

This is the more risky change because it will cause cleanup to run in
places where it didn't before.

- patch 13 & 19:

The main change of this series, simplifying the
qmp-migrate --> migration_connect path. Stops calling the connection
functions when an error happens in the transport code, adds
clarification around which paths have asynchronous completion and
makes the synchronous path return to their caller to start the
migration instead of initiating it themselves.

- patches 14-18, 20-22:

Moves code out of migration.c and into channel.c. Now that the code is
more compartmentalized, move it to a more appropriate source file.

- patches 23-25:

BONUS CONTENT, wrap the uri/channels parsing and move it to channel.c
as well.

- future work?

I think we could move all QMP command functions to a QAPI-specific
file, but I don't see any standardization in the tree, there's
block/qapi.c, various instances of foo-qmp-cmds.c and many more just
laying along with the rest of the code. So I left this for another
moment.

CI run: https://gitlab.com/farosas/qemu/-/pipelines/2233810778

Fabiano Rosas (25):
  migration: Remove redundant state change
  migration: Fix state change at migration_channel_process_incoming
  migration/tls: Remove unused parameter
  migration: Cleanup TLS handshake hostname passing
  migration: Move postcopy_try_recover into migration_incoming_process
  migration: Use migrate_mode() to query for cpr-transfer
  migration: Free the error earlier in the resume case
  migration: Move error reporting out of migration_cleanup
  migration: Expand migration_connect_error_propagate to cover
    cancelling
  migration: yank: Move register instance earlier
  migration: Fold migration_cleanup() into
    migration_connect_error_propagate()
  migration: Handle error in the early async paths
  migration: Move setting of QEMUFile into
    migration_outgoing|incoming_setup
  migration/rdma: Use common connection paths
  migration: Start incoming from channel.c
  migration/channel: Rename migration_channel_connect
  migration: Rename instances of start
  migration: Move channel code to channel.c
  migration: Move transport connection code into channel.c
  migration: Move channel parsing to channel.c
  migration: Move URI parsing to channel.c
  migration: Free cpr-transfer MigrationAddress along with gsource
  migration: Move CPR HUP watch to cpr-transfer.c
  migration: Remove qmp_migrate_finish
  migration/channel: Centralize calling
    migration_channel_connect_outgoing

 include/migration/cpr.h  |   5 +
 migration/channel.c      | 370 ++++++++++++++++++++++----
 migration/channel.h      |  27 +-
 migration/cpr-exec.c     |   2 +-
 migration/cpr-transfer.c |  23 ++
 migration/exec.c         |  11 +-
 migration/exec.h         |   8 +-
 migration/fd.c           |  15 +-
 migration/fd.h           |   9 +-
 migration/file.c         |  20 +-
 migration/file.h         |   7 +-
 migration/migration.c    | 557 ++++++++++-----------------------------
 migration/migration.h    |  16 +-
 migration/multifd.c      |  17 +-
 migration/multifd.h      |   2 +-
 migration/options.c      |   5 +
 migration/postcopy-ram.c |   2 +-
 migration/rdma.c         |  46 ++--
 migration/rdma.h         |   6 +-
 migration/socket.c       |  30 +--
 migration/socket.h       |   6 +-
 migration/tls.c          |  33 +--
 migration/tls.h          |   9 +-
 migration/trace-events   |  20 +-
 24 files changed, 637 insertions(+), 609 deletions(-)

-- 
2.51.0


