Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79E42CD98ED
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 07:56:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZl7j-0006AH-0B; Wed, 17 Jun 2026 03:55:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wZl7h-0006A3-CL
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 03:55:45 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wZl7f-0006gP-Fb
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 03:55:45 -0400
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 65H7tZZh064788
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 17 Jun 2026 16:55:35 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=Jl6Bw2oHiNk9lZd8G5x/7MVXbzJ1Nv8PaKEeyuaD0Cc=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1781682935; v=1;
 b=CFkddcXWXnMZVWmCVlt2dionGOqWtiDO6vc/gdmUgTj2gw85tt+4bVi/m1X1svZQ
 zJ8AT3yQF9k5u05jxka/Amv9an/1d3n9mw4RGbceZl2/OxDYay4EliO0zLUqLMRt
 AyTVHnvA+3p4n+D/pxj4aRyfXa/0X8Cwi1HoF5Z65a5EGUO5R3eEgx2ZVCMCW+1U
 AW626IAZEO7/2YUjXnZ7L/RhhG1PKN0FYuTk6oYAG6hRcuHuu5aMX/7sVMmgOa9/
 K1rTiTA/CbLR7DuQcj3w/jNu9z6IXXAo0kG3BOtfJRnq7u6tGL1mafKeHlgJDIXX
 UdjagQkJuUc1myODa3o3/g==
Message-ID: <9ce7cef1-7e5c-49c0-840b-05a0e4237d5b@rsg.ci.i.u-tokyo.ac.jp>
Date: Wed, 17 Jun 2026 16:55:34 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/7] igb: Implement TRL throttling and timer resumption
To: Josh Hilke <jrhilke@google.com>, qemu-devel@nongnu.org
Cc: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Jason Wang <jasowang@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 David Matlack <dmatlack@google.com>,
 Alex Williamson <alex.williamson@nvidia.com>
References: <20260616-igb-trl-v5-0-1183e3635e06@google.com>
 <20260616-igb-trl-v5-5-1183e3635e06@google.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260616-igb-trl-v5-5-1183e3635e06@google.com>
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

On 2026/06/17 7:35, Josh Hilke wrote:
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
>   hw/net/igb_core.c | 73 +++++++++++++++++++++++++++++++++++++++++++++++++++++--
>   1 file changed, 71 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/net/igb_core.c b/hw/net/igb_core.c
> index b7f880e..7f14564 100644
> --- a/hw/net/igb_core.c
> +++ b/hw/net/igb_core.c
> @@ -96,6 +96,8 @@ igb_receive_internal(IGBCore *core, const struct iovec *iov, int iovcnt,
>   
>   static void igb_raise_interrupts(IGBCore *core, size_t index, uint32_t causes);
>   static void igb_reset(IGBCore *core, bool sw);
> +static uint64_t igb_trl_get_target_rate(const IGBTrlQueue *q);
> +
>   
>   static inline void
>   igb_raise_legacy_irq(IGBCore *core)
> @@ -875,6 +877,16 @@ igb_tx_enabled(IGBCore *core, const E1000ERingInfo *txi)
>           (core->mac[TXDCTL0 + (qn * 16)] & E1000_TXDCTL_QUEUE_ENABLE);
>   }
>   
> +static uint64_t igb_trl_calculate_delay(uint64_t target_rate,
> +                                        size_t bytes_sent)
> +{
> +    uint64_t low, high;
> +
> +    mulu64(&low, &high, bytes_sent, NANOSECONDS_PER_SECOND);
> +    divu128(&low, &high, target_rate);

What Philippe suggested is to use muldiv64(), but this is more 
complicated because of uint64_t. I think it will be simpler and more 
accurate if you merge igb_trl_get_target_rate() and this function.

Regards,
Akihiko Odaki

> +    return low;
> +}
> +
>   static void
>   igb_start_xmit(IGBCore *core, const IGB_TxRing *txr)
>   {
> @@ -883,12 +895,19 @@ igb_start_xmit(IGBCore *core, const IGB_TxRing *txr)
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
> @@ -902,9 +921,19 @@ igb_start_xmit(IGBCore *core, const IGB_TxRing *txr)
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
> @@ -4330,15 +4359,55 @@ igb_autoneg_resume(IGBCore *core)
>                     qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL) + 500);
>       }
>   }
> +static uint32_t igb_trl_get_scaled_rate_factor(uint32_t trlrc)
> +{
> +    /*
> +     * The TRLRC register stores the Rate Factor in 10.14 fixed-point format:
> +     * - Bits 13:0: Fractional part
> +     * - Bits 23:14: Integer part
> +     *
> +     * Combined, the lower 24 bits of the register (23:0) represent the
> +     * concatenated 24-bit scaled Rate Factor directly.
> +     */
> +    return extract32(trlrc, 0, 24);
> +}
>   
>   bool igb_trl_enabled(const IGBTrlQueue *q)
>   {
>       return q->trlrc & E1000_TRLRC_RS_ENA;
>   }
>   
> +static uint64_t igb_trl_get_target_rate(const IGBTrlQueue *q)
> +{
> +    const uint32_t rf_scaled = igb_trl_get_scaled_rate_factor(q->trlrc);
> +
> +    if (!igb_trl_enabled(q)) {
> +        return 0;
> +    }
> +
> +    if (rf_scaled == 0) {
> +        return 0;
> +    }
> +
> +    /*
> +     * The rate factor is a fixed-point number with a 14-bit fractional part:
> +     * Rate Factor = rf_scaled / 2^14
> +     *
> +     * The target rate is:
> +     * Target Rate = Link Rate / Rate Factor
> +     *             = Link Rate / (rf_scaled / 2^14)
> +     *             = (Link Rate * 2^14) / rf_scaled
> +     */
> +    return (E1000_LINK_RATE_1GBPS << 14) / rf_scaled;
> +}
> +
>   static void igb_trl_timer_cb(void *opaque)
>   {
> -    /* Stub */
> +    IGBTrlQueue *trl = opaque;
> +    IGB_TxRing txr;
> +
> +    igb_tx_ring_init(trl->core, &txr, trl->qidx);
> +    igb_start_xmit(trl->core, &txr);
>   }
>   
>   static void igb_trl_init(IGBCore *core)
> 


