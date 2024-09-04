Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7213ACD4849
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2024 12:49:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slpN6-000386-36; Wed, 04 Sep 2024 08:44:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1slpN4-00036n-6X
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 08:44:26 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1slpN2-0005OL-9B
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 08:44:25 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 2E92A1F38E;
 Wed,  4 Sep 2024 12:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1725453861; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=zygBvS8SfWmSxzUak9TIhuAZ8VuB8IHs7xQf2ypzyTg=;
 b=PxvSRBlGkkQ/3NOzWv5x+uoygAyRelcvlpyEeaNz3rTgSs5c0MCaCwkcl+aAO6qlordkcA
 q8knVSZcX2PgKCflawxr7P29I/HfNFBxn1I0Ws1iGU3hRIALEPr9KPCuvsAJkgGMzp9qfJ
 1uXzXUKyExLKMqS85zRRrGH9yyO/Z2M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1725453861;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=zygBvS8SfWmSxzUak9TIhuAZ8VuB8IHs7xQf2ypzyTg=;
 b=YH8E3IAhNfxZmbzmMdVFMaPS6mkYN4wNoeq2OyCnNHSW80acBD7YjjIwFbiLju1OK85dD0
 HjlY+oijSI1ot+Dg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1725453861; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=zygBvS8SfWmSxzUak9TIhuAZ8VuB8IHs7xQf2ypzyTg=;
 b=PxvSRBlGkkQ/3NOzWv5x+uoygAyRelcvlpyEeaNz3rTgSs5c0MCaCwkcl+aAO6qlordkcA
 q8knVSZcX2PgKCflawxr7P29I/HfNFBxn1I0Ws1iGU3hRIALEPr9KPCuvsAJkgGMzp9qfJ
 1uXzXUKyExLKMqS85zRRrGH9yyO/Z2M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1725453861;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=zygBvS8SfWmSxzUak9TIhuAZ8VuB8IHs7xQf2ypzyTg=;
 b=YH8E3IAhNfxZmbzmMdVFMaPS6mkYN4wNoeq2OyCnNHSW80acBD7YjjIwFbiLju1OK85dD0
 HjlY+oijSI1ot+Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 02B30139D2;
 Wed,  4 Sep 2024 12:44:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id f5JyLiNW2GZuVQAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 04 Sep 2024 12:44:19 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 00/34] Migration patches for 2024-09-04
Date: Wed,  4 Sep 2024 09:43:43 -0300
Message-Id: <20240904124417.14565-1-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCPT_COUNT_THREE(0.00)[3];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
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

The following changes since commit e638d685ec2a0700fb9529cbd1b2823ac4120c53:

  Open 9.2 development tree (2024-09-03 09:18:43 -0700)

are available in the Git repository at:

  https://gitlab.com/farosas/qemu.git tags/migration-20240904-pull-request

for you to fetch changes up to d41c9896f49076d1eaaa32214bd2296bd36d866c:

  tests/qtest/migration: Add a check for the availability of the "pc" machine (2024-09-03 16:24:37 -0300)

----------------------------------------------------------------
Migration pull request

- Steve's cleanup of unused variable
- Peter Maydell's fixes for several leaks in migration-test
- Fabiano's flexibilization of multifd data structures for device
  state migration
- Arman Nabiev's fix for ppc e500 migration
- Thomas' fix for migration-test vs. --without-default-devices

----------------------------------------------------------------

Arman Nabiev (1):
  target/ppc: Fix migration of CPUs with TLB_EMB TLB type

Fabiano Rosas (22):
  tests/qtest/migration: Remove vmstate-static-checker test
  migration/multifd: Reduce access to p->pages
  migration/multifd: Inline page_size and page_count
  migration/multifd: Remove pages->allocated
  migration/multifd: Pass in MultiFDPages_t to file_write_ramblock_iov
  migration/multifd: Introduce MultiFDSendData
  migration/multifd: Make MultiFDPages_t:offset a flexible array member
  migration/multifd: Replace p->pages with an union pointer
  migration/multifd: Move pages accounting into
    multifd_send_zero_page_detect()
  migration/multifd: Remove total pages tracing
  migration/multifd: Isolate ram pages packet data
  migration/multifd: Don't send ram data during SYNC
  migration/multifd: Replace multifd_send_state->pages with client data
  migration/multifd: Allow multifd sync without flush
  migration/multifd: Standardize on multifd ops names
  migration/multifd: Register nocomp ops dynamically
  migration/multifd: Move nocomp code into multifd-nocomp.c
  migration/multifd: Make MultiFDMethods const
  migration/multifd: Stop changing the packet on recv side
  migration/multifd: Fix p->iov leak in multifd-uadk.c
  migration/multifd: Add a couple of asserts for p->iov
  migration/multifd: Add documentation for multifd methods

Peter Maydell (9):
  tests/qtest/migration-test: Fix bootfile cleanup handling
  tests/qtest/migration-test: Don't leak resp in
    multifd_mapped_ram_fdset_end()
  tests/qtest/migration-test: Fix leaks in calc_dirtyrate_ready()
  tests/qtest/migration-helpers: Fix migrate_get_socket_address() leak
  tests/qtest/migration-test: Free QCRyptoTLSTestCertReq objects
  tests/unit/crypto-tls-x509-helpers: deinit privkey in test_tls_cleanup
  tests/qtest/migration-helpers: Don't dup argument to qdict_put_str()
  tests/qtest/migration-test: Don't strdup in get_dirty_rate()
  tests/qtest/migration-test: Don't leak QTestState in
    test_multifd_tcp_cancel()

Steve Sistare (1):
  migration: delete unused parameter mis

Thomas Huth (1):
  tests/qtest/migration: Add a check for the availability of the "pc"
    machine

 migration/file.c                     |   3 +-
 migration/file.h                     |   2 +-
 migration/meson.build                |   1 +
 migration/multifd-nocomp.c           | 389 +++++++++++++++++++
 migration/multifd-qpl.c              |  79 +---
 migration/multifd-uadk.c             | 104 ++---
 migration/multifd-zero-page.c        |  13 +-
 migration/multifd-zlib.c             |  99 ++---
 migration/multifd-zstd.c             |  98 +----
 migration/multifd.c                  | 559 +++++----------------------
 migration/multifd.h                  | 152 ++++++--
 migration/ram.c                      |  10 +-
 migration/savevm.c                   |  10 +-
 migration/trace-events               |   9 +-
 target/ppc/machine.c                 |   2 +-
 tests/qtest/libqtest.c               |  17 +-
 tests/qtest/libqtest.h               |   2 -
 tests/qtest/migration-helpers.c      |  20 +-
 tests/qtest/migration-test.c         | 114 +-----
 tests/unit/crypto-tls-x509-helpers.c |  13 +-
 tests/unit/crypto-tls-x509-helpers.h |   6 +
 21 files changed, 772 insertions(+), 930 deletions(-)
 create mode 100644 migration/multifd-nocomp.c

-- 
2.35.3


