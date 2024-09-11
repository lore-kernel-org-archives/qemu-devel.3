Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E05CCEE499E
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 12:25:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soMIA-0001Lv-Qq; Wed, 11 Sep 2024 08:17:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1soMHP-0007oY-HU
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 08:17:11 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1soMHN-0007X3-1m
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 08:17:03 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-42cae4eb026so43486385e9.0
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 05:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726057018; x=1726661818; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JU4QuyjYj1/UxZRyLrg4rkCW/UKrByK+1gpsauwYgCE=;
 b=IGt0azURt3pYtAwIPgw7+nCKG8krTzixhLMHZkkskIVOu0VatyS3/JJd+EbyXisGvU
 IBRCrPrJ1YyvkPfYE5KSgOvIAYzQ5gYwR1mte/sGOWKd6S10GUG6LkM5wYGPcrjJ++jT
 tTOk0+jC/2nRA2/k2TrfmD2IK6OUb/ReaNOor6Ygmh9GS4v9pA7rY2Q3Q3KWz/ioVFUA
 4JuysRum5LlS8n7U0atzn3/yFru0qWAzk7aUSBuSWQj5LZ3TEhIQ1o/8UDc2Jp0Wo3/C
 4WgS81r3+32+cOg/oIYskoPLhjh/Tx+AZQG5i56LX5CPAKFQf8J9p4i3gYMSTA6Nh24n
 eVwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726057018; x=1726661818;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JU4QuyjYj1/UxZRyLrg4rkCW/UKrByK+1gpsauwYgCE=;
 b=w246O6OBslVwrsnJYAqB08/SZsezzWpESAIMnkUJz6CNtFeNojt8BSLTikOw1IuLDq
 qYdMQuOk6QE+FrW1N/qzhe5mX4ydmW3jVRI2Q3gSrQ3IgJZ4XgDS8kgw27SG2+chtcUV
 MR1KtGaB6P26udj3MlBUmc3Y1rdfUWLVfkKHXxgkX7u847/bLxUM6mKR11SuFCVAkWoy
 guKqS/oj46lFfB+O1le0lLjsKKT2i5z3yQEI9tiAxbQLfCv1hUTrfv42hmcqk95QJ95Q
 3P471sJTNTauX812hW/igB6GMDQcJAcmxu2hjk3xr/yRo5sdgd8/letdu/iQX526teLA
 BCWA==
X-Gm-Message-State: AOJu0YzU/CUbOMnsUIZJW/V4a7t1p+VDnzni/OsEjhIPk2CD8vFbtQpe
 p4Y40RLRgmX7UwGa3hm8Y6ZEu/FswQho0HdUPvUnZjrwyaaFfMVG2EIeMr4tysmppp7jcpB4NNZ
 f
X-Google-Smtp-Source: AGHT+IHRYajQB+3qtagMnvYhEPPdMxkgokITfO4p9w1vzIWmBRmHDclNy0NsGbC1r/OFW/DhelZbTQ==
X-Received: by 2002:a05:600c:4ec9:b0:42c:af06:703 with SMTP id
 5b1f17b1804b1-42caf060a7cmr110888005e9.31.1726057018470; 
 Wed, 11 Sep 2024 05:16:58 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.196.107])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42caeb815e8sm142084885e9.31.2024.09.11.05.16.57
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 11 Sep 2024 05:16:58 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 22/56] hw/audio/virtio-sound: fix heap buffer overflow
Date: Wed, 11 Sep 2024 14:13:47 +0200
Message-ID: <20240911121422.52585-23-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240911121422.52585-1-philmd@linaro.org>
References: <20240911121422.52585-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

From: Volker Rümelin <vr_qemu@t-online.de>

Currently, the guest may write to the device configuration space,
whereas the virtio sound device specification in chapter 5.14.4
clearly states that the fields in the device configuration space
are driver-read-only.

Remove the set_config function from the virtio_snd class.

This also prevents a heap buffer overflow. See QEMU issue #2296.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2296
Signed-off-by: Volker Rümelin <vr_qemu@t-online.de>
Acked-by: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20240901130112.8242-1-vr_qemu@t-online.de>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/audio/virtio-snd.c | 24 ------------------------
 hw/audio/trace-events |  1 -
 2 files changed, 25 deletions(-)

diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
index d1cf5eb445..69838181dd 100644
--- a/hw/audio/virtio-snd.c
+++ b/hw/audio/virtio-snd.c
@@ -107,29 +107,6 @@ virtio_snd_get_config(VirtIODevice *vdev, uint8_t *config)
 
 }
 
-static void
-virtio_snd_set_config(VirtIODevice *vdev, const uint8_t *config)
-{
-    VirtIOSound *s = VIRTIO_SND(vdev);
-    const virtio_snd_config *sndconfig =
-        (const virtio_snd_config *)config;
-
-
-   trace_virtio_snd_set_config(vdev,
-                               s->snd_conf.jacks,
-                               sndconfig->jacks,
-                               s->snd_conf.streams,
-                               sndconfig->streams,
-                               s->snd_conf.chmaps,
-                               sndconfig->chmaps);
-
-    memcpy(&s->snd_conf, sndconfig, sizeof(virtio_snd_config));
-    le32_to_cpus(&s->snd_conf.jacks);
-    le32_to_cpus(&s->snd_conf.streams);
-    le32_to_cpus(&s->snd_conf.chmaps);
-
-}
-
 static void
 virtio_snd_pcm_buffer_free(VirtIOSoundPCMBuffer *buffer)
 {
@@ -1400,7 +1377,6 @@ static void virtio_snd_class_init(ObjectClass *klass, void *data)
     vdc->realize = virtio_snd_realize;
     vdc->unrealize = virtio_snd_unrealize;
     vdc->get_config = virtio_snd_get_config;
-    vdc->set_config = virtio_snd_set_config;
     vdc->get_features = get_features;
     vdc->reset = virtio_snd_reset;
     vdc->legacy_features = 0;
diff --git a/hw/audio/trace-events b/hw/audio/trace-events
index b1870ff224..b8ef572767 100644
--- a/hw/audio/trace-events
+++ b/hw/audio/trace-events
@@ -41,7 +41,6 @@ asc_update_irq(int irq, int a, int b) "set IRQ to %d (A: 0x%x B: 0x%x)"
 
 #virtio-snd.c
 virtio_snd_get_config(void *vdev, uint32_t jacks, uint32_t streams, uint32_t chmaps) "snd %p: get_config jacks=%"PRIu32" streams=%"PRIu32" chmaps=%"PRIu32""
-virtio_snd_set_config(void *vdev, uint32_t jacks, uint32_t new_jacks, uint32_t streams, uint32_t new_streams, uint32_t chmaps, uint32_t new_chmaps) "snd %p: set_config jacks from %"PRIu32"->%"PRIu32", streams from %"PRIu32"->%"PRIu32", chmaps from %"PRIu32"->%"PRIu32
 virtio_snd_get_features(void *vdev, uint64_t features) "snd %p: get_features 0x%"PRIx64
 virtio_snd_vm_state_running(void) "vm state running"
 virtio_snd_vm_state_stopped(void) "vm state stopped"
-- 
2.45.2


