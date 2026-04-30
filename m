Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1EE7FF886F
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 04:57:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIJSZ-00071c-1m; Thu, 30 Apr 2026 00:57:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wIJSW-0006zW-0Z
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 00:57:08 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wIJSU-0002vm-Hr
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 00:57:07 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-48a3e9862f0so2358675e9.1
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 21:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777525023; x=1778129823; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LcUJShvgwRJZTqlRLQ36GrNEECCK4K1/fC3hQ7KojQI=;
 b=PRZECkl7IYLV1lfU2/dTIs2GZZ5tpNOMt31g8RqEjObV/Ac0YSTJ/QTguJLE7YkRvb
 FkqQqsvQy5/8IB63dJW6XOzifjv4NsdQgm9cvn5yyiynrq7HHenuRB+9ycV/jF8ivubD
 xox42FvUPWyuCLv3SkiSBbg6KfFM/3jTyoBX/2x/RM3w40QayI1LB/8/eEsLq3Hrq50n
 ArMLgNkl0jdx1UuzTuE43sfi7Gkmp/dC9a0CtfQnWd7e2ZI+pnmx7Dkc+It+7atBjZ4A
 KkRdxMPb3JUBtSKJ4wxFnb/DJnBPUpsk0o1jTtYcebJ+FmNeTbQG0h2cEYwoK/5Ncm/s
 FWiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777525023; x=1778129823;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LcUJShvgwRJZTqlRLQ36GrNEECCK4K1/fC3hQ7KojQI=;
 b=XDcwe4jPIOv1DYERdyxiKzQw+K+IC4T3y3TsBPvCNyOqyWizaID0boEa7uPjqKJenf
 bu7DY1gIqVMV9Yx54SSZ/hmh/s0wzszTyfdrqPrA7u72kvTpsEYPCTxffJBHbHsQLY/F
 EmCK+vi8yAYKygkd3i3KL9imYKGoW0juYWyHLLq0i7EUlktxJ6+RBFdS5/405xq9HCaj
 SmrgP7t1hLYinBB6JTDBrM3NYthtbvdlIGs4I6FNHCZDbtP3sL4sw5mWQmku0b7AAdxx
 Y6CXxTBeIwg5ETBE3MJSoqCFvbKVMH6PN+dD7Cp4ihHOmx4ZU197vxBpLwPEVOJ/nn1J
 GPTg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+lCH0MoQmQgv35dmuyMxuAcBYxZHwqFiQZYNx2639RfMob3LdYov+/UsEAbCDTkXnSGvNfzLXxJqI5@nongnu.org
X-Gm-Message-State: AOJu0YxMz1UhO6eHBq4e6RtU+lGvj4lLVezImrur3zZzckE1ktvwNXuC
 NO7CbV+hssPXtCOCThHNeIIQYzP9KiI3yxstuvlgYm0JPRX0jiHmeEFJ4k2p23VPiEvP9PMdEFI
 D5Wu8Uxo=
X-Gm-Gg: AeBDievGzjiO7EnFBGCHtU0CLtcqNsXp0JEbjHWOV8vUw5DFg7lu9TB3aVc9v3lX+I/
 VjFjzKRQ6JhagPFzjzZ22ibR5EbIiGxd3gR2p6qj6xcrkjdnfCfGtOp3BmX+yjnlXMSnRUG+ouU
 OBqo3kI66DrE+78Td4eG3aVrorttu2D+kUnXo7vFgvgy1tyJVNDtgclvVm74vY7/sb8FdEHH1IP
 7sONaBbX6zJu5bB9ZnsWpRoe/rIOSA0QdLZwzVEoyvuDagV1ECx6JdMd6ZbJCcfbOJw2wnaKh5u
 ziWXboiCUhToZz1Ih0gfV2KifQVyCOIJWEnzGkVnzKSe/Oe6jOHV7UZnyjvCjopkL3NteseNfU6
 V4HwAVdKE09QNB2Ubr/m9BymGn1ZCIgvdAy/u2MSDYmmMoKpMw0XzBEmRZSCkDk952ZjisAr0XN
 h/tVf+BYGX9/f+4cDX4Bf6UQmdskzPSvAgN1QvoeQDjuBCq3Wte48bXRLY3iQBjsRlQ8mDoAZcv
 24o
X-Received: by 2002:a05:600c:608f:b0:489:1abb:5559 with SMTP id
 5b1f17b1804b1-48a85e24614mr13339475e9.5.1777525022745; 
 Wed, 29 Apr 2026 21:57:02 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a81ed659dsm40267515e9.2.2026.04.29.21.57.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Apr 2026 21:57:01 -0700 (PDT)
Message-ID: <574611db-76c7-4c27-abe9-ec77be88f7c9@linaro.org>
Date: Thu, 30 Apr 2026 06:57:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 16/40] fpu: Return struct from parts{64,128}_pick_nan
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20260430000524.56046-1-richard.henderson@linaro.org>
 <20260430000524.56046-17-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260430000524.56046-17-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

On 30/4/26 02:04, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   fpu/softfloat.c           |  8 ++++----
>   fpu/softfloat-parts.c.inc | 28 ++++++++++++++++------------
>   2 files changed, 20 insertions(+), 16 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

