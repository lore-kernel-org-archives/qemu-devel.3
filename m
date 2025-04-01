Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBA44C36010
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Apr 2025 13:06:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzbJS-0006Kd-BY; Tue, 01 Apr 2025 09:05:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <corey@minyard.net>) id 1tzbIv-0005sl-W9
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 09:05:24 -0400
Received: from mail-oa1-x33.google.com ([2001:4860:4864:20::33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <corey@minyard.net>) id 1tzbIs-00006e-RW
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 09:05:21 -0400
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-2c7b2c14455so3241435fac.2
 for <qemu-devel@nongnu.org>; Tue, 01 Apr 2025 06:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=minyard-net.20230601.gappssmtp.com; s=20230601; t=1743512717; x=1744117517;
 darn=nongnu.org; 
 h=in-reply-to:content-disposition:mime-version:references:reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0eu0Sn/jD+3TQ5aYVt19dcYMIDSZ/+eB1KinermfB1s=;
 b=IXD3xV/vToeukub0CYkQtwBE4U1n2zcGtuJbN6CU49KwvW+3547JyKBpyZ8HgPXi3t
 U5hYubsnOgIKgdGAMxwFaachrQqiev/hDLO7dD9gv0vFQhPbw4nrA7eatzoOMIEjz+/Q
 Nk1kaMdOnqDaV3YoIShCM0QCPYtyMJx+2gw1YKnZerHiGt/c7qsz8+dPbgnmYRrjWzTN
 2MPXxHjw7cOfvhsH4w5vGzGtuhKUTrPVDAxlIuZ8bS2jZ7bQ73ApP0FunNoKXJwnG8O2
 mogMZAT6WQGEXn+HnRQSK0GQRmn8iFrgv48yayJ/u9MTiPTrhprh+2dsJxJ8zFhe1eZi
 4lvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743512717; x=1744117517;
 h=in-reply-to:content-disposition:mime-version:references:reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0eu0Sn/jD+3TQ5aYVt19dcYMIDSZ/+eB1KinermfB1s=;
 b=HtlbIZAum+sYdYKagBUBkqy5F+XXneWgq4bOHwra0IECXDmsTFWjicB8UAqMR37+pH
 LmSc4PRguuMJANMb2xOEgR48gwVn8YsxMShHmq6kMUqy3Bq+oHLaNEgacb66h/j3L/ua
 fN+K+A3sAVrh6uT4kyigfMeOlC/I8e5drTpVLUBZzrO8rbW6CBNKX748bnZEqKghD8dN
 UeRPjK2DTiKi7TnSNIz6Y2hEeS1NJLxgFibx/2/+q/lVz4USOpPwIugPbJR+GfuCRBZQ
 DYF9Ep1M5KT9E4PxmQNkVcF4ZPxdYU+ILOQzryuv/8ecgpqweWUXLBj7B8Z+QyzTzqO4
 Qknw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJAFXoXYV0O7ZNqxTWBehz3dcZhSt9uD56BePvqBAHhEOaQATp9Aw1GuFLvB4z15DpvqYjPjNxxdTy@nongnu.org
X-Gm-Message-State: AOJu0Yx/bf8cxDPy94yQTN1gK0wVzoEgsCXi20HfQRniikS2aOlyfO6Y
 rYwji4Gp3TsAMXmzhAxqDHl+x8KJCVBx1Dds0+zC++UpkEE6KZNQRp59i6C29BI=
X-Gm-Gg: ASbGncsZWQLQ3ytdJ7mDdi+sUvBAXg/JsMUI8RiJln2nAPxEpZvA9Iosmz/L6LxIF4R
 uvaAhb0t1okt82kZNLhOm6T6ZtSHvdO1GMh72nuUN9TmeU6yFqpMB+ZqCM/+ybQmbYF3qfhbJ/7
 vnVvZstkSmdmYEEJaC2AjrAYYcj9nB4UzjCxyU2y75nSl7qhLNH1UnGZa3C7AW18nDnrv+Bu7M7
 2ZF+1fN2/l8g/Og2eFSK8b0M4+KpMjszi0A6S2eG4937ke+mEWDRctNw45khfSDMuawiLfXPrZs
 gL2WCsmPxWerP/6pHakyEZMYNaHhQ8aO4+6yY4CwcSgoWQdm
X-Google-Smtp-Source: AGHT+IHoMDvQL0J5VGpV9omFx+JbAl/vlFJgu6hS/pm6R8Z7ziPHq0DGVw4inXfNb5HO6HHoFusOJA==
X-Received: by 2002:a05:6870:a44a:b0:29e:58ec:2a11 with SMTP id
 586e51a60fabf-2cbcf575b57mr7472421fac.21.1743512716838; 
 Tue, 01 Apr 2025 06:05:16 -0700 (PDT)
Received: from mail.minyard.net ([2001:470:b8f6:1b:8459:d76b:f4fb:8568])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2c86a856e16sm2295998fac.37.2025.04.01.06.05.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Apr 2025 06:05:16 -0700 (PDT)
Date: Tue, 1 Apr 2025 08:05:11 -0500
From: Corey Minyard <corey@minyard.net>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Corey Minyard <minyard@acm.org>, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 4/5] ipmi/bmc-sim: implement watchdog dont log flag
Message-ID: <Z-vkh-c-TwvLQM0O@mail.minyard.net>
References: <20250401114412.676636-1-npiggin@gmail.com>
 <20250401114412.676636-5-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250401114412.676636-5-npiggin@gmail.com>
Received-SPF: none client-ip=2001:4860:4864:20::33;
 envelope-from=corey@minyard.net; helo=mail-oa1-x33.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Reply-To: corey@minyard.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Apr 01, 2025 at 09:44:11PM +1000, Nicholas Piggin wrote:
> If the dont-log flag is set in the 'timer use' field for the
> 'set watchdog' command, a watchdog timeout will not get logged as
> a timer use expiration.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  hw/ipmi/ipmi_bmc_sim.c | 32 ++++++++++++++++++++++----------
>  1 file changed, 22 insertions(+), 10 deletions(-)
> 
> diff --git a/hw/ipmi/ipmi_bmc_sim.c b/hw/ipmi/ipmi_bmc_sim.c
> index 216bf8ff7f0..3cefc69f8a8 100644
> --- a/hw/ipmi/ipmi_bmc_sim.c
> +++ b/hw/ipmi/ipmi_bmc_sim.c
> @@ -514,7 +514,8 @@ static void gen_event(IPMIBmcSim *ibs, unsigned int sens_num, uint8_t deassert,
>  
>  static void sensor_set_discrete_bit(IPMIBmcSim *ibs, unsigned int sensor,
>                                      unsigned int bit, unsigned int val,
> -                                    uint8_t evd1, uint8_t evd2, uint8_t evd3)
> +                                    uint8_t evd1, uint8_t evd2, uint8_t evd3,
> +                                    bool do_log)
>  {
>      IPMISensor *sens;
>      uint16_t mask;
> @@ -534,7 +535,7 @@ static void sensor_set_discrete_bit(IPMIBmcSim *ibs, unsigned int sensor,
>              return; /* Already asserted */
>          }
>          sens->assert_states |= mask & sens->assert_suppt;
> -        if (sens->assert_enable & mask & sens->assert_states) {
> +        if (do_log && (sens->assert_enable & mask & sens->assert_states)) {
>              /* Send an event on assert */
>              gen_event(ibs, sensor, 0, evd1, evd2, evd3);
>          }
> @@ -544,7 +545,7 @@ static void sensor_set_discrete_bit(IPMIBmcSim *ibs, unsigned int sensor,
>              return; /* Already deasserted */
>          }
>          sens->deassert_states |= mask & sens->deassert_suppt;
> -        if (sens->deassert_enable & mask & sens->deassert_states) {
> +        if (do_log && (sens->deassert_enable & mask & sens->deassert_states)) {
>              /* Send an event on deassert */
>              gen_event(ibs, sensor, 1, evd1, evd2, evd3);
>          }
> @@ -700,6 +701,7 @@ static void ipmi_sim_handle_timeout(IPMIBmcSim *ibs)
>  {
>      IPMIInterface *s = ibs->parent.intf;
>      IPMIInterfaceClass *k = IPMI_INTERFACE_GET_CLASS(s);
> +    bool do_log = !IPMI_BMC_WATCHDOG_GET_DONT_LOG(ibs);
>  
>      if (!ibs->watchdog_running) {
>          goto out;
> @@ -711,14 +713,16 @@ static void ipmi_sim_handle_timeout(IPMIBmcSim *ibs)
>              ibs->msg_flags |= IPMI_BMC_MSG_FLAG_WATCHDOG_TIMEOUT_MASK;
>              k->do_hw_op(s, IPMI_SEND_NMI, 0);
>              sensor_set_discrete_bit(ibs, IPMI_WATCHDOG_SENSOR, 8, 1,
> -                                    0xc8, (2 << 4) | 0xf, 0xff);
> +                                    0xc8, (2 << 4) | 0xf, 0xff,
> +                                    do_log);
>              break;
>  
>          case IPMI_BMC_WATCHDOG_PRE_MSG_INT:
>              ibs->msg_flags |= IPMI_BMC_MSG_FLAG_WATCHDOG_TIMEOUT_MASK;
>              k->set_atn(s, 1, attn_irq_enabled(ibs));
>              sensor_set_discrete_bit(ibs, IPMI_WATCHDOG_SENSOR, 8, 1,
> -                                    0xc8, (3 << 4) | 0xf, 0xff);
> +                                    0xc8, (3 << 4) | 0xf, 0xff,
> +                                    do_log);
>              break;
>  
>          default:
> @@ -734,28 +738,36 @@ static void ipmi_sim_handle_timeout(IPMIBmcSim *ibs)
>  
>   do_full_expiry:
>      ibs->watchdog_running = 0; /* Stop the watchdog on a timeout */
> -    ibs->watchdog_expired |= (1 << IPMI_BMC_WATCHDOG_GET_USE(ibs));
> +
> +    if (do_log) {
> +        ibs->watchdog_expired |= (1 << IPMI_BMC_WATCHDOG_GET_USE(ibs));
> +    }
> +

This change needs to be removed.  watchdog_expired has nothing to do
with logs, it's a field reporting in another message.

Other than that, this is good.

-corey

>      switch (IPMI_BMC_WATCHDOG_GET_ACTION(ibs)) {
>      case IPMI_BMC_WATCHDOG_ACTION_NONE:
>          sensor_set_discrete_bit(ibs, IPMI_WATCHDOG_SENSOR, 0, 1,
> -                                0xc0, ibs->watchdog_use & 0xf, 0xff);
> +                                0xc0, ibs->watchdog_use & 0xf, 0xff,
> +                                do_log);
>          break;
>  
>      case IPMI_BMC_WATCHDOG_ACTION_RESET:
>          sensor_set_discrete_bit(ibs, IPMI_WATCHDOG_SENSOR, 1, 1,
> -                                0xc1, ibs->watchdog_use & 0xf, 0xff);
> +                                0xc1, ibs->watchdog_use & 0xf, 0xff,
> +                                do_log);
>          k->do_hw_op(s, IPMI_RESET_CHASSIS, 0);
>          break;
>  
>      case IPMI_BMC_WATCHDOG_ACTION_POWER_DOWN:
>          sensor_set_discrete_bit(ibs, IPMI_WATCHDOG_SENSOR, 2, 1,
> -                                0xc2, ibs->watchdog_use & 0xf, 0xff);
> +                                0xc2, ibs->watchdog_use & 0xf, 0xff,
> +                                do_log);
>          k->do_hw_op(s, IPMI_POWEROFF_CHASSIS, 0);
>          break;
>  
>      case IPMI_BMC_WATCHDOG_ACTION_POWER_CYCLE:
>          sensor_set_discrete_bit(ibs, IPMI_WATCHDOG_SENSOR, 2, 1,
> -                                0xc3, ibs->watchdog_use & 0xf, 0xff);
> +                                0xc3, ibs->watchdog_use & 0xf, 0xff,
> +                                do_log);
>          k->do_hw_op(s, IPMI_POWERCYCLE_CHASSIS, 0);
>          break;
>      }
> -- 
> 2.47.1
> 

