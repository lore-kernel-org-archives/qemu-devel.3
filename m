Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F34606A326
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 12:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MVgXrfEF
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVpwY-0005U0-7m; Tue, 24 Nov 2026 07:48:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xVpwV-0005TR-0l
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 07:48:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xVpwS-0000nR-V1
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 07:48:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795524491;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BTWoJfz8+4TZMSDcv1D77kOYYeoGoPkoK9AZQUvU0Sg=;
 b=MVgXrfEFv+973ebsY6E8guuUM4m2U5rUtU6ef9rGY7RUJua0sW9PsKkt5sBVruSCBkjjgf
 aaoYbZHHsPkws6NI41FWgulZUyYISn2YnlsrLZB+7wzxWsRL0GzrkuWsub/hhTr8iWYDGi
 lkUcIacAt/AH/3UEWhGxD4VoFURhTYg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-331-crysxII7OIqH-xsqJaiATA-1; Tue,
 24 Nov 2026 12:48:07 +0000
X-MC-Unique: crysxII7OIqH-xsqJaiATA-1
X-Mimecast-MFC-AGG-ID: crysxII7OIqH-xsqJaiATA_1795524486
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A9DAD1956088; Tue, 24 Nov 2026 12:48:06 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B0CF718011D3; Tue, 24 Nov 2026 12:48:05 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 24 Nov 2026 16:47:46 +0400
Subject: [PATCH v4 3/6] hw/display/vhost-user-gpu: don't set an fd handler
 without a socket
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261124-issue-4848-v4-3-24993c4766fc@redhat.com>
References: <20261124-issue-4848-v4-0-24993c4766fc@redhat.com>
In-Reply-To: <20261124-issue-4848-v4-0-24993c4766fc@redhat.com>
To: qemu-devel@nongnu.org
Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry R <rdmitry@taktcycles.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1428;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=/79/dhM998W/bi4+wN5uBzRDSCNXfta5bEBeiCDsU+w=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBrBYd26Uot0NfkXzmKcY98ugqxDQ3ZIe0Pg0z4x
 89KEdaUW4uJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCawWHdgAKCRDa6OEJdZac
 5fKlD/sG4nj1rfYBwS1GVNSDhCL5advsYA7rXqn8pmgsBKKSOE7yZGBxIrvoWJtg9m2DxWEmbfy
 I1bu+9DmVOAKWkTZafUXhzF2lLgKPXabn2hCPq19KALDgIgeiHi6lIACStKINB5wfr7k1mvLkkn
 k16uakZltLVZbCntSo596iQKXrbNkWWWleWwP3dHWcyMgXU8hlEQvWGl3LvIoZ/Sh+x1JwRlvYR
 RDvKBfpX/g2skCOvrxZl+Px2JimMbiJIcqgLXCTJa1dRZ+EVlxbLugKPW0/CZ8u+Fl/LFY72/xb
 wIJWujpPACNBLfIIFem2XM/QHlst6IyusoatV89r99ryX+4STZMQ17Fsa2YFcmcR+b6A5M7weaE
 WC8EGv+SONWUfZKKuJdWiNAdZMGGnagJiMcdhlpkXwaix/ao5/xhlWOj4SDuIhP4aQAdzCBpD7U
 AiFbVmzjlGupv3B7VOpjA4CrblggXpA4QVMMuvXbzjsbzfv5D1L9lm9kqJ6pl6V7lsxQDrH7dKD
 y/JpSypsmsiuQPcUahT1qXW44IpsSWV6hH3B4aH4cG0qO1ZCYLWSXHTX99jG+fsjpxxC178+YKv
 Atpx8fFzVpEV9VavGfWpvIVm2+283UHQ3XUhPVh7QReqGMBHgnETDf2tBrXV/x4910mdeDxNmKI
 9PeS7fT5k/M0rRQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

A GL display client that stays attached across a device stop can unblock
the console after vhost_gpu_fd has been reset to -1: the UpdateDMABUF
reply or the one-second gl unblock timer reach
vhost_user_gpu_gl_flushed(), which installs the display socket handler
on fd -1. With the io_uring fd monitor, the failed poll of fd -1 is
reported as readiness, so the handler runs and is re-armed forever.

Only set the handler when the device has a display socket.

Fixes: 3cddb8b9e0b5 ("display/ui: add a callback to indicate GL state is flushed")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/4847
Reported-by: Dmitry R <rdmitry@taktcycles.com>
Tested-by: Dmitry R <rdmitry@taktcycles.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/display/vhost-user-gpu.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/display/vhost-user-gpu.c b/hw/display/vhost-user-gpu.c
index 32e7d9638f68..61a15dd916f8 100644
--- a/hw/display/vhost-user-gpu.c
+++ b/hw/display/vhost-user-gpu.c
@@ -448,6 +448,11 @@ end:
 static void
 vhost_user_gpu_update_blocked(VhostUserGPU *g, bool blocked)
 {
+    /* the display socket doesn't exist before DRIVER_OK */
+    if (g->vhost_gpu_fd == -1) {
+        return;
+    }
+
     qemu_set_fd_handler(g->vhost_gpu_fd,
                         blocked ? NULL : vhost_user_gpu_chr_read, NULL, g);
 }

-- 
2.56.0.116.g6de20f6092dc


