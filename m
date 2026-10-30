Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C34606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 19:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Ps6wRCH4
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMsNW-0000aL-I9; Fri, 30 Oct 2026 15:35:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1xMsNU-0000Y6-Md
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 15:35:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1xMsNT-0007lE-3O
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 15:35:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793388902;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0+7UvJTxWmf/PeFHP2HIInprW3+xR9CGmrDUeTnMQYc=;
 b=Ps6wRCH4AIIAPVAn1hZNgebU5hnccSS44+nTGSnHmXMn2B/htFzQdAjJ4MoWLJFseZmVTE
 q89/JwycNmO9bY/fOc5jff3KAyfN8KXJoMxYgxyqZ+xdbQo9LhohAvz2nXWBVIp27Fmo9A
 e3gdOF4tyRssJtzf/V9BfhU7qTrtiQ4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-352-RONa20WUM3O9DTz_7_qK4g-1; Fri,
 30 Oct 2026 15:34:54 -0400
X-MC-Unique: RONa20WUM3O9DTz_7_qK4g-1
X-Mimecast-MFC-AGG-ID: RONa20WUM3O9DTz_7_qK4g_1793388891
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E6FC718011CD; Fri, 30 Oct 2026 19:34:50 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 999571956087; Fri, 30 Oct 2026 19:34:50 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Zhao Liu <zhao1.liu@intel.com>, Kevin Wolf <kwolf@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Fam Zheng <fam@euphon.net>, devel@lists.libvirt.org,
 "Denis V. Lunev" <den@openvz.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 John Snow <jsnow@redhat.com>
Subject: [PULL 5/5] virtio-blk-test: Test truncated serial
Date: Fri, 30 Oct 2026 15:34:16 -0400
Message-ID: <20261030193416.1691807-6-stefanha@redhat.com>
In-Reply-To: <20261030193416.1691807-1-stefanha@redhat.com>
References: <20261030193416.1691807-1-stefanha@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Kevin Wolf <kwolf@redhat.com>

Only 20 bytes are written to the passed buffer and the returned string
doesn't have a NUL terminator.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20261029231001.194240-5-kwolf@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 tests/qtest/virtio-blk-test.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/tests/qtest/virtio-blk-test.c b/tests/qtest/virtio-blk-test.c
index 825ea261bed..722bd0711fa 100644
--- a/tests/qtest/virtio-blk-test.c
+++ b/tests/qtest/virtio-blk-test.c
@@ -858,6 +858,25 @@ static void get_id_serial_short_20_characters(void *obj, void *data,
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
+    status = get_id_request(dev, vq, buf, 25, 0xa5, t_alloc);
+    g_assert_cmpint(status, ==, 0);
+    g_assert_cmpmem(buf, 25, expected, sizeof(expected));
+
+    qvirtqueue_cleanup(blk_if->vdev->bus, vq, t_alloc);
+}
+
 static void *virtio_blk_test_setup(GString *cmd_line, void *arg)
 {
     char *tmp_path = drive_create();
@@ -898,6 +917,10 @@ static void register_virtio_blk_test(void)
     opts.edge.extra_device_opts = "serial=01234567890123456789";
     qos_add_test("get_id/serial_short_20_characters", "virtio-blk",
                  get_id_serial_short_20_characters, &opts);
+
+    opts.edge.extra_device_opts = "serial=012345678901234567890123456789";
+    qos_add_test("get_id/serial_short_trunc", "virtio-blk",
+                 get_id_serial_short_trunc, &opts);
 }
 
 libqos_init(register_virtio_blk_test);
-- 
2.56.0


