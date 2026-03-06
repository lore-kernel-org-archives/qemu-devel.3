Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 091DFFCC066
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 19:51:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vybCN-0004B1-Cw; Fri, 06 Mar 2026 14:50:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vybCL-0004A9-Vs
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 14:50:58 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vybCG-0000Pu-Qh
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 14:50:57 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-439cb5af25bso3069796f8f.1
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2026 11:50:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772826651; x=1773431451; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ajuMgwjCTtN4ZPB1zEJyv0G4VENDgEDxiFhANRLA7Jg=;
 b=mlAmj90pYLs+MLyCpO/yPBzqySyF1PiwWiw7pNygypm2kL9ZcgSLouuWgIlpxwtAjS
 1xpxHMk3gLaF/7l2DVW9gUVX5+geBxU9DtiP99Zgwn8zRcUYofZdK81g19yFzXZUIH4P
 aXK5zmiALIaReOWXOKIeM5SbAhpC2+O/86FNFbfSRmuN9zyYXdCjYOwsQcfNMhFcB8RP
 akqGKyImdZvrt5+p2cVP4xkDIOYPJyGVNVpKLQhvCCCVZIU99clHFJTemSILrBfd6zZL
 UQgujpKEJXCkSfZSAbAXghu3nuZTC2V1gkVASHHmvz/xyVFVv5983rz74M19FEAm7pUf
 P7tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772826651; x=1773431451;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ajuMgwjCTtN4ZPB1zEJyv0G4VENDgEDxiFhANRLA7Jg=;
 b=mI+mVIQ8Vi5vQYyiZtzJ4bCEO6enG4QsjDhVsSXhPywBOcFlqJnPyfxeGKZ38Il+lQ
 0KmBc9lpIXe5+uGF6Rdge5gRnJ+KF1U4UuTaooVppR9QQxEmAkStQ2f9siyYXLefJETm
 4u86HKoFBQKd9+EZRGdNjD3Vm2KO152LzUFI2O9bI4negqrpctWuCUWU0o6/MgcOmavb
 cF73nMsZtVkKSg2aqBAmZl5uu1SjvYjSBksZALF7XCYgejPIaRyUoQ7TciwP9yK7lraC
 nbYoaMpcprlosu9ewwL3K+gjGVgARoHvuMgnoApBHvrYT23L9EPMAduTEkUcjHPNJg0t
 +70w==
X-Gm-Message-State: AOJu0Yw7BwC9F9kmhRO/C49IUu3F5aog9MlZOlzdv5ctebIOHPaLYdXP
 ydOMZWjyOUZnqWa7sWsRo9c5yGMs4Gz43+apNrcxc4/889cZ/FdBe25WgvpTDkD5Q6k=
X-Gm-Gg: ATEYQzwss1VwkCKJEqmjBWMrbwO1DzdaSS9X0XvyjTpKOIntoSDx99dzY/HNC+RfG9o
 QnI3vwqlK9q47A2greEWLkvPnOt1BlwblGvaDOMG3ZqHQYcPUvw93ry8Xme09RBl6TLPhmzEfP1
 ESvhH1YS5kcaBd8fqWDuaHqxQ10mTCP01Qqjo7iTApkTIDxO9HgecZQpREt0qJQZlFFrMR6u1U1
 jeUqp08kvs9oaqdtWmjKjPtodBphWC6R5oWi65V7/qCSYorOScZT3jt7+mqunDc2D8AkNtXLg+p
 VM/0AMMCdgR67tSILoC6+46n3so61YPAY5tUjga4U5081Gez/YlzGnMSbUWl/fSslkOHaqnhIMf
 vlgc6d6o/Gr4TxLG83HY1WFBOhYqolHJgwjvomwbPqc5Xocc2iJXMB00RglnN6NAQ3Ixstb7v+C
 iZf9Pz3Y0rN2Bx2VfxDW/rgbSTlFd6KHv1hg==
X-Received: by 2002:a05:6000:400f:b0:439:b59e:5e65 with SMTP id
 ffacd0b85a97d-439da355a90mr6060205f8f.6.1772826651254; 
 Fri, 06 Mar 2026 11:50:51 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439dad97be5sm6191805f8f.11.2026.03.06.11.50.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2026 11:50:49 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 03843689D0;
 Fri, 06 Mar 2026 19:50:49 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Andrew Keesler <ankeesler@google.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Eric Blake <eblake@redhat.com>
Subject: [PULL 01/20] Support per-head resolutions with virtio-gpu
Date: Fri,  6 Mar 2026 19:50:28 +0000
Message-ID: <20260306195048.2869788-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260306195048.2869788-1-alex.bennee@linaro.org>
References: <20260306195048.2869788-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42c.google.com
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
Message-ID: <20260304165043.1437519-2-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

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


