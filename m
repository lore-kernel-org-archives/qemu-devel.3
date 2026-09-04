Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88C1DC624D3
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 13:10:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2Tgd-0003C7-Uw; Fri, 04 Sep 2026 09:10:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x2Tga-0003Be-G0
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 09:10:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x2TgW-00050M-VS
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 09:10:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788527424;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5HEkwSuzOhXmto7J4E5NF2/noKk26U+3km90AD2jdMc=;
 b=VaGDJrmDFYSfe2v3BcRfFXLSuMDsHM5//bLm7pV0QYZST4Cdk+oyZgzWffeLe9EGd3WwHd
 zaALmXqo83/wN6Z4G2PS1k9qe8/PP/VS/7wvdJxgDVu0idnkvqDcKrAX/2vupcSSaGhVUe
 a3W5mLbn9TGgcgyvyEgI1vipovHT0dc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-586-1QTPQ1Z1PqylOAn1xiyRIQ-1; Fri,
 04 Sep 2026 09:10:20 -0400
X-MC-Unique: 1QTPQ1Z1PqylOAn1xiyRIQ-1
X-Mimecast-MFC-AGG-ID: 1QTPQ1Z1PqylOAn1xiyRIQ_1788527419
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C5FD9195FDE8; Fri,  4 Sep 2026 13:10:18 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8EA831955F00; Fri,  4 Sep 2026 13:10:16 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 04 Sep 2026 17:10:05 +0400
Subject: [PATCH v2 01/25] virtio-gpu: disable blob scanouts on mapping cleanup
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260904-virtio-gpu-cleanup-v2-1-15b5ae6b0023@redhat.com>
References: <20260904-virtio-gpu-cleanup-v2-0-15b5ae6b0023@redhat.com>
In-Reply-To: <20260904-virtio-gpu-cleanup-v2-0-15b5ae6b0023@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, 
 Alex Williamson <alex@shazbot.org>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1301;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=q3zv9zCNGeUcSlIz/E/RqZ/72w8TCNyB/dnNjsQxhws=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqmsMvctzR/V5VSitPYL48MzD+laK/Xmf0K0ln5
 Y2KkCwBCseJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaprDLwAKCRDa6OEJdZac
 5by6EAChuuk45bvy1SOENvf9nPKDgVGicwUqCLJLR9Xw0vlDUk4RUFGGuuOO6rMaV7ut7OjOxBs
 U1zS8BIrYKoimeWT0DsQDhZ5DJYQx3MQR8gSDQ37m0HdJmhlVTmfMJJ9p9IGUI9Ejz81AKsiUMw
 QEuuJdEzrkqRkowLJ3mMPgf61alGrV27o4imZM/klcoapimXjgEVg9KmYlQjTzkAgWNzVjQRCyt
 PsXnfUrRnNkrcX9iHakod64u1qWKX4HzHD0jxXCazh8S0yfZUDaYcvoS3U3RyaYQC4C5HYa1jOd
 Aw4FPGDvmkZ+rwTTDc1O9I4Zeu44KTZEA0SHTgIN0TBEBlt/5N0N/Iek19FRn53ZVt9hT2ayge/
 fX34xsECQNfs1jrtatOpuweEt0ycU5cLcsbi6a7+GgQND/0L+UPH97SBK+3aADs0LHZzZICs3Kg
 fn8uqgo2OqA2rFYmGwqXBSQnIhy43aSaZywMO7RsqGUmD4HhJoLV7M98zgayGUeG/k6rtxlkpSQ
 C3idE2kqILwvEob6Dd+RFOmnKh6HlqerkkPY85g6581xPdilMnoHD/nDsCHH4T6F88NdhOhZmWA
 F12qYHVAdkyK0ec7I8slYG1CX/LM2FMPen5cjDPh6x6X663IrG7OqoQqJdrO9rM68QzcouLDGNq
 vcDjqGhAtT+paMA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

When a blob resource backing is cleaned up (for ex via detach_backing),
any scanouts referencing it must be disabled first to prevent the
dmabuf from outliving its backing memory.

Fixes: CVE-2026-66020
Fixes: 32db3c63ae11 ("virtio-gpu: Add virtio_gpu_set_scanout_blob")
Reported-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/display/virtio-gpu.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 55a1c7f80fb8..5b63a292933a 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -1022,6 +1022,16 @@ void virtio_gpu_cleanup_mapping_iov(VirtIOGPU *g,
 void virtio_gpu_cleanup_mapping(VirtIOGPU *g,
                                 struct virtio_gpu_simple_resource *res)
 {
+    if (res->blob) {
+        int i, max_outputs = g->parent_obj.conf.max_outputs;
+
+        for (i = 0; i < max_outputs; i++) {
+            if (g->parent_obj.scanout[i].resource_id == res->resource_id) {
+                virtio_gpu_disable_scanout(g, i);
+            }
+        }
+    }
+
     virtio_gpu_cleanup_mapping_iov(g, res->iov, res->iov_cnt);
     res->iov = NULL;
     res->iov_cnt = 0;

-- 
2.55.0.543.g5ebe2ebe4ea8


