Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9FA0C02194
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 20:47:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg8lm-00085t-S2; Thu, 06 Feb 2025 15:46:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tg8lj-00085C-5k
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 15:46:40 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tg8lh-0004Dg-GR
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 15:46:38 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2166f1e589cso34866925ad.3
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 12:46:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738874795; x=1739479595; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5GRup5ROKgyQDpJmIzSbu8dIfXd8csqbh9/bDVrBuq4=;
 b=P+wdnoxOrgWGRVm1g/s+vdSdDCHYeH4mVf2jcsz8UJUThjyGWFkShYDbaM7MfuGC9J
 F9fePhOSczR4yKf0eCdVQ3+7pG3SCFOcKnNBzHYnm9SWieUb2WXP4gQbuXCG0GSKrzAe
 2wGZy4ksThUVgpAbdTpipupoYssy8dG0427/aPO3MdyNhran6/rw4WVQsTrqit/s2BjZ
 k0KsV/oTaCQEOSxJJFXWAY0cMf7KK+msoj4QYILK1zNPBCnNHQpho3BW2Uo500kMqY8f
 8HURYc0nmf4Y6BEtluzlR7eEVMqQUfWE+3TTxiT8uQr2Cml2RSEDjuAL3jmgTM1zUT7h
 HhWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738874795; x=1739479595;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5GRup5ROKgyQDpJmIzSbu8dIfXd8csqbh9/bDVrBuq4=;
 b=skpg+TgadheSHoDvKCrBVdQSpG93jis6Twwjehk6uZgPl0UybehY8ZtErGOR2owKZb
 FcJe+Ub1ay+poo2pAUHe4wVfi7anFIYQcbrdW/OWN8qaAkpSoYaOShwCbq3hXN2x1EMB
 kl3ES+HD8gTggxHauxzvfBNlvCqy/lkbx9hKznhv3B4T5tmBVFCPgZ2cXo1wcssLbGnE
 dgPpHWgchWWW/xL9T/uw3drhIBLXb/clgdi+MA3sVkK0zdJdFD1V3VDANjI5vUSiB79F
 syRTicc1Vzt7Rfsg95gJYLVvi6eWGK/3hlR3fsGM2ahz3YKl4h7WvRn266I5n7f6isWL
 9tHw==
X-Gm-Message-State: AOJu0YxijfgHGUewf24RXQuHTWBLPkjeIh8gOKknSS8wAYji6ldT6qPl
 tJOIlBjysR8Mm7zefT2jg0IHZ2YdK2kYh7GYGGatMNu520k1jSRTzLz+zM1kLkxz0G6rDKd0zXY
 2
X-Gm-Gg: ASbGncvxSzmLX2aUmzVa1xZCFAzWLevtrS98PQ+bFS6by7dlGkKc5ZK3vkr+HFStDNC
 Hpw05qLFf62IiyjZTEYzLK3kNNxeEucNiWUd+0Vk4qz/S40JYwWXa6zRmdvDc1vGiKih743FFsM
 eq17SUcjIr6xr5iDTJl225LFjXyRX5GyWOMlROac7Z0XV+IAz0c8YAE1BO1y7zmUxIGC/KkMQpz
 f8/3kcigu33GChHRofWbglOQ2afbJ4kY7Z+AVs2mbdnYhVpxoKh0ojjHnRnJQGem4Rl6/TXWjJS
 70ERbOWDgE76z6iG6LaFhvPdDuR2lBGx+bEHfyprFqh56XLs/OT6ksU=
X-Google-Smtp-Source: AGHT+IE9XkigiFY0eu9pawJbBBnhNnpxj7Mvsj0Jj1Ll0uSD1kbdrIVzTcZcBuLLlSNBh5s3QXrYZA==
X-Received: by 2002:a17:903:1a06:b0:21b:d105:26b8 with SMTP id
 d9443c01a7336-21f4e1c89cfmr7823965ad.7.1738874795489; 
 Thu, 06 Feb 2025 12:46:35 -0800 (PST)
Received: from [192.168.0.4] (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fa08268f47sm1866250a91.13.2025.02.06.12.46.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Feb 2025 12:46:35 -0800 (PST)
Message-ID: <bfadcd17-3a3d-4fe2-a352-f0bcdd830177@linaro.org>
Date: Thu, 6 Feb 2025 12:46:33 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] monitor/hmp-cmds.c: Clean up hmp_dumpdtb printf
To: qemu-devel@nongnu.org
References: <20250206151214.2947842-1-peter.maydell@linaro.org>
 <20250206151214.2947842-2-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250206151214.2947842-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

On 2/6/25 07:12, Peter Maydell wrote:
> In hmp_dumpdtb(), we print a message when the command succeeds.  This
> message is missing the trailing \n, so the HMP command prompt is
> printed immediately after it.  We also weren't capitalizing 'DTB', or
> quoting the filename in the message.  Fix these nits.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   monitor/hmp-cmds.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
> index 0aa22e1ae27..ff87fd89e4d 100644
> --- a/monitor/hmp-cmds.c
> +++ b/monitor/hmp-cmds.c
> @@ -431,6 +431,6 @@ void hmp_dumpdtb(Monitor *mon, const QDict *qdict)
>           return;
>       }
>   
> -    monitor_printf(mon, "dtb dumped to %s", filename);
> +    monitor_printf(mon, "DTB dumped to '%s'\n", filename);
>   }
>   #endif

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

