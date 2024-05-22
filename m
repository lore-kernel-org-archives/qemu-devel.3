Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30360C25B7D
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2024 22:21:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9uKF-0005R6-KP; Wed, 22 May 2024 18:20:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1s9uKB-0005QX-Qr
 for qemu-devel@nongnu.org; Wed, 22 May 2024 18:20:44 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1s9uK8-0003fZ-8o
 for qemu-devel@nongnu.org; Wed, 22 May 2024 18:20:42 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0863021C21;
 Wed, 22 May 2024 22:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1716416438; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=is/RpDpHv5lZV2dWY2IophhyTb//P1hJoNYZQO5ncvc=;
 b=YCmPzBGYT0P7HoZFdeB5+HNUL0ByQaj6Rcw1sP1B+2myRcDd0PI4Q4iqdANcTRbGWN8IuK
 vO9W2S47W3fdJTHlU3awPaFFOM+Sk0exDmenk6Z5LKqczY0Y5TI5ffIF4Ib0pzVZbrdzDs
 0p6WHP29SXMlDip9JXfBDsZyzIZ/nmY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1716416438;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=is/RpDpHv5lZV2dWY2IophhyTb//P1hJoNYZQO5ncvc=;
 b=Tlpan0QTDqOff3r4eAb/0M2cRCBlKnlkjrxjumdDV428je6nG1jAffA3kDg5wjgpxihuRN
 NuDRYg5wEKmYG9CA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1716416438; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=is/RpDpHv5lZV2dWY2IophhyTb//P1hJoNYZQO5ncvc=;
 b=YCmPzBGYT0P7HoZFdeB5+HNUL0ByQaj6Rcw1sP1B+2myRcDd0PI4Q4iqdANcTRbGWN8IuK
 vO9W2S47W3fdJTHlU3awPaFFOM+Sk0exDmenk6Z5LKqczY0Y5TI5ffIF4Ib0pzVZbrdzDs
 0p6WHP29SXMlDip9JXfBDsZyzIZ/nmY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1716416438;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=is/RpDpHv5lZV2dWY2IophhyTb//P1hJoNYZQO5ncvc=;
 b=Tlpan0QTDqOff3r4eAb/0M2cRCBlKnlkjrxjumdDV428je6nG1jAffA3kDg5wjgpxihuRN
 NuDRYg5wEKmYG9CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D231F13A6B;
 Wed, 22 May 2024 22:20:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id WDxUJbRvTmaABAAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 22 May 2024 22:20:36 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 0/9] Migration patches for 2024-05-22
Date: Wed, 22 May 2024 19:20:25 -0300
Message-Id: <20240522222034.4001-1-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_TLS_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 RCPT_COUNT_THREE(0.00)[3]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
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

The following changes since commit 01782d6b294f95bcde334386f0aaac593cd28c0d:

  Merge tag 'hw-misc-20240517' of https://github.com/philmd/qemu into staging (2024-05-18 11:49:01 +0200)

are available in the Git repository at:

  https://gitlab.com/farosas/qemu.git tags/migration-20240522-pull-request

for you to fetch changes up to 8f023a0bd946bb0c122543c64fe2b34bad0dd048:

  tests/qtest/migration-test: Fix the check for a successful run of analyze-migration.py (2024-05-22 17:34:41 -0300)

----------------------------------------------------------------
Migration pull request

- Li Zhijian's COLO minor fixes
- Marc-André's virtio-gpu fix
- Fiona's virtio-net USO fix
- A couple of migration-test fixes from Thomas

----------------------------------------------------------------

Fiona Ebner (1):
  hw/core/machine: move compatibility flags for VirtIO-net USO to
    machine 8.1

Li Zhijian (3):
  migration/colo: Minor fix for colo error message
  migration/colo: make colo_incoming_co() return void
  migration/colo: Tidy up bql_unlock() around bdrv_activate_all()

Marc-André Lureau (3):
  migration: add "exists" info to load-state-field trace
  migration: fix a typo
  virtio-gpu: fix v2 migration

Thomas Huth (2):
  tests/qtest/migration-test: Run some basic tests on s390x and ppc64
    with TCG, too
  tests/qtest/migration-test: Fix the check for a successful run of
    analyze-migration.py

 hw/core/machine.c              |  7 +++---
 hw/display/virtio-gpu.c        | 30 ++++++++++++++++++-------
 include/hw/virtio/virtio-gpu.h |  1 +
 include/migration/colo.h       |  2 +-
 migration/colo-stubs.c         |  3 +--
 migration/colo.c               | 12 +++-------
 migration/migration.c          | 12 +++++-----
 migration/trace-events         |  2 +-
 migration/vmstate.c            |  7 +++---
 tests/qtest/migration-test.c   | 41 +++++++++++++++++-----------------
 10 files changed, 64 insertions(+), 53 deletions(-)

-- 
2.35.3


