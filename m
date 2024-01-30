Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD06AC46CD2
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 07:56:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUiyg-0006GI-SL; Tue, 30 Jan 2024 02:56:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rUiya-0006FG-38
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 02:56:12 -0500
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rUiyX-0006jv-5H
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 02:56:11 -0500
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a35d0764076so200815166b.1
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 23:56:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706601368; x=1707206168; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cuW28c+BYLmiqysCymIstb7NEFQqdWJjjHphmOigLJY=;
 b=WEmqf2IF4Cc7/KKjtAzuctfwbWoq97GGPMWlpHrDOT7DBd9gSNU29PVyyGQsEuLC/c
 4MrDJfSP9+azu2SKhiYsxHJRJywck8JqOQtG8Uqrjb/scsGHi7zEAWzS17QuGATbhEVW
 Yax0C4l+ujEPmo7DaOTkEtkorcPXITf5zF4ROhMPLgAV3vS2XV42KykF7nwfbKQP7fa7
 KN3pTumBmlnOa08TJQ2GSlityMRvsrBNsLCcdjq8mOaVQtjUWSF+04pquyjwW6XoipJN
 Cb7HzAKylFkwNt/lcyISnGXhn/uLwtLkI5/bY60ufheYVsbp1NsSTBdas2MytOEJyiir
 Rt4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706601368; x=1707206168;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cuW28c+BYLmiqysCymIstb7NEFQqdWJjjHphmOigLJY=;
 b=B0Ue7NFPVra9yLuSFtGxFvxP7aAgOUUWeSaBXTL1G9bqnQQRREqrQlRf4nW5p/muln
 AdRx/L1E7dqMNq4Xm1r0+k4bBECaKtnd4C9XOHr5rDDheVq64KE51jgGBByxQ8EnXfDs
 mdQ4GbSgAzXX7jufX7PuZl3+bcWlkbSkf2fy0xMg4tVtunFzrSsjBfRol+aFr/6zd74z
 e8Zp7tX8ZYFJCYBk6n2W/4zxGKUzDc3gtDS8LHzGKuAGBEb+vDckaAvnP9bNTWC9tyu1
 c4delpJDQ1c+9I7FubUcU8ptd1fXd05VcMyhd7sIW6Ksl9WJ3qgUC1TYY6zKt0HrCbqp
 4gIQ==
X-Gm-Message-State: AOJu0Yw09G7Y4eSgphS1vqx3habMBDDanU8ViU4zki0LOZH1mepQSLbH
 U6yhqFIKJaPawZTvwsxCH6+1vuWtH4Jrp9t+NBaguTjsYfIyahDgfZfIRpIZdi0=
X-Google-Smtp-Source: AGHT+IEjyawnpfEx+5oD80MM4Z/UNcuJkBZ0uipar9qYbx8fQI3lSioPjjPHXdyo9GcmRkAKeFNWWA==
X-Received: by 2002:a17:906:a013:b0:a32:b376:48d8 with SMTP id
 p19-20020a170906a01300b00a32b37648d8mr5802773ejy.18.1706601367702; 
 Mon, 29 Jan 2024 23:56:07 -0800 (PST)
Received: from [192.168.69.100] ([176.187.218.134])
 by smtp.gmail.com with ESMTPSA id
 bq26-20020a170906d0da00b00a3618de97efsm526540ejb.2.2024.01.29.23.56.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Jan 2024 23:56:07 -0800 (PST)
Message-ID: <525a134c-30e2-4513-b563-8f52100f6c9b@linaro.org>
Date: Tue, 30 Jan 2024 08:56:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/22] target/sparc: Introduce gen_{load,store}_fpr_Q
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
References: <20231103173841.33651-1-richard.henderson@linaro.org>
 <20231103173841.33651-5-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231103173841.33651-5-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62a.google.com
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

On 3/11/23 18:38, Richard Henderson wrote:
> Use them for trans_FMOVq.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/sparc/translate.c | 25 +++++++++++++++++++------
>   1 file changed, 19 insertions(+), 6 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


