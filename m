Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E78FC02180
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 13:51:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tY3nU-0006hn-JU; Wed, 15 Jan 2025 08:51:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1tY3nL-0006Ze-6y
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 08:50:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1tY3nJ-0007uZ-5s
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 08:50:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736949052;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xsKepFBipeuwCEkbj9TToSPlSSF2s/jUgoEpM16fklg=;
 b=VXpptz3zCVdqb3+jdgC1lEyOmLHWAgeWBLDj1mgkuIISYUkxA8h1aEYANNCOoa6eBuYxGS
 PaFkcjmU0n9itkBrxbgM+WoH9+ysaWJzGAAbf2ThDY6pMJ82vu58n4iT61/H8ORggwl7T9
 1OML7kQTatCw0VES3fLEp7Z3uOcV1mI=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-363-GpbBqshOOX-0kccjMcRxBA-1; Wed,
 15 Jan 2025 08:50:50 -0500
X-MC-Unique: GpbBqshOOX-0kccjMcRxBA-1
X-Mimecast-MFC-AGG-ID: GpbBqshOOX-0kccjMcRxBA
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 28215197700A
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 13:50:50 +0000 (UTC)
Received: from lenovo-t14s.redhat.com (unknown [10.39.192.232])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7D5AB19560A3; Wed, 15 Jan 2025 13:50:48 +0000 (UTC)
From: Laurent Vivier <lvivier@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Hanna Czenczek <hreitz@redhat.com>,
 Jason Wang <jasowang@redhat.com>
Subject: [PATCH v2 1/2] vhost: Add stubs for the migration state transfer
 interface
Date: Wed, 15 Jan 2025 14:50:43 +0100
Message-ID: <20250115135044.799698-2-lvivier@redhat.com>
In-Reply-To: <20250115135044.799698-1-lvivier@redhat.com>
References: <20250115135044.799698-1-lvivier@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=lvivier@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Migration state transfer interface is only used by vhost-user-fs,
so the interface needs to be defined only when vhost is built.

But I need to use this interface with virtio-net and vhost is not always
enabled, and to avoid undefined reference error during build, define stub
functions for vhost_supports_device_state(), vhost_save_backend_state() and
vhost_load_backend_state().

Cc: Hanna Czenczek <hreitz@redhat.com>
Signed-off-by: Laurent Vivier <lvivier@redhat.com>
---
 include/hw/virtio/vhost.h | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
index 461c168c3739..a9469d50bca1 100644
--- a/include/hw/virtio/vhost.h
+++ b/include/hw/virtio/vhost.h
@@ -365,7 +365,14 @@ static inline int vhost_reset_device(struct vhost_dev *hdev)
  * Returns true if the device supports these commands, and false if it
  * does not.
  */
+#ifdef CONFIG_VHOST
 bool vhost_supports_device_state(struct vhost_dev *dev);
+#else
+static inline bool vhost_supports_device_state(struct vhost_dev *dev)
+{
+    return false;
+}
+#endif
 
 /**
  * vhost_set_device_state_fd(): Begin transfer of internal state from/to
@@ -448,7 +455,15 @@ int vhost_check_device_state(struct vhost_dev *dev, Error **errp);
  *
  * Returns 0 on success, and -errno otherwise.
  */
+#ifdef CONFIG_VHOST
 int vhost_save_backend_state(struct vhost_dev *dev, QEMUFile *f, Error **errp);
+#else
+static inline int vhost_save_backend_state(struct vhost_dev *dev, QEMUFile *f,
+                                           Error **errp)
+{
+    return -ENOSYS;
+}
+#endif
 
 /**
  * vhost_load_backend_state(): High-level function to load a vhost
@@ -465,6 +480,14 @@ int vhost_save_backend_state(struct vhost_dev *dev, QEMUFile *f, Error **errp);
  *
  * Returns 0 on success, and -errno otherwise.
  */
+#ifdef CONFIG_VHOST
 int vhost_load_backend_state(struct vhost_dev *dev, QEMUFile *f, Error **errp);
+#else
+static inline int vhost_load_backend_state(struct vhost_dev *dev, QEMUFile *f,
+                                           Error **errp)
+{
+    return -ENOSYS;
+}
+#endif
 
 #endif
-- 
2.47.1


