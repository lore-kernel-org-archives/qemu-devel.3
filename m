Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD320C35FFA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 16:09:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuvyp-00042S-Dr; Wed, 19 Mar 2025 12:09:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tuvym-0003v2-2S
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 12:09:16 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tuvyk-0004fd-7f
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 12:09:15 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2260c915749so54736645ad.3
 for <qemu-devel@nongnu.org>; Wed, 19 Mar 2025 09:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742400552; x=1743005352; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Bd/SyEh4Vk6oOCuQyumvrcHtqRyBq0sWObDi4KQdyMw=;
 b=DDR1vL2Fpga4+iycAjIYLcmq+ZdHFuORxGLCluqeG3UzMlHYJTiVkuXNa1fLeJopRE
 ZGJ63ueJDYBt8vJIj/ebt6iDGyKzRvTMuzI6JodwV0Oemo5fD3x+bQPBQwy8OA0jBN6M
 /bmDsSgIcHE1akwaTvSysslqyK/plCDqRWYS0z6/62bVZrNkMWSgr/1ev/+28XZB6bKH
 7Chys4juEYSxGD+8MPXhdLqC08Oit2PCN76dQf/iMsCoQYqQTMBkbvZ8DEC4sH5FJrnc
 3o9CM9cjm1k4CEkTgFZdG4OyuJ0lejGpiWcRaSTDMXuphRbSS7qoa375q4QTeKpu0Fpa
 bI+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742400552; x=1743005352;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Bd/SyEh4Vk6oOCuQyumvrcHtqRyBq0sWObDi4KQdyMw=;
 b=iyWtTpSomV/9UsSnljrCmVCmuEVrjJex3hC5hwdl73iCUTSk5oq7e0Xjc5cSrw7TgU
 OVCA4FHM/ZEXSpwvkeJ1sUFEGBYm2N8S/de4rNH21MqfWjudz3glSQcexpp9RSJU+q4c
 UgWb0U1jkUQCWI2sh6dmceuGo5w4BeCzu2FTA6pPPBN/BuQJtNfFKQnn8Z+ogEup9JYh
 ZLwwh4A+0waX2ib9erHC5yCPBKl7V2jbu7qluwAcxc/mh4DWlw8QmZKYFVzeQIWfKbP0
 KIi8yEQsBn+CKLfnSgcRxF+FMELzDkK/nkoeeSnRn3mzSsVyNJHDIwPdOEfW6tVpDD0N
 D8CQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCURihn2YgC9TKXqxAMnnk7HZ5smuVdPSgdIBKgIJS0QuGmKmnYpFNzVro6F1wl9jtHtYn1I2KXQXVJr@nongnu.org
X-Gm-Message-State: AOJu0YznK2UKZHSc7yF18KPrtod7CuNAAJLd1BL0Fcnj8HXBtuOLArR3
 W5JaDk/4Q6wNc0ZvoZyeCWJdfoCqaPlHb/+S68is/qgXWU7yK6ZGvOkdkskY4Ic=
X-Gm-Gg: ASbGncuyeCw75/QLtakeEuNbN07qvdbcOZBPCLSQ7UIji3M9EE1Rz4/H5g4nPCEtrh7
 A3aLAf1oQbbv14RKBg4wwVff2zkvFfv2ftPM2wEagB88S1igMSBxdoj4fjc2b4u6+FQ8qENmut/
 YhM9TUsl3W9du5q8z0LW5t1hY9SrrY4/kPntSWjxtdL/dMD4fTEgFVuigbCi0Z5yYgva5P4/oeE
 VqS6Ii+tsLKvUviiYYdb2xjUslAMNGMpHqFBdxSIEv/AZTxZJM1xYrWDmaFq/1nN420Tbg5Cyij
 DnvKi0svC0I2Eq/8YqEYTSxn2ISzshrzP2V7tuIMhTBAEvzPaVx329Ch1E3MxhNIVb5g6PMnR8O
 GoWbEhONK
X-Google-Smtp-Source: AGHT+IEkgqMI+tssRyA0kqBo6xInRSkQ+lPfiLbFlLxCZe1Wlfnmf8F0yU1+TrGjhlqA8ZoIqF64cQ==
X-Received: by 2002:a17:903:41ce:b0:224:10a2:cad9 with SMTP id
 d9443c01a7336-22649caaabcmr49897005ad.41.1742400551732; 
 Wed, 19 Mar 2025 09:09:11 -0700 (PDT)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22647996ca6sm18426935ad.106.2025.03.19.09.09.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Mar 2025 09:09:11 -0700 (PDT)
Message-ID: <7114e08e-4eac-422f-8d49-c2eda3822a96@linaro.org>
Date: Wed, 19 Mar 2025 09:09:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1 02/12] tcg: Always define
 TARGET_INSN_START_EXTRA_WORDS
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>, Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20250319134507.45045-1-philmd@linaro.org>
 <20250319134507.45045-3-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250319134507.45045-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

On 3/19/25 06:44, Philippe Mathieu-Daudé wrote:
> Do not define TARGET_INSN_START_EXTRA_WORDS under the
> hood, have each target explicitly define it.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   include/tcg/insn-start-words.h | 4 ----
>   include/tcg/tcg-op.h           | 2 +-
>   target/alpha/cpu-param.h       | 2 ++
>   target/avr/cpu-param.h         | 2 ++
>   target/hexagon/cpu-param.h     | 2 ++
>   target/loongarch/cpu-param.h   | 2 ++
>   target/ppc/cpu-param.h         | 2 ++
>   target/rx/cpu-param.h          | 2 ++
>   target/tricore/cpu-param.h     | 2 ++
>   target/xtensa/cpu-param.h      | 2 ++
>   10 files changed, 17 insertions(+), 5 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

