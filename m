Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1312FCD98D2
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2026 19:11:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYqDG-0007cv-BD; Sun, 14 Jun 2026 15:09:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYqCV-00075d-G7
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:08:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYqCU-0002Mk-5Q
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:08:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781464133;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+5IDvjHpbpqRVslTo52DM6RFiRL2u3ldzUfX7cVrHQM=;
 b=RRdsm1v2B0SnCXczhMo2fMiUHm4KkJLxa7Q5rbEyV56cZn0XxsfDwF0sXjX7j6FGh7ebFH
 A/NFVosz228/8aiTjEFBTAtum6r+kE7cnvL8RG9SoktlNWXHFDW7ePFSP9mmPHEWE8B6ob
 1zXeFGQAFIWaVkKPAnPC3/SeDXY2T0c=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-RVkU-ZjtP52rV1XSGfQjtA-1; Sun, 14 Jun 2026 15:08:51 -0400
X-MC-Unique: RVkU-ZjtP52rV1XSGfQjtA-1
X-Mimecast-MFC-AGG-ID: RVkU-ZjtP52rV1XSGfQjtA_1781464130
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-45efa2f7009so1710306f8f.3
 for <qemu-devel@nongnu.org>; Sun, 14 Jun 2026 12:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781464130; x=1782068930; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=+5IDvjHpbpqRVslTo52DM6RFiRL2u3ldzUfX7cVrHQM=;
 b=DFBBH+NCskbBl8EXciOpXX5buQgqBwcqBiews3gBpKuxna1TvqGANVIuPfReaGFab5
 ZTn4pOXcxXH4aWySm/KoM1qqeWFvpZw6+oWLA/Lge+7q2xYPSlho2Ika6eF5G4qKhwGj
 gd7ipmFshZOwurMoazo7shNQdR81m0DB1ip+1/tdoxmcm4UOAB0DQ8RnV5WVt5kYN13A
 giSPkaZkCYrnRI4iaBjsRq0XzoKGtck3NSonm/Jy9J59EAGr4i8sT9mOL2SNrGz0Vsxh
 ugrGB7XLudYSf3yvyujtt45IAR/jml/Kq8IMg/FGgohpGcDAtR2phUOuwCSHN84M1aWr
 DNMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781464130; x=1782068930;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+5IDvjHpbpqRVslTo52DM6RFiRL2u3ldzUfX7cVrHQM=;
 b=LqK2HTG3VLqSP3/tCSMtXiIgJxRy55cReHlgTQRF8fvzM1gP46TETdCBBVAayZ5R28
 +OsRs28BjajB69LOQRdFOpYLXlP1VQAINU0Xw4VI/tHrB+8wvKXqr8IyXH3v8PZpqN/9
 ZV7faWr3l5fVzwL9B6Jqn8WHmz/d7N/Gn3vPoFB41CkFTCd1ilgJprFbGJMmUnd4H5Cl
 NThUXY++HCXjuN5O6bJpj90cQPoB0g5EdRmVkM0tWyrfAh9HdMrl6LmcyOiR0e7PT6xj
 3UfdCu1eP33pyzf83qIYljYS/f1OglYM3eihUSPteu1pWKLIkgXWkg65baSG6qPrt3hi
 Qy6w==
X-Gm-Message-State: AOJu0Yx+nSiVMJvA/s17t7E4ZNE1QjRxXkYpnPVFq9h2d4iwA2sfVYpw
 suawoyUln/ckrYbMQFnO01pUvEzsht7UhpiZMLC1v/hxfhLXJ0lao578M3raNyBWhaMy+AJtSeD
 abwlAwCoRV+rriBZnuhVI8m9QN+WtLXSiuPnZ/vsmjc+jf/RATaJ0vynf8Ml416ttR4/tb2EYKv
 7DuCerh9UnQ72qXjNVv5zG/Qj2t+RP03Pxkg==
X-Gm-Gg: Acq92OHEx6qimlcPRHhDG9NCDI/7VujC5b5MLXMkyWwbDgu4BjqlTq5CGKLJ42wvFgz
 vqkH9PYtvNOBvINa09FwYVn1Q1UidsyNKkOGTGm3kcguqITJOeb1CscqJMwN801iJlnQVicciIk
 +pfVkyTVnGvMva81uyBBan8TftyJelyre0MosDnyZdom6QlH97e1F9VU1L1kXFIlShFaX5owais
 2vSk9ZxiV/cl6HK3cLLIRLKzYXoB8+Gii6+4K4M+2R3NH853+1DTuHbwIsL8RsOuCP5A7N+b7EL
 mhcdzDIUihNPsx2IlhFm8kv6r0u6LS6lHn4TxLV5GHQm1nbxbHvoJw2O4On+WazhB3U1xkiOTbJ
 1xtLKhVrmPxrMZ4UVI9cUIF7wYlJ2JlP3e/nbjov+fs8=
X-Received: by 2002:a05:600c:1790:b0:48a:8b02:ae91 with SMTP id
 5b1f17b1804b1-49220092ec4mr53592005e9.11.1781464130351; 
 Sun, 14 Jun 2026 12:08:50 -0700 (PDT)
X-Received: by 2002:a05:600c:1790:b0:48a:8b02:ae91 with SMTP id
 5b1f17b1804b1-49220092ec4mr53591845e9.11.1781464129863; 
 Sun, 14 Jun 2026 12:08:49 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49220368ef4sm181995035e9.12.2026.06.14.12.08.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jun 2026 12:08:49 -0700 (PDT)
Date: Sun, 14 Jun 2026 15:08:47 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>
Subject: [PULL 072/106] virtio: Allow to fill a whole virtqueue in order
Message-ID: <eceff0982f97cc79a26883b93f8eac05cd126dd8.1781463125.git.mst@redhat.com>
References: <cover.1781463125.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1781463125.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Eugenio Pérez <eperezma@redhat.com>

As the while steps < max_steps is already one less than the vq size, the
right maximum max_steps variable is queue length, not the maximum
possible remainder of % vq->vring.num.

Fixes: b44135daa37 ("virtio: virtqueue_ordered_fill - VIRTIO_F_IN_ORDER support")
Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20260304173535.2702587-2-eperezma@redhat.com>
---
 hw/virtio/virtio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index fb7f7f0f06..ed58c1af9f 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -986,7 +986,7 @@ static void virtqueue_ordered_fill(VirtQueue *vq, const VirtQueueElement *elem,
      * We shouldn't need to increase 'i' by more than or equal to
      * the distance between used_idx and last_avail_idx (max_steps).
      */
-    max_steps = (vq->last_avail_idx - vq->used_idx) % vq->vring.num;
+    max_steps = MIN(vq->last_avail_idx - vq->used_idx, vq->vring.num);
 
     /* Search for element in vq->used_elems */
     while (steps < max_steps) {
-- 
MST


