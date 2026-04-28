Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46236FF886F
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2026 06:10:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHbef-0002f1-EG; Tue, 28 Apr 2026 02:10:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wHbdj-00027c-Ra
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 02:09:55 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wHbdh-0007oQ-DO
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 02:09:47 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4891e86fabeso121589485e9.1
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 23:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777356584; x=1777961384; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VJIliAY2FoDu9qYZv6alSSLBi/On3sCWsnPpCQuqEww=;
 b=B2I4rI0QZm8AK1rwvdUCoQvEgHPxYUZT64l+BF3YYibGRcTFF4ofPh9grs0KvVR/Xm
 D0K0TRIgwvDzPMGz5IaWUo/g9uyRNaSm3xRsihwJ5TdZ3MPyYuMojvOWo1LQWNu40XA1
 ly0OMUSEuOyVVU4RCtnyFrSySBODqgCLJi/WGP7VOT83aSQre1tgJgRj2ZMBUvu2Swdr
 2WPBqCxiC3x5jqUCIRvDRGv0+Kz2EgeD7L2jVwoPGMPCtIfYDo/zWVRCyvwA4yxcaqWq
 jv4IBYJ8iAOTLi3E+jSI4PHexRQmSIUUdAYJB80HH7SoGOgvjxZMpWuRlXYrdW87Zhg4
 rk4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777356584; x=1777961384;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VJIliAY2FoDu9qYZv6alSSLBi/On3sCWsnPpCQuqEww=;
 b=Bkq6ALURqOjTi3Tq+/3iAvzDGZt0i+cWyBbZvYn2AorOY43qsMjTmKwaq5uFaMNH1l
 TIH80UXFg+WqKdlSH9zA3ms23fhGHYDk7dy/uQ7AK/E78uBQusW34F7lpLBYzzGMcy01
 fLDoUNeaXDL7V/0yi5LEALxcmgatEYhKx60H8XxC+RGETkGgX36H7YdchUb80JYmKolP
 udEbLgLI7PKAjIyk+SKUUtqrN2p/uw3r/HOy2naxXJAlxMWiHo7HD/94keJ7PxdRa5To
 cCa4gis/ZiqpsCwzX44jUmcxDS7cklp1ywc8tLIWnmmBMKE//rTsBOy0AAcq/aabeoT9
 oejQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+mL/NPveAr54dQpnBO6ezwdZpBVd8ryJo9zePqDRtrxG8GtxecU2gYiyde1YtbdLhvFQd6ihqfRL1G@nongnu.org
X-Gm-Message-State: AOJu0Yx0j41FFC49eM6AzAeGBvelvsV5Ax6hOKLtdqZihhvl9HiKales
 mXXn48kL+BliBAr6ikJ2C+kE0OW/cA5dJasD7/eFqGfimvsmmbRnD7/Kse0Y3Flb2t4=
X-Gm-Gg: AeBDiesNx3R8yNqHeCUoD6yHmmVeEVdkW2mJY1vNmDk4H/FjX3EUzEzSC3r3NG5awOh
 LUGwf9mMxXufSVUfzWB+ohR1D/MDczg/UxrS7k6w4zQIjzWgSu+0H/JaoGbkE4jpWskeoZFAVue
 h35O1zP6JWxTl/55UwNdahYeCXi8qzj6QVZ0UYAzIxTLAeSPF9f4pIv5+hpdBzxLwPU0QXkzeud
 R4cgYtC5G/xYv31pq5h0jOhNKhEfz00SHGqJGNxhnfLmq3/jraOk6Q+AfDfqyRvcfoQtFrOBlqo
 o099u68PglSfTiIqN+xKaadUjRgc2e+R+kaO6X8/FQxXG5dloJI8LiPmYgASc0ivu1cRSDoLwst
 yzzO5uEBBx/xBBdTfZsFFXE1K74QO2or+pF1nV5jMBntCuvOtXDddc8+u5DnSmlas2JejILGzI0
 VVGBfQrmxrfb4RBWuNCynDgtZvLUv2RKeywcfth6JrrQDYGk+c2U9YHXWGqk7qCGw97SaIZSHXo
 W03
X-Received: by 2002:a05:600c:1d20:b0:489:6c22:e081 with SMTP id
 5b1f17b1804b1-48a777b4b4cmr31345205e9.0.1777356583599; 
 Mon, 27 Apr 2026 23:09:43 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a775d9329sm15932035e9.4.2026.04.27.23.09.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Apr 2026 23:09:43 -0700 (PDT)
Message-ID: <009e6600-be19-4c28-81b7-b9a4b45c0fb4@linaro.org>
Date: Tue, 28 Apr 2026 08:09:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 52/84] fpu: Inline bfloat16_pack_raw into callers
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-s390x@nongnu.org
References: <20260426134002.865628-1-richard.henderson@linaro.org>
 <20260426134002.865628-53-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260426134002.865628-53-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

On 26/4/26 15:39, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   fpu/softfloat.c | 13 ++++---------
>   1 file changed, 4 insertions(+), 9 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

