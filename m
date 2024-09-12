Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D986EED60F
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 14:45:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sol4F-0000Ud-6u; Thu, 12 Sep 2024 10:45:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1sol4C-0000Jd-4i
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 10:45:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1sol4A-0007RT-HH
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 10:45:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726152301;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=71UNforyMAADaO/AkBH1iXP7SY8+C4OzMXtsk5W1E6U=;
 b=MdArJnSbGibVvgvm1+8oR0ieFWg1knFmehxAfazB7so7ZxbhMZ13Kg/DaBgwMf+1L9qlKo
 nnqgcxO8ENdEkw9I15lJPGzvTLSaWThsMt6ouX6KEtn+3Sd45//ZoZRd6usIAPhLu+eUkK
 1R3hvPX01efT0Klc5SeJNhdXtq+XRSw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-28-bLGT_bRaPWCba4HDDl9ztg-1; Thu,
 12 Sep 2024 10:44:58 -0400
X-MC-Unique: bLGT_bRaPWCba4HDDl9ztg-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 42E1A1944AB1; Thu, 12 Sep 2024 14:44:57 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.45.224.195])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 861AB3000235; Thu, 12 Sep 2024 14:44:53 +0000 (UTC)
From: Albert Esteve <aesteve@redhat.com>
To: qemu-devel@nongnu.org
Cc: slp@redhat.com, hi@alyssa.is, mst@redhat.com, stefanha@redhat.com,
 Stefano Garzarella <sgarzare@redhat.com>, david@redhat.com,
 stevensd@chromium.org, jasowang@redhat.com,
 Albert Esteve <aesteve@redhat.com>
Subject: [PATCH 3/3] vhost_user.rst: Add GET_SHMEM_CONFIG message
Date: Thu, 12 Sep 2024 16:44:32 +0200
Message-ID: <20240912144432.126717-4-aesteve@redhat.com>
In-Reply-To: <20240912144432.126717-1-aesteve@redhat.com>
References: <20240912144432.126717-1-aesteve@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=aesteve@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Add GET_SHMEM_CONFIG vhost-user frontend
message to the spec documentation.

Signed-off-by: Albert Esteve <aesteve@redhat.com>
---
 docs/interop/vhost-user.rst | 39 +++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
index ec898d2440..fb7b27ce94 100644
--- a/docs/interop/vhost-user.rst
+++ b/docs/interop/vhost-user.rst
@@ -348,6 +348,19 @@ Device state transfer parameters
   In the future, additional phases might be added e.g. to allow
   iterative migration while the device is running.
 
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
+:mem size: 64-bit size of VIRTIO Shared Memory Region
+
 C structure
 -----------
 
@@ -372,6 +385,7 @@ In QEMU the vhost-user message is implemented with the following struct:
           VhostUserShared object;
           VhostUserTransferDeviceState transfer_state;
           VhostUserMMap mmap;
+          VhostUserShMemConfig shmem;
       };
   } QEMU_PACKED VhostUserMsg;
 
@@ -1054,6 +1068,7 @@ Protocol features
   #define VHOST_USER_PROTOCOL_F_XEN_MMAP             17
   #define VHOST_USER_PROTOCOL_F_SHARED_OBJECT        18
   #define VHOST_USER_PROTOCOL_F_DEVICE_STATE         19
+  #define VHOST_USER_PROTOCOL_F_SHMEM                20
 
 Front-end message types
 -----------------------
@@ -1728,6 +1743,30 @@ Front-end message types
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
+  to gather the VIRTIO Shared Memory Region configuration. Back-end will
+  respond with the number of VIRTIO Shared Memory Regions it requires, and
+  each shared memory region size in an array. The shared memory IDs are
+  represented by the index of the array. The information returned shall
+  comply with the following rules:
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
2.45.2


