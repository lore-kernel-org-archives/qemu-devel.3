Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C773C41513
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 20:20:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAEud-0000do-5w; Thu, 23 May 2024 16:19:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sAEuc-0000d3-6q
 for qemu-devel@nongnu.org; Thu, 23 May 2024 16:19:42 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sAEuP-0002G0-3V
 for qemu-devel@nongnu.org; Thu, 23 May 2024 16:19:41 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B2B322049B;
 Thu, 23 May 2024 20:19:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1716495566; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=LOUiqTkYaqAXpqKd/UfZC/rKgV09kJQX5VhTGsTaLA0=;
 b=QsZqM4ApvY3NndCmDXb6mvUWfrtee13Sty2FCYH50jl3w+IFStMBi78i7uaW5HPba/1k8i
 M/bdq9g4vQP7Stt6RZMOxZNxkhlhkWUJI8WTlMgRfe3quifLGhKRPQ+Z6E52at8jesqKDe
 vQwCKMTQROFkkTbnhEv2U4JMsyOXgtk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1716495566;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=LOUiqTkYaqAXpqKd/UfZC/rKgV09kJQX5VhTGsTaLA0=;
 b=tfunJeH2QqnNISZJjGqDJhBx3JrXRysjdzsRtyBbb5RsoJxhLDsQ1Lf2gdj5ShH6aKzzEo
 ZN/bs1Zq1vlHDLAw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=QsZqM4Ap;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=tfunJeH2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1716495566; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=LOUiqTkYaqAXpqKd/UfZC/rKgV09kJQX5VhTGsTaLA0=;
 b=QsZqM4ApvY3NndCmDXb6mvUWfrtee13Sty2FCYH50jl3w+IFStMBi78i7uaW5HPba/1k8i
 M/bdq9g4vQP7Stt6RZMOxZNxkhlhkWUJI8WTlMgRfe3quifLGhKRPQ+Z6E52at8jesqKDe
 vQwCKMTQROFkkTbnhEv2U4JMsyOXgtk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1716495566;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=LOUiqTkYaqAXpqKd/UfZC/rKgV09kJQX5VhTGsTaLA0=;
 b=tfunJeH2QqnNISZJjGqDJhBx3JrXRysjdzsRtyBbb5RsoJxhLDsQ1Lf2gdj5ShH6aKzzEo
 ZN/bs1Zq1vlHDLAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D697D13A6C;
 Thu, 23 May 2024 20:19:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id di58JsykT2ZqcgAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 23 May 2024 20:19:24 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Fiona Ebner <f.ebner@proxmox.com>, Het Gala <het.gala@nutanix.com>
Subject: [RFC PATCH 0/4] migration-test: Device migration smoke tests
Date: Thu, 23 May 2024 17:19:18 -0300
Message-Id: <20240523201922.28007-1-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: B2B322049B
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_SOME(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 ARC_NA(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+];
 RCPT_COUNT_FIVE(0.00)[6];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim, imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
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

We have discussed recently about two relatively cheap ways to catch
migration compatibility breakages across QEMU versions. This series
adds support for both.

1) vmstate-static-checker.py

This script has existed for a while and takes a dmup of vmstates from
two different QEMU versions and compares them.

The migration maintainer will run this before merges, but it's useless
for bugs that don't enter via the migration tree. I'm adding this test
to the CI for everyone.

Cons: the script can't handle renames and other compatible changes
that might happen to the vmstate structures without modification, so
these kinds of changes would fail the CI job during that release until
the script is fixed or the old QEMU version catches up. I think this
is passable because the CI job is already marked as allow_failure.

2) migration-tests with -device

We never ran the migration-tests with devices added to the QEMU
command line because the migration-tests run custom guest
code. However, just having the device in the command line already
causes it's state to be sent around and this has been shown to catch
bugs[1].

I'm adding support for running any migration-test with a list of
devices, either a hardcoded one provided by us, or a custom one
provided by whoever is experimenting with this code. This also give us
the ability to quickly check what happens when a new (to the tests)
device is added.

1- https://lore.kernel.org/r/87wmo5l58z.fsf@suse.de

Fabiano Rosas (4):
  tests/qtest/libqtest: Introduce another qtest_init version with no
    handshake
  tests/qtest/migration: Add a test that runs vmstate-static-checker
  tests/qtest/migration: Add support for simple device tests
  ci: Add the new migration device tests

 .gitlab-ci.d/buildtest.yml   |  43 ++++++++++++---
 tests/qtest/libqtest.c       |  14 +++--
 tests/qtest/libqtest.h       |  13 +++++
 tests/qtest/migration-test.c | 101 ++++++++++++++++++++++++++++++++++-
 4 files changed, 157 insertions(+), 14 deletions(-)


base-commit: 01782d6b294f95bcde334386f0aaac593cd28c0d
-- 
2.35.3


