Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E444DC56201
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2026 19:26:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrKmk-0007CA-9H; Tue, 04 Aug 2026 15:26:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wrKmj-0007C2-Ay
 for qemu-devel@nongnu.org; Tue, 04 Aug 2026 15:26:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wrKmh-00059d-Nz
 for qemu-devel@nongnu.org; Tue, 04 Aug 2026 15:26:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785871602;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JBuZeH/hyIo3fbh1PQfwbL8P51yWnlk8B0Vwt9xpvUY=;
 b=Wc4k592nHl0nleoT0AvvElMDeMWySidMzaQQvNbH0KN0rnDN2Dm0+RvCFFLnz2oYFu9yle
 caBUOHqiQVeUgd0yQu5G5Hebuf29HdSz+3/kXkJkQpntaaPNEpY/EF0SWQ3BJTyV60XHoN
 hnZxtZjtm8sfY9ietaSidq7Bq8fXFBE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-640-GiRBMkbbNxmgBFjyxatTPQ-1; Tue,
 04 Aug 2026 15:26:41 -0400
X-MC-Unique: GiRBMkbbNxmgBFjyxatTPQ-1
X-Mimecast-MFC-AGG-ID: GiRBMkbbNxmgBFjyxatTPQ_1785871600
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1AED91956069; Tue,  4 Aug 2026 19:26:40 +0000 (UTC)
Received: from localhost (unknown [10.44.22.2])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A9D5130001A4; Tue,  4 Aug 2026 19:26:38 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 04 Aug 2026 23:21:51 +0400
Subject: [GIT PULL v2 4/9] hw/display/virtio-gpu: fix offset wraparound in
 scanout_blob_to_fb
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260804-fix-v2-4-70e8fe489c9e@redhat.com>
References: <20260804-fix-v2-0-70e8fe489c9e@redhat.com>
In-Reply-To: <20260804-fix-v2-0-70e8fe489c9e@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2466;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=FfMPC0vcyAbfCBx4BJKAkGllsY7YFmvTU8YJxb5Uii8=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqcjzUh8lofjE6WNnOeaQWHxiFv6J51SI4Q+qdj
 hRzR467FpuJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCanI81AAKCRDa6OEJdZac
 5ZxNEACbAeclCDWq0lgJez8AIJ9JBhmDGnxtwBYt+1nkjRpZgzb62YOaSEwtohoL2OTnoIw5zXF
 AxpauUrKAUNM8Z3Zzkd/Iyy/y8cCjeMtAAzNl2rCbkU0PZVFr6e52Cn/5SAOwT/IYr/PAc1qqz0
 PgXMswKa4OD44+BfUw8XgOl7norvF2BxU1eckZdjaZArGnpTgCyNEVW3Znh84gUtOa9uTwugXFO
 izd5Kvejp7FVcQVb+dfqR8F7yQC2gdvF95lku9rSumY410/FYZJslqzdjowwVTmKdTSvPLBMSDQ
 bn95SyyaiAoYFBQd3l+FE/Og5YaKe1TQ3DMME49nkKG7VWy9dQ+dX/OTmYgUl65IulUJMhX5ojJ
 QNlY9a23bdyBaRItFYVaM44LDcvLbmHagUdWHVtCsOpSZFFd5oS7mIs8w3fKfomhZk15p8FFxzD
 zoJdlaPwwvmAKBiDDK61IbFhERLyMPup9mOZZdcIe+cgDWHEmspfLhtrL91y0CMsGyxOf78Zg+M
 /l+Juy1c0RDQv6eyXmdMkfieYxAIB0jHcGPa8kM2cbWe4RskiXLZ5GTURQ35oPy8e53egXOAvjx
 E6PLTv8OUpRK4FwAGhI04gVNEVZIfr2hy+01ORik58fhI1KFJFdHpg6ee+RkVhXn004gkHpdh/M
 NGnXo7ODaxY8TEQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.795,
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

virtio_gpu_scanout_blob_to_fb() computes the framebuffer offset from
guest-controlled offsets[0], r.x, r.y and stride using uint32_t
arithmetic. When the sum exceeds UINT32_MAX, silent wraparound lets
the guest steer the scanout to an arbitrary in-bounds region of the
blob instead of the intended rectangle.

Compute the offset in uint64_t, reject values exceeding UINT32_MAX
(the width of fb->offset), and only store into fb->offset once both
range checks pass.

("[PATCH] hw/display/virtio-gpu: Remove the bytes_pp field")

Fixes: 32db3c63ae11 ("virtio-gpu: Add virtio_gpu_set_scanout_blob")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3871
Based-on: <20260719-bpp-v1-1-9b91946d6cf3@rsg.ci.i.u-tokyo.ac.jp>
Reported-by: Cyber_black <Cyberblackk@proton.me>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20260725122734.1775774-1-marcandre.lureau@redhat.com>
---
 hw/display/virtio-gpu.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 0206910cc377..51592b49c21e 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -777,7 +777,7 @@ bool virtio_gpu_scanout_blob_to_fb(struct virtio_gpu_framebuffer *fb,
                                    struct virtio_gpu_set_scanout_blob *ss,
                                    uint64_t blob_size)
 {
-    uint64_t fbend;
+    uint64_t fbend, offset;
     uint32_t bytes_pp;
 
     fb->format = virtio_gpu_get_pixman_format(ss->format);
@@ -807,18 +807,20 @@ bool virtio_gpu_scanout_blob_to_fb(struct virtio_gpu_framebuffer *fb,
         return false;
     }
 
-    fb->offset = ss->offsets[0] + ss->r.x * bytes_pp + ss->r.y * fb->stride;
+    offset = (uint64_t)ss->offsets[0] + (uint64_t)ss->r.x * bytes_pp +
+             (uint64_t)ss->r.y * fb->stride;
 
-    fbend = fb->offset;
-    fbend += (uint64_t) fb->stride * ss->r.height;
+    fbend = offset + (uint64_t)fb->stride * ss->r.height;
 
-    if (fbend > blob_size) {
+    if (offset > UINT32_MAX || fbend > blob_size) {
         qemu_log_mask(LOG_GUEST_ERROR,
-                      "%s: fb end out of range\n",
+                      "%s: invalid fb bounds\n",
                       __func__);
         return false;
     }
 
+    fb->offset = offset;
+
     return true;
 }
 

-- 
2.55.0


