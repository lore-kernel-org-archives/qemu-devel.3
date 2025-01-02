Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53EC5E77198
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2025 22:07:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTTLA-0004Kv-9A; Thu, 02 Jan 2025 17:06:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tTTL4-00049P-8R
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 17:06:46 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tTTL2-00079P-Ko
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 17:06:46 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 74AFB210E4;
 Thu,  2 Jan 2025 22:06:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1735855603; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zDdx6HssDYQhd7rR0sHQDfOrtoYXs2B7j43OhZVuzH8=;
 b=clgxZuKohPSZD6dGJV3p0kbBVKzw1y1Q2FBiZYBNHYc8k/ZwtZ/JmXpqMa9w7dd1q3MayQ
 luU/yrIXRq346XeaamvN31tMPzsCDmQ/EbE8WU19hYgLQX3O5UVh/C/J0QbI2Caao+KVWp
 wyGqNZbeSldJFl7aM7yQXuPR/uB8T9s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1735855603;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zDdx6HssDYQhd7rR0sHQDfOrtoYXs2B7j43OhZVuzH8=;
 b=Xhwde95vciHIesNgkldvd3d8U3MIsS7MoHQXRsDaz5QXm3vDC8+2l9se/TwtuDf/wth58M
 4WBWfiDfwehEKABA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1735855603; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zDdx6HssDYQhd7rR0sHQDfOrtoYXs2B7j43OhZVuzH8=;
 b=clgxZuKohPSZD6dGJV3p0kbBVKzw1y1Q2FBiZYBNHYc8k/ZwtZ/JmXpqMa9w7dd1q3MayQ
 luU/yrIXRq346XeaamvN31tMPzsCDmQ/EbE8WU19hYgLQX3O5UVh/C/J0QbI2Caao+KVWp
 wyGqNZbeSldJFl7aM7yQXuPR/uB8T9s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1735855603;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zDdx6HssDYQhd7rR0sHQDfOrtoYXs2B7j43OhZVuzH8=;
 b=Xhwde95vciHIesNgkldvd3d8U3MIsS7MoHQXRsDaz5QXm3vDC8+2l9se/TwtuDf/wth58M
 4WBWfiDfwehEKABA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7CBB4132EA;
 Thu,  2 Jan 2025 22:06:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 8DpgEPINd2emeQAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 02 Jan 2025 22:06:42 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>
Subject: [PULL 7/8] tests/qtest/migration: Re-enable postcopy tests
Date: Thu,  2 Jan 2025 19:06:28 -0300
Message-Id: <20250102220629.11351-8-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250102220629.11351-1-farosas@suse.de>
References: <20250102220629.11351-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo];
 RCVD_TLS_ALL(0.00)[]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

Postcopy tests have been inadvertently disabled since commit
124a3c58b8 ("tests/qtest/migration: Move ufd_version_check to
utils"). That commit moved the ufd_version_check() function to another
file but failed to make sense of the ifdefs and includes:

The <sys/syscall> include was incorrectly dropped. It is needed to
pull in <asm/unistd.h> for __NR_userfaultfd.

The <sys/ioctl.h> was moved under the wrong ifdef.

Fixes: 124a3c58b8 ("tests/qtest/migration: Move ufd_version_check to utils")
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
Message-Id: <20241218192223.10551-2-farosas@suse.de>
---
 tests/qtest/migration/migration-util.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tests/qtest/migration/migration-util.c b/tests/qtest/migration/migration-util.c
index 401fe27f00..526bed74ea 100644
--- a/tests/qtest/migration/migration-util.c
+++ b/tests/qtest/migration/migration-util.c
@@ -22,6 +22,11 @@
 #include "migration/bootfile.h"
 #include "migration/migration-util.h"
 
+#if defined(__linux__)
+#include <sys/ioctl.h>
+#include <sys/syscall.h>
+#endif
+
 /* for uffd_version_check() */
 #if defined(__linux__) && defined(__NR_userfaultfd) && defined(CONFIG_EVENTFD)
 #include <sys/eventfd.h>
@@ -31,7 +36,6 @@
 /* For dirty ring test; so far only x86_64 is supported */
 #if defined(__linux__) && defined(HOST_X86_64)
 #include "linux/kvm.h"
-#include <sys/ioctl.h>
 #endif
 
 
-- 
2.35.3


