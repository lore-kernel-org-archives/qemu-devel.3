Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45680C4451C
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 12:11:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wm9Iv-00081H-2r; Tue, 21 Jul 2026 08:10:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wm9Is-0007zn-G9; Tue, 21 Jul 2026 08:10:30 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wm9Iq-0001sj-R1; Tue, 21 Jul 2026 08:10:30 -0400
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 66LCAKej045818
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Tue, 21 Jul 2026 21:10:20 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=JR8KYisS1exnA+cDcQ5qUmRkBOKa5qNf07fKDFkLWr4=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1784635820; v=1;
 b=o6VsGect1F8l5XS/TyDOMbjagjhRRsQ0VWlN4U+Ek2ld8qmjmqKDbZ4uZV7yxKRo
 Arwh96ND2VFnW9GEfeR7wZHf5xN6O8jHn3KqAnm6W0Gu2Q61PwTKFQFZqQ6LhDWv
 vMZ6+N3NoaJ21LpzEymDj7ZXCrDSz838GfBw1W7CibxZalMaqkR+fQwLnn9MeOrH
 waUyohw8I8OfyzhuGzdc2tFaVABp2TEerYyNmLkGmVvLXtTHS6H5JtFt10Y4QT72
 UxoxckumXXQekYLU53Dtzh99zUpnyUyDsn0qUk3fhROhRwsmkdAgADqXVeFS49DB
 umTJmBk7m9vxan2GA0a9iA==
Message-ID: <d134541f-0ac0-43be-87cc-c03cd712f40b@rsg.ci.i.u-tokyo.ac.jp>
Date: Tue, 21 Jul 2026 21:10:19 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] hw/net/igb: recalculate rx_desc_len on migration load
To: Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org
Cc: Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Jason Wang <jasowangio@gmail.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, qemu-stable@nongnu.org
References: <20260721111126.3278244-1-lvivier@redhat.com>
 <20260721111126.3278244-3-lvivier@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260721111126.3278244-3-lvivier@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 2026/07/21 20:11, Laurent Vivier wrote:
> Same issue as e1000e: rx_desc_len is migrated from the stream but
> can be computed from the register state. Recalculate it in post_load
> to prevent a crafted migration stream from setting an invalid value.

igb actually doesn't use the register state. igb_calc_rxdesclen() calls 
igb_rx_use_legacy_descriptor() to determine the value, but 
igb_rx_use_legacy_descriptor() is currently a stub and returns false.

The change itself is fine.

Regards,
Akihiko Odaki

> 
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> ---
>   hw/net/igb_core.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/hw/net/igb_core.c b/hw/net/igb_core.c
> index 45d8fd795b84..2a4883907353 100644
> --- a/hw/net/igb_core.c
> +++ b/hw/net/igb_core.c
> @@ -4548,5 +4548,7 @@ igb_core_post_load(IGBCore *core)
>       igb_intrmgr_resume(core);
>       igb_autoneg_resume(core);
>   
> +    igb_calc_rxdesclen(core);
> +
>       return 0;
>   }


