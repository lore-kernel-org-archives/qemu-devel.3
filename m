Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6040EC36010
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Apr 2025 14:26:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u14TB-0001GN-VJ; Sat, 05 Apr 2025 10:26:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u14T9-0001Fw-C3
 for qemu-devel@nongnu.org; Sat, 05 Apr 2025 10:25:59 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u14T7-0005xX-Lg
 for qemu-devel@nongnu.org; Sat, 05 Apr 2025 10:25:59 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43edecbfb46so6596875e9.0
 for <qemu-devel@nongnu.org>; Sat, 05 Apr 2025 07:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743863156; x=1744467956; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:cc:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=G6f8tcaO4zwEE9EZ+ERqq6+TEX0Hk9/rQxpE0bwYDGY=;
 b=EY8MxTpsSkZ365dPAb67LNXNaPwlByuK0HJHnbvZHoJND1JXfjBJ6lQHGu11Y06wQt
 ZyBweDH80Fs8CHDhTU+3cPv16HwU+O/GqkS0ST0xp+YCrx5S7To3ReKB3zhqOCRlLwzo
 Tj5D5wzfT9ZY7ezCC41N5jL65u6ME5+FEWxtTJ7fU+auRGP/7HO1Cq960dOGN0nQORYK
 OYR9TW8CNzeBzjXIKK9MDy9p0RBGfJp1LRvSgQnGJWPRu3zsgmKKirPU/AHcyt+uqyVu
 2Zc40y36uNR+7wry3uk6l4hWz5bBWvlo4gJcmwft5Uw43K0De9mmhDIakBOp+nXYIXho
 XfbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743863156; x=1744467956;
 h=content-transfer-encoding:in-reply-to:from:cc:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=G6f8tcaO4zwEE9EZ+ERqq6+TEX0Hk9/rQxpE0bwYDGY=;
 b=HBR44SLUVgXIygC/2t65W0bnc8hBFb6DWJEQri3T2Ge28TWyAql802CvXJj6MbpHd0
 fFLB4e5Kzkl+4bkV5zcP8emvldMIMkBCLxLvg7SpURW7efd8kiWxeKB9mweL/eSaTMBL
 orSkqXYKv6PIBcTJdWTkWrmcrrwXVXJb1bObZhx2uecenlNUZLw0cOUrEMWkVxOV4f4s
 e3Z3rHYh5AMD3TAnnngwKR1LTVUQeMI8IDvzl200WojOGeKk+7McwpxEfKrlGxiarh7f
 7QFBUSjEDT6frD13aqtJZYM67xux90oFWowhkAAyuNvq+osP/27FtE26JT+YSIeje7CK
 2PTA==
X-Gm-Message-State: AOJu0YyUQm0GMfuAKZP45R0GuzO7eW4uaQlm1IRImRF00zAU0MUF2uXh
 QgTq2Wu+u5rQQrIKa6mK9f0M50ClPgjgrSKO74qrkRgv3waaGbEw6l0gLM07x1kSQiIg1V3gkxf
 V
X-Gm-Gg: ASbGncvKmQlEmQmd86hZZlRtD127zR29WlSMEYOd/yxf3ZnA58yEHN2cIZII/Ngvd1q
 2oOZh9EG61gn9OC+cQyW1S2DjXgOKdXThfxDXeR/djaW5chh+DwdNCdLH0AbS0CUjdlniFwvEDc
 BhEAw5g5ZrC/M+Ip+aRe2BkuOOeGUqFxkybbROXabkXD+b0i26x7BiaKHkejLq7MbrwfA35bGuP
 4AcV+w9yJBRdVgWwlM9+4jh8sNadtLQFp6S63H0lc1zcArhgaWjbk+lpBlZZUk6NC1jtVZIjiql
 /xnrAGRbHeZfaMHep2XFQEd6hNj+OdX685aH8wPjnB+qPtvMR+zMwk/xBFasubFJ/82ganLRyoC
 ebubfa5PILiI7Y0wW8zsDdq/nH1Ve
X-Google-Smtp-Source: AGHT+IFrGe9K3YHW1Pdv+zkeTkLU3dHzVuFwGUnLC2shfzvV3bXNLnAoVMIk9VdrUalqwQlG6GvhGQ==
X-Received: by 2002:a05:600c:45ca:b0:43c:f332:703a with SMTP id
 5b1f17b1804b1-43ecfa3726dmr60034215e9.31.1743863156199; 
 Sat, 05 Apr 2025 07:25:56 -0700 (PDT)
Received: from [192.168.69.238] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c301b8ad6sm7195263f8f.56.2025.04.05.07.25.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 05 Apr 2025 07:25:55 -0700 (PDT)
Message-ID: <cbd14121-16f0-42d2-a861-fb737656bc03@linaro.org>
Date: Sat, 5 Apr 2025 16:25:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Question about memory trace with execlog plugin
To: Yannis Bolliger <yannis.bolliger@protonmail.com>,
 "qemu-discuss@nongnu.org" <qemu-discuss@nongnu.org>
References: <CyPTzkaf9gPwB4yBJ2L2v7OEa1ifWfc6Ys8CFowNoUee6ap4yEu3YThfluX0AObgYU4UcWQFHNbfWrw0kZ-wNQF3gER8mhXZg2Vc74SOstw=@protonmail.com>
Content-Language: en-US
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CyPTzkaf9gPwB4yBJ2L2v7OEa1ifWfc6Ys8CFowNoUee6ap4yEu3YThfluX0AObgYU4UcWQFHNbfWrw0kZ-wNQF3gER8mhXZg2Vc74SOstw=@protonmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Cc'ing plugin experts

On 5/4/25 13:25, Yannis Bolliger via wrote:
 > Hi everyone,
> 
> I am using the execlog plugin to generate a trace of memory accesses, in 
> particular I am interested in the physical RAM addresses.
> Now I'd like to identify which of these memory accesses are related to a 
> kernel buffer -> user buffer copy operation.
> To that end I am logging the physical addresses as obtained by 
> page_to_phys (+ the offset of the RAM in the memory map) in the kernel 
> before the copy is done.
> I'd expect to find memory accesses in my trace that go to the buffer 
> addresses I logged in the kernel, but I cannot find any.
> 
> Is it possible to correlate these addresses? What do I need to look out 
> for?
> I may have a wrong understanding of how things work.
> 
> Any help is appreciated,
> Yannis
> 
> Some background info:
> 
>   * qemu-system-aarch64 on an x86_64 host.
>   * android kernel (cuttlefish)
> 


