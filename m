Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66E5BC021A0
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Feb 2025 18:13:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjMeb-0001N9-Os; Sat, 15 Feb 2025 13:12:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjMeZ-0001Mw-6w
 for qemu-devel@nongnu.org; Sat, 15 Feb 2025 13:12:35 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjMeX-000115-4Y
 for qemu-devel@nongnu.org; Sat, 15 Feb 2025 13:12:34 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-220bfdfb3f4so64895745ad.2
 for <qemu-devel@nongnu.org>; Sat, 15 Feb 2025 10:12:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739643151; x=1740247951; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7dpdecLhwAdixda/HffUvO6S89/lsR9AkyMowtcLARE=;
 b=LgEdqCPe73jmd6IWUXQtmpXkQ6APRncus4r+nUMFE3dkmBl5SZACHWtpWt7Ziu0CLK
 lJv4UNTVz54SdhtGHNEQ3PqtUSVLjTyPVO85Bqbdt8sntVgIyRkDNYaPtabSVgz9I3gV
 xUvuiGttx/dhC50dLlDv0QZukaLNDqRgPecVI4NeU77QB8ClOO4E/NV7zIDy98dOGRd8
 uf7fuIf6UHNUpZdJ1Rcp+JMYcYx56rRrURPraCHnypUcFIU1AKm0Hfw4437XngiyPFyQ
 7lCZ4FKiUucdsNTUoXaFbk/M7SK5sUFf0YeqNCN3mhTxXyzt0Q275xi5kCxJ8iCBVfQB
 14zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739643151; x=1740247951;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7dpdecLhwAdixda/HffUvO6S89/lsR9AkyMowtcLARE=;
 b=kOcWY362kF+5hag5b/zSjeeSHkK0YKa4ufRos2EdJ6in9mXAlqGN++xOqkyg0V+Xif
 UFYnx/5uwFMmiRhj7Eh6bpMQnsOpsMDskSg8syud96w5O4iHmLARsXWZSmtsmTsPYiaN
 zAxgPxCjaCTv7QGbrfqBqdIuHlvATyp33OQW8rG0Sx7XNvl5asHPRlGUM330aASvWh5D
 n9jPQ/3kuCe+zV5hFVT2LfRONlEKDAcpumTr6d+L58LD22MlnM1Q5j+8+Cs7A1cYVGxT
 i0M3O6DazYNjDMavL0qTsJaqR+nhs8xM3o7eDJ9IAVLYV9/+HKkdnz6cLK7yCWRC2toU
 qTSQ==
X-Gm-Message-State: AOJu0YxYuE1uxeEPDVTm4xwiDg3iHvxjIQ46h9CMH5p8oI66zNpmwwgl
 jOlAjCBNafUBT6fzQf7LcdkwXxcLrFIvcVcyHQp6hj6lJxBmyiTK/FVKD3kLZgCZNN+QD6P11UU
 e
X-Gm-Gg: ASbGnctb5Wa9nV1adzmsEI9VR5dGfEORnuiFHkf6EZzCkID3BqJ083sqmJgzEf9flCb
 UZ7Q3hADBEfV5aZBKc8asdJMrtO45zBnlFiLbr9LoC62bO70vYcBEfCrhr15Jrl6BR9WB5OJ8PR
 GUrpjMFED5pO4IudveP/utPjUjM1i4drtOF3Mv+MGGXZvw1lwQY9uzdsKQIGoPX8HNkBCu7kHaE
 /ZJm/a0XmJoc3rXKxKhx1/+y+yGzh2mTrLGbFCjeSnXJGUR02vQ6CNyfd8Eq6FgyZCA9me+zlwG
 /mPWd4cRIunMyRGlVwEm9l4PtDpn9uAAMs2rajm6fziQw62S7sxE394=
X-Google-Smtp-Source: AGHT+IHHEB1Jv9zRcZmLGjijI9mFsLXHN89zha2I5S6FRasEN6+aEfR+GFpEKIxkEQ0G2dqVoHUF5A==
X-Received: by 2002:a05:6a20:e30b:b0:1ee:88d2:f0a7 with SMTP id
 adf61e73a8af0-1ee8cad2b95mr7517935637.12.1739643150946; 
 Sat, 15 Feb 2025 10:12:30 -0800 (PST)
Received: from [192.168.0.4] (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7326a38ff76sm986724b3a.160.2025.02.15.10.12.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 15 Feb 2025 10:12:30 -0800 (PST)
Message-ID: <3ef573fa-2aea-41c1-be17-cdf30e38ed57@linaro.org>
Date: Sat, 15 Feb 2025 10:12:29 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] target/rx: Set exception vector base to 0xffffff80
To: qemu-devel@nongnu.org
References: <20250215021654.1786679-1-keithp@keithp.com>
 <20250215021654.1786679-3-keithp@keithp.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250215021654.1786679-3-keithp@keithp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 2/14/25 18:16, Keith Packard via wrote:
> The documentation says the vector is at 0xffffff80, instead of the
> previous value of 0xffffffc0. That value must have been a bug because
> the standard vector values (20, 21, 23, 25, 30) were all
> past the end of the array.
> 
> Signed-off-by: Keith Packard <keithp@keithp.com>
> ---
>   target/rx/helper.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/rx/helper.c b/target/rx/helper.c
> index 80912e8dcb..55e2ae4a11 100644
> --- a/target/rx/helper.c
> +++ b/target/rx/helper.c
> @@ -90,7 +90,7 @@ void rx_cpu_do_interrupt(CPUState *cs)
>           cpu_stl_data(env, env->isp, env->pc);
>   
>           if (vec < 0x100) {
> -            env->pc = cpu_ldl_data(env, 0xffffffc0 + vec * 4);
> +            env->pc = cpu_ldl_data(env, 0xffffff80 + vec * 4);
>           } else {
>               env->pc = cpu_ldl_data(env, env->intb + (vec & 0xff) * 4);
>           }

This does appear to match the unnamed constants used as operands to raise_exception, 
comparing to the vector addresses in the manual: (0xffffffd0, etc).

It would be nice to have them named, e.g. per the named list in rx_cpu_do_interrupt.  The 
0x100 constant would probably be better numbered 32, so that

   vec < 0x100

checks themselves don't imply wraparound from 0xffffff80.


r~

