Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62377CEBF92
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 08:50:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLHPi-0003y1-RR; Tue, 18 Nov 2025 03:50:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vLHPh-0003xk-0m
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 03:50:13 -0500
Received: from mail-io1-xd32.google.com ([2607:f8b0:4864:20::d32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vLHPf-0002W1-7R
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 03:50:12 -0500
Received: by mail-io1-xd32.google.com with SMTP id
 ca18e2360f4ac-9486354dcb2so227995939f.3
 for <qemu-devel@nongnu.org>; Tue, 18 Nov 2025 00:50:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763455810; x=1764060610; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=y3BnlYN7/7p1HLOlDXecJq+xrmfMpf6ziWPWiTn1jBQ=;
 b=rDL5Ubn+ryd+tEYWaD835VMz/4XRdHP1v8LeUevS12V6Ovfezb0v3qOZHz2QdpQwzf
 yMKoEkKIMwibk5CWUppLg3qtcuLgZ5Fm1g9CIQ6599m+tstn6KplO+t6sBwZVLVx+vIL
 8eEDIJ6v/J7rHq3dtt8TqmuCtU4t6uKTDKeQLz0a+ykJ0t/VoY44F+VKcUsLqMvxOG0U
 EVyb5w14zxitDaWIhuoIKZepfNo7pIBnJvrqADBZyiXVaLa903cT4y33L3sT74qdgrpi
 iHBvY5VkUDNi4Zx3ksMoYLuMjPI1/Pakg320gK8B5fulbBG3ZiRPMkNxCk46oI7bA2X9
 HDiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763455810; x=1764060610;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=y3BnlYN7/7p1HLOlDXecJq+xrmfMpf6ziWPWiTn1jBQ=;
 b=vhYJ3wu+qzxZjegOk4uB+2+7WIh02gHk6UkVuAzBMhVNs5jFnvPx104CNCnvb9dkFR
 OOWN819hrCh32dy5qC0ceQBcqgLpEnRoml4EBp/x4UO8xsbSmzpzV3htgYeSw4JLg3cn
 AJZAc+R9cbDReh9J91uVN6vnU6M+4aqAC8g/oPSpzUb7E2/3V5f2/hdqxmLk/PTC7XDc
 2LA6F9PBtJLPHOA2C8IbVJzYmEE8JvLvpOHX08F+Gqs4NM1IViXEq8NcXFOf+YOHES6q
 ZnRrJLg77VuGScshBtwcIJCANhWZV6oyWNyg8HymDU9TcDweXLTo71wfMLUGM2/De3jH
 sHVg==
X-Gm-Message-State: AOJu0YxlLDNjmYDhu1e0OKSCVwyx3SXWy4QcGTw2DERiJtjPtwIbW+CK
 vdyebwOGN6Jaovt45AGQOZ49iozlXnmE+puFxUnSo/zrX53yi5o6kEX1C01hk8ADFwg3C1nEyKz
 d8WP06K4=
X-Gm-Gg: ASbGncs3a8wdCO5IU4yX7BNI0W9HD6hs9xX4xZH69lTZerbtwbylSel95m66XA5ADZ3
 3riJKyqcFcz3OoXZj80oK16+WZO5T+r7i/N9sz+HyrfYd9S1aq8NpOqTLs/po0jjg1JV/dlxkLw
 mWnNN5dCi2yfyVpGt5BWofMLmJdZaAUTJTVeq+Oz/UeSgaNPYhrMbYROMk6PnLtUzJi6pU0V9Db
 QitbcW9GpX1f1XoD9/zvfZ8O0EgVHhA3Ls2ZsPuxPSOi+Gj459oZ9HNb683rIuB0fhiFK5BBjA+
 s21YjxaF0snMtQmkSB5yljbSSEX5bV8xkN4ZdrU0Q0IOk8EgtVSAphVxtA04elJ08W55g5RdsB2
 MvZ5SKTxtmgaF6zfg+AEuqaHjqLGIzjuoZ6sJpTtNkXSq8NPyl4OLV6RU3/UilbE1UCDJ7waMXP
 nihJ6NXOejWGqEj7DHFBhVt96w1rBOvioZr7WF3O4BpAq03iRHCr4gj8aB0dQZC0x0oVU=
X-Google-Smtp-Source: AGHT+IERj/4eusOxJUfiyAvb9H50CjmttgkeXTfpx3yNFdQd2jmFpaJKn8M7MTA+JTX2mZDLeZHmcg==
X-Received: by 2002:a05:6602:341c:b0:948:fba6:ed00 with SMTP id
 ca18e2360f4ac-948fba7010emr1158728839f.1.1763455809644; 
 Tue, 18 Nov 2025 00:50:09 -0800 (PST)
Received: from [10.89.10.227] ([172.59.191.229])
 by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-434833c5ef5sm78850405ab.3.2025.11.18.00.50.08
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Nov 2025 00:50:09 -0800 (PST)
Message-ID: <45864b2c-7211-4f63-a4dd-9d2a9a8c3385@linaro.org>
Date: Tue, 18 Nov 2025 09:50:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.2 1/3] qga/commands: Include proper Solaris header
 for getloadavg()
To: qemu-devel@nongnu.org
References: <20251117203834.83713-1-philmd@linaro.org>
 <20251117203834.83713-2-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251117203834.83713-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::d32;
 envelope-from=richard.henderson@linaro.org; helo=mail-io1-xd32.google.com
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

On 11/17/25 21:38, Philippe Mathieu-Daudé wrote:
> Solaris declares getloadavg() in <sys/loadavg.h>:
> 
>      getloadavg(3C)       Standard C Library Functions       getloadavg(3C)
> 
>      NAME
>             getloadavg - get system load averages
> 
>      SYNOPSIS
>             #include <sys/loadavg.h>
> 
>             int getloadavg(double loadavg[], int nelem);
> 
>      [...]
> 
>      Oracle Solaris 11.4           23 Jul 2020               getloadavg(3C)
> 
> Include it in order to avoid:
> 
>    ../qga/commands-posix.c: In function 'qmp_guest_get_load':
>    ../qga/commands-posix.c:1408:9: error: implicit declaration of function 'getloadavg' [-Wimplicit-function-declaration]
>     1408 |     if (getloadavg(loadavg, G_N_ELEMENTS(loadavg)) < 0) {
>        |         ^~~~~~~~~~
>    ../qga/commands-posix.c:1408:9: warning: nested extern declaration of 'getloadavg' [-Wnested-externs]
> 
> ../configure relevant output:
> 
>    C compiler for the host machine: gcc (gcc 14.2.0 "gcc (GCC) 14.2.0")
>    C linker for the host machine: gcc ld.solaris 5.11-1.3315
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   qga/commands-posix.c | 3 +++
>   1 file changed, 3 insertions(+)

Acked-by: Richard Henderson <richard.henderson@linaro.org>

r~

> 
> diff --git a/qga/commands-posix.c b/qga/commands-posix.c
> index c7059857e44..66f3e6f6733 100644
> --- a/qga/commands-posix.c
> +++ b/qga/commands-posix.c
> @@ -43,6 +43,9 @@
>   #include <net/ethernet.h>
>   #endif
>   #ifdef CONFIG_SOLARIS
> +#ifdef CONFIG_GETLOADAVG
> +#include <sys/loadavg.h>
> +#endif
>   #include <sys/sockio.h>
>   #endif
>   #endif


