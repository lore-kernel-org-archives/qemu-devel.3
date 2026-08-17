Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB1C5C5DF66
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 10:48:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvusB-0004lQ-6b; Mon, 17 Aug 2026 06:47:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wvurz-0004AB-Ds; Mon, 17 Aug 2026 06:47:10 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wvuru-0004CS-At; Mon, 17 Aug 2026 06:47:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1786963486; bh=KlIQqABdyaS4e9YH8nCF2RnZQdBZWf2veFXtmUj2i8A=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=qlMovCaLX8phhPAXX2KRVkHtwMeeU8Ii9nhi/ccQrtr1rwyYqtCaFgqH0QwTZz2xx
 qCOp1Bpbediq+Zv8I5aQ/iIQIAGlsC7DdmJjTOX4PJ+1NCCan7/BfxhwgyaU4M9WI/
 flmP9QlEpEABWPkzSp69uRvQXzkiV7HNYdP2LgLrnDqZ43+h6ZZF4PwrapPLtz3EIV
 fqYmf9ovuyePDNxMG7kijZQNp4ZrnROsJCxrG0ZCF1rYw7x34B2hGGg1Faq8nOY4CK
 hFyIjRuEi8UCvXNFG17q4rkEngF+zEfZYin3y+4eMXNAEYVcV9DOx58YaKzKYI2LO0
 lTEXTzlGE7uvA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id B45591CBB7D;
 Mon, 17 Aug 2026 13:44:46 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id B5C4440D20E;
 Mon, 17 Aug 2026 13:45:07 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 366F930E72; Mon, 17 Aug 2026 13:44:41 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Xu <peterx@redhat.com>,
 xlabai <xlabai@tencent.com>, Jules Denardou <jules.denardou@datadoghq.com>,
 Tristan Madani <tristan@talencesecurity.com>,
 Fabiano Rosas <farosas@suse.de>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.4 v2 144/161] migration/multifd: Validate
 next_packet_size in zlib/zstd recv
Date: Mon, 17 Aug 2026 13:42:58 +0300
Message-ID: <20260817104344.2047346-24-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.4-20260817125055@cover.tls.msk.ru>
References: <qemu-stable-11.0.4-20260817125055@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

The zlib and zstd multifd compression backends read next_packet_size from
the incoming migration stream and use it directly as the read length into a
fixed-size buffer (MULTIFD_PACKET_SIZE * 2 = 1MB).  A malicious migration
source can set next_packet_size bigger than allocated, causing a heap
buffer overflow write on the destination.

Add a check against zbuff_len before reading, matching what the qatzip
backend already does.  Also replace the assert(in_size == 0) for empty
packets with proper error reporting, since the value is wire-controlled,
meanwhile assert() stops working with -DNDEBUG builds.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3737
Reported-by: xlabai <xlabai@tencent.com>
Reported-by: Jules Denardou <jules.denardou@datadoghq.com>
Reported-by: Tristan Madani <tristan@talencesecurity.com>
Reported-by: david korczynski (@david1766)
Reported-by: huntr bubble (@bubblehuntr)
Cc: qemu-stable <qemu-stable@nongnu.org>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/r/20260728210417.1925078-3-peterx@redhat.com
Signed-off-by: Peter Xu <peterx@redhat.com>
(cherry picked from commit ac7fa2e9d457ff9c777be32617f3c46548c4cadf)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/migration/multifd-zlib.c b/migration/multifd-zlib.c
index 8820b2a787c..400146566e1 100644
--- a/migration/multifd-zlib.c
+++ b/migration/multifd-zlib.c
@@ -216,10 +216,19 @@ static int multifd_zlib_recv(MultiFDRecvParams *p, Error **errp)
         return -1;
     }
 
+    if (in_size > z->zbuff_len) {
+        error_setg(errp, "multifd %u: next_packet_size %"PRIu32
+                   " exceeds allocated %"PRIu32, p->id, in_size, z->zbuff_len);
+        return -1;
+    }
+
     multifd_recv_zero_page_process(p);
 
     if (!p->normal_num) {
-        assert(in_size == 0);
+        if (in_size != 0) {
+            error_setg(errp, "multifd %u: expected empty packet", p->id);
+            return -1;
+        }
         return 0;
     }
 
diff --git a/migration/multifd-zstd.c b/migration/multifd-zstd.c
index 3c2dcf76b0f..69ef1a5f386 100644
--- a/migration/multifd-zstd.c
+++ b/migration/multifd-zstd.c
@@ -210,10 +210,19 @@ static int multifd_zstd_recv(MultiFDRecvParams *p, Error **errp)
         return -1;
     }
 
+    if (in_size > z->zbuff_len) {
+        error_setg(errp, "multifd %u: next_packet_size %"PRIu32
+                   " exceeds allocated %"PRIu32, p->id, in_size, z->zbuff_len);
+        return -1;
+    }
+
     multifd_recv_zero_page_process(p);
 
     if (!p->normal_num) {
-        assert(in_size == 0);
+        if (in_size != 0) {
+            error_setg(errp, "multifd %u: expected empty packet", p->id);
+            return -1;
+        }
         return 0;
     }
 
-- 
2.47.3


