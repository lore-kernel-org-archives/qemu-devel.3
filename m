Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64B7AC531C9
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 11:08:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnDlX-00061d-3n; Fri, 24 Jul 2026 07:08:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wnDlV-00060x-Gu
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 07:08:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wnDlT-0000nh-Az
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 07:08:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784891305;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=jgw+qa2cHk//6tkJLTRl7Ruvx3hFXDTJisY+mvGIPrc=;
 b=Y/NUKNIgLTNvdK8pebMWDqF/LipfOHu/aX7lHbQ9kpLsQ0X+Pspsr62oFilxvOAq+0YJ9R
 DM65+xL7vOS7zETF0PD7r6jOBoGEb/A69g4wu8Er/znMRCV+DNoLVm1E2HQ6mbhDlN4IjD
 B7+1Ux6afpYAiFnhNu9YmLS7V5lJK8Y=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-26-CFF-gAGOM46Ipsc3VnrwuQ-1; Fri, 24 Jul 2026 07:08:24 -0400
X-MC-Unique: CFF-gAGOM46Ipsc3VnrwuQ-1
X-Mimecast-MFC-AGG-ID: CFF-gAGOM46Ipsc3VnrwuQ_1784891303
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4954fe32d6eso2023845e9.1
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 04:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784891303; x=1785496103; darn=nongnu.org;
 h=content-disposition:content-type:mime-version:message-id:subject:cc
 :to:from:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=jgw+qa2cHk//6tkJLTRl7Ruvx3hFXDTJisY+mvGIPrc=;
 b=l2rzBAItM81XBY1o/DwDEpN1+n9/skjlaqkJI0kunkxZleVmhaxmdsOUPqJFCOSYkw
 Zy8LUAgvtrxn97N10uCEwN4H037akAzebMzB8YvZ0t6mvYQG8Dj2vyStMf/nz+Spebh1
 1o3bpy6Cw/iJNGxqQarQGPAcDBg+0QI738PFOWP8a6uZGKCaB8CKiymRc/dtmu/vtNy6
 Z0CVNoenipIRZev7pWgEqdZV7edbRPu7Ht1UgX67105/x9ptdOmOlolwIIsm8pz1oFNP
 IJAQjlR6G4SRq5fAR5rQomOaL1qCbycd+kwm4mJu9u4AzEPxqY0JueC3Bgg7hFF1HZXO
 zc5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784891303; x=1785496103;
 h=content-disposition:content-type:mime-version:message-id:subject:cc
 :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jgw+qa2cHk//6tkJLTRl7Ruvx3hFXDTJisY+mvGIPrc=;
 b=mk+j0roNiC3EPdjsmesLkd2Q0X2Rsr9ELs6MIQSV9y3xrnLACoTIuIbqMduHOHjjKG
 GgoEbu4qfHwUlCnodgPeEc9SZvFaryevCkhM8lz4tEB5UH6x2gETs2c+HRkGS0HeTyM4
 +4ONdhaVJZ7KBVIuN5r/mLJrslzSc38rCSZ01bQgcjt3gs+s105uFVE+WooAC3VupVbt
 +uyWgkrSfJ+7xkvxsIZyy7mwa8XfRqAH7n96kZvPULskseve65tl86ytDjIvMXRD3wHJ
 3qlzK4mvq5el3nRz3PsT9x5vdecsD90K/gwO6+0qSBc9ojsZLqUxzhpvPq1EfO2OPBWD
 OLPw==
X-Gm-Message-State: AOJu0YxsbS7ggzJeo3erU0PqlQuNzhPZcE3WKVGJd9r05Sna4+Z908g3
 47eaDOdhgNA8f5ygKz3LZrjM3Hs5ZLJ8cZSfmRpCgWYnkNAanTcSaMtPdeYnequ0dKFNEs+sMAP
 lA6Ip/2SRysk+KhRIbXOMWzsVfWFblqa3ui+DkxDa+JIagh3qY5dTGoFOGfvBXqd/EY4Vwbjwv8
 yEr+DvfRUOZueX/YccqtNXXyzL19c9UmLKoQ==
X-Gm-Gg: AR+sD11RtK8GeBLC8e9xXni9ENYYJIPiyFi4HcfmMEGLLoKDa+v87IKCVsSPinQV48I
 jBh9NIIzaC9GIbcJ/qmnzwjZOe1yDpqM0FeZPUT9XncuEz6v3JtzaumNwyQzpOoEdHDwQiJCxJD
 d8l54gV1aXlCw5iwbHMSxp7e8F0dKFvNrUCQmbSZoRxu7ckDTUDaA5tQWLGvEH8hN3xteNmAgC6
 Zs+5c53//zGBIxEz2J5ZQ+Dwh19+nBnq+ONKn3+9aATgxf5OBKiqZuOrxvWHpt58qH6O571N07v
 OCYjtYwSrqM8DtD/2DEmH/IVC6vjTFqnW1C6/GcxNGaE6ko9qIe4ZNDN5oJzSA5N5ucurKT46ht
 F/gb2cVAeQ+eT81Ct50JJyw==
X-Received: by 2002:a05:600c:4687:b0:495:5dcc:52ae with SMTP id
 5b1f17b1804b1-49573cc2eb8mr83874255e9.3.1784891302814; 
 Fri, 24 Jul 2026 04:08:22 -0700 (PDT)
X-Received: by 2002:a05:600c:4687:b0:495:5dcc:52ae with SMTP id
 5b1f17b1804b1-49573cc2eb8mr83873535e9.3.1784891302273; 
 Fri, 24 Jul 2026 04:08:22 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-37-66.inter.net.il. [80.230.37.66])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4957f9ae5c3sm28135365e9.3.2026.07.24.04.08.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jul 2026 04:08:21 -0700 (PDT)
Date: Fri, 24 Jul 2026 07:08:19 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowangio@gmail.com>, Yuri Benditovich <ybendito@redhat.com>,
 Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 1/2] virtio: use masked features with set_features_ex
Message-ID: <dfd27c9b26e442a2076f6ddc9bb3d38363d9b2da.1784891251.git.mst@redhat.com>
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

virtio_set_features_nocheck() calls set_features_ex
with guest-supplied feature bits, without masking the value
with host features (unlike set_features which gets the
correct val & host_features).

This does not matter if the driver matches spec, but drivers
can be malicious or buggy and set bit outside the host mask.

Devices don't expect this, so unsupported guest feature bits getting set
can break the host. In virtio-net, this can enable RSC without vnet
header support and cause out-of-bounds reads from short packets.

Pass the masked features to set_features_ex, consistent with set_features.

Fixes: CVE-2026-63321
Fixes: 64a6a336f4 ("virtio: add support for negotiating extended features")
Cc: Jason Wang <jasowangio@gmail.com>
Cc: Yuri Benditovich <ybendito@redhat.com>
Cc: Paolo Abeni <pabeni@redhat.com>
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3623
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/virtio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index f4d86a3655..7c19080db5 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -3320,7 +3320,7 @@ static int virtio_set_features_nocheck(VirtIODevice *vdev, const uint64_t *val)
     virtio_features_and(tmp, val, vdev->host_features_ex);
 
     if (k->set_features_ex) {
-        k->set_features_ex(vdev, val);
+        k->set_features_ex(vdev, tmp);
     } else if (k->set_features) {
         bad = bad || virtio_features_use_ex(tmp);
         k->set_features(vdev, tmp[0]);
-- 
MST


