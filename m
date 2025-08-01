Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BE24C87FD2
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Aug 2025 01:38:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhei9-0006dp-Ux; Thu, 31 Jul 2025 21:37:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uheWk-00073d-MM
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 21:25:43 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uheWj-0006LN-6K
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 21:25:42 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-31f3fe66ebaso2239390a91.0
 for <qemu-devel@nongnu.org>; Thu, 31 Jul 2025 18:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754011539; x=1754616339; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4PkS6NJWZlEvIkgId2xY2csCYbG80mFPQANLk+r2zgI=;
 b=ziJpfYl9b6qIfVGgal4+6m+YfJU1nZAz/7F3qvWPQC1qgC0pOK/qLxKt8tck6dBnv9
 ZKl6LY+db5im8IZcpkgXxtG5Lr2wBkSIXkOrOG5t7lqEKhp01get8kppNqheLiqBqROL
 EQmUZw7swh0E/WBFBIyFlxD79Yg8SoXEiiZni1yuiKm6T1hxllSeIAu/NaD6kzO0TQuh
 A+06vOtRo9fiQpqzQOGgXsGYogN1LNako0CGImegG2oQ9wA1PMzG+NanIHaG/Y/wLc1+
 7DeUYueoXtOIyhRLyhokGmfJE6KEJ/sbkZ5XwAEFmz938xcsTLr3B7WkMcgVn9Dlcl2C
 wtlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754011539; x=1754616339;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4PkS6NJWZlEvIkgId2xY2csCYbG80mFPQANLk+r2zgI=;
 b=ZkrZuofMgQePjqs0VH3oKkpzeA9Av7B/gY4l3QAv+w3in/TTTM7f/SFBaByLHOyUC3
 rtEcYXl8lDUtF+mWV/ZjFzQF+AFUAgDEbrJ2GtFMLxAR6zvXzmAwul2o9x0tqoPalXUX
 tm1efPOFw1eqoLYS5C0c+LCRTKFMSH1j4Sg7GX1bT70nAh1cZk6CmLJAD0WvgpvhXD45
 azRlZWH/MXH64Mxe0qATrQAvy3D7JRA9oZOeJMW69MDg41gh0UWNCPI4BuCNEtsMzDr/
 tCaw10gompWvBSlm+KPJGsT96T8n0dQS+Y9TQKGM2cvNFUEfLspdwVXvCBMFqu8BXq5r
 jn2A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUT1LE+P+STveM4LDhMsZorP9kCjTg7iGCPmvGiZAspM8gPc5EQj1QbaFbwGJlp0UMWvqx1IiKC4PUV@nongnu.org
X-Gm-Message-State: AOJu0Yy8ZnZXN7pEa+j7kUNK8I1I2Z0vzH1ZkE9nowV1LHcEYVk7zDld
 X8sAzSQkaHOZFDK38lZQtbEx1OwcAviN4nyOWs9MFYjknXgpSrSs2qtReW9+HcogrYk=
X-Gm-Gg: ASbGncvj8G+3+axCTg2ap+OgKBRr/31sC0wiV9zamCDJ/2laABSN/2NmvruWPMFPPLn
 b/xHq4nj5iHPs1GoabnDJc8wPIajLfUrMZm87QlPnoNuJQPxlTHh91EJi28UJ6IsckYj0xgX6s3
 wpRIHpCSVSHldcu8tW6O6+zIaKlOKvUhw5wVcskOmbftK+6GsmYntIKz+j7e6/Ik/o8Da8z4W1y
 1b5c3NhlTJEv+TGygBrQ/tDapXLq3P7XJ1SYAQIESxc2aMeII1wl0zTe4hB5JweOFLu9AKVBQ0A
 UgnwP4QkKPk5sDDMWm74Jk0cZwGr/hQrrvZpkcTGkVR4ArU9+3yaI0qo29jGDKECJgz/x0fnvRl
 dzmBT/r7x/vO5YMOqViJ0dx1fsa2iFjSwgwi5peaO
X-Google-Smtp-Source: AGHT+IEqzMwfSW69NBLAK9pMQKegBcPHAYyFTfJHUaz1tnLGrxUK1T8HSKLoxzoj/zLV9lfDq+eWJQ==
X-Received: by 2002:a17:90b:4c0e:b0:31e:b772:dfcb with SMTP id
 98e67ed59e1d1-320da604471mr6543903a91.10.1754011539505; 
 Thu, 31 Jul 2025 18:25:39 -0700 (PDT)
Received: from [192.168.4.112] ([180.233.125.160])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3207eba6f4csm3128282a91.5.2025.07.31.18.25.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 31 Jul 2025 18:25:38 -0700 (PDT)
Message-ID: <8658920e-34ff-4aba-b412-92d06b29fe5b@linaro.org>
Date: Fri, 1 Aug 2025 11:25:31 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/10] semihosting/arm-compat-semi: replace target_long
 with int64_t
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Weiwei Li <liwei1518@gmail.com>, philmd@linaro.org,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, qemu-riscv@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>
References: <20250730220621.1142496-1-pierrick.bouvier@linaro.org>
 <20250730220621.1142496-9-pierrick.bouvier@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250730220621.1142496-9-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1036.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 7/31/25 08:06, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   semihosting/arm-compat-semi.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/semihosting/arm-compat-semi.c b/semihosting/arm-compat-semi.c
> index e3b520631b3..715a22528ab 100644
> --- a/semihosting/arm-compat-semi.c
> +++ b/semihosting/arm-compat-semi.c
> @@ -502,7 +502,7 @@ void do_common_semihosting(CPUState *cs)
>   
>       case TARGET_SYS_ISERROR:
>           GET_ARG(0);
> -        common_semi_set_ret(cs, (target_long)arg0 < 0);
> +        common_semi_set_ret(cs, (int64_t)arg0 < 0);
>           break;
>   
>       case TARGET_SYS_ISTTY:

Here we have a semantic change.  For 32-bit, we used get_user_u32, so this will always 
return false.


r~

