Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CDABCD98D6
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2026 19:13:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYqAt-0001Eg-A7; Sun, 14 Jun 2026 15:07:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYqAr-00014w-HL
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:07:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYqAp-0001v9-7j
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:07:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781464030;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JmyJVNdxvqpFL0dv00OCrhFq3kla9VTy5HUktDdpb0c=;
 b=ioEMTQWjRryi6oe8MWWvutFF8xALQOHFlbCZHsWbKnywpVIGi/CVQK50zYc+F5j2/hxk3a
 GOjzcPpGxBlrP4vDfryQAZSpsOjH6lmPSxxPMXri3gj+cJGZDHybf1rsGnUVIFhAx6NwiI
 ohW3eAiHeprnpltyb0TzuqwL1jbwGAA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-397-pJDqvXdJPqa-nI24C5IbNA-1; Sun, 14 Jun 2026 15:07:09 -0400
X-MC-Unique: pJDqvXdJPqa-nI24C5IbNA-1
X-Mimecast-MFC-AGG-ID: pJDqvXdJPqa-nI24C5IbNA_1781464028
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-45ef4931de5so2131951f8f.1
 for <qemu-devel@nongnu.org>; Sun, 14 Jun 2026 12:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781464028; x=1782068828; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=JmyJVNdxvqpFL0dv00OCrhFq3kla9VTy5HUktDdpb0c=;
 b=pKq3/KfDFX9P4+7yfyoVg0byrgwHhOcuJ/bDFBQrbCIBJj0y2JcdJbCOSHPY2gVwaU
 0FIwufSMebwZfOES9PnT9LQ4skCWjG21q1BIpZmDKjAlmZwny3dYzqfmiLX2QXFVpz+x
 2U5a7VfIl0T8CJEG8XecgrUxvaOYFaJ0J21bDs16Cy+yQgfE/gkItqHxHH7iG95Hceif
 ofb3ubyejnhsDzzG7YK1e3F8xcCxqGjIxx9QGdmjEzV32cKY4hopYiiKG2Ib4zMOgzUm
 z//SE+wSAuLX0uVKsuPDbmD15OGdduXNMdbVje8DSqdsjBgf6oiihFNWo/lrr/lh/KMu
 CehA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781464028; x=1782068828;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JmyJVNdxvqpFL0dv00OCrhFq3kla9VTy5HUktDdpb0c=;
 b=oMB+jsPsseQRONAuItbtR7ghF46K9qh74sZqZWL43k7ilh6OeZ66A5RrSgQl7w+Qzp
 rJDXJt7EMVT74l36jtdJ18jygY3ivorJ+AGBvQqK+f2QMuCKO1Nd++Qo0JOaQNgX7/07
 kHu7sMjAkGMDVlpV8Hzr4vwXsmVQH3+d2xkk9eHy/wUtYNxpx4ShIBjxlC7aKJYTCfcy
 2BHGL1X5tuJCvr7IXIi3lvAcduahYsG/X0jbDd/mxwMpOehDAoafnWJXq2TOpvk7Lv6f
 J36jy1m9noMjOLK3E6TWkkzOYyQpdATUZJn1JWNpN9w4+Xw4Vtt9dSrsM70fL0D/Lwoy
 xtGQ==
X-Gm-Message-State: AOJu0Yxrc4h3/V3VJl76Bl9qJnhT48CCgBW6solLjPKFIiOcTyWPZQLW
 09BpFE1xl8FHJJgZCZgS+B8Kw1XTPu/rRuk07n+TjHHsmBjHNytt6BVODDdU/E5MO6qY2z42Z0M
 9cILngwnXMUmz6ZtXj7JiNK3s3fhabLZ85jp8w4sX8YR+DNGGYeIMiGxU2ZxhCj8ZRN3FRq+FtF
 h8BI/gsTA4kBc1fWfr+H0odpdN+a+8E7JNpQ==
X-Gm-Gg: Acq92OHHFXRwimtkR1vs2oIKQiMEhUYXPlLRQglUFBpkz9OKQJeqaP+pU3VVCZtzQp7
 rLEkv9wdFD4fHY+k5b7PuweEW79w/g4dEa3IUt4dVoJ/SfhjNmR39Fb3TltcC0HzAegh1+vYfzv
 sKRBvQm8t8GVvoKc5YuymzfyO/wjmmwt9SRSqaGbcmHJHI/eaWVf6SdZJ1pnc3Qc93mBbwJIkMR
 alHJp5ElhIVGGiFmpmcJJJfZf+MWhEg2bm14tUusN6sK4mUWn6nGuu6ioRIF2Bbon7Tk/lHrSmE
 oAeN8kB6Kn0znV8X2JJfeSkgy+9AwDSGo34lOdMy3qVLZCak+PN70Ki2SGcDzgyMCW+3gowG7Tt
 vaxgfIvBLdLFmzZAAoAQyRJe+SU4g/KoSg59UOFSiDpM=
X-Received: by 2002:a05:600c:1d02:b0:489:32b:ac0b with SMTP id
 5b1f17b1804b1-490ec48fec5mr124765115e9.6.1781464027780; 
 Sun, 14 Jun 2026 12:07:07 -0700 (PDT)
X-Received: by 2002:a05:600c:1d02:b0:489:32b:ac0b with SMTP id
 5b1f17b1804b1-490ec48fec5mr124764695e9.6.1781464027272; 
 Sun, 14 Jun 2026 12:07:07 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4922037055csm191121755e9.13.2026.06.14.12.07.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jun 2026 12:07:06 -0700 (PDT)
Date: Sun, 14 Jun 2026 15:07:04 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Raphael Norwitz <raphael.s.norwitz@gmail.com>,
 Daniil Tatianin <d-tatianin@yandex-team.ru>, Lei Yang <leiyang@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Subject: [PULL 031/106] vhost-user-gpu: drop code duplication
Message-ID: <0641dfdac00ba76ffbe41c59291e5ad23c62c219.1781463125.git.mst@redhat.com>
References: <cover.1781463125.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1781463125.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

Obviously, this duplicated fragment doesn't make any sense.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Reviewed-by: Daniil Tatianin <d-tatianin@yandex-team.ru>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Tested-by: Lei Yang <leiyang@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20260420200339.708640-6-vsementsov@yandex-team.ru>
---
 hw/display/vhost-user-gpu.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/hw/display/vhost-user-gpu.c b/hw/display/vhost-user-gpu.c
index 6e5e6540a4..6f02314356 100644
--- a/hw/display/vhost-user-gpu.c
+++ b/hw/display/vhost-user-gpu.c
@@ -644,10 +644,6 @@ vhost_user_gpu_device_realize(DeviceState *qdev, Error **errp)
         VIRTIO_GPU_F_RESOURCE_UUID)) {
         g->parent_obj.conf.flags |= 1 << VIRTIO_GPU_FLAG_RESOURCE_UUID_ENABLED;
     }
-    if (virtio_has_feature(g->vhost->dev.features,
-        VIRTIO_GPU_F_RESOURCE_UUID)) {
-        g->parent_obj.conf.flags |= 1 << VIRTIO_GPU_FLAG_RESOURCE_UUID_ENABLED;
-    }
 
     if (!virtio_gpu_base_device_realize(qdev, NULL, NULL, errp)) {
         return;
-- 
MST


