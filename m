Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADBF4C43458
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2026 19:57:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wg6Tl-0001Y4-Hk; Sat, 04 Jul 2026 15:56:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wg6Tf-0001Xb-73
 for qemu-devel@nongnu.org; Sat, 04 Jul 2026 15:56:39 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wg6Td-0002lh-Ky
 for qemu-devel@nongnu.org; Sat, 04 Jul 2026 15:56:38 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-3847e8b0f3aso345190a91.3
 for <qemu-devel@nongnu.org>; Sat, 04 Jul 2026 12:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783194996; x=1783799796; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=z0OSqNhMMeE+ZdGERI7cdk+gLghNfDYcwh0t9cxK7P4=;
 b=Y/CAqdMoRGZliVyN5V+8WTB/FGaQrqTeQbR02lIYNlhQKBBynekCG/3dSRwom5Cz1f
 nIgTh+dnh3TelFUDDWLeMw8m/4PElszuMfY5Ha5DN67s+g2Jz9A1QBEYX37x38XEU3YY
 XRv9Ic3XljdpqieNSfDGgr+F/0Az/XVssHj29CVZC9JIlehjRcSdFCQ2AdkXLvMRAoE1
 FjiMfW83QNofl187dElBJdHxLe/YHii6/f8TdPuxixidnh60bp2z3nCvsgVv3xIhZ7ES
 k3drbE+4PGBY5KQVoJhPfMJGjnFpyFwAZdkfJdRt8OGbViz6M7JctIyhlp2EXvgzG5t2
 D1hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783194996; x=1783799796;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=z0OSqNhMMeE+ZdGERI7cdk+gLghNfDYcwh0t9cxK7P4=;
 b=Yki0iJ3CWI6FANWuCVU7qX80U6FFxTNB1MBjpyjTZrMEnV2JVIqulc5uGmTGkzS1cQ
 u2PtOLTGyB8wZUWIuAiqTfzBtOgDnkIrwfSoBnRdJ6/sgI8mhT9nQHX90YW5V8Uo4Hox
 ZXHHLIrjZmA73iWUvnclkLnHyECHAKdpj6Ox9pvJZJMhNO1+A+z829x6lepYNk3zineA
 P3mbR5BonsmCRmZBtPGZbJNSo+OiSRUYvEYYqzNqXnGG8FuCTsRj4hgd3Fdm5li+n5Aq
 WxwTtXAF/RUh3CiExy9oJVvAKdMJy6LuvLYgsHbtw4wi4Uj9G/rVPE+PC+1gq1GxXcPC
 BBUg==
X-Forwarded-Encrypted: i=1;
 AHgh+Roj2HwY1WZQdr56ODPFpw0dFusuidVuhdofWbP1mWEIPUQYLUcyA+9OTV5umB0GMiij6SAmTBIUq0rZ@nongnu.org
X-Gm-Message-State: AOJu0Yz0d1Evvv2eOMwcPKXnNisVuvP1obFK/LTnXDQJVlH71jFqIyFf
 SV43R27/VN0AmzwOOI1+2gKZrZVC/zth1mMTuuUeGYANeDVCEBRRKP6EPNvclu46yW0=
X-Gm-Gg: AfdE7cmZ62HhZ4uvPOmQkP2g3o3npDDJw2Ekz+W1m8KjXToGwD+tI6SPNxMAu/VraSd
 CoNuFfxS43A3w7lz4H2gQj0NN2PE4B4lhY1+H52lqM/kBpj8VYgQCU17tyvacWqgpXtvt4tgABE
 qfdrR05o5sRdf+WAjQGqPJD6iKxNBy7J3YES6fGJb7UvijtvHluWCDbLLOgm1yZkrkBDWfyLq2u
 lhCZJWKxxvPrbtX/uvUNqMZFtW3bJqz+wVu3Cs/AyJ3toB+xDYSTreP+Zer3sB8JHr7HN1tF+8+
 NJXl4gp5gRK4LjOdnhH7yzMStDBjaUIOboUBgGICy5nssDw7hmxuAREhd5zCMURtWzxPb/24miH
 GbVDvbugkAE2kimkl52F5a4WAkdbucQhGzC9MSTbkXGgzWkLUebV1zVweVGesNJRTRxBN89id3+
 lXyMvAwW3bEcaxvQ7hWJECD30LM1bYxpiJjmresVYtPkwz3/wtaoo97ks=
X-Received: by 2002:a17:90b:1810:b0:37f:9ce1:cdaf with SMTP id
 98e67ed59e1d1-3829f9deb8fmr4875880a91.29.1783194996218; 
 Sat, 04 Jul 2026 12:56:36 -0700 (PDT)
Received: from [192.168.0.4] (71-212-39-188.tukw.qwest.net. [71.212.39.188])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3835bd053d1sm861340a91.2.2026.07.04.12.56.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 04 Jul 2026 12:56:35 -0700 (PDT)
Message-ID: <498d4984-58fd-488d-b504-4fbee70cfc70@linaro.org>
Date: Sat, 4 Jul 2026 12:56:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 20/33] cpu: Define BreakpointFlags type
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Chao Liu <chao.liu.zevorn@gmail.com>, qemu-s390x@nongnu.org,
 Xiaoyao Li <xiaoyao.li@intel.com>, Zhao Liu <zhao1.liu@intel.com>,
 alex.bennee@linaro.org, Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-ppc@nongnu.org,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20260703163757.55500-1-philmd@oss.qualcomm.com>
 <20260703163757.55500-21-philmd@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260703163757.55500-21-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1035.google.com
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

On 7/3/26 09:37, Philippe Mathieu-Daudé wrote:
> --- a/include/exec/breakpoint.h
> +++ b/include/exec/breakpoint.h
> @@ -12,6 +12,7 @@
>   #include "exec/vaddr.h"
>   #include "exec/memattrs.h"
>   
> +typedef int BreakpointFlags;
>   /* Breakpoint/watchpoint flags */
>   #define BP_MEM_READ           0x01
>   #define BP_MEM_WRITE          0x02
> @@ -28,7 +29,7 @@
>   
>   typedef struct CPUBreakpoint {
>       vaddr pc;
> -    int flags; /* BP_* */
> +    BreakpointFlags flags;
>       QTAILQ_ENTRY(CPUBreakpoint) entry;
>   } CPUBreakpoint;

Missing the replacement in CPUWatchpoint.

> -void cpu_watchpoint_remove_all(CPUState *cpu, int mask);
> +void cpu_watchpoint_remove_all(CPUState *cpu, BreakpointFlags flags);

Please don't rename mask to flags.  Several instances.

The arguments that are 'flags' are installed/compared exactly (==), and the arguments that 
are 'mask' are used as bitmasks (&).


r~

