Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6E59CCD199
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 15:06:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9PWZ-0002Ci-JR; Thu, 16 Oct 2025 11:04:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v9PWX-0002C6-TA
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 11:04:13 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v9PWO-0001AL-Mm
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 11:04:13 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-426fc536b5dso470574f8f.3
 for <qemu-devel@nongnu.org>; Thu, 16 Oct 2025 08:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760627042; x=1761231842; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LKX1JcbUUcRo5zoCpPFg8mImjKOb7aFJD3nDg/qhPKo=;
 b=Ny5o+O6GeYt0zaIA8ejMj7RNSqc7fUM84tk/fQBc3dl9i5SV0G5145dJgjQh9RF/s6
 UECZrFZ/Y1aJpIr5DTHuG78228aFS2tiNp+ZHVVYZXRy8sVHKOGr1OwCpDliO4pvmRDa
 ZWUv+pRdkEyOhzN3UpKcFT+KcKB8nEBiwy0371z6nRG+A6rCDH1cw4qGL5KhcRvTAax/
 mKDP55yuJ6nhYrK9lVHx3F4egmNL4YCpyRsjZKWRHvUxxnYGwPhjzzXKWLiKrjsfkoly
 538OBN86XQsEpzKldrpX/6//9Sc1l6YviZnhuajBnKPdg3LLeSC/UMl04MHhn+Ew/doq
 fFjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760627042; x=1761231842;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LKX1JcbUUcRo5zoCpPFg8mImjKOb7aFJD3nDg/qhPKo=;
 b=BXpYoMb48IWOrQSjoFtc42R5CA7DI2j3twvhkdG6fZOKks9T+Y/N/5TERZsCCzViop
 rgLzuoXvf68cBHv170JXWahefmXy/tSHPeAB9CM/0mbFwkjwrkq2IcpSb5ZNyZT0ocYw
 brhewkqAATizObNn1lUZasqlQSl1Isk8cgpS+eIAk7ZdFhtsjedzfR1letpSgwAaLNWT
 kc+yKrvdEQ+z1s1bdVF+ierPX7Qhr6CUsoTLP4yQJIdvYpGj31SqGDfgWHnS+mSs4STM
 hUIlvSJroXJ/m+45X9c6z7tWeZhqRlXJyjnRBIQq3fSsw38WaiRsSJ9Yvnnm5RmuPfEI
 q6kA==
X-Gm-Message-State: AOJu0Yw3WdAbW7n6kcyAdr/843RQqhWGTOgBYf3LT30AJNTYq3q1TPwY
 Vq6tA+ybYfcJdl1RZ3UIFP2AO+x5UvlBgodmdV2N02C1OwGjPYb/9HTgYHF/tR1Bqvc=
X-Gm-Gg: ASbGncszwYo//KOML1/MFPF2nJP3tQvC22vv9VPJNhh6cq+UqQeTV+n1LOVjPcK6vlx
 rE4GHi2KBfOAL9q6QCx9ICEzOzgvssWTNmbuRQm8yzgKRZsLykpNu0eqMrdbB8QzfT7FQhZc5ub
 kNZe5cjYEXo+rEy+SKq4P1zR5N/tEXyVv6uQmq2Dr92UFsrllo4W+aYTz2yhsFrsuHmYjuCBns+
 X/Ld89LsfzRtdcZNNpaHi2ahNmSE0bf86CmG7n6O3A6o04HPFlIGXPMn27sQ5q8F2uNbyNNuig0
 o7nOJdKKtFuiv96djGljsDnfarNDP4GaQcWQyXvggIJcMXh2huRZOS+omKMBJEeyC3cguj/OqoR
 pUDBvflHPkC9QU3jdOoBt4PapbWo+vXX0DeQ8x4xN3+kgStPcA1eYJaVhczdl0r1RqKyTZwzn4u
 VxdICX
X-Google-Smtp-Source: AGHT+IG6GNVsampnh5gf3rQc+2jQ/s9xgWyJfv0gSmPXT4OYAEMJYLUMEM/J/6OLcMkvZpqMRhKwLQ==
X-Received: by 2002:a05:6000:4b08:b0:427:526:16aa with SMTP id
 ffacd0b85a97d-42705261894mr181971f8f.58.1760627041575; 
 Thu, 16 Oct 2025 08:04:01 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426feeb7441sm4722744f8f.43.2025.10.16.08.03.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Oct 2025 08:03:59 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id D3BA45FAAE;
 Thu, 16 Oct 2025 16:03:57 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Levon <john.levon@nutanix.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Thomas Huth <thuth@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Andrew Keesler <ankeesler@google.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 04/11] Support per-head resolutions with virtio-gpu
Date: Thu, 16 Oct 2025 16:03:49 +0100
Message-ID: <20251016150357.876415-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251016150357.876415-1-alex.bennee@linaro.org>
References: <20251016150357.876415-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x429.google.com
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
[AJB: dropped pointless output_idx range check, tweak commit]
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 qapi/virtio.json             | 10 ++++++++--
 hw/display/virtio-gpu-base.c |  9 +++++++++
 2 files changed, 17 insertions(+), 2 deletions(-)

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
index 7269477a1c8..14058f6bffb 100644
--- a/hw/display/virtio-gpu-base.c
+++ b/hw/display/virtio-gpu-base.c
@@ -233,6 +233,15 @@ virtio_gpu_base_device_realize(DeviceState *qdev,
     g->req_state[0].width = g->conf.xres;
     g->req_state[0].height = g->conf.yres;
 
+    for (output_idx = 0, node = g->conf.outputs;
+         node; output_idx++, node = node->next) {
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


