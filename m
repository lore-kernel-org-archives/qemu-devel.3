Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A033C25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 07:28:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s793h-00088a-IH; Wed, 15 May 2024 03:28:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s793f-00088J-GR
 for qemu-devel@nongnu.org; Wed, 15 May 2024 03:28:15 -0400
Received: from mail-lj1-x230.google.com ([2a00:1450:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s793d-0006bZ-LZ
 for qemu-devel@nongnu.org; Wed, 15 May 2024 03:28:15 -0400
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2e09138a2b1so92630521fa.3
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 00:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715758091; x=1716362891; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=S5oxJez4KQme3DlY+euUCTfRuzdmNh0OWVHCeCR1uBY=;
 b=v/xZ0nyMfsTC1gky02dUIktkKFHW3DU7HAQXz9J1YcLlOG5JaZuiQar70i//cOHZl/
 +/xDZSGcvt6V7K0OxhKPITr6mMa6KIgT6OURIa91xsLzJl00fqnktMmEVo1wZp92rinM
 zb9ozHiVsD93iT79lo8yf45iiL9xCVM/zfYvuRClFG0+tqRVNaWuDeJEaPQ2Jz7UJSHQ
 0ze2EEr9FJF9o/lgYJFH9K590/ixDkF178W/ARFPMlaeBugkwaJ0yvho7rzvu1tHVZDD
 jW3EvMPnW/qnazOi7F0JIwr2rGJinaHh6bAEvxZWsW2iZTcoWUi0gBgtmTVOeoGPq991
 J0SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715758091; x=1716362891;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=S5oxJez4KQme3DlY+euUCTfRuzdmNh0OWVHCeCR1uBY=;
 b=EwLjWzVJB3TTzNFax0SkDTDgr+W1cW7SKbTBnIQcKtMTC4uYTyT21NEUZolFUpRgB5
 cd6umkYpq+X7x3rDe0akGJfAZM8/ELLl8Yxdnjas3OIdNiEcPPtAioECm0rrytpCZ+Na
 LYF9v3Weif9JaP2NZ4GRZrAA62/sdOLBaKjKAfEBg+1wbbePR01C1ufgVHcwKelQmG/D
 KP9VCtDW3V06WMrexS3eIeSD7kPt+pghKlygBCoxAdLvCs3fHr+h6ic4taRWlJdMeOpK
 sQ9Ji2j5fiubYc0xYjcSrh5YFtZ14eAiOh/izTg1ib1ZjHdv/FkgJy+BOSrHt+8BIm1k
 WQtA==
X-Gm-Message-State: AOJu0YwT2SvIowiO2HiiOQ7OC0SstRvNmxWZlNbXtXe9e21NIwHyrFd/
 GQk3mCrmjeBY+tGzFtZUf3cMTPXXSOAeCFL2rJRF7bjwSB2c3k3m0+q1CqTV0OY=
X-Google-Smtp-Source: AGHT+IEPt4itALpRBhDQoL7J53MYWOuFZoy1LptxmLDecM6eWOjkifyqGjp6+U6RCWhgpSyXHqjQVg==
X-Received: by 2002:a2e:b889:0:b0:2db:381a:bf6e with SMTP id
 38308e7fff4ca-2e51ff5d117mr108678081fa.16.1715758088990; 
 Wed, 15 May 2024 00:28:08 -0700 (PDT)
Received: from [10.91.1.91] ([149.14.240.163])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42010ca475asm142052925e9.16.2024.05.15.00.28.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 May 2024 00:28:08 -0700 (PDT)
Message-ID: <c22b33d3-ce61-466d-b19d-41cd0a08cd17@linaro.org>
Date: Wed, 15 May 2024 09:28:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 24/45] target/hppa: Use TCG_COND_TST* in trans_bb_imm
To: Helge Deller <deller@kernel.org>
Cc: qemu-devel@nongnu.org, deller@gmx.de
References: <20240513074717.130949-1-richard.henderson@linaro.org>
 <20240513074717.130949-25-richard.henderson@linaro.org>
 <ZkOS8pUKCOg5NmUQ@carbonx1>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <ZkOS8pUKCOg5NmUQ@carbonx1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::230;
 envelope-from=richard.henderson@linaro.org; helo=mail-lj1-x230.google.com
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

On 5/14/24 18:36, Helge Deller wrote:
>> -    tcg_gen_shli_i64(tmp, tcg_r, p);
>> -
>> -    cond = cond_make_ti(a->c ? TCG_COND_GE : TCG_COND_LT, tmp, 0);
>> +    cond = cond_make_vi(a->c ? TCG_COND_TSTEQ : TCG_COND_TSTNE,
>> +                        load_gpr(ctx, a->r), 1ull << (63 - p));
> 
> I wonder if this actually fixes a bug...
> Before it tested against all values >= tmp (even for which the bit
> wasn't set), and now it correctly just checks the bit.

No, the shli moved the bit under test up to the sign bit.
The comparison was always against 0.


r~

