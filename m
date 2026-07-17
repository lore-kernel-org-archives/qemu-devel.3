Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66A9CC44520
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 11:54:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkh8f-0004jC-FS; Fri, 17 Jul 2026 07:53:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wkh8d-0004ga-Vv
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 07:53:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wkh8c-0003SG-IS
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 07:53:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784289233;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Py9sueUcvDOLQV1YacJm2IgmkQ8EMFzR3H2U3/ovunw=;
 b=C7WTv8h8Vt48TINmFX3GzeuKzubnzk6IbF/zP6XNGssEMqgXVrwfs39RQ3SPrS43z/H1lt
 QuCEK7JtNkURRwBEHXgpZQgvk4RCYWoqYMWpog5rbHPDIWJx/u1bcWs1w+uygrFy7GZF5s
 GtiWvrM37jomfDM2pStYSDACqw4URhE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-59-5v2iWF7INrO5QG1qtfB5mg-1; Fri,
 17 Jul 2026 07:53:52 -0400
X-MC-Unique: 5v2iWF7INrO5QG1qtfB5mg-1
X-Mimecast-MFC-AGG-ID: 5v2iWF7INrO5QG1qtfB5mg_1784289231
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D029918007D2
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 11:53:51 +0000 (UTC)
Received: from localhost (unknown [10.44.22.17])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EB139180034C
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 11:53:50 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 17 Jul 2026 15:52:48 +0400
Subject: [GIT PULL 09/15] hw/display/virtio-gpu: fix dmabuf_fd leak on
 remap failure
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260717-fix-v1-9-cb9f7d49dc52@redhat.com>
References: <20260717-fix-v1-0-cb9f7d49dc52@redhat.com>
In-Reply-To: <20260717-fix-v1-0-cb9f7d49dc52@redhat.com>
To: qemu-devel@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=1460;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=vLdcAxZ8xQPI4i6TVMAkpWJIUU2DGKECrUR33XNoTng=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqWheaFZEso9QZyfka6/XhTGozpxaQPPZWLQHUi
 WWQEDrG0l2JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaloXmgAKCRDa6OEJdZac
 5cajD/426qHQvqN5zQR2MS4QM5++TiVQRLbhVPhGlcK9nSrCdE3CPx0MgrB0/JvjbCJUGrMBfQ6
 dLukjoHmQtIHBPfGW9ltvf3oXvY/nYxL81P5WUcsUy9SWqu6qLGt6TRQsSPOxQA7dNZeGbq9AB8
 /JX8evXFyBjvBfK1KWxqKmCNywTWk7QRvaZXGKSPCLbuBGcyn7h8OnMVnmCVEgsYGQzB8MtuV1F
 ddKETfncajLha/fzrE34kPbrdKANcT3TNZe4y1T5BTXCiBDJPouzCvGmUOmaJFj/cvmW2aTICTL
 IJNbYeCmAaTKmGUCzlVbE4bpn9L0DP4BFEMIeAtQeBDxwW1Vd9bNF++cKjIJJF8nr1bwY2RTZGj
 efgTVgWA7sRA+sKZs4traJdhGh9bQ37MzHnxjgQCefxhr9FQCnCMkCQvVdbXHpGwlFjsj7oLuwv
 +SJUwi8mS2LcSC9jv8yn1UhI1uoVeflB2d3fYJnfO9tIa17oV2suU7tFLLILdF+NsDUghN/6RYC
 oC11Q1ydlyGnqRfB0KQfp6BJqTorFeCEdYmJ4dbgqrl9wyPfhT9LAH3fehgN5Mma0vE28iomvi3
 Tdnu/JOq+Xj/Hrxt5uQwuG50bb5VsL7iEenLHFpPmI2GUMZ1cwx9Eu1/iJzjqPvblughFM1t8wb
 gxNEv99lVTTdufA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: permerror client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_PASS=-0.001,
 T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

When virtio_gpu_create_udmabuf() succeeds but virtio_gpu_remap_udmabuf()
fails (mmap returns MAP_FAILED), virtio_gpu_init_udmabuf() returns early
without closing the dmabuf fd. Since res->blob is never set in this
path, later cleanup via virtio_gpu_cleanup_mapping() skips
virtio_gpu_fini_udmabuf() entirely, leaking the file descriptor.

Call virtio_gpu_destroy_udmabuf() before the early return to close
the fd. This function already handles partial state correctly: it
skips the munmap when res->remapped is NULL and closes the fd when
res->dmabuf_fd >= 0.

Fixes: 9b60cdf98723 ("virtio-gpu: Add udmabuf helpers")
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/display/virtio-gpu-udmabuf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/display/virtio-gpu-udmabuf.c b/hw/display/virtio-gpu-udmabuf.c
index d5ac1cfca0e..5f08c855dde 100644
--- a/hw/display/virtio-gpu-udmabuf.c
+++ b/hw/display/virtio-gpu-udmabuf.c
@@ -143,6 +143,7 @@ void virtio_gpu_init_udmabuf(struct virtio_gpu_simple_resource *res)
         }
         virtio_gpu_remap_udmabuf(res);
         if (!res->remapped) {
+            virtio_gpu_destroy_udmabuf(res);
             return;
         }
         pdata = res->remapped;

-- 
2.55.0


