Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0D38E6529E
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Feb 2026 23:30:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmgt4-0003Wj-O4; Sun, 01 Feb 2026 18:29:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vmgt3-0003Ut-Gj
 for qemu-devel@nongnu.org; Sun, 01 Feb 2026 18:29:49 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vmgt2-0002eZ-3j
 for qemu-devel@nongnu.org; Sun, 01 Feb 2026 18:29:49 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4806f3fc50bso39254435e9.0
 for <qemu-devel@nongnu.org>; Sun, 01 Feb 2026 15:29:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769988586; x=1770593386; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EAuDEWjgtcjAI73PpDk9D1EoNYCz8v3TBHOpftqU/Uk=;
 b=So9C8JDY1XKP4r9FKGLfUxr7JHFLluv2VfTiUm9XieOrx3APkGDBScdcR+9GrtjjD6
 pP6pzG7sLIGay+GCcnEm62iydzVSvxTwbR7Hf7E4aOGJFgkwSAb/10NNh9e9JyVUIhmf
 6cNNIc4JZdf1gl13ssH+fmHDpMxD6P2uMRaB8gu+TwYMkUPl26THSRlNwM4LbjSxK5+D
 +a/LF+RCkDu0M3oYCD2PzQmIRlAuHA5jcB2i3pDDhkdOOXIQRIiPJ0hfyFPlqr9+wYmk
 HcPYsgEWjX2q+LmF39ATltPAto3OCj0B9NSDbabvHqP0gCEb/X16NteVEs/CGu4drUWV
 7hXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769988586; x=1770593386;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EAuDEWjgtcjAI73PpDk9D1EoNYCz8v3TBHOpftqU/Uk=;
 b=L0vHXOAA+LvQmDg6dDNw8DRJWcfvUQIaXEQXRrLBEIazKi4kgrZrlzVQjCcpX/wXMg
 wi/sREK47oPCKu9PO3IOiBgqBNzNaNu2SW5f4CYZgZy0LlmLHnsud5UUM7nPiNAhBjjJ
 BCh2oJwHJERJOIVedlynxt+lbKTO8t30ZVeWWhB22Uc4d/qwaFyajzP/x7som9sR3Aa/
 V//guJJHfAYd9fxkcL7iCTqttZ1ZeveHhgvT5hBsxFURV7jXij9gtmXroF5Z6+rm0htw
 AgCgRSLLS0X5vAxoGsnmDatH86hKVc6mWspS2eTFFESst03hiZT2Eu+Fl8oBckPm00cM
 +7rw==
X-Gm-Message-State: AOJu0Yxl1XFrCQVhs65+57OCUZ5Pxp1m2AXiI54b0qre0qxAxRfdHUS7
 7rq0JGf3P66RW9Z04gUN+/98i1AM/Fx91etihOFO61T5/Usj8gAjtjqzLNSGj41eZMujQOmx6b6
 c02ItlO8=
X-Gm-Gg: AZuq6aKtwG6ni0bTeUxbUAK+KK73LO6B4TkoirSoe48wu3ibNFP53yTpAEr6dZMNeKY
 TuX/CURe/wETJQQfDX8hu1BHkUupGxTMpLRWagCa/jmcPer9h/qXzXXg/lH0oZ/p3jnxhyUsbnE
 K96naRooMfCkziBH/H5I/tKk1U9bveAvWxPtRiVVhDvbAwNm5eCDw8qoN5gzlDkC7apiygbMBPy
 ggCDqTASbR2nfTM+2siMx9lJYFslspqYfRYyboFkwIYgXhiJ64VcdGZkldQqHnqNYRWiHZh8ogg
 foztAKvroXGxKTbPxioSSGu/AQO2rWSgT1cbx/9R+Dk15t3ggJ/0rV25TXFgbhfDtdi9xlL1X7c
 Ld8eMihaUdIJ1xt4iKUFs+MLc4cCa36EPi3clfxiJiBoUR+ixBeZo0Sx+/rudKj6v1Z6lR82Mzl
 NUg0CFYEPlHIXkljYRz4sJ2oAWxN/JrhkHq3A2YIPrjJyb3JIXcjm7qRLaUlnt
X-Received: by 2002:a05:600c:64c6:b0:477:5ad9:6df1 with SMTP id
 5b1f17b1804b1-482db4593a1mr130157765e9.3.1769988586350; 
 Sun, 01 Feb 2026 15:29:46 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-482e047d863sm80727295e9.1.2026.02.01.15.29.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 01 Feb 2026 15:29:45 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Subject: [PATCH v3 03/11] hw/virtio: Introduce
 VirtIODevice::access_is_big_endian boolean field
Date: Mon,  2 Feb 2026 00:29:15 +0100
Message-ID: <20260201232924.93399-4-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260201232924.93399-1-philmd@linaro.org>
References: <20260201232924.93399-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

VirtIODevice::access_is_big_endian boolean field, initialized on
device reset, represents whether load/store accesses are ordered
using big endianness.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/virtio/virtio.h | 5 +++++
 hw/virtio/virtio.c         | 1 +
 2 files changed, 6 insertions(+)

diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index 17b105c146d..7a4f7de7475 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -154,6 +154,11 @@ struct VirtIODevice
     VMChangeStateEntry *vmstate;
     char *bus_name;
     uint8_t device_endian;
+    /**
+     * @access_is_big_endian: whether load/store memory accesses are ordered
+     * using big endianness. Might change during device resets.
+     */
+    bool access_is_big_endian;
     /**
      * @user_guest_notifier_mask: gate usage of ->guest_notifier_mask() callback.
      * This is used to suppress the masking of guest updates for
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 86fc0e262f7..242c207a591 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -3247,6 +3247,7 @@ void virtio_reset(VirtIODevice *vdev)
         /* System reset */
         vdev->device_endian = virtio_default_endian();
     }
+    vdev->access_is_big_endian = virtio_access_is_big_endian(vdev);
 
     if (k->get_vhost) {
         struct vhost_dev *hdev = k->get_vhost(vdev);
-- 
2.52.0


