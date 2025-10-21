Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 561BECCD1A5
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 19:57:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBITu-0002dQ-Dh; Tue, 21 Oct 2025 15:57:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vBITl-0002cK-3a
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 15:57:09 -0400
Received: from mail-ot1-x330.google.com ([2607:f8b0:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vBITj-0008Ed-5s
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 15:57:08 -0400
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-7c2766675adso3647709a34.1
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 12:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761076625; x=1761681425; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=AjyONCkRbAa4eIFLOL0u6R/QoJrD/nuI/ZLrBKUnC/Q=;
 b=eYnBRgzvAlzM+58H72fenA5cVs7FP5WaPRyrz5HCfZQlcSlWaDEdkfKa/RcyTaPYji
 cRcwU+Ov7OS4HXlnLVbb/AkdNyMd4JZe+R+EHk8fOPvrbJvN9h90yXANfP5Cz78MZsue
 bX4KDvTtqYKhb2IJcX3LKDzPtTeJJJpz6L595ixY98cwBdwmkg7Y/EQfBC1FeOJR29Lg
 VVC4M1f0CjlVOXQTyv4hGd8WAJeFOtWY9iwhfAMOiw7agawCdnhIMpIAl9uwlSPBvucc
 gHSlUVyNb+uYWT/kOw//q2mQCt6Wg10KeDJSdYBSCJz4mn8q8QbsF1Ft0qKQXlpXeQU2
 QF9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761076625; x=1761681425;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AjyONCkRbAa4eIFLOL0u6R/QoJrD/nuI/ZLrBKUnC/Q=;
 b=vNZfHNSHAYs574hEFoRo85nZqvvf8gQi9eE1g5bm2HJb9soDRGeeT1d0xbyTjGTeCx
 +I0KCr8zwt87GWNchC6ka40EHGnRLbFW12H6iwFBYP/hWPbJaqW9zuhJ7aTwlptuKhTz
 xayrdRfR1fKeXGeda/PJh/xXj0f0hIHPOF5hX4pJSx/E+WhuL41mtqgc72EANBNL1DqF
 NVm/5IAtpHR1FYMSmO878MONywH5oryidtGF4desk+aPhdv4Kk3QVyYu/E93rgyLdaJc
 sjQ3DK9gWZtMxbWc8p7AaKwqNxG1B4C9pp4bFMDITMVldYPbE3OgBYzR9gAlWVSQFnEa
 nwEw==
X-Gm-Message-State: AOJu0Yxtdqd/2JPUcP592lWFHobeBf1ISAPsO2v+rD9FH8hg00GLDeVG
 vgYlCVVKgPa4RTNq49Elt5nl9+kfuwuXF2mKBPGTUcl7t7pNBmh3bKPsW8H+PJ2Ns8r+AyOWLPK
 vcmlD
X-Gm-Gg: ASbGncuhmtUyMoQr3SZQjKT2ksEUoNg0Rr0vxaDbjtk1nwtqXndi1mFdqKTZ1BJxfbt
 42vD8Q8aTyPFJRn69caJsBcgUC+2yv30QcanrpokzvypeWy8Ldn34xEy6fFoGuDHcSypx8OEUvy
 YhzayVtCU7IfHwNck1X7YyGu1yxwOU1lVZXZxQAjYE9FmN0e/TQ3sEYEbhdaeiVlWhFNDIayGH8
 2hoiu5+J4RECoDc/zlSMWdrB/v6i/MyPkywKQ0EUED7gYCIAam7kR1zmoEQM9xmfi9VM8Rda+5N
 dAy1iEb/rOl68dbYD1v8X2cT1AjbBMZstomkALPy2RQyIKQZRmJcfY0wI+dUd58lrzhoohQPxMr
 9t2w/Y2PcmbO8oGE+91e74LRhxxSG4QJxZWo4RUgp3F7p3qy3vLvAxGp5sz1g97Cu9/tmOsgThX
 tQ6dZuQZef1Hq6BsgmTPpAsWEIR4Av11cgULt3IHz5Onr5n3ZlVgJbNJkyiCzuq4G22TawPw==
X-Google-Smtp-Source: AGHT+IHGHwHCabKDrkxEjif0h1GNnPcI+KAkNvQgsB9fy2YwAZ8bMxKjkXVS5FvI1sFny8eZBoP4EA==
X-Received: by 2002:a05:6808:6902:b0:441:d7c3:e4f0 with SMTP id
 5614622812f47-443a2ecf367mr7784957b6e.9.1761076625623; 
 Tue, 21 Oct 2025 12:57:05 -0700 (PDT)
Received: from [10.128.41.227] (c-174-170-192-123.hsd1.tx.comcast.net.
 [174.170.192.123]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-651d3f3d553sm3037750eaf.17.2025.10.21.12.57.05
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Oct 2025 12:57:05 -0700 (PDT)
Message-ID: <bc074822-a6bd-4cd0-8679-fbc68600bf15@linaro.org>
Date: Tue, 21 Oct 2025 14:57:03 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] linux-user: fix reserved_va page leak in do_munmap
To: qemu-devel@nongnu.org
References: <20251011200337.30258-1-mlugg@mlugg.co.uk>
 <20251011200337.30258-4-mlugg@mlugg.co.uk>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251011200337.30258-4-mlugg@mlugg.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::330;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x330.google.com
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

On 10/11/25 15:03, Matthew Lugg wrote:
> The previous logic here had an off-by-one error: assuming 4k pages on
> host and guest, if `len == 4097` (indicating to unmap 2 pages), then
> `last = start + 4096`, so `real_last = start + 4095`, so ultimately
> `real_len = 4096`. I do not believe this could cause any observable bugs
> in guests, because `target_munmap` page-aligns the length it passes in.
> However, calls to this function in `target_mremap` do not page-align the
> length, so those calls could "drop" pages, leading to a part of the
> reserved region becoming unmapped. At worst, a host allocation could get
> mapped into that hole, then clobbered by a new guest mapping.
> 
> A simple fix didn't feel ideal here, because I think this function was
> not written as well as it could be. Instead, the logic is simpler if we
> use `end = start + len` instead of `last = start + len - 1` (overflow
> does not cause any problem here), and use offsets in the loops (avoiding
> overflows since the offset is never larger than the host page size).

No, it is not simpler with 'end', because end == 0 is 'valid' in the sense that the range 
goes from [start, (abi_ptr)-1].  But having end <= start is awkward in the extreme.

Thus we prefer the inclusive range [start, last] to the exclusive range [start, end).

Not everything has been converted away from 'end', but we certainly should not regress 
existing code.


r~

