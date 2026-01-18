Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1217C9830C
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Jan 2026 23:12:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhbwI-00033K-3g; Sun, 18 Jan 2026 18:12:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vhbwF-0002xP-Mn
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 18:12:07 -0500
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vhbwE-0002Gx-Ag
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 18:12:07 -0500
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-81f4dfa82edso1683979b3a.0
 for <qemu-devel@nongnu.org>; Sun, 18 Jan 2026 15:12:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768777925; x=1769382725; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=udhvTu+pxgsH86Rid0ugXWTbdFW8ltO1c0WIkM752jI=;
 b=tYQWubfLXoUCSRBxES4/l79Q722PHw2euWic50g1/eVRVDQsgBVdNN6Saqx1LvSf+D
 4i28uSssBhqK1MPLGLps/5jmkN0aJ7cTUR+KLdVD4pusHoGkwNPJ3q85PbJIv6bHrsoC
 A9wPAdYfIq7ibIBEOTnowvIo6p0UWF8ibEJYvvEv3HwxIIHyfu6e1geYbyM/7/dRHTiU
 7OrpqG+ocD4VdGVKhSatvvhQE1S9dXHq2Yf8TDvlNLtVKU76pX1ytaYVGlAedHxYwh2z
 UgIXhHsew30v5JTvo1Ox8AvoVf03E7RgytzPUECU8wZD1VcFcrnsJkO8pmV/Q2IWbZgl
 9yhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768777925; x=1769382725;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=udhvTu+pxgsH86Rid0ugXWTbdFW8ltO1c0WIkM752jI=;
 b=IkTmmwO/x5igiTVkpBbwoID3XXnDxkF5EQyWYPBsvT+pwQD2cl0MhmG/id+/sH2Gob
 MkLJzA+kbzMDwHy0kzosgRF+xyK94BS0iUWaba1BT+Efh/lU8qCAQMJDMfwY8uptLuI4
 bGw+A/AoT/qsAZPP3gS1bDqOx6WoHMtNNwcfyyFd1WNaIjUu6Y9vaHza5C4VTWrYVyWn
 cy/Y3QZ25mTD567ia6GRhmtdG6A+I3Gg7Am5mBSWY3CpoENb49I9OT3OkiTLO1KnpAOY
 S2kc+IxAXD32SVxxYPLpul+2aPojA2+2SYSXJxKz+5RoPPPBPZkwbwykD/YiNsaG81V6
 hBAg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVG0E16oov8YOj99SQ9dJ9Fz1HxpW3lMaoMt4okBQWswF6lobdDCi148+Fx8u2AhD19T99Vk6Rx5BbX@nongnu.org
X-Gm-Message-State: AOJu0YzEs/IKFjA4+UcuQC6IfADHJJo2AwRi3Z1Y0WZ78YbaTR0Chu4T
 HFqwPDQ33GcnikdJg+w7BQ9tzbW80DvOuJIHNr/WM4zNPDTutOK4yAmTiluhuKTuduA=
X-Gm-Gg: AY/fxX7GfMxLZbqbgp600Yp1cBVAMvgxwDOne+2DY0AszbcBBYNMR+rRAC5JZoYd6ff
 zBO9/570K2ekGz8KHWcDnqbJOKytPrLaA8ebXX47VW9899ec9xr4I0iVLWuxppKqbYsL4LellJG
 LA38jyh0/KEyU9q+Dbw3fyzFoY8wpjnO1MFQGM3gbY94kzKQrfBOK90PaDt8m9I2OvYRjtlbZ0Y
 TxnIsQRobSiY3xNB36C4KSOaI2mNqtxhc0wd0QR38WRwoQmzE1/A04GGSdgKuvSygili7OfXWR4
 NB1ZlnS71SKssTiTQZEHp7S2NTbPOiVGO4U8F4Kz4/k2fPN9wG/J65Fegle/12/v8YtNQpHXtK8
 DQwAqByfRoO57AXAXW7bgTSmeEjRiQr9RGM4YfWFddCm2c8I9PzkMtnKD9bL6QuapOmZmC0l5Ap
 W529ijzAGIXgLeNu6qW90bUlX98T+ptw==
X-Received: by 2002:aa7:88d6:0:b0:7e8:4471:ae6d with SMTP id
 d2e1a72fcca58-81fa1862fd1mr7456159b3a.57.1768777924775; 
 Sun, 18 Jan 2026 15:12:04 -0800 (PST)
Received: from [192.168.10.140] ([180.233.125.201])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-81fa1278061sm7398977b3a.44.2026.01.18.15.12.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 18 Jan 2026 15:12:04 -0800 (PST)
Message-ID: <3ea89a04-6a45-4f05-99c6-117eeb37d2c7@linaro.org>
Date: Mon, 19 Jan 2026 10:11:59 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 02/18] bswap: Use 'qemu/bswap.h' instead of
 'qemu/host-utils.h'
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Anton Johansson <anjo@rev.ng>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20260118193509.42923-1-philmd@linaro.org>
 <20260118193509.42923-3-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260118193509.42923-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 1/19/26 06:34, Philippe Mathieu-Daudé wrote:
> These files only require "qemu/bswap.h", not "qemu/host-utils.h".
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   tests/qtest/ahci-test.c              | 2 +-
>   tests/qtest/libqos/ahci.c            | 2 +-
>   tests/qtest/libqos/generic-pcihost.c | 2 +-
>   tests/qtest/libqos/pci-spapr.c       | 2 +-
>   util/hbitmap.c                       | 2 +-
>   5 files changed, 5 insertions(+), 5 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

