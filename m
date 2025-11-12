Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81C02CD342D
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Nov 2025 17:27:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJEcN-00049R-6m; Wed, 12 Nov 2025 12:26:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1vJEcB-00043h-TZ
 for qemu-devel@nongnu.org; Wed, 12 Nov 2025 12:26:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1vJEcA-0008Us-8g
 for qemu-devel@nongnu.org; Wed, 12 Nov 2025 12:26:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762968397;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DxApWQxEapDWxzNO7n2j26/sZn4eBrSyKdxuZia6SQg=;
 b=PQHHBoqDGBJfxKN1HTLELfHBa9NwyLi03qxY9E8cofkNNXeSFzuN5IDQBI1Vs78JOL7KGz
 ymyf2fVWeWf+EvYKa9O3K5eq180HWlG6I1R6Y+C88I0be2ij5uNvJn04RRL47rbsZbBfiQ
 N2AC2WrPghKFtQ7haEYkDaE4pV6RVuo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-76-HJHgv0xnPsanzoax8lur4Q-1; Wed,
 12 Nov 2025 12:26:32 -0500
X-MC-Unique: HJHgv0xnPsanzoax8lur4Q-1
X-Mimecast-MFC-AGG-ID: HJHgv0xnPsanzoax8lur4Q_1762968390
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6121E180045C; Wed, 12 Nov 2025 17:26:30 +0000 (UTC)
Received: from gshan-thinkpadx1nanogen2.rmtau.csb (unknown [10.64.136.14])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D6D181955F1A; Wed, 12 Nov 2025 17:26:22 +0000 (UTC)
From: Gavin Shan <gshan@redhat.com>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, jonathan.cameron@huawei.com,
 mchehab+huawei@kernel.org, gengdongjiu1@gmail.com, mst@redhat.com,
 imammedo@redhat.com, armbru@redhat.com, anisinha@redhat.com,
 eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, zhao1.liu@intel.com, peter.maydell@linaro.org,
 pbonzini@redhat.com, shan.gavin@gmail.com
Subject: [PATCH v4 3/8] acpi/ghes: Increase GHES raw data maximal length to
 4KiB
Date: Thu, 13 Nov 2025 03:25:30 +1000
Message-ID: <20251112172535.403042-4-gshan@redhat.com>
In-Reply-To: <20251112172535.403042-1-gshan@redhat.com>
References: <20251112172535.403042-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The current GHES raw data maximal length isn't enough for 16 consecutive
CPER errors, which will be sent to a guest with 4KiB page size on a
erroneous 64KiB host page. Note those 16 CPER errors will be contained
in one single error block, meaning all CPER errors should be identical
in terms of type and severity and all of them should be delivered in
one shot.

Increase GHES raw data maximal length from 1KiB to 4KiB so that the
error block has enough storage space for 16 consecutive CPER errors.

Signed-off-by: Gavin Shan <gshan@redhat.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
---
 docs/specs/acpi_hest_ghes.rst  | 6 +++---
 hw/acpi/generic_event_device.c | 2 ++
 hw/core/machine.c              | 1 +
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/docs/specs/acpi_hest_ghes.rst b/docs/specs/acpi_hest_ghes.rst
index aaf7b1ad11..b3ecb5856c 100644
--- a/docs/specs/acpi_hest_ghes.rst
+++ b/docs/specs/acpi_hest_ghes.rst
@@ -68,9 +68,9 @@ Design Details
     and N Read Ack Register entries. The size for each entry is 8-byte.
     The Error Status Data Block table contains N Error Status Data Block
     entries. The size for each entry is defined at the source code as
-    ACPI_GHES_MAX_RAW_DATA_LENGTH (currently 1024 bytes). The total size
-    for the "etc/hardware_errors" fw_cfg blob is
-    (N * 8 * 2 + N * ACPI_GHES_MAX_RAW_DATA_LENGTH) bytes.
+    GHES_MAX_RAW_DATA_LENGTH, which is 4096 bytes in QEMU 10.2 or onwards,
+    but 1024 bytes in other cases. The total size of "etc/hardware_errors"
+    fw_cfg blob is (N * 8 * 2 + N * GHES_MAX_RAW_DATA_LENGTH) bytes.
     N is the number of the kinds of hardware error sources.
 
 (4) QEMU generates the ACPI linker/loader script for the firmware. The
diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_device.c
index e7b773d84d..30a5078878 100644
--- a/hw/acpi/generic_event_device.c
+++ b/hw/acpi/generic_event_device.c
@@ -364,6 +364,8 @@ static const Property acpi_ged_properties[] = {
                      TYPE_PCI_BUS, PCIBus *),
     DEFINE_PROP_BOOL("x-has-hest-addr", AcpiGedState,
                      ghes_state.use_hest_addr, true),
+    DEFINE_PROP_UINT32("x-error-block-size", AcpiGedState,
+                       ghes_state.error_block_size, 4096),
 };
 
 static const VMStateDescription vmstate_memhp_state = {
diff --git a/hw/core/machine.c b/hw/core/machine.c
index 06e0c9a179..539793b11b 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -40,6 +40,7 @@
 
 GlobalProperty hw_compat_10_1[] = {
     { TYPE_ACPI_GED, "x-has-hest-addr", "false" },
+    { TYPE_ACPI_GED, "x-error-block-size", "1024" },
     { TYPE_VIRTIO_NET, "host_tunnel", "off" },
     { TYPE_VIRTIO_NET, "host_tunnel_csum", "off" },
     { TYPE_VIRTIO_NET, "guest_tunnel", "off" },
-- 
2.51.1


