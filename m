Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 035CDCCF9E3
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Nov 2025 11:23:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIPza-0003rJ-BP; Mon, 10 Nov 2025 06:23:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vIPgJ-00015B-R2
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 06:03:43 -0500
Received: from mail-oi1-x22c.google.com ([2607:f8b0:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vIPgG-0003Ou-2u
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 06:03:30 -0500
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-45045024527so78219b6e.1
 for <qemu-devel@nongnu.org>; Mon, 10 Nov 2025 03:03:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762772606; x=1763377406; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SPa5Roy8ZBwnrS48RwPdrJlEa9pJlzzuf8bu3IzUT+s=;
 b=SQqpDEgOJSipaQ9Wd+d69dhAHldU45znmblqnjTnUUwca6MvhSDBbtycuOKS62HwZD
 l1k4ciYJeUuv7Ynt79u88QDXJor3bOt8EMYmOhqFHOC3pT+Y2T0fTn+cFQa73EBC15Vb
 1mVrXAlPEF6lu3CnkEdC5pkhII+g2Jf23ANw/M9IVM0dBz4ZCmPakZLpvL3yiGEh+Jmd
 z3hGflnlz9vqTsxdjUJvko3ZUtCeBJyoiepIc9hq+/zTk0mxdNVRu90ljkokas/Njol7
 TSyX9fAVhonAtnC5xKpLad6SfOLg+I6MT6hg9zvEiwQcszJbVruwtTACtSD3WvSbGcuN
 HnrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762772606; x=1763377406;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SPa5Roy8ZBwnrS48RwPdrJlEa9pJlzzuf8bu3IzUT+s=;
 b=IP3sgwjoTFtSuzwvthiW/OzQ9KM8e1I7kw8Rfe2dprk6DtT4/eZUhZnrdQboKpdgv1
 C3AnOiSGFDYM4kSfU6HO67dsE6La4bS9RPrnhH1631NDpf3MHod2ugoTwYv/NhBGUdZF
 CjZHkPEDbGc+0dvfJsgNCJW6ckoX2GjjIEnYGPcxSpfENiTDtNUsJ+MAu8naMSM0ZtlF
 sdOde1oVet2cnTFPFONhOG/YKyzRS3NSF3sf7VuR0gXhoAJxVxQOBapsTxGmkRVSW7tL
 +quZX0kAWO5QIu0hlhFuw/uYps4QggK2Qiy2/Z0Ls0wrItM/8d+UJkq9QIn195jxGDBr
 Oe6w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVY6kJHJ2K/y2rNYMzCeXIEbDsuSLucMEc4XATqwnQ6Oz+fy7YF9qngEvfwmvfFIxhZWF9HQgSL1gWi@nongnu.org
X-Gm-Message-State: AOJu0YxOKi3GL9W+Z8fyjjRAfZhA0C+xY6QyCdXWU9LqoJl/a97tZgSS
 pBYuYag3/9FVkmrvu3fgcVsl4/uFsz/kAYuw5Xe7mwqjSTU2x9oTK/AIjWE5vvj5x7U=
X-Gm-Gg: ASbGncudDWXxZudESaGmgrBTFIEcp6SlmHEgI8NOUnjA4+yT0RcYqKFps9bscZ7XlRC
 n382TBpXO7JSR17p3uJbEYx2R+AGf4/b7yKtTU5mPpzy7zhxXBB2M/aCy7PMQV5cZuJaMyJ3lW4
 kEhnoSm5bZe6+lu3fuvShnSzr0hWQxxI27/qFmkV1KpIAi77DH9fh/5uZ3BgGRp6ZerLkxcbuJm
 33/UWH34ohPJH5zQ0EI6M4POKup5ZrADv6+afW64JE63P6QHBj+9g3rbQEENN06eW/3swby5WMo
 KjKBNe1IGC0WQa1e4DxucKks+OFoQWo5VbAZ02vcMXwZ5xaPtukjRStp4YvwqNKIUBsjDwEOnuH
 kO2ulF8Yo6q+0gl6q52007dGzNR9cXK9AxO1nfm8reVCffVSp3IU0pPyN2LzCHPB2zqNP+DWhXe
 gT/VmdH1v/bHChVencwWPwXMNRETnBs1EqpKiG124=
X-Google-Smtp-Source: AGHT+IE84PE9i3tXizduQdV1m32+FpHgQUkzxpBRRqlKJOxDnaGA2/WJk4XODjC0cf4bOYR7Iv8cdw==
X-Received: by 2002:a05:6808:198d:b0:44f:ddf1:f238 with SMTP id
 5614622812f47-4501c55d866mr7233494b6e.0.1762772606590; 
 Mon, 10 Nov 2025 03:03:26 -0800 (PST)
Received: from [10.89.10.227] ([172.58.183.226])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-656c57d5928sm5844316eaf.13.2025.11.10.03.03.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Nov 2025 03:03:26 -0800 (PST)
Message-ID: <885acde6-a468-41ef-bf54-b977a1fad0bf@linaro.org>
Date: Mon, 10 Nov 2025 12:03:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/x86: Correctly handle invalid 0x0f 0xc7 0xxx insns
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>
References: <20251021173152.1695997-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251021173152.1695997-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22c;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22c.google.com
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

On 10/21/25 19:31, Peter Maydell wrote:
> In the decode_group9() function, if we don't recognise the insn as
> one that we should handle, we leave the 'entry' pointer unaltered.
> Because the X86OpEntry struct has a union for the gen and decode
> pointers, this means that the top level code will call decode.e.gen()
> which tries to use the decode function pointer (still set to
> decode_group9) as a gen function pointer.
> 
> This is undefined behaviour, but seems to be mostly harmless in
> practice (we call decode_group9() again with bogus arguments and it
> does nothing).  If you have CFI enabled then it will trip the CFI
> check:
> 
> ../target/i386/tcg/decode-new.c.inc:2862:9: runtime error: control flow integrity check for type 'void (struct DisasContext *, struct X86DecodedInsn *)' failed during indirect function call
> 
> Set *entry to UNKNOWN_OPCODE to provoke the #UD exception, as we do
> in decode_group1A() and decode_group11() for similar situations.
> 
> Thanks to the bug reporter for the clear description and analysis of
> the bug and the simple reproducer.
> 
> Cc: qemu-stable@nongnu.org
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3172
> Fixes: fcd16539ebfe2 ("target/i386: convert CMPXCHG8B/CMPXCHG16B to new decoder")
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Queued.

r~

