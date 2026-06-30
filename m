Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 389ECC43458
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 14:15:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weZEu-00020T-5x; Tue, 30 Jun 2026 10:15:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1weZEs-0001zk-Oh
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 10:15:02 -0400
Received: from mail-dy1-x1333.google.com ([2607:f8b0:4864:20::1333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1weZEm-0003qQ-V6
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 10:14:58 -0400
Received: by mail-dy1-x1333.google.com with SMTP id
 5a478bee46e88-30bc871ecdfso6125648eec.1
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 07:14:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782828895; cv=none;
 d=google.com; s=arc-20260327;
 b=b9BAQ8HpJhuE/EPsPxO8cH3SNm2qlxqZkwHjaW/3DeCEGLbk1YpPt2s66SEg01ifQ5
 VtkkzaP7460OVIToib4NhVsV8AzSlbwT0oVLQJcV8dY6HBpWqrYjhsyJz4VQaRUKyJJI
 PwDsqp0gaLwR8unG6g0P/se5yb1CuwrQjmoV7dHagUNYpEhXY0EgjOiV4KgNlrpaAPuu
 8NacpQKCI+g8d7YyryyySO/phP/V/kVPlhsUf2+eUeVk81SqGVd4/TcmNp4D0wP9X6uy
 7qC2YSAia2cweqwxaNDpoQhgdq/+RmQCIzCWnZXbC0ziwmxU128Gdm8cbb7PHDC90zbv
 RAGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=UkVDLaJDNQOl4sVuHADtBAqX37JYxoOBUaM57zC9puY=;
 fh=UcPTacNDH0s5IGqnKdbAAPfHJkJqsMCJCiCJ3AY//nU=;
 b=C+CLq4r+b81zY5nd+JRjwhj+L2BOmFd7ZupATkt1O5/BRR8SQdgorW6iFhdxopYgtL
 wSl/8RP6t+fqlRNKJPQ9y3B1gp5lg4AUSPi2MATT2kb+OXa4Ro7FFgcq3+VyYOT/wr2Y
 DrDC1NzUoddOff3pXq2We0N6ZaISOeNkMXoXc7jfNN3OBVjAmuGp8itrgRpvGAg9inwi
 KlOOfEEdAS/NJdgs43rUXXuaSUktEJKGTYz9f5Ba7imT9ZA2JFiKhUUXol7UXAUb6Fil
 8uImLM+PNxSMWahdjRUnoHM3amzT5hLfag/5aWR2hY3VAy+eEXomKX2oy3YBMIZ+3nuj
 lwnA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782828895; x=1783433695; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=UkVDLaJDNQOl4sVuHADtBAqX37JYxoOBUaM57zC9puY=;
 b=m3suRl64cktaxIETcOPkVgDBWjmqjcCGAsF3D2W9iN1WvmnqrJXniiZv63lOCVP48B
 lVD9C7aN/7Pd1m3fTGZS6p/gjpn+1g1gIOKTFBmVCh0cgllTlrdR1b/Zui3xr5qH07U1
 2lGkxokTEvnQ+YvLTfMml6hLQy9MnLBQKgUdetQaVHSTJm2qMO4F5nr2J/aKWYRrIYB0
 ETs4qaaysxaY4yq+CuHA2gjxhUm1+H1TVuRYrTRzhb9LPs3B65tJQZgBBGQ+6wBvEB59
 aKmniWcR1jcs4ZfskPJfDCduX/6XZyv2VOvbviFJE/B1e3AqryAO7V5hyIGZSMfvS4Yg
 m+UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782828895; x=1783433695;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=UkVDLaJDNQOl4sVuHADtBAqX37JYxoOBUaM57zC9puY=;
 b=T5ONIq2Mg2/jZN5TnovwmnsJe3jeCFWCwOPk2gpmTQ6a9TDXc+25F5ar6uDxlgoIid
 OwHVU4b30D3TS5HryerO3mwqqUOO9Cbcrg7UhPSYqEY5hpNsUUVo/35eIcENQ5fkzXpm
 wqaLvUS5ew8Z5a071bCNLIlw6mCBdW4snLtJ+wFte2E1N47P5Mt3Krh1taKo/aylOPvy
 8E53GJ2oiCFOydX6kloM7GksOrkO283MpzU56K+jHLE5/E1Yvwtw44ZXmtfwQR0hRtvA
 2LzLb31iFUD+tE1ZP/jvC96FQEkuWl9KRL5zBdI5OjbuD1vDWiOzJLwszpxKCALZYCsF
 q1Og==
X-Gm-Message-State: AOJu0Yy1HyMz+dM6jyYP8iHyf/w3hI9A6AhumThbKWQM8D+d9WIYOI5t
 EQcUEQfFANGywVEmvGNFw7exZv5FVHdyGPLv43exQkJQ3fHqR8hPnMVxiMI/G9B7V8UubSFfv5m
 PykxG1kdyv+oUL/4bQO/vl7NP9SyGIPs=
X-Gm-Gg: AfdE7ckVvQxe9gqHWAo1GESNhrwYttuDNSDKbwWAoxatib0VyfsNxFtiKZAgr3mQNCu
 Mz1AwTOuKkkbEGqXmDKEE6qupqnKWuJ+YACcDApLWKnio2feC9/8BRjy8Sc7nWbrJ9V5YDLWilB
 R6fHJjYRxJFiERvwnIXHZadTJ8pFJmRF/9We0L9HyNKCeivOEnQUOBhqnpPreNgczVeTqyjfqbG
 TPrRBqTC2uijMbfsNUtQcJsthlaTdhppjcNwLN8r92CIHva2fZTEkx5JEakDs7k1wz2Ii2IanDu
 ml1RA3//OPX8YpU5ShFmnRYvbQXRUop4hY+TeA0=
X-Received: by 2002:a05:7300:6409:b0:304:e2a5:689c with SMTP id
 5a478bee46e88-30ee146e255mr3473906eec.21.1782828895037; Tue, 30 Jun 2026
 07:14:55 -0700 (PDT)
MIME-Version: 1.0
References: <20260626080554.1656771-1-ziyifu970225@gmail.com>
In-Reply-To: <20260626080554.1656771-1-ziyifu970225@gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 30 Jun 2026 18:14:39 +0400
X-Gm-Features: AVVi8Cez40oNTl0JOFzk6vtc84sYyAdmDilGonjrHu7Wfbua4EbjwUX5oC_b20o
Message-ID: <CAJ+F1CLq=FJhE+tBgySzVCfjDkEExWv14Pe_ib4FKY22Gm=4dQ@mail.gmail.com>
Subject: Re: [PATCH] hw/usb: record async control completion for parameter
 transfers
To: Ziyi Fu <ziyifu970225@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, 
 Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>, 
 BU Embedded <bu-embedded@cyberus-technology.de>,
 Ziyi Fu <ziyi.fu@cyberus-technology.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1333;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-dy1-x1333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Jun 26, 2026 at 4:05=E2=80=AFPM Ziyi Fu <ziyifu970225@gmail.com> wr=
ote:
>
> From: Ziyi Fu <ziyi.fu@cyberus-technology.de>
>
> Record the completion side of parameter-based control transfers when they
> complete asynchronously. This lets pcap captures include descriptor
> response data for requests such as GET_DESCRIPTOR from usb-host devices.
>
> The synchronous path already recorded the completion, but the async
> SETUP_STATE_PARAM path was missing it.
>
> Signed-off-by: Ziyi Fu <ziyi.fu@cyberus-technology.de>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
> Tested with a usb-host HID keyboard on qemu-xhci. Before this change, the
> generated pcap contained GET_DESCRIPTOR submissions but not the correspon=
ding
> completion payloads. After this change, the pcap contains the descriptor
> payloads and Wireshark can associate endpoint 0x81 with the HID interface=
.
>
>  hw/usb/core.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/hw/usb/core.c b/hw/usb/core.c
> index 9572a870cc..d71204c5c8 100644
> --- a/hw/usb/core.c
> +++ b/hw/usb/core.c
> @@ -345,6 +345,7 @@ void usb_generic_async_ctrl_complete(USBDevice *s, US=
BPacket *p)
>              p->actual_length =3D 0;
>              usb_packet_copy(p, s->data_buf, s->setup_len);
>          }
> +        usb_pcap_ctrl(p, false);
>          break;
>
>      default:
> --
> 2.51.2
>


--=20
Marc-Andr=C3=A9 Lureau

