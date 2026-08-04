Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 085F8C5518F
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2026 07:21:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wr9Sf-00039K-GE; Tue, 04 Aug 2026 03:21:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wr9Sd-00038u-QJ
 for qemu-devel@nongnu.org; Tue, 04 Aug 2026 03:21:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wr9Sc-0001Xr-9h
 for qemu-devel@nongnu.org; Tue, 04 Aug 2026 03:21:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785828073;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xLTgyxY9t4cPAN5vmpA9Vq9M1u5pAtCooxqyWOTxbao=;
 b=D/I9UexnAPi6P+D408b41ij2nE9zjoHcH9PXI/kFGURhCaFXACvjE9j8fPYlXJKOqTYJ1H
 sCbaaIV6VnSQhtJtfTJqNammleKKp5/9C/15Wjn/3x2Dp0Y+jnFrnQEt0swpBFHo9zjEOf
 Jih7oPxFF0b6z7z1wd9cOpKk82Gga2w=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-79-KMuBmVa-OH-SNGqKmrnzdg-1; Tue,
 04 Aug 2026 03:21:12 -0400
X-MC-Unique: KMuBmVa-OH-SNGqKmrnzdg-1
X-Mimecast-MFC-AGG-ID: KMuBmVa-OH-SNGqKmrnzdg_1785828071
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EDD76180057E; Tue,  4 Aug 2026 07:21:10 +0000 (UTC)
Received: from localhost (unknown [10.44.22.2])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2124C300019F; Tue,  4 Aug 2026 07:21:03 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 04 Aug 2026 11:18:57 +0400
Subject: [GIT PULL 8/9] hw/display/virtio-gpu: Unmap DMA regions on reset
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260804-fix-v1-8-0c2be5390809@redhat.com>
References: <20260804-fix-v1-0-0c2be5390809@redhat.com>
In-Reply-To: <20260804-fix-v1-0-0c2be5390809@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1303;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=6pt76Ocwcwq2ZkN5Bq1JB7UBUtXQ0SHmKMc3+x+kQHk=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqcZJdNRcM6gwc/02TQ5MnL7EqesJaJTc4FZjce
 eijx5SXGGSJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCanGSXQAKCRDa6OEJdZac
 5blqD/sH6Ugjs7DIopypDFg65ZZYjhtolONc3d6qo2q4BXMQm+rRVW6eAEuQRKlTnfz3D610YXV
 j+JLjBrzp/K5rIcPgQVk6/EJnJ/OC5+V2L43tr3krqPVfdsostn1J2/hzN7DQDYrvez5PIAOhBT
 ShD7q9lo5fGjNgKexuwrRjwe4fwP+XW4GPqwoKOR81wHO/8MwR+3geo7xgnzELejK+W1m8VcpQG
 4Dur7F9D22iH70mgwvVPswAXWPRxmcn7uH7mpZ/k8+hJ95z28Cs8Ug2kMQBJZMKMTXMyB+ENvpk
 5bXyyFY2D/sc2Khmgp8DMSDH5WuF2cEjF2/HEshyut3k/xnt3zE5V6cATknIOT2fwno1VMBH+TS
 K4yMp+lyLiJ+VusBw+4M7bc3Qj7mAgb4g046hm250L8xSsu4V5ksQMllOdQVS4RZpQvPIcXo1zR
 lTzUojlAv8oSx5iF/e3rhIcz/McTuXJq76gYMQ9DACKNhQmqLYYDARUCZcS99iArOICxG0GOG0V
 WM/1hSgjzJuFgp5TxgUPpZJ1w0Rmt5ryzjYLwNiViYBxuNYz8L7Qdh7kWM1/qvSr2IH/vG3Hcax
 PHIH//ZwF0lB4i6k2uBVCH5QP2I5wn+V+LleHHqX1yk4ARFVDkDAL1BGK99xTPQ07Uy/ieSihPc
 aMBSJ/E0fePUI+Q==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.811,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Bin Guo <guobin@linux.alibaba.com>

virtio_gpu_reset() freed in-flight commands without unmapping the
DMA regions acquired by virtqueue_pop().  Call virtqueue_detach_element()
before g_free() in both drain loops.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3467
Cc: qemu-stable@nongnu.org
Signed-off-by: Bin Guo <guobin@linux.alibaba.com>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20260803082158.62998-1-guobin@linux.alibaba.com>
---
 hw/display/virtio-gpu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index c15d4b527d0e..fbb6fec7a0ad 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -1725,12 +1725,14 @@ void virtio_gpu_reset(VirtIODevice *vdev)
     while (!QTAILQ_EMPTY(&g->cmdq)) {
         cmd = QTAILQ_FIRST(&g->cmdq);
         QTAILQ_REMOVE(&g->cmdq, cmd, next);
+        virtqueue_detach_element(cmd->vq, &cmd->elem, 0);
         g_free(cmd);
     }
 
     while (!QTAILQ_EMPTY(&g->fenceq)) {
         cmd = QTAILQ_FIRST(&g->fenceq);
         QTAILQ_REMOVE(&g->fenceq, cmd, next);
+        virtqueue_detach_element(cmd->vq, &cmd->elem, 0);
         g->inflight--;
         g_free(cmd);
     }

-- 
2.55.0


