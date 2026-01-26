Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ED99D19510
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 18:44:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkRZR-0005K6-I9; Mon, 26 Jan 2026 13:44:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vkRZ7-0005Ap-5D
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 13:44:00 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vkRYp-0003Jn-5A
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 13:43:41 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-47fedb7c68dso49109785e9.2
 for <qemu-devel@nongnu.org>; Mon, 26 Jan 2026 10:43:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769453017; x=1770057817; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OPEoA9Tj22A931jzg8EH3482TjmbL3AN2M6LO80FBA4=;
 b=jYaqXKoOEQywQIMtv1y4qDXjSIHM6LEvo2pzRBhnXNjCMTChdWyCKIG4Bty2jqNBhv
 8k+JYUNi1V4HqTdw77C0cxJY4Ubga/ktveqDm50fPHod4lrjzlmsNuMDWxqyRAifLMWf
 6g7A7UU/X6pl/ReWSNTyuFQ6JGcA1B78RXsKNKF4R+iX8CbnfiBAwF3DxBzPokSZfNE9
 0/w65pvVxfyPH/IcIXNA4TsYaTvcM9p0oSBi5mjlruRDytaX9Eypnz57OkseFT89C9oY
 pLdlq4QexhKDWXorbVTCok6bjKXAvKwd3IACs7jyWKgRStwl7CgxQbm4rQny8HTf2aaD
 NPqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769453017; x=1770057817;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OPEoA9Tj22A931jzg8EH3482TjmbL3AN2M6LO80FBA4=;
 b=DwXCnP2UHPYMaUg+yQBowLJsnPWAGbwGBO8GAj/vt+rmvWAu3Rk/rHFxKaG+xasRUX
 XJZcOvNsXz/nuYHLM2uH2I8mHeNqSZDV4IEHdYqThFyRFi+9edMxtXwDZ64umACo/uEI
 hHlMBnQmhoqyZMAYoZv8tK78TVxUOXwEPFOMTT8Jr73lioTDUUGiFqO/C0iSXpRcIcni
 VYrZyOREcXJT7qU3UJmJwQGSV6NFkIf7JVoa/GW8+cCZK42A4O1yK03NgTIU4ovvEP+c
 fOmZZ6Th8qB/PmVsBthgWhUcOC11VInY7XWcO2Oyl02Ql3vCSwkmaX3Sr8afzpXXu7a2
 lD7g==
X-Forwarded-Encrypted: i=1;
 AJvYcCX1tXM1N+pG7vOmSKygc2f34LUVEQuyJVv0PUrIUZ9DO0ztdUX3dmgtF/hsOuKyHa47ScCXhc09dsgo@nongnu.org
X-Gm-Message-State: AOJu0YwZTV+yshlHyt7pWo8WwLcDgYEO13BiSZsfhD1Jc/789JDGiqcI
 nOw4QiwSJQgq0Qescb83vDZDU86dKrSmq8dbr+R9cJGxXJxgdQaru03potQNh87/ecY=
X-Gm-Gg: AZuq6aJXIPVxqPq4YSwixhXwTl26vB1Bb9zXEXeNjszKSNfWT+aS4GC8HosCf6BxU9L
 OPIOC2m+rZtfMCIENbIwI/a3z9G6zVGAh29HZ52HMbuO4gVcWTgx+TDq7VWF/LFuXskiPGOnCz2
 yU8QFPsvLVySxUh8SnBUZv+js+DHbfQHfStIOzl0ogZHKdQHbjsI6SvsRUXaXHZHVgtslNCEOhx
 jxMLsQ+GOYRGRs+2Dm3JczfM2iKCQHFErtVAmM8E1SCEAFyhLCqrT1uhWHbSRbdmBbg5XlghdUZ
 t714DUa5mDP7lJhuZLPCXBOz1EspXsK5lEATRNGS/pqvq13ReintOG5CCWzsAokaF1dknNwoFMp
 GBSokp1oHeZvrdtyQFf+/opzPp8RO9HdR2doy1nu4AE7E0kvmHTvh26ZglV8SAoX/JYwDo/LLbW
 sM0Amraf1bEPuzqP2wGmhJgzzvwe6a/plV9WgB3Aw3qqA1ikCLaRx7Bg==
X-Received: by 2002:a05:600c:3b0d:b0:480:3a71:92b2 with SMTP id
 5b1f17b1804b1-4805cf66b1fmr73106145e9.26.1769453016640; 
 Mon, 26 Jan 2026 10:43:36 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48066bf93cesm6414845e9.9.2026.01.26.10.43.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Jan 2026 10:43:36 -0800 (PST)
Message-ID: <255672cd-92f3-47e1-b6e1-263bc094427c@linaro.org>
Date: Mon, 26 Jan 2026 19:43:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 07/16] MAINTAINERS: add reviewer for linux-user
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Joe Perches <joe@perches.com>, John Snow <jsnow@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20260123145750.1200879-1-alex.bennee@linaro.org>
 <20260123145750.1200879-8-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260123145750.1200879-8-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

On 23/1/26 15:57, Alex Bennée wrote:
> From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> 
> I had interest in this area for some time, and would like to help
> reviewing it.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Acked-by: Laurent Vivier <laurent@vivier.eu>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Message-ID: <20260115201712.2706663-1-pierrick.bouvier@linaro.org>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   MAINTAINERS | 1 +
>   1 file changed, 1 insertion(+)

Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>


