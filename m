Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3AD4EF9011
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 16:53:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxpT5-0001cr-Ce; Wed, 04 Mar 2026 11:53:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1vxpT2-0001Pp-EP
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 11:53:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1vxpT0-0002f6-W0
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 11:53:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772643178;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hon6YFACQydjiVC2MLBH4P+JHfOzlsYj8EtkcwJKskg=;
 b=aWhJQMRZ+N3RHvO7YKnbgQ0GLbA66laszmJy5kD0oVB064XL/VhFhtNlIYcQhl/jIlL4E/
 iGy3/EFUAIlxflSE8xfY/fnkNhhXHypvnFJ7rGJJbf8sGJJ7v+gzEDr3u1YBIdHD+O5qpw
 bhB53Int8610lnYGO/V09l21zM8EKus=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-414-_fb43jOkPLGvfB81hvDKPg-1; Wed,
 04 Mar 2026 11:52:55 -0500
X-MC-Unique: _fb43jOkPLGvfB81hvDKPg-1
X-Mimecast-MFC-AGG-ID: _fb43jOkPLGvfB81hvDKPg_1772643173
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 759501956059; Wed,  4 Mar 2026 16:52:53 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.32.26])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EDE251800361; Wed,  4 Mar 2026 16:52:46 +0000 (UTC)
From: Albert Esteve <aesteve@redhat.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, Stefano Garzarella <sgarzare@redhat.com>,
 manos.pitsidianakis@linaro.org, slp@redhat.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 stefanha@redhat.com, stevensd@chromium.org,
 Laurent Vivier <lvivier@redhat.com>, jasowang@redhat.com,
 Peter Xu <peterx@redhat.com>, hi@alyssa.is,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, dbassey@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v14 3/7] vhost_user.rst: Add SHMEM_MAP/_UNMAP to spec
Date: Wed,  4 Mar 2026 17:52:19 +0100
Message-ID: <20260304165223.2166175-4-aesteve@redhat.com>
In-Reply-To: <20260304165223.2166175-1-aesteve@redhat.com>
References: <20260304165223.2166175-1-aesteve@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=aesteve@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 33
X-Spam_score: 3.3
X-Spam_bar: +++
X-Spam_report: (3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.703,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=1.386, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Add SHMEM_MAP/_UNMAP request to the vhost-user
spec documentation.

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Reviewed-by: Alyssa Ross <hi@alyssa.is>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Albert Esteve <aesteve@redhat.com>
---
 docs/interop/vhost-user.rst | 61 +++++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
index 4c1538cf88..08a5e43988 100644
--- a/docs/interop/vhost-user.rst
+++ b/docs/interop/vhost-user.rst
@@ -350,6 +350,27 @@ Device state transfer parameters
   In the future, additional phases might be added e.g. to allow
   iterative migration while the device is running.
 
+MMAP request
+^^^^^^^^^^^^
+
++-------+---------+-----------+------------+-----+-------+
+| shmid | padding | fd_offset | shm_offset | len | flags |
++-------+---------+-----------+------------+-----+-------+
+
+:shmid: a 8-bit shared memory region identifier
+
+:fd_offset: a 64-bit offset of this area from the start
+            of the supplied file descriptor
+
+:shm_offset: a 64-bit offset from the start of the
+             pointed shared memory region
+
+:len: a 64-bit size of the memory to map
+
+:flags: a 64-bit value:
+  - 0: Pages are mapped read-only
+  - 1: Pages are mapped read-write
+
 C structure
 -----------
 
@@ -375,6 +396,7 @@ In QEMU the vhost-user message is implemented with the following struct:
           VhostUserInflight inflight;
           VhostUserShared object;
           VhostUserTransferDeviceState transfer_state;
+          VhostUserMMap mmap;
       };
   } QEMU_PACKED VhostUserMsg;
 
@@ -1067,6 +1089,7 @@ Protocol features
   #define VHOST_USER_PROTOCOL_F_SHARED_OBJECT           18
   #define VHOST_USER_PROTOCOL_F_DEVICE_STATE            19
   #define VHOST_USER_PROTOCOL_F_GET_VRING_BASE_INFLIGHT 20
+  #define VHOST_USER_PROTOCOL_F_SHMEM_MAP               21
 
 Front-end message types
 -----------------------
@@ -1888,6 +1911,44 @@ is sent by the front-end.
   when the operation is successful, or non-zero otherwise. Note that if the
   operation fails, no fd is sent to the backend.
 
+``VHOST_USER_BACKEND_SHMEM_MAP``
+  :id: 9
+  :equivalent ioctl: N/A
+  :request payload: fd and ``struct VhostUserMMap``
+  :reply payload: N/A
+
+  When the ``VHOST_USER_PROTOCOL_F_SHMEM`` protocol feature has been
+  successfully negotiated, this message can be submitted by the backends to
+  advertise a new mapping to be made in a given VIRTIO Shared Memory Region.
+  Upon receiving the message, the front-end will mmap the given fd into the
+  VIRTIO Shared Memory Region with the requested ``shmid``.
+  If ``VHOST_USER_PROTOCOL_F_REPLY_ACK`` is negotiated, and
+  back-end set the ``VHOST_USER_NEED_REPLY`` flag, the front-end
+  must respond with zero when operation is successfully completed,
+  or non-zero otherwise.
+
+  Mapping over an already existing map is not allowed and requests shall fail.
+  Therefore, the memory range in the request must correspond with a valid,
+  free region of the VIRTIO Shared Memory Region. Also, note that mappings
+  consume resources and that the request can fail when there are no resources
+  available. Lastly, mappings are automatically unmapped by the front-end
+  across device reset operation.
+
+``VHOST_USER_BACKEND_SHMEM_UNMAP``
+  :id: 10
+  :equivalent ioctl: N/A
+  :request payload: ``struct VhostUserMMap``
+  :reply payload: N/A
+
+  When the ``VHOST_USER_PROTOCOL_F_SHMEM`` protocol feature has been
+  successfully negotiated, this message can be submitted by the backends so
+  that the front-end un-mmaps a given range (``shm_offset``, ``len``) in the
+  VIRTIO Shared Memory Region with the requested ``shmid``. Note that the
+  given range shall correspond to the entirety of a valid mapped region.
+  If ``VHOST_USER_PROTOCOL_F_REPLY_ACK`` is negotiated, and the back-end
+  sets the ``VHOST_USER_NEED_REPLY`` flag, the front-end must respond with
+  zero when operation is successfully completed, or non-zero otherwise.
+
 .. _reply_ack:
 
 VHOST_USER_PROTOCOL_F_REPLY_ACK
-- 
2.52.0


