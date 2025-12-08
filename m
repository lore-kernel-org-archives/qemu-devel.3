Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55E46D3ABEF
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Dec 2025 04:37:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vSSzi-0001iP-8J; Sun, 07 Dec 2025 23:37:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hzuo@redhat.com>) id 1vSSzg-0001hx-5C
 for qemu-devel@nongnu.org; Sun, 07 Dec 2025 23:37:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hzuo@redhat.com>) id 1vSSze-0001lN-KV
 for qemu-devel@nongnu.org; Sun, 07 Dec 2025 23:37:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765168621;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=1HbRr05zOLZIZ/6xW5N3Iy+ENg28xDhYlN0Wvk+6tUg=;
 b=D9TsmsYpLGhDuHTCGh4apQNipjOxL/Rqf/qic+h/8pvnpnPOntACcTO/DOwaDuA0ZM9djt
 eaRWbl2j53k/riT11N6Al3p/I9mGSaxaFi8384h46JGmxG40OSbViFZQ73V04NOc1uoiuV
 utXtE4f2Vu0CMqKI1VmPqkbbXkoZn60=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-212-SmTA8z1zNuazVlgI8qR-Cg-1; Sun,
 07 Dec 2025 23:35:40 -0500
X-MC-Unique: SmTA8z1zNuazVlgI8qR-Cg-1
X-Mimecast-MFC-AGG-ID: SmTA8z1zNuazVlgI8qR-Cg_1765168539
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 163741956046
 for <qemu-devel@nongnu.org>; Mon,  8 Dec 2025 04:35:39 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.72.116.145])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9DDD31956095; Mon,  8 Dec 2025 04:35:36 +0000 (UTC)
From: "Houqi (Nick) Zuo" <hzuo@redhat.com>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, Cindy Lu <lulu@redhat.com>,
 Yanhui Ma <yama@redhat.com>
Subject: [PATCH v6] net/tap-linux.c: avoid abort when setting invalid fd
Date: Mon,  8 Dec 2025 12:35:18 +0800
Message-ID: <20251208043518.3223721-1-hzuo@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hzuo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, RCVD_IN_SBL_CSS=3.335,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

This patch removes abort() call in the tap_fd_set_vnet_hdr_len()
function. If the fd is found to be in a bad state (e.g., EBADFD
 or ENODEV), the function will print an error message.

When QEMU creates a tap device automatically and the tap device is
manually removed from the host while the guest is running, the tap
device file descriptor becomes invalid. Later, when the guest executes
shutdown, the tap_fd_set_vnet_hdr_len() function may be called and
abort QEMU with a core dump when attempting to use the invalid fd.
The expected behavior for this negative test case is that QEMU should
report an error but continue running rather than aborting.

Testing:
- Start QEMU with automatically created tap device
- Manually remove the tap device on the host
- Execute shutdown in the guest
- Verify QEMU reports an error but does not abort

Fixes: 0caed25cd171 ("virtio: Call set_features during reset")
Signed-off-by: Houqi (Nick) Zuo <hzuo@redhat.com>
---
 net/tap-linux.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/net/tap-linux.c b/net/tap-linux.c
index 2a90b58467..922684f349 100644
--- a/net/tap-linux.c
+++ b/net/tap-linux.c
@@ -214,10 +214,11 @@ bool tap_probe_has_tunnel(int fd)
 
 void tap_fd_set_vnet_hdr_len(int fd, int len)
 {
-    if (ioctl(fd, TUNSETVNETHDRSZ, &len) == -1) {
-        fprintf(stderr, "TUNSETVNETHDRSZ ioctl() failed: %s. Exiting.\n",
-                strerror(errno));
-        abort();
+    int ret;
+
+    ret = ioctl(fd, TUNSETVNETHDRSZ, &len);
+    if (ret != 0) {
+        error_report("TUNSETVNETHDRSZ ioctl() failed: %s.", strerror(errno));
     }
 }
 
-- 
2.47.3


