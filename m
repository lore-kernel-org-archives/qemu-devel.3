Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73642C5321D
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2024 17:40:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1shYG2-0007sS-DO; Fri, 23 Aug 2024 13:39:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1shYFz-0007iS-BM
 for qemu-devel@nongnu.org; Fri, 23 Aug 2024 13:39:27 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1shYFx-0008TI-MR
 for qemu-devel@nongnu.org; Fri, 23 Aug 2024 13:39:27 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0A7BB20361;
 Fri, 23 Aug 2024 17:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1724434763; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zBNH5hoMByRQw4O6EKyHHEbwBKscWoD9zGn8eAJCu0A=;
 b=uy83LAm34o07jwAkPUgE/B9zsRZFglhEoxH8HT8Ofam+Sdxiu1mKGNNBF4H7Vbh6l2PS58
 rxK7Wt/7u4O/u4KG8m5cErk70t3oJ8EVZg8lvbhMn7z5NnFhNGtVqddLaRN6fQz7YhLQu0
 HAncGaBfqGyVQ9m9RVKGgiMS1Z/ZzYw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1724434763;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zBNH5hoMByRQw4O6EKyHHEbwBKscWoD9zGn8eAJCu0A=;
 b=wZTIB8/4mnZ5sBrpHGrFiCLUJmmuECWQRpB98jRKZOJjwFfxIjx9TwWQMa+31nK5TMESOR
 MNP0sogd1kKyi7Bw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1724434763; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zBNH5hoMByRQw4O6EKyHHEbwBKscWoD9zGn8eAJCu0A=;
 b=uy83LAm34o07jwAkPUgE/B9zsRZFglhEoxH8HT8Ofam+Sdxiu1mKGNNBF4H7Vbh6l2PS58
 rxK7Wt/7u4O/u4KG8m5cErk70t3oJ8EVZg8lvbhMn7z5NnFhNGtVqddLaRN6fQz7YhLQu0
 HAncGaBfqGyVQ9m9RVKGgiMS1Z/ZzYw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1724434763;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zBNH5hoMByRQw4O6EKyHHEbwBKscWoD9zGn8eAJCu0A=;
 b=wZTIB8/4mnZ5sBrpHGrFiCLUJmmuECWQRpB98jRKZOJjwFfxIjx9TwWQMa+31nK5TMESOR
 MNP0sogd1kKyi7Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D62741333E;
 Fri, 23 Aug 2024 17:39:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id mALGJknJyGb2LwAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 23 Aug 2024 17:39:21 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>
Subject: [PATCH v4 05/16] migration/multifd: Introduce MultiFDSendData
Date: Fri, 23 Aug 2024 14:39:00 -0300
Message-Id: <20240823173911.6712-6-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240823173911.6712-1-farosas@suse.de>
References: <20240823173911.6712-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.986];
 MIME_GOOD(-0.10)[text/plain]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid];
 RCVD_TLS_ALL(0.00)[]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/multifd.h | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/migration/multifd.h b/migration/multifd.h
index 660a9882c2..7bb4a2cbc4 100644
--- a/migration/multifd.h
+++ b/migration/multifd.h
@@ -17,6 +17,7 @@
 #include "ram.h"
 
 typedef struct MultiFDRecvData MultiFDRecvData;
+typedef struct MultiFDSendData MultiFDSendData;
 
 bool multifd_send_setup(void);
 void multifd_send_shutdown(void);
@@ -88,6 +89,31 @@ struct MultiFDRecvData {
     off_t file_offset;
 };
 
+typedef enum {
+    MULTIFD_PAYLOAD_NONE,
+    MULTIFD_PAYLOAD_RAM,
+} MultiFDPayloadType;
+
+typedef union MultiFDPayload {
+    MultiFDPages_t ram;
+} MultiFDPayload;
+
+struct MultiFDSendData {
+    MultiFDPayloadType type;
+    MultiFDPayload u;
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


