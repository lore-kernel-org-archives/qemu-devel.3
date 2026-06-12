Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7C80CD98CE
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2026 11:19:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXzuW-00084T-Ji; Fri, 12 Jun 2026 07:18:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wXzuU-000837-HY
 for qemu-devel@nongnu.org; Fri, 12 Jun 2026 07:18:50 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wXzuS-00026t-Hp
 for qemu-devel@nongnu.org; Fri, 12 Jun 2026 07:18:50 -0400
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 65CBIXUT027407
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Fri, 12 Jun 2026 20:18:33 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=PPDD6TfFhYE1yujP/TOUOfWY/f1HlLV+pARAduFgOHk=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1781263113; v=1;
 b=Gvbw8uZRcJhF+LwoUL5oURt0cYw6bJKf7R/o7c2beOZoYxy4ACb1xISpDDcp4boH
 l1R4IqpVI3QhAtKdIH1CepFmwAQy4H+wY6F/jPBH0l4PMdd7j2QEvCh8QrGT/cHh
 yLtei6w6UHGxXOwRbMmmZMXrKGiQAIUhPT9f7u1NXGqKWLlnYjMingk3OF4SLvwE
 bOdvHpsYig52SF3mq+LWDMkBm5BIe6ZUxmNoTGsZQYgo3kwcnnevuUjXTWC0wl4m
 vvNiApsrIE6/Bg0Z1kg7qNYk2mZdLjrJ11sYJO6ghwUSu0F31bGjC8lNmBsdLz+r
 f0PANtt2WyjpHm7Dg/tNeA==
Message-ID: <29b87e3b-1df3-4a0a-9f80-a9b94ef3f685@rsg.ci.i.u-tokyo.ac.jp>
Date: Fri, 12 Jun 2026 20:18:32 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/7] igb: Implement TRL register write and configuration
To: Josh Hilke <jrhilke@google.com>, qemu-devel@nongnu.org
Cc: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Jason Wang <jasowang@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 David Matlack <dmatlack@google.com>,
 Alex Williamson <alex.williamson@nvidia.com>
References: <20260611-igb-trl-v2-0-bd58de9eb0fa@google.com>
 <20260611-igb-trl-v2-3-bd58de9eb0fa@google.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260611-igb-trl-v2-3-bd58de9eb0fa@google.com>
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
> Implement write handlers for TLDQSEL and TRLRC registers to allow the
> guest to configure Transmit Rate Limiting. Translate the register Rate
> Factor into a physical target rate (bytes/sec) per queue.  Disable TRL
> and clear timers when the link status changes or when TRL is disabled by
> the guest.
> 
> Signed-off-by: Josh Hilke <jrhilke@google.com>
> ---
>   hw/net/igb_core.c | 79 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 78 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/net/igb_core.c b/hw/net/igb_core.c
> index 05d8241..90d94d4 100644
> --- a/hw/net/igb_core.c
> +++ b/hw/net/igb_core.c
> @@ -2136,11 +2136,29 @@ igb_set_phy_ctrl(IGBCore *core, uint16_t val)
>       }
>   }
>   
> +static void igb_trl_disable_queue(IGBCore *core, int qidx)
> +{
> +    core->trl[qidx].target_rate = 0;
> +    core->trl[qidx].trlrc = 0;
> +
> +    timer_del(core->trl[qidx].timer);
> +}
> +
> +static void igb_trl_disable(IGBCore *core)
> +{
> +    for (int i = 0; i < IGB_NUM_QUEUES; i++) {
> +        igb_trl_disable_queue(core, i);
> +    }
> +    core->mac[TRLRC] &= ~E1000_TRLRC_RS_ENA;

Assigning core->mac[TRLRC] no longer makes difference.

Regards,
Akihiko Odaki

> +}
> +
>   void igb_core_set_link_status(IGBCore *core)
>   {
>       NetClientState *nc = qemu_get_queue(core->owner_nic);
>       uint32_t old_status = core->mac[STATUS];
>   
> +    igb_trl_disable(core);
> +
>       trace_e1000e_link_status_changed(nc->link_down ? false : true);
>   
>       if (nc->link_down) {
> @@ -2623,6 +2641,62 @@ static void igb_set_vtivar(IGBCore *core, int index, uint32_t val)
>        */
>   }
>   
> +static uint32_t igb_get_trlrc(IGBCore *core, int index)
> +{
> +    int qidx = core->mac[TRLDQSEL];
> +
> +    return core->trl[qidx].trlrc;
> +}
> +
> +static void igb_set_trldqsel(IGBCore *core, int index, uint32_t val)
> +{
> +    core->mac[index] = val & 0xF;
> +}
> +
> +static void igb_set_trlrc(IGBCore *core, int index, uint32_t val)
> +{
> +    uint64_t rf_scaled;
> +    int qidx;
> +
> +    core->mac[index] = val;
> +
> +    qidx = core->mac[TRLDQSEL];
> +    core->trl[qidx].trlrc = val;
> +
> +    if (!(val & E1000_TRLRC_RS_ENA)) {
> +        goto disable;
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
> +    rf_scaled = val & 0xFFFFFF;
> +
> +    /* Zero is not a valid rate factor, treat as disabled */
> +    if (rf_scaled == 0) {
> +        goto disable;
> +    }
> +    /*
> +     * The rate factor is a fixed-point number with a 14-bit fractional part:
> +     * Rate Factor = rf_scaled / 2^14
> +     *
> +     * The target rate is:
> +     * Target Rate = Link Rate / Rate Factor
> +     *             = Link Rate / (rf_scaled / 2^14)
> +     *             = (Link Rate * 2^14) / rf_scaled
> +     */
> +    core->trl[qidx].target_rate = (E1000_LINK_RATE_1GBPS << 14) / rf_scaled;
> +    return;
> +
> +disable:
> +    igb_trl_disable_queue(core, qidx);
> +}
> +
>   static inline void
>   igb_autoneg_timer(void *opaque)
>   {
> @@ -3678,6 +3752,7 @@ static const readops igb_macreg_readops[] = {
>       [RQDPC15] = igb_mac_read_clr4,
>       [VTIVAR ... VTIVAR + 7] = igb_mac_readreg,
>       [VTIVAR_MISC ... VTIVAR_MISC + 7] = igb_mac_readreg,
> +    [TRLRC] = igb_get_trlrc,
>   };
>   enum { IGB_NREADOPS = ARRAY_SIZE(igb_macreg_readops) };
>   
> @@ -4126,7 +4201,9 @@ static const writeops igb_macreg_writeops[] = {
>       [PVTEICR6] = igb_set_vteicr,
>       [PVTEICR7] = igb_set_vteicr,
>       [VTIVAR ... VTIVAR + 7] = igb_set_vtivar,
> -    [VTIVAR_MISC ... VTIVAR_MISC + 7] = igb_mac_writereg
> +    [VTIVAR_MISC ... VTIVAR_MISC + 7] = igb_mac_writereg,
> +    [TRLDQSEL] = igb_set_trldqsel,
> +    [TRLRC]    = igb_set_trlrc
>   };
>   enum { IGB_NWRITEOPS = ARRAY_SIZE(igb_macreg_writeops) };
>   
> 


