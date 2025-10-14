Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC1F2CCD184
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 11:15:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8cxa-00081K-9S; Tue, 14 Oct 2025 07:12:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v8cxS-0007vi-J6
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 07:12:47 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v8cxP-000826-6S
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 07:12:46 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-63963066fb0so10827320a12.3
 for <qemu-devel@nongnu.org>; Tue, 14 Oct 2025 04:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760440360; x=1761045160; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UBrmEioes5BcTvg3mWej6DkCUcELOhpLd7xx/WVVmZs=;
 b=FF0KFTGKVlQY1GQfOmtZzZmJsmH4tEeaEAA7UqMhvdvcPKau0bl1aGLFyeTP71vWQR
 GnF8i4t9CsQLqgy14P505kJ9UezliQ/1cokLqPrlpHt2DTJ8Tdtc8N5V6cCTgXUYl9vw
 dQ6Tc3ij9os/gMM088Q/pSbJ8jv8Ekrcp0+jenKE2Yv+q/vd+GWAGUusY6jHAjkqUgjd
 UzJiFKrRS6MxNku+P0qfzZkYvm7jZMev7+61nx/xkef4py+73MpozdAKKgLAybCgjfXa
 QNel2cCpv/tALMNRajOaEHJmaqXmu4Mld4CqHYDjyROcVafMQtm0mMgLNaBF8z0v8pX1
 DGNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760440360; x=1761045160;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UBrmEioes5BcTvg3mWej6DkCUcELOhpLd7xx/WVVmZs=;
 b=MvZ6oGfk2QR0VD4Qci/A3MaMPNQFrzYyDPGbHYYWaiznATURjzIlDCYRx9oD9KDeDe
 qoihSE+rDzNnDtH6ghg8Lw6NwirT/54/CKI/9aUuPvsaCVadOEzM2efO3NvB3iR+q9zv
 yY4omyqzBwySM9f9388laXERgV6aeX5+chVFmxDTsJc2b/n0/bHN1PXVsDwlihj9WgCO
 FhTUxOVgLRFz1x0R+yqp3tfkizeuFvqzqMU2zn4qolhlkIc3q+7Bcif7Mycz9QOZKOMs
 ufEEYYxl7EUpbPRAtEPcOriZKQ0kLfgitYzUC+poQgTy51HQuGOv2PW8EwKalv6KcSnR
 ns2w==
X-Gm-Message-State: AOJu0YwPsoScmfq6oa4jZfZtchlOI64HThF1p8978ohW2V/VfgaK6HrM
 7b8knuEBt/KeoQ1XnVoVc5VMgK8UwVGTU+vYJgOo1pPPcfaeg9Prvz9eZlGSM7JIAx4=
X-Gm-Gg: ASbGncsmb9L3XAclKkV+hooWShH+/vZmLUezyaStX1lhK2qVNPzGpVEGiJVR6Xccz+b
 KIvsroB/3Q0uIVipakSoEvzLesz5wgZNx9fse3h1T2sa19r6RlL++tyuKF+nD2B9QdjQikY3dUa
 UuLch2ey+EfjUOZXXfb/PK7aAxVpqn8FTru6mirxjUXB897VxfySFj1Ndz4O/AHVmDpCdb7hJvc
 6eOIf0l3AnTpvuv1VA+Dq59gx/n6/Y6f0/SzUWlWaVOfLQA72GyFIyZn/8HGFBnl1tcJOzbifgv
 /oP8XHTN+we+T8VGK5F9ZBageH18ZiKzI48ThcjJuErBpSS8WnPXxNvWYkn3jBdvIuaNtV3+f/j
 HRLftvMuXA4XHK2fQks7aYzCxGiLEFhg25G7NMF19VsBwnR+meD+I+fWl5jlsKjtdGVY=
X-Google-Smtp-Source: AGHT+IHkXi19VXhoMSJIweJrDy7ZFTE6XAIQpOzd35ITzE6n5SPGE6PG7mOB1EpyDCLz42VCCT5xhQ==
X-Received: by 2002:a17:907:9690:b0:b3f:d232:5797 with SMTP id
 a640c23a62f3a-b50aaa97b7amr2466771066b.22.1760440360102; 
 Tue, 14 Oct 2025 04:12:40 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b55d5cad7e1sm1133061466b.9.2025.10.14.04.12.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Oct 2025 04:12:38 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 6D72C5F871;
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
 Peter Xu <peterx@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 4/8] hw/display: add blob map/unmap trace events
Date: Tue, 14 Oct 2025 12:12:30 +0100
Message-ID: <20251014111234.3190346-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251014111234.3190346-1-alex.bennee@linaro.org>
References: <20251014111234.3190346-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52f.google.com
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


