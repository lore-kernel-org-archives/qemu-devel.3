Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5059EE7717D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 23:48:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLWQT-0007MY-J9; Wed, 11 Dec 2024 18:47:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tLWQR-0007Lk-AW
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 18:47:27 -0500
Received: from mail-oi1-x232.google.com ([2607:f8b0:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tLWQO-0000dX-TP
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 18:47:27 -0500
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-3eb687d96e9so17904b6e.2
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 15:47:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733960842; x=1734565642; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Qkb8oD9u4TgqN+pxR7Frz6fjPra88BkSdEWP5k4hn+g=;
 b=jvUIE2VCbD1f7SIbnNqE2qDMtUtx3M3QQ5sCEpd9+qrruUARu1S7dd1XDcII1JD6gz
 qOGMJcq+D+TTQ+Yy8qNAco6mU2enPlaeKuEzIxP5xA+WpPsQFpU0OLHEK0yyqRAzWR6U
 VbA1r5NddAbi1Ot/1FGpO0k4J3K1Yl79aOxSDxk5+CbxSMrJT07K/dkVWPieNJgGr0iN
 qTNiN0bHRL8XO5mANfvGNelrA3RscT3EqqygyeB6HbzvTqlqcigQ7bSIKHmxlxuabqrr
 wRc/5+Q0QpbqI2dwJ2hEnHvCDt3pr0t3b6t2vBR/z/iSyVSodHFLRauiayr1MsQWW+3H
 TD2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733960842; x=1734565642;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Qkb8oD9u4TgqN+pxR7Frz6fjPra88BkSdEWP5k4hn+g=;
 b=d569R7uHgKADetfg9XmhrvtN3kgEuFuuXC/Hdi/UY9d/nIXw6uLkE4V9XtI+Hy+f8I
 BQ/up5O/dYdMjgYGWSPS/3F37zmmcFSA05gNBXZAzaLXWZTcaoqQ6BJolm8Zm/1bfP6c
 5HLg3BXDG+lU5NAtBtSxY5GwCwLdSbkudP+Pi9z4odVEtcZikk1n14cWM+Vv9+4agsH6
 xSH/CGO0qUyPgxjHtJIdN9EclyJ4jWSKuWWhumvBAPj0cKvXV/LQ9T7bb68pb9WN4HL6
 ucbJZCh9CnKmcEP3Yrh1Kvt3oH4muz0XrBSbdDjj9YGRdMANF37oAgSYovlpmHEOTvFS
 xUjA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW9NN9Ch4VJWWcNgYYeG58paDluGx8DIfMsGmBKVeKlXONlWb+ajvsqrE3qtnVGCWQXInBiS9FWvuUd@nongnu.org
X-Gm-Message-State: AOJu0YxDB0TgamOT5sT+akdxywx5M8JRYcOSLG9wais88ZfoUr7o8IfW
 VxGu5ex6BZ68BE0zTo4RxcOZZ2/qMr/F1BOh5E1Ndj8cO35w6Kpk+uUOgX0iJKM=
X-Gm-Gg: ASbGncvJtlZmDjiiJaszZRQsnQKYadjjSiIR9bZNTC2RkWPX4c81Safs6LZ1wcJP927
 ZBW46Su/fQHx/Y544PjWaDXHeUo3yNDq1Gho4+XD76fbWfFN9sefdEiaWJh5vsaJakcbBFWkvDt
 z3jGdoA0ezKnv19jroA9O0WtGhX3XUPawpyNdkYckzE74MEXsVzURTzoM2hI26ObYml61RovEld
 kzBkkdU2uWJPkU1HgrnS3WRJe9Bg+pQdwfFzAJoY0FOxZwDobe8WvEdgSQTgJ3CCagkTfrSyWUv
 1KyWAKxjARKBFrEkKGFm5zuH6ojyg9s5
X-Google-Smtp-Source: AGHT+IHU+cOWE86uvXrorvXrtIkRj2xEl00rtlMihVTUR2Ba5ADfWDMcN0frAXUXDSR/VNjOFrzqPA==
X-Received: by 2002:a05:6808:448b:b0:3ea:3db5:ffd4 with SMTP id
 5614622812f47-3eb85d4c48amr3027896b6e.32.1733960842106; 
 Wed, 11 Dec 2024 15:47:22 -0800 (PST)
Received: from [192.168.4.112] (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3eb076f8bbasm3517013b6e.30.2024.12.11.15.47.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Dec 2024 15:47:21 -0800 (PST)
Message-ID: <ff4153d8-89de-4e9f-b0d7-7ffa58ce7b11@linaro.org>
Date: Wed, 11 Dec 2024 17:47:19 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/9] accel/tcg: Include missing 'exec/tswap.h' header
 in translator.c
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-arm@nongnu.org
References: <20241211230357.97036-1-philmd@linaro.org>
 <20241211230357.97036-4-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241211230357.97036-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::232;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x232.google.com
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

On 12/11/24 17:03, Philippe Mathieu-Daudé wrote:
> translator.c indirectly gets "exec/tswap.h" declarations via
> "exec/cpu-all.h". Include it directly to be able to remove the
> former from the latter, otherwise we get:
> 
>    accel/tcg/translator.c:433:15: error: call to undeclared function 'tswap16'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
>      433 |         tgt = tswap16(raw);
>          |               ^
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   accel/tcg/translator.c | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

