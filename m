Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4BE8CAC592
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Sep 2025 19:47:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyF8l-0004NP-A9; Mon, 15 Sep 2025 15:45:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uyF8b-0004D8-0x
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 15:45:28 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uyF8W-0003qE-A9
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 15:45:20 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-32df5cae0b1so3323879a91.2
 for <qemu-devel@nongnu.org>; Mon, 15 Sep 2025 12:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1757965507; x=1758570307; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CZjhAiAeVJ43Zq9j+jJhfVnjGNz1MNSHpN2V18BY9Lc=;
 b=im5CUpHLxQ54q8Ek7y409JCEKLxoLcWj0L0R8wb0ydDriMyt6jzGFEj4mc/xBNKXnd
 zPoUXOrbrbdiyYUmzZZImcbAJsAu6gJEoJesbiKwQT4GrhXVS5im6uneauE06oLrX8M0
 rntcKYcEXQcw3FGgPU7z2aa9223vt939yvq8SZpMfiGD8sM/BXvU1JV4yWIf72yAjO4J
 1YjJRNpJVZCilYdizOCDnWrX5Ch6CBp+f+vTp1uzr9t3I3JuKTUXlLlEbdLLn8ZugV+h
 MXiQ+6Lk6cuJqe/wAuK904JYAL7PqE8fMuQHAPP33P+9HKRkGj0/T8ec9ITgG4pIiMC6
 WnYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757965507; x=1758570307;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CZjhAiAeVJ43Zq9j+jJhfVnjGNz1MNSHpN2V18BY9Lc=;
 b=bxZnJasQrM9Jec98lb4b9tQhnWUpNjUjbA8X2+PKTi9vKKSSxofdZRZVX7+ZmaYvBc
 fT5q06aHhom9AARke8IXM6eALdc7eFunr2SGkpFvKCYCH5H8H3jQmZRm74wjva/y54bb
 jHphQ6/CdAYXx99CSulrMP/83hcXG+Cb7SnqUR3aauRjEdcsp8o9NeHTqIm1zH91Ba2S
 Ob5FDZhvH7O11CWQj2b1w6/bcIIqZB65p+mkHs1RaSqyh+Cq6HWle3iXyiWc0D77qcpm
 6MfBsxfa0z1ZhVvbIVReOaHJtpvnmlHY9khDEzDZgyuIYGnEHi2W6bwTwV2kfNQmdlAT
 P1wA==
X-Gm-Message-State: AOJu0YwjE9I4JwvPDcHr2MqRvgvEDfeGie06w3dXtof8/Qbi/pPWXWn4
 jxOxcD3bC2kkZh3IBQy1UeDztyeKQiWnv7sIj/7JodfwrseaTAQ3MAS/hcTYBzhNKes=
X-Gm-Gg: ASbGnctZDTXKtcRTD+RWPfB+Z/hEEfnsNVcGGXHOlbBxzC9ISGpCzVL3d9ACGHNupcO
 F09alBbCchElNEolMxd0pZKxs9Z+tJAryfxCmYKibxF4YjaAtIcN18wKvXCC3eSQgw65s62Ha4l
 i3fSKwvCRGGqJsHbpOSyP3tDxlzIBA3qJ8fLgnGLUlhxonUhVwSdE8ro+Ii778bvGanhvBDBnYf
 w73QFL4MAbNnNG6YwPQiD2nchtZhwE/71kIVJHn879NknCbHGKVa4mgTE+/JAwe2POOp4tyuvit
 tkM52jm6NryCEsdryXKV060ilJfWPgCcc+lL/xulPQ8uXL9c2JIWVCDJ49IiI8cktzFgFzMc6tz
 u6osgZovQIMpXIBBgRbUUyQqqZIjBIsfmtX/YDttJ3QGIE+g=
X-Google-Smtp-Source: AGHT+IGZmoHNFN+hq1ukdEEA9K/NjQLZASrYd5dyC1u8bpW4/otVeeNYcLQkiZuzYXGJEOIMhjD+8w==
X-Received: by 2002:a17:90b:3fc3:b0:32e:27a3:44b4 with SMTP id
 98e67ed59e1d1-32e27a34648mr8410687a91.26.1757965506813; 
 Mon, 15 Sep 2025 12:45:06 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-32dd98b438esm15321766a91.14.2025.09.15.12.45.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Sep 2025 12:45:06 -0700 (PDT)
Message-ID: <b1116aa2-8441-4d2f-bbc4-b1b6b121350e@linaro.org>
Date: Mon, 15 Sep 2025 12:45:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 50/84] target/arm: Expand pstate to 64 bits
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20250830054128.448363-1-richard.henderson@linaro.org>
 <20250830054128.448363-51-richard.henderson@linaro.org>
 <CAFEAcA-DbtHsjPPhRwhbDQ+QZxwSu2Yfs9xacRbFFJVNvm8M=A@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <CAFEAcA-DbtHsjPPhRwhbDQ+QZxwSu2Yfs9xacRbFFJVNvm8M=A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102c.google.com
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

On 9/8/25 08:57, Peter Maydell wrote:
>> +static int get_pstate64_1(QEMUFile *f, void *opaque, size_t size,
>> +                          const VMStateField *field)
> 
> Why the _1 suffix ?

Symbol conflict:

  static const VMStateInfo vmstate_pstate64_1 = {
...
  static const VMStateDescription vmstate_pstate64 = {

The get/set_pstate64_1 symbols are named to match usage.

Naming suggestions welcome.  :-)

> I note that there is actually a defined bit above 32
> in the SPSR_ELx format for exceptions taken from
> AArch32 to AArch64: PPEND, used with FEAT_SEBEP. That
> suggests we should probably at least consider handling
> 64-bit AArch32 "CPSR" values, though FEAT_SEBEP in
> particular may be out of scope for us.
> 
> Incidentally I think we are not correctly migrating
> PSTATE.SS when in AArch32 -- we will migrate the CPSR
> via cpsr_read() / cpsr_write(), but that view doesn't have
> the PSTATE.SS bit in it. Possibly these things could
> be addressed at the same time, so we have a subsection
> for 64-bit pstate/cpsr, and its save/load uses
> cpsr_read_for_spsr_elx() (and a corresponding _write_
> that we don't have yet) when AArch32, and the .needed
> function is "if top 32 bits not all zero, or PSTATE_SS bit
> is set".

Good catch.  I'll have a look at this.


r~

