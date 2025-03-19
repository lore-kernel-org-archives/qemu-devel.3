Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9592BC35FFA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 14:16:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuuAm-0002UQ-W9; Wed, 19 Mar 2025 10:13:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1tuuA9-0001hN-8B
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 10:12:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1tuu9y-0006l2-V2
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 10:12:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742393539;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QzhP9OAVsP3Z1Y7/Rdm8Ho3H/XRS32EXq7epwFlF2GU=;
 b=FL3ulDEwqNuWa17L7SAUb/gwx2AqS/0BS9SH3li/sUJWZGajRX9kmuQpcuRCeCktzjRoCS
 fcc5k+vCjmQhRMuBYdh6H+KKAztyERlXlFltpgpvkd8nVGmVSePu0ER4gkUC//QWVKFrIO
 Am/PpmlOsii9O7yOMwg3LHZXY0deRXg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-577-xbrANIUVNiOUHHec3K9q4Q-1; Wed,
 19 Mar 2025 10:12:15 -0400
X-MC-Unique: xbrANIUVNiOUHHec3K9q4Q-1
X-Mimecast-MFC-AGG-ID: xbrANIUVNiOUHHec3K9q4Q_1742393534
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 37F07180AF57; Wed, 19 Mar 2025 14:12:14 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.45.224.38])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 85C511955BEE; Wed, 19 Mar 2025 14:12:13 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 94A8618003B9; Wed, 19 Mar 2025 15:11:59 +0100 (CET)
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
Subject: [PATCH v3 6/6] docs/firmware: add feature flag for host uefi variable
 store
Date: Wed, 19 Mar 2025 15:11:58 +0100
Message-ID: <20250319141159.1461621-7-kraxel@redhat.com>
In-Reply-To: <20250319141159.1461621-1-kraxel@redhat.com>
References: <20250319141159.1461621-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.337,
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

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 docs/interop/firmware.json | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/docs/interop/firmware.json b/docs/interop/firmware.json
index 57f55f6c5455..745d21d82232 100644
--- a/docs/interop/firmware.json
+++ b/docs/interop/firmware.json
@@ -214,13 +214,23 @@
 #                  PL011 UART. @verbose-static is mutually exclusive
 #                  with @verbose-dynamic.
 #
+# @host-uefi-vars: The firmware expects the host to provide an uefi
+#                  variable store.  qemu supports that via
+#                  "uefi-vars-sysbus" (aarch64, riscv64, loongarch64)
+#                  or "uefi-vars-x64" (x86_64) devices.  The firmware
+#                  will not use flash for nvram.  When loading the
+#                  firmware into flash the 'stateless' setup should be
+#                  used.  It is recommened to load the firmware into
+#                  memory though.
+#
 # Since: 3.0
 ##
 { 'enum' : 'FirmwareFeature',
   'data' : [ 'acpi-s3', 'acpi-s4',
              'amd-sev', 'amd-sev-es', 'amd-sev-snp',
              'intel-tdx',
-             'enrolled-keys', 'requires-smm', 'secure-boot',
+             'enrolled-keys', 'requires-smm',
+             'secure-boot', 'host-uefi-vars',
              'verbose-dynamic', 'verbose-static' ] }
 
 ##
-- 
2.48.1


