Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05895CCD1AB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 13:58:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBZMB-0006XP-OA; Wed, 22 Oct 2025 09:58:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1vBZM8-0006X9-Ji
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 09:58:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1vBZM5-0001GG-3x
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 09:58:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761141499;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kosnzVeJl5a+NqVLPv+iQ7jTMMFnmYdBYAblzR8xE60=;
 b=enL0CDR3xEfj5omEquHMW9c1ry9zhrHJ3vhE074UjU7BSZRs9XhF2WKiZKXLRwAeSO3OSx
 bJB4DQ7SofsAF5V0xmtAvnGCGUHE/W7xxLS0C3Amjn9XaZzYpoIJXEx1x0iq6jfR/kb2RP
 TDDUV89Vxub9maniTgf8a6WWS+/UHi8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-275-yeCZEsyAMcSUnK-A8SduRQ-1; Wed, 22 Oct 2025 09:58:17 -0400
X-MC-Unique: yeCZEsyAMcSUnK-A8SduRQ-1
X-Mimecast-MFC-AGG-ID: yeCZEsyAMcSUnK-A8SduRQ_1761141497
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3ece0fd841cso3067149f8f.0
 for <qemu-devel@nongnu.org>; Wed, 22 Oct 2025 06:58:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761141496; x=1761746296;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kosnzVeJl5a+NqVLPv+iQ7jTMMFnmYdBYAblzR8xE60=;
 b=UD5jGAuD4Vre7wSKFvQoRsWDGzod7Y2jI5SiSwNl1XV8Y4Qt5djQ6bP9M1ifcY8RW5
 SkSgznGSpTqIgFiLo+0LyD3K8MPb+DKb2IoFFnZuc9JoyIAytF6SN3QxNqEoyuSw2Vfg
 mo+nDrQq1lyRDjTZhDACwLqULk9a/81/tve7blWHEvRXscHnmq7AhjjXlUrWO7gHmRbE
 KSjvdPqsILLI+iJrixOh/WDOsBaktZIcp8Ar9DIUxXNWLqNI7bGzO1MuOg1jm/8aYeZ1
 Ja1nXhzdR6WF5i/jWU3q4befOEGXtfPZsavr/+UityDVKsYhNTXPiBwbsgzJmmCJ3eND
 A0Pg==
X-Gm-Message-State: AOJu0YxGOGPmgPSg1TNiVJ1FaikQAtXlLgCY57QADM6RoLYYbk5nY5Gl
 eASpr0nEF9ZpgQ2ZKYsK+pwMAMRFCQkX5sfxeBC0fpe71/z3H0MuFreyOBrqhh8DCaGUED6rFKh
 5HMExzRcDTKjYV4WzeoQf37x6XE086xkH20d4fCrPWD8Ypa6lbBNUIOdR
X-Gm-Gg: ASbGncvfdz5a9NxYUbUAEEbmR3KOaGhTdjVVsvQX1BUK95oq7sPbULELppoSC4xZ/Fy
 GGcAZtiGJYHChXEADGFD2kOYvakj8b8t/i9ziwGNlihcBn5SKgpx48B4xFKjEzxFS7CiI3UXUMk
 /FFX82bPR0jW0trZnorZVYxwIdCzf0/2lRBztB+vNbhGuTHr+btzndCJ6i4hFtxJCuZ57m1sVEF
 mF/oSyft4vfae5AnAHNE+xKkAEJh6oUOLvTGUSsOgIB0VwfxXSn3rB4CpUHr82dRWYQ4JWi/FX1
 kifXPxQcdwltsuE/aPV7uEd6Ba+0okES0Cacd6rHC5Q7+BCxyylylkHRGmcgo3jNIzW+hnE3jpk
 OHNjyeb2rrin1wA2qDJMh6sR/hF7KFKS8H3vxQwBK0/+aDWzXOKA=
X-Received: by 2002:a05:6000:40df:b0:3ec:42ad:591 with SMTP id
 ffacd0b85a97d-42704d9899emr16154657f8f.36.1761141496632; 
 Wed, 22 Oct 2025 06:58:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IECpW9zeVxFCJomMJBciQWI5DVgK7gp/nuODHm1fDPER2Onkphu5pQ1jE9nLg/a5fOwxlCEAA==
X-Received: by 2002:a05:6000:40df:b0:3ec:42ad:591 with SMTP id
 ffacd0b85a97d-42704d9899emr16154632f8f.36.1761141496194; 
 Wed, 22 Oct 2025 06:58:16 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-153.retail.telecomitalia.it.
 [79.46.200.153]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-427e1be5d6csm25096143f8f.0.2025.10.22.06.58.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Oct 2025 06:58:15 -0700 (PDT)
Date: Wed, 22 Oct 2025 15:58:11 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: gmaglione@redhat.com
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>, 
 Eugenio Perez Martin <eperezma@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] Make vhost_set_vring_file() synchronous
Message-ID: <lvktcgd5f6je5awxgueawbdl5rrjx5iurnxrz3etnnb27257l7@n3tuwrvrmot5>
References: <20251022133228.301365-1-gmaglione@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20251022133228.301365-1-gmaglione@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
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

If you need to resend, please add a `vhost-user: ` prefix in the title.

On Wed, Oct 22, 2025 at 03:32:28PM +0200, gmaglione@redhat.com wrote:
>From: German Maglione <gmaglione@redhat.com>
>
>QEMU sends all of VHOST_USER_SET_VRING_KICK, _CALL, and _ERR without
>setting the NEED_REPLY flag, i.e. by the time the respective
>vhost_user_set_vring_*() function returns, it is completely up to chance
>whether whether the back-end has already processed the request and
  ^
There is an extra "whether" here.

>switched over to the new FD for interrupts.
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

IIUC this is related to an issue discovered in virtiofsd, should we put 
a link to that?

>
>Signed-off-by: German Maglione <gmaglione@redhat.com>
>Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
>---
> hw/virtio/vhost-user.c | 18 +++++++++++++++++-
> 1 file changed, 17 insertions(+), 1 deletion(-)
>
>diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
>index 36c9c2e04d..641960293b 100644
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
>@@ -1336,13 +1339,26 @@ static int vhost_set_vring_file(struct vhost_dev *dev,
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

What about adding a comment here that summarizes the excellent 
description of this commit?

BTW all minor comments, the fix LGTM:

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

Thanks,
Stefano

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


