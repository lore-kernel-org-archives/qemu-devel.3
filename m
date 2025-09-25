Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35B70CAC5B9
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 19:56:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1s34-0000Fm-QM; Thu, 25 Sep 2025 15:54:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v1s2v-0000DK-AX
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 15:54:29 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v1s2m-00027t-Im
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 15:54:27 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-32df5cae0b1so1636281a91.2
 for <qemu-devel@nongnu.org>; Thu, 25 Sep 2025 12:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758830056; x=1759434856; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=huGg+JDtn/sFdBpFQQur299CQ0GD+V3S980nc4yHYDE=;
 b=o4HyrTTRlewOlMj18FBW9+KvASmk0+/ikdiypex4NkQjTX7P5dFkcOdhTp03aSeFbv
 rsFwMKjR0+p7bgcUoJTYXZagHsU0nvRbiY7Ge9kVS/3jMhyozexeWGVgUgPZB6bCU1xu
 lLC93jc7S+0yVFXPk+ciOgRylxI+pAV1SfHUgCnNHC1GkLpEq4pVzLAQt0rwaZdPRkCY
 5tzbhMA22FgJM2yC48sn/s/qvxIyFw9gR5y3pX0ZHj5Uamn+oE1JBPhR62gEOb+L16P0
 GKKCeioirHbzf+T+ykT8rvXf2yy3fCxBDHtx284dRsD9MKpzxsKIB6cnuwTcexvV1/49
 wfMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758830056; x=1759434856;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=huGg+JDtn/sFdBpFQQur299CQ0GD+V3S980nc4yHYDE=;
 b=uDzsIz1dhSxVbJ9y/iW0IeQf8zeoZ//hIte+FIxNjtJQ1aOzDVWlKL2t2arqYTVrzx
 BhgIzFkf2HEDe4ahPO8k99rACFSkiXwzZeOC7pC3N2wjG7wiTMvziIxvzz72br8RdrSd
 morYUvbafprh5R8vW9K4JAHAUI0GNxE9bb+nKFeLM8Mi9XH3nN1vLLlAtnkJnI8xSAxn
 Yw0hdvC1175i3vWngMjrbEyLW66KaYA48LQk6Lm0+SEn67pygRxRrTNWeXsOEp/B0vDR
 HnULtb4BqzLij/u8QUm62k3kuC/+ypwhuslvwNRErgXWMX0h/nZvrXzmBzsjr+g6g0ag
 bHeA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXIaZH5rwNmO0bXqaytVdCSBlzqSRHpgsQk3M5JIHmAWzChRmwVhG3HOZAbllMEfjxjOriJR+kFtuzu@nongnu.org
X-Gm-Message-State: AOJu0YzkQE3YiQyb1vFNwyrYcH3Kk2O/+WTT00LuNMXBnN8aWw2x6OO7
 +lDr98cBq4pKevhAtQkjlpHjPmOxEfkUE5i/1NVF0AjUbAXUt2rWuiOeRwwkhCT6Ba8=
X-Gm-Gg: ASbGncspvlMYisn44v5qqw+UpLQssWKzAK9rdXauJ++Ny9GpWOKmgKtrTfIFdw/8uh6
 iJAlL2nRIUvpkWxhZujp5ZbGAg11Tv/NqNHPXzw02HVfMRyQyOgHJWvoo5hRxWOChFYz2BbKZ1X
 MCzDBr+dsFTJMSPtxfJZzt9hmuwbnpWVQyQo9tARIg7UlU7NKBi3vq3iOZgwo03fTsz7w4sD5UV
 lm6coDfRqTlNHO9w0MyEx8TA+2GW0LLE4GAXy45DkbTz1aFmWu8HFkox++XfKTneZvGXkXoo7gQ
 Hi58wpiFLixwCDSClwCbpcu2uebgykgvTp7JxGfLBOTJUTg03B8a7CP+RET0/zPnOIAp1+sBsRG
 iCmRDZmL8e9jHPHN3dW539yi179HXJ57lvs7A
X-Google-Smtp-Source: AGHT+IFhl/ns+PLhbKtjh7jgrF/weQmm9CmxxrtR5ypWrDNA9JBRv42FfcppOpJfeHuBiLF9QKMsCw==
X-Received: by 2002:a17:90b:3911:b0:330:6d5e:f174 with SMTP id
 98e67ed59e1d1-3342a2b1263mr5134919a91.20.1758830055785; 
 Thu, 25 Sep 2025 12:54:15 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-33471d735d4sm3259397a91.2.2025.09.25.12.54.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Sep 2025 12:54:15 -0700 (PDT)
Message-ID: <960eb1ad-7b12-45ea-ab40-1fb1d0d82914@linaro.org>
Date: Thu, 25 Sep 2025 12:54:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 16/23] util: fix interleaving of error & trace output
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
References: <20250925094441.1651372-1-berrange@redhat.com>
 <20250925094441.1651372-17-berrange@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250925094441.1651372-17-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 9/25/25 02:44, Daniel P. Berrangé wrote:
> +    if (monitor_cur_is_hmp()) {
> +        cur = monitor_cur();
> +    }

Didn't your last patch set return Montor* from monitor_cur_is_hmp?
Because this takes the locks in monitor_cur() twice.

> +    if (message_with_timestamp && !cur) {
>          timestr = real_time_iso8601();
> -        error_printf("%s ", timestr);
> +        error_printf_mon(NULL, "%s ", timestr);

Passing NULL to error_printf_mon is fprintf to stderr.


r~

