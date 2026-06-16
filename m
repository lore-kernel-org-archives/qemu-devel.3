Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B014CD98D2
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 04:45:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZLf1-0004BS-MD; Tue, 16 Jun 2026 00:44:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wZLef-00049x-Kb
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 00:44:10 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wZLec-0007az-UT
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 00:44:05 -0400
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 65G4hcrA097231
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Tue, 16 Jun 2026 13:43:38 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=VZmuK66Fxz6xrfvfCjD5+FD1zm75+JH7GHChdoSzaDg=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1781585018; v=1;
 b=nApCy19l5hcWSLdeIr2xpAZ2XRnmKFthqQBZB6Euw3EmlmliOfJ8arDeiqVMsHhN
 Mc7chy68GOuxYbpm5h3wFzrQDgGjkD+JeUnUK7Njp6RTgxwpH4WarNQRroTvGIkq
 62p5U35IbACfzw1t4I/R5SJskXVPHiOQ6vaO/TBvbypVqgXW6BNckWrwLYj8HmJE
 98OHbiARqNDgeGP8Urgbbxl+mtp0fGvtV6gCdvElhDUk/dTCE0cCTzYCLUwqzwxk
 2wNuW1U6JuR77W3ee3Rp2A0uK7bjWTmML403DjViGYQ6ziLc5vwtbVM57VPpSy2h
 O7DkULuQKrRBwLT1SPKPDg==
Message-ID: <9be379f1-196e-474f-a39c-942e9c4cafd5@rsg.ci.i.u-tokyo.ac.jp>
Date: Tue, 16 Jun 2026 13:43:38 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/7] igb: Add VMState support for TRL state
To: Josh Hilke <jrhilke@google.com>, qemu-devel@nongnu.org
Cc: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Jason Wang <jasowang@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 David Matlack <dmatlack@google.com>,
 Alex Williamson <alex.williamson@nvidia.com>
References: <20260615-igb-trl-v4-0-cf5739bf529f@google.com>
 <20260615-igb-trl-v4-2-cf5739bf529f@google.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260615-igb-trl-v4-2-cf5739bf529f@google.com>
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
> Add VMState representation for the Transmit Rate Limiter (TRL) state to
> support migration. This includes the TRL timers and target rates per
> queue.
> 
> Signed-off-by: Josh Hilke <jrhilke@google.com>
> ---
>   hw/net/igb.c | 43 +++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 43 insertions(+)
> 
> diff --git a/hw/net/igb.c b/hw/net/igb.c
> index c076807..04c48f1 100644
> --- a/hw/net/igb.c
> +++ b/hw/net/igb.c
> @@ -563,6 +563,45 @@ static const VMStateDescription igb_vmstate_intr_timer = {
>       VMSTATE_STRUCT_ARRAY(_f, _s, _num, 0,                           \
>                            igb_vmstate_intr_timer, IGBIntrDelayTimer)
>   
> +static bool igb_trl_needed(void *opaque)
> +{
> +    IGBState *s = opaque;
> +
> +    for (int i = 0; i < IGB_NUM_QUEUES; i++) {
> +        if (igb_trl_enabled(s->core.trl[i].trlrc)) {

It will lose bits else E1000_TRLRC_RS_ENA when E1000_TRLRC_RS_ENA is not 
set. It should return true when any bit is set.

Regards,
Akihiko Odaki

> +            return true;
> +        }
> +    }
> +
> +    return false;
> +}
> +
> +static const VMStateDescription igb_vmstate_trl_queue = {
> +    .name = "igb-trl-queue",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .fields = (const VMStateField[]) {
> +        VMSTATE_TIMER_PTR(timer, IGBTrlQueue),
> +        VMSTATE_UINT32(trlrc, IGBTrlQueue),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
> +#define VMSTATE_IGB_TRL_QUEUE_ARRAY(_f, _s, _num)                    \
> +    VMSTATE_STRUCT_ARRAY(_f, _s, _num, 0,                            \
> +                         igb_vmstate_trl_queue, IGBTrlQueue)
> +
> +static const VMStateDescription igb_vmstate_trl_state = {
> +    .name = "igb/trl_state",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .needed = igb_trl_needed,
> +    .fields = (const VMStateField[]) {
> +        VMSTATE_IGB_TRL_QUEUE_ARRAY(core.trl, IGBState, IGB_NUM_QUEUES),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
>   static const VMStateDescription igb_vmstate = {
>       .name = "igb",
>       .version_id = 1,
> @@ -591,6 +630,10 @@ static const VMStateDescription igb_vmstate = {
>           VMSTATE_INT64(core.timadj, IGBState),
>   
>           VMSTATE_END_OF_LIST()
> +    },
> +    .subsections = (const VMStateDescription * const []) {
> +        &igb_vmstate_trl_state,
> +        NULL
>       }
>   };
>   
> 


