Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E29AC83F26
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 21:08:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhE1h-0007Bf-CO; Wed, 30 Jul 2025 17:07:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhE16-0005wu-6P
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 17:07:20 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhE13-0005kW-4X
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 17:07:15 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-7682560a2f2so213077b3a.1
 for <qemu-devel@nongnu.org>; Wed, 30 Jul 2025 14:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753909623; x=1754514423; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RumQlkc7hEzWm9lGIcgWyhIVpphtcbkJHVovvoUjnZ4=;
 b=h0WLpiAQrRt8Z/vaHeVsenrokvDMMZV9F7PGhgCvQREccPvQNb2VILIUKPAvVaiICe
 t1cRhkKemqT8JNC6zAuIMTn5JUKhfbVkyC1pnWpRS7BHGArRO0mdGL8IOyPvrx7zhR0h
 7X1o9N44W1ZJ/7+QlWWAKZAJXpV/jjb4ygRj4rnZF5SNAze/Ati9szxEuSat7fIk9/aI
 aLLOnUK8gnrPWaoCU2KGyLPRCTE54X6D74UW/ueAAJdq80n8HRaMx7UweSG1MyWLAacR
 SfPI9K2sWWgM/3X9hPtG3lMYuwZNv58S+YjbvkkW5DHPmBt68/QPzF8ieWKueaCJmbTH
 yvrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753909623; x=1754514423;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RumQlkc7hEzWm9lGIcgWyhIVpphtcbkJHVovvoUjnZ4=;
 b=HhbRZ/DyMbH3W+eqZ5axjuE2m/fmBR+Qjn/yp+CzqcBVYGLaX2HXG0+GlWh/HkcJnY
 uMtzKlD+fyey/wD+oqW4F0nGo2GaoLrESGaOKJ76jwKkWf2OxYSWI+2oxLe16CRsGI+5
 AwpKZk/FK6Y9i20SkuATsnwW9WoPuEnQi8M5mKixfsaNINjdHLBgjjxkhE+3E2M6NFXu
 /rksJhIdOnf8hhU/HfjSBpphkeJIsvcRS+KxS/66kVT38UNNdfoylOH/0C1GhuVZTML0
 Slnj5WnITuGIeWeWrS3e4MWqZ1wc8kB4iPyiQ8yjc/4Ju1N/N5oaP26xuc3RMokBaS2W
 7fug==
X-Forwarded-Encrypted: i=1;
 AJvYcCVgYukLy0XK9B4v7lnIV5AqPnxhHANJTX7EwGM+F+ju5soGI/eAc0/LDQYpRE18L9Nq17KEpDTPvKLc@nongnu.org
X-Gm-Message-State: AOJu0YwPQpMRpepfipLLYldXvzccfAfs7hG4wCrkZrn7cTVTPLlKsXyd
 3AaR0KyYnjtLtwWHjYCqdP2Rz6Z8rxYHWz3VrOR3EOT36PzZdHKm9p8NzhHqmJCN/YY=
X-Gm-Gg: ASbGnctIBzi/Z6lHJHyz1IFtjQVkhxyuklYMxf5rkq1BtEXUrOK0T0phXnKDMFWRx4R
 /15Na8gZLMWcM8SWF7OLvwdmoHcYMjJtOnH+Qs+YC2OdOnIQPNgB9myIA+JCdskFLNSXNei5w5+
 +1JMOm2aISprv0zMsxt6+ZtikvFIQQ52BIg9lQpPxgcd4cbCw0Rk60/g3YA3OCVoP9s7FWNmvbV
 ORPNrvnIWg/Co2xL4ee7cdz/HPZPbOWyhYtHmlenXBlos+49WZypuG16RaokTQyO51c3ZmJ8wa8
 oG/Pm5Maq4fMjXb/71m7gA19jZON/Lrf07KCPL8UqA/KTsSsacPBr0t30GCInQAG6xLS9K7y8qP
 GYXhNkJZLUDLjWy7Rgts/OQ4pBdsC3AoKXfA=
X-Google-Smtp-Source: AGHT+IGcO0/vnDKPMu+1eGlWGp84zkP86iEjhCMKq9XAXdj58hAdUB7o/hLD1rIHCnGLyQfVupJQNA==
X-Received: by 2002:a05:6a20:7490:b0:220:88f2:51a5 with SMTP id
 adf61e73a8af0-23dadca295bmr13671500637.18.1753909622737; 
 Wed, 30 Jul 2025 14:07:02 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b3f7f6b0817sm9859096a12.54.2025.07.30.14.07.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Jul 2025 14:07:02 -0700 (PDT)
Message-ID: <b9cc7220-c3c7-4954-a8dd-996cbccd52a0@linaro.org>
Date: Wed, 30 Jul 2025 14:07:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 28/82] include/hw/core/cpu: Widen MMUIdxMap
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20250727080254.83840-1-richard.henderson@linaro.org>
 <20250727080254.83840-29-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250727080254.83840-29-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42c.google.com
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

On 7/27/25 1:02 AM, Richard Henderson wrote:
> Widen MMUIdxMap to 32 bits.  Do not yet expand NB_MMU_MODES,
> but widen the map type in preparation.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/hw/core/cpu.h | 2 +-
>   accel/tcg/cputlb.c    | 3 ---
>   2 files changed, 1 insertion(+), 4 deletions(-)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


