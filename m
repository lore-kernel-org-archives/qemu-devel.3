Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F27CBC3ABAA
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 19:33:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uC1ZD-0004ar-Lf; Mon, 05 May 2025 15:33:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uC1ZC-0004aY-OM
 for qemu-devel@nongnu.org; Mon, 05 May 2025 15:33:30 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uC1ZB-00036j-1S
 for qemu-devel@nongnu.org; Mon, 05 May 2025 15:33:30 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-7399838db7fso5036931b3a.0
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 12:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746473607; x=1747078407; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Thi3hvEQxeRKknVgAae96A089ORswGCS9UJ8rEIaeMg=;
 b=CmFalJO+UNleVKNcveHFlRu0DyMDlC4GVYHEj4ErBe//TK5OVCidvVPHVKdeovDTYw
 MVP3HGGXUwmXxAvlynNWknJWo/RfI3qJZxS1Vxary5bQiP7K5D0KTF3f05LpAEF5uVJo
 +d54goQ/q3zikej3LMZG7HTvp4uUf99zyxG2KKR9mfxrhId1L224ar+zp/2cHpvhvWW6
 WLvG1J0pAu9v4oLViYG4SVkb1TAM40GOXsrYiMYdI7f3MSvMxr5Wtf3/BS+OtcwKKzPr
 nImvyO0y36E0RxVWrHtfw879WGFlX5gh5bLIkXznAY8g3iJhutGlAvLLM6M4iGgHeCVw
 XXTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746473607; x=1747078407;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Thi3hvEQxeRKknVgAae96A089ORswGCS9UJ8rEIaeMg=;
 b=EPqs1yqx87PRXogWh4UqE0pFUJmI0vB/5VqVJnOv+kHBPPL6yGZknKgsFAw0pszyBd
 Nle8PwPRDc2G7t5xdlHDFHLroqzyY0Kysh+x/5wjAD9YBZwciY51BglHBDBXNADaE7nY
 QXBW4ZIRCe3t1QKNg/Uxx3A6qOv2I5qw8sTouylnSD6rZ67cE/Py45vW9IkfI6W2Swd7
 TYlipzE8xLZIvTKbm3FxZvei01NN6X+xouqYiXxg12I3Vcql1Uy85QbYj2XuH3l5sAtL
 1OPLqK7UUTrda3dkbeIG2cTVc2a6BMvr60ffciiVsF48Vki7brUDIEG1OmTeQWxr6rXL
 ftog==
X-Gm-Message-State: AOJu0Yz/Me7MQONpkBzQimKF96fT8oKmjPhXrdHyZAUZmwn19iQeCRMw
 yxDgSaorl2XUExqsAdtGusAlXipmTRrieC+mDMYUv9oyTtUL4AuIa2j7WbSiErU=
X-Gm-Gg: ASbGncu1ixdg2dkIcBGbSFSYePyUAdprxYetaAPZM3BQcD6iW9mMOEVgVnLZphVHUyG
 lXe1F5hX+7oh6QX4gldlKNE730xJJeQ6Or5kFC9QZSzX83SF5adKMASf7ggmF9RKQu5ifojk1YP
 GaQ1etlHrzIdO+lUU8kZ18xFeyhC5JAay07ZZrdGH53WTTKZPocryuNT5vQf5qCaz78Nfnl1QhD
 wMRfupaXlMJbZKXY0TemPJCuJvhHcmnbT0N73Nl9O6IJ2HFtBefvBl9JX7MYZBohax0wgar235F
 ecYDfp8z1ECXMl94U3T26JkvQ82e4FmbiTNRRCZV46+2TPO2Tf4Y8AFPaLG3r8LF9W6yDRpNA8j
 gs5FDCXU=
X-Google-Smtp-Source: AGHT+IFpXM9eV/hSpgi4CIx+8V4AcSBzcHBtGqx5a9rMptex5RbJI4j9l+qCZS1eUAqNsAYyMm+8kg==
X-Received: by 2002:aa7:8e42:0:b0:73c:3f2e:5df5 with SMTP id
 d2e1a72fcca58-74090e925c8mr823329b3a.9.1746473606681; 
 Mon, 05 May 2025 12:33:26 -0700 (PDT)
Received: from [192.168.0.4] (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74059021090sm7239922b3a.116.2025.05.05.12.33.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 May 2025 12:33:26 -0700 (PDT)
Message-ID: <9306f5b7-6299-4ee2-8198-ef2c9fba02a8@linaro.org>
Date: Mon, 5 May 2025 12:33:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] target/i386/emulate: stop overloading
 decode->op[N].ptr
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, wei.liu@kernel.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20250502214841.242584-1-pbonzini@redhat.com>
 <20250502214841.242584-3-pbonzini@redhat.com>
 <5d461945-155b-40e8-bab4-502e57d94b03@linaro.org>
 <674de496-b0fb-486b-b74e-f4f856e6d9bc@redhat.com>
 <120a2e48-ded8-400c-bfd5-83b47c8c17fd@linaro.org>
 <CABgObfaNoytDo5RZwoP3r14DHuVvjmscyH72QfvaWjfOn5E4Xw@mail.gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CABgObfaNoytDo5RZwoP3r14DHuVvjmscyH72QfvaWjfOn5E4Xw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
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

On 5/5/25 05:59, Paolo Bonzini wrote:
> On Mon, May 5, 2025 at 12:54 PM Philippe Mathieu-Daudé
> <philmd@linaro.org> wrote:
>>> I don't think target_long/target_ulong is a big blocker towards single-
>>> binary anyway.  The trick is to confine it to target/, making it
>>> essentially a #define.  That is, let target/* include one of two new
>>> headers target_long_32.h and target_long_64.h.  See lore.kernel.org/
>>> r/68b6c799-6407-43cc-aebc-a0ef6b8b64fa@redhat.com as well.
>>
>> Yes, I have this tagged to understand and address. Maybe Pierrick
>> already understood the issue (similar mention from Richard? [1]) and
>> is addressing it, see [2].
> 
> Those are different.  TCGv_vaddr is able to store a *host* pointer,
> i.e.  a host uintptr_t.

No, vaddr is about a guest pointer.

The state of affairs is slightly confusing because once we dropped 64-bit guests from 
32-bit hosts, we subsequently made the simplifying assumption that a host pointer is never 
smaller than a guest pointer.  Thus exec/vaddr.h has typedef uintptr_t vaddr.


>  But target_long/target_ulong are already
> completely absent from tcg/ (there are a couple appearances in
> include/tcg), so I'm proposing to remove them completely and leave
> them as just macros.

The "problem" with target_long in target/arch/ occurs when target/arch/ is built twice, 
e.g. i386 vs x86_64, arm vs aarch64, etc.

We want to build these once.  For the most part this already works, e.g. 
qemu-system-x86_64 running 32-bit cpus just fine.  That relies on the wider value of 
target_long, so we can avoid ambiguity by using a different type.  In this case, if we 
really do want to represent a guest virtual address, then "vaddr" is the best type to use.


r~

