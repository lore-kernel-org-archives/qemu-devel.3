Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27B30F99378
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 11:48:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFsXe-0002AE-Bc; Thu, 23 Apr 2026 07:48:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wFsXc-00029n-Oh
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 07:48:20 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wFsXb-0008Rk-7J
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 07:48:20 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-362bb3260f1so2177232a91.2
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 04:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776944898; x=1777549698; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gTHWdchgWp6d3CCiMd8ogh5/MoNzQd2vYbTKEymdXv0=;
 b=HRr74T+RcZMGoeTHydBcdtmpSFZua22/qyKo5tELJ/Gm0hTcGs6f1WMRnaSHP0rPww
 H1QM78sf0/2kc2YtwnblHoRCBRxuoK6vJHDKTt5hbfdSg60l1rqgip9Aj/zsgTyUV+A0
 aOUuK4MQaybKgpq96CmWWK32yN4ztSe+48qAwgpxCCzt/x347RgKwZv6qCSnCfDxHLhG
 lS6bwpY2ExwZCrXGnYDAOD96QtEiTxe9t/twrExyhzsXW+joFGvQA5NrSF70w6JTvZMt
 W2ZbzQkIPN+p3SoW4s6MMPis/pI4lxNWMlAQS8Dht/eQXs/mKAU1aD197yLIyPTJ8rvH
 SWtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776944898; x=1777549698;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gTHWdchgWp6d3CCiMd8ogh5/MoNzQd2vYbTKEymdXv0=;
 b=fxzuHnS4K69IS+66CNdFjF1vZafIKwYG/iVmWx+yXBiLcQLoBm/UFp2FfVa7m42ZUK
 1QSsuFbVDO1ak1+cKEfZirc7yzleBgBsn/JuVP2CRQ/H7oa0L0kMMC8O9t8kwlTTRHPr
 x7R6ocGgHIYBAjlO8oNHEtqkH2u0qCjioK0QcwQGw0hePH5jtA3QYU8rIK+Ic6LwKDim
 ORSX1wjkFVJfsrpeP3eg1BZ/K+Bq6+0ZWvjHDIVdaChDujPp/kSutoBYXtt3NOioy7LB
 meJV+UKu2TAGrwBt70OimVPoRZlgD8ieWH1fP80J5XELlUH9ac4ZC3QjciqJ/eNpHOcr
 XSbQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+3Gv6zvBjDM8+s29di4/5lrCKCD9o0k5k9R1f7eSoI3VuOf6lir/Ut8NzXUD5j9jrO5aRa1JcBabN+@nongnu.org
X-Gm-Message-State: AOJu0YwwdPoDiMQS30wRNZ7GW47bd+hycfgjCUadD3hksCiaQvx4msiD
 3PE+8/ncPYUJ4aAdi/CJTAOZ1j+BuLJcEDPGGC0qKvtjCsLclOzd4sCSurwm8kmMbXA=
X-Gm-Gg: AeBDieuulUq5wt3IkzBd6XyRZ+IrXjaerPPtWY845Hp6Z8zNQGhA5ukDSgq/VFuNsDz
 bzFVUyVc27HuB8WrCmxkR6CeTqZ6zkT6sGwAMCZGKbKdv5eaNQinSCE6hSrCEuteZ471IY0VO2R
 zRdwJwLkgz8fOcAnDpzNEuojvvdI9evR/o1GNGrwkQTfY7mlgjy2xqLSXDytqfepM0Dgf0Fq/Qt
 LkrGTDKo0Bck1nEIeBkcU2UnKCHn1FJWWZEXO0M5XUMRHDwix833gZ6N+5YTMm2cv6fFS1bcwg7
 YWY/3Xf33qcD2cT/CTfbjkip8T9eDuNMyAx/8adRp8gGYi71sQKasnTbP8anMFGQy5V8bOJEkEQ
 Ne6gxpjoCqWpJEFgGM7+/u+mn5HdQvVsJfuxxVl+EguZWHnu/84Z8zepWni4D/4hFQpoluJZGhA
 rsVu20KHfW/yriuP4J1y2ZYxA35+RLUswuXvZTBBtmbPCBXQlx4A==
X-Received: by 2002:a17:90b:55cf:b0:35d:9c43:57fe with SMTP id
 98e67ed59e1d1-3614046583dmr27490484a91.13.1776944897596; 
 Thu, 23 Apr 2026 04:48:17 -0700 (PDT)
Received: from [192.168.1.134] ([110.239.0.232])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5fab20c6asm174780175ad.58.2026.04.23.04.48.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Apr 2026 04:48:17 -0700 (PDT)
Message-ID: <32e7f68c-0a14-46b0-be45-3764d12353bc@linaro.org>
Date: Thu, 23 Apr 2026 21:48:07 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/9] target/microblaze: Compile cpu.c as common unit
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Anton Johansson <anjo@rev.ng>
References: <20260423100612.27278-1-philmd@linaro.org>
 <20260423100612.27278-8-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260423100612.27278-8-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1032.google.com
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

On 4/23/26 20:06, Philippe Mathieu-Daudé wrote:
> In order do build cpu.c as a common unit we simply need
> to use the common version of "accel/tcg/cpu-ldst.h".
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/microblaze/cpu.c       | 2 +-
>   target/microblaze/meson.build | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

