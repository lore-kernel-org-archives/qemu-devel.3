Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B2C9D172A6
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Feb 2026 22:39:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmg6S-0000rF-E7; Sun, 01 Feb 2026 17:39:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vmg6Q-0000pU-Rr
 for qemu-devel@nongnu.org; Sun, 01 Feb 2026 17:39:34 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vmg6P-0001a9-Fp
 for qemu-devel@nongnu.org; Sun, 01 Feb 2026 17:39:34 -0500
Received: by mail-wm1-x341.google.com with SMTP id
 5b1f17b1804b1-4806bf39419so29051475e9.1
 for <qemu-devel@nongnu.org>; Sun, 01 Feb 2026 14:39:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769985571; x=1770590371; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=APsWugfr3D0j2QnkBk0zIOt7OhNfgoHHys78AHDV+Pg=;
 b=iK8wal7DaFllENJrXOuyJOh8EqJtIfbELk63kJzbApGiJZD71saNvasfMiKgEdLAVD
 3AUsTDxMZFFcBCxgKvfc84HPtvv00ISOw9g7z8paT+0P5fnftjD20UoIDR4soZUeF1Kx
 l7649fv5GOj1n5KWKVYVfNthXo6qjEwG/ub8MlAwkXuot6izMH79LiUm5+tbKFS2eoEJ
 TGrV9HphcJo3DxKQzQp98A6aZzvnPbelkURmqfetZyE4uNCn9fFWLuBXQabZG13l1c79
 kxZTFtgpmeihtwlY+chyj5Jiq2/gysI3iGaTDzHuUHr05Q1SH1RcL3LJjLQMbZhTCcIS
 lZow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769985571; x=1770590371;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=APsWugfr3D0j2QnkBk0zIOt7OhNfgoHHys78AHDV+Pg=;
 b=vjPWYqAPkt9Lj6qRie/oiQ1f4MhwANyNP7jCJfgpotrQDO07PYtUncau+YuPSFxqeS
 nCOAqoC6kRciX0nKofnKHatSCpvpc5NMwL7BGbBx2j8+QJRIsbdm5cMI2sf/PRVRxDRq
 PCqG/eCkHWDu4A5FANfI1sAYxHNer6EZtpO82n5AbPebyK9e65UKMPWgDjV2t5VfpR9M
 e9yH0VIc0zfVsbw/3EiqoaJUQaRdmISe0t+cSRH3uwN14VOJL4poDCn14pLkG24xQiK9
 n1//Tf0lB5Da6jq5dnGh8dXkDWHlP5/aS49t/s4oHHvkA5rmkoqajUcbLXee+cd2w7kx
 7ABw==
X-Gm-Message-State: AOJu0YxWSHPZIvKawhoSSg5awtSpyqRh2PL9syKXOFIfVnPx6f4V5oAL
 38l4C7aRMc6nmDvmKS1vUBCmeLNoXUroxDFmotni62sNDUPqhjfvFEhbD7yQIYXTT4744A9QBhi
 2q1vd2j01qQ==
X-Gm-Gg: AZuq6aIgWsDQgfSSMJN+7NhPoEPU8s5JTW6H1oEBMYyIWlJ/mqR2nspuSoQiLB59z1Z
 z3ftKz0GTHG97mbfxmXQcUtG8wwkitMZK3aVmNlHfSm/WrnCu8cV6e6ghGmV69uUFTSATFGB3b3
 g77PY5VmilXcCEPG6efZQidcMPHahrsu7mFWvBl7bYO9bvZi3KJ6Dk8OUf+6oNCMi3cNPZgPPjd
 SjfuIGbo0cc1M8BJlMUYe/UWObEFRGLzs+zrgZ9UoxnaE64iO2Wc8wgIcAwslNp8hLgUrrtoiaA
 xmlR1EQvPL3IOnlXNK1r7qClR8a+vIaAmaG7EAFyKEOic4bfc8333aATH79b9zf9dHjPhbLTbYC
 z7qzO98VYLgSsbgyHEw0ln4ZFLLLMyP+JAXEuz+REJotJjiZZoF1ndKbxh7SsBA0yfKUSU1roUo
 LCyEf4i56mY6bbYdqGbSOePndCgOnK6t6BQw7Y74WCHqGnKXX1/5eaREuEa7ht
X-Received: by 2002:a05:600c:470b:b0:477:9890:9ab8 with SMTP id
 5b1f17b1804b1-482db2591f5mr130094395e9.3.1769985571123; 
 Sun, 01 Feb 2026 14:39:31 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-482db623407sm96821295e9.0.2026.02.01.14.39.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 01 Feb 2026 14:39:30 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] hw/virtio: Pass VirtIODevice pointer to virtio_reset()
Date: Sun,  1 Feb 2026 23:39:29 +0100
Message-ID: <20260201223929.78790-1-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x341.google.com
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

virtio_reset() expects a VirtIODevice pointer, which
is what the single caller - virtio_bus_reset - pass.
Promote the opaque argument to a plain VirtIODevice.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/virtio/virtio.h | 2 +-
 hw/virtio/virtio.c         | 3 +--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index 27cd98d2fe1..fcaa9b03b4a 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -370,7 +370,7 @@ void virtio_queue_set_vector(VirtIODevice *vdev, int n, uint16_t vector);
 int virtio_queue_set_host_notifier_mr(VirtIODevice *vdev, int n,
                                       MemoryRegion *mr, bool assign);
 int virtio_set_status(VirtIODevice *vdev, uint8_t val);
-void virtio_reset(void *opaque);
+void virtio_reset(VirtIODevice *vdev);
 void virtio_queue_reset(VirtIODevice *vdev, uint32_t queue_index);
 void virtio_queue_enable(VirtIODevice *vdev, uint32_t queue_index);
 void virtio_update_irq(VirtIODevice *vdev);
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 3dc9423eae9..86fc0e262f7 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -3233,9 +3233,8 @@ int virtio_set_features_ex(VirtIODevice *vdev, const uint64_t *features)
     return ret;
 }
 
-void virtio_reset(void *opaque)
+void virtio_reset(VirtIODevice *vdev)
 {
-    VirtIODevice *vdev = opaque;
     VirtioDeviceClass *k = VIRTIO_DEVICE_GET_CLASS(vdev);
     uint64_t features[VIRTIO_FEATURES_NU64S];
     int i;
-- 
2.52.0


