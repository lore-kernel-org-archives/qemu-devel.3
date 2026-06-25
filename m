Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77D8CCDE002
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 09:29:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcgNz-0008FU-U1; Thu, 25 Jun 2026 05:28:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wcgNx-0008FH-SU
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 05:28:37 -0400
Received: from mail-yx1-xb12d.google.com ([2607:f8b0:4864:20::b12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wcgNw-000827-6J
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 05:28:37 -0400
Received: by mail-yx1-xb12d.google.com with SMTP id
 956f58d0204a3-6603d8697d2so1749608d50.0
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 02:28:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782379714; cv=none;
 d=google.com; s=arc-20260327;
 b=HLQGYyzIu2DPm/pRJIIMcd8Spzv9NsxtAq313ILPX7WjG/cW/s9Wgfrb+l5DGxRFsw
 O4E4sthrzI/7uaCaKQinsLwqQKw+GRRCCk/SThFrhl5vdXB08aah7r4xWiB/uiY5+RyU
 euU14MwpYb4SbkRb4NGLfgJ1KP9zCaJIp9dPFYHIEFdcbmFsK+S+oIpk6Jh+QHZ88MyN
 yFVehtH+8+HxqQwkfiIUpGexEFve7VKdAgRZ8t9oEBxM0jWrvOecPBzDE9DVa12Gxsz+
 Noblq2Qru4WxJggxuqtkcljbONtrL+ZfXxrKU3bkJAiOtnSl1m1bilHzMxDN7qJqVhGd
 SX6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=BC/JzwQItWLPkMOyqZ34Mg9FnwxMPIpA9htULZZ8KJc=;
 fh=eSk94K6eHQHq+QbeB+UqQmtRQW163/Ve2dXPEiYe6zU=;
 b=QUosn7ItDuGQi5WilMvHtZgMdvHt4ZWopUi/UHO1+Zhfxswu2biWm6A/gFRtpnOGAs
 zuzUDbGi90UOrvF8hDTriHXyAVopyQRB16sxrVejY+aV+DKKFQwn+SSdCtRG/hl4kkd/
 eRdpsxIsvTOO9vTw+cAKWedaXlQCv1/ClDfR8eq/O1BFJIoMLTemKA713eq60mauuTVU
 1kbfIxTTgWAIg2CXw7RGzX7NkW2cZmjrNP6q4SNk+NGZyYSYLD5g4LLrUeW6prfvZYxx
 DYsPyS8Pb4Y8cSKbbh8YMnOCt46CAH3+/OdZ2S+05l6MKYhFRlRfmHpJOlocpvCO+QAV
 5LKg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782379714; x=1782984514; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=BC/JzwQItWLPkMOyqZ34Mg9FnwxMPIpA9htULZZ8KJc=;
 b=d+F8UktUsQAnym68xuJLyc1hVtWTqjcox2ngsIShtNAy2VfIxyn9ZhEiAHxKG6/GOe
 YyUBUi6nFOa7EBR3WVkJZt29ydoCVk2h/2LWNJYqOZOewtClXymNVlbBm9cbgpufN0CK
 kYIE4b2ryslL6BCYbEesPJ6UMop2pKHWiTnxgJUTd84ESSpgMiXd1M1KDPURVrv1YoIC
 4JJ9xXZyEj7Tto4N7aYSnvgQtWQR0hp0TAV4hqecWUcNNay/GZEv6u+orhzgGlqZXm6P
 18jP7V2Q/PhqQoFSpI8uzk/f4PkhEy2lwR5HIeoGLa5gJAeafkUvB9icnu3tZPTK41dY
 O0Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782379714; x=1782984514;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BC/JzwQItWLPkMOyqZ34Mg9FnwxMPIpA9htULZZ8KJc=;
 b=Hd5R2kZjCrw8kFFhEbZvkM8JMI+Umy4eWJDS2vy/CjYpOQ9hgmFtQaXSBEgcbazE+i
 m0LEiPADutoa5mYFSZoInGEcIS7f9jWvdSM7OPXpG8NXfP6Q1C2a/YPXLG3WLkPu8192
 L7kRIOHzPY5qTy79rodwC3WCVl3QiPc0sOvyvDYvNSXHCk0UkMS/WzZU9iDizSxNDROH
 EorfjZtCVomnpP2pYStnozL3xaCXjGxMnaNaB2PYbJE8qOGNpNtGd6o2hFbdITp3BFDW
 SDE4r3Jw76OLOHwOmUYGCDddPSI1AIxAFcT9+/oT9KLzM/5eCmidQwyyYxx9eAiZsKeR
 UuiQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoUhE32LHHTE4PrUygyi4xVDHiG3vTDe7qS5EvNhkS6dp4Xe50OE3oSxggichjrKFY0j/+5O1qcy+8L@nongnu.org
X-Gm-Message-State: AOJu0Yz1P5+varO3zusc8n51ttLrv67vXyZuOejBzwoQUm8UkxZPzWYY
 vO8zZFn9iRZfTrucc7S5JMd1rgcCiJDJW4QrROedChYIY0/+0rzhrcoxEKdpzi7i9MkMjGwMpGq
 1ukW6WBThqXA6Yv2P4CiOE0QavDrUpdUmaUatv85nlA==
X-Gm-Gg: AfdE7cnonJLIpgHxPSmWyq++aYpMQum4xUBYOpdQ/iS2BURjSfpjsQOUNKT14yG6Qiy
 fJ1WtC/tmdhwYni7hWy5oV+/0SAiubs98K//y69B1xBVx/AR1cOLnP+Ff+bHEqe7ARW1cOoC17J
 RcEAegzSSqKFZarAM73H/jJXTgZGDED/g8307k1VvErAtcE5PBI3P/XFLh2ezw/5s6jzB7QLIkE
 LLC/W6usx1kW8ju7ooNN+4rE6S1EfnnOOT8wRy1xynRBf2i1NJfXlA65jo4i1iqAaG4/6vj7T79
 sF31HBaeF7b4/+8dsX12auYc97EaOhGgT1kviif5g75CDO9ok+08Pjt/zcz/GV9O4Iw=
X-Received: by 2002:a05:690e:4882:10b0:663:88d6:c967 with SMTP id
 956f58d0204a3-66487e26d26mr873790d50.52.1782379714087; Thu, 25 Jun 2026
 02:28:34 -0700 (PDT)
MIME-Version: 1.0
References: <20260624-net-tx-pkt-ip-length-padding-v1-1-7a22fe9b4e40@gmail.com>
 <34d263ce-863f-4509-a2a0-55ac1d47da7a@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <34d263ce-863f-4509-a2a0-55ac1d47da7a@rsg.ci.i.u-tokyo.ac.jp>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 25 Jun 2026 10:28:22 +0100
X-Gm-Features: AVVi8Ce_YEXnQzRg35S0xgpYDrC7aLeM81m65wQHNQAI3F3IRYauJnap-2_dPIs
Message-ID: <CAFEAcA8kZCAE4QAr1=B1yU2HZ7GipszqTnRJ68KDwRi1fQ6ASA@mail.gmail.com>
Subject: Re: [PATCH] hw/net/net_tx_pkt: clamp payload_len to IP header length
 for padded frames
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: Sanjeeva Yerrapureddy <y.sanjeevreddy@gmail.com>, qemu-devel@nongnu.org, 
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Jason Wang <jasowang@redhat.com>, Bin Meng <bmeng.cn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Thu, 25 Jun 2026 at 05:53, Akihiko Odaki
<odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
>
> On 2026/06/25 6:45, Sanjeeva Yerrapureddy wrote:
> > When a guest transmits a short Ethernet frame, iov_size() returns the
> > wire length including any Ethernet padding bytes added to reach the
> > minimum 60-byte frame size.  net_tx_pkt_rebuild_payload() used that
> > inflated size directly as payload_len.  net_tx_pkt_update_ip_hdr_
> > checksum() then rewrites the IP Total Length (IPv4) or Payload Length
> > (IPv6) field using this value, producing a malformed packet on the
> > wire: the receiver interprets Ethernet padding bytes as IP payload.
> >
> > In practice this breaks protocol stacks that validate IP lengths
> > strictly.  A nested ESXi host running on OpenStack using the e1000e
> > emulation sends short TCP ACK packets in response to a Windows guest's
> > virtio TLS client hello, which get padded to 60 bytes; the inflated IP
> > Total Length corrupts the IP header seen by Windows, causing TLS
> > handshakes and TCP connections to fail.
> >
> > Fix net_tx_pkt_rebuild_payload() to read the IP header's declared
> > length and clamp payload_len accordingly:
> >
> >    IPv4: ip_total_len - l3_hdr_len
> >    IPv6: ip6_plen adjusted for parsed extension headers
> >
> > Guard both paths against malformed guest packets where the header-
> > declared length is shorter than the IP header itself; without the
> > guard the unsigned subtraction would underflow, producing a huge
> > payload_len.  Fall back to the raw iov_size() value in that case.
>
> This breaks net_tx_pkt_get_total_len(), which also uses payload_len and
> expects pkt->hdr_len + pkt->payload_len produces the size of the entire
> packet. It is also unclear whether fall back to the raw iov_size() makes
> sense. I think we need to define what payload_len should represent to
> figure out a correct solution.

See also this other recent thread about short packets:
https://lore.kernel.org/qemu-devel/CAFEAcA_UhmCxJc16CHE=4ZR1+PA0=4-29=fEe+d+iUmhLTzpuQ@mail.gmail.com/

I'm not sure we're entirely clear and consistent about why and when
we pad short packets (are we doing it to make our lives easier in
writing the receive path in network device models? are we doing it
because some net backends will hand us a 40 byte packet and a
network device is entitled to expect a complete ethernet frame? other?).
Do we need to distinguish (can we always?) the payload length and
the padded length? I had a go at some patches that move the "pad
this short packet" code around so we do it more consistently, but I
don't feel very confident in them because I don't have an understanding
of the overall requirements here yet.

thanks
-- PMM

