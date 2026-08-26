Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB40CC61DC2
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 14:32:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzEdS-0001Do-HM; Wed, 26 Aug 2026 10:29:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wzEdQ-0001Cx-L9
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 10:29:48 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wzEdO-00024A-Ti
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 10:29:48 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 665C3211E0;
 Wed, 26 Aug 2026 14:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787754581; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fRRHQXAWBSoz8D3kIzWAjQPHhGiF4yCSa3k6HkPIOAA=;
 b=fCI3m7V7RBMMIp22LG04laoRd1F4plJw+B24gaYxgZdHS6qSAjC4/+bO00YRvRkMvJk90g
 Kks0mzQKuxZ9wtCKEQduON/CFjsjPUDLiyuYm7dOl3njZWpGT7UM5VK+UJzv7171XNAhNs
 RjsuzekIABon9LFCdgedxICkY4gMykE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787754581;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fRRHQXAWBSoz8D3kIzWAjQPHhGiF4yCSa3k6HkPIOAA=;
 b=8H5ZNE3pztNo51Ydf2o0YMADrwelxNU1aKMWvJwvnOfeGi3A+jx8WcGk66ch+9McvlzmBS
 8RvJ95EDLguvOtCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787754577; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fRRHQXAWBSoz8D3kIzWAjQPHhGiF4yCSa3k6HkPIOAA=;
 b=CVT3Mx2qyo3U1Wx4CH+SWoEsBsJq/ZFWtNG1TrtydJAYknNFB8TNLBPN+3+C+nbX9Kl23L
 DFXNpKz/JgVR1IiuArKWVcZ9yHecER3PwHNFQ+WSi8vUDOJwkeYuZ2ONg0AmboO070T97/
 qp+BiRftlK5eKyJ6y+UFRUYYQUxQ4eQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787754577;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fRRHQXAWBSoz8D3kIzWAjQPHhGiF4yCSa3k6HkPIOAA=;
 b=nf/YA87hL5ebLvN8IW72PNXo/NWSwZJXGfljyC+FEoBmcn4UIh3dlqA1VMVphTQK2Jxfg9
 vjK5cs1j3QNV0gDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 76C3B13675;
 Wed, 26 Aug 2026 14:29:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id uAsRElD4jmpTJAAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 26 Aug 2026 14:29:36 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
	Jinpu Wang <jinpu.wang@cloud.ionos.com>
Subject: [PULL 21/30] migration/rdma: Sanity check compress request ranges
Date: Wed, 26 Aug 2026 11:28:56 -0300
Message-ID: <20260826142905.2315503-22-farosas@suse.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260826142905.2315503-1-farosas@suse.de>
References: <20260826142905.2315503-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.77 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.17)[-0.843];
 MIME_GOOD(-0.10)[text/plain]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[ionos.com:email,suse.de:email,suse.de:mid,gitlab.com:url,imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
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


