Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E43D0CD98E2
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 07:56:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZl7V-000695-E4; Wed, 17 Jun 2026 03:55:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wZl7T-00068u-TW
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 03:55:32 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wZl7R-0006cd-W7
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 03:55:31 -0400
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 65H7tKnm064717
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 17 Jun 2026 16:55:20 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=1Q47Ow4RHK5IU87YBvEL/BcV9QwAml86qZHF1nWeAAY=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1781682920; v=1;
 b=Xl0PRD8BByCsv9QoH1IlI45b3SBmHL3b8XXzCZuMHs5Xh2IIfwUH6rJkviyIufCi
 FBKrsIM0Uv/N4xIic2uNBdgIPqAiq7S3v569A6yWtUvrXFIVqfod2F69UIqTyAA+
 hDuQlYvU2l0fJW2EM6odqu+g/eJh3DTH3sWfnVM0pvDvQ0VkpyngiPCH+moqCNRd
 4211oOshcfFBrsBgtZ1QJkUpd4L8fGPT6s+5wzN4raq30wy0nomePC6Wek/01jVk
 3zO/cGeXDdRKaL7udN2dXUQYRfogG03587+xzoKDVrWfAKoqeankuxFRZ/l6B/6O
 OBeDQnwBMv7ByB83z990ug==
Message-ID: <fd8aa07d-1579-42ac-b9b4-17045b2d1e53@rsg.ci.i.u-tokyo.ac.jp>
Date: Wed, 17 Jun 2026 16:55:19 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/7] igb: Implement TRL register write and configuration
To: Josh Hilke <jrhilke@google.com>, qemu-devel@nongnu.org
Cc: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Jason Wang <jasowang@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 David Matlack <dmatlack@google.com>,
 Alex Williamson <alex.williamson@nvidia.com>
References: <20260616-igb-trl-v5-0-1183e3635e06@google.com>
 <20260616-igb-trl-v5-3-1183e3635e06@google.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260616-igb-trl-v5-3-1183e3635e06@google.com>
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
> Implement write handlers for TLDQSEL and TRLRC registers to allow the
> guest to configure Transmit Rate Limiting. Translate the register Rate
> Factor into a physical target rate (bytes/sec) per queue.  Disable TRL
> and clear timers when the link status changes or when TRL is disabled by
> the guest.
> 
> Signed-off-by: Josh Hilke <jrhilke@google.com>
> ---
>   hw/net/igb_core.c | 38 +++++++++++++++++++++++++++++++++++++-
>   1 file changed, 37 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/net/igb_core.c b/hw/net/igb_core.c
> index 44e8e58..fb31e37 100644
> --- a/hw/net/igb_core.c
> +++ b/hw/net/igb_core.c
> @@ -2145,11 +2145,21 @@ static void igb_trl_reset(IGBCore *core)
>       }
>   }
>   
> +static void igb_trl_disable(IGBTrlQueue *q)
> +{
> +    q->trlrc &= ~E1000_TRLRC_RS_ENA;
> +    timer_del(q->timer);

Don't do timer_del(q->timer) here; it will dismiss the pending request.

Regards,
Akihiko Odaki

> +}
> +
>   void igb_core_set_link_status(IGBCore *core)
>   {
>       NetClientState *nc = qemu_get_queue(core->owner_nic);
>       uint32_t old_status = core->mac[STATUS];
>   
> +    for (int i = 0; i < IGB_NUM_QUEUES; i++) {
> +        igb_trl_disable(&core->trl[i]);
> +    }
> +
>       trace_e1000e_link_status_changed(nc->link_down ? false : true);
>   
>       if (nc->link_down) {
> @@ -2632,6 +2642,29 @@ static void igb_set_vtivar(IGBCore *core, int index, uint32_t val)
>        */
>   }
>   
> +static uint32_t igb_get_trlrc(IGBCore *core, int index)
> +{
> +    const unsigned int qidx = core->mac[TRLDQSEL];
> +
> +    return core->trl[qidx].trlrc;
> +}
> +
> +static void igb_set_trldqsel(IGBCore *core, int index, uint32_t val)
> +{
> +    core->mac[index] = extract32(val, 0, 4);
> +}
> +
> +static void igb_set_trlrc(IGBCore *core, int index, uint32_t val)
> +{
> +    const unsigned int qidx = core->mac[TRLDQSEL];
> +
> +    core->trl[qidx].trlrc = val;
> +
> +    if (!igb_trl_enabled(&core->trl[qidx])) {
> +        igb_trl_disable(&core->trl[qidx]);
> +    }
> +}
> +
>   static inline void
>   igb_autoneg_timer(void *opaque)
>   {
> @@ -3687,6 +3720,7 @@ static const readops igb_macreg_readops[] = {
>       [RQDPC15] = igb_mac_read_clr4,
>       [VTIVAR ... VTIVAR + 7] = igb_mac_readreg,
>       [VTIVAR_MISC ... VTIVAR_MISC + 7] = igb_mac_readreg,
> +    [TRLRC] = igb_get_trlrc,
>   };
>   enum { IGB_NREADOPS = ARRAY_SIZE(igb_macreg_readops) };
>   
> @@ -4135,7 +4169,9 @@ static const writeops igb_macreg_writeops[] = {
>       [PVTEICR6] = igb_set_vteicr,
>       [PVTEICR7] = igb_set_vteicr,
>       [VTIVAR ... VTIVAR + 7] = igb_set_vtivar,
> -    [VTIVAR_MISC ... VTIVAR_MISC + 7] = igb_mac_writereg
> +    [VTIVAR_MISC ... VTIVAR_MISC + 7] = igb_mac_writereg,
> +    [TRLDQSEL] = igb_set_trldqsel,
> +    [TRLRC]    = igb_set_trlrc,
>   };
>   enum { IGB_NWRITEOPS = ARRAY_SIZE(igb_macreg_writeops) };
>   
> 


