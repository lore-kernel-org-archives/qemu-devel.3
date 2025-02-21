Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A8C3C021B3
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 17:02:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlWPn-0003Cj-9f; Fri, 21 Feb 2025 12:02:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tlWPP-00035V-NZ
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 12:01:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tlWPO-00018Z-4F
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 12:01:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740157308;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=wAUly4KhHlVeRCeHaDBLg8bXsoC/IXf/HW2qCiJewmk=;
 b=WgVuMDFxWPv02Ar4xCRgkMlhz5Xa4ZLtQSSz0WIOMUvSaru1ZNdHg+X9KvC+P1HfQ1c0w3
 GatBqpNrC1rJQxaK4LIJNpGNwmmABRDyXdd4ItXX3Cp8QNhc8xHkLddN3Igs+lESqW0dyC
 rvhSBUvFaKWaqoiNV86xjRwpGF0YcEU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-407-99reXSnAM2WyoCmSqF5MgQ-1; Fri, 21 Feb 2025 12:01:46 -0500
X-MC-Unique: 99reXSnAM2WyoCmSqF5MgQ-1
X-Mimecast-MFC-AGG-ID: 99reXSnAM2WyoCmSqF5MgQ_1740157305
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4393b6763a3so10928755e9.2
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2025 09:01:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740157305; x=1740762105;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wAUly4KhHlVeRCeHaDBLg8bXsoC/IXf/HW2qCiJewmk=;
 b=hiRvB5zMPtT/fs2vBjZYM9WX0cv55BPhO0Agf2enGZKxradK1jnngNTBs35ZSLaAp2
 7AOPiNMrVx7vyPx7qCAl3pgBiUMQY4//bNBCpnhMZ2JUvswNMgQZH9zYZ2w04KXDMTwv
 hrzZMHkwg/O0qKn6KHMg64E4B6SSOx+PolU1WJWGFy02rnjSnfXMnBL6CBTV8WkUS626
 uUFTmp/qHfa53UnJYSUqBSffA+wrCgoxVgZz1JEP7IqqIHid/Rb+XR5hcqnL7u6kRAD+
 67e10NUs8brx6VUAc4yNpUAFytxOTHo3jmtSEiGp7l8VCAxfx83rvs8AgE5ObTcI+SJO
 oqLA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU0Q6V+ukKfoffvem2HIPp5laBXy/roiekuKbCXEZcEiAELZRg2FscjFSnnCdFZKT6yydu2CZkWSHl5@nongnu.org
X-Gm-Message-State: AOJu0YzYyUZ659e1MsKxvJowAH2op+tKTNIbIAqssFAL/aPS2v++dN3m
 vYiFwxc6pgVN43j5L/F/cztztdrmoYvOnTK1va2snSyCQ/GsU3YekhrC1CbBHrq27zW/NOe83Hl
 OlLuWaSJSJzL/feOpYSJfRVyfr7TzhwMJYdp60RVH434I/mC7bVOouRo0f5LWUxU=
X-Gm-Gg: ASbGncvHKaigw9wwQxOTtX2iUpuJIOlUBi+EVSebL5+dy0NgHvKwHIWtFM1v4+KGIll
 qIBNFW1xi0kdZgw7/5Uwp1U1yEuLEHNeJX/TrexJEGJfC/mqTdRvjNJDhZ5B1Z/1TNvEC80v5Ko
 cGM17aqot8VBgIQl42RM+dAGlKqXxxr2iaa2azfUTxUROX9Zcgvf67yoJhyc6w5C7yxcCgTzCEm
 EJhtb76MEvV78hS9/hvd6jbcsRrH9GHJSao1YJoLWwQKovUCD49oWNgbUhc+lWU9wDGaRPfhTEy
 NrcPS2LfA1M6Zi7IJME=
X-Received: by 2002:a05:600c:5253:b0:439:a093:fffe with SMTP id
 5b1f17b1804b1-439ae1e9601mr37851675e9.7.1740157305139; 
 Fri, 21 Feb 2025 09:01:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEcTPxhDiHweEndiePmzQ66eyjSmhewgWnuS3oExvLBV3TRt/NM9LhpawkyRMkPlC7rPsZfOw==
X-Received: by 2002:a05:600c:5253:b0:439:a093:fffe with SMTP id
 5b1f17b1804b1-439ae1e9601mr37851175e9.7.1740157304724; 
 Fri, 21 Feb 2025 09:01:44 -0800 (PST)
Received: from [192.168.10.81] ([151.95.61.185])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-439b031b62dsm22661135e9.35.2025.02.21.09.01.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Feb 2025 09:01:43 -0800 (PST)
Message-ID: <701a0452-8aa9-4bcd-b334-bdfca2d12fd4@redhat.com>
Date: Fri, 21 Feb 2025 18:01:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] pvg: do not enable it on cross-architecture targets
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Phil Dennis-Jordan <phil@philjordan.eu>
References: <20250220133306.1104382-1-pbonzini@redhat.com>
 <20250220133306.1104382-2-pbonzini@redhat.com>
 <df0b1287-1a4d-43ad-860a-59bcd6ec3c7e@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <df0b1287-1a4d-43ad-860a-59bcd6ec3c7e@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.424,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 2/20/25 16:19, Philippe Mathieu-Daudé wrote:
> Hmm what about keeping a MAC_PVG_COMMON instead:
> 
> -- >8 --
> --- a/hw/display/Kconfig
> +++ b/hw/display/Kconfig
> @@ -141,15 +141,17 @@ config XLNX_DISPLAYPORT
>   config DM163
>       bool
> 
> -config MAC_PVG
> +config MAC_PVG_COMMON
>       bool
> -    default y
> +    depends on MAC_PVG
> 
>   config MAC_PVG_MMIO
>       bool
> -    depends on MAC_PVG && AARCH64
> +    depends on AARCH64

It's possible, but the two "depends on MAC_PVG" cannot be removed here,
because otherwise MAC_PVG_PCI would be selected by "default y".  The
only reason to do so, in my opinion, was if one wanted to build pvg as
a module, otherwise it's just (a handful) more lines of code with no
particular benefit.

> -if host_os == 'darwin'
> -  system_ss.add(when: 'CONFIG_MAC_PVG',         if_true: [files('apple- 
> gfx.m'), pvg, metal])
> -  system_ss.add(when: 'CONFIG_MAC_PVG_PCI',     if_true: [files('apple- 
> gfx-pci.m'), pvg, metal])
> -  if cpu == 'aarch64'
> -    system_ss.add(when: 'CONFIG_MAC_PVG_MMIO',  if_true: [files('apple- 
> gfx-mmio.m'), pvg, metal])
> -  endif
> -endif
> +system_ss.add(when: 'CONFIG_MAC_PVG_COMMON', if_true: [files('apple- 
> gfx.m'), pvg, metal])
> +system_ss.add(when: 'CONFIG_MAC_PVG_PCI',    if_true: [files('apple- 
> gfx-pci.m'), pvg, metal])
> +system_ss.add(when: 'CONFIG_MAC_PVG_MMIO',   if_true: [files('apple- 
> gfx-mmio.m'), pvg, metal])

Removing the "if" is independent of whether you keep CONFIG_MAC_PVG_COMMON.
I can squash that in patch 2:

-if pvg.found()
-  system_ss.add(when: 'CONFIG_MAC_PVG_PCI',     if_true: [files('apple-gfx.m', 'apple-gfx-pci.m'), pvg])
-  system_ss.add(when: 'CONFIG_MAC_PVG_MMIO',    if_true: [files('apple-gfx.m', 'apple-gfx-mmio.m'), pvg])
-endif
+system_ss.add(when: [pvg, 'CONFIG_MAC_PVG_PCI'],     if_true: [files('apple-gfx.m', 'apple-gfx-pci.m')])
+system_ss.add(when: [pvg, 'CONFIG_MAC_PVG_MMIO'],    if_true: [files('apple-gfx.m', 'apple-gfx-mmio.m')])

(you need to keep the conditional, whether as "if" or "when:"; otherwise,
because Meson cannot know that the .m files will never be built, it
complains that you don't have an Objective-C compiler).

Paolo


