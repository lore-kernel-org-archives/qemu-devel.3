Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20192CC6B24
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 06:06:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGs7i-0007mF-Vp; Wed, 14 Oct 2026 02:05:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xGs7h-0007ls-3n
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 02:05:57 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xGs7f-0005Sn-NS
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 02:05:56 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4a172eb31f0so29924095e9.1
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 23:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791957954; x=1792562754; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=I90z3+TIuHQyFon2sTpadMb2arK3M8TUwhpq1HNaNVc=;
 b=BCqW3YAOUI9sqI5FiDz/FZNHgfPmdhyRXzEgnwR3oek+GBvsFh4xKrEjG0I0aLlb9K
 3jNnJWO+HK4YIC0FJdycsyrNBFX72ANBDsfKZhGuWowQnRuS9O3V2Rzo6MavgELOKhge
 xemmZ5kmrcMs4L6eX1f8ET8bUkJgMkST4zy27gWXuOrcQlaMvFq9Og+nVz0KZpbr3pzt
 5leAXMD1NdtAhMl9FUAg5XLbxfe3DNlGvS5A+3PvWW81zYqJN54dzn0geSV8bimXa1Nc
 iaGgJeXQbd8dgPLln12fRSs/D3AYsrRp/OzSR6LwoMrsd2rMQVUZR5QUt9Jt709W62Q8
 oqVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791957954; x=1792562754;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=I90z3+TIuHQyFon2sTpadMb2arK3M8TUwhpq1HNaNVc=;
 b=XdESIMRYPkNtlLLyCAJak+WBF/OZqVaC2VYomIOjEb5X9RUMUO3AXAyn3m7ODtvd/R
 598b+ca8GSg8233ZmE7kCWcbZfFZTh0hL/Zkc+SbUGCbDfsYj3054xJeqH8ttyD9XYtd
 kgX07Poa+PvVQQ3BemcKdmNpDNShcYaK+LncIRbXOeJhgJEFUcUxQQa2E6I8jzU2fdMv
 8785f2Nay2BX96oOkilpPW8lI015IsjjlPYDa2wtm3gCCqfwfj8s8AmE6D9hpZpa3rYE
 r6UNYKF8rZ7ny0urj9hrSQ49cBF6wtKv4B2qhX4Y9W6M3JJwiR52BiKVBvaO215fg9sh
 1xtQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzdZsP09EG3AoVbsV7wI9YwpdM3v1Ws9stwsoePZPC+sMJCpI1QK30DZ6FHjVemtbAVh/qWxfDlDAZg@nongnu.org
X-Gm-Message-State: AFq9FYJGUBk9GVFyDnygfNs7G+XRSaDbydBFDg2WLyGQYSOr4hzBFf34
 x/V2Q/hYgzta25tPkrsB0dSQ72euM7EWLHVjCv+KFijagvo1CxgeADO5/G8N7a/1JZc=
X-Gm-Gg: AYBFou2EmurtGtKzyeqRb+LEKKThB0GdYHgIsjSFXBwKC958wk7rVSYEfjywfSxsYFg
 pJmsyI3lE76xFP3byQYufvJQn5Nqpyg3w1+Y1u5Mp5QFpPgOjk+71bO+qvXXE+zz4TszPx9SCfU
 n8HqrJotrFf4VOIIPhuV7PsznuyqdHE9lOBaSOfVL2+mm8w9NUljEIl2f2suKP5/1QvgF7Lhu3F
 oIyBiq7Yo4z1og1qfYp9BVDYQu3+g6y3AnMkjqwqmi8Z57eaqyV3t0O9O+eKuBTbA6ntb1VKtS2
 OsRBTfQ1sn6nSNidNPkb+KKiphkhK/odJMTLhaQlP61J9xUwByiytHW+nXil3bax9FKZQ6ZId9q
 mPnAVBMM68caqUEF6ykb6Y0oTH3RDUWesJmg8YDEJdEHQbCP4sBbppp/GwKlUHDiXzJjuujuHc2
 9uCBXlnrOaxC7Cbkxw86Km40gNaoku/a+RCF7ENw94T7VG/B74QlzV+iJbK0rVGCj4Onf7JQScz
 jySOnqBOhrSaJzWIBvo0b/aPOCG+ypX9xvGX6zcjnPYZ+MOHbnRGVaEEl05FV/skuM=
X-Received: by 2002:a05:600c:8518:b0:49f:cbf3:551c with SMTP id
 5b1f17b1804b1-4a18e4a8ca6mr266016225e9.12.1791957951596; 
 Tue, 13 Oct 2026 23:05:51 -0700 (PDT)
Received: from [10.86.151.227] (ip-109-091-152-129.um37.pools.vodafone-ip.de.
 [109.91.152.129]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a195002123sm449220435e9.1.2026.10.13.23.05.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Oct 2026 23:05:50 -0700 (PDT)
Message-ID: <2e8e75fc-6622-48d3-ad8a-3072fd1c573c@linaro.org>
Date: Wed, 14 Oct 2026 08:05:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tcg/riscv64: Fix vector constant matching for logical ops
To: Aurelien Jarno <aurelien@aurel32.net>
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 "open list:RISC-V TCG target" <qemu-riscv@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
References: <20261008181647.3015949-1-aurelien@aurel32.net>
 <118805f8-bc4c-4600-b156-5b494a840ef5@linaro.org>
 <asksJ0sjVi9BZ5m0@aurel32.net>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <asksJ0sjVi9BZ5m0@aurel32.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32b.google.com
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

On 10/9/26 20:02, Aurelien Jarno wrote:
> Or maybe you just mean to replace the check by
> 
> +        if ((vece != MO_8) || (val == dup_const(vece, val))) {
> 
> ?
Yep.


r~

