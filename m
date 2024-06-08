Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C1A3C25B76
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Jun 2024 22:31:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sG4aT-0000eE-UL; Sat, 08 Jun 2024 18:31:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shorne@gmail.com>) id 1sG4aS-0000db-0q
 for qemu-devel@nongnu.org; Sat, 08 Jun 2024 18:31:00 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shorne@gmail.com>) id 1sG4aQ-00052c-1B
 for qemu-devel@nongnu.org; Sat, 08 Jun 2024 18:30:59 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-35f0f4746c2so761263f8f.3
 for <qemu-devel@nongnu.org>; Sat, 08 Jun 2024 15:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717885856; x=1718490656; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=UUVFq7oMeiL/jTff6N0E7twnzg6HPt8Ee+ls4hVDtUo=;
 b=EV8eTsLNjtM3dro59K15KSkC4xkPnJrBf/6o9aR3jxPDeXOdAxOVUE5fzkNW8WpLqy
 NUpyAqaybec6VdOmgSjO7tqwO94b0cd+6/RlfLMqxCdeSjdD8OXxvCp7GXKJH27YaAh9
 PLjCZvtN3jzLuGDbuy4NjlPMPA2TD0F16pt3lDF0vhl07lafZNyXUmLY277H4ITe7sSb
 +ILsMnBP4DZ6ODO0FjTjshSx1dp2bk21WDkZIRAHdHWUQjiWkrioP2lq93VlGf1xTemd
 OE8C18jitFjz3Ox/twJDoXsA/nNrueILHY+IJ91xf0ty/3FCZeX5ERa3soP9DaVtc4Iz
 qb1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717885856; x=1718490656;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UUVFq7oMeiL/jTff6N0E7twnzg6HPt8Ee+ls4hVDtUo=;
 b=CeGgdDt8McWL8YGqZzI5ty192ey+H3iCwM0DeiJl+eCkM9vo+QjKQlu40ZXTJqSdS2
 E/MkbGNazRDxLodTbe3+ry7hIuAgXcbPadl07/hnCY/rYRarGG0KD90zT6Z34TG8rnJI
 9CDLl8b76YHES04fIEPplWECTtj/oKoYideTE1jZDCaBWIQ28qty07evfEOTEompYVQp
 iT8ja8NHuAkTiykOFbbH22KQa82EpMNAyPo75sLMAMPSo+9AHsMPGm28eTyPPNUioFdS
 1n+B2W3qjSCFv6vJOYLt7ksbNKoHN6T4fH6PahNXe9x1ys52/axsexXdgh2jSuvQ3HM3
 izLQ==
X-Gm-Message-State: AOJu0YxdtZJ0piVIF7ClCuD/d2PMS7O2ORU3Ptb0k06rrGAA8u1og6l1
 iwe8SPlqaqfhAhNKr85NawdoM9CZ6CX4IEV0VxiywtcVHcOaKWVr881Ckojl
X-Google-Smtp-Source: AGHT+IFTkl4ns5JLw51QR5RPn9np5i9RqhHJOkUM4H7LldGwHY7wHGk3/WIoET93+lVH0I2j86JmQQ==
X-Received: by 2002:adf:f10f:0:b0:35f:1030:c6b4 with SMTP id
 ffacd0b85a97d-35f1030c87cmr2071706f8f.28.1717885855314; 
 Sat, 08 Jun 2024 15:30:55 -0700 (PDT)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net.
 [86.9.131.95]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35ef5d4d521sm7278218f8f.47.2024.06.08.15.30.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Jun 2024 15:30:54 -0700 (PDT)
Date: Sat, 8 Jun 2024 23:30:53 +0100
From: Stafford Horne <shorne@gmail.com>
To: Joel Holdsworth <jholdsworth@nvidia.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH] hw/openrisc: Fixed undercounting of TTCR in continuous
 mode
Message-ID: <ZmTbnfrp73tAt3KY@antec>
References: <20240607222933.45791-1-jholdsworth@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240607222933.45791-1-jholdsworth@nvidia.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=shorne@gmail.com; helo=mail-wr1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi Joel,

I am away and wont be able to have too much time to look at this.

But have a few comments below and questions.

 - You sent this 2 times, is the only change in v2 the sender address?

On Fri, Jun 07, 2024 at 03:29:33PM -0700, Joel Holdsworth via wrote:
> In the existing design, TTCR is prone to undercounting when running in
> continuous mode. This manifests as a timer interrupt appearing to
> trigger a few cycles prior to the deadline set in SPR_TTMR_TP.

This is a good find, I have noticed the timer is off when running on OpenRISC
but never tracked it down to this undercounting issue.  I also notice
unexplained RCU stalls when running in Linux when tere is no load, this timer
issue might be related.

Did you notice this via other system symptoms when running OpenRISC or just via
code auditing of QEMU?

> When the timer triggers, the virtual time delta in nanoseconds between
> the time when the timer was set, and when it triggers is calculated.
> This nanoseconds value is then divided by TIMER_PERIOD (50) to compute
> an increment of cycles to apply to TTCR.
> 
> However, this calculation rounds down the number of cycles causing the
> undercounting.
> 
> A simplistic solution would be to instead round up the number of cycles,
> however this will result in the accumulation of timing error over time.
> 
> This patch corrects the issue by calculating the time delta in
> nanoseconds between when the timer was last reset and the timer event.
> This approach allows the TTCR value to be rounded up, but without
> accumulating error over time.

In QEMU there is a function clock_ns_to_ticks(). Could this maybe be used
instead to give us more standard fix?

> Signed-off-by: Joel Holdsworth <jholdsworth@nvidia.com>
> ---
>  hw/openrisc/cputimer.c | 22 +++++++++++++---------
>  1 file changed, 13 insertions(+), 9 deletions(-)
> 
> diff --git a/hw/openrisc/cputimer.c b/hw/openrisc/cputimer.c
> index 835986c4db..ddc129aa48 100644
> --- a/hw/openrisc/cputimer.c
> +++ b/hw/openrisc/cputimer.c
> @@ -29,7 +29,8 @@
>  /* Tick Timer global state to allow all cores to be in sync */
>  typedef struct OR1KTimerState {
>      uint32_t ttcr;
> -    uint64_t last_clk;
> +    uint32_t ttcr_offset;
> +    uint64_t clk_offset;
>  } OR1KTimerState;
>  
>  static OR1KTimerState *or1k_timer;
> @@ -37,6 +38,8 @@ static OR1KTimerState *or1k_timer;
>  void cpu_openrisc_count_set(OpenRISCCPU *cpu, uint32_t val)
>  {
>      or1k_timer->ttcr = val;
> +    or1k_timer->ttcr_offset = val;
> +    or1k_timer->clk_offset = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
>  }
>  
>  uint32_t cpu_openrisc_count_get(OpenRISCCPU *cpu)
> @@ -53,9 +56,8 @@ void cpu_openrisc_count_update(OpenRISCCPU *cpu)
>          return;
>      }
>      now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
> -    or1k_timer->ttcr += (uint32_t)((now - or1k_timer->last_clk)
> -                                    / TIMER_PERIOD);
> -    or1k_timer->last_clk = now;
> +    or1k_timer->ttcr = (now - or1k_timer->clk_offset + TIMER_PERIOD - 1) / TIMER_PERIOD +
> +        or1k_timer->ttcr_offset;
>  }
>  
>  /* Update the next timeout time as difference between ttmr and ttcr */
> @@ -69,7 +71,7 @@ void cpu_openrisc_timer_update(OpenRISCCPU *cpu)
>      }
>  
>      cpu_openrisc_count_update(cpu);
> -    now = or1k_timer->last_clk;
> +    now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
>  
>      if ((cpu->env.ttmr & TTMR_TP) <= (or1k_timer->ttcr & TTMR_TP)) {
>          wait = TTMR_TP - (or1k_timer->ttcr & TTMR_TP) + 1;
> @@ -110,7 +112,8 @@ static void openrisc_timer_cb(void *opaque)
>      case TIMER_NONE:
>          break;
>      case TIMER_INTR:
> -        or1k_timer->ttcr = 0;
> +        /* Zero the count by applying a negative offset to the counter */
> +        or1k_timer->ttcr_offset += UINT32_MAX - (cpu->env.ttmr & TTMR_TP);
>          break;
>      case TIMER_SHOT:
>          cpu_openrisc_count_stop(cpu);
> @@ -137,8 +140,8 @@ static void openrisc_count_reset(void *opaque)
>  /* Reset the global timer state. */
>  static void openrisc_timer_reset(void *opaque)
>  {
> -    or1k_timer->ttcr = 0x00000000;
> -    or1k_timer->last_clk = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
> +    OpenRISCCPU *cpu = opaque;
> +    cpu_openrisc_count_set(cpu, 0);
>  }
>  
>  static const VMStateDescription vmstate_or1k_timer = {
> @@ -147,7 +150,8 @@ static const VMStateDescription vmstate_or1k_timer = {
>      .minimum_version_id = 1,
>      .fields = (const VMStateField[]) {
>          VMSTATE_UINT32(ttcr, OR1KTimerState),
> -        VMSTATE_UINT64(last_clk, OR1KTimerState),
> +        VMSTATE_UINT32(ttcr_offset, OR1KTimerState),
> +        VMSTATE_UINT64(clk_offset, OR1KTimerState),
>          VMSTATE_END_OF_LIST()
>      }
>  };

This is a change to the VM state, we would need to update the version.

-Stafford

