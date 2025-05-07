Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 157F8C3ABC5
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 15:59:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uChAl-0004ow-Ue; Wed, 07 May 2025 11:59:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uChAk-0004oK-1c
 for qemu-devel@nongnu.org; Wed, 07 May 2025 11:59:02 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uChAc-0003Iz-2w
 for qemu-devel@nongnu.org; Wed, 07 May 2025 11:59:01 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A6BC71F441;
 Wed,  7 May 2025 15:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1746633524; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=93rumMTr624m2fb7gcTv6Fvs61zqZ25TaSAxaNcNA9g=;
 b=VYnqCXuw90PFn+CfAAWD7Y4oRkLt68d8Bqq1OnLZ9uA76dw9ZjbkRnqNx7XBkEDXpnUdhq
 H73MLn+p69hKjHyfTZvXYI7amh/xis2iCnnJpHRCnBy7I76nR+po2P33pSb79md7CN4Y3q
 4uCc3ofuqkqcNqdNx15Z+3RaQsPt0a8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1746633524;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=93rumMTr624m2fb7gcTv6Fvs61zqZ25TaSAxaNcNA9g=;
 b=5hzanwwbOKBH/XR2Fj6VsaIq2tM+BFwiyRN/SokqSB5qSGmbu/2Xwxp1EgLZTBW2FbChtl
 rU5HSylfRb7b4FAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1746633524; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=93rumMTr624m2fb7gcTv6Fvs61zqZ25TaSAxaNcNA9g=;
 b=VYnqCXuw90PFn+CfAAWD7Y4oRkLt68d8Bqq1OnLZ9uA76dw9ZjbkRnqNx7XBkEDXpnUdhq
 H73MLn+p69hKjHyfTZvXYI7amh/xis2iCnnJpHRCnBy7I76nR+po2P33pSb79md7CN4Y3q
 4uCc3ofuqkqcNqdNx15Z+3RaQsPt0a8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1746633524;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=93rumMTr624m2fb7gcTv6Fvs61zqZ25TaSAxaNcNA9g=;
 b=5hzanwwbOKBH/XR2Fj6VsaIq2tM+BFwiyRN/SokqSB5qSGmbu/2Xwxp1EgLZTBW2FbChtl
 rU5HSylfRb7b4FAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8AA48139D9;
 Wed,  7 May 2025 15:58:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id OAMIEjODG2gncQAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 07 May 2025 15:58:43 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>
Subject: [PATCH 3/3] ci: Reduce the size of artifacts for build-previous-qemu
Date: Wed,  7 May 2025 12:58:35 -0300
Message-Id: <20250507155835.31074-4-farosas@suse.de>
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
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
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

The build-previous-qemu job is intented to produce a build of the
previous QEMU release for consumption by the migration-compat-*
jobs. Keep only the pieces of the build that are necessary.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 .gitlab-ci.d/buildtest.yml | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
index 159bdde2e8..a85c8cefa9 100644
--- a/.gitlab-ci.d/buildtest.yml
+++ b/.gitlab-ci.d/buildtest.yml
@@ -188,12 +188,11 @@ build-previous-qemu:
     when: on_success
     expire_in: 2 days
     paths:
-      - build-previous
-    exclude:
-      - build-previous/**/*.p
-      - build-previous/**/*.a.p
-      - build-previous/**/*.c.o
-      - build-previous/**/*.c.o.d
+      - build-previous/qemu-bundle
+      - build-previous/qemu-system-aarch64
+      - build-previous/qemu-system-x86_64
+      - build-previous/tests/qtest/migration-test
+      - build-previous/scripts
   needs:
     job: amd64-opensuse-leap-container
   variables:
-- 
2.35.3


