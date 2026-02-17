Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3013BE909CF
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Feb 2026 16:16:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsNj8-00015u-6D; Tue, 17 Feb 2026 11:15:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vsNj3-00010p-A5
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 11:15:02 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vsNiy-0002sh-Mv
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 11:15:01 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7D5733E718;
 Tue, 17 Feb 2026 16:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1771344887; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=luLM0vHPkLb2Q+4P4WAWdCTD4HqzH18BgcVwS6oKeAE=;
 b=JVd8EYgJC1TMydARvAAu8dR6DVI0yLrTD6f1KHT/ETM3Vx3IaLBMfE0Xr3fHOW3H1BWiGw
 09UKv7G7dPFkcG5zUNvRF8/w93BvTc65bAFZz+PiGAdc1GmroonDxurwLaexlHorBuDwEI
 fSoFeqXp53tph0aoqOFkE+tP+enNf8s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1771344887;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=luLM0vHPkLb2Q+4P4WAWdCTD4HqzH18BgcVwS6oKeAE=;
 b=+Dvf0knq4SQuYdnKlL8gY7tLYLPWuQqwtdAJ++JnCON6xyE1/LpgD+w61EYrTM0/Wdc/hk
 WA4dk8kgnP80QODg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1771344887; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=luLM0vHPkLb2Q+4P4WAWdCTD4HqzH18BgcVwS6oKeAE=;
 b=JVd8EYgJC1TMydARvAAu8dR6DVI0yLrTD6f1KHT/ETM3Vx3IaLBMfE0Xr3fHOW3H1BWiGw
 09UKv7G7dPFkcG5zUNvRF8/w93BvTc65bAFZz+PiGAdc1GmroonDxurwLaexlHorBuDwEI
 fSoFeqXp53tph0aoqOFkE+tP+enNf8s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1771344887;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=luLM0vHPkLb2Q+4P4WAWdCTD4HqzH18BgcVwS6oKeAE=;
 b=+Dvf0knq4SQuYdnKlL8gY7tLYLPWuQqwtdAJ++JnCON6xyE1/LpgD+w61EYrTM0/Wdc/hk
 WA4dk8kgnP80QODg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7CFE53EA66;
 Tue, 17 Feb 2026 16:14:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id pxGMEPaTlGmHTgAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 17 Feb 2026 16:14:46 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>
Subject: [PULL 00/32] Migration patches for 2026-02-17
Date: Tue, 17 Feb 2026 13:14:11 -0300
Message-ID: <20260217161443.12738-1-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCPT_COUNT_TWO(0.00)[2]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,gitlab.com:url,suse.de:mid]; 
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[gitlab.com:url, suse.de:mid,
 imap1.dmz-prg2.suse.org:helo]
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

The following changes since commit ece408818d27f745ef1b05fb3cc99a1e7a5bf580:

  Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into staging (2026-02-13 10:30:08 +0000)

are available in the Git repository at:

  https://gitlab.com/farosas/qemu.git tags/migration-20260217-pull-request

for you to fetch changes up to fd5ecd187bc245013399d14cc225f05c0ad1a96c:

  tests/qtest/migration/tls-tests.c: Don't use tls_psk end hook for no_tls tests (2026-02-17 10:06:03 -0300)

----------------------------------------------------------------
Migration pull request

- Notifier changes: Remove duplicated events during postcopy. Emit
  MIG_EVENT_FAILED before the VM is started.

- Undefined behavior fix for tls-tests.

- Cleanups: COLO, savevm handlers, CPR/VFIOheaders.

----------------------------------------------------------------

Cédric Le Goater (1):
  migration/cpr: Include vfio-cpr.h instead of vfio-device.h

Fabiano Rosas (1):
  migration: Update comments mentioning qmp_migrate_finish

Peter Maydell (1):
  tests/qtest/migration/tls-tests.c: Don't use tls_psk end hook for
    no_tls tests

Peter Xu (29):
  migration: Add a tracepoint for invoking migration notifiers
  migration: Fix double notification of DONE/FAIL for postcopy
  migration: Notify migration FAILED before starting VM
  migration: Drop explicit block activation in postcopy fail path
  migration: Rename MIG_EVENT_PRECOPY_* to MIG_EVENT_*
  migration: Introduce qemu_savevm_send_* helpers
  migration: Use qemu_savevm_send_header() in qemu_save_device_state()
  migration: Remove one migration_in_colo_state() occurance
  migration/savevm: Remove SaveStateEntry.is_ram
  migration/colo: Unwrap qemu_savevm_live_state()
  migration: Remove call to send switchover start event in colo/savevm
  colo: Forbid VM resume during checkpointing
  migration/colo: Use the RAM iterable helper directly
  migration/colo: Document qemu_fflush(fb)
  migration: Drop iterable_only in qemu_savevm_state_complete_precopy
  migration: Drop qemu_file_set_error() when save non-iterable fails
  migration/colo: Send device states without copying buffer
  migration/postcopy: Send device states without copying buffer
  migration: Introduce qemu_savevm_state_end()
  migration: Provide helper for save vm description
  migration: Split qemu_savevm_state_complete_precopy_non_iterable()
  migration: qemu_savevm_state_complete_precopy() take MigrationState*
  migration: Cleanup error propagates in qemu_savevm_state_setup()
  migration: Refactor qemu_savevm_state_setup()
  migration: Introduce qemu_savevm_state_active()
  migration/bg-snapshot: Cleanup error paths
  migration: Make qemu_savevm_state_non_iterable() take errp
  migration: Simplify qemu_save_device_state()
  migration/colo/xen: Use generic helpers in qemu_save_device_state()

 hw/intc/arm_gicv3_kvm.c           |   2 +-
 hw/net/virtio-net.c               |   4 +-
 hw/scsi/scsi-disk.c               |   4 +-
 hw/vfio/cpr-legacy.c              |   2 +-
 hw/vfio/cpr.c                     |   8 +-
 hw/vfio/migration.c               |   4 +-
 include/migration/misc.h          |  20 +-
 migration/colo.c                  |  16 +-
 migration/cpr-exec.c              |   6 +-
 migration/cpr.c                   |   2 +-
 migration/migration.c             |  86 ++++----
 migration/savevm.c                | 320 ++++++++++++++++--------------
 migration/savevm.h                |  18 +-
 migration/trace-events            |   1 +
 monitor/qmp-cmds.c                |   3 +
 net/vhost-vdpa.c                  |   4 +-
 tests/qtest/migration/tls-tests.c |   8 +-
 ui/spice-core.c                   |   7 +-
 18 files changed, 280 insertions(+), 235 deletions(-)

-- 
2.51.0


