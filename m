Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF0A2E77197
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2025 22:06:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTTKz-000474-Kh; Thu, 02 Jan 2025 17:06:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tTTKu-00045c-OE
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 17:06:37 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tTTKs-00076l-M9
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 17:06:36 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 01E38211A5
 for <qemu-devel@nongnu.org>; Thu,  2 Jan 2025 22:06:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1735855593; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=W16EDWhUikHN1jB8MXskdFeUKZvu8F6jAEkRTmjXA/g=;
 b=y4+FLipRbsxCotak67BuwLqcaWCGX7FTtPtihzooFCGU19FdDA1rki/hkPhN+VCjEGHmL1
 qAqiJB4UdrqOvESdOP3ehiKOrqu4rogR8r/EMqPs6Sy9tJteRuxGKuZHmWKFzHdlhqNSx7
 0qEd5PeetL6zgSe9jasL3aFVc1ZVHIo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1735855593;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=W16EDWhUikHN1jB8MXskdFeUKZvu8F6jAEkRTmjXA/g=;
 b=DmxveDNXg2s04wwWcZZvr2/dPZC9ZHini7o0oCVPkgMg0zlP52kHzL35GpzJPdPVk+QKox
 XXQK+EWJFatQrlDw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=y4+FLipR;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=DmxveDNX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1735855593; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=W16EDWhUikHN1jB8MXskdFeUKZvu8F6jAEkRTmjXA/g=;
 b=y4+FLipRbsxCotak67BuwLqcaWCGX7FTtPtihzooFCGU19FdDA1rki/hkPhN+VCjEGHmL1
 qAqiJB4UdrqOvESdOP3ehiKOrqu4rogR8r/EMqPs6Sy9tJteRuxGKuZHmWKFzHdlhqNSx7
 0qEd5PeetL6zgSe9jasL3aFVc1ZVHIo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1735855593;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=W16EDWhUikHN1jB8MXskdFeUKZvu8F6jAEkRTmjXA/g=;
 b=DmxveDNXg2s04wwWcZZvr2/dPZC9ZHini7o0oCVPkgMg0zlP52kHzL35GpzJPdPVk+QKox
 XXQK+EWJFatQrlDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 44DE0132EA
 for <qemu-devel@nongnu.org>; Thu,  2 Jan 2025 22:06:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 7YC5AugNd2emeQAAD6G6ig
 (envelope-from <farosas@suse.de>)
 for <qemu-devel@nongnu.org>; Thu, 02 Jan 2025 22:06:32 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Subject: [PULL 0/8] QTest patches for 2025-01-02
Date: Thu,  2 Jan 2025 19:06:21 -0300
Message-Id: <20250102220629.11351-1-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 01E38211A5
X-Spamd-Result: default: False [-3.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 MIME_TRACE(0.00)[0:+]; RCPT_COUNT_ONE(0.00)[1];
 FROM_HAS_DN(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]; TO_DN_NONE(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 PREVIOUSLY_DELIVERED(0.00)[qemu-devel@nongnu.org];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns, suse.de:dkim, suse.de:mid]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
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

The following changes since commit 8b70d7f2071e2db51b1910502bfb7f84ebf926be:

  Merge tag 'hw-misc-20241231' of https://github.com/philmd/qemu into staging (2025-01-01 15:17:08 -0500)

are available in the Git repository at:

  https://gitlab.com/farosas/qemu.git tags/qtest-20250102-pull-request

for you to fetch changes up to d9f2b09dd6c3030cda9af9c29e26a0bdfc02bec6:

  qtest/fw-cfg: remove compiled out code (2025-01-02 19:02:11 -0300)

----------------------------------------------------------------
Qtest pull request

- migration-test: fix UADK build, reinstate postcopy tests and other cleanups
- a couple of memory leak fixes for bios-tables-test and virtio-iommu-test
- drop dead code from fw_cfg-test

----------------------------------------------------------------

Ani Sinha (1):
  qtest/fw-cfg: remove compiled out code

Fabiano Rosas (5):
  tests/qtest/migration: Do proper cleanup in the dirty_limit test
  tests/qtest/migration: Initialize buffer in probe_o_direct_support
  tests/qtest/bios-tables-test: Free tables at dump_aml_files
  tests/qtest/virtio-iommu-test: Don't pass uninitialized data into
    qtest_memwrite
  tests/qtest/migration: Re-enable postcopy tests

Peter Xu (1):
  tests/migration: Drop arch_[source|target]

Shameer Kolothum (1):
  tests/qtest/migration: Fix compile errors when CONFIG_UADK is set

 tests/qtest/bios-tables-test.c            |  1 +
 tests/qtest/fw_cfg-test.c                 |  6 ---
 tests/qtest/migration/compression-tests.c | 54 -----------------------
 tests/qtest/migration/framework.c         |  8 +---
 tests/qtest/migration/migration-util.c    |  7 ++-
 tests/qtest/migration/precopy-tests.c     |  5 +++
 tests/qtest/virtio-iommu-test.c           |  4 +-
 7 files changed, 16 insertions(+), 69 deletions(-)

-- 
2.35.3


