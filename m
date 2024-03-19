Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA6B7C54E71
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 20:22:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmfxu-0001CY-8F; Tue, 19 Mar 2024 16:21:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rmfxt-0001AF-0N
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 16:21:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rmfxr-0007Xa-JJ
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 16:21:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710879699;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GmyzAPxjTgeKDjVJ0AWjCjntKl9QWcHfcWNyKOLGQb8=;
 b=gTKm+JNsHVdc2SADBmvngtiMmMuMR707XaXueYJL8blabq/D9tWyyBAF765trq4YKazI3V
 reaDiWOqRNwB3P9Ooue3xUOpTlIxe6IJ0i1qlFgwZ67JREfNLLM+bJicifEF0wtN/sTy4B
 dSgfflM1uHMD4GlGif1Udf/ftF5oFrU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-62-pHaeTyxDOwm7T4-xieEC-Q-1; Tue,
 19 Mar 2024 16:21:37 -0400
X-MC-Unique: pHaeTyxDOwm7T4-xieEC-Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 21A833C0252B;
 Tue, 19 Mar 2024 20:21:37 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.88])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 928C017A91;
 Tue, 19 Mar 2024 20:21:35 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PULL 6/8] crypto: query gcrypt for cipher availability
Date: Tue, 19 Mar 2024 20:21:19 +0000
Message-ID: <20240319202121.233130-7-berrange@redhat.com>
In-Reply-To: <20240319202121.233130-1-berrange@redhat.com>
References: <20240319202121.233130-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.422,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Just because a cipher is defined in the gcrypt header file, does not
imply that it can be used. Distros can filter the list of ciphers when
building gcrypt. For example, RHEL-9 disables the SM4 cipher. It is
also possible that running in FIPS mode might dynamically change what
ciphers are available at runtime.

qcrypto_cipher_supports must therefore query gcrypt directly to check
for cipher availability.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 crypto/cipher-gcrypt.c.inc | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/crypto/cipher-gcrypt.c.inc b/crypto/cipher-gcrypt.c.inc
index 6b82280f90..4a8314746d 100644
--- a/crypto/cipher-gcrypt.c.inc
+++ b/crypto/cipher-gcrypt.c.inc
@@ -93,6 +93,11 @@ bool qcrypto_cipher_supports(QCryptoCipherAlgorithm alg,
         return false;
     }
 
+    if (gcry_cipher_algo_info(qcrypto_cipher_alg_to_gcry_alg(alg),
+                              GCRYCTL_TEST_ALGO, NULL, NULL) != 0) {
+        return false;
+    }
+
     switch (mode) {
     case QCRYPTO_CIPHER_MODE_ECB:
     case QCRYPTO_CIPHER_MODE_CBC:
-- 
2.43.0


