Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 035DFCCD184
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Oct 2025 16:47:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAWZ8-0000t0-Pc; Sun, 19 Oct 2025 12:47:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vAWZ7-0000sX-9U
 for qemu-devel@nongnu.org; Sun, 19 Oct 2025 12:47:29 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vAWZ5-000548-NW
 for qemu-devel@nongnu.org; Sun, 19 Oct 2025 12:47:29 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-4283be7df63so667803f8f.1
 for <qemu-devel@nongnu.org>; Sun, 19 Oct 2025 09:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760892446; x=1761497246; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1UZJHhcHmf8i0TDy9eoofpqvfOwudqitX7puce+GQaA=;
 b=XN+jSGp/6kD9qNQylrl5qREXg7V+q48fncJVou2GvCFJNX9Atj5kBBUFfX/cDUkpaa
 W+PL4/f04C4ammjGpxNzi12S5NnsPbF0nD1KHoxjPjJNjN9XqabRAzaApYs2LJ4X2cWe
 jiRhGapW3c6+1mbWQHrG+liAdbAnK1tSDZNXuYB5AiqQhbiRnEv0DZb9AQqvwUXpwYxE
 6uJsSzljLrwWKmDbRHzUKu4qwTIwU7KnOn+IIKTTymwUEwEPUmRmhKn/nhjzS1+zpK1A
 jGC66dwolZN1/5Nri29CSi3b8YW3vtw9eyXAOMel7YoTtUy0pmxbPlDOANIQKB2Ji61S
 /hGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760892446; x=1761497246;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1UZJHhcHmf8i0TDy9eoofpqvfOwudqitX7puce+GQaA=;
 b=u+tIWHEtUtaWzGkC+q40t+dvcmvM6v460ORg0OvtvGbTm2CR8Sq6o0YEZQ8v1waWt4
 nOP5nwoBTSAdGOrEKBym176SN+CxECUzYEUKo8ha7XPUoZtBqlBLk/BrdjMbvzZELCpn
 y906P0VWSM87crhieA+DbFDYqlMnrX1h1gLdvEjIugYY9OUqTWQF+lwLBdk+RqK4Js4k
 z8d9KUXI8Ot+3GhGcIaoNohZ7LntWlTqgjA9cmjp3b5OmWljK32kn4hcW9sV4k4h1o4g
 nEz+69QZhnKoQPMSLeYsczPIV9MOe4LSSRA5fng+QixtyopVJ2ZN2xPdEQQuH+PhqCw5
 Y2Qw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVAxG5MHiCuxF9SDimXTKAHXVQq1+yAUwu1qNx0/Xgtk0XTtD6YJYC9s2yUj3TSXqypFrFvtQd5JJcl@nongnu.org
X-Gm-Message-State: AOJu0YzSLv6VKNcUS3Oq9SyCop5WQtzOcd+3Bdk3/i54JpI1euL0c4v8
 mtcpj0Mbr5f7695o34hJ/3apusoJ/e+Rf4Wpm9EL1inpHpQp3xQcVxiCRwLYdSt5XNFdc4og+7B
 oRKFXboc=
X-Gm-Gg: ASbGncuIW5BGkxkuUrb5rQ2345APi73wIUPSH2GJAGVLsG8OWP/D/tXMjGuMHler8SS
 H5SamvCT0PebQgbX2B9jho+JN9Cr7g85IHZnFIUZOPEfksDu0jqdhFJMlnEpf+mNwJrghP3F/Fi
 Uuz8qdJSqiatrREH1zXVm+H7IhPXMhYblAFIJmIb6jyF9hWzzUdLCGYsWTgesiBITvaRkgn4v3p
 eptgVBruJdKbbyKOlqpksGQGNWkA8lDJ33eGWUTb8tKUSZiV7N6Q8lqBxlJ70VBg+WZ4fSFPdOq
 1+seEfvYwvpz2hfCCNn7pY8q8/5/7LRtQOfEEe2zYwSHUhejPCcf4jO1FGf95J2DMf5r1dAv5tP
 nLw4DjOmyfvLCPG0LUTM9rn/SgH6V6BhSzOGL9s2faGUVXtXXNDSM0MG9KcO3qz344Ut7t/cE36
 JlJEyyOGJ2TZVBiudAl+vWfSKDImjG287w1CZcb5sG7iE=
X-Google-Smtp-Source: AGHT+IFyB91R2fbTZWYgyMGPgyBVYAgxYvcn7QT2lzIDOyZ653E/MCXG9g2TfIaeGa5F2H/5+XzMfg==
X-Received: by 2002:a05:6000:4285:b0:425:7329:e1d2 with SMTP id
 ffacd0b85a97d-42704d75170mr7228996f8f.16.1760892445888; 
 Sun, 19 Oct 2025 09:47:25 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-427f00ce08asm10950863f8f.44.2025.10.19.09.47.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 19 Oct 2025 09:47:25 -0700 (PDT)
Message-ID: <08d12d1e-aba6-4829-a74c-c59fa9846261@linaro.org>
Date: Sun, 19 Oct 2025 18:47:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Claim the Arm XML in gdb-xml
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20251017154244.971608-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251017154244.971608-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

On 17/10/25 17:42, Peter Maydell wrote:
> Add F: entries to the Arm CPU section to claim the Arm related
> XML files in gdb-xml.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> I happened to notice while doing the SME2 gdbstub handling
> that we didn't have an entry in MAINTAINERS making the
> Arm gdb xml files fall under the right section.
> 
>   MAINTAINERS | 2 ++
>   1 file changed, 2 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


