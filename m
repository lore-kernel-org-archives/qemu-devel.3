Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F05AAC5516D
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2026 08:59:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpj4w-00010W-Eq; Fri, 31 Jul 2026 04:58:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wpj4u-0000zl-RW
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 04:58:52 -0400
Received: from mail-yx1-xb133.google.com ([2607:f8b0:4864:20::b133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wpj4s-0006Qx-V4
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 04:58:52 -0400
Received: by mail-yx1-xb133.google.com with SMTP id
 956f58d0204a3-6679d88abdcso959189d50.2
 for <qemu-devel@nongnu.org>; Fri, 31 Jul 2026 01:58:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785488329; cv=none;
 d=google.com; s=arc-20260327;
 b=czzFPaqz62v+Ysy74iL51hyD1O9kaguEOuUlMKWGAEuibMQfRnlH9nfIp2yhW1jATe
 rRwqvWaczxiw7Wu7Vytir14qp463dWw4RsG7eQQ4iCEhkkoOIFLCvt0rgq7UrrlRLdOC
 c0Ll0mp1KyL85pIInQwu1FF8wYXwdPWjjHUjH9BZrMnDtG0KWhN15Kmlc6OzDaJxH14i
 zSWbw/XFhlsuGPPC4Z695InT7XzAsO+ZV5jS7WkbL/YBNFVy5RYvLx02sKeUlsa1bCSH
 N3f+yTl7smbltd34NVeyOmhPlMPgMYAOuuyRstipXLvdTgdLGzmTEy6YAQdyqRKEdyGx
 tCqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=cjzJ3LqOhhqUQuv3Ul2oRa8Rsc/LKEczqA8n96bIPVM=;
 fh=Yl+iNZ7S1Pp6aV5bTwkL5eTB1LNUnCRlxbaofhjMwNE=;
 b=FbKYYvd/C9KeX2jfa3eB5sGQzcFXpL7cMVSnECKkTO6G7PeyltGjIDzGwpq3rctpYO
 PbVhMJXEOJewodoGMo1Tqyio8+i/r2y3ixxBz5m2ETLEa8Md1+weBm989p9oOqAn2p4n
 OzDI1UYM6Jmx7/FarBSwXHHY47AhDcC7j5ctTQ78UDWmTrG8S8njMpItmNc0iiZOhB9J
 yu40BlqVIofgM2016CrXyW3YdcRzdzInu4oYjoz34l/AUJfryOeaHPzM0x8xX3vxjcK9
 x4GTbUNIcqPamR8hv8bj5RHS+NMD+oSZQVPELgqZbr/no+3uoT2ZtMhbcTtfihq4SCII
 3w8w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785488329; x=1786093129; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=cjzJ3LqOhhqUQuv3Ul2oRa8Rsc/LKEczqA8n96bIPVM=;
 b=DFNznq5juPvXHslGHxjI+xv83t/tn6wZAZVvPxQKBZE4AaOori49B8iBa0IQJ9sqqW
 /OsoSgrVMz0faDm2xdVWh1K60+I+6URYc5NpeETnIVGBkyAOhEKIJnhipvQyJtnAIGZA
 I9fkYs8JTKdPHZsJG7kIzhpNCYO8Svg/Qd/Q+uan7x+3cwe6LwbwrZzORiV6UUALCIMf
 KbvEihB+T6yYISIAgYgRgYR2jDEeLAMAvqA1INws8to86GT4PJoMY16LNPJuPDrsPINR
 cpnP3zKOIQ1BtA2JeMbaioXAGJEZcU/FdF6fGxbpTp34WsqInREzAK+Zi0L4XePwM3Lw
 QCyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785488329; x=1786093129;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=cjzJ3LqOhhqUQuv3Ul2oRa8Rsc/LKEczqA8n96bIPVM=;
 b=eYkdL2sZALoH8fsQDqd7N+deuSBZQ+kjAn6yxgjT3uAulLod2ynOVqdE9nOjWHd4xQ
 RZWG7k8JfWTPOX3NRBlYotglo3C9JgETXcQOOtZ6sny8URNYzeay2LnL6iWFkVheJ61l
 OiVKIswcX+263yACSdVQ7KxwOgucc8kZA7vq5DdpKd0mFcLJccRSrpytyFhA9gT/0Bs5
 7A4f+wFcbNttMSnBsWylEFM+O9JHwlmonLKq4dwCNmRoetXByRtVOz4lH1boBLJ+M1aT
 P5pYos9v5DwMTtNRHHlc6u3HSWTTXXdO6kxkomFktGUfbhLvdIp9wlihtUK8gnRyp99p
 2P4g==
X-Gm-Message-State: AOJu0YxSOxcXN66BSbEoNVilMo4bsC28K6HHteu7IZpEf37KFbPhQceP
 vd3PsDVqlCbmQ8u1ojkGRwvBxwDB9cpPaQki5FeMRe0km8PMesmfqQLUXXSv1ip32QLhvEdHbGn
 9Q3glkDTRoCisPAC7UBZJnmrR9YrVc5Q9GnO3UNkQcQ==
X-Gm-Gg: AR+sD12B6LNpiX/UafkAr8ap8SA2HDvZgGooudGodsSCaZXz9+lNNYn0Vq5GF9kWPp4
 Bsq9RpVVQyV9sZMeZQES2pxT14Whu82VYw0D/04Lm7BkktwoN1HMTWewprkEnPMBkne12ScQ6au
 MCNzvjcGnQrj/74Ur2ZowfoFjkR4X2ka7oHxbb7RPkHOLk/9z5mpVATnJktRlqQg/ujrlzXjKWF
 rxZJXXZn/DiLxd/7+0Zj6PB5CkCZRjwrHbsbzssbvOe3GemXGJnKzsxWKqgi2UJXCwZ8WO4qjCW
 hw/MGIQ3jaKOQyQxJi+XwNH2wZBgjXNQBaHirnCD3BiPza9i+Xl0jk5plo09F6dCcw2FA/h4RRk
 gtR9SzMbUhmAP3x8gHl/EXuhqRtuh
X-Received: by 2002:a53:b45d:0:b0:668:2e46:41b5 with SMTP id
 956f58d0204a3-669454aac14mr548397d50.47.1785488329163; Fri, 31 Jul 2026
 01:58:49 -0700 (PDT)
MIME-Version: 1.0
References: <20260730205846.19479-1-stefanha@redhat.com>
 <20260730205846.19479-3-stefanha@redhat.com>
In-Reply-To: <20260730205846.19479-3-stefanha@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 31 Jul 2026 09:58:36 +0100
X-Gm-Features: AUfX_mxlzeSqCJD9cOWoq3g9Vs2ibL5edy5Gf9kCAY7YrqrYTBrtlQ6XwJUMXPM
Message-ID: <CAFEAcA9Opun4GED3TGoJB-tDKFy=70raJxRK9gSSe7booz-vaQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] virtio: use Error for queue size validation in
 virtio_add_queue()
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 virtio-fs@lists.linux.dev, Hanna Reitz <hreitz@redhat.com>, 
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Milan Zamazal <mzamazal@redhat.com>, 
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Dorjoy Chowdhury <dorjoychy111@gmail.com>, 
 "Gonglei (Arei)" <arei.gonglei@huawei.com>, Alexander Graf <graf@amazon.com>, 
 Laurent Vivier <lvivier@redhat.com>, Jason Wang <jasowangio@gmail.com>, 
 David Hildenbrand <david@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-block@nongnu.org, 
 Greg Kurz <groug@kaod.org>, Raphael Norwitz <rnorwitz@nvidia.com>,
 Eric Auger <eric.auger@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, Kuan-Wei Chiu <visitorckw@gmail.com>,
 Amit Shah <amit@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b133;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb133.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, 30 Jul 2026 at 21:59, Stefan Hajnoczi <stefanha@redhat.com> wrote:
>
> Coverity is unhappy with the code path where the x-override-queue-size
> property value is passed to g_new0() since it is a signed int rather
> than an unsigned int:
>
>       *** CID 1664271:         Error handling issues  (NEGATIVE_RETURNS)
>       /builds/qemu-project/qemu/hw/virtio/virtio.c: 2595             in virtio_add_queue()
>       2589         }
>       2590
>       2591         vdev->vq[i].vring.num = queue_size;
>       2592         vdev->vq[i].vring.num_default = queue_size;
>       2593         vdev->vq[i].vring.align = VIRTIO_PCI_VRING_ALIGN;
>       2594         vdev->vq[i].handle_output = handle_output;
>       >>>     CID 1664271:         Error handling issues  (NEGATIVE_RETURNS)
>       >>>     "__n" is passed to a parameter that cannot be negative.
>       2595         vdev->vq[i].used_elems = g_new0(VirtQueueElement, queue_size);
>
> Introduce an Error **errp argument to virtio_add_queue() and set it when
> the queue_size argument or the x-override-queue-size property value are
> invalid.
>
> At the moment none of the callers propagate the Error object. Instead
> they are all modified to pass &error_abort so that the error message is
> printed and the program terminates (it also terminated before). Further
> work, especially in new device emulation code, could actually propagate
> the Error object but is left for the future.



> diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
> index bf64d1231a8..4045414cd2f 100644
> --- a/hw/scsi/virtio-scsi.c
> +++ b/hw/scsi/virtio-scsi.c
> @@ -1317,10 +1317,13 @@ void virtio_scsi_common_realize(DeviceState *dev,
>      s->sense_size = VIRTIO_SCSI_SENSE_DEFAULT_SIZE;
>      s->cdb_size = VIRTIO_SCSI_CDB_DEFAULT_SIZE;
>
> -    s->ctrl_vq = virtio_add_queue(vdev, s->conf.virtqueue_size, ctrl);
> -    s->event_vq = virtio_add_queue(vdev, s->conf.virtqueue_size, evt);
> +    s->ctrl_vq = virtio_add_queue(vdev, s->conf.virtqueue_size, ctrl,
> +                                  &error_abort);
> +    s->event_vq = virtio_add_queue(vdev, s->conf.virtqueue_size, evt,
> +                                   &error_abort);

The virtqueue_size here is user-settable via the device property,
and the realize function only checks that it is at least 2, not
for any upper bound. So this one at least ought ideally to be
propagating the error up. Still, this is no worse than the
previous situation, where we abort() inside virtio_add_queue().

thanks
-- PMM

