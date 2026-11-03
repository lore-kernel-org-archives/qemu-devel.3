Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94338606A324
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2026 03:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=L5jzKzwd
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xO5cM-0006OF-RZ; Mon, 02 Nov 2026 22:55:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xO5cK-0006N6-Fd
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 22:55:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xO5cI-0000a8-Sg
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 22:55:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793678122;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UW3eAHIVbNg3x5s+iHlq9p1VjyqRHEnAy06IQicSRoE=;
 b=L5jzKzwdKW200CruoHrvVoRFYRJhumB/mO5oeij7UjUSJtQYvA4nAnYbbl4zD23pWAH2B/
 VPqx8W+Z14GwSSOEhoco5bhc1DYgOsXGMKs6F4tVXWuodsB1l98DVjiMEZKGWlzjT+mfW9
 An9p+36x5YdsUhBo134Zee536P6wYs4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-648-RtR-wQCNO6Ozn9skfB5QEA-1; Mon,
 02 Nov 2026 22:55:18 -0500
X-MC-Unique: RtR-wQCNO6Ozn9skfB5QEA-1
X-Mimecast-MFC-AGG-ID: RtR-wQCNO6Ozn9skfB5QEA_1793678117
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 443661800760; Tue,  3 Nov 2026 03:55:17 +0000 (UTC)
Received: from eblake.csb (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8D9067E2; Tue,  3 Nov 2026 03:55:15 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Denis V. Lunev" <den@openvz.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>
Subject: [PULL 03/16] tests/qtest/virtio-scsi: cover a replacement that
 changes the size
Date: Mon,  2 Nov 2026 21:54:14 -0600
Message-ID: <20261103035506.2688772-21-eblake@redhat.com>
In-Reply-To: <20261103035506.2688772-18-eblake@redhat.com>
References: <20261103035506.2688772-18-eblake@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
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

From: "Denis V. Lunev" <den@openvz.org>

Realize a scsi-hd on a 1 MiB node, replace it with a 128 MiB one using
qom-set, and check that the device reports CAPACITY DATA HAS CHANGED and
then serves a read which only fits in the new node.

Both halves regress on their own. Without the notification from
bdrv_replace_child_bs() the first command after the replacement fails with
ILLEGAL REQUEST / LOGICAL BLOCK ADDRESS OUT OF RANGE instead of the unit
attention. Without the refresh in scsi_disk_resize_cb() the read after it
is refused the same way, since nothing here issues READ CAPACITY.

Signed-off-by: Denis V. Lunev <den@openvz.org>
Message-ID: <20260812121500.1034178-4-den@openvz.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 tests/qtest/virtio-scsi-test.c | 63 ++++++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/tests/qtest/virtio-scsi-test.c b/tests/qtest/virtio-scsi-test.c
index e2350c52f6f..f82b7e5de9c 100644
--- a/tests/qtest/virtio-scsi-test.c
+++ b/tests/qtest/virtio-scsi-test.c
@@ -236,6 +236,53 @@ static void test_unmap_large_lba(void *obj, void *data,
     qvirtio_scsi_pci_free(vs);
 }

+/* Test replacing the backing node with one of a different size */
+static void test_replaced_node_size(void *obj, void *data,
+                                    QGuestAllocator *t_alloc)
+{
+    QVirtioSCSI *scsi = obj;
+    QVirtioSCSIQueues *vs;
+    uint8_t buf[512] = { 0 };
+    /* READ(10), LBA 0, transfer length 1 */
+    const uint8_t read_low_cdb[VIRTIO_SCSI_CDB_SIZE] = {
+        0x28, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x00
+    };
+    /* READ(10), LBA 0x1000 (2 MiB), transfer length 1 */
+    const uint8_t read_high_cdb[VIRTIO_SCSI_CDB_SIZE] = {
+        0x28, 0x00, 0x00, 0x00, 0x10, 0x00, 0x00, 0x00, 0x01, 0x00
+    };
+    struct virtio_scsi_cmd_resp resp;
+
+    alloc = t_alloc;
+    vs = qvirtio_scsi_init(scsi->vdev);
+
+    /* LBA 0 is inside the 1 MiB node the device was realized with */
+    virtio_scsi_do_command(vs, read_low_cdb, buf, sizeof(buf), NULL, 0, &resp);
+    g_assert_cmphex(resp.response, ==, 0);
+    g_assert_cmphex(resp.status, ==, GOOD);
+
+    /* Swap in a 128 MiB node; the device is not reset by this */
+    qtest_qmp_assert_success(global_qtest,
+                             "{'execute': 'qom-set', 'arguments': {"
+                             "  'path': '/machine/peripheral/scsi-hd0',"
+                             "  'property': 'drive', 'value': 'big'}}");
+
+    /* The guest has to be told that the capacity it knows is stale */
+    virtio_scsi_do_command(vs, read_high_cdb, buf, sizeof(buf), NULL, 0, &resp);
+    g_assert_cmphex(resp.response, ==, 0);
+    g_assert_cmphex(resp.status, ==, CHECK_CONDITION);
+    g_assert_cmphex(resp.sense[2], ==, UNIT_ATTENTION);
+    g_assert_cmphex(resp.sense[12], ==, 0x2a);
+    g_assert_cmphex(resp.sense[13], ==, 0x09); /* CAPACITY DATA HAS CHANGED */
+
+    /* LBA 0x1000 is past the old node but well inside the new one */
+    virtio_scsi_do_command(vs, read_high_cdb, buf, sizeof(buf), NULL, 0, &resp);
+    g_assert_cmphex(resp.response, ==, 0);
+    g_assert_cmphex(resp.status, ==, GOOD);
+
+    qvirtio_scsi_pci_free(vs);
+}
+
 static void test_write_to_cdrom(void *obj, void *data,
                                 QGuestAllocator *t_alloc)
 {
@@ -365,6 +412,18 @@ static void *virtio_scsi_setup_4k(GString *cmd_line, void *arg)
     return arg;
 }

+static void *virtio_scsi_setup_replace(GString *cmd_line, void *arg)
+{
+    g_string_append(cmd_line,
+                    " -blockdev driver=null-co,read-zeroes=on,"
+                    "size=1048576,node-name=small"
+                    " -blockdev driver=null-co,read-zeroes=on,"
+                    "size=134217728,node-name=big"
+                    " -device scsi-hd,id=scsi-hd0,drive=small,"
+                    "lun=0,scsi-id=1");
+    return arg;
+}
+
 static void *virtio_scsi_setup_cd(GString *cmd_line, void *arg)
 {
     g_string_append(cmd_line,
@@ -399,6 +458,10 @@ static void register_virtio_scsi_test(void)
     qos_add_test("large-lba-unmap", "virtio-scsi",
                  test_unmap_large_lba, &opts);

+    opts.before = virtio_scsi_setup_replace;
+    qos_add_test("replaced-node-size", "virtio-scsi",
+                 test_replaced_node_size, &opts);
+
     opts.before = virtio_scsi_setup_cd;
     qos_add_test("write-to-cdrom", "virtio-scsi", test_write_to_cdrom, &opts);

-- 
2.56.0


