Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1477EE6B69
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 22:20:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voUAc-00063C-G8; Fri, 06 Feb 2026 17:19:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1voUAb-00062C-Ao
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 17:19:21 -0500
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1voUAZ-00079A-IG
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 17:19:21 -0500
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-c6c444e89bcso933519a12.2
 for <qemu-devel@nongnu.org>; Fri, 06 Feb 2026 14:19:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770416357; x=1771021157; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BDVf0HcSlG+DZgs/i7+uJFbsNebFbALD/dqSu3oQmMY=;
 b=Trosb6454QyhFg1H2TJuX6LgGDSX76J60tXs5ti45lqSbIuXqLFzhq5hrTnTlSC34m
 1RA3J+uA1lyjypwu1ts83Flpcf+jxFk1H1DylLKAZ86GJ7/xGX/IKpGliPk4aoMlcVkz
 lOzP5lifOgG3j6gX+U6cSx2sYBlQ8ANJzWIzX3mslNpGaw1KUzxXN2bcLKaqvHVDVgTm
 L1EFkdFCM6UogFsI5MqcXiIxKJIK7dChIebd7Jb0fXKE5dzTlyQNZnnfxaZ2oBqrTOPA
 SRxq6VKOfLYzQjhvGnvTLLHUcF8FPzkK/rAVzkmc8wSRM6Yw/bvCG6GvY9UT0ZHjFG7e
 7Uzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770416358; x=1771021158;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BDVf0HcSlG+DZgs/i7+uJFbsNebFbALD/dqSu3oQmMY=;
 b=bpFifCF28HjOMc/of3w72LEMl0g7ipG1mUx5hq8Km2cORTldya4N8vW0usLEOEfrUr
 2djIhgZ4UIRR0kOlFkggZ1TMEN5wo1PlYxuWJXQZ0IwVAjcv2LTsjd6yShGFMYEXE8nf
 r5aZ9XMClpdJvjR9Ahd+Im9bsk+DVoOXVMWR4qhRw7F/FoUopq3O3ZovOpPPULNqqQ1A
 qZX5PwA35BfjE8Fr4pv3r4Fvj3o4S6OYZ866mVCgp36TyXCOglUI/JAcjjfvU6Gc1Lpq
 u+sM64i63O2n6X580W1kNo0iv5haCu+Ez2WKwShu0PTY1g41h73TW+mwzZdxjCQ3QdaR
 uUcw==
X-Gm-Message-State: AOJu0YyrLhoeSijPbZA9M2QniqxopJIbvmbr4TPfe+6HddCRnQJoktXb
 qH6W5PmQypIOOJkZxPw7RUS5iiW4duT426M8bPHfVQnMzZRt6BYQLj7ysGCLyAMsqNkIltudVJG
 inzPo
X-Gm-Gg: AZuq6aJNZ9JRAf7aEa7fqtwfdvYksR9n97sCEl+v83lOSVpU3dA9+qn/ax7Rr/M2+D8
 IQ5g1vj8QrWK6POoO7v5ypDFwNd+84bk9ZIJBEeD1KXBXmvK2/mUeVDeEHUDd0Rwg3/ZG/jyqU8
 t8DYzXnrRLeqrKPbxcbzgtMHQNFVOXK7VQWW7OY7f3quqJYX0Ss5r5p0Jp5VeeBQndgDdRlkV/8
 ekIBpiwjAlzaCKQEwQnEy8/eNfzle/02ncFXL4PFbB0dqpfSJwFZNSFDByQOFaA9O3m4dvquIqY
 8RQLNzoaUs8OuPAiVhzyyDzkbTT0kVnMwKQV9rSPp/U4nHcUVkwKEO3MCAoGjIr+sKgTp5xbhOR
 6981+aNt1kmkB36p2XZa8hcz3EiPgD/qT6g0/NzwTRnPn6TQz7W8qi6m5/3ygWG7WWo9YZ/Iefr
 olzyW8LbU7ZcG/LE/OvTlxRveybBThEpzRsLyaX/lC88XIbMzEUOLeAe6QlESKU72iNSaYCiDh5
 w+b
X-Received: by 2002:a17:903:298b:b0:2a9:484c:ff21 with SMTP id
 d9443c01a7336-2a951666249mr45795875ad.25.1770416357498; 
 Fri, 06 Feb 2026 14:19:17 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a95bff42f7sm13316575ad.68.2026.02.06.14.19.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Feb 2026 14:19:17 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, stefanha@redhat.com,
 richard.henderson@linaro.org, qemu-ppc@nongnu.org
Subject: [PATCH v5 2/9] hw/virtio: Introduce
 VirtIODevice::access_is_big_endian boolean field
Date: Fri,  6 Feb 2026 14:19:01 -0800
Message-ID: <20260206221908.1451528-3-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260206221908.1451528-1-pierrick.bouvier@linaro.org>
References: <20260206221908.1451528-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x52a.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

VirtIODevice::access_is_big_endian boolean field, initialized on device
realize, and updated when setting device features. This happens on reset
or when configuring device after initial realize. It represents
whether load/store accesses are ordered using big endianness.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/hw/virtio/virtio.h | 5 +++++
 hw/virtio/virtio.c         | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index 65872f2c54c..0f792e24f23 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -154,6 +154,11 @@ struct VirtIODevice
     VMChangeStateEntry *vmstate;
     char *bus_name;
     uint8_t device_endian;
+    /**
+     * @access_is_big_endian: whether load/store memory accesses are ordered
+     * using big endianness.
+     */
+    bool access_is_big_endian;
     /**
      * @user_guest_notifier_mask: gate usage of ->guest_notifier_mask() callback.
      * This is used to suppress the masking of guest updates for
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 77ca54e5206..a429ff7de39 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -3154,6 +3154,10 @@ static int virtio_set_features_nocheck(VirtIODevice *vdev, const uint64_t *val)
     }
 
     virtio_features_copy(vdev->guest_features_ex, tmp);
+    if (!bad) {
+        /* set_features might enable VIRTIO_F_VERSION_1 */
+        vdev->access_is_big_endian = virtio_access_is_big_endian(vdev);
+    }
     return bad ? -1 : 0;
 }
 
@@ -4075,6 +4079,7 @@ static void virtio_device_realize(DeviceState *dev, Error **errp)
     vdev->listener.commit = virtio_memory_listener_commit;
     vdev->listener.name = "virtio";
     memory_listener_register(&vdev->listener, vdev->dma_as);
+    vdev->access_is_big_endian = virtio_access_is_big_endian(vdev);
 }
 
 static void virtio_device_unrealize(DeviceState *dev)
-- 
2.47.3


