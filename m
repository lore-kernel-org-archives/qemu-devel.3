Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67FDBC2D0CD
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 06:33:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFS9L-00086a-9l; Thu, 15 May 2025 02:32:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuri.benditovich@daynix.com>)
 id 1uFS9I-00084i-Iw
 for qemu-devel@nongnu.org; Thu, 15 May 2025 02:32:56 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yuri.benditovich@daynix.com>)
 id 1uFS9D-0006S3-Hg
 for qemu-devel@nongnu.org; Thu, 15 May 2025 02:32:54 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3a1c85e77d7so297287f8f.0
 for <qemu-devel@nongnu.org>; Wed, 14 May 2025 23:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1747290767; x=1747895567;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=xFX2/rCvFl/aHVRlpBletJAsr6RLsmN/7Y/0M9LH1qQ=;
 b=TeB75cExuwPhHwfJTThNoGKiKBQyYFlhwoa9Fje0lgSxumiMpKybm4gJTHb9llV/ap
 3HdkyruIagPn0FgFvvyIzQC7b4buFrdB9zCjZ71ZNB2PKYjUIsUjsEb+Xi52xgbDLM+7
 Ezmu2tWq+In85dYuT/HOdE6wg7foHfOXxKRHoUVtzmAK0oRreXJF/plMyDi9JU8gaavF
 Qb+L4tirI5MWt86B5IgL+pgJ92dEANJp/VIDeyyZO3BBNk5UicnzCGUN1uUTo6yIAZDM
 oAN4C4j+nf4k8Ddv8fD5sbhl/JQszFflqlJhexBeZe9v4mWjbmNP6Em3FDxFewt7Ev5Y
 SZwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747290767; x=1747895567;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xFX2/rCvFl/aHVRlpBletJAsr6RLsmN/7Y/0M9LH1qQ=;
 b=hdZJr5u0080PGEXg0D5F1UuJJq0jmxjpd9ln4HFREuM7GhHzSaVSLjo5EH1JJ+d5Z4
 nTvFSlR5gPjgr4Q9trxJYsOZw1Xh7yWUWxwkslAALDFZVuROCq+fyL5RXF+ijVqFoS3w
 0fh5T/bOXghgO/7EUTBSbQotH2q5vIXtLR5f765HoRKqTAcTh+QQhYgoLsmGjNq9xl+f
 Z/Hja/Oy/2t2t6AIGxcyK7JMAz/twB9X4FcLCB1kobcGSF5luY+qy2RBZGimtvexpoC8
 /aUZGXyOZWHbvKC+BTOacmuBmjRaR0Cw50p5BUt9NfFxB+RZ4M0ktzc0akuT/0n4JEqL
 n2BQ==
X-Gm-Message-State: AOJu0YyGluj/9EXuyhSKowuvlLmhksNrJX/r/QfoR0vfhMtvW5/sk1Pc
 zI9s+2oYYDHx+eMGQMrCGncG7jgMWC8/8ggCgAItExmtzycwpi2auzclCvMDaTl4382mStqSdlJ
 J42o=
X-Gm-Gg: ASbGncseBQKPbR2/kWHK+K+LNeK/pZGDpBof9zdMc6AcP7m2A+iI/JnZEufPNMb08+p
 K1B8ALd8m5rF9E6ncR/GJhPxpgyZSWSOihU1ikji8qBSYnDeTp3K+qYpty0sh/8TaBD/hhmbcUD
 ZGPPUBcql3ZixtlNY56p/I/V8sPJyQKKDpfZ2yz5ZwxZkxxPLSJaNjittMsSmwpdaNQ7BxeGhlQ
 T/R5CzRzlBWkjDr7vBU9Fnx2Q3N0YQxk0oUJNp/MfPlWUq3IwRGl0DEAKGRGBQNT6E/eB6hCxeI
 wynwuISKCBhlUD/8GPa7wDrfb1e7knIO5Utb2RyCXGxnGv0wVCdK/2CKRiRbbMnHWDI78+heRIf
 QKJM=
X-Google-Smtp-Source: AGHT+IEdDBx1AaCz6FtLTxU/hK2AVg1DfoBAtGLHgrrwxZXas//pO+5H4+KN0xWLHtG7e9AiAVpong==
X-Received: by 2002:a05:6000:40d9:b0:39c:16a0:fee4 with SMTP id
 ffacd0b85a97d-3a3537485f6mr942267f8f.27.1747290767023; 
 Wed, 14 May 2025 23:32:47 -0700 (PDT)
Received: from localhost.localdomain
 ([2a06:c701:46e6:f100:c8c7:3786:c3ef:951f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a1f58ecadfsm21580670f8f.22.2025.05.14.23.32.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 May 2025 23:32:46 -0700 (PDT)
From: Yuri Benditovich <yuri.benditovich@daynix.com>
To: qemu-devel@nongnu.org,
	mst@redhat.com
Cc: devel@daynix.com
Subject: [PATCH] virtio: check for validity of indirect descriptors
Date: Thu, 15 May 2025 09:32:37 +0300
Message-Id: <20250515063237.808293-1-yuri.benditovich@daynix.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=yuri.benditovich@daynix.com; helo=mail-wr1-x42e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

virtio processes indirect descriptors even if the respected
feature VIRTIO_RING_F_INDIRECT_DESC was not negotiated.
If qemu is used with reduced set of features to emulate the
hardware device that does not support indirect descriptors,
the will probably trigger problematic flows on the hardware
setup but do not reveal the  mistake on qemu.
Add LOG_GUEST_ERROR for such case. This will issue logs with
'-d guest_errors' in the command line

Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
---
 hw/virtio/virtio.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 480c2e5036..8d185f282a 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -205,6 +205,15 @@ static const char *virtio_id_to_name(uint16_t device_id)
     return name;
 }
 
+static void virtio_check_indirect_feature(VirtIODevice *vdev)
+{
+    if (!virtio_vdev_has_feature(vdev, VIRTIO_RING_F_INDIRECT_DESC)) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "Device %s: indirect_desc was not negotiated!\n",
+                      vdev->name);
+    }
+}
+
 /* Called within call_rcu().  */
 static void virtio_free_region_cache(VRingMemoryRegionCaches *caches)
 {
@@ -1733,6 +1742,7 @@ static void *virtqueue_split_pop(VirtQueue *vq, size_t sz)
             virtio_error(vdev, "Invalid size for indirect buffer table");
             goto done;
         }
+        virtio_check_indirect_feature(vdev);
 
         /* loop over the indirect descriptor table */
         len = address_space_cache_init(&indirect_desc_cache, vdev->dma_as,
@@ -1870,6 +1880,7 @@ static void *virtqueue_packed_pop(VirtQueue *vq, size_t sz)
             virtio_error(vdev, "Invalid size for indirect buffer table");
             goto done;
         }
+        virtio_check_indirect_feature(vdev);
 
         /* loop over the indirect descriptor table */
         len = address_space_cache_init(&indirect_desc_cache, vdev->dma_as,
-- 
2.40.1


