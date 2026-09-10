Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B005C79F9F
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 19:42:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4keB-0007Ih-6S; Thu, 10 Sep 2026 15:41:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x4kc9-0006i7-5U
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 15:39:26 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x4kbn-00070w-CE
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 15:39:04 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-cbee846deecso268210a12.1
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 12:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789069073; x=1789673873; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=kemQVwMWo+Pmh7khYCCQ7xNNC4nVIU38bFca7y07Vik=;
 b=L+rFK/vqzDmv4+uUQbShUEjunIO2TK+sChuhSL76injF0aCYgWmJ7HVwO1YkEDmyiA
 4pwgLnSZDM7byysQoL+nh1mgtRxHVEhzPGqHAiHUdbt+sCubSOtiqHn2G7zwv4gZdMzo
 zQK1fh7BL76xu7yjz6IekSmBpNyK5Aq7+BWWHeNasVWp3a2VbAZgP//afC39z9x2kPu7
 hE6wDNCYbBPffYIMGTbSc73+b4Zt/pWHX0sCUjU+A0sjIkeGGcQhdJlO6/fi1RV9FLDd
 ZMYWlRZN2cL3zRKLG6Ul4gXhwGG6P7O46FMuqDbzsfM8stMBaDuOEMv21+oWbR6L0bJX
 RibQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789069073; x=1789673873;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kemQVwMWo+Pmh7khYCCQ7xNNC4nVIU38bFca7y07Vik=;
 b=W1WsiKu3VaIyv6zap1uhF9uyBOjv+N7SVB0fbufrB420NHdn+J+cAuozCZ0/CWPh04
 NMuyuV6vQEPshN/V4Y7A/ZhCH34t5SCMPXgWn3pavVcUSEIUshGtZHYQfMrL78vuF+ow
 XMv8oZHc2X/vuYI5qs3Roy15QWE8wWGDgNpCaeznw1ezH7ngs+pxxlFoh008ZMmCWsIl
 P9ntDk745RkJ4lMcVwS29NiVY2T7q/Sf18yBz/6Bib1Mmu2hwWKY1ppMzOutNYunVCPD
 JmqzlZ8VyMBVAPpR2OCPRdiTosJiZgwattxLoiNmKZIk7g+GNfmZqDpGkg3h4BVneKZw
 gD1w==
X-Gm-Message-State: AFuF++nEIRKxRA/kI1cx5k5YP9BWy0hLG+DKXYkhXmIKhUbONLQjsUoi
 yiSyA4ClMBUvQOvZ7vZQps9uPffOsuqOJFhOlmuog5RrztEOav0TnyDvRh5ru6ejTUfPaED8fGL
 vDFTQaco=
X-Gm-Gg: AYBFou04jOgtPOgKoJcNwTBdve9TE2SrL+ecXCKIPJoSvvCVR87J3MU+8uBMv8VArPc
 8AGYMD3sivW2nUC7wx9PowDNaz0cqxspyVZoXUoNFfY1yfCh8kQwrJ+EPOMG8pA0JTucBHrt1WX
 spnSVh4k7uLArPnPspMoWlssOI19oMeJcVWu3hE2x+2JOtM/f8jDnpqLQ06/GONEgdMw/c5ucR4
 BOF6ZB8V5HNAfmYhI+hJ+u4xjW4oIWgtEsAZLgjA8V1He2sTIzdD0EXgqGplATqXVkG+Qk5thKI
 UcepD9SMeqGGwQVPLs8bUiAtWm2K7KUGImT/b+rdZVfjc+ed2A2as1Ad5KRfrzaWJtiW7n7NI0M
 6Rc3RcesVwkiU4MrTeo5zxRT0vgheV4BCBjLQxUf0Z/+pRDxGEhfwr3dyLhM3Yp+SfoeaUHh6n4
 7nM0a28OE0uY9kK8feZTkEit2J4QhxQ6w3YZfgZTC4KOyiexyLUBu7pZcUogry1JB7GiVr/xVdA
 E5YeCFvepK++BYy
X-Received: by 2002:a05:6a20:a120:b0:3d3:ae50:97c7 with SMTP id
 adf61e73a8af0-3daed7dcbedmr574184637.20.1789069073269; 
 Thu, 10 Sep 2026 12:37:53 -0700 (PDT)
Received: from [10.171.0.227] ([98.155.112.169])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33ba4ed295esm270264eec.15.2026.09.10.12.37.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Sep 2026 12:37:52 -0700 (PDT)
Message-ID: <e0769c98-0190-48cf-baf1-e22d6eaf4602@linaro.org>
Date: Thu, 10 Sep 2026 09:37:49 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/6] target/arm: Implement FEAT_IDTE3
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20260806173123.333423-1-richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260806173123.333423-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52c.google.com
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

Ping.  Prerequisites now merged.

r~

On 8/6/26 07:31, Richard Henderson wrote:
> Based-on: 20260806172709.333300-1-richard.henderson@linaro.org
> ("[PATCH v2 0/6] target/arm: Implement FEAT_FGWTE3")
> 
> Changes for v2:
>    - Rebase on the max-v9 split.
>    - Continue to ignore HCR.TID3 in v7 for undefined ID regs.
> 
> r~
> 
> Richard Henderson (6):
>    target/arm: Rename isar_feature_aa64_idst
>    target/arm: Enable writes to SCR_EL3.TID{3,5}
>    target/arm: Implement HCR_EL2.TID3 trap on undefined TID3 registers
>    target/arm: Implement SCR_EL3.TID3
>    target/arm: Implement SCR_EL3.TID5
>    target/arm: Enable FEAT_IDTE3 for -cpu max
> 
>   target/arm/cpregs.h            |  8 ++++++++
>   target/arm/cpu-features.h      |  7 ++++++-
>   target/arm/cpu.h               |  2 ++
>   target/arm/tcg/helper-defs.h   |  1 +
>   target/arm/helper.c            | 37 ++++++++++++++++++++++++++++++----
>   target/arm/tcg/cpu64.c         |  4 ++++
>   target/arm/tcg/op_helper.c     | 23 ++++++++++++++++++++-
>   target/arm/tcg/translate-a64.c | 12 +++++++++--
>   target/arm/tcg/translate.c     | 18 +++++++++++++++++
>   docs/system/arm/emulation.rst  |  1 +
>   10 files changed, 105 insertions(+), 8 deletions(-)
> 


