Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15BE2C61DBD
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 14:31:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzEdj-0001OC-99; Wed, 26 Aug 2026 10:30:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wzEdb-0001Gd-2r
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 10:29:59 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wzEdZ-0002Lw-Bf
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 10:29:58 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D8E331F822;
 Wed, 26 Aug 2026 14:29:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787754592; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Yogt7hp0asx6p9ZHQBFyYyBwc22IVXY4dpf+tsNP4gU=;
 b=1EFuM8X0e2pazw+svAYKXcwX0uXoyWuq6xbUQ8oyVJ7+ndlz6JoN6lN7llJ/m0DhpZ011v
 zoR4Rtc/mMI177tmV2rb1KwLXNf3u/IkNpy49tXWRARUVn75X18VMeH1acGvz0PBH1gbKB
 oV57yosbpahl+tGL0a0P5wWpOD+89xU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787754592;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Yogt7hp0asx6p9ZHQBFyYyBwc22IVXY4dpf+tsNP4gU=;
 b=GmVicwK2uW03IwcThJ47nBs2yT2W2m9v9fuWR7unztvDZnMa8UgETCDESCxBdmVeRgEOXA
 3v/jDKA5syZ+iuBA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=pBdakwEH;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=KyfYhy0T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787754587; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Yogt7hp0asx6p9ZHQBFyYyBwc22IVXY4dpf+tsNP4gU=;
 b=pBdakwEHvDING+A3Y2Xcr5b0wDjzlg8ecSxQlTs2/2OxlsYlo/+ifv+a+BETBOZvhcrXCK
 zpjoH1zZ/7hzYXbUcPXUmwn270pJl5Zswk/nUY1NF1Ra+q3Psofy8I7m1itBpzTf3q7D9C
 oiP+d2H/bKTYta4Iv5sAcQwecFU/Wgs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787754587;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Yogt7hp0asx6p9ZHQBFyYyBwc22IVXY4dpf+tsNP4gU=;
 b=KyfYhy0TgMvWSs7U/ShGeAoEzK6zEUGw0jJ3famusvzcXsx5F1r+E/PPqZU9IzkXip/uJY
 nWlJLn/ckEglM1DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E8E8D13354;
 Wed, 26 Aug 2026 14:29:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id oAL9LVr4jmpTJAAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 26 Aug 2026 14:29:46 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
	hongmianquan <hongmianquan@bytedance.com>
Subject: [PULL 30/30] migration/postcopy: fix page_requested leak for
 vhost-user shared pages
Date: Wed, 26 Aug 2026 11:29:05 -0300
Message-ID: <20260826142905.2315503-31-farosas@suse.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260826142905.2315503-1-farosas@suse.de>
References: <20260826142905.2315503-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-0.989]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FROM_HAS_DN(0.00)[]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid,suse.de:dkim,bytedance.com:email];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 URIBL_BLOCKED(0.00)[bytedance.com:email,suse.de:email,suse.de:mid,suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCPT_COUNT_THREE(0.00)[3]; DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: D8E331F822
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
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

From: hongmianquan <hongmianquan@bytedance.com>

With postcopy-preempt enabled, a postcopy migration of a guest with a
vhost-user device can hang at the very end on the destination, after all
pages are transferred (query-migrate: status=postcopy-active, remaining=0).

Root cause is an add/del key mismatch on mis->page_requested:

- add: a backend fault goes through postcopy_request_shared_page() ->
  postcopy_request_page() -> migrate_send_rp_req_pages(), which inserts
  the request and bumps page_requested_count keyed by client_addr.
- del: qemu_ufd_copy_ioctl() removes the entry and drops the counter
  keyed by this QEMU process's host address for the page.

client_addr is a VA in the external vhost-user backend's address space and
never equals QEMU's host address, so the removal misses and the counter
leaks. postcopy_ram_incoming_cleanup() then waits for it to reach zero
forever, which also stalls the source (it waits for the return path).

Racing threads:
  dst: postcopy_ram_listen_thread -> postcopy_ram_incoming_cleanup ->
       qemu_cond_wait_impl              (waits for page_requested_count==0)
       (postcopy_preempt_thread already placed/woke the pages)
  src: migration_thread -> migration_completion ->
       await_return_path_close_on_source -> qemu_thread_join
       (source_return_path_thread blocked in recvmsg)

The leak is only triggered when the vhost-user backend faults on a page
that has not been received yet: only then does the request take the
shared-fault slow path and register an entry in page_requested. If that
page is subsequently delivered while the request is still outstanding,
its entry is never removed. (Pages already present when the backend
faults just take the wake path and never register.) So a run may leak
only a few entries (9 of ~244k requests in our repro) yet still hang.

Fix: key the request with the same host address the removal uses
(rb->host + aligned_rbo) instead of client_addr. The backend wake still
happens at placement time via postcopy_wake_shared().

Signed-off-by: hongmianquan <hongmianquan@bytedance.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/postcopy-ram.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index 885ab58fca5..5509cbdcb8d 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -1123,7 +1123,20 @@ int postcopy_request_shared_page(struct PostCopyFD *pcfd, RAMBlock *rb,
         return postcopy_wake_shared(pcfd, client_addr, rb);
     }
     /* TODO: support blocktime tracking */
-    postcopy_request_page(mis, rb, aligned_rbo, client_addr, 0);
+
+    /*
+     * The page will be placed by qemu_ufd_copy_ioctl(), which removes the
+     * matching entry from mis->page_requested (and drops
+     * page_requested_count) using this QEMU process's host address for the
+     * page. Register the request with the same key, rb->host + aligned_rbo,
+     * not client_addr: client_addr is a VA in the external vhost-user
+     * backend's address space and can never equal that host address, so the
+     * removal would miss forever, leaking page_requested_count and hanging
+     * postcopy teardown.
+     */
+    postcopy_request_page(mis, rb, aligned_rbo,
+                          (uint64_t)(uintptr_t)qemu_ram_get_host_addr(rb) +
+                          aligned_rbo, 0);
     return 0;
 }
 
-- 
2.53.0


