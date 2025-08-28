Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE77BCA0EFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 17:10:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usOh9-0005mt-8A; Sat, 30 Aug 2025 12:44:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urkso-0007Pk-98
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 18:14:14 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urksl-0006oH-Qc
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 18:14:14 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-7704799d798so1261065b3a.3
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 15:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756419248; x=1757024048; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QleH+kn2l6mkCsEVw1sGTpJNqVermfngu9IR1SevNGU=;
 b=Epu6sBqSGMQaCO7jki4z/ydCWYGewCWfzMp+qLlEIOat0ccA46jd2ZfBrk88LhNMrN
 siGgjcylJK5KiNiTVr4q14QXIJ2oXZYMU/bpMzHzpF+grK/gVg56mpwPh4pMcnIQfebd
 9HL4fGMDp126wlUoWlJGJzczP+kK9MSPDgn5OPCczKOXNsWB66jcDubM7aZcR2579+iW
 gy0wJChMBgwai8dPEKZPGUXN/XZQPe+AXKgy9yfCln9tnLuBUVjA1YvGBEVU8tuYbQmm
 tUuPGbbDb+PStLRCS97An/xHl5QaKQaHENTVNNZxA5o6wmaGpJkqBPqFC6qi4X1cm+4c
 obzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756419248; x=1757024048;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QleH+kn2l6mkCsEVw1sGTpJNqVermfngu9IR1SevNGU=;
 b=TH7WJKNl74ugq/tcJw/GMQOUMgrCw/LtiwGGtJ4ojLMryXWC4yV/xTTJetWsovEe8+
 SYYkJWm92cKRZC11fiQ5ScYQ3HEo5ud+M5/dHZ6p75TiwixC9DjQt0ZCyaCY5kfq1Sar
 xYGc+rVIMfV+QmrBoeXujfTy/eD4S5Ti6PVQnk3ijMlKjMCxXXodjVE/mdBqueTEeNDu
 ynUOBxYg+FJinySB1FaFeOi9cPw0XeIV5mU8ReKq8qQR6tVoblySYF2wlGr1IhjbGUK9
 adFxmBykLjWH502JevMxY6gaM9MPzjWCnurEDKJZKjzjcx+mlS20Rb84ph4ER98Wr6ec
 vcMg==
X-Gm-Message-State: AOJu0YwIlvhfflX2MsVYKl05jjW0uyTc6QfxgxopBxfquz/nJnisBLxm
 rUMJa6hCV6QdKElFTDmiuQCA4I5zrN7WbcAjL26dqzOoy3PuGquGR9T493OZEVokLcs=
X-Gm-Gg: ASbGncuqdatEvtkx4xuG7HA5ARoWC431SS1A6c8q7swdiW9PZxH96Fhz4wlwC+sypwH
 Bj8ErVi/1NfzVr62q2mIOTYMSjBgVdfL5POovNhsyp3YEjoK9yyD7rs6vU0+UOKmlQ3zeEoSiR9
 y1WrQSi3salcQVXkelrxziWrz9Q1aIPNwM+XGGGUmOk1Pz2Zm0OJF3XLEieuXFmG5aEoxjcRa3T
 JKdW0Ws4Saa2QEc6zoDqEfMA2nkjfEiVIT6cA/0DQ/UWSGfjPxgnapWvtjfvpbAPIMtSDiAhb0y
 aPTWXNfgGUsaDC9EOsCGHz4z6mYApYAIoFvtP0uUUZRjAoLeJZ2cuehKzrvtz/llBom4kr3W2up
 JIYPrb1AnCZWo9lWwzuZNw3zIBnuS5S5vFysmCnl9DbkhuLY=
X-Google-Smtp-Source: AGHT+IFHkISrWfT3a05kqLTgzW3P+eDeNhNEE/LXSvi2n+YQeTAIF+B80YfjAzHO7Hf28ua6K1D6rA==
X-Received: by 2002:a05:6a20:7d9f:b0:21f:ee3f:8ad5 with SMTP id
 adf61e73a8af0-24340b27e92mr36319552637.20.1756419248538; 
 Thu, 28 Aug 2025 15:14:08 -0700 (PDT)
Received: from [192.168.0.195] ([144.6.121.55])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b4cd28b37dfsm392165a12.25.2025.08.28.15.14.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Aug 2025 15:14:07 -0700 (PDT)
Message-ID: <fa015de3-3d90-4c2a-9746-0337e53fac89@linaro.org>
Date: Fri, 29 Aug 2025 08:14:02 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 30/87] linux-user/i386: Create target_ptrace.h
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20250828120836.195358-1-richard.henderson@linaro.org>
 <20250828120836.195358-31-richard.henderson@linaro.org>
 <CAFEAcA9AbA4pa9EjOnkmrGMOOC-4nS+FNqni91bfDDkH1wOAbA@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <CAFEAcA9AbA4pa9EjOnkmrGMOOC-4nS+FNqni91bfDDkH1wOAbA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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

On 8/29/25 00:42, Peter Maydell wrote:
> On Thu, 28 Aug 2025 at 13:09, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>> +/*
>> + * Compare linux arch/x86/include/uapi/asm/ptrace.h (struct pt_regs) and
>> + * arch/x86/include/asm/user_32.h (struct user_regs_struct).
>> + * The structure layouts are identical; the user_regs_struct names are better.
>> + */
> 
> Why do you think the user_regs_struct names are better?
> "bx" suggests a 16-bit register, but these are 32-bit, right?

Mostly I really don't like xds etc.

> Commit message should say something about why we're changing
> the types (though clearly here the target-specific types are
> more sensible than the host-specific ones).

Oops, yes.  There are quite a lot of error across the various target_pt_regs structures 
that we never caught because they were never used.


r~

