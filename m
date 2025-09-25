Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37DFFCAC5A5
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 10:36:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1jKO-0001hV-CG; Thu, 25 Sep 2025 06:35:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v1jKJ-0001gm-4Z
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 06:35:51 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v1jK3-0004lY-SZ
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 06:35:49 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3ece1102998so574658f8f.2
 for <qemu-devel@nongnu.org>; Thu, 25 Sep 2025 03:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758796532; x=1759401332; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TVnT9/bfeElcUuZpxPL2NI8pn6v0NhHePey+agUmBBE=;
 b=VATd5TcxHSQlW5kwcQCPJctcL+3nXJNwHnYz6k7Tya6uQMKKXB66CwlJvC/Zwqp4zK
 n2/E1oCM+kIfcvvUaMPvDNMc615BUyhYg1wzXXMyjnr9M7/JaC6ytNY5/76b3Q7iqpFH
 AfgwvMuEfDgnUjK0snwTkcjKM8KH+OXRRkWN9EgmraD5jrcKQdAjaQZKxYS+s6ZwthqX
 6mGlDxSyWFccK8SOEFMCoNvCflBDfEEHm2dcpRK/dvSRg7iER43zGb3oP0zju386t8mJ
 5SAIM3R6X3+3udmmkgNqOrKcbLWBZTgfOEi+UraSuICYdYvnDNzpeqbtwTR8RI2l1hpZ
 PmbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758796532; x=1759401332;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TVnT9/bfeElcUuZpxPL2NI8pn6v0NhHePey+agUmBBE=;
 b=v5UzvfmJbzsvBENqWgoxkrMvgNCnhsT94CAsN0zUfT4heibvyyCnUuX7l0vOREpcVv
 mjoIyTH9se40ZUKKWRTkfQ64pBO9EHjTM6ceH0ozBPN6HdY1XPt80GWF2SwuDlOXthEr
 ovHLrXnphD4rzZQT9ZtALmAjVnRrkRN/7xtACqmgq7jW1iKEpMjalgqlNxqnHrCNjpCW
 yXSFPXIIWGMwn2myCchPA2xENeaJv9YFwH1HO2QOv2BzaVhC05aopBMe7uHdyFwATtXT
 nSbp4B11QRlNvZDnSyvDu5mhRKvIBp50k+LQROw+Q646SXotTvvNEyDIw43eKDt3qGW/
 TM0w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWFoCGyJH51/D3vk1bk48OA21bhT0S38tKqJgmiWWb1+ybj9S+SkMD8jMAWidCzHUlTRJmbOZmRsDsS@nongnu.org
X-Gm-Message-State: AOJu0YwmKmCqkxVx5CjqOm8yLaIu5x0GYSgBcXOQ6sGV0moFvdnu5VSq
 wedFdZRI7WhJ74gYePQWcB8/u3RYebvbiUOoKw+mS6UmMpWsLxGd/6kcFQlGTXaTkPM=
X-Gm-Gg: ASbGncvAxJPHVRt7arcyOvjuWIMc3gF5a6TvckJJo93ol0Gzc24d1l6bYPpgAz99/Bp
 yu9ity6MmFrOjAaPUEX9OR8YyxKYQIdW/yAmwWkGG/qkDUPGIyYcI8yF6obcdAn3wSDoPuu/FCC
 pGxz7set4AoTv81hg+gebI+2xdQy667lUkwhchoevLsMPP7v3kJzH14vIcurTYuXVtV8VuaRlXn
 /uZzwnOx8CjhY7TpCzgNlD8zhH4XbIBkn7kuvw97QBAFSqLkCS4dY9VDuq6JPD4idqa1cN9dr8u
 Y4Uew1C5NQ4EsuILRF8sfNkifQUykNrdENBzCFpk590XIjoNFzfXVfXMzW1M874qMxUvaVeTxjP
 abv0vXUpm2vy1yrnPbdBkW5xQd8zG7zYLdApVbVrRfs0vCN+zOdR8poZF0phviFoLWnjhkDiZno
 IF
X-Google-Smtp-Source: AGHT+IEQDYNen3/U5CUsqPlHGmkfGoQo3o18XqapKtke1ZP7TxMkXIx2u9Vtdwc/mxzut38IDcLu3Q==
X-Received: by 2002:a05:6000:2585:b0:3d4:15a2:11e9 with SMTP id
 ffacd0b85a97d-40e49e7291dmr2699223f8f.61.1758796531822; 
 Thu, 25 Sep 2025 03:35:31 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e33105e58sm14118775e9.7.2025.09.25.03.35.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Sep 2025 03:35:30 -0700 (PDT)
Message-ID: <1f36c178-223a-451d-a145-1938b466e37f@linaro.org>
Date: Thu, 25 Sep 2025 12:35:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/36] target/arm/hvf: Use raw_read, raw_write to access
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org
References: <20250916142238.664316-1-richard.henderson@linaro.org>
 <20250916142238.664316-10-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250916142238.664316-10-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On 16/9/25 16:22, Richard Henderson wrote:
> Reduce the places that know about field types by 2.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/hvf/hvf.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>


