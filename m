Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41686CD98CE
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 12:48:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXepe-0006HV-R3; Thu, 11 Jun 2026 08:48:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wXepc-0006HN-FM
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 08:48:24 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wXepZ-0002Dz-BQ
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 08:48:24 -0400
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 65BCm7V0066937
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 11 Jun 2026 21:48:07 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=51ca9CT925yxm45xMZQSM56r3e20zFtHF4IfAqoiID8=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1781182087; v=1;
 b=efXWWIGrTMUMgoqIYJX61nOJK2TD2nt2RGsK2AYxpYdYFI44n3FvVhsPtTPJG3sX
 qyoWk/1ILiDnD+7esUtFrXMW3Hs/QVx5LZhYquFwIJiW8Jq6SM1Ac2AYKJvJLeYw
 1Mg1nH/lLNqB5XKLUSjKSto5H8h6LZK9EQoq0FU2tO13MG65uKR8C0uyb6YK86cC
 o1YXEsZCnrJE89u0zx5Xh5Zuhzkgsm7y1aVL7Nb0Lzf7+DgHhP2ifcGsu2q+lYs+
 TgJdgNfNdFw/QakM472VVAfg20wXiyTJJgx9nfs5DH/lfwgi0aGY1P17pzom+xFm
 L77ob5WxI8YjmPwwxCpl6A==
Message-ID: <eaa0aa70-12a2-4340-9416-5f64072d3ee4@rsg.ci.i.u-tokyo.ac.jp>
Date: Thu, 11 Jun 2026 21:48:06 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] igb: Implement TRL throttling and timer resumption
To: Josh Hilke <jrhilke@google.com>, qemu-devel@nongnu.org
Cc: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Jason Wang <jasowang@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 David Matlack <dmatlack@google.com>,
 Alex Williamson <alex.williamson@nvidia.com>
References: <20260611023028.102071-1-jrhilke@google.com>
 <20260611023028.102071-5-jrhilke@google.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260611023028.102071-5-jrhilke@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 2026/06/11 11:30, Josh Hilke wrote:
> Integrate throttling logic into the transmission path. In
> `igb_start_xmit`, check if the queue is currently throttled.  Accumulate
> bytes sent, calculate the transmission delay based on the configured
> target rate, and if a throttle is triggered, set the virtual timer, mark
> the queue as throttled, and defer remaining packets.  Implement the
> timer callback to clear the throttled state and resume transmission when
> the timer expires.
> 
> Signed-off-by: Josh Hilke <jrhilke@google.com>
> ---
>   hw/net/igb_core.c | 37 +++++++++++++++++++++++++++++++++++--
>   1 file changed, 35 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/net/igb_core.c b/hw/net/igb_core.c
> index 9ed0e78..b8c0500 100644
> --- a/hw/net/igb_core.c
> +++ b/hw/net/igb_core.c
> @@ -875,6 +875,14 @@ igb_tx_enabled(IGBCore *core, const E1000ERingInfo *txi)
>           (core->mac[TXDCTL0 + (qn * 16)] & E1000_TXDCTL_QUEUE_ENABLE);
>   }
>   
> +static uint64_t igb_trl_calculate_delay(IGBCore *core, int qidx,
> +                                        size_t bytes_sent)
> +{
> +    uint64_t ns_per_sec = 1000000000ULL;

Please use NANOSECONDS_PER_SECOND.

> +
> +    return (uint64_t)bytes_sent * ns_per_sec / core->trl_target_rate[qidx];
> +}
> +
>   static void
>   igb_start_xmit(IGBCore *core, const IGB_TxRing *txr)
>   {
> @@ -883,17 +891,23 @@ igb_start_xmit(IGBCore *core, const IGB_TxRing *txr)
>       union e1000_adv_tx_desc desc;
>       const E1000ERingInfo *txi = txr->i;
>       uint32_t eic = 0;
> +    size_t bytes_sent;
>   
>       if (!igb_tx_enabled(core, txi)) {
>           trace_e1000e_tx_disabled();
>           return;
>       }
>   
> +    if (core->trl_throttled[txi->idx]) {
> +        return;
> +    }
> +
>       d = pcie_sriov_get_vf_at_index(core->owner, txi->idx % 8);
>       if (!d) {
>           d = core->owner;
>       }
>   
> +    bytes_sent = 0;
>       while (!igb_ring_empty(core, txi)) {
>           base = igb_ring_head_descr(core, txi);
>   
> @@ -902,9 +916,20 @@ igb_start_xmit(IGBCore *core, const IGB_TxRing *txr)
>           trace_e1000e_tx_descr((void *)(intptr_t)desc.read.buffer_addr,
>                                 desc.read.cmd_type_len, desc.wb.status);
>   
> -        igb_process_tx_desc(core, d, txr->tx, &desc, txi->idx);
> +        bytes_sent += igb_process_tx_desc(core, d, txr->tx, &desc, txi->idx);
>           igb_ring_advance(core, txi, 1);
>           eic |= igb_txdesc_writeback(core, base, &desc, txi);
> +
> +        if (core->trl_target_rate[txi->idx] > 0) {
> +            uint64_t delay_ns =
> +                igb_trl_calculate_delay(core, txi->idx, bytes_sent);
> +            if (delay_ns > 0) {
> +                core->trl_throttled[txi->idx] = true;

I think you can use timer_pending() instead of having a separate field, 
trl_throttled.

Regards,
Akihiko Odaki

> +                timer_mod(core->trl_timer[txi->idx].timer,
> +                          qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + delay_ns);
> +                break;
> +            }
> +        }
>       }
>   
>       if (eic) {
> @@ -4358,7 +4383,15 @@ igb_autoneg_resume(IGBCore *core)
>   
>   static void igb_trl_timer_cb(void *opaque)
>   {
> -    /* Stub */
> +    IGBTrlTimer *trl_timer = opaque;
> +    IGBCore *core = trl_timer->core;
> +    int qidx = trl_timer->queue_idx;
> +    IGB_TxRing txr;
> +
> +    core->trl_throttled[qidx] = false;
> +
> +    igb_tx_ring_init(core, &txr, qidx);
> +    igb_start_xmit(core, &txr);
>   }
>   
>   void


