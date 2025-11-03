Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE127CCF9FE
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 13:24:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFuWx-0006hK-Sz; Mon, 03 Nov 2025 08:23:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vFuWv-0006gh-32
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 08:23:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vFuWf-00029A-51
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 08:23:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762176187;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PMUbQ0qTcx0H4tp2yfLeB44fxoxRDr72HkJE9bmJOjM=;
 b=CqmlA/BZXgc1qimtKYH1tVA6WKPRUG4iNeKRh65orUdfSDaTEjPlYwhkEXFsfUlPifOlgo
 VyrDckRJua8udDVpMGE2RSkhNA/3sSau+ZRxTa2wRA6iYZS3uaPKvckQ/xVSWnWC45PZmo
 gtrDSqO7dnfqA+yk7UbPP8lQZAD+7Fc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-332-g54Zzgt2PdeWOlON9QugTA-1; Mon, 03 Nov 2025 08:23:06 -0500
X-MC-Unique: g54Zzgt2PdeWOlON9QugTA-1
X-Mimecast-MFC-AGG-ID: g54Zzgt2PdeWOlON9QugTA_1762176185
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-475dabb63f2so21173955e9.3
 for <qemu-devel@nongnu.org>; Mon, 03 Nov 2025 05:23:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762176185; x=1762780985;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PMUbQ0qTcx0H4tp2yfLeB44fxoxRDr72HkJE9bmJOjM=;
 b=ju7qQXNatoa1iJQKx5S8Vi2VhagZ95YdFmJx7SF0AqI7LzL3CTsLq2vdHfJRXXPE4F
 U3SPzxSjEdd8+wo92Wi3NJE+C/72ijhWDHp/cLyr7Sx6YJ+A23MNMHoeseMNiQle9Bvx
 dTwPtDYrX0n93aFVRD5KBDHudkopU7e3tzyQth4l6N/ijE6GsuFdzwLIxKq8cpjEvYhd
 TVug2ksS3mor+9tEcyi9vRu0Oioo29HpsYKKcp+FzCeau6i2WeCWWEUjconfd3QFLwPz
 JLDL8XnNES+IOFv2mZcPxELomplltozzaVJJkJKwHhHwI/6zY/yZLSfFkKRb0V3wMc04
 R63g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWr2mpwkx0DI3rUjwawzxApOQHUjgpYlFSeEq+5zWyoe5iQGoEug0QsMEJOrMZi+zEBLVs1VjobRNfX@nongnu.org
X-Gm-Message-State: AOJu0YyH7I36YNg0zjJqAHtHiXLzG/4qUsTGl6fMELDjWe2fwwvY3KtD
 zdlirJ+Yd28x6jnD02Z5sFOn/Jmp4cNcSTMYKG+hUcw3+AnIvRnawxpBbLoKVY9PcCvMJ7MusaN
 NWCsGmyqFr4pzBOWTKaYOtXQXdoShu0jrqRXEgVc2RYQ9x+0sJF1+XjTO
X-Gm-Gg: ASbGncvBUPM6aZZitnu2HAr2ThaQyW0MqRV0YYpVQsnjPt1ANtjf2D3V9Hybq1uhGZg
 KlKHx0IbqCVsZm9Q+ymBj0J8MH0mD9eu/CPpR1Tw5FH3PQQJtG/UPa+C06MB3/1bPklaEa94Yfk
 TyHiw2Vceb+xCoJSXAnG0Cz9p6mwdZKGmaE0zN8k49kNgbN6SMcr1D51eemsXiuVKt7f73Hnslc
 VjRa7KfJrbI3l8NhQg/mAtK5pW4JE/VAUApUmHxYLJuUqvSwlacxECmtFPrJRvj5zh3XzfCqS83
 N/tYmCoNy3kxFcRsCe8COR4KwP/LtOaNqWM+lh9p3hr2fvay6xkKC0496iW+Ofc2+eIYOWx+e9V
 7p2W/IpyPYesuK+mBilBdbR0NezwPjO8CdXG++HlCKwNAog==
X-Received: by 2002:a05:600c:4f93:b0:475:de05:661f with SMTP id
 5b1f17b1804b1-477308aa918mr119574135e9.41.1762176185181; 
 Mon, 03 Nov 2025 05:23:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGg4g6GOp3gHFYKbrG/9AVBkt+CHn9Dw+y6oSM6xpY8Dt5PWCIdOLTQmCr9JXCep06zq4tdgg==
X-Received: by 2002:a05:600c:4f93:b0:475:de05:661f with SMTP id
 5b1f17b1804b1-477308aa918mr119573835e9.41.1762176184790; 
 Mon, 03 Nov 2025 05:23:04 -0800 (PST)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4772ff83182sm87961605e9.4.2025.11.03.05.23.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Nov 2025 05:23:04 -0800 (PST)
Message-ID: <923f350a-1aa0-4402-b328-fa6dd5abd530@redhat.com>
Date: Mon, 3 Nov 2025 14:23:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 23/23] docs/devel: Add IOMMUFD nesting documentation
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, mst@redhat.com,
 jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, skolothumtho@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com
References: <20251024084349.102322-1-zhenzhong.duan@intel.com>
 <20251024084349.102322-24-zhenzhong.duan@intel.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20251024084349.102322-24-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Zhenzhong,

On 10/24/25 10:43 AM, Zhenzhong Duan wrote:
> Add documentation about using IOMMUFD backed VFIO device with intel_iommu with
> x-flts=on.
>
> Suggested-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>  docs/devel/vfio-iommufd.rst | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>
> diff --git a/docs/devel/vfio-iommufd.rst b/docs/devel/vfio-iommufd.rst
> index 3d1c11f175..f1e4d940e6 100644
> --- a/docs/devel/vfio-iommufd.rst
> +++ b/docs/devel/vfio-iommufd.rst
> @@ -164,3 +164,28 @@ RAM discarding for mdev.
>  
>  ``vfio-ap`` and ``vfio-ccw`` devices don't have same issue as their backend
>  devices are always mdev and RAM discarding is force enabled.
> +
> +Usage with intel_iommu with x-flts=on
s/with/featuring to void repetition?
> +-------------------------------------
> +
> +Only IOMMUFD backed VFIO device is supported when intel_iommu is configured
> +with x-flts=on, for legacy container backed VFIO device, below error shows:
> +
> +.. code-block:: none
> +
> +    qemu-system-x86_64: -device vfio-pci,host=0000:02:00.0: vfio 0000:02:00.0: Failed to set vIOMMU: Need IOMMUFD backend when x-flts=on
> +
> +VFIO device under PCI bridge is unsupported, use PCIE bridge if necessary,
> +or else below error shows:
s/or else/otherwise
> +
> +.. code-block:: none
> +
> +    qemu-system-x86_64: -device vfio-pci,host=0000:02:00.0,bus=bridge1,iommufd=iommufd0: vfio 0000:02:00.0: Failed to set vIOMMU: Host device under PCI bridge is unsupported when x-flts=on
s/under PCI bridge/downstream to a PCI bridge
may have been better I think
> +
> +If host IOMMU has ERRATA_772415_SPR17, kexec or reboot from "intel_iommu=on,sm_on"
> +to "intel_iommu=on,sm_off" in guest is also unsupported. Configure scalable mode
> +off as below if it's not needed by guest.
> +
> +.. code-block:: bash
> +
> +    -device intel-iommu,x-scalable-mode=off
Besides
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric


