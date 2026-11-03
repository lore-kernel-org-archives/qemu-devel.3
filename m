Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8496F606D808
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2026 16:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=azXYUW2T
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOGvA-00021G-Oz; Tue, 03 Nov 2026 10:59:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xOGv1-00020c-Ni
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 10:59:29 -0500
Received: from mail-yw1-x112d.google.com ([2607:f8b0:4864:20::112d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xOGuy-0006WW-1f
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 10:59:26 -0500
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-8b2fafe2812so9700947b3.0
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2026 07:59:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793721562; cv=none;
 d=google.com; s=arc-20260327;
 b=iqTnjNtzo5gwbbUGParr5EnRWLY8gbiNtLoMY/BwpwUiOTy0n5G6kSDgvvdnwNrIU6
 seWtG2/jjVLujDCvFiMRQi1coj+/9yy5gycFCcw/mk2iK1yPtcXdFUQDL4LiJVG+vg2n
 x8G4kIU11XItiTKZF9Q79lRhpkkab+CcIu/nF6fJP/lglZmImCDM6xOSTWdn/gy1JKor
 HAPA51Xd5H5tXHc99Af4lExxWbC0zb/eds9umhmv9Pivdz6jhM98/+FVa+yWDsXb2S7h
 mKrUR3FFLNaQumjs1kxBDPcf3vv7ebRVajW1dRb2rlcgbLA/psicmKREmeheU8rQ3Jts
 x+XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=h9uZa6t5YUeH9iDqjsOueDXpTpS70mIv+zoKiS+ojkA=;
 fh=SlDoQItQG4p7LdqrQL3c7WvqMiQdiz//f6Mq3ioTtkQ=;
 b=qIW++LzdUDZdCkwVXQ0RGZEQ/9KpereNzXVEFhK9+4I7ez+ZnJbzIGgQWqI5GUEXgS
 LWaqOsScr5N+jOTqo4i4/NESAzH5aR44FsX6Kz4xbetW8mNDzcif1pFFOTErxd86aIiU
 Anj9E+Xub4OPBo6Uvf2SrUABwtbYxWpg7cw64Im2RRPLJ5ugA8ybqORCo8DhRTOXBIjq
 X4cWTObUivAY9PdJIkj9sGDvt7X4SSMrZfUIMHYkRbF2ya81//sM24KShFDcaCJNucFl
 MujA45vdLbv7JB/hWJHXUeepWk074aa/Zrm5iAaKULx4NDajpf5AzV/43xCCWTbuHnR8
 Shaw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793721562; x=1794326362; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=h9uZa6t5YUeH9iDqjsOueDXpTpS70mIv+zoKiS+ojkA=;
 b=azXYUW2Td8EOoQX2+keT4h50zox1IlUouRataoEjmKqmi2kRY31zOqWiXWyChYhRtV
 RiNVmvkrB/+mpATlGRoRX6zJZoJKo9v9B8sX3KiNbmjPdN+YVnyLBiJ2u7aMeCFUpAlL
 7vw7cvbK3J9E+7F2ceWy8lqc/wtgIAO9M+cAsR6HlMUb0EAGt1KT65HBzYhsgMrtUJPH
 8CR6oL1HIpnezGqh7Iq+YSEwI9zRH07xYym34J7KemT2+NOGaDS6bnMllA2vDKp5jeDa
 Xyu82a2jAIU2V+t/n0WmYdolHOn6ReY2bZX9VPImePia+kRzoBGDaYlelM8nck0ie4W1
 ldBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793721562; x=1794326362;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=h9uZa6t5YUeH9iDqjsOueDXpTpS70mIv+zoKiS+ojkA=;
 b=cPxISq18jzBWzJ2Gqpk8EqtlvWa51iZ0YC23UDptcav+ecSBgLtWhx0f8ZGuWBndyg
 kLXjxKN8lq0YC0MOHtrhPknXrJwAaZE6UvP7i44Bz8kTsA7Wz4A3iOQ8CuEYVwu/iVuQ
 +RmDCeTlmW7t2w00QRQ9TXEdCgzPqW/Q/4SVtpJohYHningrmKmw46UQXs2qdo6vUO2F
 X47ejXYrNbmu1KmDm7WJaoEU+ChZ55fkie997QNs224JWSpfk321YyqGq1eOP/D2evIG
 CKyhy/zPvyZpDTxj51vHERrYD+WyxICp6ApeNPxJi6mwT9YWVEsW0ENr/oXciT/DMIYG
 ANHA==
X-Gm-Message-State: APuU4Z9BCM7OBRWEXXM2ILtg9pS2VXdo+PDcDXNdSuYfTRjtL5qUtCeg
 jeedDTqVdy9T7eSGr8/hD371HrrlW1SGMt6GZkhd9PQg91Ca3+2jLv/zU7Z1hCMYJLGXCiTPPlS
 N8B+sPqdgE/eSax5klnPNoe0O7XRr8w16ZBjRrFI8jw==
X-Gm-Gg: AYBFou25/eg0va/l4ipLZiD1Iq6yCHatHlHX5ZKbxDhjTrhbWSEihMRioff/0Ip3VpB
 rPsp3rbAdUJMZzK4cMd/U/hUjmuvmJxFj8qG7DPyUdIA+1V7lDkH35FYmLKN4AwZ7HDIha5ljH1
 xqpC598SW2m7DMTy5CSdq/dCD9ydqkEQYtxx4avGlv63B5eoSw1/geJHbaWozinJRI0lq4vT6Hz
 nW/wdPa2jzstv/bt0lckcWOpt29giWFrwn9+u7ED1mfar8T/yz/gFWqzKuHScRRdszaMCs3+sb2
 ECNrNTIsxAweTYkp3mAmBR1lDl8upHIuAMMn1aLBkzCe0B39+Zw1tQHl1i0+gWbrtaQa52+sQpx
 5XzjZab7UIHbh3YZXKZXWXV8KLqItmwm1B52+FKlIAL3BSX+yZlKADCQmeBL3ZYIaHv8/zWpktA
 H+fZ4ZYX0OwhdXiOn1gM8gtMe53FkyrJo26LKO5JNFhg==
X-Received: by 2002:a05:690c:c90:b0:81e:d001:e0ca with SMTP id
 00721157ae682-8b2b6723231mr96332827b3.17.1793721561927; Tue, 03 Nov 2026
 07:59:21 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20260920-eth-v1-1-ddd05ce24843@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260920-eth-v1-1-ddd05ce24843@rsg.ci.i.u-tokyo.ac.jp>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 3 Nov 2026 15:59:10 +0000
X-Gm-Features: AclHuK-lmZxcIJjGQIy43le4BfSXTM_UQ2XFb_jptjZbYzHshocFqEkPN5uhZG8
Message-ID: <CAFEAcA-C1c=sH+E8_4GfN5u-+66OANDrLXyBotQkzveOM7pbkg@mail.gmail.com>
Subject: Re: [PATCH] net/eth: Add missing L4/L5 header bound checks
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: qemu-devel@nongnu.org, Dmitry Fleytman <dmitry.fleytman@gmail.com>, 
 Jason Wang <jasowangio@gmail.com>, qemu-stable@nongnu.org,
 Lazymio <mio@lazym.io>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112d.google.com
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun, 20 Sept 2026 at 11:52, Akihiko Odaki
<odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
>
> We already have some L4/L5 header bound checks but they were not
> comprehensive. Add the missing coverage.
>
> The IPv6 header parser incorrectly derives L4 offsets greater than
> actual values. Adding a bound check without fixing it would reject
> valid packets while fixing it without adding a bound check can result
> in an out-of-bounds access, so fix it along with the bound check
> addition.
>
> One fixed problem of the IPv6 header parser is that extension header
> size is not properly computed for the Fragment Header and the IP
> Authentication Header.
>
> RFC 8200 "Internet Protocol, Version 6 (IPv6) Specification" section
> 4.5. "Fragment Header" says the Fragment Header has a fixed size.
> The byte represented by ext_hdr.ip6r_len is reserved and "ignored on
> reception".
>
> RFC 4302 "IP Authentication Header" section 2.2. "Payload Length" says
> it specifies the length of AH in 32-bit words (4-byte units), minus "2".
>
> Another fixed problem is that the parser continues parsing extensions in
> noninitial fragments.
>
> RFC 8200 "Internet Protocol, Version 6 (IPv6) Specification" section
> 4.5 "Fragment Header" says the noninitial fragment packets have the
> Fragment Header containing "the Next Header value that identifies the
> first header after the Per-Fragment headers of the original packet"
> followed by "the fragment itself."
>
> Therefore, the data following the Fragment Header in the noninitial
> fragment packet must be treated as a fragment instead of another
> extension header, regardless of the Next Header value the Fragment
> Header contains.
>
> Fixes: eb700029c783 ("net_pkt: Extend packet abstraction as required by e1000e functionality")
> Fixes: 75020a702151 ("Common definitions for VMWARE devices")
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4155
> Cc: qemu-stable@nongnu.org
> Reported-by: Lazymio <mio@lazym.io>
> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> ---
>  net/eth.c | 47 ++++++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 40 insertions(+), 7 deletions(-)
>
> diff --git a/net/eth.c b/net/eth.c
> index 12ec316e240e..96d3f871f4bc 100644
> --- a/net/eth.c
> +++ b/net/eth.c
> @@ -16,6 +16,7 @@
>   */
>
>  #include "qemu/osdep.h"
> +#include "qemu/bitops.h"
>  #include "qemu/log.h"
>  #include "net/eth.h"
>  #include "net/checksum.h"
> @@ -156,7 +157,8 @@ void eth_get_protocols(const struct iovec *iov, size_t iovcnt, size_t iovoff,
>
>          copied = iov_to_buf(iov, iovcnt, *l3hdr_off, iphdr, sizeof(*iphdr));
>          if (copied < sizeof(*iphdr) ||
> -            IP_HEADER_VERSION(iphdr) != IP_HEADER_VERSION_4) {
> +            IP_HEADER_VERSION(iphdr) != IP_HEADER_VERSION_4 ||
> +            *l3hdr_off + IP_HDR_GET_LEN(iphdr) > input_size) {
>              return;
>          }

The patch I sent
https://patchew.org/QEMU/20261102201828.1879576-1-peter.maydell@linaro.org/20261102201828.1879576-5-peter.maydell@linaro.org/

does this as

+            IP_HDR_GET_LEN(iphdr) < sizeof(*iphdr) ||
+            input_size - *l3hdr_off < IP_HDR_GET_LEN(iphdr) ||

which (a) has an extra check and (b) does a subtraction which is
guaranteed not to underflow (because we already checked that
input_size >= *l3hdr_off) rather than an addition which isn't
immediately obviously "can't possibly overflow". So I think I prefer that.

>
> @@ -188,7 +190,8 @@ void eth_get_protocols(const struct iovec *iov, size_t iovcnt, size_t iovoff,
>          if (_eth_copy_chunk(input_size,
>                              iov, iovcnt,
>                              *l4hdr_off, sizeof(l4hdr_info->hdr.tcp),
> -                            &l4hdr_info->hdr.tcp)) {
> +                            &l4hdr_info->hdr.tcp) &&
> +            *l4hdr_off + TCP_HEADER_DATA_OFFSET(&l4hdr_info->hdr.tcp) <= input_size) {

Similarly
 "input_size - *l4hdr_off >= TCP_HEADER_DATA_OFFSET(...)"


>              l4hdr_info->proto = ETH_L4_HDR_PROTO_TCP;
>              *l5hdr_off = *l4hdr_off +
>                  TCP_HEADER_DATA_OFFSET(&l4hdr_info->hdr.tcp);
> @@ -456,7 +459,9 @@ bool eth_parse_ipv6_hdr(const struct iovec *pkt, int pkt_frags,
>      struct ip6_ext_hdr ext_hdr;
>      size_t bytes_read;
>      uint8_t curr_ext_hdr_type;
> +    uint16_t buf;
>      size_t input_size = iov_size(pkt, pkt_frags);
> +    bool subsequent = false;
>
>      info->rss_ex_dst_valid = false;
>      info->rss_ex_src_valid = false;
> @@ -496,25 +501,53 @@ bool eth_parse_ipv6_hdr(const struct iovec *pkt, int pkt_frags,
>              return false;
>          }
>
> -        if (curr_ext_hdr_type == IP6_ROUTING) {
> +        switch (curr_ext_hdr_type) {
> +        case IP6_ROUTING:
>              if (ext_hdr.ip6r_len == sizeof(struct in6_address) / 8) {
>                  info->rss_ex_dst_valid =
>                      _eth_get_rss_ex_dst_addr(pkt, pkt_frags,
>                                               ip6hdr_off + info->full_hdr_len,
>                                               &ext_hdr, &info->rss_ex_dst);
>              }
> -        } else if (curr_ext_hdr_type == IP6_DESTINATON) {
> +            info->full_hdr_len += (ext_hdr.ip6r_len + 1) * IP6_EXT_GRANULARITY;
> +            break;
> +
> +        case IP6_DESTINATON:
>              info->rss_ex_src_valid =
>                  _eth_get_rss_ex_src_addr(pkt, pkt_frags,
>                                           ip6hdr_off + info->full_hdr_len,
>                                           &ext_hdr, &info->rss_ex_src);
> -        } else if (curr_ext_hdr_type == IP6_FRAGMENT) {
> +            info->full_hdr_len += (ext_hdr.ip6r_len + 1) * IP6_EXT_GRANULARITY;
> +            break;
> +
> +        case IP6_FRAGMENT:
> +            bytes_read = iov_to_buf(pkt, pkt_frags,
> +                                    ip6hdr_off + info->full_hdr_len + 2,
> +                                    &buf, sizeof(buf));
> +            if (bytes_read < sizeof(buf)) {
> +                return false;
> +            }
> +
> +            info->full_hdr_len += 8;
>              info->fragment = true;
> +            subsequent = extract16(be16_to_cpu(buf), 3, 13);

I don't understand what this is doing. I guess this is the
"don't parse extensions in fragments" change mentioned in the
commit message, but I don't see why this is the way to determine
that. This is testing the "fragment offset" field for being non-zero,
isn't it?

> +            break;
> +
> +        case IP6_AUTHENTICATION:

Worth a brief comment, e.g.:
    /* Per RFC4302, ip6r_len for this header is different from the ipv6 norm */

> +            info->full_hdr_len += (ext_hdr.ip6r_len + 2) * 4;
> +            break;
> +
> +        default:
> +            info->full_hdr_len += (ext_hdr.ip6r_len + 1) * IP6_EXT_GRANULARITY;
>          }
>
> -        info->full_hdr_len += (ext_hdr.ip6r_len + 1) * IP6_EXT_GRANULARITY;
>          curr_ext_hdr_type = ext_hdr.ip6r_nxt;
> -    } while (eth_is_ip6_extension_header_type(curr_ext_hdr_type));
> +    } while (!subsequent &&
> +             eth_is_ip6_extension_header_type(curr_ext_hdr_type));
> +
> +    if (input_size < ip6hdr_off + info->full_hdr_len) {
> +        return false;
> +    }

I think I prefer the "do this once at the end of the loop" that my
patch does, rather than checking at the start of the loop and then
afterwards.

>
>      info->l4proto = ext_hdr.ip6r_nxt;
>      return true;

Otherwise the eth_parse_ipv6_hdr() changes look good to me, but I
think they're complex enough to be worth having in their own
patch separate from the eth_get_protocols() changes.

thanks
-- PMM

