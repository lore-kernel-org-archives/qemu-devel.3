Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE5C2C79FB6
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 11:03:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4G5l-0002FS-9I; Wed, 09 Sep 2026 07:03:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x4G5j-0002F9-Rr
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 07:03:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x4G5i-0005Ep-Hn
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 07:03:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788951826;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wjrug66JF7sj2Em1iOXDLtWW+CYxXnfe2H2hXOKSaUU=;
 b=Rdmu+L8HghkXqRUVHqzUnLUSZxGGyo7TXmaLSaYRclfdu3ylZFFO20Bm0nsVgce6K5u1kJ
 UCqLgqF/VB0sqhQzuay9O+/nT9VhXvYAosXF70v7+ye8cPv0Pg1eSzwkR6+mb0KDsq8/mM
 aYCgZgfnFNY2iqvVZvfQfQ2WJRLwoeE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-152-ALxAPdPEOMmZJNnPxNecAA-1; Wed,
 09 Sep 2026 07:03:42 -0400
X-MC-Unique: ALxAPdPEOMmZJNnPxNecAA-1
X-Mimecast-MFC-AGG-ID: ALxAPdPEOMmZJNnPxNecAA_1788951821
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6F1971954AD7; Wed,  9 Sep 2026 11:03:41 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D022F1800446; Wed,  9 Sep 2026 11:03:39 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 09 Sep 2026 15:03:09 +0400
Subject: [PATCH v3 04/24] virtio-gpu/virgl: free BHs and timers on renderer
 reset
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260909-virtio-gpu-cleanup-v3-4-99266590e79d@redhat.com>
References: <20260909-virtio-gpu-cleanup-v3-0-99266590e79d@redhat.com>
In-Reply-To: <20260909-virtio-gpu-cleanup-v3-0-99266590e79d@redhat.com>
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
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqoTzyIR3lBujTDdAJiESTnLtTn89BfrKWbWifz
 OGzIM0g3QCJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaqE88gAKCRDa6OEJdZac
 5WHED/4x+Vss34gpEbL+xvbaMOKL8zy1QmXcnQC8654Lq6GuPL/uGHxediEMyjZqXkn7av95rn3
 8XwN2mJCCtV2I2rTITDNmv+21wvrUacb6cEXhuRIHotDP7SelmOK0DoeKgNumlLBSXII+iS/QqQ
 oSOs+xTqyXIVmSte0Z10s+WdzkBWx/Wgy5DvDiyzr8ouhw2NjG+kXuMqL341l5/AMhPzGggfMO1
 kMJX9dmfoL8OuuJpXqpiSodkneQ5TrtQvuXpJk7gTfy7uENE69i6HeKihIUhzx/aQIzLk93FfA0
 WkQuhnfJ/t9G6vvbGMTo6ZDz1i4nQvws5tWn8hj6nQLWajmCcqyTsV8tOxgjXU8GRR5y8yXdBtY
 HtkF6rJS/wZV4pLPhXc/PpJua3/cBdnBW1T3BTTxEbpoQlxqqgUpV9zXGDqWcYEp+1/l6Ap7X2z
 lqSlEqENPwtGq/FmwcMjGw7QSbZKIc+8a4AGvjAvJkFSPHWCi1+bhOk2T78dmGOzuZLPHGsxn0y
 ATbIWi+l3IUwFgjfmt584RTsPeECdVdCSE6yVQNr52137Rm41cY5lpB3W7mUgT97YnHH1Zh+gze
 eBFRIvmWWSbTN7IFuHm8OWwDlR3Jg2MDWh7EVAA5AZctYTUHOHLmnv5xthR8SaaJrLnIYQf4FsW
 EwTzBUcFJ2jZDdA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
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


