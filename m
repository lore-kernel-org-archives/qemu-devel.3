Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD3BFCAC5B0
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Oct 2025 17:52:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v56Pv-00050M-Bu; Sat, 04 Oct 2025 13:51:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v56Pi-0004z9-Ua
 for qemu-devel@nongnu.org; Sat, 04 Oct 2025 13:51:24 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v56Pg-0007uu-72
 for qemu-devel@nongnu.org; Sat, 04 Oct 2025 13:51:22 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-781206cce18so2916455b3a.0
 for <qemu-devel@nongnu.org>; Sat, 04 Oct 2025 10:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759600278; x=1760205078; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dOQ9sN4EO5SB4zFbuW2MVhbBdWTmAqE0qRYFcWUyUpE=;
 b=mw3PAWgjs6PRqwSwuIKyZ74lp8FJylg9MWLGce3SMCAu6xcOGtoHb0h3AWmNZDd1HI
 0rkQ+Xu7eEL1HwxxWMqr+Jj4J8NCvZZtJnNXUxTZX+T6i2rMI4eAgB5Thdn7vk+/3+Yt
 e4bk5ed7Ag5kH1zelRCSasmQIfbFcUxMWBCeq7TokkciYR0CK3p5nppL1LUttpz+Edfi
 LgifgQVR0SQ7kcHj5M5CT57tqYQPFbdb8obEUXWL3W5mH1Y5u7Rs/1P2aHDJK53RC1jC
 0HDiL+eqpdFo3txqtqA8aFghfazlOHjtw0aTO/JLUf/Nvi947yaGtw0dQHiYHvdE3Won
 Qe6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759600278; x=1760205078;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dOQ9sN4EO5SB4zFbuW2MVhbBdWTmAqE0qRYFcWUyUpE=;
 b=HnDxbofTvwjssksez3rAebIkJxxWlFMXwuVJDIVNndVilv07QPcr5cThxDp1hF/Z1Z
 /WiZWfYXqJGjXAWOkvhvbSnGdLMaRoqQPweebtdgfxlBdE29mFG+cQm/9Da0CFdUz9ww
 B8A7gB4mym25QAR3n6ZNcq7JR5SLH3G5yyrEgRIPhoQ6AsTNlbcKFtGRiMN4/D/+fBrH
 GwZPEMcPdjKGG/CrsGueNd8owRhvsbLUH1yynjvU2a0YCfbIG4VmY6OruWrYYQ7wFA6O
 uA7vQMYrHjXzBR+/OMgBgnS2V78h/o33oZtJAlBR9obi77YmMo6Yuiioap9OAw1wti8+
 yP0g==
X-Gm-Message-State: AOJu0YxaSzm0lKrAul9a+RrvJYsSkhO9JlYn9Nwfe7o3PuLjD8z505Oq
 W4OOpT1UtqpwJ2+oyYElJmIKn4CLjmvfve08RzVGpHGyaBC81sPcHHb7RYxzZS90j9jspoZWcJd
 r+soTwnk=
X-Gm-Gg: ASbGncsDojAw8g2aMnehJYDwIYv+dwEF/nWdIKdaWgiimkuFoL6ttqeHwFNl6DAWwau
 RDGo6K/S8B+j/BlkIIipXSYshMF0RE4ygAT1hzUMAx6nSt2Ze0DfB9M8aZiwtDqmxM0YnPUTw/r
 wWrudZL6gimdmMm0y0CySRFXOwoEJmfmSUh4Dkm0K9c6hoILs9OXQ0KVUa8SFcy+ScO9u7c7K5h
 kLPgDladYKAzNZjUOTkk7hiZ9JF3gvFHk9hCEIYTOJl8yydD1a5pFSl+mVILngZMhqxGSxGKuM7
 S+ze6x8Z4bDj/whlCoAqOEpWkKlfHTj/MqYTLJjauCHJbvVXn5WrA0fuhOReGiDYc9cT2f9fQDf
 BapcQ9hQJTrDnba4vCvM/IT0x1on/AQNU7+Kgp2XBnFpxRvxS3Vfic0r1Jobu7XavlrsDwEgHkZ
 w=
X-Google-Smtp-Source: AGHT+IFOKlyhVRC5aVIQxmUyXuFgfVzGiW5F5CM0ADicv1sFSbNuqhoIJ0H+PqBqAtTwqblJuMgKfw==
X-Received: by 2002:a05:6a00:22c5:b0:76b:ecf2:7ece with SMTP id
 d2e1a72fcca58-78b024a6b8bmr11836339b3a.12.1759600277738; 
 Sat, 04 Oct 2025 10:51:17 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-78b020539e4sm8113154b3a.59.2025.10.04.10.51.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 04 Oct 2025 10:51:17 -0700 (PDT)
Message-ID: <8066242e-853e-476b-8ce0-7b303ca67aa8@linaro.org>
Date: Sat, 4 Oct 2025 10:51:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 15/41] target/i386/whpx: Replace legacy
 cpu_physical_memory_rw() call
To: qemu-devel@nongnu.org
References: <20251004071307.37521-1-philmd@linaro.org>
 <20251004071307.37521-16-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251004071307.37521-16-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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

On 10/4/25 00:12, Philippe Mathieu-Daudé wrote:
> Get the vCPU address space and convert the legacy
> cpu_physical_memory_rw() by address_space_rw().
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Message-Id: <20251002084203.63899-10-philmd@linaro.org>
> ---
>   target/i386/whpx/whpx-all.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
> index 2a85168ed51..82ba177c4a5 100644
> --- a/target/i386/whpx/whpx-all.c
> +++ b/target/i386/whpx/whpx-all.c
> @@ -788,8 +788,11 @@ static HRESULT CALLBACK whpx_emu_mmio_callback(
>       void *ctx,
>       WHV_EMULATOR_MEMORY_ACCESS_INFO *ma)
>   {
> -    cpu_physical_memory_rw(ma->GpaAddress, ma->Data, ma->AccessSize,
> -                           ma->Direction);
> +    CPUState *cpu = (CPUState *)ctx;
> +    AddressSpace *as = cpu_addressspace(cs, MEMTXATTRS_UNSPECIFIED);
> +
> +    address_space_rw(as, ma->GpaAddress, MEMTXATTRS_UNSPECIFIED,
> +                     ma->Data, ma->AccessSize, ma->Direction);
>       return S_OK;
>   }
>   

Build fails: https://gitlab.com/qemu-project/qemu/-/jobs/11605808806
Mismatch cs/cpu in there.


r~

