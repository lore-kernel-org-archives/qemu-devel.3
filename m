Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34041C35FFA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 14:13:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuuAX-000239-C8; Wed, 19 Mar 2025 10:13:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1tuuA9-0001hM-7g
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 10:12:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1tuuA0-0006ki-IM
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 10:12:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742393537;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+OMMrBdJVZeaiydw5/kpxjoxLOQi34o3C5q8EbZWnAY=;
 b=em8EmYqcjWFm5qSZkzfaF4gK3fDIiT+H2HAzXCb4fZT9hn6+KgWY6dV8dgKzm4CjoNBT/y
 JMTcaI1494Ynk7aAtphVFeothDnpzP0rbEk1SVuygnjwt/Fd1X9QAOH66zcnafeAqxKdf4
 QpQWqOMZOCVfT9O+bbv5ZemKFzmTwzQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-294-l-wgJGBVNk6ssKXS3QIZMQ-1; Wed,
 19 Mar 2025 10:12:12 -0400
X-MC-Unique: l-wgJGBVNk6ssKXS3QIZMQ-1
X-Mimecast-MFC-AGG-ID: l-wgJGBVNk6ssKXS3QIZMQ_1742393531
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DBF331801A00; Wed, 19 Mar 2025 14:12:10 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.45.224.38])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4A9DF1956094; Wed, 19 Mar 2025 14:12:10 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 7FE1B18003B7; Wed, 19 Mar 2025 15:11:59 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: Bibo Mao <maobibo@loongson.cn>, Kashyap Chamarthy <kchamart@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Song Gao <gaosong@loongson.cn>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-riscv@nongnu.org, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Weiwei Li <liwei1518@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH v3 5/6] hw/uefi-vars-sysbus: allow for loongarch virt
Date: Wed, 19 Mar 2025 15:11:57 +0100
Message-ID: <20250319141159.1461621-6-kraxel@redhat.com>
In-Reply-To: <20250319141159.1461621-1-kraxel@redhat.com>
References: <20250319141159.1461621-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.337,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

Allow the device being added to loongarch virt VMs.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/loongarch/virt.c | 2 ++
 hw/uefi/Kconfig     | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index a5840ff96857..b6f5f6a3b546 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -38,6 +38,7 @@
 #include "hw/mem/nvdimm.h"
 #include "hw/platform-bus.h"
 #include "hw/display/ramfb.h"
+#include "hw/uefi/var-service-api.h"
 #include "hw/mem/pc-dimm.h"
 #include "system/tpm.h"
 #include "system/block-backend.h"
@@ -1207,6 +1208,7 @@ static void virt_class_init(ObjectClass *oc, void *data)
     object_class_property_set_description(oc, "v-eiointc",
                             "Enable Virt Extend I/O Interrupt Controller.");
     machine_class_allow_dynamic_sysbus_dev(mc, TYPE_RAMFB_DEVICE);
+    machine_class_allow_dynamic_sysbus_dev(mc, TYPE_UEFI_VARS_SYSBUS);
 #ifdef CONFIG_TPM
     machine_class_allow_dynamic_sysbus_dev(mc, TYPE_TPM_TIS_SYSBUS);
 #endif
diff --git a/hw/uefi/Kconfig b/hw/uefi/Kconfig
index f139008b632b..b55529fca137 100644
--- a/hw/uefi/Kconfig
+++ b/hw/uefi/Kconfig
@@ -1,3 +1,3 @@
 config UEFI_VARS
 	bool
-        default y if X86_64 || AARCH64 || RISCV64
+        default y if X86_64 || AARCH64 || RISCV64 || LOONGARCH64
\ No newline at end of file
-- 
2.48.1


