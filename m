Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01145FF887E
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 00:32:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHsqG-0001fl-4G; Tue, 28 Apr 2026 20:31:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wHsqA-0001eV-8U
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 20:31:46 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wHsq8-0004SS-I8
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 20:31:46 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 159495BD3F
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 00:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1777422701; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=XXY7HCOLpCskfTMmIfCIFUbuKFkTh2ffH+q24y9GptM=;
 b=QRdc0xI9FW7Q+hTbsW5QpkorkUD6O0tOiHNO6hYjDWI8Y1PYI2cnPMrANOg08XGlchgqla
 K+iPFFJPxd4XqCCX/DfKGQsiTPvAT7ZfqTqOlvw16KGEVN/13HVr5HrVA8OQzHnCpjg9Vo
 qu5fALIeYOsMFEq8ncue93XvF6KR5kM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1777422701;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=XXY7HCOLpCskfTMmIfCIFUbuKFkTh2ffH+q24y9GptM=;
 b=SO7ZtJIIeXlAKswYNfL7bgv6AHKaTCBZ+Ni9qVULCiaBj67XbJoF4iUnzg2L4tyXacydLd
 kA58mIVlqNZ46yAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1777422701; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=XXY7HCOLpCskfTMmIfCIFUbuKFkTh2ffH+q24y9GptM=;
 b=QRdc0xI9FW7Q+hTbsW5QpkorkUD6O0tOiHNO6hYjDWI8Y1PYI2cnPMrANOg08XGlchgqla
 K+iPFFJPxd4XqCCX/DfKGQsiTPvAT7ZfqTqOlvw16KGEVN/13HVr5HrVA8OQzHnCpjg9Vo
 qu5fALIeYOsMFEq8ncue93XvF6KR5kM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1777422701;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=XXY7HCOLpCskfTMmIfCIFUbuKFkTh2ffH+q24y9GptM=;
 b=SO7ZtJIIeXlAKswYNfL7bgv6AHKaTCBZ+Ni9qVULCiaBj67XbJoF4iUnzg2L4tyXacydLd
 kA58mIVlqNZ46yAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7809F593B0
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 00:31:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Gye6EWxR8WnseQAAD6G6ig
 (envelope-from <farosas@suse.de>)
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 00:31:40 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 0/3] tests/qtest: Tweak env variables
Date: Tue, 28 Apr 2026 21:31:27 -0300
Message-ID: <20260429003130.15164-1-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; TO_DN_NONE(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 RCPT_COUNT_ONE(0.00)[1]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FROM_HAS_DN(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[qemu-devel@nongnu.org];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo]
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

Allow QEMU command line options to be passed via an environment
variable, make QTEST_LOG more useful and document QTEST standard
variables.

CI run: https://gitlab.com/farosas/qemu/-/pipelines/2486792726

Fabiano Rosas (3):
  tests/qtest/libqtest: Replace QTEST_TRACE with QTEST_QEMU_ARGS
  tests/qtest: Individual verbose switches
  docs/devel/qtest: Mention environment variables usage

 docs/devel/testing/qtest.rst          | 33 +++++++++++++
 tests/qtest/fuzz/fuzz.c               |  7 +--
 tests/qtest/fuzz/generic_fuzz.c       |  2 +-
 tests/qtest/libqmp.c                  |  7 +--
 tests/qtest/libqtest.c                | 67 ++++++++++++++++++++++++---
 tests/qtest/libqtest.h                | 11 +++++
 tests/qtest/migration/framework.c     |  2 +-
 tests/qtest/migration/framework.h     |  5 +-
 tests/qtest/migration/precopy-tests.c |  2 +-
 tests/unit/meson.build                |  2 +-
 tests/unit/test-qga.c                 |  2 +-
 11 files changed, 120 insertions(+), 20 deletions(-)

-- 
2.51.0


