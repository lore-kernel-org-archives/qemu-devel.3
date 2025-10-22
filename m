Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EAC8CCD1BC
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 16:41:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBbt2-0006zS-Ml; Wed, 22 Oct 2025 12:40:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1vBbsy-0006y5-KQ
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 12:40:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1vBbst-0003y2-5F
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 12:40:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761151220;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WP8uNGaD5su+WJpo/8OVK0l0XweSPWbf/VzxT8HtdGk=;
 b=gzpE6YzghODY74biV2dLgGRFGF7HKfvT9NPipEC0jcXpWKstIFbLzpTREqQuU1xG9EDYSM
 kjpZ30z4IMrd0NIz6Tzq98NgXLnrt2Km9FuaeMIq0g+LzQrdU9LwDKioaber66QxID0bRD
 yX9p7NwoaI7cZdrlYReN5xKJE+muiUg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-60-uhEDtBtGO-SkdlqeOIBXmg-1; Wed, 22 Oct 2025 12:40:17 -0400
X-MC-Unique: uhEDtBtGO-SkdlqeOIBXmg-1
X-Mimecast-MFC-AGG-ID: uhEDtBtGO-SkdlqeOIBXmg_1761151217
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-427027a2095so7248793f8f.2
 for <qemu-devel@nongnu.org>; Wed, 22 Oct 2025 09:40:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761151216; x=1761756016;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WP8uNGaD5su+WJpo/8OVK0l0XweSPWbf/VzxT8HtdGk=;
 b=hPkdsYuW31WY+5PwSJpPgXbqC/o2T7tN2ITqZtJ2igZ+qcJvLcB86FrG86Nes8760S
 hf8U35Kv2O1ErZ8HjufRbbMQi4gQJmUyDBeuzPmrW4H1mMngNdSVAzY5dKHoUNNv1VC7
 W0uHzHPwaJCrCttM7GAaAgaLB/uDodRLSv/FZ4GZ1Ge0sDVAyq9kXFstTlP+WmjvpSfl
 JgoFznxxQpMKt4SssQ9XMZwV1dPug0uufJzkcXE2I/TAVXKHsxE44VQe2iOHgyx7dSup
 IazkKdtuRCHCovXK9gUbRHQQ68ORb1+Yw7f5sPhJowaeSwbneYEEbaVhrC4qOj7Zf5Rn
 Iogw==
X-Gm-Message-State: AOJu0YzyMJWGb9NKgb3uom1WpOZA+BDu5VyJs6pMnWjFOud7yBQLHbWl
 K6KaqjSIKEkfw+IydrWFwxKvOGb0HTvKgN3BJhbq6NzsZfI8cy3E9kuEQ91X5lJNtTRBAxeufh8
 QyxZzIF2tSqGRT3CKeAFCbVViQeGbAP/gs0j6RFymc7B1uZY18SgQ02eB
X-Gm-Gg: ASbGnctOXxx/MFi4IC+r+JB+e9M4ML37esP6rNMPo0miU6mrz+RpG9ao4TQz+KWzOWU
 7Qr9c7NmaACYNG50iWw0cipNkvYEkOFS5nXCBximOl2suB43qhGJ8VZ12PLTh+2gRzR+u3GhLVC
 harIg2I0zgX1gBRtblCssSrcNumzjW+kFwqekp/4ZpgOQ5nd9HuX2AlR8chuTlG9u2sVLeRCTIK
 TeOaFJRMG5kGN50COzrvYWTUgHXR3vYI9PUXML5HHbXKbrvPvyZ93B3VPKR6BlQ8JtKz4nq4BgY
 SC21oo6hPso6iuqRNIvmpzjJGpSDL0CnZKYd1x5KeVsqrGqZEpHAWgXqdqVoOahCFnJHvPo2Pp0
 K6DVYXYoMeT+UcwY3tUFWMd11IaYk1sIFAV5FXeYdq2XG1Ll1Qp0=
X-Received: by 2002:a05:6000:25ee:b0:427:62d:132c with SMTP id
 ffacd0b85a97d-427062d135emr11806072f8f.21.1761151216645; 
 Wed, 22 Oct 2025 09:40:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHAU+86qja0NkWE0dn1DaiSbozkiGBCViNh2Bka2H1HUIzg1zR1RWEmu5HEujrbn4sEziQ8LA==
X-Received: by 2002:a05:6000:25ee:b0:427:62d:132c with SMTP id
 ffacd0b85a97d-427062d135emr11806051f8f.21.1761151216226; 
 Wed, 22 Oct 2025 09:40:16 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-153.retail.telecomitalia.it.
 [79.46.200.153]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-427f009a797sm26042291f8f.27.2025.10.22.09.40.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Oct 2025 09:40:15 -0700 (PDT)
Date: Wed, 22 Oct 2025 18:40:03 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: German Maglione <gmaglione@redhat.com>
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>,
 Eugenio Perez Martin <eperezma@redhat.com>
Subject: Re: [PATCH v2] vhost-user: make vhost_set_vring_file() synchronous
Message-ID: <ktmfrqpzytywmxxwu52kj4hn4zu75blinpumtinkfoshjtowgn@q5pqhpgffsch>
References: <20251022162405.318672-1-gmaglione@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20251022162405.318672-1-gmaglione@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Wed, Oct 22, 2025 at 06:24:05PM +0200, German Maglione wrote:
>QEMU sends all of VHOST_USER_SET_VRING_KICK, _CALL, and _ERR without
>setting the NEED_REPLY flag, i.e. by the time the respective
>vhost_user_set_vring_*() function returns, it is completely up to chance
>whether the back-end has already processed the request and switched over
>to the new FD for interrupts.
>
>At least for vhost_user_set_vring_call(), that is a problem: It is
>called through vhost_virtqueue_mask(), which is generally used in the
>VirtioDeviceClass.guest_notifier_mask() implementation, which is in turn
>called by virtio_pci_one_vector_unmask().  The fact that we do not wait
>for the back-end to install the FD leads to a race there:
>
>Masking interrupts is implemented by redirecting interrupts to an
>internal event FD that is not connected to the guest.  Unmasking then
>re-installs the guest-connected IRQ FD, then checks if there are pending
>interrupts left on the masked event FD, and if so, issues an interrupt
>to the guest.
>
>Because guest_notifier_mask() (through vhost_user_set_vring_call())
>doesn't wait for the back-end to switch over to the actual IRQ FD, it's
>possible we check for pending interrupts while the back-end is still
>using the masked event FD, and then we will lose interrupts that occur
>before the back-end finally does switch over.
>
>Fix this by setting NEED_REPLY on those VHOST_USER_SET_VRING_* messages,
>so when we get that reply, we know that the back-end is now using the
>new FD.
>
>We have a few reports of a virtiofs mount hanging:
>- https://gitlab.com/virtio-fs/virtiofsd/-/issues/101
>- https://gitlab.com/virtio-fs/virtiofsd/-/issues/133
>- https://gitlab.com/virtio-fs/virtiofsd/-/issues/213
>
>This is quite difficult bug to reproduce, even for the reporters.
>It only happens on production, every few weeks, and/or on 1 in 300 VMs.
>So, we are not 100% sure this fixes that issue. However, we think this
>is still a bug, and at least we have one report that claims this fixed
>the issue:
>
>https://gitlab.com/virtio-fs/virtiofsd/-/issues/133#note_2743209419
>
>Signed-off-by: German Maglione <gmaglione@redhat.com>
>Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
>---
> hw/virtio/vhost-user.c | 24 +++++++++++++++++++++++-
> 1 file changed, 23 insertions(+), 1 deletion(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
>index 36c9c2e04d..1605485396 100644
>--- a/hw/virtio/vhost-user.c
>+++ b/hw/virtio/vhost-user.c
>@@ -1327,8 +1327,11 @@ static int vhost_set_vring_file(struct vhost_dev *dev,
>                                 VhostUserRequest request,
>                                 struct vhost_vring_file *file)
> {
>+    int ret;
>     int fds[VHOST_USER_MAX_RAM_SLOTS];
>     size_t fd_num = 0;
>+    bool reply_supported = virtio_has_feature(dev->protocol_features,
>+                                              VHOST_USER_PROTOCOL_F_REPLY_ACK);
>     VhostUserMsg msg = {
>         .hdr.request = request,
>         .hdr.flags = VHOST_USER_VERSION,
>@@ -1336,13 +1339,32 @@ static int vhost_set_vring_file(struct vhost_dev *dev,
>         .hdr.size = sizeof(msg.payload.u64),
>     };
>
>+    if (reply_supported) {
>+        msg.hdr.flags |= VHOST_USER_NEED_REPLY_MASK;
>+    }
>+
>     if (file->fd > 0) {
>         fds[fd_num++] = file->fd;
>     } else {
>         msg.payload.u64 |= VHOST_USER_VRING_NOFD_MASK;
>     }
>
>-    return vhost_user_write(dev, &msg, fds, fd_num);
>+    ret = vhost_user_write(dev, &msg, fds, fd_num);
>+    if (ret < 0) {
>+        return ret;
>+    }
>+
>+    if (reply_supported) {
>+        /*
>+         * wait for the back-end's confirmation that the new FD is active,
>+         * otherwise guest_notifier_mask() could check for pending interrupts
>+         * while the back-end is still using the masked event FD, losing
>+         * interrupts that occur before the back-end installs the FD
>+         */
>+        return process_message_reply(dev, &msg);
>+    }
>+
>+    return 0;
> }
>
> static int vhost_user_set_vring_kick(struct vhost_dev *dev,
>-- 
>2.49.0
>


