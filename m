Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02723C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2024 14:21:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s0MRY-00074H-MB; Fri, 26 Apr 2024 10:20:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1s0MRX-00073z-Kr
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 10:20:51 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1s0MRV-0001ik-Vk
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 10:20:51 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 30965227DD;
 Fri, 26 Apr 2024 14:20:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1714141248; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=PeUb6rqCcIMGpo2cSQMhh/lSuPgR1i+KzSqUBIQZ3EY=;
 b=VorzYvuNflR1IyMG+HcjiYqKGkjMxoTwlpRchUA1uC2CWhr+8P9HfBrpnYltuj6FLTAWQv
 M46z/fxJXYE+y18pEf8sU4dQ3dNTjPCnrUrtWGJry79MjinfoDr3XJlcmvY8VDpOzXE9gE
 Z/n/kmi32JUGO6XI7RfhR/BnXBTGIJ4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1714141248;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=PeUb6rqCcIMGpo2cSQMhh/lSuPgR1i+KzSqUBIQZ3EY=;
 b=vWLYZIKweHezZaTho282k02DA7le3dWykdnrQEv4pwjoTFtv7Fkm+DwOnlRHCFSxY9/iDk
 UnEwslHepjySMkBQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Xa71TPl2;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=lJ4LD7Ub
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1714141247; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=PeUb6rqCcIMGpo2cSQMhh/lSuPgR1i+KzSqUBIQZ3EY=;
 b=Xa71TPl2p778qlrLznOs4WJvg4jOE7PQiTUlDIUH4j9CgiacV0JInVeXFXpRAkIWXGVhnA
 Ft9/lqsP+Zm8wjYxjPAHcBqHBxGdilrjYzuPKcKNMoMOBD4gNbu2y9v1STW/O/GphT/UNq
 h1S0NH3mbP8MHt3RQk7mB+xQMm8ps9A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1714141247;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=PeUb6rqCcIMGpo2cSQMhh/lSuPgR1i+KzSqUBIQZ3EY=;
 b=lJ4LD7UbY+WU8ax96Syb+dkpMpOi0qubKQmY4Cxu0cZk3V5gW7vp6ADQCKLfvpdB6/WLYv
 TfWe5SP4900JeUBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 53476136DB;
 Fri, 26 Apr 2024 14:20:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id SNjoBj24K2YWcAAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 26 Apr 2024 14:20:45 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, armbru@redhat.com, Peter Xu <peterx@redhat.com>,
 Claudio Fontana <cfontana@suse.de>, Jim Fehlig <jfehlig@suse.com>
Subject: [PATCH 0/9] migration/mapped-ram: Add direct-io support
Date: Fri, 26 Apr 2024 11:20:33 -0300
Message-Id: <20240426142042.14573-1-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.79 / 50.00]; SEM_URIBL(3.50)[gitlab.com:url];
 BAYES_HAM(-3.00)[100.00%]; MID_CONTAINS_FROM(1.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; R_MISSING_CHARSET(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 BAD_REP_POLICIES(0.10)[]; MX_GOOD(-0.01)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 MIME_TRACE(0.00)[0:+]; TO_DN_SOME(0.00)[]; ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 R_DKIM_ALLOW(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; DKIM_TRACE(0.00)[suse.de:+];
 RCPT_COUNT_FIVE(0.00)[6]; RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns, suse.de:dkim]
X-Spamd-Bar: /
X-Rspamd-Queue-Id: 30965227DD
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
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

Hi everyone, here's the rest of the migration "mapped-ram" feature
that didn't get merged for 9.0. This series adds support for direct
I/O, the missing piece to get the desired performance improvements.

There's 3 parts to this:

1- The plumbing for the new "direct-io" migration parameter. With this
   we can already use direct-io with the file transport + multifd +
   mapped-ram. Patches 1-3.

Due to the alignment requirements of O_DIRECT and the fact that
multifd runs the channels in parallel with the migration thread, we
must open the migration file two times, one with O_DIRECT set and
another with it clear.

If the user is not passing in a file name which QEMU can open at will,
we must then require that the user pass the two file descriptors with
the flags already properly set. We'll use the already existing fdset +
QMP add-fd infrastructure for this.

2- Changes to the fdset infrastructure to support O_DIRECT. We need
   those to be able to select from the user-provided fdset the file
   descriptor that contains the O_DIRECT flag. Patches 4-5.

3- Some fdset validation to make sure the two-fds requirement is being
   met. Patches 6-7.

CI run: https://gitlab.com/farosas/qemu/-/pipelines/1269352083

Fabiano Rosas (9):
  monitor: Honor QMP request for fd removal immediately
  migration: Fix file migration with fdset
  tests/qtest/migration: Fix file migration offset check
  migration: Add direct-io parameter
  migration/multifd: Add direct-io support
  tests/qtest/migration: Add tests for file migration with direct-io
  monitor: fdset: Match against O_DIRECT
  migration: Add support for fdset with multifd + file
  tests/qtest/migration: Add a test for mapped-ram with passing of fds

 docs/devel/migration/main.rst       |  18 +++
 docs/devel/migration/mapped-ram.rst |   6 +-
 include/qemu/osdep.h                |   2 +
 migration/file.c                    | 108 ++++++++++++++-
 migration/migration-hmp-cmds.c      |  11 ++
 migration/migration.c               |  23 ++++
 migration/options.c                 |  30 +++++
 migration/options.h                 |   1 +
 monitor/fds.c                       |  13 +-
 qapi/migration.json                 |  18 ++-
 tests/qtest/migration-helpers.c     |  42 ++++++
 tests/qtest/migration-helpers.h     |   1 +
 tests/qtest/migration-test.c        | 202 +++++++++++++++++++++++++++-
 util/osdep.c                        |   9 ++
 14 files changed, 465 insertions(+), 19 deletions(-)


base-commit: a118c4aff4087eafb68f7132b233ad548cf16376
-- 
2.35.3


