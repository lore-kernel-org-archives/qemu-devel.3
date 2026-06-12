Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11252CD98CE
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2026 11:18:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXztR-0007fo-H8; Fri, 12 Jun 2026 07:17:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wXztO-0007fN-VE
 for qemu-devel@nongnu.org; Fri, 12 Jun 2026 07:17:43 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wXztL-0001px-VD
 for qemu-devel@nongnu.org; Fri, 12 Jun 2026 07:17:42 -0400
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 65CBHMBv027098
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Fri, 12 Jun 2026 20:17:22 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=9w3h1Zq5WRjGTFRqaeqUgyMwUvrWPJHWXaie8WL4nr8=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1781263042; v=1;
 b=bVo2g73WpTy6cBApnoKiycyOg+vyM1kaw5l8ql5YeYpxmPy5XJyWO8aT+Df0G1gN
 Kx+BN9I2mAka4iEoNOvNBz07ZEpw7hDDgLkJkX3xI51qOO8+hdivU2mXc6wVWjXA
 BAtfJs/HqET0Q4glltkDcHG1pSGmp0tNr18Y7o9Q6tNKR9L/y95qCuExFP0vSSF2
 vi+PxGqjCFRGFCaKsbBreL5NmSoNua3Hcz2ZYIG4jy6s8uUCeNH2Bli2t+u0k0KY
 7q1vdMnHIEdtKUsUK0R8ppz2Zs0rV6zQZSKFgip9br0U3tW6kGXAVTbsAPtiYwAB
 VFFl6RE0FM9t+ffNdbNgGA==
Message-ID: <1a37cf72-ec21-4c77-8554-fb07394eb3c7@rsg.ci.i.u-tokyo.ac.jp>
Date: Fri, 12 Jun 2026 20:17:22 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/7] igb: Define TRL registers and core state
To: Josh Hilke <jrhilke@google.com>, qemu-devel@nongnu.org
Cc: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Jason Wang <jasowang@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 David Matlack <dmatlack@google.com>,
 Alex Williamson <alex.williamson@nvidia.com>
References: <20260611-igb-trl-v2-0-bd58de9eb0fa@google.com>
 <20260611-igb-trl-v2-1-bd58de9eb0fa@google.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260611-igb-trl-v2-1-bd58de9eb0fa@google.com>
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

On 2026/06/12 6:11, Josh Hilke wrote:
> Introduce register offsets and bitmask constants for the Transmit Rate
> Limiter (TRL). Add the IGBTrlQueue structure and corresponding fields to
> IGBCore to track TRL state (timers, throttling status, and target rates)
> per queue. Initialize and free these timers during the device
> realize/uninit lifecycle, and reset them on device reset.
> 
> Signed-off-by: Josh Hilke <jrhilke@google.com>
> ---
>   hw/net/igb_common.h |  1 +
>   hw/net/igb_core.c   | 17 +++++++++++++++++
>   hw/net/igb_core.h   | 11 +++++++++++
>   hw/net/igb_regs.h   | 11 +++++++++++
>   4 files changed, 40 insertions(+)
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
> index 45d8fd7..05d8241 100644
> --- a/hw/net/igb_core.c
> +++ b/hw/net/igb_core.c
> @@ -4282,6 +4282,11 @@ igb_autoneg_resume(IGBCore *core)
>       }
>   }
>   
> +static void igb_trl_timer_cb(void *opaque)
> +{
> +    /* Stub */
> +}
> +
>   void
>   igb_core_pci_realize(IGBCore        *core,
>                        const uint16_t *eeprom_templ,
> @@ -4296,6 +4301,11 @@ igb_core_pci_realize(IGBCore        *core,
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
> @@ -4319,6 +4329,7 @@ igb_core_pci_uninit(IGBCore *core)
>   
>       for (i = 0; i < IGB_NUM_QUEUES; i++) {
>           net_tx_pkt_uninit(core->tx[i].tx_pkt);
> +        timer_free(core->trl[i].timer);
>       }
>   
>       net_rx_pkt_uninit(core->rx_pkt);
> @@ -4469,6 +4480,12 @@ static void igb_reset(IGBCore *core, bool sw)
>   
>       igb_intrmgr_reset(core);
>   
> +    for (i = 0; i < IGB_NUM_QUEUES; i++) {
> +        timer_del(core->trl[i].timer);
> +        core->trl[i].trlrc = 0;
> +        core->trl[i].target_rate = 0;
> +    }
> +
>       memset(core->phy, 0, sizeof core->phy);
>       memcpy(core->phy, igb_phy_reg_init, sizeof igb_phy_reg_init);
>   
> diff --git a/hw/net/igb_core.h b/hw/net/igb_core.h
> index d70b54e..49733b1 100644
> --- a/hw/net/igb_core.h
> +++ b/hw/net/igb_core.h
> @@ -63,6 +63,14 @@ typedef struct IGBIntrDelayTimer_st {
>       IGBCore *core;
>   } IGBIntrDelayTimer;
>   
> +typedef struct IGBTrlQueue_st {
> +    QEMUTimer *timer;
> +    IGBCore *core;
> +    int queue_idx;
> +    uint32_t trlrc;
> +    uint64_t target_rate;

I suggest removing target_rate and solely rely on trlrc instead. Keeping 
two variables is a common source of bug. Having it inside VMState also 
requires to keep two copies forever even if one of the data 
representations becomes useless in the future.

Regards,
Akihiko Odaki

> +} IGBTrlQueue;
> +
>   struct IGBCore {
>       uint32_t mac[E1000E_MAC_SIZE];
>       uint16_t phy[MAX_PHY_REG_ADDRESS + 1];
> @@ -99,6 +107,9 @@ struct IGBCore {
>       void (*owner_start_recv)(PCIDevice *d);
>   
>       int64_t timadj;
> +
> +    /* Transmit Rate Limiting */
> +    IGBTrlQueue trl[IGB_NUM_QUEUES];
>   };
>   
>   void
> diff --git a/hw/net/igb_regs.h b/hw/net/igb_regs.h
> index 4dc4c31..f7895ef 100644
> --- a/hw/net/igb_regs.h
> +++ b/hw/net/igb_regs.h
> @@ -718,4 +718,15 @@ static inline uint8_t igb_ivar_entry_tx(uint8_t i)
>       return i < 8 ? i * 4 + 1 : (i - 8) * 4 + 3;
>   }
>   
> +/* Transmit Rate Limiting */
> +#define E1000_TRLDQSEL 0x03604
> +#define E1000_TRLRC    0x036B0
> +
> +#define E1000_TRLRC_RS_ENA      BIT(31)
> +#define E1000_TRLRC_RF_DEC_MASK 0x3FFF
> +#define E1000_TRLRC_RF_INT_MASK 0x3FF
> +
> +/* 1 Gbps link rate in bytes per second (1,000,000,000 bits/s / 8) */
> +#define E1000_LINK_RATE_1GBPS 125000000ULL
> +
>   #endif
> 


