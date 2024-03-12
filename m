Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5ABCC54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 12:49:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk1VQ-00050O-U9; Tue, 12 Mar 2024 08:45:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rk1Uw-0004FV-EK
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 08:44:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rk1Ur-0000T5-Ps
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 08:44:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710247485;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rIgnOsfFSMsEGyT7FNEqh+sTvP35EQ6b4LH2suBdKa0=;
 b=W1bLiYCd2XagLFVw3gxcqZzGQj6EgkIK6Ng2GLFNA6r737nIhzlxr6LmCSuDxiNZoqpvbf
 R49CL1e5YnDZ1faqAqhC6QwJR3zwmY1/6jObUaIGsBQBWaKaOri4j11s5GFR2ZJzGgPp+H
 FBYqz7JFvwoDXMwQsFcCM+fYE2e1joI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-dJ5XrLoIMhuJ21aBty9TrQ-1; Tue, 12 Mar 2024 08:44:42 -0400
X-MC-Unique: dJ5XrLoIMhuJ21aBty9TrQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BBD29810FDA;
 Tue, 12 Mar 2024 12:44:41 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.69])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9A530492BD4;
 Tue, 12 Mar 2024 12:44:40 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Zhao Liu <zhao1.liu@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PULL 29/55] hw/virtio/vhost: Fix missing ERRP_GUARD() for
 error_prepend()
Date: Tue, 12 Mar 2024 13:43:13 +0100
Message-ID: <20240312124339.761630-30-thuth@redhat.com>
In-Reply-To: <20240312124339.761630-1-thuth@redhat.com>
References: <20240312124339.761630-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Zhao Liu <zhao1.liu@intel.com>

As the comment in qapi/error, passing @errp to error_prepend() requires
ERRP_GUARD():

* = Why, when and how to use ERRP_GUARD() =
*
* Without ERRP_GUARD(), use of the @errp parameter is restricted:
...
* - It should not be passed to error_prepend(), error_vprepend() or
*   error_append_hint(), because that doesn't work with &error_fatal.
* ERRP_GUARD() lifts these restrictions.
*
* To use ERRP_GUARD(), add it right at the beginning of the function.
* @errp can then be used without worrying about the argument being
* NULL or &error_fatal.

ERRP_GUARD() could avoid the case when @errp is &error_fatal, the user
can't see this additional information, because exit() happens in
error_setg earlier than information is added [1].

In hw/virtio/vhost.c, there are 2 functions passing @errp to
error_prepend() without ERRP_GUARD():
- vhost_save_backend_state()
- vhost_load_backend_state()

Their @errp both points to callers' @local_err. However, as the APIs
defined in include/hw/virtio/vhost.h, it is necessary to protect their
@errp with ERRP_GUARD().

To follow the requirement of @errp, add missing ERRP_GUARD() at their
beginning.

[1]: Issue description in the commit message of commit ae7c80a7bd73
     ("error: New macro ERRP_GUARD()").

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Message-ID: <20240311033822.3142585-27-zhao1.liu@linux.intel.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/virtio/vhost.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 2c9ac79468..2e4e040db8 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -2199,6 +2199,7 @@ int vhost_check_device_state(struct vhost_dev *dev, Error **errp)
 
 int vhost_save_backend_state(struct vhost_dev *dev, QEMUFile *f, Error **errp)
 {
+    ERRP_GUARD();
     /* Maximum chunk size in which to transfer the state */
     const size_t chunk_size = 1 * 1024 * 1024;
     g_autofree void *transfer_buf = NULL;
@@ -2291,6 +2292,7 @@ fail:
 
 int vhost_load_backend_state(struct vhost_dev *dev, QEMUFile *f, Error **errp)
 {
+    ERRP_GUARD();
     size_t transfer_buf_size = 0;
     g_autofree void *transfer_buf = NULL;
     g_autoptr(GError) g_err = NULL;
-- 
2.44.0


