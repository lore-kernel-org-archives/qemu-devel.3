Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A67606A31E
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 19:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WpSzX5NG
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xX1Nf-0001m5-F9; Fri, 27 Nov 2026 14:13:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cassel@kernel.org>)
 id 1xX1NY-0001k2-G7; Fri, 27 Nov 2026 14:13:05 -0500
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cassel@kernel.org>)
 id 1xX1NW-0005r6-J3; Fri, 27 Nov 2026 14:13:04 -0500
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3ED15418B9;
 Fri, 27 Nov 2026 19:13:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B586A1F000C1;
 Fri, 27 Nov 2026 19:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795806780;
 bh=NIA6vEM+YcWX1sXh5hJuHyoqPH1OUdZMzydKosMLNqA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=WpSzX5NGFodGaasMPe1dhH+2niF5Ygcp6j5HOhl2ghqLKEf0Ih//HWps7P3F0PgHv
 uD909N/IFSflYlmJmLVjfsJtrZRRMvjy1MnJOhwrHp1ZBDcOBdsjRehM+XAEHtSAUO
 tZYG4Np+GGB9rQBBQdMfyfeliU+CmT4KhrfGJ6rrL6pCotL364/ncMDSsbIlN/7J+A
 3nfTnerdR2tdaz6BVh/jgjSs8YR62vfvHcI6EgOFOdYK0jdI1ky1cbR26LZ5LM2SuR
 D+wX2pYz9GR6HooSsxKD5qzEamL6azgZCONajk8ajP4R8SIEDB+BbhKxU8VIstmJzV
 aaJrqbevkYnfw==
From: Niklas Cassel <cassel@kernel.org>
To: John Snow <jsnow@redhat.com>,
	"Denis V. Lunev" <den@openvz.org>
Cc: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH 01/13] hw/ide: report the SMART state in IDENTIFY DEVICE
Date: Fri, 27 Nov 2026 20:12:36 +0100
Message-ID: <20261127191250.3298004-2-cassel@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261127191250.3298004-1-cassel@kernel.org>
References: <20261127191250.3298004-1-cassel@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.234.252.31; envelope-from=cassel@kernel.org;
 helo=sea.source.kernel.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Currently, IDENTIFY DEVICE word 85 bit 0 always reports the SMART feature
set as enabled, regardless if it has been disabled using SET FEATURES or
SMART DISABLE OPERATIONS.

Add a helper to build word85, such that the SMART feature set and the
write cache is reported in IDENTIFY DEVICE correctly.

Also, just like the write cache state is re-initialized after migration,
re-initialize the SMART state after migration.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 hw/ide/core.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/hw/ide/core.c b/hw/ide/core.c
index 06e6bb6067..7e3f882969 100644
--- a/hw/ide/core.c
+++ b/hw/ide/core.c
@@ -138,6 +138,14 @@ static void ide_identify_size(IDEState *s)
     put_le16(p + 103, s->nb_sectors >> 48);
 }
 
+/* IDENTIFY DEVICE word 85: the commands and feature sets that are enabled */
+static uint16_t ide_identify_word85(IDEState *s)
+{
+    /* 14 = NOP supported, 5=WCACHE enabled, 0=SMART feature set enabled */
+    return (1 << 14) | (blk_enable_write_cache(s->blk) ? 1 << 5 : 0) |
+           (s->smart_enabled ? 1 : 0);
+}
+
 static void ide_identify(IDEState *s)
 {
     uint16_t *p;
@@ -204,12 +212,7 @@ static void ide_identify(IDEState *s)
     } else {
         put_le16(p + 84, (1 << 14) | 0);
     }
-    /* 14 = NOP supported, 5=WCACHE enabled, 0=SMART feature set enabled */
-    if (blk_enable_write_cache(s->blk)) {
-        put_le16(p + 85, (1 << 14) | (1 << 5) | 1);
-    } else {
-        put_le16(p + 85, (1 << 14) | 1);
-    }
+    put_le16(p + 85, ide_identify_word85(s));
     /* 13=flush_cache_ext,12=flush_cache,10=lba48 */
     put_le16(p + 86, (1 << 13) | (1 <<12) | (1 << 10));
     /* 14=set to 1, 8=has WWN, 1=SMART self test, 0=SMART error logging */
@@ -1714,12 +1717,12 @@ static bool cmd_set_features(IDEState *s, uint8_t cmd)
     case 0x02: /* write cache enable */
         blk_set_enable_write_cache(s->blk, true);
         identify_data = (uint16_t *)s->identify_data;
-        put_le16(identify_data + 85, (1 << 14) | (1 << 5) | 1);
+        put_le16(identify_data + 85, ide_identify_word85(s));
         return true;
     case 0x82: /* write cache disable */
         blk_set_enable_write_cache(s->blk, false);
         identify_data = (uint16_t *)s->identify_data;
-        put_le16(identify_data + 85, (1 << 14) | 1);
+        put_le16(identify_data + 85, ide_identify_word85(s));
         ide_flush_cache(s);
         return false;
     case 0xcc: /* reverting to power-on defaults enable */
@@ -1942,11 +1945,9 @@ static bool cmd_smart(IDEState *s, uint8_t cmd)
 
     switch (s->feature) {
     case SMART_DISABLE:
-        s->smart_enabled = 0;
-        return true;
-
     case SMART_ENABLE:
-        s->smart_enabled = 1;
+        s->smart_enabled = s->feature == SMART_ENABLE;
+        put_le16((uint16_t *)s->identify_data + 85, ide_identify_word85(s));
         return true;
 
     case SMART_ATTR_AUTOSAVE:
@@ -2901,6 +2902,7 @@ static int ide_drive_post_load(void *opaque, int version_id)
 
     if (s->blk && s->identify_set) {
         blk_set_enable_write_cache(s->blk, !!(s->identify_data[85] & (1 << 5)));
+        s->smart_enabled = s->identify_data[85] & 1;
     }
     return 0;
 }
-- 
2.56.1


