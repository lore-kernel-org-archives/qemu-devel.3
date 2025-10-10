Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AFB9CCA476
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 16:58:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7GQu-0002Dv-EK; Fri, 10 Oct 2025 12:57:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v7GQs-0002DZ-GL
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 12:57:30 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v7GQp-0008A5-O3
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 12:57:30 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-7930132f59aso3256077b3a.0
 for <qemu-devel@nongnu.org>; Fri, 10 Oct 2025 09:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760115441; x=1760720241; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XmCc5jPEyTPNa6wJ1h1HXyfWGGshQ+TdRfe/mtlnCmo=;
 b=nVv+us/d/wMxKHaz1tGDFN59Nm6epP4k4Uo8TxTYhZhAHmoV5h/zgVJJLxkS829pWj
 OjNd0PRN+rBKz10I2lWmm2Z/ao1yRdv+lh5v5EzuY4psR3VcTFXHAfDPI9Zt7I0Q1Bsx
 TcJ2EY3K/6v001y0cpQhFcn3+y7sKMTFVjkY1D8sryqPK5xbpXtej0acohE3woWBUMbH
 9TXnuPq6kBeYmSzEunfAAFYbOqDKgwkoooWyJxdlxmvMJyp+Eo6/rJJrK7W0iqtauBn4
 906GbbQy0Q+6k05tt8yhaxu0d78ZKqM/VaAeGMBL6tuxJHxi7r+ltWNWucHtVdnF0Wrg
 NEJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760115441; x=1760720241;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XmCc5jPEyTPNa6wJ1h1HXyfWGGshQ+TdRfe/mtlnCmo=;
 b=Q/WXRwEKdDfP2mM2AOFw7ehcG4jhs7RiSLbCul/t5RcGyu07DXhnoiCjCSFTozMW+J
 tONxqxEgNyZWr0LUhPv9IrCEiQ9w0wpqfmQGibLq5ZbgePsqKjZK8XO06RK9+7U9aQ+K
 qMKdgqFlnrnnyO2IIAKde4QidpneEhlsYu2jHscXt0y9njStCqyhNDlbCnjLTa64CwEm
 H9sPVubts7lGBN2DKpmtiEO9f2UU0RCLcAOYIBZ3teUq3FIc7AJyjyhW0kjD0/pkfqIc
 jtunh05J4QCIFQ4DjUwYvJ3PNUP/xme1wQJOVVi6yGVYjpEYuxyNEKIZAeu7Z5iRBBeM
 jncA==
X-Gm-Message-State: AOJu0YyoMxvbyJXMEnu1Jk6b8H3XEB923BddUFJmkfHsVo79AoESwsmd
 fKSHd5xT7OUO1Qf3PkvW48ktJWhF4ziHFVNf0yNq5+ro6BXdTa3+JDj+FOiMEXJoZrYkArQhep3
 AWyzmQR0=
X-Gm-Gg: ASbGncsLwyx6s8TFDL0c6we5XyTtKqYqdWGmhK0F4YjKKcTeoORyX+imRdUCjQ4IJXf
 2zjs48xC/vK4W8pYB90dODMYNrX7Lx6DakKi2BlkXLIKEBvTT5ffAeWHd56HAR+ymv/htrWLpL5
 EVMhZfLN2B6mLMg3x1x1PEoQGw1uyfxrLBeHkLMFRrecVHnfFSH5mhEyMeDJpp1vNmCD2oyp6Gm
 r3xGvJ+7ufvqOFNqAnF6C0v2cSigaRjCKEeO4+EBJuD9eGfixIN4azIEt9gi8Qy7xvj4OFoP9wW
 Prr8gNnTZrZCwYwA/GfQYl71rBRa769RssKZS8OTHGlFNdqtf6NZGacdJq99ypJRGLgIv+1RrmW
 YOkEd93gU85mRmoT232DlAyX99Ac/hceVsHXX53OICB69c+cnL2j8Q+xsXVo=
X-Google-Smtp-Source: AGHT+IGSDSxB6oe7sjkGIrJoFYG4ECAQgqMIrY/Fb9fw8M34qp5a0WKJG7OAf/QDw5HtU2qdRKtbBA==
X-Received: by 2002:a05:6a00:a8f:b0:781:f1ee:a9cd with SMTP id
 d2e1a72fcca58-793858fb683mr16259263b3a.13.1760115440745; 
 Fri, 10 Oct 2025 09:57:20 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7992d0966d7sm3487972b3a.40.2025.10.10.09.57.20
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Oct 2025 09:57:20 -0700 (PDT)
Message-ID: <76aa4062-4811-4822-8b5b-c585a88f789b@linaro.org>
Date: Fri, 10 Oct 2025 09:57:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/12] target/tricore: Remove target_ulong use in
 translate_insn() handler
To: qemu-devel@nongnu.org
References: <20251010052141.42460-1-philmd@linaro.org>
 <20251010052141.42460-4-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251010052141.42460-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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

On 10/9/25 22:21, Philippe Mathieu-Daudé wrote:
> Since commit 85c19af63e7 ("include/exec: Use vaddr in DisasContextBase
> for virtual addresses") the DisasContextBase::pc_first field is a
> vaddr type.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/tricore/translate.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/tricore/translate.c b/target/tricore/translate.c
> index dd09f0651f5..4b769b204ab 100644
> --- a/target/tricore/translate.c
> +++ b/target/tricore/translate.c
> @@ -8414,7 +8414,7 @@ static void tricore_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
>       ctx->base.pc_next = ctx->pc_succ_insn;
>   
>       if (ctx->base.is_jmp == DISAS_NEXT) {
> -        target_ulong page_start;
> +        vaddr page_start;
>   
>           page_start = ctx->base.pc_first & TARGET_PAGE_MASK;
>           if (ctx->base.pc_next - page_start >= TARGET_PAGE_SIZE

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

