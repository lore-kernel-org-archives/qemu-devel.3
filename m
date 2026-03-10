Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B4F1FCC9C8
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 06:16:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzqNd-000604-Dz; Tue, 10 Mar 2026 02:15:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzqNa-0005yt-5q
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 02:15:42 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzqNX-0000Kb-HR
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 02:15:41 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4852e09e23dso24218565e9.0
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 23:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773123336; x=1773728136; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ypmdLDVyHCzygN19of2F/slBTQPRbg8+egZSZUSC8Gg=;
 b=r+7XDBZSFQlQ2SzRZVu0Utf20UO+e+ekLrXWCcChN5YP71OJ4nlUSGLcwsMS/5Bb2L
 7qcgYhUsXXAq0SVb2X8gcpW4BlXxaMB9CB9ISKTTjIsvOUmnD74vE5cC4Z98aCvu9dsS
 yfZznS9EdehOy8Eq6htQasVB7AIxHJIfxxQ5TRjYPnps2GB7omaHxxmJSccx4NOpK756
 pNOKFCAO84rawIzfDgaBLQvMckkfNJ+1lOj3irl0KnT9cvxW2hokUH4+NnoM3v548Hpw
 ratf3J0Jx+I3CggVPT1Jvpi9kojBvTDKdJbfMCPUfkC1BYlbK9InhAKI76nJ2/n0XxE1
 IyXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773123336; x=1773728136;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ypmdLDVyHCzygN19of2F/slBTQPRbg8+egZSZUSC8Gg=;
 b=dRv//C8DNCr/bFim5Ce5srjEtYTDGeOFxfIwOSEReFzEUN0A0JUaMhVanowG7aMEJe
 Knb06hpBZ8glbpUWg2nwD88y/51GyUoJpPIROUYQxMK6LPvMgUFl+vhkeglhFbJzsBzu
 tH6aGLyZbiE1PtggFizGr+m4kUms37prwlLIpqFbweArq8Xd0tXHWH3I9F+H7aLAl3M4
 KBTyglJEP+kLsL+Bl5UBeaE3LNqh2dMwhXpPYBK3FpW5irpPOPwaOmtf6y9YLWoaRpxd
 k3TF26csajqGaskw/asGAXv/zKl9N3/0kWmJrXdAgLB6lYcjP7cCmqVidqTjmjBJy5e2
 i3Jw==
X-Forwarded-Encrypted: i=1;
 AJvYcCURBFttSlFtTQTw+jAjSd4aJanyWjyUtnCpX7xX3hcbfbACjJI+1uRn7CPnuKmSI2/o87d52ZobF05L@nongnu.org
X-Gm-Message-State: AOJu0YwbM8RS2uSpvatSSD125AUHOYAp6dTadRwHvU04umjZo8pV8vSL
 OYenAKGoNViPwPNYSKrxOZDceKToQVfq12Nnl/oJ6AfJ5DufMVMkZ4PwnlDgivbteh6A6ZMonB6
 Qm2E/ZwA=
X-Gm-Gg: ATEYQzx3x92VN+UwDuyFhS0SNQYDiU43zG6f452htxK0ijwdqiw0ROVNTSQ7eyMc4Wh
 CcO48PUzPFeRGXJRx8yMEIlP5kPsKAKuJydrWBqGgB0VzjfLOKrced0tnUXqk2K3tFacqVLZStF
 f/qRYC1Rx1SZ1Ea0Bfu12kpiqerT5qMXIazqXZuLhApIoHpfzT2ARL1oSEy1+M7O4dH0ETPqMo5
 EVwUj6d371bDmvlgnlObWm09xanfnE+dpsLp/4SY2stKFmXuxTo5TU2sQTSnRQJde6opU3uRnAD
 zJ3tcmO7iyhfDG22sfrgetPPTQi3BzR+aY1RnjnqW7x2Pq0zsEWJt+Fcip968ZyxQHZ+rmOXlk3
 l8xd/VR87VQzfVRMuKtlyMer+jOsmkeUd0EOH9mSU3Vj39g8AQwmL8UUjr8p/eOosDf1hicZ+U5
 zulSHWMxS3/zPlGSRYrT+JuqIQVHMR/OQ7g/GVV08g9uLTngfOig9+Ke0yBMkEILIAfi2ZENXpX
 rSn
X-Received: by 2002:a05:600c:350e:b0:485:17a7:ba0d with SMTP id
 5b1f17b1804b1-485269785bamr229177355e9.32.1773123336216; 
 Mon, 09 Mar 2026 23:15:36 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48541a9e6aesm47175525e9.11.2026.03.09.23.15.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Mar 2026 23:15:35 -0700 (PDT)
Message-ID: <52cbaf6d-f7a4-4984-9561-ca31418cdc0f@linaro.org>
Date: Tue, 10 Mar 2026 07:15:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 12/12] target/hppa: add 64 bit support to gdbstub
Content-Language: en-US
To: deller@kernel.org, qemu-devel@nongnu.org
Cc: Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Helge Deller <deller@gmx.de>,
 Sven Schnelle <svens@stackframe.org>,
 Richard Henderson <richard.henderson@linaro.org>, Fam Zheng <fam@euphon.net>
References: <20251223155031.7110-1-deller@kernel.org>
 <20251223155031.7110-13-deller@kernel.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251223155031.7110-13-deller@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

Hi,

(now merged as commit b2c2d00f48cc5f4486cfba33b505ff86d79cb137)

On 23/12/25 16:50, deller@kernel.org wrote:
> From: Sven Schnelle <svens@stackframe.org>
> 
> Signed-off-by: Sven Schnelle <svens@stackframe.org>
> Reviewed-by: Helge Deller <deller@gmx.de>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Signed-off-by: Helge Deller <deller@gmx.de>
> ---
>   target/hppa/gdbstub.c | 62 ++++++++++++++++++++++++++++---------------
>   1 file changed, 41 insertions(+), 21 deletions(-)
> 
> diff --git a/target/hppa/gdbstub.c b/target/hppa/gdbstub.c
> index 0daa52f7af..777f4a48b9 100644
> --- a/target/hppa/gdbstub.c
> +++ b/target/hppa/gdbstub.c
> @@ -21,16 +21,25 @@
>   #include "cpu.h"
>   #include "gdbstub/helpers.h"
>   
> -/*
> - * GDB 15 only supports PA1.0 via the remote protocol, and ignores
> - * any provided xml.  Which means that any attempt to provide more
> - * data results in "Remote 'g' packet reply is too long".
> - */
> +static int hppa_num_regs(CPUHPPAState *env)
> +{
> +    return hppa_is_pa20(env) ? 96 : 128;
> +}
> +
> +static int hppa_reg_size(CPUHPPAState *env)
> +{
> +    return hppa_is_pa20(env) ? 8 : 4;
> +}
>   
>   int hppa_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
>   {
> -    CPUHPPAState *env = cpu_env(cs);
> -    uint32_t val;
> +    HPPACPU *cpu = HPPA_CPU(cs);
> +    CPUHPPAState *env = &cpu->env;
> +    target_ulong val;
> +
> +    if (n >= hppa_num_regs(env)) {
> +        return 0;
> +    }
>   
>       switch (n) {
>       case 0:
> @@ -133,24 +142,35 @@ int hppa_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
>           val = env->cr[30];
>           break;
>       case 64 ... 127:
> -        val = extract64(env->fr[(n - 64) / 2], (n & 1 ? 0 : 32), 32);
> -        break;
> -    default:
> -        if (n < 128) {
> -            val = 0;
> +        if (hppa_is_pa20(env)) {
> +            val = env->fr[n - 64];

Coverity reports:

 >>>     CID 1645613:         Memory - illegal accesses  (OVERRUN)
 >>>     Overrunning array "env->fr" of 32 8-byte elements at element 
index 32 (byte offset 263) using index "n - 64" (which evaluates to 32).

>           } else {
> -            return 0;
> +            val = extract64(env->fr[(n - 64) / 2], (n & 1 ? 0 : 32), 32);
>           }
>           break;
> +    default:
> +        val = 0;
> +        break;
>       }
>   
> -    return gdb_get_reg32(mem_buf, val);
> +    if (hppa_is_pa20(env)) {
> +        return gdb_get_reg64(mem_buf, val);
> +    } else {
> +        return gdb_get_reg32(mem_buf, val);
> +    }
>   }
>   
>   int hppa_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
>   {
> -    CPUHPPAState *env = cpu_env(cs);
> -    uint32_t val = ldl_p(mem_buf);
> +    HPPACPU *cpu = HPPA_CPU(cs);
> +    CPUHPPAState *env = &cpu->env;
> +    target_ulong val;
> +
> +    if (n >= hppa_num_regs(env)) {
> +        return 0;
> +    }
> +
> +    val = ldn_p(mem_buf, hppa_reg_size(env));
>   
>       switch (n) {
>       case 0:
> @@ -267,16 +287,16 @@ int hppa_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
>           cpu_hppa_loaded_fr0(env);
>           break;
>       case 65 ... 127:
> -        {
> +        if (hppa_is_pa20(env)) {
> +            env->fr[n - 64] = val;

Ditto:

 >>>     CID 1645614:         Memory - corruptions  (OVERRUN)
 >>>     Overrunning array "env->fr" of 32 8-byte elements at element 
index 32 (byte offset 263) using index "n - 64" (which evaluates to 32).

> +        } else {
>               uint64_t *fr = &env->fr[(n - 64) / 2];
>               *fr = deposit64(*fr, (n & 1 ? 0 : 32), 32, val);
>           }
>           break;
>       default:
> -        if (n >= 128) {
> -            return 0;
> -        }
>           break;
>       }
> -    return 4;
> +
> +    return hppa_reg_size(env);
>   }


