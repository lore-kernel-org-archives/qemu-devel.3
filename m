Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8651CEE01FF
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 03:13:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soDnP-0001ap-7H; Tue, 10 Sep 2024 23:13:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1soDnN-0001Vq-Uu
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 23:13:29 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1soDnM-0008Ax-DY
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 23:13:29 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-71798661a52so343634b3a.0
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 20:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726024407; x=1726629207; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zlI3QBv/gWzKZjxvJrm0zSp7Wu0btrZeCIp8jHTapqU=;
 b=x+UFehf+YXkyAHRbx/o8nCgSqM/DNgGDykOoTnuwTM3qal+DwB6ay5uCGjuUt2HmDB
 P0tCZqDNMLIq43utmyx+Jv4MPVNA/pReg92xtPfmmbxnov4MXwHYiWYS9JGiSQrtposP
 3gv2hjyk4tTuo4vzVXlNL3RlCbfKs3nzF8ShRY/n7IlHIyic7o7s73Q6HNJU0q6AmQfq
 jt62RrEP9Tn5CWFJGoifbTG8h1xHDgBZuxeNweA+1WbBHjWjFcbVrps27HlziFLHgtTW
 8hnbfMUqw2NY3vHYscy7oSyidJj+f4rED8GV0oUsYZaykscwlc5BeB/Pox33Lqq3DHco
 3nBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726024407; x=1726629207;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zlI3QBv/gWzKZjxvJrm0zSp7Wu0btrZeCIp8jHTapqU=;
 b=J1f5P4v+7ANlMR3G1f1W+gAJAOstKg8WtvYm5lY4+GN85qdhM4WNK/bITxiT51Ehos
 +wDabzPpMXQ9nAM4/EaFSeqxvjC6VvgzPJnBO7/Z0OB+cNIx5s1Be79azAD/nlNLBP9f
 MNsDxug7tJ+S/tHp9x70frKT0c8ClQHHEYeAbC98aIAsdamS5SwyscBZPi9sM6Fk3EkD
 fju9+t78w5XLPJhm3AZmDWNZ5e6mU1LvA/FhXceFW8TVYVTBBNq00yTZPe81k88WtNdk
 piM586spbxUfoisJ+9W2c/7qwmVDC6I+7NFkipNz4Bm47rm97q9MKSs9I1UxeWObw00R
 RuSQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXONFqeOcZlpZgafxP4tMg3gNP9PvZT7hjSGYi7uciosAM0U9wv6xtzWpbJwQWbHaOx7rNy741x3hg/@nongnu.org
X-Gm-Message-State: AOJu0YwFxVjYm8vFwcmV/sAM6N66pzDywFzREedDkZzWqt7R0LhRwlnw
 RbYaMYpvKBXgXH7VXb+f51XuyfGg/1CqQagoYitlCyEU0/qnc7gGu1+r4p9nX/c=
X-Google-Smtp-Source: AGHT+IHrWkoDjVa2xjJPvt7gBF6DMrr6jx7EQTWJWxbnG+g+mcEXCwdwd9iLQjq7GGOu7J8TiyFpVg==
X-Received: by 2002:aa7:8e46:0:b0:717:864a:8b0a with SMTP id
 d2e1a72fcca58-71907eccf82mr8552932b3a.7.1726024406804; 
 Tue, 10 Sep 2024 20:13:26 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71909006428sm2101442b3a.96.2024.09.10.20.13.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Sep 2024 20:13:26 -0700 (PDT)
Message-ID: <7cec22ff-10b8-423a-9f52-9197a6ff571c@linaro.org>
Date: Tue, 10 Sep 2024 20:13:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/39] system: replace assert(0) with
 g_assert_not_reached()
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
References: <20240910221606.1817478-1-pierrick.bouvier@linaro.org>
 <20240910221606.1817478-11-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240910221606.1817478-11-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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

On 9/10/24 15:15, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   system/rtc.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/system/rtc.c b/system/rtc.c
> index dc44576686e..216d2aee3ae 100644
> --- a/system/rtc.c
> +++ b/system/rtc.c
> @@ -62,7 +62,7 @@ static time_t qemu_ref_timedate(QEMUClockType clock)
>           }
>           break;
>       default:
> -        assert(0);
> +        g_assert_not_reached();
>       }
>       return value;
>   }

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

