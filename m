Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C537EC43327
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 11:11:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1we9t4-0001QK-25; Mon, 29 Jun 2026 07:10:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yujun@kylinos.cn>) id 1we9sz-0001Q3-OH
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 07:10:45 -0400
Received: from mailgw.kylinos.cn ([124.126.103.232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yujun@kylinos.cn>) id 1we9st-0005Ei-6c
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 07:10:45 -0400
X-UUID: 22d623d673ab11f1aa26b74ffac11d73-20260629
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12, REQID:48128c12-8646-4f80-872a-9ffd164e7f71, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:e7bac3a, CLOUDID:9ac0a07ac34f1c63eb20f70483b7a4fd,
 BulkI
 D:nil,BulkQuantity:0,Recheck:0,SF:102|136|850|865|898,TC:nil,Content:0|15|
 50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0
 ,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 22d623d673ab11f1aa26b74ffac11d73-20260629
X-User: yujun@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
 (envelope-from <yujun@kylinos.cn>)
 (Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
 with ESMTP id 553986624; Mon, 29 Jun 2026 19:10:28 +0800
From: yujun <yujun@kylinos.cn>
To: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: [PATCH] crypto/x509-utils: fix gnutls error code in crt_init failure
 path
Date: Mon, 29 Jun 2026 19:10:26 +0800
Message-Id: <20260629111026.281185-1-yujun@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=124.126.103.232; envelope-from=yujun@kylinos.cn;
 helo=mailgw.kylinos.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

qcrypto_get_x509_cert_fingerprint() reports gnutls_strerror(ret) when
gnutls_x509_crt_init() fails, but ret is still the initial value -1.
Store the gnutls return code before formatting the error, matching
other gnutls call sites in the tree.

Fixes: 2183ab6251 ("crypto/x509-utils: Check for error from gnutls_x509_crt_init()")
Signed-off-by: yujun <yujun@kylinos.cn>
---
 crypto/x509-utils.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/crypto/x509-utils.c b/crypto/x509-utils.c
index 39bb6d4d8c..1843488bca 100644
--- a/crypto/x509-utils.c
+++ b/crypto/x509-utils.c
@@ -46,7 +46,8 @@ int qcrypto_get_x509_cert_fingerprint(uint8_t *cert, size_t size,
         return -1;
     }
 
-    if (gnutls_x509_crt_init(&crt) < 0) {
+    ret = gnutls_x509_crt_init(&crt);
+    if (ret < 0) {
         error_setg(errp, "Unable to initialize certificate: %s",
                    gnutls_strerror(ret));
         return -1;
-- 
2.25.1


