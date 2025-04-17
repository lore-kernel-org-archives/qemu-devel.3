Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6364DC369BD
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Apr 2025 00:19:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5Cy7-0004A8-FS; Wed, 16 Apr 2025 20:19:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u5Cy6-00049t-19
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 20:19:02 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u5Cy4-0000ZC-CC
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 20:19:01 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-22409077c06so3396875ad.1
 for <qemu-devel@nongnu.org>; Wed, 16 Apr 2025 17:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744849138; x=1745453938; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YfebzoBpfubmfxOdBpKtLXB34njMOCjZmuaSAhr4wfk=;
 b=Evg7jmh+q6Z8EAyiqqgk995+WfDHbW/reQ6DFSB8QOuc+ZsRmZFVJJyCMeWC5OdyR9
 SZkoJD36vI/z5/m2lK0tNUyGtNhIVutUK3OL7eDk6gf3/6qU/4aHtLZsqjGUe6tD3IuV
 496mizrkM8w19HzJA0GNBp1Qckmg5Fl9eNf7cPNSXl55uZ8xVucrutqgdGSzhNCo10oW
 FbQRowyD4SAK7bPied5/4t5ZX8Q8BGHI+dYKYZBHZsyrAb4ts1gjgX30OHvy6HsBhnpZ
 hL9ELsVQttvBAiFCjOexSJVQZFA5Df8gmxZV/R2WnHUOg6nWG/WB5rWC1aF18nAJkUVF
 I1kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744849138; x=1745453938;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YfebzoBpfubmfxOdBpKtLXB34njMOCjZmuaSAhr4wfk=;
 b=b4FyN6qhW4vB0ZNeZS3JBuE4MVZG5ZVoprwR/jjZsXI3YlNIeHReU8HuXc/475jKvQ
 0smN8+uvgRgm55om5ExbCpG6wUNAVCuepaNEAMVFBGM9LecnrP/DWcNMR6MD0rPQRSM9
 EPLhv7ob8/0VAqaXqPUsXtIg2XpfWpAW+W0OMUkJlBr6uZ2O/mkBO/gmtm8TRHwLJ7in
 8VQEcb+Qbh+4IZx2R/uPP8o0E4kRWEue0nSyNeGoJRWMiYYuyvKP156vz/QYonKCSscM
 0LasnbwmsMNRnZqL+/mcqgZ/PF/kadh30cHV7TN1x+17cn7nKYJ4CJstcWeeUX4Ldyk1
 fDbw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU2Jm2v4Nnp2Pfks0Jb0Wer7iDVfnpMBjX1UoFioElDTKsCnXxtlj0LWYZcHTCPH/ZIFRb7GFeqeMAP@nongnu.org
X-Gm-Message-State: AOJu0YxCEWVMsv3s6dJe3Q3TYIMZCQvhxrxQVoV8oQqrgcQuCfEHANT5
 Mu+L+VqeL7KycGpm2kK03MZAXdf4IiqGPgZheqnnhzO5188wXmZwbIguPYVsOImNW9UgHIeDd7f
 g
X-Gm-Gg: ASbGnct7RFcPAY/DreC4oP15dZwOjLpq0ELYLm3ZcWJPWrO6dm8PMP/zeLumBNrpmot
 eUF00bZ6d7QwTyE95sDvxpyikI4XquhNThdFNnyysMvTtGg6k7IbmkPnXIZ6eEusCzLudmnEjV2
 8M09T9ftlYahIHc+Vole1Yi7ayfBil2x/IH1WWWKj797YUw68xszbB9wkydzy3lz1lR+bE9x0PO
 VIr9oY30p+3OcF/JgJvUHQ+t/PVWI4JIREpNvRq9Ci1Q7mn2K2dN+R82QyxiiLFcnFPByTAjfE8
 qf/ZMn7fYMt+D+SWfUXgTKbzXAXqRD6hvMdf7eNv26uDt2ppuEt78KVBvTJ8PmYsm/8BhvW8R5O
 b7I60wRo=
X-Google-Smtp-Source: AGHT+IEdlhFV9PJUkhXGK6YnnwxRkOG9gsH0tT60FuVTfpdynd5xskdGUt0y0vv+rD8POl9GzqYbww==
X-Received: by 2002:a17:902:e54a:b0:224:179a:3b8f with SMTP id
 d9443c01a7336-22c359182bamr58405455ad.23.1744849137786; 
 Wed, 16 Apr 2025 17:18:57 -0700 (PDT)
Received: from [192.168.0.4] (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c33fa5c8asm20663125ad.155.2025.04.16.17.18.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Apr 2025 17:18:57 -0700 (PDT)
Message-ID: <baa52414-03a5-4c86-9719-d6d5419cd798@linaro.org>
Date: Wed, 16 Apr 2025 17:18:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 000/163] tcg: Convert to TCGOutOp structures
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20250415192515.232910-1-richard.henderson@linaro.org>
 <a093de11-8901-4e1b-83eb-fd3b6a557249@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <a093de11-8901-4e1b-83eb-fd3b6a557249@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

On 4/16/25 16:38, Pierrick Bouvier wrote:
> The only concern I have is that we could create silent "performance" related bugs, where a 
> specific feature is deactivated because of a bad combination, but it's inherent to this 
> approach and not a blocker.

I think I know what you mean, and the way I see things it that the silent performance bug 
was previously scattered across different sections of the code, whereas now it is on the 
same page.  But underneath there is no real change.

Unless you mean something different?

> As a more general question, how do you approach testing for a series like this one? I see 
> two different challenges, as it touches the IR itself, and the various backends.
> - For the IR, I don't know how extensive our complete test suite is (regarding coverage of 
> all existing TCG ops), but I guess there are some holes there. It would be interesting to 
> generate coverage data once we can get a single binary in the future.

I don't use anything more than our testsuite.
Coverage data would indeed be interesting; I've not attempted that.

> - For the various backends:
>    * Are you able to compile QEMU on all concerned hosts and run testing there?

I have aarch64, arm, s390x via *.ci.qemu.org;
loongarch64, riscv64, ppc64le via the gcc compile farm.

>    * Or do you cross compile and run binaries emulated?

This is my only option for mipsel, mips64el.

I do not even have a cross-compile solution for ppc32, as there is no longer any distro 
support. I have been ignoring that, waiting to remove it when all 32-bit hosts get kicked.


r~

