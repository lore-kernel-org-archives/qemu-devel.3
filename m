Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC1D3EDE997
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 03:34:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soE7k-00054r-GF; Tue, 10 Sep 2024 23:34:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1soE7j-0004xT-Gk
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 23:34:31 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1soE7h-0001Vv-TL
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 23:34:31 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-205659dc63aso62578715ad.1
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 20:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726025668; x=1726630468; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3zH6hjyCBEKG6cy9wCvWZOi7dNJ8goyBTvXCd0KuMp0=;
 b=eqTZt7cENcNe1uP6/MLn8bn4kWoP8Ss5XwAiDaKizHebrRZKEsc71EEJJMJrPWaUDg
 ZAoNTvx416SRASM5sY6FGfzNCq/U3duVHqcgjzPcrX14fIabpnLrW9s9gNLpHIYYSCpB
 njqx1YW2nP9E5kGPptpx9SnX4xpguTiLMg58r290iVM18RHwftUTHN8V9xI1wD4IZMaH
 YrF+Jnx+UKp+EGblrBMFkC9qQj3Uvdxkbb6G42+QqiGzbPd7VSKTuQsZARJyOZarYnjF
 8OJNK+uNaW7sxUnpwdtbVIkVF0LOS2Zs/diFlzH7wP40xgPb+IMr6gUFuGsAIaAcF4gV
 US0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726025668; x=1726630468;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3zH6hjyCBEKG6cy9wCvWZOi7dNJ8goyBTvXCd0KuMp0=;
 b=caRjI4KE2UbGzsfDM09HEqtY7L54i2dNyUgVfRh9TZ15tu87PNo4ZwzSMFB6B2gMMw
 TJugJVRWHHN75ptUKbWMSVB2sxYi0Oihsc1m/5gzMmVoVRMcQ7HIQPr8EZNtQnZosGu9
 +bPTBK6KsHLgMKMXrzRiW7iv16CIgPhBVPSQZpT0K4MLPdZs0U81KQG+AmwUpYEq0E1o
 MFdHqiv6HpYVIEyvycV85g3zbX8XxC50JDDeMtCYH8kvN0yoIG8uG+72C7u5SI8XeFBr
 VQiJ0230ok1V9ORBbeLd6Fg0FEwikCDbH0EfpwjmONMdud+ZBGBcE+pSnAG713VUEeM8
 ZIfA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVl/80Nqh/UBFSeHPDr8aLGr5o3Vue9gKaAO6lFX1qVLFyeQ3b7NOb/xeVYZRzCuITzFrm1gjL/g2fN@nongnu.org
X-Gm-Message-State: AOJu0YyXOeWlpe5al7ZClVybjZ+4J0hpp1NOtw+NGp7BXfN8/bZ/OugL
 5PxEQU0MC/QlvSZdfy47yZA4EaiAAwj0EcrSAyGOq8E5B4ph5e0VAsovTKCrPl5+1M0ebd/o2dq
 0
X-Google-Smtp-Source: AGHT+IHymXu6+axCN7oWRRDR86qLAwp00BymO7Npjtg4KSbwFsPneZ1bwrdAOjaU/Vin/y+rC/38MA==
X-Received: by 2002:a17:902:f948:b0:205:500f:5dcc with SMTP id
 d9443c01a7336-2074c727da6mr25244435ad.40.1726025668250; 
 Tue, 10 Sep 2024 20:34:28 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2075d237a6bsm897245ad.303.2024.09.10.20.34.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Sep 2024 20:34:27 -0700 (PDT)
Message-ID: <1c6af120-19a9-4e90-9144-279a1c63fad3@linaro.org>
Date: Tue, 10 Sep 2024 20:34:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 35/39] tests/qtest: remove break after
 g_assert_not_reached()
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
References: <20240910221606.1817478-1-pierrick.bouvier@linaro.org>
 <20240910221606.1817478-36-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240910221606.1817478-36-pierrick.bouvier@linaro.org>
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

On 9/10/24 15:16, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   tests/qtest/migration-helpers.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/tests/qtest/migration-helpers.c b/tests/qtest/migration-helpers.c
> index a43d180c807..00259338833 100644
> --- a/tests/qtest/migration-helpers.c
> +++ b/tests/qtest/migration-helpers.c
> @@ -76,7 +76,6 @@ static QDict *SocketAddress_to_qdict(SocketAddress *addr)
>           break;
>       default:
>           g_assert_not_reached();
> -        break;
>       }
>   
>       return dict;

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

