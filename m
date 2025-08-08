Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C437C87FDA
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Aug 2025 18:25:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukRle-0002To-5N; Fri, 08 Aug 2025 14:24:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ukRlc-0002R6-RL
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 14:24:37 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ukRla-0002dr-VJ
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 14:24:36 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-7682560a2f2so2744926b3a.1
 for <qemu-devel@nongnu.org>; Fri, 08 Aug 2025 11:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754677473; x=1755282273; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=iq4zC0LAzpVaQUDoIdxCaKjzxm6+TesC8G8eLvYHTkk=;
 b=UZxZsSPojsr3CMB5nOaZ3vBcYKsY9DeT7wap2wEnBp1s/xcccWGAlLUTqzuqyABLXl
 MYLN1I8vWWvQroszzbuf6wr8OVxwmDUGmJyHakP13EtehJWEGHK+YujHfd0H/VGGB0Lv
 xImvicidDYku3tEQcqSdQDQ7/QRYETnM9WpS65lcTPvP0A0yug1HqMv52NfkRbeXiDUa
 XWRB3ii5jVMM3J0JabG+QULfsVGTCasgOhWYNTe7kmH5aCF0a9SwKAyd/FZlhHy9YJP1
 4KnHOVb4XCsoXYfIIriI5J8yNSnAHt3zztHZP5WXnBRW6YtmjFIVmKwW+X3tgm6QzeWY
 Orlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754677473; x=1755282273;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iq4zC0LAzpVaQUDoIdxCaKjzxm6+TesC8G8eLvYHTkk=;
 b=dZyMAtMUDziBttrfMd7cshoIz6CG6SRTRdG8FERJprm9dIvf5jf31A1jYY4HDYWC/e
 zE4iKRZ4jH9eN7kv/DmInYdyxxsJ17UOe6dYqp+1ayjfTD/W/21qUwIMiWP0vYwJBFmU
 WczxkAX8oTxjmjC+yCvGRd42p8695auWh+B+y8Z0V59/gLgfpNjxSb/SbaqfTNKg26co
 oT0XZr2lLXOUDaKrnekFS5w4pEn5mhGZ+R7jPYtQ6bQu5CwA/VFpwdu68Udf8GZB0jv3
 zK+dzG6UixXMdhUfADPT/YlvBNEPEsOiU1N8sTXtjChZ3FvndscczFo5/JXlmfBABVE+
 1/Qw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVn5upwXyMa7h4FjyD7fGWPjR7xu96Qm+WdlGMM6ZyRu78CF+9Xo9qEH5DIHby4s7MzvboxPLaTauM8@nongnu.org
X-Gm-Message-State: AOJu0YxyFxPY+tSS3XWMlubjeDmCWa+1n3uxbIvh/uFlP5yQ9zZApFLD
 T+zRpyv00kYjhRnsX5FvuTe3WG99CnkFoaYeIj8yvfCdgYJr8l3G9Pi9TZapDqWRhP4=
X-Gm-Gg: ASbGncsQUIwD2uuLiHF39DmY6LbfkIw/cJuEx+jJ75iYHKsBSBRctLdds7UWF1jJlVw
 d+HdT+DgwCgWagwLnNVZBQA/oAwNDiEkm9HR6d8t+NeGAEv9HpImSGpGvwXavE84b4c5it1s6Dy
 W6pZy73nOOOtJUpTiNKpxpgTPhLEyJvmCvFxyrf0nxJMhI6tNMOVRP7MNtuSvTnD9nJ5SsN8Tgf
 tdjfHp45F+fPGh7QrPFiTifaGfM8EiXad708sYyF34nO16We9DA16Q9v2ne8ullnM4Jm9Uv9nrS
 +SYX01RHUB7G+PP/ymFACy4dje6OhEC8bJJ0EthHWhVBXcyGVaDg2YE18CbgfgQLbbLmC8toee0
 yR3xY2pKrfEIf8EY3ingzSKdZ72lyHkQ15Sg=
X-Google-Smtp-Source: AGHT+IE/m+wCV3LTyJRzukTml7kXxYe9YdOEoBgj+ApVKqb+2rwz6nriludAxTIu+gUGKyC2sHJemA==
X-Received: by 2002:a05:6a20:4309:b0:220:1843:3b7b with SMTP id
 adf61e73a8af0-2405551d114mr7246649637.4.1754677472984; 
 Fri, 08 Aug 2025 11:24:32 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b426f0883fasm8990569a12.21.2025.08.08.11.24.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 Aug 2025 11:24:32 -0700 (PDT)
Message-ID: <aa438e3c-f0f8-4978-9b37-bf9d783ec0a8@linaro.org>
Date: Fri, 8 Aug 2025 11:24:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/9] contrib/plugins/uftrace: implement tracing
Content-Language: en-US
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-devel@nongnu.org
Cc: Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud_=C3=A9?= <philmd@linaro.org>,
 rowan Hart <rowanbhart@gmail.com>, Gustavo Romero
 <gustavo.romero@linaro.org>, =?UTF-8?Q?Alex_Benn_=C3=A9_e?=
 <alex.bennee@linaro.org>, Alexandre Iooss <erdnaxe@crans.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20250808020702.410109-1-pierrick.bouvier@linaro.org>
 <20250808020702.410109-5-pierrick.bouvier@linaro.org>
 <t0o4ts.nym46t847yx5@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <t0o4ts.nym46t847yx5@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42b.google.com
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

On 8/8/25 2:11 AM, Manos Pitsidianakis wrote:
> On Fri, 08 Aug 2025 05:06, Pierrick Bouvier <pierrick.bouvier@linaro.org> wrote:
>> We implement tracing, following uftrace format.
>> Trace is flushed every 32 MB, so file operations don't impact
>> performance at runtime.
>>
>> A different trace is generated per cpu, and we ensure they have a unique
>> name, based on vcpu_index, while keeping room for privilege level coming
>> in next commit.
> 
> Suggestion (not a request): put some kind of documentation about the
> format this patch implements, maybe a commit sha & URL to a header file
> from upstream uftrace.
> 

I added a link to uftrace source:
https://github.com/namhyung/uftrace/blob/v0.18/libmcount/record.c#L909

As well, I updated the comment with this URL.

