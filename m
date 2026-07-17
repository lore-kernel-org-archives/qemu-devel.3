Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38BF3C44521
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 11:55:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkh95-0005uT-6l; Fri, 17 Jul 2026 07:54:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wkh93-0005tr-OK
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 07:54:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wkh92-0003Th-7g
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 07:54:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784289259;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TVeXjKZ9PQU3WPt/ZnTqRyme+JzWbiNAr/8eTl2v9XU=;
 b=dzDd56sRW0vs33ineGHE2fiKNtYXT9UlBYZi7pt2HfykFJnIIWdEhmLcycp9FiEdvlNfKT
 DR/iA8nM/wOnWdQ7tdpY05H2Qiem8cp3Xb0JuHvk1KfPWr6UWwyfal+t0+ZDc+PjIC9OIs
 FT7YsvFR5BMHfUyiguekpcBn35nyouY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-674-N53sqC5nPDqd3QUfKiCmrg-1; Fri,
 17 Jul 2026 07:54:18 -0400
X-MC-Unique: N53sqC5nPDqd3QUfKiCmrg-1
X-Mimecast-MFC-AGG-ID: N53sqC5nPDqd3QUfKiCmrg_1784289257
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6CC9C1954237
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 11:54:17 +0000 (UTC)
Received: from localhost (unknown [10.44.22.17])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 863733004180
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 11:54:16 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 17 Jul 2026 15:52:53 +0400
Subject: [GIT PULL 14/15] hw/display/virtio-gpu: reject strides exceeding
 INT_MAX
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260717-fix-v1-14-cb9f7d49dc52@redhat.com>
References: <20260717-fix-v1-0-cb9f7d49dc52@redhat.com>
In-Reply-To: <20260717-fix-v1-0-cb9f7d49dc52@redhat.com>
To: qemu-devel@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=2162;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=GmgZk+S+DfdSu7csUhCv2ZCT0ku4rxhnerEsjmN1ofk=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqWheaKYEX3Sk9m+qUnvkeaW48K9l3fyT8Og+3y
 06OO+nyNcWJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaloXmgAKCRDa6OEJdZac
 5RYVD/4rL6H4NxliTOKO/ddUvAM2Gq29pxIH5uElXq4sgc9vlbGsQx4V6V+yyMF6AxONmtfgoqw
 VW9zmDHSWhG1fEnpwYROQAFLxg2cOdlRxfaXLq6UpDwM+vQKKKFvX+lkswEclfiL0+ym/cTiVky
 pMblrQhN53P6Lp5LZrWkV0cBQsfeD+hHHGPAI1H/nwLuB9m8Fuv5yV6pphgzxdFby5sQ0YaHtjq
 VNocUW9qTR9yyY5vNXuTjg1XWWn9YMpc4bwHc1bLAom/l9HaTZ3Qs7KbWCMZiYGSNEADwJd3SwT
 A3aDojro9XoghknxSu2fYnTGmGbH3Z/Bx2TA6evM2qC2HFm5cjm8OCB41MVc66UShp6adTYIC8w
 r4NIlVB3D1158lfwgiVlmim/bkZoLEoUY3mwZzRv/vFAbZyyY8N1a0wuJB7oSl2jiol8ZlgLW14
 yVziDut/ZlmXVljkycPIQkAlIfK3+UP2bhElOvbv7iOXQnjp8XqlAFtm9pxSvvJp9rYJxvdpkU9
 pFmyrTFTicSF4XXf0JA9V0Qa9IGQJr0Zl4cLAqA+wLnp1r+pvHX7Z4tMeVmeBkveFcWVwPEiuoo
 1En0wvdi/VVfE2VrW5mWmRQiAtxbd9gzmszNON41dUYmaLYpM75rFrzaysCUTBw89GQRXhmb1C/
 iQzs8I/gR1pDeyQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: permerror client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 T_SPF_PERMERROR=0.01 autolearn=no autolearn_force=no
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

From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

VIRTIO_GPU_CMD_SET_SCANOUT_BLOB supplies a guest-controlled uint32_t
stride, but some downstream consumers take it as int. They may interpret
a value greater than INT_MAX as negative and cause issues:

- pixman_image_create_bits() takes the stride as int, and Pixman may
  later access memory before the blob buffer.

- eglCreateImageKHR() also takes the stride as EGLint when importing the
  DMA-BUF, and Mesa rejects it.

Reject such strides before scanout.

The check in virtio_gpu_scanout_blob_to_fb() rejects unsupported blob
configurations early. The check added in virtio_gpu_do_set_scanout()
covers migration post_load.

Fixes: 32db3c63ae11 ("virtio-gpu: Add virtio_gpu_set_scanout_blob")
Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20260717-int-v1-1-8aa05e1791a0@rsg.ci.i.u-tokyo.ac.jp>
---
 hw/display/virtio-gpu.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 048b151872e..3090edf89a8 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -654,6 +654,14 @@ static bool virtio_gpu_do_set_scanout(VirtIOGPU *g,
         return false;
     }
 
+    if (fb->stride > INT_MAX) {
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: stride is %" PRIu32
+                      ", larger than the supported maximum (%d)\n",
+                      __func__, fb->stride, INT_MAX);
+        *error = VIRTIO_GPU_RESP_ERR_INVALID_PARAMETER;
+        return false;
+    }
+
     g->parent_obj.enable = 1;
 
     if (res->blob) {
@@ -769,6 +777,13 @@ bool virtio_gpu_scanout_blob_to_fb(struct virtio_gpu_framebuffer *fb,
         return false;
     }
 
+    if (fb->stride > INT_MAX) {
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: stride is %" PRIu32
+                      ", larger than the supported maximum (%d)\n",
+                      __func__, fb->stride, INT_MAX);
+        return false;
+    }
+
     fb->offset = ss->offsets[0] + ss->r.x * fb->bytes_pp + ss->r.y * fb->stride;
 
     fbend = fb->offset;

-- 
2.55.0


