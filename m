Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65A57FF8864
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 07:52:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHziO-0002Hj-Ky; Wed, 29 Apr 2026 03:52:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wHziI-0002Gz-T6
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 03:52:06 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wHziH-0002PP-CW
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 03:52:06 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4891f625344so5921755e9.0
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 00:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777449122; x=1778053922; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7pfTNdgZupOA/raaRL2jlLYSWQUwKZXZl7e3Fr45oAY=;
 b=xyrKaid/HyVEWIeGTTcoCwPs5JbHOggYUR7i5obh+EzwAkpcL7m1CYp43vVBdI9I13
 eBTXS4HL4A9WZncQDJzr8r4YL/oyRcL5Eyd3aw+WdKGlnytFwiyKyToeW5aaP9OAFAR3
 UOknTBZ7LS1yhmXvGfNPHTDSy7S4SXtvmkRB2o/0LwVRNKqvdrAjxBth9+Ogd3lmkY5V
 rTRPbnRSJXxjMDHzKxuys7UnWfrAInQYehbWLpgcBF9ltBKoYln6/T3XIvbThItgQWsw
 9A2RuxdE/ejmczMMlUV1VjU/EdYmooj+3ZlqXjr9TES+NCSyT/ORLrMLK1aOrWME2j6T
 USaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777449122; x=1778053922;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7pfTNdgZupOA/raaRL2jlLYSWQUwKZXZl7e3Fr45oAY=;
 b=YM+3wkFuuJfIjP6f5yjV9gwZYTSWaQLKV2wjo9q++m8bCbJRsA9tNwCQjeFZTf8Yna
 QnFRFR5s/OgRPBX/2DIrHtj6IWLpYJx6X1LK6jhJeDOFakA5TRM6kiycUUjRA2dHgh1U
 k9fceivUNBO/++4l6qVu7WNcpFx2FuD8x+YGII9OzysZYX+EkKNMbQttr0Uz3u6LpbhP
 UC5cCkgsLxGFePUE3ljR56pyfOHWxCuQYM2fQfP5PZfk7AUbVZ/Ic4GKOHkT7qKQJUjC
 ww6N7wvwsEccG+9CHNA0IahafxC2IR8TUJoO70mWp7n7P2I+AQLKpvYcvvyaXB1TH1Ad
 9IMQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9bjNP8tSbcGvxKOu7cHDroiPjbIRk0DuDcTehbsLqZdLC5lezjWZsGlJuMGIe618+PhHoRY+xh5cGm@nongnu.org
X-Gm-Message-State: AOJu0Yw7YXJaYfORpJUh1lTJ/ZYU+Q5z20HwqwomNX9NfsnJJe2G5R0/
 UT/yxniDnIzjpmZ+bw8L/yI7IKVgAM/AfEd2KRSwjmo8HegHm8MclmznlgGDHN81+G4=
X-Gm-Gg: AeBDieuA8eLbYnhczCPGga66TA4a7EV9NyehPq4UOo5gy7S40oyO3ktGE6ooPKd+T7e
 mPFGoaYHVsve0R/kyb+7i98DmTZu/u+noVUbRyoXBSw0UHh6QVYHdvG57bWqdcOIQDgnq8mbMoI
 FE6GbHiz08gN35zqvHvRTQc+HwkL0s20NTrgQN/V90xvrzHYo0u5LKLEU1gYuxhrm3zJMfX+2+1
 wgCi5j6OcR0gD2+0drtXeYqWcFDtQqUq0ei+4I5j2HxkOaYzVmNzz3+L9Fj7zDHtbOPI+El23OC
 xQ94evmmqUQI1b28IkoMu8I8T3600vLJm8sw0o41++hQRHR2zaMzMGqfUJJZqrHMhDQkm9QJQrY
 jXuSxPc8Fy6PA0wGjcX8MpKVs5T2z1YnIVWA6JEjwe7wap7qY5mODsdAo4u2hLFGw4lvvtjQ7ES
 vE8EKeQ5eynCQ9hJOVQwaBwWxvu5AnTjQS8c9Ww5Cuz20pdwTeds3w3fO2dynMEzjJfRmzrT4xj
 FYR
X-Received: by 2002:a05:600c:a404:b0:48a:79d8:a8d6 with SMTP id
 5b1f17b1804b1-48a7bfa1982mr27388655e9.7.1777449122198; 
 Wed, 29 Apr 2026 00:52:02 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a7c57b641sm37952995e9.6.2026.04.29.00.52.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Apr 2026 00:52:01 -0700 (PDT)
Message-ID: <114b0825-3d98-4b36-ae5d-7ccd41e4ea8e@linaro.org>
Date: Wed, 29 Apr 2026 09:52:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] system/memory: assert on invalid MemoryRegionOps
 .unaligned combo
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Tyrone Ting <kfting@nuvoton.com>,
 Hao Wu <wuhaotsh@google.com>, Max Filippov <jcmvbkbc@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 qemu-riscv@nongnu.org, qemu-arm@nongnu.org
References: <20260428093339.2087081-1-peter.maydell@linaro.org>
 <20260428093339.2087081-5-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260428093339.2087081-5-peter.maydell@linaro.org>
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

On 28/4/26 11:33, Peter Maydell wrote:
> From: CJ Chen <cjchen@igel.co.jp>
> 
> When it comes to this pattern: .valid.unaligned = false and
> impl.unaligned = true, is effectlvely contradictory. The .valid
> structure indicates that unaligned access should be rejected at
> the access validation phase, yet .impl suggests the underlying
> device implementation can handle unaligned operations. As a result,
> the upper-layer code will never even reach the .impl logic.
> 
> Add an assertion that the MemoryRegionOps doesn't specify
> this invalid combination.
> 
> Signed-off-by: CJ Chen <cjchen@igel.co.jp>
> Tested-by: CJ Chen <cjchen@igel.co.jp>
> Suggested-by: Peter Xu <peterx@redhat.com>
> Acked-by: Tomoyuki Hirose <hrstmyk811m@gmail.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> [PMM: tweaked commit message]
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   system/memory.c | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

