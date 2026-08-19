Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D613C5DF85
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 19:37:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwm6V-0003GD-Ti; Wed, 19 Aug 2026 15:37:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wwm6Q-0003E5-35
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 15:37:37 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wwm6O-0007DD-6g
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 15:37:33 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-84e507b079dso889380b3a.0
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 12:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787168251; x=1787773051; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=7ZaeDkl60OlUq+jVOlZ9u8gBz7HA5EqSjefpFI1DsSI=;
 b=S0z1WWcz0yieacbfhHa8hPlHKaDrVMlIe+/soWUy3KCqMsQrWxsbaXnLqrLwtbyfNa
 PN4fZ3rf49F+iBqHevxCj4k0QWkA10Qr8oSGJrNlodK/oBAvfPxBcTy8cv+EQR8nJi8m
 n8qwX4QX213s7xjaJb2naRH2HoBKGiJ51WWw/QjCKyNJ6fdgCKABgfrhhO2MQo365HFu
 VORgmY0XkhLIXVBjDy0WOdVkttSGlZNcBKuPwpQRPConkZi5jcQqa75JpuayQfcXZ/ZH
 UyXDethwlga2KJz3GA/P8wezrk4XI1glW8rQ2/oZH+rMHZKSDnIIvjIxwF98oWqgmVf4
 Yfhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787168251; x=1787773051;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7ZaeDkl60OlUq+jVOlZ9u8gBz7HA5EqSjefpFI1DsSI=;
 b=CrQiY6C7mNxmVtMKgltWJPNg0Q4Ny1maI/keVnkgfipzWs4L2L7qLYcCCFLI0b3LRg
 zZCHcGCTSaFZ6SRxPPEL3uV08Og4PFy7/k2nua/dDqG+bB2A6RHdNDEB6RvWConGbWtH
 CFoBdl+gPEtRUumF+rJaaqGMdcSp3WmBlXaHzIhZymge2MLGtEigr6nLdoS0tc15u43j
 8FC09bmrbi9J73RcDPC9fIegJus4+/Ta3ksv7y4WGbm6M8fjbi/AKAZQKE/DuzezvBhX
 NsokozBbIZNKpy5RBpYLcuRtFcrjIL72KlkqSTXYJdOnIfKLwSIPcDxj5cF4CWdHU0N4
 7rZg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqjlgZCuYy7BIUs2mMM/LkN2gWcjVpXko/bcMz0t99dTryqQ5LwgUz0SCMtdUX9FKlCTSkY3ALHyv63@nongnu.org
X-Gm-Message-State: AOJu0Yyb8kCFV7TlkNKYN9DrRDO5FIloAzBi2sDe80xviHnDyGaANnSs
 dTe+YafQoZBg0+mi8RJOdRD9/++0AorSsc/RahVJDW9y4Mg7W+l9VR7WaYUVcT4qHYLx15SIJOm
 w6hWKbJw=
X-Gm-Gg: AR+sD10nbvYOu+SL2V5jLPTuSAxihQm9mxzSAtsZqrpxfeblexcabdE+bDEsGFI0LJH
 sNkAZ9Xd0h1CuZvkk9TLRIKtxcAYbxLzNjG9+yeF9iFWA8JduNnSg+CX6lL90erI7xM3SNkJ8XQ
 CbPhlFIvyfDnmDNShSgScGrHGjSOgTakEnvEZzY3KYWVWw1jS/qLYxG83bNXdjAdRG9glLZkBC2
 i0Jt/aYGU4PBIwC2nBNJTHXG9yU5hZQWlEStHR794KPPzVNidUbtjb3+UWAeoZ4h4FdmzuKQ6Ov
 qyN+9hpAo7C/739dHCi40duuks0xEEj0ZwmtR3U99CFtWKiT9KHxxJGYA693Z0qDL7369vieqfp
 IGcSfJ0tNtnzXB/l9S7CE0Y1Pv7IdzWMeCbXIO80ftgWyWbiiE/91T4hztGeLXG8xYK5pR7X8+P
 vwh6AvVZzPDfQdgNELifYy/6hHYndTDERFSAUWW8rZBbkxfiqf8cx/Dj3JX21Fw1Jw54uSjmmtH
 pIcg3ZudjVUuJSKkgQ=
X-Received: by 2002:a05:6a00:2451:b0:847:99bb:b6d0 with SMTP id
 d2e1a72fcca58-851d3a6e664mr11162444b3a.15.1787168250733; 
 Wed, 19 Aug 2026 12:37:30 -0700 (PDT)
Received: from [192.168.122.51] ([173.164.107.233])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-851d33629besm1000952b3a.1.2026.08.19.12.37.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Aug 2026 12:37:30 -0700 (PDT)
Message-ID: <279ba699-b51b-4cf8-a0b2-faf51302c0a5@linaro.org>
Date: Wed, 19 Aug 2026 12:37:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] hw/arm: Remove spurious WM8750 dependency from
 Realview Kconfig
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Jan Kiszka <jan.kiszka@web.de>
References: <20260819185430.3467629-1-peter.maydell@linaro.org>
 <20260819185430.3467629-3-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260819185430.3467629-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 8/19/26 11:54, Peter Maydell wrote:
> The REALVIEW Kconfig stanza has a "select WM8750"; however the board
> itself doesn't actually use this i2c audio device: its audio is
> provided by the pl041 (which connects to an LM4549). Remove the
> spurious dependency.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   hw/arm/Kconfig | 1 -
>   1 file changed, 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

