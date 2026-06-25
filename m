Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDB58CDB479
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 04:53:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcc58-0002fF-KF; Thu, 25 Jun 2026 00:52:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wcc52-0002ey-21
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 00:52:49 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wcc4z-0000Kj-BE
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 00:52:47 -0400
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 65P4qWg1011845
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 25 Jun 2026 13:52:32 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=tO0jZhoPymB+OU+bpha3nswoqqwV54fKv18oRdnn9jo=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1782363152; v=1;
 b=ANzLStMlqEQx2ynDWv0AmsJGNmZLC2zszVMcC0Ttn35GCJY/R0vxo8Q4VBmB3mL9
 I3aIk3MFg15Ua9Oft/h0gRJZq6YENG+K7m/voMDkUBofjPTKPvysXyOoYxElUntG
 LXdlAPqGw8DRf86P4drsBkzKLj5StvVBwPEeCYYZj5Qk6JkBWmkc9d1Nk744fAO6
 79WLLOVwF93bH6aabOfXtHCrdQmnvA5oXzmNFnZn7Ia0NgIatKw5SkmAbt3Vo0j4
 FE9RxWxpMqb5Ruy8+kBB9V9GQqRcb9I4Lrq1hPZpc5AUE52mwvPU+/heI8t2SfcW
 2Dugd22M1gbl/GFimpZcbg==
Message-ID: <34d263ce-863f-4509-a2a0-55ac1d47da7a@rsg.ci.i.u-tokyo.ac.jp>
Date: Thu, 25 Jun 2026 13:52:31 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/net/net_tx_pkt: clamp payload_len to IP header length
 for padded frames
To: Sanjeeva Yerrapureddy <y.sanjeevreddy@gmail.com>, qemu-devel@nongnu.org
Cc: Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Jason Wang <jasowang@redhat.com>
References: <20260624-net-tx-pkt-ip-length-padding-v1-1-7a22fe9b4e40@gmail.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260624-net-tx-pkt-ip-length-padding-v1-1-7a22fe9b4e40@gmail.com>
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

On 2026/06/25 6:45, Sanjeeva Yerrapureddy wrote:
> When a guest transmits a short Ethernet frame, iov_size() returns the
> wire length including any Ethernet padding bytes added to reach the
> minimum 60-byte frame size.  net_tx_pkt_rebuild_payload() used that
> inflated size directly as payload_len.  net_tx_pkt_update_ip_hdr_
> checksum() then rewrites the IP Total Length (IPv4) or Payload Length
> (IPv6) field using this value, producing a malformed packet on the
> wire: the receiver interprets Ethernet padding bytes as IP payload.
> 
> In practice this breaks protocol stacks that validate IP lengths
> strictly.  A nested ESXi host running on OpenStack using the e1000e
> emulation sends short TCP ACK packets in response to a Windows guest's
> virtio TLS client hello, which get padded to 60 bytes; the inflated IP
> Total Length corrupts the IP header seen by Windows, causing TLS
> handshakes and TCP connections to fail.
> 
> Fix net_tx_pkt_rebuild_payload() to read the IP header's declared
> length and clamp payload_len accordingly:
> 
>    IPv4: ip_total_len - l3_hdr_len
>    IPv6: ip6_plen adjusted for parsed extension headers
> 
> Guard both paths against malformed guest packets where the header-
> declared length is shorter than the IP header itself; without the
> guard the unsigned subtraction would underflow, producing a huge
> payload_len.  Fall back to the raw iov_size() value in that case.

This breaks net_tx_pkt_get_total_len(), which also uses payload_len and 
expects pkt->hdr_len + pkt->payload_len produces the size of the entire 
packet. It is also unclear whether fall back to the raw iov_size() makes 
sense. I think we need to define what payload_len should represent to 
figure out a correct solution.

Regards,
Akihiko Odaki

> 
> Signed-off-by: Sanjeeva Yerrapureddy <y.sanjeevreddy@gmail.com>
> ---
>   hw/net/net_tx_pkt.c | 55 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 54 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/net/net_tx_pkt.c b/hw/net/net_tx_pkt.c
> index 903238dca2..d3549a4378 100644
> --- a/hw/net/net_tx_pkt.c
> +++ b/hw/net/net_tx_pkt.c
> @@ -274,7 +274,60 @@ static bool net_tx_pkt_parse_headers(struct NetTxPkt *pkt)
>   
>   static void net_tx_pkt_rebuild_payload(struct NetTxPkt *pkt)
>   {
> -    pkt->payload_len = iov_size(pkt->raw, pkt->raw_frags) - pkt->hdr_len;
> +    size_t raw_payload_len = iov_size(pkt->raw, pkt->raw_frags) - pkt->hdr_len;
> +    struct iovec *l2hdr = &pkt->vec[NET_TX_PKT_L2HDR_FRAG];
> +    uint16_t l3_proto = eth_get_l3_proto(l2hdr, 1, l2hdr->iov_len);
> +
> +    /*
> +     * Clamp payload_len to what the IP header says, not what iov_size()
> +     * returns. When a short frame is padded to the Ethernet minimum of 60
> +     * bytes, iov_size() includes the padding. Using that inflated size as
> +     * payload_len causes net_tx_pkt_update_ip_hdr_checksum() to rewrite the
> +     * IP total/payload length to include Ethernet padding, making the packet
> +     * malformed (receiver may treat padding as payload or miscalculate
> +     * checksums). Clamp to the guest-provided IP length instead.
> +     *
> +     * IPv4: ip_len is the total length including the IP header.
> +     * IPv6: ip6_plen is the payload length after the base 40-byte header
> +     *       (extension headers are included in ip6_plen but also in
> +     *       l3_hdr_len, so subtract them out).
> +     */
> +    if (l3_proto == ETH_P_IP) {
> +        uint16_t ip_total_len = be16_to_cpu(pkt->l3_hdr.ip.ip_len);
> +        size_t l3_hdr_len = pkt->vec[NET_TX_PKT_L3HDR_FRAG].iov_len;
> +        /*
> +         * Guard against malformed packets where ip_total_len is zero or
> +         * smaller than the IP header itself. Without this check, the
> +         * subtraction (ip_total_len - l3_hdr_len) would underflow (both
> +         * types are unsigned), producing a huge payload_len and corrupting
> +         * the packet. Fall back to the raw iov_size value in that case.
> +         */
> +        if (ip_total_len > l3_hdr_len) {
> +            pkt->payload_len = MIN(raw_payload_len, ip_total_len - l3_hdr_len);
> +        } else {
> +            pkt->payload_len = raw_payload_len;
> +        }
> +    } else if (l3_proto == ETH_P_IPV6) {
> +        uint16_t ip6_payload_len = be16_to_cpu(pkt->l3_hdr.ip6.ip6_plen);
> +        size_t l3_hdr_len = pkt->vec[NET_TX_PKT_L3HDR_FRAG].iov_len;
> +        size_t ext_hdr_len = l3_hdr_len - sizeof(struct ip6_header);
> +        /*
> +         * Guard against malformed packets where ip6_plen is zero or does
> +         * not cover the extension headers that were already parsed. Without
> +         * this check, the subtraction (ip6_payload_len - ext_hdr_len) would
> +         * underflow (unsigned), producing a huge payload_len. Fall back to
> +         * the raw iov_size value in that case.
> +         */
> +        if (ip6_payload_len > ext_hdr_len) {
> +            pkt->payload_len = MIN(raw_payload_len,
> +                                   ip6_payload_len - ext_hdr_len);
> +        } else {
> +            pkt->payload_len = raw_payload_len;
> +        }
> +    } else {
> +        pkt->payload_len = raw_payload_len;
> +    }
> +
>       pkt->payload_frags = iov_copy(&pkt->vec[NET_TX_PKT_PL_START_FRAG],
>                                   pkt->max_payload_frags,
>                                   pkt->raw, pkt->raw_frags,
> 
> ---
> base-commit: b83371668192a705b878e909c5ae9c1233cbd5fb
> change-id: 20260624-net-tx-pkt-ip-length-padding-5a8f358933fc
> 
> Best regards,
> --
> Sanjeeva Yerrapureddy <y.sanjeevreddy@gmail.com>
> 


