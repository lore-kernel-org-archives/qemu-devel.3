Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4577BE9A03B
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 09:11:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsdYH-0006L6-UZ; Wed, 18 Feb 2026 04:08:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1vsdY7-0005fE-Nc
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 04:08:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1vsdY6-0002cH-6Q
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 04:08:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771405725;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4oWfw6035PII9Qeeij0fGVbqVCik1F331LNJe4fg0xE=;
 b=dT0R7RBc0hVDB7XjJ5a9nTJDGgF5CWuzpWR4xYc79vAxOij7aqGSeNpT2zik8MSdKjDMTO
 hmfJG7mjLqJ6zXMc2Ssy+8m95cvsr0HBusegLvKSXGn6Nx4VDWm1yPXSK8uFoO7u/4QnyH
 hVZU9iuayYQdgNiIh7tJIzzxDlLTarI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-215-kYpjngUENpq9P3HFruf7fg-1; Wed,
 18 Feb 2026 04:08:42 -0500
X-MC-Unique: kYpjngUENpq9P3HFruf7fg-1
X-Mimecast-MFC-AGG-ID: kYpjngUENpq9P3HFruf7fg_1771405721
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5219B1955BE0; Wed, 18 Feb 2026 09:08:41 +0000 (UTC)
Received: from dobby.home.kraxel.org (unknown [10.45.226.44])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DA67030001A5; Wed, 18 Feb 2026 09:08:40 +0000 (UTC)
Received: by dobby.home.kraxel.org (Postfix, from userid 1000)
 id 8162468B175; Wed, 18 Feb 2026 09:59:45 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@redhat.com, qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Kashyap Chamarthy <kchamart@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Andrea Bolognani <abologna@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PULL 2/2] docs/interop/firmware: Add 'uefi-vars' member for
 FirmwareMappingMemory
Date: Wed, 18 Feb 2026 09:59:45 +0100
Message-ID: <20260218085945.1050788-3-kraxel@redhat.com>
In-Reply-To: <20260218085945.1050788-1-kraxel@redhat.com>
References: <20260218085945.1050788-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.043,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Andrea Bolognani <abologna@redhat.com>

This allows describing firmwares that are loaded as ROMs but also
support a UEFI variable store. This is the case for edk2 builds
that are set up to use the uefi-vars QEMU device, and whose
descriptors would advertise the 'host-uefi-vars' feature.

Signed-off-by: Andrea Bolognani <abologna@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Acked-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20260217131553.313772-2-abologna@redhat.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 docs/interop/firmware.json | 43 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 42 insertions(+), 1 deletion(-)

diff --git a/docs/interop/firmware.json b/docs/interop/firmware.json
index da0362a2c0..3c71914a52 100644
--- a/docs/interop/firmware.json
+++ b/docs/interop/firmware.json
@@ -369,6 +369,39 @@
 { 'struct' : 'FirmwareMappingKernel',
   'data'   : { 'filename' : 'str' } }
 
+##
+# @FirmwareMemoryUefiVars:
+#
+# Contains information needed to set up the "uefi-vars" device
+# to provide UEFI variable store access to the firmware.
+#
+# @template: The path to the UEFI JSON variable store template
+#     compatible with the firmware.  Management software instantiates
+#     an individual copy -- a specific UEFI variable store file --
+#     from @template for each new virtual machine definition created.
+#     @template itself is never mapped into virtual machines, only
+#     individual copies of it are.  The file created by copying
+#     @template is used for persistently storing the non-volatile
+#     UEFI variables of a virtual machine definition.  The
+#     corresponding QEMU command line options are
+#
+#     ::
+#
+#         -device uefi-vars-x64,jsonfile=PATH_TO_PRIVATE_FILE
+#
+#     for x86_64 virtual machines, or
+#
+#     ::
+#
+#         -device uefi-vars-sysbus,jsonfile=PATH_TO_PRIVATE_FILE
+#
+#     for other UEFI architectures (aarch64, riscv64, loongarch64).
+#
+# Since: 11.0
+##
+{ 'struct' : 'FirmwareMemoryUefiVars',
+  'data'   : { 'template' : 'str' }}
+
 ##
 # @FirmwareMappingMemory:
 #
@@ -380,10 +413,18 @@
 #     definitions.  The corresponding QEMU command line option is
 #     "-bios @filename".
 #
+# @uefi-vars: Information specific to firmware builds that expect the
+#     "uefi-vars" device to be used to provide access to the UEFI
+#     variable store.  If the mapping contains this member, the
+#     firmware descriptor must advertise both the @uefi interface
+#     from @FirmwareOSInterface and the @host-uefi-vars feature from
+#     @FirmwareFeature.  (Since 11.0)
+#
 # Since: 3.0
 ##
 { 'struct' : 'FirmwareMappingMemory',
-  'data'   : { 'filename' : 'str' } }
+  'data'   : { 'filename' : 'str',
+               '*uefi-vars' : 'FirmwareMemoryUefiVars' } }
 
 ##
 # @FirmwareMappingIgvm:
-- 
2.53.0


