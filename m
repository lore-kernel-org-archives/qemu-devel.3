Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CA70CD98F6
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 07:24:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wa76Z-0003lu-Ff; Thu, 18 Jun 2026 03:24:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wa76X-0003lU-Gh
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 03:24:01 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wa76V-0000os-E8
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 03:24:01 -0400
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 65I7NosC009657
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 18 Jun 2026 16:23:51 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=e20cxW3875e+Xle73d9bJD2fT3/qfoxyqkxfo4rfZLs=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1781767431; v=1;
 b=g4zKXh9bkASa0cHJsz5/PlDvO2/Y4c+aPrZ1+UjsgKE3xtHZiGDiauTy6hqVY8fO
 A5LV6VtCgVY023aP5qidlk0GkbgoOq/TaVM3wfOCLlgtEX34w1cBq8m95cvtFbf/
 CUIz19Mw+Ds+YXDyf/wAuLb8hZ/a1r5j0QqnHE/glPZyYvT0aRJupmqj+UPMRbyK
 d3NmuV9956QRTUVB5YR6BUx+pdXg7TOEE/7kxd3UE6daMhj6jqVXYUODoXAaxDuw
 Gn5BcZv71LpmQYJafOJQh7APlc6ZKSIzslFDgoNyeZtExbiv+69FvI6iEnbXCAHU
 GSiKQtJ1CIqf7zwra9FnEw==
Message-ID: <55fe504a-5ac1-4252-981d-453c4553bed7@rsg.ci.i.u-tokyo.ac.jp>
Date: Thu, 18 Jun 2026 16:23:50 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 5/7] igb: Implement TRL throttling and timer resumption
To: Josh Hilke <jrhilke@google.com>, qemu-devel@nongnu.org
Cc: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Jason Wang <jasowang@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 David Matlack <dmatlack@google.com>,
 Alex Williamson <alex.williamson@nvidia.com>
References: <20260617-igb-trl-v6-0-bbdfcadb81e2@google.com>
 <20260617-igb-trl-v6-5-bbdfcadb81e2@google.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260617-igb-trl-v6-5-bbdfcadb81e2@google.com>
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

On 2026/06/18 5:15, Josh Hilke wrote:
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
>   hw/net/igb_core.c | 60 ++++++++++++++++++++++++++++++++++++++++++++++++++++---
>   1 file changed, 57 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/net/igb_core.c b/hw/net/igb_core.c
> index 693353e..7d61d7d 100644
> --- a/hw/net/igb_core.c
> +++ b/hw/net/igb_core.c
> @@ -97,6 +97,7 @@ igb_receive_internal(IGBCore *core, const struct iovec *iov, int iovcnt,
>   static void igb_raise_interrupts(IGBCore *core, size_t index, uint32_t causes);
>   static void igb_reset(IGBCore *core, bool sw);
>   
> +
>   static inline void
>   igb_raise_legacy_irq(IGBCore *core)
>   {
> @@ -875,6 +876,42 @@ igb_tx_enabled(IGBCore *core, const E1000ERingInfo *txi)
>           (core->mac[TXDCTL0 + (qn * 16)] & E1000_TXDCTL_QUEUE_ENABLE);
>   }
>   
> +static uint64_t igb_trl_calculate_delay(const IGBTrlQueue *q,
> +                                        size_t bytes_sent)

The signature fits in one line.

> +{
> +    uint32_t target_rate;
> +    uint32_t rf_scaled;
> +
> +    if (!igb_trl_enabled(q)) {
> +        return 0;
> +    }
> +
> +    /*
> +     * The TRLRC register stores the Rate Factor in 10.14 fixed-point format:
> +     * - Bits 13:0: Fractional part
> +     * - Bits 23:14: Integer part
> +     *
> +     * Combined, the lower 24 bits of the register (23:0) represent the
> +     * concatenated 24-bit scaled Rate Factor directly.
> +     */
> +    rf_scaled = extract32(q->trlrc, 0, 24);
> +    if (rf_scaled == 0) {
> +        return 0;
> +    }
> +
> +    /*
> +     * Rate Factor = rf_scaled / 2^14
> +     * Target Rate = Link Rate / Rate Factor
> +     *             = (Link Rate * 2^14) / rf_scaled
> +     *
> +     * Clamp target rate to link speed.
> +     */
> +    target_rate = MIN(E1000_LINK_RATE_1GBPS,
> +                      (E1000_LINK_RATE_1GBPS << 14) / rf_scaled);
> +
> +    return muldiv64(bytes_sent, NANOSECONDS_PER_SECOND, target_rate);

By merging igb_trl_get_target_rate() and igb_trl_calculate_delay(), I 
meant not just to put the literal formulae into one place, but to fold 
them so that we don't have to worry about overflows and fractions until 
we really need them. Concretely:

     uint32_t divisor;
     uint32_t rf;

     if (!igb_trl_enabled(q)) {
         return 0;
     }

     /*
      * 7.8 Transmit Rate Limiting (TRL)
      *
      * > RF = 1Gb/s / Target-Rate (Rate Factor) is the ratio between the
      * > nominal link rate and the target maximum rate to achieve for
      * > that rate controlled queue. It is a decimal number ranging from
      * > 1 to 1,000 (1 Mb/s minimum target rate) at least 10-bits before
      * > the hexadecimal point and 14-bits after, as required for the
      * > maximum PL by which it is multiplied.
      *
      * The TRLRC register stores the RF in 10.14 fixed-point format:
      * - Bits 13:0: Fractional part
      * - Bits 23:14: Integer part
      *
      * Combined, the lower 24 bits of the register (23:0) represent the
      * RF directly.
      */
     rf = MAX(extract32(q->trlrc, 0, 24), 1 << 14);

     /*
      * Delay = PL (Packet Length) / Target-Rate
      *       = PL / (1Gb/s / RF)
      *       = PL * RF / 1Gb/s
      *       = PL * RF / (1G / b/B / ns/s)B/ns
      *       = (bytes_per_sent * (RF / 2^14) / (1G / b/B / ns/s))ns
      *       = (bytes_per_sent * RF / (1G / b/B * 2^14 / ns/s))ns
      */
     divisor = ((1000000000ULL / BITS_PER_BYTE) << 14) /
               NANOSECONDS_PER_SECOND;

     return bytes_sent * rf / divisor;

I also folded E1000_LINK_RATE_1GBPS here since its unit is unclear and 
we can centralize all unit conversions here by doing so.

Regards,
Akihiko Odaki

> +}
> +
>   static void
>   igb_start_xmit(IGBCore *core, const IGB_TxRing *txr)
>   {
> @@ -883,12 +920,19 @@ igb_start_xmit(IGBCore *core, const IGB_TxRing *txr)
>       union e1000_adv_tx_desc desc;
>       const E1000ERingInfo *txi = txr->i;
>       uint32_t eic = 0;
> +    size_t bytes_sent = 0;
> +    uint64_t delay_ns;
>   
>       if (!igb_tx_enabled(core, txi)) {
>           trace_e1000e_tx_disabled();
>           return;
>       }
>   
> +    if (igb_trl_enabled(&core->trl[txi->idx]) &&
> +        timer_pending(core->trl[txi->idx].timer)) {
> +        return;
> +    }
> +
>       d = pcie_sriov_get_vf_at_index(core->owner, txi->idx % 8);
>       if (!d) {
>           d = core->owner;
> @@ -902,9 +946,16 @@ igb_start_xmit(IGBCore *core, const IGB_TxRing *txr)
>           trace_e1000e_tx_descr((void *)(intptr_t)desc.read.buffer_addr,
>                                 desc.read.cmd_type_len, desc.wb.status);
>   
> -        igb_process_tx_desc(core, d, txr->tx, &desc, txi->idx);
> +        bytes_sent += igb_process_tx_desc(core, d, txr->tx, &desc, txi->idx);
>           igb_ring_advance(core, txi, 1);
>           eic |= igb_txdesc_writeback(core, base, &desc, txi);
> +
> +        delay_ns = igb_trl_calculate_delay(&core->trl[txi->idx], bytes_sent);
> +        if (delay_ns > 0) {
> +            timer_mod(core->trl[txi->idx].timer,
> +                      qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + delay_ns);
> +            break;
> +        }
>       }
>   
>       if (eic) {
> @@ -4329,7 +4380,6 @@ igb_autoneg_resume(IGBCore *core)
>                     qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL) + 500);
>       }
>   }
> -
>   bool igb_trl_enabled(const IGBTrlQueue *q)
>   {
>       return q->trlrc & E1000_TRLRC_RS_ENA;
> @@ -4337,7 +4387,11 @@ bool igb_trl_enabled(const IGBTrlQueue *q)
>   
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


