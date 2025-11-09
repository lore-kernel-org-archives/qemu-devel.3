Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85BB5CCFA1A
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Nov 2025 14:37:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vI6Vy-0002DM-UM; Sun, 09 Nov 2025 09:35:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vI6Vx-0002Cw-Mu
 for qemu-devel@nongnu.org; Sun, 09 Nov 2025 09:35:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vI6Vw-0001oH-1D
 for qemu-devel@nongnu.org; Sun, 09 Nov 2025 09:35:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762698931;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qEti7Ogz8rb9NG0Hkns7Wvi5D2MMh1SqCQoP/RLdhF4=;
 b=UJ9hME6zcuV2+2b+P5UGmOdYgL2at2ZGJxl/5mgbc9PuZ1Gl7+DPjg7Vs05j8NFoqyAqM0
 NuzUpRe1fPFf/SW6h3tANqAXlwOFlF8rcWTYJaLsyunyV8Ao2PW8b1EIgqjuMytc1b1/I5
 oL45F4UbLcKYmVj6AGvcXjJ9QWfUNXo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-110-BE_6j9uLO72nSS7-ut20Ng-1; Sun, 09 Nov 2025 09:35:29 -0500
X-MC-Unique: BE_6j9uLO72nSS7-ut20Ng-1
X-Mimecast-MFC-AGG-ID: BE_6j9uLO72nSS7-ut20Ng_1762698928
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-429cbed2b8fso1057388f8f.1
 for <qemu-devel@nongnu.org>; Sun, 09 Nov 2025 06:35:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1762698928; x=1763303728; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=qEti7Ogz8rb9NG0Hkns7Wvi5D2MMh1SqCQoP/RLdhF4=;
 b=Jo7jPyNN6bu88SYWpCXZRuDKs3pr5orA6GIIguJlgo+HG/8fQUktozJx6M6uc2ZOZZ
 zwd0i2ISRXmBXhX3QZU8Ab7x+ihHvyobvZxCkNCugt2tTd10jYvkq04jU3AHexhMafmc
 zgIqr6/7wsfWmkR7pLuOe+AEAjShEGdhKoxpcG6ed92gluxqSLsLrAW3JwicWbeZZIjQ
 +gEzOwf1PYJm5+RvBKfnXx0SFLZRS6268MsLH1dHM7QmUpXXuH1IUJWk1dQIXNCyyaJ0
 mTUanjsvI+cb8wc9ij51eH5MiBe5Kx8HtJ286RL2a0Qd3QDJV3ihrzEC+8aqgn+acLsb
 T3cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762698928; x=1763303728;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qEti7Ogz8rb9NG0Hkns7Wvi5D2MMh1SqCQoP/RLdhF4=;
 b=KjDh/wDAgJ8BFfHQZbQQyFmpZev5qR12CAje1X1o/PQ5zggZAGyZ8a9aL/rgWcWAN+
 85M5E1uFaG7GG1BERwObfbqXH/f0VG19uBRFGnG1iD9DGDdPVtZTAOVo9TXtGw7Ob1z6
 TMaIVTG3XZM/LLj3ggts009ZtPwn2k5hE46VHM3cMmeB25rOFjuhqvtQUz+RE1qy4UMD
 HlM13MA0YYbMrsoZYbbHyt88gV5vGPz9Cpjoy7UANWApLCymTSxO+60VmUhH+pvmCRiL
 FfKT3i8h2LtNtxzXo0+fE0YJLyxA1MyUgslDC4WG8kSBLGndbvzLbt9YUBU5/ZXPnD/F
 xjsQ==
X-Gm-Message-State: AOJu0YwBhAXwtRDr9PY7m/u7VAGXYRXo/BxvV237mDn2SDMmblnWAvH1
 WLa4YqLXEv+SaWFpGTdsY1chikljNcQlpsnN3B40hKMChjzbCQNRw456tQK456zdZnRcoyZYbPs
 O62oV9Tmzf7+4yJbKO+8IpIMKvNTtSLRbyoWbsDAAlf82Yjrld6OzyQhZhRgnVG7CBmpVORHfRC
 iSRL3MhzkQJrxwfymoBLyTN0ucsepN8g3DXg==
X-Gm-Gg: ASbGnctw8hoy5oa/GC+frhOSpprYbAqA1iGPB3AsxgRXRby55YLuOsXPH6awTHmBfdz
 pqTDSNJTMMxwlfdhPzjg9qBH6kD673Fx71OHNXcyAwc2Ozwz2tWyohIoWgcNTORsC/5O9lXl9D5
 e/mWkNNZGsblmNOWq739YhHqzu+Gtsqsl4F/m+6F4P9O4d4NrQSjALZAM08J2QYhIXZEAW0FcGd
 bMfQsNSDQ8MHXDN+0dcuFzhBARX/2LursZeRdJhrVgoJLwf7wlwRs9QraYGkUimMQpzOadCiNeh
 7VkrD4UsA94Zd59SI2wUVAOyvf2rylZjTyLZC4mfkSmapSVGMdRp0RrifjLxy7gIJRQ=
X-Received: by 2002:a05:6000:2b05:b0:42b:3023:66be with SMTP id
 ffacd0b85a97d-42b30236929mr2584623f8f.32.1762698927536; 
 Sun, 09 Nov 2025 06:35:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEpjVxelPkLoe9A0H7b3V2vdn1iAiCkblwTe6HkdSI+gKgsH90Ujvlm6fNcM4uTvnOBQXp8OA==
X-Received: by 2002:a05:6000:2b05:b0:42b:3023:66be with SMTP id
 ffacd0b85a97d-42b30236929mr2584603f8f.32.1762698927013; 
 Sun, 09 Nov 2025 06:35:27 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1536:2700:9203:49b4:a0d:b580])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42b2f7a0512sm9050632f8f.18.2025.11.09.06.35.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Nov 2025 06:35:26 -0800 (PST)
Date: Sun, 9 Nov 2025 09:35:25 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 German Maglione <gmaglione@redhat.com>, Hanna Czenczek <hreitz@redhat.com>,
 Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PULL 08/14] vhost-user: make vhost_set_vring_file() synchronous
Message-ID: <1ba9a5220325dd5260a0c37b6299ce38364a5120.1762698873.git.mst@redhat.com>
References: <cover.1762698873.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1762698873.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: German Maglione <gmaglione@redhat.com>

QEMU sends all of VHOST_USER_SET_VRING_KICK, _CALL, and _ERR without
setting the NEED_REPLY flag, i.e. by the time the respective
vhost_user_set_vring_*() function returns, it is completely up to chance
whether the back-end has already processed the request and switched over
to the new FD for interrupts.

At least for vhost_user_set_vring_call(), that is a problem: It is
called through vhost_virtqueue_mask(), which is generally used in the
VirtioDeviceClass.guest_notifier_mask() implementation, which is in turn
called by virtio_pci_one_vector_unmask().  The fact that we do not wait
for the back-end to install the FD leads to a race there:

Masking interrupts is implemented by redirecting interrupts to an
internal event FD that is not connected to the guest.  Unmasking then
re-installs the guest-connected IRQ FD, then checks if there are pending
interrupts left on the masked event FD, and if so, issues an interrupt
to the guest.

Because guest_notifier_mask() (through vhost_user_set_vring_call())
doesn't wait for the back-end to switch over to the actual IRQ FD, it's
possible we check for pending interrupts while the back-end is still
using the masked event FD, and then we will lose interrupts that occur
before the back-end finally does switch over.

Fix this by setting NEED_REPLY on those VHOST_USER_SET_VRING_* messages,
so when we get that reply, we know that the back-end is now using the
new FD.

We have a few reports of a virtiofs mount hanging:
- https://gitlab.com/virtio-fs/virtiofsd/-/issues/101
- https://gitlab.com/virtio-fs/virtiofsd/-/issues/133
- https://gitlab.com/virtio-fs/virtiofsd/-/issues/213

This is quite difficult bug to reproduce, even for the reporters.
It only happens on production, every few weeks, and/or on 1 in 300 VMs.
So, we are not 100% sure this fixes that issue. However, we think this
is still a bug, and at least we have one report that claims this fixed
the issue:

https://gitlab.com/virtio-fs/virtiofsd/-/issues/133#note_2743209419

Fixes: 5f6f6664bf24 ("Add vhost-user as a vhost backend.")
Signed-off-by: German Maglione <gmaglione@redhat.com>
Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
Reviewed-by: Eugenio Pérez <eperezma@redhat.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20251022162405.318672-1-gmaglione@redhat.com>
---
 hw/virtio/vhost-user.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 4b0fae12ae..63fa9a1b4b 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -1327,8 +1327,11 @@ static int vhost_set_vring_file(struct vhost_dev *dev,
                                 VhostUserRequest request,
                                 struct vhost_vring_file *file)
 {
+    int ret;
     int fds[VHOST_USER_MAX_RAM_SLOTS];
     size_t fd_num = 0;
+    bool reply_supported = virtio_has_feature(dev->protocol_features,
+                                              VHOST_USER_PROTOCOL_F_REPLY_ACK);
     VhostUserMsg msg = {
         .hdr.request = request,
         .hdr.flags = VHOST_USER_VERSION,
@@ -1336,13 +1339,32 @@ static int vhost_set_vring_file(struct vhost_dev *dev,
         .hdr.size = sizeof(msg.payload.u64),
     };
 
+    if (reply_supported) {
+        msg.hdr.flags |= VHOST_USER_NEED_REPLY_MASK;
+    }
+
     if (file->fd > 0) {
         fds[fd_num++] = file->fd;
     } else {
         msg.payload.u64 |= VHOST_USER_VRING_NOFD_MASK;
     }
 
-    return vhost_user_write(dev, &msg, fds, fd_num);
+    ret = vhost_user_write(dev, &msg, fds, fd_num);
+    if (ret < 0) {
+        return ret;
+    }
+
+    if (reply_supported) {
+        /*
+         * wait for the back-end's confirmation that the new FD is active,
+         * otherwise guest_notifier_mask() could check for pending interrupts
+         * while the back-end is still using the masked event FD, losing
+         * interrupts that occur before the back-end installs the FD
+         */
+        return process_message_reply(dev, &msg);
+    }
+
+    return 0;
 }
 
 static int vhost_user_set_vring_kick(struct vhost_dev *dev,
-- 
MST


