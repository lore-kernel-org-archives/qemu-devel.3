Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F35EC531F9
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 13:12:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnFhb-0004K6-0H; Fri, 24 Jul 2026 09:12:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wnFhX-0004EY-BZ
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 09:12:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wnFhV-0004NM-P1
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 09:12:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784898748;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=5X+mTeeJR0+JokeGLSCySUN+MNDPHWYMbx0g9Ygmp4g=;
 b=gtUNwblNvs3MzvYUxocPznR9lv9nLNP7/E5fVlJioqEAoIOHwkaHgYHtGoNV15sSOUjPKB
 wTzlZHsHxFzOFnJ+uTwiwIGRdm8Vt4XVXA5ppTqxj3LQZFLu6JbypFlDN+rKYFPSi5GjwA
 tBENuXdMAFvtJtIfZ7Fo4G/ElDEjU0k=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-214-DSsZjNy_MNGy7YFUlmgUyQ-1; Fri, 24 Jul 2026 09:12:27 -0400
X-MC-Unique: DSsZjNy_MNGy7YFUlmgUyQ-1
X-Mimecast-MFC-AGG-ID: DSsZjNy_MNGy7YFUlmgUyQ_1784898746
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-47f9ae25143so381219f8f.2
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 06:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784898746; x=1785503546; darn=nongnu.org;
 h=content-disposition:content-type:mime-version:message-id:subject:cc
 :to:from:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=5X+mTeeJR0+JokeGLSCySUN+MNDPHWYMbx0g9Ygmp4g=;
 b=ZT1M5gpcUw7xBpmVb4FM2GthKyv3e9YJtFkR7rleSYfyJucGmtmcFBeLjlUrSma//Z
 N78kayuydKapnr/i6xJcAhE8b8C8mwYZFvGZagaJeyxcH/VqrmjsMleiMNgl5SS85fJg
 rfqjzBXvavAbME0G/yvlEZDUDQh5Ki/C1OsYWLn35VsQKCjUH9gyi18DNsmRcJXILYZT
 cvlR351KdWl0s9wBaksCs0ryoZ3/4wXRKOzcXEEIRWg3cgd31w3uUiFoD0SuzSIG9D7x
 yQmXhX22jtAxvgwnPX74QWha2Cduq5NblATJXQ0LQgReEV0a9IV8LRU5OsV6rpDGUnov
 SO0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784898746; x=1785503546;
 h=content-disposition:content-type:mime-version:message-id:subject:cc
 :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5X+mTeeJR0+JokeGLSCySUN+MNDPHWYMbx0g9Ygmp4g=;
 b=IQZITxW8Nvzzng6AJXtouUtZy95CuLJeZRNM7549MwOJdpwbz+5hZTS4cPysgoQapt
 DGNK1XkXKz7yyC1XlxM+s3e/NTCIvGPMazkoCibN5iew4kBKxhLs0VUVm67zVp6whjKR
 60hjTocvaV6+Tn+agghgS4wDsBdaOC6L74K8HPHxrHvGzMMbET6L0cm2ODbNgtGTaAqn
 LF+YzK4zpfrhbPsRlm3FnGxAgmhJ4gj/lXjpMY8vum/q5ZXVb/qXlG+4ivRZq4hf9Kya
 ibcvmxwRSH+OChA7AQoblby61aqz4AM0w8xSOZ9Ltpwv5FTZZXJuumWS3Xk7opjKY5j3
 jnFg==
X-Gm-Message-State: AOJu0Yw88L7llOCNhSjtSprC4JDr+12TH+04j2vECjTtszLZObkAHkQD
 xCrkfnlX2fLXb//y9kJnHPL1gU97DdwSu0uFLuUxcbOFwBSLKlPm1Knd6AbFwNR5DhciMYCwKZG
 5U9truxQ8cNVJfcY/rUHnyHwWCuy5I5CRmYG9KkOWq9BrRJfR+1OfAK1D3LU1LRkDqYXvsuGuRS
 7vlEvlEbbDlSSKh0PWHCe+HbTFa7rR4QPb7w==
X-Gm-Gg: AR+sD12EsYxxqtnbdW0Za3/HtXN5cQGdt6FXm7+OV+uPmYXCBQA/HhqdHpWhBzcS2dt
 +TnmMZwppwCn3dg9HISIC2Aw1okWMbf6ZB8hEh/pshUlCks+y3aSFHurinf6p1RO56iCLrz7X1e
 egzW6UnfLOvyvr1Z649RGSj4WX2Pu8zZKnuoLgRnrg1uQAIb42l9LzSxEwvDfCT5lfxdIrr7spL
 +uR8cMdWNcL+lADFRmgPD1t0as7LuzRdwzZs43pFAUBq5d2loLcJqBe3hwjLTojxhARxJqrSv+U
 mi3q/gIZPuduI6IK+AwtxioqD+aYC1O4Ogr9K9f+Di8T2+JQsrMVQIYYFZCzPhqEMvZ84BbD4yS
 c/i9baTlCjMKG0WK9Psp+/Q==
X-Received: by 2002:a05:600c:529b:b0:493:e404:3727 with SMTP id
 5b1f17b1804b1-49573cf6d94mr85376275e9.23.1784898745834; 
 Fri, 24 Jul 2026 06:12:25 -0700 (PDT)
X-Received: by 2002:a05:600c:529b:b0:493:e404:3727 with SMTP id
 5b1f17b1804b1-49573cf6d94mr85375795e9.23.1784898745297; 
 Fri, 24 Jul 2026 06:12:25 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-37-66.inter.net.il. [80.230.37.66])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4957f5665f0sm33864465e9.0.2026.07.24.06.12.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jul 2026 06:12:24 -0700 (PDT)
Date: Fri, 24 Jul 2026 09:12:23 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowangio@gmail.com>
Subject: [PATCH] virtio: reject zero-length indirect packed descriptors
Message-ID: <04768f1e9a9f1329fe89631f2d8df9aa7b10bd09.1784898728.git.mst@redhat.com>
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

The packed-ring indirect descriptor handling in
virtqueue_packed_get_avail_bytes() and virtqueue_packed_pop() accepts
desc.len == 0, so a zero-length indirect descriptor reaches
address_space_cache_init(), triggers its len > 0 assertion, and aborts
QEMU.

Harmless except if the driver is in guest userspace, then it's a DoS
attack on the guest.

Check and reject desc.len == 0 - also matches the split-ring behaviour.

Fixes: CVE-2026-63324
Fixes: 86044b24e8 ("virtio: basic packed virtqueue support")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3754
Cc: Jason Wang <jasowangio@gmail.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/virtio.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 7c19080db5..2d33622daf 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -1475,7 +1475,7 @@ static void virtqueue_packed_get_avail_bytes(VirtQueue *vq,
         }
 
         if (desc.flags & VRING_DESC_F_INDIRECT) {
-            if (desc.len % sizeof(VRingPackedDesc)) {
+            if (!desc.len || (desc.len % sizeof(VRingPackedDesc))) {
                 virtio_error(vdev, "Invalid size for indirect buffer table");
                 goto err;
             }
@@ -1927,7 +1927,7 @@ static void *virtqueue_packed_pop(VirtQueue *vq, size_t sz)
     vring_packed_desc_read(vdev, &desc, desc_cache, i, true);
     id = desc.id;
     if (desc.flags & VRING_DESC_F_INDIRECT) {
-        if (desc.len % sizeof(VRingPackedDesc)) {
+        if (!desc.len || (desc.len % sizeof(VRingPackedDesc))) {
             virtio_error(vdev, "Invalid size for indirect buffer table");
             goto done;
         }
-- 
MST


