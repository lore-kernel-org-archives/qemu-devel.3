Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 802B3CAC598
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 14:10:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyWN6-0000bA-7B; Tue, 16 Sep 2025 10:09:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uyWN4-0000Zg-4y
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 10:09:26 -0400
Received: from mail-yw1-x112f.google.com ([2607:f8b0:4864:20::112f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uyWN2-0005ns-0u
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 10:09:25 -0400
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-72ce9790aceso36776967b3.3
 for <qemu-devel@nongnu.org>; Tue, 16 Sep 2025 07:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758031762; x=1758636562; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=rBnw5wHMf5QAkmfvITJZI8gIrqDUotC+chL8JdKkWZY=;
 b=HRNY6pM3OgL4Y/S5i9imiyTt0MILjXrEjF8nUzs1zhs6x2kcDu6jMQrwpCPdWctOA3
 gob0JhmI7G764lGmL0pU7LYF6kDb5BqK5FZroMXe7MIqOly0n6PKMhUkef21bipMzWd2
 62uMI1x/3X3tdDpHpPqC2yY2xfEbflFcu0AakELjH8GqU531pJbPjaPgIdlJpVlRDmbe
 KV88X56KEgh0gMzwB6XOz2b/O+xquTKCCNPjlocWVjIhZb9FCjm+0CJUwR4NydtvmvwF
 zoV9u6fcALKLfth8GV399DfKX4byy903paywTikPbiCHZB6EjPzqzC28GP81lTl8CvJZ
 E6IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758031762; x=1758636562;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rBnw5wHMf5QAkmfvITJZI8gIrqDUotC+chL8JdKkWZY=;
 b=qKwMmacQnyILU19Tls57nMyLS/W/6Gwvvzd8iXrx9nfbXkF/fQJnStm0MZMbdYruj0
 SijTUC4tgKhoteVHm5fgoXmuh21gQsdUcI7jat1o6BElTuwoXamTpn/h4OMgWxXPn/v/
 VA6RFcGBzlJKRvyf4ipBGkFetlwhC326g4nZY7+DD4gkdgNHJlhPebrYcBcgpUDqK0/C
 3ig5Hiflp/TADDBkquyMgowB/+01q42oFXE+oR1koGH+XP7kS+nwHRj61BDda8g5t2c3
 XOJ2UinuBSC52ECPlBnbafNPqkMNZHaVduXMahRINpKlWaGobydT7RO6XpmiEcAPcQYy
 NbHg==
X-Gm-Message-State: AOJu0YwbXFAkVQHNC5ZK3SkVoMER7fWGqy8jDiB48uUlRHkKAYYDWdy+
 Vq2FgB/JGcfHJyChlIvwX7chYBnAESnNPVbUTfiUUP84ZwMmgpWTEenfOv2X5dJlrPPy1mi69oD
 mUoVWAMucK2m6AtiywGI4YcAw2QTUWr9sQ4ecYtNpYA==
X-Gm-Gg: ASbGnctRaMOGuN9Mrh2bX0EEn1cz6g+SrH7bKu93MyjTtyECCLPL/2biduxEMOS++8C
 6zg7XVAjnvQf/nKVtBzKRLkth3uBph5ufrYhmIm7XE8VhXwetzOO9ucq6eah4CpYthxFL6BFmi3
 KfX24wxGmrxbkwuDqJnrJ94NWWCMVCx/uoUZWmjYCzEz18yfzk9nzoDOMmsSZXPbeeIwY8FD8kF
 RomcXmD
X-Google-Smtp-Source: AGHT+IEMYTYJMW0I8kkNnXpHiEwJEJFK+/XPzHCXI738j3mIhI5whmvrBSrl+Iwlq6PZuoyCnCFE/NTGjv6MOPEA2W0=
X-Received: by 2002:a05:690c:6105:b0:721:69f6:d403 with SMTP id
 00721157ae682-730623e2b12mr147747457b3.11.1758031761934; Tue, 16 Sep 2025
 07:09:21 -0700 (PDT)
MIME-Version: 1.0
References: <tencent_E89CB2B19584679F7D6FF370ADEEC2992707@qq.com>
In-Reply-To: <tencent_E89CB2B19584679F7D6FF370ADEEC2992707@qq.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Sep 2025 15:09:10 +0100
X-Gm-Features: Ac12FXyP6M_7DabWncJukQVfTySqsBMW-w4jhHCDwGu0PVS-sRa9jsx2XVGsKj4
Message-ID: <CAFEAcA9s1fCej4rpsKAgb61w1_hoUoptDa9uNQncpx0TjbX_hQ@mail.gmail.com>
Subject: Re: [PATCH] hw/net/can: Remove redundant status bit setting in
 can_sja1000
To: SillyZ <1357816113@qq.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112f.google.com
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

On Tue, 16 Sept 2025 at 14:50, SillyZ <1357816113@qq.com> wrote:
>
> In PeliCAN mode reception, the RBS (Receive Buffer Status) bit
> is set twice at line 842 and 845 with identical operations:
>   s->status_pel |= 0x01;
>   s->status_pel |= (1 << 0);
>
> Between these two operations, only interrupt_pel is modified and
> status_pel bit 4 is cleared, neither affecting bit 0. The second
> operation is redundant.
>
> This cleanup aligns PeliCAN mode with BasicCAN mode, which correctly
> sets this bit only once (line 883).
>
> Signed-off-by: SillyZ <1357816113@qq.com>
> ---
>  hw/net/can/can_sja1000.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/hw/net/can/can_sja1000.c b/hw/net/can/can_sja1000.c
> index 5b6ba9df6c..6b08e977a1 100644
> --- a/hw/net/can/can_sja1000.c
> +++ b/hw/net/can/can_sja1000.c
> @@ -842,7 +842,6 @@ ssize_t can_sja_receive(CanBusClientState *client, const qemu_can_frame *frames,
>          s->status_pel |= 0x01; /* Set the Receive Buffer Status. DS-p23 */
>          s->interrupt_pel |= 0x01;
>          s->status_pel &= ~(1 << 4);
> -        s->status_pel |= (1 << 0);
>          can_sja_update_pel_irq(s);
>      } else { /* BasicCAN mode */
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

