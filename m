Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAA4AC5516D
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2026 14:30:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpoF5-0001Ca-NX; Fri, 31 Jul 2026 10:29:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wpoF4-0001AT-20
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 10:29:42 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wpoF2-00040z-0S
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 10:29:41 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2cad8076b01so10882645ad.2
 for <qemu-devel@nongnu.org>; Fri, 31 Jul 2026 07:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785508178; x=1786112978; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=E/noXmKlbngrH62CJOPqLkKBMDdAy4WXHVEoX0aD4ek=;
 b=xkUSo/lQld+s7iVlAl7SOdajj27n9eshOigFB8vgsXL7WCvRh6gWTHsJO/70vCq13e
 OOVfENplg5ABnoG6iPOjyogYrnprXxglbzhsJ94HACo2VJrJPn5xfvLZCNYvHNtaOG9e
 QdvORAKtvCsZeabBXVRlAnnZIL2atdzIL9N6hAlIat3WLCkHnqxa8Uru/7TP/9KIOzRG
 lAtR1Y9qQMp43eVMoY4dqWQnxgl1K9PKxAxLHAY89xdtkcezAwuZ5IWaxeO/ZwCTjs12
 nlIEd0AxP6oSH0W3UU8pODEAmKtoV6sjG8DHegZGdLCtCNX6RKtbCig3sL7Ztu4rSsPD
 X1qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785508178; x=1786112978;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=E/noXmKlbngrH62CJOPqLkKBMDdAy4WXHVEoX0aD4ek=;
 b=CcozMMN9ngGMFN79vvSHybCos5ul28K5Ow0xFI/laLoTSzLMzYv60VWgpa59qZxeTu
 lUN48k5HqpGGo8HT4SbBaWJqxPiaYpBJjaVuxcoLgpK4nrdJQfJ6lFMs2W6flawgDIwS
 nH12X+MNtTpJBrteCy06RWesNfcs0XSIIQBTVYnRmr4GgjPT5QdobYNcx5eWWmtO8LXp
 2teMNsVRRZ0Zv9YfXybjw1HU3O+m78S4mvVrxiDkquGmBDG2vcGBnIlzCVwZ22c713qM
 C5MkvLVM9jES21ZQn0/2R2HDHqTX5JnJExR+PXkmFU/PFBfzfi56fqx4zxSXAYXWpTlc
 xOeg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr7N2xfKk48vpk1o/nCGSdhGoNLGHuLw6cFtRTppN1E41uYpchAk+7HcjYywfMzKI9Ca79SDyNOQgWd@nongnu.org
X-Gm-Message-State: AOJu0YzzEue5hkBu1LhqJeZZesCSksbD0WxPln9/i31kMi+mXGxrhEv1
 fKgW19sn0Trg2cPGN/M8FMvSze8XgNQRDI5IPul53/Vk9iVwucatpgqg2ahWLsHeFNw=
X-Gm-Gg: AR+sD12nWuVsNnTeQnClVPKTqKxVXNbXYrqqtigv/r/JcPqwXRRUb50ssqNx/dyuf9H
 IF/I1Iulo5rmpGqFOUp5JZ9pjbb3epD2znz8VzgszchT2nls3fyUhcIkhGBBziCTCBBW3aViY7J
 +c3uwhYZPtT0KzLLC9JnrxKnVL22w2G49EoNMlnpFnkvzPW4ZnCoab0L7mkq4yYl8hEIlHc2yIh
 E2EKGznd3KNcU9Di2GLKTjdhOcdlYc+jxA3KOOd5nsPQUU1xPbD8/+CsTsPehPWYQo4g5JsC59I
 VmYCKgZGBaUgFpb8OsaekgVpmUe9HyeUlFkvuY63O1Xz+fBJPjFt3z/HmmlaTKWHF3pqBq7MXj7
 pw5CvaHi/u/wAoUKAaC24HwuOApqccN7qd7KCpQX4nRBvK7MtFGqFXOMN2sYyEeeoQmWHp956S/
 TCSK3F/rBHAGjlGvTfgUmEJChI8K6P649OvFHVGgL4pr7K1V7MhcyXr0CCuyHeQFO0wk/3Y/dly
 StYWJX3tk7nBbnJ3tW6VYLjQjZ3
X-Received: by 2002:a05:6a20:7293:b0:3c3:6af8:ab24 with SMTP id
 adf61e73a8af0-3c91b375288mr2561768637.56.1785508178576; 
 Fri, 31 Jul 2026 07:29:38 -0700 (PDT)
Received: from [192.168.0.4] (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cbe3963da0asm653988a12.4.2026.07.31.07.29.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 31 Jul 2026 07:29:38 -0700 (PDT)
Message-ID: <0be76aec-54da-4d5c-a92c-0a8520e39e89@linaro.org>
Date: Fri, 31 Jul 2026 07:29:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/11] tcg: Add tcg_gen_revbit{32,64}
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: anjo@rev.ng, qemu-arm@nongnu.org, git@xen0n.name, 17746591750@163.com,
 maobibo@loongson.cn, lixianglai@loongson.cn, philmd@mailo.com,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20260731000503.170446-1-richard.henderson@linaro.org>
 <20260731000503.170446-3-richard.henderson@linaro.org>
 <348faafd-2346-43dd-85d0-4ed7fe965ebb@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <348faafd-2346-43dd-85d0-4ed7fe965ebb@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 7/30/26 23:49, Philippe Mathieu-Daudé wrote:
>> +void tcg_gen_revbit32_i64(TCGv_i64 ret, TCGv_i64 arg, int flags);
>> +void tcg_gen_revbit64_i64(TCGv_i64 ret, TCGv_i64 arg);
> 
> Could the bswap flag be defined once per target?

It is not intended for bswap (or revbit) to have a set interpretation for any target, but 
to be contextually correct for the usage.

For instance, TCG_BSWAP_IZ would generally be only known at the call-site, because of how 
one has prepared the input.  It's usage within s390x follows forced zero-extension:

     C(0xe31f, LRVH,    RXY_a, Z,   0, m2_16u, new, r1_16, rev16, 0)
...
     C(0xe33f, STRVH,   RXY_a, Z,   la2, r1_16u, new, m1_16, rev16, 0)

Annoyingly, s390x should have these memory insns updated to perform the "reversed" 
load/store via MO_BSWAP.

> - output sign-extended (TCG_BSWAP_OS):
> 
>    alpha, hppa, loongarch, m68k, mips, riscv, rx, sh4, tricore
> 
> - output zero-extended (TCG_BSWAP_OZ):
> 
>    arm, avr, hexagon, microblaze, openrisc, ppc, sparc, x86, xtensa

But note that arm uses both OS (aarch32 REVSH) and OZ (aarch64 REV32).


r~

