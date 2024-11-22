Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF781E65D29
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2024 07:02:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tENfj-00052o-Sg; Fri, 22 Nov 2024 02:01:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tENfh-00052N-SQ
 for qemu-devel@nongnu.org; Fri, 22 Nov 2024 02:01:42 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tENfg-0003JA-4l
 for qemu-devel@nongnu.org; Fri, 22 Nov 2024 02:01:41 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-43162cf1eaaso20689445e9.0
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2024 23:01:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732258898; x=1732863698; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=o5n7gZkt7jHDWRX8S2pc+Ptpth6O2IYLpxCswCv47D4=;
 b=dHQq0srNrrH+hmqOsT2tFdvAQidqBtl63n0m0sjviIHu+7nM8cG/RHwevI0gaSX25p
 yCPAffrFOhq6+rOMj9yE87U4NhmOvLCtODY2CF9GELdCpvZHmDVYholyr+IebiTQl2Rq
 X0q9Ri5lL/wub74K22JJU9gDLktf3naK0QaSDC+w1Qe6nGf7xvI/Cvb8ILx+gP5r20CR
 SCPkwGpJseqGImG3V/x7ksltVGFNvlWjhtYeFGKjE+UsXOOBqjc+79hGyndOt1fqW/Rl
 FlJvsyGDI/9d+sXtL0AJWQiB6XGKdIrX9AAzQ7wLO3DKfWk/Fq1q6PaYP2iED2alGRNB
 AvWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732258898; x=1732863698;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=o5n7gZkt7jHDWRX8S2pc+Ptpth6O2IYLpxCswCv47D4=;
 b=s64YatF7Z/MB4B9XfXCfWJWrz+PmYHMvZLfsEBnM8QZPa9vvdQcXexxGfTUQvWqSBj
 JbO7rrqC5ON54rsSaO48n8en83GApBgGJEIrAFeTpzWF76P5hVm5vzQ1mWmEy6PLBVgC
 tHH560/2oroC1hbLi0niMpIBRnS0Bu5pu/eL92LX53NEkvrqO4KWPeGz0zd4lTFdmvb4
 rd2KI9+IIJRMiK0rbMcGBrDgdRk7HH/Y7mHYOWBvtveUKwGJC5CjeRZxFt+5y+vgURst
 5351JfBpt19aP+Xjf9fIT1tSrRhnr9kS0GlSErnQs5j1HNm3JFeiXzd0H44ljZfHyqba
 5Arg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUvItzECIp1fz52G2JWoEc8SpKnJPdOV4FgvW23QENDzi1yOdcrOHh/UJFAo7RSe4LTkCdTleXKDzmc@nongnu.org
X-Gm-Message-State: AOJu0YzQqV4EStsFFzvVqjxBanivoHNVkI+F3JMGMXPTuEY0hxPmTyFW
 tB37dfw/tACj40kt9x/GOzN36ZbxIcdHeCfvALKnIsA67YOEzX7gV34gZnxc89A=
X-Gm-Gg: ASbGncvm89QkpQ1VikQp/335cOowZ6C8/EAHy+Uono7plBG9rLijVpRS4oKmwmoObR0
 i+6EFUd7SzUlXYNEQf7XDS+c5XHHFR7biYm2laqmSVvR5DjE7SANN17X7Ynh9xMz6M8ojqc8DgK
 uSfK3Pv2f7VqL6771JLpRYenD17uKCgxFozRDYKo41f73QfRBtlMyru8dXm27VUV1C2PvVeQgIv
 l/aRVvaIWl/XPRS02ZQt8rA5QwsSLNLLv6U2pFpJU2cX52Pf+3wHieQGc28bo4=
X-Google-Smtp-Source: AGHT+IEL4Y9IvGIqACgjKeH3oUBN82YtTnZF6xnv9OFdkKiwXc4pTCfWevO6lWKbthO+Vm5fRgh9dQ==
X-Received: by 2002:a05:600c:b87:b0:431:4847:47c0 with SMTP id
 5b1f17b1804b1-433ce41035bmr12666615e9.7.1732258898164; 
 Thu, 21 Nov 2024 23:01:38 -0800 (PST)
Received: from [192.168.1.121] ([176.187.204.90])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-433cde97c68sm17209385e9.36.2024.11.21.23.01.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Nov 2024 23:01:36 -0800 (PST)
Message-ID: <52aebd45-da0c-41a9-ab2f-acee8da5d7e4@linaro.org>
Date: Fri, 22 Nov 2024 08:01:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/virtio: Fix getting the correct ring number on loading
To: Wafer <Wafer@jaguarmicro.com>, mst@redhat.com, jasowang@redhat.com,
 groug@kaod.org
Cc: eperezma@redhat.com, qemu-devel@nongnu.org, angus.chen@jaguarmicro.com
References: <20241122020002.564-1-Wafer@jaguarmicro.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241122020002.564-1-Wafer@jaguarmicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

Hi Wafer,

On 22/11/24 03:00, Wafer wrote:
> From: Wafer Xie <wafer@jaguarmicro.com>
> 
> The virtio-1.2 specification writes:
> 
> 2.7.6 The Virtqueue Available Ring:
> "idx field indicates where the driver would put the next descriptor entry
> in the ring (modulo the queue size). This starts at 0, and increases"

"modulo" ...

> 
> The idx will increase from 0 to 0xFFFF and repeat,
> So idx may be less than last_avail_idx.
> 
> Fixes: 616a6552 (virtio: add endian-ambivalent support to VirtIODevice)

This commit is only about endianness... Do you mean 1abeb5a65d
("virtio: fix up VQ checks") or 258dc7c96b ("virtio: sanity-check
available index")?

> 
> Signed-off-by: Wafer Xie <wafer@jaguarmicro.com>
> ---
>   hw/virtio/virtio.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index a26f18908e..ae7d407113 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -3362,7 +3362,13 @@ virtio_load(VirtIODevice *vdev, QEMUFile *f, int version_id)
>                   continue;
>               }
>   
> -            nheads = vring_avail_idx(&vdev->vq[i]) - vdev->vq[i].last_avail_idx;
> +            if (vring_avail_idx(&vdev->vq[i]) >= vdev->vq[i].last_avail_idx) {
> +                nheads = vring_avail_idx(&vdev->vq[i]) -
> +                         vdev->vq[i].last_avail_idx;
> +            } else {
> +                nheads = UINT16_MAX - vdev->vq[i].last_avail_idx +
> +                         vring_avail_idx(&vdev->vq[i]) + 1;
> +            }

...           nheads %= UINT16_MAX; ?

>               /* Check it isn't doing strange things with descriptor numbers. */
>               if (nheads > vdev->vq[i].vring.num) {
>                   virtio_error(vdev, "VQ %d size 0x%x Guest index 0x%x "


