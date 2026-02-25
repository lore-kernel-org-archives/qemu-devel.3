Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F12F3EFD214
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 09:21:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvB4w-0000Lq-7R; Wed, 25 Feb 2026 04:21:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vvB4u-0000LN-NE
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 04:21:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vvB4t-0003SR-6D
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 04:21:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772011266;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=atUyOXq/ndB56PYRrYWogkTmutwY7ae7cotwzCQtdys=;
 b=QEBt4uNUeveKSO6TZU6xVO1Y+sGfDLqhBpEQE01/+fEAtC+iEKBifcDOJwLoVLXq2x2M9u
 HwUC2jZc8udB2UBH7s/danxuKbJhM7aNwweT88FAYvlp/7hUooovLYaoXAHfpHJyaQMC/6
 eCeXWCfjbNLGfto8kpEanEc8C30xOyE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-516-PAfmYGCFNGuFk1yb9_DGEQ-1; Wed,
 25 Feb 2026 04:21:02 -0500
X-MC-Unique: PAfmYGCFNGuFk1yb9_DGEQ-1
X-Mimecast-MFC-AGG-ID: PAfmYGCFNGuFk1yb9_DGEQ_1772011260
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6B3C01956094; Wed, 25 Feb 2026 09:21:00 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.158])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4113019560B6; Wed, 25 Feb 2026 09:20:54 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Eduardo Habkost <eduardo@habkost.net>, Yanan Wang <wangyanan55@huawei.com>,
 Zhao Liu <zhao1.liu@intel.com>, Jason Wang <jasowang@redhat.com>,
 Yi Liu <yi.l.liu@intel.com>,
 =?UTF-8?q?Cl=C3=A9ment=20Mathieu--Drif?= <clement.mathieu--drif@eviden.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH v2 04/16] hw/core/machine: Remove hw_compat_2_8[] array
Date: Wed, 25 Feb 2026 10:20:12 +0100
Message-ID: <20260225092024.794595-5-thuth@redhat.com>
In-Reply-To: <20260225092024.794595-1-thuth@redhat.com>
References: <20260225092024.794595-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.358, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.659,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

The hw_compat_2_8[] array was only used by the pc-q35-2.8 and
pc-i440fx-2.8 machines, which got removed. Remove it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20250501210456.89071-6-philmd@linaro.org>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 include/hw/core/boards.h |  3 ---
 hw/core/machine.c        | 14 --------------
 2 files changed, 17 deletions(-)

diff --git a/include/hw/core/boards.h b/include/hw/core/boards.h
index edbe8d03e56..71d6b234f68 100644
--- a/include/hw/core/boards.h
+++ b/include/hw/core/boards.h
@@ -880,7 +880,4 @@ extern const size_t hw_compat_2_10_len;
 extern GlobalProperty hw_compat_2_9[];
 extern const size_t hw_compat_2_9_len;
 
-extern GlobalProperty hw_compat_2_8[];
-extern const size_t hw_compat_2_8_len;
-
 #endif
diff --git a/hw/core/machine.c b/hw/core/machine.c
index d4ef620c178..848d0dc83d7 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -272,20 +272,6 @@ GlobalProperty hw_compat_2_9[] = {
 };
 const size_t hw_compat_2_9_len = G_N_ELEMENTS(hw_compat_2_9);
 
-GlobalProperty hw_compat_2_8[] = {
-    { "fw_cfg_mem", "x-file-slots", "0x10" },
-    { "fw_cfg_io", "x-file-slots", "0x10" },
-    { "pflash_cfi01", "old-multiple-chip-handling", "on" },
-    { "pci-bridge", "shpc", "on" },
-    { TYPE_PCI_DEVICE, "x-pcie-extcap-init", "off" },
-    { "virtio-pci", "x-pcie-deverr-init", "off" },
-    { "virtio-pci", "x-pcie-lnkctl-init", "off" },
-    { "virtio-pci", "x-pcie-pm-init", "off" },
-    { "cirrus-vga", "vgamem_mb", "8" },
-    { "isa-cirrus-vga", "vgamem_mb", "8" },
-};
-const size_t hw_compat_2_8_len = G_N_ELEMENTS(hw_compat_2_8);
-
 MachineState *current_machine;
 
 static char *machine_get_kernel(Object *obj, Error **errp)
-- 
2.53.0


