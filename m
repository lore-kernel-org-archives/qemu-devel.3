Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF0E606A321
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 06:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=iL0YtPRA
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWp6q-0005Kc-92; Fri, 27 Nov 2026 01:07:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWp6L-00048e-Mq; Fri, 27 Nov 2026 01:06:29 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWp6J-0001zp-Tm; Fri, 27 Nov 2026 01:06:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1795759047; bh=eQD4MC0a7ibvoGPvhRGeS4OkPSt1kW4oMH1XLzoCtis=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=iL0YtPRAdIB2bHHpSUIEdWMmoKLn0b8svsuLYGKjUwJuqG3B7OaIpeBSDCSssL1E7
 WChOLr/fsP9guEuuI8ZZ0MkD1gLy4Yd/GRE/oL64ITMVHw6qS8ojKM/XrdIbhiEkqs
 GNNJg1bH5RlPIPVEnoR1RKIoBE1PhSJUNSlKhqqpUvkYet9ICpGSa/qllRC2HVwkt4
 9RTnONTcCp0qGd7UIcrJ5wj7dgljoQX21bMmJVlksw/A8n8Hz60CCMJWVatAPZT5SW
 5LI8Wi0dwFtZCw1kHZ93FtCZG0arhef0PbNCGkqEaH/O9x4uUR+So2y9heIQ9+KHai
 SqGBbj9SO1VWQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 20A1F1EA35A;
 Fri, 27 Nov 2026 08:57:27 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 1E73D469985;
 Fri, 27 Nov 2026 08:57:27 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 079D0CF302; Fri, 27 Nov 2026 08:57:27 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, malike <malike@kylinos.cn>,
 Kevin Wolf <kwolf@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.4 v2 104/152] block/bochs: validate bitmap size and
 compute extent_blocks after validation
Date: Fri, 27 Nov 2026 08:54:02 +0300
Message-ID: <20261127055709.39630-41-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.1.4-20261127085309@cover.tls.msk.ru>
References: <qemu-stable-11.1.4-20261127085309@cover.tls.msk.ru>
X-Archived-By: <archiver.kernel.org>
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: malike <malike@kylinos.cn>

bochs_open() computes bitmap_blocks using the formula
"1 + (le32_to_cpu(bochs.bitmap) - 1) / 512".  le32_to_cpu() returns
uint32_t, so when bochs.bitmap is zero the subtraction wraps to
UINT32_MAX (0xFFFFFFFF) in unsigned arithmetic, yielding
bitmap_blocks = 8388608 instead of 1.

The bitmap field is read directly from the on-disk image header and was
never validated.  The overflowed bitmap_blocks propagates into
seek_to_sector()'s bitmap_offset calculation, causing reads to target
wrong offsets and return I/O errors or incorrect data.

Add an explicit zero check for bochs.bitmap before the formula.

Also move the extent_blocks calculation to after the existing
extent_size validation.  The same "1 + (x - 1) / 512" pattern applies
to extent, but extent==0 is already caught by the "extent_size <
BDRV_SECTOR_SIZE" check; the calculation is moved after that check for
clarity and robustness, and uses the already-validated s->extent_size
instead of re-reading the header field.

Cc: qemu-stable@nongnu.org
Fixes: a8753c3466dc ("Bochs disk image support")
Signed-off-by: malike <malike@kylinos.cn>
Message-ID: <20261014033419.236057-1-malike@kylinos.cn>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
(cherry picked from commit e777dac72518c20d8780e119fb5695c169e9bda4)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/block/bochs.c b/block/bochs.c
index bfda88017d9..7a8091d47d9 100644
--- a/block/bochs.c
+++ b/block/bochs.c
@@ -167,8 +167,13 @@ static int bochs_open(BlockDriverState *bs, QDict *options, int flags,
 
     s->data_offset = le32_to_cpu(bochs.header) + (s->catalog_size * 4);
 
+    if (le32_to_cpu(bochs.bitmap) == 0) {
+        error_setg(errp, "Bitmap size must not be zero");
+        ret = -EINVAL;
+        goto fail;
+    }
+
     s->bitmap_blocks = 1 + (le32_to_cpu(bochs.bitmap) - 1) / 512;
-    s->extent_blocks = 1 + (le32_to_cpu(bochs.extent) - 1) / 512;
 
     s->extent_size = le32_to_cpu(bochs.extent);
     if (s->extent_size < BDRV_SECTOR_SIZE) {
@@ -188,6 +193,8 @@ static int bochs_open(BlockDriverState *bs, QDict *options, int flags,
         goto fail;
     }
 
+    s->extent_blocks = 1 + (s->extent_size - 1) / 512;
+
     if (s->catalog_size < DIV_ROUND_UP(bs->total_sectors,
                                        s->extent_size / BDRV_SECTOR_SIZE))
     {
-- 
2.47.3


