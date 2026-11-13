Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F3E606A32D
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 20:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rsg.ci.i.u-tokyo.ac.jp header.i=@rsg.ci.i.u-tokyo.ac.jp header.a=rsa-sha256 header.s=rs20250326 header.b=AAaEsaO1
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRxkB-0004Dh-Bi; Fri, 13 Nov 2026 15:19:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1xRxk8-00049J-G9
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 15:19:28 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1xRxk5-0002jJ-Iv
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 15:19:28 -0500
Received: from [172.31.11.120] (m85.aaa.bbb.ccc.bctel.net [209.52.143.85] (may
 be forged)) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 6ADKJC3L096324
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Sat, 14 Nov 2026 05:19:13 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=LYv2Pwqiw8GdikUkkjbB4phR30zcFSe7f3VNlzacawY=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1794601154; v=1;
 b=AAaEsaO1Ea573iKdQrvzBMJmJHX9RoFDjWTbCN3mhyA616Z2q6imJklHL06knPkZ
 Csnb4RLjY2tfXuH3nhmMUQLiK19DLmVQtCcoG6P90cSUHiwSUP8+Xsut+x/XpfCT
 AhFI/L8gRVk/DtFm6glwGttowLIoBMMsVqIVh6JaWY3LfWUC/kbltQvraEgrxB0H
 HD7OpEytHAVh4myIUoY6eg/2KDqdy/CPvQKcHnhY6SbgDQpbs8rBNFpPHZN3ON8h
 tZxn7c/3yFSd/Cz+aI7G9UuxdY8UjdWy5ba5+D5oEauroiTJZvEq43reHkYI6Y56
 2LcjY7sGyYXjjq/54QTuQQ==
Message-ID: <1c57a740-c743-4d1f-8709-a59455ec7cd4@rsg.ci.i.u-tokyo.ac.jp>
Date: Fri, 13 Nov 2026 13:19:11 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] net/checksum.c: Correct handling of IP header length
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Jason Wang <jasowangio@gmail.com>
References: <20261112180239.489819-1-peter.maydell@linaro.org>
 <20261112180239.489819-2-peter.maydell@linaro.org>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20261112180239.489819-2-peter.maydell@linaro.org>
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-22.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026/11/12 13:02, Peter Maydell wrote:
> In net_checksum_calculate() we are careless about handling of the IP
> header length, in a way which can allow it to become negative for a
> suitably crafted packet.  This bypasses the attempt to check that
> it's big enough, because in comparisons like
>    if (ip_len < sizeof(tcp_header))
> ip_len is converted to size_t and we do this as an unsigned
> comparison, so negative values of ip_len pass the check.
> 
> This results in net_checksum_tcpudp() attempting to checksum nearly
> 64K of memory (because it takes the length as a uint16_t), which will
> typically be a read off the end of a buffer resulting in a segfault.
> If the attacker is able to set up a situation where the read doesn't
> fault, it's possible for some callers that the 2-byte store of the
> updated checksum is an out-of-bounds write.
> 
> This code is used by at least xen-nic, virtio-net, and the COLOj
> filter-rewriter, all of which are in QEMU's security "virtualization
> use case", though the write is probably only exploitable for the
> filter-rewriter; otherwise it's just a theoretical "information leak
> to guest" of a 2-byte checksum of 64K of host RAM.
> 
> Improve the checking of lengths in this function:
>   * assert that the caller provided us a positive buffer length

The new assertion is reachable through eTSEC. It assumes callers always 
supply a nonnegative length. However, eTSEC accumulates descriptor 
lengths without a frame-size cap, then passes the unsigned length to 
this signed parameter in process_tx_fcb(). An aggregate exceeding 2 GiB 
can therefore abort QEMU.

A natural way to fix it would be to change the type to an unsigned one 
that can contain that large length, which would also eliminate the need 
for the assertion.

Regards,
Akihiko Odaki

>   * check length before subtracting various header sizes,
>     rather than afterwards
>   * check that the packet's IHL field reports a valid header
>     length that's not larger than the packet itself
>   * check that the packet's total length field doesn't claim
>     to be smaller than the header
> 
> Cc: qemu-stable@nongnu.org
> Fixes: 50dbce6538d1 ("net: improve UDP/TCP checksum computation.")
> Fixes: CVE-2026-127233
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4720
> Reported-by: Xiang Chen <https://gitlab.com/x14ngch3n>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   net/checksum.c | 32 ++++++++++++++++++++++++--------
>   1 file changed, 24 insertions(+), 8 deletions(-)
> 
> diff --git a/net/checksum.c b/net/checksum.c
> index 537457d89d0..997a0dd2350 100644
> --- a/net/checksum.c
> +++ b/net/checksum.c
> @@ -59,7 +59,7 @@ uint16_t net_checksum_tcpudp(uint16_t length, uint16_t proto,
>   
>   void net_checksum_calculate(void *data, int length, int csum_flag)
>   {
> -    int mac_hdr_len, ip_len;
> +    int mac_hdr_len, ip_len, ip_hdr_len;
>       struct ip_header *ip;
>       uint16_t csum;
>   
> @@ -69,6 +69,8 @@ void net_checksum_calculate(void *data, int length, int csum_flag)
>        * struct members (just in case).
>        */
>   
> +    assert(length >= 0);
> +
>       /* Ensure we have at least an Eth header */
>       if (length < sizeof(struct eth_header)) {
>           return;
> @@ -94,23 +96,33 @@ void net_checksum_calculate(void *data, int length, int csum_flag)
>           break;
>       }
>   
> -    length -= mac_hdr_len;
> -
>       /* Now check we have an IP header (with an optional VLAN header) */
> -    if (length < sizeof(struct ip_header)) {
> +    if (length < mac_hdr_len + sizeof(struct ip_header)) {
>           return;
>       }
>   
> +    length -= mac_hdr_len;
> +
>       ip = (struct ip_header *)((uint8_t *)data + mac_hdr_len);
>   
>       if (IP_HEADER_VERSION(ip) != IP_HEADER_VERSION_4) {
>           return; /* not IPv4 */
>       }
>   
> +    ip_hdr_len = IP_HDR_GET_LEN(ip);
> +
> +    if (ip_hdr_len < sizeof(struct ip_header) || ip_hdr_len > length) {
> +        /*
> +         * Ignore packet with an invalidly short IHL, or which claims the
> +         * IP header is larger than the buffer
> +         */
> +        return;
> +    }
> +
>       /* Calculate IP checksum */
>       if (csum_flag & CSUM_IP) {
>           stw_he_p(&ip->ip_sum, 0);
> -        csum = net_raw_checksum((uint8_t *)ip, IP_HDR_GET_LEN(ip));
> +        csum = net_raw_checksum((uint8_t *)ip, ip_hdr_len);
>           stw_be_p(&ip->ip_sum, csum);
>       }
>   
> @@ -120,12 +132,16 @@ void net_checksum_calculate(void *data, int length, int csum_flag)
>   
>       ip_len = lduw_be_p(&ip->ip_len);
>   
> -    /* Last, check that we have enough data for the all IP frame */
> -    if (length < ip_len) {
> +    /*
> +     * Last, check that the packet's total length field doesn't
> +     * imply a negative amount of data given the header length,
> +     * and that it's not larger than the data buffer we have.
> +     */
> +    if (ip_len < ip_hdr_len || length < ip_len) {
>           return;
>       }
>   
> -    ip_len -= IP_HDR_GET_LEN(ip);
> +    ip_len -= ip_hdr_len;
>   
>       switch (ip->ip_p) {
>       case IP_PROTO_TCP:


