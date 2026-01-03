Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3660BFC6182
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Jan 2026 21:45:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vc9QA-0004W2-AV; Sat, 03 Jan 2026 16:44:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <bounce.d86mq3ge2ho10b1=w20q0n0bx2we=2qt2ewlysgjf5v@em483429.getutm.app>)
 id 1vc9Q8-0004VM-UJ
 for qemu-devel@nongnu.org; Sat, 03 Jan 2026 16:44:24 -0500
Received: from a4i726.smtp2go.com ([158.120.82.214])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <bounce.d86mq3ge2ho10b1=w20q0n0bx2we=2qt2ewlysgjf5v@em483429.getutm.app>)
 id 1vc9Q7-0002jr-7l
 for qemu-devel@nongnu.org; Sat, 03 Jan 2026 16:44:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=getutm.app;
 i=@getutm.app; q=dns/txt; s=s483429; t=1767476653; h=from : subject :
 to : message-id : date;
 bh=VR9Up13b8dTB1mgr5eJ6rhvArKgValaoK8FbWzJqJFA=;
 b=VpS8jAOaUx2VxjbJTKXJ4iUQlQR+yDYRC6vvDrmWSZIANx7tCEwJLXJut2yfK6H7NE5Sj
 ZWvXLbDIXuaXN7ouMWbp8EPekNGv4y38mxLYsHQ3nSvmv6e6dfGBi/SyD+58lsX0i9NLmrJ
 giBOtsBwfbGGj/Y7KPXRPL+z2t6TBWsZjluRF8QmvtBhyjAkbRg2XPgjXbf56hrh1mC6NuM
 Srkt4R2xTQyy5fEDaBLNAluBhMXhrIJwIZbhytUctqCWPVphDSR8FForMNglG+Q56e4u543
 vXQW+JA/KGvTsCC38lDY4IcpSZxyxTN2rROl1Lqb+Xv+nMZ6G7HYwo8p7HJg==
Received: from [10.159.238.187] (helo=localhost.localdomain)
 by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA512__CHACHA20_POLY1305:256)
 (Exim 4.98.1-S2G) (envelope-from <j@getutm.app>)
 id 1vc9Pq-4o5NDgrrZL6-jU47; Sat, 03 Jan 2026 21:44:07 +0000
From: Joelle van Dyne <j@getutm.app>
To: qemu-devel@nongnu.org
Cc: Joelle van Dyne <j@getutm.app>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>
Subject: [PATCH v3] virtio-gpu-virgl: correct parent for blob memory region
Date: Sat,  3 Jan 2026 13:43:59 -0800
Message-ID: <20260103214400.71694-1-j@getutm.app>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse: Please forward a copy of this message, including all headers,
 to <abuse-report@smtp2go.com>
Feedback-ID: 483429m:483429abrvJvs:483429sW-ujAA395
X-smtpcorp-track: 94kD0OWaS-Uz.QirYWaV5p0dr.6ei-qgSB8ok
Received-SPF: pass client-ip=158.120.82.214;
 envelope-from=bounce.d86mq3ge2ho10b1=w20q0n0bx2we=2qt2ewlysgjf5v@em483429.getutm.app;
 helo=a4i726.smtp2go.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

When `owner` == `mr`, `object_unparent` will crash:

object_unparent(mr) ->
object_property_del_child(mr, mr) ->
object_finalize_child_property(mr, name, mr) ->
object_unref(mr) ->
object_finalize(mr) ->
object_property_del_all(mr) ->
object_finalize_child_property(mr, name, mr) ->
object_unref(mr) ->
fail on g_assert(obj->ref > 0)

However, passing a different `owner` to `memory_region_init` does not
work. `memory_region_ref` has an optimization where it takes a ref
only on the owner. That means when flatviews are created, it does not
take a ref on the region and you can get a UAF from `flatview_destroy`
called from RCU.

The correct fix therefore is to use `NULL` as the name which will set
the `owner` but not the `parent` (which is still NULL). This allows us
to use `memory_region_ref` on itself while not having to rely on unparent
for cleanup.

Signed-off-by: Joelle van Dyne <j@getutm.app>
---
 hw/display/virtio-gpu-virgl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
index 18404be5892..b8a0af702e0 100644
--- a/hw/display/virtio-gpu-virgl.c
+++ b/hw/display/virtio-gpu-virgl.c
@@ -123,7 +123,7 @@ virtio_gpu_virgl_map_resource_blob(VirtIOGPU *g,
     vmr->g = g;
 
     mr = &vmr->mr;
-    memory_region_init_ram_ptr(mr, OBJECT(mr), "blob", size, data);
+    memory_region_init_ram_ptr(mr, OBJECT(mr), NULL, size, data);
     memory_region_add_subregion(&b->hostmem, offset, mr);
     memory_region_set_enabled(mr, true);
 
@@ -189,7 +189,7 @@ virtio_gpu_virgl_unmap_resource_blob(VirtIOGPU *g,
         /* memory region owns self res->mr object and frees it by itself */
         memory_region_set_enabled(mr, false);
         memory_region_del_subregion(&b->hostmem, mr);
-        object_unparent(OBJECT(mr));
+        object_unref(OBJECT(mr));
     }
 
     return 0;
-- 
2.50.1 (Apple Git-155)


