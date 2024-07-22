Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10F80C3DA7E
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 18:00:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVxJs-0002yr-Ba; Mon, 22 Jul 2024 13:59:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sVxJn-0002pV-PS
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 13:59:28 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sVxJl-000374-FR
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 13:59:27 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9695121B8C;
 Mon, 22 Jul 2024 17:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1721671163; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iG9KIiyOBzYdvie4pn+w1wJTeVwhMXBO9AnRUlQiMu4=;
 b=k7dla34je0L3e8Cz9F/i2e8/HMuddlnm8s+0NNDvd/6oweUq1BVdVjnSmJGCd8Ck3xpto3
 AxeFk+Zqww9Lj+842Dnrcak6Z0vi/sNILGrgyL3Jwh5fkxZmRR2NrBF59SNST9YdKm7vAQ
 BjYh0IpeVXSKi+aDaRcJKnicuTxsTVk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1721671163;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iG9KIiyOBzYdvie4pn+w1wJTeVwhMXBO9AnRUlQiMu4=;
 b=+zGijYWSQ8t6nSJI3FHLI2CZr6Eo36UG3dQNMQhIvOKbv4/QZi7Sr47dKWgf9IlfVdWj6H
 jKlchDiNvYk1mRAw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=k7dla34j;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=+zGijYWS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1721671163; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iG9KIiyOBzYdvie4pn+w1wJTeVwhMXBO9AnRUlQiMu4=;
 b=k7dla34je0L3e8Cz9F/i2e8/HMuddlnm8s+0NNDvd/6oweUq1BVdVjnSmJGCd8Ck3xpto3
 AxeFk+Zqww9Lj+842Dnrcak6Z0vi/sNILGrgyL3Jwh5fkxZmRR2NrBF59SNST9YdKm7vAQ
 BjYh0IpeVXSKi+aDaRcJKnicuTxsTVk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1721671163;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iG9KIiyOBzYdvie4pn+w1wJTeVwhMXBO9AnRUlQiMu4=;
 b=+zGijYWSQ8t6nSJI3FHLI2CZr6Eo36UG3dQNMQhIvOKbv4/QZi7Sr47dKWgf9IlfVdWj6H
 jKlchDiNvYk1mRAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 606CB13996;
 Mon, 22 Jul 2024 17:59:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id kLsJCvqdnmYnCQAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 22 Jul 2024 17:59:22 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>
Subject: [RFC PATCH v2 3/9] migration/multifd: Introduce MultiFDSendData
Date: Mon, 22 Jul 2024 14:59:08 -0300
Message-Id: <20240722175914.24022-4-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240722175914.24022-1-farosas@suse.de>
References: <20240722175914.24022-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.19 / 50.00]; MID_CONTAINS_FROM(1.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FROM_HAS_DN(0.00)[]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim]; RCVD_TLS_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: 9695121B8C
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Bar: /
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Add a new data structure to replace p->pages in the multifd
channel. This new structure will hide the multifd payload type behind
an union, so we don't need to add a new field to the channel each time
we want to handle a different data type.

This also allow us to keep multifd_send_pages() as is, without needing
to complicate the pointer switching.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/multifd.h | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/migration/multifd.h b/migration/multifd.h
index 0ecd6f47d7..c7b1ebe099 100644
--- a/migration/multifd.h
+++ b/migration/multifd.h
@@ -16,6 +16,7 @@
 #include "ram.h"
 
 typedef struct MultiFDRecvData MultiFDRecvData;
+typedef struct MultiFDSendData MultiFDSendData;
 
 bool multifd_send_setup(void);
 void multifd_send_shutdown(void);
@@ -89,6 +90,29 @@ struct MultiFDRecvData {
     off_t file_offset;
 };
 
+typedef enum {
+    MULTIFD_PAYLOAD_NONE,
+    MULTIFD_PAYLOAD_RAM,
+} MultiFDPayloadType;
+
+struct MultiFDSendData {
+    MultiFDPayloadType type;
+    union {
+        MultiFDPages_t ram;
+    } u;
+};
+
+static inline bool multifd_payload_empty(MultiFDSendData *data)
+{
+    return data->type == MULTIFD_PAYLOAD_NONE;
+}
+
+static inline void multifd_set_payload_type(MultiFDSendData *data,
+                                            MultiFDPayloadType type)
+{
+    data->type = type;
+}
+
 typedef struct {
     /* Fields are only written at creating/deletion time */
     /* No lock required for them, they are read only */
-- 
2.35.3


