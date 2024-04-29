Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DAEDC4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 00:50:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1FDH-0002wq-F7; Sun, 28 Apr 2024 20:49:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s1FDG-0002wg-Ef
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 20:49:46 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s1FDE-0004Bz-V8
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 20:49:46 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-6f043f9e6d7so4061447b3a.3
 for <qemu-devel@nongnu.org>; Sun, 28 Apr 2024 17:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714351783; x=1714956583; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+cw7+EJodaKdIYcI1VI/QahJY4ZvCbrrwkB03h30AkA=;
 b=C+2xnTXNlNJmMzpsOqWLi6cUHNGhLEBZk3XwqS4nzl1+sy23aygJLs0JjCmeJwxkRq
 AZ+UHl89sf8ygazJV8v9npWYtaVOWUfmVuYfssoMVk4uHjb6XaEwbhUlMXpFt0G0HL+5
 onVb4j87rEwypdMD9siBrR0tUT1BwzFiYtkDuFMMoIO9vtUfFMjEAMSmnzl+KVJvp4Ux
 X6bwgupU/V9nz8xWZN/M3iSzB67xVPNH0z21qZU7uSpv+LUqhv/uruDV5Sqm8ORhAWCw
 PhRUr3GWi08duewgIpCPnnYkezet7wJEl2rkpMJ88Ntb3dcz4NxwGgWZ/flE3fwG7ezX
 p9/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714351783; x=1714956583;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+cw7+EJodaKdIYcI1VI/QahJY4ZvCbrrwkB03h30AkA=;
 b=UCbof4Dbyc1ONFyJ4zD2+c1JCgn7xbL3X2WDE4qwT8QFYJ/aV2epR19N+rGrAcsswC
 zyA2kEV1IAxrt7tEoe2c6m2kGgeQWgkwQ6a5DamN2JrPoklzhObqjGeqQ+RPBrNqmrGJ
 yCKEYIGvKeo+kz0TJpxMJDhr9JtCd/M7VGtiCGKuCAirTYznzWhLC0xrwdvi5VK9YYlL
 U4BzQAZo/4oJ6SaHl8hvNG+5HRCYXC1KI7uZS3HcsieKQ0OLEpAWr+5tNgSBLlYGRJea
 nh8AAkMVPqwLdUozG+s2DOfL/2KVCwyCF9qValboIMymGSl+SFT5JiXz3w1FbjVMPbYq
 vHVA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUSgzbjdMNFaWLxX+ep5f/IhZNxwipgP7OteqQMWZ5xQspjaYAovbzqnNnDXJFj1qKT87Js4Xs83Rw75uMLhfnAHpCy2eA=
X-Gm-Message-State: AOJu0YzYzENtXYeRgheXLTiCKp1roqCrQgHEfCOW4yT7v2WL3MWH1cz2
 DMxbZsErg2lRWWvHqQ/4d0sIMZIp5YcV+QdY8xLzyg8V8/0OEVON0Dls/XEqYTs=
X-Google-Smtp-Source: AGHT+IEKgWf3kSsvfPhx1oMx80lrftxNzvyrzMcylY/YODcKKGA2wOdQYSHwBiEWai7D5UGLu/iU8A==
X-Received: by 2002:a05:6a00:8a81:b0:6ed:4a97:5dec with SMTP id
 id1-20020a056a008a8100b006ed4a975decmr7880570pfb.20.1714351783115; 
 Sun, 28 Apr 2024 17:49:43 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 ld2-20020a056a004f8200b006eaf43bbcb5sm18156619pfb.114.2024.04.28.17.49.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 28 Apr 2024 17:49:42 -0700 (PDT)
Message-ID: <32c7d43f-0418-4353-bbfe-38b3380f8066@linaro.org>
Date: Sun, 28 Apr 2024 17:49:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/24] exec/user: Move 'thunk.h' from 'exec/user' to 'user'
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>
References: <20240428221450.26460-1-philmd@linaro.org>
 <20240428221450.26460-2-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240428221450.26460-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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

On 4/28/24 15:14, Philippe Mathieu-Daudé wrote:
> Keep all user emulation headers under the same user/ directory.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   bsd-user/qemu.h                 | 2 +-
>   include/{exec => }/user/thunk.h | 8 ++++++--
>   linux-user/user-internals.h     | 2 +-
>   linux-user/thunk.c              | 2 +-
>   4 files changed, 9 insertions(+), 5 deletions(-)
>   rename include/{exec => }/user/thunk.h (97%)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

