Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF74AD6D247
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2024 22:36:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGQdg-0002rc-Ix; Wed, 27 Nov 2024 17:36:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tGQdb-0002rF-JF
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 17:35:59 -0500
Received: from mail-oo1-xc2f.google.com ([2607:f8b0:4864:20::c2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tGQdY-0005vm-Se
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 17:35:58 -0500
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-5f1e365469eso126096eaf.3
 for <qemu-devel@nongnu.org>; Wed, 27 Nov 2024 14:35:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732746955; x=1733351755; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OCjfmYHEOM4wwKDVojl0rhc1QWsJfJtEGK4x6oDmynI=;
 b=KwZNkKo7fYs/1MwwtJKZkgxBUMYIVWmrnjehD9zUXgJ2L2i7RLquYuDF1uHg7qKGYF
 7a1XFcnHPuIEvQmE7JyO+z5w6lPxJBsVVR+MPlg5WIL88aZZ9KozspnofGOhX3rAM5LO
 0K9kUem1x0T1s+GUC/iD71PIIDKEx6WH8/DXtj/3nWqc1e8wsg+pqafVRmE9BmFemB7i
 n/Zusy4+2z2UGoDCVHaWxYNpP+TR4ZlovXdTJgWidmgVnawB/NSGPgaUtEnn3gI/HYZ8
 R8pHUH0NtalmCJnrBVoY6FRgnBHE0w2pP+kVExKjPqx6g4C2kFF4AdUkvnpybV2cF0e3
 to0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732746955; x=1733351755;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OCjfmYHEOM4wwKDVojl0rhc1QWsJfJtEGK4x6oDmynI=;
 b=KLjshSD8A0j7oIV3CD/tYBv+c8ZTmHMDJwuJdJpaISuNrJ5HS1mnE9EYoGC28gZHZy
 9SOp4aQc+C6/aDrzmdxdPSn6y2NmObkszqA5akKVxJ3H0a+VOPNdeZQrFw/+pcnPK9d8
 nAfWtNme6rSh3OkBynEX5TnkTwCk7rAB2Her9alWrU72EmqD5OoizN8KFXCTRicSCMhb
 wFLr7UTqok9dnHojV34P3eoY64ks7DsjTokmOZjaEiaydRRCoS15jFG5+/tKpUioioWG
 p68nLglEGrL5tFoyw8/9milpKohuCaynwVQ/9Rh8l2dDoB6jTLgTVIq5AOG6Boapgf0G
 yQIA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVXCw7uypDYguRZEJsZkikWokajaQQs8R59c/Hm49r1xqzqJEFxuUPM8yC39++hdmjlsU9YeSISRm3z@nongnu.org
X-Gm-Message-State: AOJu0YzI+Mf4/PjrIxmXVcc4YG0f9Omkf0AXAl/5f9BbcTkZaJuz0I05
 JJKzyzFyB4kDZgmclV1ViwErKEh90A821buH/WHwdo1iwH5px3Ypt5C1LsXVNFP8JTtsNIn+j9l
 ozm4=
X-Gm-Gg: ASbGncvYM+ll4CtMDDPyenWxeXqqysnro0Ww8uRVctqAKCmpFB5y34ZDQG+pBq9E9Dv
 0gDOqOjui2nPwWSb7/WREC20lTSBlEfi8xjV0cwNRXz/a2cV9ZCcJbBDiRkU5D6tB7/wCquKMru
 wSZdNUm+6ejCuFN9BLIEPY/OJjvenGisLL/BWM53nD5XaKPd5JYfWZY4wUkdZEiufxJX439LMGO
 b2IwX87aZBHDDLBtPux9EAXqHmSWySjh2FjqZ4HfXb0P4OiS/jKyiJWLtHF+5SHUCI2PoMy9coN
 uWRBd8i5z0KkpDYdJtVtkSOJSbmP
X-Google-Smtp-Source: AGHT+IEiQJf/MsFi34s/NENEhRnZzKei8skWU4tlXcRQIRa+2v0rObSRFAw1HoaRgui4sQZdFWgFWg==
X-Received: by 2002:a4a:ee87:0:b0:5e1:c19d:3f4e with SMTP id
 006d021491bc7-5f20a2017a3mr4514253eaf.8.1732746955348; 
 Wed, 27 Nov 2024 14:35:55 -0800 (PST)
Received: from [192.168.4.112] (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5f21a50408asm38178eaf.39.2024.11.27.14.35.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Nov 2024 14:35:55 -0800 (PST)
Message-ID: <6f265a48-eaa3-4e2d-b6d2-26e4935693ba@linaro.org>
Date: Wed, 27 Nov 2024 16:35:51 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.0] system/qtest: Access memory using
 cpu_physical_memory_rw() API
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Anton Johansson <anjo@rev.ng>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
References: <20241127191914.34146-1-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241127191914.34146-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2f;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2f.google.com
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

On 11/27/24 13:19, Philippe Mathieu-Daudé wrote:
> There is no vCPU within the QTest accelerator (well, they
> are stubs doing nothing, see dummy_cpu_thread_fn).
> Directly use the cpu_physical_memory_rw() API -- which
> amusingly prefixed 'cpu_' does not use vCPU -- to access
> memory. This reduces accesses to the global 'first_cpu'.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   system/qtest.c | 42 ++++++++++++++----------------------------
>   1 file changed, 14 insertions(+), 28 deletions(-)
> 
> diff --git a/system/qtest.c b/system/qtest.c
> index 12703a20455..a2de9a7d5a4 100644
> --- a/system/qtest.c
> +++ b/system/qtest.c
> @@ -18,6 +18,7 @@
>   #include "chardev/char-fe.h"
>   #include "exec/ioport.h"
>   #include "exec/memory.h"
> +#include "exec/cpu-common.h"
>   #include "exec/tswap.h"
>   #include "hw/qdev-core.h"
>   #include "hw/irq.h"
> @@ -514,23 +515,19 @@ static void qtest_process_command(CharBackend *chr, gchar **words)
>   
>           if (words[0][5] == 'b') {
>               uint8_t data = value;
> -            address_space_write(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED,
> -                                &data, 1);
> +            cpu_physical_memory_write(addr, &data, 1);

This just calls address_space_write with &address_space_memory.
I assume we'll get rid of address_space_memory too, at some point.
But I suppose that's good enough for qtest for now.

r~


