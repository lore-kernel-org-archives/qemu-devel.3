Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2390BCD98C5
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 05:57:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZ0K3-0002VL-V3; Mon, 15 Jun 2026 01:57:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wZ0K2-0002Un-Db
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 01:57:22 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wZ0K0-000601-IV
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 01:57:22 -0400
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 65F5v9R7012117
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 15 Jun 2026 14:57:09 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=A79jDKtoLOMCCcGnjoyxM8PqXabQ/9YUHzpBeZ3/wRY=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1781503029; v=1;
 b=Lc5orBmjocNPG42VWi4LAo9BndPn1gWLkDu78xHFKoGGGnDZ124/ihKVXhWkzEgt
 U//kKnFdOM1ssZFrSeGDkFnyAjwzLC9mu/Pn6+6nvVcZ/fN3WKm7/9opyS+lj6Ne
 t/IY99N8laWAnNmSQPjfV4ukb1KjAfOSD4IUV6HmvCo6ZORfKHvskJ682Q44q6Ri
 0oc1XPKPxh5m06tgUI9cUGccTlZ14ofXmWoq11ZBjxXQJUwCDYsIFVLmMsMVz0EG
 TW79kqFbgodi6Usp5TH5Gj5J8weS/zGqC+lxvCNUJFQccmaLQIcBRnXiD+hWv4KG
 Rn+3r0Oi0OBiG/xQmdKlvQ==
Message-ID: <6ab555ee-5d4e-4a3d-b408-3619fb999cd3@rsg.ci.i.u-tokyo.ac.jp>
Date: Mon, 15 Jun 2026 14:57:09 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/7] igb: Implement TRL throttling and timer resumption
To: Josh Hilke <jrhilke@google.com>, qemu-devel@nongnu.org
Cc: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Jason Wang <jasowang@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 David Matlack <dmatlack@google.com>,
 Alex Williamson <alex.williamson@nvidia.com>
References: <20260612-igb-trl-v3-0-19607f9a3dde@google.com>
 <20260612-igb-trl-v3-5-19607f9a3dde@google.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260612-igb-trl-v3-5-19607f9a3dde@google.com>
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

On 2026/06/13 6:50, Josh Hilke wrote:
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
>   hw/net/igb_core.c | 44 +++++++++++++++++++++++++++++++++++++++++---
>   1 file changed, 41 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/net/igb_core.c b/hw/net/igb_core.c
> index 4670c1e..c323a40 100644
> --- a/hw/net/igb_core.c
> +++ b/hw/net/igb_core.c
> @@ -875,6 +875,14 @@ igb_tx_enabled(IGBCore *core, const E1000ERingInfo *txi)
>           (core->mac[TXDCTL0 + (qn * 16)] & E1000_TXDCTL_QUEUE_ENABLE);
>   }
>   
> +static uint64_t igb_trl_calculate_delay(uint64_t target_rate,
> +                                        size_t bytes_sent)
> +{
> +    uint64_t ns_per_sec = 1000000000ULL;

Please use NANOSECONDS_PER_SECOND.

Regards,
Akihiko Odaki

> +
> +    return (uint64_t)bytes_sent * ns_per_sec / target_rate;
> +}
> +
>   static void
>   igb_start_xmit(IGBCore *core, const IGB_TxRing *txr)
>   {
> @@ -883,12 +891,19 @@ igb_start_xmit(IGBCore *core, const IGB_TxRing *txr)
>       union e1000_adv_tx_desc desc;
>       const E1000ERingInfo *txi = txr->i;
>       uint32_t eic = 0;
> +    size_t bytes_sent = 0;
> +    uint64_t target_rate;
> +    uint64_t delay_ns;
>   
>       if (!igb_tx_enabled(core, txi)) {
>           trace_e1000e_tx_disabled();
>           return;
>       }
>   
> +    if (timer_pending(core->trl[txi->idx].timer)) {
> +        return;
> +    }
> +
>       d = pcie_sriov_get_vf_at_index(core->owner, txi->idx % 8);
>       if (!d) {
>           d = core->owner;
> @@ -902,9 +917,19 @@ igb_start_xmit(IGBCore *core, const IGB_TxRing *txr)
>           trace_e1000e_tx_descr((void *)(intptr_t)desc.read.buffer_addr,
>                                 desc.read.cmd_type_len, desc.wb.status);
>   
> -        igb_process_tx_desc(core, d, txr->tx, &desc, txi->idx);
> +        bytes_sent += igb_process_tx_desc(core, d, txr->tx, &desc, txi->idx);
>           igb_ring_advance(core, txi, 1);
>           eic |= igb_txdesc_writeback(core, base, &desc, txi);
> +
> +        target_rate = igb_trl_get_target_rate(&core->trl[txi->idx]);
> +        if (target_rate > 0) {
> +            delay_ns = igb_trl_calculate_delay(target_rate, bytes_sent);
> +            if (delay_ns > 0) {
> +                timer_mod(core->trl[txi->idx].timer,
> +                          qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + delay_ns);
> +                break;
> +            }
> +        }
>       }
>   
>       if (eic) {
> @@ -2142,9 +2167,16 @@ igb_set_phy_ctrl(IGBCore *core, uint16_t val)
>   
>   static void igb_trl_disable_queue(IGBCore *core, int qidx)
>   {
> +    IGB_TxRing txr;
> +
>       core->trl[qidx].trlrc = 0;
>   
> -    timer_del(core->trl[qidx].timer);
> +    if (timer_pending(core->trl[qidx].timer)) {
> +        timer_del(core->trl[qidx].timer);
> +        /* Flush the queue of any pending packets */
> +        igb_tx_ring_init(core, &txr, qidx);
> +        igb_start_xmit(core, &txr);
> +    }
>   }
>   
>   static void igb_trl_disable(IGBCore *core)
> @@ -4375,7 +4407,13 @@ uint64_t igb_trl_get_target_rate(const IGBTrlQueue *q)
>   
>   static void igb_trl_timer_cb(void *opaque)
>   {
> -    /* Stub */
> +    IGBTrlQueue *trl = opaque;
> +    IGBCore *core = trl->core;
> +    int qidx = trl->queue_idx;
> +    IGB_TxRing txr;
> +
> +    igb_tx_ring_init(core, &txr, qidx);
> +    igb_start_xmit(core, &txr);
>   }
>   
>   void
> 


