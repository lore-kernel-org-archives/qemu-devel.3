Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D868CCD19A
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 15:06:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9PWk-0002F8-7O; Thu, 16 Oct 2025 11:04:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v9PWf-0002E2-Gm
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 11:04:21 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v9PWR-0001Ag-1l
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 11:04:20 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3f0308469a4so635369f8f.0
 for <qemu-devel@nongnu.org>; Thu, 16 Oct 2025 08:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760627044; x=1761231844; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UBrmEioes5BcTvg3mWej6DkCUcELOhpLd7xx/WVVmZs=;
 b=zUItmF04rCFYAhOYy7a7W6y+3GIUGF6FKd5+yBKUbMgyqyCZuZOW4uc+7qBdmQaX/g
 fNDFab6zLKvLbmxejzKaQF7GUP4WAC9TNYBlh1TD75KLjmgf5yFu1T71oPQGQfKAKsDs
 PozvLp7OgHhrZyyZqDqDEZXiCiqytHSCS+LSoFfWRsSk5V2YAKIZGWEUD78y29186vL4
 XeAWrvbr36GvU2+l1SpTGeyweRkBr/b+SYajXLir/9y5pyde7eTvDMKygZW/jyDNOEt/
 WrHJNREWjLf3sXfKydUegVB/3kcoYzPlTO5cGOzqsYo7d6Me6ZT9riJug7KyBNFolltn
 nrMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760627044; x=1761231844;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UBrmEioes5BcTvg3mWej6DkCUcELOhpLd7xx/WVVmZs=;
 b=er6IIveAkQi32TUJ8wtSQBWYbqMHq4JHn3mU12CtuFv9pV0k+Csx5kA0pSaw/uKBJF
 DwkODUnUn/y5xeWiVghuzxoj5wDZLe+1qnhS1Ad9VLkwiuy/TmkF6j1hGRO6ex6hiJ7h
 sBGSRsGoopMe9Ypqkv6eAJWtq+OHuGO2Helf4guuvcNtfqeNqr0BdMdgD9QpusWal0jL
 +/p1AUCvA2KlyV3jZuCpggsSCU51bRk6GHHuAht7ltDi2T9PeYgI6u1tYz/ttWJhwRZU
 QzDHA6i+i19d8el/jY5Hjtc3Jk0wmPSaulnYElpSIzCvp5Py9SSvr/utBKvsxSoW/2oQ
 ufGA==
X-Gm-Message-State: AOJu0YyCeTWQNcmSW29pwXr9jwE74Uss581a+toV3vAoYyeIUVM1yTYd
 ieqQfisJeu76x8apDvT7tyJblcbqiEI5D9bz/jmEQCgwcivbFxMJX6b1M8buzKWiYq0=
X-Gm-Gg: ASbGnctapxzVNOVhvlfM/hfDT0i/QC5bFxp+cFQ9zKNkkU5Tu9VjAP4ljBubA64jpjq
 ln0Q+T3/LQwsWF2aBb11zcr671IHUVWA/KIqOmNODDjQUiINOG71mnErDO2xxhpKBBoHuYpB2hy
 PxPLYDmoy2MH1OPf3PxbEQCj2XEUENIZfY2B1fug9McQRpT65lZyWE1v6qSv7GCJG/B3ktv1IYS
 xy8U3YZool8InxT3WPA4AX2RdeNMtpA2kmIRbzFlnbaU7Jubfiua76LBts1uwluBqxj+s+hx6B6
 Qcrbc+n9OsRH2UZLtXnyUUrGV7tcWmuIojdCVjoZ1Ej7UCDE7yor1+fcu0zdxMLU68DmEqYVmjg
 uFc07cnzetMJupxmKVj8dJZ3RX+6IVuZoU3y/0dyk8AZ4FCWIXBDM+pn8p2eWXh1C8KEREDO++j
 8F
X-Google-Smtp-Source: AGHT+IGidc46ksb55VYkEQ2ctOcuO5Kok6UJE2BXc+kXHohYK04LJWkpjhBdomLr955V0jZ/h98HNw==
X-Received: by 2002:a05:6000:240f:b0:425:8bf9:557d with SMTP id
 ffacd0b85a97d-42704d9e934mr342256f8f.44.1760627043795; 
 Thu, 16 Oct 2025 08:04:03 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce5cf6b4sm35470459f8f.25.2025.10.16.08.03.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Oct 2025 08:03:59 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 11E605FACF;
 Thu, 16 Oct 2025 16:03:58 +0100 (BST)
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
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: [PATCH 06/11] hw/display: add blob map/unmap trace events
Date: Thu, 16 Oct 2025 16:03:51 +0100
Message-ID: <20251016150357.876415-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251016150357.876415-1-alex.bennee@linaro.org>
References: <20251016150357.876415-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x431.google.com
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

As these events happen dynamically as the guest does various things
they are quite handy to trace.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 hw/display/virtio-gpu-virgl.c | 4 ++++
 hw/display/trace-events       | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
index 94ddc01f91c..07f6355ad62 100644
--- a/hw/display/virtio-gpu-virgl.c
+++ b/hw/display/virtio-gpu-virgl.c
@@ -134,6 +134,8 @@ virtio_gpu_virgl_map_resource_blob(VirtIOGPU *g,
 
     res->mr = mr;
 
+    trace_virtio_gpu_cmd_res_map_blob(res->base.resource_id, vmr, mr);
+
     return 0;
 }
 
@@ -153,6 +155,8 @@ virtio_gpu_virgl_unmap_resource_blob(VirtIOGPU *g,
 
     vmr = to_hostmem_region(res->mr);
 
+    trace_virtio_gpu_cmd_res_unmap_blob(res->base.resource_id, mr, vmr->finish_unmapping);
+
     /*
      * Perform async unmapping in 3 steps:
      *
diff --git a/hw/display/trace-events b/hw/display/trace-events
index 52786e6e184..e323a82cff2 100644
--- a/hw/display/trace-events
+++ b/hw/display/trace-events
@@ -38,6 +38,8 @@ virtio_gpu_cmd_set_scanout_blob(uint32_t id, uint32_t res, uint32_t w, uint32_t
 virtio_gpu_cmd_res_create_2d(uint32_t res, uint32_t fmt, uint32_t w, uint32_t h) "res 0x%x, fmt 0x%x, w %d, h %d"
 virtio_gpu_cmd_res_create_3d(uint32_t res, uint32_t fmt, uint32_t w, uint32_t h, uint32_t d) "res 0x%x, fmt 0x%x, w %d, h %d, d %d"
 virtio_gpu_cmd_res_create_blob(uint32_t res, uint64_t size) "res 0x%x, size %" PRId64
+virtio_gpu_cmd_res_map_blob(uint32_t res, void *vmr, void *mr) "res 0x%x, vmr %p, mr %p"
+virtio_gpu_cmd_res_unmap_blob(uint32_t res, void *mr, bool finish_unmapping) "res 0x%x, mr %p, finish_unmapping %d"
 virtio_gpu_cmd_res_unref(uint32_t res) "res 0x%x"
 virtio_gpu_cmd_res_back_attach(uint32_t res) "res 0x%x"
 virtio_gpu_cmd_res_back_detach(uint32_t res) "res 0x%x"
-- 
2.47.3


