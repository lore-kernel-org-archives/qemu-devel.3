Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F549C83F17
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Jul 2025 08:27:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhOcK-0005Pr-0E; Thu, 31 Jul 2025 04:26:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uhOcF-0005Gz-AC
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 04:26:19 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uhOc8-0006uG-9N
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 04:26:16 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-45618ddd62fso5822255e9.3
 for <qemu-devel@nongnu.org>; Thu, 31 Jul 2025 01:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753950369; x=1754555169; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Rj9DQXa2tBkRnNQLTKkGjnzAc3iD26wKzXwbJ9nHvX4=;
 b=h/vJ/AtIAB6gspc1Hs+wtNag/QE1kYJ3uTjKMry7TEjr/QPYI5zQL0r9oapOabxjiN
 FJlbFvfZuqRoAuASfwd5RTUW0ckY46hU/Da2H1pdAOCUp8V0HNS6a6lUL3Pylgp1USEP
 oSbvw4ire/7p8k/5yxauBgBpqg9vI1NLkm+1KmZd1I/bsMwMtdqjP4eJFQFVNZTLiSaB
 NOgzGkshfrFSQ5shzHlqdyNvsUHP1YIVHu3+JyrQk8aczAIXt95weV9efIC2E0MhhF6Z
 YXnG8dh2AIzpttv3m4Bt/++jAg1G5g4430WTX8ubGLBP/PF2AbIp8VkVXG0hbeZHPmus
 ESCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753950369; x=1754555169;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Rj9DQXa2tBkRnNQLTKkGjnzAc3iD26wKzXwbJ9nHvX4=;
 b=CNQuyXhXOtKa9ESypK4yUDPXwian1vprleb1mLAqemgPS+rv9BbQ17ZWFp6kSQKHi5
 8zBpr+1NFeMSPz/r8dGdo/UYgAcjFXl6s7HyZ/PptjPxJXgGmV30C7bELex3CCDIWbbm
 fMZ1GWDqprkHrrPY9ePunL3+LHlSUcel/jjgzvzoPwhQnzPemuolcwzLfwRJSR/AcRFs
 6Ug/YRy+vQuG/mYcByHwke06Nu1bxFvNEKNsa20lbBXvU18st3jw5VXIztISIpFY3nC5
 yvEO4X2lXq2U7o5Wo6ix7G+B0A57KX5HqHjuBcmKxUkUHtj1YCy0mgMEzBoXZY/E9Co+
 R7dg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXsqoygtiv42qvomrU7O9CJ/NNGE8j0S5Zf8LoIx/imvuH0UaN/uiJdo3AFuQk9wMU+6vArCT4z+sSr@nongnu.org
X-Gm-Message-State: AOJu0YwNRonDUi4Iq3oIeQmUX5bww4SMVbJgqVpOBAaul/pDl+Q2GQFj
 cvqtrrwZ1Mc3sTeaToRSNmLygzkRhPCCt21O3MsJ+ySu2CzvYkdTXXEZXaIXPZDzo79xBxTF+1A
 t+nVJ
X-Gm-Gg: ASbGncs9PXE2pMIGNmwJvLA9nKKkBAfuIoyCAFtJULdwJzJYfd3/w8o1sp/JTXPpO+6
 PA+IBJxq8mG2qG+01h6TyBofSYJto/Own5PWjR4slgCr+wmG8z2f7XNn4UPCJjqN22cwr5jXk/y
 HANlqPsX1yD7tlmzffy+/Eqctr5rOEhuhvXOnG3mKOOFWEMHaC1FazoqXxmx/psWNWK3YdrKr1K
 bSNVE7TUNNTOP+Nj47lm2fProL40qTTCNArXFXHJP3Tj2AIPikc6dTlj6FpEVXDQnB1Tls+rc8p
 RYzAFxPS2Hc5ouZ+jDRTELYw+T2h2FlzrXPR0ZLczLKMThtfLdy4/ubIl8daHxbGphBBVozjQVs
 1y3uDKl1wDsoJIMF1C1MqVrVOsnWhhF1KxmFXZZ+ZxbfwKm0BAoKEs+befLwiNuThnFUqcIl461
 h4
X-Google-Smtp-Source: AGHT+IFw9iE9pC5QgyOrEy0RnpnIWrAnRgsO7tiAJ4S5yE+YPmrOjuRXMe1G2TyPXcFF8hesOOgFrw==
X-Received: by 2002:a05:600c:1f0d:b0:456:25aa:e9b0 with SMTP id
 5b1f17b1804b1-45892bc48f7mr67970015e9.16.1753950368772; 
 Thu, 31 Jul 2025 01:26:08 -0700 (PDT)
Received: from [192.168.69.209] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4589ee4f0d2sm16876545e9.18.2025.07.31.01.26.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 31 Jul 2025 01:26:08 -0700 (PDT)
Message-ID: <1e5263cc-23fb-44cf-a8c1-f01b6fbb6ef3@linaro.org>
Date: Thu, 31 Jul 2025 10:26:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vfio: Introduce helper vfio_device_to_vfio_pci()
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 chao.p.peng@intel.com
References: <20250731033123.1093663-1-zhenzhong.duan@intel.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250731033123.1093663-1-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

Hi,

On 31/7/25 05:31, Zhenzhong Duan wrote:
> Introduce helper vfio_device_to_vfio_pci() to transform from VFIODevice to
> VFIOPCIDevice, also to hide low level VFIO_DEVICE_TYPE_PCI type check.
> 
> Suggested-by: Cédric Le Goater <clg@redhat.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>   include/hw/vfio/vfio-device.h |  1 +
>   hw/vfio/container.c           |  4 ++--
>   hw/vfio/device.c              | 10 +++++++++-
>   hw/vfio/iommufd.c             |  4 ++--
>   hw/vfio/listener.c            |  4 ++--
>   5 files changed, 16 insertions(+), 7 deletions(-)
> 
> diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
> index 6e4d5ccdac..00df40d997 100644
> --- a/include/hw/vfio/vfio-device.h
> +++ b/include/hw/vfio/vfio-device.h
> @@ -157,6 +157,7 @@ bool vfio_device_attach_by_iommu_type(const char *iommu_type, char *name,
>                                         Error **errp);
>   void vfio_device_detach(VFIODevice *vbasedev);
>   VFIODevice *vfio_get_vfio_device(Object *obj);
> +struct VFIOPCIDevice *vfio_device_to_vfio_pci(VFIODevice *vbasedev);

Please return the typedef (like in the implementation), not the struct.

A one line comment describing what this helper does would he helpful.

Regards,

Phil.

> diff --git a/hw/vfio/device.c b/hw/vfio/device.c
> index 52a1996dc4..a4f9c9216c 100644
> --- a/hw/vfio/device.c
> +++ b/hw/vfio/device.c


> @@ -429,6 +429,14 @@ VFIODevice *vfio_get_vfio_device(Object *obj)
>       }
>   }
>   
> +VFIOPCIDevice *vfio_device_to_vfio_pci(VFIODevice *vbasedev)
> +{
> +    if (vbasedev && vbasedev->type == VFIO_DEVICE_TYPE_PCI) {
> +        return container_of(vbasedev, VFIOPCIDevice, vbasedev);
> +    }
> +    return NULL;
> +}


