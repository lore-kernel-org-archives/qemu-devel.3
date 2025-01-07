Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6024E7719A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 15:34:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVBap-00034k-DP; Tue, 07 Jan 2025 10:34:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1tVBan-00034L-P2
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 10:34:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1tVBam-000524-CG
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 10:34:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736264041;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UVhloq3ti9EHIyiQV/uSapzfpupxQNhfhuCF+psO+Wc=;
 b=O5Mrc5rHYed7e+k3t5MIH67oIr5IXhFicBCuI4d1cUvg1Fs3/zLqW2999VfvqCXDs7FZfF
 28aChYVetJApCcY83Z3yi5p2PAgysh2toLQOghVP9zNFrpCJBCdYg9wKg0BCIYHimnos6D
 9BWnavu1xZ5uQ3xi6Z0EAu1LISw+EmU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-637-TR7RHDnjPZifxcD4rOp4IA-1; Tue,
 07 Jan 2025 10:33:59 -0500
X-MC-Unique: TR7RHDnjPZifxcD4rOp4IA-1
X-Mimecast-MFC-AGG-ID: TR7RHDnjPZifxcD4rOp4IA
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 929181955E9C; Tue,  7 Jan 2025 15:33:57 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.192.66])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AF7E5195606B; Tue,  7 Jan 2025 15:33:55 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 77425180039D; Tue, 07 Jan 2025 16:33:53 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, graf@amazon.com,
 Paolo Bonzini <pbonzini@redhat.com>, Michael Roth <michael.roth@amd.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org,
 Eric Blake <eblake@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Laszlo Ersek <lersek@redhat.com>
Subject: [PATCH v2 01/21] hw/uefi: add include/hw/uefi/var-service-api.h
Date: Tue,  7 Jan 2025 16:33:28 +0100
Message-ID: <20250107153353.1144978-2-kraxel@redhat.com>
In-Reply-To: <20250107153353.1144978-1-kraxel@redhat.com>
References: <20250107153353.1144978-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.437,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This file defines the register interface of the uefi-vars device.
It's only a handful of registers: magic value, command and status
registers, location and size of the communication buffer.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Laszlo Ersek <lersek@redhat.com>
---
 include/hw/uefi/var-service-api.h | 40 +++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)
 create mode 100644 include/hw/uefi/var-service-api.h

diff --git a/include/hw/uefi/var-service-api.h b/include/hw/uefi/var-service-api.h
new file mode 100644
index 000000000000..37fdab32741f
--- /dev/null
+++ b/include/hw/uefi/var-service-api.h
@@ -0,0 +1,40 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * uefi-vars device - API of the virtual device for guest/host communication.
+ */
+#ifndef QEMU_UEFI_VAR_SERVICE_API_H
+#define QEMU_UEFI_VAR_SERVICE_API_H
+
+
+/* isa: io range */
+#define UEFI_VARS_IO_BASE                   0x520
+
+/* sysbus: fdt node path */
+#define UEFI_VARS_FDT_NODE       "qemu-uefi-vars"
+#define UEFI_VARS_FDT_COMPAT     "qemu,uefi-vars"
+
+/* registers */
+#define UEFI_VARS_REG_MAGIC                  0x00  /* 16 bit */
+#define UEFI_VARS_REG_CMD_STS                0x02  /* 16 bit */
+#define UEFI_VARS_REG_BUFFER_SIZE            0x04  /* 32 bit */
+#define UEFI_VARS_REG_BUFFER_ADDR_LO         0x08  /* 32 bit */
+#define UEFI_VARS_REG_BUFFER_ADDR_HI         0x0c  /* 32 bit */
+#define UEFI_VARS_REGS_SIZE                  0x10
+
+/* magic value */
+#define UEFI_VARS_MAGIC_VALUE               0xef1
+
+/* command values */
+#define UEFI_VARS_CMD_RESET                  0x01
+#define UEFI_VARS_CMD_MM                     0x02
+
+/* status values */
+#define UEFI_VARS_STS_SUCCESS                0x00
+#define UEFI_VARS_STS_BUSY                   0x01
+#define UEFI_VARS_STS_ERR_UNKNOWN            0x10
+#define UEFI_VARS_STS_ERR_NOT_SUPPORTED      0x11
+#define UEFI_VARS_STS_ERR_BAD_BUFFER_SIZE    0x12
+
+
+#endif /* QEMU_UEFI_VAR_SERVICE_API_H */
-- 
2.47.1


