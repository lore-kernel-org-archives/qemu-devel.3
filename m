Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8827AE8782A
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 13:31:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnGUY-0003s3-Bs; Tue, 03 Feb 2026 08:30:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vnGUX-0003o9-A0
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 08:30:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vnGUV-0006uE-QQ
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 08:30:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770125451;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=xb2PJj/ck2B3XoHxEMTZFU2KlVnDtPaOCdSpg8ChGVI=;
 b=hlHZ0ZSksyIExDj+uJ+OPqv6eJPGQsanvV5YEn0sM0wzpj7DN5sqnHIuqe2ncmO8jHEwkM
 f4XRcAtKynnIwoSroR50RHKVLGMG+ItAy47W2FFb6xo6nrQlVKPM6sFqXO/y3o9e+P01ou
 TKuUAhws747+k9sRUrlvN39Q4XvMg8w=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-1-h-4onaFqN1WtY0L9k3Qqfg-1; Tue, 03 Feb 2026 08:30:49 -0500
X-MC-Unique: h-4onaFqN1WtY0L9k3Qqfg-1
X-Mimecast-MFC-AGG-ID: h-4onaFqN1WtY0L9k3Qqfg_1770125449
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-47edf8ba319so60320205e9.2
 for <qemu-devel@nongnu.org>; Tue, 03 Feb 2026 05:30:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770125448; x=1770730248; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=xb2PJj/ck2B3XoHxEMTZFU2KlVnDtPaOCdSpg8ChGVI=;
 b=awqaLij2OGt55Urc37tc/qfx0JFjJkPOndKMOEOUQDlPjn6RsfyT2YJHAfruRTyRZN
 NDdP92CYn6Ja4u3W8ibrsEEp+C4mIluZ2LiSJVlR0SuIlnzEWozwVPqpVBpTreusI2T9
 h1EghqFCyF/I0CW5nFCw4PXlP8XL3T1auWt2LrBGrQhnrrsjCqya/c+UVwspqFPBSgT3
 hD7vn1Jh8oELYaFg4RgIX8Hh47WFbl5/H9uufc2XBwDiuJL1rNQ4gT5fYULsmryZ/uUE
 9lplU12heqm3NSagMfhUjiP73qUy2Fw9p19Mw9t+UsR4oHEXmVdM+2Q0LYgZqleIHJek
 60EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770125448; x=1770730248;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xb2PJj/ck2B3XoHxEMTZFU2KlVnDtPaOCdSpg8ChGVI=;
 b=bOkqhlGHditZYd0F+kcMaVh7zd3qptF3yiyxDCf+G25PcPOzse2kh1Nri5b2R3ZYEw
 D+nhvh/XkC0wH3LqMuuqh1VY9KhvP9ATarJxzNQopFGtkRMcpMTztV+frrbXuYZ9zEvg
 r5vMvfgL09OIlx+4vY6nvLqXFp4IpN4SKsEXNcLZRjXapFXzoXcSYKyxY2GjyA2PVeZ5
 LtslVgMKNrGVe5KR47wQGIUq6m4BQFsiq+9xOwSO3OcRQpti71EyRVBa5auMuKB7HduD
 FuPDSuUKckGGkafdS+3KKVRYbPVidaVsJGw5IY5jlkBhskUjjSC41FZUXGFtKdYbKWYw
 OiVQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU0bonsdUg7XYN/kQbAqUBY9h/wxsaKhIRrXWMb5fK3Qp6sQcjSskffpqzwueDnODrN/s47jCVSHAAt@nongnu.org
X-Gm-Message-State: AOJu0YwaPiXLJeYH3M3Ix0MFyNteKQqQGt7rK2iZ/r/Bt6/xKSuBA5Qx
 MCsJ4tlCYiEkpK/RoxZQWDxLbVSj+886VLmxfsIxYpD12IU4LxHJUI8PF7MIDB7BZcUcLL0z63A
 cQ7cPmrTHS7UMqQSRkFEbm/d8Qx0rZmcK0obitgPCqgHgFJ+PQtWDUi6SrA/W140G
X-Gm-Gg: AZuq6aICWGnjY4f3L2I54+R64ISmVGy/RyeP24fvc3CXymvfz6vgMYdAEUjjWuKIdE0
 AI/nKcg5jPnFVHFNp6YUSdnVbFFhdjTsIwNt/3lPh+0ZdEoE2yUjpi5j8lCMZRUMLSnTFbwTfZx
 0qzOmNLhpCf9PIzgCGhgiXFag5Ci3kRRu6nhcCVaYBMR4TMzcqaYWbiWZh49kOx6v147x7SDy+g
 JJcDLhiO5oNJV3d9i64gxsnbfA4RdaCk9MQq+Y2OKrPdmOObzZTEZ48mb2bSqTJzEZymmo8wU45
 KCQrHAwOkfuiSTr7oY8Yk+qSJJnjVi+okDl1gwbTes5B7xJV40p8Zgtl98Mo7YJK+sEcErHSgNN
 OMO2acXPTOT6C8PdAZVHJtuDHw+pji7amMsSfuMTMwWW1zi3k
X-Received: by 2002:a05:600c:350a:b0:480:6910:abd1 with SMTP id
 5b1f17b1804b1-482db491f3emr174594725e9.18.1770125448225; 
 Tue, 03 Feb 2026 05:30:48 -0800 (PST)
X-Received: by 2002:a05:600c:350a:b0:480:6910:abd1 with SMTP id
 5b1f17b1804b1-482db491f3emr174594455e9.18.1770125447800; 
 Tue, 03 Feb 2026 05:30:47 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483051372cdsm102546635e9.13.2026.02.03.05.30.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Feb 2026 05:30:46 -0800 (PST)
Message-ID: <4f7f77df-afa9-43c4-a429-2ca387fe9df7@redhat.com>
Date: Tue, 3 Feb 2026 14:30:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 09/12] vfio/device: Add a helper to lookup VFIODevice
 from memory region
To: Vivek Kasireddy <vivek.kasireddy@intel.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>
References: <20260203073200.848183-1-vivek.kasireddy@intel.com>
 <20260203073200.848183-10-vivek.kasireddy@intel.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260203073200.848183-10-vivek.kasireddy@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 2/3/26 08:30, Vivek Kasireddy wrote:
> Instead of iterating over all QOM devices to find the VFIODevice
> associated with a memory region, it is faster to just use the
> vfio_device_list to lookup the VFIODevice.
> 
> Cc: Alex Williamson <alex@shazbot.org>
> Cc: Cédric Le Goater <clg@redhat.com>
> Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
> ---
>   hw/vfio/device.c | 23 +++++++++++++++++++++++
>   1 file changed, 23 insertions(+)
> 
> diff --git a/hw/vfio/device.c b/hw/vfio/device.c
> index 973fc35b59..ecb3581fcc 100644
> --- a/hw/vfio/device.c
> +++ b/hw/vfio/device.c
> @@ -644,3 +644,26 @@ static VFIODeviceIOOps vfio_device_io_ops_ioctl = {
>       .region_read = vfio_device_io_region_read,
>       .region_write = vfio_device_io_region_write,
>   };
> +
> +static bool vfio_device_lookup(struct iovec *iov, VFIODevice **vbasedevp,
> +                               Error **errp)
> +{
> +    VFIODevice *vbasedev;
> +    RAMBlock *first_rb;
> +    ram_addr_t offset;
> +
> +    first_rb = qemu_ram_block_from_host(iov[0].iov_base, false, &offset);
> +    if (!first_rb) {
> +        error_setg(errp, "Could not find first ramblock\n");
> +        return false;
> +    }
> +
> +    QLIST_FOREACH(vbasedev, &vfio_device_list, next) {
> +        if (vbasedev->dev == first_rb->mr->dev) {
> +            *vbasedevp = vbasedev;
> +            return true;
> +        }
> +    }
> +    error_setg(errp, "No VFIO device found to create dmabuf from\n");
> +    return false;
> +}


This won't compile and break bisect. Please merge with the following patch.

Thanks,

C.


