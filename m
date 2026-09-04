Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA5D3C61DD6
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 13:13:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2Tgs-0003TK-3S; Fri, 04 Sep 2026 09:10:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x2Tgk-0003Hq-C6
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 09:10:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x2Tgi-00051X-0S
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 09:10:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788527434;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wjrug66JF7sj2Em1iOXDLtWW+CYxXnfe2H2hXOKSaUU=;
 b=Qjdj0mim7kfxOyoOBi0vjzbNkR5YLOBJLds2nKKOKq1eVFYUWXgtYq4s/NzFav93VxqbC8
 zDWklWX4OxUgUEMqwrwCU+E2GfvvD25eKEu9rsNaDsK7/12jOMdLZ3ffLlo/N+xSQPR+s9
 yHP9pfbN+rCrL86DI4pahjR7Ld+SVdw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-79-rcuulTDkOuydoLBZBAF0nA-1; Fri,
 04 Sep 2026 09:10:31 -0400
X-MC-Unique: rcuulTDkOuydoLBZBAF0nA-1
X-Mimecast-MFC-AGG-ID: rcuulTDkOuydoLBZBAF0nA_1788527430
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 213151801314; Fri,  4 Sep 2026 13:10:30 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 357B91955F00; Fri,  4 Sep 2026 13:10:28 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 04 Sep 2026 17:10:08 +0400
Subject: [PATCH v2 04/25] virtio-gpu/virgl: free BHs and timers on renderer
 reset
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260904-virtio-gpu-cleanup-v2-4-15b5ae6b0023@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1353;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=pjazvMH3OTm4G/gkcv4HVSFx91Q4hZxlcUF0x0N0LS8=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqmsMvFToo+kejW4pAC6TNLOmw580cx8me2WLnl
 CCedRhlW+iJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaprDLwAKCRDa6OEJdZac
 5ecVEACIkzyTahFzt/+wHL0Kh/mFCrFhoUg8icjH03SRArGoUC7we0j+3dZuO1Yub1V94JIsFmG
 8qfQIYopZJ1m2F8kqlrMNjBnuMVaYIuLTX/Ue79FTETiCo1BY17zjFf5cnSglF+p1JviOgXOktH
 +Vjyj3APPkt8TZllcY6z4n1xikb4C1JZTbEcGbz2wEexndntjrQXF/NnF5Mfd3AiAeSjfFBzwdt
 Ieuy3x4Pi75R8VCE3csJX07Lb1kOmNPMLs65VxkMgp2jRUiZferJe8hFrwR31jQa1dQZyMVF+Nz
 0gQ6FURRgo73IWVQzZf5UPOmtLg0Jj9q/g1eazPX9JnqfOfSe5q6D5DjtpWaASj6lRPnu7fUMLh
 XqfexlqPNadAZkARM1IYx8UmjvaCwk/hcSyvQUu0a2kA16p+e+f1XvkiAlCHVHvsjxneK9/8cFa
 g/s0xiljwkfq5hryvHh2YicCO8oBWswZjnLAYZJYfC4341FCyNAkhkrdfnPvgCpUJgaYHncxH20
 UnVmYJ8G5Qlj15odSHXQGgy40RGd+ENtiOl5VrZLLZqArQcwZbyAhq/6AXaUl9S9gY2xT2EshfL
 191u92WkfsafaA+mhfsY47bNl/1D/X/tTBsMywkuT7MHfGRe0nsCfgPneKnp6c4hc3q4hffe+gN
 YHog/umRlH0yofQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

virtio_gpu_virgl_reset() does not free the bottom halves or timers
allocated by the previous virtio_gpu_virgl_init() call. A subsequent
virtio_gpu_virgl_init() overwrites the old pointers, leaking the
previous allocations.

Fixes: 7e688d1bf515 ("virtio-gpu: Handle virtio_gpu_virgl_init() failure")
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/display/virtio-gpu-virgl.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
index 742d9dde4a32..7f1d1e0c3276 100644
--- a/hw/display/virtio-gpu-virgl.c
+++ b/hw/display/virtio-gpu-virgl.c
@@ -1430,6 +1430,7 @@ void virtio_gpu_virgl_reset_scanout(VirtIOGPU *g)
 
 static bool virtio_gpu_virgl_reset(VirtIOGPU *g)
 {
+    VirtIOGPUGL *gl = VIRTIO_GPU_GL(g);
     struct virtio_gpu_simple_resource *res, *tmp;
 
     /*
@@ -1448,6 +1449,11 @@ static bool virtio_gpu_virgl_reset(VirtIOGPU *g)
 
     virtio_gpu_virgl_reset_async_fences(g);
 
+    g_clear_pointer(&gl->cmdq_resume_bh, qemu_bh_delete);
+    g_clear_pointer(&gl->async_fence_bh, qemu_bh_delete);
+    g_clear_pointer(&gl->print_stats, timer_free);
+    g_clear_pointer(&gl->fence_poll, timer_free);
+
     return true;
 }
 

-- 
2.55.0.543.g5ebe2ebe4ea8


