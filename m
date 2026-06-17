Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4857CD98E2
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 07:55:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZl7K-000684-Ry; Wed, 17 Jun 2026 03:55:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wZl7I-00067e-4d
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 03:55:20 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wZl7F-0006MS-8A
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 03:55:19 -0400
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 65H7sxCp064597
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 17 Jun 2026 16:54:59 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=MXSpxOxnyD7BxUSNzGGp7BOAW4aDpJ8Z7OiU6wGXC8I=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1781682899; v=1;
 b=hxaOyxiYGQyHOG9kKqrgPZ9ltwyVXnFZ+NaCSdjZCZrts6w7RTod68OApd/alpm3
 nnvO3pTUK3+QjvjTpm81/+lOATOr3sNlfop0Br7RD9yjeW510vFG3u3yz1ORPW1t
 gZvT8zJNu8HEqLev96NslY0dcbTAUKX24A9VCMefU47LlVbVUVVe9S74y0p/pjyS
 iJ9d1Ci7mlp9QKHWOjJPefxx1tegfVxGj+YO22DJd4P+MPpJDR7IlrgegmduEMfY
 qeMp5Qq7VmwI0nxtqEcMqW55bDbcMsHvfRCHMEboLAip3nk946csyphev+WYxIjA
 AoS1TdkewkhyjO3N5tk9wg==
Message-ID: <770787d0-250d-47fc-827a-c2b4226e4840@rsg.ci.i.u-tokyo.ac.jp>
Date: Wed, 17 Jun 2026 16:54:59 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/7] igb: Define TRL registers and core state
To: Josh Hilke <jrhilke@google.com>, qemu-devel@nongnu.org
Cc: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Jason Wang <jasowang@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 David Matlack <dmatlack@google.com>,
 Alex Williamson <alex.williamson@nvidia.com>
References: <20260616-igb-trl-v5-0-1183e3635e06@google.com>
 <20260616-igb-trl-v5-1-1183e3635e06@google.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260616-igb-trl-v5-1-1183e3635e06@google.com>
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
> Introduce register offsets and bitmask constants for the Transmit Rate
> Limiter (TRL). Add the IGBTrlQueue structure and corresponding fields to
> IGBCore to track TRL state (timers, throttling status, and target rates)
> per queue. Initialize and free these timers during the device
> realize/uninit lifecycle, and reset them on device reset.
> 
> Signed-off-by: Josh Hilke <jrhilke@google.com>
> ---
>   hw/net/igb_common.h |  1 +
>   hw/net/igb_core.c   | 41 +++++++++++++++++++++++++++++++++++++++++
>   hw/net/igb_core.h   | 12 ++++++++++++
>   hw/net/igb_regs.h   |  6 ++++++
>   4 files changed, 60 insertions(+)
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
> index 45d8fd7..44e8e58 100644
> --- a/hw/net/igb_core.c
> +++ b/hw/net/igb_core.c
> @@ -2136,6 +2136,15 @@ igb_set_phy_ctrl(IGBCore *core, uint16_t val)
>       }
>   }
>   
> +
> +static void igb_trl_reset(IGBCore *core)
> +{
> +    for (int i = 0; i < IGB_NUM_QUEUES; i++) {
> +        core->trl[i].trlrc = 0;
> +        timer_del(core->trl[i].timer);
> +    }
> +}
> +
>   void igb_core_set_link_status(IGBCore *core)
>   {
>       NetClientState *nc = qemu_get_queue(core->owner_nic);
> @@ -4282,6 +4291,33 @@ igb_autoneg_resume(IGBCore *core)
>       }
>   }
>   
> +bool igb_trl_enabled(const IGBTrlQueue *q)
> +{
> +    return q->trlrc & E1000_TRLRC_RS_ENA;
> +}
> +
> +static void igb_trl_timer_cb(void *opaque)
> +{
> +    /* Stub */
> +}
> +
> +static void igb_trl_init(IGBCore *core)
> +{
> +    for (int i = 0; i < IGB_NUM_QUEUES; i++) {
> +        IGBTrlQueue *q = &core->trl[i];
> +        q->timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, igb_trl_timer_cb, q);
> +        q->core = core;
> +        q->qidx = i;
> +    }
> +}
> +
> +static void igb_trl_uninit(IGBCore *core)
> +{
> +    for (int i = 0; i < IGB_NUM_QUEUES; i++) {
> +        timer_free(core->trl[i].timer);
> +    }
> +}
> +
>   void
>   igb_core_pci_realize(IGBCore        *core,
>                        const uint16_t *eeprom_templ,
> @@ -4297,6 +4333,7 @@ igb_core_pci_realize(IGBCore        *core,
>       for (i = 0; i < IGB_NUM_QUEUES; i++) {
>           net_tx_pkt_init(&core->tx[i].tx_pkt, E1000E_MAX_TX_FRAGS);
>       }
> +    igb_trl_init(core);
>   
>       net_rx_pkt_init(&core->rx_pkt);
>   
> @@ -4321,6 +4358,8 @@ igb_core_pci_uninit(IGBCore *core)
>           net_tx_pkt_uninit(core->tx[i].tx_pkt);
>       }
>   
> +    igb_trl_uninit(core);
> +
>       net_rx_pkt_uninit(core->rx_pkt);
>   }
>   
> @@ -4469,6 +4508,8 @@ static void igb_reset(IGBCore *core, bool sw)
>   
>       igb_intrmgr_reset(core);
>   
> +    igb_trl_reset(core);
> +
>       memset(core->phy, 0, sizeof core->phy);
>       memcpy(core->phy, igb_phy_reg_init, sizeof igb_phy_reg_init);
>   
> diff --git a/hw/net/igb_core.h b/hw/net/igb_core.h
> index d70b54e..d80cfaa 100644
> --- a/hw/net/igb_core.h
> +++ b/hw/net/igb_core.h
> @@ -63,6 +63,13 @@ typedef struct IGBIntrDelayTimer_st {
>       IGBCore *core;
>   } IGBIntrDelayTimer;
>   
> +typedef struct IGBTrlQueue_st {
> +    QEMUTimer *timer;
> +    IGBCore *core;
> +    unsigned int qidx;

Using an unsigned type is a good improvement, but unsigned int is not a 
type used elsewhere for the queue index. A possible candidate is 
uint32_t, which is used by core->mac[TRLDQSEL].

Regards,
Akihiko Odaki

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
> @@ -143,4 +153,6 @@ igb_receive_iov(IGBCore *core, const struct iovec *iov, int iovcnt);
>   void
>   igb_start_recv(IGBCore *core);
>   
> +bool igb_trl_enabled(const IGBTrlQueue *q);
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


