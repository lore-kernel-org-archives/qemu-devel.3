Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF909CD98E3
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 06:13:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZN2Q-0002pO-Gs; Tue, 16 Jun 2026 02:12:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wZN2O-0002ol-8f
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 02:12:40 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wZN2L-0006Qs-DH
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 02:12:39 -0400
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 65G6CM2F040544
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Tue, 16 Jun 2026 15:12:22 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=kCzWBtRTv/NXVlMSlgwLnjMMqQFc/a7ningIJINP3CY=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1781590342; v=1;
 b=TZHuXtdbYQ63WJoj222AXb0QEqz+Zj0KV1EzvENKoyQubf9RcLImaFZcqBC9eTmk
 z+3PcJWyEfmne/P1DsT+wCOjPJOYSE7/znCJElLNoUTiSrNDFjEBbePdKg96RhzU
 pzuN2R2NDadlG5jRHTyCkoNaWUxG9htUoIG6WfJv+foCjLf8rhmPAgAg8hblVs8h
 rjIyvW48u1ax99FouRk1LZbnPHYxwYYqLkAkRSsf04JlzFew4Mwrmqd5GKlPgUOo
 Ym8aet7SElbvgpPn9+/y2C3xNR3rr8FkQbkUdFEQLeTYQtn9G9LJ6qtD2KPwHOLi
 eHg7v7HnjwKc0Ky3x7HHhQ==
Message-ID: <eeccac7c-1517-420b-b879-8d26bac54bb1@rsg.ci.i.u-tokyo.ac.jp>
Date: Tue, 16 Jun 2026 15:12:21 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/7] igb: Define TRL registers and core state
To: Josh Hilke <jrhilke@google.com>, qemu-devel@nongnu.org
Cc: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Jason Wang <jasowang@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 David Matlack <dmatlack@google.com>,
 Alex Williamson <alex.williamson@nvidia.com>
References: <20260615-igb-trl-v4-0-cf5739bf529f@google.com>
 <20260615-igb-trl-v4-1-cf5739bf529f@google.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260615-igb-trl-v4-1-cf5739bf529f@google.com>
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

On 2026/06/16 7:18, Josh Hilke wrote:
> Introduce register offsets and bitmask constants for the Transmit Rate
> Limiter (TRL). Add the IGBTrlQueue structure and corresponding fields to
> IGBCore to track TRL state (timers, throttling status, and target rates)
> per queue. Initialize and free these timers during the device
> realize/uninit lifecycle, and reset them on device reset.
> 
> Signed-off-by: Josh Hilke <jrhilke@google.com>
> ---
>   hw/net/igb_common.h |  1 +
>   hw/net/igb_core.c   | 59 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>   hw/net/igb_core.h   | 13 ++++++++++++
>   hw/net/igb_regs.h   |  6 ++++++
>   4 files changed, 79 insertions(+)
> 
> diff --git a/hw/net/igb_common.h b/hw/net/igb_common.h
> index b316a5b..8c0a0cf 100644
> --- a/hw/net/igb_common.h
> +++ b/hw/net/igb_common.h
> @@ -148,6 +148,7 @@ enum {
>       defreg(MTA_A),
>   
>       defreg(VTIVAR), defreg(VTIVAR_MISC),
> +    defreg(TRLDQSEL), defreg(TRLRC),
>   };
>   
>   uint64_t igb_mmio_read(void *opaque, hwaddr addr, unsigned size);
> diff --git a/hw/net/igb_core.c b/hw/net/igb_core.c
> index 45d8fd7..c94e8d3 100644
> --- a/hw/net/igb_core.c
> +++ b/hw/net/igb_core.c
> @@ -96,6 +96,7 @@ igb_receive_internal(IGBCore *core, const struct iovec *iov, int iovcnt,
>   
>   static void igb_raise_interrupts(IGBCore *core, size_t index, uint32_t causes);
>   static void igb_reset(IGBCore *core, bool sw);
> +static uint32_t igb_trl_get_scaled_rate_factor(uint32_t trlrc);
>   
>   static inline void
>   igb_raise_legacy_irq(IGBCore *core)
> @@ -4282,6 +4283,53 @@ igb_autoneg_resume(IGBCore *core)
>       }
>   }
>   
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
> +    return trlrc & 0xFFFFFF;
> +}
> +
> +bool igb_trl_enabled(uint32_t trlrc)
> +{
> +    return trlrc & E1000_TRLRC_RS_ENA;
> +}
> +
> +uint64_t igb_trl_get_target_rate(const IGBTrlQueue *q)

Please add the static qualifier.

> +{
> +    const uint64_t rf_scaled = igb_trl_get_scaled_rate_factor(q->trlrc);
> +
> +    if (!igb_trl_enabled(q->trlrc)) {
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
> +static void igb_trl_timer_cb(void *opaque)
> +{
> +    /* Stub */
> +}
> +
>   void
>   igb_core_pci_realize(IGBCore        *core,
>                        const uint16_t *eeprom_templ,
> @@ -4296,6 +4344,11 @@ igb_core_pci_realize(IGBCore        *core,
>   
>       for (i = 0; i < IGB_NUM_QUEUES; i++) {
>           net_tx_pkt_init(&core->tx[i].tx_pkt, E1000E_MAX_TX_FRAGS);
> +        core->trl[i].timer =
> +            timer_new_ns(QEMU_CLOCK_VIRTUAL, igb_trl_timer_cb,
> +                         &core->trl[i]);
> +        core->trl[i].core = core;
> +        core->trl[i].queue_idx = i;
>       }
>   
>       net_rx_pkt_init(&core->rx_pkt);
> @@ -4319,6 +4372,7 @@ igb_core_pci_uninit(IGBCore *core)
>   
>       for (i = 0; i < IGB_NUM_QUEUES; i++) {
>           net_tx_pkt_uninit(core->tx[i].tx_pkt);
> +        timer_free(core->trl[i].timer);
>       }
>   
>       net_rx_pkt_uninit(core->rx_pkt);
> @@ -4469,6 +4523,11 @@ static void igb_reset(IGBCore *core, bool sw)
>   
>       igb_intrmgr_reset(core);
>   
> +    for (i = 0; i < IGB_NUM_QUEUES; i++) {
> +        timer_del(core->trl[i].timer);
> +        core->trl[i].trlrc = 0;
> +    }
> +
>       memset(core->phy, 0, sizeof core->phy);
>       memcpy(core->phy, igb_phy_reg_init, sizeof igb_phy_reg_init);
>   
> diff --git a/hw/net/igb_core.h b/hw/net/igb_core.h
> index d70b54e..f3d50bc 100644
> --- a/hw/net/igb_core.h
> +++ b/hw/net/igb_core.h
> @@ -63,6 +63,13 @@ typedef struct IGBIntrDelayTimer_st {
>       IGBCore *core;
>   } IGBIntrDelayTimer;
>   
> +typedef struct IGBTrlQueue_st {
> +    QEMUTimer *timer;
> +    IGBCore *core;
> +    int queue_idx;
> +    uint32_t trlrc;
> +} IGBTrlQueue;
> +
>   struct IGBCore {
>       uint32_t mac[E1000E_MAC_SIZE];
>       uint16_t phy[MAX_PHY_REG_ADDRESS + 1];
> @@ -99,6 +106,9 @@ struct IGBCore {
>       void (*owner_start_recv)(PCIDevice *d);
>   
>       int64_t timadj;
> +
> +    /* Transmit Rate Limiting */
> +    IGBTrlQueue trl[IGB_NUM_QUEUES];
>   };
>   
>   void
> @@ -143,4 +153,7 @@ igb_receive_iov(IGBCore *core, const struct iovec *iov, int iovcnt);
>   void
>   igb_start_recv(IGBCore *core);
>   
> +bool igb_trl_enabled(uint32_t trlrc);
> +uint64_t igb_trl_get_target_rate(const IGBTrlQueue *q);
> +
>   #endif
> diff --git a/hw/net/igb_regs.h b/hw/net/igb_regs.h
> index 4dc4c31..9ef628b 100644
> --- a/hw/net/igb_regs.h
> +++ b/hw/net/igb_regs.h
> @@ -718,4 +718,10 @@ static inline uint8_t igb_ivar_entry_tx(uint8_t i)
>       return i < 8 ? i * 4 + 1 : (i - 8) * 4 + 3;
>   }
>   
> +/* Transmit Rate Limiting */
> +#define E1000_TRLDQSEL 0x03604
> +#define E1000_TRLRC 0x036B0
> +#define E1000_TRLRC_RS_ENA BIT(31)
> +#define E1000_LINK_RATE_1GBPS (1000000000ULL / BITS_PER_BYTE)
> +
>   #endif
> 


