Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10A66CAC5A5
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 13:30:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1m2h-0004Yo-VQ; Thu, 25 Sep 2025 09:29:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v1m2b-0004LY-Lr
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 09:29:47 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v1m2U-0004Pw-7f
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 09:29:45 -0400
Received: by mail-wr1-x441.google.com with SMTP id
 ffacd0b85a97d-3f42b54d1b9so1180066f8f.0
 for <qemu-devel@nongnu.org>; Thu, 25 Sep 2025 06:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758806974; x=1759411774; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/qvUVT3yO9nd3SqPHDwu5amgWsvjic55XPaTGM5tiZw=;
 b=emgg/rOZbwYUvf5gqOOwgud7tmvE5JlKhId8fQpibM6bSQVTsahLjynSQDitCS9Dgs
 YQQAMjm3SOeYfu9os4AVGP20MozeIINxSu9LizlrtBK7MGI0D4/FVn2tJHTW2cb3F1S7
 YHZKhow3Jy9vyj6DiUWDWMsXromRgjaVYLLl0VpNR4YpP6bwX9jOJSf/1Mxdqre2op4B
 jGwjCgZM6zQ3jP3fhvSpTXb0mxRhwTVmDp1ARgErigx7+ZnJ4weYBhulG4/I1kzxRCBm
 rfZstSXwNlICo0w0nmsVFT61O9BA9nDvSKoZPcouhtAwhFpuZBCCSxJbU6Q2a1NPANBd
 zCzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758806974; x=1759411774;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/qvUVT3yO9nd3SqPHDwu5amgWsvjic55XPaTGM5tiZw=;
 b=qh6kNgI5lBUhNtUjMhMplmmCUT+Y05wgdHAnPhb1DPAGhpaFYqDdjshKpBidga0u3M
 ghEmxhMN5G6vLXeHS41AFn013EiJ4ppxCb5vvlZCanwMmZLtqTrpNvqHguXNkjs0NbEO
 EefUUltq7G8Syi1hzf+0ipNlmJCNcQSlZ9qrws9VdUrbwRiLlCimDFNdKSlrMZkoKMMy
 0zY6zd65PkUlg2OovjZI3xod54raPfHtaXLxleJzEAOyVNjRLI96+IDs8sNnWi/OXZGl
 K8a6HlyFnOr0CTcISqTD7YvZF8cXVOM+cyHoLbUwOuuTo28vibG/PQSeUjFZZvE7z1Cn
 H45w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVTyS3UDrpd53/eaFLhL6RqYsrqfodz3tHW0a+IGpHENwzTZACS7xwNXtYIy3axQFnzd+2g7aJqIPFK@nongnu.org
X-Gm-Message-State: AOJu0Yzi3eL3uRAFkf58cwkLv2s1A8hz9q0++7qG14kTmGNSaYXDhK8/
 zInmayTXWKKPDSecrTPbnYt1oyKoBPQ93BLbAYPLo4APkUmye+o/ETdauaPgJvnd69Y=
X-Gm-Gg: ASbGncv501drHqPmAReRkJlCxVuvyevDIiNpHxvFvQHf5GoeOljoCaeBWCXITKdmYD2
 aTG/tYrcoORcXYGa/vAesfmJFxzbasueuQ73k24bSu5Q5JE2f6VujLcvbYpkjN7tbkf42xf2HhF
 C4OdZQDWiNfcweNGhEWUeN81DW2OAunvMypmbUPj48MY/8X2v2rZQH8Y5WMUa5mVHjQOCVrK5LH
 DDibBFhyYo28lB1UPoQFzyb/fdeXK9uwpNla8G8rLN5je8csA9rj9LZJ92bM0u1Ot3VXNcNossL
 W3KZw8ULQ6f61IBCIhs8t0YcJbi0rXYLjv6/ioMtadujsnDe31z3UMfePvG7VfOWBOfbRrFC4rR
 Ra1Nj0xc5N5//orLulB8x5ERwfgoTUvw5+NIaueiU1uDILCVMBe+WHI85Y5GIUzpy3A==
X-Google-Smtp-Source: AGHT+IE+HIm3H/CRosOSHbJ63suIHHlZo1uzRspV7AABVJamp7JcJuMBnna0yNqqvvLiiBrd0LzaEw==
X-Received: by 2002:a05:6000:400b:b0:3e8:9e32:38f8 with SMTP id
 ffacd0b85a97d-40e44498167mr3829232f8f.14.1758806973669; 
 Thu, 25 Sep 2025 06:29:33 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e2a996d7dsm81832975e9.4.2025.09.25.06.29.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Sep 2025 06:29:33 -0700 (PDT)
Message-ID: <2bab9ba5-263b-466f-8748-3d65a1d8d93c@linaro.org>
Date: Thu, 25 Sep 2025 15:29:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/arm: Don't set HCR.RW for AArch32 only CPUs
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20250925115723.1293233-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250925115723.1293233-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x441.google.com
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

On 25/9/25 13:57, Peter Maydell wrote:
> In commit 39ec3fc0301 we fixed a bug where we were not implementing
> HCR_EL2.RW as RAO/WI for CPUs where EL1 doesn't support AArch32.
> However, we got the condition wrong, so we now set this bit even on
> CPUs which have no AArch64 support at all.  This is wrong because the
> AArch32 HCR register defines this bit as RES0.
> 
> Correct the condition we use for forcing HCR_RW to be set.
> 
> Cc: qemu-stable@nongnu.org
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3128
> Fixes: 39ec3fc0301 ("target/arm: HCR_EL2.RW should be RAO/WI if EL1 doesn't support AArch32")
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/arm/helper.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


