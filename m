Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3739CEE368C
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 14:53:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqXwE-0007yD-Gz; Thu, 12 Feb 2026 09:45:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vqXvv-0007MG-6V
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 09:44:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vqXvr-0006MY-Iw
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 09:44:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770907478;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=54SHBBPNFsC0ZFulw8wmW3134g9+RXDqPlgB8aDRbaw=;
 b=YnKV7ozVPHY+29nHq6pnd1qfJy1padhwwH64L4Nkut6vqwnF7sm+rHGBMd0P/butNW8Xgr
 Zgm/y6XWI6B0AzcW54MB34gDNFDw4Nkv693wCV9JJHLLsgTfRyHtT1aUyBq+m9lrVrbvag
 Zp7vH10KCpOSW18xqQvKOmwjMQ5X4CQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-xS4l8PpcNSOEOhkqxCKS5w-1; Thu, 12 Feb 2026 09:44:37 -0500
X-MC-Unique: xS4l8PpcNSOEOhkqxCKS5w-1
X-Mimecast-MFC-AGG-ID: xS4l8PpcNSOEOhkqxCKS5w_1770907476
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4836cf00787so4467295e9.1
 for <qemu-devel@nongnu.org>; Thu, 12 Feb 2026 06:44:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770907476; x=1771512276;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=54SHBBPNFsC0ZFulw8wmW3134g9+RXDqPlgB8aDRbaw=;
 b=tiuRAzboUHMqpPLwKJQWFJMupKzFkzd9fDxEZtEQ+ChNi2ncEgpi/NPKxt2JmdMwYT
 dAwLozJ1a/zNajZ2Jm+gtdbsWDC3WxgYGze8BlYKguErMcVpeVdhDZQF8UCON2Zp+9Wl
 4ZoSEvXGCmnPiM1yxxcElm9B/2rnM/n+JzYPGzTljvAUCBp5+wj2drwEfDzvSzXPN0CW
 Qjxb8k1LeG5bNmppqacEA5IlcZ9h4LtbN0uOUUabb8hyHTyQBNHcy7qX88CMAlX9t44B
 +0OB1fQOo8xeyft4pYFBiJIVFL/jNrrj/TeFO5rJxG/EKkmcIFLvCg001cXP+xmgs11k
 l6vQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWuNph/3O51Z5tU/EDhrJ9z9C2a0FI6rVq5miK3gKkS8tUn35ds95E34Vdo9JeryHq6XRh78b473SUz@nongnu.org
X-Gm-Message-State: AOJu0YyvHyrjv/fGcufI7j1edKr2oVzmuiQb6dxf2fHsb+Hz6XgJhgDZ
 P31knFd/HZZ1Us9S3Xu7nWhOfOTJ4R3EpZg72OptVtOQX0DLMphRPe23hL6kWnCI2dXnur9JQ/Y
 WqrokSS8eNGOFSPNQbdjvbtlt7rvu46R2iyJ1mL8AGvm0JpHddYeV3hx+
X-Gm-Gg: AZuq6aK6j/2yR0Fr2df1CL4jRgFRP92/sNDaRdtC3vL0aeHmcG+0OEGJV2Cvyt2X+bq
 toYcGOrf9GfztSh5wTQKShB4gkhp8MVYDsn4/+IHoAYPPFlE2ZEpSN4R5FyeG2CiF8wKMmBsnXD
 mC4c5uCQ6WXg2PkAUrOgI1bQ+yVGxn5qjHGRwtoawJcLDsRjpw9TBe6dPtF7LSOdZocSk+5dN+X
 EhmAzH2vKUj64mxWTflGXRLd+l+Sv7iNNrlLDnmGlRgmGWcFnezuTaJSBsXLKYPEOGmjgRRH94k
 /wj8wkTdnXJHjgfYC32TL1o2bmw4jyFyJQELJBVwHqmy3nLVH9qGWt+fWZ5Hn3Am9c9ZeFghvrY
 q1E+EIIxvczABVv4wTgTIe3RmLpJM9TRHgaf5LC5PDIbTowVgGpAZpY/uO+UAyczsWjcRYQ==
X-Received: by 2002:a05:600c:8010:b0:483:14ec:5925 with SMTP id
 5b1f17b1804b1-48365febeaemr41532495e9.2.1770907476152; 
 Thu, 12 Feb 2026 06:44:36 -0800 (PST)
X-Received: by 2002:a05:600c:8010:b0:483:14ec:5925 with SMTP id
 5b1f17b1804b1-48365febeaemr41531675e9.2.1770907475634; 
 Thu, 12 Feb 2026 06:44:35 -0800 (PST)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4835bc7b986sm42324555e9.17.2026.02.12.06.44.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Feb 2026 06:44:35 -0800 (PST)
Message-ID: <d33ee89b-0f75-4c6c-8331-b422840c85ba@redhat.com>
Date: Thu, 12 Feb 2026 15:44:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/24] hw/arm/smmuv3-accel: Introduce CMDQV ops
 interface
Content-Language: en-US
To: Shameer Kolothum <skolothumtho@nvidia.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, clg@redhat.com, alex@shazbot.org,
 nicolinc@nvidia.com, nathanc@nvidia.com, mochs@nvidia.com, jan@nvidia.com,
 jgg@nvidia.com, jonathan.cameron@huawei.com, zhangfei.gao@linaro.org,
 zhenzhong.duan@intel.com, kjaju@nvidia.com
References: <20260206144823.80655-1-skolothumtho@nvidia.com>
 <20260206144823.80655-6-skolothumtho@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20260206144823.80655-6-skolothumtho@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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



On 2/6/26 3:48 PM, Shameer Kolothum wrote:
> CMDQ-Virtualization (CMDQV) is a hardware extension to SMMUv3 that enables
> virtualization of multiple command queues (VCMDQs).
>
> CMDQV support is a specialization of the IOMMUFD backed accelerated
> SMMUv3 path. Introduce an ops interface to factor CMDQV specific
> initialization and CMDQV vIOMMU/vEVENTQ allocation behavior out of
> the base implementation. The ops pointer and associated state are
> stored in the accelerated SMMUv3 state.
>
> No functional change
>
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
> ---
>  hw/arm/smmuv3-accel.h | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>
> diff --git a/hw/arm/smmuv3-accel.h b/hw/arm/smmuv3-accel.h
> index c9c10e55c3..ca087240e5 100644
> --- a/hw/arm/smmuv3-accel.h
> +++ b/hw/arm/smmuv3-accel.h
> @@ -16,6 +16,23 @@
>  #endif
>  #include CONFIG_DEVICES
>  
> +/*
> + * CMDQ-Virtualization (CMDQV) hardware support, extends the SMMUv3 to
> + * support multiple VCMDQs with virtualization capabilities.
> + * CMDQV specific behavior is factored behind this ops interface.
> + */
> +typedef struct SMMUv3AccelCmdqvOps {
> +    bool (*init)(SMMUv3State *s, Error **errp);
> +    bool (*alloc_viommu)(SMMUv3State *s,
> +                         HostIOMMUDeviceIOMMUFD *idev,
> +                         uint32_t *out_viommu_id,
> +                         Error **errp);
> +    void (*free_viommu)(SMMUv3State *s);
> +    bool (*alloc_veventq)(SMMUv3State *s,  Error **errp);
> +    void (*free_veventq)(SMMUv3State *s);
> +    void (*reset)(SMMUv3State *s);
> +} SMMUv3AccelCmdqvOps;
> +
>  /*
>   * Represents an accelerated SMMU instance backed by an iommufd vIOMMU object.
>   * Holds bypass and abort proxy HWPT IDs used for device attachment.
> @@ -28,6 +45,8 @@ typedef struct SMMUv3AccelState {
>      uint32_t bypass_hwpt_id;
>      uint32_t abort_hwpt_id;
>      QLIST_HEAD(, SMMUv3AccelDevice) device_list;
> +    const SMMUv3AccelCmdqvOps *cmdqv_ops;
> +    void *cmdqv;
effectively looks duplucate, check !cmdqv_ops ?

Eric
>  } SMMUv3AccelState;
>  
>  typedef struct SMMUS1Hwpt {


