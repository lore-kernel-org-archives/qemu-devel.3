Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2319EC369AB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 20:53:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u83ZK-0007m1-9i; Thu, 24 Apr 2025 16:53:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u83ZH-0007lJ-KP
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 16:53:11 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u83ZG-000856-1S
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 16:53:11 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-43cf680d351so16086665e9.0
 for <qemu-devel@nongnu.org>; Thu, 24 Apr 2025 13:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745527988; x=1746132788; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5ASBBnIM+JvTdvlbys0J94u5zglYl4KJNYKLn6kQ5z4=;
 b=qmvTxHeGD2Rxf0oqJ+eW02OdTWdqdorJT+KJr7ETSBka24dA1urssQn4etbXZXCLUY
 Ji9VqLyZLI5Kbcd+sIXY79ywqVuPo5HtnhiydyHtpdcuRsj8EcBXwzH+zwn+GXUTNSWV
 nKprtB7BSSIKt0JsJYJIa+eG0vG3M1GiMxVp/JRArxny90I2WT5N77JWOGnJsRqIMGHs
 rBbUtoc5lJBY7IJHjUWXW9Ieh9qwxRpzz4yJodzl35IveAkglAnK8Oxd2P9TJCcexsVb
 6E4NxxUxukkZuaSdplctVEzZ2HhzIXBEHazNfR5wM/8TuCmeqO7BfCWwKdiVlonWfnNH
 1mXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745527988; x=1746132788;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5ASBBnIM+JvTdvlbys0J94u5zglYl4KJNYKLn6kQ5z4=;
 b=eVxyP3GIH4dhAmAFFxBR0yRXlxo6VZuHyrf6hAQ/s5ZcGA8U9VeE3Q1HoMhLOiTduF
 yL9WI0gMQtd3p9rUi8OxMjCI4uK22iIFn+XqQQtabaBD+YYTnmj1Q8DJRdw9ZxqbyzYf
 MozOKHR3pBvs/4Rm1PzIvSjvQbIMsE+GXk9WKIn8XUIhfeJ19p0VJ1gPByGmrrDXva8f
 bIcXrVjNdjVsv503mqff94jIUih29c5DjZ7tJJsBEEADkoW87zNtvrvyz6Gb9lzSYunE
 TwIhWRx6LxVveDw9MEEI4qasSUxZP0ysQj3LVIkdhB+Vf1TVj62S/Mm3OFLepuxwNxQ6
 cXOA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWpaLD1tivd+TFcn8sxq+1WumT1wL0Lp9e2ee1FzvaZn+FUKkPS+jqWXnTcnwRylVR7q2FK+raWcvCi@nongnu.org
X-Gm-Message-State: AOJu0Ywa5EpPrHeohXlBkba3PiY+N9uYggyS+BSEFd8WemteoE7gvs0G
 0Wv7bOqQkiBowdKiie+FwxiXzPXNoMzkSKuxDc8cIVDgFffA6BBn0fYRvtd0kwA=
X-Gm-Gg: ASbGnctoWXqe4mUO9bj1C6ysZvUHcJq3mZbWc3jKSqgfygPBYM+nBU40Zhy7BwA5tWZ
 S/UOO0S5i43RGacGorQkUUQEhbza4X3G519j33F0GUsGXGPg5KGug4t4ifH591XOqlH2pUoIjcy
 XaoMFuJH+yKsIUF8ogX1iy9fkZP7I2U1BkhnkjayzRIo5ZRqR2vYK/45Z0JtUTndFCcVVbRbo/O
 Y7tG/fcbsUDCD6i+g7g5stLMXNS416oJn6zr/T47sjzhJsrN7Hneep6QiB5bmv59meZJ4sKj841
 1HMqiqisbpb2g8oFN3jd98XNgmpvrIOJCq0wuzMXCFPjb1aPMwiPoFFhUppE5Ax9py7ulDm0jr0
 9Of1Luaqpb6IpdEPYHzw=
X-Google-Smtp-Source: AGHT+IGxqOjNbppitLfZ2BJSkEW1UdBbVodqqk6N82DsRpYxISOW37bJOYQuRqctNz3LFf6K8k8JeQ==
X-Received: by 2002:a05:600c:3d11:b0:439:873a:1114 with SMTP id
 5b1f17b1804b1-4409c4773b0mr33657075e9.6.1745527988021; 
 Thu, 24 Apr 2025 13:53:08 -0700 (PDT)
Received: from [192.168.69.169] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4409d2aab65sm33071215e9.17.2025.04.24.13.53.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Apr 2025 13:53:07 -0700 (PDT)
Message-ID: <ca665cd1-e060-4920-8d20-872c4de2e84a@linaro.org>
Date: Thu, 24 Apr 2025 22:53:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] tcg/loongarch64: Fix vec_val computation in
 tcg_target_const_match
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: git@xen0n.name
References: <20250424190741.738515-1-richard.henderson@linaro.org>
 <20250424190741.738515-2-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250424190741.738515-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

On 24/4/25 21:07, Richard Henderson wrote:
> Only use vece for a vector constant.  This avoids an assertion
> failure in sextract64 when vece contains garbage.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/loongarch64/tcg-target.c.inc | 14 ++++++++------
>   1 file changed, 8 insertions(+), 6 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


