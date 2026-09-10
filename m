Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27E9CC88E41
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 00:26:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4ot5-0001RF-OA; Thu, 10 Sep 2026 20:13:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4lXR-0006iB-M6
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 16:38:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4lXB-0004Ro-9C
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 16:38:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789072503;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cztzzK3RRsXNvSO1Mj0DbxdXP/qmCz45hPp6THADzZ0=;
 b=KX0rCiOavBbqErHmWmDq27Y79O/fF6s9opmyIhk5m27KinZRH53cyK/gJHFmR2Y++Sbh8Q
 s1EwecqTF35f5zzL5vylLJaaEsvAIGwdDa7zFG8Dpa+kq2xvYdI5DWgohh1wWjhT74o+Fd
 c9pFt/13zxn34feyQO/4eZwbAXS6wQU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-DHfwrLzROryMdYv6gMcRrQ-1; Thu, 10 Sep 2026 16:11:32 -0400
X-MC-Unique: DHfwrLzROryMdYv6gMcRrQ-1
X-Mimecast-MFC-AGG-ID: DHfwrLzROryMdYv6gMcRrQ_1789071091
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-48439eea716so54490f8f.2
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 13:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789071091; x=1789675891; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=cztzzK3RRsXNvSO1Mj0DbxdXP/qmCz45hPp6THADzZ0=;
 b=obM2euD31cDujhvkapkycCxbQBDlmf3E6uhatnKkncCBiQ3UnPmClAx95HOKriOQmX
 bRfUKbhU1OV1HOqlbtR5n0eCJE4yEX12dNaB7pW+niYjEOYCJWAieTSvV9ZKLg2QBhN6
 ja0FhRT6F3N+qwNhaqN/sXmhWinbZGmGp6jQh/1SOmpYESdcJyTIunrmRhNiuzSgQwSS
 a70tWXKY3r00DCoAkejos+zY+wg2Z698FB9K/14wIve/DfSFivx4XqQAcjNBFz8q7wka
 JmA0tcyLKfgMBK9+czrBEbuteTH43im9DEXgNI8zJI1FMFuk/bOLiELdDSN55PEWNkz0
 iMjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789071091; x=1789675891;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=cztzzK3RRsXNvSO1Mj0DbxdXP/qmCz45hPp6THADzZ0=;
 b=Jgjr2+oazSP1b3KsqNCzOKky1bC1hVj86TRFE7VK2+2Ep//pLl09joBz4KzmMujunf
 pxxvLHbS3T2Zr/cz23j7m/0AM3XiAygpCZPxjcAVqEd9Su1WViACM1x94d2AOiiA4KOP
 feF0s+jgtrn4MV2MwfNWsMxdNkWPgl5Rj9QGgyWwWN8kHhpKt76yskhpES8oLU4biKJy
 Au7yooImCoLUuis99AAygKo8ZWE4RLxTi6Aj8WzT+LMZEXUOhAENP9Zw+6XRhktQCRJM
 aN6VpWEqxyzhZ4CdEV7kFEkVtOmBAEvdnXQNZM273BtL5HCvSlApS3f4qyBXqIkFHsx4
 oi3w==
X-Gm-Message-State: AFuF++miJhOEbPZtryuPH7WjZtNDarP/zekZ26N+DFGFi20l/TKUyh88
 ctoXGSv6CP9fIokgmSemnXeS25lot+b/5APOK6YbWC04SerrT6SDMTXrWL0HPw4VH/ONFBOwuae
 vKCWGxdrjGm1DtkvHxw4yMRQtHuL/h6mgpjbjwUOXzhTfnmbdS4gVB7Z3eByjNIbs8+p+rhCFDu
 zQLSPXPEnvHzZKOmFyxlMYEMRXlcXuc9GS6Q==
X-Gm-Gg: AYBFou00+9EGYzgVn4dKXyT455vp2e0+H9VigST87FCP6GltYCv5GwvkQANpoimumNo
 BkPUpNIx4IgTVrBAR0kfRwTfmCYAUxfhO9J11BVYbnUUbA6Kzb6g4unyIEPxkbwWodXsYpv1kmX
 YZR9zwbGmX5sQv1tJLgNgUqW1YgVbzyzJW3SpY7nC6PO/WZL9LtUoU1T+A+7P90UiSyAWyW0bt0
 MKIRMLfZATd2A2chlKznoCB8Gg4U8jz4y9ZlWaorSrpQgG97UZDtqvBghFLVXk5jNCZo8qChOjK
 MlH9y/fDHhVojN+azaF5fUFhyftYAadwQgWpHIsnha1a6cpJeZGXiYpTjq7/tdx/56em1XBS5PP
 PIGC0+9L5fKnRHckscAQWwA0=
X-Received: by 2002:a05:6000:2005:b0:485:8fb5:20e2 with SMTP id
 ffacd0b85a97d-486eafd5fe0mr723645f8f.12.1789071090764; 
 Thu, 10 Sep 2026 13:11:30 -0700 (PDT)
X-Received: by 2002:a05:6000:2005:b0:485:8fb5:20e2 with SMTP id
 ffacd0b85a97d-486eafd5fe0mr723592f8f.12.1789071090173; 
 Thu, 10 Sep 2026 13:11:30 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-486eb360409sm707483f8f.36.2026.09.10.13.11.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 13:11:29 -0700 (PDT)
Date: Thu, 10 Sep 2026 16:11:28 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Kangjie Xu <kangjie.xu@linux.alibaba.com>
Subject: [PULL 03/90] virtio-pci: reject Q_ENABLE write on already-enabled
 queue
Message-ID: <62976e8a2ea7fcc8c635754739fbaf2c499dc754.1789071042.git.mst@redhat.com>
References: <cover.1789071042.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1789071042.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

When the guest writes 1 to the VIRTIO_PCI_COMMON_Q_ENABLE field of a
queue that is already enabled, QEMU re-applies the ring geometry stored
in the PCI proxy shadow registers by calling virtio_queue_set_num() and
virtio_queue_set_rings().  Those functions update the vring descriptor,
available, and used addresses and the region cache, but they do not
touch the host-side progress fields - last_avail_idx, shadow_avail_idx,
used_idx, inuse, and the packed-ring wrap counters - which are only
zeroed by __virtio_queue_reset().

Because the progress indices are stale while the ring layout is new, the
host can treat the new ring as though there are up to 65535 pending
descriptors already waiting, causing virtqueue_pop() to iterate far
beyond what the guest actually posted.  On virtio-iommu this translates
into a stream of ATTACH/DETACH/MAP/UNMAP commands, driving the QEMU
process toward OOM from guest-controlled BAR writes.

The virtio specification requires the driver to complete a full queue
reset cycle before re-enabling a queue.  Fix this by checking the
proxy's per-queue enabled flag before processing the write.  If the
queue is already enabled, log the violation as a guest error and ignore
the write.

Fixes: d1060e3dc5 ("virtio-pci: support queue enable")
Cc: Kangjie Xu <kangjie.xu@linux.alibaba.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/virtio-pci.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index 6f5db5fc42..c73f1f546c 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -1692,6 +1692,13 @@ static void virtio_pci_common_write(void *opaque, hwaddr addr,
         break;
     case VIRTIO_PCI_COMMON_Q_ENABLE:
         if (val == 1) {
+            if (proxy->vqs[vdev->queue_sel].enabled) {
+                qemu_log_mask(LOG_GUEST_ERROR,
+                              "%s: queue %d already enabled - "
+                              "reset queue before re-enabling\n",
+                              __func__, vdev->queue_sel);
+                break;
+            }
             virtio_queue_set_num(vdev, vdev->queue_sel,
                                  proxy->vqs[vdev->queue_sel].num);
             virtio_queue_set_rings(vdev, vdev->queue_sel,
-- 
MST


