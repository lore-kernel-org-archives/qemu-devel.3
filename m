Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E52FCCCD1AF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 19:59:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBIWG-0004rD-Id; Tue, 21 Oct 2025 15:59:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBIWA-0004pZ-0d
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 15:59:39 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBIW7-0008Qp-BI
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 15:59:36 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-47118259fd8so37533195e9.3
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 12:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761076773; x=1761681573; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=j48KuoDHtbbwSAUnEQ6mzXdYYHkCq/HBNozjTY/XuIU=;
 b=Tybe9BgxaiKt2fu/oLXXaQ4U2zir2guoVsGUKRuc83fq03xHUPthdJzMQLWt4iB41B
 7KcetD4aiRv/YnUmXQUSVDfiWweyFrz0HclyXXXyEVIcA6rmFn9y/yM0gf334jH9NWg0
 GlSIbLtSdaSYjkiBQhbGY76UN3Jpv1LV8XU1YchP27Bv2fv3k10KmqhS92dSmIOPrrbU
 8bAm90dK6IafEYYDKKApRgyn8tZ4AT0y+q6EUNzUAbOnmdaBSwQVXDkj7dX7UhaNbmIm
 fTm6Kru/X4h9yKgYiNgoPGoNPZgyAZ/2Wk+L5Gsgk0o72b7iwU29X0WRPLkBCUkVPI89
 vFEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761076773; x=1761681573;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=j48KuoDHtbbwSAUnEQ6mzXdYYHkCq/HBNozjTY/XuIU=;
 b=KUctVV5btbHfRmiN3DU+AoFvQlL2MPi2Qp1VnPC+04LcBVmVMkGvkW4F15CcRTFFuO
 LRfntaa6pA5DW8ipC8jSk+POUA269uD8ilooVBQn6ZSIUaRJBF2dyNjZKt85hRvTQLws
 fSCrgypTWQCM/UJT2IjrlBlc/CLk6vkVqu1+TBT5hCulRL0GS9tWyNA/ipbmVmqTopcP
 A0UIudOHOCKrmRQsSDY5fTbK5WZiTxTtLCsBeLgtOVguSwqqVxYeVx+Fs9t6eG9E7KaL
 uL3/iDLnA7hKQbj5Ky31Z7YrtK5zeiMGpgl9yAcS/pBBOlyV8M++19Kz4lbMzy4tys38
 U5QQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUeLfD4aHyS/U85liB9TTmlHXR22pxRfig4to8jnl2TkgeOCnKYlaxAy4bnUhu11rP7rXYKVNquoM+O@nongnu.org
X-Gm-Message-State: AOJu0YwZEWHXIqJLvQrY+7+JWHyZUDFCtdJwXbCfEzlUGNxzVnLZ3OuF
 ufwQEsDTWmjYXPQsAekbv6MAPJE4g2XI0XJnN/HYEkt4BM5sn+mhRTBokOa/eLHpZbo=
X-Gm-Gg: ASbGncv3gBa48GvImyvH8HT7SFnZyEuHXanYLXHxz+VLqADZTuu6bm7UKCL2dSXhgz9
 VGsrNdLHJ0rtm1AGptQ8o1YgxUq2ZsXvPX6CZLxOMSBs9JQ8tWJg1M8/RZjmdwbLsuJOaK820Db
 NRYA+3Ny5IWIlYsb52NAmnKJHE05v8yKNyUeu6dRV2zMPcu6gp4uZOHkIMt2q+puX7+nM0E1lzq
 RmzYeQMeJr8JmkynKPGNDV3IrOrRAmWUEdJaQ42e+gJBaaX3pJcvdHGfMJjrSYqHYf01QUm5waR
 MbyjjbK3RUYJC1ppop269gNpwKJGRi88M12Aa2CYLCeKwebKrhCEN47xitZ9H6j6XPXqgPCNkbw
 XLTYVoQ79ZGHCl412DBIlPqwoSgV2UUuCUfIcGfoKgiJQbX7CeR+GFTTcfeWbtSi4Og/9vlthYF
 sv5kop9eyBqcDOVMJh2R1XZ6vxwXehZA8Sf+XlSW4+sY9zM39dB36pxw==
X-Google-Smtp-Source: AGHT+IE4oyrgTRYmvh8uMaDX8oqegQtOUnQVlXJSo3J4IvNmYspq1ZzPSOFinC8CvPmF5nMRhCK41Q==
X-Received: by 2002:a05:600c:5298:b0:46d:996b:826a with SMTP id
 5b1f17b1804b1-4711791d69fmr122957245e9.36.1761076773521; 
 Tue, 21 Oct 2025 12:59:33 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475c427c3casm8116985e9.4.2025.10.21.12.59.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Oct 2025 12:59:32 -0700 (PDT)
Message-ID: <48e098b8-284a-40f1-8257-c1ddd4bb5679@linaro.org>
Date: Tue, 21 Oct 2025 21:59:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 14/25] target/openrisc: call plugin trap callbacks
Content-Language: en-US
To: Julian Ganz <neither@nut.email>, qemu-devel@nongnu.org
Cc: Stafford Horne <shorne@gmail.com>
References: <cover.1760884672.git.neither@nut.email>
 <7525e266c45664ce58a2c6c7f92318cad8e6caf7.1760884672.git.neither@nut.email>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <7525e266c45664ce58a2c6c7f92318cad8e6caf7.1760884672.git.neither@nut.email>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

On 19/10/25 17:15, Julian Ganz wrote:
> We recently introduced API for registering callbacks for trap related
> events as well as the corresponding hook functions. Due to differences
> between architectures, the latter need to be called from target specific
> code.
> 
> This change places hooks for OpenRISC targets. We treat anything other
> than resets, timer and device interrupts as exceptions.
> 
> Signed-off-by: Julian Ganz <neither@nut.email>
> ---
>   target/openrisc/interrupt.c | 15 +++++++++++++++
>   1 file changed, 15 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


