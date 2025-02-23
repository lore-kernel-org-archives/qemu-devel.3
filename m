Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B277C021B2
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Feb 2025 18:07:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmGNv-0003Sc-Ay; Sun, 23 Feb 2025 13:07:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tmGNq-0003SG-0R
 for qemu-devel@nongnu.org; Sun, 23 Feb 2025 13:07:19 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tmGNm-0002sc-JL
 for qemu-devel@nongnu.org; Sun, 23 Feb 2025 13:07:15 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-220bff984a0so76612655ad.3
 for <qemu-devel@nongnu.org>; Sun, 23 Feb 2025 10:07:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740334033; x=1740938833; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bSd23soFX2ostxGKhe2MSVL+YYc/0wk0BpM0ztRtfI8=;
 b=b2kjhGFfLSDu+Da1Y4lj5GL9yZy+ysgem36WM2i9soBxjUK+KgG12tiwrdYcJsr72h
 6JhlZID9O1uJTuv/KTgvvK5DljJMJOrwWh2auWZzy2d1D9zHbaz7S6laW/DueRW5k/9L
 tfbK0F6laL6gLglH/Uw2vzlQBsFkVlUVzLhDdJhcuJJS51Fx87xV3Ov2EwSkldd2nsMN
 bowhSXknL7udn4ju3rk+R/RHqdlH6nUAPcOBFoSHee1U6qFoVfzbeciLy1mpkvlv9p+y
 JWN5u7Fn71MQ1OGwhn1+PCUCN8bu71YI/UABAUEcxudDJGwD4VyHzKHTE7fgjGWXqFUR
 mJ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740334033; x=1740938833;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bSd23soFX2ostxGKhe2MSVL+YYc/0wk0BpM0ztRtfI8=;
 b=tz3/k19zwQaIsDB0aYowVWljXpEd/3zC64d2Nrt0BNXjD9rkmAtdub3ihqjzioDso7
 wErJ280TN9M73U3tLxFZqivexKSgBpRX5tb9nmz5mienwSxlbr8RlvV8EpAxBq0xbwl8
 I4oOSy59LpeBQ74zv2pnNg5yLPoiJPuXXgfmBLvF2lhHSYEJiKUM1Evyc/oIWl23YuFw
 J/W9DVX1gL0+il4VF12j8wCtocZXGs6fzDHQt/0ANU0IZOYT9/roj7iR4/M7gg1L4hDq
 mVd/3sMLondNVMG/XaROrStS6xCDXcpx6klqVBVwTAU1LX1k/42tL6hPCEOsIlrR5NJi
 9PSQ==
X-Gm-Message-State: AOJu0YyZWUKqVyOrjoO9VXe1kEcSaO9fEBsz/kiKEnVfLaYkM4ARVdhd
 pOZaYg4YiN1yPAE9prmb5MpBw+RC+XR/51ID5UK3yeU3KM84KvlMAw7DxYofZZiJuXh7CwGkB2k
 k
X-Gm-Gg: ASbGnctBop/e1ShGbzQCQ9JzBh+ARnXalnvGTH6WInTNCNYjSssxvs8BkM67KhmMAuf
 Vp52e8JG5S7Rf/vq4cr0Sq9+jYBqgRKdr3NwsdGBqQu2IcKY/T5/KykbtpLyo8jkhsw4/+Z+if/
 PiSQoVdQfY1lTuu/d4QP6Q1Ssd9iGOAsPBxtzBpTTzVWK5kP+DMTvznVhVeKilXUgZq2hW0wlGC
 /tSBQFihH5xtrECvWB+y9VcE72rMU0edAq2jMB0Xnj3mbx7FHhXyKVyfJ0At/cUcauVui4o9zdK
 UQmLo+12LtJn0I10M6aVHqpAwIoluHTZs5k/mW6UzzONFf5el6swFlsPhhR/pCsO5WeOmCWieUb
 byb8xNHk=
X-Google-Smtp-Source: AGHT+IEimqicSXYMuyTs23eL2rg0tTCwtNU+AI20mirjDY8Kaq3C1Df9akOGp8aglniLtLxHev41qg==
X-Received: by 2002:a05:6a00:17a2:b0:730:8e97:bd74 with SMTP id
 d2e1a72fcca58-73426c7c671mr16558915b3a.2.1740334032807; 
 Sun, 23 Feb 2025 10:07:12 -0800 (PST)
Received: from [10.254.143.227] (syn-156-019-246-023.biz.spectrum.com.
 [156.19.246.23]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7324277be22sm19207606b3a.158.2025.02.23.10.07.12
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 23 Feb 2025 10:07:12 -0800 (PST)
Message-ID: <7f8e2ffa-bc0b-490b-8fc7-1f97319ba737@linaro.org>
Date: Sun, 23 Feb 2025 10:07:10 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 9/9] hw/char/sh_serial: Return correct number of empty
 RX FIFO elements
To: qemu-devel@nongnu.org
References: <20250220092903.3726-1-philmd@linaro.org>
 <20250220092903.3726-10-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250220092903.3726-10-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

On 2/20/25 01:29, Philippe Mathieu-Daudé wrote:
> In the IOCanReadHandler sh_serial_can_receive(), if the Serial
> Control Register 'Receive Enable' bit is set (bit 4), then we
> return a size of (1 << 4) which happens to be equal to 16, so
> effectively SH_RX_FIFO_LENGTH.
> 
> The IOReadHandler, sh_serial_receive1() takes care to receive
> multiple chars, but if the FIFO is partly filled, we only process
> the number of free slots in the FIFO, discarding the other chars!
> 
> Fix by returning how many elements the FIFO can queue in the
> IOCanReadHandler, so we don't have to process more than that in
> the IOReadHandler, thus not discarding anything.
> 
> Remove the now unnecessary check on 's->rx_cnt < SH_RX_FIFO_LENGTH'
> in IOReadHandler, reducing the block indentation.
> 
> Fixes: 63242a007a1 ("SH4: Serial controller improvement")
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> Reviewed-by: Luc Michel<luc.michel@amd.com>
> ---
>   hw/char/sh_serial.c | 30 ++++++++++++++----------------
>   1 file changed, 14 insertions(+), 16 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

