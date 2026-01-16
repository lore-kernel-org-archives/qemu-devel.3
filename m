Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B16BD4A601
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 06:01:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgctP-0004nl-Fh; Fri, 16 Jan 2026 01:01:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vgctN-0004kz-7a
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 01:01:05 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vgctL-0007yw-O5
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 01:01:04 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4801d7c72a5so5112835e9.0
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 22:01:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768543262; x=1769148062; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=e3UPZEfF2ibq2MEl6XvBBMAIzGiMY5TrDNXm9djthIg=;
 b=AfOxM+N10XV+OFWDMy8mtl2KES3SGeUQ5+gdq9nTlqSY6OFZlxUglqar8Gu6Z0TjbC
 XNyvMEeciMWOpp3pnMR/i8gDO6818NEmJcN2hE2XlM2AsOWBdEvbh/VRNbXXt/WQxv3g
 pungpTMQrO75Mlh2HAXsVhWpxwhpK4u3BHv7PuawgqH6jR7+0BTj+SNo9ZI2acL1YjMn
 1GS7gDb3KIFTQT2AVB0lVdJozTMFPmrTYLE7H30zTQDi92+ik4r5Es6w17Dj+EyDYKUV
 Z+Bm8n7e7TXqdWQD+3O8J6SzslpjLhiobIrGhFKE2xUmPNNCk+dEVAOSwzSxsZW4lx+3
 7wtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768543262; x=1769148062;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=e3UPZEfF2ibq2MEl6XvBBMAIzGiMY5TrDNXm9djthIg=;
 b=ROjLySDcKEYVVyLEAlUl6rNRnDnS7qIFeHQlTblWAEZGxOvdTOY/fvhH+e5j+FcKG7
 wso9rGtIQ0LpxubK4dLTdZq7mMZH384ACf0J+EVHswD27HuO5DNRYYhHzjEbovkXiiYA
 SjzBYaYxNONqSCMpV0hpV8e/LO9bh9K1tUSw1T9YaKQ3Y16wf3SL2tHJaCK8PL+ldlD+
 SusekaxUfZGeKw04RWsfrmfKtYnFe8e5IsZXAT1Rm+K9s3TZvnxTYTQJFLECf1R2GoG1
 LZqQBxyfd3HwV+ppeD+Gi/+6V3lvYhMhTydEIM7jFdOp5mMd9dw3xagyohY+XthbkjVz
 FbuA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXXf583h/0PUNGx2vEK/tZeqyxob67NneupVPVBqBA1t8K4lEwDntlqxcCaFKJlIt7SC0vykefSsgpB@nongnu.org
X-Gm-Message-State: AOJu0YwcU+l3CttC88LC7MXZZQge1PG+Zh1mcIaWaR2QcUiIabwyn5iO
 Qumjst4vXd8d+gFtFG2TJHy/tiGZee+Z8OPmOp43GUhf4n5Ha4lrUEm4ZN8nAsDtl7A=
X-Gm-Gg: AY/fxX55rJ8JN0NuXWfyyX2/2gDmb8XLTo9DNj7koqY2fCGrbpt9O6N2383jJmDQ8ys
 OmnUwjM3XTiFGChNez5hKvYVlXJwDdS58c3kD/Nxm15gjJFQfEOWr+TVCU5mn2L5Gq3TUFPsKD9
 +PcIvwMYRruY4p0QL3+KrGVRJSHtoH5VTA7BHX4DTcOvtXAb7cCNUQJ04WDzuQOdnk/y/NNLsvM
 GoHQwNoHw2MUahRf3meoU26Y3iNkqVau3f2eu82gHYubckumg54F3+V+vHuKni9gWxum34Cb/kw
 fEIWkknRnlyObzAvPPLlMpKdthp5/8muVL/IMRNxE0e6CKPNKY4KkTX9uING4304sMuoKvpq9sI
 +AG/xkFz20mpiGSTBl9qW3dmFEL7hr6z6EXT11aFgzKw4DThjKSzHq3eZ3Z/KMNPB5dmnt4yPar
 /aO+h0attpJbfwQDedEHo8xxRRvWe5rld90RmbT5RH+rS2stOuwu2HEw==
X-Received: by 2002:a05:600c:5304:b0:45d:dc85:c009 with SMTP id
 5b1f17b1804b1-4801eac09c0mr13176565e9.10.1768543261727; 
 Thu, 15 Jan 2026 22:01:01 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4356996dad0sm3052463f8f.27.2026.01.15.22.01.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Jan 2026 22:01:01 -0800 (PST)
Message-ID: <fc213839-5ec1-4f58-bd33-8db5645ac45f@linaro.org>
Date: Fri, 16 Jan 2026 07:01:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/58] meson: Reject 32-bit hosts
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: ktokunaga.mail@gmail.com, berrange@redhat.com,
 pierrick.bouvier@linaro.org, thuth@redhat.com, pbonzini@redhat.com
References: <20260116033305.51162-1-richard.henderson@linaro.org>
 <20260116033305.51162-9-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260116033305.51162-9-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 16/1/26 04:32, Richard Henderson wrote:
> 32-bit hosts have been deprecated since 10.0.
> As the first step, disable any such at configuration time.
> Further patches will remove the dead code.
> 
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   docs/about/deprecated.rst       | 29 -----------------------------
>   docs/about/removed-features.rst |  6 ++++++
>   meson.build                     | 17 ++++-------------
>   3 files changed, 10 insertions(+), 42 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

