Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 434D8E7716E
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 20:35:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJIZR-0006QZ-SN; Thu, 05 Dec 2024 15:35:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <icegambit91@gmail.com>)
 id 1tJIZP-0006DM-FP
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 15:35:31 -0500
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <icegambit91@gmail.com>)
 id 1tJIZM-0004pM-OX
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 15:35:31 -0500
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-2ee709715d9so989888a91.3
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2024 12:35:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733430921; x=1734035721; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vvD8iJMWbVGgLrHgj6Wpg47VvHU8OZqOaHm8l4MsBPw=;
 b=AK7OBFF0exl668EexGJKspXsq+aGEe5Gwyei7sgSV8qDtF2fAuLm/H9fuqfvGK3Lsy
 Z8rIT72TxYiCXjNPShrus9IOmCj5THutjxST1aGsIlxA1uvVKpP8SFsRBACo5U28AQZm
 QDt9hFcrzT8NFurXwfRts7S588eKweUOMkHKQgXbbFSccFHCIJn7pDbpqc64fxnmztan
 LtHDp+GjaLG28AstCRgxBMy2ihYhTVBZ2jpIR5nfns6mHyXUDu7047sBapoCeh2rtAna
 4VlgUdnuDvXhC8wNV4Sp0CKC3/uVfPQ2xl5TXuXJJn6htMDK7WviR6zxREBl3z4x8uFS
 +0cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733430921; x=1734035721;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vvD8iJMWbVGgLrHgj6Wpg47VvHU8OZqOaHm8l4MsBPw=;
 b=rE8q0MNSC6BccUCwpate1NsHWaB5uGDg4fMzfddTPfd9fM/1ZXuq56ShRhCTTGGZpI
 MgQzlK4FctqDGJ+vKnBCwUKM/xTbtGHSbdK/X4V1jUq1ojIwnPzjxEvCPaI1URlsNDZg
 SxO9LgCXms7d5fYyEROQRoO6zjaIt5oL3FgbvsWnb3YzjH/iekryKzjY4oFhOZwZ+XVA
 DOFjthOJydC3XOIYDL1CiyMUZWpqEtJACsWG+yegqUBanNhXuIo7EiyE0ahZxWB5XP+d
 lxvlS3t1FbmX2EqwGpRV1w+WwwmYyh3ilrxnHDkVRp4BoQdSnpIllbDFLMjTaC9QHzhp
 wLzg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUhSwKEMntz6TaVa7SdN91ryfWqq4kkp8DpPljdsKwj4esXLoNKcy8tCUocVVR38z0mPKGY/sfLYut+@nongnu.org
X-Gm-Message-State: AOJu0Yxi1Xj2huMzOZw8JfIEx/DoKg0/sxIE86rUsNGakviDqR6hijWg
 QybvR130xCoHOWXl1z4//9kodR4FhE2wW9z9DAv8pliwwf4at9Yp
X-Gm-Gg: ASbGncuCokGiOhCQx4yQrt/fYE1UdTMSUSICNQggZlxvlDoJQKxiibSgVbk2FcvozNX
 zvG8wgXp4b8fpkZsao2O72aqYv26EBRKV320aVTOQ3MZeHUdLtfCKWRVOhy32XVQOyzVMdqKpsk
 jcxoWcC0XULkVhAepzEkXC/wqNWXgYOPt2oz0Nbo0My5RyAJbP6LHAKwK0ESSVq5zxVq6M7XX6W
 vqHW5HUH/N4K7sX2vCAayXBhGGnTCphdhybHLfso48=
X-Google-Smtp-Source: AGHT+IEppdbuIhzZsemGUvQ0MVmTuFmfK56YOZaDymUlTbFQTmQIe4O/O13eTYhx1Dmfh5q3pEh/iQ==
X-Received: by 2002:a17:90b:4f46:b0:2ee:eb5b:6e06 with SMTP id
 98e67ed59e1d1-2ef6aaf3a46mr772276a91.36.1733430921365; 
 Thu, 05 Dec 2024 12:35:21 -0800 (PST)
Received: from valdaarhun.. ([2409:4081:2c01:b2be:f39d:e902:7582:5526])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ef2701c2f2sm3705905a91.23.2024.12.05.12.35.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Dec 2024 12:35:20 -0800 (PST)
From: Sahil Siddiq <icegambit91@gmail.com>
X-Google-Original-From: Sahil Siddiq <sahilcdq@proton.me>
To: eperezma@redhat.com,
	sgarzare@redhat.com
Cc: mst@redhat.com, qemu-devel@nongnu.org, Sahil Siddiq <sahilcdq@proton.me>
Subject: [RFC v4 5/5] vdpa: Support setting vring_base for packed svq
Date: Fri,  6 Dec 2024 02:04:30 +0530
Message-ID: <20241205203430.76251-6-sahilcdq@proton.me>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241205203430.76251-1-sahilcdq@proton.me>
References: <20241205203430.76251-1-sahilcdq@proton.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=icegambit91@gmail.com; helo=mail-pj1-x1036.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Linux commit 1225c216d954 ("vp_vdpa: allow set vq state to initial
state after reset") enabled the vp_vdpa driver to set the vq state to
the device's initial state. This works differently for split and packed
vqs.

With shadow virtqueues enabled, vhost-vdpa sets the vring base using
the VHOST_SET_VRING_BASE ioctl. The payload (vhost_vring_state)
differs for split and packed vqs. The implementation in QEMU currently
uses the payload required for split vqs (i.e., the num field of
vhost_vring_state is set to 0). The kernel throws EOPNOTSUPP when this
payload is used with packed vqs.

This patch sets the num field in the payload appropriately so vhost-vdpa
(with the vp_vdpa driver) can use packed svqs.

Link: https://lists.nongnu.org/archive/html/qemu-devel/2024-10/msg05106.html
Link: https://lore.kernel.org/r/20210602021536.39525-4-jasowang@redhat.com
Link: 1225c216d954 ("vp_vdpa: allow set vq state to initial state after reset")
Signed-off-by: Sahil Siddiq <sahilcdq@proton.me>
Acked-by: Eugenio Pérez <eperezma@redhat.com>
---
Changes v3 -> v4:
- New commit.
- vhost-vdpa.c
  (vhost_vdpa_svq_setup): Add comment.

 hw/virtio/vhost-vdpa.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
index 97ed569792..3e32874ce9 100644
--- a/hw/virtio/vhost-vdpa.c
+++ b/hw/virtio/vhost-vdpa.c
@@ -1252,6 +1252,19 @@ static bool vhost_vdpa_svq_setup(struct vhost_dev *dev,
     };
     int r;
 
+    /* In Linux, the upper 16 bits of s.num is encoded as
+       the last used idx while the lower 16 bits is encoded
+       as the last avail idx when using packed vqs. The most
+       significant bit for each idx represents the counter
+       and should be set in both cases while the remaining
+       bits are cleared. */
+    if (virtio_vdev_has_feature(dev->vdev, VIRTIO_F_RING_PACKED)) {
+        uint32_t last_avail_idx = 0 | (1 << VRING_PACKED_EVENT_F_WRAP_CTR);
+        uint32_t last_used_idx = 0 | (1 << VRING_PACKED_EVENT_F_WRAP_CTR);
+
+        s.num = (last_used_idx << 16) | last_avail_idx;
+    }
+
     r = vhost_vdpa_set_dev_vring_base(dev, &s);
     if (unlikely(r)) {
         error_setg_errno(errp, -r, "Cannot set vring base");
-- 
2.47.0


