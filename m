Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61337E909D0
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Feb 2026 16:16:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsNk4-0002GL-Gs; Tue, 17 Feb 2026 11:16:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vsNjw-0001cV-2F
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 11:15:57 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vsNjt-0003CL-Pb
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 11:15:55 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 727015BCF6;
 Tue, 17 Feb 2026 16:15:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1771344920; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7WBuHXqVW46mjO6PApAR2x1nlI/zWNGwf5+rqN91fS0=;
 b=bFEqEmEDv5Td8+ou7fL5YnhIcSoQ2u40UYADjxRUDE2ZjOzRPVcJsXC7oL9Ix4YLJJE4IZ
 oSg900f02VaIdStyHED/7c6Mylb0RlvsdFvEY0bSEhE18YvAOKQeCDYdWrxnasIteXiJHE
 W1kpkIc+xpQVS+h0kxtmK1S93XyeYJA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1771344920;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7WBuHXqVW46mjO6PApAR2x1nlI/zWNGwf5+rqN91fS0=;
 b=+b9qajxkWkjc6r2ezdtJNanf3axE3LV3L30pOK0ruHK7mMviyxiHGY8p26Q2f3AdjS0AWs
 VRnHkeGPL2UUjBCw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=bFEqEmED;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=+b9qajxk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1771344920; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7WBuHXqVW46mjO6PApAR2x1nlI/zWNGwf5+rqN91fS0=;
 b=bFEqEmEDv5Td8+ou7fL5YnhIcSoQ2u40UYADjxRUDE2ZjOzRPVcJsXC7oL9Ix4YLJJE4IZ
 oSg900f02VaIdStyHED/7c6Mylb0RlvsdFvEY0bSEhE18YvAOKQeCDYdWrxnasIteXiJHE
 W1kpkIc+xpQVS+h0kxtmK1S93XyeYJA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1771344920;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7WBuHXqVW46mjO6PApAR2x1nlI/zWNGwf5+rqN91fS0=;
 b=+b9qajxkWkjc6r2ezdtJNanf3axE3LV3L30pOK0ruHK7mMviyxiHGY8p26Q2f3AdjS0AWs
 VRnHkeGPL2UUjBCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 392083EA66;
 Tue, 17 Feb 2026 16:15:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id wIGMOxaUlGmHTgAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 17 Feb 2026 16:15:18 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
	Lukas Straub <lukasstraub2@web.de>
Subject: [PULL 19/32] migration/postcopy: Send device states without copying
 buffer
Date: Tue, 17 Feb 2026 13:14:30 -0300
Message-ID: <20260217161443.12738-20-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260217161443.12738-1-farosas@suse.de>
References: <20260217161443.12738-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:mid,suse.de:email];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_SOME(0.00)[]; ARC_NA(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 FREEMAIL_CC(0.00)[redhat.com,web.de]; RCVD_TLS_ALL(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:mid,suse.de:email];
 RCPT_COUNT_THREE(0.00)[3]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]; FREEMAIL_ENVRCPT(0.00)[web.de]
X-Rspamd-Queue-Id: 727015BCF6
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
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

From: Peter Xu <peterx@redhat.com>

Put buffer can be async as long as the flush happens before the buffer will
be recycled / reused.  Do it for postcopy package data.  Quick measurement
shows a small VM the time to push / flush the package shrinks from 91us to
38us.

Signed-off-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Tested-by: Lukas Straub <lukasstraub2@web.de>
Link: https://lore.kernel.org/qemu-devel/20260127185254.3954634-14-peterx@redhat.com
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/savevm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index 9d2109718a..d41e89228d 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1136,7 +1136,8 @@ int qemu_savevm_send_packaged(QEMUFile *f, const uint8_t *buf, size_t len)
     trace_qemu_savevm_send_packaged();
     qemu_savevm_command_send(f, MIG_CMD_PACKAGED, 4, (uint8_t *)&tmp);
 
-    qemu_put_buffer(f, buf, len);
+    /* We can use async put because the qemufile will be flushed right away */
+    qemu_put_buffer_async(f, buf, len, false);
     qemu_fflush(f);
 
     return 0;
-- 
2.51.0


