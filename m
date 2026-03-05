Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F354DF3D338
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 17:08:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyCB1-0005Ux-3w; Thu, 05 Mar 2026 12:07:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <bounce+0e9322.97607e-qemu-devel=nongnu.org@yodel.dev>)
 id 1vyCAw-0005UX-IK
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 12:07:51 -0500
Received: from v512.v5f06b487.use4.send.mailgun.net ([143.55.232.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1)
 (envelope-from <bounce+0e9322.97607e-qemu-devel=nongnu.org@yodel.dev>)
 id 1vyCAr-0004Wh-QQ
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 12:07:49 -0500
X-Mailgun-Sid: WyI4ZDFlNiIsInFlbXUtZGV2ZWxAbm9uZ251Lm9yZyIsIjk3NjA3ZSJd
Received: from mail.yodel.dev (mail.yodel.dev [35.209.39.246]) by
 9f2d8d5d1dd87aa62bc113c6907ca85310f17ee72b07f13c1d4fdfb31e9af075 with SMTP id
 69a9b851a4133bd94d18d3c5; Thu, 05 Mar 2026 17:07:29 GMT
X-Mailgun-Sending-Ip: 143.55.232.12
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yodel.dev;
 s=rsa2048; t=1772730448;
 bh=LIPjZ3lng+vaabtxN+yylONZX6XgtyHltI7wUEddpPQ=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:
 X-Mailgun-Dkim:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:From:Reply-to:Subject:Date:Message-id:To:
 Cc:Mime-version:Content-type:Content-transfer-encoding:In-reply-to:
 References;
 b=HdJcZH+nl+CxFbR/KuCdn3fqFOoT2yYTTVbBRDJ4WLMUr/cz1MQXNDMunvhCDkDnf
 EM2/JrYxnofxIamcehMX4sf+7IqjWauUs5aTWt/2qZVwy8fgz5E7ouRG7rUAmASjOK
 qi5DXbKNS4n+WBTsaKB1sSdQsvWPnchy23RJ1F/OF8Bn6ewwlJTcozidlFUOUZbhj+
 geEWf7iLr982832sqkWPnqIsc8OrlqVbhwT+m0lpBlzRhH0273+iPHd49Xk7lkXmGN
 0a8GSMUuAPFuAQ4PDgMESQ001RrBORVy9AG1f0puhp6lPGcUxjLrEYC/RFAm0xBooU
 1IqUTVJBmL6OA==
Message-ID: <24116535-2f3d-4ded-b9d1-e0701c5cf74b@yodel.dev>
Date: Thu, 5 Mar 2026 11:07:27 -0600
MIME-Version: 1.0
Subject: Re: [PATCH v2] hw/net/rtl8319: Work around GCC sanitizer /
 -Wstringop-overflow bug
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
References: <20260305140512.1330691-1-peter.maydell@linaro.org>
Content-Language: en-US
X-Mailgun-Dkim: no
X-Mailgun-Dkim: no
From: Yodel Eldar <yodel.eldar@yodel.dev>
Autocrypt: addr=yodel.eldar@yodel.dev; keydata=
 xjMEZxqXdhYJKwYBBAHaRw8BAQdAkletQdG3CLyANZyuf2t7Z9PK4b6HiT+DdSPUB2mHzmPN
 I1lvZGVsIEVsZGFyIDx5b2RlbC5lbGRhckB5b2RlbC5kZXY+wpkEExYKAEECGwMFCQOcG00F
 CwkIBwIGFQoJCAsCBBYCAwECHgECF4AWIQTTzRjNQG27imap+N+V7k+3NmVNrAUCaNWASwIZ
 AQAKCRCV7k+3NmVNrNnSAPoDjQXa6v7ZzdQSaLdRfAQy/5SsUucv+zp3WAP4pXdgJQEAzMMC
 Ctx4l6b13Fs2hZdRXEnF/4BZ9t1K68nwzZOV3QnOOARnGpd2EgorBgEEAZdVAQUBAQdAKPIy
 3W/DKFsm1e+31zoqmOY0pqz8vjIM846wM6lEY2QDAQgHwn4EGBYIACYCGwwWIQTTzRjNQG27
 imap+N+V7k+3NmVNrAUCaNWG7QUJA5wi9wAKCRCV7k+3NmVNrPusAQCQDQwETy7VT6UhHPho
 TkrQnsNqQfFU3tXqCTiViToktQD7B/U2/to97hQIJCWbK6yd3T+KPZJPMcHMg2XRyedUvgA=
In-Reply-To: <20260305140512.1330691-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=143.55.232.12;
 envelope-from=bounce+0e9322.97607e-qemu-devel=nongnu.org@yodel.dev;
 helo=v512.v5f06b487.use4.send.mailgun.net
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HELO_STATIC_HOST=-0.001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.892, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.622,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Hi, Peter

On 05/03/2026 08:05, Peter Maydell wrote:
> If you compile QEMU with GCC with -fsanitize=address and
> -Wstringop-overflow, this causes GCC to produce a false-positive
> warning which it does not produce when the sanitizer is not enabled
> (and which makes compilation fail if you're using -Werror, as we do
> by default for builds from git):
> 
> ../../hw/net/rtl8139.c: In function ‘rtl8139_io_writeb’:
> ../../hw/net/rtl8139.c:2264:17: error: writing 8 bytes into a region of size 0 [-Werror=stringop-overflow=]
>   2264 |                 memcpy(data_to_checksum, saved_ip_header + 12, 8);
>        |                 ^
> In file included from ../../hw/net/rtl8139.c:62:
> /home/pm215/qemu/include/net/eth.h:50:14: note: at offset [8, 48] into destination object ‘ip_ver_len’ of size 1
>     50 |     uint8_t  ip_ver_len;     /* version and header length */
>        |              ^~~~~~~~~~
> ../../hw/net/rtl8139.c:2192:21: error: writing 8 bytes into a region of size 0 [-Werror=stringop-overflow=]
>   2192 |                     memcpy(data_to_checksum, saved_ip_header + 12, 8);
>        |                     ^
> /home/pm215/qemu/include/net/eth.h:50:14: note: at offset [8, 48] into destination object ‘ip_ver_len’ of size 1
>     50 |     uint8_t  ip_ver_len;     /* version and header length */
>        |              ^~~~~~~~~~
> ../../hw/net/rtl8139.c:2192:21: error: writing 8 bytes into a region of size 0 [-Werror=stringop-overflow=]
>   2192 |                     memcpy(data_to_checksum, saved_ip_header + 12, 8);
>        |                     ^
> /home/pm215/qemu/include/net/eth.h:50:14: note: at offset [8, 48] into destination object ‘ip_ver_len’ of size 1
>     50 |     uint8_t  ip_ver_len;     /* version and header length */
>        |              ^~~~~~~~~~
> In file included from /home/pm215/qemu/include/system/memory.h:21,
>                   from /home/pm215/qemu/include/hw/pci/pci.h:4,
>                   from /home/pm215/qemu/include/hw/pci/pci_device.h:4,
>                   from ../../hw/net/rtl8139.c:54:
> In function ‘stl_he_p’,
>      inlined from ‘stl_be_p’ at /home/pm215/qemu/include/qemu/bswap.h:371:5,
>      inlined from ‘rtl8139_cplus_transmit_one’ at ../../hw/net/rtl8139.c:2244:21,
>      inlined from ‘rtl8139_cplus_transmit’ at ../../hw/net/rtl8139.c:2345:28,
>      inlined from ‘rtl8139_io_writeb’ at ../../hw/net/rtl8139.c:2728:17:
> /home/pm215/qemu/include/qemu/bswap.h:284:5: error: writing 4 bytes into a region of size 0 [-Werror=stringop-overflow=]
>    284 |     __builtin_memcpy(ptr, &v, sizeof(v));
>        |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> /home/pm215/qemu/include/net/eth.h: In function ‘rtl8139_io_writeb’:
> /home/pm215/qemu/include/net/eth.h:50:14: note: at offset [24, 64] into destination object ‘ip_ver_len’ of size 1
>     50 |     uint8_t  ip_ver_len;     /* version and header length */
>        |              ^~~~~~~~~~
> 
> This has been triaged as a bug in GCC:
>   https://gcc.gnu.org/bugzilla/show_bug.cgi?id=114494
>   https://gcc.gnu.org/bugzilla/show_bug.cgi?id=99673
> (the sanitizer pass rewrites the IR in a way that conflicts with its
> use by the warning pass that runs afterwards).
> 
> Since this is the only place in our code where we hit this, work
> around it by disabling the -Wstringop-overflow in the part of
> the function that hits it. We do this only when using the
> address sanitizer on GCC, so that we still get the benefit
> of the warning in most compilation scenarios.
> 
> Cc: qemu-stable@nongnu.org
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3006
> Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> v2: disable the warning rather than using the incorrect attempt
> at a workaround that v1 had.
> 
> On the fence about whether this is worth backporting to stable.
> ---
>   hw/net/rtl8139.c | 23 +++++++++++++++++++++++
>   1 file changed, 23 insertions(+)
> 
> diff --git a/hw/net/rtl8139.c b/hw/net/rtl8139.c
> index 2ad6338ebe..424af73a18 100644
> --- a/hw/net/rtl8139.c
> +++ b/hw/net/rtl8139.c
> @@ -2124,6 +2124,26 @@ static int rtl8139_cplus_transmit_one(RTL8139State *s)
>                       hlen, ip->ip_sum);
>               }
>   
> +            /*
> +             * The code in this function triggers a GCC bug where an
> +             * interaction between -fsanitize=address and -Wstringop-overflow
> +             * results in a false-positive stringop-overflow warning that is
> +             * only emitted when the address sanitizer is enabled:
> +             *     https://gcc.gnu.org/bugzilla/show_bug.cgi?id=114494
> +             *     https://gcc.gnu.org/bugzilla/show_bug.cgi?id=99673
> +             * GCC incorrectly thinks that the eth_payload_data buffer has
> +             * the type and size of the first field in 'struct ip_header', i.e.
> +             * one byte, and then complains about all other attempts to access
> +             * data in the buffer.
> +             *
> +             * Work around this by disabling the warning when building with
> +             * GCC and the address sanitizer is enabled.
> +             */
> +#pragma GCC diagnostic push
> +#if !defined(__clang__) && defined(QEMU_SANITIZE_ADDRESS)
> +#pragma GCC diagnostic ignored "-Wstringop-overflow"
> +#endif
> +
>               if ((txdw0 & CP_TX_LGSEN) && ip_protocol == IP_PROTO_TCP)
>               {
>                   /* Large enough for the TCP header? */
> @@ -2307,6 +2327,9 @@ static int rtl8139_cplus_transmit_one(RTL8139State *s)
>                   /* restore IP header */
>                   memcpy(eth_payload_data, saved_ip_header, hlen);
>               }
> +
> +#pragma GCC diagnostic pop
> +
>           }
>   
>   skip_offload:

Thanks for addressing this issue. LGTM.

Tested-by: Yodel Eldar <yodel.eldar@yodel.dev>


