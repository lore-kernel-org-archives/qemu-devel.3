Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31C9CC624D3
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 13:12:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2Tht-0006Gk-3z; Fri, 04 Sep 2026 09:11:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x2Thr-00067T-C7
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 09:11:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x2Thp-0005DW-VE
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 09:11:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788527505;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eDpJv5fVSHBFINWcnPkvTTbGfWX5pHmQw/bOk6t9n7o=;
 b=IQZfbNYvucibsgG3+woJy1d9r+1shto9dwhOiqFw7CLjm8pN/hB5j6pd2KqSWS0oFFgZhd
 CgtAlrh1x20eW8s44VbXxght2301N+yLFjyJ2SZe6Zolt3jMqRebzg7Adr+ISJE7I7LvsS
 yyqsMfLo0RUI4BcsAPBCPTKrNsuIgGM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-299-FSwanOTwNC2e3W8HxxZJHQ-1; Fri,
 04 Sep 2026 09:11:44 -0400
X-MC-Unique: FSwanOTwNC2e3W8HxxZJHQ-1
X-Mimecast-MFC-AGG-ID: FSwanOTwNC2e3W8HxxZJHQ_1788527503
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 13AD7180AD5C; Fri,  4 Sep 2026 13:11:43 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CA6AE18005AC; Fri,  4 Sep 2026 13:11:41 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 04 Sep 2026 17:10:26 +0400
Subject: [PATCH v2 22/25] virtio-gpu/virgl: disable scanouts on resource unref
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260904-virtio-gpu-cleanup-v2-22-15b5ae6b0023@redhat.com>
References: <20260904-virtio-gpu-cleanup-v2-0-15b5ae6b0023@redhat.com>
In-Reply-To: <20260904-virtio-gpu-cleanup-v2-0-15b5ae6b0023@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, 
 Alex Williamson <alex@shazbot.org>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1365;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=V1GN5LoBN9Orpkbh0wMfjyjOHFm67aaxsE17BfJbx1k=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqmsMwzg89Cv1ZHxmIW5Z1+75qsFM/V8bVix3u6
 Ce0FjTeWDeJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaprDMAAKCRDa6OEJdZac
 5YxBEACvDgvoXyEAMhArIw3aGQdJcp3naIGfin3TuGm+FZV+t50/E+5etuWogbZNZD1GsxEE131
 qaZm7aUkp5GDqkEUNfZzeaWeKhBO9Nvhh2XcWuJp7I+tNKT/zxrZRyi5VGkrfAYjNXWhyxwG+Mi
 FEFtxj05P/VSNfr/dHcREo/pTXRUkDRr2m2J6m6IMYQAKBqL84hSuIhCEP+OO3AxQiyupD9xnER
 h4p2CN5x2jl5LP1savXM5W7Cp1sShyCr/g7CeC0pmrh3uCn33JfbgkOgWmnXznA2Kog1ByH3rW0
 Kqsb5UfUxA2kV2JC7K5MVOZJ3oReEUswZZrEGpf3bhYu5tpKLeSl4hOTbm6A2LlxpMBpDpd/8ux
 iJ5RkCKl+phvGQVOcpY0vdF4OAdWcN9sOdgjHS/TKkGIEkAJ3jGxx+htBqndkglNetIT03bJFLA
 GE9L+Bh9GObJNqXNccQdLs6JybulCoav6cRjlSJaBGpE9Pdlh/XJVIwGnmDFh+euLykM0hJ+Qob
 XJTEWpYbuqqJqVOq/0onACpT306FVcAeuyLsmas4xcwkoCiqHm1I9nDnIpKaNU84lrP8Plxw309
 88KbsjfCCxHSSev53h39+mbLAjp+fvb+FGEtMy1QqpZgoW5YLEEkU6H961vII9bTUpn990J+cxJ
 cYAqe31rB8YsH8w==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

Disable scanouts referencing a resource being unreferenced.

The scanout disable callbacks may change the current GL context, so
restore the renderer context before detaching and unreferencing the
resource.

Fixes: 9d9e152136bd ("virtio-gpu: add 3d mode and virgl rendering support.")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/display/virtio-gpu-virgl.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
index 118419171ff0..cf624761610a 100644
--- a/hw/display/virtio-gpu-virgl.c
+++ b/hw/display/virtio-gpu-virgl.c
@@ -431,6 +431,7 @@ virtio_gpu_virgl_resource_unref(VirtIOGPU *g,
 {
     struct iovec *res_iovs = NULL;
     int num_iovs = 0;
+    int i;
 #if VIRGL_VERSION_MAJOR >= 1
     int ret;
 
@@ -443,6 +444,13 @@ virtio_gpu_virgl_resource_unref(VirtIOGPU *g,
     }
 #endif
 
+    for (i = 0; i < g->parent_obj.conf.max_outputs; i++) {
+        if (g->parent_obj.scanout[i].resource_id == res->base.resource_id) {
+            virtio_gpu_disable_scanout(g, i);
+        }
+    }
+
+    virgl_renderer_force_ctx_0();
     virgl_renderer_resource_detach_iov(res->base.resource_id,
                                        &res_iovs,
                                        &num_iovs);

-- 
2.55.0.543.g5ebe2ebe4ea8


