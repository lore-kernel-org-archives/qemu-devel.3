Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F4BCC79F99
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 06:14:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3p5F-00025K-3I; Tue, 08 Sep 2026 02:13:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1x3p5B-00022b-O1; Tue, 08 Sep 2026 02:13:25 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1x3p57-0000jj-UG; Tue, 08 Sep 2026 02:13:25 -0400
Received: from h183.csg.ci.i.u-tokyo.ac.jp (h183.csg.ci.i.u-tokyo.ac.jp
 [133.11.54.183]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 6886CG94048190
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Tue, 8 Sep 2026 15:12:28 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=iLKOB8hGXB6J2Cht2MFDQIwqaTH+BaQ1D2vqKRWE34U=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-Id:To:Subject:Date;
 s=rs20250326; t=1788847948; v=1;
 b=AF2WKFVftAVOrWUdEFRSsWaQ2eJzruMRvQ0G52hhhc8/Y9VhqvKTTyFBxvL5bG5W
 Xt1/EdBrhe3AXk14Hg92ll4lylVC7aDSex0urb/Di13g7Vb6aymMU4NuNo1zy3Pz
 OVSvzGLIwZoZ1RCGzVquTzO+VLjuthSqRYILNhDO9hsV27RVuSWdy3uqupNtnBs/
 okINnDDnZkTTPtJzVdz5sNvKOK8mReBY730v4pa0Euxadeiuh2nP88lpJVuN38LC
 71fHINieJkUi807AnMppmdrJnSVAPvxrIxRS3k6ezYdRrpePHWdE+aVJk3U+wN2l
 LiL0vZyWk/YeyONj9pjmcg==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Tue, 08 Sep 2026 15:11:24 +0900
Subject: [PATCH v3 7/9] hw/display/virtio-gpu: Balance inflight counter changes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260908-gpu-v3-7-25332a85f909@rsg.ci.i.u-tokyo.ac.jp>
References: <20260908-gpu-v3-0-25332a85f909@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260908-gpu-v3-0-25332a85f909@rsg.ci.i.u-tokyo.ac.jp>
To: qemu-devel@nongnu.org, Gurchetan Singh <gurchetansingh@chromium.org>
Cc: =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>,
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Greg Kurz <groug@kaod.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Raphael Norwitz <rnorwitz@nvidia.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Amit Shah <amit@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 David Hildenbrand <david@kernel.org>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>, qemu-block@nongnu.org,
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
X-Mailer: b4 0.16-dev-925f5
X-Developer-Signature: v=1; a=openpgp-sha256; l=1441;
 i=odaki@rsg.ci.i.u-tokyo.ac.jp; h=from:subject:message-id;
 bh=wN0el4OYO+T8Df0slBrEEleYmRlpJeg9byDB3gBTvv8=;
 b=owGbwMvMwCWmMbc20y1CyJDxtFoSQ9b85e6zUqb03l6pnhC0flPSjDMTCzO3NGrO0j8s5Pc+2
 f5xuGpLRykLgxgXg6yYIktK0W5ujejaT4UJ8S0wc1iZQIYwcHEKwEQmpjH84QuqVdeM6J92oSfl
 Vni2hL6rzOLgEK9Vm04dcVEQOO2mysjw58q7hjDdmPn7A5sNtP4lqBaa69Y2cDdza5ncmubnpMA
 CAA==
X-Developer-Key: i=odaki@rsg.ci.i.u-tokyo.ac.jp; a=openpgp;
 fpr=AEDC03C9AF734F2EC26A7BFFA4BAEAA73536753C
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

virtio_gpu_virgl_async_fence_bh() decrements g->inflight for each
asynchronous fence, but it is incremented for each fenced command though
an asynchronous fence may complete several or no fenced commands.
Change it to decrement g->inflight for each fenced command to balance
the increment and the decrement.

Fixes: 6698eae8a1f6 ("virtio-gpu: Support asynchronous fencing")
Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
 hw/display/virtio-gpu-virgl.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
index c37df91e3ed1..20a5d06d9a3a 100644
--- a/hw/display/virtio-gpu-virgl.c
+++ b/hw/display/virtio-gpu-virgl.c
@@ -1266,14 +1266,14 @@ static void virtio_gpu_virgl_async_fence_bh(void *opaque)
             virtio_gpu_ctrl_response_nodata(g, cmd, VIRTIO_GPU_RESP_OK_NODATA);
             QTAILQ_REMOVE(&g->fenceq, cmd, next);
             g_free(cmd);
+            g->inflight--;
+            if (virtio_gpu_stats_enabled(g->parent_obj.conf)) {
+                trace_virtio_gpu_dec_inflight_fences(g->inflight);
+            }
         }
 
         trace_virtio_gpu_fence_resp(f->fence_id);
         g_free(f);
-        g->inflight--;
-        if (virtio_gpu_stats_enabled(g->parent_obj.conf)) {
-            trace_virtio_gpu_dec_inflight_fences(g->inflight);
-        }
     }
 }
 

-- 
2.55.0


