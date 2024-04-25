Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52BEAC19F4E
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 15:11:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s00jM-0000lK-DJ; Thu, 25 Apr 2024 11:09:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1s00jK-0000kp-Pv
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 11:09:46 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1s00jI-0000P4-TJ
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 11:09:46 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1E71A5BD99;
 Thu, 25 Apr 2024 15:09:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1714057783; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=dQtSa2hfjcdz169xmUIVMrp0H9cjYaBM46p4FRynbEc=;
 b=vCojdrHz/aOx7ANOIHai4ny2Ykjhr6SCuUVj7UGvYfSB0qsiEjVutCXtxbX8pkJr8hxLpX
 yAhIZAPNNiP6L5UWdevKf+yWV24k6h0GphxG1M2gAIuqKrYxxjpj4gAUhH+iSMpAUhcT1y
 Fh8YLH1Cb3rVB+p59tkCxiuIaqH0Ft4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1714057783;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=dQtSa2hfjcdz169xmUIVMrp0H9cjYaBM46p4FRynbEc=;
 b=yKkWwX6t7aRdLqmE1h1QlNHD57G9arGY1/wJEImm59CboTQxe2UBxxNJXu62QvfAo3BOEt
 +Tq1DQ2n7YKWM2Cw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=vCojdrHz;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=yKkWwX6t
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1714057783; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=dQtSa2hfjcdz169xmUIVMrp0H9cjYaBM46p4FRynbEc=;
 b=vCojdrHz/aOx7ANOIHai4ny2Ykjhr6SCuUVj7UGvYfSB0qsiEjVutCXtxbX8pkJr8hxLpX
 yAhIZAPNNiP6L5UWdevKf+yWV24k6h0GphxG1M2gAIuqKrYxxjpj4gAUhH+iSMpAUhcT1y
 Fh8YLH1Cb3rVB+p59tkCxiuIaqH0Ft4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1714057783;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=dQtSa2hfjcdz169xmUIVMrp0H9cjYaBM46p4FRynbEc=;
 b=yKkWwX6t7aRdLqmE1h1QlNHD57G9arGY1/wJEImm59CboTQxe2UBxxNJXu62QvfAo3BOEt
 +Tq1DQ2n7YKWM2Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A94E51393C;
 Thu, 25 Apr 2024 15:09:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id AFPVGzVyKma9DQAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 25 Apr 2024 15:09:41 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Xu <peterx@redhat.com>, devel@lists.libvirt.org
Subject: [PATCH 0/6] migration removals & deprecations
Date: Thu, 25 Apr 2024 12:09:33 -0300
Message-Id: <20240425150939.19268-1-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 1E71A5BD99
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.21 / 50.00];
 SEM_URIBL(3.50)[gitlab.com:url]; BAYES_HAM(-3.00)[100.00%];
 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; BAD_REP_POLICIES(0.10)[];
 MX_GOOD(-0.01)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[];
 R_DKIM_ALLOW(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCPT_COUNT_THREE(0.00)[4]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[meson.build:url, imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns, suse.de:dkim]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
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

Hi everyone,

Here's some cleaning up of deprecated code. It removes the old block
migration and compression code. Both have suitable replacements in the
form of the blockdev-mirror driver and multifd compression,
respectively.

There's also a deprecation for fd: + file to cope with the fact that
the new MigrationAddress API defines transports instead of protocols
(loose terms) like the old string API did. So we cannot map 1:1 from
fd: to any transport because fd: allows *both* file migration and
socket migration.

CI run: https://gitlab.com/farosas/qemu/-/pipelines/1267859704

Fabiano Rosas (6):
  migration: Remove 'skipped' field from MigrationStats
  migration: Remove 'inc' option from migrate command
  migration: Remove 'blk/-b' option from migrate commands
  migration: Remove block migration
  migration: Remove non-multifd compression
  migration: Deprecate fd: for file migration

 .gitlab-ci.d/buildtest.yml       |    2 +-
 MAINTAINERS                      |    1 -
 docs/about/deprecated.rst        |   51 +-
 docs/about/removed-features.rst  |  104 ++-
 docs/devel/migration/main.rst    |    2 +-
 hw/core/machine.c                |    1 -
 include/migration/misc.h         |    6 -
 meson.build                      |    2 -
 meson_options.txt                |    2 -
 migration/block.c                | 1019 ------------------------------
 migration/block.h                |   52 --
 migration/colo.c                 |    1 -
 migration/meson.build            |    4 -
 migration/migration-hmp-cmds.c   |   97 +--
 migration/migration.c            |   70 +-
 migration/migration.h            |    7 -
 migration/options.c              |  229 -------
 migration/ram-compress.c         |  564 -----------------
 migration/ram.c                  |  166 +----
 migration/savevm.c               |    5 -
 qapi/migration.json              |  205 +-----
 scripts/meson-buildoptions.sh    |    4 -
 tests/qemu-iotests/183           |  147 -----
 tests/qemu-iotests/183.out       |   66 --
 tests/qemu-iotests/common.filter |    7 -
 tests/qtest/migration-test.c     |  139 ----
 26 files changed, 130 insertions(+), 2823 deletions(-)
 delete mode 100644 migration/block.c
 delete mode 100644 migration/block.h
 delete mode 100644 migration/ram-compress.c
 delete mode 100755 tests/qemu-iotests/183
 delete mode 100644 tests/qemu-iotests/183.out

-- 
2.35.3


