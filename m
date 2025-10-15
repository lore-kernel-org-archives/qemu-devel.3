Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35E77CCD193
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 09:02:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8xN4-0003cT-9W; Wed, 15 Oct 2025 05:00:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1v8xN1-0003bu-8o
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 05:00:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1v8xMv-0005Bw-QY
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 05:00:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760518821;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4hVX23j1qg89GM2XTJ2f9M0XbvXysR1u9GM3HK6Mb+g=;
 b=HfLwTAUBUT3euDnDHuYuGWFspq7wc7soqqwZv4wteiLZ9aRNGLB5QbaBWNohWmwhSjwGY3
 qibQn/fd2bxtaieC+OQUUSiOjLC1k1Pc+nkGvO8JfjH0N/xBUBNX6R1ZiCoIgcwv2tPdo6
 DDVuMK+sY8wApTN7Xz6G7O+NqDYxm84=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-324-IbO7UJtNNC2CNuQ4qyaEwA-1; Wed,
 15 Oct 2025 05:00:18 -0400
X-MC-Unique: IbO7UJtNNC2CNuQ4qyaEwA-1
X-Mimecast-MFC-AGG-ID: IbO7UJtNNC2CNuQ4qyaEwA_1760518817
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EE2581956052; Wed, 15 Oct 2025 09:00:16 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.44.32.123])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4A19B1800353; Wed, 15 Oct 2025 09:00:10 +0000 (UTC)
From: Albert Esteve <aesteve@redhat.com>
To: qemu-devel@nongnu.org
Cc: stevensd@chromium.org, jasowang@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>, hi@alyssa.is,
 Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, david@redhat.com,
 manos.pitsidianakis@linaro.org, Fabiano Rosas <farosas@suse.de>,
 "Michael S. Tsirkin" <mst@redhat.com>, stefanha@redhat.com,
 Stefano Garzarella <sgarzare@redhat.com>, slp@redhat.com,
 dbassey@redhat.com, Albert Esteve <aesteve@redhat.com>
Subject: [PATCH v9 5/7] vhost_user.rst: Add GET_SHMEM_CONFIG message
Date: Wed, 15 Oct 2025 10:59:28 +0200
Message-ID: <20251015085930.1517330-6-aesteve@redhat.com>
In-Reply-To: <20251015085930.1517330-1-aesteve@redhat.com>
References: <20251015085930.1517330-1-aesteve@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=aesteve@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add GET_SHMEM_CONFIG vhost-user frontend
message to the spec documentation.

Reviewed-by: Alyssa Ross <hi@alyssa.is>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Albert Esteve <aesteve@redhat.com>
---
 docs/interop/vhost-user.rst | 39 +++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
index dab9f3af42..54d64ae75f 100644
--- a/docs/interop/vhost-user.rst
+++ b/docs/interop/vhost-user.rst
@@ -371,6 +371,20 @@ MMAP request
   - 0: Pages are mapped read-only
   - 1: Pages are mapped read-write
 
+VIRTIO Shared Memory Region configuration
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
++-------------+---------+------------+----+--------------+
+| num regions | padding | mem size 0 | .. | mem size 255 |
++-------------+---------+------------+----+--------------+
+
+:num regions: a 32-bit number of regions
+
+:padding: 32-bit
+
+:mem size: contains ``num regions`` 64-bit fields representing the size of each
+           VIRTIO Shared Memory Region
+
 C structure
 -----------
 
@@ -397,6 +411,7 @@ In QEMU the vhost-user message is implemented with the following struct:
           VhostUserShared object;
           VhostUserTransferDeviceState transfer_state;
           VhostUserMMap mmap;
+          VhostUserShMemConfig shmem;
       };
   } QEMU_PACKED VhostUserMsg;
 
@@ -1754,6 +1769,30 @@ Front-end message types
   Using this function requires prior negotiation of the
   ``VHOST_USER_PROTOCOL_F_DEVICE_STATE`` feature.
 
+``VHOST_USER_GET_SHMEM_CONFIG``
+  :id: 44
+  :equivalent ioctl: N/A
+  :request payload: N/A
+  :reply payload: ``struct VhostUserShMemConfig``
+
+  When the ``VHOST_USER_PROTOCOL_F_SHMEM`` protocol feature has been
+  successfully negotiated, this message can be submitted by the front-end
+  to gather the VIRTIO Shared Memory Region configuration. The back-end will
+  respond with the number of VIRTIO Shared Memory Regions it requires, and
+  each shared memory region size in an array. The shared memory IDs are
+  represented by the array index. The information returned shall comply
+  with the following rules:
+
+  * The shared information will remain valid and unchanged for the entire
+    lifetime of the connection.
+
+  * The Shared Memory Region size must be a multiple of the page size
+    supported by mmap(2).
+
+  * The size may be 0 if the region is unused. This can happen when the
+    device does not support an optional feature but does support a feature
+    that uses a higher shmid.
+
 Back-end message types
 ----------------------
 
-- 
2.49.0


