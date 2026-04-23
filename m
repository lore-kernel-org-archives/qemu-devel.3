Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC8B8FDEE3F
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 19:20:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFzaq-0001kx-PB; Thu, 23 Apr 2026 15:20:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wFzap-0001jl-9M
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 15:20:07 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wFzal-0001Vg-Q1
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 15:20:06 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 4AADF6A890;
 Thu, 23 Apr 2026 19:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1776972001; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=d0r2OBS7K3Hgx5NSx5PjWG23PFhTyZSV7OHI5QLGtKM=;
 b=BbRfoxuwpwePONVK6PTCnsajRC42uAYnf3WKImmYfGwyd/306ZTbI9jUmLyOJicgOWgJ8y
 qNxbWMLIofrLA8uCwAnRW4g+Iu8bms7jMHv/CUOumoA6aHzai9sWxKhwY26O0D0mTqW5pi
 G5iSMhOnixOwdpI2owtckJLxNIpjHbk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1776972001;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=d0r2OBS7K3Hgx5NSx5PjWG23PFhTyZSV7OHI5QLGtKM=;
 b=1qig+DuZaaLH2M2hdnpUm4yZ0LCcuLSFKLYZPRk1qlFjzkGI3shAat4i4H+3QcI5Vb+8py
 6wn5FNfwnI2Al0Cw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=BbRfoxuw;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=1qig+DuZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1776972001; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=d0r2OBS7K3Hgx5NSx5PjWG23PFhTyZSV7OHI5QLGtKM=;
 b=BbRfoxuwpwePONVK6PTCnsajRC42uAYnf3WKImmYfGwyd/306ZTbI9jUmLyOJicgOWgJ8y
 qNxbWMLIofrLA8uCwAnRW4g+Iu8bms7jMHv/CUOumoA6aHzai9sWxKhwY26O0D0mTqW5pi
 G5iSMhOnixOwdpI2owtckJLxNIpjHbk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1776972001;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=d0r2OBS7K3Hgx5NSx5PjWG23PFhTyZSV7OHI5QLGtKM=;
 b=1qig+DuZaaLH2M2hdnpUm4yZ0LCcuLSFKLYZPRk1qlFjzkGI3shAat4i4H+3QcI5Vb+8py
 6wn5FNfwnI2Al0Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 741E0593A3;
 Thu, 23 Apr 2026 19:20:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id lFRpEOBw6mlJCwAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 23 Apr 2026 19:20:00 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>
Subject: [PULL 00/43] Migration patches for 2026-04-23
Date: Thu, 23 Apr 2026 16:19:14 -0300
Message-ID: <20260423191958.1440-1-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 4AADF6A890
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

The following changes since commit bb230769b4d01de714bed686161ad39a8f4f3fd1:

  Merge tag 'ui-pull-request' of https://gitlab.com/marcandre.lureau/qemu into staging (2026-04-22 14:30:04 -0400)

are available in the Git repository at:

  https://gitlab.com/farosas/qemu.git tags/migration-20260423-pull-request

for you to fetch changes up to 78532838ab9edeaced231760693898614280cbb5:

  migration/qemu-file: drop incorrect const from qemu_get_buffer_at buf (2026-04-23 12:14:52 -0300)

----------------------------------------------------------------
Migration pull request

- Cleanups to internal vmstate APIs
- Cleanups to handling of vmstate flags
- New vmstate VMS_ARRAY_OF_POINTER_AUTO_ALLOC
- Fixes to:
  - functional exec test
  - leaks in file migration
  - mapped-ram migration input validation
  - programming errors in qemu-file and multifd
  - qtest leaks
- Additions to iochannel APIs:
  qio_channel_pread{v,}_all{,_eof}
  qio_channel_pwrite{v,}_all
- New migration qtest for capabilities validation
- Tweaks to documentation and checkpatch

----------------------------------------------------------------

Alexander Mikhalitsyn (1):
  tests/unit/test-vmstate: add tests for VMS_ARRAY_OF_POINTER_AUTO_ALLOC

Fabiano Rosas (3):
  checkpatch: Allow spaces after all coroutine annotations
  tests/functional: Make socat wait longer in migration exec test
  vmstate: Stop checking size for nullptr compression

Junjie Cao (7):
  io/channel: introduce qio_channel_pread{v, }_all{, _eof}()
  io/channel: introduce qio_channel_pwrite{v,}_all()
  migration/file: fix type mismatch and NULL deref in
    multifd_file_recv_data
  tests/unit: add pread/pwrite _all tests for io channel file
  migration/qemu-file: switch buffer_at functions to positioned I/O _all
    helpers
  migration/file: switch file_write_ramblock_iov to pwritev_all
  migration/qemu-file: drop incorrect const from qemu_get_buffer_at buf

Markus Armbruster (1):
  migration: Tweak description of migration property multifd-compression

Peter Xu (9):
  vmstate: Pass in struct itself for VMSTATE_ARRAY_OF_POINTER
  vmstate: Pass in struct itself for VMSTATE_VARRAY_OF_POINTER_UINT32
  vmstate: Do not set size for VMS_ARRAY_OF_POINTER
  vmstate: Update max_elems early and check field compressable once
  vmstate: Rename VMS_NULLPTR_MARKER to VMS_MARKER_PTR_NULL
  vmstate: Introduce vmstate_save_field_with_vmdesc()
  vmstate: Allow vmstate_info_nullptr to emit non-NULL markers
  vmstate: Implement load of ptr marker in vmstate core
  vmstate: Implement VMS_ARRAY_OF_POINTER_AUTO_ALLOC

Takeru Hayasaka (1):
  tests/qtest/migration: Add mapped-ram/postcopy validation test

Trieu Huynh (3):
  migration: fix QIOChannelFile leak on error in file_connect_outgoing
  migration: validate page_size in mapped-ram header before use
  tests/qtest/migration: fix fd leak in ufd_version_check

Vladimir Sementsov-Ogievskiy (18):
  migration: vmstate_save_state_v: fix double error_setg
  migration: make vmstate_save_state_v() static
  migration: make .post_save() a void function
  migration: vmstate_load_state(): add some newlines
  migration: vmstate_save/load_state(): refactor tracing errors
  migration: factor out vmstate_pre_save() from vmstate_save_state()
  migration: factor out vmstate_save_field() from vmstate_save_state()
  migration: factor out vmstate_pre_load() from vmstate_load_state()
  migration: factor out vmstate_load_field() from vmstate_load_state()
  migration: factor out vmstate_post_load() from vmstate_load_state()
  migration: convert vmstate_subsection_save/load functions to bool
  migration: VMStateInfo: introduce new handlers with errp
  migration: introduce vmstate_load_vmsd() and vmstate_save_vmsd()
  migration/cpr: move to new migration APIs
  migration/savevm: move to new migration APIs
  hw/s390x/css: drop use of .err_hint for vmstate
  migration: drop VMStateField.err_hint
  migration/vmstate-types: move to new migration APIs

 docs/devel/migration/main.rst          |   2 +-
 hw/block/fdc.c                         |   2 +-
 hw/core/qdev-properties-system.c       |   2 +-
 hw/display/qxl.c                       |   4 +-
 hw/display/vga.c                       |   2 +-
 hw/display/virtio-gpu.c                |   2 +-
 hw/display/vmware_vga.c                |   2 +-
 hw/i386/vmmouse.c                      |   2 +-
 hw/ide/ahci.c                          |   2 +-
 hw/intc/openpic.c                      |   2 +-
 hw/intc/spapr_xive.c                   |   2 +-
 hw/intc/xics.c                         |   2 +-
 hw/intc/xive.c                         |   2 +-
 hw/nvram/eeprom93xx.c                  |   2 +-
 hw/pci/pci.c                           |   2 +-
 hw/pci/pcie_aer.c                      |   2 +-
 hw/ppc/spapr_iommu.c                   |   2 +-
 hw/ppc/spapr_pci.c                     |   7 +-
 hw/ppc/spapr_vio.c                     |   4 +-
 hw/s390x/css.c                         |  15 +-
 hw/usb/hcd-uhci.c                      |   2 +-
 include/hw/intc/riscv_aclint.h         |   6 +-
 include/io/channel.h                   | 133 +++++
 include/migration/cpr.h                |   2 +-
 include/migration/vmstate.h            | 161 ++++--
 io/channel.c                           | 139 ++++++
 migration/cpr.c                        |  22 +-
 migration/file.c                       |  23 +-
 migration/qemu-file.c                  |  37 +-
 migration/qemu-file.h                  |   2 +-
 migration/ram.c                        |   6 +
 migration/savevm.c                     | 136 ++++--
 migration/trace-events                 |  30 +-
 migration/vmstate-types.c              | 650 ++++++++++++-------------
 migration/vmstate.c                    | 593 ++++++++++++++--------
 rust/migration/src/migratable.rs       |   6 +-
 rust/migration/src/vmstate.rs          |  12 +-
 scripts/analyze-migration.py           |  22 +-
 scripts/checkpatch.pl                  |   1 +
 target/arm/machine.c                   |   4 +-
 target/ppc/machine.c                   |   6 +-
 tests/functional/migration.py          |   2 +-
 tests/qtest/migration/file-tests.c     |  48 ++
 tests/qtest/migration/migration-util.c |  10 +-
 tests/qtest/migration/misc-tests.c     |  52 ++
 tests/unit/test-io-channel-file.c      | 207 ++++++++
 tests/unit/test-vmstate.c              |  90 +++-
 47 files changed, 1712 insertions(+), 752 deletions(-)

-- 
2.51.0


