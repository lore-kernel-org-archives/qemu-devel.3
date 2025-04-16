Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 032AAC369BA
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Apr 2025 17:17:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u56NS-0007jL-4T; Wed, 16 Apr 2025 13:16:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u56NQ-0007iI-87
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 13:16:44 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u56NO-0006ZO-Bi
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 13:16:43 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-72d3b48d2ffso6868691b3a.2
 for <qemu-devel@nongnu.org>; Wed, 16 Apr 2025 10:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744823801; x=1745428601; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Wp3Br3vlGsteJ8ox9+DcOowfAt22e0pJC9nZY84QNAU=;
 b=M6YDPwWsuZLwgJJ5fztXQS1RB7jAFaFB/EDrJBLi5vcs6HNfBjkFGSxkPWokWL5zQb
 Lr8yuYvq5LrwMX0+vBTfg7xvNy4Ys497uFdkFYIF1KFoaJJjpjUjKwioVHDYG7mzfQQW
 AUXkyYeZX4FVWmqZcWf9aOquVRBsh9CGM+a/ZHcqSM7AhmX8gaExGfUKft7HZ2gURRDK
 SZDJzeEsCjStqaVU1OEcqlrU6E5+5H7wZTZASRTF7IQRt/KtxaOrFKPfTnXUjfuwEo9G
 GSOCWzV+kFnKezwOz8S9Yt1Cp7nXhpVHEbI8hfdw/iaKgPXMMOalagLNv2YkwJF90Isv
 tp7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744823801; x=1745428601;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Wp3Br3vlGsteJ8ox9+DcOowfAt22e0pJC9nZY84QNAU=;
 b=Mfb8t94BqkZ8WAlRvhZtpmteFf+qDRVn8iJXqrl9cvFlSlL1f1ea+2rQlBp3lltbUA
 kmJHuwNbGDiviv0jkeF/hEuAED3h3S5lx+pvgGkbsm0wZQeA+B4vP7foJDjRHcAfBpuf
 Y0JFa08bTpcgjUP0WMrKt/japflwCx8fzJqCPnBYLTqZN/uhreP+uCe++/nN5a1ajRnU
 YMpH7JLlDDsDC+d8RSONHRNicjcLO/vN85EqTwpX4pPF8C2fa4uW2BR8Wbrq9OoLn3JA
 qVY0rzLyh3eR9Lem+yJXCLo2Ete4kbsFCY5uUe/5JZKnHG2YogKCxN2BxTYCOTvTuUN5
 IrYA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWxyV9xethhiuVB+v4hz9TLIovxNkGrN4NkJHNmoG2s8FY2vNLwgoBF34Ueb2YFay5xs6KyvSL9iv64@nongnu.org
X-Gm-Message-State: AOJu0Yyq5rTDAyZFNYC4rVZ2dHIiFXb2q8fvjlcFuEZPFWIjdTsTKOoC
 hVK0vhBY1putj9zELrDSFjj9wripJXdtldWu1Xb4ox1PkcBwaYuiGU0qlSUSqFk=
X-Gm-Gg: ASbGncu6+0CQ/2tyDTMZNrkLHLZNr52Tuj6kjTcEjWNdZXiXuz01aoq7JIv9bTa5cHw
 YXwx1azTNcdhAMFJh6ZxykkiYsUoaytMsFg9JHIVgMoWirMWIFsDlJbQM/JWnXI7xBxM7U5hcBg
 nDOP8QMJC5dhgWNqVnZtP3PgTiwJXc0tamjCK5trpeEQBbegdB+4Dwc4IQ8KaMJHYJLJ/tSQYtq
 HeitBquqYPwPjd78RvKjKkzQNsy6uqNTtaqQj2990t45L8WBSB4LdOxbhEUQoCVrpzOOj5lKs4u
 5yzuIp7Uoc4lExwvii6CdIZpQlWiFOlCWqVD6noXu0jBHQ7QvF+HZxNflV8coIZtZmuqGOWWK+B
 t3dzRBaM=
X-Google-Smtp-Source: AGHT+IHC38kiU6oiN4PnI54/KpRii0JTUCe9PJDsr02YEgWw3CKl31oiBflQ5UNOJ5yA3JeNqLMZeg==
X-Received: by 2002:a05:6a21:8cc6:b0:1f3:418d:91b5 with SMTP id
 adf61e73a8af0-203b3eeedc5mr4781375637.24.1744823800885; 
 Wed, 16 Apr 2025 10:16:40 -0700 (PDT)
Received: from [192.168.0.4] (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b0b220e997asm1545162a12.37.2025.04.16.10.16.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Apr 2025 10:16:40 -0700 (PDT)
Message-ID: <9a681970-9c85-49fa-abab-25a878c38b79@linaro.org>
Date: Wed, 16 Apr 2025 10:16:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/3] target/arm: Replace target_ulong -> uint64_t for
 HWBreakpoint
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Anton Johansson <anjo@rev.ng>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20250415172246.79470-1-philmd@linaro.org>
 <20250415172246.79470-3-philmd@linaro.org>
 <655c920b-8204-456f-91a3-85129c5e3b06@linaro.org>
 <e30bcd1e-6df2-469d-af6d-67b2a263690d@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <e30bcd1e-6df2-469d-af6d-67b2a263690d@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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

On 4/16/25 10:13, Pierrick Bouvier wrote:
> On 4/16/25 10:05, Richard Henderson wrote:
>> On 4/15/25 10:22, Philippe Mathieu-Daudé wrote:
>>> CPUARMState::pc is of type uint64_t.
>>
>> That's not a good argument.  It's a guest virtual address, and using vaddr would
>> self-document that fact.
>>
> 
> Ideally, should we update CPUARMState::pc also?

I don't think so, no.

r~

