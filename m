Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B5FDCCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 07:45:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3rVb-0005b4-Hj; Wed, 01 Oct 2025 03:44:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3rVU-0005Jw-A7
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 03:44:12 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3rVK-0008QQ-7g
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 03:44:12 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-46e47cca387so50249915e9.3
 for <qemu-devel@nongnu.org>; Wed, 01 Oct 2025 00:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759304634; x=1759909434; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=50ZABzaAuXRvrwTkKyVl0AKOtqDw44bctJ5PxckI8vU=;
 b=Md7VTjOjaVJgreJpLw3qt9Bo6Q8fXVCrwH//Fknflxhahn3Itb88RWd0+DhbvIu9iG
 FcugEXkbyZqITv49vHViEwntierulGgMWA3vZGxSBF2aEil7J9QVtJ+z1RiaVoFgtByQ
 MoKdN14iLCJKvelGxPSZbVQ3qUigKB02VEdxf32GgfDoDcArxyio0N8mRVV6Fucug+20
 qfqtJd3V/9sckuBkA8iyCJrc6JuLWu8Gl1pyjfHEOZgrw4ESg5wlD9Gd2kPHr+c+u38R
 hgqojkjN2vr14RYJWxgcz0QcBIiY7AnpopRqR3ksZwKSWY/kELhVatG951QuXqDwv1/B
 lkFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759304634; x=1759909434;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=50ZABzaAuXRvrwTkKyVl0AKOtqDw44bctJ5PxckI8vU=;
 b=PjNXMBWZMHS/we/wFBB3KINqTbcDqonfWQusYlJ9KsmLcV3MtUvmwuKRBceGfTMR0m
 blVYe/iNfqk5frSdcCsL4VVNILqrHZo7sW4ENXFR4D+NzUHWEkizAqP8t8YW3npjFgFW
 ex9HEUicmH2TdhutGHeLR6JJim50rSQ1YgxXCnE9tMcBHRdf07H3rX1Y258QtI10qkLC
 BZ3ma6iz55srFbeG+bJD72cTsprGi5ghg27tmCrqWh1Dg6cV4rCKCeFnRN5DXcH9ytDJ
 oxVFSIR4Z3u7pEegPhEZo7li+0hM/QWrRmc39FkdlrXGlzgGIcLg1DCEzMdRr2xsN/t5
 YJ6g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXYGPK/V5kw5ANsgOefUrAFaFuHLn7ojRD3Q9VxmEmxLE0I7z0mLOuxoKIHWCdH7G9n9kt3SBhUPq7C@nongnu.org
X-Gm-Message-State: AOJu0Yw5jv8U2o78emRyLaocO1UMZ8p83pg+4mdEQKrvS1jzH+SLH2KN
 CkrfWcQRu2AgeIQU+dJXZndKOJLl69zXF5Khqgtk3VPN1RhhOlDH64zvBWs0i95X4TM=
X-Gm-Gg: ASbGncuktJuMYtobw3v+w9wKKBl0K2lvKa1gBqqjZgHB4EvYVUWM91UiM+bi0qS3mZR
 b5ajtRP7Ut5ud3cN4goj43f9hFE8fZ0Xs478TTpGUg+AFRb7iOFzj3B5Rj1wUnJ68MXBTK94iol
 aKTIxqmlTQf6Y57wUDvNNu83BAu5UF8XOaWY8wscsfTB+TBrFx4RbGpoS60p5OKbDuUFA4ofnYz
 0pqw2i/tro/mwdDzGHybGE8E1/E1DG+dwmUJOhajodkGI+S7EtrDUAiDnnjIpu6bFCSjPJbcpXY
 fUtV5E0WWI5Df9yy9nYV43i+XHUay1OR7KBBNsdtD/EV0QVyE6nIiIw07xBCaL3WpDUs/6n8+EU
 jBx1pb2/BXDXjnhbi5yKTpY8XeN4dKfx3AhhOKPFl+NVMQue5iEKbKFAYGYz/GRgGKdMMiMdCPl
 YbN4/mwSR/4pUwog==
X-Google-Smtp-Source: AGHT+IHY/kP3yT4bDw74LcIFeYWaehX7GJww0p5akcadII87Gi7lr189ALta7IJddM4dwCuTtQYFpA==
X-Received: by 2002:a05:600c:6099:b0:46e:3550:9390 with SMTP id
 5b1f17b1804b1-46e612bda1emr20540035e9.20.1759304634558; 
 Wed, 01 Oct 2025 00:43:54 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fb871c811sm25893496f8f.15.2025.10.01.00.43.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Oct 2025 00:43:54 -0700 (PDT)
Message-ID: <753aa8ee-8c39-4e60-a6ee-b7b0ae991a01@linaro.org>
Date: Wed, 1 Oct 2025 09:43:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 26/33] target/riscv: Replace target_ulong in
 riscv_cpu_get_trap_name()
Content-Language: en-US
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org, richard.henderson@linaro.org,
 alistair.francis@wdc.com, palmer@dabbelt.com
References: <20251001073306.28573-1-anjo@rev.ng>
 <20251001073306.28573-27-anjo@rev.ng>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251001073306.28573-27-anjo@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 1/10/25 09:32, Anton Johansson wrote:
> Fix cause argument to 64 bit to match env->mcause.
> 
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>   target/riscv/cpu.h | 2 +-
>   target/riscv/cpu.c | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


