Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6182AC25B10
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2024 10:26:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s5NRO-0005fT-6i; Fri, 10 May 2024 06:25:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1s5NRD-0005b7-Hg
 for qemu-devel@nongnu.org; Fri, 10 May 2024 06:25:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1s5NRA-0001yz-Ft
 for qemu-devel@nongnu.org; Fri, 10 May 2024 06:25:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715336709;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AlDzUCjj+A3q3X+Q4OfKNPy973++5CJIerEShWUeb4Y=;
 b=dZV71pYJ5raHmBAiEyvaSKb+DK+nWe3GR6TmI+lgjptTMLMI+t3LXIjg+xXuKyWFe12HdD
 BqqPO801PUShFJwSLIZZ+M9jyY10HfFMtlSVEFLjGcCO9W7PCmtNxe2Ule+46jAg8QED3C
 XRRceb62e3CcpcYLN+daisRnuxApTvM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-468-VhaVt6TDPiGi5S8-vis0rQ-1; Fri, 10 May 2024 06:25:08 -0400
X-MC-Unique: VhaVt6TDPiGi5S8-vis0rQ-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-34d9055c7e0so1116597f8f.3
 for <qemu-devel@nongnu.org>; Fri, 10 May 2024 03:25:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715336707; x=1715941507;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AlDzUCjj+A3q3X+Q4OfKNPy973++5CJIerEShWUeb4Y=;
 b=aZf6PDXQc66WiSNYfWqFx2AjdfdX1Xl+p6svHQJ0sOPuN72yDHjzLns5FSXQweIk7r
 /l0lkE958xQ27w8ttuvVbQnsXRtlUauCXBPHgq/zLOCVTEAjHc47HAJglRsF4aycGlS4
 j1iZiOdH2fNgYT1o2IY0J7LGCc4pRmZhwWKOgp55qiG/YC0+j538U/SgvCdeWeGTJYn4
 hYK9qB+NL38keCvh1T2LiJHea1lG+MOjbNFyDogEuW3qzPFmMloxWbdNRzNLKavLoeXU
 tCzxJePKT7VWWv8+G/1sdhaWjaEAa6X+UEdU7uHWm/7STKTkhSdOf1+FMZemQzELXWof
 HLTw==
X-Gm-Message-State: AOJu0YzxjWdGmgbsf3dYLpXsSVwDT4Nzr4qjdnNjPG2R+1ywk295IqSX
 AYgPX8/BQYppbsXBgQ2nVVS5ow5EHjQh2H9ZpMFwhw0KDuRp7wwZgfYZOXIT9DMdXmit/YAw4WP
 f32eJenBCfkjWoW/aeR1tXe0mSwFI9y1JxGxpAr5QIEW0UAbc5uhs
X-Received: by 2002:a5d:4d43:0:b0:346:92d2:a496 with SMTP id
 ffacd0b85a97d-3504a7388demr1541770f8f.29.1715336706955; 
 Fri, 10 May 2024 03:25:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFUmHUBoquyB5FpVHCEkSLc4ndke3UqKqZeFnZcxV82DUUDWz5hREueMudcdPcv6qu1FvHIFQ==
X-Received: by 2002:a5d:4d43:0:b0:346:92d2:a496 with SMTP id
 ffacd0b85a97d-3504a7388demr1541750f8f.29.1715336706422; 
 Fri, 10 May 2024 03:25:06 -0700 (PDT)
Received: from redhat.com ([2a06:c701:7408:4800:68b:bbd9:73c8:fb50])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3502b79bc3bsm4178749f8f.13.2024.05.10.03.25.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 May 2024 03:25:05 -0700 (PDT)
Date: Fri, 10 May 2024 06:25:02 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Sebastian Ott <sebott@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Eduardo Habkost <eduardo@habkost.net>, Fiona Ebner <f.ebner@proxmox.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Peter Xu <peterx@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 peter.maydell@linaro.org, Yanan Wang <wangyanan55@huawei.com>
Subject: Re: [PATCH 3/4] virtio-gpu: use a VMState variant for the scanout
 field
Message-ID: <20240510062414-mutt-send-email-mst@kernel.org>
References: <20240507111920.1594897-1-marcandre.lureau@redhat.com>
 <20240507111920.1594897-4-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240507111920.1594897-4-marcandre.lureau@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
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

On Tue, May 07, 2024 at 03:19:19PM +0400, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Depending on the version, use v1 or v2 of the scanout VM state.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>  hw/display/virtio-gpu.c | 22 +++++++++++++++++-----
>  1 file changed, 17 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
> index ae831b6b3e..4fd72caf3f 100644
> --- a/hw/display/virtio-gpu.c
> +++ b/hw/display/virtio-gpu.c
> @@ -1191,17 +1191,29 @@ static const VMStateDescription vmstate_virtio_gpu_scanout = {
>      },
>  };
>  
> +static bool vmstate_before_v2(void *opaque, int version)
> +{
> +    return version <= 1;
> +}
> +
>  static const VMStateDescription vmstate_virtio_gpu_scanouts = {
>      .name = "virtio-gpu-scanouts",
> -    .version_id = 1,
> +    .version_id = 2,
> +    .minimum_version_id = 1,
>      .fields = (const VMStateField[]) {
>          VMSTATE_INT32(parent_obj.enable, struct VirtIOGPU),
>          VMSTATE_UINT32_EQUAL(parent_obj.conf.max_outputs,
>                               struct VirtIOGPU, NULL),
> -        VMSTATE_STRUCT_VARRAY_UINT32(parent_obj.scanout, struct VirtIOGPU,
> -                                     parent_obj.conf.max_outputs, 1,
> -                                     vmstate_virtio_gpu_scanout,
> -                                     struct virtio_gpu_scanout),
> +        VMSTATE_VSTRUCT_TEST_VARRAY_UINT32(parent_obj.scanout, struct VirtIOGPU,
> +                                           vmstate_before_v2,
> +                                           parent_obj.conf.max_outputs, 1,
> +                                           vmstate_virtio_gpu_scanout,
> +                                           struct virtio_gpu_scanout, 1),
> +        VMSTATE_VSTRUCT_TEST_VARRAY_UINT32(parent_obj.scanout, struct VirtIOGPU,
> +                                           NULL,
> +                                           parent_obj.conf.max_outputs, 2,
> +                                           vmstate_virtio_gpu_scanout,
> +                                           struct virtio_gpu_scanout, 2),
>          VMSTATE_END_OF_LIST()
>      },


Just don't, please.
Add a property and add a conditional field based on property, set
from the compat machinery.


>  };
> -- 
> 2.41.0.28.gd7d8841f67


