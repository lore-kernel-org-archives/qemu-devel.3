Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F9CFF46445
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2026 10:42:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w25O0-0006Mn-Si; Mon, 16 Mar 2026 06:41:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1w25Nr-0006LR-TW
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 06:41:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1w25Nq-0003WK-4P
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 06:41:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773657673;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cnFEtZSi+7ySBBZ42VpMXR2gben3kTwPtzkp9CIZ83Q=;
 b=R83YN39Yq3PSHm9e5nQ2PYXTGuCPkX43uLfkaNjUr6IzsJTM6N3ATCtXTS0L6KgmSeD6iW
 Lh0ewHL/EfmK85OTw3T2Tpi2til2/xKPleUmSNStiHuh7S4IxAdVgMfhKBplc4V0aJbGyZ
 0HDyAe+zQob3GOfIrvZT8r+Ui/4rV9w=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-318-I9QQc5ymM-SZeTNbvgP-1Q-1; Mon,
 16 Mar 2026 06:41:12 -0400
X-MC-Unique: I9QQc5ymM-SZeTNbvgP-1Q-1
X-Mimecast-MFC-AGG-ID: I9QQc5ymM-SZeTNbvgP-1Q_1773657671
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7B6A1195609E; Mon, 16 Mar 2026 10:41:11 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.33.101])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B62CC19560AB; Mon, 16 Mar 2026 10:41:09 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Alistair Francis <alistair.francis@wdc.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PULL 09/14] hw/acpi: generic_event_device: Don't call
 qdev_get_machine in initfn
Date: Mon, 16 Mar 2026 11:40:34 +0100
Message-ID: <20260316104039.195960-10-thuth@redhat.com>
In-Reply-To: <20260316104039.195960-1-thuth@redhat.com>
References: <20260316104039.195960-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
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

From: Alistair Francis <alistair.francis@wdc.com>

Calling qdev_get_machine() in the acpi_ged_initfn function would result
in the following assert

    ../hw/core/qdev.c:858: qdev_get_machine: Assertion `dev' failed.

when trying to run

    ./qemu-system-aarch64 -S -display none -M virt -device acpi-ged,help

as the machine wasn't created yet. We call qdev_get_machine() to obtain
the ram slots of the machine. So instead of initialising the GED in
the init let's instead do it in the realise where the machine
will exist.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Tested-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20260312043158.4191378-8-alistair.francis@wdc.com>
[thuth: Replaced soc_init with acpi_ged_initfn in the patch description]
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/acpi/generic_event_device.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_device.c
index 30dab43a00c..9e9416d4067 100644
--- a/hw/acpi/generic_event_device.c
+++ b/hw/acpi/generic_event_device.c
@@ -506,6 +506,9 @@ static void acpi_ged_realize(DeviceState *dev, Error **errp)
     uint32_t ged_events;
     int i;
 
+    acpi_memory_hotplug_init(&s->container_memhp, OBJECT(dev),
+                             &s->memhp_state, 0);
+
     if (pcihp_state->use_acpi_hotplug_bridge) {
         s->ged_event_bitmap |= ACPI_GED_PCI_HOTPLUG_EVT;
     }
@@ -568,8 +571,6 @@ static void acpi_ged_initfn(Object *obj)
     memory_region_init(&s->container_memhp, OBJECT(dev), "memhp container",
                        MEMORY_HOTPLUG_IO_LEN);
     sysbus_init_mmio(sbd, &s->container_memhp);
-    acpi_memory_hotplug_init(&s->container_memhp, OBJECT(dev),
-                             &s->memhp_state, 0);
 
     memory_region_init_io(&ged_st->regs, obj, &ged_regs_ops, ged_st,
                           TYPE_ACPI_GED "-regs", ACPI_GED_REG_COUNT);
-- 
2.53.0


