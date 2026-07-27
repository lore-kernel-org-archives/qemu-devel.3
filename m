Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A59EC53219
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 07:53:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woG9g-0008OE-GB; Mon, 27 Jul 2026 03:53:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1woG9c-0008MW-4E
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 03:53:40 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1woG9Z-00010r-Fu
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 03:53:39 -0400
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 66R7rPoG035543
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 27 Jul 2026 16:53:25 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=dAaCAYb5jKXvHWxI6rUrgYUBtGl+A1ZZZXB7e1iTgik=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1785138805; v=1;
 b=aCvnTVPBf+/JTPDDxH5tMdWM30XmuxF8Et5EnNE9KxS4keZ8nncKubLAx6DiMBLx
 51Dz43vicKquGwYn4jbtWDcVr6eBgNilB3ODvX9Ge1b2xwHPQmV6ozUrK6ACBZ0p
 zqMF4+jd+rTPL3McLPDgbz8u4jCppvgvx7kDEVzu0JENXrmvJL2aeYeSdE/QYwIl
 BwCt9CxJvVT8JN4U2r2BbwQmWzhDlH1QP5HASDsCcZOXG39y0oX6chuCBr5O5jZj
 JrQOEyecZ0wWo/VnSWFCz8duZ3zGN1YM/SwWB8z7ITOyjMIYMPrnGrTYTeTOVPwG
 DUPYgTXdBKMrK+cnibax2Q==
Message-ID: <69c86ece-ba69-419c-bfde-ef722e335f31@rsg.ci.i.u-tokyo.ac.jp>
Date: Mon, 27 Jul 2026 16:53:25 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 05/11] igb: Add VF post-load fixups for live migration
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Jason Wang <jasowangio@gmail.com>, Alex Williamson <alex@shazbot.org>,
 "Michael S . Tsirkin" <mst@redhat.com>, Peter Xu <peterx@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>
References: <20260727053935.1392269-1-clg@redhat.com>
 <20260727053935.1392269-6-clg@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260727053935.1392269-6-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 2026/07/27 14:39, Cédric Le Goater wrote:
> Add post-load fixups in igbvf_mig_load() to propagate VF interrupt
> state that the register load path bypasses by writing directly to
> mac[] without triggering register handler side effects.
> 
> igb_core_vf_propagate_irqs() ORs PVT shadow values back into the PF
> aggregates (EIMS/EIAC/EIAM) and clears stale VF bits from EICR.

OR cannot clear stale destination bits. Furthermore, source EIMC can 
clear the aggregate without updating PVTEIMS, so a disabled interrupt 
may be restored as enabled.

> 
> igb_core_vf_propagate_ivar() re-applies VTIVAR routing to the shared
> IVAR0 entries that the L1 PF driver may have overwritten after L0
> vmstate restore.
> 
> Assisted-by: Claude
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>   hw/net/igb_core.h      |  2 ++
>   hw/net/igb_core.c      | 56 ++++++++++++++++++++++++++++++++++++++++++
>   hw/net/igb_migration.c |  7 ++++++
>   3 files changed, 65 insertions(+)
> 
> diff --git a/hw/net/igb_core.h b/hw/net/igb_core.h
> index 58d4f57c99bb..150567eb346d 100644
> --- a/hw/net/igb_core.h
> +++ b/hw/net/igb_core.h
> @@ -144,4 +144,6 @@ void
>   igb_start_recv(IGBCore *core);
>   
>   IGBCore *igb_pf_get_core(void *pf);
> +void igb_core_vf_propagate_irqs(IGBCore *core, uint16_t vfn);
> +void igb_core_vf_propagate_ivar(IGBCore *core, uint16_t vfn);
>   #endif
> diff --git a/hw/net/igb_core.c b/hw/net/igb_core.c
> index 45d8fd795b84..2565dd7f96d3 100644
> --- a/hw/net/igb_core.c
> +++ b/hw/net/igb_core.c
> @@ -4550,3 +4550,59 @@ igb_core_post_load(IGBCore *core)
>   
>       return 0;
>   }
> +
> +/*
> + * Propagate VF interrupt state to PF aggregates after loading VF
> + * registers. The load path writes directly to mac[] bypassing the
> + * register handlers that OR VF bits into EIMS/EIAC/EIAM. Also clear
> + * stale VF bits in EICR that may have been set by packets arriving
> + * between PF vmstate restore and VF state load.
> + */
> +void igb_core_vf_propagate_irqs(IGBCore *core, uint16_t vfn)
> +{
> +    uint32_t shift = 22 - vfn * IGBVF_MSIX_VEC_NUM;
> +    uint32_t pvt_idx;
> +
> +    pvt_idx = PVTEIMS0 + vfn * 0x40;
> +    core->mac[EIMS] |= (core->mac[pvt_idx] & 0x7) << shift;
> +    pvt_idx = PVTEIAC0 + vfn * 0x40;
> +    core->mac[EIAC] |= (core->mac[pvt_idx] & 0x7) << shift;
> +    pvt_idx = PVTEIAM0 + vfn * 0x40;
> +    core->mac[EIAM] |= (core->mac[pvt_idx] & 0x7) << shift;
> +
> +    core->mac[EICR] &= ~(0x7 << shift);
> +}
> +
> +/*
> + * Re-apply VTIVAR -> IVAR0 interrupt routing. The L1 PF driver
> + * may have overwritten the shared IVAR0 entries with its own
> + * queue routing after L0 vmstate restore.
> + */
> +void igb_core_vf_propagate_ivar(IGBCore *core, uint16_t vfn)
> +{
> +    uint32_t vtivar = core->mac[VTIVAR + vfn];
> +    int n;
> +    uint8_t ent;
> +    uint32_t mask;
> +
> +    if (vtivar & E1000_IVAR_VALID) {
> +        n = igb_ivar_entry_rx(vfn);
> +        ent = E1000_IVAR_VALID |
> +              (24 - vfn * IGBVF_MSIX_VEC_NUM - (2 - (vtivar & 0x7)));
> +        mask = 0xffU << (8 * (n % 4));
> +        core->mac[IVAR0 + n / 4] =
> +            (core->mac[IVAR0 + n / 4] & ~mask) |
> +            ((uint32_t)ent << (8 * (n % 4)));
> +    }
> +
> +    ent = vtivar >> 8;
> +    if (ent & E1000_IVAR_VALID) {
> +        n = igb_ivar_entry_tx(vfn);
> +        ent = E1000_IVAR_VALID |
> +              (24 - vfn * IGBVF_MSIX_VEC_NUM - (2 - (ent & 0x7)));
> +        mask = 0xffU << (8 * (n % 4));
> +        core->mac[IVAR0 + n / 4] =
> +            (core->mac[IVAR0 + n / 4] & ~mask) |
> +            ((uint32_t)ent << (8 * (n % 4)));
> +    }
> +}

This function updates only valid entries. An invalid source route 
consequently leaves a stale valid destination route. Replace or clear 
each VF slice unconditionally.

Regards,
Akihiko Odaki

> diff --git a/hw/net/igb_migration.c b/hw/net/igb_migration.c
> index 61cf155a188d..4f123df6795d 100644
> --- a/hw/net/igb_migration.c
> +++ b/hw/net/igb_migration.c
> @@ -382,6 +382,7 @@ static int igb_core_vf_load_state(IgbVfState *s,
>   
>   static int igbvf_mig_load(IgbVfState *s, const void *buf, size_t size)
>   {
> +    IGBCore *core = igbvf_get_core(s);
>       int ret;
>   
>       ret = igb_core_vf_load_state(s, buf, size);
> @@ -389,6 +390,12 @@ static int igbvf_mig_load(IgbVfState *s, const void *buf, size_t size)
>           return ret;
>       }
>   
> +    /*
> +     * Post-load: sync VF interrupt and routing state to PF aggregates
> +     */
> +    igb_core_vf_propagate_irqs(core, s->vfn);
> +    igb_core_vf_propagate_ivar(core, s->vfn);
> +
>       return 0;
>   }
>   


