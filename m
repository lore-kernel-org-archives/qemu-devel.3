Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85055D3CCB4
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 05:40:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgG4u-0006sZ-Tx; Thu, 15 Jan 2026 00:39:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vgG4r-0006rH-SY
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 00:39:25 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vgG4n-0004fJ-Jc
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 00:39:24 -0500
Received: from h205.csg.ci.i.u-tokyo.ac.jp (h205.csg.ci.i.u-tokyo.ac.jp
 [133.11.54.205]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 60F5cwVf061416
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 15 Jan 2026 14:39:07 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=NlBwYP7hYz7hXShyLqc38rtmmyvw4LTe00HInGEpDxM=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Date:Subject:Message-Id:To;
 s=rs20250326; t=1768455547; v=1;
 b=NkPcQOawlW+mbhrHa26C4CJIfln48c+S4dksepWUkmTaNSG8MNdZPCz0GEtyuVTo
 /ZsvZFN66zr9z5ZTnl8fgjLdjn/kWsYngPw3QqvKJv1gi9E7VfgFNK4fRgZs8QSw
 f4PFPYxsUNs2xSDLxdZzik0Q23xhQ/yeVDRjGos8rxzvWMjudAI6Edpvc2cKlr3F
 uprvWLIfErBnXQeKgfUlz2VJIROV9XDJbDEtF6usujySNbaGLKgtVIvtuliVPzUL
 qJvTOxlWEu2m33bNBLKOa4SZWpydlnugcHeb8cdKw0V2q+ifBVWbPGQMFEqKne0n
 fweFe1HwvPhF9wHxebqr3A==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Thu, 15 Jan 2026 14:38:54 +0900
Subject: [PATCH v3 5/5] virtio-gpu: Force RCU when unmapping blob
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260115-force_rcu-v3-5-1f8bfaff4815@rsg.ci.i.u-tokyo.ac.jp>
References: <20260115-force_rcu-v3-0-1f8bfaff4815@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260115-force_rcu-v3-0-1f8bfaff4815@rsg.ci.i.u-tokyo.ac.jp>
To: qemu-devel@nongnu.org, Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
X-Mailer: b4 0.15-dev-179e8
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Unmapping a blob changes the memory map, which is protected with RCU.
RCU is designed to minimize the read-side overhead at the cost of
reclamation delay. While this design usually makes sense, it is
problematic when unmapping a blob because the operation blocks all
virtio-gpu commands and causes perceivable disruption.

Minimize such the disruption with force_rcu(), which minimizes the
reclamation delay at the cost of a read-side overhead.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Tested-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 hw/display/virtio-gpu-virgl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
index 07f6355ad62e..71cde671c193 100644
--- a/hw/display/virtio-gpu-virgl.c
+++ b/hw/display/virtio-gpu-virgl.c
@@ -187,6 +187,7 @@ virtio_gpu_virgl_unmap_resource_blob(VirtIOGPU *g,
         memory_region_set_enabled(mr, false);
         memory_region_del_subregion(&b->hostmem, mr);
         object_unparent(OBJECT(mr));
+        force_rcu();
     }
 
     return 0;

-- 
2.52.0


