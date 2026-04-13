Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 370D6F3ED5C
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2026 06:10:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCAV6-0007ul-5u; Mon, 13 Apr 2026 02:10:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wCAV4-0007tI-J2
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 02:10:22 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wCAV2-00028S-UU
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 02:10:22 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-c06cb8004e8so1519081a12.0
 for <qemu-devel@nongnu.org>; Sun, 12 Apr 2026 23:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776060619; x=1776665419; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MLX4wCcIiSlsY6hRCQ1Ru6myBQTf7/t2qWLiRvGjQbw=;
 b=Cg5uUg17Ku+KUSOATmpXWVy2f/FzwQ7PsP9p5P7r89vh0G8ivBb6B8AvYthb5L0VwM
 oR4Tg5zH2JBkUFb/eOXl68/QtXMaktJzkKBSHfJkHWQ7yB2mmPjAUncYgTRzWB5nJzGG
 LdwdGE7xK81tcb3R8F6Y1wIahxoQwfATiPvxM0Psh+L19c9v+2R1usBftVLU5QE2cH31
 i4dwvwv7uoiGqSLoWGmiEWQx4SYO/Szs5OjS5Kkb24WlWwG+dhFM0StIaQQPvVMvCK8/
 vi0C9AGnFOeLpiZOdvs5pxQqaRvHuXLq2UXwgP5rrlV3zwtqO8svZJrvQ7MAnDkuzONj
 PvPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776060619; x=1776665419;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MLX4wCcIiSlsY6hRCQ1Ru6myBQTf7/t2qWLiRvGjQbw=;
 b=BlcICbwAuUT2DNAOiVYYtk7xucOGVf3Zc53tbCkOiPFGonVAulijWBB7r55P3J6UFN
 dyxTxZtroCQ8eyrmESA3JSqCdPpSimGxPpGE2/SIgZSvrr5LZOnRm4Hu9yv/psKArz9Q
 rvgQeHH0/14j098vMjBSH2ok63tP9J46w9XXo8uOFPhHSEfGCkzP0pYcYQL7kUP16vWN
 UBFRDMKVvFLINqP9WRaIUzH0Ma9Ah3wDJTPhwqexRWDFQmJATapF8t+Ls4OMQrGTSTB8
 Ly1vMCsD80+4g/XQl2EEpox+ci8bs+frkDlPq2u/A+JwI29FaleWWJWUGEQ/2nYMTfB9
 PP0w==
X-Forwarded-Encrypted: i=1;
 AFNElJ/qmdtpOn2EKCaC+a04Ni3kptnLv7u79k+eoEYfn1rqiWN0J4MQPdeo5NZgOG3uUzoYh8PdsiqiKCzP@nongnu.org
X-Gm-Message-State: AOJu0YyH4aewvoiD7qPBldsjM96kX/VfDZnuSYXe+2D6+H4L0aAP8qSi
 87NZc2YxDXm3NzB4oROf+0uZJy+RO436cJ5MyVIyvUecU5ggictlRVgQrspbpWY0JLg=
X-Gm-Gg: AeBDievHhPAelYPypzMh5sCb13Gb8sRr/R2zbMswqANBKYGRnTU6RmGdhdKpPqT7RwK
 y8ICoCCXu2JpINAu+igcIwgpXl4zSTHPbg3RZSqtA58O8nEsAcnVANjk8VkI6E9kLzZMa5aHq8p
 RkhltxRynPpJU4+Tc69UqYTBw+/c+BS/gM4M2VYWGAK0rH/tja5R6eE8LUAlJux7go1fjGqzWG8
 drOEALjjFtgTUZa0QOHUXhPqeS46mF0X89llRqZwmeamIQ3mUXd28DLkONIkuGmCASF1vUUrWcO
 N6tiVGjnTBfvANxlL1SyFMQsoCn3EeaPOkrSiOoBSeWAkD8gyoN/YSsdI3N6S4AwyR/HZRyN69A
 9cmqPQ3chB7Rqr8xwASxKEd1xxMCNvhKE9sHu5X/sUGfltCz5OtpzlVUO4556OGTGfAtHvSbOQB
 03m03PEg9A7XOy74xgEedBgUUR0Vyb6MoO+1pHaI5JySI+o9212wAs1TURIii4cJzxB4J0HbAwB
 WKfZ9eluH1L0bKUC2oyiUiD
X-Received: by 2002:a05:6a20:12d3:b0:39f:a91:783 with SMTP id
 adf61e73a8af0-39fe3c92b4amr13371087637.4.1776060619353; 
 Sun, 12 Apr 2026 23:10:19 -0700 (PDT)
Received: from ?IPV6:2401:d002:dc0f:2100:a7b4:d4f1:5b23:321f?
 ([2401:d002:dc0f:2100:a7b4:d4f1:5b23:321f])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c793488d824sm4539217a12.16.2026.04.12.23.10.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 12 Apr 2026 23:10:18 -0700 (PDT)
Message-ID: <ff17fdcd-5841-42aa-b381-7dc26205c27d@linaro.org>
Date: Mon, 13 Apr 2026 16:10:14 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 22/27] monitor: Do not check TARGET_I386 to build
 target/i386/ commands
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20260410195323.17937-1-philmd@linaro.org>
 <20260410195323.17937-23-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260410195323.17937-23-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52c.google.com
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
> These commands are filtered at build-time for i386/x86_64 binaries.
> By using the recently introducedHMPCommand::arch_bitmask flag
> we can filter them at runtime, making it possible to compile
> hmp-commands[-info].hx files once.
> 
> Since these methods are used inconditionally within target/i386/,
> define them in the same stub file.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   MAINTAINERS                  |  1 +
>   stubs/hmp-cmds-target-i386.c | 13 +++++++++++++
>   hmp-commands-info.hx         |  4 +---
>   hmp-commands.hx              |  5 +----
>   stubs/meson.build            |  1 +
>   5 files changed, 17 insertions(+), 7 deletions(-)
>   create mode 100644 stubs/hmp-cmds-target-i386.c

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

