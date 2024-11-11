Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FDBBD2E9E6
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2024 13:12:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAUCb-0000dt-T6; Mon, 11 Nov 2024 08:11:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tAUCZ-0000db-Lo
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 08:11:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tAUCY-0007dR-8v
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 08:11:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731330689;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=kpIqZCWfOSeUNXH88gHlyRlIY6nqNzkaLyvZnUt+VI8=;
 b=Lwgcu8gvJUV7/i0HaeLgkTjM4F3mPIlwL7FwafKa2M6XhRXVKySQI067PtGUPs6MpH0NG9
 +37p3FsN/q2amoZhd3s9ydlJ+VHEgnMqpkBSq5H7RNMZOEFt+2cJWlHPDAvuE/qYgT1L6e
 QMK/eYviKLgcav+2AQBHRHfZVDxhet8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-687-f_xseuytOAKOCFRzFYtyNw-1; Mon,
 11 Nov 2024 08:11:25 -0500
X-MC-Unique: f_xseuytOAKOCFRzFYtyNw-1
X-Mimecast-MFC-AGG-ID: f_xseuytOAKOCFRzFYtyNw
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 933831944D3F; Mon, 11 Nov 2024 13:11:24 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.194.138])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 39DB619560A3; Mon, 11 Nov 2024 13:11:21 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Jared Rossi <jrossi@linux.ibm.com>
Subject: [PATCH] pc-bios/s390-ccw: Re-initialize receive queue index before
 each boot attempt
Date: Mon, 11 Nov 2024 14:11:20 +0100
Message-ID: <20241111131120.317796-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.122,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.671,
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

Now that we can boot from multiple boot devices, we have to make sure
to reinitialize static variables like rx_last_idx to avoid that they
contain garbage data during the second boot attempt (which can lead to
crashes when the code tries to access the wrong ring data).

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 pc-bios/s390-ccw/virtio-net.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/pc-bios/s390-ccw/virtio-net.c b/pc-bios/s390-ccw/virtio-net.c
index f9854a22c3..578c89d0c5 100644
--- a/pc-bios/s390-ccw/virtio-net.c
+++ b/pc-bios/s390-ccw/virtio-net.c
@@ -51,6 +51,8 @@ int virtio_net_init(void *mac_addr)
     void *buf;
     int i;
 
+    rx_last_idx = 0;
+
     vdev->guest_features[0] = VIRTIO_NET_F_MAC_BIT;
     virtio_setup_ccw(vdev);
 
-- 
2.47.0


