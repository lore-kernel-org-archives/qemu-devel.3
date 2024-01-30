Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CD9AC46CD2
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 21:52:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUw1w-0002fk-7d; Tue, 30 Jan 2024 16:52:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rUw1o-0002W4-1l
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 16:52:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rUw1m-0005rv-I5
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 16:52:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706651541;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sY5gJ4RqzuSGN30tSkomCOHdnKgc43QiUnfx499MYH4=;
 b=iF0PG0so/efmDZu20wX7bzDMXlFJ5oUoY+6gigorTpO08p7Wi00ifIw0geyoU0/OmAVHaD
 3KKPMlGOKvQt708R+o3s+Cu8NvGUK6rPYsOX4pqR7czy5K6LSeS76F69Iebvi0IFZXH0P3
 8l7qwZCqzJPhZ2gqsRGvZg5DrpXO2pc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-209-xoBaqtMtOeyhV5iK2V20kg-1; Tue, 30 Jan 2024 16:52:16 -0500
X-MC-Unique: xoBaqtMtOeyhV5iK2V20kg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F076688CDCB;
 Tue, 30 Jan 2024 21:51:46 +0000 (UTC)
Received: from localhost (unknown [10.39.192.65])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5CCA2492BE5;
 Tue, 30 Jan 2024 21:51:46 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aarushi Mehta <mehta.aaru20@gmail.com>, Fam Zheng <fam@euphon.net>,
 Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 qemu-block@nongnu.org, Julia Suvorova <jusual@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>, Hanna Reitz <hreitz@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PULL 4/5] hw/core/qdev.c: add qdev_get_human_name()
Date: Tue, 30 Jan 2024 16:51:33 -0500
Message-ID: <20240130215134.346557-5-stefanha@redhat.com>
In-Reply-To: <20240130215134.346557-1-stefanha@redhat.com>
References: <20240130215134.346557-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.292,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

Add a simple method to return some kind of human readable identifier for
use in error messages.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Message-id: 8b566bfced98ae44be1fcc1f8e7215f0c3393aa1.1706598705.git.manos.pitsidianakis@linaro.org
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 include/hw/qdev-core.h | 14 ++++++++++++++
 hw/core/qdev.c         |  8 ++++++++
 2 files changed, 22 insertions(+)

diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index 151d968238..66338f479f 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -993,6 +993,20 @@ const char *qdev_fw_name(DeviceState *dev);
 void qdev_assert_realized_properly(void);
 Object *qdev_get_machine(void);
 
+/**
+ * qdev_get_human_name() - Return a human-readable name for a device
+ * @dev: The device. Must be a valid and non-NULL pointer.
+ *
+ * .. note::
+ *    This function is intended for user friendly error messages.
+ *
+ * Returns: A newly allocated string containing the device id if not null,
+ * else the object canonical path.
+ *
+ * Use g_free() to free it.
+ */
+char *qdev_get_human_name(DeviceState *dev);
+
 /* FIXME: make this a link<> */
 bool qdev_set_parent_bus(DeviceState *dev, BusState *bus, Error **errp);
 
diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 43d863b0c5..c68d0f7c51 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -879,6 +879,14 @@ Object *qdev_get_machine(void)
     return dev;
 }
 
+char *qdev_get_human_name(DeviceState *dev)
+{
+    g_assert(dev != NULL);
+
+    return dev->id ?
+           g_strdup(dev->id) : object_get_canonical_path(OBJECT(dev));
+}
+
 static MachineInitPhase machine_phase;
 
 bool phase_check(MachineInitPhase phase)
-- 
2.43.0


