Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B806C2D0CD
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 13:30:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uH0Ye-0000Z2-Mk; Mon, 19 May 2025 09:29:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1uH0Yc-0000Yn-SF
 for qemu-devel@nongnu.org; Mon, 19 May 2025 09:29:30 -0400
Received: from mail-vs1-xe30.google.com ([2607:f8b0:4864:20::e30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1uH0Yb-00069W-10
 for qemu-devel@nongnu.org; Mon, 19 May 2025 09:29:30 -0400
Received: by mail-vs1-xe30.google.com with SMTP id
 ada2fe7eead31-4e150f1ba9aso1677134137.2
 for <qemu-devel@nongnu.org>; Mon, 19 May 2025 06:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1747661367; x=1748266167; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jB03WAm88rZi0gMmTdcZJlDteAih2spbKdHkhIS+dsE=;
 b=Yo43gppweAbivR7cZLj8Zc4fOO6EvHQYNkjhYT0DDuZhYggFq5Cr67FbD5VxiJ45lb
 b6mOu1wYrxnK2n7L7sHXeco7zgH4hPYq2IXB3x0TCRIDcJE/NYkBsEKOZD8UcyuBu6gp
 wzlhqzfnToUIQk3ep6/y9ojZl/AeB24vwRDJYYHPtjcSqh5Eyfuf+JiyzkpVMAE0Qivj
 4Leuq2K+y/VbhK87u8jwbEl0mSR8gjuAI3jGP5CA5HHwjmSsyjyJaqAcuT1Xga1DQQlo
 NMqgGxiSj868t1jwAxixcKh1ZfBufXdbi3ix9aDNz+oWDDfygbYUgDopCtk+sNpkSP1W
 Fo0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747661367; x=1748266167;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jB03WAm88rZi0gMmTdcZJlDteAih2spbKdHkhIS+dsE=;
 b=HRaqRT6Men1b4RF218JsE9v91wHcs7UHRgeMVQ1g6X7CrIKXU+xOQTYrKmY3LEWefU
 ZaZAlMwBFUSn1YBQ0DVshK1d3SmAfZXzzY3xMPmYD+GHUe5seC8iGjQ5h1Rs2OusgwNO
 G8/ELRwZzTPPoIjBmuq25nJVOdw0n9dKxhoPTMGxr0/gDD6H2ZUtqnCZyB/i+MyaMG2H
 S4Ej6Tb6cbLqdoA1NrYcDmOcm2GDyKSQvvs72zPulnP3K+oCQP73zsecZu7gV13+kL9J
 /Fo/E7QgeDbo8yt5/3yi4SxrZAZgwas+bt5AhShY3cKHx9Hm5HiAa/ZRoQ7UcNPe4CDt
 E9xQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXpRMTt0VIGsjV1+roCKjZc0yToEy2N0Fn5bzPTveSfAhn7tfavUWTuOeQEIJ6PP+PY7jEK7xRGOKd4@nongnu.org
X-Gm-Message-State: AOJu0Yw5O6WaxVUsweuIXdEiQRrRZ3pIGXGuLdTMGn0vWN2EoCAYJgmf
 QE/WB67Owog0kbwJzIMeWwKtsm3mkrXv8u05OrhwH8QNqbqqZQr7HsW2CML1imCTwUat+dae+DB
 lyxOC
X-Gm-Gg: ASbGncubuGFUfKjiKu/2YabOVdcTj7P1w2xdqADbb/tdUquRfRgcm3yxTSC9WRMpPSh
 z8TefZqp5HUUOdpaToLJQCBToOjEUymb8wLrraa5jW91VtIlor9HmjJ/oKjMUSDIevqTG+oEo3X
 P6hWmihsM8s/MfBVY1rth3KJCXtBsrmRwJvymVCNGVuf00eLwFAmkLM9Y9ML9vBIhBegPVBUSsp
 SgTqlKsVJMX/ai3E5wb9GzRu+ti0adjSR5ENSOR43aIY3GXuh/E2b81+PxCF+fvK40+0vpyXkF0
 u9xLamPiLLqsBdvi0OVBlDV2aIEThITqLC3qylUEvWgyIkKhEywfkh7IfoyQhu8mWMM=
X-Google-Smtp-Source: AGHT+IEZ3LIjIZK8tNY89dckeF8YL4rFSAHcKlUPRvF1rczEn2qj8e9KVZO2lpX6xsCyJD/HbWjqcA==
X-Received: by 2002:a05:6102:358c:b0:4e2:900d:aff7 with SMTP id
 ada2fe7eead31-4e2900db70dmr2757236137.21.1747661367207; 
 Mon, 19 May 2025 06:29:27 -0700 (PDT)
Received: from [192.168.68.110] ([152.250.131.100])
 by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-87bec1efb29sm5804848241.25.2025.05.19.06.29.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 May 2025 06:29:26 -0700 (PDT)
Message-ID: <c4d7883c-fc50-4b23-bf89-2d9ee7c7ca6a@ventanamicro.com>
Date: Mon, 19 May 2025 10:29:23 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] target: riscv: Fix satp mode initialization based on
 profile
To: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 Alexandre Ghiti <alexghiti@rivosinc.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liwei1518@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
References: <20250516122319.4100121-1-alexghiti@rivosinc.com>
 <87y0usiz22.fsf@all.your.base.are.belong.to.us>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <87y0usiz22.fsf@all.your.base.are.belong.to.us>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::e30;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-vs1-xe30.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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



On 5/19/25 9:07 AM, Björn Töpel wrote:
> Alexandre Ghiti <alexghiti@rivosinc.com> writes:
> 
>> The satp mode is set using the svXX properties, but that actually
>> restricts the satp mode to the minimum required by the profile and
>> prevents the use of higher satp modes.
>>
>> Fix this by not setting any svXX property and allow all satp mode to be
>> supported.
> 
> I figured I'll add some more findings.
> 
> The RISC-V profile initialization seems a bit brittle; Without Alex' fix
> we're getting different supported satp on the first hart (0) than the
> other harts; Hart 0 has sv57, whereas the other harts has enforced sv39.
> This caused the smp bringup on Linux to fail.
> 
> Some observations on, e.g., a
> "rv64,b=on,zbc=off,v=true,vlen=256,elen=64,sscofpmf=on,svade=on,svinval=on,svnapot=on,svpbmt=on,zcb=on,zcmop=on,zfhmin=on,zicond=on,zimop=on,zkt=on,zvbb=on,zvfhmin=on,zvkt=on,zkr=on"
> 8 hart machine:
> 
> When realizing the cpus, the first cpu calls riscv_cpu_add_profiles()
> all profiles are disabled, whereas for the other cpu calls to
> riscv_cpu_add_profiles() have some profiles enabled. Having some
> profiles enabled, will issue a call to cpu_set_profile() that will
> enforce the satp code that Alex removes in this patch.
> 
> The riscv_cpu_validate_profile() function is called after
> riscv_cpu_add_profiles(), which explains why the harts subsequent the
> first one will get the cpu_set_profile() call. The first hart will not
> have cpu_set_profile() called.
> 
> IOW, there are more issues hiding here, in addition to Alex' fix.

There is. I'll send a fix shortly. Thanks for letting us know!


Daniel

> 
> 
> Björn


