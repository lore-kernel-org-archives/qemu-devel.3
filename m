Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D212C0219E
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 10:37:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjyUS-00015s-QN; Mon, 17 Feb 2025 05:36:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tjyUP-00015L-VU
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 05:36:38 -0500
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tjyUN-0000fm-Kt
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 05:36:37 -0500
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-2f83a8afcbbso6426864a91.1
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2025 02:36:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739788594; x=1740393394; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VZaQA6oY1zAQN3KDt3w+Eb4KY8WFms2yXCHu4yTJQ4s=;
 b=h+Dy7YweuxN08wjsrBWfE8huPKH1STn/WCDbHzxKVwtkWY7UHbkVxHDV/m3EdbeIZN
 Afn4dy8QwbeEFdpkzSOBwx6/T3dMPYkCYyPe22tv5Ghu0/zd+xK+CLFJsnUI1zccfHFJ
 hOQ8YdW2zIbzy4/OSEpF/58y7pyMSbCaPljC6+IfFG68TANhciFMWRpVt9Qp8RF6xYKe
 LmywtScWGt+0ycwWFENoXplG+R/xDaA//uCVsr+FrxlHhb4/8rlEZA9xDhx7IIoJBzdg
 hUXZ0Mo5IjG0imNznrrN91OzoVenJxTJ8HXzbnhx2no1pr76aXmc++dXu+o0Y7Wfl7JW
 XXvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739788594; x=1740393394;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VZaQA6oY1zAQN3KDt3w+Eb4KY8WFms2yXCHu4yTJQ4s=;
 b=u4glx4QvyWt+kP291R34ckSzDt1IK3dWU3rZJmbKYCOzsFsZB02konFGzXIx+ydDpY
 8jeRpEFkl38iF16nPLTdL8KBv7egzFaMnwxxc7xvxZvKmwRN1DCDQVede7lvxEhPAaea
 0ZUl7N6D/Tt3tFM4Xou9XFqy688xSbj2XRWmW9H8oA+DAd34PhjCQ27AZM3aRFD8nyzY
 rVKOPBGxMshrczh++gzWlyFUm/5F2er5czJO84ob6MVO3pse56uFuXtLtoZHYGSRGYvZ
 P9ZTvwZzf4EjUfq2IYYWm1/IkVskNKXxgjdI4qgcdmBygC+BY9zqRcRFq9nvThVSjJp0
 mRmA==
X-Gm-Message-State: AOJu0Yz4B6N7grtbmpcAexpkWBHcoIqQcjVnZynrdBZ9OMf846d6iegl
 5pJ4nHQEFgpbDa+JatCct7t/X1T6HUPExccFepLMYYFMQv57szhj3AYoT5yB2H4SC4pLLUKOgtl
 IlOs=
X-Gm-Gg: ASbGncuN2golPWK4hZZLrkRZ9vTkWk0m5MbtQSdoCcIA0Or4h53ntwOCdQZsENW78/4
 X23FdYbFxbZwk5InO42beypaWGqtOgmC8e8DiSH22Fw33S8aQLLLaEHH+KCzoPOdgARxIlfdDgw
 dgserSEoOf2xwowXv81w4PpueLyyr6zUxhshatqp3r+hnu4cDHNZen4Z6U1RaLSo34doiog7nJJ
 ERtsDJw2XWbKhlgNUSpEOYHgo9LDuTvpFcCfI4Mtj/e/gaLdgGms4pvqvGnMdrehHq7n6EgBQ4a
 lzJ2Oi5Vqga/rAprVvchuRT+pYoEsC2xCYA=
X-Google-Smtp-Source: AGHT+IES+rDfV9ffiOceN6o8qUivKnir1ZgNdL3BxTNxyizQHU2bwU8wigF0FGAJbnBITx/XfBDLYQ==
X-Received: by 2002:a17:90b:4a42:b0:2fa:3174:e344 with SMTP id
 98e67ed59e1d1-2fc0fa49d92mr27696481a91.14.1739788593848; 
 Mon, 17 Feb 2025 02:36:33 -0800 (PST)
Received: from [192.168.1.121] ([176.167.144.216])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fc7e9325fesm1550248a91.46.2025.02.17.02.36.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Feb 2025 02:36:33 -0800 (PST)
Message-ID: <efcfc900-c928-4cdb-aca8-f187f18ef1fb@linaro.org>
Date: Mon, 17 Feb 2025 11:36:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] qemu/compiler: Absorb 'clang-tsa.h'
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Warner Losh <imp@bsdimp.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20250117170201.91182-1-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250117170201.91182-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=philmd@linaro.org; helo=mail-pj1-x1031.google.com
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

On 17/1/25 18:02, Philippe Mathieu-Daudé wrote:
> We already have "qemu/compiler.h" for compiler-specific arrangements,
> automatically included by "qemu/osdep.h" for each source file. No
> need to explicitly include a header for a Clang particularity.
> 
> Suggested-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
> Reviewed-by: Kevin Wolf <kwolf@redhat.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   bsd-user/qemu.h                  |   1 -
>   include/block/block_int-common.h |   1 -
>   include/block/graph-lock.h       |   2 -
>   include/exec/page-protection.h   |   2 -
>   include/qemu/clang-tsa.h         | 114 -------------------------------
>   include/qemu/compiler.h          |  87 +++++++++++++++++++++++
>   include/qemu/thread.h            |   1 -
>   block/create.c                   |   1 -
>   tests/unit/test-bdrv-drain.c     |   1 -
>   tests/unit/test-block-iothread.c |   1 -
>   util/qemu-thread-posix.c         |   1 -
>   11 files changed, 87 insertions(+), 125 deletions(-)
>   delete mode 100644 include/qemu/clang-tsa.h

Patch queued, thanks.

