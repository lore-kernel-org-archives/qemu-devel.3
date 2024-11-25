Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C4CCD58D4C
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2024 14:04:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFZhC-0000xn-63; Mon, 25 Nov 2024 09:04:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tFZhA-0000wA-Rr
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 09:04:08 -0500
Received: from mail-oi1-x234.google.com ([2607:f8b0:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tFZh8-0005uQ-PQ
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 09:04:08 -0500
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-3e63e5c0c50so2368874b6e.0
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2024 06:04:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732543445; x=1733148245; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=D6tV8TK0EfROUQtEtz+4bnsTwJx+ZhOSilBImBbqBFQ=;
 b=PN3r0cOa0rN+JHMD2kJWKU3YWkiUtrAstT1K7y6HN0IuQXGRpSKO992dKNz7X/6fhW
 tHhZ40RJX2a0XLwpU9FrjB6Cr61wrCqEqaUt4pQcmO8Ga4edCV8QcjjcNt8/aAcCFo29
 rlqpQZMkpzJEUYXv789ms/YILdy+GGr2Hrf0D1OWCBsZtu7ywHVtxVf6/MP7yrjrrXJy
 9zG2lmhQf95M9JCVIhnwlDQbcrMNMOQwJ3uPx+yC8pbKd8UpqC3oX6AtMAztKVcPf+JP
 C9ph86flBrTi0hd4FrmqaaffL0eKs+drSoaSg6KCLRUvcA9qCr2Fg2wZbqzmjXI0FdKU
 hhxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732543445; x=1733148245;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=D6tV8TK0EfROUQtEtz+4bnsTwJx+ZhOSilBImBbqBFQ=;
 b=AIXjMWk+2e8Hh8KKeOZQuddvcut/fRVm6lvf91FSnZzHTjKYcMSI1vf6NE+vZfU1qP
 HzzHgTPLxLf0AuTE0QCtAmeDjF1ZUlg5ruL+4WPU9tMzKv1yIjnMMlGf+cz1ATGS51UQ
 KqtxQnR+y3gBTZBtqbuGN3DbiJRoogAHjzt/s5uOaf4CkXqJVtCTjuAJwBG2LcJ3uqKc
 LmMOSwmsCbqBKrtci3DnboL1P1C7vZcsaaL3AU56idhq/SpZnxliAaQEB3cZmrdKVxiA
 Zd6NQvF7NlgbIOwWJbjSH7Yfmj9B6/zogaX0pW8CbhoiF/b7Bocu7ryTWnH4kYdpQmYM
 YItQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUMFv80gR5Qr91Qsy5vFVFptZC2kUeO3fzXP9S4VE0KPWCcV4UWnkED8Wa/3dMEgpzCvJ0RXeUaDl5R@nongnu.org
X-Gm-Message-State: AOJu0YzIeQbCKPQE3HhmAmIDjh3q1u16EcoGe0hpTCxiOXAaVuzrz5lB
 awR6VV8b+HeyXY4Zgih8aCn4f1ETIgbsqjxS9KtemjXQygYGid9VO+yPVy9TgaI=
X-Gm-Gg: ASbGncuFn8Juae3M98veBAHV7Aci7GZ+0QsTu7fKwQqUhBVH9c6ntgKeNcNyL/ASmQ7
 ES2U9pbi2XOM2MAyUiZMbPpNuZuze48KywnXd+6q3wVT0sQVszBMDq+dEMZHw7zEky/mJl1azcb
 sr5rmPF8+x1GdEUFDB1l4YNO2zk0HyGRmL9PfKl4gunr7nJESR5en9Ud1bXtUCKQdxoJWdv/j7P
 /tuPUU87R8UrYqcl6wPv5kjCwN460WehdVbpiJMPoOLzk8VqYPi0K0bUXnZSNl6BQ==
X-Google-Smtp-Source: AGHT+IGu4S9v9c/wKRzPpgbDWMVuy9J+3xBL5b+dEzukrUC5OE6d6sRZs4ejwjNeWM3pGOHfCrejag==
X-Received: by 2002:a05:6808:1590:b0:3ea:51bf:fcc1 with SMTP id
 5614622812f47-3ea51c0019emr661607b6e.6.1732543445237; 
 Mon, 25 Nov 2024 06:04:05 -0800 (PST)
Received: from [10.25.0.199] ([187.210.107.185])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-3ea4c06a600sm473203b6e.8.2024.11.25.06.04.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 Nov 2024 06:04:04 -0800 (PST)
Message-ID: <77e47a71-a426-4bdb-bbad-24e6f99c498c@linaro.org>
Date: Mon, 25 Nov 2024 08:04:01 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Supporting clang on windows
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
References: <66c346de-7e20-4831-b3eb-1cda83240af9@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <66c346de-7e20-4831-b3eb-1cda83240af9@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::234;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x234.google.com
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

On 11/23/24 18:21, Pierrick Bouvier wrote:
> After thinking about it, a simple, exhaustive and reliable way to find this type 
> information is the debug (dwarf) info.
> By compiling qemu binaries with --enable-debug, and extracting info using llvm-dwarfdump 
> plus a custom filter [4], we can obtain a text representation of all structures QEMU uses.

It appears you are re-creating libabigail's abidiff tool.

https://sourceware.org/libabigail/manual/abidiff.html


r~

