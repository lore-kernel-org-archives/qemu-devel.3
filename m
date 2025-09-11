Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B9B3CAC58E
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Sep 2025 18:05:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwlfV-0001XL-3W; Thu, 11 Sep 2025 14:05:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uwlfS-0001W3-19
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 14:05:10 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uwlfQ-0004GX-53
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 14:05:09 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-45cb6180b60so7458945e9.0
 for <qemu-devel@nongnu.org>; Thu, 11 Sep 2025 11:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1757613906; x=1758218706; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CWXGcMgEpokLbE0wjnpjge6Ilh7Zjrmv+FxN0jp/DwM=;
 b=kNWqmarV+YCuTFNqpRmXlWupNFIBuSNSiuk39igbc60J0OnrSrXP+yN9sD1yjnpBBH
 FrP1jHj38q9oBEyg07WLWY8HWiw8a3JOVgHvWUvf5E7Ei9XWrBh3l3tTkr9sjaNjrlbg
 Om3I4ZK6PEIyOYQhJwnC35NVTQLco+cMKBB+LqZq9B757WWxDM7PWwd5YKpzUWu7igOx
 60ilM2hWg4MWU312MYjMjfwNPMw4X72NgvcbK4Yie4XfxI0xT7xplpMtODZizkZ8LiFr
 aLmnUZoAWS4QrH4PmLTt8O4R1IMd3Ovlqce/4id/vkqDXWGo0A8E3JVwqpejhpXbft5A
 bJzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757613906; x=1758218706;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CWXGcMgEpokLbE0wjnpjge6Ilh7Zjrmv+FxN0jp/DwM=;
 b=snTUfodBrzxCUpYBTJlCnkw5UTQU8RtV422kS+o/GsrAKj7lc9vsbIyC1Cb2ryPDxb
 eQtLWbWFpT3lcWdUi6FXx86mSfqdHoWTl3Tohqs3DinXs7tu6z30ok17y9ilwsqpBA8n
 b1/RhIx8ReAhisx+MTN/2+xX70ybKGrZ10AEqcmP7xeve/3iwCIWhkHJsROo9ZP/ZYUL
 bIKybnxe8BRPWVVtcD+hhChdcy+bwXyz140hMibwdHgTNaB0J+AmbrtIlo3QC+DA4G0U
 eg21e2VZVtomWZL01fb6Y8iPxS3l8nPrW5cN5R4WGvjG71QjtbEyH84E/s5v4YGdoan9
 vP8A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUsKLaDDHYiUBg+d3LXDss8cBZMypwaUnOcT+sv5hkZ61HgTaYFm+YyBlF/VWUV8RXvNpCMsZX9PWTG@nongnu.org
X-Gm-Message-State: AOJu0YznUY6J4WiTb7ipshJGskfdSAmOv5vb6vSwbHnYVpumEsLV9KGR
 0smzh9rS8QXG1dB+XjjzmNC0meuPnjUB8z7NiZagGODbKloqDrBSV9uzn7UZzy1lEaE=
X-Gm-Gg: ASbGncvOMQWizoSiOOInHKWDptYubl+qR8sazIpaxOYman0mIwOZ9D8IcabSkCXvizZ
 9x6CG9LvOJWmlWC2YMbm0wEgZIE5fUkMyA63JJcXJrJB8AYsK46hfCXg+iIyRig4RXOTARhVm3T
 dc9uyhnpIUiMnTVqK1vYAuX4D5MFsfa3w8Vw/Yj+90spCLa7aO1TYbLlKTfkGT1BDAmYtHXAjA5
 yhjXJqQRuBdZlvt1Qtoxd5fzyFzr/gj4ELYE70hR+SbqGKk1n/hkDUkZOJmqjbiyY9R5kEMKZ5n
 ygIwmx/P58098ZA6ED6E3zlb/3BHHjSJrIjmlmr5foU4IVlo8leL5B6PxtZCo/tzFyon3EqS78B
 eV1Vx1NT3tHdRRGO3Nk66ainZH+hFG1JA38NNeTvDiWwXtHCBPrZpU7beyxXr368B+AGSBt5tBv
 KErRI=
X-Google-Smtp-Source: AGHT+IF6J4ncdGnQSIcxNia+CWfm9sGNznJqKAI1f+x+b2W8P0Lz2chkQBDTUmJT8bpMsRZjmSXdHg==
X-Received: by 2002:a05:600c:6c51:b0:45d:f7cb:8954 with SMTP id
 5b1f17b1804b1-45f211d4eedmr2798105e9.9.1757613906331; 
 Thu, 11 Sep 2025 11:05:06 -0700 (PDT)
Received: from [172.16.30.12] (ipnet-92-225.static.simnet.is. [157.157.92.225])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45e0372bbd3sm31277875e9.10.2025.09.11.11.05.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Sep 2025 11:05:05 -0700 (PDT)
Message-ID: <b22eec99-48ae-4d77-9e63-3944247ae5d5@linaro.org>
Date: Thu, 11 Sep 2025 18:05:01 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 14/20] util: fix interleaving of error & trace output
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Stefan Weil <sw@weilnetz.de>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>
References: <20250910180357.320297-1-berrange@redhat.com>
 <20250910180357.320297-15-berrange@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250910180357.320297-15-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x330.google.com
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

On 9/10/25 18:03, Daniel P. Berrangé wrote:
> +    } else {
> +        print_func = (error_print_func)fprintf;
> +        print_vfunc = (error_print_vfunc)vfprintf;
> +        print_opaque = stderr;
> +    }
> +
> +    if (message_with_timestamp && !cur) {
>           timestr = real_time_iso8601();
> -        error_printf("%s ", timestr);
> +        print_func(print_opaque, "%s ", timestr);
>           g_free(timestr);
>       }
>   
>       /* Only prepend guest name if -msg guest-name and -name guest=... are set */
> -    if (error_with_guestname && error_guest_name && !monitor_cur_hmp()) {
> -        error_printf("%s ", error_guest_name);
> +    if (error_with_guestname && error_guest_name && !cur) {
> +        print_func(print_opaque, "%s ", error_guest_name);
>       }

It's worth pushing these second and third if into the first else,
so that !cur is already true.


r~

