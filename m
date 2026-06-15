Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25A10CD98CE
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 05:49:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZ0Cb-0001Hu-PH; Mon, 15 Jun 2026 01:49:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wZ0CZ-0001HX-Vq
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 01:49:39 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wZ0CY-0005A7-6f
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 01:49:39 -0400
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 65F5nR9p008746
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 15 Jun 2026 14:49:27 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=5DT1+nZZxSUg9RtaAl7pJqTT0dQSMwGO9MlI5hZq22I=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1781502567; v=1;
 b=bV4pkLFxlpt9hJmJuRa/uwjSpOuXXK+Bc12bAJsupszmYGdL1wZ8oP0hqbl04tmA
 RXBSwua4eK38jgGOJ9pOYZfABPK2T2Ffir26cDtiH2R3chC3kp7CYRYC1itCavHY
 DEUPkhaug0KMpuGwnKST6gbWi4P93n86+jgXgxmOb/jADP+EqAyMVRA/WVmj2yhE
 +5gUxYavh0CFC5eZYnH0avG2kajMkMZZOPLTfLI/YXYRyN9WRwOKJsIpk77bUZZ1
 T7pBkA+FGbgyBqnlAjSS3JC1SLK5SNH+qWuiu0MHDRyIfz7jx7+D/2cOKv1zyJ2A
 ljpIXhPnqHM/d9UgOoc+gQ==
Message-ID: <76db7f41-cb6a-4738-bf51-0b8ac9fc21a8@rsg.ci.i.u-tokyo.ac.jp>
Date: Mon, 15 Jun 2026 14:49:26 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/7] igb: Refactor TX path to return processed byte
 count
To: Josh Hilke <jrhilke@google.com>, qemu-devel@nongnu.org
Cc: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Jason Wang <jasowang@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 David Matlack <dmatlack@google.com>,
 Alex Williamson <alex.williamson@nvidia.com>
References: <20260612-igb-trl-v3-0-19607f9a3dde@google.com>
 <20260612-igb-trl-v3-4-19607f9a3dde@google.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260612-igb-trl-v3-4-19607f9a3dde@google.com>
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

On 2026/06/13 6:50, Josh Hilke wrote:
> Modify igb_process_tx_desc to return the total size of the transmitted
> packet (in bytes) when processing the End of Packet (EOP) descriptor,
> and 0 otherwise. This allows the transmission loop to track how many
> bytes are being sent for rate-limiting calculations.
> 
> Signed-off-by: Josh Hilke <jrhilke@google.com>
> ---
>   hw/net/igb_core.c | 10 +++++++---
>   1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/net/igb_core.c b/hw/net/igb_core.c
> index 3eddfbe..4670c1e 100644
> --- a/hw/net/igb_core.c
> +++ b/hw/net/igb_core.c
> @@ -599,7 +599,7 @@ igb_on_tx_done_update_stats(IGBCore *core, struct NetTxPkt *tx_pkt, int qn)
>       }
>   }
>   
> -static void
> +static size_t
>   igb_process_tx_desc(IGBCore *core,
>                       PCIDevice *dev,
>                       struct igb_tx *tx,
> @@ -632,10 +632,10 @@ igb_process_tx_desc(IGBCore *core,
>               tx->ctx[idx].seqnum_seed = le32_to_cpu(tx_ctx_desc->seqnum_seed);
>               tx->ctx[idx].type_tucmd_mlhl = le32_to_cpu(tx_ctx_desc->type_tucmd_mlhl);
>               tx->ctx[idx].mss_l4len_idx = le32_to_cpu(tx_ctx_desc->mss_l4len_idx);
> -            return;
> +            return 0;
>           } else {
>               /* unknown descriptor type */
> -            return;
> +            return 0;
>           }
>       } else {
>           /* legacy descriptor */
> @@ -654,7 +654,9 @@ igb_process_tx_desc(IGBCore *core,
>       }
>   
>       if (cmd_type_len & E1000_TXD_CMD_EOP) {
> +        size_t total_len = 0;
>           if (!tx->skip_cp && net_tx_pkt_parse(tx->tx_pkt)) {
> +            total_len = net_tx_pkt_get_total_len(tx->tx_pkt);

This should be done after igb_tx_insert_vlan() since it can increase the 
packet size.

Regards,
Akihiko Odaki

>               idx = (tx->first_olinfo_status >> 4) & 1;
>               igb_tx_insert_vlan(core, queue_index, tx,
>                   tx->ctx[idx].vlan_macip_lens >> IGB_TX_FLAGS_VLAN_SHIFT,
> @@ -675,7 +677,9 @@ igb_process_tx_desc(IGBCore *core,
>           tx->first = true;
>           tx->skip_cp = false;
>           net_tx_pkt_reset(tx->tx_pkt, net_tx_pkt_unmap_frag_pci, dev);
> +        return total_len;
>       }
> +    return 0;
>   }
>   
>   static uint32_t igb_tx_wb_eic(IGBCore *core, int queue_idx)
> 


