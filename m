Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91807C46CD2
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 07:52:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUiuA-0002yI-IK; Tue, 30 Jan 2024 02:51:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rUiu0-0002u5-9w
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 02:51:28 -0500
Received: from mail-lf1-x135.google.com ([2a00:1450:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rUitu-0005wR-RC
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 02:51:25 -0500
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-51025cafb51so5149827e87.2
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 23:51:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706601081; x=1707205881; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JsLkEIfJHXL56e0Gz/0no1vs5VXLmbOPVBqPvukIiU8=;
 b=nLXhStVhLOY+garxPEvnLXzzX5v3MHSR87Okva2LWTiv+/uotKtTAaZzk7K9Dkuv37
 Ba+4wtWmBF/F0sLOSZQq0HkLmCcHrjxNQ1yTpp4dutwMheZPlgEjj66Xjkntb48pkyzf
 Ri3by5EG+NgkBai0opd1tXm7I4e7LmuNjzCOSBpSrvhNh6zjIUFDfJAvXp4v+KHP9FkP
 OnPYEuKFjORbRGw0pyGf1Ur2OLzDpcEk4k80NQBjdKVgYsj1P1W4+caZxGrXMFer87F0
 6O/thV4VP2M7AdDq4jQ/Fx7ySMKSi7vzL2QZhM4oe0Plo8lvFC8MP2FV5quPhZlkk5rG
 bnCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706601081; x=1707205881;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JsLkEIfJHXL56e0Gz/0no1vs5VXLmbOPVBqPvukIiU8=;
 b=XQu9XyiEC5dEs16PN9Qf2okfbbFkU6ONIRuDNrmjMyGUSD0S4XwSocUL8HW+dpiSFv
 OY3mkLz6oAbtAUIaJpGBdeZQ/ZvGjbBDW+orwVUTchBFry5FofgVZxmdX1ocu8DU1TBc
 cyBnmhq8iOT/qhbZjrXH9FGlUaFASwbghcLo0d7sD0ZcfClMujOq+qiKME7117ABMSnQ
 VOZ1qy6b7CbWlyuqtKXLYXKusmR9Ps6TldmQH3Wq2Y0E/AJcgiNLWNwQLLy7EiCshICc
 zhBvRbHhd4qC6DXdmiHg0Ewl9S2D9BRJLsRAVFgBtBP6DA1GgIwV6RlKjRfTTPRtsUce
 Aajg==
X-Gm-Message-State: AOJu0YwUHUjq3tzjRAhuhuJo+Nx/kdkGXSN6F6oSVsL9uzd6TTn85tvP
 1vQPV8Hs43cqixgOvS/n+Z13Ckc4J4kWGQsNGds8BtHlGC40JfQuuklV3X+2cA0Z2E5NluHM4x/
 J
X-Google-Smtp-Source: AGHT+IFWzaowBCfFdqxo4lHRT2VllA/FJkRQfMYfm9wxtWBueGzfvA2BDS84YhjFY+SIoGFksm4Q2w==
X-Received: by 2002:a05:6512:11c7:b0:511:1ed7:61b9 with SMTP id
 h7-20020a05651211c700b005111ed761b9mr278683lfr.39.1706601080891; 
 Mon, 29 Jan 2024 23:51:20 -0800 (PST)
Received: from [192.168.69.100] ([176.187.218.134])
 by smtp.gmail.com with ESMTPSA id
 eo6-20020a056000428600b0033af5086c2dsm2570237wrb.58.2024.01.29.23.51.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Jan 2024 23:51:20 -0800 (PST)
Message-ID: <ecf81b39-0b2a-44be-a496-18557316b9b9@linaro.org>
Date: Tue, 30 Jan 2024 08:51:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 26/29] target/sparc: Prefer fast cpu_env() over slower
 CPU QOM cast macro
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-s390x@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 qemu-ppc@nongnu.org, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>
References: <20240129164514.73104-1-philmd@linaro.org>
 <20240129164514.73104-27-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240129164514.73104-27-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::135;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x135.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 29/1/24 17:45, Philippe Mathieu-Daudé wrote:
> Mechanical patch produced running the command documented
> in scripts/coccinelle/cpu_env.cocci_template header.
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/sparc/cpu.c          | 17 +++++------------
>   target/sparc/gdbstub.c      |  3 +--
>   target/sparc/int32_helper.c |  3 +--
>   target/sparc/int64_helper.c |  3 +--
>   target/sparc/ldst_helper.c  |  6 ++----
>   target/sparc/mmu_helper.c   | 15 +++++----------
>   target/sparc/translate.c    |  9 +++------
>   7 files changed, 18 insertions(+), 38 deletions(-)

Per v2:
Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

(https://lore.kernel.org/qemu-devel/140c63fc-f99c-41f3-b96c-5f9d88fa82ba@ilande.co.uk/)

