Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8FEFCC6B03
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 13:26:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGcVF-0002jU-8V; Tue, 13 Oct 2026 09:25:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xGcUf-00025F-2N
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 09:24:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xGcUd-0004jO-Ag
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 09:24:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791897870;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pwNY6DylGEoxks1pUfWv4NvG8AC7XceEkwd4bcGu3ck=;
 b=Yh8bSpnjSs3IOphRNkzNksQY/+2hPPsQuuA/Olkg8JBNP+DSjo6R+zp30AAvyVdJA+RqJ5
 kjT7x0npUQyk2N6Yye5uJrwQMPkwMXYxPFmiJ2lP+UWVG630PQ/pLt1eXJ2e9piMcjJvyY
 NOOyQcezKn+hV6HKGmJCPR4kcu+kLiY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-323-1ImMUVLmMcKXUifcgTDUkA-1; Tue,
 13 Oct 2026 13:24:26 +0000
X-MC-Unique: 1ImMUVLmMcKXUifcgTDUkA-1
X-Mimecast-MFC-AGG-ID: 1ImMUVLmMcKXUifcgTDUkA_1791897865
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A689B1828B05; Tue, 13 Oct 2026 13:24:25 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 514FF1800446; Tue, 13 Oct 2026 13:24:23 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 13 Oct 2026 17:23:14 +0400
Subject: [GIT PULL 17/40] virtio-gpu: fix memory leaks in virgl and
 rutabaga
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261013-ui-v1-17-92da3082ad96@redhat.com>
References: <20261013-ui-v1-0-92da3082ad96@redhat.com>
In-Reply-To: <20261013-ui-v1-0-92da3082ad96@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1991;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=x09hVeFBV3OUvQp9gJUjZMonfsXHxSDBsEFJdQVWWQQ=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqzjDDA/Wh7x08UZG0/taX4vT/E6z0hMswqpJ3u
 XH/oxHYLAmJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCas4wwwAKCRDa6OEJdZac
 5cvyEACgdzuwU6FOXnU4sVuGvsKMDkqp1AvVLXZYsNlOKQ1o5PmzokQ1Rixi8LXPCkkaCpnIduS
 HvrTLe9P4ThFuAU23jQNf+1r31npyrC+kDtcW7RLR6L3qTaygM1JKqKbzv2w9Tg2prP6x9raaIT
 T3eXCT0hvf38GIJDauYoXQ4ZhWLI1lOMO/YWdwCCBf8151Ec3liHrf+p2LxvfUpQpkbjafx2/vN
 NxfdB/2j79s0xLzl7AJ3hZRP4nM+RVlfS84LPF0YCZAYQ+rMLzQqjD5B+gLlKLAilbZEss49gNq
 UgWMnv3wlfh4WZi5NZz/+W8hZJhTiThTdk0LzY4q7tKPCEdGknwpgECsnhDwOS2T6NRkjGCoO7C
 DX7gds/nrmXlDhsytKa9xD1RroqSRHj1lWENk7RA5X5SiccekyElj3JLoLLscd/N8BmZmZ5POR9
 A/FDBIlaBTAApqqzY1FnIVoi3KAzaNpT9YI8ttopkjFjwZr9kHfIuXZ5IXwpng8ZJuDjjreDlQ/
 /4XDoH97tF4wIzk+xh5Gr7GT8y3B0zGGgJ6rK3M7Oj0dWIpJ1JC7uY42JQPkiBsruAoZIejDXwF
 U35KjA0Tim70nOkoYRN63nKfXrEQmX096CDpQ+DJjUY9WQoxe5kJ55L81/gHIzX8OrRfZ1D88wm
 9nELfHyRSxUCB8w==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

From: Tom Desnoyers <tom.ds1@gmx.com>

When a gpu buffer backed by a guest-memory blob is unreferenced, virgl
and rutabaga free the resource but not its addrs field, leaking memory
on every unref.

In virtio-gpu-virgl.c, call virtio_gpu_cleanup_mapping() instead of
virtio_gpu_cleanup_mapping_iov(). In virtio-gpu-rutabaga.c, call
virtio_gpu_cleanup_mapping() before freeing the resource.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4634
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Tom Desnoyers <tom.ds1@gmx.com>
Message-ID: <20261012165754.11891-1-tom.ds1@gmx.com>
---
 hw/display/virtio-gpu-rutabaga.c | 2 ++
 hw/display/virtio-gpu-virgl.c    | 6 +++---
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/hw/display/virtio-gpu-rutabaga.c b/hw/display/virtio-gpu-rutabaga.c
index edf7b6270329..1312a67d7011 100644
--- a/hw/display/virtio-gpu-rutabaga.c
+++ b/hw/display/virtio-gpu-rutabaga.c
@@ -164,6 +164,8 @@ virtio_gpu_rutabaga_resource_unref(VirtIOGPU *g,
     }
 
     QTAILQ_REMOVE(&g->reslist, res, next);
+
+    virtio_gpu_cleanup_mapping(g, res);
     g_free(res);
 }
 
diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
index f45571060fea..f71f287d9486 100644
--- a/hw/display/virtio-gpu-virgl.c
+++ b/hw/display/virtio-gpu-virgl.c
@@ -451,13 +451,13 @@ virtio_gpu_virgl_resource_unref(VirtIOGPU *g,
     virgl_renderer_resource_detach_iov(res->base.resource_id,
                                        &res_iovs,
                                        &num_iovs);
-    if (res_iovs != NULL && num_iovs != 0) {
-        virtio_gpu_cleanup_mapping_iov(g, res_iovs, num_iovs);
-    }
+    res->base.iov = res_iovs;
+    res->base.iov_cnt = num_iovs;
     virgl_renderer_resource_unref(res->base.resource_id);
 
     QTAILQ_REMOVE(&g->reslist, &res->base, next);
 
+    virtio_gpu_cleanup_mapping(g, &res->base);
     g_free(res);
 
     return 0;

-- 
2.56.0.116.g6de20f6092dc


