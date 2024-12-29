Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11062E77188
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Dec 2024 01:50:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tRiRG-0005ym-JF; Sat, 28 Dec 2024 20:49:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tRiRE-0005y2-2O
 for qemu-devel@nongnu.org; Sat, 28 Dec 2024 20:49:52 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tRiRC-0006Yg-BZ
 for qemu-devel@nongnu.org; Sat, 28 Dec 2024 20:49:51 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2166f1e589cso125913905ad.3
 for <qemu-devel@nongnu.org>; Sat, 28 Dec 2024 17:49:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735436989; x=1736041789; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0IIKW2B8fsTu+cWbPgs+0ZLDo9KwXZrbXrCRNYkkf2M=;
 b=tiCRTMGWwofWE+3vbUP7zwOVyOG9WT650tiRmTEaq/ba8W12razDI9eBZsFI/emKH3
 wHSXlcqWiOrMltZm9aOEWNO8goDOqLMSVFdGFs6MCQqEBRwvi++/M0LSDr/VzKLv4Ty/
 xiAbMPwkp27FJ+Qia+SeBYHkOC1AldzMlYFOUIhLOTtW+v6d88/jbJGn2rhY3wniCdqo
 qaeJRWfrzu9jqD1TBeCN/o7If+ziCoJMQGvn/ZOhlOz9yjbY1DZnDpz9D69FvzHGpzwi
 n+mNq545IZ37fYE0PLjXsh1tfC/27ebped/M0tX1FFoqBCV+Krdeu0DStUgsIRjVkBqD
 UXIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735436989; x=1736041789;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0IIKW2B8fsTu+cWbPgs+0ZLDo9KwXZrbXrCRNYkkf2M=;
 b=kr0Rh4nZByvrsXYkR0c3uBkoIbuUNpnAJ2WsrnOIoIV7zfBNNIbb60CPvIhAw6GyKm
 cxK/mtLcaKofD4T7Wy6l0Dqdx3I6j04OoOHuHgyMKlLpWjrYd/TAEGZN8G7Gic31xAjA
 AZ5EteS6A+C1A8BpkI/B2/scTRav7buuDejkchZImj4Txzhw9sfQ22P30RFUJ99btc6L
 Vp+arCzeE+ulUelSAvngK9P0xsbxonr843h9zu+Ai3kFtodX5JKSU2j/jxDwXwfFe24o
 WOWDYsTbK2aMIvXswh7bsHOr84kuEtIuUtACu9LdUwrygCCeCPpUyNdPDGPiqDjwt8ad
 NTmA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXlGUKikIVx/0GDweqBfNf3mbywmi/Z+oOZgBIEGCnxkavMO2Xo/Sa9RVeTXNPuzqxJTA33NbHnLI8+@nongnu.org
X-Gm-Message-State: AOJu0YyOHje4EQVqdXqId5M+5UKfbx7dav4g5/Svj4sbadpAqHdAsiZS
 sjLsF/YnTHx7l8kJOAdfWPvLhEY+UnVU/Dr81g6WXRkwy1aQVyO22M+3VDyWZbM=
X-Gm-Gg: ASbGncv+DAfiTZFvr9noNPtynMbuD2quKQvF3j3UdFlso0pqJzs0Ush0ucvzfjWxY2s
 k6H8He1oQlEKHuBX2bzBpqloBucBp4rb56BTwzL5lgCT2jFW1HnaFf+aywK2XB0PSp5oVX9TYTj
 0SEGAifHnmNFN7AI4LkI41wKtFLSXIzWrnmLPxJnrgwJmHE9rMebHm4tdim1ZnLgONPmCuV4v1C
 rXacSCPI8BfECl7ARnqBJHV2suExeVqZE6dzn7JSWfgZfKPR1Rhh0P0qsBoJCnjt5cn+ghj5Mly
 kT/HAxjiJ7sAr4QGZJn5sFamnHAWtz208UlDtuI=
X-Google-Smtp-Source: AGHT+IEfqixBZDzald3nipW+P6YrZZlHAnL7bru8taeOljmA5L41Psh2Z9MiyoDL4gJwz+wzMgeBAg==
X-Received: by 2002:a17:903:120d:b0:216:5af7:5a8e with SMTP id
 d9443c01a7336-219e6ebdc17mr469361435ad.26.1735436988871; 
 Sat, 28 Dec 2024 17:49:48 -0800 (PST)
Received: from [192.168.125.227] (syn-156-019-246-023.biz.spectrum.com.
 [156.19.246.23]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-219dc9629acsm155916565ad.46.2024.12.28.17.49.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 28 Dec 2024 17:49:48 -0800 (PST)
Message-ID: <dbd73c27-4ede-43f9-8503-e3e1f64615dd@linaro.org>
Date: Sat, 28 Dec 2024 17:49:45 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/m68k: Handle EXCP_SEMIHOSTING for m68k class CPU
To: Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, qemu-stable@nongnu.org
References: <20241229-m68k-semihosting-v1-1-db131e2b5212@flygoat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241229-m68k-semihosting-v1-1-db131e2b5212@flygoat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

On 12/28/24 16:22, Jiaxun Yang wrote:
> EXCP_SEMIHOSTING can be generated by m68k class CPU with
> HALT instruction, but it is never handled properly and cause
> guest fall into deadlock.
> 
> Handle it as what we've done to coldfire.
> 
> Fixes: f161e723fdfd ("target/m68k: Perform the semihosting test during translate")
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
>   target/m68k/op_helper.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/target/m68k/op_helper.c b/target/m68k/op_helper.c
> index 15bad5dd46518c6e86b6273d4a2b26b3b6f991de..95b3d5cf052c6ffd515afdffd5465550ae3af455 100644
> --- a/target/m68k/op_helper.c
> +++ b/target/m68k/op_helper.c
> @@ -285,6 +285,9 @@ static void m68k_interrupt_all(CPUM68KState *env, int is_hw)
>               /* Return from an exception.  */
>               m68k_rte(env);
>               return;
> +        case EXCP_SEMIHOSTING:
> +            do_m68k_semihosting(env, env->dregs[0]);
> +            return;
>           }

Oops.

Anyway, better to hoist both calls to do_interrupt_all.


r~

