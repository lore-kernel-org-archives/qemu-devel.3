Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DCB5D185CC
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 10:56:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdngI-0001qJ-S9; Thu, 08 Jan 2026 05:55:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vdngE-0001jm-Oz
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 05:55:53 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vdngC-0007LR-RA
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 05:55:50 -0500
Received: by mail-wr1-x444.google.com with SMTP id
 ffacd0b85a97d-432d28870ddso211267f8f.3
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 02:55:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767869747; x=1768474547; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fbHVa2zMXmTT23KDs5oE7gtAg08fYL8bf/s51vxqAms=;
 b=oTD5Bzv871ADSGvtccwYTs+UwIsQIMWlp/ZA8EJwXx7yBkXzwO+QUy9+key7ojmr1+
 ZuWe1CyoJg2K/DOxcNmRPjjE7M7pWeBdEUB5vA7WXBgnR3slF/J+FqQNXBEMaGDCw2JM
 msMn5RBA30tbAbAtFr7KoAiFm/USqsIhiLcOaCsHUqIOYhzME7SsjRat9zKUQ7oh4QQ9
 AirdHj2JzwGneeEautDzSx3y+zT3dg9rofhHaL69+k1WTW0AH5jYtI9eV3qRJ1bzzxDK
 gG6W61rDrmn/BiF/EWn1hhr2GO2ZcfPOFwUVOsy7JQ8UYLVXNd+Rgl+4XOhaxY/JsLik
 c5VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767869747; x=1768474547;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fbHVa2zMXmTT23KDs5oE7gtAg08fYL8bf/s51vxqAms=;
 b=dJaX2rryM+QB7djWPQzjDNUhXVPMi3Z+I44mv8lt3lfgMxvqmoqRoE7zYDG7XKnlg0
 BnnM+HE2AGUaPlPr5FoMtscehbq1n5YwDSVOaI+28xiI+Gk14PjQLlJzrUfyh6BtaV2H
 P3waFBR7wMkNxcKjRP4uDVLFa+y+Gh4EIP4YXk/ZoYVKAEuXlDbaBg8ZFEoCoLYu6ok2
 A2U78NW8U5Vevl+MrYBsocicjhD2ni1NyV6NOR72OKff0woK15OSDLrjasPiXurNVZcG
 Ay2gA5UwcvXNDDYnP0AmEoeLxJMwQvv2tUPIbsQLJ9evOqLNAUG2UUDs6CMNeJO4qvMq
 NJsQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVz8UK3xs10vV6ADAVfUiQCAsEGHPeReoLIII9NyLJoMgN+GGypAM7jgizDW9tDjo+bHHwqlz3tuEGP@nongnu.org
X-Gm-Message-State: AOJu0YxVwze1pxt+mqlzMktajErqdGwq/TTJpG/3atDmduE6KmZaMtGS
 izM9DUP9KBZbu73UKJLJ/8y1vws8HiGE42CVrRRpu0Vv3EHkdIiqaQclg3lW3NGWZAQ=
X-Gm-Gg: AY/fxX5UEQ850tOzWNHNOIOpENtCQQHfZyefME7i5cVI5nLtoPDtj38g/NE9AX87AHL
 wiQE1QudZ0+JeKYagkTUSifHE0IIveQ8Xub0+FPJtj0sf9tmPKpotPRPsUEdPOn24mb6FI0mVmd
 mMyo87zR9sma6E0V+9D4uRi/ZFtMxa/Lb0BYD8nyLJ0SydsWHbcgBxWpLhK+uh0tLKgVnPxGZBC
 1TLGEWJMJLwnYLt2A43e2HzcT116z2efkkKFSK1BH3aLsWlIbmgZ9AhKrL1deY/w+0Fr8djsf9e
 KqTvRz6u4FWP6WUpBtr1ARkFl1psJaWhjYezy5N18yo/lu328T09Uc6XM+HuZA5AtOAr0tB1543
 XSKvCcnRtpXyqTkrDkREiBR2BrscocLQHoxSFqhol3owcM6bIFvrDRIW6piSP+E8/sPofIXuEHV
 Pwq/aoX3uXVR9+Zyd55h45VIW4eY7nzCpb8JTt60GP3i9jZGW1rr+wpQ==
X-Google-Smtp-Source: AGHT+IFulqlBStm6OV5CAndDzBCDFiMnNgKs86HMu0FaixJPDboTe2cBAx+ttiqN1lYiSoVyzinySA==
X-Received: by 2002:a05:6000:40df:b0:431:a63:d3d3 with SMTP id
 ffacd0b85a97d-432c3632b3dmr7483939f8f.24.1767869746745; 
 Thu, 08 Jan 2026 02:55:46 -0800 (PST)
Received: from [192.168.69.213] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd0e16f4sm16174930f8f.11.2026.01.08.02.55.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Jan 2026 02:55:46 -0800 (PST)
Message-ID: <1dcc1199-26c1-45f0-8cc8-548f1ae82041@linaro.org>
Date: Thu, 8 Jan 2026 11:55:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/50] bsd-user: Fix __i386__ test for
 TARGET_HAS_STAT_TIME_T_EXT
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>
References: <20260108053018.626690-1-richard.henderson@linaro.org>
 <20260108053018.626690-5-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260108053018.626690-5-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x444.google.com
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

On 8/1/26 06:29, Richard Henderson wrote:
> The target test is TARGET_I386, not __i386__.
> 
> Cc: Warner Losh <imp@bsdimp.com>
> Cc: Kyle Evans <kevans@freebsd.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   bsd-user/syscall_defs.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


