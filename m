Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01F74E8B399
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 04:39:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnUfP-0007YF-1x; Tue, 03 Feb 2026 23:39:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vnUfM-0007XR-Sx
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 23:39:00 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vnUfL-0007cf-Cb
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 23:39:00 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2a7bceb6cd0so44317205ad.1
 for <qemu-devel@nongnu.org>; Tue, 03 Feb 2026 20:38:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770179938; x=1770784738; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6AjPSMQE9r9xMiet5INCWLgLfuJ1FkmlzyE5bMDP29Q=;
 b=iclgP3QuIRy+G8iiDpu6NFnoX34cQL/K0XeJje2JHtHabWtsaTpbgzCHPnF1BhURlj
 Q3Qh8cKk170SRwDBaYviSlOep/r9xWj5q3snz8KjxBYRMyWCIxQzI5ZCCaH4kq+91O8F
 zq1yeiwUrLqdDPYArh3JLxw9jWR29KrEE4hU6sdF3NRumSLJx1drF4Y/BXe9wx4HPAEb
 ItV4ZkSa+zP7XYiMgKXuxJtGmFs87sUUnwwUEOb4w86uNLyoxYpq35ZyUHgCR260SCt7
 OnqMPrB0VaIrGXMr5aDARFfRXdw1ZfCh4d/RR9aX3M2SuiuyLSJIeGmLvOf9k1LSTCj0
 /D/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770179938; x=1770784738;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6AjPSMQE9r9xMiet5INCWLgLfuJ1FkmlzyE5bMDP29Q=;
 b=HEDJGON6smWS6dBkhtW2OgN4kNNLt3wXN00n9y+uychCCnB//hz+Wp8X7NONr0wnQf
 Eb8Ax4ZX65s3xv0BNAGRK27HAQNe+rTjLtYXQ0HQf+S/1ZxvfyxES4fHyJ/W05NdCvzB
 9P0cac2OGeuasL1uoUVg1flO62Vl78ZprK+lX9szXuNKGVeUaRDbK+3QaZtwhHB3KJaQ
 7LGAgc56mJF5vsX3Yuy1DdICCf+gKZU9hgr3XIJzV/GxWrLgCJML35bTFgI6GpIbGOoy
 wu0J5Xg3jA7/IrXv4JqnaRLiGwtVbJDOLT7CPvI7rN8hmdz6QQ2TlOUX2as7lC0Ro/9W
 7Nfw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWxN31Dh6VBgagX6llU9+5AZKKrxVzppfn8RQncVKPY9mSYKLnGItqU+NC1Gok8QFhCYjK3EwBy1QaB@nongnu.org
X-Gm-Message-State: AOJu0YzezWOnMDx4HkFmECnVEIXVlV0yg9owcYQJIvmHMv/lvQtE1yXX
 7m+iwoJW8Xt3YFIsOAPv+7M2+OOs8cXZxxGN7ovYgIjYZkq5Ur39yaY1TGo2Tpyu0sCBM/dp5wO
 p0kXfO88=
X-Gm-Gg: AZuq6aI0CjkYYlyJERXy7GlhMc1ur08/dxA4bqfD0Em3r7NZiasab7X/gySWJeiOWJl
 9AoVJeaFPXPGuWkMmq1dOmCJ/u0EaIVfa/ZQBrJqEutaQH6VsulQHKoQ37OpyC+sq5E6Dti+Jm8
 LZ0cSVDV1JG8eE1eQ6syCcts6C6783/9rokEOSrFnZaYCiBqGwTh3e4osNMPJ4iDRuENUVltaHD
 iRXJRpf6HQ9wy5yPmlnv0hZaWvkyKI4suschaduu/GbjGusE2U5lDQYBo/jZyd8IuBdApqS2OJc
 Lve4nvET774YP5HpYo3NJBDW0ljT4ly4N1GsmJTZb8potctXhRGthoYDaMUALOe49FUi+btwxMM
 56tAzgw897XUmlrjZPszIcsPorvMtJfQAk1T4ZMfgz0qCyi4ZuHGbna4QI0qzicm6eNbZmqOhlv
 aaBQ33TM0P7B3X14IfoeSUjUEk8jTuMbTndzDCvXQ/qiHz4AA+xW66Jb8S6k6IwrBlmXKK54geB
 Fen5tpHyVKjLEgKB4Is6Jr2WuIpZITNP/i/OJXoEtoR3Nw=
X-Received: by 2002:a17:902:e94c:b0:2a7:fe78:a344 with SMTP id
 d9443c01a7336-2a933cdd07dmr17520025ad.6.1770179937664; 
 Tue, 03 Feb 2026 20:38:57 -0800 (PST)
Received: from ?IPV6:2401:d002:dc0f:2100:1bc:fe1e:491:928e?
 (bg30dhzlx7lnyrq74wrz.ip6.superloop.au.
 [2401:d002:dc0f:2100:1bc:fe1e:491:928e])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a933965c32sm8769865ad.70.2026.02.03.20.38.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Feb 2026 20:38:57 -0800 (PST)
Message-ID: <1c32b9bf-1e6b-4cba-8dd5-c672975545f7@linaro.org>
Date: Wed, 4 Feb 2026 14:38:52 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/11] gdbstub/user: rename and use bool for running_state
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20260203115201.2387721-1-alex.bennee@linaro.org>
 <20260203115201.2387721-12-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260203115201.2387721-12-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

On 2/3/26 21:52, Alex Bennée wrote:
> This is just a clean-up to document what we using the running variable
> for in user-mode.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   gdbstub/user.c | 18 +++++++++++-------
>   1 file changed, 11 insertions(+), 7 deletions(-)



Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

> 
> diff --git a/gdbstub/user.c b/gdbstub/user.c
> index a16f37616b1..97eb13e796a 100644
> --- a/gdbstub/user.c
> +++ b/gdbstub/user.c
> @@ -87,7 +87,11 @@ enum GDBForkMessage {
>   typedef struct {
>       int fd;
>       char *socket_path;
> -    int running_state;
> +    /*
> +     * running state of the guest, when we process a packet that restarts
> +     * the guest we set this to true.
> +     */
> +    bool running;
>       /*
>        * Store syscalls mask without memory allocation in order to avoid
>        * implementing synchronization.
> @@ -241,8 +245,8 @@ int gdb_handlesig(CPUState *cpu, int sig, const char *reason, void *siginfo,
>   
>       sig = 0;
>       gdbserver_state.state = RS_IDLE;
> -    gdbserver_user_state.running_state = 0;
> -    while (gdbserver_user_state.running_state == 0) {
> +    gdbserver_user_state.running = false;
> +    while (!gdbserver_user_state.running) {
>           char buf[256];
>           int n = read(gdbserver_user_state.fd, buf, 256);
>           if (n > 0) {
> @@ -611,11 +615,11 @@ void gdbserver_fork_end(CPUState *cpu, pid_t pid)
>   
>       gdbserver_state.state = RS_IDLE;
>       gdbserver_state.allow_stop_reply = false;
> -    gdbserver_user_state.running_state = 0;
> +    gdbserver_user_state.running = false;
>       for (;;) {
>           switch (gdbserver_user_state.fork_state) {
>           case GDB_FORK_ENABLED:
> -            if (gdbserver_user_state.running_state) {
> +            if (gdbserver_user_state.running) {
>                   close(fd);
>                   return;
>               }
> @@ -728,7 +732,7 @@ void gdb_handle_query_attached(GArray *params, void *user_ctx)
>   
>   void gdb_continue(void)
>   {
> -    gdbserver_user_state.running_state = 1;
> +    gdbserver_user_state.running = true;
>       trace_gdbstub_op_continue();
>   }
>   
> @@ -750,7 +754,7 @@ int gdb_continue_partial(char *newstates)
>               cpu_single_step(cpu, gdbserver_state.sstep_flags);
>           }
>       }
> -    gdbserver_user_state.running_state = 1;
> +    gdbserver_user_state.running = true;
>       return res;
>   }
>   


