Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB633D65520
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2024 16:36:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFyY7-0000m8-4I; Tue, 26 Nov 2024 11:36:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tFyY5-0000lj-E5
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 11:36:25 -0500
Received: from mail-oa1-x29.google.com ([2001:4860:4864:20::29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tFyY3-0005Fc-6p
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 11:36:24 -0500
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-297078d8eaeso4017562fac.1
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2024 08:36:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732638981; x=1733243781; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ww3Jh20ZJEP4F+Nsb0heGiHlNDB3wKQk7wkEE/KUbdM=;
 b=DTLPriOqlNOdf8xzkqV2zP2TWVMUYXs9dX1zb//pdZvMl9YgrCLYXTFi8cgrcF4dE+
 3/IkyuBfx+fJoR8MBmWcKOEGRK47RfkoxoYyWVhgXqLsf+dDSEuX+F5utTjDkcpNMo7q
 duYU5C1FZVXbmAvlceTKIfPCqKY4DzhW7Q+0WTOBypddoMU30uQi5gDO/oMwmhXuQIvd
 X8veTArR6ZduPY6pGflB6D7Qwo8xFCYakL+fcavk1Dky889RKfYjsWYkI/1vZXqgQa3P
 Os8PiPh/g2NxmYTug6OTop9DMjW1sIYLVJcKWruxxBOzo7+LxSlqVvFZ0AGK6F0rfSmB
 i23Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732638981; x=1733243781;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ww3Jh20ZJEP4F+Nsb0heGiHlNDB3wKQk7wkEE/KUbdM=;
 b=CHAR9UJdP6IqeM5gNKH98A57PopW/aQJiDUDkuAMX5snXiEpX96ZNqihrUfghhhrcK
 0rMeCfP1BUuW+LFdk2y5ixd5GBpKNUsdqfykHhh6T0w6NmbD1NadDKbJVRZu7RF7VUXk
 9PmQzb1TcxMyPucjJfsiWxlF/oWPIp4wagKSeZuQeMEzHQSJwtLc9JlHz0HhSTF/g+4Y
 WoQx5UBPb0Dd7GmrqXeP0HanogVS2NbzE2hfUqu2F8MHBJ9l2mn9HVJyzd7/6uEWN1hC
 nQ1UPUerF8SbPAUjqD/ZZlHjdxO9UOoWObH3rOT2qSjugcmqmXZ+Dpg+SgizpH1UIqP+
 YIpg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVWRMr3RhmZ1NTZUYFEAJ8F9cOB7fq7iWAecDnJceKOL1agw4gTHi4i8mtx7yVqeJRmzofRJRzhYjpJ@nongnu.org
X-Gm-Message-State: AOJu0YylRxFCpX5u39uYGDg39hYdY1c/n6eSPIUUse/cDDK5OggtroEj
 A/CTmlC7/R4DRJRzEGMU2z1Eq9N2zkHgWiFRAHB4Mw6es8jAn2Q1kW8lZqiJkW0=
X-Gm-Gg: ASbGncv+lJlZhMfMMG9pukEGJ6dOBaeauGF8BdKb3X69un2MibYEntNLeQ02TPtJbNg
 kqEbWXPck2NWXc5S6OXyP4/yfWtLyeonhrSsuq/+cnq+ZfU2GQf39euCIbzTvr0kOwFQezQTgh5
 nAcB3ldnDlGuB8pvJnYY2QNrd8JuKeBx9zY+TEVJGO58XTAwjeRG8fC9z/Vc8MC0YLmGR6KY/Hv
 /vG5pB04hC9SiXLqj22SPfjiYUIa4OJBA7h3K+kwqTeci0fSgRS4JjIp8G/sp6xQg==
X-Google-Smtp-Source: AGHT+IHS9O8o7uTGuZxTy3Kn7nSGogN2d/o70PHwhUAi7CkJmWeDR7zaKSvpUsPVcKqKM9hOqRN+pQ==
X-Received: by 2002:a05:6870:c08:b0:296:c3cf:39ed with SMTP id
 586e51a60fabf-29720f71e8dmr14761036fac.38.1732638980880; 
 Tue, 26 Nov 2024 08:36:20 -0800 (PST)
Received: from [10.25.0.199] ([187.210.107.185])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71c03758454sm3044689a34.3.2024.11.26.08.36.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Nov 2024 08:36:20 -0800 (PST)
Message-ID: <1f26207b-120c-4e11-964d-e5792045c1a8@linaro.org>
Date: Tue, 26 Nov 2024 10:36:18 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 13/16] target/mips: Add gen_li() helper
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Rikalo <arikalo@gmail.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>
References: <20241126140003.74871-1-philmd@linaro.org>
 <20241126140003.74871-14-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241126140003.74871-14-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::29;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x29.google.com
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

On 11/26/24 07:59, Philippe Mathieu-Daudé wrote:
> gen_li() is the trivial 'Load Immediate' instruction.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/mips/tcg/translate.h        |  1 +
>   target/mips/tcg/comput_translate.c | 21 +++++++++++++++++++++
>   target/mips/tcg/meson.build        |  1 +
>   3 files changed, 23 insertions(+)
>   create mode 100644 target/mips/tcg/comput_translate.c

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

