Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02AA9C53219
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 23:23:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wor8Q-0003se-Qa; Tue, 28 Jul 2026 19:22:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wor8P-0003sN-GW
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 19:22:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wor8O-0002D1-0n
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 19:22:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785280971;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jcEG/1WekdiDcEugRjB6HpFz7LXnxpDlrbH+l78OfH4=;
 b=OQB1QofF35bcH9JdcoERXZB/8nQamKgTaGtOwnYGjYsf4DG39kzw3WO5PJpgGobeut6asO
 X2K66WA3LTT5TGE4Ya5nXTpIYSv3rxhzhK892Qo9/I5GaWgKWqZuDRADQQIG8OtjjBwAI2
 IH80PInqLJXVPsCRUHOG2/wmlayP9Q4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-382-oI4rYbzNMYegL1g7IvgQxw-1; Tue, 28 Jul 2026 19:22:49 -0400
X-MC-Unique: oI4rYbzNMYegL1g7IvgQxw-1
X-Mimecast-MFC-AGG-ID: oI4rYbzNMYegL1g7IvgQxw_1785280969
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4954b1c6310so2987225e9.0
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 16:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785280968; x=1785885768; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=jcEG/1WekdiDcEugRjB6HpFz7LXnxpDlrbH+l78OfH4=;
 b=XjP0OAm3xcLGGonPdNod6JHsSVkqBpGldPjHr2V+huVTwGWNqjth4LPTstVzudvaGx
 FPWYKBoFHrNYTpnjN0SxyOATa7/fj7V0WWSrtAzXGJvzjR7+y2lvciJPzwrwUudtKHgr
 RmRakh8FjMefRfKMFEObun8J1q1IWYlBfXDQ1EhnyA2XBcqZCokQGSpj8w9Kt0Gz0wyt
 4YtBdkZidG6hdbjDGcJQrBkWrNMOMH6/EOtmcUq4oVIC5MWVun8Nhon6Y55DITz/RNSC
 foCeNGAHCvTuN3RID7Ynb2RbgI9XeB7jwMlzl51PejyUbm59BCAYsI9Gu1SNhEx+aVm5
 xEpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785280968; x=1785885768;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=jcEG/1WekdiDcEugRjB6HpFz7LXnxpDlrbH+l78OfH4=;
 b=BPWS5SnOQf1Znrn82r2gUVcLA+JgXj3Ae4flegZmyy9X7j8RhnLdorzumjrNA0VApx
 DUyWp9eiMeCuPIPoC716KT4O4G+Va4ZQnHRn5yl9lA8fwVB2a3hp8iwxKZ0D3ixupe1J
 Mytbc54sWBbW1MROYpQ7xCTBodsm4NnAIf9hS+DfiUDcwVTlVhCrdwYBRbyILC8RPi7H
 XwK2f3JeC1Ig+HWHbVeHICFMJ6EcBjX2SMQB/6GcnMJ18NJHFbEwzLffDodfji9i1zv3
 gHOKUBobB0gu4mijiCeo8z7JQSKswHtpCl0HV8fm4VfpXRF8fS4xGfpizqybA39Z0JSU
 8ISA==
X-Gm-Message-State: AOJu0Yw+kVWkzXmFyh8ywh+i3b1aTpzMhZCa2qfe0yaplNwQFv96KYXP
 L0h7Vq8lMRYkVkkY3+JwsJHjhl6cHV5GT2PiBAxKaz/qDhZ3or7xQD1nqypVC9BOFs+V7jU+nHX
 Op1FILK5imtDROd9PHPnGTdpdvjcr6Rm5+pKpFBCIfKaJ01BLFmbhQpvO
X-Gm-Gg: AR+sD12KujiqNyqMU7CIti82RBPUmn3+SbctwuAlKIaep8aWSrs/I+JbFPzdrqtE8ax
 mOKjfMCsGyOGRjEpFPF/s2Shsq9EW3Fk2xAG1HfG7aNuQhc0o1GCM2kitC0nWWp5QNLQLXNekyb
 ZYpyERfAysDQtweKlsB6MNgiYN0e+392l8Td4CZK755Fhg/fbNMpxjpjl5a+wDcJtxEpBVh7J9t
 g19yGcwD8C8myghXs7KdlrIZq2af+KfjMXFJH3zNACQEf5UfT7XRPZ4WFu1W5sgaoe9H/AFa0mG
 N5Zsu/o3NLJbfBqc0Jc0adTXKaVSHJDT4hd6ksqq3u9ZUdABq55b5X2vuZGzPruwJhbLUamkQbE
 efIEmQDfB9fcvcgenVbvBrqk=
X-Received: by 2002:a7b:c00b:0:b0:493:d741:5d72 with SMTP id
 5b1f17b1804b1-496c65a5ab0mr34112395e9.38.1785280968523; 
 Tue, 28 Jul 2026 16:22:48 -0700 (PDT)
X-Received: by 2002:a7b:c00b:0:b0:493:d741:5d72 with SMTP id
 5b1f17b1804b1-496c65a5ab0mr34112285e9.38.1785280968054; 
 Tue, 28 Jul 2026 16:22:48 -0700 (PDT)
Received: from redhat.com (ppp-94-66-118-61.home.otenet.gr. [94.66.118.61])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-496c44afaecsm125210845e9.2.2026.07.28.16.22.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 16:22:47 -0700 (PDT)
Date: Tue, 28 Jul 2026 19:22:44 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Yonggang Luo <luoyonggang@gmail.com>, Miku Hatsune <anznu1l@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@mailo.com>,
 Zhao Liu <zhao1.liu@intel.com>, QEMU Stable <qemu-stable@nongnu.org>
Subject: Re: [PULL v2 09/30] virtio-mmio: fix QUEUE_NUM_MAX
Message-ID: <20260728192047-mutt-send-email-mst@kernel.org>
References: <cover.1785179875.git.mst@redhat.com>
 <a5cff318f06cd06b37224e15ee74d64d1df8b12b.1785179875.git.mst@redhat.com>
 <65990a19-6a7e-4c1c-9354-0fffa13cbba9@tls.msk.ru>
 <20260728154328-mutt-send-email-mst@kernel.org>
 <75f2277a-8508-4e6e-adfe-92bed9fc1bf6@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <75f2277a-8508-4e6e-adfe-92bed9fc1bf6@tls.msk.ru>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
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

On Tue, Jul 28, 2026 at 11:17:34PM +0300, Michael Tokarev wrote:
> On 7/28/26 22:45, Michael S. Tsirkin wrote:
> > On Tue, Jul 28, 2026 at 11:40:24AM +0300, Michael Tokarev wrote:
> 
> ...
> > > > diff --git a/hw/core/machine.c b/hw/core/machine.c
> > > > index 805148678d..73b4d82b4a 100644
> > > > --- a/hw/core/machine.c
> > > > +++ b/hw/core/machine.c
> > > > @@ -41,6 +41,7 @@
> > > >    #include "hw/arm/smmuv3.h"
> > > >    GlobalProperty hw_compat_11_0[] = {
> > > > +    { "virtio-mmio", VIRTIO_QUEUE_SIZE_OVERRIDE, "1024" },
> > > 
> > > ..because it is adding a new field into the migration stream,
> > > which is a problem for stable series.
> > 
> > 
> > this is compat not a migration stream, right?
> 
> Aha, yes, I was a bit tired today.
> 
> > For stable, the value needs to be 1024 for all types.
> 
> So this whole change, for older versions, becomes just:
> 
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -2572,6 +2572,8 @@ VirtQueue *virtio_add_queue(VirtIODevice *vdev, int queue_size,
>      if (i == VIRTIO_QUEUE_MAX || queue_size > VIRTQUEUE_MAX_SIZE)
>          abort();
> 
> +    queue_size = VIRTQUEUE_MAX_SIZE; /* fixed properly in 11.1. */
> +

Or you can stick to upstream and add the compat entry for 11.0.

>      vdev->vq[i].vring.num = queue_size;
>      vdev->vq[i].vring.num_default = queue_size;
>      vdev->vq[i].vring.align = VIRTIO_PCI_VRING_ALIGN;
> 
> 
> so we override supplied size just like when
> x-override-queue-size is set for compat-11.0 or earlier.
> 
> Got it.
> 
> Now, the fun continues - this is the first time in qemu history
> when a bigger change reduces in stable series into such a one-liner :)
> 
> Thanks,
> 
> /mjt


