Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1167110F9973
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 19:17:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAYJb-0000lh-Q9; Wed, 08 Apr 2026 15:11:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wAYHO-0005qS-LZ
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 15:09:34 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wADbU-0002PH-VX
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 17:04:58 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-488a8ca4aadso34628315e9.3
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2026 14:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775595895; x=1776200695; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9HpQFuT0DKPaDPfbPNtPLVWuxJBPTKUXJcpXFbKe3q0=;
 b=eQUxkUIA7TLcnPPXYL3MflfClUJ0edtHH8p0zbrXGRojFM9FIlQ5fKj4/2qOj1T4TD
 1vjAPKxJJptBdL+YrLxWtp6zFW1yt1IuetaIjY6qw5ZhK5g3tQyvjBqqZDoC8XgQjaBF
 AGaPcYspj6kT590EQUMXGwykZuWsww2ZOBStGcriVssvgEQCpHBIMcI/200IAgU99wML
 lFNY4ltqy8sGxVqfNQHSFV1lwbUM+2uNfI0xsvSH08NAuoQ1sgUSTgsdYgA0vvRgrR86
 8vrjMMiWVE8jGFXIfT8o4+SoM7dXfSCGoNouAjdnZ0iWneOguJC3LuBk3fqX/Jn0/cee
 4MOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775595895; x=1776200695;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9HpQFuT0DKPaDPfbPNtPLVWuxJBPTKUXJcpXFbKe3q0=;
 b=OLnxIeJGmUSBaWMX6nzVy2cjOKqFbcyz65cVG14l6MjpnixHI/+9ngV5oETg4dxxgr
 66dge0IMZqzFH9BmzZYTETgehLiztRDDDK4ljPgztvROpuZC5DI4eyPKY2JCv91ez9dE
 r6iQQlPdxW0cT3cUbIMSpk7Qri8sJwx/mWW88WlzFd4My7ZTvCNenFUPgwMlxl9HrNR/
 8m9ssGsE3wNuTd9VZQtqBU5U4XIjYOhCs8gg+dRdYuoHeXzruLDOuKy9UPvjOFXMsEKs
 hLH4U9zFh5AxHR6xocGVHND+MTLV8bHI4tk5DlxyzivjScp0M3JXjhs2E+V6j9O0prGo
 lZ5A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUOWaCl1kUsl7cogPx6YY9FC41dNksgkT9WtfeobDqmCDVI+LdGVLI+XN7fzn3YYUs3eGYDTw6RXnPW@nongnu.org
X-Gm-Message-State: AOJu0YxEOdhYEuYd2Ck8iKWIXyVgKtll14ZVDav3O0GwPMC32rxgdrSw
 szEFfBXBjqsqSrMDwzUDTlcl4equx0A+e+37rKaMt1YaMP6rGASiaq+mwfHvhYQzo1o=
X-Gm-Gg: AeBDieud687AtpycakI1IR1eqwS1nJMVJ1tp24ohnj6SnDaMc53tRwiIMiw2QYKhkfO
 qUecob5DFYZ37wGWLc80DmBudjEt+bYqsPaqb8Dqf5+kwYF+rYrHPzk4NOubeU7UM5IoORxVeSv
 pNCOpNfFGS5fNIJk/nGg11pCOYX7dYSxZkA6zmYtopu/U96JzM4JJzd3e1yLNX7kU+AtQbMnnEo
 mcNedT2PCe/Mob1b8k7YcpDdNvhLsbcPLhM+Q2WyLKSC1NPPpAl8PbiSiOcAKt8N/F1n9mJCm9n
 H85TZxwb+pvEQdThZ1uRIvDXklTXflU1ea76ypt7KpQEEFZIR2ZCOKfeo5CWdW26Q+sTA1rzCWr
 IxHtxpSpCF9t3fD3vfDM0gRCy8zNp0xj6tFlSxBfsJnPf+QuzZF8oTRMqjbX7tVW46b4fvuOWyn
 oil6LyLiHFTbsDOG+6EzRVj+WR0VWlhVqS4ZAuGlxneKwAl4FbQwQX5ZiAyI5SqBzHQhMDCY1SL
 wHA
X-Received: by 2002:a05:600c:a47:b0:485:4eaf:eb53 with SMTP id
 5b1f17b1804b1-48899781357mr280250015e9.19.1775595895154; 
 Tue, 07 Apr 2026 14:04:55 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488a952a03asm258729465e9.0.2026.04.07.14.04.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Apr 2026 14:04:54 -0700 (PDT)
Message-ID: <0188d667-151f-4d82-b848-18646e1b340e@linaro.org>
Date: Tue, 7 Apr 2026 23:04:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 17/21] target/arm/tcg/arm_ldst.h: merge in translate.c
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, jim.macarthur@linaro.org,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20260407195922.196410-1-pierrick.bouvier@linaro.org>
 <20260407195922.196410-18-pierrick.bouvier@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260407195922.196410-18-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

On 7/4/26 21:59, Pierrick Bouvier wrote:
> Only translate.c uses those functions, thus move them back to this file.
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   target/arm/tcg/arm_ldst.h  | 47 --------------------------------------
>   target/arm/tcg/translate.c | 22 +++++++++++++++++-
>   2 files changed, 21 insertions(+), 48 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

