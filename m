Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEEA4C9830E
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2026 15:42:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xA82M-0006gr-Rj; Fri, 25 Sep 2026 11:40:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1xA82L-0006gP-3f
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 11:40:33 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1xA82J-0004bX-AX
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 11:40:32 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D97161FDA7;
 Fri, 25 Sep 2026 15:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1790350826; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r+rSzTpAzrT4c/X+RTvbzW/ZNpBPyGBfleZmS7Annoo=;
 b=fnDdKY3W+SCpZbDScCZIH+u+XeRO3wnNwlBTQcomVGA/yeecnJKGnjDw1KglZLPLIrQJVA
 ho500HXUYXeo603LIwlfCOrbCzA9lH4Pa4RcQl0Y203bIMXLVYxuGaa+900v8/KV7M/fo2
 WIpy6fZJIb2aE2r0FwcLBKNXiYOLvj0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1790350826;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r+rSzTpAzrT4c/X+RTvbzW/ZNpBPyGBfleZmS7Annoo=;
 b=AK9eGG8cH343V47yn8r52JXF2y/3+5HukZHz0yLdcaobgIC+n3G3fohp8RajNSWvilMjT5
 Pe2YXyX+GdZW0gCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1790350821; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r+rSzTpAzrT4c/X+RTvbzW/ZNpBPyGBfleZmS7Annoo=;
 b=tsaxNpUjbR5l6FSOjyn0zRFi+F8jZ2AvjjOohXmZS0PJ+p4dxiOGJujRB4CsE4mYH04HvC
 kjSCJcV6TH3kr1GAEe+qskXA5iWhzjcRXJ7FcQ+EDdwEL6Mo/Rp4gSncsB/dxG/56yQ9wL
 aBWD99+0ZQW9eiZ6B/nijtvzunl0CfU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1790350821;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r+rSzTpAzrT4c/X+RTvbzW/ZNpBPyGBfleZmS7Annoo=;
 b=94GtCiUGUdNJNCUDgMrvoV5NvcaRErBcH7dCTT7HJyyLo3WCiHPu3+9DJjYfoEul64f6bj
 El1RGnL/Qseu9cAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7E56E13297;
 Fri, 25 Sep 2026 15:40:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id xxRgCd2VtmqjOwAAD6G6ig:T6
 (envelope-from <farosas@suse.de>); Fri, 25 Sep 2026 15:40:20 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Yanfei Xu <yanfei.xu@bytedance.com>,
 Jack Wang <jinpu.wang@cloud.ionos.com>
Subject: [PULL 05/19] migration/rdma: Post initial receive before accepting
Date: Fri, 25 Sep 2026 12:39:56 -0300
Message-ID: <20260925154010.599247-6-farosas@suse.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260925154010.599247-1-farosas@suse.de>
References: <20260925154010.599247-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.997];
 MIME_GOOD(-0.10)[text/plain]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email,bytedance.com:email,ionos.com:email];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[]
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

From: Yanfei Xu <yanfei.xu@bytedance.com>

The source return-path thread can send READY before the destination has
posted its initial receive.  Since RNR retries default to zero, the send
can fail and abort migration.

Post the initial receive before rdma_accept() to close this window.

Adding delays can easily reproduce it. For exmaple with sleep(1), error
could be found at the source side:

2026-08-20T05:55:11.471421Z qemu_rdma_exchange_get_response_start CONTROL: READY receiving...
2026-08-20T05:55:11.471422Z qemu_rdma_post_send_control CONTROL: sending QEMU FILE..
2026-08-20T05:55:11.471447Z qemu_rdma_poll_other other completion 2000 received left 0
2026-08-20T05:55:11.471589Z qemu_rdma_poll_recv completion 0 received (4000) left 0
2026-08-20T05:55:11.471592Z qemu_rdma_poll_other other completion 4000 received left 0
2026-08-20T05:55:11.471594Z qemu_rdma_exchange_get_response_start CONTROL: READY receiving...
2026-08-20T05:55:11.471596Z qemu_rdma_post_send_control CONTROL: sending QEMU FILE..
2026-08-20T05:55:11.471617Z qemu_rdma_poll_other other completion 2000 received left 0
2026-08-20T05:55:11.705561Z qemu_rdma_close
2026-08-20T05:55:11.705587Z qemu_rdma_close
2026-08-20T05:55:11.705626Z qemu-system-x86_64: rdma migration: send polling control error
2026-08-20T05:55:11.707001Z qemu-system-x86_64: warning: Early error. Sending error.
2026-08-20T05:55:11.707031Z qemu_rdma_post_send_control CONTROL: sending ERROR..
2026-08-20T05:55:11.707038Z qemu-system-x86_64: warning: rdma migration: send polling control error
2026-08-20T05:55:11.707301Z qemu_rdma_cleanup_disconnect
2026-08-20T05:55:11.710569Z qemu_rdma_cleanup_disconnect

Fixes: 55cc1b5937a8 ("migration: create a dedicated connection for rdma return path")
Signed-off-by: Yanfei Xu <yanfei.xu@bytedance.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Jack Wang <jinpu.wang@cloud.ionos.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/rdma.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index 61181deb8a..618324645b 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -3141,6 +3141,12 @@ static int qemu_rdma_accept(RDMAContext *rdma)
         }
     }
 
+    ret = qemu_rdma_post_recv_control(rdma, RDMA_WRID_READY, &err);
+    if (ret < 0) {
+        error_report_err(err);
+        goto err_rdma_dest_wait;
+    }
+
     /* Accept the second connection request for return path */
     if ((migrate_postcopy() || migrate_return_path())
         && !rdma->is_return_path) {
@@ -3173,12 +3179,6 @@ static int qemu_rdma_accept(RDMAContext *rdma)
     rdma_ack_cm_event(cm_event);
     rdma->connected = true;
 
-    ret = qemu_rdma_post_recv_control(rdma, RDMA_WRID_READY, &err);
-    if (ret < 0) {
-        error_report_err(err);
-        goto err_rdma_dest_wait;
-    }
-
     qemu_rdma_dump_gid("dest_connect", rdma->cm_id);
 
     return 0;
-- 
2.53.0


