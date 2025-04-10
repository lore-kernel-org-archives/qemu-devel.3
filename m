Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F21D3C369A6
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Apr 2025 13:46:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2sDw-0002w1-TH; Thu, 10 Apr 2025 09:45:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1u2sDm-0002mx-Nq
 for qemu-devel@nongnu.org; Thu, 10 Apr 2025 09:45:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1u2sDk-0001LG-5O
 for qemu-devel@nongnu.org; Thu, 10 Apr 2025 09:45:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744292730;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=W9DOsD21uLbA0VMGxKqTNK2oef+5UCnyF7Q5sLLk+fk=;
 b=Meztp7KRn2fG1K+kiij9Q67tuqk7MnYN/Bhvu8ndDPdToub/qZrcmWfA00NuMdLNmxh5Iq
 M2aKGLb1uh6g8VhHOqsD+ebX+1UukErmQ5QohQTQW70g8d7UxyiMeORZMxZFV3D98ziCiO
 nXQNwYdWZZbWGVM8OpYvOYt4nS4b3Kk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-lZ3lrJlGP_uN8PqX0Ih1uA-1; Thu, 10 Apr 2025 09:45:27 -0400
X-MC-Unique: lZ3lrJlGP_uN8PqX0Ih1uA-1
X-Mimecast-MFC-AGG-ID: lZ3lrJlGP_uN8PqX0Ih1uA_1744292726
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43cf172ff63so6447635e9.3
 for <qemu-devel@nongnu.org>; Thu, 10 Apr 2025 06:45:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744292725; x=1744897525;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W9DOsD21uLbA0VMGxKqTNK2oef+5UCnyF7Q5sLLk+fk=;
 b=CO5o7mmD4KVdsaNiy241yvlyg3KgsJBP1VJrAQ3hh8yFV7yddfZLlsuiWv4paKsVxe
 tACXXXD+7DhLy3/dkNqXUiyRMOZb33SRGSWZB04UzqfYbqz5i2QvpCvn79L1RKiGSjCK
 tbKD6BWjfGj0dhxsNHIiQAdTPyiZiEgnzrvIGtvR9H7h05J/i/2yNP8u/RtcWjD4GYFF
 XEDCO1Y2WEOVIvcIOZNlEsSpzwmcISEuj9ksUGVxzS5tAfMiEc627iZZ/sznyRaUHpr7
 8FD9pcEDU12uAIUrL4xq2fO64aYmiWczArdz7GXXRJgFmjnedJWqjZXR4P9gbI7SQynu
 2EnQ==
X-Gm-Message-State: AOJu0Yyg/h9Csumywf/WXLFbnWzITg/6dV9StzOOtMejBwb7SFFMhrpH
 BZ9MIye6qgA9Sxr/4Ue1/EA3Ng2ExRJgN8YQOiuK4AgeNPS7nauI/M4qcv/sPoB5X90HUNle0oQ
 /7scmx7VO5aa5jmQXdvpVk7b5tuP0uWs+viO+EEoHluOdmE3vWzsSZ63+Dqyi
X-Gm-Gg: ASbGncujddY4l0OAfmEz47ssPJXyx/ZGj4o7ijgBy9VnYd0DmC2YwgtFUPmVpvQeZvY
 GY2gSMC9+vSeX4HY1JNJA1XWXLzxp9XKNb8DWCqnKHQEazxFargpI7w9JcWMcyC7v7UMW9GISns
 R9DfPLxnGCY4eMafR8ueq/BMqV1GbID0YmiyieyetwbfJd6PYcp2L4utbjOk6+t+G88AaS50ofp
 FXn47DjdKay7BqE6okuYqXGxPVu/+teMnCjhlyjytGsqZ+Uj5DkjCYa3mWzwJMY09bkqdEnQfv6
 /Be8CA==
X-Received: by 2002:a05:600c:1c87:b0:43c:f1b8:16ad with SMTP id
 5b1f17b1804b1-43f2d9a12acmr31753445e9.30.1744292725293; 
 Thu, 10 Apr 2025 06:45:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFpWyIekgAfRJHRTLktDnfA2jiOhV/0Z23LKsoiWLwBf+foczHchXBm4WGlPaeOR2RV30zwGA==
X-Received: by 2002:a05:600c:1c87:b0:43c:f1b8:16ad with SMTP id
 5b1f17b1804b1-43f2d9a12acmr31753235e9.30.1744292724874; 
 Thu, 10 Apr 2025 06:45:24 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43f206269c8sm57945505e9.16.2025.04.10.06.45.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Apr 2025 06:45:24 -0700 (PDT)
Date: Thu, 10 Apr 2025 09:45:21 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: qemu-devel@nongnu.org, devel@daynix.com, qemu-stable@nongnu.org
Subject: Re: [PATCH] virtio: Call set_features during reset
Message-ID: <20250410094119-mutt-send-email-mst@kernel.org>
References: <20250410-reset-v1-1-751cd0064395@daynix.com>
 <20250410034550-mutt-send-email-mst@kernel.org>
 <ece28e1e-ea85-4247-b2b1-54fbd8d2ce37@daynix.com>
 <20250410035935-mutt-send-email-mst@kernel.org>
 <d387d721-a5fc-4661-8a3b-576c34780398@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d387d721-a5fc-4661-8a3b-576c34780398@daynix.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.593,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, Apr 10, 2025 at 05:26:47PM +0900, Akihiko Odaki wrote:
> On 2025/04/10 17:02, Michael S. Tsirkin wrote:
> > On Thu, Apr 10, 2025 at 04:54:41PM +0900, Akihiko Odaki wrote:
> > > On 2025/04/10 16:48, 'Michael S. Tsirkin' via devel wrote:
> > > > On Thu, Apr 10, 2025 at 04:42:06PM +0900, Akihiko Odaki wrote:
> > > > > virtio-net expects set_features() will be called when the feature set
> > > > > used by the guest changes to update the number of virtqueues. Call it
> > > > > during reset as reset clears all features and the queues added for
> > > > > VIRTIO_NET_F_MQ or VIRTIO_NET_F_RSS will need to be removed.
> > > > > 
> > > > > Fixes: f9d6dbf0bf6e ("virtio-net: remove virtio queues if the guest doesn't support multiqueue")
> > > > > Buglink: https://issues.redhat.com/browse/RHEL-73842
> > > > > Cc: qemu-stable@nongnu.org
> > > > > Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> > > > 
> > > > The issue seems specific to virtio net: rset is reset,
> > > > it is distict from set features.
> > > > Why not just call the necessary functionality from virtio_net_reset?
> > > 
> > > set_features is currently implemented only in virtio-net; virtio-gpu-base
> > > also have a function set but it only has code to trace. If another device
> > > implements the function in the future, I think the device will also want to
> > > have it called during reset for the same reason with virtio-net.
> > > 
> > > virtio_reset() also calls set_status to update the status field so calling
> > > set_features() is more aligned with the handling of the status field.
> > 
> > That came to be because writing 0 to status resets the virtio device.
> > For a while, this was the only way to reset vhost-user so we just
> > went along with it.
> 
> It is possible to have code to send a command to write 0 to status to
> vhost-user in reset(), but calling set_status() in virtio_reset() is more
> convenient and makes sense as the status is indeed being set to 0. I think
> the same reasoning applies to features.

I don't know who makes assumptions that features are only set during
driver setup, though.
This will send an extra VHOST_USER_SET_FEATURES message for vhost-user,
for example.
I want to have a good reason to add this overhead.

> > 
> > 
> > > > 
> > > > 
> > > > > ---
> > > > >    hw/virtio/virtio.c | 86 +++++++++++++++++++++++++++---------------------------
> > > > >    1 file changed, 43 insertions(+), 43 deletions(-)
> > > > > 
> > > > > diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> > > > > index 85110bce3744..033e87cdd3b9 100644
> > > > > --- a/hw/virtio/virtio.c
> > > > > +++ b/hw/virtio/virtio.c
> > > > > @@ -2316,49 +2316,6 @@ void virtio_queue_enable(VirtIODevice *vdev, uint32_t queue_index)
> > > > >        }
> > > > >    }
> > > > > -void virtio_reset(void *opaque)
> > > > > -{
> > > > > -    VirtIODevice *vdev = opaque;
> > > > > -    VirtioDeviceClass *k = VIRTIO_DEVICE_GET_CLASS(vdev);
> > > > > -    int i;
> > > > > -
> > > > > -    virtio_set_status(vdev, 0);
> > > > > -    if (current_cpu) {
> > > > > -        /* Guest initiated reset */
> > > > > -        vdev->device_endian = virtio_current_cpu_endian();
> > > > > -    } else {
> > > > > -        /* System reset */
> > > > > -        vdev->device_endian = virtio_default_endian();
> > > > > -    }
> > > > > -
> > > > > -    if (k->get_vhost) {
> > > > > -        struct vhost_dev *hdev = k->get_vhost(vdev);
> > > > > -        /* Only reset when vhost back-end is connected */
> > > > > -        if (hdev && hdev->vhost_ops) {
> > > > > -            vhost_reset_device(hdev);
> > > > > -        }
> > > > > -    }
> > > > > -
> > > > > -    if (k->reset) {
> > > > > -        k->reset(vdev);
> > > > > -    }
> > > > > -
> > > > > -    vdev->start_on_kick = false;
> > > > > -    vdev->started = false;
> > > > > -    vdev->broken = false;
> > > > > -    vdev->guest_features = 0;
> > > > > -    vdev->queue_sel = 0;
> > > > > -    vdev->status = 0;
> > > > > -    vdev->disabled = false;
> > > > > -    qatomic_set(&vdev->isr, 0);
> > > > > -    vdev->config_vector = VIRTIO_NO_VECTOR;
> > > > > -    virtio_notify_vector(vdev, vdev->config_vector);
> > > > > -
> > > > > -    for(i = 0; i < VIRTIO_QUEUE_MAX; i++) {
> > > > > -        __virtio_queue_reset(vdev, i);
> > > > > -    }
> > > > > -}
> > > > > -
> > > > >    void virtio_queue_set_addr(VirtIODevice *vdev, int n, hwaddr addr)
> > > > >    {
> > > > >        if (!vdev->vq[n].vring.num) {
> > > > > @@ -3169,6 +3126,49 @@ int virtio_set_features(VirtIODevice *vdev, uint64_t val)
> > > > >        return ret;
> > > > >    }
> > > > > +void virtio_reset(void *opaque)
> > > > > +{
> > > > > +    VirtIODevice *vdev = opaque;
> > > > > +    VirtioDeviceClass *k = VIRTIO_DEVICE_GET_CLASS(vdev);
> > > > > +    int i;
> > > > > +
> > > > > +    virtio_set_status(vdev, 0);
> > > > > +    if (current_cpu) {
> > > > > +        /* Guest initiated reset */
> > > > > +        vdev->device_endian = virtio_current_cpu_endian();
> > > > > +    } else {
> > > > > +        /* System reset */
> > > > > +        vdev->device_endian = virtio_default_endian();
> > > > > +    }
> > > > > +
> > > > > +    if (k->get_vhost) {
> > > > > +        struct vhost_dev *hdev = k->get_vhost(vdev);
> > > > > +        /* Only reset when vhost back-end is connected */
> > > > > +        if (hdev && hdev->vhost_ops) {
> > > > > +            vhost_reset_device(hdev);
> > > > > +        }
> > > > > +    }
> > > > > +
> > > > > +    if (k->reset) {
> > > > > +        k->reset(vdev);
> > > > > +    }
> > > > > +
> > > > > +    vdev->start_on_kick = false;
> > > > > +    vdev->started = false;
> > > > > +    vdev->broken = false;
> > > > > +    virtio_set_features_nocheck(vdev, 0);
> > > > > +    vdev->queue_sel = 0;
> > > > > +    vdev->status = 0;
> > > > > +    vdev->disabled = false;
> > > > > +    qatomic_set(&vdev->isr, 0);
> > > > > +    vdev->config_vector = VIRTIO_NO_VECTOR;
> > > > > +    virtio_notify_vector(vdev, vdev->config_vector);
> > > > > +
> > > > > +    for (i = 0; i < VIRTIO_QUEUE_MAX; i++) {
> > > > > +        __virtio_queue_reset(vdev, i);
> > > > > +    }
> > > > > +}
> > > > > +
> > > > >    static void virtio_device_check_notification_compatibility(VirtIODevice *vdev,
> > > > >                                                               Error **errp)
> > > > >    {
> > > > > 
> > > > > ---
> > > > > base-commit: 825b96dbcee23d134b691fc75618b59c5f53da32
> > > > > change-id: 20250406-reset-5ed5248ee3c1
> > > > > 
> > > > > Best regards,
> > > > > -- 
> > > > > Akihiko Odaki <akihiko.odaki@daynix.com>
> > > > 
> > 


