Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCB16F513E2
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 22:18:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyH0r-000119-Us; Thu, 05 Mar 2026 17:17:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vyH0p-00010M-7m
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 17:17:43 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vyH0n-0003X6-8e
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 17:17:42 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-483703e4b08so83523555e9.1
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2026 14:17:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772749059; x=1773353859; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6o7gJlSzox/1LQ7u+8u2lPFR/PjezTFDExdWlHtAlbM=;
 b=a/KJwL4d+Sa+D2IMljXpCZdI3BOAz9qgcsn3ZQoMbty+bGGxlThci3QfsCsRT94hjA
 WkAEEkZD6RBLxbLCDDIWPmLIoC4ol+6oHg3Cx876l8Un+zg9P4ioE5/sxNzh0Qg5K+Fc
 0IUcFAYQKCfo51I4JXBsOJrGR3BaDlf/p8JLpnSSvR1xpfMz5Uc/g/um5gFb+kvE75px
 Cjasz0DUCq/NHuvLVmMIBc5UWJIrS74P7jCec4uP8LqG+tVlB5/HXsapSA3g/v4xUPch
 rQd87H5uQWG/MRxZTN1GQWBrH5vz+L/RKSeHc2g3wgUyEgQ5M0dzv9syiGH/YdLSu3AA
 k9cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772749059; x=1773353859;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6o7gJlSzox/1LQ7u+8u2lPFR/PjezTFDExdWlHtAlbM=;
 b=FhMvLQ/D1QuOz73aUPCiJysmN9nxeLHs4Dr9oosyqwK032aDPsfIPmAUc5u/tEMtta
 L0vjNf2Trz+9564622sy7LXYOwO9JRSRSzyIQurCEt+E6PsSYtOkx7J5txqsJN1ogmc1
 ywKsielJ7JtS6tKpHI4tIfNEMzMBI/xxfSSK0AySDUbRP25RW5mXzEuU94cow4wLH57O
 oqm/DCJXGJdHDL76gdRGIFAfGpfHIW9kdY2/siu4FQwQuokW/pHz7oVESPiYb35LbNW0
 B3vSy0ojo/PqNNq5US2YHgORlrU9TFuP7UYosGgEdT+xM5ONYMEewI7VRalkYmhZHBp6
 WVEQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVtuY+HGP4crI3W6A0lniXW9MvJtBDI6EuWmtbN/56+/E6dXS/VBjj59r2HKMLWPJe3B94MVKhyKSCo@nongnu.org
X-Gm-Message-State: AOJu0YyqK3OS4SwHi2N7sa0G+otc3UjwiT3ioUwveX2+geXvDZPPaToj
 7myV2tf++OZZ5+BETpVB6Km44aifZvhsddwvDtdQAjBj3f1B/ND/NQBRQq3cR5+EaJo=
X-Gm-Gg: ATEYQzyz7Ov/3RlXzt6JvuwiWLrOcEG6k1Haa1ia+g0VPYuDCgBBSHyea766DfbA5dJ
 IxjxisMMQNr4g2DSdXYfHXB2iXCRr8HposGYnDzLC6zwRSqFfAfZwxKEq9nLbzx1PcoiAt/UpJu
 KmdWORZKNm+VirOZijnj4NqOibRc1CPA/arts2ZbnmJvzebQj5EILC8AvfWkDCPSKfnBVs7SBUF
 YZkepadqMDLBuqf2GyA54D+TZV/8CXs8ey7effMONuY43Bi5kfp659VDBzDkhTvwNC+v/E16wBm
 /tccj0Vjximua25AhovZhYH1nNO/b09pc7983032Sq7muu3VRt7HYASxMKikh76cgFYyiN4z7gK
 UCZM9X8dvKqSSY+GbLSBfvvBpcwEZNITZpaZHRIB/xbsNoZylfikqXHxlwu+KeSSCnJE/7NIRci
 YQtgdizDBzh6tS+Rwa20oUfbbXqS3HvtDGo+Ci+EGid5TijPaNKiwMz1ObiBz25W1Q8g==
X-Received: by 2002:a05:600c:8a1b:20b0:47d:7004:f488 with SMTP id
 5b1f17b1804b1-4851ee992d9mr53143545e9.10.1772749059349; 
 Thu, 05 Mar 2026 14:17:39 -0800 (PST)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4851fb33815sm140413985e9.12.2026.03.05.14.17.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Mar 2026 14:17:38 -0800 (PST)
Message-ID: <8ada0065-169f-4e52-b5e5-1861e4d6497e@linaro.org>
Date: Thu, 5 Mar 2026 23:17:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/14] hw/char/serial: Prefer fifo8 methods over
 open-coding
Content-Language: en-US
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>, Troy Lee
 <leetroy@gmail.com>, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Steven Lee <steven_lee@aspeedtech.com>, Jamin Lin
 <jamin_lin@aspeedtech.com>, qemu-arm@nongnu.org, Helge Deller <deller@gmx.de>
References: <20260305220911.131508-1-shentey@gmail.com>
 <20260305220911.131508-7-shentey@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260305220911.131508-7-shentey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

On 5/3/26 23:09, Bernhard Beschow wrote:
> Use fifo8_is_empty() and fifo8_is_full() to improve readability of the
> code.
> 
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/char/serial.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

