Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBEDEC43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 07:50:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1we6ku-0005rs-Ok; Mon, 29 Jun 2026 03:50:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1we6ks-0005rc-Gc
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 03:50:10 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1we6kp-0002jz-5x
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 03:50:10 -0400
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 65T7ntT7080599
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 29 Jun 2026 16:49:55 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=Fym/IDJP1mJh+UksadXUAZptHqdRbesW/iBzqwAouDw=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1782719395; v=1;
 b=PkKq+oon/nAioeTXYBnBQINDju2WpkGRruYI0UFn10/0NgaZkFiPBxbb+KuQCsNd
 tqSaI3qKRONE3iV7iKIsQnMHW00U/zMznW4gE03Oo+L6NDDIna4RTKIozM9YJ5/4
 ZxqXTv6wZazl1NW6Dx0ZDJsFeFAQZju26eRN3QUyHs8tX7g9OUAoGReXXadKLEYw
 slY+H/5h4nfQTpMrIkaTjH6mqXxJV7YKegTlivC0wKNiFjt2tb9XNoohn4shL3GS
 e8oJ5xGgenW/mfSCtmy5mRa+vpqtQZbidRiGIhX+/H+evWdzlOu+38yL6P93ISLB
 0js1VT5+jZZn47bfVGuYtw==
Message-ID: <d30d23c2-5d95-40b0-92f1-cc2fd2329340@rsg.ci.i.u-tokyo.ac.jp>
Date: Mon, 29 Jun 2026 16:49:54 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] hw/net: fix e1000e ip_len inflation by Ethernet
 minimum-frame padding
To: Sanjeeva Yerrapureddy <y.sanjeevreddy@gmail.com>, qemu-devel@nongnu.org
Cc: Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Jason Wang <jasowang@redhat.com>
References: <20260628-net-tx-pkt-ip-length-padding-v4-1-1794063064fa@gmail.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260628-net-tx-pkt-ip-length-padding-v4-1-1794063064fa@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 2026/06/29 0:33, Sanjeeva Yerrapureddy wrote:
> When a guest transmits a short Ethernet frame, iov_size() returns the
> padded wire length including any bytes added to reach the Ethernet
> minimum frame size of 60 bytes.  net_tx_pkt_rebuild_payload() uses
> this inflated size as payload_len.  In the non-TSO IXSM path,
> net_tx_pkt_update_ip_hdr_checksum() then overwrites the IPv4 Total
> Length field with payload_len + l3_hdr_len, inflating it by the
> padding bytes.  The receiver interprets Ethernet padding as IP
> payload, producing a malformed packet.
> 
> Fix the IXSM path in e1000e by adding a new function,
> net_tx_pkt_update_ip_hdr_checksum_only(), that recomputes the IPv4
> header checksum without modifying ip_len.  For non-TSO packets the
> guest has already set ip_len correctly; only the checksum needs to be
> recomputed after the header is reassembled into the linear buffer.
> A new common-layer function is needed because struct NetTxPkt is
> opaque to device code and the IP header bytes required by
> net_raw_checksum() are inaccessible from e1000e_core.c.

Now we have a better picture of the issue. I think 
net_tx_pkt_update_ip_hdr_checksum() should not modify ip_len but only 
update checksum. The function has three callers:

- e1000e_setup_tx_offloads()
- igb_setup_tx_offloads()
- net_tx_pkt_update_ip_checksums()

igb has effectively the same requirement with e1000e, so 
net_tx_pkt_update_ip_checksums() is the exceptional one that needs 
modifying ip_len. So we can move the logic to modify ip_len to 
net_tx_pkt_update_ip_checksums(), and avoid having somewhat confusing 
two similar functions: net_tx_pkt_update_ip_hdr_checksum() and 
net_tx_pkt_update_ip_hdr_checksum_only(). Eventually we will have both 
e1000e and igb corrected just with a change of a few lines.

Regards,
Akihiko Odaki

> 
> The TSO path is unaffected: it continues to call
> net_tx_pkt_update_ip_checksums() which correctly writes ip_len from
> payload_len (ip_len=0 per Intel 82574 datasheet §7.3.4 for TSO
> super-packets that the host must segment).
> 
> Signed-off-by: Sanjeeva Yerrapureddy <y.sanjeevreddy@gmail.com>
> ---
> Thank you Akihiko for your review. I agree that device-specific logic
> should stay in device code and not in net_tx_pkt_rebuild_payload(). v4
> takes a different approach that avoids any changes to the common
> parsing path.
> 
> Changes in v4:
> - Revert all changes to net_tx_pkt_rebuild_payload(); it is unchanged
>    from upstream.
> - Add net_tx_pkt_update_ip_hdr_checksum_only() to the net_tx_pkt
>    common layer: identical to net_tx_pkt_update_ip_hdr_checksum() but
>    skips the ip_len write. A new common-layer function is necessary
>    because struct NetTxPkt is opaque to device code — the IP header
>    bytes needed by net_raw_checksum() are inaccessible from e1000e_core.c.
> - Change the IXSM (non-TSO) path in e1000e_setup_tx_offloads() to call
>    net_tx_pkt_update_ip_hdr_checksum_only(). The guest has already set
>    ip_len correctly; we only need to recompute the checksum.
> - The TSO path is unaffected: it continues to call
>    net_tx_pkt_update_ip_checksums() which correctly writes ip_len from
>    payload_len (ip_len=0 per §7.3.4 for TSO super-packets).
> - Link to v3: https://lore.kernel.org/qemu-devel/20260627-net-tx-pkt-ip-length-padding-v3-1-e860dabadd3f@gmail.com
> 
> Changes in v3:
> - Architectural redesign: three-case fallback logic in
>    net_tx_pkt_rebuild_payload() plus net_tx_pkt_set_payload_len() API;
>    e1000e pre-sets payload_len from PAYLEN descriptor field.
> - Link to v2: https://lore.kernel.org/qemu-devel/20260625-net-tx-pkt-ip-length-padding-v2-1-287d0ba59ec1@gmail.com
> 
> Changes in v2:
> - Fix iov_copy() to use raw_payload_len and net_tx_pkt_get_total_len()
>    to use iov_size() to preserve correct wire frame size.
> - Link to v1: https://lore.kernel.org/qemu-devel/20260624-net-tx-pkt-ip-length-padding-v1-1-7a22fe9b4e40@gmail.com
> 
> On the relationship to the short-packet receive-path discussion
> (Peter Maydell):
> https://lore.kernel.org/qemu-devel/CAFEAcA_UhmCxJc16CHE=4ZR1+PA0=4-29=fEe+d+iUmhLTzpuQ@mail.gmail.com/
> 
> The linked thread concerns the receive path. This patch addresses only
> the transmit path: the IXSM offload path was overwriting a correctly
> set guest ip_len with an inflated value that included Ethernet padding.
> No changes to padding behaviour or the receive path are made.
> ---
>   hw/net/e1000e_core.c |  8 +++++++-
>   hw/net/net_tx_pkt.c  | 17 +++++++++++++++++
>   hw/net/net_tx_pkt.h  | 13 +++++++++++++
>   3 files changed, 37 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/net/e1000e_core.c b/hw/net/e1000e_core.c
> index 46e156a5dd..3c0347caf8 100644
> --- a/hw/net/e1000e_core.c
> +++ b/hw/net/e1000e_core.c
> @@ -614,7 +614,13 @@ e1000e_setup_tx_offloads(E1000ECore *core, struct e1000e_tx *tx)
>       }
>   
>       if (tx->sum_needed & E1000_TXD_POPTS_IXSM) {
> -        net_tx_pkt_update_ip_hdr_checksum(tx->tx_pkt);
> +        /*
> +         * Guest already set ip_len correctly; only recompute the checksum.
> +         * net_tx_pkt_update_ip_hdr_checksum() would overwrite ip_len with
> +         * payload_len + l3_hdr_len, inflating it by any Ethernet
> +         * minimum-frame padding bytes present in payload_len.
> +         */
> +        net_tx_pkt_update_ip_hdr_checksum_only(tx->tx_pkt);
>       }
>   
>       return true;
> diff --git a/hw/net/net_tx_pkt.c b/hw/net/net_tx_pkt.c
> index 903238dca2..c2eae2f74b 100644
> --- a/hw/net/net_tx_pkt.c
> +++ b/hw/net/net_tx_pkt.c
> @@ -102,6 +102,23 @@ void net_tx_pkt_update_ip_hdr_checksum(struct NetTxPkt *pkt)
>       pkt->l3_hdr.ip.ip_sum = cpu_to_be16(csum);
>   }
>   
> +void net_tx_pkt_update_ip_hdr_checksum_only(struct NetTxPkt *pkt)
> +{
> +    uint16_t csum;
> +    assert(pkt);
> +
> +    /*
> +     * Recompute the IP header checksum without touching ip_len.
> +     * Used for non-TSO packets where the guest already set ip_len
> +     * correctly; overwriting it would inflate it by any Ethernet
> +     * minimum-frame padding present in payload_len.
> +     */
> +    pkt->l3_hdr.ip.ip_sum = 0;
> +    csum = net_raw_checksum(pkt->l3_hdr.octets,
> +        pkt->vec[NET_TX_PKT_L3HDR_FRAG].iov_len);
> +    pkt->l3_hdr.ip.ip_sum = cpu_to_be16(csum);
> +}
> +
>   void net_tx_pkt_update_ip_checksums(struct NetTxPkt *pkt)
>   {
>       uint16_t csum;
> diff --git a/hw/net/net_tx_pkt.h b/hw/net/net_tx_pkt.h
> index 0a716e74a5..d2840f38e8 100644
> --- a/hw/net/net_tx_pkt.h
> +++ b/hw/net/net_tx_pkt.h
> @@ -133,6 +133,19 @@ bool net_tx_pkt_update_sctp_checksum(struct NetTxPkt *pkt);
>    */
>   size_t net_tx_pkt_get_total_len(struct NetTxPkt *pkt);
>   
> +/**
> + * recompute the IPv4 header checksum without modifying ip_len
> + *
> + * Use for non-TSO packets where the guest already set ip_len correctly.
> + * Calling net_tx_pkt_update_ip_hdr_checksum() instead would overwrite
> + * ip_len with payload_len + l3_hdr_len, inflating it by any Ethernet
> + * minimum-frame padding present in payload_len.
> + *
> + * @pkt:            packet
> + *
> + */
> +void net_tx_pkt_update_ip_hdr_checksum_only(struct NetTxPkt *pkt);
> +
>   /**
>    * get packet type
>    *
> 
> ---
> base-commit: b83371668192a705b878e909c5ae9c1233cbd5fb
> change-id: 20260628-net-tx-pkt-ip-length-padding-951e75fa97b4
> 
> Best regards,
> --
> Sanjeeva Yerrapureddy <y.sanjeevreddy@gmail.com>
> 


