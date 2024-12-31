Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26FC9E77188
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Dec 2024 17:37:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tSgAk-00026A-Lj; Tue, 31 Dec 2024 12:36:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tSgAh-00025q-1K
 for qemu-devel@nongnu.org; Tue, 31 Dec 2024 12:36:47 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tSgAe-0006n9-SH
 for qemu-devel@nongnu.org; Tue, 31 Dec 2024 12:36:46 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-385df53e559so7949592f8f.3
 for <qemu-devel@nongnu.org>; Tue, 31 Dec 2024 09:36:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735666602; x=1736271402; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wafRc2gNuj8ETKMyvc2WA8Sr40XFxZnRTYIYUgl7VaI=;
 b=yahZkEn22gx/xGnp/T8cJqgjBe/cycsFZbdJV5G1gjkcwqQuubNCdsco/ixcXwtMt1
 vNgm7sAb6d1PcqV5HU2cPH/jpoyLwirLiWBSZa5YSXZ0gYNlbh6iHT0ZLGNM9udDxUZ/
 gbZnxaog+8Kott6jGPCOwyG1cu4dJWMX+PMKmmKiQpIejl8Z0/DO2d2qTrfpP0bz3aIh
 ZOZCom+y/C94WfoVgMc9+yMerXt5ZJO4d5PZLHGcLA9hlckxAusbJ6llWPM2S1D3olcl
 fXkTnHFrM/J3ReL0jO35NVh9ohWI91ap8nvfLVliihi4xyO2meXY14FvRkY+U7vBarrI
 pSlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735666602; x=1736271402;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wafRc2gNuj8ETKMyvc2WA8Sr40XFxZnRTYIYUgl7VaI=;
 b=o55FFhANMLavQNLRcuSLSUSwEeMYeWquOx01l41y1kMbTUvQDdYviJSfcjVYRdUJCZ
 smnWETlcMfrOYAVGGpmSjLZ9PBO+qR6F6o0puynLYnScKf3Hsxe75qi1edru+BBRxTKn
 Je0AZ5MhPpEsr/Bq5yEbePlttS9OCzfGJwu2Fbe/Z38sGh0EmMEaVxq7L/VUW7ik2aL+
 CVWSutBD1dTQhIpWPc5WlD2Ftl3KDms+gHStcdKstDK+9xZpsbCacaMa/bcU43NM87Ts
 wI/kaVkr1vdi41SIKgIyoPk+xn4X5tgL5Nk6hQV3gp7IhVZoVop/S/3a/kd0O2spm3Qy
 GN2w==
X-Gm-Message-State: AOJu0Yyx9PKrzwa5r+BzuRdAndhRvCj1kaVTlytS5DGiKNLYZzdkdVbr
 /fOQ8EiigZDRrj/osKG0kgInroNwCT8i5U9c81fQJME6td+l4l2S1gNDUnACFct9BqAZnzi/Q/l
 3Rks=
X-Gm-Gg: ASbGncuNGJsyiFRC69Tf+8rzmU3XUs5j3+R4w+W8mbZJ0Mj8s9Mk30j5/ANdMlCxXK9
 TJisI45OFTJHuZ94wqttayCTNV3fAcWduC33lOS6gkrtPklx5/YtjCXnVBBCqIy60PoQgHlH/Jv
 u6LWUXX2HeaRTOoSaavoV1ie/EbWmDgnToOPfr70FGHBRg2sb98P8qFTFoWu7o2AriJUkwCScwM
 BKsolhCSahZBNc1ZFnQ65cOXwGE8hvSpsFp5hq1RTdLr2N892YcvBGyBftKPLgUkZv5xnzQujZ6
 2CUEI5FKnZdpnkWRcrHvJlt2
X-Google-Smtp-Source: AGHT+IFQGGryGVkan3TcsQnSIUh2iffunwMspZ+V7LSrqFqSZ3t73AQbj580W9PVAEhdLCbNbOlZQg==
X-Received: by 2002:a05:6000:154f:b0:385:eeb9:a5bb with SMTP id
 ffacd0b85a97d-38a221f698amr32110612f8f.17.1735666601938; 
 Tue, 31 Dec 2024 09:36:41 -0800 (PST)
Received: from [192.168.69.132] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436611ea3e0sm399392885e9.7.2024.12.31.09.36.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 31 Dec 2024 09:36:41 -0800 (PST)
Message-ID: <f47ce9a3-d1f1-4ac2-b1fd-a5c2b7939b5b@linaro.org>
Date: Tue, 31 Dec 2024 18:36:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.0 v2] hw/i386/amd_iommu: Simplify non-KVM checks on
 XTSup feature
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, Vasant.Hegde@amd.com,
 Santosh Shukla <santosh.shukla@amd.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Sairaj Kodilkar <sarunkod@amd.com>, Daniel Hoffman <dhoff749@gmail.com>
References: <20241129155802.35534-1-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241129155802.35534-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

On 29/11/24 16:58, Philippe Mathieu-Daudé wrote:
> Generic code wanting to access KVM specific methods should
> do so being protected by the 'kvm_enabled()' helper.
> 
> Doing so avoid link failures when optimization is disabled
> (using --enable-debug), see for example commits c04cfb4596a
> ("hw/i386: fix short-circuit logic with non-optimizing builds")
> and 0266aef8cd6 ("amd_iommu: Fix kvm_enable_x2apic link error
> with clang in non-KVM builds").
> 
> XTSup feature depends on KVM, so protect the whole block
> checking the XTSup feature with a check on whether KVM is
> enabled.
> 
> Since x86_cpus_init() already checks APIC ID > 255 imply
> kernel support for irqchip and X2APIC, remove the confuse
> and unlikely reachable "AMD IOMMU xtsup=on requires support
> on the KVM side" message.
> 
> Fix a type in "configuration" in error message.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> v2:
> Rebased on merged 0266aef8cd6 ("amd_iommu: Fix kvm_enable_x2apic
> link error with clang in non-KVM builds").
> Supersedes: <20241129114113.33215-1-philmd@linaro.org>
> ---
>   hw/i386/amd_iommu.c | 11 ++---------
>   1 file changed, 2 insertions(+), 9 deletions(-)

Patch queued, thanks.

