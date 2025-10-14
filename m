Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89EC5CCD187
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 11:15:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8cxZ-00081I-Si; Tue, 14 Oct 2025 07:12:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v8cxS-0007vk-Qr
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 07:12:47 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v8cxO-00081u-AQ
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 07:12:46 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-b5a8184144dso226890766b.1
 for <qemu-devel@nongnu.org>; Tue, 14 Oct 2025 04:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760440358; x=1761045158; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j/kw8tYIwMBnzBLUietdBRI+PGY5gSak1QKmauHgZS8=;
 b=Dlk3VAGB9dJq8iJSWVpniELaIWLMoS8Ab1dHeDP7Ml7bIGh01CtKeagMwdZo1cb6MM
 ElVjPIU1QYJEyTjDSzWwknQ5xWe9PDWhsOBhTzhefizQagiIVoxNE549T1kLn/zUL81M
 SvS4oiEyHpuV7BKg9QOXAKyJP/ip5TkF2OVEfM1g8YzaYkithnoWh3taKmcptJ7fiAeq
 X+OypvQFe73lFfOl2oW51X3Yi2h0zYxVIvAahCLwzUm/rlGJLWpseHzgmBDk0bZF6Rhm
 bG5hCIoPOJw7f1aQk5XU56SYnjKHV0HwOdQ6Y8BKrYG2rXH68j9NVBENCzD2uZYOvtbI
 f2eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760440358; x=1761045158;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=j/kw8tYIwMBnzBLUietdBRI+PGY5gSak1QKmauHgZS8=;
 b=Q54Zc7KxZxNPujxg5Z27StWVbC+pNw+5vtXvcq49lqmQSJpCEuhTmjBopZw3Ohai40
 6+UUPCfyzB8yMOMyAlaWm5tTJkthP3eFhN+7KlZk6tw239S5CSyFIoOi+Fb+pmnUcZ7q
 E9ubU9q5syBpvKD61bpMtW+HPM7/2sm611WsSsUnS1CEO/okcoym5hK99qhpcFW4P67m
 khrLAFLlmhNVu5Pk9xuDLJvBvP6luvoDzui4MvfVFre6/wHGLN+XkS+HwaLyrWR3NRNS
 Wa+3vTBHYLWxxNwW+T8bAHwcxrULC2Msv0ROcEPN+smCKV/1icorFGEKVbuFIpGY8DnC
 P5ug==
X-Gm-Message-State: AOJu0YzmZpdhIeX8MScLYOJEffS+I1OfLCRU8y18dXN0LNYsLsRPXBt+
 +sCawXs7L1aSik9TMwmnGQn0K5v1lvOB9x4N8DcBB2pxxLOcsEvRXnQWHtDLas8I87k=
X-Gm-Gg: ASbGncssRTomGShUhPEiHkIp9Mj+aj2pObeIc5ByKWKHKGAgS2Aier8JYF/qf2WIwTP
 SQehBhjuwmJp0hfAOAhizODgiDLET5/l8aIe5SmA/NAGKIzIlEgXHGPIzFTLXjU6eAlyLTV827L
 lfPaFT0zb1NTQdj8uQKdfFa9knDQiGeZOBgOihJ10nAn6BXqOzDpnI8ZWMhdDVQnExlxRlVxi9X
 kpvldI3NjisWzxR8YsEoPqJDpIWOxGgdsS6ZzwcJaKKfLF5peUg+iKq8goNuFbNm2sydfpEMMBj
 uAuMI56SHRu5c0veIy0twSQToLTRjShN+hDfSDxYMOHfNZFyFak6HPCjedUFkKfCbC2sGB0ZIK9
 JsmyuwC6MNNJhepVC+i+QsK/qpod25fVXHy6cH/XMCAkyuA==
X-Google-Smtp-Source: AGHT+IGmVtbq3KsPtESdOWmj6fQM0KKisYYnvk4u+b0iGptwk2279uwTHKTo7zmh6e3FNPabruOkbw==
X-Received: by 2002:a17:907:868b:b0:b3e:babd:f257 with SMTP id
 a640c23a62f3a-b50aa49207amr2896780366b.10.1760440358209; 
 Tue, 14 Oct 2025 04:12:38 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b55d951ceb4sm1133750766b.72.2025.10.14.04.12.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Oct 2025 04:12:35 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 28D2A5F82B;
 Tue, 14 Oct 2025 12:12:35 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Xu <peterx@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Andrew Keesler <ankeesler@google.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 1/8] Support per-head resolutions with virtio-gpu
Date: Tue, 14 Oct 2025 12:12:27 +0100
Message-ID: <20251014111234.3190346-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251014111234.3190346-1-alex.bennee@linaro.org>
References: <20251014111234.3190346-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Andrew Keesler <ankeesler@google.com>

In 454f4b0f, we started down the path of supporting separate
configurations per display head (e.g., you have 2 heads - one with
EDID name "AAA" and the other with EDID name "BBB").

In this change, we add resolution to this configuration surface (e.g.,
you have 2 heads - one with resolution 111x222 and the other with
resolution 333x444).

  -display vnc=localhost:0,id=aaa,display=vga,head=0 \
  -display vnc=localhost:1,id=bbb,display=vga,head=1 \
  -device '{"driver":"virtio-vga",
            "max_outputs":2,
            "id":"vga",
            "outputs":[
              {
                 "name":"AAA",
                 "xres":111,
                 "yres":222
              },
              {
                 "name":"BBB",
                 "xres":333,
                 "yres":444
              }
            ]}'

Here is the behavior matrix of the current resolution configuration
surface (xres/yres) with the new resolution configuration surface
(outputs[i].xres/yres).

Case: !(xres || yres) && !(outputs[i].has_xres && outputs[i].has_yres)
Behavior: current behavior - outputs[0] enabled with default xres/yres

Case: (xres || yres) && !(outputs[i].has_xres && outputs[i].has_yres)
Behavior: current behavior - outputs[0] enabled with xres/yres

Case: !(xres || yres) && (outputs[i].has_xres && outputs[i].has_yres)
Behavior: new behavior - outputs[i] enabled with outputs[i].xres/yres

Case: (xres || yres) && (outputs[i].has_xres && outputs[i].has_yres)
Behavior: new behavior - outputs[i] enabled with outputs[i].xres/yres
Signed-off-by: Andrew Keesler <ankeesler@google.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-ID: <20250902141312.750525-2-ankeesler@google.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 qapi/virtio.json             | 10 ++++++++--
 hw/display/virtio-gpu-base.c | 10 ++++++++++
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/qapi/virtio.json b/qapi/virtio.json
index 05295ab6655..0ce789bb22f 100644
--- a/qapi/virtio.json
+++ b/qapi/virtio.json
@@ -971,15 +971,21 @@
 ##
 # @VirtIOGPUOutput:
 #
-# Describes configuration of a VirtIO GPU output.
+# Describes configuration of a VirtIO GPU output. If both xres and
+# yres are set, they take precedence over root virtio-gpu
+# resolution configuration and enable the corresponding output.
 #
 # @name: the name of the output
 #
+# @xres: horizontal resolution of the output in pixels (since 10.2)
+#
+# @yres: vertical resolution of the output in pixels (since 10.2)
+#
 # Since: 10.1
 ##
 
 { 'struct': 'VirtIOGPUOutput',
-  'data': { 'name': 'str' } }
+  'data': { 'name': 'str', '*xres': 'uint16', '*yres': 'uint16' } }
 
 ##
 # @DummyVirtioForceArrays:
diff --git a/hw/display/virtio-gpu-base.c b/hw/display/virtio-gpu-base.c
index 7269477a1c8..6adb5312a40 100644
--- a/hw/display/virtio-gpu-base.c
+++ b/hw/display/virtio-gpu-base.c
@@ -233,6 +233,16 @@ virtio_gpu_base_device_realize(DeviceState *qdev,
     g->req_state[0].width = g->conf.xres;
     g->req_state[0].height = g->conf.yres;
 
+    for (output_idx = 0, node = g->conf.outputs;
+         node && output_idx < g->conf.max_outputs;
+         output_idx++, node = node->next) {
+        if (node->value->has_xres && node->value->has_yres) {
+            g->enabled_output_bitmask |= (1 << output_idx);
+            g->req_state[output_idx].width = node->value->xres;
+            g->req_state[output_idx].height = node->value->yres;
+        }
+    }
+
     g->hw_ops = &virtio_gpu_ops;
     for (i = 0; i < g->conf.max_outputs; i++) {
         g->scanout[i].con =
-- 
2.47.3


