Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FE42C79FB9
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Jan 2026 19:11:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vcpvj-0007tN-3u; Mon, 05 Jan 2026 14:07:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vcpv5-0007g5-Ra
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 14:07:18 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vcpv1-000581-Sy
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 14:07:09 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id F2E2C33767;
 Mon,  5 Jan 2026 19:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1767640013; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TL+uCIHm4IMLJvAke8wrvDvZqP++O5z0LD5bYx6kqZs=;
 b=C3IyIDNKTw4B5BiKKWu58nbQ8Fnir5lJ186lj14Makwkt09VjmEDRCMPs9GZIozlxPtGp2
 7q0M9yEfMGekgbJXuxwQ0XK8cSkFB88bNLp/zU/qf6ixOlawDkBOvMCbNnPQcFIljPsrRF
 5kgRyfHcRA0QesIZ/nwERm1qEkRGwx8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1767640013;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TL+uCIHm4IMLJvAke8wrvDvZqP++O5z0LD5bYx6kqZs=;
 b=DW4RkojKvO3i+MMcWVWsQ1wxhvVnq7mI6TqLVKcMLOyNcQCxYAwahhg0KJEMA3tket3NLi
 ZZ8+fmZ1qmpcPxBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1767640012; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TL+uCIHm4IMLJvAke8wrvDvZqP++O5z0LD5bYx6kqZs=;
 b=k2HHRkPZE+2DSd4zmEim+F+yzI3HBsjDGDz2khNl5eDWip0RONaEAn3tqj8blMSf5zq9VS
 uvlVoKxtXdxSmxY2smR6nagvcz+KxhSq533pRSeVW4wZLegcpIFlua7rqfvj1lcSdOf4Hb
 //HD0/3MKkmn+gjEdm74t1XzDMaKxrQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1767640013;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TL+uCIHm4IMLJvAke8wrvDvZqP++O5z0LD5bYx6kqZs=;
 b=DW4RkojKvO3i+MMcWVWsQ1wxhvVnq7mI6TqLVKcMLOyNcQCxYAwahhg0KJEMA3tket3NLi
 ZZ8+fmZ1qmpcPxBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A9AA513964;
 Mon,  5 Jan 2026 19:06:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id sENHGssLXGmSOgAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 05 Jan 2026 19:06:51 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com,
	berrange@redhat.com
Subject: [PATCH v2 02/25] migration: Fix state change at
 migration_channel_process_incoming
Date: Mon,  5 Jan 2026 16:06:19 -0300
Message-ID: <20260105190644.14072-3-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260105190644.14072-1-farosas@suse.de>
References: <20260105190644.14072-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.982];
 MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 RCVD_TLS_ALL(0.00)[]
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

When the incoming migration fails during the channel connection phase,
the state transition to FAILED is currently being done in the
MigrationState->state, but the MigrationIncomingState->state is the
one that should be used.

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/channel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/migration/channel.c b/migration/channel.c
index 92435fa7f7..4768c71455 100644
--- a/migration/channel.c
+++ b/migration/channel.c
@@ -48,7 +48,7 @@ void migration_channel_process_incoming(QIOChannel *ioc)
 
     if (local_err) {
         error_report_err(local_err);
-        migrate_set_state(&s->state, s->state, MIGRATION_STATUS_FAILED);
+        migrate_set_state(&mis->state, mis->state, MIGRATION_STATUS_FAILED);
         if (mis->exit_on_error) {
             exit(EXIT_FAILURE);
         }
-- 
2.51.0


