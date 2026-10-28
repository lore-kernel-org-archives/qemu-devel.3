Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32399606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 23:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WsoCYIrX
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMD0n-0001RA-OG; Wed, 28 Oct 2026 19:24:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xMD0R-0001O8-A0
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 19:24:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xMD0O-0003cv-If
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 19:24:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793229867;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ma2YrZhxOGAk3pcTKwyKhbOn2VE8E6MJUvg9VjIQPH0=;
 b=WsoCYIrXXx4+TuHIYq35zjPybLv6fqA+ThA5zcJvOXONIkotspzBwsEizLsoGq3Dis5lt+
 xrURialIoCFk+ZG9iUhd8l3kTs8UH36K4TlqX2Af0EIcAfIEPK5nJskCf2vLWgGDIAZus3
 87TIHUTMEX73Qw1ciwkIhCbNXWC7GBc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-623-PYrtckJYNKK37mxar3ZT9w-1; Wed,
 28 Oct 2026 19:24:26 -0400
X-MC-Unique: PYrtckJYNKK37mxar3ZT9w-1
X-Mimecast-MFC-AGG-ID: PYrtckJYNKK37mxar3ZT9w_1793229865
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 44F92195422B; Wed, 28 Oct 2026 23:24:25 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.44.32.110])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 483E518004D2; Wed, 28 Oct 2026 23:24:23 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, stefanha@redhat.com, mst@redhat.com,
 devel@lists.libvirt.org, qemu-devel@nongnu.org
Subject: [PATCH 5/5] virtio-blk-test: Test truncated serial
Date: Thu, 29 Oct 2026 00:24:00 +0100
Message-ID: <20261028232400.222535-6-kwolf@redhat.com>
In-Reply-To: <20261028232400.222535-1-kwolf@redhat.com>
References: <20261028232400.222535-1-kwolf@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Only 20 bytes are written to the passed buffer and the returned string
doesn't have a NUL terminator.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qtest/virtio-blk-test.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/tests/qtest/virtio-blk-test.c b/tests/qtest/virtio-blk-test.c
index 14fadcb4009..99d785d9e1a 100644
--- a/tests/qtest/virtio-blk-test.c
+++ b/tests/qtest/virtio-blk-test.c
@@ -835,6 +835,25 @@ static void get_id_serial_short(void *obj, void *data, QGuestAllocator *t_alloc)
     qvirtqueue_cleanup(blk_if->vdev->bus, vq, t_alloc);
 }
 
+static void get_id_serial_short_trunc(void *obj, void *data,
+                                      QGuestAllocator *t_alloc)
+{
+    QVirtioBlk *blk_if = obj;
+    QVirtioDevice *dev = blk_if->vdev;
+    QVirtQueue *vq;
+    uint8_t status;
+    /* Everything after the 20 character maximum is untouched, no '\0' */
+    const char expected[25] = "01234567890123456789\xa5\xa5\xa5\xa5\xa5";
+    char buf[25];
+
+    vq = get_id_setup(dev, t_alloc);
+    status = get_id_request(dev, vq, buf, 25, t_alloc);
+    g_assert_cmpint(status, ==, 0);
+    g_assert_cmpmem(buf, 25, expected, sizeof(expected));
+
+    qvirtqueue_cleanup(blk_if->vdev->bus, vq, t_alloc);
+}
+
 static void *virtio_blk_test_setup(GString *cmd_line, void *arg)
 {
     char *tmp_path = drive_create();
@@ -871,6 +890,10 @@ static void register_virtio_blk_test(void)
     opts.edge.extra_device_opts = "serial=abc";
     qos_add_test("get_id/serial_short", "virtio-blk",
                  get_id_serial_short, &opts);
+
+    opts.edge.extra_device_opts = "serial=012345678901234567890123456789";
+    qos_add_test("get_id/serial_short_trunc", "virtio-blk",
+                 get_id_serial_short_trunc, &opts);
 }
 
 libqos_init(register_virtio_blk_test);
-- 
2.56.0


