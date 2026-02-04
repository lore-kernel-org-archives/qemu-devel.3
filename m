Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB06AEA7944
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 19:09:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vniC0-0003hX-5g; Wed, 04 Feb 2026 14:05:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vniB3-0002xB-Ms
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 14:04:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vniB2-0008B0-6q
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 14:04:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770231875;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MYOHd7OZhpLHGlsgoLBWOeyBZyIml693wIxtgYusuig=;
 b=UB7ALBn7yU4N9BljTodWk/JnFKSCf8JnhhFWOjvfEGOnmid3DoKQvZ4jTrdNe+QaBk82Sb
 sAyrtacuFGafgpNU1/1xZsdHLVLDWlQF/HfwXQNqWRPzsiq+iiUzAcfN5/nNVmDXmI9Jq2
 aArtQnP8IMobFLDpgzAYTHT88s50ZB0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-Tf0mnLSUOC-qIBAJFt7AaQ-1; Wed, 04 Feb 2026 14:04:34 -0500
X-MC-Unique: Tf0mnLSUOC-qIBAJFt7AaQ-1
X-Mimecast-MFC-AGG-ID: Tf0mnLSUOC-qIBAJFt7AaQ_1770231873
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4801c1056c7so763405e9.2
 for <qemu-devel@nongnu.org>; Wed, 04 Feb 2026 11:04:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770231872; x=1770836672; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=MYOHd7OZhpLHGlsgoLBWOeyBZyIml693wIxtgYusuig=;
 b=gvKyK3YkHJoed+hemBVh4ZPObTaBjH3dfkOxWlpRkLP88aQnH5+bSmguo0/7Dk89L8
 +s8ClpqQbnvSBNw6yUkQP1eBrcmfyM6GE95AWDSereoEdggD93dq+peyATP1Aq/hrn3R
 PeUywj9YU8kjjZwwsQ3beQopKO2qRZbj50R+4XSrxQjR0Mbq+xDvEd968jAhr8aXWJF5
 mEQXMuXFZC9wuUD1MxTPe9vRd7gwvkz9QnsrmwH/u5UCRIoGfhGeMMZJyxUdQ77VRzIS
 PApu0XxBLVhAenyzMXOmbuLu4WiGFAQ/oqR5l8az34eb+uzQzrRtow3ZDqdUD7o3SJCA
 XVVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770231872; x=1770836672;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MYOHd7OZhpLHGlsgoLBWOeyBZyIml693wIxtgYusuig=;
 b=Ndpx7/+tIuhsrkJ95hxwnbqlJupa9PUsVCkwJrNwpZUury8g7DvSeOmF7fsW82pKEl
 VJkKbqCKRFdtl2tMKwhR4vm/kKLF0zVEmC9v3bCbKKDtQsYQlmnr4aoQsa83Xbeuz+5n
 aKeRHqLfSHLR3YuhqAx5JagmywpEzk1tNxvtfDNlKJFVODz6RJ5KYweMRuzV9O75P94b
 uf8mD/pQFbAvH7Bo821yNqCzyUWSgW11rmFh875H1ipr03OSt9xxb+QgLTDaqEO4SiRH
 4M43GEb4/3hpJLqiqMWa2NXbFe9BKLkyFhACtjiuMj6/i8PuCOWhR+/QWx5AQNaGoFjK
 d/AA==
X-Gm-Message-State: AOJu0Yy7sp9KN5WdNu23kO3hEA+qhvjTHPUHZ49kgUToMHt7wjPurXRm
 yx5ROUY5xYVQSqUe43EbUuNMg3BTkb0OCuX8JgCDOytqiwkG9Tb0L98BSZHQDRPCnxVfRk4Ktjg
 HY4gGH3qkzNzc8sGFxwNepe1pDyWkATrA/utDFkNw9aHHHTybpkfx3tJbRWhzqYUPLPM67pHYck
 98VaBiyHPOgZve16yB+XkNW0+SrAiLrb9wOA==
X-Gm-Gg: AZuq6aK5fG+Q8nLqQY+GOg5ZI902p8ez6sXcoIr6JMNgKJneVov1wiX2+usT14MBYxx
 bwtNPKNqdhEOaB/jkmhVYP/aXfP//z65yvkd7yiL5PV+bfEptDl7jrVL3gCfQ07PedbscJBOQKO
 86yCPz3+NDSnh618rSe+nMZjnnPxtkG0Fspp1EDcUr9djYuP8TxSzzQb27s+eohxtjXfU8G/tMx
 /d4jnW86+VL7aiQb/halPYspDtWS8XYLNpH2zmpAeDGnoiKlqiHtCG8kV1FnBquP/bb9oKs+3sq
 0D3P7zwMqD69j16ZDi2TS09iZRGpa7XCi7rdXQvFQOJp5shXkP+l+RGBUWOGyiz55VcTeJ9T1+W
 WRikD3zcS6v9SG5Js1xNwwnw18tTwIjLsUA==
X-Received: by 2002:a05:600c:444d:b0:480:1b1a:551d with SMTP id
 5b1f17b1804b1-4830e96d468mr54584575e9.18.1770231872503; 
 Wed, 04 Feb 2026 11:04:32 -0800 (PST)
X-Received: by 2002:a05:600c:444d:b0:480:1b1a:551d with SMTP id
 5b1f17b1804b1-4830e96d468mr54584085e9.18.1770231871920; 
 Wed, 04 Feb 2026 11:04:31 -0800 (PST)
Received: from redhat.com (IGLD-80-230-34-155.inter.net.il. [80.230.34.155])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4830ec6fc89sm25782095e9.6.2026.02.04.11.04.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Feb 2026 11:04:31 -0800 (PST)
Date: Wed, 4 Feb 2026 14:04:29 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Honglei Huang <honghuan@amd.com>,
 Markus Armbruster <armbru@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 44/51] virtio-gpu: use consistent error checking for
 virtio_gpu_create_mapping_iov
Message-ID: <24688ce275c19731c359af89a67f4f899be9fca5.1770231744.git.mst@redhat.com>
References: <cover.1770231744.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1770231744.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Honglei Huang <honghuan@amd.com>

Unify error checking style for virtio_gpu_create_mapping_iov() across the
codebase to improve consistency and readability.

virtio_gpu_create_mapping_iov() returns 0 on success and negative values
on error. The original code used inconsistent patterns for checking errors:
- Some used 'if (ret != 0)' in virtio-gpu-virgl.c and virtio-gpu.c
- Some used 'CHECK(!ret, cmd)' in virtio-gpu-rutabaga.c

For if-statement checks, change to 'if (ret < 0)' which is the preferred
QEMU coding convention for functions that return 0 on success and negative
on error. This makes the return value convention immediately clear to code
readers.

For CHECK macro usage in virtio-gpu-rutabaga.c, keep the original
'CHECK(!ret, cmd)' pattern as it is more concise and consistent with other
error checks in the same file.

Updated locations:
- hw/display/virtio-gpu-virgl.c: virgl_resource_attach_backing()
- hw/display/virtio-gpu-virgl.c: virgl_cmd_resource_create_blob()
- hw/display/virtio-gpu.c: virtio_gpu_resource_create_blob()
- hw/display/virtio-gpu.c: virtio_gpu_resource_attach_backing()

Signed-off-by: Honglei Huang <honghuan@amd.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Reviewed-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20260113015203.3643608-3-honghuan@amd.com>
---
 hw/display/virtio-gpu-virgl.c | 4 ++--
 hw/display/virtio-gpu.c       | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
index 741728cabb..ecf8494f36 100644
--- a/hw/display/virtio-gpu-virgl.c
+++ b/hw/display/virtio-gpu-virgl.c
@@ -561,7 +561,7 @@ static void virgl_resource_attach_backing(VirtIOGPU *g,
 
     ret = virtio_gpu_create_mapping_iov(g, att_rb.nr_entries, sizeof(att_rb),
                                         cmd, NULL, &res_iovs, &res_niov);
-    if (ret != 0) {
+    if (ret < 0) {
         cmd->error = VIRTIO_GPU_RESP_ERR_UNSPEC;
         return;
     }
@@ -705,7 +705,7 @@ static void virgl_cmd_resource_create_blob(VirtIOGPU *g,
         ret = virtio_gpu_create_mapping_iov(g, cblob.nr_entries, sizeof(cblob),
                                             cmd, &res->base.addrs,
                                             &res->base.iov, &res->base.iov_cnt);
-        if (ret != 0) {
+        if (ret < 0) {
             cmd->error = VIRTIO_GPU_RESP_ERR_UNSPEC;
             return;
         }
diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index f23eec6862..643e91ca2a 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -354,7 +354,7 @@ static void virtio_gpu_resource_create_blob(VirtIOGPU *g,
     ret = virtio_gpu_create_mapping_iov(g, cblob.nr_entries, sizeof(cblob),
                                         cmd, &res->addrs, &res->iov,
                                         &res->iov_cnt);
-    if (ret != 0) {
+    if (ret < 0) {
         cmd->error = VIRTIO_GPU_RESP_ERR_UNSPEC;
         g_free(res);
         return;
@@ -933,7 +933,7 @@ virtio_gpu_resource_attach_backing(VirtIOGPU *g,
 
     ret = virtio_gpu_create_mapping_iov(g, ab.nr_entries, sizeof(ab), cmd,
                                         &res->addrs, &res->iov, &res->iov_cnt);
-    if (ret != 0) {
+    if (ret < 0) {
         cmd->error = VIRTIO_GPU_RESP_ERR_UNSPEC;
         return;
     }
-- 
MST


