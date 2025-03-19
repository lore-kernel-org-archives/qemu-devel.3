Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21886C28B28
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 07:28:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tunq6-0002vu-GV; Wed, 19 Mar 2025 03:27:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tunpI-0002km-AT
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 03:27:05 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tunpF-00066K-FO
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 03:26:55 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-43d04ea9d9aso19362135e9.3
 for <qemu-devel@nongnu.org>; Wed, 19 Mar 2025 00:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742369210; x=1742974010; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=91syd5qkyFBqb+gtKhIMDtD9gCAqjqxowmlvaEv9PmY=;
 b=MKfT8dR2pCQFwX3OMRHRdQbC/dWvayDnOXhH7Sd9/+uOSE1unAUtj4hCQqKLCIlS8D
 bmSV0iwRvCNdaUF6ijdT3BCIrWUXHahG/N8G9P0vJ0/zqbUgTjLiY4hxp8HjBi+/vWlp
 QxnrdEr58eb6m5nCx72wLZzGdEmSm+bAXe3Mj5wWUbTUWvGekSmk2jWPuPC82f2/Q7qY
 LqR3yZrwy/RQHm6tyh+8aBzh2tkiLNIzlwTQsqubGo6pw99ykKS8Lf+o86qGqzh4xKOa
 HRObYellW+FrsfUT1Wy/iryg/zVEoIq//J2cmzM5GUftCsO5Gcc+ol9ki+xYwLlzATMj
 E5VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742369210; x=1742974010;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=91syd5qkyFBqb+gtKhIMDtD9gCAqjqxowmlvaEv9PmY=;
 b=Oom7JLWVAe9fUswNvbjQr8czGKu99B4NgDP+9TyNKdePRrJNnz/+UqSHihwSQEO15B
 e9JuudOonEnjiEKxl9Tco5aksMQQFlZep7Nd57rYrFDOvj/6YNd9yjnGaVYbBFN9zCiu
 6NKcvcotKrt3po/f6cyyiEfcmUrEzffEEht0q7IFRG1UGB/yHcphZjdKCVNrNQNzeEMI
 3RMiKP7y5XAd1PmZBJcy+0BH/hlpxU3mTMsDu6ZqrpHRVYtyzqzsit5KuPE7bHEUev5j
 +PhL0+9K+nwGU3N0h9srfKbH0NvDIO+JFfNRUwqhC0ttH7VLyan3F9a8gGtymn1rK3CQ
 uT3Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUYEr8XHyROEa9oEZophPbMY94pbfqRZTJvRqe9iySTmB7UssM5O4+12BiIEUPaq6YETeKHTQMe1i4Q@nongnu.org
X-Gm-Message-State: AOJu0YwaKWzqVmkm4yAepmqsnq6Ot6PsNjYfLXwYspij5xnJuXM4RCCg
 GnAY8jdQ5wvcQM7jFgw/jKvPv7npMxx10YYBd5/eYvM3uvhRReRHadjDB9AAWAM=
X-Gm-Gg: ASbGncuoRlT6Mkk2Ldn0tqGaInVqoFEDwDuY0Rlcd5tJpGOz+NdSVU67JkyF1oVya2u
 86SyHCaI8ky7xnZCT4O/MYDWQ1ZTOWQuYTxcrXP5pI6ySJsolkF5XaW99lGjqMV3VHzutM973ma
 QESVYzvniELKA9rpDD0ob8D2IO5KBqUYS/X8nFY9+2hrdE61ZID56MK5KioVPKAoetPh1OWnQWI
 P1cbFlwpiImVwaFOISagzR5j+wBGnZHHnKMlhFFRYalNEXie/GTsm2PBqWITHUot8Nd5LQ+3tQI
 FDGoBd2z0/ATts9b20zIPoYJc4IdVJqnkbnHP77IwmNcapMejZYRC8nJZlecT3Xzaq19ggomSyh
 IctwfJ5a3esC7
X-Google-Smtp-Source: AGHT+IHZ0hok4eiAWm1IAlRlGg4tFBi34hFIL9oMYKjsG84PwHARlDGtQnUgatpFQZvrQ3Q+U2ny1A==
X-Received: by 2002:a05:600c:3b23:b0:43d:bb9:ad00 with SMTP id
 5b1f17b1804b1-43d437a8f73mr11883845e9.15.1742369210424; 
 Wed, 19 Mar 2025 00:26:50 -0700 (PDT)
Received: from [192.168.69.235] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-395c888167bsm20113198f8f.45.2025.03.19.00.26.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Mar 2025 00:26:49 -0700 (PDT)
Message-ID: <efeaf8cf-a6a6-4b9a-a54b-275eb0641aa1@linaro.org>
Date: Wed, 19 Mar 2025 08:26:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 39/42] include/system: Remove ifndef CONFIG_USER_ONLY
 in qtest.h
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org
References: <20250318213209.2579218-1-richard.henderson@linaro.org>
 <20250318213209.2579218-40-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250318213209.2579218-40-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

On 18/3/25 22:32, Richard Henderson wrote:
> This is include/system, so CONFIG_USER_ONLY will never be true.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/system/qtest.h | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/include/system/qtest.h b/include/system/qtest.h
> index 6ddddc501b..84b1f8c6ee 100644
> --- a/include/system/qtest.h
> +++ b/include/system/qtest.h
> @@ -23,7 +23,6 @@ static inline bool qtest_enabled(void)
>       return qtest_allowed;
>   }

IIRC the problem I had here were uses in common ARM cpus code.

i.e.:
target/arm/cpu.c:1786:     if (tcg_enabled() || qtest_enabled()) {
target/arm/cpu64.c:765:    if (tcg_enabled() || qtest_enabled()) {

I'll recheck how code evolved in your branch.

