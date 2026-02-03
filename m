Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72880E8B366
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 20:57:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnNSD-0006bY-CM; Tue, 03 Feb 2026 15:56:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vnNSB-0006ae-5a
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 15:56:55 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vnNS9-0003Tg-6s
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 15:56:54 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2a09d981507so1489135ad.1
 for <qemu-devel@nongnu.org>; Tue, 03 Feb 2026 12:56:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770152212; x=1770757012; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JeipM9QRVydOFQNgbc5lZdQYc3E8fV/sokpGLUmNtbc=;
 b=K80a06mcX5feyY5wm/hvXRiJFPdI3/VuwHgFHOZUdfi6QLzTMLkfG6TaSnbpkrjGx6
 HY1Aln3tgRrHlSQC/gG9fFPodYtcyAlCMUS8LGU30bZhaH0R3oLP9pJ6SNbmpztdbIY0
 riluo8gxPFScJDn+CeskDVsMBXxSv5T4+D1ADQ1r2hJFD2MbOt+Cj4Sc2/7AT8DoZ2tj
 1sQP3frxnL5Ei97cN/UdeDztuTrT2fjHA7kEYrF+El4awukVCbvhJF1XmEyKaSMfIa4B
 gvKXwom4vC0lXoc49hg+eAARKlE8V8s9N3/YpSreC1OpI4/baDZWoAPn6W/lLbQPJUwa
 XzkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770152212; x=1770757012;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JeipM9QRVydOFQNgbc5lZdQYc3E8fV/sokpGLUmNtbc=;
 b=gZwakr9Lr5XwjAwwGWB3E3Wwg6Zav2kvjTqQToinqsMCM7LxeZgQlKGq/TJGCWO8WT
 /LZKWAx5F/qVDbqjQG5LW37shYu5z+35XlYztlwaaykrI0qyY4EokyOlrWrXY3OSZ0vG
 R6DeFYIUEwuRXvDqif+p0GrXwzGtqDC9FGOi0irdDGS2mE7AT8XbAl2UJ0Ox7YGdAFCP
 q+7GmNc/zzO03UQayfHVmRyAojfm/unDUSkIsKGuN4A8v1mBqGiGIfQrDRnnAFSxCkz/
 wzHM+BZKM/O3qIV8sfW3l68lYOMMIZoSrf+xY7JX/55RbdLOGepE0qVQHXUfVIDSzKe3
 efiA==
X-Gm-Message-State: AOJu0Yw0wmJ+akqNVRAOtZLdl+9qdIOdafiftEvkOIur4rIqEjYKGvZU
 ybDuZM+LdzY94K4RMlBPiWilwKcXfM9/kop9QtJ9v2hKC1f166Mkf/f8ZBEgMATKpDsmYrWQEXb
 1t/fw92c=
X-Gm-Gg: AZuq6aJ7+Abq8TULe8ShEoxONjWDQ+bpla91lKdHrkYaiCzn5DZ0WK7xvNEKrNcXkFd
 oTrsBZ8moyIf15K1NlYtAyQsYFl+XsYKSfauvSbWuqm3H89607sFSyVg7a12rIG99ROuqDsBCOG
 NTDaSy9xs1cIzlt9624ejf1ko9KdHAjUK7O6tmJxDQumr19/0IL4Fl0zfVTrqqNQjUksoBE6SAk
 q4AGYEUfWQV37akgu/4BPUQQH7a5op/wqaKr5j1HNjpo5HOVmfL1tVs8LudsxNqN3blH05Yzbyi
 J7axQVazAwBaRF1bL/3MgEXdN/eWVCWttNOanXC255LqbSs/o913w66qs122/JY/M/BOiBNnnv5
 4wiP7aXLlojewue0XudE3//k8BsEB7jEKjrTfTnyRzSTon9mFKszZ1F+nY8vH+L+V5aJBl2O5HT
 0tbKZ2QNnUp1Pyxh4Gq5922dGRoVe1095KbqGgh73C71YHWsXABJnvC+8G+3gAH59Q
X-Received: by 2002:a17:902:ef01:b0:2a7:c188:bd1b with SMTP id
 d9443c01a7336-2a9339a66demr6075265ad.25.1770152211814; 
 Tue, 03 Feb 2026 12:56:51 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a9338512f4sm3612875ad.9.2026.02.03.12.56.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Feb 2026 12:56:51 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-ppc@nongnu.org, Stefano Garzarella <sgarzare@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: [PATCH v4 2/9] hw/virtio: Introduce
 VirtIODevice::access_is_big_endian boolean field
Date: Tue,  3 Feb 2026 12:56:30 -0800
Message-ID: <20260203205637.3109749-3-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260203205637.3109749-1-pierrick.bouvier@linaro.org>
References: <20260203205637.3109749-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x631.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

VirtIODevice::access_is_big_endian boolean field, initialized on
device reset, represents whether load/store accesses are ordered
using big endianness.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/hw/virtio/virtio.h | 5 +++++
 hw/virtio/virtio.c         | 1 +
 2 files changed, 6 insertions(+)

diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index 65872f2c54c..6c05f1febcc 100644
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
index 3dc9423eae9..df2887e7296 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -3248,6 +3248,7 @@ void virtio_reset(void *opaque)
         /* System reset */
         vdev->device_endian = virtio_default_endian();
     }
+    vdev->access_is_big_endian = virtio_access_is_big_endian(vdev);
 
     if (k->get_vhost) {
         struct vhost_dev *hdev = k->get_vhost(vdev);
-- 
2.47.3


