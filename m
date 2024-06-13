Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 983EFC27C4F
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2024 05:50:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHdLI-0007vS-IM; Thu, 13 Jun 2024 01:49:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sHdLG-0007vK-Fx
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 01:49:46 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sHdLE-0000uS-Hm
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 01:49:46 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4217c7eb6b4so6893915e9.2
 for <qemu-devel@nongnu.org>; Wed, 12 Jun 2024 22:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718257781; x=1718862581; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=1Pke5SnVgSyp7kc2reUGj589dsJKNLncqYWR1n+SCgo=;
 b=RSSDhc3GjnokU/Qyz/PXSRMMX8TIXDgSzdVKs79XLMtod32Fdmkl8jTdx5SGE2fyxW
 rocLHRTENs56hHNzF7nfoQJfV7Ek9j8PJf/SbhdbuTJ9O/3zIr70F9u++CQJOj4owWbQ
 XH27cQ2KLoxhTmDhKVQDYNpV0qErScuEfakKFjslCksWyrlgHZwjOtZPaJTjfPQiL6rZ
 Znl7eg1aaNqFsG31IgI4LIwtHSWOAXCcQ86pHNILhpJE6/9gpbUARwxcA0W6XPntUWRt
 7sosq1s/DRHkUmBz3XyOxoeWO3mDsvXsaHdICJm9juPNEhJmYxCl+c6S7+E50cxHebxH
 HE0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718257781; x=1718862581;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1Pke5SnVgSyp7kc2reUGj589dsJKNLncqYWR1n+SCgo=;
 b=pZpN8M+zeoOZquR7/dK6+Ipu8XWDhhSOfsLOrVxfc8Ca785rZ72OnzW54Upwk/jx+K
 mTFGE3IgZTVqxskG6E+jFxgyWw+vkO24JqwPPmMWOY1XnloOAPQDsXTenjE1krgaW7aV
 SVjI8fTWcp7FP6RqIBqwoUXa6b5ePNVcTU0YqxWfwVg6ipjPvjPhRDjLgPB6NVL6JT/R
 ClSwbBoLYFWJD049dZ+/mdx1pONPu2BTZu+LZmN8SnSWWCc9UJOGMYlkBSd8yMSunf8e
 S/MdVYfUIJbLNS/XOKmCSa2M1TvsbtSbT+t4PzdnKWdPCHSwKmobga/Q608ta10q3vvG
 xhBA==
X-Gm-Message-State: AOJu0YzD7hqFxUdnFetHM9FCvHps0vN128s0SB+fhPWMf7NOD+DBBQGI
 GrpyBP9HA/PjgOS2s0dMF98GHb/mWC4ulAhKRHFlDJjpK+Urb2eETTxq4Nm6PyCkEHYGFPZ6Ypw
 ztVU=
X-Google-Smtp-Source: AGHT+IHkorExO8QBf+zR+i6G4MUmZk2OwPv2XU8J4n9+uF1nm5mt4yedbFzzyup29H6+8t01IHeGTg==
X-Received: by 2002:a05:600c:5487:b0:422:1a82:3ebf with SMTP id
 5b1f17b1804b1-422867bec26mr35385055e9.35.1718257780857; 
 Wed, 12 Jun 2024 22:49:40 -0700 (PDT)
Received: from localhost.localdomain (adsl-105.37.6.1.tellas.gr. [37.6.1.105])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-422874de68asm48632175e9.29.2024.06.12.22.49.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Jun 2024 22:49:40 -0700 (PDT)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Zheyu Ma <zheyuma97@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Eric Auger <eric.auger@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2] virtio-iommu: add error check before assert
Date: Thu, 13 Jun 2024 08:49:12 +0300
Message-ID: <20240613-fuzz-2359-fix-v2-manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

A fuzzer case discovered by Zheyu Ma causes an assert failure.

Add a check before the assert, and respond with an error before moving
on to the next queue element.

To reproduce the failure:

cat << EOF | \
qemu-system-x86_64 \
-display none -machine accel=qtest -m 512M -machine q35 -nodefaults \
-device virtio-iommu -qtest stdio
outl 0xcf8 0x80000804
outw 0xcfc 0x06
outl 0xcf8 0x80000820
outl 0xcfc 0xe0004000
write 0x10000e 0x1 0x01
write 0xe0004020 0x4 0x00001000
write 0xe0004028 0x4 0x00101000
write 0xe000401c 0x1 0x01
write 0x106000 0x1 0x05
write 0x100001 0x1 0x60
write 0x100002 0x1 0x10
write 0x100009 0x1 0x04
write 0x10000c 0x1 0x01
write 0x100018 0x1 0x04
write 0x10001c 0x1 0x02
write 0x101003 0x1 0x01
write 0xe0007001 0x1 0x00
EOF

Reported-by: Zheyu Ma <zheyuma97@gmail.com>
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2359
Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
Range-diff against v1:
1:  a665c6e73d ! 1:  8e50c1b00e virtio-iommu: add error check before assert
    @@ Commit message
     
      ## hw/virtio/virtio-iommu.c ##
     @@ hw/virtio/virtio-iommu.c: static void virtio_iommu_handle_command(VirtIODevice *vdev, VirtQueue *vq)
    +         iov = elem->out_sg;
    +         sz = iov_to_buf(iov, iov_cnt, 0, &head, sizeof(head));
    +         if (unlikely(sz != sizeof(head))) {
    ++            qemu_log_mask(LOG_GUEST_ERROR,
    ++                          "%s: read %zu bytes from command head"
    ++                          "but expected %zu\n", __func__, sz, sizeof(head));
    +             tail.status = VIRTIO_IOMMU_S_DEVERR;
    +             goto out;
    +         }
    +@@ hw/virtio/virtio-iommu.c: static void virtio_iommu_handle_command(VirtIODevice *vdev, VirtQueue *vq)
      out:
              sz = iov_from_buf(elem->in_sg, elem->in_num, 0,
                                buf ? buf : &tail, output_size);
     +        if (unlikely(sz != output_size)) {
    ++            qemu_log_mask(LOG_GUEST_ERROR,
    ++                          "%s: wrote %zu bytes to command response"
    ++                          "but response size is %zu\n",
    ++                          __func__, sz, output_size);
     +            tail.status = VIRTIO_IOMMU_S_DEVERR;
    -+            /* We checked that tail can fit earlier */
    ++            /*
    ++             * We checked that sizeof(tail) can fit to elem->in_sg at the
    ++             * beginning of the loop
    ++             */
     +            output_size = sizeof(tail);
     +            g_free(buf);
     +            buf = NULL;

 hw/virtio/virtio-iommu.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
index 1326c6ec41..9d801fb180 100644
--- a/hw/virtio/virtio-iommu.c
+++ b/hw/virtio/virtio-iommu.c
@@ -782,6 +782,9 @@ static void virtio_iommu_handle_command(VirtIODevice *vdev, VirtQueue *vq)
         iov = elem->out_sg;
         sz = iov_to_buf(iov, iov_cnt, 0, &head, sizeof(head));
         if (unlikely(sz != sizeof(head))) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "%s: read %zu bytes from command head"
+                          "but expected %zu\n", __func__, sz, sizeof(head));
             tail.status = VIRTIO_IOMMU_S_DEVERR;
             goto out;
         }
@@ -818,6 +821,25 @@ static void virtio_iommu_handle_command(VirtIODevice *vdev, VirtQueue *vq)
 out:
         sz = iov_from_buf(elem->in_sg, elem->in_num, 0,
                           buf ? buf : &tail, output_size);
+        if (unlikely(sz != output_size)) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "%s: wrote %zu bytes to command response"
+                          "but response size is %zu\n",
+                          __func__, sz, output_size);
+            tail.status = VIRTIO_IOMMU_S_DEVERR;
+            /*
+             * We checked that sizeof(tail) can fit to elem->in_sg at the
+             * beginning of the loop
+             */
+            output_size = sizeof(tail);
+            g_free(buf);
+            buf = NULL;
+            sz = iov_from_buf(elem->in_sg,
+                              elem->in_num,
+                              0,
+                              &tail,
+                              output_size);
+        }
         assert(sz == output_size);
 
         virtqueue_push(vq, elem, sz);

base-commit: f3e8cc47de2bc537d4991e883a85208e4e1c0f98
-- 
γαῖα πυρί μιχθήτω


