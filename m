Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DBE9D489A3
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 13:07:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgjXW-0000sQ-9n; Fri, 16 Jan 2026 08:06:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vgjXR-0000rh-EW
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 08:06:53 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vgjXP-0002mj-OO
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 08:06:53 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4801bc32725so9341005e9.0
 for <qemu-devel@nongnu.org>; Fri, 16 Jan 2026 05:06:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768568808; x=1769173608; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rMBiL8Ik4KobwQMZUOPGCIKZuj7DVBHdotEjvdgjHUo=;
 b=HipKEfJx/JelJEF05i7si+ngu4H/uuXMg2OckwtnyAJtqcBklj0WnYhJVaS5Cqpuur
 p5WrxBdklnGIuESfcoYufVUqWj4HYNywelXhLIhL4YMCSMt2dVISYyDBV9MQXYLE7Qbz
 Tk19IvnPLWla+xMLWmsQSdWKKXTzustvRMS9IDcL+z7jBEVMwiA6HlUrXxMjJtFghbwo
 cukamMfN0GH1uU4YP0O7mirVT2TpZUuZ3D+JHoEjhl6hImournSYsO/kCFRyK/FQuyCP
 gQ1ASG11lNYd0W3GppsgXElsDb6kTUAMSPzmUBbS0kVUi3/BA05ZwEPLl/FyMMFdhH7N
 DXxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768568808; x=1769173608;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rMBiL8Ik4KobwQMZUOPGCIKZuj7DVBHdotEjvdgjHUo=;
 b=hRBCyEOWIkOzXva2sqFKRvqkr3ACfKrGyPGwHOY8PEAFlnrRgUqk3IvAUHIMMll7kV
 zsnygJCYYgEia01lIhsKgKThGxIn+4uqZxSa8hCN89av0G5V8jnNkAeBwjZ7hAKK/CK/
 Czyqx8zrYF3hywtoblgAzWEiRBhn+ZNiGqJ/gQbNupBJzfXASjm9hn/IB3GD03OTMvnU
 JsWWTg8mA8jYENdosxyHFQDDUk9aH9kSXYgajLbDpn6thQhkkYELtqKBy+eGJJrm5LL5
 s/tRkBfrMnwRYGUVB/C6/KxEnsIH9iwsgXnsWAoSyYRuj7LLamfmybHGdXkMj5DTPyCa
 IRvg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWKHshUUk4pZfswb4YO1bLUFKifNzhnkLsfMy30CXrj8vOkbqBOi5hoct1M7IAv1/edCHUyvETVzPpP@nongnu.org
X-Gm-Message-State: AOJu0Yyu8Z1gf9pgPIE1/au8pex2QPd9yJ/0D56d6/Vxmdl/QIpy+oEB
 bcqaEyj2v9J0NjSxnXAl45236WI9DnjNWDXa+6ILPTovMKCK7qVVlfagmA6dfnzwSss=
X-Gm-Gg: AY/fxX4AGJar/MxZNN0qlwwln+A3wUaBvc+b9Ap5golXaPIBBSbM4D8ENt2/QsgzzMR
 FwDdHwudGq4MU/JWRnmo5Tks7ddJgJeus1YWWKC+MkPAM7PRy2fDZ2iuuiZ68b5xIlsvAjnWdH/
 cOH5trxhkRLIFhEVPt53MkOH26mN4bEBB1uKqwwaH9ZS4L4KK3vIO2KWv6UjMEyT2uf/sCVfRdU
 A/eBAbmnhqOTYs53q3Fsgx6fsuK8PDIHQh4HRs9l0thVJmNQXUYC8rSjG2RnMwyzGbkyUGx1MlB
 Sb7dUpHPDumoG0yDetf49xoKImvWP528nJmg0LrlgsmU4xauOZyrXW6ZmGimmMhiMGMao/QIPRa
 X/HlnpraFq7Vi7Zq4NmDy1gg4L6HX9YUVzf8N+U3hPjz5xZ/8a+3wAMgUoH5LiE6dsAfI5cgMdd
 AmptJMReQ64j6PyaurpJnjzCR6G0z9/LIwjiez1Cu33yhmzi/b4E21TQ==
X-Received: by 2002:a05:600c:37c8:b0:46e:1a5e:211 with SMTP id
 5b1f17b1804b1-4801eb09213mr29567465e9.21.1768568808381; 
 Fri, 16 Jan 2026 05:06:48 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43569926ffcsm5255158f8f.18.2026.01.16.05.06.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Jan 2026 05:06:47 -0800 (PST)
Message-ID: <0263441b-ff23-422e-bb53-726fd7fd8795@linaro.org>
Date: Fri, 16 Jan 2026 14:06:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] bsd-user: Clean up includes
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Magnus Kulke <magnus.kulke@linux.microsoft.com>,
 Wei Liu <wei.liu@kernel.org>, Warner Losh <imp@bsdimp.com>,
 Kyle Evans <kevans@freebsd.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>, Michael Roth <michael.roth@amd.com>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>
References: <20260116125830.926296-1-peter.maydell@linaro.org>
 <20260116125830.926296-3-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260116125830.926296-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

On 16/1/26 13:58, Peter Maydell wrote:
> This commit was created with scripts/clean-includes:
>   ./scripts/clean-includes '--git' 'bsd-user' 'bsd-user'
> 
> All .c should include qemu/osdep.h first.  The script performs three
> related cleanups:
> 
> * Ensure .c files include qemu/osdep.h first.
> * Including it in a .h is redundant, since the .c  already includes
>    it.  Drop such inclusions.
> * Likewise, including headers qemu/osdep.h includes is redundant.
>    Drop these, too.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   bsd-user/bsd-mem.h         | 3 ---
>   bsd-user/bsd-proc.c        | 1 -
>   bsd-user/freebsd/os-proc.h | 2 --
>   bsd-user/qemu-bsd.h        | 1 -
>   4 files changed, 7 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

