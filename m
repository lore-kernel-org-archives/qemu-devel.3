Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEAD3D5E123
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Nov 2024 08:24:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9gla-0006Ll-2R; Sat, 09 Nov 2024 03:24:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1t9glX-0006LV-L5
 for qemu-devel@nongnu.org; Sat, 09 Nov 2024 03:24:19 -0500
Received: from mail-ed1-f52.google.com ([209.85.208.52])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1t9glW-0003ft-9O
 for qemu-devel@nongnu.org; Sat, 09 Nov 2024 03:24:19 -0500
Received: by mail-ed1-f52.google.com with SMTP id
 4fb4d7f45d1cf-5cec7cde922so3809201a12.3
 for <qemu-devel@nongnu.org>; Sat, 09 Nov 2024 00:24:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731140655; x=1731745455;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uZtLh9Hcgmq6+k5LnrIXwjPt0blStXf4eGnoAObbwbI=;
 b=ju6QueknLpTMk7HOvLY8eH7klnKFKPvcZkaWu4S9EKliiORJg8zhZF/QjDfLjoRCM5
 A9d8cvIVhaE9xrmXfsGlWDV+tWfLIszQPE27fMajeoU/O0s1aVrJeRDp6E6K7kYU73ED
 n4FgEM+9UtJCM32sfj9LNjS7/Z/WyaIS84YwoQyGxf4NUfog1DWidaaz5/ki78s1tkOT
 NO5vgCE1AWvOe/5PqBu95l79c/vurJVbSP0H7ipU8AwkP+SkXPmCvIP/XLX+BENsJ7PC
 PZOvIAXbK0jQ/KJZwQKCOikKtw8nUjrElL5dOSaUzMqqsMGUrtHO74WobYrJ7Y7Y54cR
 n2Iw==
X-Gm-Message-State: AOJu0Yy2Kb8umzN7B+Z8FZUX6noqcSxfzx3vMqkQWdhqGc5QAUME5B6u
 Aai/9BOJsWzjtHl4s4wL8ppIgNbfBYV1g0mDaUyM38g66oADNkpFayzHyXg5
X-Google-Smtp-Source: AGHT+IFvYjAdRS08Mef6tJ8Z4Ej2xkDE3i7ccZ+qBg0gcr6Txs8yh54q4hGmvJtL8hANLP4a/PNz6A==
X-Received: by 2002:a05:6402:90a:b0:5ce:cfef:1d08 with SMTP id
 4fb4d7f45d1cf-5cf0a45f7a0mr3346229a12.32.1731140655008; 
 Sat, 09 Nov 2024 00:24:15 -0800 (PST)
Received: from tpx1 (ip-109-42-51-55.web.vodafone.de. [109.42.51.55])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5cf03b5d7e6sm2790442a12.14.2024.11.09.00.24.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 Nov 2024 00:24:14 -0800 (PST)
Date: Sat, 9 Nov 2024 09:24:11 +0100
From: Thomas Huth <huth@tuxfamily.org>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 31/36] next-cube: add rtc-cmd-reset named gpio to reset
 the rtc state machine
Message-ID: <20241109092411.5ced24d0@tpx1>
In-Reply-To: <20241023085852.1061031-32-mark.cave-ayland@ilande.co.uk>
References: <20241023085852.1061031-1-mark.cave-ayland@ilande.co.uk>
 <20241023085852.1061031-32-mark.cave-ayland@ilande.co.uk>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=209.85.208.52; envelope-from=th.huth@gmail.com;
 helo=mail-ed1-f52.google.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Am Wed, 23 Oct 2024 09:58:47 +0100
schrieb Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>:

> This allows us to decouple the next-pc and next-rtc devices from each
> other in next_scr2_rtc_update().
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>  hw/m68k/next-cube.c | 23 +++++++++++++++++++----
>  1 file changed, 19 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
> index bd24359913..16b16e9956 100644
> --- a/hw/m68k/next-cube.c
> +++ b/hw/m68k/next-cube.c
> @@ -108,6 +108,7 @@ struct NeXTPC {
>      NeXTRTC rtc;
>      qemu_irq rtc_power_irq;
>      qemu_irq rtc_data_irq;
> +    qemu_irq rtc_cmd_reset_irq;
>  };
>  
>  typedef struct next_dma {
> @@ -264,7 +265,6 @@ static void next_rtc_data_in_irq(void *opaque, int n, int level)
>  static void next_scr2_rtc_update(NeXTPC *s)
>  {
>      uint8_t old_scr2, scr2_2;
> -    NeXTRTC *rtc = &s->rtc;
>  
>      old_scr2 = extract32(s->old_scr2, 8, 8);
>      scr2_2 = extract32(s->scr2, 8, 8);
> @@ -282,9 +282,7 @@ static void next_scr2_rtc_update(NeXTPC *s)
>          }
>      } else {
>          /* else end or abort */
> -        rtc->phase = 0;
> -        rtc->command = 0;
> -        rtc->value = 0;
> +        qemu_irq_raise(s->rtc_cmd_reset_irq);
>      }
>  }

Don't we also need a spot where the gpio gets lowered again?

 Thomas

