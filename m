Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C723C54E41
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 08:10:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfxy0-0003H4-Qd; Fri, 01 Mar 2024 03:10:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rfxxz-0003Gw-EM
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 03:10:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rfxxx-0006jC-LZ
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 03:10:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709280600;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0nNph5qZkU4HPnA3Bzes6NJb6fMhVgODi6vzQipxT6s=;
 b=Dev3pRLum+g+6lcL5a9AGGsWSkw1ZQ7Sbv2MMmyUjuX1QMkKiJdGqOjOh+/3Hh0ERR83A5
 6dTtngvVkF9kHM8iZ5W3e2hyJtzAlje8/bdOHc6SyA6Wg8AdGoUbcLRXuL/dYlrm9wwZOE
 aLAeHBaLuONMnU0BIZ2cCtJm8DHrQNs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-9-OJLNPvp3MDKzofrifxChTQ-1; Fri, 01 Mar 2024 03:09:56 -0500
X-MC-Unique: OJLNPvp3MDKzofrifxChTQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5D61984AC87;
 Fri,  1 Mar 2024 08:09:56 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.193.125])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2C7762015B7E;
 Fri,  1 Mar 2024 08:09:55 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 1/6] libqos/virtio.c: init all elems in
 qvring_indirect_desc_setup()
Date: Fri,  1 Mar 2024 09:09:48 +0100
Message-ID: <20240301080953.66448-2-thuth@redhat.com>
In-Reply-To: <20240301080953.66448-1-thuth@redhat.com>
References: <20240301080953.66448-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.096,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

The loop isn't setting the values for the last element. Every other
element is being initialized with addr = 0, flags = VRING_DESC_F_NEXT
and next = i + 1. The last elem is never touched.

This became a problem when enabling a RISC-V 'virt' libqos machine in
the 'indirect' test of virti-blk-test.c. The 'flags' for the last
element will end up being an odd number (since we didn't touch it).
Being an odd number it will be mistaken by VRING_DESC_F_NEXT, which
happens to be 1.

Deep into hw/virt/virtio.c, in virtqueue_split_pop(), into
virtqueue_split_read_next_desc(), a check for VRING_DESC_F_NEXT will be
made to see if we're supposed to chain. The code will keep up chaining
in the last element because the uninitialized value happens to be odd.
We'll error out right after that because desc->next (which is also
uninitialized) will be >= max. A VIRTQUEUE_READ_DESC_ERROR will be
returned, with an error message like this in the stderr:

qemu-system-riscv64: Desc next is 49391

Since we never returned, we'll end up timing out at qvirtio_wait_used_elem():

ERROR:../tests/qtest/libqos/virtio.c:236:qvirtio_wait_used_elem:
    assertion failed: (g_get_monotonic_time() - start_time <= timeout_us)

The root cause is using uninitialized values from guest_alloc() in
qvring_indirect_desc_setup(). There's no guarantee that the memory pages
retrieved will be zeroed, so we can't make assumptions. In fact, commit
5b4f72f5e8 ("tests/qtest: properly initialise the vring used idx") fixed a
similar problem stating "It is probably not wise to assume guest memory
is zeroed anyway". I concur.

Initialize all elems in qvring_indirect_desc_setup().

Fixes: f294b029aa ("libqos: Added indirect descriptor support to virtio implementation")
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20240217192607.32565-2-dbarboza@ventanamicro.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/qtest/libqos/virtio.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/tests/qtest/libqos/virtio.c b/tests/qtest/libqos/virtio.c
index 410513225f..4f39124eba 100644
--- a/tests/qtest/libqos/virtio.c
+++ b/tests/qtest/libqos/virtio.c
@@ -280,14 +280,27 @@ QVRingIndirectDesc *qvring_indirect_desc_setup(QTestState *qs, QVirtioDevice *d,
     indirect->elem = elem;
     indirect->desc = guest_alloc(alloc, sizeof(struct vring_desc) * elem);
 
-    for (i = 0; i < elem - 1; ++i) {
+    for (i = 0; i < elem; ++i) {
         /* indirect->desc[i].addr */
         qvirtio_writeq(d, qs, indirect->desc + (16 * i), 0);
-        /* indirect->desc[i].flags */
-        qvirtio_writew(d, qs, indirect->desc + (16 * i) + 12,
-                       VRING_DESC_F_NEXT);
-        /* indirect->desc[i].next */
-        qvirtio_writew(d, qs, indirect->desc + (16 * i) + 14, i + 1);
+
+        /*
+         * If it's not the last element of the ring, set
+         * the chain (VRING_DESC_F_NEXT) flag and
+         * desc->next. Clear the last element - there's
+         * no guarantee that guest_alloc() will do it.
+         */
+        if (i != elem - 1) {
+            /* indirect->desc[i].flags */
+            qvirtio_writew(d, qs, indirect->desc + (16 * i) + 12,
+                           VRING_DESC_F_NEXT);
+
+            /* indirect->desc[i].next */
+            qvirtio_writew(d, qs, indirect->desc + (16 * i) + 14, i + 1);
+        } else {
+            qvirtio_writew(d, qs, indirect->desc + (16 * i) + 12, 0);
+            qvirtio_writew(d, qs, indirect->desc + (16 * i) + 14, 0);
+        }
     }
 
     return indirect;
-- 
2.44.0


