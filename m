Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56070CF8868
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Oct 2024 01:40:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swtle-00070u-6Y; Fri, 04 Oct 2024 21:39:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1swtlO-0006zE-IY
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 21:39:19 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1swtlL-0007dY-BY
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 21:39:18 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-2e082f2a427so2063274a91.3
 for <qemu-devel@nongnu.org>; Fri, 04 Oct 2024 18:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728092347; x=1728697147; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rohLClojdk8wkdcu6fQZFqY88qAJfLBOIF9elHTCyFE=;
 b=xqrg7Va2LfHabOh1DkDal76sJ/4sggd6G+ryHRDqsv4yKRRTbHX+h3YHrqcx55kUeA
 ckftM6sHFCCU4j0iNcbJL0ZALlenlaXHy6k4Y7pKxt1pzLfANrIfjY/lQSJ0gX8E+T5a
 UAO+hyy9Vc1g06rju9yf8b2qG9gv4g4UfvLjIuuNpoinJ4cuoYJavClvhTchuv3uZrHb
 CtNbowTKk8KqRQtzrStlm+yxw47ut3tCuqqoIhGcY4neNK7ZApdpTpWFtHwZaoNak4sZ
 w7TqPLn5LMIPZ9pLdACAeloxEQ9Ab74iRUk7IQEgLIvGw70v3NZ0kHmd64bjlpkgiWuT
 7CQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728092347; x=1728697147;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rohLClojdk8wkdcu6fQZFqY88qAJfLBOIF9elHTCyFE=;
 b=Ufh2GwVy+Psfs4//++sIl/beauIEYEyJfPuSWcTtcGVohU7TEs3cu68MTMrkxB0rbz
 zafvLY+EbfNjD7qW+RxnPEvPuT27STRLzvVIXa5XekBHyLwWbt5nBHB2ke+vl4SyqrCB
 kobs6bX/FZC3CgeDXCdCp1+g9cjMFtnSyKKiZVKyr6eI/vD6AdrY1QNArVXSZQS3Ch3r
 FDiSeJk2vlKdY3OChSGMEkEytdYIeDAQu+yYseUQZsrYAwEz/+1gVgFGAkVfUuPtMBpo
 O9Ej9KCCRIB1XrLCmm04MQNP/KGYJ4vg7pzHkbtSgaOovVfK9pzZ1Bri0yFoYnnF9rWP
 gdSg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUkNLcsMVLvVcQFf3gva9sbwy/JyvcK3A6LTLHyyg6NPjRIM1k9H1pVjfxibc1feF0/8pmKsBWIaQdD@nongnu.org
X-Gm-Message-State: AOJu0YxIdbLYE3eFprhZ89qqXIsBdh7EM9b2RJZBMpIUkJTreT/k64db
 omGRIgrzr7qpuaLPIB8P6RTg06EJkwOfwlaHhn0hpwD7vHcZNRqw/eQi3OniRE8=
X-Google-Smtp-Source: AGHT+IHpdJE+Ia9NF9NA/ecEHCT8ni3gOSTEurybXV/XFtH5AADLv4cnHXKH7yDsYu7E1LqPEH6iSQ==
X-Received: by 2002:a17:90b:1a85:b0:2d8:8ead:f013 with SMTP id
 98e67ed59e1d1-2e1e621355dmr5493811a91.7.1728092347468; 
 Fri, 04 Oct 2024 18:39:07 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20c1398ee06sm4517555ad.288.2024.10.04.18.39.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Oct 2024 18:39:07 -0700 (PDT)
Message-ID: <5a1606e1-649f-4bda-83e9-aff8c9dfd9f4@linaro.org>
Date: Fri, 4 Oct 2024 18:39:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/25] misc: Use explicit endian LD/ST API
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-s390x@nongnu.org,
 Thomas Huth <thuth@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-ppc@nongnu.org,
 Alistair Francis <Alistair.Francis@wdc.com>
References: <20241004163042.85922-1-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241004163042.85922-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1035.google.com
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

On 10/4/24 09:30, Philippe Mathieu-Daudé wrote:
> Philippe Mathieu-Daudé (25):
>    gdbstub/helpers: Have ldtul_p() definition use ldn_p()
>    target/hexagon: Replace ldtul_p() -> ldl_p()
>    target/alpha: Replace ldtul_p() -> ldq_p()
>    target/s390x: Replace ldtul_p() -> ldq_p()
>    gdbstub/helpers: Introduce ldtul_$endian_p() helpers
>    target/alpha: Use explicit little-endian LD/ST API
>    target/hexagon: Use explicit little-endian LD/ST API
>    hw/i386: Use explicit little-endian LD/ST API
>    target/i386: Use explicit little-endian LD/ST API
>    target/avr: Use explicit little-endian LD/ST API
>    linux-user/i386: Use explicit little-endian LD/ST API
>    target/loongarch: Use explicit little-endian LD/ST API
>    target/sh4: Use explicit little-endian LD/ST API
>    target/tricore: Use explicit little-endian LD/ST API
>    target/rx: Use explicit little-endian LD/ST API
>    target/riscv: Use explicit little-endian LD/ST API
>    hw/m68k: Use explicit big-endian LD/ST API
>    target/m68k: Use explicit big-endian LD/ST API
>    hw/sparc: Use explicit big-endian LD/ST API
>    target/sparc: Use explicit big-endian LD/ST API
>    target/hppa: Use explicit big-endian LD/ST API
>    hw/s390x: Use explicit big-endian LD/ST API
>    target/s390x: Use explicit big-endian LD/ST API
>    target/openrisc: Use explicit big-endian LD/ST API
>    hw/ppc/e500: Use explicit big-endian LD/ST API

The sh4, rx, and riscv targets *can* support multiple endianness.

While we removed sh4eb for system mode, we still support sh4eb-linux-user, and therefore 
the target/sh4 patch affecting gdbstub is wrong.

RX sets endianness via a pin sampled at reset; if we ever implement this, it would be via 
a property on the cpu.  RISCV sets endianness via a couple of bits in MSTATUS; system mode 
would always use little-endian, but riscv64eb-user isn't out of the question.

While we have never supported rx or riscv in big-endian, but there's no reason that we 
can't, and those target/ patches make things harder. Since target/ will *always* have 
TARGET_BIG_ENDIAN available, I don't see that we're saving anything there.


r~

