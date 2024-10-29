Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76D5BD2AB2F
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2024 12:11:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5l3X-0004Zs-9t; Tue, 29 Oct 2024 08:10:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t5l3V-0004ZE-A8
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 08:10:37 -0400
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t5l3T-0007S3-GB
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 08:10:36 -0400
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-539f7606199so5777677e87.0
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2024 05:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730203833; x=1730808633; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yA1TnKmdYIVh4QgM+44m/kYyl/YIszs+Fc2n46GOLvM=;
 b=JFdMRnP4EOj7RewedcCvJSGsmxqwqa669Nbbs9pBeCeqhB+OrfEk0YVJj+gsmgIj6C
 4CaSSY6r6RBtY5Td3PvTUplr6d/Sx/xRPB80ODOHKm1+aTPNE6A1fGK3xIhA0WYBwMEC
 hwk6ynAXf0YkvdagSCC55WU8MorKmWY48b0E9dYqs+gxFj+8GUN07Org9hmBnts+H+eP
 WS3JgKqj6G6WrKY2da1Dxef6as2aTetGInKoxh3N3FtAv0lmiG7kojza+qM4zOndrdDo
 v85vv1x+lGN0i2GZxhyFK9n3TQkjVSWdgtonFyyXLhDgPoj5mdSno8+Ka7EUJur3QgI7
 wReQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730203833; x=1730808633;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yA1TnKmdYIVh4QgM+44m/kYyl/YIszs+Fc2n46GOLvM=;
 b=rNoL0IpSI6Y6fgs4SuUAfPGkmdjw+uVR+UUkRWGlkohlwvvoINcRVtsxA+nbRLJBNU
 eGqKSzMnwz0VEZMg3C6GgoigF1b8Al1vvUksA3YchJKZmKiI20svL1Vhiuf8MURhRtzY
 eB5vy0dtOuqfJzG7yuP1tfbeE9oitO8J1qg3EX718rHqARd/ARR6vwsd90e0c+RUfm+f
 2YJ2NAItrCPJhoniYJzG0mkJI5ayAFTqs5hC4hhTbSK5upsTFIAqkGO+V36SAItSsEMp
 k9s99L+4fz3Tg0Jrh0tZpjxo22aAXLQ6bv6TjYwh/JcZwLsRFTXKm/G9rL0v3y24751k
 gRKg==
X-Gm-Message-State: AOJu0Yxky2diYqc/HXbls8NbfZMowVwUKB7WJLTuEk2tGRG6ZOmBsQkK
 DmrFrQ4IvpphHeCRv3M4x5GLKq/OVQOjkTEHzpOXEQbct9gwhZka8cpMlGv/bCE=
X-Google-Smtp-Source: AGHT+IHKWmMBCflfS6OWMR5fxPo+gpUEkW5EOgVP3PAaiLEOCZPZhRos29mPm/JbT7RUOVP8Sp9lhA==
X-Received: by 2002:a05:6512:3404:b0:53b:27ba:2d11 with SMTP id
 2adb3069b0e04-53b348cb2cbmr6486997e87.16.1730203832896; 
 Tue, 29 Oct 2024 05:10:32 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43193572932sm145210695e9.1.2024.10.29.05.10.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Oct 2024 05:10:31 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 910F95F929;
 Tue, 29 Oct 2024 12:10:30 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PULL 01/13] virtio-gpu: Use trace events for tracking number of
 in-flight fences
Date: Tue, 29 Oct 2024 12:10:18 +0000
Message-Id: <20241029121030.4007014-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241029121030.4007014-1-alex.bennee@linaro.org>
References: <20241029121030.4007014-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x134.google.com
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

From: Dmitry Osipenko <dmitry.osipenko@collabora.com>

Replace printf's used for tracking of in-flight fence inc/dec events
with tracing, for consistency with the rest of virtio-gpu code that
uses tracing.

Suggested-by: Marc-André Lureau <marcandre.lureau@gmail.com>
Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Message-Id: <20241024210311.118220-2-dmitry.osipenko@collabora.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
index 9f34d0e661..14091b191e 100644
--- a/hw/display/virtio-gpu-virgl.c
+++ b/hw/display/virtio-gpu-virgl.c
@@ -525,7 +525,7 @@ static void virgl_write_fence(void *opaque, uint32_t fence)
         g_free(cmd);
         g->inflight--;
         if (virtio_gpu_stats_enabled(g->parent_obj.conf)) {
-            fprintf(stderr, "inflight: %3d (-)\r", g->inflight);
+            trace_virtio_gpu_dec_inflight_fences(g->inflight);
         }
     }
 }
diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 49fd803393..3fcc434732 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -1046,7 +1046,7 @@ void virtio_gpu_process_cmdq(VirtIOGPU *g)
                 if (g->stats.max_inflight < g->inflight) {
                     g->stats.max_inflight = g->inflight;
                 }
-                fprintf(stderr, "inflight: %3d (+)\r", g->inflight);
+                trace_virtio_gpu_inc_inflight_fences(g->inflight);
             }
         } else {
             g_free(cmd);
@@ -1066,7 +1066,7 @@ static void virtio_gpu_process_fenceq(VirtIOGPU *g)
         g_free(cmd);
         g->inflight--;
         if (virtio_gpu_stats_enabled(g->parent_obj.conf)) {
-            fprintf(stderr, "inflight: %3d (-)\r", g->inflight);
+            trace_virtio_gpu_dec_inflight_fences(g->inflight);
         }
     }
 }
diff --git a/hw/display/trace-events b/hw/display/trace-events
index 781f8a3320..e212710284 100644
--- a/hw/display/trace-events
+++ b/hw/display/trace-events
@@ -53,6 +53,8 @@ virtio_gpu_cmd_ctx_submit(uint32_t ctx, uint32_t size) "ctx 0x%x, size %d"
 virtio_gpu_update_cursor(uint32_t scanout, uint32_t x, uint32_t y, const char *type, uint32_t res) "scanout %d, x %d, y %d, %s, res 0x%x"
 virtio_gpu_fence_ctrl(uint64_t fence, uint32_t type) "fence 0x%" PRIx64 ", type 0x%x"
 virtio_gpu_fence_resp(uint64_t fence) "fence 0x%" PRIx64
+virtio_gpu_inc_inflight_fences(uint32_t inflight) "in-flight+ %u"
+virtio_gpu_dec_inflight_fences(uint32_t inflight) "in-flight- %u"
 
 # qxl.c
 disable qxl_io_write_vga(int qid, const char *mode, uint32_t addr, uint32_t val) "%d %s addr=%u val=%u"
-- 
2.39.5


