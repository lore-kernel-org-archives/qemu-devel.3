Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC84ECA9ED0
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 16:59:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGJM8-0007vk-R2; Mon, 12 Oct 2026 12:58:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tom.ds1@gmx.com>) id 1xGJM5-0007uF-84
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 12:58:29 -0400
Received: from mout.gmx.net ([212.227.15.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tom.ds1@gmx.com>) id 1xGJM2-00069P-Ug
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 12:58:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
 s=s31663417; t=1791824295; x=1792429095; i=tom.ds1@gmx.com;
 bh=WgS2HM6XNZibhbGwJlBXPTM3Mm5z/BbEj6TOaZi57es=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
 References:MIME-Version:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=niJPezNKL31U/rpwl3Q7ilZV7691h4oSg3qQWsp/17h6Fg9qlD7JI5QlX2k09Sne
 oal70B5g3aD8G8CPbO/oCP0hok5zSR2Oo717A8cNnqJlm5ik1qxB5/tblre3xXmVU
 blTi7SmYPh8lc4FbHoXlCsROQIfuK4ibgSLsn9EUH1ZsPp1xE/YTNFqWn0ElKFStm
 xWX9n4lm1By3shL3sLItauliZ1IgOvmmafK539sRR3hjlPlh3kordnZolr+WjMWNs
 vxwUZuF8sS4s+vi4pGzoGcpm4p9ySw2hTOdBub5zM5t0SrvXsafKIl2GkRRd/ShWn
 ppBmNXEuWFXxAKmUXA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MCsPy-1xP92V0TqK-003knv; Mon, 12
 Oct 2026 18:58:15 +0200
From: Tom Desnoyers <tom.ds1@gmx.com>
To: tom.ds1@gmx.com
Cc: alex.bennee@linaro.org, dmitry.osipenko@collabora.com, mst@redhat.com,
 odaki@rsg.ci.i.u-tokyo.ac.jp, qemu-devel@nongnu.org
Subject: [PATCH v2] virtio-gpu: fix memory leaks in virgl and rutabaga
Date: Mon, 12 Oct 2026 18:57:54 +0200
Message-ID: <20261012165754.11891-1-tom.ds1@gmx.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261006135504.416083-1-tom.ds1@gmx.com>
References: <20261006135504.416083-1-tom.ds1@gmx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:yrovXRP55qsXK8HiYF7a0Pxvng2O1/x0TM1OVmijEHNTiUFH06x
 rl8EqS+n72KYeq0uG5dIcOC4AxpOD1Y5gI7sbnuch1PJc7lmxUgci2SQbWC8BIjw4bWU3tp
 HELUA6jLfqYeN/O3KmPjAQHkyd9+XpNCl0sxgOTLj1ZeljUaOyrUNB0tc3cPwnOWIHiDAX5
 D1yxl0oSk0dTbulqykz6g==
UI-OutboundReport: notjunk:1;M01:P0:qtP735yEVqM=;p+p6EbOdpAIoZwV1wZSftTE0G7i
 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
Received-SPF: pass client-ip=212.227.15.18; envelope-from=tom.ds1@gmx.com;
 helo=mout.gmx.net
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

When a gpu buffer backed by a guest-memory blob is unreferenced, virgl
and rutabaga free the resource but not its addrs field, leaking memory
on every unref.

In virtio-gpu-virgl.c, call virtio_gpu_cleanup_mapping() instead of
virtio_gpu_cleanup_mapping_iov(). In virtio-gpu-rutabaga.c, call
virtio_gpu_cleanup_mapping() before freeing the resource.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4634
Signed-off-by: Tom Desnoyers <tom.ds1@gmx.com>
=2D--
v2:
- replace virtio_gpu_cleanup_mapping_iov() by virtio_gpu_cleanup_mapping()=
 (Akihiko Odaki)

v1:
https://lore.kernel.org/qemu-devel/20261006135504.416083-1-tom.ds1@gmx.com

 hw/display/virtio-gpu-rutabaga.c | 2 ++
 hw/display/virtio-gpu-virgl.c    | 6 +++---
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/hw/display/virtio-gpu-rutabaga.c b/hw/display/virtio-gpu-ruta=
baga.c
index 3aafa4dc66..e5c993c758 100644
=2D-- a/hw/display/virtio-gpu-rutabaga.c
+++ b/hw/display/virtio-gpu-rutabaga.c
@@ -164,6 +164,8 @@ virtio_gpu_rutabaga_resource_unref(VirtIOGPU *g,
     }
=20
     QTAILQ_REMOVE(&g->reslist, res, next);
+
+    virtio_gpu_cleanup_mapping(g, res);
     g_free(res);
 }
=20
diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
index f45571060f..f71f287d94 100644
=2D-- a/hw/display/virtio-gpu-virgl.c
+++ b/hw/display/virtio-gpu-virgl.c
@@ -451,13 +451,13 @@ virtio_gpu_virgl_resource_unref(VirtIOGPU *g,
     virgl_renderer_resource_detach_iov(res->base.resource_id,
                                        &res_iovs,
                                        &num_iovs);
-    if (res_iovs !=3D NULL && num_iovs !=3D 0) {
-        virtio_gpu_cleanup_mapping_iov(g, res_iovs, num_iovs);
-    }
+    res->base.iov =3D res_iovs;
+    res->base.iov_cnt =3D num_iovs;
     virgl_renderer_resource_unref(res->base.resource_id);
=20
     QTAILQ_REMOVE(&g->reslist, &res->base, next);
=20
+    virtio_gpu_cleanup_mapping(g, &res->base);
     g_free(res);
=20
     return 0;
=2D-=20
2.56.0


