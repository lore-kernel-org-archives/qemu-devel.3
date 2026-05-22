Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9281CD5BB3
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 21:52:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQXmk-0002yW-BH; Fri, 22 May 2026 17:52:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wQXmL-0002cb-Li; Fri, 22 May 2026 17:51:41 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wQXmH-0003nw-EA; Fri, 22 May 2026 17:51:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1779486560; bh=ShN1YawPOBejdJIy6tjrordl8O94iVv8f/3vbxRUpwU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=iFbHrR8eTsZUY+QweMVMwo7+i3dR/EJkV5a7nXnW7OGJxmb9x25rR0Me6JXPKmZhT
 /dyl13aC5txKE/DhNi5kCERNzuhnFBpGHOZSkctvhShrtzf92kYXsRG7ocOu/qGHfT
 zzqF4voCxmi32S0YB88wsaADGm7bRpWnkB+8At0fVFnQDc6qBpVS0nBAPTgxM305BR
 xAuagpixbwePegZxlHqE+zyo3xRSUVkTPwxA5o03wUMbgotsmr0fEgiJvLsMHuvHji
 /tyn7uyaqMuTsdaasK7Es0KMxOpkxrooKS/E77pkLs7oMQZx9NPvUFw4EO7Fys/PGn
 GLC/TLXMk8lAg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 9B6121AFB71;
 Sat, 23 May 2026 00:49:20 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id BADF73B71C0;
 Sat, 23 May 2026 00:49:24 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Jeuk Kim <jeuk20.kim@samsung.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.2.3 123/149] hw/ufs: Zero reserved bytes in REPORT LUNS
 response header
Date: Sat, 23 May 2026 00:48:55 +0300
Message-ID: <20260522214923.807017-24-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.2.3-20260522213553@cover.tls.msk.ru>
References: <qemu-stable-10.2.3-20260522213553@cover.tls.msk.ru>
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

From: Jeuk Kim <jeuk20.kim@samsung.com>

ufs_emulate_report_luns() writes the 4-byte LUN list length into
outbuf[0..3] via stl_be_p() but leaves outbuf[4..7], the reserved
field, uninitialized. Those bytes are then DMA'd to guest memory,
leaking uninitialized QEMU stack data.

Fixes: 7708e298180 ("hw/ufs/lu: skip automatic zero-init of large array")
Cc: qemu-stable@nongnu.org
Signed-off-by: Jeuk Kim <jeuk20.kim@samsung.com>
(cherry picked from commit 042dbcff8382393b20b716294a6c4b1a4af6b3f1)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/ufs/lu.c b/hw/ufs/lu.c
index 3f3c9589ce..709d6adcf6 100644
--- a/hw/ufs/lu.c
+++ b/hw/ufs/lu.c
@@ -101,6 +101,10 @@ static int ufs_emulate_report_luns(UfsRequest *req, uint8_t *outbuf,
         return SCSI_COMMAND_FAIL;
     }
 
+    if (outbuf_len < 8) {
+        return SCSI_COMMAND_FAIL;
+    }
+    memset(outbuf, 0, 8);
     len += 8;
 
     for (uint8_t lun = 0; lun < UFS_MAX_LUS; ++lun) {
-- 
2.47.3


