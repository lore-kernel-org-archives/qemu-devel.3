Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D824ED1118B
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Nov 2025 18:05:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOJtD-0006iP-QO; Wed, 26 Nov 2025 13:05:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vOJtA-0006dQ-TD
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 13:05:13 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vOJt8-0003uv-MO
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 13:05:12 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-297dc3e299bso470275ad.1
 for <qemu-devel@nongnu.org>; Wed, 26 Nov 2025 10:05:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764180308; x=1764785108; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nD45fd4lJxQWdUIYbkZRF7Ng72feXPOZ4FAdLNprFYA=;
 b=I4xkWHbU5V/1allJyBVmAuu5923W15syLG0+vm6+r/pkIZU2fts3zPLB5iKCsgtM+W
 TbAW4/khfy/WzhCAJ5YRtOJ3NZQ7ujf1LJC13o2g6taqUycXx1Dk3qtdaLJuGLhiR/bL
 VNtjhZPhWdHy99Ms+WhrHas5QoUu8PR/YXW4TKHjDbuHDaUgbfvC7sn1W5mlvK7559VJ
 KBY1OJreSKzKVFKoAfgau36/S1WpyS+kkaT2d8Pw7GdNahAMehHd9kGouVSwpeSVH+be
 u84Vc73WdmphlJrm4hoGQIP535F22ClYcoLab559shbt7f7y16fJUo+zbiB/lvbsxu0S
 iLrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764180308; x=1764785108;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nD45fd4lJxQWdUIYbkZRF7Ng72feXPOZ4FAdLNprFYA=;
 b=agzucgxDcDsDWwmqQJRi7qEPl9p+NSKTdyQpvWRHELX6nOQ9K1Xa8H40nHwy+RCw4S
 GRDkaaZ2d+mfliytlnE1AjSqxHM+4EvsQvq0i8qiFINAPPYzAci1cXwe9t4tDj5CKTdR
 GWWtzIlrX927O1v3NV2oq5V6NYPNv7zUL9krKtq5rYyC8v0oeKk0YfPvl+4FJtpEVZtQ
 ZjH8WyQ6YoNS40h+Ib4cNc8gsD2fNzQ5o0ri4Qj4AI3u1q7GmEiE66+fA1lWOygIZK+N
 tdGkzgfCDdUvkaE4VIA506M7VWK+SBLRXotqWjaX5Geic5x6Z8DOn4t/ShJItZTrMtuN
 OdOA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXRi+BITvCvH0Py6F7XxVUR8UuTBx7WYDWmIPq9+/xYIAB4OC7Ok/ClfvUgU1/jcG6U5vzF1m9V5e9M@nongnu.org
X-Gm-Message-State: AOJu0Ywox1wrqONecKkoboshBbA1zxsJC45xpdd4atBBVSl6/CVvXzeY
 4l1h7xvYm/3UsC7/9homfEuR1RHFDY89sN2N1gzZTxXrPQ+ahkm5vWPizhukyUYZGLY=
X-Gm-Gg: ASbGncs5KrietWDXAtv88N+U2S+iMv/8kgEufOcmsPvXcFNL66PgjIE9iHHHA6KTeJF
 9ttbZOhMoNhXsny3Q25z7BEY/YNPZOKntNGLYd/jRLbGSfpcRqsE+q7A11zPxoaLU8VG9/NWKj/
 8L9ClpaVQacVtU0SVsh8Ap6NCNovj8x7Xl/+lW7KKr7SeQ1gwFJ7+1ayRscj4lwhZ02x2+qGjso
 01O8PwuCmPh29aUjly5zBfCmIPOlqKSWwXcCuo4NqERYML+luktGGwd11rd2GGUZd/uAD7w68h0
 5VSemoz6RE87+qFF+A052Tic9Gx2QcNFGXdY0GaeGrzRnLN2BTKBAnN/CC5MUzikIlGxJvQ0o2H
 nBSMlfSW/DsMoTPbOlrudv9IMF6zRD20tWqqBG4941+lWGK3s8uvl0KAFHSgflsTvKtxeLGH7T9
 BQxGNqhg0/9hnX/rhXdK6VDqlRix7nAc0/Ou4bqemkySeTqS0APA==
X-Google-Smtp-Source: AGHT+IF8t/HmIcCgq8EijR+wfpK2xRkjLbIo3+altVeF3DNuuSI5mEbSSBa+h8G4DTqapkSEHnqSLA==
X-Received: by 2002:a17:902:c407:b0:297:d4c4:4d99 with SMTP id
 d9443c01a7336-29baae454d1mr91970175ad.6.1764180306284; 
 Wed, 26 Nov 2025 10:05:06 -0800 (PST)
Received: from [192.168.0.4] (174-21-76-60.tukw.qwest.net. [174.21.76.60])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29b5b2ae1c3sm207258885ad.92.2025.11.26.10.05.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Nov 2025 10:05:05 -0800 (PST)
Message-ID: <c0a3523e-5c30-4428-93a3-3ad51df3bf0c@linaro.org>
Date: Wed, 26 Nov 2025 10:05:04 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-11.0 v2 05/12] target/rx: Use little-endian variant of
 cpu_ld/st_data*()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, qemu-riscv@nongnu.org,
 Yoshinori Sato <yoshinori.sato@nifty.com>
References: <20251126075003.4826-1-philmd@linaro.org>
 <20251126075003.4826-6-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251126075003.4826-6-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

On 11/25/25 23:49, Philippe Mathieu-Daudé wrote:
> We only build the RX target using little endianness order,
> therefore the cpu_ld/st_data*() definitions expand to the little
> endian declarations. Use the explicit little-endian variants.
> 
> Mechanical change running:
> 
>    $ tgt=rx; \
>      end=le; \
>      for op in data mmuidx_ra; do \
>        for ac in uw sw l q; do \
>          sed -i -e "s/cpu_ld${ac}_${op}/cpu_ld${ac}_${end}_${op}/" \
>                    $(git grep -l cpu_ target/${tgt}/); \
>        done;
>        for ac in w l q; do \
>          sed -i -e "s/cpu_st${ac}_${op}/cpu_st${ac}_${end}_${op}/" \
>                    $(git grep -l cpu_ target/${tgt}/); \
>        done;
>      done
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/rx/helper.c    | 14 +++++++-------
>   target/rx/op_helper.c |  6 +++---
>   2 files changed, 10 insertions(+), 10 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

