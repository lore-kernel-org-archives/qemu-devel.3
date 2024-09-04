Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC31ECD4849
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2024 12:48:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slpNX-0004pN-4B; Wed, 04 Sep 2024 08:44:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1slpNU-0004dX-6d
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 08:44:52 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1slpNS-0005Yc-8h
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 08:44:51 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 233582191F;
 Wed,  4 Sep 2024 12:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1725453889; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zBNH5hoMByRQw4O6EKyHHEbwBKscWoD9zGn8eAJCu0A=;
 b=xKsRHyWPqYkHQFlluVX60mHVi01J6qMSou5213r/XPycDpWFbmIWtfJoe300nwe+JBzdkm
 M9W6LJg9yDRPpZhZ3Gzk/dZX0yYopNjCVTTD0PcyMyMxW/rUfgfc3HYyislPyjL2AQLy8e
 7rnnYB/IU3iBDr3WafQWM9CuRAtB1Hg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1725453889;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zBNH5hoMByRQw4O6EKyHHEbwBKscWoD9zGn8eAJCu0A=;
 b=L42n4J1/nTg5XfsYcWHKCngOSfVDyh/u77Ap3aKwNelLezqAlYmqqA+I3YlkgcsW/QPOZW
 hqnGwVdUC1Q1MiBA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=xKsRHyWP;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="L42n4J1/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1725453889; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zBNH5hoMByRQw4O6EKyHHEbwBKscWoD9zGn8eAJCu0A=;
 b=xKsRHyWPqYkHQFlluVX60mHVi01J6qMSou5213r/XPycDpWFbmIWtfJoe300nwe+JBzdkm
 M9W6LJg9yDRPpZhZ3Gzk/dZX0yYopNjCVTTD0PcyMyMxW/rUfgfc3HYyislPyjL2AQLy8e
 7rnnYB/IU3iBDr3WafQWM9CuRAtB1Hg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1725453889;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zBNH5hoMByRQw4O6EKyHHEbwBKscWoD9zGn8eAJCu0A=;
 b=L42n4J1/nTg5XfsYcWHKCngOSfVDyh/u77Ap3aKwNelLezqAlYmqqA+I3YlkgcsW/QPOZW
 hqnGwVdUC1Q1MiBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EA1ED139D2;
 Wed,  4 Sep 2024 12:44:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id SCerKz9W2GZuVQAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 04 Sep 2024 12:44:47 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 16/34] migration/multifd: Introduce MultiFDSendData
Date: Wed,  4 Sep 2024 09:43:59 -0300
Message-Id: <20240904124417.14565-17-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240904124417.14565-1-farosas@suse.de>
References: <20240904124417.14565-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 233582191F
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,suse.de:mid];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2];
 DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
 RCPT_COUNT_THREE(0.00)[3]; DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
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


