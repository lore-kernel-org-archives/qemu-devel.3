Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD9F0C3DA64
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 17:41:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZZnb-0008LW-L0; Thu, 01 Aug 2024 13:41:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sZZna-0008KV-BS
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 13:41:10 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sZZnY-0006xe-JH
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 13:41:10 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id BB01921AAB;
 Thu,  1 Aug 2024 17:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1722534066; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9VDyXskFnITGQW9zu7TJf06nIW9hIv9edvT8t4/uTIU=;
 b=mZgY79Kf1PZz3tgNoSAj1KFI1pcPI0A5uWXMhL6PeoLxFyHiXygKv//Np0sVGWxc9NKaAu
 Szu+RVMR5bLu5emMXIggapqcs2xvAsVSAPAxTso8eSL1EdGeDlducx1S1ElnrdiIceJJNY
 fnyTihccRsk7+cdgj+VIEmBRxrWWm4I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1722534066;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9VDyXskFnITGQW9zu7TJf06nIW9hIv9edvT8t4/uTIU=;
 b=HC4CgoJ61wLx2BxQWtwd+oRsUBT9NFLno7wOXGsv+sTgrosLHW+MhAzd4X77250rujH69/
 5N8iy/it5z6sOFCg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=mZgY79Kf;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=HC4CgoJ6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1722534066; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9VDyXskFnITGQW9zu7TJf06nIW9hIv9edvT8t4/uTIU=;
 b=mZgY79Kf1PZz3tgNoSAj1KFI1pcPI0A5uWXMhL6PeoLxFyHiXygKv//Np0sVGWxc9NKaAu
 Szu+RVMR5bLu5emMXIggapqcs2xvAsVSAPAxTso8eSL1EdGeDlducx1S1ElnrdiIceJJNY
 fnyTihccRsk7+cdgj+VIEmBRxrWWm4I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1722534066;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9VDyXskFnITGQW9zu7TJf06nIW9hIv9edvT8t4/uTIU=;
 b=HC4CgoJ61wLx2BxQWtwd+oRsUBT9NFLno7wOXGsv+sTgrosLHW+MhAzd4X77250rujH69/
 5N8iy/it5z6sOFCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 86542136CF;
 Thu,  1 Aug 2024 17:41:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id kNQ3E7HIq2brOQAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 01 Aug 2024 17:41:05 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
	Jim Fehlig <jfehlig@suse.com>
Subject: [PATCH 1/2] migration: Fix cleanup of iochannel in file migration
Date: Thu,  1 Aug 2024 14:41:00 -0300
Message-Id: <20240801174101.31806-2-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240801174101.31806-1-farosas@suse.de>
References: <20240801174101.31806-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: BB01921AAB
X-Spamd-Result: default: False [-4.81 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 FROM_HAS_DN(0.00)[]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 DKIM_TRACE(0.00)[suse.de:+]
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

The QIOChannelFile object already has its reference decremented by
g_autoptr. Trying to unref an extra time causes:

ERROR:../qom/object.c:1241:object_unref: assertion failed: (obj->ref > 0)

Fixes: a701c03dec ("migration: Drop reference to QIOChannel if file seeking fails")
Fixes: 6d3279655a ("migration: Fix file migration with fdset")
Reported-by: Jim Fehlig <jfehlig@suse.com>
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


