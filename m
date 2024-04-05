Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBAC5CD1284
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2024 06:54:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsdSV-0006fy-IY; Fri, 05 Apr 2024 02:53:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pavel.dovgalyuk@ispras.ru>)
 id 1rsdST-0006fl-F2
 for qemu-devel@nongnu.org; Fri, 05 Apr 2024 02:53:53 -0400
Received: from mail.ispras.ru ([83.149.199.84])
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pavel.dovgalyuk@ispras.ru>)
 id 1rsdSQ-00087Z-PC
 for qemu-devel@nongnu.org; Fri, 05 Apr 2024 02:53:53 -0400
Received: from [10.12.10.172] (unknown [78.37.10.254])
 by mail.ispras.ru (Postfix) with ESMTPSA id EB7784076735;
 Fri,  5 Apr 2024 06:53:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru EB7784076735
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
 s=default; t=1712300007;
 bh=11FDnVn4whbBWqDbQsiag3HswbNQyE+yMnIKZ27REAQ=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=PcMhvndn7drnN6PIejm38tC2YxHMa2dD04nyTB+C4Udu0M6bOdj6ZmZITXF4rDrPD
 5g7NCuGyWfJPL7g6I9Nbq6DuE25ZWj+4zdXJ0ilzPsD1DBv3SfwOgu63Zl9/SyNZdC
 Rbz7gYQMn+xmXJiWWNTceeeBzFSOSoxer9hnJIhU=
Message-ID: <6f934f8e-c5f7-4ef4-a2e0-561e81dda9f2@ispras.ru>
Date: Fri, 5 Apr 2024 09:53:26 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 10/24] virtio-net: Use replay_schedule_bh_event for bhs
 that affect machine state
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
References: <20240318154621.2361161-1-npiggin@gmail.com>
 <20240318154621.2361161-11-npiggin@gmail.com>
From: Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru>
In-Reply-To: <20240318154621.2361161-11-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=83.149.199.84;
 envelope-from=pavel.dovgalyuk@ispras.ru; helo=mail.ispras.ru
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Reviewed-by: Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>

On 18.03.2024 18:46, Nicholas Piggin wrote:
> The regular qemu_bh_schedule() calls result in non-deterministic
> execution of the bh in record-replay mode, which causes replay failure.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>   hw/net/virtio-net.c | 11 ++++++-----
>   1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index 9959f1932b..6ac737f2cf 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -40,6 +40,7 @@
>   #include "migration/misc.h"
>   #include "standard-headers/linux/ethtool.h"
>   #include "sysemu/sysemu.h"
> +#include "sysemu/replay.h"
>   #include "trace.h"
>   #include "monitor/qdev.h"
>   #include "monitor/monitor.h"
> @@ -416,7 +417,7 @@ static void virtio_net_set_status(struct VirtIODevice *vdev, uint8_t status)
>                   timer_mod(q->tx_timer,
>                                  qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + n->tx_timeout);
>               } else {
> -                qemu_bh_schedule(q->tx_bh);
> +                replay_bh_schedule_event(q->tx_bh);
>               }
>           } else {
>               if (q->tx_timer) {
> @@ -2724,7 +2725,7 @@ static void virtio_net_tx_complete(NetClientState *nc, ssize_t len)
>            */
>           virtio_queue_set_notification(q->tx_vq, 0);
>           if (q->tx_bh) {
> -            qemu_bh_schedule(q->tx_bh);
> +            replay_bh_schedule_event(q->tx_bh);
>           } else {
>               timer_mod(q->tx_timer,
>                         qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + n->tx_timeout);
> @@ -2879,7 +2880,7 @@ static void virtio_net_handle_tx_bh(VirtIODevice *vdev, VirtQueue *vq)
>           return;
>       }
>       virtio_queue_set_notification(vq, 0);
> -    qemu_bh_schedule(q->tx_bh);
> +    replay_bh_schedule_event(q->tx_bh);
>   }
>   
>   static void virtio_net_tx_timer(void *opaque)
> @@ -2962,7 +2963,7 @@ static void virtio_net_tx_bh(void *opaque)
>       /* If we flush a full burst of packets, assume there are
>        * more coming and immediately reschedule */
>       if (ret >= n->tx_burst) {
> -        qemu_bh_schedule(q->tx_bh);
> +        replay_bh_schedule_event(q->tx_bh);
>           q->tx_waiting = 1;
>           return;
>       }
> @@ -2976,7 +2977,7 @@ static void virtio_net_tx_bh(void *opaque)
>           return;
>       } else if (ret > 0) {
>           virtio_queue_set_notification(q->tx_vq, 0);
> -        qemu_bh_schedule(q->tx_bh);
> +        replay_bh_schedule_event(q->tx_bh);
>           q->tx_waiting = 1;
>       }
>   }


