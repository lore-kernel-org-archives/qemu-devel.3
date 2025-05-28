Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58FFAC5AD49
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 10:08:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKDgd-0005xk-RE; Wed, 28 May 2025 06:07:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uKDgO-0004rJ-Jk
 for qemu-devel@nongnu.org; Wed, 28 May 2025 06:06:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uKDgL-0007JD-94
 for qemu-devel@nongnu.org; Wed, 28 May 2025 06:06:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748426798;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i4s4nDeinyoCVN53qRh52ZsiWvCPH0QRvFdBdGrsLMM=;
 b=bwMWvY2gFWG3XwaTk0To00As95pI9IKTNGzMnqRYf63JeUhDNLAdSw85nSj8QJO9CV7gdF
 L2mvvL1fxHQ6zJSBCziRetBooKvkPtdZjPOmQ1E04RIsMN+y9//WCMEwPVnhbC24zUsXEX
 BzdzIFgxbUVYIZxLcw0MleDZXQlp9Vw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-319-WGmg8QXLPbO2IP_ZpkaAiA-1; Wed,
 28 May 2025 06:06:34 -0400
X-MC-Unique: WGmg8QXLPbO2IP_ZpkaAiA-1
X-Mimecast-MFC-AGG-ID: WGmg8QXLPbO2IP_ZpkaAiA_1748426794
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F085F1800261; Wed, 28 May 2025 10:06:33 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.34.110])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A0846180049D; Wed, 28 May 2025 10:06:30 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PULL 24/27] hw/net/vmxnet3: Remove
 VMXNET3_COMPAT_FLAG_OLD_MSI_OFFSETS definition
Date: Wed, 28 May 2025 12:05:04 +0200
Message-ID: <20250528100507.313906-25-thuth@redhat.com>
In-Reply-To: <20250528100507.313906-1-thuth@redhat.com>
References: <20250528100507.313906-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) DKIMWL_WL_HIGH=-2.907, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

VMXNET3_COMPAT_FLAG_OLD_MSI_OFFSETS was only used by the
hw_compat_2_5[] array, via the 'x-old-msi-offsets=on' property.
We removed all machines using that array, lets remove all the
code around VMXNET3_COMPAT_FLAG_OLD_MSI_OFFSETS.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Message-ID: <20250512083948.39294-18-philmd@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/net/vmxnet3.c | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/hw/net/vmxnet3.c b/hw/net/vmxnet3.c
index 83d942af179..3cf5d71f478 100644
--- a/hw/net/vmxnet3.c
+++ b/hw/net/vmxnet3.c
@@ -42,18 +42,13 @@
 #define VMXNET3_MSIX_BAR_SIZE 0x2000
 
 /* Compatibility flags for migration */
-#define VMXNET3_COMPAT_FLAG_OLD_MSI_OFFSETS_BIT 0
-#define VMXNET3_COMPAT_FLAG_OLD_MSI_OFFSETS \
-    (1 << VMXNET3_COMPAT_FLAG_OLD_MSI_OFFSETS_BIT)
 #define VMXNET3_COMPAT_FLAG_DISABLE_PCIE_BIT 1
 #define VMXNET3_COMPAT_FLAG_DISABLE_PCIE \
     (1 << VMXNET3_COMPAT_FLAG_DISABLE_PCIE_BIT)
 
 #define VMXNET3_EXP_EP_OFFSET (0x48)
-#define VMXNET3_MSI_OFFSET(s) \
-    ((s)->compat_flags & VMXNET3_COMPAT_FLAG_OLD_MSI_OFFSETS ? 0x50 : 0x84)
-#define VMXNET3_MSIX_OFFSET(s) \
-    ((s)->compat_flags & VMXNET3_COMPAT_FLAG_OLD_MSI_OFFSETS ? 0 : 0x9c)
+#define VMXNET3_MSI_OFFSET    (0x84)
+#define VMXNET3_MSIX_OFFSET   (0x9c)
 #define VMXNET3_DSN_OFFSET     (0x100)
 
 #define VMXNET3_BAR0_IDX      (0)
@@ -61,8 +56,7 @@
 #define VMXNET3_MSIX_BAR_IDX  (2)
 
 #define VMXNET3_OFF_MSIX_TABLE (0x000)
-#define VMXNET3_OFF_MSIX_PBA(s) \
-    ((s)->compat_flags & VMXNET3_COMPAT_FLAG_OLD_MSI_OFFSETS ? 0x800 : 0x1000)
+#define VMXNET3_OFF_MSIX_PBA   (0x1000)
 
 /* Link speed in Mbps should be shifted by 16 */
 #define VMXNET3_LINK_SPEED      (1000 << 16)
@@ -2122,8 +2116,8 @@ vmxnet3_init_msix(VMXNET3State *s)
                         &s->msix_bar,
                         VMXNET3_MSIX_BAR_IDX, VMXNET3_OFF_MSIX_TABLE,
                         &s->msix_bar,
-                        VMXNET3_MSIX_BAR_IDX, VMXNET3_OFF_MSIX_PBA(s),
-                        VMXNET3_MSIX_OFFSET(s), NULL);
+                        VMXNET3_MSIX_BAR_IDX, VMXNET3_OFF_MSIX_PBA,
+                        VMXNET3_MSIX_OFFSET, NULL);
 
     if (0 > res) {
         VMW_WRPRN("Failed to initialize MSI-X, error %d", res);
@@ -2221,7 +2215,7 @@ static void vmxnet3_pci_realize(PCIDevice *pci_dev, Error **errp)
     /* Interrupt pin A */
     pci_dev->config[PCI_INTERRUPT_PIN] = 0x01;
 
-    ret = msi_init(pci_dev, VMXNET3_MSI_OFFSET(s), VMXNET3_MAX_NMSIX_INTRS,
+    ret = msi_init(pci_dev, VMXNET3_MSI_OFFSET, VMXNET3_MAX_NMSIX_INTRS,
                    VMXNET3_USE_64BIT, VMXNET3_PER_VECTOR_MASK, NULL);
     /* Any error other than -ENOTSUP(board's MSI support is broken)
      * is a programming error. Fall back to INTx silently on -ENOTSUP */
@@ -2472,8 +2466,6 @@ static const VMStateDescription vmstate_vmxnet3 = {
 
 static const Property vmxnet3_properties[] = {
     DEFINE_NIC_PROPERTIES(VMXNET3State, conf),
-    DEFINE_PROP_BIT("x-old-msi-offsets", VMXNET3State, compat_flags,
-                    VMXNET3_COMPAT_FLAG_OLD_MSI_OFFSETS_BIT, false),
     DEFINE_PROP_BIT("x-disable-pcie", VMXNET3State, compat_flags,
                     VMXNET3_COMPAT_FLAG_DISABLE_PCIE_BIT, false),
 };
-- 
2.49.0


