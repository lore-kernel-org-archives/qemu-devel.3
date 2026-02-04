Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEAC7E8B387
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 01:51:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnS3R-0005U3-8m; Tue, 03 Feb 2026 20:51:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vnS3P-0005S4-0c
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 20:51:39 -0500
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vnS3L-00056z-Ca
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 20:51:36 -0500
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-81f4ba336b4so5239644b3a.1
 for <qemu-devel@nongnu.org>; Tue, 03 Feb 2026 17:51:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770169893; x=1770774693; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=t3hPdbETkY0/DzU5luywE4IdAQ6LHqzcVpQ4LCpwRg4=;
 b=m81cX9P9pgzbah/w1G75T0k+qRKyynxBkFWNP7zEUnNnDeOsAqaqVh0BY0Gl0hQ39C
 o7sDQekB1gDb3XZ16ZbFuG3b8cYEeAfyp5sXGqNdwaGD3R6JohH7U/24I+NnZ/QFelyW
 QR0NjP3EF0DzXf3AUNacbVa91UtG7U6DBzKPZ6ezpfdF+5596J6/z62GNkLb+ws2pCW3
 wkO6+ZwjiKKXDrUcf2Hch7FFTJX7lZ0p6zM21vRw+kpYu9qF0Urnpkw0lDpiMq0iwUpt
 xMD7+Se8eJeq5TwvvcYFez+KFpKYh77d0voLszHF26Zs/EERa8l8JadX3pX3Z+qUsbqf
 9SLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770169893; x=1770774693;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=t3hPdbETkY0/DzU5luywE4IdAQ6LHqzcVpQ4LCpwRg4=;
 b=bm6bnRuWrtiIawzAobVkwgtnrXEZhsQ6XsrLNJsE/uY18vqXhPE0ghwhLkNUluhear
 ALr0I6BdBDSoUAaAG1z84sqblZiA286j0/d6RVOGjZog7tl+bxs40Yw9ac60WU9eaSlN
 IKs3ZemjFSi5CMsWiKp5FGUoPOxsLNzUFW/Vz0kFyujybbodsjNY189GxnzPstL7Tp9A
 nLXcP5n/gGedfJLgXOnjDGQ1gt3girNPGCasFMBGHEhcuGuXwQwMtFsJkdRl45FEbcAG
 K92TDno4Pdo130qjJRs8NYglZTQ+1gD2dvWARo9OUhgV6zbKSFY9uv2Yw5B9Lw/Jxb2y
 HtYg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW3Tf3T2j6rsZrfZqdDEXX8VBIh6sB7CGMp278PJknAOkVBVV1b/1RYFxIlAMwXsCKNMJAVh2u3rGms@nongnu.org
X-Gm-Message-State: AOJu0YzKgBJVkTx93zzGY4HBDnS/1JImna8CfvXw9mYEpxT9m28kbS++
 zzqNLMoC39F755/DbPWVSCDVvevMroqIrMdxCt0k7eSL21I0Jt6PF32JMnTwGmyZFjg=
X-Gm-Gg: AZuq6aLx4ZgZTc99C5J8zPxA626hGcW42CnuIwyfRPT2bRoMQ8+AORAg0XxpuzOQC2m
 l+vuMobcZlPeZhtdhHZTqeDBy+twLFDlHivP5TOVhCh9tzcjaWcvlDzqPl15vQbgmtuP/yN1b77
 3aWnqa6C6GT72Dhb3QvnhDz/R5/mpeQ6ZQSStUg0R0M/9K5fAaqFptUHsnxfPsSlNOU5bmFqW88
 Aa+F9DKrp9kI096VJnjylgYOE+GrQQQAKC6/za+o4/Elk6QBPEiegGo6qjO897CPUqgK/Y0fGIR
 VaDrGrAukc4UnOstKhVez1AxVVTKOeaGqIzmgvshsMHnJqOQFEKg4IKMlsPpikh5aWKa8AGCn/U
 4tPZ7viVzNbFN4jzX1efBWQpzM0mJ2nhFpv5BLFUH623Wq8boKCdwvjdLf0WpKe9C/fR4HT9jAI
 Hzwgy1lOO5izoqr10RN1I3vNurC+fxcqLk+GfQ5bHYbLZ8iDLBEAJWeuQj4kFglzMz0QzvEnkHF
 2dNxpgb6d454W3xnTVj1PnS3x+5ewprz8tq
X-Received: by 2002:a05:6a00:ab86:b0:821:78bf:b048 with SMTP id
 d2e1a72fcca58-8241c6a65c8mr1378200b3a.62.1770169893458; 
 Tue, 03 Feb 2026 17:51:33 -0800 (PST)
Received: from ?IPV6:2401:d002:dc0f:2100:1bc:fe1e:491:928e?
 (bg30dhzlx7lnyrq74wrz.ip6.superloop.au.
 [2401:d002:dc0f:2100:1bc:fe1e:491:928e])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8241d1bd466sm606154b3a.20.2026.02.03.17.51.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Feb 2026 17:51:32 -0800 (PST)
Message-ID: <5a698261-9d37-4502-ac45-2db098a513e3@linaro.org>
Date: Wed, 4 Feb 2026 11:51:27 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/5] configs/targets: Forbid SPARC to use legacy native
 endianness APIs
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
References: <20260203230054.23667-1-philmd@linaro.org>
 <20260203230054.23667-6-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260203230054.23667-6-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
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

On 2/4/26 09:00, Philippe Mathieu-Daudé wrote:
> All SPARC-related binaries are buildable without a single
> use of the legacy "native endian" API. Set the transitional
> TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API definition to forbid
> further uses of the legacy API.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> Reviewed-by: Manos Pitsidianakis<manos.pitsidianakis@linaro.org>
> ---
>   configs/targets/sparc-linux-user.mak       | 1 +
>   configs/targets/sparc-softmmu.mak          | 1 +
>   configs/targets/sparc32plus-linux-user.mak | 1 +
>   configs/targets/sparc64-linux-user.mak     | 1 +
>   configs/targets/sparc64-softmmu.mak        | 1 +
>   5 files changed, 5 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

