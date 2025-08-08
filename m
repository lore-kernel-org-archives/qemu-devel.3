Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4C95C87FCB
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Aug 2025 16:15:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukPjl-0002vo-TP; Fri, 08 Aug 2025 12:14:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ukPjb-0002uA-J9
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 12:14:25 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ukPjW-00016s-SP
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 12:14:23 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-23aeac7d77aso20558575ad.3
 for <qemu-devel@nongnu.org>; Fri, 08 Aug 2025 09:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754669657; x=1755274457; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=beb9Jvn6Yhwrz3bSjpv5nzdM6y4rkfmDjig7WL8gsg4=;
 b=rvlAOzrlOl1jsajR79oiVjxE7eFKRFAxphhQS5u5FsMSbJ2ShOrh/ECJs9To6Wg4cQ
 c6ZkDqCh3RBzFVssiVOpeEA6BupZ7mJtIz/VZq2joryGQeYYGjyeLm3fsYeic3I3di1P
 vDb6y/+HRyYOfy4xGdiJWQDHikb91GD6xMwLpcWPKUvc9DQN1Nn+rrU6dvvIjbWQKiTw
 yIsVPENSts/Xe6Vm4sDPYcOXVZWi9vQEqci2hNPnj9VsEuhJLrSMxpFl8QFqNcdFV8hv
 yvtT10MSTGLG+ICH2s1gAyMM2zrFk70pTEuuHi6uidT6FYBmyIPpyifb2p/HT1h9S0mJ
 uRFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754669657; x=1755274457;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=beb9Jvn6Yhwrz3bSjpv5nzdM6y4rkfmDjig7WL8gsg4=;
 b=q7OYTMGmXx/7SVZ34jY2Dwd+88odxv+5uslE8SdOcQhpKQajvKIv8Czb6La1qzvVf5
 YcbuMJWBz2JEgar58TilZWbg6aLuETW0Ll59DGIP2opYhYeO7+XlFg8z9y5Wd1+d7rdh
 vdwGa+q42cZed4yQbDoGTn5PT/TSpnDER+sbM1yhLKhwSGFoFHf1tTIpUdJ2rFBOLkO0
 kQj5qa2mzz7rTTV0j10Xi26ILI22uE+zB0Old6wKZWgYddUHAbxXYZuSNm0z95L8sWC7
 2k2C9e5XUcJrXpM3kY6HtXFhRmLZ4JsndmcIQ0tmmyM8XU/X7032bIK0e/AhyNXA4UCb
 uAdA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUDkV3CXki3XfCWQ+5JTQWiElYuUY+5bnORmbvHgxZTS36II7LTIbFZBkXnKm9bairNrHxT0rP6NCz9@nongnu.org
X-Gm-Message-State: AOJu0Yy94Q2A/RFRvTZ68A0BLafbTLiT7nhz3WirHBrDR1fNdnY8PwF6
 wKTdQLtQ1nYat8nhk4R3ChjqQYI+psSQL10KUYq3rwZlh8HBMC7bQBBLAfyQfwyKgXQ=
X-Gm-Gg: ASbGncvDshNnDONHZgn4xH2CVqhy21mIjkoEOespFMhA8bskrfxShWwmd9AQoMLJ/mV
 6a2DM6MdN1Xw66JP/i+EQ4YABzsZvhjFqY9qAKhOuZ/pFtCbw9p71Sa0nQ8KJMs4H4Ho4XXRMkN
 vgTMIFuNC23wEiL1td2IP9Gs4c7NidE7y5bDybu2CObOftRIBYa24ka3VyjRsovBwF4mG6rQHzQ
 yzo4t47JIxRj061HXkcpi0q8YyuydDJmvc9BrB3Il5q9t4oAL2VKOWeuxblcOn+J7hCCJLwT+5q
 T9kXH92jkGOisQQ6EoF0/OZOZQAVC6kEMonUP5VhENlwJqP1vHyJkeO+YCg6E0bayqpjat0A4Kq
 r2iyOW9L31Qy+aWir0LuDZHhaPPHxpLNJ7nu/1mgzCgbzIA==
X-Google-Smtp-Source: AGHT+IFdtcFpVQtfia5Y19J5hFX4ExR3n5Da5rtLa2hb3BCNesVDaPR8R16diSV223tV0grYofgVmg==
X-Received: by 2002:a17:903:247:b0:240:3eb9:5363 with SMTP id
 d9443c01a7336-242c21e082fmr44637545ad.27.1754669657119; 
 Fri, 08 Aug 2025 09:14:17 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-241e8aaaa75sm214085415ad.154.2025.08.08.09.14.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 Aug 2025 09:14:16 -0700 (PDT)
Message-ID: <9ebe5c4a-b88c-4622-b809-a9085787d841@linaro.org>
Date: Fri, 8 Aug 2025 09:14:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 17/18] whpx: arm64: gicv3: add migration blocker
Content-Language: en-US
To: Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>, Phil Dennis-Jordan
 <phil@philjordan.eu>, Ani Sinha <anisinha@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Alexander Graf <agraf@csgraf.de>,
 Peter Maydell <peter.maydell@linaro.org>, Mads Ynddal <mads@ynddal.dk>,
 Sunil Muthuswamy <sunilmut@microsoft.com>, Zhao Liu <zhao1.liu@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, Cameron Esfahani <dirty@apple.com>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Shannon Zhao <shannon.zhaosl@gmail.com>,
 qemu-arm@nongnu.org, Yanan Wang <wangyanan55@huawei.com>
References: <20250808065419.47415-1-mohamed@unpredictable.fr>
 <20250808065419.47415-18-mohamed@unpredictable.fr>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250808065419.47415-18-mohamed@unpredictable.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On 8/7/25 11:54 PM, Mohamed Mediouni wrote:
> GICv3 state save-restore is currently not implemented yet.
> 
> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> ---
>   hw/intc/arm_gicv3_whpx.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/hw/intc/arm_gicv3_whpx.c b/hw/intc/arm_gicv3_whpx.c
> index 35dc5ac531..700b2a1a2f 100644
> --- a/hw/intc/arm_gicv3_whpx.c
> +++ b/hw/intc/arm_gicv3_whpx.c
> @@ -17,6 +17,7 @@
>   #include "system/whpx-internal.h"
>   #include "gicv3_internal.h"
>   #include "vgic_common.h"
> +#include "migration/blocker.h"
>   #include "qom/object.h"
>   #include "target/arm/cpregs.h"
>   
> @@ -228,6 +229,15 @@ static void whpx_gicv3_realize(DeviceState *dev, Error **errp)
>           error_setg(errp, "Nested virtualisation not currently supported by WHPX.");
>           return;
>       }
> +
> +    Error *whpx_migration_blocker = NULL;
> +
> +    error_setg(&whpx_migration_blocker,
> +        "Live migration disabled because GIC state save/restore not supported on WHPX");
> +    if (migrate_add_blocker(&whpx_migration_blocker, errp)) {
> +        error_free(whpx_migration_blocker);
> +        return;
> +    }
>   }
>   
>   static void whpx_gicv3_class_init(ObjectClass *klass, const void *data)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


