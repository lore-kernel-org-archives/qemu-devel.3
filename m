Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1550BC531C9
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 13:18:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnFmZ-0004MK-3W; Fri, 24 Jul 2026 09:17:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wnFmT-0004G4-9B
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 09:17:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wnFmR-0004yx-KI
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 09:17:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784899054;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=EaMM9Bpk3ukrnBNCRttpr0MC4s1HmNV9ciuUIX/i8lo=;
 b=WHtrHW6RH6dN/VL8sMFBOPVOk5bZFDthVXERrff51jIAvg2Vmxgxh0GGrqzgI38i0GjJxN
 TXIr3aI5FFe/C1qgE3d+NGGXDRujoOoKWBKNKyIfWzio5iIjjztSmQRGxJf9WaNkzzJg8V
 1IyeLaYFPva0uQkcg7bGjhV3GQJ1qsk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-kOHRqt2aOn6ZIYllRNdzIg-1; Fri, 24 Jul 2026 09:17:33 -0400
X-MC-Unique: kOHRqt2aOn6ZIYllRNdzIg-1
X-Mimecast-MFC-AGG-ID: kOHRqt2aOn6ZIYllRNdzIg_1784899052
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4955edc851aso2936225e9.2
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 06:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784899052; x=1785503852; darn=nongnu.org;
 h=content-disposition:content-type:mime-version:message-id:subject:cc
 :to:from:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=EaMM9Bpk3ukrnBNCRttpr0MC4s1HmNV9ciuUIX/i8lo=;
 b=kohl0oBlWUg/Z1eZjygnNo1GgiCr91vWMprH9BwCBq5b0actXIGZaXDTZFhkF4wGaB
 laxSVjgiAhpP6wIVYmIxePUYTucsytfbX8oL+okpyo6vsU4gLQJj8ncTolQdVBQefYOI
 +svbMrebr5SN0JuUZHZWAZ7dMp2t86nbCHRvdKLzO/ooK2o3bGL8MoYdvio+sMZeef+c
 LF08oUM2ZkemLeVpaIR+BtvMRFAHLvsV91UbhBxrVRK5Hvm3IaKeUa396uCwgAg6Gtgy
 uz4G5XHWfe6ATug/pOa9/qHy794tugV/BdiCIHV80VL+ZAT7fLoywrnIH0zTO64lG0Ws
 rg8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784899052; x=1785503852;
 h=content-disposition:content-type:mime-version:message-id:subject:cc
 :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EaMM9Bpk3ukrnBNCRttpr0MC4s1HmNV9ciuUIX/i8lo=;
 b=lDEy+GzId1s/FilTvxXULwBGHLkw7egrjS2GWT1nv2YEufOSLUIobJPhvdapDj5rCg
 PgA1xVtR9Zm/pz1eJd5yC+Ar+5eOh9oT3A78CTpPcrG8NrT7NDUlGuVk/TcgKCrJYhSt
 rUGCK6XoQD8uFpSHSnW+M4Y3n0xSaXQXf+PO1odl2Wq5YXw1C1MKcjBI/DY1IP962Xi4
 WK5G8ZBGSvHLtwm1piFVyilMBi0UONCCkJp3DdgRAnuTF3Mt1ELBwCuHmlKMcHlP44ln
 xTFsBGsSJgnGYEYtRw/EaGVWVSJ9o0iD1CImQq+uAROg6rXojMZogGCH16zPb1hCmArm
 aK/w==
X-Gm-Message-State: AOJu0YzAlA362tmFTeQ22Eka/Ae/yfdA98MGgUR1LKSV9hW+l/GTLBkC
 WwOJLQnxx3/ekAvan22uw7kdlilYiBs4/vogdijIA3ASewml/4M56hC76cPmk6FQbqjZyHZTp9n
 E7vwwr3nyn2rBN7oLSEbzgyWMy9JRYdZfG5np4bRt9CZDiT3Uq982Fu6nH0f865COCDjwN2qqSb
 +q7YM5hjg7e/E5uETKAc9tJc7sTXrOhxbINg==
X-Gm-Gg: AR+sD11J6llqg39J+I/jSQzRc5G9pgK+TkdYyBkcD+ttBdgRINp2Fi6A9bUFF5nlMvH
 U5jGgIUQ3IFc2aTjETdP1mpI95Ur+Df8VffiKfer2nCA9qA0/KVBEv6b+pbXBlBzSshqju2xhLm
 GuQ67aO1yb4pu7QhSwQdWBbZK9bX75oYYl4ayvn9g+bSdcLozMTn1ShncLmdArdwbT2TxrgL+23
 Wt0XQjsh0HIl23/vAgoWf/B40jyEYwwYaqid5fuHRk16wT7IV5/3TgT0omWzO0uS7BvtrNItO/c
 KovV7a7uH1GXIdYPeiX/8S6jHk+2NDCWr/hfqwvsfrZOsEznB3V+pa/GEJUpVbEOm1ebS+S8+S2
 bw+PIC7WmU/T+PFk69Md8cg==
X-Received: by 2002:a05:600c:c4a2:b0:495:4e17:cad5 with SMTP id
 5b1f17b1804b1-49573ce96aemr81900145e9.26.1784899051902; 
 Fri, 24 Jul 2026 06:17:31 -0700 (PDT)
X-Received: by 2002:a05:600c:c4a2:b0:495:4e17:cad5 with SMTP id
 5b1f17b1804b1-49573ce96aemr81899505e9.26.1784899050996; 
 Fri, 24 Jul 2026 06:17:30 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-37-66.inter.net.il. [80.230.37.66])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4957af78845sm67580135e9.8.2026.07.24.06.17.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jul 2026 06:17:30 -0700 (PDT)
Date: Fri, 24 Jul 2026 09:17:28 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH] virtio: fix queue size validation against allocated maximum
Message-ID: <eb7cc3672a20db392f577edbece2300aa6754dd3.1784898967.git.mst@redhat.com>
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

virtio_add_queue() allocates used_elems for num_default entries, but
virtio_queue_set_num() accepts larger guest-supplied queue sizes up to
VIRTQUEUE_MAX_SIZE. With VIRTIO_F_IN_ORDER, this lets the guest drive
used_elems accesses past the allocation and cause out-of-bounds reads
and writes.

Reject queue sizes larger than num_default in virtio_queue_set_num()
and mark the device broken.

Fixes: e63c0ba1bc ("virtio: Add support for guest setting of queue size")
Fixes: CVE-2026-50626
Cc: Peter Maydell <peter.maydell@linaro.org>
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3882
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3921
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3923
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3613
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/virtio.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 340bac2607..ee9247f98f 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -2440,6 +2440,11 @@ void virtio_queue_set_num(VirtIODevice *vdev, int n, int num)
         num < 0) {
         return;
     }
+    if (num > vdev->vq[n].vring.num_default) {
+        virtio_error(vdev, "virtio: queue %d size %d exceeds max size %u",
+                     n, num, vdev->vq[n].vring.num_default);
+        return;
+    }
     vdev->vq[n].vring.num = num;
 }
 
-- 
MST


