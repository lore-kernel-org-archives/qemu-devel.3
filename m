Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04DF9C5DF8F
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 23:33:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxCF6-00027C-9z; Thu, 20 Aug 2026 19:32:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wxCF4-00026w-Hz
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 19:32:14 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wxCF3-0001hF-0i
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 19:32:14 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-cbedf6a6fe8so322750a12.3
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 16:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787268731; x=1787873531; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=kYt82G8cEeyX8CUQcRRMEnvpMwo/kIV7i+eXjCVKu6c=;
 b=P8n378HJPwMd7XCAqDQfv0Bo6P8EuMqQoLKWWEo5gvXw1vC8wEJ/X3ad+cTVTfblXK
 fcaAnRfiMIQmavTn9j/agHLYAeNKLvvQhriv1+qwlR5JFhDyxOR5QRt0A2pKFEV3z6wL
 PgC8lm80OGxn0xEzEJGj5E93RW0nB7cmQRyP7Iz7rXAfqdMzmLIOuOEblrNXPfJNgWVf
 dcWO512dC/uByT7zIYlJvN0Knh7u6nweXS25qUl5jQ5+LVn3jYdmm1iwHC5mMvZ1xiLX
 ten62vobH5voh8mSBp3Qz5ZSL9OWkU+A02QkE19LrvZQpmFiSjhYvejuC6UWLH/Au+ce
 FdhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787268731; x=1787873531;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kYt82G8cEeyX8CUQcRRMEnvpMwo/kIV7i+eXjCVKu6c=;
 b=XJeiSeWv7Rfrh7K3IdXC/Rh0l4fX/MkjqaoT06RarvflXkPxStI8+Is2UgvqLWtEaW
 x4QJB9xejYiP3rZW9jNUEW3YXPZjZQhJoAoN8rYw6D5gQkT4UBgwTuvV6dQ0FyF3hgym
 luqXNNWpvkje6DfaM7jW4dL9G+sSUpceikRSougrKqbYFKCJSrZNrUF8tgVyvpTnFLfd
 ixaiJarmJn0WPC1Cy2vmhcm4iYSxMEApW1j2PyAJk8FPJmF5RoTuZsqjggjutwL7GJj2
 OP6IZlXB6Yvmbos1TIAzULmKwC9YVy6HSRZpIC89zVInhqEQ/05yO/G4KlM6l+SKCdyH
 tRwA==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro7GUXcktTZ87B76GFs3kiL5gLrPYQKEQ3GITs55NBnL7qRmTRuKFDE/zIMtG7D1qGduMcBpZmUElzK@nongnu.org
X-Gm-Message-State: AOJu0YxEBQmGf2OJXav2IDPuffPNP8KwWNH7z7rBMtUM8rO+V0mTiv1b
 MlFnOD6b2rKGfMcHf4RYAhj+nZqOOpf2d5bvo8Sab6PA3xsskIWk+s3FTvTkfgNDFezkouk6mbg
 cSUGp
X-Gm-Gg: AR+sD10lB+LC6oVmALrjAEtCORZV7SAsHWtHPzobSc0AayBbuNUR9GYsddsw97OzyVO
 xnTEvjkEmgqYYLVlyM9SA/KhgnAGx10rI9hQDSlD7xVq6ZLUMlel/YHyb+QJohNb70AZ7rBlH4K
 2MVEkgjLB1cPtVha0badesCZWCXQ43ho2xN6pDFNF6ogo0nME7l1+Sk+hSJ5Iz72StHkBk4jg4R
 Vr8GIpNla2sd77IYrijqXjIcUh4iFg+fZMeza67vNPIMilxFeHGuQ+mv1I0kYvIsNbwnMgg5VDR
 6Zsy3+IldgDVxI5co5JjLbFoIj/kMT2/7FYgW/Z0PWXOf4Tj+mSUYPuN5w4crLj1K9si4EYY0us
 j4esv+HQO6i+LkKWymg/bdIVNM+pNM9fANtba5GppQYsXJczviJ44gPOaZKSaAxssGhIIXZt1ZE
 LDb4zxpUNfiN8uckaTUn2R5MDKSnMT9YYLjPb4SDeuNO7INHDLM6uRqlizCRjyEuip+3+aH85KQ
 Ux7
X-Received: by 2002:a05:6a20:a121:b0:3b2:a809:1000 with SMTP id
 adf61e73a8af0-3cd30586d26mr3175916637.3.1787268730840; 
 Thu, 20 Aug 2026 16:32:10 -0700 (PDT)
Received: from [172.20.6.151] ([108.174.179.84])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc15cada6fesm1880859a12.27.2026.08.20.16.32.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Aug 2026 16:32:10 -0700 (PDT)
Message-ID: <d9971d3e-0faa-4517-b748-9737822c5c66@linaro.org>
Date: Thu, 20 Aug 2026 16:32:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] tests/tcg/riscv64: Add vector load and store tests
To: Joel Stanley <joel@jms.id.au>, Alistair Francis <alistair.francis@wdc.com>
Cc: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
References: <20260820130223.2762-1-joel@jms.id.au>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260820130223.2762-1-joel@jms.id.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52e.google.com
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

On 8/20/26 06:02, Joel Stanley wrote:
> Hi Richard, I was testing your riscv vector load/store series and
> noticed there were some regressions with page crossing loads and stores.
> We don't have any tests for that in the tree, so I wrote some.
> 
> The tests trigger assertions in linux-user for me:
> 
>    $ make -C build/tests/tcg/riscv64-linux-user run-test-rvv-ldst
>    make: Entering directory 'build/tests/tcg/riscv64-linux-user'
>      TEST    test-rvv-ldst on riscv64
>    **
>    ERROR:../accel/tcg/user-exec.c:810:probe_access: assertion failed: (-(addr | TARGET_PAGE_MASK) >= size)
>    timeout: the monitored command dumped core
>    Aborted
>    make: *** [Makefile:223: run-test-rvv-ldst] Error 134
>    make: Leaving directory 'build/tests/tcg/riscv64-linux-user'

Bah.  Off by one bug.  I'll post v2 shortly.
Thanks again.


r~

