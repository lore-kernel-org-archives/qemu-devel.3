Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5945ACDE008
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 05:46:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wczNV-0001Tx-Sn; Fri, 26 Jun 2026 01:45:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wczNP-0001Sj-KP
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 01:45:23 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wczNL-0001tH-8q
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 01:45:18 -0400
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 65Q5j4jA088176
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Fri, 26 Jun 2026 14:45:04 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=Le714S7ljpXMYdTHWtvO7xuolFIeGJQkrvDczH7GI0M=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1782452704; v=1;
 b=DAalFj8JZ9ilfa2QLoqqR4+KOFu07Hv07UDVIrFFxS66sBXfSgPwnybJie1HmMl3
 VXwxNkWSlzbwrldjT49qaMUuZEV8PEpa0YLxF96bgxsrkdiiNKSp8fUITYKDpe7c
 IBswZJDVBKpY836+QLlcshLFrlPfNMImgyqkVYZyCcWFwtm4gWyT5lXEbWZBotpO
 FvsbVB9aUMjJqx95OpPkUxZAJpvHun2a64rkDlmPrBrDQYXBQgJHG9h9hFV8Oolr
 RxF7XRUS8YS0ofjyP1hb9VWkQ+cIG+R9SJh/yozoCdyvQe+x9n5bjWXL7u+YSpmY
 aNzzvw6+5NNIbbT1ks/v3Q==
Message-ID: <b0337cc7-2c48-4e39-a2f0-49d42bbe5ddc@rsg.ci.i.u-tokyo.ac.jp>
Date: Fri, 26 Jun 2026 14:45:03 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hw/net/net_tx_pkt: clamp payload_len to IP header
 length for padded frames
To: Sanjeeva Yerrapureddy <y.sanjeevreddy@gmail.com>, qemu-devel@nongnu.org
Cc: Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Jason Wang <jasowang@redhat.com>
References: <20260625-net-tx-pkt-ip-length-padding-v2-1-d56f741bcdcd@gmail.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260625-net-tx-pkt-ip-length-padding-v2-1-d56f741bcdcd@gmail.com>
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

On 2026/06/26 10:10, Sanjeeva Yerrapureddy wrote:
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
> 
> Signed-off-by: Sanjeeva Yerrapureddy <y.sanjeevreddy@gmail.com>
> ---
> Changes in v2:
> - Fix iov_copy() to use raw_payload_len (full wire size including Ethernet
>    padding) instead of the IP-clamped payload_len; v1 silently dropped
>    padding bytes from the TAP frame, causing short frames to be transmitted
>    with incorrect wire size (addresses part 1 of Akihiko Odaki's review).
> - Fix net_tx_pkt_get_total_len() to return iov_size(pkt->raw, pkt->raw_frags)
>    instead of hdr_len + payload_len, which under-counted for short padded
>    frames (addresses part 1 of Akihiko Odaki's review).
> - Expand comments to make the two sizes explicit: payload_len is the
>    IP-declared payload length used only for header/checksum operations;
>    raw_payload_len is the full wire size used for iov_copy and total_len.
> - Document the LSO/TSO super-packet (ip_len=0) and IPv6 jumbogram cases
>    as known real-world triggers for the fallback path.
> - Link to v1: https://lore.kernel.org/qemu-devel/20260624-net-tx-pkt-ip-length-padding-v1-1-7a22fe9b4e40@gmail.com
> 
> On the fallback to raw_payload_len when ip_len is too small (Akihiko Odaki):
> 
> The fallback is necessary for LSO/TSO super-packets where the ESXi e1000e
> driver sets ip_len=0 as a placeholder in the unfragmented super-packet
> header before the NIC performs segmentation.  The following log traces
> (captured with a temporary debug printk and then removed) confirm this
> path is triggered in practice:
> 
>    IPv4 ip_len=0 <= IP hdr len 20 (raw_payload_len=14793), using raw size
>    IPv4 ip_len=0 <= IP hdr len 20 (raw_payload_len=16445), using raw size
>    IPv4 ip_len=0 <= IP hdr len 20 (raw_payload_len= 5864), using raw size
>    IPv4 ip_len=0 <= IP hdr len 20 (raw_payload_len= 1528), using raw size
>    IPv4 ip_len=0 <= IP hdr len 20 (raw_payload_len= 3870), using raw size
>    IPv4 ip_len=0 <= IP hdr len 20 (raw_payload_len= 2621), using raw size
>    IPv4 ip_len=0 <= IP hdr len 20 (raw_payload_len= 1659), using raw size
>    IPv4 ip_len=0 <= IP hdr len 20 (raw_payload_len= 1528), using raw size
>    IPv4 ip_len=0 <= IP hdr len 20 (raw_payload_len= 4610), using raw size
>    IPv4 ip_len=0 <= IP hdr len 20 (raw_payload_len= 1830), using raw size
> 
> For these packets the TCP segmentation engine drives the loop and does
> not rely on payload_len to determine the payload extent, so using
> raw_payload_len is correct and safe.

I think this should be based on the device specification rather than on
a heuristic that happens to match one driver.

For 82574/e1000e, the datasheet explicitly describes this case.
Section 7.3.4, "TCP Segmentation Source Data", says that the IPv4
header "Length should be set to zero"; it says the same for the IPv6
header length.  The per-frame length is then generated by the device as
part of TSO, as described in section 7.3.6.2, "IP/TCP/UDP Header
Updating".

For IPv4, the first and subsequent frames use:

     IP Total Length = MSS + HDRLEN - IPCSS

and the last frame uses:

     IP Total Length = (last frame payload bytes + HDRLEN) - IPCSS

where the last-frame payload is derived from PAYLEN - (N * MSS).

Those variables come from the e1000e transmit context descriptor, not
from the IP header.  Section 7.2.10.2 describes the context transmit
descriptor, section 7.2.10.2.1 defines IPCSS/TUCSS, section 7.2.10.3
defines MSS, section 7.2.10.3.1 defines HDRLEN, and section 7.2.10.4
defines PAYLEN.

So I do not think common net_tx_pkt code should define a generic policy
for packets whose IP length field is invalid.  Outside a device-specific
offload context, the correct payload length is not well-defined.  For
e1000e TSO, however, the hardware contract gives us the needed
device-specific state, so the e1000e path should derive the length from
the TSO context instead of relying on raw_payload_len as a common-code
fallback.

Regards,
Akihiko Odaki

> 
> On the relationship to the short-packet receive-path discussion (Peter Maydell):
> https://lore.kernel.org/qemu-devel/CAFEAcA_UhmCxJc16CHE=4ZR1+PA0=4-29=fEe+d+iUmhLTzpuQ@mail.gmail.com/
> 
> The linked thread concerns the receive path — whether tap_send is the
> right place to pad short incoming frames for guest NIC models.  This
> patch addresses the transmit path: the guest NIC adds Ethernet padding
> correctly, but net_tx_pkt_rebuild_payload was then using the padded
> wire size to compute payload_len, causing net_tx_pkt_update_ip_hdr_
> checksum to rewrite ip_len to include the padding bytes.
> 
> This fix does not change when or where padding is applied.  It only
> ensures that payload_len reflects the IP-declared payload length, while
> the full padded frame continues to be forwarded to the TAP via
> iov_copy using raw_payload_len.
> ---
>   hw/net/net_tx_pkt.c | 91 +++++++++++++++++++++++++++++++++++++++++++++++++++--
>   1 file changed, 88 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/net/net_tx_pkt.c b/hw/net/net_tx_pkt.c
> index 903238dca2..2dcbf23354 100644
> --- a/hw/net/net_tx_pkt.c
> +++ b/hw/net/net_tx_pkt.c
> @@ -274,11 +274,89 @@ static bool net_tx_pkt_parse_headers(struct NetTxPkt *pkt)
>   
>   static void net_tx_pkt_rebuild_payload(struct NetTxPkt *pkt)
>   {
> -    pkt->payload_len = iov_size(pkt->raw, pkt->raw_frags) - pkt->hdr_len;
> +    size_t raw_payload_len = iov_size(pkt->raw, pkt->raw_frags) - pkt->hdr_len;
> +    struct iovec *l2hdr = &pkt->vec[NET_TX_PKT_L2HDR_FRAG];
> +    uint16_t l3_proto = eth_get_l3_proto(l2hdr, 1, l2hdr->iov_len);
> +
> +    /*
> +     * payload_len tracks the IP-declared payload size. It is used by
> +     * net_tx_pkt_update_ip_hdr_checksum() to rewrite ip_len and by the L4
> +     * pseudo-header checksum helpers. It must NOT include Ethernet
> +     * minimum-frame padding: if the guest sends a short frame (e.g. a pure
> +     * TCP ACK of 54 bytes) padded to 60 bytes, iov_size() returns 60 but the
> +     * IP header still reports the payload as 20 bytes. Using the inflated size
> +     * would cause ip_len to be rewritten to include the padding, making the
> +     * packet malformed on the receiver.
> +     *
> +     * Note: the actual iov_copy below still copies raw_payload_len bytes
> +     * (the full wire payload including padding) into the payload fragments so
> +     * the TAP receives a correctly-sized Ethernet frame. The receiver's IP
> +     * stack uses ip_len to find the real payload boundary and ignores the
> +     * trailing padding bytes, which is exactly how a real NIC behaves.
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
> +         * Guard against ip_total_len that does not cover the IP header.
> +         * Subtracting would underflow (both types unsigned), producing a
> +         * huge payload_len.  Fall back to raw_payload_len in that case.
> +         *
> +         * Known trigger: some LSO/TSO implementations (e.g. ESXi e1000e
> +         * driver) set ip_len=0 in the super-packet header as a placeholder
> +         * when offloading segmentation to the NIC.  In that case
> +         * raw_payload_len correctly reflects the full super-packet payload
> +         * from the TX descriptors, and the TCP segmentation path does not
> +         * rely on payload_len to drive the loop, so this is safe.
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
> +            /*
> +             * ip6_plen=0 is valid for IPv6 jumbograms (payload length
> +             * carried in a Hop-by-Hop option), but QEMU does not support
> +             * jumbograms so raw_payload_len is the best we can do.
> +             * Also guards against malformed packets where ip6_plen is
> +             * smaller than the extension headers already parsed.
> +             */
> +            pkt->payload_len = raw_payload_len;
> +        }
> +    } else {
> +        pkt->payload_len = raw_payload_len;
> +    }
> +
> +    /*
> +     * Copy the full raw_payload_len bytes (including any Ethernet padding)
> +     * so the wire frame sent to the TAP has the correct size.  payload_len
> +     * (the IP-declared value set above) is used only for header/checksum
> +     * operations; raw_payload_len preserves the original frame size.
> +     */
>       pkt->payload_frags = iov_copy(&pkt->vec[NET_TX_PKT_PL_START_FRAG],
>                                   pkt->max_payload_frags,
>                                   pkt->raw, pkt->raw_frags,
> -                                pkt->hdr_len, pkt->payload_len);
> +                                pkt->hdr_len, raw_payload_len);
>   }
>   
>   bool net_tx_pkt_parse(struct NetTxPkt *pkt)
> @@ -428,7 +506,14 @@ size_t net_tx_pkt_get_total_len(struct NetTxPkt *pkt)
>   {
>       assert(pkt);
>   
> -    return pkt->hdr_len + pkt->payload_len;
> +    /*
> +     * Use the raw iov size rather than hdr_len + payload_len.  payload_len
> +     * reflects the IP-declared payload length (excluding any Ethernet minimum-
> +     * frame padding), so hdr_len + payload_len would under-count for short
> +     * frames.  pkt->raw always holds the exact bytes that arrived from the
> +     * guest TX descriptors, padding included, giving the true wire size.
> +     */
> +    return iov_size(pkt->raw, pkt->raw_frags);
>   }
>   
>   void net_tx_pkt_dump(struct NetTxPkt *pkt)
> 
> ---
> base-commit: b83371668192a705b878e909c5ae9c1233cbd5fb
> change-id: 20260624-net-tx-pkt-ip-length-padding-5a8f358933fc
> 
> Best regards,
> --
> Sanjeeva Yerrapureddy <y.sanjeevreddy@gmail.com>
> 


