Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50A42C44520
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 11:54:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkh91-0005pP-Ss; Fri, 17 Jul 2026 07:54:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wkh8z-0005gX-QB
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 07:54:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wkh8y-0003TR-6v
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 07:54:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784289255;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ma06sRa+gkxOkPrGVzY/3snPWHWCY9B46BWzFm1ys7k=;
 b=LI3EukKLIrRhJ7vRo/xDpdFDypAGevM5b7/31mHH5dy6+EwuX+IfU6r3V4Ma0aEuKo+KOS
 GpuboNEPZwVU+CboEGDFZbJvkuP39JGtTiSvtgOeLMlCP5z3YtKoJHr13qcXAJiuMHE6xN
 QRlwAqGjuqmVOzM7UJALG1jwEE7iFx4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-654-l7F6mIhvPe-nof05yyTrKA-1; Fri,
 17 Jul 2026 07:54:13 -0400
X-MC-Unique: l7F6mIhvPe-nof05yyTrKA-1
X-Mimecast-MFC-AGG-ID: l7F6mIhvPe-nof05yyTrKA_1784289252
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AC8B91800990
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 11:54:12 +0000 (UTC)
Received: from localhost (unknown [10.44.22.17])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C54FB1955D89
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 11:54:11 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 17 Jul 2026 15:52:52 +0400
Subject: [GIT PULL 13/15] hw/display/virtio-gpu: handle migration iov
 allocation failure
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260717-fix-v1-13-cb9f7d49dc52@redhat.com>
References: <20260717-fix-v1-0-cb9f7d49dc52@redhat.com>
In-Reply-To: <20260717-fix-v1-0-cb9f7d49dc52@redhat.com>
To: qemu-devel@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=2315;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=2Mx0BATBe6G622ffalvUopaB0e2yv5GZQfltNK2nJQ0=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqWheaOORBXfwx/HO8nxwN6j1LrDuMpCnzAdm//
 iitwut94D+JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaloXmgAKCRDa6OEJdZac
 5RSzD/0ZmSn/UK2oZI22w2obQ+QxewcRBR/Wj+sV2n40SgNseFfDRhkRaXGvG+zrqVZHKjWKUnK
 Alb1UM72+Uo7UKBxM5IPFIIFSWsnxvy9ySXAY6I9svQ/qIWwQP1+3CDjl2Q2dN4ZhA5hJtWJSem
 D/ksbf9giF1nS8n6QlPBtosfCZwqAz5AKYZM3jvLTyaNWT8Q3tSY7vSE7UVTP5qZZZ46++fgFKf
 TFIY3AcnpiXOxRuA9T8SL3RGmCDmqV8AVNgnPmZeFV34PQ5Dbd20EbFE/UMTaPweZYG6s+mPS8h
 7cjWf9CTL6O4D8dKb3BXPM9MUulkVe9/i5cYD7K/Fv+lPIYpbV0ObJV+VMYWe8/X5+tHfBvcTOM
 pgvYyOOrcSFpGV9QwwQUWHxCYcwSZxKomweX/QWTI/jV2/KX7PoEc2dV4duGmMYwkFJ4j9dbXzB
 q9lwvztSXVcBWGewlG+6dXDcpDIiZzNGjMthy2ftFV6pko+LbZD6d+ge9h7JNJpvSOapVuXh4mq
 hkw3Rx8/rdCGa0Q3FEks3vrIrYCnopNWTnqUpU+DN0tcwumEjcJWuGhvOmZUSJ/dyl73Wbi5Qus
 A8eHDKlFCZlB+UfsmrVhMhQ6Hsj85FudJgJA6VU/8y+Bq7wTxlRHngGAkJFi6yzqB/+GGnHmodS
 yW3JjY/KRrhDKXA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: permerror client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001, T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

An unbounded iov_cnt from the migration stream drives two g_new()
allocations whose combined size can exceed available memory, causing
GLib to abort the process.

Switch to g_try_new() and propagate the failure as a migration error.

Fixes: 0c244e50ee12 ("virtio-gpu: add live migration support")
Fixes: f66767f75c9c ("virtio-gpu: add virtio-gpu/blob vmstate subsection")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3753
Reported-by: Feifan Qian <bea1e@proton.me>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/display/virtio-gpu.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index e00fb6effa5..048b151872e 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -1365,8 +1365,15 @@ static int virtio_gpu_load(QEMUFile *f, void *opaque, size_t size,
             return -EINVAL;
         }
 
-        res->addrs = g_new(uint64_t, res->iov_cnt);
-        res->iov = g_new(struct iovec, res->iov_cnt);
+        res->addrs = g_try_new(uint64_t, res->iov_cnt);
+        res->iov = g_try_new(struct iovec, res->iov_cnt);
+        if (res->iov_cnt && (!res->addrs || !res->iov)) {
+            pixman_image_unref(res->image);
+            g_free(res->addrs);
+            g_free(res->iov);
+            g_free(res);
+            return -EINVAL;
+        }
 
         /* read data */
         for (i = 0; i < res->iov_cnt; i++) {
@@ -1440,8 +1447,15 @@ static int virtio_gpu_blob_load(QEMUFile *f, void *opaque, size_t size,
         res->resource_id = resource_id;
         res->blob_size = qemu_get_be32(f);
         res->iov_cnt = qemu_get_be32(f);
-        res->addrs = g_new(uint64_t, res->iov_cnt);
-        res->iov = g_new(struct iovec, res->iov_cnt);
+
+        res->addrs = g_try_new(uint64_t, res->iov_cnt);
+        res->iov = g_try_new(struct iovec, res->iov_cnt);
+        if (res->iov_cnt && (!res->addrs || !res->iov)) {
+            g_free(res->addrs);
+            g_free(res->iov);
+            g_free(res);
+            return -EINVAL;
+        }
 
         /* read data */
         for (i = 0; i < res->iov_cnt; i++) {

-- 
2.55.0


