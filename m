Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BE8DC021AA
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 16:43:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tk4CN-0004ed-Ip; Mon, 17 Feb 2025 11:42:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1tk4CI-0004cB-VW
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 11:42:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1tk4CG-0007z9-3r
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 11:42:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739810535;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rrOHEASD5ETftMjnPAsJydFA8UyEJ3azffjK7xeCoRc=;
 b=CH2Z1DMfPwMUgMpbnoUTHU0NjABD2fOR6NnI7fZfqRqv7jD1xqrUgZbmlBUZ/5YxyNFFDF
 k/TuogsPG97Nv1UFLgYYDe1DeEENkzByRgHnAko+5pkwVOyITpZl+tsiMS5OC7YDjdUzBM
 DfkZnsF9JQXXYuJne6FR2fZ7QVIA09M=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-679-Ghl4AiDdM6Wz8Gl_v4r54Q-1; Mon,
 17 Feb 2025 11:41:07 -0500
X-MC-Unique: Ghl4AiDdM6Wz8Gl_v4r54Q-1
X-Mimecast-MFC-AGG-ID: Ghl4AiDdM6Wz8Gl_v4r54Q_1739810466
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AFE121801A13; Mon, 17 Feb 2025 16:41:06 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.225.252])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 42A8D1800352; Mon, 17 Feb 2025 16:41:01 +0000 (UTC)
From: Albert Esteve <aesteve@redhat.com>
To: qemu-devel@nongnu.org
Cc: slp@redhat.com, stevensd@chromium.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>, stefanha@redhat.com,
 david@redhat.com, hi@alyssa.is, mst@redhat.com, jasowang@redhat.com,
 Albert Esteve <aesteve@redhat.com>
Subject: [PATCH v4 9/9] vhost_user.rst: Add MEM_READ/WRITE messages
Date: Mon, 17 Feb 2025 17:40:12 +0100
Message-ID: <20250217164012.246727-10-aesteve@redhat.com>
In-Reply-To: <20250217164012.246727-1-aesteve@redhat.com>
References: <20250217164012.246727-1-aesteve@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=aesteve@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Add MEM_READ/WRITE request to the vhost-user
spec documentation.

Signed-off-by: Albert Esteve <aesteve@redhat.com>
---
 docs/interop/vhost-user.rst | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
index 96156f1900..9f7a2c4cf7 100644
--- a/docs/interop/vhost-user.rst
+++ b/docs/interop/vhost-user.rst
@@ -391,6 +391,7 @@ In QEMU the vhost-user message is implemented with the following struct:
           VhostUserTransferDeviceState transfer_state;
           VhostUserMMap mmap;
           VhostUserShMemConfig shmem;
+          VhostUserMemRWMsg mem_rw;
       };
   } QEMU_PACKED VhostUserMsg;
 
@@ -1938,6 +1939,38 @@ is sent by the front-end.
   given range shall correspond to the entirety of a valid mapped region.
   A reply is generated indicating whether unmapping succeeded.
 
+``VHOST_USER_BACKEND_MEM_READ``
+  :id: 11
+  :equivalent ioctl: N/A
+  :request payload: ``struct VhostUserMemRWMsg``
+  :reply payload: N/A
+
+  When the ``VHOST_USER_PROTOCOL_F_SHMEM`` protocol feature has been
+  successfully negotiated, this message can be submitted by the backends to
+  read a memory region that has failed to resolve a translation due to an
+  incomplete memory table, after another device called
+  ``VHOST_USER_BACKEND_SHMEM_MAP`` for the same region on a shared
+  descriptor file.
+
+  This mechanism works as a fallback for resolving those memory
+  accesses and ensure that DMA works with Shared Memory Regions.
+
+``VHOST_USER_BACKEND_MEM_WRITE``
+  :id: 12
+  :equivalent ioctl: N/A
+  :request payload: ``struct VhostUserMemRWMsg``
+  :reply payload: N/A
+
+  When the ``VHOST_USER_PROTOCOL_F_SHMEM`` protocol feature has been
+  successfully negotiated, this message can be submitted by the backends to
+  write a memory region that has failed due to resolve a translation an
+  incomplete memory table  after another device called
+  ``VHOST_USER_BACKEND_SHMEM_MAP`` for the same region on a shared
+  descriptor file.
+
+  This mechanism works as a fallback for resolving those memory
+  accesses and ensure that DMA works with Shared Memory Regions.
+
 .. _reply_ack:
 
 VHOST_USER_PROTOCOL_F_REPLY_ACK
-- 
2.48.1


