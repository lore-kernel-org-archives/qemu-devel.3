Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E743C27C79
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2024 21:23:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKPDn-0000uH-Aw; Thu, 20 Jun 2024 17:21:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sKPDl-0000ti-DP
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 17:21:29 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sKPDj-0007GX-PJ
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 17:21:29 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 75B3B1F8B6;
 Thu, 20 Jun 2024 21:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1718918486; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HuycVr/TfjIEk380XWBsQQ+Xkk+SaTBl4KTPwhXsgAI=;
 b=FGNWovgJBiV3omDJPA/xgpP5M+zJ47SYkWQ7JMhWs69YuIGluCz7oilYjKKX7w13foxtEy
 OlWKnFkLpUFcJp5IIF4FsGnDao3VzjY5qfcM5FORltp7/8+aqY6Y85GazIcdP/lL9tzx5I
 TtmQMlb5w/W4LnK1HnrBF3i0u1t66r4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1718918486;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HuycVr/TfjIEk380XWBsQQ+Xkk+SaTBl4KTPwhXsgAI=;
 b=WEtEnsXgF9ms6/B8qRELGOJJYsajyTkuvZhKAo/askcWgDpQURxdqcbqBQ1zEa/I6jAIJH
 Kb2T+uwX9NyiQgBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1718918486; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HuycVr/TfjIEk380XWBsQQ+Xkk+SaTBl4KTPwhXsgAI=;
 b=FGNWovgJBiV3omDJPA/xgpP5M+zJ47SYkWQ7JMhWs69YuIGluCz7oilYjKKX7w13foxtEy
 OlWKnFkLpUFcJp5IIF4FsGnDao3VzjY5qfcM5FORltp7/8+aqY6Y85GazIcdP/lL9tzx5I
 TtmQMlb5w/W4LnK1HnrBF3i0u1t66r4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1718918486;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HuycVr/TfjIEk380XWBsQQ+Xkk+SaTBl4KTPwhXsgAI=;
 b=WEtEnsXgF9ms6/B8qRELGOJJYsajyTkuvZhKAo/askcWgDpQURxdqcbqBQ1zEa/I6jAIJH
 Kb2T+uwX9NyiQgBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4DD0A1369F;
 Thu, 20 Jun 2024 21:21:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id iGZmBVWddGabYAAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 20 Jun 2024 21:21:25 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>
Subject: [RFC PATCH 7/7] migration/multifd: Hide multifd slots implementation
Date: Thu, 20 Jun 2024 18:21:11 -0300
Message-Id: <20240620212111.29319-8-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240620212111.29319-1-farosas@suse.de>
References: <20240620212111.29319-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.998];
 MIME_GOOD(-0.10)[text/plain]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo];
 RCVD_TLS_ALL(0.00)[]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The only two things the multifd client needs to access are the active
slot and the active slot size:

The active slot itself is obviously needed because it's where the data
is put.

The slot size is needed only by the ram pages code, because it does
not fill the data slot and sends it in one go, it instead fills the
slot partially at each call of multifd_queue_page(), so the size is
needed to differentiate an empty slot (free or recently consumed) from
the slot that is partially full.

Hide the MultiFDSlots implementation so the client is not tempted to
make use of the free list. That field is there simply because we need
the client to carry a handle to that memory, it's not supposed to be
accessed directly.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/multifd.c | 26 +++++++++++++++++++++++---
 migration/multifd.h |  8 +++-----
 2 files changed, 26 insertions(+), 8 deletions(-)

diff --git a/migration/multifd.c b/migration/multifd.c
index f22a1c2e84..9fb719eb0d 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -38,6 +38,11 @@
 #define MULTIFD_MAGIC 0x11223344U
 #define MULTIFD_VERSION 1
 
+struct MultiFDSlots {
+    MultiFDSendData **free;
+    MultiFDSendData *active;
+};
+
 typedef struct {
     uint32_t magic;
     uint32_t version;
@@ -737,7 +742,22 @@ static inline bool multifd_queue_full(MultiFDPages_t *pages)
 static inline void multifd_enqueue(MultiFDPages_t *pages, ram_addr_t offset)
 {
     pages->offset[pages->num++] = offset;
-    multifd_ram_send_slots->active->size += qemu_target_page_size();
+    multifd_set_slot_size(multifd_ram_send_slots, qemu_target_page_size());
+}
+
+void *multifd_get_active_slot(MultiFDSlots *multifd_ram_send_slots)
+{
+    return multifd_ram_send_slots->active->opaque;
+}
+
+void multifd_set_slot_size(MultiFDSlots *multifd_ram_send_slots, size_t size)
+{
+    multifd_ram_send_slots->active->size += size;
+}
+
+bool multifd_slot_has_data(MultiFDSlots *multifd_ram_send_slots)
+{
+    return !!multifd_ram_send_slots->active->size;
 }
 
 /* Returns true if enqueue successful, false otherwise */
@@ -746,7 +766,7 @@ bool multifd_queue_page(RAMBlock *block, ram_addr_t offset)
     MultiFDPages_t *pages;
 
 retry:
-    pages = multifd_ram_send_slots->active->opaque;
+    pages = multifd_get_active_slot(multifd_ram_send_slots);
 
     /* If the queue is empty, we can already enqueue now */
     if (multifd_queue_empty(pages)) {
@@ -951,7 +971,7 @@ int multifd_send_sync_main(void)
         return 0;
     }
 
-    if (multifd_ram_send_slots->active->size) {
+    if (multifd_slot_has_data(multifd_ram_send_slots)) {
         if (!multifd_send(multifd_ram_send_slots)) {
             error_report("%s: multifd_send_pages fail", __func__);
             return -1;
diff --git a/migration/multifd.h b/migration/multifd.h
index 5230729077..8f99fe2652 100644
--- a/migration/multifd.h
+++ b/migration/multifd.h
@@ -102,15 +102,13 @@ struct MultiFDSendData {
     void (*cleanup)(void *);
 };
 
-struct MultiFDSlots {
-    MultiFDSendData **free;
-    MultiFDSendData *active;
-};
-
 MultiFDSlots *multifd_allocate_slots(void *(*alloc_fn)(void),
                                      void (*reset_fn)(void *),
                                      void (*cleanup_fn)(void *));
 void multifd_ram_save_setup(void);
+void *multifd_get_active_slot(MultiFDSlots *multifd_ram_send_slots);
+void multifd_set_slot_size(MultiFDSlots *multifd_ram_send_slots, size_t size);
+bool multifd_slot_has_data(MultiFDSlots *multifd_ram_send_slots);
 
 typedef struct {
     /* Fields are only written at creating/deletion time */
-- 
2.35.3


