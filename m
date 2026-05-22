Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D75F7CD5BB8
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 21:54:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQXlX-0008Uf-2l; Fri, 22 May 2026 17:50:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wQXlR-0008FZ-2b; Fri, 22 May 2026 17:50:41 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wQXlN-0003Ln-LZ; Fri, 22 May 2026 17:50:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1779486560; bh=6yNTHyY4n+czwCDJOviiZkYDpnz4dMyJaeqmCz/8sP8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=f4ypp9qTDrbMBnGxRr2VEWfU4hKquHS7jVvVT1Ax2ochXFLkMGWi7nHNF6Oq8th5J
 0KefefqWWxia1Gy00vhaUI6mtwtBTs1S//PZWMVRguspPSKfQrFi9H9xdByr9DsCdf
 Xc7GZVW0st8FJL578uI19o1+gLHokcG78hxvqMTBCwrCZa7KuginheoYBxfMwsChkM
 EQxY0e+tvOW+RQJ4QYDNMcgmrqFQeSJ93qhJUAzzxJaRu94cKtGvI4h5qhg2pAOC+I
 56cvSYRsgTZUUvg5g4wPxW9Vkw272wlb5xsM4/fVIyyvehoCVs4803489hCBFJXb0E
 sEjiOn444JBvQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 3006F1AFB6A;
 Sat, 23 May 2026 00:49:20 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 4D0B93B71B9;
 Sat, 23 May 2026 00:49:24 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 Katherine Leaver <katherine.j.leaver@gmail.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.2.3 116/149] hw/uefi: verify data size before accessing it
 in wrap_pkcs7
Date: Sat, 23 May 2026 00:48:48 +0300
Message-ID: <20260522214923.807017-17-mjt@tls.msk.ru>
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

From: Gerd Hoffmann <kraxel@redhat.com>

Fixes: CVE-2026-41439
Fixes: 3e33af2cb306 ("hw/uefi: add var-service-pkcs7.c")
Reported-by: Katherine Leaver <katherine.j.leaver@gmail.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20260422092910.444997-6-kraxel@redhat.com>
(cherry picked from commit 22b7b222d8f5428be8b5d4787f36efd0a0b75292)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/uefi/var-service-pkcs7.c b/hw/uefi/var-service-pkcs7.c
index 32accf4e44..f17ad6872f 100644
--- a/hw/uefi/var-service-pkcs7.c
+++ b/hw/uefi/var-service-pkcs7.c
@@ -73,7 +73,8 @@ static void wrap_pkcs7(gnutls_datum_t *pkcs7)
     };
     gnutls_datum_t wrap;
 
-    if (pkcs7->data[4] == 0x06 &&
+    if (pkcs7->size > 16 &&
+        pkcs7->data[4] == 0x06 &&
         pkcs7->data[5] == 0x09 &&
         memcmp(pkcs7->data + 6, signed_data_oid, sizeof(signed_data_oid)) == 0 &&
         pkcs7->data[15] == 0x0a &&
-- 
2.47.3


