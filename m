Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9673F8E499
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 03:44:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDa7O-0006Jm-6K; Thu, 16 Apr 2026 23:43:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wDa7J-0006JW-8c
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 23:43:42 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wDa7G-0002xV-QS
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 23:43:41 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-488b8bc6bc9so1093305e9.3
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 20:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776397417; x=1777002217; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NzSddJEDv3unYlb/g3xhjSy1tYm6BVEdJaWVC7UTOeM=;
 b=R418J8F3FWzFTC4JRQ9XCBgJCtKGVlUepDOhJMtqqBY9MkHUlPKSYDPiFHrAwdjgbI
 GyuBtBNGiL0fQ3SfLUTgGyEatBwf9EbZQAvJwhJHbW0Ur/dlgMyuhVMOn5KeQeBCw3q6
 KiFDuS3BDqI6tJCaBni6GnwqvsEn/f/JQIZkChjKH28bOzeOg5kP17f68/aIeOGrJuu1
 sB9S1+oCvtImLk9nzvCNe+DGGLPTh9XlYhiOSzLj8Xb8I6xOchJDdZsdHKFPIG/p18XV
 QPYkE7WkSqjhyYH5gLhlAGrOixOhKxJwtoTg1yhhWDvrNxZg8ARnRxfYzgwI4S748sJL
 86Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776397417; x=1777002217;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NzSddJEDv3unYlb/g3xhjSy1tYm6BVEdJaWVC7UTOeM=;
 b=Gu3TVx7puVGBhpRgwLaDGl+puaA2femjIy7ah2t5PLB1F1Og29AurMsKQHGXghpnSX
 STHfj8aIKzyAaqxVpHDCEG12e83HGtiPZnhdixQfiAt8XDlR2tEnQeVBddcxZbyyhjuy
 VRat5u81vaH+YlFFexSwkuEDASgo/uM2fgd2AROmbCvD5lZ5j4RcO3tjYN0uZ+gOhRq8
 KLrP9SJntvTl7eUKJd02UGBrhyvIAD4BlkOSIicFYLIYDwfVIbLxjqsb3Q4TdEHs7e1x
 4akcE6ARJP4u48O+k+meplAgRJkqAfZBornKeJzEtEBaT6VTwxzHeq0c9osNLYMwQM93
 WD/Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ9Udv0qjGz+YRXMtLTnTTl9jPQ+Ha2hwdEMxEN0KTd5VWPTBdYBY61CmF7INaw3CZz+dgRF+MgKJYIw@nongnu.org
X-Gm-Message-State: AOJu0YzFyx7LD+9Hs6ftJ1M9itl0b3cjyfGJfvQ3QWrzAtNP9p7XvDFY
 0ibdljq/+HZH7BzXVZkziMYzgIb+uKRH5mnVtdiRCSGvYT2i8apDf1HCoCgI0mj7zys=
X-Gm-Gg: AeBDieuNhChmT0xiLPN72qU1EwL2VykIrY06A6RLTSzKdnBqDrD3uwyZCeeaye3hj6p
 Z9DbiQ47VQBUHZu5LMSyHN6XXBo5JevqcQypT4h50fGvGKntViTSLyMp/C/ecLuRQZVebstGo2U
 3o1uFbuaE0mt2w0S01QH0yinrFnx3rw9GOC0gyAnPh3JNpGpM3ecsNrPJvGbC2rsNCHGHFDjyLC
 cHbTIuhvHsL9tnXZUT47US0njDY5VGVziwpUdHqbVDyi57FXVVUVv4vE3kFvAzSmaJNBeL1JOwB
 cSy43rPcG8CHFpqfqy5gQG+R6ELC/R98Jhx0oFh57A577bJN3M5k0GhrVDpbxsUDogkIDETuDFR
 0HTw3c6QwmOojVNPXCmKxFRAH7I6idquxURU91l8LmBK/tcp0riaOucpwFmJNOxVj3PzokKijsN
 /lbDfrveOXjVICMggl83SPUzIpNbshDuoDfg+qBm50RkF+5LyaO/Zn2NcqNw5amj/976ALIMxyI
 Box
X-Received: by 2002:a05:600c:5295:b0:486:fbd1:9dc0 with SMTP id
 5b1f17b1804b1-488fb780463mr11109435e9.22.1776397416729; 
 Thu, 16 Apr 2026 20:43:36 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fc1393d3sm16299095e9.11.2026.04.16.20.43.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Apr 2026 20:43:35 -0700 (PDT)
Message-ID: <e9ceedba-0af7-4a98-8f4f-2938ebe57d78@linaro.org>
Date: Fri, 17 Apr 2026 05:43:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/4] target/mips: Check alignment for microMIPS pre-R6
 LD/ST multiple
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Aleksandar Rikalo <arikalo@gmail.com>
References: <20260416210508.30686-1-philmd@linaro.org>
 <20260416210508.30686-5-philmd@linaro.org>
 <bcbfb47e-022b-4db5-90d9-a91599ed227f@linaro.org>
 <4aa2a069-a7c3-48cd-b8ca-4b03adaa1227@linaro.org>
In-Reply-To: <4aa2a069-a7c3-48cd-b8ca-4b03adaa1227@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

On 17/4/26 05:29, Philippe Mathieu-Daudé wrote:
> On 17/4/26 01:07, Richard Henderson wrote:
>> On 4/17/26 07:05, Philippe Mathieu-Daudé wrote:
>>> Pre-REL6 microMIPS requires alignment while REL6 microMIPS does not.
>>> Pass the MemOp alignment as argument to gen_ldst_multiple(). Keep
>>> using MO_UNALN for REL6 decoder but use MO_ALIGN for the pre-REL6
>>> part.
>>>
>>> Fixes: 3c824109da0 ("target-mips: microMIPS ASE support")
>>> Reported-by: Richard Henderson<richard.henderson@linaro.org>
>>> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
>>> ---
>>>   target/mips/tcg/micromips_translate.c.inc | 16 +++++++++-------
>>>   1 file changed, 9 insertions(+), 7 deletions(-)
>>
>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> 
> I'm not sure about our testing coverage here; I think I should
> use default_tcg_memop_mask in a previous patch, see
> mips_tr_init_disas_context():
> 
>     ctx->default_tcg_memop_mask = (!(ctx->insn_flags & ISA_NANOMIPS32) &&
>                                    (ctx->insn_flags & (ISA_MIPS_R6 |
>                                    INSN_LOONGSON3A))) ? MO_UNALN
>                                                       : MO_ALIGN;

This comes from commit be3a8c53b4f ("target-mips: Misaligned memory
accesses for R6").

Thinking about it, 'default_tcg_memop_mask' might be a misleading name.

'[default_]mo_align' is clearly more explicit. Or maybe even better
would be to make it explicit in the relevant call paths?

