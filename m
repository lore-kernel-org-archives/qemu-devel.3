Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21917C3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 14:27:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZtEz-0002gJ-Tp; Fri, 02 Aug 2024 10:26:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sZtEx-0002Wr-OX
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 10:26:43 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sZtEw-00072o-19
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 10:26:43 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id AD2E321A2E;
 Fri,  2 Aug 2024 14:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1722608800; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ETNzyJjdp7TYx51VqKqMVMVzTho8yGlI9Pv1whWqCX4=;
 b=LaCavBYriYMHYR/UYjIEwQSO7fjO1yTDWwpl5RsQ0FcxdwNbG9Rn0kQofIow/vdwf5Yj0T
 4y9mCaMBcHnspmYqxbFotlb9FNSg5WAXi4s9NsZZswiH/dHDmUibTlk6vsjeBhdcCeXE1m
 NFsu5SVdE8siwWoWlPr4KI2CnQ1Wvyc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1722608800;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ETNzyJjdp7TYx51VqKqMVMVzTho8yGlI9Pv1whWqCX4=;
 b=NHurqGQSMVpfK1fZvJiHoz3W/KBk05wNe0W6yISrjLS16mnqLpQUc1v4s1D546uyrllc82
 N+VVwhY72r/ghfBQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=LaCavBYr;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=NHurqGQS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1722608800; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ETNzyJjdp7TYx51VqKqMVMVzTho8yGlI9Pv1whWqCX4=;
 b=LaCavBYriYMHYR/UYjIEwQSO7fjO1yTDWwpl5RsQ0FcxdwNbG9Rn0kQofIow/vdwf5Yj0T
 4y9mCaMBcHnspmYqxbFotlb9FNSg5WAXi4s9NsZZswiH/dHDmUibTlk6vsjeBhdcCeXE1m
 NFsu5SVdE8siwWoWlPr4KI2CnQ1Wvyc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1722608800;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ETNzyJjdp7TYx51VqKqMVMVzTho8yGlI9Pv1whWqCX4=;
 b=NHurqGQSMVpfK1fZvJiHoz3W/KBk05wNe0W6yISrjLS16mnqLpQUc1v4s1D546uyrllc82
 N+VVwhY72r/ghfBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4E66913999;
 Fri,  2 Aug 2024 14:26:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id cGGmBZ/srGZ2AQAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 02 Aug 2024 14:26:39 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Jim Fehlig <jfehlig@suse.com>
Subject: [PULL 2/3] migration: Fix cleanup of iochannel in file migration
Date: Fri,  2 Aug 2024 11:26:32 -0300
Message-Id: <20240802142633.19249-3-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240802142633.19249-1-farosas@suse.de>
References: <20240802142633.19249-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: AD2E321A2E
X-Spamd-Result: default: False [-5.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 DWL_DNSWL_MED(-2.00)[suse.de:dkim]; MID_CONTAINS_FROM(1.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_THREE(0.00)[4];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
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

The QIOChannelFile object already has its reference decremented by
g_autoptr. Trying to unref an extra time causes:

ERROR:../qom/object.c:1241:object_unref: assertion failed: (obj->ref > 0)

Fixes: a701c03dec ("migration: Drop reference to QIOChannel if file seeking fails")
Fixes: 6d3279655a ("migration: Fix file migration with fdset")
Reported-by: Jim Fehlig <jfehlig@suse.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/file.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/migration/file.c b/migration/file.c
index db870f2cf0..6451a21c86 100644
--- a/migration/file.c
+++ b/migration/file.c
@@ -112,7 +112,6 @@ void file_start_outgoing_migration(MigrationState *s,
         error_setg_errno(errp, errno,
                          "failed to truncate migration file to offset %" PRIx64,
                          offset);
-        object_unref(OBJECT(fioc));
         return;
     }
 
@@ -120,7 +119,6 @@ void file_start_outgoing_migration(MigrationState *s,
 
     ioc = QIO_CHANNEL(fioc);
     if (offset && qio_channel_io_seek(ioc, offset, SEEK_SET, errp) < 0) {
-        object_unref(OBJECT(fioc));
         return;
     }
     qio_channel_set_name(ioc, "migration-file-outgoing");
-- 
2.35.3


