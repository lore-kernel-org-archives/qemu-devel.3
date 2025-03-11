Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F6F1C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 17:48:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ts3hQ-00016P-EX; Tue, 11 Mar 2025 13:47:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ts3h0-00011t-DQ
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 13:47:02 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ts3gp-0000eE-Oq
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 13:47:00 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-2ff4a4f901fso8726006a91.2
 for <qemu-devel@nongnu.org>; Tue, 11 Mar 2025 10:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741715210; x=1742320010; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xMbQfB6FZjsgaL0CpuJkTh1ZPBBTDvDEkwVBdCkUPFk=;
 b=D9gXZCCL9iauTJAVaYVB5jJ8yomAJ2B+yaTp5mAsIwnemcd0h/Z5HZgfVGjXYTuOzE
 mbsXEUk3F3pd+1jeyRTwBVmmADP/3ihN2r3Q6wVHOphw4zQgdZcEmo+ytXuInN/I8wOe
 wsrEZP9xWIPFgiRjNC+K5yo2vI3Dnxax4g89+woNusqtjQePio92MrY3530YSwUrQlx3
 Di1JLZcScU+voYGrSZJlVidJHcu6TgQKIKSPQokdGfzqixgfFDDaWXjwbOlUnXwbfhh5
 Sbmvar/DfI7xPg+P0P8VjAzlaTPgRz3CyD9EamdK9REX+JtYlkeP5C/ACxaBFXonIZ+E
 sA/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741715210; x=1742320010;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xMbQfB6FZjsgaL0CpuJkTh1ZPBBTDvDEkwVBdCkUPFk=;
 b=o6LdK/BrcdrjWTNV31JQIZeSXWdM05tRulRqBCvNmGED/m/ULWKW/fUWrxfXmf/LH/
 Z+g/Ctr2i0ZiuEZXyNV9AaSX37GelPcdtRE4ZYFF/KpwByacaSh9s/97ogWREYLKuUEu
 UiHkn3Cjo39XRg4kpLu3A6qNI6VSIr3iTa9TsY91cld4yFoMsHoNUKFs3kDfB/M46HCM
 hHpa3mNOMtv/GGfk/GsnBKWIBVdj8JsSXQTKRYBj7klc3Wpd7EoNfQe6ekw244HrYerM
 FZdEL0w9nrJzHRcKW52jns1KPyLQ84MuLno7dArJZ/12u2URqLWM886oGVn+KaHgdAtD
 c9Yw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUv3KHZBn9ayHZd0AEY0qUq6hZdMspqSBE9RKZY17hMlW+FZIoPHjI40nFPpQQHwa1fZ9WrwCTCz9Ot@nongnu.org
X-Gm-Message-State: AOJu0YxBXrYiVeIp/IulY6pfsHwk9+inp2rk/1SqwUiIRAo6gelmzFAJ
 PhIQ850vEFF0HNzJW/PlZC+m9q4B8i3OIHLrf0vbfeAZxj1n+D7bOYgc7VK0AOY=
X-Gm-Gg: ASbGnctqBrEdLkD2IszkCw6pA5VWoOGQ3ojDU3Z73K9TsAkBHrO5ZNARZNPftMKpVVT
 OlEgEv21uzo7YYgu+oAuyW1/9pCjh8gYtimdfs88G4Q4nuhDHvfebgNuRo8RM2n0BlUvuxxwi3U
 y4gjkAb2JegT17fDAMPO+QTjdAGdlGOZnLas9KZ/e9UbpJN0+HUkBAuLIiR5yAm3XT6RCsGVEjh
 avg7zQ5VNxpSLlyXaAGrWx+DWeDfpkMlTaXXM2399CLsbOo+sNwhHrcMdOaftvHPP5De3XzBF8Z
 yGOkto7XW726zIcaKWtxosBSYM2L7EfpfPl12DUr61jqatOoLk5qMRjeXaArRgGitrCeYlATocy
 p/ZvMYSyK
X-Google-Smtp-Source: AGHT+IGfBITfOBMekM7FglGYIYkXQUwam35Q1HRhFYoS8dUppiXAEfrrgYbbEaPwb96+GddI6xCMog==
X-Received: by 2002:a17:90b:2b88:b0:2fe:8902:9ecd with SMTP id
 98e67ed59e1d1-300ff0a9f50mr5373583a91.1.1741715209746; 
 Tue, 11 Mar 2025 10:46:49 -0700 (PDT)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ff693746b9sm10210115a91.27.2025.03.11.10.46.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Mar 2025 10:46:49 -0700 (PDT)
Message-ID: <003e9831-2d15-4142-81c5-58bd973289e1@linaro.org>
Date: Tue, 11 Mar 2025 10:46:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/14] arm/cpu: Store aa64smfr0 into the idregs array
To: Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
References: <20250311162824.199721-1-cohuck@redhat.com>
 <20250311162824.199721-9-cohuck@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250311162824.199721-9-cohuck@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1036.google.com
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

On 3/11/25 09:28, Cornelia Huck wrote:
> From: Eric Auger<eric.auger@redhat.com>
> 
> Signed-off-by: Eric Auger<eric.auger@redhat.com>
> Signed-off-by: Cornelia Huck<cohuck@redhat.com>
> ---
>   target/arm/cpu-features.h | 6 +++---
>   target/arm/cpu.h          | 1 -
>   target/arm/cpu64.c        | 7 ++-----
>   target/arm/helper.c       | 2 +-
>   target/arm/kvm.c          | 3 +--
>   target/arm/tcg/cpu64.c    | 4 ++--
>   6 files changed, 9 insertions(+), 14 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

