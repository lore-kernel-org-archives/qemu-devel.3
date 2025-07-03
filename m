Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48AEEC77B7C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 16:58:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXNG8-0000r8-DK; Thu, 03 Jul 2025 12:58:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXNG2-0000pI-O9
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 12:57:59 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXNFx-00008w-NG
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 12:57:58 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3a4f72cba73so831730f8f.1
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 09:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751561872; x=1752166672; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2svJRRsEE235sDS6s7N5s0yBjX3cKxaUZsdF48yM/rc=;
 b=d1rsGhpFOMNJrEYUr9sTL6CELUt0ZfsjqO3ridTy4aOQ7m5ssWtMa+/U0QSL/TR7Hs
 HUZnu4QU2UQFqFyn2LnwqujcsD8sX6JeGn2DlOofQyUmkJYOQDHf+7/E0WHjfQlJD6OK
 5/+2tSvrjwbqp0kSzobm6TEdIACQg+LzO0+/eCD7g6s/GnePAy59odJ7QmlgxME7Moid
 J2R5AHHuf4aECPyrTdqxNCVAgxi0nuvd0yupEYz+yt3Eqn0uEIdomkuyBcu0hhGXh8oA
 /RqombtLKo9lMiSXudNjPp2HsX5A4ua1+HBa26cj7lm2aNlEHiZb1BzSTtOUtafZQ772
 DzmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751561872; x=1752166672;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2svJRRsEE235sDS6s7N5s0yBjX3cKxaUZsdF48yM/rc=;
 b=EE/enzfLokGtcXkXkBdTjcmH75N53rERdzCYWDvBSAJwTX9gx/DNJfE2TY1GmJ+toP
 G1qxdhpc2ugYayMvwzCbtDdhrC0SqKWJzf56uRTNikxwzPzBgc5gQwEV6iJvoefF5HGZ
 M74bDOcPRp4HYKij1sXtC9JsvhPTXL0SsrFn9E4hycsoyCNmT7zsVA/P9p2W77AtBvja
 V6PnpZGECB9MlpbA8PGrr6AxKg847B+kxXeHt438HzMj+plvX5jkun4/V5aL1JPAOEZK
 pQaGskMLxTptDiWa4LDcGdhibfg+0Y9z3MpXVyGoYAk3R0MhScvbKBnl3OqE8VnRP/l3
 cPcA==
X-Gm-Message-State: AOJu0Yz8LiKmQrmeFYymXybWXsuai2F37ySBDsfysnFDQa0CJBx7Y8Nh
 +BG/Htka3lNsTOtrZ7KAa76eZDJpSJWyOsS5tX8+wxx+GiR2gGS4llHvef1hnEu2EZQ=
X-Gm-Gg: ASbGnctPOdvpRFmMCupZMSH2gMJTlRQadX9tO8Fqi4MwrHEmvZiWe0X6wZ3cFvoPkFJ
 GU7hPt9P2qHxnMNnwC322NoH3YglPW6hXXObqx9PIPyFY0uCYKXyb8uieW1WZEEzCnF3Ej3JCet
 RTXdydCA2AhKeCnHivgDJ8jJN4vEiLxuZLSnJDe2MvpfTJmAXWV///LYrdX2WNswzA8ZEJ8fv+R
 gtzGKQRmVayekAxMU25kJI0uhbKDRLuf9qH5/dUWh7+DQpNfn6Vvw+Wdy5YcY8qFX5DRF6/bzXG
 KmRaO1/kDIxZLnEwFS6aLX/dX0xvFRngMLSO7ao07aUKbaVWZ4KjPf87Jx9EpviiP9GSXRvvdK5
 nxfMS+Op+03PcY7d1EJ6q+6UxbTWx9w==
X-Google-Smtp-Source: AGHT+IFRQQ1iDcsV3CTg61lEb2JYAwQlmBhvcCZp4J+UM+eFJpRRPRInN8RQSyG1fp1w5dDe5FNHFQ==
X-Received: by 2002:a05:6000:2308:b0:3a4:eb7a:2ccb with SMTP id
 ffacd0b85a97d-3b344322dfdmr2749552f8f.16.1751561872124; 
 Thu, 03 Jul 2025 09:57:52 -0700 (PDT)
Received: from [192.168.69.218] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454b161f481sm2747345e9.2.2025.07.03.09.57.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Jul 2025 09:57:51 -0700 (PDT)
Message-ID: <0ad78f12-3ab4-42c8-8976-05a01a622f19@linaro.org>
Date: Thu, 3 Jul 2025 18:57:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 26/65] accel/tcg: Implement get_[vcpu]_stats()
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20250702185332.43650-1-philmd@linaro.org>
 <20250702185332.43650-27-philmd@linaro.org> <877c0pcixs.fsf@draig.linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <877c0pcixs.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

On 3/7/25 18:55, Alex Bennée wrote:
> Philippe Mathieu-Daudé <philmd@linaro.org> writes:
> 
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   accel/tcg/tcg-all.c | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/accel/tcg/tcg-all.c b/accel/tcg/tcg-all.c
>> index ae83ca0bd10..d49d2b3b0fa 100644
>> --- a/accel/tcg/tcg-all.c
>> +++ b/accel/tcg/tcg-all.c
>> @@ -239,11 +239,17 @@ static int tcg_gdbstub_supported_sstep_flags(AccelState *as)
>>       }
>>   }
>>   
>> +static void tcg_get_stats(AccelState *as, GString *buf)
>> +{
>> +    tcg_dump_flush_info(buf);
> 
> This is failing in linux-user because we don't have a monitor:
> 
>    /usr/bin/ld: libuser.a.p/accel_tcg_tcg-all.c.o: in function `tcg_get_stats':
>    /home/alex/lsrc/qemu.git/builds/all/../../accel/tcg/tcg-all.c:244:(.text+0x194): undefined reference to `tcg_dump_flush_info'
>    collect2: error: ld returned 1 exit status

(reported by Zhao and fixed in v5)

