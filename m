Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93553E77187
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 13:46:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNuL1-0001yr-E7; Wed, 18 Dec 2024 08:43:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tNuKZ-0001Kk-Aa
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 08:43:16 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tNuKR-0005ey-Ic
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 08:43:14 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4361f65ca01so63008075e9.1
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 05:43:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734529386; x=1735134186; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BpfgCgqmjRnFtWOFA/8n5tIUZ3UhRJDzx4+XUahnt+k=;
 b=ABGGdBImiLaZ6L3zboa0U3yca+vFQPHKIxCZBmQ0rf+Fz+Y4glmLai0MXCp/WHJg+q
 sDd1ehkEpM04TT/YKXWQ7Iqx1QvwsCrw/J6eX/KSnsO5xM24AHcqeiuK6khlxHPs69ue
 eyFp/q29jdVnH9YxAykbji96iBgsouuMOYZjPu35ldDdSBXfg3cxDxh2+k9K+8GJ/GOn
 +IAyaX0ThhR7+jUd5lE72CCa+8a/IyGGvO8+/f9XOGwaNNf0SWPfms3s2JsezrjV4wth
 t6sFq4bP2XdgivvPCixI9i79B7YP9viezapkLeEsGtnvB8oOIEgatXafTkt5MPbHtQDG
 jKQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734529386; x=1735134186;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BpfgCgqmjRnFtWOFA/8n5tIUZ3UhRJDzx4+XUahnt+k=;
 b=Uba9ySZq0rE1pp3sAfURn6cCA9XkJ3WEV99pKTBFdCxQrA4Lg8vTpw5T2ezeyRafGF
 bbwpu/bv3mX31U35dJFlVLd0A63ZCD54x0UjyQPaAvMW77U0Ddv5YjRWkLhvVk1kqD2K
 xWTC3yCIahTJ1m/ywrHZ8zGxxbmXuzF+1abGG3U7/epuzMRMRjZfYQVAiEX4fYcO1ahl
 OhvJemMoHK9RrhrFw81qLCoXQKPRUmsYG4RExZDUVDszpWua0MUNRA28UAVIjrFGYlOu
 E8Q5ekxV3wYqmKkUEhMg5f/ZbzBCgzidg+J6vSmGa0CO8U6pi2HsVR9LBTBMYwsl+Wb9
 Wv0w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUjUDqw5dypzRXJQ6f7U7HZU1Mmwflmx3OUjzxX/qymhXebkX5pnDik9UpEKDxSvNL6s6mjfmUB/FCM@nongnu.org
X-Gm-Message-State: AOJu0Yznn7SDU3/YLHgoyhfUeKMHahOF6QHBO0Dc3qIswKBvMaUNi4ZR
 2pce4gUXPDQOmaVapOtgznFaaF6d13BLah0ExcW8BQSVe2onRlF4G6AeveUMvuo=
X-Gm-Gg: ASbGncuGiWBPvUNtwE+e2kBJtcC3ftikJddtuaXRC7qgn8veQXavh2TcYvPN3PEAHUB
 kY0JrcjVL2sl7+PJG80UtrrWwwAbSbZgSjWDT0kdpJq+086RnQoaV20jv3CrZ6lhMLrYFP89efy
 1RCqHoBPNXKctS2NG1uvwulvjjHzME8fZn6/SZPfmNKKlNAzCOkjjVNRiR84pgQIWNt0wD19VxH
 jRKcyek8+84edhoESe2yOxwBFd0/QBvEjT8pog3IokL2u0uP0J6SYexQ0gZcRoeyADqJVoQ
X-Google-Smtp-Source: AGHT+IGMDVw0UvdLp/ZKIs8ScGhZu8pCTr4YSAgP21wA6B7azBCoRNbI0hhp4SbT+lh1tmWs6Gghlg==
X-Received: by 2002:a05:600c:3b0e:b0:434:9df4:5485 with SMTP id
 5b1f17b1804b1-436553ff1ddmr23633015e9.32.1734529385746; 
 Wed, 18 Dec 2024 05:43:05 -0800 (PST)
Received: from [192.168.1.117] ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43656b12498sm20622655e9.21.2024.12.18.05.43.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Dec 2024 05:43:05 -0800 (PST)
Message-ID: <b51dfeff-c567-4f21-95ae-59a59f371085@linaro.org>
Date: Wed, 18 Dec 2024 14:43:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/7] rust: pl011: extend registers to 32 bits
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org
References: <20241212172209.533779-1-pbonzini@redhat.com>
 <20241212172209.533779-6-pbonzini@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241212172209.533779-6-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 12/12/24 18:22, Paolo Bonzini wrote:
> The PL011 Technical Reference Manual lists the "real" size of the
> registers in table 3-1, and only rounds up to the next byte when
> describing the registers; for example, UARTDR is listed as having
> width 12/8 (12 bits read, 8 written) and only bits 15:0 are listed
> in "Table 3-2 UARTDR Register".
> 
> However, in practice these are 32-bit registers, accessible only
> through 32-bit MMIO accesses; preserving the fiction that they're
> smaller introduces multiple casts (to go from the bilge bitfield
> type to e.g u16 to u64) and more importantly it breaks the
> migration stream (though only on big-endian machines) because
> the Rust vmstate macros are not yet type safe.

This also better matches PL011_OPS::impl_.

> 
> So, just make everything 32-bits wide.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   rust/hw/char/pl011/src/device.rs | 36 ++++++++++++++------------------
>   rust/hw/char/pl011/src/lib.rs    | 23 +++++++++-----------
>   2 files changed, 26 insertions(+), 33 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


