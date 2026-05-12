Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 503F7CD343F
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 21:09:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMuIT-0003VG-R1; Tue, 12 May 2026 17:05:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuIE-0001oZ-JF; Tue, 12 May 2026 17:05:30 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuIC-0000uL-OB; Tue, 12 May 2026 17:05:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1778619280; bh=6yNTHyY4n+czwCDJOviiZkYDpnz4dMyJaeqmCz/8sP8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=th1enPlCGj7WKrKTEOLcDRsgb4Jp59yqtVdDQY0oe6n4lMPxv4NQTf1DDmSWoqZ3s
 lnijZcqj2T+lzOx/1pVJxTViWuCMp+SkmxYkBW4PvYyqoSCC8FsbZObJsYxxMtRlzQ
 iRHobmSUnkgSepCshgjX6RoyF3x4YslQun6IQodsI7bBdloM1oSbT3RkMlTXAjaXWn
 EvhFZ+zMaPXNtS3Fg4oCfTR5E/Wz0yK4pYzKKxgocN8ikg1OKILH8ewx0hEN/wI4PW
 SlhNHIqff3iB/4R+g/qadGnJ55xbh8M44fvr9Uu47LwWAbHEC709qGHvhWN+bvqKaX
 Sbbxb3MkgdtuA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 7C1741AA336;
 Tue, 12 May 2026 23:54:40 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 7CEB33ABCA7;
 Tue, 12 May 2026 23:54:44 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 Katherine Leaver <katherine.j.leaver@gmail.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.10 106/107] hw/uefi: verify data size before accessing
 it in wrap_pkcs7
Date: Tue, 12 May 2026 23:54:33 +0300
Message-ID: <20260512205437.360850-106-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.10-20260512103844@cover.tls.msk.ru>
References: <qemu-stable-10.0.10-20260512103844@cover.tls.msk.ru>
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


