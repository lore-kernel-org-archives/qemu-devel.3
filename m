Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B16CCCD98F3
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 17:04:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZtfr-0005Ry-V6; Wed, 17 Jun 2026 13:03:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wZtfZ-0005Q2-5v
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 13:03:18 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wZtfX-0003BI-Cj
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 13:03:16 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-84226d0f1d2so3906269b3a.1
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 10:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781715793; x=1782320593; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mEd/qdrlUIRxX56WVn/W7wH8hMQZqnfTJMJMRDEdAD8=;
 b=ePcXtRyPMk/mplZ8DlAo8Prv70M9ilVX+4F/R4a9ptoUv5sya3CA6KGJc32Ta9m9T0
 3Izgniag2iTQCV4m9oeE12glODwsXEklUEvxDGm1fYsPVHi9YVWj9gHDHFor5mp6Jm/z
 DOFjzsQf7NcdZnYR4btIKqkxw0+zeFTDUsyc7bdlk6ggbVc5Qqey/kQRIPHymMcsTj4u
 ZA+rjymjDpIB4jGyvfYtv/vECzxG7twdN7+QRXovX2KgelkKJNHA6R8d8Sy1Ea6asNb9
 BbBPu81p0jROP7GxGRfXgSjuFs3mVm3w1njboHTG/98xYdiPVfykg4si9MZW8PqtJlSL
 NJoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781715793; x=1782320593;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mEd/qdrlUIRxX56WVn/W7wH8hMQZqnfTJMJMRDEdAD8=;
 b=fJJwik2UDIo2X/zmzqk+W3Gx3CJtfD57dOrBF/MpMWc+VUO0ce/ugOhbuBd7pyCu9P
 wR6A2HYRtk+zv7RzYL6otMsTiThRsI/azylJ7prWyHDy5bKXB46VQ+kxlT2+N+fHB8je
 hRhp8Pv9GSgaC8I4u1GmBj5yy9EKHeqcvWDJuV8ydVCUcB9B8C9JXdehxtOeji8X5Il1
 neaN/or8LRPbJMnczYmAg+SxF4ef8PCQJ/PWx/rLX2YxipXcTZEtl5XDGTqqQ+BT/m4h
 Cn+kgd61odYLwJgWN6xi6xsShMxNqE+yTKAbnMIOhw28Q7JAhb4u1WHiPbctpDcwgFdU
 K2og==
X-Forwarded-Encrypted: i=1;
 AFNElJ8PQXTaCx5ofOX5mqXzsX3la1VhKQqN85RL3b0ReS34zelIkT4G0BrOdwsAEkEC62EcxKOPOQece2y5@nongnu.org
X-Gm-Message-State: AOJu0YzAWW4GbEaIKQW2G0p94VfpnqdVmwprzf9cbTB4OfccMbugb3wz
 aTTmG7QW/nRzijLUWzYUGbEcYG2ptLWlz0nzhUd86jIX/ubmTLFZIe0AuD/rAVu2PPs=
X-Gm-Gg: Acq92OEYhmLBnnnTCNH46uzDgpD+gmp28h+75eHzaykVtDDP9BHOuCx2+wQMT1Vqhcz
 RxunbLfYQNNKaPgekWDEuac9kyR6zyiYwGdiBu7abe1JFuRsmoFYnFZSicI0qZndEJr8LdKxf1C
 Dko7mIDwUDK7+fWElpCyVzoIwEF+zruz7l9ZbbII3Gk7OJr2Z/E9nWtlvaVj5ULjO84SgrzlSP0
 0jSt0ZwWkvGlFcnodJ9DjwbCZaDwtSzxlvAGxWUS8P8i1CMpN3blw066JAE9LG6oUPpvSr8w06z
 5Ys+GzmfZCIoNzt39qBpOsOhXABhH/v1aBSHC9AeLEyHicyney9BcvXc22QAmSHyCC/rUG34hck
 gt8etr1xTRH1FOXCWaeG3Ay7Ln/qddhpk1TZM/TQjV4zvbxfitq/YUPZcgCNXHMryiu4fUeJfBL
 kTlFY0yGDnYHyumGLmVI8soyPP5Y3fGlv1QUKK+7Lq+vXqjCV0dLGKjIXg+A==
X-Received: by 2002:a05:6a00:2d17:b0:839:44c5:c321 with SMTP id
 d2e1a72fcca58-845247b623fmr4452871b3a.44.1781715793179; 
 Wed, 17 Jun 2026 10:03:13 -0700 (PDT)
Received: from [192.168.0.4] (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8434ac9cd8dsm16237517b3a.1.2026.06.17.10.03.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Jun 2026 10:03:11 -0700 (PDT)
Message-ID: <53438e7e-0d13-49d9-972a-49b6ba4488c8@linaro.org>
Date: Wed, 17 Jun 2026 10:03:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] target/sparc: Include missing 'accel/tcg/cpu-ops.h'
 header in cpu.c
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
References: <20260617160426.64461-1-philmd@oss.qualcomm.com>
 <20260617160426.64461-2-philmd@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260617160426.64461-2-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
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

On 6/17/26 09:04, Philippe Mathieu-Daudé wrote:
> target/sparc/cpu.c implement a TCGCPUOps structure, which is
> defined in "accel/tcg/cpu-ops.h":
> 
>    1040 static const TCGCPUOps sparc_tcg_ops = {
>    ...
> 
> While this header is currently included indirectly, make the
> inclusion explicit to avoid issue when refactoring unrelated
> headers.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@oss.qualcomm.com>
> ---
>   target/sparc/cpu.c | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

