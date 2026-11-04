Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34443606A32E
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 03:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=rsg.ci.i.u-tokyo.ac.jp header.i=@rsg.ci.i.u-tokyo.ac.jp header.a=rsa-sha256 header.s=rs20250326 header.b=n484jjj8
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xORtg-0002XS-IO; Tue, 03 Nov 2026 22:42:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1xORtc-0002Wr-UI; Tue, 03 Nov 2026 22:42:45 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1xORta-0003cw-1A; Tue, 03 Nov 2026 22:42:44 -0500
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 6A43gTOw043096
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 4 Nov 2026 12:42:30 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=PKKwkyXMVUa34/cGv8Wf8Zd8bHvJomy2XFnamZRhw5I=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1793763750; v=1;
 b=n484jjj8qWUeqW8HgC7Vboy7z8mC3Fn2CMtIDWXojgiI1xoJEW0t21hjopaQwsYr
 Aqizh6ZoBJKs/Uqg1mRkxal7MIYFnSbDGqKE8x1d0VdTE4dfd+sjIqKnXMxirMII
 4ASvSKWAT69ffmi5EYe+YjWDdD2LA7gsFejd+0f4rrO9bJZBfuD+pfFQMFbskam6
 ofrUrhgVt2U/sZsYF0sxJsB/jY4Ol5ywOCeNmsy0HdLyzBNTm6bLi+L1IDNjwDIL
 5FmyoQD+fQC1ppT0LVcij681BIkxSjoSbs7BigDlWqJcuJJ2t8PsPdFRRGeQsoFT
 76mNy0WCJi7iToueigf01g==
Message-ID: <472f5ab9-336f-4175-b4d6-53e19793d26b@rsg.ci.i.u-tokyo.ac.jp>
Date: Wed, 4 Nov 2026 12:42:29 +0900
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/eth: Add missing L4/L5 header bound checks
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Jason Wang <jasowangio@gmail.com>, qemu-stable@nongnu.org,
 Lazymio <mio@lazym.io>
References: <20260920-eth-v1-1-ddd05ce24843@rsg.ci.i.u-tokyo.ac.jp>
 <CAFEAcA-C1c=sH+E8_4GfN5u-+66OANDrLXyBotQkzveOM7pbkg@mail.gmail.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <CAFEAcA-C1c=sH+E8_4GfN5u-+66OANDrLXyBotQkzveOM7pbkg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_SBL=1.623 autolearn=no autolearn_force=no
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

On 2026/11/04 0:59, Peter Maydell wrote:
> On Sun, 20 Sept 2026 at 11:52, Akihiko Odaki
> <odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
>>
>> We already have some L4/L5 header bound checks but they were not
>> comprehensive. Add the missing coverage.
>>
>> The IPv6 header parser incorrectly derives L4 offsets greater than
>> actual values. Adding a bound check without fixing it would reject
>> valid packets while fixing it without adding a bound check can result
>> in an out-of-bounds access, so fix it along with the bound check
>> addition.
>>
>> One fixed problem of the IPv6 header parser is that extension header
>> size is not properly computed for the Fragment Header and the IP
>> Authentication Header.
>>
>> RFC 8200 "Internet Protocol, Version 6 (IPv6) Specification" section
>> 4.5. "Fragment Header" says the Fragment Header has a fixed size.
>> The byte represented by ext_hdr.ip6r_len is reserved and "ignored on
>> reception".
>>
>> RFC 4302 "IP Authentication Header" section 2.2. "Payload Length" says
>> it specifies the length of AH in 32-bit words (4-byte units), minus "2".
>>
>> Another fixed problem is that the parser continues parsing extensions in
>> noninitial fragments.
>>
>> RFC 8200 "Internet Protocol, Version 6 (IPv6) Specification" section
>> 4.5 "Fragment Header" says the noninitial fragment packets have the
>> Fragment Header containing "the Next Header value that identifies the
>> first header after the Per-Fragment headers of the original packet"
>> followed by "the fragment itself."
>>
>> Therefore, the data following the Fragment Header in the noninitial
>> fragment packet must be treated as a fragment instead of another
>> extension header, regardless of the Next Header value the Fragment
>> Header contains.
>>
>> Fixes: eb700029c783 ("net_pkt: Extend packet abstraction as required by e1000e functionality")
>> Fixes: 75020a702151 ("Common definitions for VMWARE devices")
>> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4155
>> Cc: qemu-stable@nongnu.org
>> Reported-by: Lazymio <mio@lazym.io>
>> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
>> ---
>>   net/eth.c | 47 ++++++++++++++++++++++++++++++++++++++++-------
>>   1 file changed, 40 insertions(+), 7 deletions(-)
>>
>> diff --git a/net/eth.c b/net/eth.c
>> index 12ec316e240e..96d3f871f4bc 100644
>> --- a/net/eth.c
>> +++ b/net/eth.c
>> @@ -16,6 +16,7 @@
>>    */
>>
>>   #include "qemu/osdep.h"
>> +#include "qemu/bitops.h"
>>   #include "qemu/log.h"
>>   #include "net/eth.h"
>>   #include "net/checksum.h"
>> @@ -156,7 +157,8 @@ void eth_get_protocols(const struct iovec *iov, size_t iovcnt, size_t iovoff,
>>
>>           copied = iov_to_buf(iov, iovcnt, *l3hdr_off, iphdr, sizeof(*iphdr));
>>           if (copied < sizeof(*iphdr) ||
>> -            IP_HEADER_VERSION(iphdr) != IP_HEADER_VERSION_4) {
>> +            IP_HEADER_VERSION(iphdr) != IP_HEADER_VERSION_4 ||
>> +            *l3hdr_off + IP_HDR_GET_LEN(iphdr) > input_size) {
>>               return;
>>           }
> 
> The patch I sent
> https://patchew.org/QEMU/20261102201828.1879576-1-peter.maydell@linaro.org/20261102201828.1879576-5-peter.maydell@linaro.org/
> 
> does this as
> 
> +            IP_HDR_GET_LEN(iphdr) < sizeof(*iphdr) ||
> +            input_size - *l3hdr_off < IP_HDR_GET_LEN(iphdr) ||
> 
> which (a) has an extra check and (b) does a subtraction which is
> guaranteed not to underflow (because we already checked that
> input_size >= *l3hdr_off) rather than an addition which isn't
> immediately obviously "can't possibly overflow". So I think I prefer that.
> 
>>
>> @@ -188,7 +190,8 @@ void eth_get_protocols(const struct iovec *iov, size_t iovcnt, size_t iovoff,
>>           if (_eth_copy_chunk(input_size,
>>                               iov, iovcnt,
>>                               *l4hdr_off, sizeof(l4hdr_info->hdr.tcp),
>> -                            &l4hdr_info->hdr.tcp)) {
>> +                            &l4hdr_info->hdr.tcp) &&
>> +            *l4hdr_off + TCP_HEADER_DATA_OFFSET(&l4hdr_info->hdr.tcp) <= input_size) {
> 
> Similarly
>   "input_size - *l4hdr_off >= TCP_HEADER_DATA_OFFSET(...)"
> 
> 
>>               l4hdr_info->proto = ETH_L4_HDR_PROTO_TCP;
>>               *l5hdr_off = *l4hdr_off +
>>                   TCP_HEADER_DATA_OFFSET(&l4hdr_info->hdr.tcp);
>> @@ -456,7 +459,9 @@ bool eth_parse_ipv6_hdr(const struct iovec *pkt, int pkt_frags,
>>       struct ip6_ext_hdr ext_hdr;
>>       size_t bytes_read;
>>       uint8_t curr_ext_hdr_type;
>> +    uint16_t buf;
>>       size_t input_size = iov_size(pkt, pkt_frags);
>> +    bool subsequent = false;
>>
>>       info->rss_ex_dst_valid = false;
>>       info->rss_ex_src_valid = false;
>> @@ -496,25 +501,53 @@ bool eth_parse_ipv6_hdr(const struct iovec *pkt, int pkt_frags,
>>               return false;
>>           }
>>
>> -        if (curr_ext_hdr_type == IP6_ROUTING) {
>> +        switch (curr_ext_hdr_type) {
>> +        case IP6_ROUTING:
>>               if (ext_hdr.ip6r_len == sizeof(struct in6_address) / 8) {
>>                   info->rss_ex_dst_valid =
>>                       _eth_get_rss_ex_dst_addr(pkt, pkt_frags,
>>                                                ip6hdr_off + info->full_hdr_len,
>>                                                &ext_hdr, &info->rss_ex_dst);
>>               }
>> -        } else if (curr_ext_hdr_type == IP6_DESTINATON) {
>> +            info->full_hdr_len += (ext_hdr.ip6r_len + 1) * IP6_EXT_GRANULARITY;
>> +            break;
>> +
>> +        case IP6_DESTINATON:
>>               info->rss_ex_src_valid =
>>                   _eth_get_rss_ex_src_addr(pkt, pkt_frags,
>>                                            ip6hdr_off + info->full_hdr_len,
>>                                            &ext_hdr, &info->rss_ex_src);
>> -        } else if (curr_ext_hdr_type == IP6_FRAGMENT) {
>> +            info->full_hdr_len += (ext_hdr.ip6r_len + 1) * IP6_EXT_GRANULARITY;
>> +            break;
>> +
>> +        case IP6_FRAGMENT:
>> +            bytes_read = iov_to_buf(pkt, pkt_frags,
>> +                                    ip6hdr_off + info->full_hdr_len + 2,
>> +                                    &buf, sizeof(buf));
>> +            if (bytes_read < sizeof(buf)) {
>> +                return false;
>> +            }
>> +
>> +            info->full_hdr_len += 8;
>>               info->fragment = true;
>> +            subsequent = extract16(be16_to_cpu(buf), 3, 13);
> 
> I don't understand what this is doing. I guess this is the
> "don't parse extensions in fragments" change mentioned in the
> commit message, but I don't see why this is the way to determine
> that. This is testing the "fragment offset" field for being non-zero,
> isn't it?

Yes. A nonzero offset identifies a noninitial fragment. Its bytes are 
fragment data, so we must stop parsing extension headers there. For 
offset zero, we can continue parsing the headers present in the
first fragment.

> 
>> +            break;
>> +
>> +        case IP6_AUTHENTICATION:
> 
> Worth a brief comment, e.g.:
>      /* Per RFC4302, ip6r_len for this header is different from the ipv6 norm */

It may be worthwhile to add comments throughout the extension parsing 
code, including the subsequent fragment detection above.

> 
>> +            info->full_hdr_len += (ext_hdr.ip6r_len + 2) * 4;
>> +            break;
>> +
>> +        default:
>> +            info->full_hdr_len += (ext_hdr.ip6r_len + 1) * IP6_EXT_GRANULARITY;
>>           }
>>
>> -        info->full_hdr_len += (ext_hdr.ip6r_len + 1) * IP6_EXT_GRANULARITY;
>>           curr_ext_hdr_type = ext_hdr.ip6r_nxt;
>> -    } while (eth_is_ip6_extension_header_type(curr_ext_hdr_type));
>> +    } while (!subsequent &&
>> +             eth_is_ip6_extension_header_type(curr_ext_hdr_type));
>> +
>> +    if (input_size < ip6hdr_off + info->full_hdr_len) {
>> +        return false;
>> +    }
> 
> I think I prefer the "do this once at the end of the loop" that my
> patch does, rather than checking at the start of the loop and then
> afterwards.

I can do that; I don't have a strong preference either way.

> 
>>
>>       info->l4proto = ext_hdr.ip6r_nxt;
>>       return true;
> 
> Otherwise the eth_parse_ipv6_hdr() changes look good to me, but I
> think they're complex enough to be worth having in their own
> patch separate from the eth_get_protocols() changes.

That makes sense. The changes inside eth_parse_ipv6_hdr() need to be in 
one patch, but it can be still separate from the eth_get_protocols() 
changes.

We can use your patch for the IPv4 change, as it also adds overflow 
safety and the additional sizeof(*iphdr) check.

A separate patch should be written for the TCP bounds check and precede 
the IPv6 parser fixes. Correcting the AH length can make a TCP header 
reachable in cases where the old parser's incorrect offset caused the 
header copy to fail. Without the TCP bounds check, an oversized TCP data 
offset could then reach igb's header-splitting path as an out-of-range 
L5 offset. Keeping that ordering avoids an unsafe intermediate state.

I plan to send a patch series featuring a patch for the TCP bounds check 
and another for the IPv6 parser fixes, while dropping the IPv4 change.

Regards,
Akihiko Odaki

