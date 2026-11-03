Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26464606A324
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2026 14:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=rsg.ci.i.u-tokyo.ac.jp header.i=@rsg.ci.i.u-tokyo.ac.jp header.a=rsa-sha256 header.s=rs20250326 header.b=ovKWHdUB
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOFj0-0005LX-OE; Tue, 03 Nov 2026 09:42:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1xOFiy-0005LH-3s
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 09:42:56 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1xOFiv-00067x-IX
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 09:42:55 -0500
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 6A3Egg5j035409
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Tue, 3 Nov 2026 23:42:42 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=sDL2+SgtoYCn2DkLB3ogUcPMwVRGkvsNds7qXkQa8rk=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1793716962; v=1;
 b=ovKWHdUBnv8vSh6WufdcGiJnQHDt4Hp/+VyWZF99vgO+eNYDtW5YGtKEd31qfMWB
 7PUb1KH4BeOx/GhQWqYz+Rj+IpyVA3ELNVCkdZo2P2pcKUWH78VB0567vs+ip31H
 QbIF4kx3LfG356VrZciIwV7tAc7v/tXB8CgxdOXAs9XsT7VujUozlfU2T8UPiVyb
 XqCO0Pe6JTpTpwRyuPQFuPdw9GAoK76fvSp1AmkMLikZiJ/Blplkb9jg77oOKdkT
 13UWxabZX+mS4jSlkbXGWSvxs8EecOr2ROL99VInQjx4GQYPE7mbVdw/dMYDsJX8
 pyolrHO1GRO9sVSWla+ERg==
Message-ID: <d9e1d6ff-abc8-4516-a64b-5669ac0239ad@rsg.ci.i.u-tokyo.ac.jp>
Date: Tue, 3 Nov 2026 23:42:42 +0900
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/11] net/eth.c: In eth_parse_ipv6_hdr(), fix check of
 input size
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Jason Wang <jasowangio@gmail.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>
References: <20261102201828.1879576-1-peter.maydell@linaro.org>
 <20261102201828.1879576-3-peter.maydell@linaro.org>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20261102201828.1879576-3-peter.maydell@linaro.org>
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026/11/03 5:18, Peter Maydell wrote:
> In the eth_parse_ipv6_hdr() function, when parsing the
> extension headers we check
>          if (input_size < ip6hdr_off + info->full_hdr_len) {
>              return false;
>          }
> This is checking that an extension header did not specify an
> extension header length that claims to extend off the end of the
> actual packet. However, we do it at the wrong end of the loop:
> 
>   * In the first iteration, full_hdr_len is sizeof(struct ipv6_header)
>     (i.e. just the initial fixed IPv6 header); but this check is
>     redundant because the initial part of the function did an
>     iov_to_buf() of sizeof(ip6_hdr) bytes from offset ip6hdr_off,
>     and checked that it read that many bytes. If input_size was
>     small enough to fail the check here then the iov_to_buf()
>     would have reported a short read
>   * In the last iteration, we update full_hdr_len at the end of
>     the loop, and then exit the loop without checking that that
>     final extension header had a valid length
> 
> Moving the length check to the end of the loop fixes this.
> 
> This bug has no visible effects provided that all the callers
> validate accessses into the packet before doing them, but spotting
> the invalid headers at this level provides a defence in depth against
> bugs elsewhere; so it's cc'd to stable on that basis.
> 
> Bugs #4138 and #4516 both note this mistake (in amongst a pile of
> other things).
> 
> Cc: qemu-stable@nongnu.org
> Fixes: eb700029c78367 ("net_pkt: Extend packet abstraction as required by e1000e functionality")
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>> --->   net/eth.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/net/eth.c b/net/eth.c
> index 12ec316e240..bc26d38dc21 100644
> --- a/net/eth.c
> +++ b/net/eth.c
> @@ -485,10 +485,6 @@ bool eth_parse_ipv6_hdr(const struct iovec *pkt, int pkt_frags,
>       info->has_ext_hdrs = true;
>   
>       do {
> -        if (input_size < ip6hdr_off + info->full_hdr_len) {
> -            return false;
> -        }
> -
>           bytes_read = iov_to_buf(pkt, pkt_frags, ip6hdr_off + info->full_hdr_len,
>                                   &ext_hdr, sizeof(ext_hdr));
>   
> @@ -514,6 +510,10 @@ bool eth_parse_ipv6_hdr(const struct iovec *pkt, int pkt_frags,
>   
>           info->full_hdr_len += (ext_hdr.ip6r_len + 1) * IP6_EXT_GRANULARITY;
>           curr_ext_hdr_type = ext_hdr.ip6r_nxt;
> +        if (input_size < ip6hdr_off + info->full_hdr_len) {
> +            /* This extension header's length field was bogus */
> +            return false;
> +        }
>       } while (eth_is_ip6_extension_header_type(curr_ext_hdr_type));
>   
>       info->l4proto = ext_hdr.ip6r_nxt;

This is a duplicate of [1], which also contains additional changes to 
avoid rejecting a valid packet with the check moved, so please review it.

[1] 
https://lore.kernel.org/qemu-devel/20260920-eth-v1-1-ddd05ce24843@rsg.ci.i.u-tokyo.ac.jp/

Regards,
Akihiko Odaki

