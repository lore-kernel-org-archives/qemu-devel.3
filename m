Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AA14C282DE
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 18:10:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trha1-0003nt-LD; Mon, 10 Mar 2025 14:10:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1trhZs-0003ln-QT
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 14:10:18 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1trhZq-0001fX-36
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 14:10:12 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-223a7065ff8so10607255ad.0
 for <qemu-devel@nongnu.org>; Mon, 10 Mar 2025 11:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741630208; x=1742235008; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Zvg20SNZGKCL735dTa8NcfaW9bphEgyvvnbYDC+SG6Y=;
 b=xpwImGMASOwGYXu3hORB9ocTC4EjM3c52IqW8ukfxfALN5AysfOpUnkoCEigmMqoL6
 AxwENURJekgKQlD+aG/NqEMcLtTgs4ReWHAknJKFcZCNPMOazpKV0zMc9yDRzhYsmMFu
 aK2G9EPyRwHlEkGjP4p/n6+gPQjLYWhwOV06TJSN3PP4azQvi3UuKu1TwxdfXNnOHWru
 lZcp+yTqXEiC/iZOQIzw42ag8kK5dmNx2cNHq4FWn4zAKtGx17lNZArHix5ZF/Q9hBXA
 ujXW9PR3N9yylbbQe65nJrTk4sXx3nEtBEXXPf3G2t9fTQlq3/1y3txBmfpXYpyNm+i6
 M5sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741630208; x=1742235008;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Zvg20SNZGKCL735dTa8NcfaW9bphEgyvvnbYDC+SG6Y=;
 b=qk53vw8eNZsW8VYyWC449Z8dGFPWccFCiF1OLbsJf4CyGzHf/n+zf5434kc7cUdQKl
 VRZn5JeMw3R7xdqkKp4ktPUCqeUWLc5p8W904TrP16cg6WjyigEVhKOGbTxzk9A/i12a
 veHtLh9beziap1OhoCMrOQFvcqc1tPYFEylr6fqv5tx908X6hDRDueljEAwTWZdNn6fn
 +A1F8sNjq/wZHe6L56ljOjxmMGhwLHrMJwvEPWFvbcK2rFK53O4MZp2qTfIzW2fbj3cD
 p5jgvnpmB8868MnL0LHcBlX1tJD0jrDRT8gN65DiDNKeIELz8D9HZlFsZuNAZVzghMBJ
 XRVw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWfxqj+HQMLsMHPVJ2tpnlihR9KJWd9FTch+DLt/aRl13kIy48xdQQmDOSc6tlGivZFfIz8XsnhcO8O@nongnu.org
X-Gm-Message-State: AOJu0YzUlI3jBw0xi8cEG+dgq85BxmEt81T6AybFZDoFvJVZLS12QnfO
 qW4eJTysX8ewJMnV1IWhBdY2Cx7zV13uTE55ujrI8ynjtVFF482bHY54DFwqhqN0Yqy4yicKd3o
 v
X-Gm-Gg: ASbGncuAJVKkDs5HmRaaNPcDw4ABuVRrp3kkDp+25tsQ5vu3D8N0lpoqnQymCZszVqP
 j12W4ze/xbsR1qhcFPNaLnk+LopQsbB+CsD0afU10yZgWaXfEF2PTEFJxcsC/S5nbXW/B5s6r+R
 ItIjc360KocCkgWsqIWmD/iTT9v/zDNXll9U3IQCw3EEce57s/IsoTgJ/8QOXm7acQIGaTEp0Db
 QDWao+MO8MkgUf4/iu8yxbMStAYYoLfxNK1Nf/e800yGRHP8uVTLNP+VcZqDKXcHlU4CaGXQAdV
 NliaIh0pd7M0VeBZgbLNgWmM4LS0csp1fHqGfBQMIWmwP8PPNBp1h5ZJYFwMqoLFm/ujrXWD5SW
 XyxVFEcfaNum0lu5BL+c=
X-Google-Smtp-Source: AGHT+IEl5foc1wOvSTzz8isV7osGSDHSNslvVEv47u+D6mpnxFcw7582xo64tn8jrLtUNfUOofPEfw==
X-Received: by 2002:a17:903:189:b0:21f:564:80a4 with SMTP id
 d9443c01a7336-22428ab796fmr184366175ad.33.1741630208100; 
 Mon, 10 Mar 2025 11:10:08 -0700 (PDT)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-224109ddfc7sm81416715ad.22.2025.03.10.11.10.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Mar 2025 11:10:07 -0700 (PDT)
Message-ID: <0decdead-5d97-4623-8d3d-22bd8d7c8980@linaro.org>
Date: Mon, 10 Mar 2025 11:10:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/16] system/memory: make compilation unit common
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
References: <20250310045842.2650784-1-pierrick.bouvier@linaro.org>
 <20250310045842.2650784-16-pierrick.bouvier@linaro.org>
 <76b4e445-0676-4982-a2c8-d273c49a9170@linaro.org>
 <2d631838-e8a5-48d9-8235-9a41ffc3381c@linaro.org>
 <76269a95-652a-4064-8f2f-6584b0677191@linaro.org>
 <b411c27f-3f38-4d22-97ff-fa36ae77fb6e@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <b411c27f-3f38-4d22-97ff-fa36ae77fb6e@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

On 3/10/25 11:04, Pierrick Bouvier wrote:
> On 3/10/25 10:58, Richard Henderson wrote:
>> On 3/10/25 10:47, Pierrick Bouvier wrote:
>>>> Maybe better as
>>>>
>>>>        MemOp mop = (target_words_bigendian() ? MO_BE : MO_LE) | size_memop(size);
>>>>        adjust_endianness(mr, &mrfd.data, size_memop(size), mop);
>>>>
>>>
>>> Do you think defining MO_TE as this expression is a good idea?
>>
>> There are not so many references to MO_TE outside target/ or accel/tcg/.
>>
>> Indeed, after this change, the only ones left are in hw/arm/armv7m.c,
>> which (because it's Arm) can be changed to MO_LE.
>>
> 
> I see a bit more than that (17 files):
> hw/arm/armv7m.c
> include/exec/memop.h
> target/arm/tcg/helper-a64.c
> target/arm/tcg/translate.c
> target/hexagon/idef-parser/parser-helpers.c
> target/hppa/translate.c
> target/i386/tcg/emit.c.inc
> target/loongarch/tcg/insn_trans/trans_vec.c.inc
> target/m68k/translate.c
> target/mips/tcg/mips16e_translate.c.inc
> target/riscv/translate.c
> target/rx/translate.c
> target/s390x/tcg/mem_helper.c
> target/s390x/tcg/translate.c
> target/s390x/tcg/translate_vx.c.inc
> target/sparc/ldst_helper.c
> target/sparc/translate.c
> 
> Plus more (22 files) who relies on:
> MO_TE* variants (which relies on MO_TE transitively)

As I said, *outside* target/ and accel/tcg/.

> Thus my proposal to have a first change to MO_TE definition, and eventually do the change 
> later.
> 
> What do you think?

I don't think a change to MO_TE is necessary.


r~

