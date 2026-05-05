Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF0D6FF8855
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 16:11:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKIM3-0008Mn-Ea; Tue, 05 May 2026 12:10:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wKIKw-0007o9-8S
 for qemu-devel@nongnu.org; Tue, 05 May 2026 12:09:33 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wKIKr-00077v-Vg
 for qemu-devel@nongnu.org; Tue, 05 May 2026 12:09:29 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9A1C66B75E;
 Tue,  5 May 2026 16:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1777997362; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=dnHEiWY/BGbdv/3Mm1djZwQWvhABZ2CINpLSZrtqux8=;
 b=fytnll3iGRKMA5iE9jXH+q8Vu8JBf5+hp+IVZfQrbc7OGf3pUHQq5SroGO3143lpNl5Uva
 y/pQHARNLlqURcrWM31B07R1xwLfp/O43cbeu24+VshQqobRs9d0ILxdFPvZBQL5UBg5W9
 ZwrfjLhmUysnyu76ul2vNp/G1onIPq8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1777997362;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=dnHEiWY/BGbdv/3Mm1djZwQWvhABZ2CINpLSZrtqux8=;
 b=HNLhwI0PZDS0dmEBodtDIZuiRtZTCDOcje9wisY17Y21HWEnJLFtRPmF1zIUAFEgBOj9Aw
 SX+/d/RmoO8TAwBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1777997362; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=dnHEiWY/BGbdv/3Mm1djZwQWvhABZ2CINpLSZrtqux8=;
 b=fytnll3iGRKMA5iE9jXH+q8Vu8JBf5+hp+IVZfQrbc7OGf3pUHQq5SroGO3143lpNl5Uva
 y/pQHARNLlqURcrWM31B07R1xwLfp/O43cbeu24+VshQqobRs9d0ILxdFPvZBQL5UBg5W9
 ZwrfjLhmUysnyu76ul2vNp/G1onIPq8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1777997362;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=dnHEiWY/BGbdv/3Mm1djZwQWvhABZ2CINpLSZrtqux8=;
 b=HNLhwI0PZDS0dmEBodtDIZuiRtZTCDOcje9wisY17Y21HWEnJLFtRPmF1zIUAFEgBOj9Aw
 SX+/d/RmoO8TAwBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D224F593A3;
 Tue,  5 May 2026 16:09:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id x0v/JzEW+mmNcgAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 05 May 2026 16:09:21 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>
Subject: [PATCH v1 00/15] tests/qtest/migration: Always defer
Date: Tue,  5 May 2026 13:08:59 -0300
Message-ID: <20260505160915.25558-1-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[]
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

As discussed before, change the tests to always use -incoming
defer. Also remove one of the uris from MigrateCommon, a single uri is
enough.

CI run: https://gitlab.com/farosas/qemu/-/pipelines/2501387628

Fabiano Rosas (15):
  tests/qtest/migration: Move cpr transfer logic into cpr-tests.c
  tests/qtest/migration: Make file-tests defer by default
  tests/qtest/migration: Set file URI by default
  tests/qtest/migration: Group unix migration tests
  tests/qtest/migration: Use precopy_unix_common for ignore-shared test
  tests/qtest/migration: Use a default TCP URI for precopy
  tests/qtest/migration: Defer by default in precopy_common
  tests/qtest/migration: Set compression method in compression-tests
  tests/qtest/migration: Remove multifd compression hook
  tests/qtest/migration: Use defer for all tests
  tests/qtest/migration: Use defer for cpr-tests
  tests/qtest/migration: Use defer for auto-converge
  tests/qtest/migration: Use defer in dirty_limit test
  tests/qtest/migration: Stop passing URI into migrate_start
  tests/qtest/migration: Unify URIs

 tests/qtest/migration/colo-tests.c        |  16 ++--
 tests/qtest/migration/compression-tests.c |  34 +++----
 tests/qtest/migration/cpr-tests.c         |  85 +++++++++++++----
 tests/qtest/migration/file-tests.c        |  56 ++---------
 tests/qtest/migration/framework.c         |  91 +++++++-----------
 tests/qtest/migration/framework.h         |  26 ++---
 tests/qtest/migration/misc-tests.c        |  62 +++++-------
 tests/qtest/migration/precopy-tests.c     |  82 ++++------------
 tests/qtest/migration/tls-tests.c         | 110 +++-------------------
 9 files changed, 192 insertions(+), 370 deletions(-)

-- 
2.51.0


