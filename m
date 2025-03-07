Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D82C2C19F32
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 11:54:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqWGn-0002K4-TD; Fri, 07 Mar 2025 06:53:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tqWGl-0002Jf-Jx
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 06:53:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tqWGj-0000Ii-Hi
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 06:53:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741348412;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ejp1ZFIkd5EIz6blSxhMLbiNuuiZYj+Bxa1o9Ig30bo=;
 b=A4LDiN0oqKAbCFVhD4GPyqQDC9zsPj2XddFTFezRm8HexRwpiKHxHf4fXeb3SdXJLCf0b2
 YTueUV177n5W2nxmwvHizkyOCkAEO9HcMagnduO26NsgipvcOcn2GKaqIUdlQPp/SxehGU
 ItxCXhAnLVvunTtMHSDpyqv+rbQqaLY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-615-sD_uyH57NSCzK6Okz27Mjg-1; Fri,
 07 Mar 2025 06:53:29 -0500
X-MC-Unique: sD_uyH57NSCzK6Okz27Mjg-1
X-Mimecast-MFC-AGG-ID: sD_uyH57NSCzK6Okz27Mjg_1741348408
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5B0D21956083; Fri,  7 Mar 2025 11:53:28 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.32.60])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 497621944F2E; Fri,  7 Mar 2025 11:53:26 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 03/15] tests/functional: reduce tuxrun maxmem to work on 32-bit
 hosts
Date: Fri,  7 Mar 2025 12:53:02 +0100
Message-ID: <20250307115314.1096373-4-thuth@redhat.com>
In-Reply-To: <20250307115314.1096373-1-thuth@redhat.com>
References: <20250307115314.1096373-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Daniel P. Berrangé <berrange@redhat.com>

maxmem=4G is too large to address on 32-bit hosts, so reduce it
to 2G since the tuxrun tests don't actually need such an elevated
memory limit.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250228102738.3064045-5-berrange@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/functional/test_ppc64_tuxrun.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/functional/test_ppc64_tuxrun.py b/tests/functional/test_ppc64_tuxrun.py
index 05c6162b5e2..e8f79c676e5 100755
--- a/tests/functional/test_ppc64_tuxrun.py
+++ b/tests/functional/test_ppc64_tuxrun.py
@@ -64,7 +64,7 @@ def ppc64_common_tuxrun(self, kernel_asset, rootfs_asset, prefix):
                          ',"index":1,"id":"pci.1"}')
         self.vm.add_args('-device', '{"driver":"spapr-vscsi","id":"scsi1"'
                          ',"reg":12288}')
-        self.vm.add_args('-m', '2G,slots=32,maxmem=4G',
+        self.vm.add_args('-m', '1G,slots=32,maxmem=2G',
                          '-object', 'memory-backend-ram,id=ram1,size=1G',
                          '-device', 'pc-dimm,id=dimm1,memdev=ram1')
 
-- 
2.48.1


