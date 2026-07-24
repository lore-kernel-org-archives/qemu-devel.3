Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 471CAC531C9
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 13:08:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnFd9-0001fe-A8; Fri, 24 Jul 2026 09:07:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wnFd7-0001fQ-2Y
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 09:07:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wnFd4-0003hm-Qk
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 09:07:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784898473;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=RaWPHqEvLynkkdiUEbV5IxgCfLZEr7aZFRXddkARyTI=;
 b=JZtNts0x1KvZ+YPhJXF6QqLan/zqZSM3At+VQUgmYwdaOdbtXLjYyGmnSrlBhwmXKriKB8
 CXfJYwFhlV3sCsmc5NH/1FCVlE+2wGXDEVV16/XYJi97Igo0ayYKh8YovrHvWc1Ts5XVM0
 zRl6r4ECLldR/s44Qcsn3qrcMLyF2e0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-QlZNen4sPk2fT-6BhiFt2A-1; Fri, 24 Jul 2026 09:07:52 -0400
X-MC-Unique: QlZNen4sPk2fT-6BhiFt2A-1
X-Mimecast-MFC-AGG-ID: QlZNen4sPk2fT-6BhiFt2A_1784898471
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-49561facb1dso4120875e9.3
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 06:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784898470; x=1785503270; darn=nongnu.org;
 h=content-disposition:content-type:mime-version:message-id:subject:cc
 :to:from:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=RaWPHqEvLynkkdiUEbV5IxgCfLZEr7aZFRXddkARyTI=;
 b=Nzv/sdr99ZMki93E22tYB8AYLeSADY4Etjb5kKFTVOSZCHNk6RFp9+1q7Jf62H47A8
 aOcW4QYm3/q+y1dvXzYiDmfcvsVNMsZ3c1a+sBlMFzXueXxPDzLT1CsCrwe4VF/z/NmK
 6A3L/FeoF6FjuBacV5kOAnH1Zr6XjQf68Ns+Vk4CDRF7C7SvvyoNH1TaShmI3GP331/F
 gRrTsJR4x6j7pDwR/6EbKf2KYITc2nq6IQknmOVzibPAOf+Ha91B3nyu/dg8kOnaT1qA
 e4aca21wxjDrz4AVLw9w/VTUG34Sd05Ka5D5D/LJOl0aTahVH2q//mRpdSRxMb/ZGhJy
 3Zhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784898470; x=1785503270;
 h=content-disposition:content-type:mime-version:message-id:subject:cc
 :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RaWPHqEvLynkkdiUEbV5IxgCfLZEr7aZFRXddkARyTI=;
 b=r7MANJSJatrxLyB+IOD279M1umjojkpBJ0XNfL9dtbXrT1hIdrWsulojrU/tJJ+zyE
 CnnM5caGCaAOCk2FAGIQFoAgdfrR/mL65kR4BpkkulwsTnlOpEc7731J1cKSRCBmrPni
 UpoEC07sUXMzndFBn1OhFckf/Tf+0/sEp0obOajue1g5DCl7FLvcu4mEj1q/kVNRy5h6
 FiS+b02vjWkROcqu2tSHzumCS8b1SIKLxmZTrviCYuU2tHZ67rlSTlF3GMt4XUz7lKd7
 Gya9frasQCTlKa051gDZguSC0T5fvzCqVNKPffWmQOQXPCq57oFEQ/sBgrKa/IgCTi58
 kusg==
X-Gm-Message-State: AOJu0YzcE2FW46eXLUXv/hTPkOTnjXU0VEMzyyRWA42BPa9XQuSA1nCQ
 uy/wnDniXid+Gc/+vgddp/RuM2N1DxByrBDZ36sxIXyq3Q9iWugw2BwaWiuGJYo7vbfRBNsMXFA
 2vFQz6TLh2nDE/7lsdubC1IQ7GgW/ycGacu3ic3/xUrvkgFOFqHixbQv2Vr+b7m9UKSZncJXKbY
 a7TPJ7CaMI/dLahGws3ee1FfIycmNvqWnFlA==
X-Gm-Gg: AR+sD11nfoT5kG3PDAdSkjgXe6qPUWEn+mVColJ8W9T6JtIysfC3LGZdb0V+tfqpoki
 5HvxaI7u7IfeNXZiceI8mxX4uT3waxeBJCeTvbsGCz4oQmj5zzUNF/oTDaaMxfj2u6C3/uITgK6
 44LSGa1bAJDta4oAtt9Lu836UQori4xF8W8UiOicvT5C1CFFGJJ2DfDC1v9FeEev7o4e9W6CXVu
 hiihUycgPxuVdpylNM1b1nrFtRPVPgrGM9iKLA7cv0qZFuUzbP7NmYcPGg4nQ60sgSXnJSCnQkx
 GQzLKQxibfqssF8bbNLBcuXGUD6aUCHFD1Ge9HOo4c/vVYoXwwCbi7uvq7L4Vp7WlnSPXB4GQA7
 de/uTmr70qJXiIjBg9z2S7g==
X-Received: by 2002:a7b:c84c:0:b0:495:3b8a:bf11 with SMTP id
 5b1f17b1804b1-49573cff52bmr58967745e9.26.1784898470376; 
 Fri, 24 Jul 2026 06:07:50 -0700 (PDT)
X-Received: by 2002:a7b:c84c:0:b0:495:3b8a:bf11 with SMTP id
 5b1f17b1804b1-49573cff52bmr58966805e9.26.1784898469436; 
 Fri, 24 Jul 2026 06:07:49 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-37-66.inter.net.il. [80.230.37.66])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85bdac28sm22807366f8f.16.2026.07.24.06.07.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jul 2026 06:07:48 -0700 (PDT)
Date: Fri, 24 Jul 2026 09:07:47 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefano Garzarella <sgarzare@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>
Subject: [PATCH] vhost: do not crash on ring map failure
Message-ID: <71961a7dc157f552303aeea8c99a75c5e1ce904e.1784898432.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.419,
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

When vhost_commit() rebuilds the memory region table after a flatview
change, it revalidates cached host virtual addresses for active vring
parts. If a mapping is stale, QEMU abort().

This is not a security problem - only the priviledged guest
can control make it invalid - but not nice e.g. for driver debugging.

Let's call virtio_error() instead, marking the device as broken.

Fixes: 0ca1fd2d68 ("vhost: Simplify ring verification checks")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3783
Cc: Stefano Garzarella <sgarzare@redhat.com>
Cc: Dr. David Alan Gilbert <dave@treblig.org>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/vhost.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index af41841b52..371dca17dd 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -755,8 +755,9 @@ static void vhost_commit(MemoryListener *listener)
                        (void *)(uintptr_t)dev->mem->regions[i].userspace_addr,
                        dev->mem->regions[i].guest_phys_addr,
                        dev->mem->regions[i].memory_size)) {
-            error_report("Verify ring failure on region %d", i);
-            abort();
+            virtio_error(dev->vdev,
+                         "Verify ring failure on region %d", i);
+            goto out;
         }
     }
 
-- 
MST


