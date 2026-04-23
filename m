Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 997E0FAD3E7
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 02:03:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFjPf-0005jx-Er; Wed, 22 Apr 2026 22:03:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wFjPe-0005jn-7q
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 22:03:30 -0400
Received: from mail-qv1-xf2f.google.com ([2607:f8b0:4864:20::f2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wFjPc-0000jx-IJ
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 22:03:29 -0400
Received: by mail-qv1-xf2f.google.com with SMTP id
 6a1803df08f44-8aca4e14411so73637236d6.3
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2026 19:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776909807; x=1777514607; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8L6z4h7T4+XrkCMA9Ns/79EcAC8HM5n3lkECaVsO1c0=;
 b=YYDlC4iJAflh/9XiIslLPEdafCqIo0tqYFeZUBnw/RlGQRvM5/O6A/N6U75utytpyC
 HWMrkpOh+Vws2DTAI+zjlSqv2yHCmWtDnOn65AGApqTpc/kj5F3Kp6vAbR/2JcCOPolR
 oQ0+afwy3e0lXfIKqKULZmAqQKdSPI0iwLucru2ZusvdNrdP5ep5vDnVfmouXqniw0if
 NchTJMikMqXhknMzp/ladew93C4Ns7ppGrsxnDjPHgtFBOe4fQS42gh+kxVnysOkcGMC
 awkL1WiJYRaOHfZ/aIGRLuQa21JI6/n3jQXy7EWxirVjsO94nLtKqt/Oyg3LOP4ExCVF
 WmAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776909807; x=1777514607;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8L6z4h7T4+XrkCMA9Ns/79EcAC8HM5n3lkECaVsO1c0=;
 b=Vev5Jx7HPAcQgPKM4nYXriU8CXViN9JF/dhS06siM0vGqD5KnjD78V30p1LWwCVBa3
 jlDFfN9aigwR4Zb/Qdh7B6Dm+n8itLYu4W2uq4Jl/m5zppEwZZvQdvMQXlYZQoxHKAxx
 JsAzdSYYPC36s03qQS3QyfTwXq0jXwEm8XbLqGQRO5kwu0YC2HaUkW5CiY9kvNc5z8Nm
 6645InaVpUoya9KoqfEWIHue6KxwCxpJk6IKbBj0q8TnlxQKXQ25pvGy2aVgf3K5pTtZ
 lV0RnMIYu/x7KjAucVrtYha2EULp10zHiIYt8wqpNMf4lQHmeFUahO3ZBHVFKKz7WvrB
 DetA==
X-Gm-Message-State: AOJu0YzWJQfchmjJirqOtq/nChlMAgoBFj0myBQvwuHUXN8aOAxZXtpX
 rYZGWyOds0kDfUQG5Da6BH7wFzJ9kj/aJbxAmk1kNrKTuhtppYu/xN/Nap6dGUnzxE0Lr3jIRsq
 oiVRewsg=
X-Gm-Gg: AeBDieuXDCECCn/zlU4whuvNAZZvPWSRwRfr2yy3E1bgSdOLZ8NkF2r3I783/TTCfkN
 Sg3I2u+R1LTU5DWaN9vim2LMyzIDkX7agXkE1YsDNxACMBdFDA0AmpNh8owRKYW5XUNNoFzAWwc
 FgNWXBWfYBePuhkx/EympuKiFrRcAVVTcJXDZoicA8r4RIpPJ/CiLSkdBvk/cPitQE4RstBqexx
 oD4SjKqWEHAHZIuX0PYstpqTMyK7HuWpSO1W1UGL3OB5MuyEFIgnt5vszTRv+aT/21lAXxGRS0F
 vGRH6yvY2KCcxuHBJvO05wkNm/juOuSymOtVo2Gj5aLqXoNU156JG6BxqMEA1H0rXF+G2jOudSr
 gNs9T1H2zP0YHW6xvlK/QDuLAMpnYbPMf5mD784VY+ysb6MlF9980TDdWy2NIIlvXh6VXZKjohF
 VqhfUJOVfG73nv2pviQtBB3h25Z+6B09u8cJwh+JdYZ2SyNfUifeAHDwvO7Pm76am0fa7Az4RZh
 vfP7ubecJjjh5nWbCtGE5FrtrI4ZXiUGADetDU=
X-Received: by 2002:a05:6214:4f1a:b0:89a:9ef:1922 with SMTP id
 6a1803df08f44-8b02810218amr328080916d6.40.1776909807485; 
 Wed, 22 Apr 2026 19:03:27 -0700 (PDT)
Received: from [10.72.56.227] ([172.59.184.224])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8b02ac68e76sm142966986d6.11.2026.04.22.19.03.25
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Apr 2026 19:03:27 -0700 (PDT)
Message-ID: <770518bf-eb86-4098-a729-ab339fc3b40e@linaro.org>
Date: Thu, 23 Apr 2026 12:03:18 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs/system: add FEAT_AA32 and FEAT_AA64 to emulation list
To: qemu-devel@nongnu.org
References: <20260421093506.616307-1-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260421093506.616307-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f2f;
 envelope-from=richard.henderson@linaro.org; helo=mail-qv1-xf2f.google.com
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

On 4/21/26 19:35, Alex Bennée wrote:
> This is just a documentation tweak as we already support both.
> FEAT_AA32 implies FEAT_AA32EL0. FEAT_AA64 implies FEAT_AA64EL[0123].
> 
> This is however useful if you are using emulation.rst as a source of
> truth of what QEMU emulates and when cross checking with
> Features.json from Arm.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   docs/system/arm/emulation.rst | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
> index 7787691853e..8cd7fe7b00d 100644
> --- a/docs/system/arm/emulation.rst
> +++ b/docs/system/arm/emulation.rst
> @@ -7,6 +7,7 @@ QEMU's TCG emulation includes support for the Armv5, Armv6, Armv7,
>   Armv8 and Armv9 versions of the A-profile architecture. It also has support for
>   the following architecture extensions:
>   
> +- FEAT_AA32 (PE Support for AArch32)
>   - FEAT_AA32BF16 (AArch32 BFloat16 instructions)
>   - FEAT_AA32EL0 (Support for AArch32 at EL0)
>   - FEAT_AA32EL1 (Support for AArch32 at EL1)
> @@ -14,6 +15,7 @@ the following architecture extensions:
>   - FEAT_AA32EL3 (Support for AArch32 at EL3)
>   - FEAT_AA32HPD (AArch32 hierarchical permission disables)
>   - FEAT_AA32I8MM (AArch32 Int8 matrix multiplication instructions)
> +- FEAT_AA64 (PE uses AArch64 after last reboot)
>   - FEAT_AA64EL0 (Support for AArch64 at EL0)
>   - FEAT_AA64EL1 (Support for AArch64 at EL1)
>   - FEAT_AA64EL2 (Support for AArch64 at EL2)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

