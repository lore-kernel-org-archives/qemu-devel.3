Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8149CCCD185
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 18:23:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v968s-0006Ra-7V; Wed, 15 Oct 2025 14:22:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v968p-0006RS-Lk
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 14:22:27 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v968j-0001Kh-Ty
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 14:22:27 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-27d2c35c459so48902825ad.0
 for <qemu-devel@nongnu.org>; Wed, 15 Oct 2025 11:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760552536; x=1761157336; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/STDRoAWb8UFJFxgp00vJ9KV3E79VsLiKPiglUNkuM0=;
 b=yvotLoC0XJvAo4NTVLvMdr1kW9JhdC9JgYKtO++qmQhkkSzLhahRfEHjCcNHsi9JDy
 HortlHEF0mMpnHe/UGuPlbSoGkYyyc8bdgn+QVowPihFgwRZ/60NLNo8DWANuH+wdg++
 rvhbNAXlsEv2XJeCu8XQoVpVbt1k0hcsAV1EY8/vYP8YSVUIG4iulciUPuBg9gqmLXfk
 /m0e7PlSGrKfs3OFwjy8cd5nienXU9oJpIPHe/cuQDL1Llv06vHFhsu/A/N7HD+b5Rqq
 +bW+8sax7PckZe00ddZJgfcWYQ3NISxxD6S883wrDnt5czweJ9FUZBnpxQKNS9rvljyo
 7Ruw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760552536; x=1761157336;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/STDRoAWb8UFJFxgp00vJ9KV3E79VsLiKPiglUNkuM0=;
 b=vTu9arhOyLh5RXcg0/ldIqHm3Wd3WsBgeRZm+7ksID2IoWzN6I1Ivs28LpjCTIOyIO
 D1BYDYU1dtUUTKxAOZfk3iU+BdQSMORs/xiQ4ZuqXIi3/NpJOBedsXoAeZ7AbpSQQ6qq
 iZ0Xb7tUCo8m7n/RuwDQddXjz3va6S/ZlIvcC/ExQG4kMbzOKdNbWWQsC1hITMDEFul6
 dJ1gZf8DY5SfqjBg5rm5EmYZZkgQImxOHeHLg29mSVE46UZSnEpvluynG1f41N1v030Z
 87Awk1Kaypvxwz1Ivz0rFuxh+qs5gYWIliwKNvrx62UTG4wezUWHGyvLmXEZteNeqtPr
 22KQ==
X-Gm-Message-State: AOJu0YwhyDN+SeiJqUHQaQuldB7PJawLV5l2mXB99kjLJBOQuUKBOqWE
 wu4CDaE1/U/jZy73gj+6sSekt5bemmghapDlQPv+fQQaAomTWz5/z2poYYc9EqWGm7fiGJNXeHC
 zn5wVR5E=
X-Gm-Gg: ASbGncsh74viWBYrkpvEkkErjeNzuZTIC41ZKI/z/d9K/lKF/Nxcw2/uKKPHe7vIkuQ
 W29ki194imSe/S1+PYKNE21en0B6FTKDCdpvzS8W7p7YXTVIGSjnNXo1Bn8fJRD00/8MPtRWmNT
 XHPzm0Tq2q0uWvgUaVTbUFa4IPI3eMwRY1+vjntCmRQ+WDSb5l5H0H6+yibl5qFlRMjKti0e+jC
 PWhpAsLCkL6BLFnAWbpf0eLi+yfKDA2TSgaUo3LJcJ5JIBA3oFOOTIs44KKXgL77gZdkyleMZV6
 1VleNMPEPBWbhDGClO/ETnaUZBqB4s1YuwYJPqaVBHbmsDLEtQdZLWxVvd/5ccNQc0aNSKAjdcW
 Kjv83c5xYDp3phlHdwlNXNT/6BkpPc2GwjPQvJ+7IhxDgfzJd5cV2rOVDEk7mvXou63pR2RAqMh
 kXbz/R
X-Google-Smtp-Source: AGHT+IEmBLW7P7QCbrQfuvaXRCdBCzlB1hqjT16XpTLIu5IDIshEyyVQn+3bA4M9P3V2zNsb4Y67Sg==
X-Received: by 2002:a17:903:2b03:b0:264:70e9:dcb8 with SMTP id
 d9443c01a7336-2902739f408mr365060525ad.55.1760552536217; 
 Wed, 15 Oct 2025 11:22:16 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29099aba04asm3006745ad.89.2025.10.15.11.22.15
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Oct 2025 11:22:15 -0700 (PDT)
Message-ID: <07d52dfc-b821-4cce-8224-3901713059d4@linaro.org>
Date: Wed, 15 Oct 2025 11:22:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/7] target/microblaze: Remove target_ulong use in
 gen_goto_tb()
To: qemu-devel@nongnu.org
References: <20251015180115.97493-1-philmd@linaro.org>
 <20251015180115.97493-4-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251015180115.97493-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 10/15/25 11:01, Philippe Mathieu-Daudé wrote:
> translator_use_goto_tb() expects a vaddr type since commit
> b1c09220b4c ("accel/tcg: Replace target_ulong with vaddr in
> translator_*()").
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> Reviewed-by: Anton Johansson<anjo@rev.ng>
> Reviewed-by: Pierrick Bouvier<pierrick.bouvier@linaro.org>
> ---
>   target/microblaze/translate.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

