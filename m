Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28E2BCA5FF1
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 09:15:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xENfG-0006fZ-Nf; Wed, 07 Oct 2026 05:10:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tom.ds1@gmx.com>) id 1xEInY-0007ZP-2l
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 23:58:42 -0400
Received: from mout.gmx.net ([212.227.17.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tom.ds1@gmx.com>) id 1xEInV-0003pp-9R
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 23:58:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
 s=s31663417; t=1791345501; x=1791950301; i=tom.ds1@gmx.com;
 bh=rcHZ1gmKyUcQJYfB1EuvEDFykOuGnXowHTWuR5IPehU=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
 MIME-Version:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=N9Iyy9PG5/UGHbBR1ZH2iQnst8ZzO6oeowFFlbb9ciH8wU01ixGIvA2JWZEHh60k
 p1KYjSO3LFQCMaWlyq9nfyY0MCeWllGShZRWn/Wy9wpV64hqrd6/3T+tKBn/toQM3
 Tq5JJ22xwFSRtLtEIfsG4uE7j487wXkTYg4kikKBuQ/cVZB2BJ69zURAEpxS44S9x
 cuIEAI+vYY8Yn921MokU1ZQrbwWmJv917ulPVs7pxd0GYYX8zaP+dqlgFrwCmzl6+
 N3LhWyp8O78rsD2rW3x5FSYgQxOsVdE9chiRZ09bgtYUW72vyCd8CXOma+RufPBy9
 dcC/Zh02IE79oLAVlQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M7b2T-1xJpjo2mE9-00EZUh; Tue, 06
 Oct 2026 15:55:13 +0200
From: Tom Desnoyers <tom.ds1@gmx.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, alex.bennee@linaro.org, odaki@rsg.ci.i.u-tokyo.ac.jp,
 dmitry.osipenko@collabora.com, Tom Desnoyers <tom.ds1@gmx.com>
Subject: [PATCH] virtio-gpu: fix memory leaks in virgl and rutabaga
Date: Tue,  6 Oct 2026 15:55:04 +0200
Message-ID: <20261006135504.416083-1-tom.ds1@gmx.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:dMWXtIH9Edep8ZaK5hUteQHMuvCYC7pxbRq4CgovKziu9GzaVFm
 Mw59ru6CMpUbi65dHanmA/L+OypqfgvtJ8FQ0dPyShC0dCO9c2+66GWDfI35IooRB7Cvw9R
 FsanQnXAnWgcP65Nvisiov5XZ7LUmt6oX45iT5HMBJZcctx4IKNDlB/z/nHlExyibbYNjQq
 XB9FOKHTX01gL4pbtOd6Q==
UI-OutboundReport: notjunk:1;M01:P0:V1heLSbpdE4=;g+HXqJXKA32P+FOtOSv77O6glwQ
 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
Received-SPF: pass client-ip=212.227.17.21; envelope-from=tom.ds1@gmx.com;
 helo=mout.gmx.net
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 07 Oct 2026 04:24:19 -0400
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

In virtio-gpu-virgl.c, free res->base.addrs before freeing the resource.
In virtio-gpu-rutabaga.c, call virtio_gpu_cleanup_mapping() before
freeing the resource.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4634
Signed-off-by: Tom Desnoyers <tom.ds1@gmx.com>
=2D--
 hw/display/virtio-gpu-rutabaga.c | 1 +
 hw/display/virtio-gpu-virgl.c    | 1 +
 2 files changed, 2 insertions(+)

diff --git a/hw/display/virtio-gpu-rutabaga.c b/hw/display/virtio-gpu-ruta=
baga.c
index 3aafa4dc66..7907aea85a 100644
=2D-- a/hw/display/virtio-gpu-rutabaga.c
+++ b/hw/display/virtio-gpu-rutabaga.c
@@ -164,6 +164,7 @@ virtio_gpu_rutabaga_resource_unref(VirtIOGPU *g,
     }
=20
     QTAILQ_REMOVE(&g->reslist, res, next);
+    virtio_gpu_cleanup_mapping(g, res);
     g_free(res);
 }
=20
diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
index f45571060f..b5b160c840 100644
=2D-- a/hw/display/virtio-gpu-virgl.c
+++ b/hw/display/virtio-gpu-virgl.c
@@ -458,6 +458,7 @@ virtio_gpu_virgl_resource_unref(VirtIOGPU *g,
=20
     QTAILQ_REMOVE(&g->reslist, &res->base, next);
=20
+    g_free(res->base.addrs);
     g_free(res);
=20
     return 0;
=2D-=20
2.55.0


