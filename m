Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF3F9C54F30
	for <qemu-devel@archiver.kernel.org>; Sat, 24 May 2025 12:46:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uIoGK-0008J6-J3; Sat, 24 May 2025 08:46:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uIoGB-0008Ih-1V
 for qemu-devel@nongnu.org; Sat, 24 May 2025 08:45:59 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uIoG9-00034U-3y
 for qemu-devel@nongnu.org; Sat, 24 May 2025 08:45:54 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3a36efcadb8so677678f8f.0
 for <qemu-devel@nongnu.org>; Sat, 24 May 2025 05:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748090748; x=1748695548; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bH/WbEQ6QePZwNev228Z4SiBpSVmwpXhMMQz2fE+g3o=;
 b=sezS3YfdPaZ5WCp+6uztDUcJ+WI9n+StFYRK/1mrGoPycUOIYpotWpWykT2AFr6EiR
 x50b3g3OClDl6EI6xdJtb/8hx7TCVpLqYMwzRIk/syb9OIwUXDiihklYy6ACqLOJ8LuZ
 Y/WQt3IHSwiRNvAWiYH1WWAK1PWag4iD4XFFl1s/TnwB5CbLRZAor8mvyQb1IncNIlXC
 XiPHkFrCPin+HKAZVec3JiDsFVVUhNW+AWDNSODNmTPQ7j5jtRUQ9dYIId3tufAiKrYH
 8OsW12mg13UphaBdKiEZM9BhyXxSkrrgNAoRDYRtY69ApesL0sBpBv/gFY42fnWYG6TL
 rybw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748090748; x=1748695548;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bH/WbEQ6QePZwNev228Z4SiBpSVmwpXhMMQz2fE+g3o=;
 b=BeQ2hc+JZ88PqJY8SbikTb1MHB/ILxdvU1TrjngvxYzo5QcfU7UqCC7H+c/yvmMIov
 LDZaYx/+FASdPzoptPOrNCIaqi0uo8SVQQytxuL0AEYy45sx0r6o8V9u/TZNG3e9fdmA
 JcE7BmjArg7Qz0l2466I7FqAZtxx6d+gxrJHOCA92TDw2ewZEnjAxVDllBagxnTUTGkj
 gOT+Y26JhtwXzh8y0Kzeubl5+3PNCA5ZRSBT/WyagZMezGMC6dBsw5kgnLBAWSToLXVF
 cpHc1l1W7ZLcnopvaOYbpnFRK2yXMytlrw2JnNviC5WCLQ+7JRmxfkkuUXyn6UtUD7Wr
 1NTQ==
X-Gm-Message-State: AOJu0YwgJdyzNnNTBQ/SrCx0oRT+zzUKGHWdaHSKILuAAtHMrZikRcHL
 ZNTMlW81mjZKRAiEKqL0NST1EUX/qNIpsY2UCGHahLE5IUlGDUQcsIlgwTX9uhp4xq+xQesXCB2
 t7ikPDJE31A==
X-Gm-Gg: ASbGncsr4Cx5AdKm837zWHZdpOKUuDIYPQgHmuR0LkccccppPivLxwiirxY44rWSVT6
 UWuGa/lyQrQKNEyc0axEWF9iMs8E1JABddgRmZDyarOxJucScNcwDNTFNMHe9bxudYsLXEmvgxo
 bSVhO2EOTgKejv6XN5s26p8l2yAuxD41xfmYY1Ii1nmtM8wnRcOx4WEOMbmlHBYA+XxejI01wZG
 JTbVY7IoqqXEQbwb+1zL8IcV6wSlqMaA8NKyBqVL+B1Lt6f3Mo9YvVQ28pube03+sjQbRWyS9KI
 /lfHgMP9bc3DJnUEdHzedR1EMmBBXtdvGHFq3AaL0vS/ZF2Eaau91eid6Jn+sxYbkQ==
X-Google-Smtp-Source: AGHT+IHx+JjXN2Zf1WygCFiFU5DpMfv8JM84hMXpG37RR8Jnt2xzogTVaBzN/y6K3DJ/jaway3XnoA==
X-Received: by 2002:a05:6000:e4d:b0:3a3:75d7:5864 with SMTP id
 ffacd0b85a97d-3a4cb4834cdmr1926278f8f.47.1748090747723; 
 Sat, 24 May 2025 05:45:47 -0700 (PDT)
Received: from [172.16.25.47] ([195.53.115.74])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a35ca889d9sm29728932f8f.77.2025.05.24.05.45.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 24 May 2025 05:45:47 -0700 (PDT)
Message-ID: <6efd040a-e54e-43df-874d-5801f876bd6a@linaro.org>
Date: Sat, 24 May 2025 13:45:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] system/main: comment lock rationale
To: qemu-devel@nongnu.org
References: <20250515174641.4000309-1-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250515174641.4000309-1-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x432.google.com
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

On 5/15/25 18:46, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   system/main.c | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
> 
> diff --git a/system/main.c b/system/main.c
> index 1c022067349..b8f7157cc34 100644
> --- a/system/main.c
> +++ b/system/main.c
> @@ -69,8 +69,21 @@ int (*qemu_main)(void) = os_darwin_cfrunloop_main;
>   int main(int argc, char **argv)
>   {
>       qemu_init(argc, argv);
> +
> +    /*
> +     * qemu_init acquires the BQL and replay mutex lock. BQL is acquired when
> +     * initializing cpus, to block associated threads until initialization is
> +     * complete. Replay_mutex lock is acquired on initialization, because it
> +     * must be held when configuring icount_mode.
> +     *
> +     * On MacOS, qemu main event loop runs in a background thread, as main
> +     * thread must be reserved for UI. Thus, we need to transfer lock ownership,
> +     * and the simplest way to do that is to release them, and reacquire them
> +     * from qemu_default_main.
> +     */
>       bql_unlock();
>       replay_mutex_unlock();
> +
>       if (qemu_main) {
>           QemuThread main_loop_thread;
>           qemu_thread_create(&main_loop_thread, "qemu_main",

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

