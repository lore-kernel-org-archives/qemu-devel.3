Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DA72D6EC0D
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2024 13:55:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tH1Sz-0007YY-Fc; Fri, 29 Nov 2024 08:55:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tH1Sx-0007Xu-B2
 for qemu-devel@nongnu.org; Fri, 29 Nov 2024 08:55:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tH1Sv-0004na-LJ
 for qemu-devel@nongnu.org; Fri, 29 Nov 2024 08:55:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732888525;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6lmoXx0HT9jU7VAbahDRzLM1yjEzUQqnGfaV0xMXw3w=;
 b=LuOqHumLw2aNoG4DAn77zz7uuUgoj2uNjFjzNi1CjcQ0JlOUj+zxHfIBCTRFNBlHYG5lAe
 3/GDhU+AEXLYB43DuLZ4u9sXYUEL/EMBfkKqe8yWF9KA+pAuO1S+ltH0uIyKNRFBbEauMM
 PX/8ST3yZSxXUjyCXdnySu9RAOo1yEs=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-683-_I2uBRTNOIG0CINRGfNFLA-1; Fri,
 29 Nov 2024 08:55:21 -0500
X-MC-Unique: _I2uBRTNOIG0CINRGfNFLA-1
X-Mimecast-MFC-AGG-ID: _I2uBRTNOIG0CINRGfNFLA
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BC8161954AF2; Fri, 29 Nov 2024 13:55:20 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.37])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D0ECE1955D45; Fri, 29 Nov 2024 13:55:16 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 David Hildenbrand <david@redhat.com>, Martin Pitt <mpitt@redhat.com>,
 "Richard W . M . Jones" <rjones@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 2/3 for 9.2] tests/qtest: drop 'fuzz-' prefix from
 virtio-balloon test
Date: Fri, 29 Nov 2024 13:55:06 +0000
Message-ID: <20241129135507.699030-3-berrange@redhat.com>
In-Reply-To: <20241129135507.699030-1-berrange@redhat.com>
References: <20241129135507.699030-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.93,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

This test file is expected to be extended for arbitrary virtio-balloon
related tests, not merely those discovered by fuzzing.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 tests/qtest/meson.build                                       | 2 +-
 .../{fuzz-virtio-balloon-test.c => virtio-balloon-test.c}     | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)
 rename tests/qtest/{fuzz-virtio-balloon-test.c => virtio-balloon-test.c} (84%)

diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index f2f35367ae..bd41c9da5f 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -88,7 +88,7 @@ qtests_i386 = \
   (config_all_devices.has_key('CONFIG_MEGASAS_SCSI_PCI') ? ['fuzz-megasas-test'] : []) +    \
   (config_all_devices.has_key('CONFIG_LSI_SCSI_PCI') ? ['fuzz-lsi53c895a-test'] : []) +     \
   (config_all_devices.has_key('CONFIG_VIRTIO_SCSI') ? ['fuzz-virtio-scsi-test'] : []) +     \
-  (config_all_devices.has_key('CONFIG_VIRTIO_BALLOON') ? ['fuzz-virtio-balloon-test'] : []) + \
+  (config_all_devices.has_key('CONFIG_VIRTIO_BALLOON') ? ['virtio-balloon-test'] : []) + \
   (config_all_devices.has_key('CONFIG_Q35') ? ['q35-test'] : []) +                          \
   (config_all_devices.has_key('CONFIG_SB16') ? ['fuzz-sb16-test'] : []) +                   \
   (config_all_devices.has_key('CONFIG_SDHCI_PCI') ? ['fuzz-sdcard-test'] : []) +            \
diff --git a/tests/qtest/fuzz-virtio-balloon-test.c b/tests/qtest/virtio-balloon-test.c
similarity index 84%
rename from tests/qtest/fuzz-virtio-balloon-test.c
rename to tests/qtest/virtio-balloon-test.c
index ecb597fbee..6bea33b590 100644
--- a/tests/qtest/fuzz-virtio-balloon-test.c
+++ b/tests/qtest/virtio-balloon-test.c
@@ -1,5 +1,5 @@
 /*
- * QTest fuzzer-generated testcase for virtio balloon device
+ * QTest test cases for virtio balloon device
  *
  * Copyright (c) 2024 Gao Shiyuan <gaoshiyuan@baidu.com>
  *
@@ -30,7 +30,7 @@ int main(int argc, char **argv)
 {
     g_test_init(&argc, &argv, NULL);
 
-    qtest_add_func("fuzz/virtio/oss_fuzz_71649", oss_fuzz_71649);
+    qtest_add_func("virtio-balloon/oss_fuzz_71649", oss_fuzz_71649);
 
     return g_test_run();
 }
-- 
2.46.0


