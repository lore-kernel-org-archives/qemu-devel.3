Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE34CECE589
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 22:15:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snmev-0003w2-5R; Mon, 09 Sep 2024 18:14:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1snmem-0003NI-7j
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 18:14:49 -0400
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1snmej-0008HZ-2Q
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 18:14:47 -0400
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-5356aa9a0afso8467111e87.2
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 15:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725920083; x=1726524883; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Q6Z7Eppn4WkcnRDYXeaQcLF4ZIWvzl8edl1uYcGTQRY=;
 b=CwRFbJs/b6dVHOXlLiIvDegkqaF3b+EfaL8s4GZmWariiE1EuYLXOSPrkro3dpTLJ0
 j5Fo9VjLhDu5WaDxLqUYMLkAoqRtY4KKy1vRJl7n++LirJGdxpb24hV7XaKkuaFA6oRq
 8ev/4pd4Tqm8VOpX/wIss30fEMBB9dw92jvae2x6J3Nv3wcZila20b63stvt4coIWnLn
 d4GTNcZSiYEAYy/VfztGupdeF+wl6E+aS5a4POzMuSvISRZLTblauEUUgb64pW38VKjq
 HrwbPXEjcNerk2Ujt/g1iFhS9G0ILUInsKy16ujzYCI85L1GP/a6benXHPT1ZBiUk6JY
 Z41w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725920083; x=1726524883;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Q6Z7Eppn4WkcnRDYXeaQcLF4ZIWvzl8edl1uYcGTQRY=;
 b=Jkn1miHVk4SylfzZ02p2AGsCtEwxArlEVFYr7+7j1osW5qBCQjTOkytIuGWCXTz5Rw
 etZu2NUDi4AWrPrlEqEHKNJ7hlFnuYn6i9D8xif6U8FbHSrOSvG0jCljtDWiRrzKYbED
 x/zBd+l8FGJWJlHGsG1rWg+9DK5iYrEJxBslpYZqRL/MV8r116EHKBeScQq8snPmWTfm
 vXLM0r3NPrUdTwZ9YGkDp1ZpJIZAiXBOZRpbbk8ejc/gA5yHuDGkTitHfTuEYTGZczhf
 Xx8LGsmyYaJItOGj3GPHPSQL5oatwkj3sc4V61bohi1Cx22TKn7DnHjwTLP4qklIf938
 4LPw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVVcMr9+3iuh42RBwMArQlgbwH7qxOFQRdpLYbAsB/PucaTBMbsGz8ESBaQb6OcDzmFpEBwRzRrd8ks@nongnu.org
X-Gm-Message-State: AOJu0YygUelmMOi4ZUdE2XbefZNdRcXjPIzgQ8WUvLhQjlxx3QK+fACm
 4esl1VemD9keGOycTla5tI046kVZEayyv6ar/dzVgoqgiCnmhjpaDCxWE+VuEus=
X-Google-Smtp-Source: AGHT+IGkeG837elBNJTILgSL4hDB9NfgS7+5abh1f2T96WEAiykBRNTkVa5tQAuPjrLtkzMkwUqsCA==
X-Received: by 2002:a05:6512:3a85:b0:535:6951:9e1c with SMTP id
 2adb3069b0e04-536587ada96mr10634526e87.15.1725920082962; 
 Mon, 09 Sep 2024 15:14:42 -0700 (PDT)
Received: from [192.168.69.100] (nsg93-h02-176-184-54-166.dsl.sta.abo.bbox.fr.
 [176.184.54.166]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d25c7277bsm388095166b.102.2024.09.09.15.14.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Sep 2024 15:14:42 -0700 (PDT)
Message-ID: <86bb681e-c7b3-4b0b-9212-6b0221222354@linaro.org>
Date: Tue, 10 Sep 2024 00:14:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 20/26] target/m68k: Move gen_addr_fault into gen_{load, 
 store}_mode_fp
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: laurent@vivier.eu, daniel@0x0f.com
References: <20240909172823.649837-1-richard.henderson@linaro.org>
 <20240909172823.649837-21-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240909172823.649837-21-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x134.google.com
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

On 9/9/24 19:28, Richard Henderson wrote:
> Move the exception to be raised into the helpers.
> This in preparation for raising other exceptions,
> and still wanting to return failure.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/m68k/translate.c | 10 ++++++----
>   1 file changed, 6 insertions(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


