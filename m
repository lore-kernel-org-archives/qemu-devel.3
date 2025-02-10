Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9AF1C02198
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 22:06:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thbum-0006mo-Q0; Mon, 10 Feb 2025 17:06:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thbud-0006k0-46
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 17:05:55 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thbuZ-0000Hh-34
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 17:05:53 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-38dcae0d6dcso2027786f8f.1
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 14:05:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739225137; x=1739829937; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1iLQ3Fcjem5IgImYsaao2KKU5aHeiU/l6CC9WMjgOAM=;
 b=QoYK5IndW7diMnFGkUluCKChc3KEC2nh2KK6xfeiuBu17hAuJ+X28XEMYPfcMNoawv
 vR/7m16xER3jSnQWnrNYOmtMq8RLo7DsOUl/FG2UO5HH2tcMvVUTdcnFl3VFi5i94s9I
 K98u8Dx2oMUr419Ny7+I2ovlGHJ7fP3Bl2jWrXlmlyFGWZRJG3S6zFz/oWiTa5aTQfPU
 hkGEdAmTa3kO+HJRzn8WBl8IpGnAtV7qY2yD1T8tSTxLKLB2TSHC4IOZjP0K1Cu0Hm9L
 r94Vvwroo6JRbpzQW32C9k/FLl1OplyDV5ysjppptAiMctsjJcmaweo1M19egEaggqli
 Pptw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739225137; x=1739829937;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1iLQ3Fcjem5IgImYsaao2KKU5aHeiU/l6CC9WMjgOAM=;
 b=QVRNqEhEQsqPO4fWtcTLy5+VMtTUhPPrTXrlMfMNwtvC2hrzpCgbB1kuzYTdPJoffS
 a2dTvpPPUYw++FGRwRUd0ib9rxtskY/UdIg9Wbm/l2nTldfSDOgw8cgIMbaDNdOsZvY8
 HWa4jC2MxVbyPoVkAk55+y2YcG3sOfaf2tj7e088qw4NGZZF61S5t81Hl979roZ7BA9m
 //Fz4IWJ4yULgjD1LEzEacg6H8mJuB+WG8lWB5PKj77uV7x23HwKeNmr3R7U611njKQN
 V1eTdQr2FdG5ewJuSXJygr0sCuqmfeP9iK3PKqRdbMUBdK7SnYwN+BpCAXoFsx6ADxsR
 Faww==
X-Forwarded-Encrypted: i=1;
 AJvYcCUuE4YxgO8AboG4fgqRtNIoXgROYE2QP3Vb7RKeiVz8ImrtsR9RjaYh4c03PCLmHouBofPTwA/PzvKz@nongnu.org
X-Gm-Message-State: AOJu0Yx4YaUFbKAvwN+8PK6KIi3BrAE6oHUMJdN+bK63sSFFRPa2nAOF
 JgJITCIJ8DJ/aiFD+BnxyDZxECoAhcw+IPfb9cYlSl5OZr8CHo/k85XIBPRoSc8=
X-Gm-Gg: ASbGncvhDp2MFkrD6SOtKruy+a6NL8YjIWyiVSGmHXaiBtUk7EwkYEZCUMk6NdgFmru
 R8Mm0aWjaL/pKUx93quLTqA3asBFy+Bh6XSHTsGoXnw8OT4puTTSyoMk4iqWyc3h1Ago0gdi/pB
 VLD0piNcyNZORyU/Tft0ri/qYhKxbQ0o8oVnt7FJ4mv+oUPOodQQxkqz0MWEqNSOAcTN0VKzJky
 IzZvZvBx67kzCn+zzZVqLHZwKXsviRV2J5ObK/rvKWEGZ0Y2zwvIntSSp0GNDK0p062+Ba1bubi
 OG/bzDbFMUOgP3Ao5ek94Ga2zHzxaW6W5S8Kxmjp7mhPch9uEnkRrWXwDsA=
X-Google-Smtp-Source: AGHT+IHhXUoqwl/Nu31ezgYu2++rZsruPsFC24VtrXyM/lh4z6NgW48t/r+hCnTFdB2inuUGohXiOA==
X-Received: by 2002:a05:6000:1f83:b0:38d:de92:adab with SMTP id
 ffacd0b85a97d-38dde92ae55mr5374456f8f.29.1739225137114; 
 Mon, 10 Feb 2025 14:05:37 -0800 (PST)
Received: from [192.168.69.198] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dc9ce31e8sm10632809f8f.5.2025.02.10.14.05.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Feb 2025 14:05:36 -0800 (PST)
Message-ID: <5cfe8347-12e0-4f61-8e5e-f4e5caa80fed@linaro.org>
Date: Mon, 10 Feb 2025 23:05:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/10] target: Set disassemble_info::endian value for
 little-endian targets
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-arm@nongnu.org, Thomas Huth
 <thuth@redhat.com>, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org
References: <20250210212931.62401-1-philmd@linaro.org>
 <20250210212931.62401-2-philmd@linaro.org>
 <45b18fab-59a3-49c4-b600-b9a26b815961@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <45b18fab-59a3-49c4-b600-b9a26b815961@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 10/2/25 22:54, Richard Henderson wrote:
> On 2/10/25 13:29, Philippe Mathieu-Daudé wrote:
>> @@ -35,6 +35,11 @@ static const gchar *tricore_gdb_arch_name(CPUState 
>> *cs)
>>       return "tricore";
>>   }
>> +static void tricore_cpu_disas_set_info(CPUState *cpu, 
>> disassemble_info *info)
>> +{
>> +    info->endian = BFD_ENDIAN_LITTLE;
>> +}
> 
> While this is not wrong, since there's no disassembler it's slightly 
> disingenuous.
> 
> This is the only target without a callback function, correct?  Let's 
> split this function out separately, along with the hunk in patch 10 
> which makes the disas_set_info call unconditional.

OK, I'll also move this line to the previous conditional call:

+    g_assert(s->info.endian != BFD_ENDIAN_UNKNOWN);

> 
> Otherwise,
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Thanks!

