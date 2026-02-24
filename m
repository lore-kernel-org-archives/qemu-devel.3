Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB926F4BB8B
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 21:32:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vv019-000644-Sf; Tue, 24 Feb 2026 16:32:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vv00x-00061G-GP
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 16:32:20 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vv00v-0005f7-II
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 16:32:19 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2ad9f316d68so6216505ad.2
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 13:32:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771968735; x=1772573535; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VdVc/jPBAC5SlysNLIH40TGkdFUx9emiFP4FTzh5d3w=;
 b=dJGj7D+AaqmbuJI4dkxqWQmR8+0q03Mo8s67VMN2CWTlO0vL5OFrqtfF3duCuJ8/64
 NE91hNYAhBerL46W6mbbxhpe5h84szrBZfjAoDkipYvJslWhpKJd8bwHj4P72iw3ZefN
 O0dRC4L9mdC03dtfs4Czkm1n9QMObn+p+L7iK22LFR0C3IDca2qheLgiqYJ/XwdNaFcO
 3JhtY8ASo3p775uqWZpFDrmeZSibycRavUjmvl8a4Rets13OUcg0KYSCpFuSxdot6YQA
 LZTWysxn8E+t/9pwNd/FikKRkjrUDUniN/7OexC/VQvr0U6+p9beTrAC8sdeNG1/o/Bc
 RQVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771968735; x=1772573535;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VdVc/jPBAC5SlysNLIH40TGkdFUx9emiFP4FTzh5d3w=;
 b=cxsVgWsnX5BKLtY5C2Xgevop6SXQo6AsyXm/qH4CwF/QEytueawxkU9der02abdT7s
 HOqSgVSMX7KH/WF5n7sSKF9ey044aQ8BTGO36ecsi7uIoqJ4PO9l2h/6HXhK7NU2w5cE
 5rCMiw+7w5dKm+XavQ334oDvajArI6WefLzKahWsMFzsg/ia/SMwH8mTzujJyKuLh9d8
 pyge+ewu755rvSzHlyEW52gCvjIed5ljoaDRqWQL55HK1vxXCD8jKRpz91WxS2fUhjxM
 3p4plh2zt5FVcVUgM+M0P5VIEDyGuhrzeWeNY2PqBBSimCbY41WhCw7EAzxXoYIpNSga
 a44Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXvU+x8kgJ9Fg3plil/6EcGiDPlNsP4XTs2YD9CYniCRzY33cd3Bc8Y0FFX9kBxnBuMET+ybYFiLyDI@nongnu.org
X-Gm-Message-State: AOJu0Yx/NOhrFYWKIiTQNbVx8w4AWcLxMTUvk9zFXlCKpXXgYdnTqvpU
 diqmDaYR4SSTgTBMT93WanQ8nS0NdZoY5YRGO07GsW3Pv16Syg1NOYT7yeyxBHQxjG4=
X-Gm-Gg: ATEYQzymYhODNTbmUyCxlySLLpgEB+syOBeeFnvuKgSEh8/GWTE5dtTu2C3akBe6J7G
 n3V5u2piS5Rr5h/zIikA0Kz6dYN+A1RVnyw2/Xx5Z+ZHM8oF5X7RWBGDUtNHJhUbAjIbde8SXJG
 BHfDj8P8W+GVj4uN0HONs183NaHlHolS2wWIU7lQruWVHxnW69N51Vky0Q/8njuGzSnllOyL2Fj
 uVzoq9iQ5DzxaQOQHiV632IicKOBa5Ky0dl0QdqWPd75jX33VC+u77ecweHO2ruJGXE7vSmQfuZ
 dznqFkZYPhxnMSZvLfsvU2RAoJglr4az5BFg7tafB5veEy9qYzY49XcCAbpro5dnCXZT/NdYkry
 IgvY31mgK3lDww1xBW/QtG0djbVzljRSy3OVELISNPAajtBIlbWd//5qXtzImMY2OxGt/OT9e6K
 RY0jjWCB9CFnB6imWHFnFrXgiGYeWdmOqJjiQoZDX61dVv7GSvODS/XJs+eXykMFOBunfW
X-Received: by 2002:a17:903:2f8c:b0:2a9:451b:422 with SMTP id
 d9443c01a7336-2ad74439669mr117654705ad.14.1771968735296; 
 Tue, 24 Feb 2026 13:32:15 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ad74f637easm112817875ad.37.2026.02.24.13.32.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Feb 2026 13:32:14 -0800 (PST)
Message-ID: <2a5a9e47-08d8-4719-987c-7f872ffeccb0@linaro.org>
Date: Tue, 24 Feb 2026 13:32:14 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/5] target/tcg: Rename some helpers common to various
 targets
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 qemu-riscv@nongnu.org, qemu-ppc@nongnu.org
References: <20260224193028.2370-1-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260224193028.2370-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62d.google.com
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

On 2/24/26 11:30 AM, Philippe Mathieu-Daudé wrote:
> TCG helpers are declared using the DEF_HELPER*() macros
> which imply global symbol scope. Unfortunately when building
> a single binary (containing multiple TCG 'target' frontends)
> these symbols clash.
> 
> This series takes the dumbest approach, renaming the symbols.
> 
> There are still around 20 symbol clashes (usually FPU helpers),
> but this series is good for my proof-of-concept.
> 
> Philippe Mathieu-Daudé (5):
>    target/tcg: Rename bitswap() helpers
>    target/tcg: Rename crc32*() helpers
>    target/tcg: Rename unaligned_access() helpers
>    target/tcg: Rename raise_exception() helpers
>    target/tcg: Rename set_rounding_mode() helpers
> 
>   target/arm/tcg/helper-a64-defs.h                 |  2 +-
>   target/arm/tcg/helper-defs.h                     |  4 ++--
>   target/hexagon/gen_tcg.h                         |  2 +-
>   target/hexagon/helper.h                          |  2 +-
>   target/i386/helper.h                             |  2 +-
>   target/i386/ops_sse.h                            |  2 +-
>   target/loongarch/tcg/helper.h                    |  8 ++++----
>   target/m68k/helper.h                             |  2 +-
>   target/microblaze/helper.h                       |  4 ++--
>   target/mips/helper.h                             |  6 +++---
>   target/ppc/helper.h                              |  2 +-
>   target/riscv/helper.h                            |  2 +-
>   target/sparc/helper.h                            |  2 +-
>   target/i386/tcg/ops_sse_header.h.inc             |  2 +-
>   target/arm/tcg/arith_helper.c                    |  4 ++--
>   target/arm/tcg/helper-a64.c                      |  4 ++--
>   target/arm/tcg/translate-a64.c                   |  4 ++--
>   target/arm/tcg/translate.c                       |  4 ++--
>   target/hexagon/op_helper.c                       |  2 +-
>   target/hexagon/translate.c                       |  2 +-
>   target/i386/tcg/excp_helper.c                    |  2 +-
>   target/i386/tcg/translate.c                      |  2 +-
>   target/loongarch/tcg/fpu_helper.c                |  2 +-
>   target/loongarch/tcg/op_helper.c                 |  6 +++---
>   target/m68k/op_helper.c                          |  2 +-
>   target/m68k/translate.c                          |  2 +-
>   target/microblaze/helper.c                       |  2 +-
>   target/microblaze/op_helper.c                    |  2 +-
>   target/microblaze/translate.c                    |  4 ++--
>   target/mips/tcg/op_helper.c                      |  6 +++---
>   target/mips/tcg/translate.c                      |  6 +++---
>   target/ppc/tcg-excp_helper.c                     |  2 +-
>   target/ppc/translate.c                           |  6 +++---
>   target/riscv/fpu_helper.c                        |  2 +-
>   target/riscv/translate.c                         |  2 +-
>   target/sparc/helper.c                            |  2 +-
>   target/sparc/translate.c                         |  6 +++---
>   target/i386/tcg/emit.c.inc                       |  2 +-
>   target/loongarch/tcg/insn_trans/trans_bit.c.inc  |  4 ++--
>   .../loongarch/tcg/insn_trans/trans_extra.c.inc   | 16 ++++++++--------
>   target/loongarch/tcg/insn_trans/trans_fmov.c.inc |  2 +-
>   41 files changed, 71 insertions(+), 71 deletions(-)
> 

It seems to be the best and easiest way to deal with it.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

