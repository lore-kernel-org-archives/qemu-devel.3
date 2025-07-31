Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 205F4C87FD2
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Jul 2025 21:29:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhap4-0008UQ-TH; Thu, 31 Jul 2025 17:28:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhaXl-0001z3-DJ
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 17:10:30 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhaXi-0004rW-U2
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 17:10:28 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-b1fd59851baso645200a12.0
 for <qemu-devel@nongnu.org>; Thu, 31 Jul 2025 14:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753996225; x=1754601025; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0k2LYOTpondkh0QlH5cLHMu4xCBe2JvKaBoAdGyR0FY=;
 b=meNfrQxcvuo5gdrk6eKAQDaqwR1X7mBMHq0Y0QlCuIIRG5kFIEG8eqZrvgCfJ4mxnw
 Ets4+S3Ppo3cw8UL7BdzmUORUZs+F1ixclpUnSD2FjdLWI0i7krzIN6reQrP3LUdDYLC
 IAToJ6Xe8yXNPb7l5ICRC30ka5qtwMYUiuPIRzp3RQZQiYDFa0TKP0ukCF4VUL3k/pSN
 x/mpwQ7v7Aqfd3fr2flyl7OdZpxVg1L0kdejwcX5vLIBoCAZ28VfgSl2pJqKJKJxwvq6
 19DAI7HH3vXty2ZvPlc0P05xipgBYB81otGQ8SytnkkYsQVX2b5vwhJe6McKEVfquUBY
 Cn2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753996225; x=1754601025;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0k2LYOTpondkh0QlH5cLHMu4xCBe2JvKaBoAdGyR0FY=;
 b=wXep0bThKksc3+d6Cs3UE+/ug0CUT1rmVyPbRUQ0MI5c7hCF5apNw7pD4Z7D9Oz57C
 JUmEmaden4B84+zgO7GGmunDaFiTMRbuKYErL6CtkL/uXLJvzpJ1c9zwsACISwNXQE5I
 8VES5RDe0bnvCDKNLYnKP79d5PuHGAxmpEozbbACXx7AgzAfMqbXBktxgvxTPVjT7Mmm
 I08tYTWaDamT0xToRShcfje3vBRoTdMrvVKFvzCWfol/wWPG4WcFj9v8hk93x9IrAclB
 GSXgJZrfcgD5CaO6TY98lJURIpioKju6/HW34kIOa7fzLPSKnMyH8okxRYLV0arOaZlD
 1ycg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW7v2zMpOY0aqaEMKl3J0D0MNT6XsIcAksQOAqZA0KzrA/Dj126LtLduWyhDjLhHGHG0d1UTBhSB7lf@nongnu.org
X-Gm-Message-State: AOJu0YwEEFplKLdYOGdh4f1YnengksX751ueworyWBT2408jjWwS0Nj5
 LH80gxV/JvRME87UwnrQtFvhL9kaW+La5qTHTQOB1jRq9o5UcsgMtmGYuqeBQ7DLGYw=
X-Gm-Gg: ASbGncsCvaDC50HOvu2ixPIByAX6VBCFyZ3+foEUdnWCGs62OzRblXHoLsHtSR9C9RE
 Wp+3v6W94+uJ2SCsvpNfZxvF6j/+4XcYutUlZ6ZYrQP6BiUXyROIEEo0gg7LEr30j5CfhStWusc
 YWYj9hwqMaJFLmjobxEDm8X6avMCfdPGa7OjwesY+U6Z69Lu1Xy8rZV3hwBPnxrA+PA2pQ7Wi6U
 WUo81NtN0iW/3zfyRYp4+OtpSQTSNLOTvt62nWcWAQ7D3s1nnxzkZFALhe/joDgapaDEqxYK/Zn
 EhURFyk3RN2wJhjxJAUfobdirvHqyVM+96k86011OAB/Lz6OH96Cn0H3M4BHXMettnwmEG01cIf
 M16eyLiXIHXRXCySb6/inf5BU2pHc03vZFL8=
X-Google-Smtp-Source: AGHT+IHBwiv0gB8Ke+iD146VL9sbyMOeqyopNmnibv4VYHmWOAV1v/FdgNipeXtECHKsUaIqLR7dyw==
X-Received: by 2002:a17:90b:3504:b0:31e:ff94:3fa6 with SMTP id
 98e67ed59e1d1-320fb75c126mr343748a91.1.1753996225394; 
 Thu, 31 Jul 2025 14:10:25 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-31f63f0b4b9sm5594545a91.27.2025.07.31.14.10.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 31 Jul 2025 14:10:24 -0700 (PDT)
Message-ID: <ef306c22-ee21-4e39-9f6b-1e8ec58a98e7@linaro.org>
Date: Thu, 31 Jul 2025 14:10:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 52/82] target/arm: Emit HSTR trap exception out of line
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20250727080254.83840-1-richard.henderson@linaro.org>
 <20250727080254.83840-53-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250727080254.83840-53-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x536.google.com
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
> Use delay_exception_el to move the exception out of line.
> Use TCG_COND_TSTNE instead of separate AND+NE.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/tcg/translate.c | 18 ++++--------------
>   1 file changed, 4 insertions(+), 14 deletions(-)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


