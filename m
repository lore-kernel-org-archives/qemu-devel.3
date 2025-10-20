Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B508BCCD193
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 10:42:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAnL1-0007aA-EU; Mon, 20 Oct 2025 06:42:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vAnKy-0007Xk-6R
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 06:42:00 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vAnKw-0000gh-0N
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 06:41:59 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-b48d8deaef9so826218466b.2
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 03:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760956916; x=1761561716; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AeXvTgpu9wvcZBhqOo2JhRfO+nkbidkcx8BpjGy3qRY=;
 b=ZeZ3uq4TzK6w+xUFGcZiC0tC1ggkKl7RoS9dSLCTLCz9g1SGtCLyV8ax6SK9fVoiim
 cG+36WljapehYE1AmSv9coxzvtKqr8t9A17b0wpfko6RtcdgTkgLRWZrqnuzmhoYdo0T
 7r8StXfGaIyKuu+OodYC2Ny0BUWM7Sej2uT5CSnaCr58pJegNdScld3a4bzVe1iOqyVI
 EhCp2ZqHlGxPozAPmmQbJllpEPNRCUctfA1GyQaS7ZAq81+WLVEwdS8FAHELnnKBPoHH
 2gt/WakQXaJqtdXVsbLA2hsUIHFNlLJ3oy3o1QnX6ZulB7pV+SR9XucqDOn3q3Sz504R
 wwLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760956916; x=1761561716;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AeXvTgpu9wvcZBhqOo2JhRfO+nkbidkcx8BpjGy3qRY=;
 b=MHfZB/p/BuJ6J5sjDPhYtRRv6ot55vHLiJFHb2SADWUP/wfkI/o9c/WS1R+CwH26yS
 AdXZO2SgO1c0zLoRyZBpdw+b69qcWXb8uxCRKCCoY3sgn09LUWZ37hFnnq6lXAg9Tmtm
 nME4V8szNIFAwJBBTJubUMicqb2UekKO9INf1GHW1XT7sDpURIJAPr/GxipSGVCZcqiz
 /a7QPIWAT/sqnbrNfDxYXyPDt0u7ucoW5UzQDgSxs4hAtLjmUHq+i5m/D/4pjp4q8ju2
 0reF4mwWSbHjXGs/9tHYmbycR+j8yINWj+BqYXocJ0ebzSMGFt3IRHP9huAWilDs8Z4M
 5Hcw==
X-Gm-Message-State: AOJu0YwXbtTX6Hsdov/xyaPwNnBkGeXxDrcrdr23lvzc2WJFXqqRO0og
 WnYn36qkcImVfhMsAKYNvRcqy1CR7BAVfEfPvr+UbesllOIfBEQw5GQcYAQcTasY+s4=
X-Gm-Gg: ASbGncvq+1ixeAEvC/ZFTZnf6fo0gmeKbdBaGM022pEnsenHPiyZGa82G1K/h/lCKGf
 Ze1h5JDq39M4iHmWVfPvHQnQuFgC0GCt0xKi/AseyoKsMNTiY6FtqESZjm32gig1zAiMbnELxQk
 ic226Rh0sCKEzzXambZmYNbm9/QWuov/lFovxQDr0FJ6gRzHRfXQGA0P3NjsfGLIoIiFGp8Tx1B
 8krrMyEu3U498IMV06j9Es0z6dTXDeLxZLsSNC30TWHDDeYtrU3C2Qgz9IAE7fTI+2rLh5kreqW
 CYdyztrTAEGP6EcOLr1Wi7T2r2GMKgVTcmJlpbDqtJNEEriqX/O1oX6EY16YwvVIzfLxq0b7nY1
 +FSbeKGY7OW5Y0LprvQt7HN1CtKPkLtlE/d6UYZolTNdGzJVIeJnaexHGsKn+V+r4NFLnHsdcY9
 WEVrLZeNVLfXk=
X-Google-Smtp-Source: AGHT+IF1MuTxeUTRofUu2EFZ0GZ7TVjuk8ylfES31AqxGsU/N9j7H49TsIibTLSQdES1Q9X7aAraKw==
X-Received: by 2002:a17:906:730d:b0:b49:96e4:1845 with SMTP id
 a640c23a62f3a-b64739521a3mr1528374166b.41.1760956915130; 
 Mon, 20 Oct 2025 03:41:55 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b65eb036884sm748265466b.40.2025.10.20.03.41.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Oct 2025 03:41:53 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 28FFD602AD;
 Mon, 20 Oct 2025 11:41:50 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>
Subject: [PULL 06/11] hw/display: add blob map/unmap trace events
Date: Mon, 20 Oct 2025 11:41:44 +0100
Message-ID: <20251020104149.4034124-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251020104149.4034124-1-alex.bennee@linaro.org>
References: <20251020104149.4034124-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x634.google.com
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Message-ID: <20251016150357.876415-7-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

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


