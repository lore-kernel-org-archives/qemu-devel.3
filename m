Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4464EF513E2
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 22:19:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyH1x-0001xL-S0; Thu, 05 Mar 2026 17:18:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vyH1e-0001s6-Hb
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 17:18:36 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vyH1c-0003uk-2V
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 17:18:33 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4836d4c26d3so67314415e9.2
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2026 14:18:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772749111; x=1773353911; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wBjm8FaMShg+Lf4yeMTdR2D3dMvooi3WnbAMYx3fv50=;
 b=Zu9QxqWmLschoVyCahSWw93rKWXiq4InvGBG1TrKWJfjGgocC9gCAy+6TY4yXIfJ2B
 8t0hnJCMVhTpKwPFGm5M209YnK5gBkP/rhsUfgNmlcwc4EqcoajfCnnLg2oL2GyU177N
 3ZDVXRBkDlIbufKdcUHQOIqC4xF8YgYWeOZosRTsRzmCjlraWDGOYFzPRD9fHTloRw+J
 c3r7xBSvmErgYoWpoOe8zCA3d790bxOAbG9o/P2CPSKV543hDEKCdrjhHrWQmoHHceO6
 doGTGXFSSebcK5iXfTZDOto3S+WSJhASuGK3GoYKUxRwTwTVwqzCJ65oh5UKGJAgUUCd
 SuIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772749111; x=1773353911;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wBjm8FaMShg+Lf4yeMTdR2D3dMvooi3WnbAMYx3fv50=;
 b=hQeoHamsFmJAprLx/wi4g+zjP9mT+q04cOaaEfb7BTa/LU/bvZNYQge9H6URvCVdIl
 e7nTpqlf9Cn0oe4iTpAd22iGW4u7zL7TiuhpYk/aoURtKQDbbrCrEbMt3qCC13ESOQqE
 g0OcgxQL8QzR2RIwOTB9BRUyA4rDvSVl8qWeY5hXdUVobRXaJoRJl5ij1INbCPSTS7+x
 RvQk12AK/rTD0eDpmoDuhxkfFzZzTnWsQPWG1EueTTqRecXXacGTUqkHhnSMi6VR4rTs
 8u15w3pIfJ2ATiCydw93H6PODvf1uHCfaL+180t08XIt+4zEUQ7OpONzWNGt41ClBxVM
 A7sQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUe+Cpy8OKazW80Vkl8MB8b1cCyys2xsbIyjnMpoSBPLFKDKypZBVvLBmUsbz6dcrzySpsh5bzG0o7u@nongnu.org
X-Gm-Message-State: AOJu0Yx5XBZr7T2OiQR1nBySZpDow/jrHZB+AorunBSpg3erFxrQy4Jg
 YVv7+xjln+odJtzJUjBcLQe7YaKAVo2cPvFpVkWksGA8j2blJRF3RTt46Lw/bRR9NWo=
X-Gm-Gg: ATEYQzxIYhCt+gnNwJkgB9pgNejCXwFpTFF9KwnCS2s7ytoCtoN4bPX79teuu5fb+9A
 4Bl4AlORhru9d2nP4I1VjDqeVuFVJEUvzlP7MT7D7dYFe81k7J7/Dh/7ba6MxDI7WkPkk9h4tfj
 HwyjTS6qmd9+fQPeF03gH0AAfnz1618J+DWd4mYA1cVjVT3JDrIpGDKCiFM2C+9P+FLLoYQ2xTX
 8zGhFR1RRPpUluljaeZfUeplFx2jp2zbZU+Re+nxoKPoa62Bz7kjCYCmajLG2UMulnkIRwE7o+9
 p1qnGrg6AazQuO/Bcjfl2xY75ik4jN51wZoN8Uta5VF/HP0EAsaPc0mEkucEcYm47tIROFG5AdH
 Tu0n01MOGcVr1CeayhwMv49Rf1zIC6wdtJpBVDzLcvLi12D3xJp5TEeHOwSMHf/K92/6Oh4dfci
 gu+091kysrLQXhg0Ch7zJXLi0R3wMvUEGVgXZZQQFLJrLyxvWntCngpN2iSdMSAYlNig==
X-Received: by 2002:a05:600c:1d26:b0:47d:5e02:14e5 with SMTP id
 5b1f17b1804b1-485198310e2mr133428435e9.5.1772749110637; 
 Thu, 05 Mar 2026 14:18:30 -0800 (PST)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4851faf3938sm67572035e9.13.2026.03.05.14.18.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Mar 2026 14:18:29 -0800 (PST)
Message-ID: <5713f127-0545-4516-9674-a57878cf2f1f@linaro.org>
Date: Thu, 5 Mar 2026 23:18:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/14] hw/char/serial: Reuse fifo8_num_used()
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
 <20260305220911.131508-8-shentey@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260305220911.131508-8-shentey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

On 5/3/26 23:09, Bernhard Beschow wrote:
> Avoids accessing private fields of struct Fifo8. Now, TYPE_SERIAL only
> accesses struct Fifo8 through its methods.
> 
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/char/serial.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

