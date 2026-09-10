Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24232C79F9F
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 13:32:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4erU-00028R-HP; Thu, 10 Sep 2026 09:30:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x4erR-00024z-Dv
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 09:30:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x4erP-0003cz-9D
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 09:30:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789047038;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wjrug66JF7sj2Em1iOXDLtWW+CYxXnfe2H2hXOKSaUU=;
 b=hIDfe4w+HuvS9aUQz9/MHLJ/yz8W6kwCR64d7IaG0RMssKbHQmXzzX9WRbMEEwJysy03y1
 5GHuz32RaoBc3vWLZ9UrVKMCwcMgAaZePsQ4/nimA2jkANk19haQv3bOWqG6yhBQxzOsAr
 Lfg6ReDDZPOFoJBvDvnuFtauJyjzThc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-414-Xv60WpmRNCe-lnI_Jfu1Ag-1; Thu,
 10 Sep 2026 09:30:36 -0400
X-MC-Unique: Xv60WpmRNCe-lnI_Jfu1Ag-1
X-Mimecast-MFC-AGG-ID: Xv60WpmRNCe-lnI_Jfu1Ag_1789047035
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 593111955EB7; Thu, 10 Sep 2026 13:30:35 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CD8761955F19; Thu, 10 Sep 2026 13:30:33 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 10 Sep 2026 17:29:59 +0400
Subject: [GIT PULL 04/24] virtio-gpu/virgl: free BHs and timers on renderer
 reset
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260910-virtio-gpu-cleanup-v1-4-ccb8927a671e@redhat.com>
References: <20260910-virtio-gpu-cleanup-v1-0-ccb8927a671e@redhat.com>
In-Reply-To: <20260910-virtio-gpu-cleanup-v1-0-ccb8927a671e@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1353;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=pjazvMH3OTm4G/gkcv4HVSFx91Q4hZxlcUF0x0N0LS8=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqorDbFzvr5aOPCondX5x3+RYdECq6ApO299KBz
 B9xZBvA1ZaJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaqKw2wAKCRDa6OEJdZac
 5Vx0EACpvGUrBpoLga/bHPvY/hHNVWfSeG5cesMW3pKNr9RL6Kg7PbtwyZDIbCV9wv52eCHgzXi
 I9rnISNwJQeoiLZErMFSi1HsfzCpOKJJWLERPvCGw1PkjLrlReh2Y/FIiMApriJyNoXwUxBiDed
 gWIbwg2Q35ZHM3ZA6ExJ67I9+GpMgLQG6gvJq2cf9DQ0BSEEiaYC3Lnkd7lBdOKDz+Pd1cbamSA
 eS3RNYAaTxN90gygH6uwGEDav9RFop3KPTerYrzbeAAaiNHFbceIcEzLrbu3UeGbtpEhCs1+5Uk
 YcFcO5OB2FgbJBwv+a1J16XTdDxwHu1G81rzxR7HaugobxYwlxUgv90C3tiDAIGRxHQnSV8ZT3b
 rH7Fw0dHAiKTMORQQAZOXU+L2JJVJprqCiqgBGTMKtgraJ+S1P/mIxTZ4JDdwC6Q0aGbB7aOh2T
 mJGoG6bOk9H36AvdTFXcg0RvEHV6QcTPDlMM/9RaJq0n37ZRUUoR2NDiFQzJSQ5PIGwL7q6OuGO
 e5iEVIwMRvSoex5EOWAH6UIKsVmFP45AHhRNPc1NE30TBqFKnQiQ0mUP3EpSFNUB1qtKMyi1s3Z
 eSz5mOCm8InOewD4eS4VrcTX7UYSvUkIZe8PEfodjXEXkXsIBxRmBZaRKsWzdTHB3dqAMwVN1p/
 0o+C76jH6tmhSMw==
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


