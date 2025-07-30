Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7B34C87FCB
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 05:58:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugzph-0004Mf-6P; Wed, 30 Jul 2025 01:58:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ugzpY-0004HT-Re
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 01:58:26 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ugzpX-0006JD-6c
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 01:58:24 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-749248d06faso5481963b3a.2
 for <qemu-devel@nongnu.org>; Tue, 29 Jul 2025 22:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753855101; x=1754459901; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=i0ZYOCbN151U4xEPPe6DXGPyX2rB5t1VLDacp1I1VXs=;
 b=OoUQgcSy6L0YQ3f3kP1EH7PUxlo4lhkDxhaqYml631FUZ/ymAwUiErpjzIyqsqTyGR
 KbAnzWrHZai74r/ZEbMcc4htNXtlRd5zA1fp3a1PTf1EWIDocUT+KnCAlR6CRn3+VVjC
 3BIRdYHK07rqUchTK2CZNTC3mBYqOcZTZYkI/1dmZf6IDeuTva00GOX7xRyubo8XW2hG
 G3pQUkT5Wh9zg3wCfJg/2r+QYtNRL2O6Koa+JiwobvVss/oBlQbu9ouZ6YWHdeNOlYrc
 M0PG2eHIVX9KWgItifSqVZgGPGofy4IOhokFRc9Q6uU2pAFDB+XnduvEvCJE40YxtR0A
 tHRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753855101; x=1754459901;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=i0ZYOCbN151U4xEPPe6DXGPyX2rB5t1VLDacp1I1VXs=;
 b=bE8AJ/cFAfdlnRnHyVAg/uF/b5hNfXj4KYefdLp0Da0vEVu/OaCKSOkPA1mOJls7tm
 YsSc+nHmERxYhYQgzzrTn0VARcv0+aaYDNWJBrig7ayPXEoXxLaW81Ow3clww773Gy0t
 ok7Ytf/28WtI1B9CUuVxta5KyM0qYe5SPwrVAFv1Y+LQXPMo8FnyNFw9CBJnE2g1gso8
 gwmUZKMviSirtg3iQGlTRtQnQZk9+AIiA8IJQDDizRNwPmjSmAU82GB1gU/79MtyvW/K
 NJU/R5OF1MUmEoFxyKRDS9NM9yYxxm3KCooldbjjcFGRv8gcP8oJOtdcr/OFwMv4e2O1
 g7rg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVck0SkpF5e5+ZL2L6uMHDYFL/CrJ+OZd00oVPpWV8VXIuthFY4mtb6kbSDrCP2pSEYnGThg3uGR+hl@nongnu.org
X-Gm-Message-State: AOJu0Yw1sxPQy8tos8qHSPpDx5H14GWQ0qz8da7sMZSmRVOItqmwAGOE
 GKJka/mVCWT2POh2a0Je+vzMUI6kirP+Nss5QyMkFmzKRp2SGhDFBmJRuz0dx4LlAUg=
X-Gm-Gg: ASbGncuxqltGqXqJW/knnK4T0jrXI92enGFdDGag43b5Y7Nh67i3aDJ0IbTLVnDAOPi
 7EOqu10RIjtYhXbCCR0WTYardlavGoARzp8xRSTYr1/oVqCALLuEsO7P5upLP+cXbgSvl+4tFZ4
 vlCvajLuI8INrkqEg/kyKGvP4wjup+7Iv3pyk1XxuATQRUonaHu+g50bmQVHg+SesjjyfE1J/Rf
 bC96XyP9w3dkmfDUpUonvOXfto5quM0GNSv4bVxPnUxHGx2Gro1vgEd4dM9GMJVjob+D9Wa/oGf
 fOKBeo5PSNdlafY33atcXARMbgAqlqkw2IxXbRr8FqeO5p2a3EP6ifX0r9G5V58utfdTcJwoQQU
 XQKwVqrmJZxqoxh2tZPHT3vWHlb+dIwZ/Ip46H7GLq9nT/H3jt4SUvGCsao4IwM34pTmwBK3Mlp
 ov7CaLdIB9Mhxu
X-Google-Smtp-Source: AGHT+IFdJvwIJljJNG5/t4mjVqHYAiJXQp671HjqPEkaXDxPsSbGvNKZ98bvnh+DYU2hOkDtR/8PTA==
X-Received: by 2002:a05:6a00:17a2:b0:746:227c:a808 with SMTP id
 d2e1a72fcca58-76ab3307d56mr3615372b3a.24.1753855101575; 
 Tue, 29 Jul 2025 22:58:21 -0700 (PDT)
Received: from [192.168.4.112] (syn-098-150-199-049.res.spectrum.com.
 [98.150.199.49]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7640b2de3dbsm9621835b3a.113.2025.07.29.22.58.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Jul 2025 22:58:21 -0700 (PDT)
Message-ID: <6b1e64a2-a031-4b90-8e77-c98fbb9b2efa@linaro.org>
Date: Tue, 29 Jul 2025 19:58:18 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 11/19] target/loongarch: Use MMUContext in
 loongarch_get_addr_from_tlb
To: Bibo Mao <maobibo@loongson.cn>, Song Gao <gaosong@loongson.cn>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org
References: <20250730030202.3425934-1-maobibo@loongson.cn>
 <20250730030202.3425934-12-maobibo@loongson.cn>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250730030202.3425934-12-maobibo@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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

On 7/29/25 17:01, Bibo Mao wrote:
> With function loongarch_get_addr_from_tlb(), parameter MMUContext
> is added and remove parameter physical, prot and address.
> 
> Signed-off-by: Bibo Mao<maobibo@loongson.cn>
> ---
>   target/loongarch/cpu_helper.c        |  7 +++++--
>   target/loongarch/tcg/tcg_loongarch.h |  4 ++--
>   target/loongarch/tcg/tlb_helper.c    | 18 +++++-------------
>   3 files changed, 12 insertions(+), 17 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

