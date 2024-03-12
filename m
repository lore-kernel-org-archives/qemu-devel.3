Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FD96C54E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 12:56:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk1Uq-0003lD-EE; Tue, 12 Mar 2024 08:44:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rk1Un-0003bS-5S
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 08:44:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rk1Ug-0000L8-A9
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 08:44:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710247473;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f5lm0VnfXsNWt+FRa/MBqsb4VrTEIB76yLlxjX43jvA=;
 b=OglKjXl3MrWjtSLe1yRnZD7/Ool4XV0LTxn2Xlkqs0sDWemJjUTyi7OdW8DlzuDVkd1Q+n
 ZQTXmunNvIYzQar2sNXmIVX5JoMgekBX8E7eZw6mGT6mIRkzEQXJX94mI7uXe+TPEG4M6l
 mHfxKqRYSHGpSfFjCi3Vt8apuE+wx5k=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-620-K0pOP1TLOie2Z7IXsK6mAw-1; Tue,
 12 Mar 2024 08:44:30 -0400
X-MC-Unique: K0pOP1TLOie2Z7IXsK6mAw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CA81B1C07F39;
 Tue, 12 Mar 2024 12:44:29 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.69])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 60014492BD0;
 Tue, 12 Mar 2024 12:44:28 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Zhao Liu <zhao1.liu@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 23/55] hw/vfio/helpers: Fix missing ERRP_GUARD() for
 error_prepend()
Date: Tue, 12 Mar 2024 13:43:07 +0100
Message-ID: <20240312124339.761630-24-thuth@redhat.com>
In-Reply-To: <20240312124339.761630-1-thuth@redhat.com>
References: <20240312124339.761630-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

In hw/vfio/helpers.c, there are 3 functions passing @errp to
error_prepend() without ERRP_GUARD():
 - vfio_set_irq_signaling()
 - vfio_device_get_name()
 - vfio_device_set_fd()

There are too many possible callers to check the impact of this defect;
it may or may not be harmless. Thus it is necessary to protect their
@errp with ERRP_GUARD().

To avoid the issue like [1] said, add missing ERRP_GUARD() at their
beginning.

[1]: Issue description in the commit message of commit ae7c80a7bd73
     ("error: New macro ERRP_GUARD()").

Cc: Alex Williamson <alex.williamson@redhat.com>
Cc: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Message-ID: <20240311033822.3142585-21-zhao1.liu@linux.intel.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/vfio/helpers.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/vfio/helpers.c b/hw/vfio/helpers.c
index 6789870802..47b4096c05 100644
--- a/hw/vfio/helpers.c
+++ b/hw/vfio/helpers.c
@@ -110,6 +110,7 @@ static const char *index_to_str(VFIODevice *vbasedev, int index)
 int vfio_set_irq_signaling(VFIODevice *vbasedev, int index, int subindex,
                            int action, int fd, Error **errp)
 {
+    ERRP_GUARD();
     struct vfio_irq_set *irq_set;
     int argsz, ret = 0;
     const char *name;
@@ -613,6 +614,7 @@ bool vfio_has_region_cap(VFIODevice *vbasedev, int region, uint16_t cap_type)
 
 int vfio_device_get_name(VFIODevice *vbasedev, Error **errp)
 {
+    ERRP_GUARD();
     struct stat st;
 
     if (vbasedev->fd < 0) {
@@ -644,6 +646,7 @@ int vfio_device_get_name(VFIODevice *vbasedev, Error **errp)
 
 void vfio_device_set_fd(VFIODevice *vbasedev, const char *str, Error **errp)
 {
+    ERRP_GUARD();
     int fd = monitor_fd_param(monitor_cur(), str, errp);
 
     if (fd < 0) {
-- 
2.44.0


