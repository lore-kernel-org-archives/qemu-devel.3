Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42DFAC53209
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jul 2026 20:45:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wo5iA-0007yT-Ux; Sun, 26 Jul 2026 16:44:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wo5i8-0007y1-1M
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 16:44:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wo5i6-00048T-F3
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 16:44:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785098673;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jdyS0SwdNs3vUAKy88HJSJe2GUYkTH6E4XHdR6+6wqI=;
 b=K6ovLZrAP3Q20XPMyf+fuw//AObAKse4eWXUhMsSLXnh3F13j6prxRmYb9lMy4K22+bS+B
 rLzCGMwJCbLLe/Oa3gtlAW5avRVBF+Nx2lLVytJnGyfzjVZF/T00oN2H/WR1fZ/pfKLs5v
 sRpf6dKxcB4fl7nW8N50xQmsbSlaxa8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-379-RMfQBsV9NAOEXuRf76343A-1; Sun,
 26 Jul 2026 16:44:30 -0400
X-MC-Unique: RMfQBsV9NAOEXuRf76343A-1
X-Mimecast-MFC-AGG-ID: RMfQBsV9NAOEXuRf76343A_1785098667
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 524BD195606A; Sun, 26 Jul 2026 20:44:26 +0000 (UTC)
Received: from localhost (unknown [10.44.24.5])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AE296180049F; Sun, 26 Jul 2026 20:44:21 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 27 Jul 2026 00:44:00 +0400
Subject: [PATCH v2 01/12] hw/display/virtio-gpu-rutabaga: zero-init capset
 info response
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260727-fix2-v2-1-d0c4831ed7ea@redhat.com>
References: <20260727-fix2-v2-0-d0c4831ed7ea@redhat.com>
In-Reply-To: <20260727-fix2-v2-0-d0c4831ed7ea@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org, 
 Jonathan Cameron <jic23@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
 Fam Zheng <fam@euphon.net>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Zhao Liu <zhao1.liu@intel.com>, Roman Bolshakov <rbolshakov@ddn.com>, 
 Phil Dennis-Jordan <phil@philjordan.eu>, Wei Liu <wei.liu@kernel.org>, 
 linux-cxl@vger.kernel.org, Brian Cain <brian.cain@oss.qualcomm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Haotian Jiang <jianghaotian.sunday@gmail.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1561;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=sa9k8gsEJKtuI61HuTaU2/NIFGh87rAtJ9OvBXauOqE=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqZnGWjRL3ARaU20KwN0Bb+7EEi0O/EflVGeLkQ
 iimEn+6/LSJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCamZxlgAKCRDa6OEJdZac
 5WM4D/9x27KZwhBuvvOFyHz35ZYKZK9Ekzxnlff1k5tQH8c/hl4wPSlgBIhQD90Lvo7XR+/CnsL
 P8SRIQryA3R2QQNhiW3dP4lMdjKq4CWbRdZ+hUu6FiUL7RvM26rOSij8TM2dSpp6KOoXqu06udj
 VAnymkChW4d+DiYR2B10e4IYKHwa7aXRezN5uxKXdZ2X/UucYPCOGFYRGiXxSkwOMhyGmuZ8VMm
 AfP/nKkb+noc2HdBjU4tA0r9aahUmN4U/GhjjHkxLotYGio7A9TmokZvZ25xyJb9MXjyPlQeEea
 ojVTXgXMHi3np8So7VTQaWwUU8PXThBfd4f1eCE+WZkXWuoBYpZGcIqL1KzyER6ZZMKoU0btbUN
 ZVuzvQ13q1KhP4AJhuw9HrZGe6AraE/GHv9SD2Z715QZvSBzvRmxv+7b4b2Th/WdrDESgv/Y+qe
 p2GxVQb8F6aDy0SuaBjDbSNTBkRdKsDE6qyY3WcyRu8PAr9gSyqvbYq883+t85KL//L6agVvLPk
 V3DtINPa0Irm0Uo7+SaHoz6Y7K6Zy/EZFlAS/bhR4/8Mkx60nQtulIH2K84OXsy9YMjT7EqKE/b
 xAumi3Si3TuoQSqdfKpauvxdz033WLprVDCa0/58x2TnlWAopUK/BjxxXwiUBGHZ1lVXdZo5uD0
 uKKSHJw+BLt5ygw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
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

rutabaga_cmd_get_capset_info() only fills in capset_id,
capset_max_version and capset_max_size before sending the response to
the guest. The remaining fields of struct virtio_gpu_resp_capset_info,
including hdr.fence_id, hdr.ctx_id and hdr.ring_idx, are left with
stack garbage and leaked to the guest, including host pointers useful
for an ASLR bypass.

Zero the response first, matching virgl_cmd_get_capset_info().

Not a real risk thanks to -ftrivial-auto-var-init=zero, but only with
gcc >= 12 or clang >= 16.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3609
Fixes: 1dcc6adbc168 ("gfxstream + rutabaga: add initial support for gfxstream")
Reported-by: Haotian Jiang <jianghaotian.sunday@gmail.com>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/display/virtio-gpu-rutabaga.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/display/virtio-gpu-rutabaga.c b/hw/display/virtio-gpu-rutabaga.c
index 4d7d7b245929..95a19eed7eda 100644
--- a/hw/display/virtio-gpu-rutabaga.c
+++ b/hw/display/virtio-gpu-rutabaga.c
@@ -555,6 +555,8 @@ rutabaga_cmd_get_capset_info(VirtIOGPU *g, struct virtio_gpu_ctrl_command *cmd)
 
     VIRTIO_GPU_FILL_CMD(info);
 
+    memset(&resp, 0, sizeof(resp));
+
     result = rutabaga_get_capset_info(vr->rutabaga, info.capset_index,
                                       &resp.capset_id, &resp.capset_max_version,
                                       &resp.capset_max_size);

-- 
2.55.0


