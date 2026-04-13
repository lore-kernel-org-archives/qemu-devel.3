Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACC5AF3ED5C
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2026 06:10:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCAUb-0007jN-KG; Mon, 13 Apr 2026 02:09:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wCAUY-0007jA-53
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 02:09:50 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wCAUV-0001e2-3m
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 02:09:48 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-82cebbdbdccso1878473b3a.1
 for <qemu-devel@nongnu.org>; Sun, 12 Apr 2026 23:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776060585; x=1776665385; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TuC21pMdlK4M0FWowMlQiYUEtaQiSnTIDnzYdYSOpEI=;
 b=lKoMPqwECQ1mnlLVwul4aFi+OUJJnYdzoFumO1NN7OEJC2jeTBR0dw9BYb3LbfHwLH
 BXRIW/zWClMdZhRc04PBB82mnMro3Yeo2UnK1GvHIQvPxssVxzn7iGcaBtbup9nFLx9X
 mTn67xOIZ7egWvXxP9QpoEapRQXLol9DzpeazvnUba1sf/U6ncLwbuDcsF8fJGTN0iPW
 FiXiPa+G2abKcGfzfn3XlbENkJ3EgVt2MDIzU05+uyOaCXWTdQDwZXuKpiOMzFoGjm44
 PZMr/dFAR2Dv+ypM6ZnDjAR+GQAVH1pK8VLqHYCF1tL4ptoHKvMbD++2m8phbMYhi566
 eKNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776060585; x=1776665385;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TuC21pMdlK4M0FWowMlQiYUEtaQiSnTIDnzYdYSOpEI=;
 b=o5ML2k7aEB/LnYCNelF+yg5c0wuO3egiSkNNAA17zFMMmPyuPySM1t7WOyqm/MSCHa
 kWujV27URpCLKixkyQR/MSVxu4HWNC4ntvkhWK1tX2kcrAJGCf6jyPGI1/F+mlN/l5Xf
 NVNXHeWjPzCwjMJICj3aORVbUIliOyqZxM6OnZoJvLlwwN02tN27s2yISpEDpwQ/wkw/
 X/b4eKZz1Jhu/7YAbLF0UyvZ9ChvbypI2r5+NMb0GBxY1+iqrfS++ghUZLEIrxaSIsSA
 SWA59I3mKSXx6e+YnzuktDt0F07o9KV1YHxYd3QlZhhcD5RY81DOgoq/4x2bN9brVjYZ
 01rg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9NNZwQPV/g85fjKkRVq0ZxFMdYcxUV/vY3L3bVvgJKeo6BalOiR86WVI+NyuUDEHwEyYjkLG7UW0Uy@nongnu.org
X-Gm-Message-State: AOJu0YzDiRlPwUPeZJG/E/XBoO732DPPtWrNd/XREWP+Fg1DZDbN6TbX
 5FWs86ykvOazfcqlY6Nh6BioJ6n/KeH+qkNulOnDBaKot4I3LAylHTpL7zHUhL2gOeNmTPL0/M7
 c9zjCR3Y=
X-Gm-Gg: AeBDiesjG2Eh9w2j9I4QcQrL7g1FQ/VoruavtE0BjOl7oe0szPFbMNavOwp+EtfiuRh
 Jq73L5x5QE8MEJnM6uMfqnXe51wT2OdABmRCT+clmuINz8ndOHgUKN6voZ7J5ryaa2MXJn3i75J
 ioG28R2gJOEHaj+mJkzmGOhuQyFohr7vW1jc75QvvsSNC7xCkmPUJI0ywezky5VSsfY8jqjBmZq
 DOgmVAS7BTuhsIrEGtz+nPR0AoZ5Q1SPOAheIQdfNTUcdl3KqYR7rB+b6jyeXY3I7ptyXoPlQ+N
 Wq5nwnFjZDauntyi3LaPbBubVGushiM0vi0ogCoB4zt/b1fl0mkhYgV7IFeQluBy7yjUj+D2SDB
 oSZJA0oiavLI6FU2SMAZLaUO4OOhTjrgAInu0sZxtKICGPG87BOZsKXVHqmLJcztKxEQc+C56De
 Vn6khmMM7rgeYqKsBvOWDIoIopZUN0TuXceXBbal2gu33Lr+KmZgvOu8Cu1EEogtEiSOeJC+oqF
 yjYYKyjjjYwEFILpjoZSzNdo/b/J2F6YTnDaidvZwm4gb7vZR7xl5c=
X-Received: by 2002:a05:6a00:4fcf:b0:82c:9c4e:66ca with SMTP id
 d2e1a72fcca58-82f0d0d190dmr9127151b3a.2.1776060584748; 
 Sun, 12 Apr 2026 23:09:44 -0700 (PDT)
Received: from ?IPV6:2401:d002:dc0f:2100:a7b4:d4f1:5b23:321f?
 (bg30dj032xp6rdh0yngy.ip6.superloop.au.
 [2401:d002:dc0f:2100:a7b4:d4f1:5b23:321f])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82f0c377318sm9595687b3a.26.2026.04.12.23.09.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 12 Apr 2026 23:09:44 -0700 (PDT)
Message-ID: <4c99eb47-ec05-4d5c-b733-77114cb10855@linaro.org>
Date: Mon, 13 Apr 2026 16:09:39 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 21/27] monitor: Do not check TARGET_S390X to build
 s390x commands
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20260410195323.17937-1-philmd@linaro.org>
 <20260410195323.17937-22-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260410195323.17937-22-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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

On 4/11/26 05:53, Philippe Mathieu-Daudé wrote:
> These commands are filtered at build-time for s390x binary.
> By using the recently introducedHMPCommand::arch_bitmask flag
> we can filter them at runtime, making it possible to compile
> hmp-commands[-info].hx files once.
> 
> Since the methods are used inconditionally within hw/s390x/,
> define them in the same stub file.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   MAINTAINERS               |  1 +
>   include/monitor/hmp.h     |  7 +++++++
>   monitor/hmp-target.c      |  5 -----
>   stubs/hmp-cmds-hw-s390x.c | 15 +++++++++++++++
>   hmp-commands-info.hx      |  6 ++----
>   hmp-commands.hx           |  6 ++----
>   stubs/meson.build         |  1 +
>   7 files changed, 28 insertions(+), 13 deletions(-)
>   create mode 100644 stubs/hmp-cmds-hw-s390x.c

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

