Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BF4DCCD1BB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 19:15:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBeIh-00085k-Dv; Wed, 22 Oct 2025 15:15:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBeIe-00085L-Tr
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 15:15:09 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBeIc-0008Pa-R2
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 15:15:08 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3ee15b5435bso1118f8f.0
 for <qemu-devel@nongnu.org>; Wed, 22 Oct 2025 12:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761160505; x=1761765305; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yljPsTmMjJmJpY2wrNEzW2EbzZC+vOlz9wDjECyOhls=;
 b=N+aaDrGe1slniFXJUU9Yk/f6neyyROFIp7nGlA0pxngh2vMQ5YFjt3aCMFIlo8g5Gc
 rk/Ws9N00nfy3NRxJwha7hQTZ7SOfsl4hWO5jchIM6r6EPR5AktNk4nYuFDz4alm8hA/
 3U9Qm7zw3zT1Bl6L2m8B1nf9mzsV54eswA8w3GlQmCoDTx4DBiEjYrKZicHj+GR5LT4d
 A6OmiAikWO5vRFP0dohrKx5kg6D0xMbxt1NA4JSrkNp52ctnkScccu/Xyl8yuLKsz2nL
 oSUN4+W6qYi0pMZJH5LEtPckrlFq406P2t3UCGrgkXs/TmdZ72BqpBK7Ev4y7BejbChp
 TRDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761160505; x=1761765305;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yljPsTmMjJmJpY2wrNEzW2EbzZC+vOlz9wDjECyOhls=;
 b=Az/bTrb7wnHq9pQPHDdeFrQlGrPxI45wZs77m/3V6+7N0T7hvvyw3huU9rPg9HqAtV
 oHe+vme8rblhifmLjVtj9XBzq6K0D7PQTpU4zYMnBbfBmAaISIsnr9diBdFXAHHhhT5V
 YAeC6bhc/XFipMR3N/Ep6GuWtXcsFfa4UHUFNbe8Zf/k7m9ti6u3KKJXie2UAJIQimBL
 2kAoP4d/DiRORbeOJ407Y5xHzKMAHbKednNEUCPrOH6fGcw+FL0f1Xp0Z2W6D98FAF86
 zW9paCL3gIwmUyUG0lXhtfhGpCoZPtGW2GMeyFYf9Vx0PJG/r/7qIXwBFJgZEKKcJLQa
 9HEA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVo5DsuDf1RapDhNVe0gLblg7MDoasetB6gllSWXIzlIoRcLbIoMdjuyxr4VXxND2be9RFw0JfQHEp0@nongnu.org
X-Gm-Message-State: AOJu0Yw2xitdOXGAB7J7f2DimZvEkHnIvT1/ZtzVjdUhLdCOA6Cr3yVY
 D2pkNzPLZrR9FT8n9WyRDkVJVQkfnjXGYQ5Z0hKKFUv6MShv4xsiqlMjT71kaLT2AAA=
X-Gm-Gg: ASbGnctw9Tct8EcklvWJ9feBjPfw0MBq7oA8SEV1dSxAApZRAmC0W9hykd3uvc8A+dr
 8W35cDiggUOKnLSRtnzYHkIJM4zSk08Ah9fBRxl7jt0b7+cUZiqWfZXr0FsaWjpASqKxd5f4Ro2
 zbHTNg0kZ7Sz3pBz11KS/LbOudNZpkXmjr9hKEg4NDzcLoteCTsAhEWfhsJE43stRKQ0Xm9ndQ6
 eZuhwDmqQ9KH/G0pxMAsrlWuWhoVSjlOnnha2o+KF1yDjIL2ljOv7YxT3v8qEF2BWBY4HCRuxmk
 LHHEZFOm7Bsc/QDCBRHuhSy8nPfyLwLk5b7hGOXP86UMmrxA3ZM4axVpObar57f5tUrvg8j+IUq
 tjz6hiWrZP2eYFHtCCef1wIhG7BJ//YN2QivduG+Ddkjas4zo7umDy+u4djCgGKWjzF9qz/22mZ
 4KdNfRHWVI8r+M1HReF4SQdYwE/hDKbLlck8ab+d4l3NI=
X-Google-Smtp-Source: AGHT+IEuveq++NdFeKuYghRSPmAC8IhTPXPMTQjrMUMSCRT3Pvz9Vzquo3neYMaStx87IBmgNSYAzA==
X-Received: by 2002:a5d:5d0b:0:b0:426:d582:14a3 with SMTP id
 ffacd0b85a97d-42704d830e0mr11892623f8f.9.1761160504876; 
 Wed, 22 Oct 2025 12:15:04 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-427f009a9a9sm27007853f8f.29.2025.10.22.12.15.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Oct 2025 12:15:04 -0700 (PDT)
Message-ID: <3e7bb5f5-b783-449b-98f9-ba52ea599f9c@linaro.org>
Date: Wed, 22 Oct 2025 21:15:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] tests/functional: Fix problems in decorators.py
 reported by pylint
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20251015095454.1575318-1-thuth@redhat.com>
 <20251015095454.1575318-3-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251015095454.1575318-3-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

On 15/10/25 11:54, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> The documentation strings should follow the function definition
> lines, not precede them.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   tests/functional/qemu_test/decorators.py | 176 +++++++++++------------
>   1 file changed, 87 insertions(+), 89 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


