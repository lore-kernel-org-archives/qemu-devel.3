Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F078C02198
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 16:55:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thX3Z-0005tb-NF; Mon, 10 Feb 2025 11:54:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1thX3X-0005sU-Hh
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 11:54:47 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1thX3V-0007gA-UB
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 11:54:47 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-219f8263ae0so83359145ad.0
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 08:54:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739206484; x=1739811284; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=suotHFWIX9/M89S7OTTGDiSsskmrnH3p+XwRJMfB89g=;
 b=s7zCwO4eqej7s0LhmIhTCtTbp05CWFynjiM60L88/FUitJn4PHktdY19bKEW6n+d8s
 fPrSfaoHZCdfekmuOD76+iw6cFhc29Fc/kS2er+IPumPYB+oFSSUh2lVOQa7I6xcNdBl
 dF1eA9kBNHZCCz1mdD6FtFZRV/gGMR3wBS4CHXJinoPr3XLfVVzMP2wnjsSNNOh67+/M
 GApoSlE1xpTFJWlyVPAihYErvQYlBpELxhWy5H6qPueDjRP9tVbO9qd0te0jT0fTC+VB
 wROAFuiHHJsKhBwNiOmX6CFBhHuDAd0DC5Qy5kX02UUPl8lGtlZmev/bODzFdNv6jdcZ
 Nubg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739206484; x=1739811284;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=suotHFWIX9/M89S7OTTGDiSsskmrnH3p+XwRJMfB89g=;
 b=mOkgGdxjRNJw6cEez1jaDVCFiYLE8MwQyR2oNAhzr3d6Ag3i0/lRG1dHhfGFH9h1Wz
 q5neofvcaFH+cS7clH/YPckwgSQZ1KfaOqg3gV1pr9VhTlq33LYaDwGAE7MzjvvDDeM7
 AyA09jMmBHmFmuYRd6GH3ZtJ5jcHZ4gm3g0FaDwQaP0kyMlJe8L3XFqMVl1EvoEHVJj+
 r1mtunNsKTaSadM6i3VbDURKoNVRJddXJbjeEOjNlyGVQMx+5WGODULN852+m1nJROSU
 brez6nzu6abm9dJX9TEKarkndlTPDn0gcCEK4cXQDgd+gpabPg4lFwVjcQu2lt4lMiFQ
 DFxw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWQdR2CbH8d/fZvZ17dJ0diXB5b8+tg+I9gauCEL6IhCJl/aQaJ4s69egPLblp1RwEn7NsRdGUTpH/U@nongnu.org
X-Gm-Message-State: AOJu0YyGKmj6T6BFRenJWNvoApialFQjvIqACzfMpHwG7uivAw6MPYH4
 pcrBsmfqdHMV+Qt97danfhnX92BcxIz7/L8JqoBEQXQmtwDYgx3vPLaW1bEZ5dE=
X-Gm-Gg: ASbGnct2/2cMMNNfw7G0tj8VUPypOUfgEDlwv0tWYPBrdZGPeWuw0E0ygh/6xxDpdYG
 VwjybJ3+XIjB4rOzm8pLsvFvUTQB56jrgzZmp46klKf/3x/YGpnOEHG70JF0h6wssqBJEqPb5Yo
 mH57TipIanB+YQMlKI0b7kwclEEO78wBiAbWh9S7g9sVqCbu+VjZn3BlGYDvR0PdqCvURaDXhGm
 ZmHrZvwwCgkGUTBQOddaVbxuIqe5Dv+yYiw6wnMjzlrCBrugIJCrtqt1rxRrRFrTFWuy+tmoc4n
 jl+oQgx0e0GFgtFxfRdzQh8+uwLxF0YY5OxRon/ZeWVBKFk2AKBgEDM=
X-Google-Smtp-Source: AGHT+IEaLEq4C1wwkyZ/1hHW/uEuXKj8MLYx9g0t0ZwoXQVh/tDxNqLv7myDajVoslyOr25lPfd23Q==
X-Received: by 2002:a17:903:234e:b0:215:bb50:6a05 with SMTP id
 d9443c01a7336-21f4e1cb7b0mr201000985ad.9.1739206484383; 
 Mon, 10 Feb 2025 08:54:44 -0800 (PST)
Received: from [192.168.0.4] (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21f3687e68bsm80775315ad.169.2025.02.10.08.54.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Feb 2025 08:54:44 -0800 (PST)
Message-ID: <0dc3beb7-c8f9-405f-a244-10b6111eb5b9@linaro.org>
Date: Mon, 10 Feb 2025 08:54:42 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/11] qom: Constify TypeInfo::class_data
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
References: <20250210133134.90879-1-philmd@linaro.org>
 <20250210133134.90879-11-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250210133134.90879-11-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

On 2/10/25 05:31, Philippe Mathieu-Daudé wrote:
> All callers now correctly expect a const class data.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/qom/object.h                                | 2 +-
>   hw/arm/armsse.c                                     | 2 +-
>   hw/block/m25p80.c                                   | 2 +-
>   hw/isa/vt82c686.c                                   | 4 ++--
>   hw/net/e1000.c                                      | 2 +-
>   hw/ppc/spapr_cpu_core.c                             | 2 +-
>   hw/scsi/megasas.c                                   | 2 +-
>   hw/sensor/tmp421.c                                  | 2 +-
>   hw/virtio/virtio-pci.c                              | 4 ++--
>   qom/object.c                                        | 2 +-
>   target/arm/cpu.c                                    | 2 +-
>   target/arm/cpu64.c                                  | 2 +-
>   target/mips/cpu.c                                   | 2 +-
>   target/s390x/cpu_models.c                           | 4 ++--
>   target/sparc/cpu.c                                  | 2 +-
>   target/xtensa/helper.c                              | 2 +-
>   rust/qemu-api/src/qom.rs                            | 2 +-
>   scripts/codeconverter/codeconverter/test_regexps.py | 2 +-
>   18 files changed, 21 insertions(+), 21 deletions(-)


Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

