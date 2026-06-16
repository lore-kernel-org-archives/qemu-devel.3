Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84685CD98DA
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 12:29:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZSv3-0000wG-03; Tue, 16 Jun 2026 08:29:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wZSuv-0000u5-9D
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 08:29:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wZSut-00059O-H3
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 08:29:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781612957;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=q94kHAtZ02dXoiHrQIqONkTUXNyFSUv0oq1lO+AFYrk=;
 b=if8q8S/cm0eu9cL7e5FwQdbcufMi76u2BZ7p6Ber+ce1BNmH3Tu+QRCyX//Ah7Sla8Twub
 xEoP778BfV2QlKBWKAnTcLxhR8vxorB6ZptmxKFD+lEXx58lJt8Y1S0VzlQ7Ic5b4AZGoR
 pjLuWi3T/0CDpfjPyfWG/2g6wEAkDps=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-345-3G615DTSMM2iBPycwo5C6g-1; Tue, 16 Jun 2026 08:29:15 -0400
X-MC-Unique: 3G615DTSMM2iBPycwo5C6g-1
X-Mimecast-MFC-AGG-ID: 3G615DTSMM2iBPycwo5C6g_1781612954
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-45ef9437b7aso2576210f8f.0
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 05:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781612954; x=1782217754; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=q94kHAtZ02dXoiHrQIqONkTUXNyFSUv0oq1lO+AFYrk=;
 b=d/2zDgEDzyj3VhS5TCOQiA/E3qaWW2grxhMXKvpBI1ITtrfne6p1/XBW8zhKuyru9x
 YNtFOaW1fqN/14VxByDWQmo7GxxVHRAAC9mYwTjZBNkoUfupjN89hovyjoUNfpOJHoOc
 rM2HnA6N4D3FyHZ5v8Kl5stuUuxxO0aPDr1aNCmXb2FxIFFIBULPMNzkuTCy1XjRzUxi
 XtLKcw3xhPTHc/g7N6B82j+r7QmgqYlmov8zrP9MNJ/8w/LKos7hk4ig46NbYoX/0ljE
 E+vIR+0VZvono3knhg4sfklJmDkDHPmbux3BLlvzZRaZhbI3OoyebXsXseaqM5txHHqs
 D+/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781612954; x=1782217754;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q94kHAtZ02dXoiHrQIqONkTUXNyFSUv0oq1lO+AFYrk=;
 b=ZVBc4CQe98YJVmhH1ebUbyk+cT63ljPEcDld9rBnO69AuQ30pbUxn0oJqVWVhZijxb
 83NaWUbdtHvIRMSpnEildi1OB5F5hgaj5+6q9bGsz1uaMgLMv5Tw/MWbi16yrpKjIlGQ
 Oa+Q2uDoJpqtPbW5pijtaCKBTzMay2sTcxIwJe+NOshYasUpDE9T2SdCgJBZZNtwkiIP
 CpA+jHlcTDeyJm8yolN3CsW4rZJ54yY7vUWGO5fMTifWQH8A8+y+JsEZZpr+xe2fkkb3
 NdMKuVNtnVngXwGtFyRTj2uAeZ9p4L0W1xl8luIu1q/7R3JSnOEvUxbQq/0TucTgYZ55
 gdAA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+a7Avj994wX/Ieproe4KhGz3+1OnY4YG1CX1DoHHb1+VRUUc0H2kUxdCq687AK65P5h4sOaOii1NbE@nongnu.org
X-Gm-Message-State: AOJu0YxWsvMB/z4mwPF+DkEtBIbYDTjqaRL82U5rCtI6UsusQDX8yMjx
 oujYPGLslpZZ9TRXGxJtsxZX0RZUtixDzmz1aiKPsBbaZIjy3uu2nZxdfsaUWxospquZX06NC1X
 QuvHzlea7DrShk0lKHgNfox/jB2s1eKEEgoNcY9mTM2Ihhr8+BHv7NgQx
X-Gm-Gg: Acq92OETYVzVe73fhVBuDZGCjrBiESW12dylQCz4GPMXhDaFEkVo3aU+BMXKiCFYP4v
 nh0GqbyMvi3pqxXY1N1BfMxFrimNt0jMNkrlC8yZ7LyXkXSj7XCExYx60vEd13QIVz6uifOGC1i
 +RhD3rLFcde4tmwR5YOTooXdcrI0bA8mCjQLOV3FRlWrCPBa7kTVRvCD8V9YrR0t8sb8sUgdw8X
 fYz/iHe8KpFAtUaRdndNZiAiXUZ91s526U10Y9sDJ19I6hVyjg0n+ysLO6A/iSUp2nCG2bTm7SV
 je1pMEKESpDf/0tEW0P8JyhR22gP+5Vp34XebNiIZcj7V2LvGCawngHjCcNf3PX7az6WiG5yJV1
 dwH3nACOOcFUkgszTbRHL0Zb8X/zkXDM+QPeAscw2Iqmc1Yw/VcbLpPdV57Rh
X-Received: by 2002:adf:fe05:0:b0:460:3233:beef with SMTP id
 ffacd0b85a97d-4619f320187mr4897734f8f.43.1781612954405; 
 Tue, 16 Jun 2026 05:29:14 -0700 (PDT)
X-Received: by 2002:adf:fe05:0:b0:460:3233:beef with SMTP id
 ffacd0b85a97d-4619f320187mr4897664f8f.43.1781612953851; 
 Tue, 16 Jun 2026 05:29:13 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f26434dsm44697927f8f.1.2026.06.16.05.29.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Jun 2026 05:29:13 -0700 (PDT)
Message-ID: <1bb65b65-fb83-4bbc-a09f-bf8f0b9cc95c@redhat.com>
Date: Tue, 16 Jun 2026 14:29:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] iommufd: Introduce handler for device ATS support
To: Nathan Chen <nathanc@nvidia.com>, qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Zhao Liu <zhao1.liu@intel.com>, Alex Williamson <alex@shazbot.org>,
 Matt Ochs <mochs@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>,
 Shameer Kolothum <skolothumtho@nvidia.com>
References: <20260615204849.3659647-1-nathanc@nvidia.com>
 <20260615204849.3659647-2-nathanc@nvidia.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260615204849.3659647-2-nathanc@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

On 6/15/26 22:48, Nathan Chen wrote:
> From: Nathan Chen <nathanc@nvidia.com>
> 
> Introduce a support_ats() handler that returns whether ATS is supported
> for a device associated with a host IOMMU device, checking if the
> IOMMU_HW_CAP_PCI_ATS_NOT_SUPPORTED capability bit is set.
> 
> Implement this handler in a new function for iommufd.
> 
> Suggested-by: Shameer Kolothum <skolothumtho@nvidia.com>
> Signed-off-by: Nathan Chen <nathanc@nvidia.com>
> ---
>   include/system/host_iommu_device.h | 9 +++++++++
>   backends/iommufd.c                 | 8 ++++++++
>   2 files changed, 17 insertions(+)
> 
> diff --git a/include/system/host_iommu_device.h b/include/system/host_iommu_device.h
> index f000301583..2cb5365340 100644
> --- a/include/system/host_iommu_device.h
> +++ b/include/system/host_iommu_device.h
> @@ -133,6 +133,15 @@ struct HostIOMMUDeviceClass {
>        * Returns: true on success, false on failure.
>        */
>       bool (*get_pasid_info)(HostIOMMUDevice *hiod, PasidInfo *pasid_info);
> +    /**
> +     *  @support_ats: Returns true if ATS can be used by the device,
> +     *  false if the host IOMMU reports it is unavailable.
> +     *
> +     *  @hiod: handle to the host IOMMU device
> +     *
> +     *  Returns: true if ATS is supported, false otherwise
> +     */
> +    bool (*support_ats)(HostIOMMUDevice *hiod);
>   };
>   
>   /*
> diff --git a/backends/iommufd.c b/backends/iommufd.c
> index 410b044370..7cc6767b4b 100644
> --- a/backends/iommufd.c
> +++ b/backends/iommufd.c
> @@ -573,6 +573,13 @@ static int hiod_iommufd_get_cap(HostIOMMUDevice *hiod, int cap, Error **errp)
>       }
>   }
>   
> +static bool hiod_iommufd_support_ats(HostIOMMUDevice *hiod)
> +{
> +    HostIOMMUDeviceCaps *caps = &hiod->caps;
> +
> +    return !(caps->hw_caps & IOMMU_HW_CAP_PCI_ATS_NOT_SUPPORTED);
> +}
> +
>   static bool hiod_iommufd_get_pasid_info(HostIOMMUDevice *hiod,
>                                           PasidInfo *pasid_info)
>   {
> @@ -595,6 +602,7 @@ static void hiod_iommufd_class_init(ObjectClass *oc, const void *data)
>   
>       hiodc->get_cap = hiod_iommufd_get_cap;
>       hiodc->get_pasid_info = hiod_iommufd_get_pasid_info;
> +    hiodc->support_ats = hiod_iommufd_support_ats;
>   };
>   
>   static const TypeInfo types[] = {

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


