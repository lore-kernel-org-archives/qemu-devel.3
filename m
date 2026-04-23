Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADD0AFDEE3F
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 19:21:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFzaw-0001nl-BY; Thu, 23 Apr 2026 15:20:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wFzau-0001nP-Cd
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 15:20:12 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wFzas-0001jp-L3
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 15:20:12 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 814AB5BD62;
 Thu, 23 Apr 2026 19:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1776972005; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+xNJmtypGwYb/d/QHNiBiDyOr2yyKzZAVHlgehqrv8c=;
 b=CIshQmRFdCLaqFzbbTM7hZV3+A+Gw+iy8iVVoOYJJx/vP5Je0md0KtJv6jfgDnPjbyG8GT
 UZtb71M+bhCWYtpUNg8XQOvQibx4Ejjumj6ZjkLqSa5KYlMsUKGMHj65hRN0qdq57XwKxI
 AiBb7oINm9Go0JHofUevYBKQ+yCAunQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1776972005;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+xNJmtypGwYb/d/QHNiBiDyOr2yyKzZAVHlgehqrv8c=;
 b=gQhH2XfeE3vCewra59rEckHd32w1VGILlPNE5BK4D5J7Ghi28OMCx7XDEn1INKJA/H/YTL
 vBO1rokeBT1wyXBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1776972004; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+xNJmtypGwYb/d/QHNiBiDyOr2yyKzZAVHlgehqrv8c=;
 b=wInpoDnqhnMaEmKVH6P3rW311GNhbs9WI23Wqs3qRtCNudg2MveSfH/C8yozTwDH8nK/g5
 f4mJ0TOSTrnl796ZRodXNQCKWVjGGPlrKSRc6PcRB0WD3LC2vLcRKldPsTxtxs4DVzp0yY
 M+pQyVxps/YT9QNhLuFG9YTvZGA2hg0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1776972004;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+xNJmtypGwYb/d/QHNiBiDyOr2yyKzZAVHlgehqrv8c=;
 b=ytLKHHqm0YUqD3wW5oUH2eSGG8hr2G+rN5QHlXZXItmW5nSV7O0ADen4PN6uaMeA1jGArO
 KdQcs0KYj2WWQkCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 49FA2593A3;
 Thu, 23 Apr 2026 19:20:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id iPIfBuNw6mlJCwAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 23 Apr 2026 19:20:03 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 02/43] tests/functional: Make socat wait longer in migration
 exec test
Date: Thu, 23 Apr 2026 16:19:16 -0300
Message-ID: <20260423191958.1440-3-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260423191958.1440-1-farosas@suse.de>
References: <20260423191958.1440-1-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email, suse.de:mid, suse.de:email,
 imap1.dmz-prg2.suse.org:helo]
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

The migration_with_exec test is failing sporadically for all
architectures due to a race when the destination socat process takes
too long to start listening while the source process is already
issuing connect().

The race is inherent because the exec: migration spawns the
to-be-exec'ed command asynchronously and returns from the
migrate-incoming command. The localhost-only testcase is not
representative of the majority of migrations. In a real scenario
between two different hosts that race wouldn't happen.

Fix the testcase by configuring the source socat command to wait
indefinitely while trying to connect.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Link: https://lore.kernel.org/qemu-devel/20260422230001.3168-1-farosas@suse.de
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/functional/migration.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/functional/migration.py b/tests/functional/migration.py
index 144f091ba8..3b7674af3b 100644
--- a/tests/functional/migration.py
+++ b/tests/functional/migration.py
@@ -85,5 +85,5 @@ def migration_with_exec(self):
         with Ports() as ports:
             free_port = self._get_free_port(ports)
             dst_uri = 'exec:socat TCP-LISTEN:%u -' % free_port
-            src_uri = 'exec:socat - TCP:localhost:%u' % free_port
+            src_uri = 'exec:socat - TCP:localhost:%u,forever' % free_port
             self.migrate(dst_uri, src_uri)
-- 
2.51.0


