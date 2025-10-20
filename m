Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D7A3CCD193
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 10:43:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAnKy-0007Xd-4f; Mon, 20 Oct 2025 06:42:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vAnKw-0007Wy-Io
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 06:41:58 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vAnKu-0000gH-0v
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 06:41:58 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-63c2d72581fso4681791a12.0
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 03:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760956914; x=1761561714; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KmuoIaZJYNvFdS9rN3/tOhcWyvPFH8X8zZaP+5cgj7Y=;
 b=BSEk8dfFKg1ERZuw4Agz9aa2SgqVmus2zsiEY0mJfyk47PjXOiegAsJfQ7r0si8sH8
 TzCZYoLIyMubadWcXQXBrnWvG6QLBpX/pD4Sl9nHuDKLpY/Kew5OohpQkXG3Eqm9L6Rv
 +hv8hA05AXJL9NrwOYMikCqASPXre/XwEjmNrrqI8rHeR1/8ZobKK5NMp6gVa/bZtLq1
 Y28rsYgK0+VXq0ne2mv6yK15S2vLNH4LkrYY/DrHkbzZgAjkpKY/he02LJTxGApNfJHP
 rawSzaxjOpUCMhNXQDdlofAlZdYWqyJZH/UUHVA2zaRNdn5TKOJgGmaQ3u6rS/M9Z79i
 Z4Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760956914; x=1761561714;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KmuoIaZJYNvFdS9rN3/tOhcWyvPFH8X8zZaP+5cgj7Y=;
 b=jHsgHAunXGeMDDeSGffymHUCUiyaZ+TX6X3oIOOLYg9t/c5crvwPd8vuzwPIKwvGIO
 bR0Yvt0Sg1qrhuZsqpBcO8/D1ShrOCjmenSJRI2BH5/3OoPRoK7WNHnO3yGfBN4uZjiZ
 kmUDBCf/ioDCIFABXVsPQZjWJo/sISmph1wHdXcbjut5j9g0D0RscGnSe5i1GPo4BSUD
 gvh4HoGKJIJmBCmIwLfW2AOQyl5LbgG8C+lKKZDtqCMg61TGWQxRLZdqnJYQzQLw5IZo
 RItCg8l3B7XVT1cDWNRyGdPt+/0h+EliLmtgDuDz0PEaiFNqmbDcmQzROsvBf6p24PJF
 Q/ug==
X-Gm-Message-State: AOJu0YyVUmdpZ9MlYljWHjmXLKnSJhqWubzCMMthFFdgFFrufO/Y2Hy5
 CplvEIwbJ9DaGpTL0Ucp8xhlT5JZqnBlTci6t2uOBMC80Cmm9XnPsfud1oT5WVukjw4=
X-Gm-Gg: ASbGncu/OO5S5KGh4BmljpM7/L6CCX7DiaweFFQlmyQTPRu/QL7TPHYIYT//bjt9QuR
 s/3VAaHLMgz7f+uHPB2YfFX7Y9FzCNpzWX7mDpbJ9KNYox+9OmD8KpM4rIn1iJl2UXsyAWXTEKq
 nzinEU66ErKgWTXxv3g3wEH+ZtDJq5yZL/OyxfEgpj38V3ysynCUtEaQIiF4orV1lsQ1QpM1Znw
 V5f54CVq0cDeZf5+nxKadGGTapCq+lz7Ork2gjmv8fkcP67wiS4feE9DdG3z5BCWOccjkU6HIpx
 VzswBzRmv+5hh88PVkQh4FAkjxphLkif2brbV28WqzvkIXjYWGkGGsDWZHkZkgLbOjeH/C63U9k
 LJQ0W1h0pnGEZlv1ugyoA5qfm536pRfaJPNsATAwzELllLhp3XBSITbzzBrrajrLsj4+46AJ8dP
 1VfjrDr8S9dAk=
X-Google-Smtp-Source: AGHT+IGEnHTAs6zU3fPWxPyPSJsBGHsRI4QAhZ31vHAAF4emgvdV5hhENK6LCrx0IrP5mUqymE7tcA==
X-Received: by 2002:a05:6402:524c:b0:633:7017:fcbc with SMTP id
 4fb4d7f45d1cf-63c1f69cd11mr12764098a12.15.1760956914229; 
 Mon, 20 Oct 2025 03:41:54 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-63c4949bed7sm6346663a12.35.2025.10.20.03.41.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Oct 2025 03:41:51 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id EEE655F9F7;
 Mon, 20 Oct 2025 11:41:49 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Andrew Keesler <ankeesler@google.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
Subject: [PULL 04/11] Support per-head resolutions with virtio-gpu
Date: Mon, 20 Oct 2025 11:41:42 +0100
Message-ID: <20251020104149.4034124-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251020104149.4034124-1-alex.bennee@linaro.org>
References: <20251020104149.4034124-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52e.google.com
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
Message-ID: <20251016150357.876415-5-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

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


