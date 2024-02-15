Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 163E5C4829E
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 17:50:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rafrn-0002at-Bt; Thu, 15 Feb 2024 12:49:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rafrm-0002Zw-Fz
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 12:49:46 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rafrk-0007pk-Tc
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 12:49:46 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-33ce8cbf465so489549f8f.3
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 09:49:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708019383; x=1708624183; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jI3fbSmqwKlVH4wFwixbOKyp+bxedrFIaiC9If+slUw=;
 b=AzBHte4EjkU2uKdtgxQT+cCewSqG1ncYCzi7nPt5mwAkH2s1b/urELGClRpeTsfSpF
 2vCKPr38xqB9aEl/dpM4tQIwqoyGrEaPJQJY+PymXTcm5Cn5t0QzTZzsljElj0ndqM0Q
 H+s8ml5QjfA98BytcbSRFq+SNVbRprgD+D/fW/cIqtgMpYucCr4DgM5GzhM6emBXLy9t
 4F14k0aDgWpgsDF00c1dVfBk6CdKhMhGdnDgwTd5vwFfuRND+LtAJN4q/kWAR163brGP
 5d89SWnyX3DUReuAFIQQfHxdFSOXijUn3v8azjTP9y+YSOT2yvcTBaR+EjT5WwJhNSvR
 Vu3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708019383; x=1708624183;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jI3fbSmqwKlVH4wFwixbOKyp+bxedrFIaiC9If+slUw=;
 b=Gcx4ANQGNzq9XnPfA7Y53JM5cc/0dFqnfPWRJ48SBzH8u2FLHTvHI4unZF6ufyL338
 knPS+7n1c8LIivoCAhi0y0eXe7b7nd7McZv4vz71+3Io8MNQxQcD5LCQQBbU35RQ8Bew
 hHjcPYTjUQB1KX8KjT+NjCQLrZNH1IsnqXQCQw2MK1WH2Z0dJXlRrNr1Vi2S091SEy6a
 PfVarmO1YS5pgeRR26E7G7RsNC2xh41a9v749JjXOJ0eXQnwjL79Exoe32NtOR8p+pcz
 r9CVoZmVLCXeziZK2d1xhP1RKgsLDCkm4WqiWk99FQ37+PBNTmNQiB7xLotF5qlWjraT
 11Nw==
X-Gm-Message-State: AOJu0Yw1xkH0d5xVnH0lL82Fp5/DDIQRr4dxIbEaOK1iClYr+r9wu+yH
 Cf4vDuTqjAUymlnKS3j+8MWpMGGKWvRwvuOM9EHbZJAq3gNgkhtnsGskR0Nd1LJqFpc4PGu7tlD
 s6oU=
X-Google-Smtp-Source: AGHT+IEaSqbM5UTl291yp9olXyM6859KXuf+AQE5llIv2PWBxTkI8whbP/8ywZkrycLXTgMmP4lWfw==
X-Received: by 2002:adf:e6c3:0:b0:33c:ddc2:ca0c with SMTP id
 y3-20020adfe6c3000000b0033cddc2ca0cmr1665762wrm.56.1708019383146; 
 Thu, 15 Feb 2024 09:49:43 -0800 (PST)
Received: from [192.168.69.100] ([176.187.193.50])
 by smtp.gmail.com with ESMTPSA id
 ex7-20020a056000248700b0033b8305ffe2sm2546489wrb.87.2024.02.15.09.49.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Feb 2024 09:49:42 -0800 (PST)
Message-ID: <24481610-11d9-4c53-9521-4cad5019bbe2@linaro.org>
Date: Thu, 15 Feb 2024 18:49:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/mips: Remove mips_def_t::SAARP field
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
References: <20240215080629.51190-1-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240215080629.51190-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 15/2/24 09:06, Philippe Mathieu-Daudé wrote:
> The SAARP field added in commit 5fb2dcd179 ("target/mips: Provide
> R/W access to SAARI and SAAR CP0 registers") has never been used,
> remove it.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/mips/internal.h | 1 -
>   1 file changed, 1 deletion(-)

Patch queued.


