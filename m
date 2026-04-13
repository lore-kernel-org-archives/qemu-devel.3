Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05A31E93817
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2026 04:21:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wC8mf-0007nz-0K; Mon, 13 Apr 2026 00:20:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wC8ma-0007km-6q
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 00:20:22 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wC8mY-0006Jg-II
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 00:20:19 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2b2429f98d0so24709065ad.2
 for <qemu-devel@nongnu.org>; Sun, 12 Apr 2026 21:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776054016; x=1776658816; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LNw0hoKQ41WblOWVXhwtYC1W/5fGL0BV9AzWD94r4e0=;
 b=EiHp0Xqj043T7DahHHkcBxxKCpA0SKbaW+bt25sXZFP14c4O5ABcOz2fhegEFYlAWC
 O3Lz9cLnytXYhJil49IuAzkAxzdXJGMt0GtRoAxQeJmwE3Ni+SNcMrQKkvfeq+1nvBHu
 Yxos6EfgF2aOhDFacJnwooE0JJpBlzxcamI9YodAegPysJXUiaaoGHxl0RdMLlCe+ncx
 3VLOc3aZ0PisYfziVc7qhUMjGSAufnF/TbcIV8avdovGmG5vTlJqkSrudDNkLYHLtR2Q
 3yJKViO1hA1Pg+y/L9n1AHtu8Gpqyik/jzwBZiwIXrBu1+r07Mt0UREpbDG5EHxfHYol
 W1FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776054016; x=1776658816;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LNw0hoKQ41WblOWVXhwtYC1W/5fGL0BV9AzWD94r4e0=;
 b=ls+cAoX+xnTri4bs6nlmNjBB8w3TFVWMqgXaOO+yNWey+VEjo8pOEL5wW3IHw1+WLD
 ybn38ZT3JMLfyPAADqMUIHfFkgjbEqYuyOE08V93If/TVyMICGwNpZ8H3tz8C6DJomH/
 tX/RGvtUxGmYFDa+Qfc4eIDMicoGZZ6NgtRp/Q5CdPPOwXF0DsxymfhL4snufR0u/hoS
 4eDzqULXwxHSm5BhOYXnZ63eKCcJ+/BgW4AtYidBObGguLGWEww0PeFg5t8CgKgIjQSV
 RI4+yhZtXpd0YozmX2KBvOovuBORZzEk200HIKcfcf3kyf4ZLp/+i7roczLTX+qZa5d9
 p+Bg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9k8skTpE/8pFmOQsMhcdsVeHdV/6Ubm3Pd01M5nJBSPuDebh5zUxA053YRir8UKv0LGL8bppjGc/HD@nongnu.org
X-Gm-Message-State: AOJu0YzRwHOPBmpFNqbYllEnTDFnNVqPycHUhnyZq2LIQQ91hU3C5KxL
 LoVduZ95uwzswJ6DyD7xzatNDRdIGfulhe80ATQ0mAWkQsd/L99YDbrSz4/I2bF0bQA=
X-Gm-Gg: AeBDievPhfa0O1Zs+TxIexoEiUNXaxw3SXi+XOKqTiZgwPT0UX1ZNHIZl8yQiH0vcSI
 wZLLSVvWm9/uLt3XFA7V1b0Tel6UJLNtC4Lg/HYo7RiXx3KZvw/N7yBg3MV8JMs/iHZZ5nISPAG
 xT+XVqhYDFfpnV5LQ0JGnqj3rJ4bnXFAX6qKQzXlFGerLt9OiytTIlgoXjdHiNkJM3O40W8Ey+R
 38Xi/2YGZaKOrQXMhGXjOcNTvjayXw3NVoBP7grO9I3BgDwHg8UCT8Mr4Qk4R+U9ZDU9ooJ7ukA
 9sG6XERlcDbs8epAaMvXN5MPJHLujyRoA9B//HsQv8a703k5CvPGOOzI/TFMUf0xLVlb/GeDSCN
 g/UUhfjTMm+areOM+qBcWaUdxYfBVkudxG/gyPZOXJORIsBcL2Q9ogSLKv2fsMw6sP2ccIrV56e
 w54uDEcGJ0uGD4V9FIg+H7DZxd7Y9XihZIdwwavVFMhwxikrGg0AJJWXpy9uaS8hfyr8gw5UlCG
 kOf+aMel56x61LZeddG9cygadlG6/VwN/CE6dZ7FtizQC80R0+R9i8=
X-Received: by 2002:a17:902:6acb:b0:2b0:5520:f497 with SMTP id
 d9443c01a7336-2b2d591ddc8mr89663365ad.9.1776054015513; 
 Sun, 12 Apr 2026 21:20:15 -0700 (PDT)
Received: from ?IPV6:2401:d002:dc0f:2100:a7b4:d4f1:5b23:321f?
 (bg30dj032xp6rdh0yngy.ip6.superloop.au.
 [2401:d002:dc0f:2100:a7b4:d4f1:5b23:321f])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b2d4f25d83sm101957875ad.58.2026.04.12.21.20.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 12 Apr 2026 21:20:15 -0700 (PDT)
Message-ID: <1909e5aa-ed18-49a2-b196-7def6772062e@linaro.org>
Date: Mon, 13 Apr 2026 14:20:10 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 17/27] monitor: Make Xen emulation commands generic ones
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20260410195323.17937-1-philmd@linaro.org>
 <20260410195323.17937-18-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260410195323.17937-18-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

On 4/11/26 05:53, Philippe Mathieu-Daudé wrote:
> In order to build hmp-commands.hx once we need to stop using
> device target-specific check. Use the generic pattern to make
> the command available on all targets, providing a stub with
> kind error message when the feature is not available.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/i386/kvm/xen-stubs.c | 12 ++++++++++++
>   hmp-commands.hx         |  2 --
>   2 files changed, 12 insertions(+), 2 deletions(-)



Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

