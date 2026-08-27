Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AB3EC61DC4
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 20:08:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzgO7-0004a3-Cb; Thu, 27 Aug 2026 16:07:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wzgO5-0004Y8-7r
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 16:07:49 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wzgO3-0001Al-JG
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 16:07:49 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-38dfe7eb825so373334a91.0
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 13:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787861266; x=1788466066; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=RkQXossPM8x2ln4eURTtPHqSSzNgexTYevvkBcw2D2A=;
 b=n4OkJXZuJvgQXnxsyXj81tzMVJK2NG3yFd+novxJZwrPLl7o9PtRLZcqutcQRrqD8Q
 pzUpG/zpOhphTwv8zXsXTcXwpcpWcn/idhRjH3meelsBREfBxpfaEozWRX3Uw3w+ykje
 citbB+JfvBlbAXJcZGmiK247/NJ2ied+5Cir77Q8DGOhXWR3l5ZMBPjjAQiiuyP52dQl
 wb7bCZTD5jXaJnXC1zSCFjxpRxRrR16d6c8MmTKFHKdSI8nTE4HXL2cv47b+rap89dUG
 zVco0aqGN5cMDzSKZq5DHqN9fLQ/6+Z1HDBJ+6DqS293unP8/V/CtAOY+2VpgewijNSz
 mVFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787861266; x=1788466066;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RkQXossPM8x2ln4eURTtPHqSSzNgexTYevvkBcw2D2A=;
 b=lvwEcC/DxL/zSMmKRBYyorr8Odcxe169kclUj2PxvxFh9O2A4+WL8XCUvJm+qj9a46
 51dc/GpBUTyVDWspkRuG6miJdO8euHkZOCEJ1kVnrQzveEow1mcpOcFAVtZi795vTBaR
 HaNDK7TtekA0fmIUAiRsyPMS3l9ai0c/POpr0S92yjq9Cv/mkwg9PkYj1C2khYqEADop
 xy5ch4Numtuv6VHTZzV+fgH0X/PewgQiicApoNxeGTW4egiKnAvcf7nYVoozukBVCALM
 pQnsJylB90N3OzBGUvRNoJBVvBWZ53Tnf3Z9+B7sGkQLSCKu2d29DALlqbpmSRe4uRAS
 avCA==
X-Gm-Message-State: AFuF++mr3PX57MBlR3GZKy9zZB8/xou3ZyfiJN9LmO6jVLJUjBC4Pxsn
 n3nbAj/Nm+YV8hUiTvIrEb746xRtLLHfLagtTwcgpRnrPH+OW08XFJbPUQz7j+FHbB0=
X-Gm-Gg: AR+sD10lJnVXodWiFPzW2qD0Ydu4iEijzWHIIdQAl8RzRM9oANsc/xS94lkytvulRM/
 SxCij2LJUFbSsmglFZteZmlcVOU6QtdAAbhx3i084Hxmdyu23wCPzA2GDShu5Cj1zxpGXCN/iFu
 BPryoEwEhOyFxUfiHLTXkDi9vbYbQxPnoOl9yjfouARIONJxqZZDB7Pcg8QdYT5ryjLZFvvCpcR
 ZuL9i9Spxr+w03G5+u6zUw6ag3qicz9O38mGeaous5Xwlw882VDfbBia04PkgBsxbXbdAE6YNWA
 5gXw9WUAZObJD7LBqC8BN0d4wZwnQ4vvoW1JmD9E1i71hFMa3gbs+HcAl7pfOEEPDRnixinpqaz
 Ldmw0bKpgNYx2BSGoI67kak5cA7nwOF2jjtgse+DrPxUSpp1BobXt5igvGn+AgmGjIx/RyAXn4i
 8+eQgcoHDGSUqy8PbeVTW7cUk2tk/AkFphM9CMAwx9uD7cEVvVYSMG36ZtKY4XV/H3/GRi7XaSz
 J+H5NwAqun/Z5oXQ3t5xRa5UaYnsvWJQujIfm0=
X-Received: by 2002:a17:90a:e710:b0:381:528a:808c with SMTP id
 98e67ed59e1d1-396d10085b8mr3275181a91.12.1787861265667; 
 Thu, 27 Aug 2026 13:07:45 -0700 (PDT)
Received: from [192.168.0.4] (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-396b0d3c9e4sm4086521a91.2.2026.08.27.13.07.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Aug 2026 13:07:45 -0700 (PDT)
Message-ID: <1ae174fe-34d2-4425-be69-f8ec54d59e4d@linaro.org>
Date: Thu, 27 Aug 2026 13:07:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tcg/loongarch64: Fix compile issue LoongArch host
To: Bibo Mao <maobibo@loongson.cn>, WANG Xuerui <git@xen0n.name>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
References: <20260827081138.1448296-1-maobibo@loongson.cn>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260827081138.1448296-1-maobibo@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1035.google.com
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

On 8/27/26 01:11, Bibo Mao wrote:
> On LoongArch host machine, qemu fails to compile. The error is something like
> this:
> In file included from ../tcg/tcg.c:1098:
> tcg/loongarch64/tcg-target.c.inc:1896:27: error: expected ‘}’ before ‘;’ token
>   1896 |     .out_rr = tgen_revbit8;
>        |                           ^
> tcg/loongarch64/tcg-target.c.inc:1894:44: note: to match this ‘{’
>   1894 | static const TCGOutOpUnary outop_revbit8 = {
> 
> Here fix one small typo issue and pass to compile on LoongArch host.
> 
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>   tcg/loongarch64/tcg-target.c.inc | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
> index f65496a040..69e76807d6 100644
> --- a/tcg/loongarch64/tcg-target.c.inc
> +++ b/tcg/loongarch64/tcg-target.c.inc
> @@ -1893,7 +1893,7 @@ static void tgen_revbit8(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1)
>   
>   static const TCGOutOpUnary outop_revbit8 = {
>       .base.static_constraint = C_O1_I1(r, r),
> -    .out_rr = tgen_revbit8;
> +    .out_rr = tgen_revbit8,
>   };
>   
>   static void tgen_revbit32(TCGContext *s, TCGType type,
> 
> base-commit: 324bb5ef83ad5e9026ea3242f99ba53191a7bf3f

Sorry about that.  I clearly did not correctly transfer my work between 
machines after testing.  I've applied this directly to master as a build 
fix.

We should add a cross-loongarch64 test to CI.


r~

