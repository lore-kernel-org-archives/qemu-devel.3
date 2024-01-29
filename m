Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7AE7C47DB3
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 22:49:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUaQH-0002da-Hd; Mon, 29 Jan 2024 17:48:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rUaQF-0002cz-Ef
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 17:48:11 -0500
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rUaQB-0005kz-BV
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 17:48:11 -0500
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-5ceb3fe708eso1886413a12.3
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 14:48:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706568485; x=1707173285; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0Jwr6rwK11cTf5xxmEGIzOjgYNqW4oVhNbXojQiD15g=;
 b=to6rpGrqyqpKGDmDMR+KGJhue4hAt9dDefa2VfeAnoRjPjC2TQa+zXglZV5tesPqxz
 5tyN3qCkStBepdXCpLt852HWDWqxIsTGwetNZabsafU40DmKwHK/z/oYFqwTmHCcm1cX
 EK8gh3oy88rjalVwP6m0T8rCFP536MId7CC2+y3NYLCP9G7BrEvBwic3W5NH424wjtDT
 It5B45VIvoD0xWnuFRDymhqorzgpc56UekVRcBAy3x0u53yvj1VT0rbw1mIGhCWT8Qex
 KEF6mtfrPLnxzR5ddNViFAN2vJl/cbeMXvJzmKbY0WnLtP8+OzFOoLqhKYB5tSjTRbdG
 YdHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706568485; x=1707173285;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0Jwr6rwK11cTf5xxmEGIzOjgYNqW4oVhNbXojQiD15g=;
 b=qvGZZGBalQkqHHkCNmQWfs7aS3+DaIYsJzkx6NMM+c49J83nH6g05JBviifnCl6O38
 MnD/KttQoCFBFHEe8YIj5A5UC5FnqcY5aywjgPcIE0GrNrwXIdAjnrhxG39V/H1M9ur0
 oy8cXYzoFjkQj3hDoEJYNNGERMXWtDyqYO1RKnBpaVPiE580CLpSPeZnkFYsElHfZsdg
 mhcI3WDuP7wNWEGGXyuZq/Fq8iBgvm19JTpXG8ZiyTF/7UBFnerpNRUBy8HnTmZxfPR8
 FGPGTDfdIYUsN6H2GeVXm5+LtZZDw8TrbG4ccG98v7jGUgL6c3su/hKbUcrr7BV0+tq8
 ec7w==
X-Gm-Message-State: AOJu0YzgTbwghXZ9Q2hvz0Z3NgBwLmoIRcIchL6kx6zO8lsRf+l2oKij
 H/pkIPbKA0VJKI6fQyyZhMSRmZbLN8jny4DXAef/jatomWs7yxm/er5DMWcapXg=
X-Google-Smtp-Source: AGHT+IFlo4O6DWF8V3uQrSiNv+oND85B/Z2B9W4cPLnrqfo23bPn1IE1TE7XjK4pyXJBM64/wZ5fZA==
X-Received: by 2002:a17:902:dac2:b0:1d8:fb06:b8f2 with SMTP id
 q2-20020a170902dac200b001d8fb06b8f2mr1772038plx.0.1706568485483; 
 Mon, 29 Jan 2024 14:48:05 -0800 (PST)
Received: from [192.168.0.103] ([103.210.27.218])
 by smtp.gmail.com with ESMTPSA id
 w18-20020a170903311200b001d8d3b94404sm2980468plc.137.2024.01.29.14.48.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Jan 2024 14:48:05 -0800 (PST)
Message-ID: <34f79da6-739c-4a64-9598-7d1337cc3be2@linaro.org>
Date: Tue, 30 Jan 2024 08:47:59 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/3] linux-user: Allow gdbstub to ignore page protection
Content-Language: en-US
To: Ilya Leoshkevich <iii@linux.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 David Hildenbrand <david@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-s390x@nongnu.org
References: <20240129093410.3151-1-iii@linux.ibm.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240129093410.3151-1-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x533.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 1/29/24 19:32, Ilya Leoshkevich wrote:
> v3:https://lists.gnu.org/archive/html/qemu-devel/2024-01/msg02907.html
> v3 -> v4: Hide InteractiveConsole behind QEMU_TEST_INTERACTIVE (Alex).
>            Probe /proc/self/mem in the PROT_NONE test.
> 
> v2:https://lists.gnu.org/archive/html/qemu-devel/2024-01/msg01592.html
> v2 -> v3: Add Richard's R-b on [1/3].
>            Fix printing the architecture name and the number of failures
>            in test_gdbstub.py.
>            Patches that need review: [2/3] and [3/3].
> 
> v1:https://lists.gnu.org/archive/html/qemu-devel/2024-01/msg01314.html
> v1 -> v2: Use /proc/self/mem as a fallback. Handle TB invalidation
>            (Richard).
>            Test cross-page accesses.
> 
> RFC:https://lists.gnu.org/archive/html/qemu-devel/2023-12/msg02044.html
> RFC -> v1: Use /proc/self/mem and accept that this will not work
>             without /proc.
>             Factor out a couple functions for gdbstub testing.
>             Add a test.

Thanks, updated tcg-next with this replacement.


r~

