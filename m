Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05116C3ABD7
	for <qemu-devel@archiver.kernel.org>; Tue, 13 May 2025 13:34:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEpm3-0001gH-Vs; Tue, 13 May 2025 09:34:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uEpm1-0001g3-Ug
 for qemu-devel@nongnu.org; Tue, 13 May 2025 09:34:21 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uEplz-0007xE-DL
 for qemu-devel@nongnu.org; Tue, 13 May 2025 09:34:21 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A5C1D211F9;
 Tue, 13 May 2025 13:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1747143240; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KHNEDmRoun4XyxRZAhKoNvbnbo6tI9VO9hyy6Snzr+8=;
 b=1i8w457CJEHH+qRa4Afk2fbHCbuc3FQhHFz1rUyN81u1/3Wx4aZAxv5SGqmNlMBvjgH8Hg
 SA2bvirwgnwZMrywF5Kgp7s4N3lrr+CAtgeUjaRWv5Paeuls60ucidMpyjNsgnhUaKaEl3
 RL7GvKsvlWOwgGFhL2k8YQCK/WrpcFA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1747143240;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KHNEDmRoun4XyxRZAhKoNvbnbo6tI9VO9hyy6Snzr+8=;
 b=tjtjpkrrDuGj4q7ETNoXmmFQjVkeVHPbpNscIo+EW2l6rs4kO2AjB2sYMidAWLu5JfprNf
 t6UNyaysB/V+oWAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1747143240; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KHNEDmRoun4XyxRZAhKoNvbnbo6tI9VO9hyy6Snzr+8=;
 b=1i8w457CJEHH+qRa4Afk2fbHCbuc3FQhHFz1rUyN81u1/3Wx4aZAxv5SGqmNlMBvjgH8Hg
 SA2bvirwgnwZMrywF5Kgp7s4N3lrr+CAtgeUjaRWv5Paeuls60ucidMpyjNsgnhUaKaEl3
 RL7GvKsvlWOwgGFhL2k8YQCK/WrpcFA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1747143240;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KHNEDmRoun4XyxRZAhKoNvbnbo6tI9VO9hyy6Snzr+8=;
 b=tjtjpkrrDuGj4q7ETNoXmmFQjVkeVHPbpNscIo+EW2l6rs4kO2AjB2sYMidAWLu5JfprNf
 t6UNyaysB/V+oWAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5B18B1365D;
 Tue, 13 May 2025 13:33:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id GNJZB0dKI2gMXgAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 13 May 2025 13:33:59 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH v2 2/3] ci: Fix build-previous-qemu when the version tag is
 absent
Date: Tue, 13 May 2025 10:33:52 -0300
Message-Id: <20250513133353.23022-3-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250513133353.23022-1-farosas@suse.de>
References: <20250513133353.23022-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 RCVD_TLS_ALL(0.00)[]
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
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 .gitlab-ci.d/buildtest.yml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
index fbad34138c..b4e39fd7c1 100644
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
@@ -223,6 +228,9 @@ build-previous-qemu:
     IMAGE: opensuse-leap
     MAKE_CHECK_ARGS: check-build
   script:
+    # Skip for round release numbers, this job is only relevant for
+    # testing a development tree.
+    - if grep -q "\.0$" VERSION; then exit 0; fi
     # Use the migration-tests from the older QEMU tree. This avoids
     # testing an old QEMU against new features/tests that it is not
     # compatible with.
-- 
2.35.3


