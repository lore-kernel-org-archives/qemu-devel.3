Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E8BC1061B1C
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2026 19:05:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7HvQ-0003o0-IV; Mon, 30 Mar 2026 15:05:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1w7HvO-0003nW-PT
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 15:05:22 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1w7HvM-0005CM-Vq
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 15:05:22 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 67B4A4D532;
 Mon, 30 Mar 2026 19:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1774897512; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2NyAqFvU5AnxXJNtvWx1acfMxJ5R90ZFEUhywru5LWE=;
 b=Q+g/XOtNgKA/MR8y51mAgA0qitt791/EEsX8mFyII76Q23PrdWrSnQSWQaPxEooeHV17ne
 jF6ZZ3rk/uv9QvKT4xLaZpiKHZJbvdIaIS1tGhN6jK/eZEiAiuojMDH+40t1G/2pAFJo4w
 kEwXljyXfy4rPQrqeqp7NfUYxZaodnc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1774897512;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2NyAqFvU5AnxXJNtvWx1acfMxJ5R90ZFEUhywru5LWE=;
 b=eZPy28Lrz5G1dMDNiq1V3n7JaO50LaCJHoXDUduQU2oCoT9Wn27YFCr+/pgpcIpnWqI1tD
 7J/MLkWBUb2EZMAQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="Q+g/XOtN";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=eZPy28Lr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1774897512; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2NyAqFvU5AnxXJNtvWx1acfMxJ5R90ZFEUhywru5LWE=;
 b=Q+g/XOtNgKA/MR8y51mAgA0qitt791/EEsX8mFyII76Q23PrdWrSnQSWQaPxEooeHV17ne
 jF6ZZ3rk/uv9QvKT4xLaZpiKHZJbvdIaIS1tGhN6jK/eZEiAiuojMDH+40t1G/2pAFJo4w
 kEwXljyXfy4rPQrqeqp7NfUYxZaodnc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1774897512;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2NyAqFvU5AnxXJNtvWx1acfMxJ5R90ZFEUhywru5LWE=;
 b=eZPy28Lrz5G1dMDNiq1V3n7JaO50LaCJHoXDUduQU2oCoT9Wn27YFCr+/pgpcIpnWqI1tD
 7J/MLkWBUb2EZMAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 686044A0B0;
 Mon, 30 Mar 2026 19:05:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id gDIrDmfJymlGdQAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 30 Mar 2026 19:05:11 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
	Markus Armbruster <armbru@redhat.com>
Subject: [PULL 1/3] migration: Fix up error message for max-cpu-throttle
Date: Mon, 30 Mar 2026 16:05:06 -0300
Message-ID: <20260330190508.8634-2-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260330190508.8634-1-farosas@suse.de>
References: <20260330190508.8634-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; ARC_NA(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; DKIM_TRACE(0.00)[suse.de:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns, suse.de:dkim, suse.de:mid, suse.de:email]
X-Rspamd-Queue-Id: 67B4A4D532
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=1, SPF_HELO_NONE=0.001,
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

From: Markus Armbruster <armbru@redhat.com>

Fixes: 1a739d301232 (migration: Do away with usage of QERR_INVALID_PARAMETER_VALUE)
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260326074247.188674-2-armbru@redhat.com
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/options.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/migration/options.c b/migration/options.c
index 658c578191..3eb5b39186 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -1207,7 +1207,7 @@ bool migrate_params_check(MigrationParameters *params, Error **errp)
 
     if (params->max_cpu_throttle < params->cpu_throttle_initial ||
         params->max_cpu_throttle > 99) {
-        error_setg(errp, "max_Option cpu_throttle expects "
+        error_setg(errp, "Option max_cpu_throttle expects "
                    "an integer in the range of cpu_throttle_initial to 99");
         return false;
     }
-- 
2.51.0


