Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBFB3C369AB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 07:02:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7qam-00084R-0F; Thu, 24 Apr 2025 03:01:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7qaj-000840-SX
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 03:01:50 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7qai-0001eA-0U
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 03:01:49 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-39c1efbefc6so375850f8f.1
 for <qemu-devel@nongnu.org>; Thu, 24 Apr 2025 00:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745478106; x=1746082906; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mF6aPklOqx+IH44FkR29S7aGIHk8DMvNMr7QRWXoays=;
 b=T7kPsKT7V1RDxpgE0PSLB95PR5gB2jocss9STz106aivA7AJCCHByE7pLR8sk5cphx
 p32+586I4AJc5jn8jfWZJ3XCav+QEKTbYjgK/XanfOWWYyTjYGr6STAf3CMZuLxJBbyW
 F3icV5o+5bqV37ijYDjQ/kocK40JKABJI79SPJ7JYEKW8VvWGgfIo8qYFU2Hln/7EYOo
 1XCmJZVSuhu+FhpziNqr2uPFKOaBpQAKkEZ16JkNYhU6vbM1jipRSqa1SIIg6KrwWFQm
 ypK5X3PoRsL7dwKXZLNJhiDW0mli0eBaRPGEmEIpIUluLZXxJpXrXglob02xqK5WdpyK
 MNKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745478106; x=1746082906;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mF6aPklOqx+IH44FkR29S7aGIHk8DMvNMr7QRWXoays=;
 b=GHoT0fS8vaLXINaaZIJ0CMEfubo18zMFXodLAtErUBQ7FY27mIkcNFLDP36dzx8RA1
 jZug6ys7sljQS4vR1WBlJBVfQObkO3Nw11OWfylP7Wwg9xCgXmE+oQG2Nkzt8Rm4c5Tw
 tNI2+iRCGLvTV3rWXmTNnw7X+6cG4KwdWHrnjXo2yYJAH+bwsVOB+EYB8st34GAwvLOz
 dIBy3KurPiUHdahtvxnfavq9oKcRmevumOfyDeW0gEQs91h3ovJmM65srg+FiPAxy55+
 OuwKMv24Qgw8ytjBdpbGe5j7w6pI4zaPqrgACB9yJxckXj5M6W7ZzCfrcytpKWfApLu+
 ZgbA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVApr/j8BUz9mf4hX8806uo4sSv6d2gx5+KR8uOp2W2KF1q3+vzLBqE8plrK+7Kzl6tfgP1mB2ivbjH@nongnu.org
X-Gm-Message-State: AOJu0Yzqo4oGcSYJNL74QRtMGmWDsECJ7P/lrQxa/fxIxv7eXKTEbAcN
 FPxIakJDZjzDh92KudbFKXXqJZ+/g9u3era7uuQZyRtLZrFM95Mz0tHNPPfB+KG6VhdbfogGQgZ
 b
X-Gm-Gg: ASbGncsNYUPSpKKQCa2nnWHX2Cf7JoiLPUmL93d/wyixoc+DKNGNcZPqeDEvk5bhr97
 1/cMpjhVPP1SZoRWhdhs6CgsahmMqZW5tgk34dvxrjJewIKvFqlMSy3n8u5IJTcJw5gmJsVASI4
 JGxtyWZ4LUuE+9TtG1UDM5+GEmjlgXDaHka9En9p+lxpCoXqZzGSnxCrCuy3qHV2HiPTn1a/h/u
 TVLQGo68pJqMusWU6jjGWChUU+zAzfYzNbeqXa/ZpYgtznjIIzby0huKSyDbXJUhSWl6gNxkbzM
 8yiVCS0IkJ7t+m9B8WlZdBNpR7xWbW8MNLW64wIRrr7UNhyJXRgYW17K0hus+33SG6VwS8oZ3OP
 bG7mHaJn6lrHO9w==
X-Google-Smtp-Source: AGHT+IGNrZ9NDUOUaGiUH/tfT2uqQUyNfAVN/V9vVO2A0CcT4M5fuBCRMoc9EtweJaG0amjIekldpA==
X-Received: by 2002:a5d:64ed:0:b0:390:e889:d1cf with SMTP id
 ffacd0b85a97d-3a06cfa7ccbmr849716f8f.37.1745478105909; 
 Thu, 24 Apr 2025 00:01:45 -0700 (PDT)
Received: from [192.168.69.169] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a06d54ee11sm1045293f8f.97.2025.04.24.00.01.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Apr 2025 00:01:45 -0700 (PDT)
Message-ID: <0fc6ae29-ffa1-4fe0-a0ad-9966626822b1@linaro.org>
Date: Thu, 24 Apr 2025 09:01:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/15] accel/tcg: Convert TARGET_HAS_PRECISE_SMC to
 TCGCPUOps.precise_smc
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250424011918.599958-1-richard.henderson@linaro.org>
 <20250424011918.599958-8-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250424011918.599958-8-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

On 24/4/25 03:19, Richard Henderson wrote:
> Instead of having a compile-time TARGET_HAS_PRECISE_SMC definition,
> have each target set the 'precise_smc' field in the TCGCPUOps
> structure.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/accel/tcg/cpu-ops.h |  7 +++++++
>   include/exec/poison.h       |  1 -
>   target/i386/cpu.h           |  4 ----
>   target/s390x/cpu.h          |  2 --
>   accel/tcg/tb-maint.c        | 32 +++++++++++++-------------------
>   accel/tcg/user-exec.c       | 10 +++++-----
>   target/i386/tcg/tcg-cpu.c   |  1 +
>   target/s390x/cpu.c          |  1 +
>   8 files changed, 27 insertions(+), 31 deletions(-)

Nice!

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


