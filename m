Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A0B5C4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 08:07:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzu7b-00036R-Al; Thu, 25 Apr 2024 04:06:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rzu7Y-00035i-E0
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 04:06:21 -0400
Received: from mail-lj1-x230.google.com ([2a00:1450:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rzu7W-00044a-Kd
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 04:06:20 -0400
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2d8a24f8a3cso7789721fa.1
 for <qemu-devel@nongnu.org>; Thu, 25 Apr 2024 01:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714032375; x=1714637175; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=iCdKGBl8MCWSdClEAgreA+ZkX6CtItXZ5VVpZBsUrJY=;
 b=J6LBprtmKYPK1zWDK0pS/vwlXfJvUfsiPKr3lvDI8O4LDAqoIoEcgnKutojk/QuYcy
 2fISjn7lWqBLrgSRDHGVlplqJ5uHVNl6Y4Lp8RknYSTSfm7X714jkGHudkwiWPPd6/wT
 s1iacFe2YQqSYlX8JSL7yo4SxO/rk+b9LFhGCyCsie/RkMKnQmmDW+tdLjykpkG6vNMo
 SuVT3PpQl11CHetMwuFiui54v5skAMBtgXJq6//s7Nuu5ONFroINBZYwGTaCppV3fb7T
 7lxC0dSinlTDMG0PRVe+gBWy3RRgz8wGkmqjEQ+6tw/XUzCfsn3rTsfqzgsAJNd7higf
 8Hgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714032375; x=1714637175;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iCdKGBl8MCWSdClEAgreA+ZkX6CtItXZ5VVpZBsUrJY=;
 b=YjVqnCeHcWK6reJ+A1nOBGXXE9YCoNdKvhOPxP5kQU8uL7JE0Q1QsJwmQ+6DInOsHl
 1GBBzji8ez3iXIAW4W7aqUf/ixReerNHW1RcG2nUBg7m5DqgIXHp+cpWRbtgQj2GFThQ
 YGZurVktDc/9fg4QKQrgd5rgTKUULM4R70BfgaHiFW75iDDunFgoUXbKKFbs9+slgVXj
 RUe1JZ2lLRX1MQVwH6XZX4RPQ8jPxUuup7kfraOINcW2LDB5E7hhY3Xh5iSd4klrxbIh
 dmm3NuryWszukcMY5vhvc4OulOebXfxgP3mHZKPd4MmHaowXHj76a+C/Zv7CECyKv45d
 Vgkw==
X-Gm-Message-State: AOJu0YzwDtzfclVmAiGbhuxu7VkgdMV5GZGP0LPXtPl/3FXbUk3OWPeP
 /QtExQFouddw9qhgjwpL4kcXJN/R9OGwGm06fpwX5qyoGNxws1qFZLWQr6YWoaM=
X-Google-Smtp-Source: AGHT+IEb4+fND5ZU/0fnVUcIFg/IIv1B6MFauRzoNd2D1aWZh7NEqWTW+bH4oFShfqLEyzeM1ITtrQ==
X-Received: by 2002:a2e:9c45:0:b0:2d8:7363:ff36 with SMTP id
 t5-20020a2e9c45000000b002d87363ff36mr2950018ljj.37.1714032375510; 
 Thu, 25 Apr 2024 01:06:15 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.197.201])
 by smtp.gmail.com with ESMTPSA id
 w20-20020adfe054000000b0034a366f26b0sm17489992wrh.87.2024.04.25.01.06.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Apr 2024 01:06:15 -0700 (PDT)
Message-ID: <a76a987f-3ea2-4c48-bc02-74ab42fd3c01@linaro.org>
Date: Thu, 25 Apr 2024 10:06:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 00/21] i386: Introduce smp.modules and clean up cache
 topology
To: Zhao Liu <zhao1.liu@intel.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Marcelo Tosatti
 <mtosatti@redhat.com>, =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Zhuocheng Ding <zhuocheng.ding@intel.com>, Babu Moger <babu.moger@amd.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>, Dapeng Mi <dapeng1.mi@intel.com>,
 Yongwei Ma <yongwei.ma@intel.com>
References: <20240424154929.1487382-1-zhao1.liu@intel.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240424154929.1487382-1-zhao1.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::230;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x230.google.com
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

Hi Zhao,

On 24/4/24 17:49, Zhao Liu wrote:

> ---
> Zhao Liu (20):
>    hw/core/machine: Introduce the module as a CPU topology level
>    hw/core/machine: Support modules in -smp
>    hw/core: Introduce module-id as the topology subindex
>    hw/core: Support module-id in numa configuration

To reduce this series size, I'm taking these 4 patches to via
my hw-misc tree.

Regards,

Phil.

