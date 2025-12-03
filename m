Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98756D116F3
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Dec 2025 04:09:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQeAG-0002Eq-69; Tue, 02 Dec 2025 23:08:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <bounce.29vafx79xran0f5=p85mwoxbn3wq=m9n7svzbgw7c67@em483429.getutm.app>)
 id 1vQeAB-0002EG-Q3
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 23:08:24 -0500
Received: from a4i956.smtp2go.com ([158.120.83.188])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <bounce.29vafx79xran0f5=p85mwoxbn3wq=m9n7svzbgw7c67@em483429.getutm.app>)
 id 1vQeAA-0000Tm-EM
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 23:08:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=getutm.app;
 i=@getutm.app; q=dns/txt; s=s483429; t=1764734891; h=from : subject :
 to : message-id : date;
 bh=rWlEgGNDGz8jZNA1IbIgK4EKjt9rl3oL/zBZZeAdEyo=;
 b=V8AqVA8NvqW6yj9Dct3NU0lXdSDQr0m0Riw2+z5lLrLEUaXtBdRTfMmNfLstMcxM174Z8
 xk8NZsDK0Jg/9054NplQQijL6jiEm0CClCjDomi04SU1MQezIVz0ee7ntTo5G5V5GYqFn5L
 IAtJTfrALyLb5VVPV8i3B3DMcJbsm1mQmOddHKvjLMMnabfXtFSPo1Qb+wyAO1EcqVtMvtg
 /4Vyk59FpovAxsLv5VBMZ8GmqkM28ahFqM2yqYztDOcb1g3GmVi+2dgVY7vipTTzm1c0VNj
 USBWyAYMMYiqfLfZnV8XWzZozIJUxlVXSvSp3/9VeyQSOKsfQ83wustT+IdQ==
Received: from [10.159.238.187] (helo=localhost.localdomain)
 by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA512__CHACHA20_POLY1305:256)
 (Exim 4.98.1-S2G) (envelope-from <j@getutm.app>)
 id 1vQe9t-FnQW0hPv7oK-X2Ra; Wed, 03 Dec 2025 04:08:06 +0000
From: Joelle van Dyne <j@getutm.app>
To: qemu-devel@nongnu.org
Cc: Joelle van Dyne <j@getutm.app>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH RFC 2/7] virtio-gpu-virgl: check page alignment of blob mapping
Date: Tue,  2 Dec 2025 20:07:49 -0800
Message-ID: <20251203040754.94487-3-j@getutm.app>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20251203040754.94487-1-j@getutm.app>
References: <20251203040754.94487-1-j@getutm.app>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse: Please forward a copy of this message, including all headers,
 to <abuse-report@smtp2go.com>
Feedback-ID: 483429m:483429abrvJvs:483429sxwTVGsyjK
X-smtpcorp-track: bfYAnkvpnQLR.tR__meNI_Pt7.RevSPwiWvRs
Received-SPF: pass client-ip=158.120.83.188;
 envelope-from=bounce.29vafx79xran0f5=p85mwoxbn3wq=m9n7svzbgw7c67@em483429.getutm.app;
 helo=a4i956.smtp2go.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Currently if a mapping is not page aligned, it will sliently fail and the
guest, assuming it is mapped, will attempt to access the memory and fail.
This is particularly an issue on macOS when the host page size is 16KiB and
the guest page size is 4KiB.

Signed-off-by: Joelle van Dyne <j@getutm.app>
---
 hw/display/virtio-gpu-virgl.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
index 20c856c04e..adf02ac22b 100644
--- a/hw/display/virtio-gpu-virgl.c
+++ b/hw/display/virtio-gpu-virgl.c
@@ -116,6 +116,20 @@ virtio_gpu_virgl_map_resource_blob(VirtIOGPU *g,
         return ret;
     }
 
+    if (!QEMU_IS_ALIGNED((uintptr_t)data, qemu_real_host_page_size())) {
+        virgl_renderer_resource_unmap(res->base.resource_id);
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: address %p is not aligned to page size\n",
+                      __func__, data);
+        return -ENOMEM;
+    }
+
+    if (!QEMU_IS_ALIGNED(size, qemu_real_host_page_size())) {
+        virgl_renderer_resource_unmap(res->base.resource_id);
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: size 0x%llx is not aligned to page size\n",
+                      __func__, size);
+        return -ENOMEM;
+    }
+
     vmr = g_new0(struct virtio_gpu_virgl_hostmem_region, 1);
     vmr->g = g;
 
-- 
2.41.0


