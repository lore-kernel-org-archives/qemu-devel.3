Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DD80CA0EED
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Aug 2025 06:35:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uocPF-0001Gj-6T; Wed, 20 Aug 2025 02:34:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uocPC-0001G3-1L
 for qemu-devel@nongnu.org; Wed, 20 Aug 2025 02:34:42 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uocP9-0003j4-LT
 for qemu-devel@nongnu.org; Wed, 20 Aug 2025 02:34:41 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-45a1b05fe23so37593805e9.1
 for <qemu-devel@nongnu.org>; Tue, 19 Aug 2025 23:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755671678; x=1756276478; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3svD1JPaJmYOeN+BlZoZwt0uCIBvoHeilNb/TI1AoIE=;
 b=X+ezngvB8qaXeA0+plH4/1FyYAtAKQKcfgC8Q3cvYJqpfMV/u5d2ZjMUkASwAt9Nr/
 8/wP4cn1PIbNv/eYvEG/BJx8+kYlI4naigx7zMR7PUpO6vxEbE9tpjSEN5ITR2uCDuXQ
 Fh7cyAFbFUE5KLXZGwCYJUU+J6qXDb8AsqB6hVuU8T+0mghE2cfJ6kJvW1sz5BNfMxpg
 kPK3NNwcLQPXQQ6HSXuX3VMV4qQ9HkaUlVdzwEC82nNbyLQE1W6k81gXu/r29BWxlM5r
 cx6kQxcuYIeak4c0nuLjZYKcgTIp/IcjfvqZYEzKXS6J58tPIXRrvIvx4tuZyCXdf7dH
 EVVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755671678; x=1756276478;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3svD1JPaJmYOeN+BlZoZwt0uCIBvoHeilNb/TI1AoIE=;
 b=PFmkTcM5YngTXafcCrf0JHKzpxgkPhmFiJibNwjBaZgdZSSJFt27KBXpdvYonu+z5w
 Re5OYBp7NUF59B9yyXSIi+MB+I41U1yY02KrrdYMTYy+1QGAsJoIXW+h2CuhCZ6UWM3P
 FoXPMH6gw0kSVdujZN19OHegrUKVRVyq/xXLfqjKwi4Y2Q3T8tuM98Q4AKLZEqOrf+pq
 ujnpifxtuUVlLael0WfxGo3frP3X55X0mvGXvOdZ/BZ1mofaVMlR1wHs82msL0P9DJZb
 L7TgG/v7EBsil3G69ePFjHrpdkKtBSwnkcem8xJMXQqO0NFWqie6y7Z//9MzO5XKHbDI
 kfhw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXjnP+UZJ9Q3sAtXCiXzc03Ooom9Vjh88KErKMjQn6ui8lhhDbMEOGqMNcyMmd0TtACmPOMsL+mjxAL@nongnu.org
X-Gm-Message-State: AOJu0YzyN+0b6lM0Ry1e6wzHt9JmcgXUANQoSMB1yivdyywSCCXDSiX6
 Yah3KHett7JbieCCxGwwpet9Xinc20jGB9ILvW3Kf6yozJ0RHXMddPRNhSwZmQk/kTdk+JTbnY1
 qUCV+
X-Gm-Gg: ASbGnctVQZRq7GOKX9wtBnvr+hNtk35Yxt8+1Es1rKTRdyIQFk73+/yyXzI71YOG8l3
 KaXfERl1GZgic/VWrR/lzI2QBMTV9lAn9O2MLzwviSojDWw2v57t0Ik/XzShl9Lcp4FNaqnU7zI
 Vb4xRbq10oROUjcvREQtl0bWN5BqZc2+pDfnnFUb0cO7Bj4/lmuPp79C4zByNRgIPLVGlqLdJGa
 FrMW2mcjioFb7/2TOdte9XsZLxD9MLU7nJkbN7upkezXTk4xE8MY+qgyw9Dz7fTNaztAeMFSeYy
 qw8mYaxfuwEwZNb1BKvXrxUvn0uTf5m5IH2vGozYfPaf3RoVK6ZP7IlpTAgAGhSWFzFui4Qcc0H
 3hidy+KicGIREMi7/IhpIOipOjUvxgzO8JdhDK15Tl0zq/5aX2CQZATkgj1ZvU1PosA==
X-Google-Smtp-Source: AGHT+IHlX7d5qMS38UjP6nLDXQbhCkxCadkAFHkwno6+bc0YThlaRaa2z/Bq0aRFlYOwRCGp37niSA==
X-Received: by 2002:a05:600c:4f8f:b0:456:19be:5e8 with SMTP id
 5b1f17b1804b1-45b479e952emr8858425e9.20.1755671677714; 
 Tue, 19 Aug 2025 23:34:37 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c07496f432sm6326772f8f.6.2025.08.19.23.34.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Aug 2025 23:34:37 -0700 (PDT)
Message-ID: <861e8b8a-3ad0-46dd-9628-cfcb49fba6a9@linaro.org>
Date: Wed, 20 Aug 2025 08:34:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests, scripts: Don't import print_function from
 __future__
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>
References: <20250819102409.2117969-1-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250819102409.2117969-1-peter.maydell@linaro.org>
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

On 19/8/25 12:24, Peter Maydell wrote:
> Some of our Python scripts still include the line
>    from __future__ import print_function
> 
> which is intended to allow a Python 2 to handle the Python 3 print()
> syntax. This particular part of the future arrived many years ago,
> and our minimum Python version is 3.9, so we don't need to keep
> this line around.
> 
> NB: the scripts in tests/tcg/*/gdbstub/ are run with whatever Python
> gdb was built against, but we can safely assume that that was a
> Python 3 because our supported distros are all on Python 3.  In any
> case these are only run as part of "make check-tcg", not by
> end-users.
> 
> Commit created with:
> 
>   sed -i -e '/import print_function/d' $(git grep -l 'from __future__')
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   scripts/userfaultfd-wrlat.py                           | 1 -
>   tests/guest-debug/test_gdbstub.py                      | 1 -
>   tests/tcg/aarch64/gdbstub/test-mte.py                  | 1 -
>   tests/tcg/aarch64/gdbstub/test-sve-ioctl.py            | 1 -
>   tests/tcg/aarch64/gdbstub/test-sve.py                  | 1 -
>   tests/tcg/multiarch/gdbstub/interrupt.py               | 1 -
>   tests/tcg/multiarch/gdbstub/memory.py                  | 1 -
>   tests/tcg/multiarch/gdbstub/sha1.py                    | 1 -
>   tests/tcg/multiarch/gdbstub/test-proc-mappings.py      | 1 -
>   tests/tcg/multiarch/gdbstub/test-qxfer-auxv-read.py    | 1 -
>   tests/tcg/multiarch/gdbstub/test-qxfer-siginfo-read.py | 1 -
>   tests/tcg/multiarch/gdbstub/test-thread-breakpoint.py  | 1 -
>   tests/tcg/s390x/gdbstub/test-signals-s390x.py          | 1 -
>   tests/tcg/s390x/gdbstub/test-svc.py                    | 1 -
>   14 files changed, 14 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


