Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4158E7717F
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 13:27:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLjD2-0006EV-8E; Thu, 12 Dec 2024 08:26:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tLjCy-0006DU-Na
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 08:26:26 -0500
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tLjCv-00050c-QO
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 08:26:24 -0500
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-71e2766994bso258244a34.3
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2024 05:26:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734009979; x=1734614779; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1txznT3aBtWrlG9pkx1PzxbA4fvvuc3OCJhfFh7+hBM=;
 b=g/y95xDCscIwS1gXOxMu9iLbvnB8gbiZH44osB0FMvb0PEouiSvfbZ1NT++o/lcrZO
 Z0njzdEMvJRRj7Pq6JklNbsoL+irGmwKPw3sxa4dBKnYmRuNttPgglOcw0Bv54g+9y4A
 ucJtwSMGU08K4eoSH+DNpobdX71iQg6gT3GnKwc+KP30XdBV6OAqq8UCu+dwwU05kRRt
 cT6VMMHR/BEqrnnIk5ZFNvL7TNcW5UgM9OKfZlW/rJtTklSQnZs8/JNgtuDeHxnHJMhZ
 Nlo+gvLa9sjdWxI529tTm7UR5rTPn79TKsuW4cGl9fum2I/qp+gUuix7CB4h9ZO6Ud9N
 pnDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734009979; x=1734614779;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1txznT3aBtWrlG9pkx1PzxbA4fvvuc3OCJhfFh7+hBM=;
 b=TfiUyCGeq08Paq2NAbDO3obVlx50kHwjyRfHYC82cVREhQnRqOKPTZJK2vvv6Lv1Ri
 djqQagTpoYa0xERjQs6xlyddGKG6f0loJ2Zop/wtNO7o98IMWfqeEEuspQFBfZAtprPS
 C52NDcVZIc9XO4jMIRerdKCm2VyA+/v6iv0Sk1JHa1qM02S2KxYBqEqhMoJ2jHKIzFUp
 ZyX7n2W8yHk+hcEb5f5lGyPdsxH8V7wbWCDgGznV6t2WBuzGN5xdMK7eFoAPRPP8/0Wg
 ha64nPNlTsFVAU6M4l+rgOhvH6YpIM7ajqRWNC8QKzKs7jeNLGCmuXh24NC+UEujYiCp
 rf/g==
X-Forwarded-Encrypted: i=1;
 AJvYcCX6Du0/yT+ktempmScmtDBJZT6ZhlyW505CLUDcUcCR+XPZDPtm9/j9QpEJYt/uTh08WSawgJKqw1Ph@nongnu.org
X-Gm-Message-State: AOJu0YxafiSOH1OfUZ7+uc8m2c0VOBEjHs4j0HpOO3DC04mY9psYkgoi
 TTbVuw6sI4zxl64HX5CK89VPL+9TYx4EKe+wJu9Jyr+2haL/l6nAhDAjHrZO0gg=
X-Gm-Gg: ASbGncu3Jb8QhKX4vjaR3BJawtPDmSQ3hUg9xh0QvwP9pXtSgV7ofhTCDiwpcZI7gpX
 foH9lmjq0NM9k7cWZCUTVlB7HYUiBLGCsBfD2EXZGEUsv/4isLaqaBpGelSw52CRYxQzZd3iBjo
 R9sPGG85gWjV1uPdRSqf+FiFKZIFIGDm2y8rikvOiJKRQcBidgeTNe4pN9Zn4XPRqzrOkDQOCOq
 UsiuTCBrgB8tOIJXdlbzPwlA5TzVhn3atf7CfefzEMFQ1Q0dFZaf4vcJBWFAoqgfqZ1eDeo1jq1
 f6WTjucYnaNqZHfPtXZcwNIBWRM1RNRv6uU=
X-Google-Smtp-Source: AGHT+IHY4V7WxYoizCwJ5z2Gs/DNl0EJadJOyvtiLsperbOH/KEhiroGp4gQl8Mu1QDPPqFRE7xp6Q==
X-Received: by 2002:a05:6830:3689:b0:71d:4264:cce2 with SMTP id
 46e09a7af769-71e36e6a4d7mr133213a34.9.1734009979375; 
 Thu, 12 Dec 2024 05:26:19 -0800 (PST)
Received: from [192.168.4.112] (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71df2d54bcdsm2105364a34.33.2024.12.12.05.26.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Dec 2024 05:26:18 -0800 (PST)
Message-ID: <74eb2184-71a7-4175-aa55-f506b073564e@linaro.org>
Date: Thu, 12 Dec 2024 07:26:16 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/arm: remove redundant code
To: gerben@altlinux.org, peter.maydell@linaro.org, qemu-devel@nongnu.org
Cc: sdl.qemu@linuxtesting.org
References: <20241212120618.518369-1-gerben@altlinux.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241212120618.518369-1-gerben@altlinux.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32e;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32e.google.com
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

On 12/12/24 06:06, gerben@altlinux.org wrote:
> From: Denis Rastyogin <gerben@altlinux.org>
> 
> This call is redundant as it only retrieves a value that is not used further.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Signed-off-by: Denis Rastyogin <gerben@altlinux.org>
> ---
>   target/arm/vfp_helper.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/target/arm/vfp_helper.c b/target/arm/vfp_helper.c
> index 62638d2b1f..f020c3c34b 100644
> --- a/target/arm/vfp_helper.c
> +++ b/target/arm/vfp_helper.c
> @@ -1095,8 +1095,6 @@ float64 HELPER(rintd)(float64 x, void *fp_status)
>   
>       ret = float64_round_to_int(x, fp_status);
>   
> -    new_flags = get_float_exception_flags(fp_status);
> -
>       /* Suppress any inexact exceptions the conversion produced */
>       if (!(old_flags & float_flag_inexact)) {
>           new_flags = get_float_exception_flags(fp_status);

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

