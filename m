Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D5A2CF9C71
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2024 10:04:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1st2Oc-0002HJ-S2; Tue, 24 Sep 2024 06:03:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1st2OW-0002Aa-Kp
 for qemu-devel@nongnu.org; Tue, 24 Sep 2024 06:03:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1st2OV-00030i-2v
 for qemu-devel@nongnu.org; Tue, 24 Sep 2024 06:03:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727172221;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D1STNGPq0B9RzmxMdXu0CSiyhrg4LP4kJr3GlwMbmuc=;
 b=HSC3iJOZt3/dRlNHN86dqdYs3ZaGL0bqQzkc8le3Bk9eP8WZLiwfmsxU2CGxHq3oF+oLGG
 aTxLdkqu6HtY+MJKpbU6V96mO4kdKvywJKqhry1ANxqhOQZDskH6AWk/HcZhXaOC7HyVaw
 cOGn0PzNeQZgQmEpvtlV29GIQnIgNB8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-695-tZVujWhMMQqn4jTCnyL1Ig-1; Tue,
 24 Sep 2024 06:03:38 -0400
X-MC-Unique: tZVujWhMMQqn4jTCnyL1Ig-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (unknown
 [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A984418FFA53; Tue, 24 Sep 2024 10:03:37 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.22.16.106])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 80A491956048; Tue, 24 Sep 2024 10:03:33 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 David Hildenbrand <david@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [PULL 1/6] virtio: kconfig: memory devices are PCI only
Date: Tue, 24 Sep 2024 12:03:24 +0200
Message-ID: <20240924100329.248738-2-david@redhat.com>
In-Reply-To: <20240924100329.248738-1-david@redhat.com>
References: <20240924100329.248738-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Paolo Bonzini <pbonzini@redhat.com>

Virtio memory devices rely on PCI BARs to expose the contents of memory.
Because of this they cannot be used (yet) with virtio-mmio or virtio-ccw.
In fact the code that is common to virtio-mem and virtio-pmem, which
is in hw/virtio/virtio-md-pci.c, is only included if CONFIG_VIRTIO_PCI
is set.  Reproduce the same condition in the Kconfig file, only allowing
VIRTIO_MEM and VIRTIO_PMEM to be defined if the transport supports it.

Without this patch it is possible to create a configuration with
CONFIG_VIRTIO_PCI=n and CONFIG_VIRTIO_MEM=y, but that causes a
linking failure.

Message-ID: <20240906101658.514470-1-pbonzini@redhat.com>
Reported-by: Michael Tokarev <mjt@tls.msk.ru>
Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/virtio/Kconfig | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/hw/virtio/Kconfig b/hw/virtio/Kconfig
index aa63ff7fd4..0afec2ae92 100644
--- a/hw/virtio/Kconfig
+++ b/hw/virtio/Kconfig
@@ -16,6 +16,7 @@ config VIRTIO_PCI
     default y if PCI_DEVICES
     depends on PCI
     select VIRTIO
+    select VIRTIO_MD_SUPPORTED
 
 config VIRTIO_MMIO
     bool
@@ -35,10 +36,17 @@ config VIRTIO_CRYPTO
     default y
     depends on VIRTIO
 
+# not all virtio transports support memory devices; if none does,
+# no need to include the code
+config VIRTIO_MD_SUPPORTED
+    bool
+
 config VIRTIO_MD
     bool
+    depends on VIRTIO_MD_SUPPORTED
     select MEM_DEVICE
 
+# selected by the board if it has the required support code
 config VIRTIO_PMEM_SUPPORTED
     bool
 
@@ -46,9 +54,11 @@ config VIRTIO_PMEM
     bool
     default y
     depends on VIRTIO
+    depends on VIRTIO_MD_SUPPORTED
     depends on VIRTIO_PMEM_SUPPORTED
     select VIRTIO_MD
 
+# selected by the board if it has the required support code
 config VIRTIO_MEM_SUPPORTED
     bool
 
@@ -57,6 +67,7 @@ config VIRTIO_MEM
     default y
     depends on VIRTIO
     depends on LINUX
+    depends on VIRTIO_MD_SUPPORTED
     depends on VIRTIO_MEM_SUPPORTED
     select VIRTIO_MD
 
-- 
2.46.1


