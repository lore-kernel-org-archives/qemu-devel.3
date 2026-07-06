Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3021C43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 09:22:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgfWT-0005iv-1r; Mon, 06 Jul 2026 05:21:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wgfWM-0005gD-F0
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 05:21:48 -0400
Received: from mail-yx1-xb131.google.com ([2607:f8b0:4864:20::b131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wgfWK-0006AU-RV
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 05:21:46 -0400
Received: by mail-yx1-xb131.google.com with SMTP id
 956f58d0204a3-667627ae83aso1586298d50.0
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 02:21:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783329703; cv=none;
 d=google.com; s=arc-20260327;
 b=Fih+pvKX+Qj8CeJqMtblyitH6jGNcqqVK8cKyrBujWDicNBxuxmORSyGiFy/Jgx8Q/
 hjr+bTTsiMnm5uVPiBR/r87Z9Qr+Y8YeOu++eqtDTFlL+d5JJXdNoI2o+ZF6uQFyK+dK
 JS76UDbJQhIVYWr5HCCE4A/eP+kuTcYCQkErTeKrbRmInmfS+SpqyDOXct687HXhRpsF
 ymuvAMoQWpMuieCjdKB/X+K6FYFOzL2klbyS8gp1geuVygUh+6rmjQugj/q29p0gl2Mv
 zhnsJLclTqHvrJe5UCXHsu71W+s7v5quKuXGwXxLVslLbsngaPL6QiwaAb+ZsO/4Dx6q
 LSVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=R7x48NwT96HfzMiY0/kj8VUVqa2ageysyCYZFuhCntQ=;
 fh=wcRrtuX7URwFnJWYJyzBwV4CZU14Opy3fSoTct/v3Co=;
 b=JaTJp01vjCDKOvJHh1fQt+PrddoXVLU0/e7Xl45LglhrOisBX8PyiYm/HcFFSfDqWE
 ANQuzXhw8Nd8m3cppF2yNF0KhD797Ljt8z6mBv+qZhAm9CLRuxbI/7HPnZS3qd3802Zt
 q53UAibjMi2zRA4JGf4zXKqJJjNCiQUUx1/gxTyG/kxgydfeO9J+uJLrkofNQdzGwILG
 7E7RYrps47r4R/sCrK7Hw2ETzfn7P1WFeUaZxAC8OC0YoqsrT+WXFQPqfTnItw1Pt3sG
 X0G4Q6Cl+50C54FZMUTRbm+N5Z6DK/V+z5Z5YHQnNN8kT6B3yeEU6ESbf3W1aph5ID2L
 6Syg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783329703; x=1783934503; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=R7x48NwT96HfzMiY0/kj8VUVqa2ageysyCYZFuhCntQ=;
 b=gQ1+Wce+kWlfif8kkDzndODizcLdi6m+CHFWaZq0W/XjUoyZZwhzaS5/WOC541Z2iL
 IhkFBfwzva0Nb9unUHbVebA3uB2RsSl+DD6IvoRJwlZHZce6X9m99S8k5TOPSHqzo37U
 lVRM021YkTAEZvqZvkUJXGaf/qXmAyXQqi0Lgk+aWtx64xZbbaiMnfy4KgIHrNh9Q2Bi
 nIDGbb2BsjdWlYm+wWEyuA4DEln5PLzKFePSMtimwqobk22hQg4lOOlHAlF8nhP9T6gi
 a0euQju5fNHXM1XCK1D+dLpUxvv3aWDEOKLT5IH7urtM4aKK+MfeZvbuQHAhwIjRSGNp
 ZjVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783329703; x=1783934503;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=R7x48NwT96HfzMiY0/kj8VUVqa2ageysyCYZFuhCntQ=;
 b=VhQBTJKxV2PAXdok0ny8ejQc76+MYaGpCo5uL3hZyqJa9z5DknjykdS3GwDvVBoAbh
 2nS2sLayMYnn49Qwdu5rkEbaARmvzKhiVGOokFwa3XKAPx9cltjuGRL5G5E1iPrxY8/E
 lYq9Q207QdDwGGm2oIpU+sjKYFr6aegtha3CnVJbvjI5wnh4P5TUvp0kQhXReHLgFqU0
 cwDKVtNFUCsyylVh7JXBodIIH2iTaptDz1VhctYUubC5/SNxjvOt+ZZHRN4XAz/SKkNu
 kSu6ExPU+xeXtmt5Iilr7XqBuSrQglJpp+M62aF1+hLShC3Ba0V5f80i6lc7zn0MzVGL
 Wovw==
X-Gm-Message-State: AOJu0YyhlU5sKx+nfL5t4WA08oXysn3akACEZZcNu+97mm+wdkGt8rz6
 jDcT48UjGpfvftvEWW15sN/Y9m3BTfVmEx/JDC+CsPqmx8RornqlqgK4WrHIygjKql+JPIh+/WD
 ecAvDKB/amT0OP/DeLNj5uWYF/AlUrkZQNUW8oQtKxA==
X-Gm-Gg: AfdE7cmkbKh6fWxQ8QrTPrd3yMSjJOfRid1nTvjNBwZWII9wXHdPm+xDOd1dNUiWRos
 3iTTfsfkpqQvbe/O2VJ+oDFMtiIHQyFdm1W5GDkCXrcUExzHImFSd20Mws2DuZIwZjQuMRHW5PG
 UvRFwECfypB52lR26OCZoz6KzOW6VlAVBunyZRZkYzWiouQ5IPHYyQW+CSwV0isJ8c1KvsGf+aS
 YlrMGS4mm/XpL2l7dZi6vKbmyDzPbB+7q3S8CS/79upQJBHT7ULJ74zccjwQAW4ZUBbmRYVVx8G
 D8SxI6KJC+OgXH7VzEll9cdyFMTYSnbHZQ+W4rI+Y3ufcQDItWrHTA+6
X-Received: by 2002:a05:690e:d5b:b0:664:cc3f:e2c with SMTP id
 956f58d0204a3-66652f08f03mr7431034d50.27.1783329703133; Mon, 06 Jul 2026
 02:21:43 -0700 (PDT)
MIME-Version: 1.0
References: <20260705224407.32464-1-gilles.grimaud@univ-lille.fr>
In-Reply-To: <20260705224407.32464-1-gilles.grimaud@univ-lille.fr>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 6 Jul 2026 10:21:31 +0100
X-Gm-Features: AVVi8CdKJKgFoJ21ehlGPs4Mpr22KcLrVTVui7lCW2N1WbKFJ-UvHJgKwV1X-nE
Message-ID: <CAFEAcA9Heev=ydTzO2u3EzeF_2q7dytOF8=67qF8ZMMY6Ky2Tw@mail.gmail.com>
Subject: Re: [RFC PATCH] target/arm: report M-profile BKPT to gdbstub when
 attached
To: Gilles Grimaud <gilles.grimaud@univ-lille.fr>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b131;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb131.google.com
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

On Sun, 5 Jul 2026 at 23:44, Gilles Grimaud
<gilles.grimaud@univ-lille.fr> wrote:
>
> While working on Raspberry Pi Pico/RP2040 support, I noticed that Pico SDK
> programs deliberately execute BKPT from _exit(). On real hardware this is
> useful when a debug probe is attached: returning from main() stops the
> debugger at the program exit point.
>
> Under QEMU this currently does not behave like the debug-probe case. For
> M-profile guests, the BKPT instruction is routed through the architectural
> guest debug exception path. Without halting debug, that path should remain a
> guest-visible DebugMonitor exception when DebugMonitor is enabled, or escalate
> towards HardFault otherwise. This patch deliberately leaves that no-debugger
> architectural path unchanged.
>
> The problem addressed here is the case where GDB is connected to QEMU's
> gdbstub. In that situation, firmware that uses BKPT as a debugger stop point
> should stop in the attached debugger. Instead, the M-profile guest currently
> continues down the guest exception path and may end in HardFault/lockup rather
> than reporting a clean trap to GDB.
>
> This is not specific to the RP2040 machine model. It is a generic
> Cortex-M/gdbstub interaction: firmware that uses BKPT as a debugger stop point
> should be reported to the attached debugger, while keeping the guest
> architectural exception path when no debugger is attached.
>
> Expose a small gdbstub helper to test whether a CPU is visible to an attached
> debugger. When an M-profile BKPT instruction is executed with such a debugger
> attached, leave the translated block with EXCP_DEBUG so the existing gdbstub
> stop path reports a trap to GDB.
>
> Signed-off-by: Gilles Grimaud <gilles.grimaud@univ-lille.fr>
> ---
>  gdbstub/gdbstub.c      | 13 ++++++++++++-
>  include/exec/gdbstub.h |  6 ++++++
>  target/arm/tcg/debug.c |  9 +++++++++
>  3 files changed, 27 insertions(+), 1 deletion(-)
>
> diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
> index c3c944e965..9f259fc005 100644
> --- a/gdbstub/gdbstub.c
> +++ b/gdbstub/gdbstub.c
> @@ -237,6 +237,18 @@ static GDBProcess *gdb_get_cpu_process(CPUState *cpu)
>      return gdb_get_process(gdb_get_cpu_pid(cpu));
>  }
>
> +bool gdb_cpu_is_attached(CPUState *cpu)
> +{
> +    GDBProcess *process;
> +
> +    if (!gdbserver_state.init || !cpu) {
> +        return false;
> +    }
> +
> +    process = gdb_get_cpu_process(cpu);
> +    return process && process->attached;
> +}

No other architecture, CPU or board in QEMU needs to do this,
so my instinct is to say that M-profile should not be special here.
Richard, Alex: how do we usually handle breakpoint insns for the
gdbstub ?

-- PMM

