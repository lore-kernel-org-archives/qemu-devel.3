Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA0E4C55ABA
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2026 19:28:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrKn5-0007S0-W0; Tue, 04 Aug 2026 15:27:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wrKn4-0007Rh-RB
 for qemu-devel@nongnu.org; Tue, 04 Aug 2026 15:27:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wrKn3-0005DC-DA
 for qemu-devel@nongnu.org; Tue, 04 Aug 2026 15:27:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785871624;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xLTgyxY9t4cPAN5vmpA9Vq9M1u5pAtCooxqyWOTxbao=;
 b=BZ7fjWGR0cwFZeR7bi8k3TjE4wM/HKb1VRMBnn0XhKdDdGp8mHD7jDBZ9J8007g7ZHIxtd
 keQ6AWS97+sEoi6VbuRntwx3v0vCEalNfdVktHdTDQIxX3ZKM8gj2WIUOD1wiVvl/Ut+Cz
 O+fsZpBSEydwrnvJEEEiGHFGVojVoiE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-437-A2ZBicCbO3SA7IeR12RGEg-1; Tue,
 04 Aug 2026 15:27:03 -0400
X-MC-Unique: A2ZBicCbO3SA7IeR12RGEg-1
X-Mimecast-MFC-AGG-ID: A2ZBicCbO3SA7IeR12RGEg_1785871621
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9549B195605A; Tue,  4 Aug 2026 19:27:01 +0000 (UTC)
Received: from localhost (unknown [10.44.22.2])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4ADC51800480; Tue,  4 Aug 2026 19:26:59 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 04 Aug 2026 23:21:55 +0400
Subject: [GIT PULL v2 8/9] hw/display/virtio-gpu: Unmap DMA regions on
 reset
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260804-fix-v2-8-70e8fe489c9e@redhat.com>
References: <20260804-fix-v2-0-70e8fe489c9e@redhat.com>
In-Reply-To: <20260804-fix-v2-0-70e8fe489c9e@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1303;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=6pt76Ocwcwq2ZkN5Bq1JB7UBUtXQ0SHmKMc3+x+kQHk=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqcjzU5SkQjwevxdQylNPx5QMdtgQj1u6XJ6DHq
 X5zSZPitaWJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCanI81AAKCRDa6OEJdZac
 5afUD/9FQ223J8O1WWGooXi68HMQH5jk/Sh7XGp6BipqNGpFxTOxtJ/Tz1MBfKVlx3o1sMqnzj4
 8omGaUs27Vg0e1Ex3TAo3qXoLTeUItTtGH+5mr4Hzh252od6Deze0nkE7p2RTB48vbk6CtTwLvg
 FWUg6ZD3ghwOz2yNUhE1hRpHtE0IpVtAOotwcnevfvJWHWymS9rqQ+z2rT4JNqHNmm/jY9ITd7c
 yZXS2oGfw22QqfxNAAJyUAhX/qvENDBQu65iV7iH4SxuV1G3dTwsq2hmdLPXJKciayZy3FzJSPe
 prt7DPB0qutAYkUpSheD7t4RHpcz37Wlgm1hLyUZ63GcE1LQbHdOEBTTW5AbIqTayOGFCMV8z9F
 CUkmtjCTnBio9lwg6GngqX1ncRqQ8THLTDZwqS5kE3+xmaQ9K5+uWxFQnnoCZnwXFV50Ica99+1
 sHdI/2/OEFr6y6taPyN/TuOJxeFPUDenk6gapbM80jTjTatV0slbYuQi+Iqa9UlDdzKzlUdEfuv
 MOyrs3y+649B0J9eGKdNIYWFQ+dQ+EZjifr/dyVqEQ9XtL97TnEss/puD3oJOP9v0olTEsOpvR6
 au8WhaXqp5bG86gHXev729mCRaioe6jKwdXxlMzxuU/RDoVFoB6hjHQI6YaECXfpVMFs9yOZA60
 AJjDn+J+APHE/uQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.795,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


