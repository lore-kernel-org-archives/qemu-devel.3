Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82E3CC54E49
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 18:37:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rflH1-0002nD-N8; Thu, 29 Feb 2024 13:36:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rflGy-0002md-9R
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 13:36:48 -0500
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rflGn-00075w-3C
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 13:36:46 -0500
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-6da4a923b1bso1102947b3a.2
 for <qemu-devel@nongnu.org>; Thu, 29 Feb 2024 10:36:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709231786; x=1709836586; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fOrM79Oa256wC3dapWDTTNP4pa5IRgbP8hj3qIVmCt4=;
 b=Phk8HtBO1//pU/9pXAwYe9L2Nu5gaMon/AIW7Chb2cyWtqFaLm28Nkyj6WHhUiD1a7
 mur8nAKuBl+gxc1bHpwa7CmVsZZtBBNP3UR5227uYBGyLMj4CAYLJV1pYE3SC2Q+hhEu
 gSIHAseZiLkBGZmVxQ2zZf8FPJRwv7QwxX7bfb9ng5SznRYojno/GTxRdsx20hntAVQ0
 P0lJeCdprl3rBh6409tX4GcZK4+zoPWSz6iXJQHNIsbfDZl3mZ7+bhlo0HVDrB0NB2q5
 yRibyJmrUFFkJ4O7tpO5fCVbcDIJiMhCZ/p4RPnFvk/0K/Y41N078+IxT1jjQ9pokgRr
 VhRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709231786; x=1709836586;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fOrM79Oa256wC3dapWDTTNP4pa5IRgbP8hj3qIVmCt4=;
 b=IyH4eJgvSM6qNNAcv2YUDf+9NjJVBPdbsKBHlT4Md4adnsiDYqt38073nXdQDUCYH/
 NSZaNeurzVRpP+uyzWCgj1QtEFvJjS+CA/xR95N9rTGmagValUgWcwVUU6LqS8Q3M6iA
 wxqm9ceFsQaQEENT3UhyUACeajI7s6wZMkfRL6IaR0B6vXrW040WTOC7GqcITws/Dl4c
 fk6vauWNTbc6VDsSjJm2duFLijnFT0+FaJn0DxIpve2J6pOBCgopejcwe6BOaUJdF1YQ
 GzMlshxjAfwE1uDNAjkWSfR4LzaufGVfOGzd7twmWQE1H2/gCiJvOvA3fAH1bX7/xxya
 a5fg==
X-Gm-Message-State: AOJu0YzTAW21SmH58UzB9vz2hAmphwlz6XH5AxxjOE4dQC49ealVClfo
 4VNK8Xg0Ax8CrjEoDBMH13MkJrjkWSVpDrBeFB7iBOo28Gxb9WntMXxcfmAedRs=
X-Google-Smtp-Source: AGHT+IE+Bhq2W/nxjavezRT1HGj2xTdPHcKDnZuGccsLouGjXUBLYXwR8lvkCh4ov1mZO+TybuGFXQ==
X-Received: by 2002:a62:aa12:0:b0:6e4:e4cf:8944 with SMTP id
 e18-20020a62aa12000000b006e4e4cf8944mr3468388pff.12.1709231786299; 
 Thu, 29 Feb 2024 10:36:26 -0800 (PST)
Received: from [192.168.6.128] (098-147-055-211.res.spectrum.com.
 [98.147.55.211]) by smtp.gmail.com with ESMTPSA id
 y19-20020a056a00191300b006e55016966fsm1569758pfi.81.2024.02.29.10.36.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Feb 2024 10:36:25 -0800 (PST)
Message-ID: <ca233ca8-25ba-4dcc-95fc-de33165f7962@linaro.org>
Date: Thu, 29 Feb 2024 08:36:22 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] target/hppa: mask CR_SAR register writes to 5/6 bit
 in gdbstub
Content-Language: en-US
To: Sven Schnelle <svens@stackframe.org>, Helge Deller <deller@gmx.de>
Cc: qemu-devel@nongnu.org
References: <20240228201434.1515893-1-svens@stackframe.org>
 <20240228201434.1515893-4-svens@stackframe.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240228201434.1515893-4-svens@stackframe.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 2/28/24 10:14, Sven Schnelle wrote:
> Signed-off-by: Sven Schnelle <svens@stackframe.org>
> ---
>   target/hppa/gdbstub.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/hppa/gdbstub.c b/target/hppa/gdbstub.c
> index a5b2c80c07..049b2d6381 100644
> --- a/target/hppa/gdbstub.c
> +++ b/target/hppa/gdbstub.c
> @@ -184,7 +184,7 @@ int hppa_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
>           env->gr[n] = val;
>           break;
>       case 32:
> -        env->cr[CR_SAR] = val;
> +        env->cr[CR_SAR] = val & (hppa_is_pa20(env) ? 63 : 31);
>           break;
>       case 33:
>           env->iaoq_f = val;

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

