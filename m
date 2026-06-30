Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2069FC43458
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 07:42:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weT6R-0008J3-6P; Tue, 30 Jun 2026 03:41:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1weT6O-0008IB-JM
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 03:41:52 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1weT6L-0004Rs-Je
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 03:41:52 -0400
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 65U7ffdc088419
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Tue, 30 Jun 2026 16:41:41 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=+wi4rJdBYKd+ALuL6Jlxgy226asFlIhS7w/t2fWsNu8=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1782805301; v=1;
 b=kP1bXRNaINf86nAmHTEP+zBVeNKfidc1beec7bdYHeOHZ2WU77SwY65QI6uY/e1j
 sCDQ9JtnmtgXhXFWId0WBx9yGPGSWBpBVvsEYF17wEVXp6PadXMyh50oaBNNUe3h
 6uAl+KQ/TPwOHLNpmmtEwCohIkt3xTi/9oeHczYnFSCL/9rQtJYHCQAB7HnPYEmH
 moQC5TL+bGY4VaJ8X0IHfKUlagz6+w8fwRIdeyFxo+SkjWuoqjehXU6ogTwwfxBw
 o4OMl8GqGUNlKAuo8Y+Dxoqf6AcYnAicv0Kv3b0hV3trA893Uj2Rwhdxr009scpW
 vValBbAhneJEk8/9/nb3eg==
Message-ID: <3b65505c-818f-42d8-8e62-2e1195f155b0@rsg.ci.i.u-tokyo.ac.jp>
Date: Tue, 30 Jun 2026 16:41:41 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] hw/net: fix e1000e/igb ip_len inflation by Ethernet
 minimum-frame padding
To: Sanjeeva Yerrapureddy <y.sanjeevreddy@gmail.com>, qemu-devel@nongnu.org
Cc: Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Jason Wang <jasowang@redhat.com>
References: <20260629-net-tx-pkt-ip-length-padding-v5-1-16760e30252e@gmail.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260629-net-tx-pkt-ip-length-padding-v5-1-16760e30252e@gmail.com>
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

On 2026/06/30 0:21, Sanjeeva Yerrapureddy wrote:
> When a guest transmits a short Ethernet frame, iov_size() returns the
> padded wire length including any bytes added to reach the Ethernet
> minimum frame size of 60 bytes.  net_tx_pkt_rebuild_payload() uses
> this inflated size as payload_len.  net_tx_pkt_update_ip_hdr_checksum()
> then overwrites the IPv4 Total Length field with payload_len +
> l3_hdr_len, inflating it by the padding.  The receiver interprets
> Ethernet padding as IP payload, producing a malformed packet.
> 
> Fix by removing the ip_len write from net_tx_pkt_update_ip_hdr_checksum()
> so it only recomputes the checksum, and moving the ip_len assignment
> into net_tx_pkt_update_ip_checksums() where it is only performed for
> TSO (where ip_len must be derived from payload_len since the guest sets
> ip_len=0 per Intel 82574 datasheet §7.3.4 for super-packets the host
> will segment).
> 
> Both e1000e and igb already call net_tx_pkt_update_ip_hdr_checksum()
> from their IXSM paths, so both are corrected by this single common-
> layer change.
> 
> Signed-off-by: Sanjeeva Yerrapureddy <y.sanjeevreddy@gmail.com>

Reivewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

Thank you for promptly responding to reviews and identifying the cause 
of the issue.

Regards,
Akihiko Odaki

> ---
> Thank you Akihiko for the review of v4. I agree that avoiding two
> similar functions is cleaner. v5 moves the ip_len write into
> net_tx_pkt_update_ip_checksums() (the TSO path that already owns it)
> and strips it from net_tx_pkt_update_ip_hdr_checksum(), which becomes a
> pure checksum recomputation. The net effect is that both e1000e and igb
> IXSM paths are corrected automatically without any device-layer change.
> 
> Changes in v5:
> - Remove the ip_len write from net_tx_pkt_update_ip_hdr_checksum() so
>    it only recomputes the checksum.
> - Move the ip_len assignment into net_tx_pkt_update_ip_checksums() (the
>    TSO path), which already called net_tx_pkt_update_ip_hdr_checksum()
>    immediately after. The comment and the ip_len line are restored to
>    their upstream positions.
> - Remove net_tx_pkt_update_ip_hdr_checksum_only() entirely — no longer
>    needed.
> - Revert the e1000e IXSM path to its original call of
>    net_tx_pkt_update_ip_hdr_checksum(). Because that function no longer
>    inflates ip_len, igb (which already calls the same function) is also
>    corrected with no additional change.
> - Link to v4: https://lore.kernel.org/qemu-devel/20260628-net-tx-pkt-ip-length-padding-v4-1-829b36db5adb@gmail.com
> 
> Changes in v4:
> - Add net_tx_pkt_update_ip_hdr_checksum_only(); call it from the e1000e
>    IXSM path to avoid inflating ip_len.
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
> 
> To: qemu-devel@nongnu.org
> Cc: Dmitry Fleytman <dmitry.fleytman@gmail.com>
> Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> Cc: Jason Wang <jasowang@redhat.com>
> ---
>   hw/net/net_tx_pkt.c | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/net/net_tx_pkt.c b/hw/net/net_tx_pkt.c
> index 903238dca2..b134348fe8 100644
> --- a/hw/net/net_tx_pkt.c
> +++ b/hw/net/net_tx_pkt.c
> @@ -93,9 +93,6 @@ void net_tx_pkt_update_ip_hdr_checksum(struct NetTxPkt *pkt)
>       uint16_t csum;
>       assert(pkt);
>   
> -    pkt->l3_hdr.ip.ip_len = cpu_to_be16(pkt->payload_len +
> -        pkt->vec[NET_TX_PKT_L3HDR_FRAG].iov_len);
> -
>       pkt->l3_hdr.ip.ip_sum = 0;
>       csum = net_raw_checksum(pkt->l3_hdr.octets,
>           pkt->vec[NET_TX_PKT_L3HDR_FRAG].iov_len);
> @@ -117,7 +114,9 @@ void net_tx_pkt_update_ip_checksums(struct NetTxPkt *pkt)
>   
>       if (gso_type == VIRTIO_NET_HDR_GSO_TCPV4 ||
>           gso_type == VIRTIO_NET_HDR_GSO_UDP) {
> -        /* Calculate IP header checksum */
> +        /* Set ip_len and calculate IP header checksum */
> +        pkt->l3_hdr.ip.ip_len = cpu_to_be16(pkt->payload_len +
> +            pkt->vec[NET_TX_PKT_L3HDR_FRAG].iov_len);
>           net_tx_pkt_update_ip_hdr_checksum(pkt);
>   
>           /* Calculate IP pseudo header checksum */
> 
> ---
> base-commit: b83371668192a705b878e909c5ae9c1233cbd5fb
> change-id: 20260628-net-tx-pkt-ip-length-padding-951e75fa97b4
> 
> Best regards,
> --
> Sanjeeva Yerrapureddy <y.sanjeevreddy@gmail.com>
> 


