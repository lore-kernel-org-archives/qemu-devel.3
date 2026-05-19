Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93345CD4F3C
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 16:04:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPMv1-0002M6-EQ; Tue, 19 May 2026 12:03:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wPMun-0002GF-Fa
 for qemu-devel@nongnu.org; Tue, 19 May 2026 12:03:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wPMuj-0003TK-2w
 for qemu-devel@nongnu.org; Tue, 19 May 2026 12:03:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779206603;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7oKSiw8BZiD2+qBkAr61x4b5B1ajwy464k5FXvHCzWM=;
 b=FjaSrut5ZLIyWBgYlEeBw3O/GSPNgT6LA6u1r+tH3a3gKElfLShwR6ds8mS0OdAtjX3o3w
 sx9V/WNihw3ISasrpPwXR8mqmKT6m0V1FMOjgoD644tEprlrlVIkW5i3G4+BWSCOTzS+0g
 6mJuF3U5YPw3K1K+iJghmj6Kqh7Se+E=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-__p0UrTzPR60cNR5i4e1pw-1; Tue, 19 May 2026 12:03:22 -0400
X-MC-Unique: __p0UrTzPR60cNR5i4e1pw-1
X-Mimecast-MFC-AGG-ID: __p0UrTzPR60cNR5i4e1pw_1779206601
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-45e80183514so2014430f8f.3
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 09:03:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779206601; x=1779811401;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7oKSiw8BZiD2+qBkAr61x4b5B1ajwy464k5FXvHCzWM=;
 b=fseus+NIsQbeK6GoGB938FzJeDaNSsr/KAUtj9ysuaM8g3zr7qPH+T6j6e5cWS1M8Y
 I82E6Bguhobqgn2CG5oH1PSqCxYo1u25XT41yzTU+ZhnBPrERGs+lWDTG3Q7fqTKDfIa
 agMAKfRM0bL9dkSZC533XlnrKt4evj+p/2VsunA5GsAbZRbXRwj4lj7NY/bC79PgZbOo
 /ZPg39Jt8HOtyvKhwP+9J413mOoohKTTZNIOF7XhMe/OTBGhhFPh3kna+8K068NPYzfg
 GMamLBDD8SOpYPC+0ZmKH6HIe0fzzoaddlVIRkTMOHzv/JFdDt4/vju4WPvdxThBZI5b
 hRdQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/EFvUgb14vHTfcMWe40mpHap9LmaptsLuLahwZJn/f74tY+wrRvtHB9CIYLPVyO+rvh3RJN8d6q3tT@nongnu.org
X-Gm-Message-State: AOJu0YxVzHd8ZIvRnn2PIOemLzk6Tab38zAjExljPTPfk1Hg/FzRFb0w
 KesBSFecKx98dZvDej+aSaR1KzGJW7demzn9CTu/BVqZUDI7J3niCcWOdaQZFNVRsacir2D0j7Y
 NoYYUds0U3YKterZpfexNowsokpu64zpFFr04/SjxxE313eRft1lmkTYK
X-Gm-Gg: Acq92OFqYL2o9nZUtf5sE1XNHKWnm6rULurqExCvezUMA4vnWqhfa2Zjxusr+bsFY0e
 KPIVwD6JAzcX0Qz3IVuGzQvAmDnxt/Fudi489DL4e+hNQzO9RkxTjtuVhMeRAESd/9rorxtpEIO
 Zl0MId+odaPA+U/YfwWt6hWg12fYA28X3rqBoP7WFyXEkFpopqXDg2rWDy8aFf48JGC9ncpmug6
 WTqiDJ0EYJfi5tq9OdPDKIKdwup/4kUR7Kdl+dg/t2T/rm4ZDrYS6CPFh+dJ4ZeLP/Monbg0cM1
 Aw/CWltP1MZxc7kWosbU4cq/bzl1NuYQL+07yHhNCb2jl7IFgNzDkwZCnNRUPZaVxdpgWaOq6hF
 E16xA76IRYp5PyXROYOfz7+O4VSN4NWsBm4BqjFXsmhAICfJ/TFwCe5EYpkS7XyzCLU/eLg==
X-Received: by 2002:a05:600c:3b12:b0:488:a824:fdff with SMTP id
 5b1f17b1804b1-48fe61ed2cfmr298120265e9.22.1779206600873; 
 Tue, 19 May 2026 09:03:20 -0700 (PDT)
X-Received: by 2002:a05:600c:3b12:b0:488:a824:fdff with SMTP id
 5b1f17b1804b1-48fe61ed2cfmr298119685e9.22.1779206600349; 
 Tue, 19 May 2026 09:03:20 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fe4c88e5asm358335595e9.6.2026.05.19.09.03.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 May 2026 09:03:19 -0700 (PDT)
Message-ID: <0e747538-5e87-40ba-ac44-bc7bbe89bc7f@redhat.com>
Date: Tue, 19 May 2026 18:03:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/7] qemu-options.hx: Support "auto" for accel SMMUv3
 properties
Content-Language: en-US
To: Nathan Chen <nathanc@nvidia.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Matt Ochs <mochs@nvidia.com>,
 Nicolin Chen <nicolinc@nvidia.com>,
 Shameer Kolothum <skolothumtho@nvidia.com>
References: <20260512193520.3109172-1-nathanc@nvidia.com>
 <20260512193520.3109172-8-nathanc@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20260512193520.3109172-8-nathanc@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Nathan,

On 5/12/26 9:35 PM, Nathan Chen wrote:
> From: Nathan Chen <nathanc@nvidia.com>
>
> Update documentation now that "auto" is supported for accelerated SMMUv3
> properties.
>
> Signed-off-by: Nathan Chen <nathanc@nvidia.com>
> ---
>  qemu-options.hx | 25 +++++++++++++++++++------
>  1 file changed, 19 insertions(+), 6 deletions(-)
>
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 96ae41f787..46b02a1bb3 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -1291,30 +1291,43 @@ SRST
>          Enabling accel configures the host SMMUv3 in nested mode to support
>          vfio-pci passthrough.
>  
> -     The following options are available when accel=on.
> -     Note: 'auto' mode is not currently supported.
> +     The following options will be set to auto by default if not manually
> +     set. When accel=on and these properties are set to auto, the value is
> +     derived from the host SMMUv3 capabilities via IOMMU_GET_HW_INFO. With
> +     accel=on, this requires at least one cold-plugged vfio-pci device; if
> +     none is present at machine init, QEMU will abort.
>  
> -    ``ril=on|off`` (default: on)
> +     If accel=off, auto values resolve to the non-accel defaults given below.
[*]
> +
> +    ``ril=on|off|auto`` (default: auto)
>          Support for Range Invalidation, which allows the SMMUv3 driver to
>          invalidate TLB entries for a range of IOVAs at once instead of issuing
>          separate commands to invalidate each page. Must match with host SMMUv3
>          Range Invalidation support.
> +        - With accel=on, auto means the value is automatically derived from the host SMMU.
instead of repeating that sentence for all props you mean put it in [*]
> +        - With accel=off, auto is resolved to 'on'.
>  
> -    ``ats=on|off`` (default: off)
> +    ``ats=on|off|auto`` (default: auto)
>          Support for Address Translation Services, which enables PCIe devices to
>          cache address translations in their local TLB and reduce latency. Host
>          SMMUv3 must support ATS in order to enable this feature for the vIOMMU.
> +        - With accel=on, auto means the value is automatically derived from the host SMMU.
> +        - With accel=off, auto is resolved to 'off'.
>  
> -    ``oas=val`` (supported values are 44 and 48. default: 44)
> +    ``oas=val|auto`` (supported values are 44 and 48. default: auto)
>          Sets the Output Address Size in bits. The value set here must be less
>          than or equal to the host SMMUv3's supported OAS, so that the
>          intermediate physical addresses (IPA) consumed by host SMMU for stage-2
>          translation do not exceed the host's max supported IPA size.
> +        - With accel=on, auto means the value is automatically derived from the host SMMU.
> +        - With accel=off, auto is resolved to 44.
>  
> -    ``ssidsize=val`` (val between 0 and 20. default: 0)
> +    ``ssidsize=val|auto`` (val between 0 and 20. default: auto)
>          Sets the Substream ID size in bits. When set to a non-zero value,
>          PASID capability is advertised to the vIOMMU and accelerated use cases
>          such as Shared Virtual Addressing (SVA) are supported.
> +        - With accel=on, auto means the value is automatically derived from the host SMMU.
> +        - With accel=off, auto is resolved to 0.
>  
>  ``-device amd-iommu[,option=...]``
>      Enables emulation of an AMD-Vi I/O Memory Management Unit (IOMMU).
But either way, with formatting checked,
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric


