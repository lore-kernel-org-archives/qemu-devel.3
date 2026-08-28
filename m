Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35A40C61DCB
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 16:00:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzyzV-0001bH-NE; Fri, 28 Aug 2026 11:59:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wzyzT-0001ZU-5U
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 11:59:39 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wzyzH-0008TY-HA
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 11:59:38 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E41201F891;
 Fri, 28 Aug 2026 15:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787932762; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fRRHQXAWBSoz8D3kIzWAjQPHhGiF4yCSa3k6HkPIOAA=;
 b=B/aj0OHfji+NH42/Na8yTlqgt6L/4dyOIq2Tp/FsfxkR1hL4WnwTadHHjrU5CILLMBPuf1
 2jyENZtA9nO3kqLnGqrE13E+O4VmvVwwGXzmVn0cViOVr5tgcbWFJ8AK4db3nZC8c5idaj
 cRNfD84rpjZlcmKilu0BOEK5FFIwTmI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787932762;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fRRHQXAWBSoz8D3kIzWAjQPHhGiF4yCSa3k6HkPIOAA=;
 b=IgTc5sby619LCsYNtJiHAHTYlj06wdXNw9E9+Fb2uKMd6n4mPTAuw+M2wCTcxRO0Ju6I0f
 dyX2uEV2eR1J7/Dw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=cOudFuTD;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=JdnZ08i7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787932757; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fRRHQXAWBSoz8D3kIzWAjQPHhGiF4yCSa3k6HkPIOAA=;
 b=cOudFuTDOUkmmTHTtm9kjkwpyK500CA54PFpdhu9wQJGAYJOrLTHkbtWDnPM/1nlTuClDc
 gSfTTrN71l1dUWcY9b16cfYH7MRbfEKavW6szK13LtstYlCCAaYwdh8URsPywkRd+vSnzr
 BXm4Cwe3NGL3pNdgr9zsXMbvmAC+juA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787932757;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fRRHQXAWBSoz8D3kIzWAjQPHhGiF4yCSa3k6HkPIOAA=;
 b=JdnZ08i7RjCkPdJ9Xi21HMqaMnAxlUKwPSk69rVr6yhLziVRd5g6tXqBje0tjdpT0ezT+L
 JxVA0Lvyk39L8EAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DB41E13688;
 Fri, 28 Aug 2026 15:59:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id sKd9KlSwkWpoBQAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 28 Aug 2026 15:59:16 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
	Jinpu Wang <jinpu.wang@cloud.ionos.com>
Subject: [PULL v2 21/30] migration/rdma: Sanity check compress request ranges
Date: Fri, 28 Aug 2026 12:58:36 -0300
Message-ID: <20260828155845.2874508-22-farosas@suse.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260828155845.2874508-1-farosas@suse.de>
References: <20260828155845.2874508-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: E41201F891
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[ionos.com:email,gitlab.com:url,suse.de:dkim,suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; DKIM_TRACE(0.00)[suse.de:+]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
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

The offset/length ranges are not sanity checked in RDMA requests, add the
checks.

Reported-by: Tristan (@TristanInSec)
Closes: https://gitlab.com/qemu-project/qemu/-/work_items/4005
Reviewed-by: Jinpu Wang <jinpu.wang@cloud.ionos.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Jack Wang <jinpu.wang@cloud.ionos.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/rdma.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index d8953363fe5..e976739fad3 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -3198,6 +3198,28 @@ static int dest_ram_sort_func(const void *a, const void *b)
     return (a_index < b_index) ? -1 : (a_index != b_index);
 }
 
+static bool rdma_compress_range_check(RDMALocalBlock *block,
+                                      RDMACompress *comp)
+{
+    uint64_t block_end = block->offset + block->length;
+    uint64_t comp_end;
+
+    if (uadd64_overflow(comp->offset, comp->length, &comp_end)) {
+        goto fail;
+    }
+
+    if (comp->offset < block->offset || comp_end > block_end) {
+        goto fail;
+    }
+
+    return true;
+fail:
+    error_report("%s: compress request range outside range"
+                 " (block=%s, offset=%"PRIu64", length=%"PRIu64")",
+                 __func__, block->block_name, comp->offset, comp->length);
+    return false;
+}
+
 /*
  * During each iteration of the migration, we listen for instructions
  * by the source VM to perform dynamic page registrations before they
@@ -3277,7 +3299,9 @@ int rdma_registration_handle(QEMUFile *f)
                 goto err;
             }
             block = &(rdma->local_ram_blocks.block[comp->block_idx]);
-
+            if (!rdma_compress_range_check(block, comp)) {
+                goto err;
+            }
             host_addr = block->local_host_addr +
                             (comp->offset - block->offset);
             if (comp->value) {
-- 
2.53.0


