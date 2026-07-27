Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7062C531D0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 09:37:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woHlg-000384-9M; Mon, 27 Jul 2026 05:37:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1woHlG-00036F-JL
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 05:36:38 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1woHlD-0003OL-PY
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 05:36:38 -0400
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 66R9aNfq091817
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 27 Jul 2026 18:36:23 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=Jk+iAodhxQjUUHvFDaPiCvzH67T5wYVlw90sd6jb5Mk=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1785144983; v=1;
 b=R5iF8a1DiuuPRgAsRoNV29JiciO3H5GDSd+a5kGkLPxGwYD4zG6xedCsOrL25V4I
 6gXfph/3w/caj5WO5uL0wPgUe3YY00oAmZHLZOGN7m3Ow54VY8QqX6fbX+uU1j5u
 FMD5qt5zpQbkBVyROWiIBaJJeihi/X47sMiTn77R/BYczkkdKqRynJM8LFjM3YfV
 aEw9AA54c8rRLfZDFTPqb3YdzU8TD6gPUQ6XCj/CwYwa/wb8mD77j3qog59p6gGe
 EuSB4VHRzgDbzOQbgCHA6AFEPd+KjsBHfhNOK15I4Q9m8SBakhv871efMGpeIlV8
 G3HVMHQhjgM5mrH5j6m51g==
Message-ID: <c2651bd6-1fb2-4cc7-a3b7-a5fd59b7348d@rsg.ci.i.u-tokyo.ac.jp>
Date: Mon, 27 Jul 2026 18:36:23 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 08/11] igb: Fix post-migration RX ring deadlock
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Jason Wang <jasowangio@gmail.com>, Alex Williamson <alex@shazbot.org>,
 "Michael S . Tsirkin" <mst@redhat.com>, Peter Xu <peterx@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>
References: <20260727053935.1392269-1-clg@redhat.com>
 <20260727053935.1392269-9-clg@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260727053935.1392269-9-clg@redhat.com>
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
> After migration, the VF unquiesce path calls igb_start_recv() to kick
> RX processing. This does not trigger an interrupt, so NAPI stays idle
> and the RX ring is never replenished.
> 
> Replace igb_start_recv() with igb_core_vf_rearm_irqs(): re-apply the
> VF's PVT shadow register into the PF aggregates, then raise interrupt
> causes via igb_set_eics(). This follows the normal EICR -> EIMS ->
> MSI-X routing. NAPI wakes, replenishes the ring via
> igbvf_alloc_rx_buffers(), and writes RDT - breaking the deadlock.

I suppose NAPI refers to a Linux-internal concept. Please keep the 
device emulation OS-neutral.

> 
> The PVT re-application is needed because the L1 PF driver's normal
> interrupt handling may have cleared EIMS between state load and
> unquiesce.
> 
> Assisted-by: Claude
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>   hw/net/igb_core.h      |  1 +
>   hw/net/igb_core.c      | 12 ++++++++++++
>   hw/net/igb_migration.c |  2 +-
>   3 files changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/net/igb_core.h b/hw/net/igb_core.h
> index 50cee2c7683c..3db520048732 100644
> --- a/hw/net/igb_core.h
> +++ b/hw/net/igb_core.h
> @@ -147,5 +147,6 @@ igb_start_recv(IGBCore *core);
>   
>   IGBCore *igb_pf_get_core(void *pf);
>   void igb_core_vf_propagate_irqs(IGBCore *core, uint16_t vfn);
> +void igb_core_vf_rearm_irqs(IGBCore *core, uint16_t vfn);
>   void igb_core_vf_propagate_ivar(IGBCore *core, uint16_t vfn);
>   #endif
> diff --git a/hw/net/igb_core.c b/hw/net/igb_core.c
> index 03c349575c0a..1621ee6602d5 100644
> --- a/hw/net/igb_core.c
> +++ b/hw/net/igb_core.c
> @@ -4589,6 +4589,18 @@ void igb_core_vf_propagate_irqs(IGBCore *core, uint16_t vfn)
>       core->mac[EICR] &= ~(0x7 << shift);
>   }
>   
> +/*
> + * Re-apply VF interrupt enables to PF aggregates and raise interrupt
> + * causes to wake NAPI so it replenishes the ring after migration.
> + */
> +void igb_core_vf_rearm_irqs(IGBCore *core, uint16_t vfn)
> +{
> +    uint32_t shift = 22 - vfn * IGBVF_MSIX_VEC_NUM;
> +
> +    igb_core_vf_propagate_irqs(core, vfn);
> +    igb_set_eics(core, EICS, 0x7 << shift);

This fabricates all three interrupt causes instead of restoring the 
actual pending slice.

> +}
> +
>   /*
>    * Re-apply VTIVAR -> IVAR0 interrupt routing. The L1 PF driver
>    * may have overwritten the shared IVAR0 entries with its own
> diff --git a/hw/net/igb_migration.c b/hw/net/igb_migration.c
> index 187077c14c48..a0b4a52c865f 100644
> --- a/hw/net/igb_migration.c
> +++ b/hw/net/igb_migration.c
> @@ -630,7 +630,7 @@ static void igb_core_vf_unquiesce(IgbVfState *s)
>       trace_igbvf_mig_unquiesce(s->vfn, core->mac[VFRE], core->mac[VFTE]);
>   
>       if (re) {
> -        igb_start_recv(core);
> +        igb_core_vf_rearm_irqs(core, s->vfn);

Interrupt recovery runs only when saved VFRE is set. A valid 
RX-disabled/TX-enabled VF can therefore lose a pending TX completion.

Regards,
Akihiko Odaki

>       }
>   }
>   


