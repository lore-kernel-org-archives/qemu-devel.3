Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09224E7719D
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 12:16:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWDuH-0001OE-V1; Fri, 10 Jan 2025 07:14:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tWDuE-0001N6-Hp
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 07:14:26 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tWDuC-0003JR-QX
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 07:14:26 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 77AD11F45A;
 Fri, 10 Jan 2025 12:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1736511263; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y1PAg2iDIDfiOwtcg7H5W6davTnATRnEm3vOrL4IAyI=;
 b=lDYpgSPWGDocqW30N5eeATEmzN0Mmu1+nXOuP3Wlsy2wop8PsvIpHZ5+fQFK63+fQCebX4
 taRnbiCsk+NvnIfb9UsGEdt7tfdYo0fwNDcT3heaCPOwIrA3zRSatg8HqukVYZxR1wp7wd
 3Fg565BswjDGCsLV0/oo1IfTZmQZhbA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1736511263;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y1PAg2iDIDfiOwtcg7H5W6davTnATRnEm3vOrL4IAyI=;
 b=yEZh9qAAXWYzj+1vH67p5eMMjnv4AU8RndAtYPoS3OA96AOMNlVk+q9cBgvDbSD4zf55Ca
 xCogEyHbrSV8LCAQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=lDYpgSPW;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=yEZh9qAA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1736511263; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y1PAg2iDIDfiOwtcg7H5W6davTnATRnEm3vOrL4IAyI=;
 b=lDYpgSPWGDocqW30N5eeATEmzN0Mmu1+nXOuP3Wlsy2wop8PsvIpHZ5+fQFK63+fQCebX4
 taRnbiCsk+NvnIfb9UsGEdt7tfdYo0fwNDcT3heaCPOwIrA3zRSatg8HqukVYZxR1wp7wd
 3Fg565BswjDGCsLV0/oo1IfTZmQZhbA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1736511263;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y1PAg2iDIDfiOwtcg7H5W6davTnATRnEm3vOrL4IAyI=;
 b=yEZh9qAAXWYzj+1vH67p5eMMjnv4AU8RndAtYPoS3OA96AOMNlVk+q9cBgvDbSD4zf55Ca
 xCogEyHbrSV8LCAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7784913A86;
 Fri, 10 Jan 2025 12:14:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 6CVHDx4PgWdURwAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 10 Jan 2025 12:14:22 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>
Subject: [PULL 04/25] migration/ram: Move RAM_SAVE_FLAG* into ram.h
Date: Fri, 10 Jan 2025 09:13:52 -0300
Message-Id: <20250110121413.12336-5-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250110121413.12336-1-farosas@suse.de>
References: <20250110121413.12336-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 77AD11F45A
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

From: Peter Xu <peterx@redhat.com>

Firstly, we're going to use the multifd flag soon in multifd code, so ram.c
isn't gonna work.

Secondly, we have a separate RDMA flag dangling around, which is definitely
not obvious.  There's one comment that helps, but not too much.

Put all RAM save flags altogether, so nothing will get overlooked.

Add a section explain why we can't use bits over 0x200.

Remove RAM_SAVE_FLAG_FULL as it's already not used in QEMU, as the comment
explained.

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Peter Xu <peterx@redhat.com>
Message-Id: <20241206224755.1108686-4-peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/ram.c  | 21 ---------------------
 migration/ram.h  | 28 ++++++++++++++++++++++++++++
 migration/rdma.h |  7 -------
 3 files changed, 28 insertions(+), 28 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index f0ddd5eabe..01521de71f 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -71,27 +71,6 @@
 /***********************************************************/
 /* ram save/restore */
 
-/*
- * RAM_SAVE_FLAG_ZERO used to be named RAM_SAVE_FLAG_COMPRESS, it
- * worked for pages that were filled with the same char.  We switched
- * it to only search for the zero value.  And to avoid confusion with
- * RAM_SAVE_FLAG_COMPRESS_PAGE just rename it.
- *
- * RAM_SAVE_FLAG_FULL was obsoleted in 2009.
- *
- * RAM_SAVE_FLAG_COMPRESS_PAGE (0x100) was removed in QEMU 9.1.
- */
-#define RAM_SAVE_FLAG_FULL     0x01
-#define RAM_SAVE_FLAG_ZERO     0x02
-#define RAM_SAVE_FLAG_MEM_SIZE 0x04
-#define RAM_SAVE_FLAG_PAGE     0x08
-#define RAM_SAVE_FLAG_EOS      0x10
-#define RAM_SAVE_FLAG_CONTINUE 0x20
-#define RAM_SAVE_FLAG_XBZRLE   0x40
-/* 0x80 is reserved in rdma.h for RAM_SAVE_FLAG_HOOK */
-#define RAM_SAVE_FLAG_MULTIFD_FLUSH    0x200
-/* We can't use any flag that is bigger than 0x200 */
-
 /*
  * mapped-ram migration supports O_DIRECT, so we need to make sure the
  * userspace buffer, the IO operation size and the file offset are
diff --git a/migration/ram.h b/migration/ram.h
index 0d1981f888..921c39a2c5 100644
--- a/migration/ram.h
+++ b/migration/ram.h
@@ -33,6 +33,34 @@
 #include "exec/cpu-common.h"
 #include "io/channel.h"
 
+/*
+ * RAM_SAVE_FLAG_ZERO used to be named RAM_SAVE_FLAG_COMPRESS, it
+ * worked for pages that were filled with the same char.  We switched
+ * it to only search for the zero value.  And to avoid confusion with
+ * RAM_SAVE_FLAG_COMPRESS_PAGE just rename it.
+ *
+ * RAM_SAVE_FLAG_FULL (0x01) was obsoleted in 2009.
+ *
+ * RAM_SAVE_FLAG_COMPRESS_PAGE (0x100) was removed in QEMU 9.1.
+ *
+ * RAM_SAVE_FLAG_HOOK is only used in RDMA. Whenever this is found in the
+ * data stream, the flags will be passed to rdma functions in the
+ * incoming-migration side.
+ *
+ * We can't use any flag that is bigger than 0x200, because the flags are
+ * always assumed to be encoded in a ramblock address offset, which is
+ * multiple of PAGE_SIZE.  Here it means QEMU supports migration with any
+ * architecture that has PAGE_SIZE>=1K (0x400).
+ */
+#define RAM_SAVE_FLAG_ZERO                    0x002
+#define RAM_SAVE_FLAG_MEM_SIZE                0x004
+#define RAM_SAVE_FLAG_PAGE                    0x008
+#define RAM_SAVE_FLAG_EOS                     0x010
+#define RAM_SAVE_FLAG_CONTINUE                0x020
+#define RAM_SAVE_FLAG_XBZRLE                  0x040
+#define RAM_SAVE_FLAG_HOOK                    0x080
+#define RAM_SAVE_FLAG_MULTIFD_FLUSH           0x200
+
 extern XBZRLECacheStats xbzrle_counters;
 
 /* Should be holding either ram_list.mutex, or the RCU lock. */
diff --git a/migration/rdma.h b/migration/rdma.h
index a8d27f33b8..f55f28bbed 100644
--- a/migration/rdma.h
+++ b/migration/rdma.h
@@ -33,13 +33,6 @@ void rdma_start_incoming_migration(InetSocketAddress *host_port, Error **errp);
 #define RAM_CONTROL_ROUND     1
 #define RAM_CONTROL_FINISH    3
 
-/*
- * Whenever this is found in the data stream, the flags
- * will be passed to rdma functions in the incoming-migration
- * side.
- */
-#define RAM_SAVE_FLAG_HOOK     0x80
-
 #define RAM_SAVE_CONTROL_NOT_SUPP -1000
 #define RAM_SAVE_CONTROL_DELAYED  -2000
 
-- 
2.35.3


