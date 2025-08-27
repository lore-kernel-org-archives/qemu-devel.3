Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8FDECA0EFF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 07:26:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urAY3-00028g-UT; Wed, 27 Aug 2025 03:26:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urAY1-000285-5y
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 03:26:21 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urAXx-0005m9-Li
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 03:26:20 -0400
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-b49db86cac4so2304112a12.3
 for <qemu-devel@nongnu.org>; Wed, 27 Aug 2025 00:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756279572; x=1756884372; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u2PgnzgcrQIHYwJRkXQXAStz7p9xGch6ymdHN0sOVds=;
 b=teVQJu/m3+XOR56vVWC9z0hB//VsxjEOSfJC9jgkVlbVkJ4v9J0mXhiNvMiRRHGRqx
 gKzBsGCU1EBI7moofY/ouqsKFxfpKswyjgAJR+usj7A7R8scLjadV49KZ1ZdyTiEer+R
 FrALsPtF81io7AWb4LFeLMt5ICfHahwEfemjavjTl7DXydegd0t3oRgIWWByixsteRJ/
 598XeQrFZDCMNMp6LuPgJ5IsovsAHrT1Cw4HibtwBxCfoBCXexZyP+C2ba+n++sYulL9
 YnKMhkrwA5cMEswVl0MHXV1P5TsW6nT0WZUKH/WSCWXoUA1u65+tMqOUr8WqIP1VvMgv
 rMJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756279572; x=1756884372;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=u2PgnzgcrQIHYwJRkXQXAStz7p9xGch6ymdHN0sOVds=;
 b=bDvtPFDpBGg9ldO4sYG74cfLD09y/IhxTeDOPKuxd4YIhgdVBZFkownXbdjCNc79Bd
 ha7m+kOdEJjBrrLMaKcY2whGJmX4D54WPjqkWFX69dMX0yysqgXbajkO6Iv1ZjSWp25A
 LT13J9K04Y2nHczlMeXg2QXbKcorXnFWJvCHi8AnrFWsyn3V6lPHweSH8XRrqiUst88L
 AwmL1Bqit+CZ6J/UcGgVcefPbbET65Qrn6X9x/BwrtYP9/WD6yrm6JWoK35zhKqMBQJg
 o87Y5Kk00NuTFg+Rhn2YvHeLFzBiTbco5A55ksdzg/EjMg5uguwCTbtERuSS55uJg+Du
 poew==
X-Gm-Message-State: AOJu0Yx2d9AS8OQP1DZvLOhu+VBZo/CYL2reDqasIrMjPHdENrFgZ0vx
 tN7VrZG4XhXX55uc4ycN8rSBRlkHFmD5KT79SE9YFXyLgKeW11or8itJSw5gHIvOeKTknCIqETn
 MKeyU4JU=
X-Gm-Gg: ASbGnctT5Y6oYTUJTx42leHS8CVRHUgxCkSIRQKyvqwtk/PYdHg17B78XB9o8osDafO
 vS9x2JwEKeg7zeOGIFqZdkDqIumEz0Dk7D1OYn5MFRhONC/lJRttE1jOwYBK5UYlZZn7PNGqN2K
 OC6XLaIj7V31lM+b/9LHFrh0KkODM/S7QDCbd/tj5eoze1i940lm9NJb2aSAOKsD+hImF7Z41yj
 kss4q97CIadrEM6HyyWT8avW9ICFYXrceHGm4oKGPtjN3JdXVSRXIVJbkeXIj9obc75yi5y5w0N
 LK1622NQyI/qaq1fV4Kij5ANhNYLSDvdYjXQQo6oGeILdKjtzXskcK9PyBt6efNgOdhpj/JbqvB
 Pb4AunDpwkntdXK82f+QzCfUAfidMpVr7JYTc++a+zLNTZenia1cbtqp/Eg==
X-Google-Smtp-Source: AGHT+IFEXyIydPGKdP5WMGLfiSQy39azEwytTEP3Kmt85+2EDc/sJL/m120IGLEiK75qKUC5btbRqA==
X-Received: by 2002:a17:902:d603:b0:246:a42b:a31d with SMTP id
 d9443c01a7336-246a42ba453mr165068045ad.44.1756279572565; 
 Wed, 27 Aug 2025 00:26:12 -0700 (PDT)
Received: from [192.168.0.195] ([144.6.121.55])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2488bfee83asm18334655ad.125.2025.08.27.00.26.10
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Aug 2025 00:26:12 -0700 (PDT)
Message-ID: <31647a8c-60b7-4e27-b89f-6d1709331ec0@linaro.org>
Date: Wed, 27 Aug 2025 17:26:07 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] tcg/i386: Improve 8-bit shifts with VGF2P8AFFINEQB
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
References: <20250809234208.12158-1-richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250809234208.12158-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x529.google.com
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

On 8/10/25 09:42, Richard Henderson wrote:
> x86 doesn't directly support 8-bit vector shifts, so we have
> some 2 to 5 insn expansions.  With VGF2P8AFFINEQB, we can do
> it in 1 insn, plus a (possibly shared) constant load.
> 
> 
> r~
> 
> 
> Richard Henderson (3):
>    cpuinfo/i386: Detect GFNI as an AVX extension
>    tcg/i386: Add INDEX_op_x86_vgf2p8affineqb_vec
>    tcg/i386: Use vgf2p8affineqb for MO_8 vector shifts
> 
>   host/include/i386/host/cpuinfo.h |  1 +
>   include/qemu/cpuid.h             |  3 ++
>   util/cpuinfo-i386.c              |  1 +
>   tcg/i386/tcg-target-opc.h.inc    |  1 +
>   tcg/i386/tcg-target.c.inc        | 81 ++++++++++++++++++++++++++++++--
>   5 files changed, 83 insertions(+), 4 deletions(-)
> 

Ping.

r~

