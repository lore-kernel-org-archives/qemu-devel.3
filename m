Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3C81E8FDB9
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Dec 2025 21:21:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZFE5-0001Ip-S2; Fri, 26 Dec 2025 16:19:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vZFDz-0001G4-LS
 for qemu-devel@nongnu.org; Fri, 26 Dec 2025 16:19:51 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vZFDy-0003fg-7h
 for qemu-devel@nongnu.org; Fri, 26 Dec 2025 16:19:51 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 68CEE5BCCD;
 Fri, 26 Dec 2025 21:19:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1766783981; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oCWOcmRaggOLrfO9cnMOTOEkRgtGI7Vl4EU7819u5a8=;
 b=IdqFcZr5+MPiPCj3VF4GetVymenoy3xda7zRqDSQinQp7V9TYtuKSFIrXoS1bP6GyVu/Mg
 WHIk9bR3RIx2WzhWm4WIhAZtJ5+Tzv0RRrHR+O1TqWyZrdvPigvTzh1YLt6G/w/Fcunc5r
 5NBoJlacMBHKx+zmRLlsk1dxVlv36Ak=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1766783981;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oCWOcmRaggOLrfO9cnMOTOEkRgtGI7Vl4EU7819u5a8=;
 b=AgPrkurx0ai7MdeK7XX7jSJhBAXX+nIp4NK6jhTPz0ARmT/QgoFTop6puPCJurlcEyfX1V
 JmXa/o99I6KeMnCw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=FSHdoXdW;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=rYUldyIs
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1766783980; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oCWOcmRaggOLrfO9cnMOTOEkRgtGI7Vl4EU7819u5a8=;
 b=FSHdoXdWE5tlwxyJeYbVKc3QhRYk1ZWNPKI1RF5YqiLpwpEAaURBGGoaO5llE3t/sRJD1r
 5zp3WbUCRsKq5wF43k5O7RDKmmdqr+mskUYxGvyBqELJJTXvJzE8AeuhW/lppy0B92lHej
 4YV+7DInzS7NiUni3YNWqHRbkoJlj2k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1766783980;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oCWOcmRaggOLrfO9cnMOTOEkRgtGI7Vl4EU7819u5a8=;
 b=rYUldyIslehrZlqLuVMqHA6hf0OOINny/BkwISjZeS4Pm3IXXOaxkYSIa+mGzHpHeUlcrm
 HC82OMoXyLFdQfDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5FE193EA63;
 Fri, 26 Dec 2025 21:19:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id cO1TCOv7TmnwJwAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 26 Dec 2025 21:19:39 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com
Subject: [RFC PATCH 04/25] migration: Move multifd_recv_setup call
Date: Fri, 26 Dec 2025 18:19:06 -0300
Message-ID: <20251226211930.27565-5-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251226211930.27565-1-farosas@suse.de>
References: <20251226211930.27565-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 68CEE5BCCD
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:dkim,suse.de:email];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:dkim,suse.de:email];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
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

The multifd_recv_setup() call is currently in a place where it will be
called for every channel that appears. That doesn't make much
sense.

It seems it was moved when the channel discovery mechanism was added
back at commit 6720c2b327 (migration: check magic value for deciding
the mapping of channels, 2022-12-20). The original place was
migration_incoming_setup() which would run for just the main channel,
but it was discovered that the main channel might arrive after a
multifd channel.

Move the call back to a place where it will be called only once.

With respect to cleanup, this new location at
qemu_start_incoming_migration() has the same issue as the previous
callsite at migration_ioc_process_incoming(): no cleanup ever happens.

The error message goes from being emitted via error_report_err(), to
being returned to the qmp_migrate_incoming() incoming command, which
is arguably better, since this is setup code.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/migration.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 71efe945f6..974313944c 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -786,6 +786,10 @@ static void qemu_start_incoming_migration(const char *uri, bool has_channels,
         return;
     }
 
+    if (multifd_recv_setup(errp) != 0) {
+        return;
+    }
+
     if (addr->transport == MIGRATION_ADDRESS_TYPE_SOCKET) {
         SocketAddress *saddr = &addr->u.socket;
         if (saddr->type == SOCKET_ADDRESS_TYPE_INET ||
@@ -1065,10 +1069,6 @@ void migration_ioc_process_incoming(QIOChannel *ioc, Error **errp)
         channel = CH_POSTCOPY;
     }
 
-    if (multifd_recv_setup(errp) != 0) {
-        return;
-    }
-
     if (channel == CH_MAIN) {
         f = qemu_file_new_input(ioc);
         migration_incoming_setup(f);
-- 
2.51.0


