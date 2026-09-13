Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 908DAC88E56
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2026 10:43:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5hgP-0005nd-IY; Sun, 13 Sep 2026 06:43:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x5hgO-0005lw-7e
 for qemu-devel@nongnu.org; Sun, 13 Sep 2026 06:43:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x5hgM-0008I2-Kq
 for qemu-devel@nongnu.org; Sun, 13 Sep 2026 06:43:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789296213;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D/MyPA+oqBcNz1p0kWs7kYIgcKYq/fY31KFsYZ6bLfE=;
 b=WxmCJvGdu7Pg6xekH1y2KgO5Cu0mlX4EEBOpgTOeUI2xvMKY0aD1icHy89tHTLfkGkNgOm
 cgAKoqG3kaxlKgXO3CXtLDAMLKDxlq56gMad93Ney5z9/ci/0F4l/X9o7eUP7pRajSYxLW
 vQVuswgH03SGnuGxxOTp0gCxnOc5/cI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-625-gEduq3IhOn-B5CDhXVMaKw-1; Sun,
 13 Sep 2026 06:43:31 -0400
X-MC-Unique: gEduq3IhOn-B5CDhXVMaKw-1
X-Mimecast-MFC-AGG-ID: gEduq3IhOn-B5CDhXVMaKw_1789296210
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0EF0D1964CE3; Sun, 13 Sep 2026 10:43:30 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D4B9430001A2; Sun, 13 Sep 2026 10:43:28 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sun, 13 Sep 2026 14:41:30 +0400
Subject: [GIT PULL 12/14] virtio-gpu-virgl: guard new_blob with
 VIRGL_VERSION_MAJORS>=1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260913-ui-v1-12-7a8d89d0423a@redhat.com>
References: <20260913-ui-v1-0-7a8d89d0423a@redhat.com>
In-Reply-To: <20260913-ui-v1-0-7a8d89d0423a@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1481;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=qvP5Da7Pf/BfIlNBWy09+EyO9FeeA3aQsw3FezAkgXk=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqpn4jTFwe5YX2L7kGQ1ktkPFmGP1wDBEiKQWwi
 b77hsT49LaJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaqZ+IwAKCRDa6OEJdZac
 5X1YD/90iSH9+HY1dHz6GBsuPiSgnb6wpBJwuCN/HDwui3Si1ta+gCWphXWlr9TS7HYGm14N80D
 Ie3a2rTAsaKWq8JDX9smjNt2ZxgvxX7LZ0y6coanApxTwQO7rmVktBa4+Zf/AWEWI/3y4TaPNuZ
 N1ivjxiauvW/lQhHtmZJbpdCTfj6Fg8zKJtn0M0kqF72yjeEnyDXn1RkPtK/5dISCaSaAf1QlFm
 E0ScI7H8+/7yp06mZvcnjDKZGE5JVltfFdWdnF/qEn3LSMGNsiMafy8/voj8xngrgjtgGFTIKwO
 Gx3OHz5TAJEPZM8nALTwGizvk68Np1pxueFFi9DigyC5sfl83HfIe+RSb0j0jdRZC7y5ABdvuVR
 KJ4NJf3vC+RHKdESwiUlI5aAk77EygMxcuOF57TCg7ImVKm9Kp0EzAV75wySO9ktQ1lIuXeCzs9
 KKNkTAU2JXbavNAbA9mLR0WlSV5xYnW5sWkZ2ikRd+2tdDvkQf2gus+9EGITHdsdtu8rwv2vPkA
 JgSIeCIHIlry454F8CoBsKkDTrELRvA0Kv9MVg+0almHkzrRUnVo2nKHv6k1JhufHuBCeFW9crC
 kZfRVXYHMKgAdtxlY5DILG1LGulmVxZh/ohFo7Xb5GkYZfGNbnqHo04WTMBUsSh0P6rZZbnPyWu
 p9Rta5TZW3G7lMw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

virtio_gpu_virgl_resource_new_blob() is only called from
virgl_cmd_resource_create_blob(), which is guarded by
VIRGL_VERSION_MAJOR >= 1.

Fixes: d814b44636d0 ("hw/display/virtio-gpu: introduce virtio_gpu_{simple,virgl}_resource_new()")
Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>
Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
Fixes: d814b44636d0 ("hw/display/virtio-gpu: introduce  virtio_gpu_{simple,virgl}_resource_new()")
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20260911140645.56094-1-marcandre.lureau@redhat.com>
---
 hw/display/virtio-gpu-virgl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
index 1c9380e2a6d2..f45571060fea 100644
--- a/hw/display/virtio-gpu-virgl.c
+++ b/hw/display/virtio-gpu-virgl.c
@@ -324,6 +324,7 @@ virtio_gpu_virgl_resource_new(uint32_t resource_id, uint32_t width,
     return res;
 }
 
+#if VIRGL_VERSION_MAJOR >= 1
 static struct virtio_gpu_virgl_resource *
 virtio_gpu_virgl_resource_new_blob(uint32_t resource_id, uint64_t blob_size)
 {
@@ -335,6 +336,7 @@ virtio_gpu_virgl_resource_new_blob(uint32_t resource_id, uint64_t blob_size)
 
     return res;
 }
+#endif
 
 static void virgl_cmd_create_resource_2d(VirtIOGPU *g,
                                          struct virtio_gpu_ctrl_command *cmd)

-- 
2.55.0.543.g5ebe2ebe4ea8


