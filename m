Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21DC4EF900B
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 16:51:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxpR1-0003rs-Ja; Wed, 04 Mar 2026 11:50:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vxpQx-0003pS-UQ
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 11:50:52 -0500
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vxpQt-0002PC-U4
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 11:50:51 -0500
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-65bfc858561so3383315a12.2
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2026 08:50:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772643046; x=1773247846; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UZAvHG40jXQMBngawC8NrPyT3mArKFlvPG9XrbzWnFE=;
 b=r80TizfW5A0K2c5OUJzq1zs/7w9Biwtl0zL6OdhnQot2cQl79qbbOJ2eGtvvl0VKI2
 fVnpPWBGIH1KCjTtV+coDKfNBQ5i8kBqMKHA/LN3qXziNbTJFHg/5SDSMaQLQAaXeQl7
 x8wB3anTNbX8i9jE6OEueJ9q5kg6EZoW8YQMis9E6/F6PfV6Ahr+uvRW7Z1xU2jP4duJ
 PaMYeVqRR6u5Vf94UnT3BvYqo5ojPsgpCkM7d6/243F2+LE+V1jlAnWnCihQxLMFggvO
 stXlh+9ImaKC751DpMO8aFMc6aX8qb8TL2DStaO1unKvkIwi2yNkIvxZmgQw1QD2Q1G4
 qP6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772643046; x=1773247846;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UZAvHG40jXQMBngawC8NrPyT3mArKFlvPG9XrbzWnFE=;
 b=RMc3XIZcONiAyE5aWdED00+BK2RXLogXwxJsacAvDmXYlR8y4ebq5uMFTM8lhU9oJG
 tF3zXshwuY3y+sFRhr1KJNq1DC4ZxtuhN0AcNZ1Uc4Q+4Z0ZtHGh0EhY3dDA6nzgyJs5
 iacphJFJ6syrnU6bvpTIo0hz2nFEG2SscpDMQGdmOZ1nvIA8rCuHX0GUph8VOEDUbSQO
 mOr2FOs0Aj6TC+UHnE2iqZ4EV82W6kHvzc7lZ3MVwaEHG5+95m3IqLLlM1RfyaycDttC
 5fG4diKkfcyc+LTBOvo8Cose/FfzfJT0ZR9cKY+oRfk5voQtVOymV1tMBozCad32o3/x
 nBNg==
X-Gm-Message-State: AOJu0YxmK0LlU/2/9pERIrPd5t9RcObfEfurAMPWEaWnNYKthx+2I+cG
 E7qibGdjDk7pXLI+9QaAzuMylcOrhVnr+eHFsGmhnVyxgF6jBszGzPD0ggnr52H72cs=
X-Gm-Gg: ATEYQzxwjWiXh/XwDS2XraqRmz3pApFo/xNty13+2hmHz9mhDJx2XWwa7ZZDWFpTZK4
 Km7voceZAmskO6kqOhAO98s7TnL842+pNU9r9AMSgnppbm4BIQac7QskWC3andJ/ZKrlvfEa1V3
 lXrNYVOlCsePS0ql80GexUlO4+6bgI9hyNs31AbrmhJkYdojQ+NZwwgGN/EloxwW5SaoLMKkGkB
 95/rbAus+EMRoFXDop7g/53HfEa+j3L7Ux8tyD7VD3Cj+FtvdWA7SiWOl4M9yAb5kMgztvDbeqk
 xiv1s0jSi0t3iKbEhY+cQ/e6NOSims9WdFs9MLsOipY3RId4SLsxRtNrklPXCIbBonDt2fj7MnD
 HaztbV2cPD+624E5w7Fx6kKZT+AfE7aLmnWDiWmOk+TopFqm4GPvVMGJ742DodJhltG8bc4785S
 NOOWI5Bl03zC+y96017onK2VI=
X-Received: by 2002:a05:6402:40c8:b0:660:48f:22b9 with SMTP id
 4fb4d7f45d1cf-660ef78bfc7mr1456247a12.12.1772643045513; 
 Wed, 04 Mar 2026 08:50:45 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-65fac06e3fasm5775501a12.25.2026.03.04.08.50.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Mar 2026 08:50:44 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id C78285FB2D;
 Wed, 04 Mar 2026 16:50:43 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Andrew Keesler <ankeesler@google.com>
Subject: [PATCH 01/20] Support per-head resolutions with virtio-gpu
Date: Wed,  4 Mar 2026 16:50:23 +0000
Message-ID: <20260304165043.1437519-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260304165043.1437519-1-alex.bennee@linaro.org>
References: <20260304165043.1437519-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x533.google.com
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

Note - we use "xres" and "yres" (instead of, say, "width" and "height")
to match analogous virtio_gpu_base_conf.xres/yres.

Case: !(xres || yres) && !(outputs[i].has_xres && outputs[i].has_yres)
Behavior: current behavior - outputs[0] enabled with default xres/yres

Case: (xres || yres) && !(outputs[i].has_xres && outputs[i].has_yres)
Behavior: current behavior - outputs[0] enabled with xres/yres

Case: outputs[i].has_xres && outputs[i].has_yres
Behavior: new behavior - outputs[i] enabled with outputs[i].xres/yres

Case: outputs[i].has_xres != outputs[i].has_yres
Behavior: error

Signed-off-by: Andrew Keesler <ankeesler@google.com>
Acked-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20260210123038.2332364-2-ankeesler@google.com>
[AJB: fix format strings for size_t in error_setg]
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 qapi/virtio.json             | 13 +++++++++++--
 hw/display/virtio-gpu-base.c | 16 ++++++++++++++++
 2 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/qapi/virtio.json b/qapi/virtio.json
index cd67c4f52e3..09dd0e6d05a 100644
--- a/qapi/virtio.json
+++ b/qapi/virtio.json
@@ -970,15 +970,24 @@
 ##
 # @VirtIOGPUOutput:
 #
-# Describes configuration of a VirtIO GPU output.
+# Describes configuration of a VirtIO GPU output.  If both @xres and
+# @yres are set, they take precedence over root virtio-gpu resolution
+# configuration and enable the corresponding output.  If none of @xres
+# and @yres are set, root virtio-gpu resolution configuration takes
+# precedence and only the first output is enabled.  Only setting one
+# of @xres or @yres is an error.
 #
 # @name: the name of the output
 #
+# @xres: horizontal resolution of the output in pixels (since 11.0)
+#
+# @yres: vertical resolution of the output in pixels (since 11.0)
+#
 # Since: 10.1
 ##
 
 { 'struct': 'VirtIOGPUOutput',
-  'data': { 'name': 'str' } }
+  'data': { 'name': 'str', '*xres': 'uint16', '*yres': 'uint16' } }
 
 ##
 # @DummyVirtioForceArrays:
diff --git a/hw/display/virtio-gpu-base.c b/hw/display/virtio-gpu-base.c
index 7269477a1c8..cb76302e2d8 100644
--- a/hw/display/virtio-gpu-base.c
+++ b/hw/display/virtio-gpu-base.c
@@ -233,6 +233,22 @@ virtio_gpu_base_device_realize(DeviceState *qdev,
     g->req_state[0].width = g->conf.xres;
     g->req_state[0].height = g->conf.yres;
 
+    for (output_idx = 0, node = g->conf.outputs;
+         node && output_idx < g->conf.max_outputs;
+         output_idx++, node = node->next) {
+        if (node->value->has_xres != node->value->has_yres) {
+            error_setg(errp,
+                       "must set both outputs[%zd].xres and outputs[%zd].yres",
+                       output_idx, output_idx);
+            return false;
+        }
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


