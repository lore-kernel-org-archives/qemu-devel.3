Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 966C9C25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2024 08:40:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7Wed-0002Rq-3c; Thu, 16 May 2024 04:39:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1s7Web-0002Rd-3r
 for qemu-devel@nongnu.org; Thu, 16 May 2024 04:39:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1s7WeZ-0003Qc-6f
 for qemu-devel@nongnu.org; Thu, 16 May 2024 04:39:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715848793;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SMTHGr/euSTgO5iAJxhkflTxXrFCHDUczHZ7F4Fcy3Y=;
 b=VgBqw6My9/maZiRnGAa3HD3nVfGKogfW5btj3kwhvTBiWSuyuNsFMnJsj+zYHIOohnQqsA
 dtXwCj9LNdx5KAchRid+ACBf9saQ6MEfnbbtHV3T7iOv3tgtZ6TPxzucaxo5YuimqvFK/J
 DB9K3G98BbHnnMFKD1qeib5u5ILA7N4=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-oICw74qPO9as1GOKCrcvlQ-1; Thu, 16 May 2024 04:39:52 -0400
X-MC-Unique: oICw74qPO9as1GOKCrcvlQ-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-5236c5cec7dso2719222e87.2
 for <qemu-devel@nongnu.org>; Thu, 16 May 2024 01:39:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715848789; x=1716453589;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SMTHGr/euSTgO5iAJxhkflTxXrFCHDUczHZ7F4Fcy3Y=;
 b=KUnHVvAv/VdicX1Jwymt8PB8OKyhaqAKFtZsCLX2ZYNT7ctygZJkUhfLPRq4rfe3j/
 HKme6hqFWc6XE3F8r2K9XKB/elbpxfu8A6Faz+p1i7yZuUO1AkcVYNqraPbe5DcPPLCm
 XmIpumYRb1dyIHbFXiQEnSSpopQK7LDIcwDoi/IKBY7dCsxABDeHZZYy+d6v54tdibz/
 rJdo6YJ1P4/eIKCZWYMcfOBAd7wETAYvIOxp8PR9UPsIzeDCddzXhgkI2QjnEHfbmRiB
 N44OUp/IdxO4HisTM0idmzLW40VWlr1Yew9aWKHahvP0M5Z22N+k0+Dtlg0VAr+HWwof
 DySw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWHeQvEI3UkZQP6NyDfKpWR/AfF1Z1+M9MjBBAhevDY/2IgavJGe9zz7xQnFXByhH9WTj8mezXqq9EaETFA/ZpCv87l0E8=
X-Gm-Message-State: AOJu0Yy8fB1qIRZFpBuMXLFY0X1L4/KX9WP3pZyTtKniBZqk5Q/M30Kd
 q5e9VZWlZxqjDPUS3Xxz0JuVsuc+vUL8Z8H/ZwastKasF/V/WB2BY6sGvZw8trYw/mIvrzPIQbh
 xxq+Szdw2PUT4VGFNGREYl49QjZIu4DXHmn+Al6n3r8sCqmfRQqdf
X-Received: by 2002:a05:6512:1321:b0:523:93e8:1cf3 with SMTP id
 2adb3069b0e04-52393e820a7mr5068753e87.51.1715848789455; 
 Thu, 16 May 2024 01:39:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHfEx0RHxifTwVNr4ZkIs/fNfoNN8Dy5gCNSgTbekrn221TCIvvvUKtKDj+UMqiAUp+JGl+6A==
X-Received: by 2002:a05:6512:1321:b0:523:93e8:1cf3 with SMTP id
 2adb3069b0e04-52393e820a7mr5068658e87.51.1715848786996; 
 Thu, 16 May 2024 01:39:46 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-25-77.business.telecomitalia.it.
 [87.12.25.77]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-574ea5d755bsm3179016a12.51.2024.05.16.01.39.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 May 2024 01:39:46 -0700 (PDT)
Date: Thu, 16 May 2024 10:39:42 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Halil Pasic <pasic@linux.ibm.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, 
 Marc Hartmayer <mhartmay@linux.ibm.com>, Jason Wang <jasowang@redhat.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Boris Fiuczynski <fiuczy@linux.ibm.com>
Subject: Re: [PATCH 1/1] vhost-vsock: add VIRTIO_F_RING_PACKED to feaure_bits
Message-ID: <ps5dukcjk6yh3an3hlkynr227r7kcln7b5dxgwope62avz5ceo@decy6vkuu56j>
References: <20240429113334.2454197-1-pasic@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20240429113334.2454197-1-pasic@linux.ibm.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.935,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Apr 29, 2024 at 01:33:34PM GMT, Halil Pasic wrote:
>Not having VIRTIO_F_RING_PACKED in feature_bits[] is a problem when the
>vhost-vsock device does not offer the feature bit VIRTIO_F_RING_PACKED
>but the in QEMU device is configured to try to use the packed layout
>(the virtio property "packed" is on).
>
>As of today, the  Linux kernel vhost-vsock device does not support the
>packed queue layout (as vhost does not support packed), and does not
>offer VIRTIO_F_RING_PACKED. Thus when for example a vhost-vsock-ccw is
>used with packed=on, VIRTIO_F_RING_PACKED ends up being negotiated,
>despite the fact that the device does not actually support it, and
>one gets to keep the pieces.
>
>Fixes: 74b3e46630 ("virtio: add property to enable packed virtqueue")
>Reported-by: Marc Hartmayer <mhartmay@linux.ibm.com>
>Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
>---
>
>This is a minimal fix, that follows the current patterns in the
>codebase, and not necessarily the best one.

Yeah, I did something similar with commit 562a7d23bf ("vhost: mask 
VIRTIO_F_RING_RESET for vhost and vhost-user devices") so I think for 
now is the right approach.

I suggest to check also other devices like we did in that commit (e.g.  
hw/scsi/vhost-scsi.c, hw/scsi/vhost-user-scsi.c, etc. )

>
>I don't quite understand why vhost_get_features() works the way
>it works. Fortunately it is documented, so let me quote the
>documentation.
>
>"""
>/**
> * vhost_get_features() - return a sanitised set of feature bits
> * @hdev: common vhost_dev structure
> * @feature_bits: pointer to terminated table of feature bits
> * @features: original feature set
> *
> * This returns a set of features bits that is an intersection of what
> * is supported by the vhost backend (hdev->features), the supported
> * feature_bits and the requested feature set.
> */
>uint64_t vhost_get_features(struct vhost_dev *hdev, const int *feature_bits,
>                            uint64_t features);
>"""
>
>Based on this I would expect the following statement to be true: if a
>feature bit is not in feature_bits then the corresponding bit in the
>return value is guaranteed to be not set (regardless of the values of
>the 3rd arguments and hdev->features).
>
>The implementation however does the following: if the feature bit is not
>listed in feature_bits (2nd argument) then the corresponding bit in the
>return value is set iff the corresponding bit in the 3rd argument
>(features) is set (i.e. it does not matter what hdev->features and thus
>the vhost backend says).
>
>The documentation however does kind of state, that feature_bits is
>supposed to contain the supported features. And under the assumption
>that feature bit not in feature_bits implies that the corresponding bit
>must not be set in the 3rd argument (features), then even with the
>current implementation we do end up with the intersection of the three
>as stated. And then vsock would be at fault for violating that
>assumption, and my fix would be the best thing to do -- I guess.
>
>Is the implementation the way it is for a good reason, I can't judge
>that with certainty for myself.

Yes, I think we should fix the documentation, and after a few years of 
not looking at it I'm confused again about what it does.

But re-reading my commit for VIRTIO_F_RING_RESET, it seems that I had 
interpreted `feature_bits` (2nd argument) as a list of features that 
QEMU doesn't know how to emulate and therefore are required by the 
backend (vhost/vhost-user/vdpa). Because the problem is that `features` 
(3rd argument) is a set of features required by the driver that can be 
provided by both QEMU and the backend.

>
>But I'm pretty convinced that the current approach is fragile,
>especially for the feature bits form the range 24 to 40, as those are
>not specific to a device.
>
>BTW vsock also lacks VIRTIO_F_ACCESS_PLATFORM, and VIRTIO_F_RING_RESET
>as well while vhost-net has both.

VIRTIO_F_RING_RESET is just above the line added by this patch.

>
>If our design is indeed to make the individual devices responsible for
>having a complete list of possible features in feature_bits, then at
>least having a common macro for the non-device specific features would
>make sense to me.

Yeah, I agree on this!

>
>On the other hand, I'm also very happy to send a patch which changes the
>behavior of vhost_get_features(), should the community decide that the
>current behavior does not make all that much sense -- I lean towards:
>probably it does not make much sense, but things like
>VIRTIO_F_ACCESS_PLATFORM, which are mandatory feature bits, need careful
>consideration, because there vhost can't do so we just won't offer it
>and proceed on our merry way is not the right behavior.
>
>Please comment!

Maybe we should discuss it in another thread, but I agree that we should 
fix it in someway. Thank you for raising this discussion!

>
>Regards,
>Halil
>---
> hw/virtio/vhost-vsock-common.c | 1 +
> 1 file changed, 1 insertion(+)

This patch LGTM, but as I mention we should fix other devices as well,
but maybe we can do with the common macro you suggested in another 
patch.

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/hw/virtio/vhost-vsock-common.c b/hw/virtio/vhost-vsock-common.c
>index 12ea87d7a7..fd88df2560 100644
>--- a/hw/virtio/vhost-vsock-common.c
>+++ b/hw/virtio/vhost-vsock-common.c
>@@ -22,6 +22,7 @@
> const int feature_bits[] = {
>     VIRTIO_VSOCK_F_SEQPACKET,
>     VIRTIO_F_RING_RESET,
>+    VIRTIO_F_RING_PACKED,
>     VHOST_INVALID_FEATURE_BIT
> };
>
>
>base-commit: fd87be1dada5672f877e03c2ca8504458292c479
>-- 
>2.40.1
>
>


