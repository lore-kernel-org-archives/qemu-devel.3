Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A18ACCD1A5
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 10:05:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vB9EV-0003Zs-34; Tue, 21 Oct 2025 06:04:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vB9EQ-0003ZZ-Df
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 06:04:44 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vB9EM-0003YU-NL
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 06:04:40 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-471193a9d9eso48595545e9.2
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 03:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761041077; x=1761645877; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zrEth1XP6xGs2sKx42w1lY93vz+lWYWYh+FPp3nRTMQ=;
 b=yfkrmupFN7UtzglF5ARh9vRW63COHq4ZYOdSlO7JRyU3x1ZCedmk822eb0vfk9T2H8
 3NY0L5BW/7cVEezOgpOLqRz6+6q+qy+aTEk+WMflAkhy5Qx2+PZqGSa3NC4ua7ADsbA2
 t4J4qMHJg0Ap6FAbrk7dAl+4B2cbTRslVxymIAzzRZAulvDeewTHloGkswtJiSf7IP/o
 oiIT1/T+XZPhzRx4Ohleqow2bkyChCygYaCBx+5tWhyP0LVfNlKLVVxMiJAX1tvUT3Or
 ikNHmIGi0ZEuyyXYACafxn3C6Qrpyg2HFgTNQ8E33yDwDuH9uxquTrRRjCPNevE16/Kt
 npTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761041077; x=1761645877;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zrEth1XP6xGs2sKx42w1lY93vz+lWYWYh+FPp3nRTMQ=;
 b=CHcZ/rgKwbsFVlVekl2ZX9ItTYTjZqDwyPUyyinEcbow7wOVB7zy5AYMw2eB+E+6Af
 XnDb/LfY+OgA+Q/dRBNmrOF0Y7wDsO516Vw33d8nqXwgK46J6mztayqVYh2UhbcrP8o4
 2yqCM6rhceDmFz357gXa31g5A1YiMqR/6on6aAnZ1N0SR7RWonGVrYx4GdYy08cGQcd+
 ovXUaD+yCs3KaxYV8TjDqIo4rHhFzy07AZHxT7k4rchIA4NWIlmab4F+ICScLrKlwyUQ
 MkKJbeCaVZzVy1phVT+PNj3+6zPX7LVGDSxEZOxjxAb+lEJ5QGJ+W+Hcg6sPaBn5r29w
 e9Jw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUfvjeofVBG+4vYt70EmdGHquIjw6z84mpOt0SXfCDro0FDR5EOAyyRPf5nktosG1/VXeriiwNZojUc@nongnu.org
X-Gm-Message-State: AOJu0Yyd2UIBFy5dz2bPwOlB87xIz24/8JpKf8ZKE2pxEXpNjxzvstEP
 OsL2pbGCN9QVIcAMcG8CTeSk+AFiS4Fy2JGdZcTJsDuXsVPhfcqEYKOfG/bqa+voklQ=
X-Gm-Gg: ASbGnctl9w/6kqZLTH9yO+uhlkPmoLgsARowxe76m9+aNQsQRNRN/kXHJTKD26UEMeO
 k5I/DSLXDS2iyh5L7+hQEY1q8EDOWVPpq1mLk44V8xutci38JNjknTFXLvH/XVUHvm2z1Knb9wP
 XlNtW7AvwRJ7CLR6w5xtvuk8xrvfMkdOTggrJ8L1eTr/2EbM5y1WNVTZBSYRUwwXuu9cDocy4b0
 a3r7LOBzhQr5OT9NFnRTyLgU6wA/q5yrMfOFi9yMejMfNIZOgyMlceBgTG1KJNC2fbbWM+p0qS8
 /UtX3PJw7GVmS7XiB/75ajLxPtiNSelGB1BdZR8zoKTjkdaxzYacQXB7pXczkqfFlCLSdjzHPtu
 1ivk2fHb1JTQF3wZRTLF0ulnIgDcdMtx3bi9Osd+jzsKAOuQaf86W04cf6WndMikTUQbJrG5xKy
 Hh6TMi2gclhhW53PH4A8Fg7sf+SWuVQhIvrICOSPZqQgU=
X-Google-Smtp-Source: AGHT+IFBPzJnzNGAqd5QohFm00w6DteOHi+5mDoycw5Lj6/WuNtyvPHGnJcxivKUo5mwgq1UJE933Q==
X-Received: by 2002:a05:600c:37c7:b0:46e:1fb7:a1b3 with SMTP id
 5b1f17b1804b1-4711790b56emr99185395e9.23.1761041075459; 
 Tue, 21 Oct 2025 03:04:35 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-471144b5c91sm272016335e9.11.2025.10.21.03.04.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Oct 2025 03:04:34 -0700 (PDT)
Message-ID: <5df75eec-29a6-46df-b2c1-95c32a137866@linaro.org>
Date: Tue, 21 Oct 2025 12:04:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/43] hw/audio: rename model list function
Content-Language: en-US
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Volker_R=C3=BCmelin?= <vr_qemu@t-online.de>,
 Gerd Hoffmann <kraxel@redhat.com>
References: <20251021090317.425409-1-marcandre.lureau@redhat.com>
 <20251021090317.425409-3-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251021090317.425409-3-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

On 21/10/25 11:02, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   include/hw/audio/soundhw.h | 2 +-
>   hw/audio/soundhw.c         | 4 ++--
>   system/vl.c                | 2 +-
>   3 files changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


