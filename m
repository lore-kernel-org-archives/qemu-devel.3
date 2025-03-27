Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 867E3C36011
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Mar 2025 18:54:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txsM4-0004QF-Ic; Thu, 27 Mar 2025 14:53:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1txsM3-0004Po-7a
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 14:53:27 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1txsM1-0007QL-F5
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 14:53:26 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id ACEAE1F395;
 Thu, 27 Mar 2025 18:53:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1743101603; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I1tqspiSU1zIDAjhnnBJYOfaPcZPQfJHD/g3pYbnSAQ=;
 b=kGq230jV6tNI5k5pn/nPtVz8S3MFyGq98G51n0Iz4yCXH7E3Fw1l5Vd/gYL8xFMNSuT5XL
 G1s1qnfygkh5c8acboNK1Bk1S0NoGUqqAmM3P98l/xNREfZoV51kzyFIIlssIrEHXq2Uzu
 1MtlaGIM11lGwCHrB4cF7+FPQG/Zr7I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1743101603;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I1tqspiSU1zIDAjhnnBJYOfaPcZPQfJHD/g3pYbnSAQ=;
 b=+digt2hpTgA62+TOswChbCf1JHWPTiGFCBHldFJOweiioCTRWyftcpyljwYdZfUsyM+wXF
 4u7xqo0YnY6aZaCw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=baRDwia2;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="/4z9rRh+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1743101602; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I1tqspiSU1zIDAjhnnBJYOfaPcZPQfJHD/g3pYbnSAQ=;
 b=baRDwia2BtJ3NC5izSkGpppEVHlElgL7IBFTRHAGL8vxyDnXowk+41HesrSllgjLSoW8st
 zAB3cyEy1WyjbFOQjsKD+pSMsiTAKLTSiMs1CVMo5Zt1+lR7ba/1jaCsUTeD0g/S7TpMeU
 +Ie6CdQz1nx6k6rQgSnSZ+rcXr/japo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1743101602;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I1tqspiSU1zIDAjhnnBJYOfaPcZPQfJHD/g3pYbnSAQ=;
 b=/4z9rRh+HLt+DNvNhmnz0cdK2h3iZSVYh3a7aqTUKOiW2Qt5znVehzZBHtQ7Cjr43NE2MV
 s7skUr7NHrcrz9DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CBF78139D4;
 Thu, 27 Mar 2025 18:53:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id EKQuIqCe5WcsMwAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 27 Mar 2025 18:53:20 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Steve Sistare <steven.sistare@oracle.com>,
 Tom Lendacky <thomas.lendacky@amd.com>, Michael Roth <michael.roth@amd.com>
Subject: [PULL 1/1] migration: Avoid SNP guest crash due to duplicate cpr
 blocker
Date: Thu, 27 Mar 2025 15:53:16 -0300
Message-Id: <20250327185316.23523-2-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250327185316.23523-1-farosas@suse.de>
References: <20250327185316.23523-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: ACEAE1F395
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_SOME(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 ARC_NA(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 FROM_EQ_ENVFROM(0.00)[];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+];
 RCPT_COUNT_FIVE(0.00)[5];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns, amd.com:email, oracle.com:email, suse.de:email,
 suse.de:dkim, suse.de:mid]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
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

From: Steve Sistare <steven.sistare@oracle.com>

With aux-ram-share=off, booting an SNP guest fails with:

  ../util/error.c:68: error_setv: Assertion `*errp == NULL' failed.

This is because a CPR blocker for the guest_memfd ramblock is added
twice, once in ram_block_add_cpr_blocker because aux-ram-share=off so
rb->fd < 0, and once in ram_block_add for a specific guest_memfd blocker.

To fix, add the guest_memfd blocker iff a generic one would not be
added by ram_block_add_cpr_blocker.

Fixes: 094a3dbc55df ("migration: ram block cpr blockers")
Reported-by: Tom Lendacky <thomas.lendacky@amd.com>
Reported-by: Michael Roth <michael.roth@amd.com>
Tested-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Message-ID: <1743087130-429075-1-git-send-email-steven.sistare@oracle.com>
[reword subject line]
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 system/physmem.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/system/physmem.c b/system/physmem.c
index e97de3ef65..333a5eb94d 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -158,6 +158,7 @@ static void io_mem_init(void);
 static void memory_map_init(void);
 static void tcg_log_global_after_sync(MemoryListener *listener);
 static void tcg_commit(MemoryListener *listener);
+static bool ram_is_cpr_compatible(RAMBlock *rb);
 
 /**
  * CPUAddressSpace: all the information a CPU needs about an AddressSpace
@@ -1908,13 +1909,18 @@ static void ram_block_add(RAMBlock *new_block, Error **errp)
             goto out_free;
         }
 
-        error_setg(&new_block->cpr_blocker,
-                   "Memory region %s uses guest_memfd, "
-                   "which is not supported with CPR.",
-                   memory_region_name(new_block->mr));
-        migrate_add_blocker_modes(&new_block->cpr_blocker, errp,
-                                  MIG_MODE_CPR_TRANSFER,
-                                  -1);
+        /*
+         * Add a specific guest_memfd blocker if a generic one would not be
+         * added by ram_block_add_cpr_blocker.
+         */
+        if (ram_is_cpr_compatible(new_block)) {
+            error_setg(&new_block->cpr_blocker,
+                       "Memory region %s uses guest_memfd, "
+                       "which is not supported with CPR.",
+                       memory_region_name(new_block->mr));
+            migrate_add_blocker_modes(&new_block->cpr_blocker, errp,
+                                      MIG_MODE_CPR_TRANSFER, -1);
+        }
     }
 
     ram_size = (new_block->offset + new_block->max_length) >> TARGET_PAGE_BITS;
-- 
2.35.3


