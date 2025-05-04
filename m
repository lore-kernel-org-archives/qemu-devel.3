Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74FF2C369DC
	for <qemu-devel@archiver.kernel.org>; Sun,  4 May 2025 21:22:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBgmb-0005OB-4y; Sun, 04 May 2025 17:21:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBgmZ-0005Ne-DF
 for qemu-devel@nongnu.org; Sun, 04 May 2025 17:21:55 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBgmX-00011H-Qy
 for qemu-devel@nongnu.org; Sun, 04 May 2025 17:21:55 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-73712952e1cso3629788b3a.1
 for <qemu-devel@nongnu.org>; Sun, 04 May 2025 14:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746393712; x=1746998512; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Wzt2MIU+ja9zZUff9ep/lMXcyuZHr1NDGHUva08OD+Y=;
 b=NoMSp6DcGSPMCuXGd8Mx5xv+JIJ9Wr4aoH/XVrIt9/f/UrgVBW1WKYDelIX3P2z8Y0
 T3cacm7zkIH8Xpqnt5eJhfNSZZe+zShoYvzIyCUMWkU08tpkhhxaDxs39RtcBfVqxu5E
 ynNZyW9LFQyPo/NsXNesqIh5sUTwqkxFed7B+zJug77Ky/g5Pv7vgUEa1/0QFj/SDCwD
 bVgUNJsquKGWNFRgQ5YHxioQBOneZYHERrdRfnzraR61dnjAze3Jke74s8t9KFPJ9Iet
 gCN8VE23Hccn7hI9WltYlygYjA756uE/4ccAEbDulTnWgaue8yUbrVW4Cn5CfDrGlwWt
 KEWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746393712; x=1746998512;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Wzt2MIU+ja9zZUff9ep/lMXcyuZHr1NDGHUva08OD+Y=;
 b=KbyY82BsOy8H8ok9C4ZUKkAy79UbNy4CfzTO/q9iu5/2yWWnuukfT5taXWuVwuMgEP
 ko/2EA0a3DT/wavbtDDY7PdFsdXMs3Z2KYWAIAoWy4sJkRsJOl5gNZ9VFNXo3GcrV2Y9
 F+agDAVtLuXnFbP5ztnc+b980eD+cOqMveAufD4fYak+HRagBEOXy+UxZ5Yq1Nnl7eLy
 tNyAaWVQ6GvY6hNXmzDbaljnzmcOGn9YnJRs6gJykkobDgZBPYlYRu9bP1RsumjgRoiD
 fIs3eSoQNRi48h9qWlrb6XVq53g4LEY1WMBJ3t7peLMikVXGOFf+aWruHP9SGgA4K6hq
 9/gg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUHxx4NoiLqWlDCZifLm5GbysMYaqH1bik1ILDkAuzUdRARiQN88og4quUP2fNkMHUcyuQXOrXNdnrv@nongnu.org
X-Gm-Message-State: AOJu0Yx4j2fExp2AyE5VskvNCyDGfW/v3WtNHJTXGPamAVLdvn48nqSh
 akTRp4XqtgaphJ1+iO5l6+hh2ydd2o8FlIAjol8tCZiuPTeaFSDb3vWAUYBUvIw=
X-Gm-Gg: ASbGncv1xOsowf0ly2BNL0TZhu/i/IZuPMvgJWQN8GERCsx9Jc6uxKtGNiW8RdnyOr+
 P+UaBiqJ2tEfl/CFdcikHrV9dkdTMP/ySGnr1K8Edh3p9DR+euLGrnw2RhMl7NS+J1ovzpnKRfR
 oxj2Kk8g6gqXyDt9r2Y1lcmLyvlTDNkHvff820OeslsDQigwgn8/W80v/Y6uQOEi9ST7rR/kTIZ
 5Ae9bqC6W5m0LveKTAb6Xmej5ag/8DubA5gcOnM1Xf14LSIdGpao5P4EC5uTTflafmqRPAXijkH
 HIs3LeXI4ezLaWqvG2j7aaLCT36iRwCH8rbxeyhnmE+QHxCh9Gb1+A==
X-Google-Smtp-Source: AGHT+IFEP8CM9M0+xN6Ha3W++Si2dxNbbBMZ3no2Obrqn+8tjPXtgi8ocx4/zL8PVRN8ui8t0pOQBA==
X-Received: by 2002:a05:6a00:328f:b0:736:5725:59b4 with SMTP id
 d2e1a72fcca58-7406f089a7dmr7077977b3a.3.1746393712223; 
 Sun, 04 May 2025 14:21:52 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74058dbb939sm5478161b3a.61.2025.05.04.14.21.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 04 May 2025 14:21:51 -0700 (PDT)
Message-ID: <5a5f4cf7-801a-476b-9da2-e328716e278f@linaro.org>
Date: Sun, 4 May 2025 14:21:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/5] qemu/target-info: Add %target_arch field to
 TargetInfo
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Thomas Huth
 <thuth@redhat.com>, David Hildenbrand <david@redhat.com>
References: <20250502214551.80401-1-philmd@linaro.org>
 <20250502214551.80401-3-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250502214551.80401-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42f.google.com
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

On 5/2/25 2:45 PM, Philippe Mathieu-Daudé wrote:
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/qemu/target-info-impl.h | 4 +++-
>   target-info-stub.c              | 1 +
>   target-info.c                   | 3 +++
>   3 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/include/qemu/target-info-impl.h b/include/qemu/target-info-impl.h
> index 1b51cbcfe1b..83d584d7dba 100644
> --- a/include/qemu/target-info-impl.h
> +++ b/include/qemu/target-info-impl.h
> @@ -9,11 +9,13 @@
>   #ifndef QEMU_TARGET_INFO_IMPL_H
>   #define QEMU_TARGET_INFO_IMPL_H
>   
> -#include "qemu/target-info.h"
> +#include "qapi/qapi-types-common.h"
>   
>   typedef struct TargetInfo {
>       /* runtime equivalent of TARGET_NAME definition */
>       const char *target_name;
> +    /* related to TARGET_ARCH definition */
> +    SysEmuTarget target_arch;
>       /* runtime equivalent of TARGET_LONG_BITS definition */
>       unsigned long_bits;
>       /* runtime equivalent of CPU_RESOLVING_TYPE definition */
> diff --git a/target-info-stub.c b/target-info-stub.c
> index fecc0e71286..2e4407ff04b 100644
> --- a/target-info-stub.c
> +++ b/target-info-stub.c
> @@ -14,6 +14,7 @@
>   
>   static const TargetInfo target_info_stub = {
>       .target_name = TARGET_NAME,
> +    .target_arch = SYS_EMU_TARGET__MAX,

Time to suggest again to implement an ifdef with all TARGET_*, so we can 
get rid of this "not set" value.
It would solve all the issues with target_system_arch() function, 
without duplicating the enum SYS_EMU_TARGET itself.

The only compromise is this ifdef, that can be shrinked and eventually 
removed when we'll have implemented target_info for all configs.

>       .long_bits = TARGET_LONG_BITS,
>       .cpu_type = CPU_RESOLVING_TYPE,
>       .machine_typename = TYPE_MACHINE,
> diff --git a/target-info.c b/target-info.c
> index 8232d488870..5f6096606e4 100644
> --- a/target-info.c
> +++ b/target-info.c
> @@ -25,6 +25,9 @@ SysEmuTarget target_system_arch(void)
>   {
>       static SysEmuTarget system_arch = SYS_EMU_TARGET__MAX;
>   
> +    if (system_arch == SYS_EMU_TARGET__MAX) {
> +        system_arch = target_info()->target_arch;
> +    }
>       if (system_arch == SYS_EMU_TARGET__MAX) {
>           system_arch = qapi_enum_parse(&SysEmuTarget_lookup, target_name(), -1,
>                                         &error_abort);


