Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DB5FC61DBD
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 16:00:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzyzV-0001bG-Ly; Fri, 28 Aug 2026 11:59:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wzyzQ-0001U8-Jb
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 11:59:36 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wzyzG-0008SP-Ak
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 11:59:36 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 551CC21F92;
 Fri, 28 Aug 2026 15:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787932759; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wMa2/41ubuJQG7osaYAeN+fD11e+ewIuN36eXzoto9M=;
 b=LEVshQd7HxEltMEgTHjO4/s/XsNu0zdL9Ko0NCfW4ISWmESHX4ZOHcz6CkQMdqB9ZOAFsr
 y3PGLUTVY83jmSDu7y9TAZ6mzeD0JTAoQ8Q1sH8oZuFPHJDvb4IGhjexuzxykI/tJz+rwZ
 5WsTxP3rBZ4iFiwe90Jxb7emYiZ6E60=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787932759;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wMa2/41ubuJQG7osaYAeN+fD11e+ewIuN36eXzoto9M=;
 b=A8bvhOYFsyLemT41znj8GB6GR9cwJ3anR8fRHItYDetldpiFQuzShllt8rwZER+EKeroYz
 OjF0Oz/HDWBABnAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787932755; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wMa2/41ubuJQG7osaYAeN+fD11e+ewIuN36eXzoto9M=;
 b=WLEgKmtqdqg/DORTvlTptMCUpSmRTDAnrVWEsD16kExjuTFOqtE0syXRtv5WDw/yCZoi1F
 EgplyyDGQHNnYtI1fhePBcWGLypM/PF4yn2H6liBuLx5QNDDtyg06UtAZkAMhuHLHd8jvR
 7Y+JtAuigmG+FPL94lDt2jplRbXVvRE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787932755;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wMa2/41ubuJQG7osaYAeN+fD11e+ewIuN36eXzoto9M=;
 b=D+6CVzVztfd9rXAQFlSb1w7GNW7GioR1QN+/DexmmrewYF0HjWGgnL3RFbJYC/AMVrSXKE
 uk7aA7E0aVywGeAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4B59313687;
 Fri, 28 Aug 2026 15:59:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id +CNpB1KwkWpoBQAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 28 Aug 2026 15:59:14 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
	Jinpu Wang <jinpu.wang@cloud.ionos.com>
Subject: [PULL v2 19/30] migration/rdma: Sanity check
 RDMA_CONTROL_REGISTER_REQUEST chunks
Date: Fri, 28 Aug 2026 12:58:34 -0300
Message-ID: <20260828155845.2874508-20-farosas@suse.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260828155845.2874508-1-farosas@suse.de>
References: <20260828155845.2874508-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.993];
 MIME_GOOD(-0.10)[text/plain]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email,ionos.com:email,gitlab.com:url];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[]
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

The value received on wire for head.chunks when registering new RDMA
regions is not correctly checked.  Logically the value can still make
ram_chunk_start() (of ram_chunk_end()) to overflow, having a result pointer
very small, smaller than RDMALocalBlock.local_host_addr.

Add the sanity check.

Reported-by: Tristan (@TristanInSec)
Closes: https://gitlab.com/qemu-project/qemu/-/work_items/4011
Reviewed-by: Jinpu Wang <jinpu.wang@cloud.ionos.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/rdma.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index f7356e759fc..cf6688a4bc3 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -3369,7 +3369,7 @@ int rdma_registration_handle(QEMUFile *f)
             }
 
             for (int count = 0; count < head.repeat; count++) {
-                uint64_t chunk;
+                uint64_t chunk, chunk_sum;
                 uint8_t *chunk_start, *chunk_end;
 
                 reg = &registers[count];
@@ -3399,6 +3399,14 @@ int rdma_registration_handle(QEMUFile *f)
                 chunk = ram_chunk_index(block->local_host_addr,
                                         (uint8_t *) host_addr);
                 chunk_start = ram_chunk_start(block, chunk);
+                if (uadd64_overflow(chunk, reg->chunks, &chunk_sum) ||
+                    chunk_sum >= block->nb_chunks) {
+                    error_report("%s: head.chunks contains illegal value"
+                                 " (chunk=%"PRIu64", chunks=%"PRIu64", "
+                                 "nb_chunks=%d)", __func__, chunk,
+                                 reg->chunks, block->nb_chunks);
+                    goto err;
+                }
                 chunk_end = ram_chunk_end(block, chunk + reg->chunks);
                 /* avoid "-Waddress-of-packed-member" warning */
                 uint32_t tmp_rkey = 0;
-- 
2.53.0


