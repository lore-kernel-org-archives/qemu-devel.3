Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D2FBC54E90
	for <qemu-devel@archiver.kernel.org>; Thu, 22 May 2025 10:31:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uI3BQ-00030l-LA; Thu, 22 May 2025 06:29:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uI3BP-00030O-7r
 for qemu-devel@nongnu.org; Thu, 22 May 2025 06:29:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uI3BN-0006NV-KQ
 for qemu-devel@nongnu.org; Thu, 22 May 2025 06:29:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747909787;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZxpEFbLS34uMmcFhE5xzGXyMY8b1zltlu/qrjpYdh8I=;
 b=L+AD+sZ0HPq9CXlqKO+rPxR4UUqUiKQDGw1vH3mLJijDw0vaO1NTAH40S67svyhFlGTDVZ
 j8ZQX2gU+6c2kJmR3OELbJC9kEaPOzt9TFYkukTpsWpWp03Hx1IeyBWO3vGqmFbh0lDTvZ
 LlSn5PC2+ygmBojC+TmJ6/Dq2/E1yAI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-518-dzxVuL-FMyC7ojCtk3EsgQ-1; Thu,
 22 May 2025 06:29:46 -0400
X-MC-Unique: dzxVuL-FMyC7ojCtk3EsgQ-1
X-Mimecast-MFC-AGG-ID: dzxVuL-FMyC7ojCtk3EsgQ_1747909785
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7AF5A18004A7; Thu, 22 May 2025 10:29:45 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.179])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7C3B01958014; Thu, 22 May 2025 10:29:42 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 05/23] tests: skip legacy qcow2 encryption test if AES is not
 available
Date: Thu, 22 May 2025 11:29:05 +0100
Message-ID: <20250522102923.309452-6-berrange@redhat.com>
In-Reply-To: <20250522102923.309452-1-berrange@redhat.com>
References: <20250522102923.309452-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.184,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This avoids test breakage when we drop support for using the
built-in AES impl as a fallback for missing crypto libraries.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 tests/unit/test-crypto-block.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tests/unit/test-crypto-block.c b/tests/unit/test-crypto-block.c
index 9217b9a2ef..3ac7f17b2a 100644
--- a/tests/unit/test-crypto-block.c
+++ b/tests/unit/test-crypto-block.c
@@ -574,6 +574,13 @@ int main(int argc, char **argv)
     for (i = 0; i < G_N_ELEMENTS(test_data); i++) {
         if (test_data[i].open_opts->format == QCRYPTO_BLOCK_FORMAT_LUKS &&
             !qcrypto_hash_supports(test_data[i].hash_alg)) {
+            g_printerr("# skip unsupported %s\n",
+                       QCryptoHashAlgo_str(test_data[i].hash_alg));
+            continue;
+        }
+        if (!qcrypto_cipher_supports(QCRYPTO_CIPHER_ALGO_AES_128,
+                                     QCRYPTO_CIPHER_MODE_CBC)) {
+            g_printerr("# skip unsupported aes-128:cbc\n");
             continue;
         }
         if (!test_data[i].slow ||
-- 
2.49.0


