Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD9FBD10BE3
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2024 04:59:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4Ysm-00065O-LQ; Sat, 26 Oct 2024 00:58:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t4Ysk-00064w-PI
 for qemu-devel@nongnu.org; Sat, 26 Oct 2024 00:58:34 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t4Ysj-0003H8-3U
 for qemu-devel@nongnu.org; Sat, 26 Oct 2024 00:58:34 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-20c767a9c50so23119075ad.1
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2024 21:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729918711; x=1730523511; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Qz7ZaYyzL+I74tcQsi/YT88DnA5d+4vygeXmGLcK1k0=;
 b=a1iXAJQBa0TolBlsSgmOuxbSr83QgM00HD65zEKzts24WrGydDy5DcKUBcAbJ5/itJ
 Jk0yR4YWcs1Fznnf/EOAk7YEek2OuMqE/AJo8TPfMEKibI+ge2aRkU7ixAbdjIctah0c
 kRfw0sUqP9wqiyqvrFS7bPNzvpGYaj4MzxooHTzW5weOgd+oU7ycEZzZG2tk4i2BPvkr
 2m7GYppgiURbXjhlbz5JD9REEwvdmZRVJZ/ys4Co/Tb1Yd2XOjHolCiSmXlcCvjFUXvv
 HErdt8ArGaR75D6srF+MIby/etb54iaR3hKYEoiEuU4wejR7QDQ5Sc3/dfZXYuhOrQvk
 fplA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729918711; x=1730523511;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Qz7ZaYyzL+I74tcQsi/YT88DnA5d+4vygeXmGLcK1k0=;
 b=ZqTq7+UOxBeeYSNBXfLU9YL8e2a+Nq/LNGH8Qk2jI0dOvTFLckpFfbyK9vtRXhwLXK
 EGatYOF4pWWlfsE35ps+RAWzeBtmYPVMNP+CFX0YfpHzqaEYgITBDjBhKGQxvlSqeslA
 ye8Ux370zUyCbgwEel3Bytb78KgQ1N0lWLLe22aEBeifENnAzHVeWsq1KEMzk6KN+0TY
 A73HQkIuLnfdliE0LV+934niDhYL6p9T9teQZcD3bKHK5XdRe+50xJqlfIQqoZWM2JZI
 aA88tO+OX7q7A/9ILHP9hocZpBgDfHrjwMyerQMNhcMiAZ8/XtCqVdeZaypxBE+rqbGK
 z8gw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX4o92Nn9hQ1HlEGv6e5+Rbvi3cupItolNjOSnfIX+bp9Eq9yCo4zYWYovTIB8cn28IYOQLuao0V87J@nongnu.org
X-Gm-Message-State: AOJu0YxPpCeGCc1zUYx2lwC23d3BVoo3IJX7i2z4UwwnpDvnQDchPkW8
 0mPS6jDTJkfljILLndZzEzEfyaAuKlKjU1aKTcjfVoLvHARGQA4ziPjOOFDM1lk=
X-Google-Smtp-Source: AGHT+IGmUOrIqFSVGmp3Xotpz37jGj+gvATHkIl/+1baVr4N6TGG8tVY1Sn1FB1eHj/udMg7Fm0yyg==
X-Received: by 2002:a17:902:da82:b0:208:d856:dbb7 with SMTP id
 d9443c01a7336-210c6c7868amr21947345ad.39.1729918711601; 
 Fri, 25 Oct 2024 21:58:31 -0700 (PDT)
Received: from [192.168.120.226] ([45.176.88.169])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-210bbf6df8csm17691735ad.99.2024.10.25.21.58.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Oct 2024 21:58:31 -0700 (PDT)
Message-ID: <8bc8a3cb-6083-4b8d-af6a-2fcde3666ffe@linaro.org>
Date: Sat, 26 Oct 2024 01:58:26 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/8] Add CP0 MemoryMapID register implementation
To: Aleksandar Rakic <aleksandar.rakic@htecgroup.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>,
 "cfu@mips.com" <cfu@mips.com>, "arikalo@gmail.com" <arikalo@gmail.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>
References: <AM9PR09MB4851FB6034EDB7FA191BA47E84402@AM9PR09MB4851.eurprd09.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <AM9PR09MB4851FB6034EDB7FA191BA47E84402@AM9PR09MB4851.eurprd09.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=philmd@linaro.org; helo=mail-pl1-x636.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 18/10/24 10:18, Aleksandar Rakic wrote:
> Add CP0 MemoryMapID register implementation.
> 
> Cherry-picked 9e0cb40adb110c2c76e2e97719ba8afcce72bcf5
> from https://github.com/MIPS/gnutools-qemu
> 
> Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> Signed-off-by: Aleksandar Rakic <aleksandar.rakic@htecgroup.com>
> ---
>   target/mips/sysemu/machine.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)

Queued rewording commit description as:

     target/mips: Migrate TLB MemoryMapID register

     Include CP0 MemoryMapID register in migration state.

     Fixes: 99029be1c28 ("target/mips: Add implementation
     of GINVT instruction")

Thanks,

Phil.

