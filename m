Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B83EC3ABC0
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 16:00:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uChAg-0004o7-N7; Wed, 07 May 2025 11:58:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uChAf-0004nd-I4
 for qemu-devel@nongnu.org; Wed, 07 May 2025 11:58:57 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uChAZ-0003In-FW
 for qemu-devel@nongnu.org; Wed, 07 May 2025 11:58:57 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2A9ED211CA;
 Wed,  7 May 2025 15:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1746633521; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Bq1vzpuEoohtdtFqzEJTfy3+fQFScKZxsZ2cGfOiP/c=;
 b=QVgciK7Gm/tzl3ONIBSwFGxP+VqTvOoaA6VN8t2aofWi63Vw8av5t5SztFj7fk7GO64Efu
 bSRswkqS9J1C0Dvju43SBoanDOdlTdC9DnffLxF78TcdcEEcFzjGLoZBd528Iy3eleH1eh
 WSNpv8rMQp8B+oNSDSDHr+kXJtGchMc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1746633521;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Bq1vzpuEoohtdtFqzEJTfy3+fQFScKZxsZ2cGfOiP/c=;
 b=VJmiUXfCCKbIiTVlWpMDxZJlIZiwVHTpf3CofIhHLiZnkXDErsSsj/ZYurzU2Q5MjyGrBY
 e5+tcVRju13uSZCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1746633521; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Bq1vzpuEoohtdtFqzEJTfy3+fQFScKZxsZ2cGfOiP/c=;
 b=QVgciK7Gm/tzl3ONIBSwFGxP+VqTvOoaA6VN8t2aofWi63Vw8av5t5SztFj7fk7GO64Efu
 bSRswkqS9J1C0Dvju43SBoanDOdlTdC9DnffLxF78TcdcEEcFzjGLoZBd528Iy3eleH1eh
 WSNpv8rMQp8B+oNSDSDHr+kXJtGchMc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1746633521;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Bq1vzpuEoohtdtFqzEJTfy3+fQFScKZxsZ2cGfOiP/c=;
 b=VJmiUXfCCKbIiTVlWpMDxZJlIZiwVHTpf3CofIhHLiZnkXDErsSsj/ZYurzU2Q5MjyGrBY
 e5+tcVRju13uSZCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 11344139D9;
 Wed,  7 May 2025 15:58:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id qFMGMC+DG2gncQAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 07 May 2025 15:58:39 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>
Subject: [PATCH 1/3] ci: Re-enable python subtests in qtest migration suite
Date: Wed,  7 May 2025 12:58:33 -0300
Message-Id: <20250507155835.31074-2-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250507155835.31074-1-farosas@suse.de>
References: <20250507155835.31074-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email];
 RCVD_TLS_ALL(0.00)[]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

The migration compatibility tests have been running with the PYTHON
variable unset to avoid running a broken test. The faulty test has
since been removed, so we can enable the python tests once again.

Aside from the broken test, only one other test uses python and I have
been running it locally ever since, so this commit should not expose
any new bug.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 .gitlab-ci.d/buildtest.yml | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
index 431bc07d8f..ccf69fb8dd 100644
--- a/.gitlab-ci.d/buildtest.yml
+++ b/.gitlab-ci.d/buildtest.yml
@@ -227,14 +227,6 @@ build-previous-qemu:
     # testing an old QEMU against new features/tests that it is not
     # compatible with.
     - cd build-previous
-    # Don't allow python-based tests to run. The
-    # vmstate-checker-script test has a race that causes it to fail
-    # sometimes. It cannot be fixed it because this job runs the test
-    # from the old QEMU version. The test will be removed on master,
-    # but this job will only see the change in the next release.
-    #
-    # TODO: remove this line after 9.2 release
-    - unset PYTHON
     # old to new
     - QTEST_QEMU_BINARY_SRC=./qemu-system-${TARGET}
           QTEST_QEMU_BINARY=../build/qemu-system-${TARGET} ./tests/qtest/migration-test
-- 
2.35.3


