Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D409C79F82
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 08:10:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3quP-0003vL-Jg; Tue, 08 Sep 2026 04:10:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1x3quN-0003uE-0D
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 04:10:23 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1x3quJ-0003yR-IF
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 04:10:22 -0400
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 6888A6xv032560
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Tue, 8 Sep 2026 17:10:06 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=/DXIDzpjmrhsS5c//yC5rbcbcUGMuF1XW4hQOLua9uI=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1788855006; v=1;
 b=i81juTjGo4+z0RmbHhUhyKHxrN0t3ioVIL+johT3RuP3oYjKLAAv0SLJsYfoRWUW
 JBDX+Q1NcNd0rAQM89c9PZhunyUor7NewvCLV17wNcW/e9bJwiNeiNRtjvl4hcJz
 TcNEn6/KQRzHOqxn/CshMMfa49JTc4Ujbs+DqUt47B/hrrZB+EQURVojlD50xZ67
 UNt5D+T5GbmjZx/IaTOCBoxFcYz58+ARV1TkvoCC84kOfn7kloYHoS6zn5m9lqyx
 T+aZheLLDwpMCuVkrgxFvn0RORKwkKazEE69UhcTFVdhhUeTCx70lDdiRGVn4V1Q
 vnkahsNWeP6BiYu+GIsg6w==
Message-ID: <ac517c84-40a3-422c-b022-41b3c8456855@rsg.ci.i.u-tokyo.ac.jp>
Date: Tue, 8 Sep 2026 17:10:05 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 4/9] igb: Add VF post-load fixups for live migration
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Jason Wang <jasowangio@gmail.com>, Alex Williamson <alex@shazbot.org>,
 Peter Xu <peterx@redhat.com>
References: <20260902192054.3329753-1-clg@redhat.com>
 <20260902192054.3329753-5-clg@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260902192054.3329753-5-clg@redhat.com>
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

On 2026/09/03 4:20, Cédric Le Goater wrote:
> After restoring per-VF register state, propagate the VF's PVT shadow
> values back into the PF's aggregate EIMS/EIAC/EIAM registers and
> re-apply the VTIVAR interrupt vector routing to the shared IVAR0.
> 
> AI-used-for: analysis, code (prototype)
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>   hw/net/igb_core.h      |  3 ++
>   hw/net/igb_core.c      | 66 ++++++++++++++++++++++++++++++++++++++++++
>   hw/net/igb_migration.c |  7 +++++
>   3 files changed, 76 insertions(+)
> 
> diff --git a/hw/net/igb_core.h b/hw/net/igb_core.h
> index 60724e2824ab..22e10e4e6d0b 100644
> --- a/hw/net/igb_core.h
> +++ b/hw/net/igb_core.h
> @@ -145,4 +145,7 @@ igb_start_recv(IGBCore *core);
>   
>   IGBCore *igb_pf_get_core(void *pf);
>   
> +void igb_core_vf_propagate_irqs(IGBCore *core, uint16_t vfn);
> +void igb_core_vf_propagate_ivar(IGBCore *core, uint16_t vfn);
> +
>   #endif
> diff --git a/hw/net/igb_core.c b/hw/net/igb_core.c
> index 2a4883907353..01745fe756d0 100644
> --- a/hw/net/igb_core.c
> +++ b/hw/net/igb_core.c
> @@ -4552,3 +4552,69 @@ igb_core_post_load(IGBCore *core)
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
> +    uint32_t vf_mask = 0x7 << shift;
> +    uint32_t pvt_idx;
> +
> +    core->mac[EIMS] &= ~vf_mask;

Restore the effective interrupt mask rather than the last EIMS write.

This clears the destination VF mask and copies PVTEIMS, but that shadow 
records only the last write: igb_set_vteims() assigns it before applying 
set-bit semantics to aggregate EIMS. For example, source writes EIMS=1, 
then EIMS=2, leave effective mask 3 and shadow 2; migration restores 2, 
suppressing vector 0 until explicitly enabled again. Conversely, EIMC 
updates aggregate EIMS without updating PVTEIMS, so migration reenables 
explicitly masked vectors. Patch 7 repeats this fixup on unquiesce 
without repairing the bookkeeping.

Regards,
Akihiko Odaki

> +    pvt_idx = PVTEIMS0 + vfn * 0x40;
> +    core->mac[EIMS] |= (core->mac[pvt_idx] & 0x7) << shift;
> +
> +    core->mac[EIAC] &= ~vf_mask;
> +    pvt_idx = PVTEIAC0 + vfn * 0x40;
> +    core->mac[EIAC] |= (core->mac[pvt_idx] & 0x7) << shift;
> +
> +    core->mac[EIAM] &= ~vf_mask;
> +    pvt_idx = PVTEIAM0 + vfn * 0x40;
> +    core->mac[EIAM] |= (core->mac[pvt_idx] & 0x7) << shift;
> +
> +    core->mac[EICR] &= ~vf_mask;
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
> +    n = igb_ivar_entry_rx(vfn);
> +    mask = 0xffU << (8 * (n % 4));
> +    if (vtivar & E1000_IVAR_VALID) {
> +        ent = E1000_IVAR_VALID |
> +              (24 - vfn * IGBVF_MSIX_VEC_NUM - (2 - (vtivar & 0x7)));
> +        core->mac[IVAR0 + n / 4] =
> +            (core->mac[IVAR0 + n / 4] & ~mask) |
> +            ((uint32_t)ent << (8 * (n % 4)));
> +    } else {
> +        core->mac[IVAR0 + n / 4] &= ~mask;
> +    }
> +
> +    n = igb_ivar_entry_tx(vfn);
> +    mask = 0xffU << (8 * (n % 4));
> +    ent = vtivar >> 8;
> +    if (ent & E1000_IVAR_VALID) {
> +        ent = E1000_IVAR_VALID |
> +              (24 - vfn * IGBVF_MSIX_VEC_NUM - (2 - (ent & 0x7)));
> +        core->mac[IVAR0 + n / 4] =
> +            (core->mac[IVAR0 + n / 4] & ~mask) |
> +            ((uint32_t)ent << (8 * (n % 4)));
> +    } else {
> +        core->mac[IVAR0 + n / 4] &= ~mask;
> +    }
> +}
> diff --git a/hw/net/igb_migration.c b/hw/net/igb_migration.c
> index c34035974620..af7257ccc4fd 100644
> --- a/hw/net/igb_migration.c
> +++ b/hw/net/igb_migration.c
> @@ -384,12 +384,19 @@ static int igb_core_vf_load_state(IgbVfState *s, const void *buf, size_t size)
>   static int igbvf_mig_load(IgbVfState *s, const void *buf, size_t size)
>   {
>       int ret;
> +    IGBCore *core = igbvf_get_core(s);
>   
>       ret = igb_core_vf_load_state(s, buf, size);
>       if (ret < 0) {
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


