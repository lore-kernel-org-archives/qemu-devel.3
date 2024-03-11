Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66858C54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 12:20:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjed6-0002z3-AQ; Mon, 11 Mar 2024 08:19:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rjecz-0002yA-QR
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 08:19:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rjecy-0007tU-Fv
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 08:19:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710159575;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Kfk/BADC8QS/5+v1rBIu2KBQ+fXJSUnRQidFPn+nsr4=;
 b=P69V3nqBTCnygyfA6E1zZsSVs5fOcIeeAegQr5j6A9eJhINsa3RRf5YW5dnBDmp5uoWvX5
 sThnfMtYsNoiTvqPPqGq5SuIs/HGLVw9YokO3VmYqXGwqFBrbCr6O3AnzzlLanho8kBrsW
 MIxWaKWuW04wSXTpU0C5+4wFMvzXAig=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-27-BvmBoOcKO2-DGPFf76YkPg-1; Mon, 11 Mar 2024 08:19:34 -0400
X-MC-Unique: BvmBoOcKO2-DGPFf76YkPg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 10C2389CA01
 for <qemu-devel@nongnu.org>; Mon, 11 Mar 2024 12:19:34 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.132])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6C453C1576F;
 Mon, 11 Mar 2024 12:19:33 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH 4/4] crypto: report which ciphers are being skipped during
 tests
Date: Mon, 11 Mar 2024 12:19:29 +0000
Message-ID: <20240311121929.212472-5-berrange@redhat.com>
In-Reply-To: <20240311121929.212472-1-berrange@redhat.com>
References: <20240311121929.212472-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.029,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Since the ciphers can be dynamically disabled at runtime, when running
unit tests it is helpful to report which ciphers we can skipped for
testing.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 tests/unit/test-crypto-cipher.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tests/unit/test-crypto-cipher.c b/tests/unit/test-crypto-cipher.c
index d0ea7b4d8e..f5152e569d 100644
--- a/tests/unit/test-crypto-cipher.c
+++ b/tests/unit/test-crypto-cipher.c
@@ -821,6 +821,10 @@ int main(int argc, char **argv)
     for (i = 0; i < G_N_ELEMENTS(test_data); i++) {
         if (qcrypto_cipher_supports(test_data[i].alg, test_data[i].mode)) {
             g_test_add_data_func(test_data[i].path, &test_data[i], test_cipher);
+        } else {
+            g_printerr("# skip unsupported %s:%s\n",
+                       QCryptoCipherAlgorithm_str(test_data[i].alg),
+                       QCryptoCipherMode_str(test_data[i].mode));
         }
     }
 
-- 
2.43.0


