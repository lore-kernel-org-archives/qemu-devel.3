Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83777CD4F21
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 10:50:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMkgB-00023x-7Y; Tue, 12 May 2026 06:49:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wMkg4-000232-MC
 for qemu-devel@nongnu.org; Tue, 12 May 2026 06:49:29 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wMkg3-00086R-0P
 for qemu-devel@nongnu.org; Tue, 12 May 2026 06:49:28 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4891e86fabeso62055225e9.1
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 03:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778582965; x=1779187765; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IPiW8eRsZhKKTSVePDZjTyB/BEDGfT8GrvIwdGcOtYI=;
 b=disNNjgTA385f/W21hahcm+jTuucL+6cFo5pXf1/3cHl8v8aT9REfeCWT5vlJXjUJu
 K4t5wqAZ6Pz7SaIU7BJnaunyLKdi5zoK1FaIW26qvNGbX4c7tswBb7nogk6i/NDDUgFR
 Y/TGauV5kcNoShpvNZEMmu+bAnKhpe4Bh+kWppLMpv2wC7A7S6+whB7+ZJ4vARj5ZOSJ
 G+FErX/SUOjLFeAYdm9VDAodoxTDz4BghlHg4fAUPT9JSSPiqYj5woXEC+HjhJFVY/4v
 6m+rgnwGbehOUrb4LIBekfqIUafx27MgEHciJgkrm3vpqlB4A/X6164K/ilbSUiUQOPA
 vM+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778582965; x=1779187765;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IPiW8eRsZhKKTSVePDZjTyB/BEDGfT8GrvIwdGcOtYI=;
 b=B7gxB4X/JypJqpMXohpGsIgTFeyK/lhzWOWWk064QZrt3+bxeSWOQZ+BiI6JDs8v/J
 jz+zMcCl4mDLEX7GTIr/TDOKT65bIBVzxowRcFRxm9/xbUvePmHK0lD8yzzHNcUv7ZIW
 bSwXEGIpQfibu4b65A7ocFqnLx+L5tiYFa1zC6ld5K8tl/9s0AMq/XhGLP2QSJ3qDrAT
 4VdNKLgf9eycKf7z761pbAch+w3bTJ710uTdwejYnmUnNki012KDGq9sf9UcU6a4OzMw
 um8Ab7YoLifMLNBq3CghVIy9VCxopyDMbHBKHxyf84GbzFlMFdNssj8mhRNI67VXJwGx
 lQFQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ86f8+590qcRuNGfXijumQB6vx5Kwt6iLJzQoAs4vHV/d7yCJc3UrDDOWmDxSHxkcacXEDVvnGam5Nz@nongnu.org
X-Gm-Message-State: AOJu0YzEkAmVTuHwQM77es5Y8LseysEJ0cAzOmiiXRezVVkTq7HEay6T
 mXuAlvCAmIZ8BDJwBfTD39jVizrr57DIVGOpuigdDpZmejRQNwYcjYRvPArxhJHLVHY=
X-Gm-Gg: Acq92OGuBHDxSyMxG+sIdSg/FC4NN59fUyYWXUhcmaRnFnqdK3rSmdpRhTfD3n4bM1e
 m0nP1k5No9dW4tsGeZsjpzlFrFNNkCwOqicBZpia7qPMYIrtubAmFq4ULIsXIztoLRAHMYlEatY
 dxhYT87Ky5+ot4LJ2w+XQX+3rIACFqvI1S8sQblOF82AEFx7bG+BiuukwGC+nP8AX0htXQITAGH
 GUYoJUbJPwwh2HOcvPn5D4uhX+/fD9ybO1IFey038hTtdvdGJlbBavcKuCYVeQ8gL59dEGEwV1Q
 NM85fzrjeZDE2vBrtuB6ep9NumuwGCA4MysPeH+1zXHSmuKxo6mTLm2UdxklxvnTujq1oQxbQRZ
 AvZ0/OspU9c5T5kMXs4DXxHriqYQ/wuO3Xi7nj4f8vbdg/Zw1Crst4wQtJx+QIxtVQMB/uFz0PC
 OwqpObGgFlDVOn60zBGBxRS0JJWZAOQ9awZb5nDJ2Wd1VRjMDGAk3CGdhlfyC/cw4kLw==
X-Received: by 2002:a05:600c:1d18:b0:488:78f2:6b0 with SMTP id
 5b1f17b1804b1-48e51f41b9cmr438764265e9.29.1778582964986; 
 Tue, 12 May 2026 03:49:24 -0700 (PDT)
Received: from [192.168.69.200] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e90677b04sm34816495e9.11.2026.05.12.03.49.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 May 2026 03:49:24 -0700 (PDT)
Message-ID: <2b681466-c32a-465d-ba57-1fe39ef71b45@linaro.org>
Date: Tue, 12 May 2026 12:49:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] target/arm: GICv5 cpuif: Fix overflow in left shift
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20260512093856.3197700-1-peter.maydell@linaro.org>
 <20260512093856.3197700-2-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260512093856.3197700-2-peter.maydell@linaro.org>
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

On 12/5/26 11:38, Peter Maydell wrote:
> Coverity points out that we forgot the "ULL" suffix when shifting 1
> right by a bitcount in various places, so for bit counts above 31 we
> end up shifting off the end of the word.  Fix the three problems
> Coverity noticed and one more of the same kind that it didn't.
> 
> CID: 1659588, 1659591, 1659559
> Fixes: ce245ac6957 ("target/arm: GICv5 cpuif: Calculate the highest priority PPI")
> Fixes: 3f79212abae ("target/arm: GICv5 cpuif: Implement GICR CDIA command")
> Fixes: 49f4c98648c ("target/arm: GICv5 cpuif: Implement GIC CDDI")
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/arm/tcg/gicv5-cpuif.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

