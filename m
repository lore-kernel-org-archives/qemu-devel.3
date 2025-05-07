Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FEC0C3ABC0
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 16:00:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uChAY-0004nH-3W; Wed, 07 May 2025 11:58:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uChAW-0004n0-Vu
 for qemu-devel@nongnu.org; Wed, 07 May 2025 11:58:49 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uChAV-0003IB-2S
 for qemu-devel@nongnu.org; Wed, 07 May 2025 11:58:48 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0D31D1F395;
 Wed,  7 May 2025 15:58:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1746633523; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+5A218k2P9cL7MdCXkGRLYlHUHMdTZlrWe9qPjNaFNE=;
 b=S+uiBBiTrTCFI9uQbIkdI3vRkPibLn3Na9+O3CfM7K/TAUB49jqugFKboqhiyIKZiHaSck
 QBbuuJAGbL5e+8HrkRmtbJuyUeXhw0/GGda67e0UnA1H8o6KpZd9sFkwHmKAsHrDuTkJ3w
 qOzoIRmEkZTeX6s1httSGuKs1ezcw4I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1746633523;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+5A218k2P9cL7MdCXkGRLYlHUHMdTZlrWe9qPjNaFNE=;
 b=HSaZNJH1EO8oFgsFo+mahg95euaLukeQYRvZqG6ZcNXBqpKqxp+/9EiE4sBMlwf9KQs8oG
 5vPLs0mIiRnLlxCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1746633523; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+5A218k2P9cL7MdCXkGRLYlHUHMdTZlrWe9qPjNaFNE=;
 b=S+uiBBiTrTCFI9uQbIkdI3vRkPibLn3Na9+O3CfM7K/TAUB49jqugFKboqhiyIKZiHaSck
 QBbuuJAGbL5e+8HrkRmtbJuyUeXhw0/GGda67e0UnA1H8o6KpZd9sFkwHmKAsHrDuTkJ3w
 qOzoIRmEkZTeX6s1httSGuKs1ezcw4I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1746633523;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+5A218k2P9cL7MdCXkGRLYlHUHMdTZlrWe9qPjNaFNE=;
 b=HSaZNJH1EO8oFgsFo+mahg95euaLukeQYRvZqG6ZcNXBqpKqxp+/9EiE4sBMlwf9KQs8oG
 5vPLs0mIiRnLlxCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A7DBB139D9;
 Wed,  7 May 2025 15:58:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 4FwJGTGDG2gncQAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 07 May 2025 15:58:41 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH 2/3] ci: Fix build-previous-qemu when the version tag is absent
Date: Wed,  7 May 2025 12:58:34 -0300
Message-Id: <20250507155835.31074-3-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250507155835.31074-1-farosas@suse.de>
References: <20250507155835.31074-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; FUZZY_BLOCKED(0.00)[rspamd.com];
 MIME_TRACE(0.00)[0:+]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Stefan reports that during QEMU release, pushing a series with the
VERSION bump commit, but not pushing the new git tag in the same
command will cause a failure of the build-previous-qemu job at the git
fetch step.

Since the job is intended to produce a build of the previous QEMU
version for consumption by the migration-compat-* jobs, there's no
reason to produce a build of the release commit because the migration
job would end up testing the release against itself.

Skip the job when VERSION contains the newly release version number.

I'm opting for 'exit 0' for both the build and the test jobs because
allow_failure would mask any real error in the jobs. It also avoids
having an orange ! on every release pipeline.

Reported-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 .gitlab-ci.d/buildtest.yml | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
index ccf69fb8dd..159bdde2e8 100644
--- a/.gitlab-ci.d/buildtest.yml
+++ b/.gitlab-ci.d/buildtest.yml
@@ -203,6 +203,11 @@ build-previous-qemu:
     GIT_FETCH_EXTRA_FLAGS: --prune --quiet
   before_script:
     - source scripts/ci/gitlab-ci-section
+    # Skip if this series contains the release bump commit. During the
+    # release process there might be a window of commits when the
+    # version tag is not yet present in the remote and git fetch would
+    # fail.
+    - if grep -q "\.0$" VERSION; then exit 0; fi
     - export QEMU_PREV_VERSION="$(sed 's/\([0-9.]*\)\.[0-9]*/v\1.0/' VERSION)"
     - git remote add upstream https://gitlab.com/qemu-project/qemu
     - git fetch upstream refs/tags/$QEMU_PREV_VERSION:refs/tags/$QEMU_PREV_VERSION
@@ -226,7 +231,8 @@ build-previous-qemu:
     # Use the migration-tests from the older QEMU tree. This avoids
     # testing an old QEMU against new features/tests that it is not
     # compatible with.
-    - cd build-previous
+    # Skip if build-previous-qemu has failed.
+    - cd build-previous || exit 0
     # old to new
     - QTEST_QEMU_BINARY_SRC=./qemu-system-${TARGET}
           QTEST_QEMU_BINARY=../build/qemu-system-${TARGET} ./tests/qtest/migration-test
-- 
2.35.3


