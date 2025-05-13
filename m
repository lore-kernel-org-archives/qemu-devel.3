Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE8CBC3ABCC
	for <qemu-devel@archiver.kernel.org>; Tue, 13 May 2025 13:35:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEplx-0001f0-GT; Tue, 13 May 2025 09:34:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uEplu-0001e6-Gz
 for qemu-devel@nongnu.org; Tue, 13 May 2025 09:34:14 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uEplq-0007wb-Hl
 for qemu-devel@nongnu.org; Tue, 13 May 2025 09:34:14 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D9A67211FD;
 Tue, 13 May 2025 13:33:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1747143238; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Hh0UIbRxkb/Yh1Vv5h/6DlCF8H6lm9gE71Fl22a972c=;
 b=d1xoPdS0ysMXoLC7r+3B3NULHt7JkD7BE90V4sLCx+CUGC9PHnRpcNil4DK8l2/KtDDK4E
 n3UU0/hQD6fbca+rUve7B2GERBA1iuwaSKVwB3daYWKk0ImMj+iitDULZTyaeoJTnMOy0o
 CfWKwasRXGYuautdgGpE+3FP4jCRfKI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1747143238;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Hh0UIbRxkb/Yh1Vv5h/6DlCF8H6lm9gE71Fl22a972c=;
 b=KK55b0mYINcW23UBFg//hfMlEqL9elM7ubENPUn12FLg4taKQtWoYnJbUNaYJGU9RJfW41
 jRfx3JDca8QI5ZBw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=d1xoPdS0;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=KK55b0mY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1747143238; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Hh0UIbRxkb/Yh1Vv5h/6DlCF8H6lm9gE71Fl22a972c=;
 b=d1xoPdS0ysMXoLC7r+3B3NULHt7JkD7BE90V4sLCx+CUGC9PHnRpcNil4DK8l2/KtDDK4E
 n3UU0/hQD6fbca+rUve7B2GERBA1iuwaSKVwB3daYWKk0ImMj+iitDULZTyaeoJTnMOy0o
 CfWKwasRXGYuautdgGpE+3FP4jCRfKI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1747143238;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Hh0UIbRxkb/Yh1Vv5h/6DlCF8H6lm9gE71Fl22a972c=;
 b=KK55b0mYINcW23UBFg//hfMlEqL9elM7ubENPUn12FLg4taKQtWoYnJbUNaYJGU9RJfW41
 jRfx3JDca8QI5ZBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D4D421365D;
 Tue, 13 May 2025 13:33:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 8G4DJUVKI2gMXgAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 13 May 2025 13:33:57 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>
Subject: [PATCH v2 1/3] ci: Re-enable python subtests in qtest migration suite
Date: Tue, 13 May 2025 10:33:51 -0300
Message-Id: <20250513133353.23022-2-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250513133353.23022-1-farosas@suse.de>
References: <20250513133353.23022-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: D9A67211FD
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
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

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 .gitlab-ci.d/buildtest.yml | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
index 248aaed137..fbad34138c 100644
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


