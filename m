Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE712CA6007
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 09:20:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xENeS-0004Al-5n; Wed, 07 Oct 2026 05:09:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xEMY5-0003JA-1P
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 03:58:53 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xEMY3-0002gO-DP
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 03:58:48 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4a022fee0caso15304775e9.1
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 00:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791359925; x=1791964725; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=8mkEbBCaLJ+gheEJVDag3x/brWnUFiNaDEFeNGRTOHg=;
 b=ClDJFu/0qu+FBexEbI0ro6XhJcGIrJ5lhKilKhGnNDRajCTMFJwyZeJr3crJ9di+QU
 U1GX8qietvEiaY0c3we76D3ouoqpqG47FNuWYUXermKv5Gi2ao/qXPFOQg7h/QXC1ODJ
 kENnzi1TaI0b2d5U8UMrPN3eH87LbK2gmV+5+5xEIVnk6JsVqOKGSrofCXAly07HK2U4
 xM3LSkxTCww+JTG4ZtJ6geJPvh2RjBZxFG0GD3NjVOEwt2uFSo5r/qa6kTw9gDCa1ajm
 Ty6qg5MWENzva/N+Hfxwb4u7iPNARuxsPh0yvcDhYEzCVwgLtm5ntjpU+pkXtf9RWJ5b
 vp+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791359925; x=1791964725;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8mkEbBCaLJ+gheEJVDag3x/brWnUFiNaDEFeNGRTOHg=;
 b=jHhjBmyQnD/RkdRFQSxKw3tZlisiHcjL7w1YdKWoQDOZ6ItM8lvPhGs2mmKK826NxB
 MtpynLSSLZQKz37cuBVnjBQpCCRdIEj+QW7/p9VJnecMoh1j/gaabPufH/+2h88zf7Zs
 bzXYlDpuE4tV1SXQGzMa7T5qgXnTMFVMD7KiUdgLuG+tsVhEh8nDHC2CyaMgbHmRqt1k
 hGqIYm7BFXuxGS1rTjiPqUBjQkLQYSMUG9BkWQdy8ZEoImQGXue1TNqzrXAHFL15jadT
 9lDMMrlK9oRZQyjBQc3Gioxfe8zpSiiRJCWHi4jDQKFVgr7dwFqahG7TtFAu89v6B8Ll
 hIfA==
X-Forwarded-Encrypted: i=1;
 AKwUvByj3JoKNz7LUgTCDanK0w2egUo6UfGgMQoclxp1IfgtjBty4REgccC3CwG6pINiJ3IdTtsXIZ7NSKi7@nongnu.org
X-Gm-Message-State: AFuF++k68OGch+n/Jk0kygheOKwVBEXC+eLLPAK+sr7DCHNdYPOFdLCk
 4VvPCuWkqYIBGzEL0YMAG0HuRoJ9C1gIpmWUzkMvPdsPTw+V8c5EbJl8MtomZ8ojKrQ=
X-Gm-Gg: AYBFou2pumPu0vxFxkosZqm0Zz/tJDjy5ZZLqs+yx+atiAZOJ8Lp+BMFdO9YGHsbOgx
 27olYqmjbExuriUwyOtSH95uQ9pkD7f1P9HhA7WFM4/o/uCLD86HlZH0/nWeLsRukpJ3bV+eRV7
 DKZ/lIypXZq8qtXqnTArYjjwXgdKAfnbpk9uXAwc2tMaPiWu4GsRHDegQ1+tbhJ6mmDob/OZSL3
 bamaKG95jl75q6RDonMLrb8aiVgGeKUUvlr0ftva5gZ0UPPR2s2ncPMMzEiMP9k+NSYM8L1IDRu
 hg7mbRQoqvsxGoR5qrnIgK5B/m+yFKJtZ97J3V1xaHxt74l5v3u42/H7Tg9XXvTq0Ius3o63ORm
 rCJd9oiy3g1HjukTzMs6qHJ6zfNblQ/Uftkd+bdKWkq7EpIn6LIMQ3VZiDLgrUZ5Eo2GdEjx9CI
 mw19F+36Ec2/scAo3Qzu+z8bDjtVGfSX7QEvKB/oOfufnv/JFbDpubOyg7/X2PbJz96WGUW/8nY
 DnBDUO5cPdf8Upw7MxVcrCVDYjQi8g5NTdFWEwDoxyhFA==
X-Received: by 2002:a05:600c:34cd:b0:4a1:7c7d:8881 with SMTP id
 5b1f17b1804b1-4a180311361mr17539135e9.13.1791359920327; 
 Wed, 07 Oct 2026 00:58:40 -0700 (PDT)
Received: from [192.168.148.71] (90-182-211-1.rcp.o2.cz. [90.182.211.1])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a178c40a28sm142968865e9.7.2026.10.07.00.58.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Oct 2026 00:58:39 -0700 (PDT)
Message-ID: <2bdb49ea-2e55-4991-ac6d-9f2d7d575de1@linaro.org>
Date: Wed, 7 Oct 2026 09:58:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/5] hw/nvme queue
To: Klaus Jensen <its@irrelevant.dk>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Klaus Jensen <k.jensen@samsung.com>
References: <20261005115805.99042-1-its@irrelevant.dk>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261005115805.99042-1-its@irrelevant.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x329.google.com
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

On 10/5/26 13:58, Klaus Jensen wrote:
> From: Klaus Jensen<k.jensen@samsung.com>
> 
> Hi,
> 
> The following changes since commit d7a65d1793d691d356a56833620f7d1e6f5d653b:
> 
>    Merge tag 'hppa-a400-updates-pull-request' ofhttps://github.com/hdeller/qemu-hppa into staging (2026-10-03 14:17:49 +0200)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/birkelund/qemu.git tags/pull-nvme-20261005
> 
> for you to fetch changes up to f6c0588fd7c22caefc5b31f485c8bb3ee994a58b:
> 
>    hw/nvme: fix firmware boot path when nvme-ns has a bootindex (2026-10-05 11:00:47 +0200)
> 
> ----------------------------------------------------------------
> nvme queue

Applied, thanks.

r~

