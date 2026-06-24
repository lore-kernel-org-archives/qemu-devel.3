Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 103D2CDE001
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 15:42:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcPje-0002Y4-DK; Wed, 24 Jun 2026 11:41:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wcPjd-0002XZ-1B
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 11:41:53 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wcPjb-0007SC-Gq
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 11:41:52 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-845a3c05e40so723290b3a.1
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 08:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782315710; x=1782920510; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/0/noeunPNKExcuuv73UsPWuQhRxVACnWNF4xhGWwYc=;
 b=XHXfHkGBUbmnI0nCaPypNgDcttu400wvJRA9pi13TE/6EVYBqkrLLkxkp1y+jhYVOi
 vh6Xw1tmgeQkl4c8eUZIKIBnytkd6/XwLIHt7+eCxa+am7goidnga91/A7M4YR4/tyx+
 wH5OnKuG7rrSbAueZ9Z28dNIWqRlpM5YpzXTBFnh/RmnuVB0wMFJ+lMfU/N3foZUh9Zo
 8R0X0vSLoo9LUa92fvrZKs/wG+EGkcOhqH2MRCR0cm3UFZi+0tYQS6M4Slg0SVqTOO4n
 cnecEa+Xui9/EB0wT154+hfBk7MVOwrkzxAfyiitvYEgQrDHmqU/3SCTrI4TvSx8NGlz
 iRWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782315710; x=1782920510;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/0/noeunPNKExcuuv73UsPWuQhRxVACnWNF4xhGWwYc=;
 b=Sp4d7u6E7LqWsU7GW0npM7UjPaz74YJQACOzds2VNG/qnB9JLl2p6B8hmozfq8XLJK
 +YlFs83Lg1fHfwrCueWEi/DW8JFEcL+QqeJV9wjcWvgl5FJimMhuHTKCDgjJ4RwWWcdB
 t9Dd83XNAEvEJGCkqVg1OPL5NinVLv/dYTqsa+4Wdxp3i9z594c+JoQUbz4GKTD8ULuN
 eq8HdGIZWar03Yr04bOewQoF3IeuqfYIhN/UIbZaTNk5uojp9z2vg3bJDUsLauXZXiQI
 kKiP3IowhNe7ZNjNBQCzvaW55+5EU0fero+HLCm92W9TB3BBVi5Lx6SZZXGLRo0T6qS3
 9AkA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrqoUz8NqgC0xfWe4SBNKg4hyF5FrBW3c0gvl5gLdZMGrtPHhHL5+I7LNx7oJOV6Xk4qFoP9BmnmRJt@nongnu.org
X-Gm-Message-State: AOJu0YwMDkM+mhD5u9xZOs/2tRbv+IIcMYbFoA+Whb+OcU8XFT+Mi+WS
 J0w3S8bwrz+/zv+Xogf7K/8Kz0TDY5TjGo+Cny4RLLc17rPpiSxmsgn1wCz9xJ4kShc=
X-Gm-Gg: AfdE7ckmxY7fIWCt9uCEpr5zoLuSYMlqeTOICXEAvGvvmhCjq54oQm2IqJoMuWe16Eb
 J8SiB/qBeBYhbMhTO2zmA/uJtjT42O3r7TBDz7hQ+S2cF1kKdY3JDjFRRQFCHe1n19oZvTTFu6J
 IbQ1xL/0cow7sMQ9CbTJNsHT/Pb0CiWWtOyyMrrZpp7/1JMmoULUl3LOSnzOZ5zZq/tYat4UiL9
 cacMd9C3KVMbC7DDQq802sSzNjh9lc0+FnuU8bdpfFpTA6q30i7k6yIBjr+MM8Y2hlKKtpelitj
 06KAJsfep+KUfM7md+27aHiHP8lRzoed0eGBqcLvOZEAZmZDonqx5mJV2e77kTly70Dn2Pnn2hx
 HumqMTFe+ovLRRljEA7YIBnT6CX9A9AmH23QbeuhbuaKb3/Axh3iZwHSvcuD8Vu1KHfKS0qFND/
 iD0tYP0iNhxMZggNI6WfvzoAPYqiyKTfuIky1mwyPeO8c5Eq+myFxE/TJmtQ==
X-Received: by 2002:a05:6a00:2e26:b0:845:2ff5:b66d with SMTP id
 d2e1a72fcca58-845a2c58858mr5156153b3a.35.1782315709753; 
 Wed, 24 Jun 2026 08:41:49 -0700 (PDT)
Received: from [192.168.0.4] (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-845a40f54bfsm2411291b3a.46.2026.06.24.08.41.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Jun 2026 08:41:49 -0700 (PDT)
Message-ID: <48f20592-0df4-49e3-a2c5-2934d2f27d52@linaro.org>
Date: Wed, 24 Jun 2026 08:41:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/6] target/arm: gate check on scr_el3 behind
 ARM_FEATURE_EL3 check
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
References: <20260624124527.1018912-1-alex.bennee@linaro.org>
 <20260624124527.1018912-5-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260624124527.1018912-5-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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

On 6/24/26 05:45, Alex Bennée wrote:
> We shouldn't be reading SCR_EL3 unless ARM_FEATURE_EL3 is enabled, if
> it is then we check SCR_ECVEN allows tweaking the offset.
> 
> Suggested-by: Richard Henderson<richard.henderson@linaro.org>
> Signed-off-by: Alex Bennée<alex.bennee@linaro.org>
> 
> ---
> v2
>    - don't bail early - if there is no EL3 we still honour CNTHCTL_EL2
> ---
>   target/arm/helper.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

