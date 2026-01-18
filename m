Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AB35C98315
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Jan 2026 21:34:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhaOs-0006da-UE; Sun, 18 Jan 2026 16:33:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vhaOh-0006bD-5F
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 16:33:23 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vhaOf-00050v-J8
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 16:33:22 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4801bc328easo28207015e9.3
 for <qemu-devel@nongnu.org>; Sun, 18 Jan 2026 13:33:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768771998; x=1769376798; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UlAbN0aIjJm+1Q4xaVrgWdkrJEC6XaTja8/SizYvcTE=;
 b=xpQlaXG/AjuXZWhETbfYcs1CQMNWTfFoU/Tihbnqwz0DEh/g3rjMyaSRa/uu+fwTxL
 UzUAEP33a9cUqtCs4Zq407zjpYmxPilwbiplhaAlmx+1w2j+fobJhNBwf4atGW7Keqrj
 VXm1MTyRid4lo1SIfL+Ij1HX0ubFH1n9Ygt9tve6l2GMIkQexkWCodqxQ0wHBGsRCK4Z
 McTiPbGiFlJNscFSFExRvHz+blphvNcBKYf6OpXGcFpTbPw/82fYtHnqu8eKNq6ma9rj
 Qk/3s4NyHoNnynZi7ng4kPu+Xbb9y6U6VipaCcX9QxeUnXV8G12XwcBIPT23PpLYQTKT
 L7WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768771998; x=1769376798;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UlAbN0aIjJm+1Q4xaVrgWdkrJEC6XaTja8/SizYvcTE=;
 b=v6eD003WJAW+2gyBb/ckV2S8tJZ66U+55Z2x2hz4P2oHRbvC9JeybbCwd5mEbwVd8Y
 umzXL+Z7+OVEw4YOcQ9swAgb2TkC+PuhZFcgQv6hXWIC7IffceS5CXpjnGj6ytK+L2QR
 xERW08DAMqsed/S/JoeU+GCWkM9j+RbTKnhUhiinN/NjNxrSxUlfeIodWgwcs2T1+4YY
 4Q/w9hV+NwnS2f5U4jiDvcWU030m9nD1wDMmvjoMR5ioYwEyLzeZ54tNpevABQ81ODt+
 O7nQBFkZjNrWTMQsTjUYrTe5831EwuiLGZnFlTlmq8/fUHLJtoC+0mzPWc5HMtwJ4kZQ
 zgpQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU+IEt4NLgR5clZXvm2EIcDMx/DZpAC5dVdMZ+doCeu8WKp9pimUSs6TFS21TBmejy4aajMzR6C0mXg@nongnu.org
X-Gm-Message-State: AOJu0YyvWnxy9hKFoxUm+xyeqTmAB4J7jtG6KsvGnTQBfSUPs1UTciDI
 tbkWdLpnJ9Hq1eTNnNqOM4uKsUZD3UQM81fDQ6ou1GLk961Q6pEHsn6aWKnlu05WmeE=
X-Gm-Gg: AY/fxX7g9s44TJ84Kn37OXyyU2rZczjJyWBpPszZO5xF4eRjU5lWyqOA6geYvKTWepw
 5ZlkHRhNyVlSPNBCpfJcSvgiSVv1A2rihu4giBKRg6/2smAzFXyAZ42/d9rEWb9RJVVAZZ7ue/3
 fq/A8QZv8/LYVED8uDaWTB0THYN1kzSUWKu0XaSYlGNUiSO1U/gs3r0iSUHO/cP/Q2uBdiQb638
 CXUd1HqVK1iAtM/a1mf8lpYckACWWwKAHim6I9sjQf/vReATME/sDqUjY8725+3Dn/9ci7sj0GR
 QwmBXByL2xFMFAG+Lt6WfREdP5YjW1HkQi8TsZNs/mVtDOjsVyH6zjt6/oih1WXBot0PFNLhCdt
 dmpvE+CF/+3GmtOFii1YVn8ryexBeoU6s+6LcxH/x/6zEpKaqL2ElsXogQXwJwfHn7PI/QYq4C3
 4sxGHVTFeGzqoVzVLwMx+E/8eAqQLzhf/mhlK0lqTVmoP/l2wQ4MpeVNytehjMN7ku
X-Received: by 2002:a05:600c:870e:b0:47d:264e:b35a with SMTP id
 5b1f17b1804b1-4801eabf1eamr98819465e9.13.1768771998323; 
 Sun, 18 Jan 2026 13:33:18 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47f42907141sm214773655e9.9.2026.01.18.13.33.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 18 Jan 2026 13:33:17 -0800 (PST)
Message-ID: <ee9a0216-0a1a-46ec-b647-64045c892af3@linaro.org>
Date: Sun, 18 Jan 2026 22:33:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] include/exec: Provide the cpu_tswap() functions
Content-Language: en-US
To: =?UTF-8?Q?Martin_Kr=C3=B6ning?= <martin.kroening@eonerc.rwth-aachen.de>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20260106-semihosting-cpu-tswap-v1-0-646576c25f56@eonerc.rwth-aachen.de>
 <20260106-semihosting-cpu-tswap-v1-1-646576c25f56@eonerc.rwth-aachen.de>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260106-semihosting-cpu-tswap-v1-1-646576c25f56@eonerc.rwth-aachen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

Hi Martin,

On 6/1/26 14:43, Martin Kröning via wrote:
> These functions are needed for CPUs that support runtime-configurable endianness.
> In those cases, components such as semihosting need to perform
> runtime-dependent byte swaps.

Are you targetting user or system emulation?

I suppose user emulation, otherwise you'd have used the
"semihosting/uaccess.h" API.

But then I'm confused because a user process can't change
the CPU endianness...

Can you explain your use case?

> Signed-off-by: Martin Kröning <martin.kroening@eonerc.rwth-aachen.de>
> ---
>   include/exec/tswap.h | 30 ++++++++++++++++++++++++++++++
>   1 file changed, 30 insertions(+)
> 
> diff --git a/include/exec/tswap.h b/include/exec/tswap.h
> index 72219e2c43..9aaafb12f3 100644
> --- a/include/exec/tswap.h
> +++ b/include/exec/tswap.h
> @@ -10,6 +10,7 @@
>   
>   #include "qemu/bswap.h"
>   #include "qemu/target-info.h"
> +#include "hw/core/cpu.h"
>   
>   /*
>    * If we're in target-specific code, we can hard-code the swapping
> @@ -21,6 +22,8 @@
>   #define target_needs_bswap()  (HOST_BIG_ENDIAN != target_big_endian())
>   #endif /* COMPILING_PER_TARGET */
>   
> +#define cpu_needs_bswap(cpu)  (HOST_BIG_ENDIAN != cpu_virtio_is_big_endian(cpu))
> +
>   static inline uint16_t tswap16(uint16_t s)
>   {
>       if (target_needs_bswap()) {
> @@ -48,6 +51,33 @@ static inline uint64_t tswap64(uint64_t s)
>       }
>   }
>   
> +static inline uint16_t cpu_tswap16(CPUState *cpu, uint16_t s)
> +{
> +    if (target_needs_bswap() || cpu_needs_bswap(cpu)) {
> +        return bswap16(s);
> +    } else {
> +        return s;
> +    }
> +}
> +
> +static inline uint32_t cpu_tswap32(CPUState *cpu, uint32_t s)
> +{
> +    if (target_needs_bswap() || cpu_needs_bswap(cpu)) {
> +        return bswap32(s);
> +    } else {
> +        return s;
> +    }
> +}
> +
> +static inline uint64_t cpu_tswap64(CPUState *cpu, uint64_t s)
> +{
> +    if (target_needs_bswap() || cpu_needs_bswap(cpu)) {
> +        return bswap64(s);
> +    } else {
> +        return s;
> +    }
> +}
> +
>   static inline void tswap16s(uint16_t *s)
>   {
>       if (target_needs_bswap()) {
> 


