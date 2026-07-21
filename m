Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D34B9C4451C
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 12:18:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wm9QT-00014g-Bm; Tue, 21 Jul 2026 08:18:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wm9QP-00014F-PZ; Tue, 21 Jul 2026 08:18:18 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wm9QM-0003K7-SN; Tue, 21 Jul 2026 08:18:17 -0400
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 66LCI0au049078
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Tue, 21 Jul 2026 21:18:00 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=tiz6sP8dmtLsU9Hg5DlqASAIyW24ZuCrV9bo/PpbL1Y=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1784636281; v=1;
 b=MBwxc82W7vc8qA2AzOiBVq1gz+UfrC2CfNk7laj3SFDBj3AiERVrcfJVaxOazPG1
 JZykgUWU4bc3pt4/E42XOogPY8EC5TsCA09LZDSXTSCs/ZWqzgf5DnfJXx9Xycgk
 gSsvqzPe8byF7+lHLveweEML1kGJuPCGVoXOBxvacg5w+JC1ZZJvxHaByQQRNu7j
 TDcZWe0+e11oMtMqRXGbKmRRVv3kUukf9sClP+GViIjNV0m9/Lk4+/LsHSj3YXQD
 emWhVfEuTvZpfBk+2WK3ECNTezib0Qk2IpR/6Be4OZmX8GmDekQUGqaM4YgvvDD5
 vToni9r8lsAChcjn5mZZFQ==
Message-ID: <5072abe3-162f-4760-9250-107877b266ef@rsg.ci.i.u-tokyo.ac.jp>
Date: Tue, 21 Jul 2026 21:18:00 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] hw/net/e1000e: recalculate rx_desc_len on migration
 load
To: Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org
Cc: Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Jason Wang <jasowangio@gmail.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, qemu-stable@nongnu.org
References: <20260721111126.3278244-1-lvivier@redhat.com>
 <20260721111126.3278244-2-lvivier@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260721111126.3278244-2-lvivier@redhat.com>
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
> rx_desc_len is migrated as a raw uint8_t from the stream, but it
> is a derived value that can be computed from the register state in
> core.mac[RCTL]. A crafted migration stream can set rx_desc_len to
> an invalid value (e.g. 64), causing a stack buffer overflow in
> e1000e_write_packet_to_guest() which copies rx_desc_len bytes into
> a 32-byte stack union.
> 
> Recalculate rx_desc_len from the register state in post_load,
> ignoring the untrusted value from the stream.
> 
> Cc: qemu-stable@nongnu.org
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3869
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> ---
>   hw/net/e1000e_core.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/hw/net/e1000e_core.c b/hw/net/e1000e_core.c
> index 46e156a5ddc2..31eb39e4aa40 100644
> --- a/hw/net/e1000e_core.c
> +++ b/hw/net/e1000e_core.c
> @@ -3557,5 +3557,7 @@ e1000e_core_post_load(E1000ECore *core)
>       e1000e_intrmgr_resume(core);
>       e1000e_autoneg_resume(core);
>   
> +    e1000e_calc_rxdesclen(core);

e1000e_set_rx_control()
e1000e has similar derived values in rxbuf_min_shift, rxbuf_sizes[], and 
rx_desc_buf_size, and e1000e_set_rx_control() computes it in sequence:

     e1000e_parse_rxbufsize(core);
     e1000e_calc_rxdesclen(core);
     core->rxbuf_min_shift = ((val / E1000_RCTL_RDMTS_QUAT) & 3) + 1 +
                                 E1000_RING_DESC_LEN_SHIFT;

I suggest creating a function to replicate this sequence for 
e1000e_core_post_load() instead of only calling e1000e_calc_rxdesclen().

Regards,
Akihiko Odaki

> +
>       return 0;
>   }


