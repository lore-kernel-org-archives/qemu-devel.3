Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B2ACC55162
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2026 16:00:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpTAs-0008T8-OU; Thu, 30 Jul 2026 11:59:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wpTAp-0008P3-Kz
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 11:59:57 -0400
Received: from mail-yw1-x1130.google.com ([2607:f8b0:4864:20::1130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wpTAn-0000Fr-Sx
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 11:59:55 -0400
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-80bb41f7f3cso26183357b3.2
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2026 08:59:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785427192; cv=none;
 d=google.com; s=arc-20260327;
 b=aSgv4dB3QlZoLCT/7hkkvXfprJTLBIubTaiTj9nM7GPb4BinoY/6qLafK84tYfqVmy
 keV8oXb5rbEdQhL0MDvOVFwSAsUYTu6Xpe2HEaeW9RSkbT9RDWaHOyoi0RLNypiTgR7f
 UTENan/Ougv16zmQzLZ28yzwWKD5QB+RrMT/796x9puHF7iQLwFJblvRDhmmh+Ig9byR
 5uBiVX0LD3e8dXAtixKvJBzS31avt9hcx2PnDV9rJ/nNpeEtxC5i0ewb1CFQbwFHChZK
 CyEiD/U2rUbQmlYqT+/keuvwv9RWdfVnLBQIdng2NNiwSdPs6RUTmkzST6k3Tze2jFCt
 i4Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ZYk6AMgtqyUsRLIu3m72iCuCHeT7D+JOE04uBqeqytM=;
 fh=2XLoswv6ZY96YHibfDh256/5iVEb+qVWApmNJHVSowY=;
 b=gANtoZiAk89UNkoQRVL6BgzR4xpNfVS5bew0Drb9tIr9AC+d160wV4kI+JZ1eYpk2W
 nAFm/PCvXFRJKSNnm0mjvaYJaC3aOqEdA0EpsNBsonu+r9aRP1H4+ZbWMDHFD+tYLxZk
 +rMIOz1PqTf3Rkjhi6rffHjvy0N2SFJydkIK179xMR8dCJInPK2Lvu7vpAWfQqn4Iccy
 H4o6/J7SVSD8vjwMytxelrRdngUPoIV8DYR65NQfYq/SK7fPj8WBfQInIkV94TNcyyYh
 9Zp+F72JCJKM2RCbvuX0KVXaykyxtGXQpoPSkG7qLnZt2TuAa6qtvzpzpMs9GrZnrPxc
 1PXA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785427192; x=1786031992; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ZYk6AMgtqyUsRLIu3m72iCuCHeT7D+JOE04uBqeqytM=;
 b=wI0uL5xdDox0KsyCK7lfWsbMVFBAW8TiLI5lfBGZoUmXQ8sUDkKP9E3gpwW5zUypte
 uQPWfaMCOHSjuCZnNaYqLEvoqwNExt/ojB08+EF3+n60y73PoRbhR/otGsq0K6GAXbhu
 j6bM2RPWTjM+rCp4USPV5erZcahUAsL47bZ2qiizPi++6G6jB7NadlpCG6MPur7KWRmr
 vKunTKj3kpXaghKMkzV60znlTh/UuFS8ofsO5n8+JkKBkrVP4VIKqaL61YqiSqGep++M
 16ct8X6IlYWa3IiCYoKeaVlIlieypK/Nh/rnin5LbVWMdGg/5UBm8Q9CrBgAYrw0Q1tF
 jaPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785427192; x=1786031992;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ZYk6AMgtqyUsRLIu3m72iCuCHeT7D+JOE04uBqeqytM=;
 b=ZCUb9stLCw9oRIpRuF2qnTBEjLWnGxIYHmFiBJomKNjBpRRv5otXTcC79MRSiEjaHd
 lJDnaa01eRO8aEHZx2xKE7CtKHa51SmH3fnxqmUamjuNsTCqJq7xS4CUfjZ+kO/xyuQ4
 OIFMyAfRc4DjBMgH/41F2FUyyzKKlCm6a39UgXtIWhWxzzlTEbVKthWcGgTAiIehod4B
 ftDX40N/z7/1foCvV/nWJnIHaPS7leWl7WPCY5vQ6KiDcDSEFVJCM8XIQjKDc93f573n
 SRSKLhMBbINFW8ou/f+8KQfGFiyVXa+4GzIJXiqxiB2fPqqxUV1F3oH3O1L07ua6vZNT
 AKLA==
X-Gm-Message-State: AOJu0YzwOPLCje28eBKqusxkf3iwYDDbBTZ+uoZY4vJ6gHyhHT6ljb2q
 vmPw1Hbdpy1V2SNMQSLAKBVD5ugQ7KwCjSyhgk1sxpPX6ebC8yuSJu/oKRMROJH1X5p82jOYkrl
 8Rlm6DzkMliq4AumeBzRS3KIi8ZovMhatGfnNk9CjZVkLDNbIj2elbgA=
X-Gm-Gg: AR+sD11YWjklfF5h0B9emP4L0x0uLtG9RkogfL1de1mT+XPd0/FQyxarJILA06oBNRM
 6UrXiJXlKd5l5cyxJabMXHKdgehlqDoSmskXxY+VmqRAE8WjQFMgkD1MLQZTYX4h485Bns5Kv2M
 Xl5FivYrp/5qDnz4fPkQAsOCfw3PdUVnUYlYbWtlXKD4UVkWU4wGUo15ci27aCugS/7xGR+V6Gs
 O+ttEQPcgq8f1PIxzRODPuR1823UVpWQYhbt+LYx/hyCcmC9sYGA5a7WfQL9wlIelHDX5x9oeiF
 xBg+M0gOCUBpIYO3X54RC1Rntpfq8ztYAlz/nVGqyZ+JSes2isr2l43jM7qBTuSXvXZBEot6jW6
 i1iFPfItXgoKE9kg9kvC2N2aOOqM21Q==
X-Received: by 2002:a05:690c:6011:b0:81e:685a:2f78 with SMTP id
 00721157ae682-81fb8a61f11mr23869327b3.43.1785427192178; Thu, 30 Jul 2026
 08:59:52 -0700 (PDT)
MIME-Version: 1.0
References: <20260730153604.1462722-1-stefanha@redhat.com>
In-Reply-To: <20260730153604.1462722-1-stefanha@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 30 Jul 2026 16:59:40 +0100
X-Gm-Features: AUfX_mwYJNyFQNCyeKGGEpgRYR_e-PbYjuWE9fOn3MJHKH51DxNK9EvkVd9a698
Message-ID: <CAFEAcA-mn4x9MJ1dVra1jP_5taJJQHwYz-khKXzm8RCeYnaELg@mail.gmail.com>
Subject: Re: [PATCH] virtio: make virtio_add_queue() queue_size an unsigned int
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1130;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1130.google.com
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

On Thu, 30 Jul 2026 at 16:36, Stefan Hajnoczi <stefanha@redhat.com> wrote:
>
> virtio_add_queue()'s queue_size argument is a signed int. Coverity is
> unhappy when that type is used as an argument to g_new0():
>
>   *** CID 1664271:         Error handling issues  (NEGATIVE_RETURNS)
>   /builds/qemu-project/qemu/hw/virtio/virtio.c: 2595             in virtio_add_queue()
>   2589         }
>   2590
>   2591         vdev->vq[i].vring.num = queue_size;
>   2592         vdev->vq[i].vring.num_default = queue_size;
>   2593         vdev->vq[i].vring.align = VIRTIO_PCI_VRING_ALIGN;
>   2594         vdev->vq[i].handle_output = handle_output;
>   >>>     CID 1664271:         Error handling issues  (NEGATIVE_RETURNS)
>   >>>     "__n" is passed to a parameter that cannot be negative.
>   2595         vdev->vq[i].used_elems = g_new0(VirtQueueElement, queue_size);

Though note that the reason Coverity thinks this value can be negative
is not because the function might be passed a negative value, but
because it incorrectly thinks that
        int override = object_property_get_int(OBJECT(qbus->parent),
                                               VIRTIO_QUEUE_SIZE_OVERRIDE,
                                               &error_abort);

can return a negative number. (It can't because of the error_abort
and because the property is a UINT16 one.)

It might be a good idea to enforce the VIRTQUEUE_MAX_SIZE bounds
check on the queue size we get from the override property. Since
I think that can be set by the end-user (though probably it won't
be in practice) ideally we would not abort() on a bad property
value, but that's awkward to do at this point...

thanks
-- PMM

