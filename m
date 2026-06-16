Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF867CD8CA8
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 06:13:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZN2g-0002wU-RE; Tue, 16 Jun 2026 02:12:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wZN2f-0002vz-K5
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 02:12:57 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wZN2d-0006Tw-Jo
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 02:12:57 -0400
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 65G6ChWx040680
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Tue, 16 Jun 2026 15:12:43 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=zGT6vgUwT2paA0eFUcSO5FfAzOcOtpGeD2KQWbHEEd0=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1781590363; v=1;
 b=Fz+JTGNRuIArPWwdYwS1JqEL7ZWo97xn8fgivZNg+xZ60qFi3ac/B7nNMAprhPef
 LCc8/6C9CcH1dQJXyzEAbFCxjj4OnlsZxbX1zUBvdBLs21LjIkX0msrP2TYVwmHA
 KtgEr4ZHb86o9AzyWsiEyFn+rCemLEAwnB/xnVkZXBMjg+4IllUXpywxKZ9COShC
 +PlWXg43KX1yAGSg00ImB9gUdFOQlozupawYGDFOTrbwcWa0UtMQsTkKz3Mp6LTN
 8rn5MUndLbp781LyIVN7PHxp1lNjWfhWaQis7bQ9B1jT4CwlhNVhDbNlaePySrP9
 ltLJioTklDMcEsKWtSMXaw==
Message-ID: <a8bfd3c4-bbae-4c0a-85f9-d7592dda3a53@rsg.ci.i.u-tokyo.ac.jp>
Date: Tue, 16 Jun 2026 15:12:43 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/7] igb: Implement TRL register write and configuration
To: Josh Hilke <jrhilke@google.com>, qemu-devel@nongnu.org
Cc: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Jason Wang <jasowang@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 David Matlack <dmatlack@google.com>,
 Alex Williamson <alex.williamson@nvidia.com>
References: <20260615-igb-trl-v4-0-cf5739bf529f@google.com>
 <20260615-igb-trl-v4-3-cf5739bf529f@google.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260615-igb-trl-v4-3-cf5739bf529f@google.com>
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
> Implement write handlers for TLDQSEL and TRLRC registers to allow the
> guest to configure Transmit Rate Limiting. Translate the register Rate
> Factor into a physical target rate (bytes/sec) per queue.  Disable TRL
> and clear timers when the link status changes or when TRL is disabled by
> the guest.
> 
> Signed-off-by: Josh Hilke <jrhilke@google.com>
> ---
>   hw/net/igb_core.c | 57 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 56 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/net/igb_core.c b/hw/net/igb_core.c
> index c94e8d3..dea8136 100644
> --- a/hw/net/igb_core.c
> +++ b/hw/net/igb_core.c
> @@ -2137,11 +2137,27 @@ igb_set_phy_ctrl(IGBCore *core, uint16_t val)
>       }
>   }
>   
> +static void igb_trl_disable_queue(IGBCore *core, int qidx)
> +{
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
> @@ -2624,6 +2640,42 @@ static void igb_set_vtivar(IGBCore *core, int index, uint32_t val)
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
> +    qidx = core->mac[TRLDQSEL];
> +    core->trl[qidx].trlrc = val;
> +
> +    if (!igb_trl_enabled(val)) {
> +        goto disable;
> +    }
> +
> +    rf_scaled = igb_trl_get_scaled_rate_factor(val);
> +
> +    /* Zero is not a valid rate factor, treat as disabled */
> +    if (rf_scaled == 0) {
> +        goto disable;
> +    }
> +    return;
> +
> +disable:
> +    igb_trl_disable_queue(core, qidx);

This behavior of overwriting TRLRC and dropping the pending work is not 
specified in the datasheet and extraneous.

Regards,
Akihiko Odaki

> +}
> +
>   static inline void
>   igb_autoneg_timer(void *opaque)
>   {
> @@ -3679,6 +3731,7 @@ static const readops igb_macreg_readops[] = {
>       [RQDPC15] = igb_mac_read_clr4,
>       [VTIVAR ... VTIVAR + 7] = igb_mac_readreg,
>       [VTIVAR_MISC ... VTIVAR_MISC + 7] = igb_mac_readreg,
> +    [TRLRC] = igb_get_trlrc,
>   };
>   enum { IGB_NREADOPS = ARRAY_SIZE(igb_macreg_readops) };
>   
> @@ -4127,7 +4180,9 @@ static const writeops igb_macreg_writeops[] = {
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


