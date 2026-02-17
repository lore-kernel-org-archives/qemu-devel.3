Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27F54E9A03B
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Feb 2026 21:45:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsSsx-0004aF-4C; Tue, 17 Feb 2026 16:45:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vsSst-0004Xv-31
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 16:45:31 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vsSsr-0007kV-Jb
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 16:45:30 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-4359a316d89so4177243f8f.0
 for <qemu-devel@nongnu.org>; Tue, 17 Feb 2026 13:45:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771364728; x=1771969528; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NSVM3xD1cBBmVUc+Dlnu2Q88t358a5kQp90bx+IJv14=;
 b=i1Aqj4i177k6EpLnCbWWLH+zxtLILPYtef2m2JIq+vJChVC5AQndLUpe5bTMFEkgdS
 P/RMtFHOq7hQWY6Kx+OTTPnxucLYwzmYe8YJyUx9uBSIR9O+IEqkTkC3Igfk/VjSLHht
 Ux2lduzPdBf7fjtoq2tUXNdqA/Wjluc8ERuDI7hGpsnSe97qz+/9XtNgM3Sk6Xn/yZ98
 O0r83HS/zchlbkq8+Y8UkHUxsv4xn3ESM8UpgkdmKMoznlxIAGTfvLIuteaykAMP/Adj
 9XOuf9Fuq/apMGLvlDukjmJZJBruJK1exF+TTfkvVvVtu6/Sw6t1xNHwjrWsjCnS5zBF
 E2ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771364728; x=1771969528;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NSVM3xD1cBBmVUc+Dlnu2Q88t358a5kQp90bx+IJv14=;
 b=wwQUn3xtoQcy+PzZFaOpgSUzib3K4nsxv7BLSyYP4hcTutodOpxoum2A2Oe7/XshNu
 CZxCDRVKi2L+Vq3Icld8Gb730mWXhCzPYonJ/bmBXDuMgWtb4e9i/lcYvHK/8O39tiLJ
 Cr8ppcjAUyDPW6Vs15r8GEj+6+AJznQUf+K7LUN/NQFrdl8wZpMCm5wCnxA1Uczhk9NR
 PgJMOOA3f0lYb8jEIhP16615fRmvJ+LDLEPJRT0HISXBeGkYBrM97rU5wmJtneTNHryn
 BP3z+MgTXnGM0UD/dJVzPqAZKwcBmF2MwcQqWXfxb8LqDw4NEzV99OD8vyjnBf2rPMVr
 QGag==
X-Forwarded-Encrypted: i=1;
 AJvYcCVRujYGCb36HGbyXevs9SxZq/Hm28iNgomdDF5OR45mSwURyerf4bOtMEpY8NpTJHH/kfjs/XjTwGMP@nongnu.org
X-Gm-Message-State: AOJu0Yx/f4qXu4X4Rocx26uFZuUfNkuBBwHbwr2+HQnhPWI8vq8a70HO
 M24KN0Jn7699gA+Wew0V2UHwkhYj+CPby83uOZ4MeAR1DmNFe/qG0zQDDAvLs8/GCEQCqCfqoqp
 vTewdJn4=
X-Gm-Gg: AZuq6aIe81XKM/8ldw0R8qJSmaG13h7VXqz9qp5wGK/B7v7GiDwvA5wJjyKNESQAlzW
 EsiIOYpFTLgi43BnoR0xuO20nh3EntJgqD9mR0KJL9F8l/IqE1nsXp0178Ckfonyq2yyoaX9P6y
 t79Px5mi6vnoUI+jez9JxROTNCEd/3U2yDurziW0PiBGHSjE4LEqg/ntmHubbAnFH3C5DJJ0HzL
 k+zjANMp68XyrpRAYTBkicND6YWj8VNL2grZispA11NqJfqo+P+vWNDEUdxpkL/RT4A7TNKanl7
 64ntOLReopbPU0eTpmihz/lGDe/OhyPLw5B5o710adLuEwtWibVWBX9225h1h+e418YkFyb51UV
 ti6OnqjwXskTwyuN4RXgj/SnD9NhV5xyw8Nk/fjAeLtvo3eToLM6uhGEmQVCqwijhxtyqgY/rLU
 KsEFOYlfSvDDD5pPU7UMsT5Cr9MCjZwduMnWBOxnrtXA3vJt2RgdQwluytWJH0Oag+rg==
X-Received: by 2002:a05:6000:1849:b0:430:fcda:452d with SMTP id
 ffacd0b85a97d-437978e1ba9mr26850416f8f.22.1771364727577; 
 Tue, 17 Feb 2026 13:45:27 -0800 (PST)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43796a6c1b4sm35071071f8f.14.2026.02.17.13.45.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Feb 2026 13:45:26 -0800 (PST)
Message-ID: <9ba1c517-6ef9-4ebf-ba8a-d191a6b7331c@linaro.org>
Date: Tue, 17 Feb 2026 22:45:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/7] target-info: Move TARGET_PAGE_BITS sanity check
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20260217095106.598486-1-richard.henderson@linaro.org>
 <20260217095106.598486-4-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260217095106.598486-4-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

On 17/2/26 10:51, Richard Henderson wrote:
> Move the check from page-vary-target.c to target-info-stub.c,
> in the process of removing page-vary-target.c entirely.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   page-vary-target.c | 4 ----
>   target-info-stub.c | 6 ++++++
>   2 files changed, 6 insertions(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

