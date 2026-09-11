Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC387C88E50
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 09:14:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4xBi-0000bB-Rz; Fri, 11 Sep 2026 05:04:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4xBD-0007Ni-R4
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 05:04:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4xBC-0008Ua-26
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 05:04:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789117457;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HnLpK+N89F2XPAWPb6Tl/ZpnNhALrwGevG6SaIgN5js=;
 b=IJVO5GctvLCRiDaxYTflBMsknTBjPUiS0KQR7qDeKOay5Xl1VQKTBI+HvlRyra5pj6CgaZ
 hBAd71BSX7w8rmWahqjHHF+L9WUXnq9789OUpwe7rRTzSBUt266Y276lwzL0sEWDz/Fn8h
 WF4HLRPX7+kdxX4hLQ/y/AUmgf3a01E=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-IpZtiYwXM1ykJIqCmAqnpw-1; Fri, 11 Sep 2026 05:04:16 -0400
X-MC-Unique: IpZtiYwXM1ykJIqCmAqnpw-1
X-Mimecast-MFC-AGG-ID: IpZtiYwXM1ykJIqCmAqnpw_1789117455
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-49cd83ca361so6766945e9.1
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2026 02:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789117455; x=1789722255; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=HnLpK+N89F2XPAWPb6Tl/ZpnNhALrwGevG6SaIgN5js=;
 b=FeUlAqlTV0fCTCfk2nwfIODi/aZ5UhNMiadWh1Up6DaiK7t+dnaTmrLTe0ryMvJm8z
 pd/HJ6tWut4m5d11aADTNPNubflQzMO4qEKsV+TIX5us5Dt5hcpqjqu74DDXAW1sQ+dV
 ndPJJf4tYPsrHwrfWe9BSKW8C0uk3NksfXOmLrqJAXB82qqc9TW+9ywtKLHbZR6LVnlt
 YWl5El8t019vc9XU5/ggDqEaxybmC0gGuJ+bY9tjnKIs+BJGDLMF3VsEDapY+p6B6E0I
 kNfGtH5SbV+h/FI66BAtrodFFmXDZWS7/spHm+q9Ix4ZhpnkB6JznqH+L+5aym/SES1F
 DUyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789117455; x=1789722255;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=HnLpK+N89F2XPAWPb6Tl/ZpnNhALrwGevG6SaIgN5js=;
 b=Jc7sJ+Q0nSFIqVgNHIVpJCuMkqaecIzMUhpWrWEv9z5v4qQjnJsoaauKMg9yDG+4Td
 lgS3bsRvFynvD+VA2baA5BLmYftp+lWcVQLW8ANmCWBQEICNCHr4wVrJSdDyEL8xGaPT
 lKhX6IGmuxjvUP8OiWb2kLQd0+y4smBK3zz+Irz9Rv2bG2DOtcB77sbtskhCpixTwFwL
 55nlxpBdwS07uBrewSxKZpsf4WAZvWsb7iURX6U/+FP3ESAdSKQ9b3KkL6V8/x3CL6dP
 ZVqdCQ3DY8oY9c/R10uApiC0mW/I0RIMnFnD3T0CKrlDYgYNCVE7xA78WC9lLubxZqOG
 dlhQ==
X-Gm-Message-State: AFuF++k3PKXhhqC3kD9wWH0Vi0UYl2+tBB9TyPFOzJZ+us0xgvtwIz7t
 HfggRVPud0fmFBIr4pOhPZ6mkZMVRoQn8ttdugWYIzjItoeo350XryWVUl657fecRWnsAd9xqfM
 pFpkqJgSw5Hs6A+r1WuqKgl2683srEdcPx9W+DKZHa6hjgXo1gcwy2xNP4pc6S1PQ3GYv0lwDxd
 o7a0n/3ypf7+ASM/b8INQ3N5BwERy1NZ88XQ==
X-Gm-Gg: AYBFou3mNCCQ1cZybo3k94Kyk0F8cK+gqKqBeKTsKv+acidmORY6ryqsrOQpfkep1NC
 QD7g4U5cjposAL2IW8mts7u7EV6dU8s8/DEO5sFBB2dBxaNJ3kgv+C8BGeN3UbiMSDrIGzrurMz
 m3F+avUo3JepMss5xF6BesNi/r5rRF47q6RryTF1CLVb1DuGklFU/fjlri39VTbTDYw7ch3gHqG
 cXCxL3HAL5wF8b2qCv4pQwbmCrtpk4BUQ5vOVOYjrYgljR/xZ3YwNvH8VC0e9grWHIfeWgeSTJy
 sILsMf9fCCJel615+y2Nj6g2ucBOpqCawfda6/SnV8eMnsGsbQf7DLJ0xNWi0xCeyrKlsCfaDk0
 NpyKt9L3hZ394u6A/07F69t0=
X-Received: by 2002:a05:600d:6414:10b0:49c:fc6c:be16 with SMTP id
 5b1f17b1804b1-49e619c64cfmr24063085e9.28.1789117454756; 
 Fri, 11 Sep 2026 02:04:14 -0700 (PDT)
X-Received: by 2002:a05:600d:6414:10b0:49c:fc6c:be16 with SMTP id
 5b1f17b1804b1-49e619c64cfmr24062605e9.28.1789117454200; 
 Fri, 11 Sep 2026 02:04:14 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e62227071sm31429585e9.3.2026.09.11.02.04.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 02:04:13 -0700 (PDT)
Date: Fri, 11 Sep 2026 05:04:12 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alexandr Moshkov <dtalexundeer@yandex-team.ru>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PULL v2 71/75] vhost-user: use skip_drain with
 GET_VRING_BASE_SKIP_DRAIN message
Message-ID: <226544a5fd4b4c40a45a318942cb998e1fa39e19.1789117222.git.mst@redhat.com>
References: <cover.1789117222.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1789117222.git.mst@redhat.com>
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

From: Alexandr Moshkov <dtalexundeer@yandex-team.ru>

Wire up the skip_drain parameter introduced in the previous commit to
the new GET_VRING_BASE_SKIP_DRAIN message. When skip_drain is set,
send GET_VRING_BASE_SKIP_DRAIN instead of GET_VRING_BASE, instructing
the back-end to suspend in-flight I/O immediately.

Signed-off-by: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260803072853.2920007-4-dtalexundeer@yandex-team.ru>
---
 hw/virtio/vhost.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 7294d3c42a..68a8e40481 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1521,7 +1521,11 @@ static int do_vhost_virtqueue_stop(struct vhost_dev *dev,
     }
 
     if (!force) {
-        r = dev->vhost_ops->vhost_get_vring_base(dev, &state);
+        if (!skip_drain) {
+            r = dev->vhost_ops->vhost_get_vring_base(dev, &state);
+        } else {
+            r = dev->vhost_ops->vhost_get_vring_base_skip_drain(dev, &state);
+        }
         if (r < 0) {
             VHOST_OPS_DEBUG(r, "vhost VQ %u ring restore failed: %d", idx, r);
         }
-- 
MST


