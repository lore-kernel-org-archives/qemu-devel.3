Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 083ABC54E68
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 20:22:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmfxy-0001Ec-0R; Tue, 19 Mar 2024 16:21:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rmfxx-0001EO-CF
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 16:21:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rmfxv-0007YB-TG
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 16:21:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710879703;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pGBnPqKCjFa5l3db9bgQvwKq16jpqFeC4+FKApoxYp0=;
 b=Mxlg5xH0uZcQqeHPxcGEj9oU+GnnzR94cVUEjhWyandeSnABnSiqCh6DsZCm1BcpXHI8Mf
 FVE4LVrJI7fn5goLVEFD3qmGjygZVet397vraWr4zAz8TNygZaeJTvLUtmcjr8GNTGK8ke
 /EE6UiEILOB0BJbhY5d6vFt8OyPxT/c=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-418-EU1XFChRN4Gz-uWV2n-xTQ-1; Tue,
 19 Mar 2024 16:21:40 -0400
X-MC-Unique: EU1XFChRN4Gz-uWV2n-xTQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C192F3C02524;
 Tue, 19 Mar 2024 20:21:39 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.88])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A415217A93;
 Tue, 19 Mar 2024 20:21:38 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PULL 8/8] crypto: report which ciphers are being skipped during tests
Date: Tue, 19 Mar 2024 20:21:21 +0000
Message-ID: <20240319202121.233130-9-berrange@redhat.com>
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

Since the ciphers can be dynamically disabled at runtime, when running
unit tests it is helpful to report which ciphers we can skipped for
testing.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
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


