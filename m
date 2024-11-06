Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC3E1D44D57
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2024 14:34:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8h6I-0000kz-Hi; Wed, 06 Nov 2024 09:33:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1t8h6H-0000ko-7p
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 09:33:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1t8h6C-0003RR-9P
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 09:33:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730903610;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nYVz4WHzKuIDywknJPbvynxHfIQPuvY/No+LgULDrBs=;
 b=dphtqaLI9kbZLwNlm0NcW1/jWn0vefsYdsMOsyMFCINsSEtggxDntozyT9w//0B5xO2PrN
 I/1ZP6onduz5eWIixRFmLXfbMAOhz6epijDVy/h6nAv9H+eGguzK3kzS+7QaiXCcv5h5CU
 Z2cgkdT15EYQuxq3GrSrEfqB6Hsyunc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-hSJ3Lg9bOUKF25M5YKumQw-1; Wed, 06 Nov 2024 09:33:29 -0500
X-MC-Unique: hSJ3Lg9bOUKF25M5YKumQw-1
X-Mimecast-MFC-AGG-ID: hSJ3Lg9bOUKF25M5YKumQw
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4315afcae6cso5972335e9.0
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2024 06:33:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730903608; x=1731508408;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nYVz4WHzKuIDywknJPbvynxHfIQPuvY/No+LgULDrBs=;
 b=ElsFA8qjbV9OwKAB53ziDTqAwCcGyTk1Bgp+6D4QEoIO9dgG5zh+kBoPi0QkODOjXb
 m7Xvs0jV+cYPm07nStTuuMTh/OcILP5oF6CNQzWFvCpCberzwp25FOmTis9n8DWy/hFR
 5O/uKIEoEnv2acUaglwvSlVF6ijwdbU7EQma0S6jnwvbRKxEqWAYpgIoe5nF5NFmZ2Ay
 faVA1qqiWZ4ym0IauktMrP2zEcMnbun7E3YRh1YUt5UiKZITNm4kyl1/s/+TlkSrdoxZ
 RpPHJpyYpLdJ56pwR0NRfMls56rCVNno0jh0rsQMdVowgjF9Ulbm2c4S4MgEWzEUjI5L
 m55Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCX0bWkIDI0Ehb7W25lMMQaxW2kQi8vFWNHONe9WM22C8FRAG/Z3NbRPyXYeb5cQ51ScjxjOKiXtEJQK@nongnu.org
X-Gm-Message-State: AOJu0Yx/U7qGPMH7F0m7gR+tkHTjl3zyOzo57dVePbNKJF7ryoxHCIJa
 LKb/eikIrzvjb38ABhpiV3nZyaWQw3vWySaxPJy5AET/vDmI2Vukd/5GE6abfUZTJFdBKkufBMA
 +glwNeKDabZTtfkSfIOHhtqYZjEl2NJjzK6PNpL8G4GqORBrBKB8T
X-Received: by 2002:a05:600c:3c96:b0:431:57cf:f13d with SMTP id
 5b1f17b1804b1-432a9a7567fmr25056325e9.3.1730903607817; 
 Wed, 06 Nov 2024 06:33:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEFFLYwnBy+09SPcf1izsuc6zu2Aw0zP23BQR41THYsrnSLwNoQfAL8s9Hq9AnmqOYST9V3JA==
X-Received: by 2002:a05:600c:3c96:b0:431:57cf:f13d with SMTP id
 5b1f17b1804b1-432a9a7567fmr25056015e9.3.1730903607176; 
 Wed, 06 Nov 2024 06:33:27 -0800 (PST)
Received: from sgarzare-redhat ([5.77.86.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432aa5b5b7fsm25334485e9.4.2024.11.06.06.33.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Nov 2024 06:33:26 -0800 (PST)
Date: Wed, 6 Nov 2024 15:33:21 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Sahil Siddiq <icegambit91@gmail.com>
Cc: eperezma@redhat.com, mst@redhat.com, qemu-devel@nongnu.org, 
 Sahil Siddiq <sahilcdq@proton.me>
Subject: Re: [PATCH] vdpa: Support setting vring_base for packed svq
Message-ID: <pu5razer3dkaltyuwiav236sepob44mj6cmigskdcet7davn4t@6orjjrzeqtau>
References: <20241104162124.49867-1-sahilcdq@proton.me>
 <k2suxbt2qy7ewjrlozlkzrhsa7bbf7xrze33outna65dejuus2@eamj5pdkvpkw>
 <77bc1be1-e4b3-46a0-a263-cc8f7d6e28fe@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <77bc1be1-e4b3-46a0-a263-cc8f7d6e28fe@gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Nov 05, 2024 at 08:24:17PM +0530, Sahil Siddiq wrote:
>Hi,
>
>Thank you for the review.
>
>On 11/5/24 3:06 PM, Stefano Garzarella wrote:
>>On Mon, Nov 04, 2024 at 09:51:24PM +0530, Sahil Siddiq wrote:
>>>Linux commit v5.14-rc1~30^2~8 enabled the vp_vdpa driver to set the
>>
>>To refer to a commit, please use the SHA-1 id or even better the form
>>suggested in
>>https://www.kernel.org/doc/html/latest/process/submitting-patches.html#describe-your-changes
>>
>>So in this case I'd use:
>>Linux commit 1225c216d954 ("vp_vdpa: allow set vq state to initial state
>>after reset")
>
>Understood, I'll change this in v2.
>
>>>vq state to the device's initial state. This works differently for
>>>split and packed vqs.
>>>
>>>With shadow virtqueues enabled, vhost-vdpa sets the vring base using
>>>the VHOST_SET_VRING_BASE ioctl. The payload (vhost_vring_state)
>>>differs for split and packed vqs. The implementation in QEMU currently
>>>uses the payload required for split vqs (i.e., the num field of
>>>vhost_vring_state is set to 0). The kernel throws EOPNOTSUPP when this
>>>payload is used with packed vqs.
>>>
>>>This patch sets the num field in the payload appropriately so vhost-vdpa
>>
>>I'm not very familiar with shadow virtqueue, so can you elaborate what
>>"appropriately" means here?
>
>My understanding is that the ioctl and the payload themselves are not
>directly related to shadow virtqueues [1]. They concern virtqueues in general.
>
>In QEMU's implementation, hw/virtio/vhost-vdpa.c:vhost_vdpa_svq_setup [2]
>is called from hw/virtio/vhost-vdpa.c:vhost_vdpa_svqs_start [3] only when
>shadow virtqueues are enabled.
>
>QEMU's vhost-user doc [1] states that the payload for the VHOST_SET_VRING_BASE
>ioctl is different for split and packed vqs. The struct is the same:
>
>struct vhost_vring_state {
>	unsigned int index;
>	unsigned int num;
>};
>
>The num field takes a different value depending on the virtqueue's format
>(split vs packed). The explanation below throws more light on this.
>
>>>(with the vp_vdpa driver) can use packed svqs.
>>>
>>>Link: https://lists.nongnu.org/archive/html/qemu-devel/2024-10/msg05106.html
>>>Link: https://lore.kernel.org/r/20210602021536.39525-4-jasowang@redhat.com
>>>Signed-off-by: Sahil Siddiq <sahilcdq@proton.me>
>>>---
>>>QEMU currently does not support packed vhost shadow virtqueues. I am
>>>working on adding support for packed svqs [1]. The test environment
>>>that I am using [2] requires vhost-vdpa to use the relevant payload
>>>when setting vring base.
>>>
>>>[1] https://wiki.qemu.org/Internships/ProjectIdeas/PackedShadowVirtqueue
>>>[2] https://www.redhat.com/en/blog/hands-vdpa-what-do-you-do-when-you-aint-got-hardware-part-2
>>>
>>>hw/virtio/vhost-vdpa.c | 4 ++++
>>>1 file changed, 4 insertions(+)
>>>
>>>diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
>>>index 3cdaa12ed5..5f81945109 100644
>>>--- a/hw/virtio/vhost-vdpa.c
>>>+++ b/hw/virtio/vhost-vdpa.c
>>>@@ -1230,6 +1230,10 @@ static bool vhost_vdpa_svq_setup(struct vhost_dev *dev,
>>>    };
>>>    int r;
>>>
>>>+    if (virtio_vdev_has_feature(dev->vdev, VIRTIO_F_RING_PACKED)) {
>>>+        s.num = 0x80008000;
>>
>>Why this magic value?
>>
>>Looking at the kernel code it looks like we are assgining 0x8000 for
>>both last_avail_idx and last_used_idx, but why 0x8000?
>>
>>Thanks,
>>Stefano
>>
>
>When I boot a VM with packed=on and x-svq=true, QEMU sets the vring base
>using VHOST_SET_VRING_BASE. I used ftrace to trace the functions in the
>linux kernel and got the following trace:
>
>[...]
>qemu-system-x86-1737    [001] ...1.  3613.371358: vhost_vdpa_unlocked_ioctl <-__x64_sys_ioctl
>qemu-system-x86-1737    [001] ...1.  3613.371358: vhost_vring_ioctl <-vhost_vdpa_unlocked_ioctl
>qemu-system-x86-1737    [001] ...1.  3613.371362: vp_vdpa_set_vq_state <-vhost_vdpa_unlocked_ioctl
>[...]
>
>In the kernel, drivers/vhost/vhost.c:vhost_vring_ioctl [4] uses
>the vhost_vring_state payload to set the last_avail_idx. For
>packed vqs, it also sets last_used_idx.
>
>    vq->last_avail_idx = s.num & 0xffff;
>    vq->last_used_idx = (s.num >> 16) & 0xffff;
>
>These values are used to populate a new struct vdpa_vq_state in
>drivers/vhost/vdpa.c:vhost_vdpa_vring_ioctl [5].
>
>    vq_state.packed.last_avail_idx = vq->last_avail_idx & 0x7fff;
>    vq_state.packed.last_avail_counter = !!(vq->last_avail_idx & 0x8000);
>    vq_state.packed.last_used_idx = vq->last_used_idx & 0x7fff;
>    vq_state.packed.last_used_counter = !!(vq->last_used_idx & 0x8000);
>
>The following check is then made in drivers/vdpa/virtio_pci/vp_vdpa.c:
>vp_vdpa_set_vq_state_packed [6]:
>
>    if (packed->last_avail_counter == 1 &&
>        packed->last_avail_idx == 0 &&
>        packed->last_used_counter == 1 &&
>        packed->last_used_idx == 0)
>        return 0;
>    return -EOPNOTSUPP;
>
>The most significant bit in 0x8000 is used to set the wrap counters.
>All the other bits are 0 and so the avail and used idx are also set
>to 0.

Thanks for these great details!

Okay, so IIUC the only configuration that vp_vdpa supports when 
VHOST_SET_VRING_BASE is called is idx == 0 and wrap_couter = true for 
both avail and used.

Is this okay with QEMU shadow vq? (More a question for Eugenio).


About the magic value, IMHO we should explain it in the code adding a 
comment, and maybe use VRING_PACKED_EVENT_F_WRAP_CTR, something like we 
do in virtqueue_init() in drivers/virtio/virtio_ring.c in Linux:

     uint32_t last_used_idx = 0 | (1 << VRING_PACKED_EVENT_F_WRAP_CTR);
     uint32_t last_avail_idx = 0 | (1 << VRING_PACKED_EVENT_F_WRAP_CTR);

     s.num = (last_used_idx << 16) | last_avail_idx;

WDYT?

Thanks,
Stefano


