Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 680DECD342F
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 09:47:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLHnu-00025e-DL; Fri, 08 May 2026 05:47:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wLHno-00025N-Qc
 for qemu-devel@nongnu.org; Fri, 08 May 2026 05:47:24 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wLHnn-00070P-5u
 for qemu-devel@nongnu.org; Fri, 08 May 2026 05:47:24 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-488a8ca4aadso16439235e9.3
 for <qemu-devel@nongnu.org>; Fri, 08 May 2026 02:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778233641; x=1778838441; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IFvnflVxCTZSb2ldonAjHdAKMR5oDg0jq6gIHVjFDok=;
 b=qnc5cTOj/FRMuAJB8TmRCdqrL4yJzMfWwv6+75m0xMYaUmvQNCBnsjG0VKkSNSNlc1
 K1SNFpiPU+7JM9lw+nqZ4k9xLSOMxrDJb30Hq2WR3C834xsaAlQlDzNX3sw6Xa32xZ0w
 I/smpiRPHqmFUNOQ2v3fC/VdeMxpIDWHhcHGhSWaOz5M/AplYRaOU5ROzNfO1Y2sIHUL
 J7W6RpI0lQQ+Qk5cJzTRovsCEKlRjPrQGqZFYXV8yfWXnBLD0ruNlM774I6JYLuaN+A6
 FY/PCIObr2bJpTHXqB0MAmQoA7Kjl+a/BfpshbEcYVJoXk8rAlIsXJbdPsaY9ij3yxye
 Msjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778233641; x=1778838441;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IFvnflVxCTZSb2ldonAjHdAKMR5oDg0jq6gIHVjFDok=;
 b=jFTotVBc5T0mO2QVPWfRFx3VMuTh2y9e36v30VEUMB8isjig0GAAw3rp4awNycWLdk
 oADS8FzVzC2JXmzVfoikzDzENvtMydjTH41x3W7b1IumqlqCSNkBDz4wGhguZrmbRmaU
 eAJhgER3e4htrpIlYykJ1tXB33lNnXr52m89wsxRuFZ0HXLWon+b5emMecRqV+tHAM+C
 rLWpGqQejpFooFpyTku0/iiXaNGv/jh/ddWnDRfEVewjg8ZHg+hDqUNPHGKxC44KRS1H
 KwxG0/HIvmdrOI02Qtf8O9G2xHECz5cf6Ag3nkwLsw0y2ZePuh92yh1ChbTTMkY1tZyU
 ygYg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+UIyOvU73HH6Hupik4b/N7EC4FIrfhCIcvy1WAgWtT63xf3feR18Oq9hKDqfP9ht678skKVbm3nVmE@nongnu.org
X-Gm-Message-State: AOJu0Yx0bf4ncIcVVHZvdC+ejEvSpgYaCZHexDMwM2hkVc3sVSe023C2
 BkEzEdsGu/SY7RB0fCtFzchQcZVEhEHk3M0QLQFzKddzYyFeGzs6lGahkVmmTYwaIkk=
X-Gm-Gg: AeBDiesYSikrZQMYi8oMQwTeQBdPBlpxy0iF804WQT+aS5PgQZfgdixwdFJIxJPSQyo
 NxLI+vuxh6dHGzHjTDX5n0EUi3VGgSijvkduISfL8ex39WoYFXLqqnCO9THn0QCeTU9k5vpvx0+
 5DDWbpt0NekkC4ahaeeaFoZUQQvAC1iv8c+YY1D+C5IhVSMNpa7o8c5LT+RxkaKDOblXrtDZKii
 N5s/Ln4MvhjCDcOXYvmKiWVIsol/TprY7jEgA5W98bfXgZVp5SCLkuGO33qF1WrwaP0ZnizmHDP
 CT84qcnYIfe0VdA3rie+8kngkFlCndew4iGm5/g9DK562mKrBs6/bYtlJ7mmaq7AQ5A2AotTnh0
 tJyq9Dp3dnX78sKdeey+5SEGg3EHcOmxRpghkzkz0brMJEtaDSDPumLgCXT9Vn8zpl6y45P6jVT
 EOX5hOeVqZMlbCXuVbUW25439pORVtKRy57zo+0R6XBxBWnkAe0H+oBevCPVruxkEw
X-Received: by 2002:a05:600c:8585:b0:487:2439:b7be with SMTP id
 5b1f17b1804b1-48e51e0b5c1mr151411575e9.6.1778233641133; 
 Fri, 08 May 2026 02:47:21 -0700 (PDT)
Received: from [192.168.0.200] (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e68ed0f4csm46608315e9.3.2026.05.08.02.47.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 May 2026 02:47:20 -0700 (PDT)
Message-ID: <54424100-ba06-46aa-a73d-89aa507b3469@linaro.org>
Date: Fri, 8 May 2026 11:47:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/18] fpu: Use {get,set}_float_rounding_mode everywhere
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20260507221717.486023-1-richard.henderson@linaro.org>
 <20260507221717.486023-6-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260507221717.486023-6-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

On 8/5/26 00:17, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/i386/ops_sse.h         |  24 ++---
>   fpu/softfloat.c               |  88 +++++++++---------
>   target/alpha/fpu_helper.c     |   2 +-
>   target/arm/tcg/vfp_helper.c   |   8 +-
>   target/hexagon/fma_emu.c      |   6 +-
>   target/i386/tcg/fpu_helper.c  |  28 +++---
>   target/m68k/softfloat.c       | 170 +++++++++++++++++-----------------
>   target/ppc/fpu_helper.c       |  14 +--
>   target/riscv/vector_helper.c  |   6 +-
>   target/s390x/tcg/fpu_helper.c |   4 +-
>   tests/fp/fp-bench.c           |   2 +-
>   tests/fp/fp-test.c            |   2 +-
>   fpu/softfloat-parts.c.inc     |   8 +-
>   tests/fp/wrap.c.inc           |  12 +--
>   14 files changed, 185 insertions(+), 189 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

