Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFCCDC369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 22:35:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8RZU-0000rv-MC; Fri, 25 Apr 2025 18:31:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u8RZ9-0000iS-5V
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 18:30:40 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u8RZ7-0005fm-HO
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 18:30:38 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-43cf05f0c3eso18985285e9.0
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 15:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745620236; x=1746225036; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uOkFJbjje6XR2/qFa30CEfQds1HRwhfSJ9CZU17scD8=;
 b=crqdayNiuzgH+XUEl15BSuKAMGDWbT9Sa5VrAQAWScuFDd4LkUzW0/41u5E+XFwNts
 +Aa+aBIN6nffFVlkPj61n7bjbqhU1tqHsJ9vvn/DH095rTqv5lqr+ql8wZhsGPOxQidE
 oGVOxHC4uFSwcKB6uFnIwlKqCDMAGt8JIMYXb5F7Fcgb72z50AwED/cYKAbpMzEIO8L4
 COFYrOb8nJVaNcmQ2pjSD8vsRAxpHlgRkgOJXV4cE+99syYjhqgj5lQl+A15mkStgx63
 mOfjJj0kRh8LySTsLw/JaIMJwC0xkI28kinP7TDgcjKTdTqfmr2rkWjjrMPhFVfl4Efb
 7B9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745620236; x=1746225036;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uOkFJbjje6XR2/qFa30CEfQds1HRwhfSJ9CZU17scD8=;
 b=jgT5KoSHhQsaEP2SnuYfJIlYT+dH9OGQkOIHHJx/hWTCczMtpYcz7g5VoktSvl0HvZ
 0klvDVK930jsc2xdPELEvf2SHTMBC/hg5nTW7PCIih5Th9QyzJPKzifmYmV7pCKC7ly0
 sZtI9+lewPCIh1JApfe2h5rWAV2zPCBiCndB7zh406+5Ymoc0KxR+peZgCFeektdzOrh
 mlrbprp2C766FJuHOiqm3nWwk1md7+RFj3G/hdvqVsWAQxGyZdLa1bgu08b6u9dkBzAS
 TyaIdWMmrMCDx1PuagEUFV8J+HHrPJVouCt1obJGT00lSylefSLgCX7O5dlD3OlGcopr
 t13w==
X-Forwarded-Encrypted: i=1;
 AJvYcCU4Gn5Er2YUANUCEHArAs0nS6chfnn0qq6MulzZ2nJoYa2IYYrIOgGjgm8w0lSM9n6o3/sY8PPHK0I8@nongnu.org
X-Gm-Message-State: AOJu0YyvQ1CSNox6R0DAlfpBtXDHAMxPA4Q+WYNiVitEO/FgJwOgcgT5
 SFxaUzi0RVqd7yA6R1wasgcuLllGMYXJSKOqCk3yU/fXM3xRP6ndKAOsQA7UmM4=
X-Gm-Gg: ASbGncsylbg+TiQuVrSJaQDCsSNej3tYuMlT4EsgomK5EKIpKI7a6e6iWElDsAhy2r4
 mX/MwnrfIb+Xa/213xhU3MwuqwuBKXHCT6DBhmeOCzZAr7lL2Ux2V/mgP65MNQ+vBkJQhIXwPqQ
 M/y+x7Ko47SZZywBzWXvTvaJiE8T6LdE8cB7S0k7xbTWH9yZ6bSOMuB6PZXB/5FB+hheHlWWacX
 KyYHYu6Rh31D1H+6/kbbwhAuGh8tVYbkYDO9HSQ3pqUzig7j+MsILZ8BhrnVJOuKKSIN2YpPu3B
 vYt1axjgUL0XKDkt8O8WtEGdEhVZKDoSb2RWTXfSztDxM/IYC7qoO6YprxD4GBxYWQCIbRK7r+o
 Z4RsJwEyu
X-Google-Smtp-Source: AGHT+IHhcYLFCwxWhPH1PASeSrws5NrvHkzYNRmLCWsdT68nQgKROIxeyzWpI7pAs1SpVVQ9grpqnA==
X-Received: by 2002:a05:6000:144b:b0:390:fb37:1bd with SMTP id
 ffacd0b85a97d-3a074f1571fmr3731376f8f.46.1745620235936; 
 Fri, 25 Apr 2025 15:30:35 -0700 (PDT)
Received: from [192.168.69.169] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073e5c68esm3490073f8f.82.2025.04.25.15.30.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Apr 2025 15:30:34 -0700 (PDT)
Message-ID: <01f025e7-954d-4d66-90a3-80c85b362b7b@linaro.org>
Date: Sat, 26 Apr 2025 00:30:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 000/159] tcg patch queue
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250425215454.886111-1-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250425215454.886111-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

On 25/4/25 23:52, Richard Henderson wrote:

> ----------------------------------------------------------------
> Convert TCG backend code generators to TCGOutOp structures,
> decomposing the monolithic tcg_out_op functions.
> 
> ----------------------------------------------------------------


>   60 files changed, 12156 insertions(+), 9609 deletions(-)

o_O

Hardcore.

