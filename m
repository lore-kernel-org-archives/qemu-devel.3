Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39EEED3B992
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Dec 2025 19:56:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vT3oP-0007bv-GR; Tue, 09 Dec 2025 14:55:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vT3oM-0007bW-8m
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 14:55:51 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vT3oK-0007w0-Ra
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 14:55:50 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4779cb0a33fso80163015e9.0
 for <qemu-devel@nongnu.org>; Tue, 09 Dec 2025 11:55:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765310147; x=1765914947; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oUGnjAUJ/WV/a+xeQ14MUp20pR8u8DiKhHojg63JL38=;
 b=fT0Ydsrkuth819C6ePnYbEMmuf6eSSYGuKN2LVwOZOSj5XP4jhvByZBeyUANuSukuG
 s36j7CVJBdS/1UCUWBJyJb6zqTekyMZ0QAskwFgDwSXG/Dc8UhYK2F8AO7XuvnE/W9HQ
 mBcRIJlc+vY/DwM2c1MA4bRqNqEXbO7FVDgyUWs/C/ft1hf6Kfa6wD4z7C/70LYJiOqJ
 +kiwmunop5JgWT+oa/f7OKxHMFsB62VBgFdCN2uaOORATJ7NZgnHoOuflqH9fHcnkc/D
 E6orBOeQsqDBNYVTQSsylhe2JWo4dWPBr+vr6q1QjmD6Ni7BUndy7Lg6DBFkuEPZdMLK
 ZCiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765310147; x=1765914947;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oUGnjAUJ/WV/a+xeQ14MUp20pR8u8DiKhHojg63JL38=;
 b=nA1Wa5nP0Nd0/DUdhMy5Nx7Cjz+zuBXOuHfRJ8gMyo4nfp3dfXV8iX6IhrW199Vtn3
 rFX4kgTSDUzQ6EVUgrsVwcVbFTEe85TquTpAExlu0G+oV2ZKpltfalPoia1ew9xVbTYT
 0Odrv2ceTJ04t5VXi+2YWZMyYojbPhRHRL5RK66IRoaGPf3ZabULz850c6PfN5677s5l
 2g+PmmSBDAIlmY04OAWjgk7J/fJsLzAMgkKH3fDGROBhHUMsglR8P+UP5DZgCm/49n95
 LPpJqqXr1tMjT+h1D6ZYaYLiJSolBjVdGcBtO0iWHPDbNkZae0OXcyO+xHH9z6Jz3tqa
 8avg==
X-Gm-Message-State: AOJu0Yyipebl6hL6pNhmUNHNZeUdz8/rCqEmFsGEk+dEpEDjkWmqa/H/
 AmA4kLHWA0uzgtFHtxjDyVlVrXeHE0u5uEB0bpdraEzEGZubKV51XRf4QnXPsvdpLjc=
X-Gm-Gg: ASbGncuyJH1nPPbE6UO98DgSSK8kUU3/ef4kj0nt/NDAY6enFbJqhH+9z6sgRQKPpZ+
 zMfsRl0EJ++uzR9L3DpiIljzf5uPRjnhygMAlSq2wbfDVE0W9oZ4bi4Ma85dewqmtCr/HHsYXpz
 WuTFMzU80VgDlwYOUB0DM4vYXCd0DMCKkcy8w/dmYx9UzmlhpxngAwAMLPklJ6oJ4p40zTJWmNV
 lQYwVPojI4XvqzP+sq3zJHMRkTzQQRDqcaOA9RDOgLCtXQt2usB6RCCssePuBS02y8V7/3GUYc4
 eMopXm4K6f2TEVQi0QCvlbZM+onhkyQLaiLQUxEWq0PuDz2pENw9odvJuBPZhkMG/UrHLu2KgDB
 EcgZ0bYU20Jb+XsCaINOcDp7zflKGijrJXNjsyZQs6K5f5XScW5l+lJOE7Les5uPCpyGs5Slpxm
 E98jp5nkWQoeWBfzTuBNCB9Q17usv67vlDIFEMQEPKOjoOQrldZmaE+A==
X-Google-Smtp-Source: AGHT+IEHYZv5vsS+JRYPTmBGYIcZInTf3285aVr4SUTxawpHjzyebWn5xCwVd9nlfnZFYIALQpkVow==
X-Received: by 2002:a05:600c:5286:b0:477:5af7:6fa with SMTP id
 5b1f17b1804b1-47a838586abmr133995e9.32.1765310147021; 
 Tue, 09 Dec 2025 11:55:47 -0800 (PST)
Received: from [192.168.69.213] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42f7d222491sm34837348f8f.22.2025.12.09.11.55.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Dec 2025 11:55:46 -0800 (PST)
Message-ID: <8b809984-c3e8-4bc8-84ca-92b3d674db92@linaro.org>
Date: Tue, 9 Dec 2025 20:55:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] migration: Fix order of function arguments
Content-Language: en-US
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Stefan Weil <sw@weilnetz.de>, Laurent Vivier <laurent@vivier.eu>
References: <20251209195010.83219-1-philmd@linaro.org>
 <aTh-TUbyMRCfkbS5@x1.local>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <aTh-TUbyMRCfkbS5@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

On 9/12/25 20:53, Peter Xu wrote:
> On Tue, Dec 09, 2025 at 08:50:10PM +0100, Philippe Mathieu-Daudé wrote:
>> From: Stefan Weil <sw@weilnetz.de>
>>
>> This fixes a compiler error when higher warning levels are enabled:
>>
>> ../migration/postcopy-ram.c: In function ‘postcopy_temp_pages_setup’:
>> ../migration/postcopy-ram.c:1483:50: error: ‘g_malloc0_n’ sizes specified with ‘sizeof’ in the earlier argument and not in the later argument [-Werror=calloc-transposed-args]
>>   1483 |     mis->postcopy_tmp_pages = g_malloc0_n(sizeof(PostcopyTmpPage), channels);
>>        |                                                  ^~~~~~~~~~~~~~~
>> ../migration/postcopy-ram.c:1483:50: note: earlier argument should specify number of elements, later size of each element
>>
>> Avoid also a related int/unsigned mismatch by fixing the type of
>> two local variables.
>>
>> Signed-off-by: Stefan Weil <sw@weilnetz.de>
>> Reviewed-by: Laurent Vivier <laurent@vivier.eu>
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> [PMD: Replace g_malloc0_n() by g_new0()]
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
> Acked-by: Peter Xu <peterx@redhat.com>

Queued, thanks :)


