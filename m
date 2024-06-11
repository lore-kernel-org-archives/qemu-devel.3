Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C22CC25B76
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2024 12:24:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sH0Xu-0002Ln-MH; Tue, 11 Jun 2024 08:24:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sH0Xs-0002L9-6q
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 08:24:12 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sH0Xp-0007NM-Tf
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 08:24:11 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-35f2c0b7701so490385f8f.0
 for <qemu-devel@nongnu.org>; Tue, 11 Jun 2024 05:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718108646; x=1718713446; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=r2IUh6JjwaeLgT7iyknV/seoPi4AaRCJv8Z19ePuBmk=;
 b=uwrm0lYDmvODbeWeLZrUK0DM9sPwjCD1gr2g3ApHl5+DJ/+RFwZmUj6wEsqx3tAnND
 3Wr5mJsSW1GJ1/NJGR+OSMAnhgVxo5EmuHuvPgfh1jkrTJ1WoCu6wPufqO49ypvQ6egT
 2zFL2S6E2UpTRkEs6J/KiUBNrSyyHea1U6ZUTskCfk71AOjFAdsLWjkK5lrQevXhwLzF
 3/zMUMTrL5C+8G/15OYyZ5zzGWw7O7bjIkNbkmMLqfVABvNcOaTmew31QKCmCzuTVK1e
 Y/FOB8qFbL1lZFBHSviHdVAKPtVJpffPGPjS/eEAoq9iWX/0keotlgMGSa52LvzAeyF3
 QIYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718108646; x=1718713446;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=r2IUh6JjwaeLgT7iyknV/seoPi4AaRCJv8Z19ePuBmk=;
 b=LEDEc4IoPekF6cCEiukIbPQsCvKru74Fi8UpBXXo9ahseWHKPVR3RwZ/tzjYbLV6JY
 Q3Loo7qYLFkRxlYijy+Hj8bWwFnsbjzCCNuaTIlEU4+43/J/dWyiXRS39P2OGNQrt86k
 9vj6jVtJmCSSdN51hrkbXBAX1DgLns+eGBbPJ8RmdzgL15y3YpGvq34RyAbPONrJfXYN
 uuci/0Zh0MyOBn7cb76SmgQAF/hLB8pbzvHSpnCsjHqJAI6DCyDUHan3FpYtOleforCg
 GxjAQDGmJB0r8LzxuinWAdMZrPfwAasmxlSV8jhJ3Mrfhq1ROsukzVIlcPHXjRljnUsb
 WOgA==
X-Gm-Message-State: AOJu0Yxm6zzxfJEj8gCLwAYIVYrUyp4L4PNJEKmuIefv+a72z6US2Nmd
 c0/gWGAHOZWxHr58L6zKwyRMmHH1xllsIInR8RU0Q2buY6IfQzBP61FmRazwQgNKfynIHg3IqMA
 wr0s=
X-Google-Smtp-Source: AGHT+IGe3in4Q9Udo0T5HV//MMvfJfnPJCzwLEdr3U8tp/GLxf0jYJPmvwZQFdDkeq+5W0aR6C/0aA==
X-Received: by 2002:a5d:6812:0:b0:35f:1e71:2635 with SMTP id
 ffacd0b85a97d-35f2b27ee1dmr2371029f8f.9.1718108646219; 
 Tue, 11 Jun 2024 05:24:06 -0700 (PDT)
Received: from localhost.localdomain (adsl-105.37.6.1.tellas.gr. [37.6.1.105])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35ef5fc0a0dsm13756623f8f.91.2024.06.11.05.24.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Jun 2024 05:24:05 -0700 (PDT)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: Zheyu Ma <zheyuma97@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Eric Auger <eric.auger@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v1] virtio-iommu: add error check before assert
Date: Tue, 11 Jun 2024 15:23:45 +0300
Message-ID: <20240611122348.3613272-1-manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x433.google.com
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
 hw/virtio/virtio-iommu.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
index 1326c6ec41..9b99def39f 100644
--- a/hw/virtio/virtio-iommu.c
+++ b/hw/virtio/virtio-iommu.c
@@ -818,6 +818,18 @@ static void virtio_iommu_handle_command(VirtIODevice *vdev, VirtQueue *vq)
 out:
         sz = iov_from_buf(elem->in_sg, elem->in_num, 0,
                           buf ? buf : &tail, output_size);
+        if (unlikely(sz != output_size)) {
+            tail.status = VIRTIO_IOMMU_S_DEVERR;
+            /* We checked that tail can fit earlier */
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

base-commit: 80e8f0602168f451a93e71cbb1d59e93d745e62e
-- 
γαῖα πυρί μιχθήτω


