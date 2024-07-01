Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FDB6C3065B
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 19:52:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sON4N-0004na-Q6; Mon, 01 Jul 2024 15:52:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sON4M-0004lh-0o
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 15:52:10 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sON4E-0004ev-PX
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 15:52:09 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1f64ecb1766so18198315ad.1
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 12:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719863521; x=1720468321; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IcikDyD0Ko7UfeHoZboF5rRMoUwL0EecDLUjgPcY02M=;
 b=F7lhj928+0HieeXPhc5TUo7V54dyG1nzzsvQvqGxNzyDHK8WR7/HQhDOTBC51tt21S
 3ybL6RTcmby2t+8v0c7An9w/s3A5T94TzrnMkmzr1K43IpPTX47VxM3KCiTkPSVveI70
 gGI55sSm5TDG97cpfEtb6A7541mjkrO6U+FpDqwzZeUz03VN656JEmtOzxJMPwpIp8AW
 LpuPWbfqarAZlwntAmB6VO12tkNveR2/0E9XdRnxGdbshqAvEIwe2PU7nW257Ul0SRE8
 AVw1nGWwGw2oUt/t6wCMHWroNUyhssDEOJ9A+MA0iH512LChqBYW1PKiEFu6H+E3e+l3
 tc6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719863521; x=1720468321;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IcikDyD0Ko7UfeHoZboF5rRMoUwL0EecDLUjgPcY02M=;
 b=BcqKbQep8ZHFcvhtN/DGQgWReqBIwWlFUlslP0cyQiflwpDx7ArGtg/hfCMCdOkBa3
 ZyX4qr4Ai3mjBavBPKY7YQGcGmp7GXx/pCmW6myQN+6l4dNKra7bB8eIPswGXMG8goJc
 QeTS5cWTUO7LjDoMFXvAt16+B8KgioOZ5HU0xnRXFj6WqH73CSRFmzTr45KoYGvn441x
 L9r0B6xCmZ2JIJjJ3iE9UK1Slxqa7oHFOrtiOxV0kS1ClDiXrfcpCYgCslOcrxl+k68W
 tm63n2G4kjO8ZitFnELGJg2l2YrU0jiYCDolNaHYwECjzg4IT5iySRsows+LA4iGD+P6
 hSvw==
X-Gm-Message-State: AOJu0YzUsiUpToMUETsOyedMeQ/NwtsGNHhRiiQ/aYhSxupbclpzfzUW
 soUgBiFNn8gNqjedOihtIIu4YiKu9GbePAnZcYY0BuDCEeChnXHNqzjj9HeeISWRusZT5DCAYBq
 I
X-Google-Smtp-Source: AGHT+IEN8TvT/uR64impadubBjAybAouCN+c1bb8Po34+wV4ltpqvKHjKOwbyyDkrizzXwDZmTkGPA==
X-Received: by 2002:a17:90a:e647:b0:2c7:b80f:75f1 with SMTP id
 98e67ed59e1d1-2c93d6eaa1fmr3602660a91.14.1719863521039; 
 Mon, 01 Jul 2024 12:52:01 -0700 (PDT)
Received: from [192.168.0.4] (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c91ce17c26sm7249852a91.6.2024.07.01.12.52.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Jul 2024 12:52:00 -0700 (PDT)
Message-ID: <83b723db-ad25-4c00-b30d-0526f295041f@linaro.org>
Date: Mon, 1 Jul 2024 12:51:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] target/i386: CCOp cleanups
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
References: <20240701025115.1265117-1-richard.henderson@linaro.org>
 <CABgObfYq5Ti6UC7Os9nhyi5XU0VmLvT80rF2tZ4hR9A7cRHjBg@mail.gmail.com>
 <8036cb57-1474-4ff6-bcee-e7c3f7070119@linaro.org>
 <CABgObfb2OOMYQ5ctCUmHpj+AzOyJXNE+TN39+T-h3Xqr4KMssQ@mail.gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CABgObfb2OOMYQ5ctCUmHpj+AzOyJXNE+TN39+T-h3Xqr4KMssQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 7/1/24 12:30, Paolo Bonzini wrote:
> BTW I found an easy way to implement X86_SPECIAL_BitTest without
> crashes (just use cpu_regs[op->n] when computing the displacement
> since you cannot have ah/bh/ch/dh). But I think it will be for 9.2.
> Maybe these patches can wait too?

Certainly.


r~


