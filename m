Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30FDDF3C9A9
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 15:57:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuun4-0006Uw-AK; Tue, 24 Feb 2026 10:57:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1vuun1-0006UC-E7
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 10:57:35 -0500
Received: from mail-vk1-xa29.google.com ([2607:f8b0:4864:20::a29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1vuumx-0000oN-FY
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 10:57:34 -0500
Received: by mail-vk1-xa29.google.com with SMTP id
 71dfb90a1353d-567543b8989so2714963e0c.2
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 07:57:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771948649; x=1772553449; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v9+lW+DSDlpSHt3UBv5+MmnqIWtMkhzwTy2QDZ17jkM=;
 b=Kv3vkqyEmbvCkPgeZbzcPiBZXt5Z9Hbi48+iFyp8AdWZbIrZmygnRqdalCJ0T04HKo
 PmWqNvoQ/y3jyBzGn7agPt7RfYAn+MfR3wxw+LaOpRrkSt/tvqWUBM4aK1GyDHd4MYNZ
 5Gr8bRU67aWfmFNAOoxDypNIJvuSiVUoD/FHq5iqjdb6iANDx6BP9UyUS2HXBzREHDm+
 u72Y6p8mUNu98Re0a/CrxI1kMZHOR7PxDCII2bCiOXusZoT2RgtyEz1WTeOlUWX4yF7U
 6XiUT/XWshOydiI/8nqwjVxsybCFQkLqjC5RZmwv9BhcQOJOrofr2+FsBCe1szGDNgO8
 JsFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771948649; x=1772553449;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=v9+lW+DSDlpSHt3UBv5+MmnqIWtMkhzwTy2QDZ17jkM=;
 b=qwKSfc9adVPMUQ1dsNIrd0V3n499dmNE7fpwwOJgr7DJgbbnM76CTs8+MKKzkD1ILj
 E5oAgZZF2nronREvoYL0ujnOWI8NxQLGWWoFTmRETqVtIS384cBRk3ak4vwQBddP/LQo
 CVZytCQ+LmmEfxRO36PadzieJyFS8Z+C5rKt8QYqazXsRnwV7klVnOU83RFlHQXBDzYe
 9CfgjJYhimcS9Oh/ruaqKPsQUWVhyAR7VGMA53VacxHAarzT+CMBmAkk91/iIP9Cdo+u
 sqk/zoP+62UXSkltIi0Gtv1jYLIZsjJstITwuGSXcLW+fCIVrFMpqvwfxIPRVVV63SHO
 IyuQ==
X-Gm-Message-State: AOJu0YwznB1v8j9qExpuXjFtyiyA4fpYf6cV8eusSELko+ctlgjvxgrd
 BH/+k9I5PDC/T+sYPEueqr104ArSjV7TwN9Kzdj91LZ6pt+2RwCYlYJqTnFm92Hx
X-Gm-Gg: ATEYQzxAAGdTART0iTr9lh4DqqCi0A402mNPzwUD8slIsClKMoY6iLdMGzbURLvsq1x
 ly1ICHWW6XW35Ls1GLWf3DFxe48vfg2QQD1ybg2NEfpOvWbv/FLB/pB0ou45XsxFKc0/Saf66qE
 NELBVACeTCnGro7EIN03BkcTCFtcnSkOqImvMtQgVKtC1to1+X9/duANFUUHEGTkR3vX8qpQbA8
 pnhh+2cjEZP1EEjaPrGvhp89meXe4s9mqwWgFt0PEDaPj57IpKLlGVfpPMlu6OyamsdKACIXDRr
 mUlq7EXi5DbanAvdR/XqCihEmJgOEm/mqd4n6rBsBN/QaRVcTtqHQa6fOSxbcNvRKCgzWNbPWsx
 cDLes5MIHAzegoLLa9bVWtiNg+b4QiUCX39uMGCugQtW56cLMLJasGG0rBat6aX9tGdYUb6RYPp
 E+S0fvGtoBtATO19acoHlslCurHz0+8Bz9l7Wlv6ojCGso62D9FJYOyKoVYA==
X-Received: by 2002:a05:6102:4192:b0:5fd:7140:e38b with SMTP id
 ada2fe7eead31-5feb310c798mr4329570137.35.1771948649433; 
 Tue, 24 Feb 2026 07:57:29 -0800 (PST)
Received: from gmail.com (ip190-5-140-142.intercom.com.sv. [190.5.140.142])
 by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-94da8a05060sm9902928241.6.2026.02.24.07.57.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Feb 2026 07:57:28 -0800 (PST)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org,
	"Michael S. Tsirkin" <mst@redhat.com>
Cc: alex.bennee@linaro.org,
	bill.mills@linaro.org,
	edgar.iglesias@amd.com
Subject: [PATCH v2 1/4] virtio: Add virtio_queue_get_rings
Date: Tue, 24 Feb 2026 16:57:18 +0100
Message-ID: <20260224155721.612314-2-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260224155721.612314-1-edgar.iglesias@gmail.com>
References: <20260224155721.612314-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::a29;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-vk1-xa29.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
---
 hw/virtio/virtio.c         | 16 ++++++++++++++++
 include/hw/virtio/virtio.h | 14 ++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index e9d5532952..00d387ba05 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -2402,6 +2402,22 @@ void virtio_queue_set_rings(VirtIODevice *vdev, int n, hwaddr desc,
     virtio_init_region_cache(vdev, n);
 }
 
+void virtio_queue_get_rings(VirtIODevice *vdev, int n, hwaddr *desc,
+                            hwaddr *avail, hwaddr *used)
+{
+    assert(vdev->vq[n].vring.num);
+
+    if (desc) {
+        *desc = vdev->vq[n].vring.desc;
+    }
+    if (avail) {
+        *avail = vdev->vq[n].vring.avail;
+    }
+    if (used) {
+        *used = vdev->vq[n].vring.used;
+    }
+}
+
 void virtio_queue_set_num(VirtIODevice *vdev, int n, int num)
 {
     /* Don't allow guest to flip queue between existent and
diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index 9dd93cf965..3a24d109fb 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -361,6 +361,20 @@ int virtio_queue_get_max_num(VirtIODevice *vdev, int n);
 int virtio_get_num_queues(VirtIODevice *vdev);
 void virtio_queue_set_rings(VirtIODevice *vdev, int n, hwaddr desc,
                             hwaddr avail, hwaddr used);
+/**
+ * virtio_queue_get_rings() - read ring addresses for a virtqueue
+ * @vdev: the virtio device
+ * @n: queue index
+ * @desc: optional pointer for the descriptor ring address
+ * @avail: optional pointer for the available ring address
+ * @used: optional pointer for the used ring address
+ *
+ * Returns the ring addresses configured for queue @n. The queue must
+ * be initialized (non-zero size); passing NULL for any output argument
+ * skips that address.
+ */
+void virtio_queue_get_rings(VirtIODevice *vdev, int n, hwaddr *desc,
+                            hwaddr *avail, hwaddr *used);
 void virtio_queue_update_rings(VirtIODevice *vdev, int n);
 void virtio_init_region_cache(VirtIODevice *vdev, int n);
 void virtio_queue_set_align(VirtIODevice *vdev, int n, int align);
-- 
2.43.0


