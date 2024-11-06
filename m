Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB1DDD40D13
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2024 00:57:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8ULW-0001kK-5h; Tue, 05 Nov 2024 19:56:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1t8ULU-0001k4-Kz
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 19:56:28 -0500
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1t8ULS-000508-Uu
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 19:56:28 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1730854580; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=AkZYcpxjE+hisdLPyTQeU6Z4zrdb2arwxanghKsfbuw3BjG01mcGtCtsHNVfebb5gqBaRLlQn/sAvrjSlG2D4Y2XFfNC/AOJJIgWMB4Z1p7DEg353XpiPxvGAbchyV9KJZuctzGkkKAP5pLyqvh3vr07mIXh1ikrqdvXxGP4tjE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1730854580;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=cFhhQeZSl2s9W+onYpPAUBntAwktooqpyWPdnNSb9oQ=; 
 b=lFJZUND5GheuHNLZ8U/Enh/tF4ZCZkWmngDThosv5aI13TnLofonSExJDjTWlyH2tgxqqzN0+gIuiwF4mw1PCQRfvtAih5Y2p7hbDTn8nuSs70O6VFLGJ0eq2z6y0h807kI2ffbGbDsvVHpuhd7fAyqeFQG407PHb83FuzXaZyE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1730854580; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=cFhhQeZSl2s9W+onYpPAUBntAwktooqpyWPdnNSb9oQ=;
 b=kfAEWo9ce1f21PlB6xmoKYDi8o2N0++JxrA58UGxZQpRkM65Pky4gBKil7Go17jO
 jNZVg7SY4Ceka+Wf6YM866zJOg7pgiXItqoRoRX93fdiyIvOw1RZav2ykibBg7PefNh
 Mm1Cz9jAb2jSYOLneYMwVZoR82SLxVSmHa30+ZZc=
Received: by mx.zohomail.com with SMTPS id 1730854579227945.6790844118677;
 Tue, 5 Nov 2024 16:56:19 -0800 (PST)
Message-ID: <09f636d9-1c90-4cf4-ba04-46831c43a721@collabora.com>
Date: Wed, 6 Nov 2024 03:56:16 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] hw/display: check frame buffer can hold blob
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>
References: <20241104165348.2361299-1-alex.bennee@linaro.org>
 <20241104165348.2361299-3-alex.bennee@linaro.org>
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Content-Language: en-US
In-Reply-To: <20241104165348.2361299-3-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.112;
 envelope-from=dmitry.osipenko@collabora.com; helo=sender4-pp-f112.zoho.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 11/4/24 19:53, Alex Bennée wrote:
> Coverity reports  (CID 1564769, 1564770) that  we potentially overflow
> by doing some 32x32 multiplies for something that ends up in a 64 bit
> value. Fix this by casting the first input to uint64_t to ensure a 64
> bit multiply is used.
> 
> While we are at it note why we split the calculation into stride and
> bytes_pp parts.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> ---
>  hw/display/virtio-gpu.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
> index e7ca8fd1cf..572e4d92c6 100644
> --- a/hw/display/virtio-gpu.c
> +++ b/hw/display/virtio-gpu.c
> @@ -741,9 +741,14 @@ bool virtio_gpu_scanout_blob_to_fb(struct virtio_gpu_framebuffer *fb,
>      fb->stride = ss->strides[0];
>      fb->offset = ss->offsets[0] + ss->r.x * fb->bytes_pp + ss->r.y * fb->stride;
>  
> +    /*
> +     * We calculate fb->stride for every line but the last which we
> +     * calculate purely by its width. The stride will often be larger
> +     * than width to meet alignment requirements.
> +     */
>      fbend = fb->offset;
> -    fbend += fb->stride * (ss->r.height - 1);
> -    fbend += fb->bytes_pp * ss->r.width;
> +    fbend += (uint64_t) fb->stride * (ss->r.height - 1);

ss->r.height=0 will result into overflow. I don't see why the last line
needs to be treated differently, that's wrong. The last line shall have
same stride as other lines, otherwise it may result into OOB reading of
the last line depending on the reader implementation. Let's fix it too,
all lines should have same stride.

-- 
Best regards,
Dmitry

