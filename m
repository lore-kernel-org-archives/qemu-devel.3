Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A215BCDB479
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 06:57:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcHYG-0001Ox-Vp; Wed, 24 Jun 2026 02:57:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1wcHY6-0001NC-AV
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 02:57:26 -0400
Received: from mail-yx1-xb134.google.com ([2607:f8b0:4864:20::b134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1wcHY4-00073Z-F1
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 02:57:26 -0400
Received: by mail-yx1-xb134.google.com with SMTP id
 956f58d0204a3-664345f8645so87262d50.3
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 23:57:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782284242; cv=none;
 d=google.com; s=arc-20240605;
 b=FW0mcFOKwc+CfdDSF4/oVM2CrlU3097Fm8+jPMIg6q4/eD5WjjrHHLbJVNuqA6ImXE
 6Mru3m9l115eRoQki5c20gqjdVgSV1FrlYQGjR/Gn3J0jfb90gfSZZj0KWXHEc0H3Ewl
 4l6Nud7tqunW9VkrietMTFplL1ja9qK1zkM20jLgaU7oozDKwWWwE05ENzODZzL2CGWL
 l5QXvBDK24jvJHhUqoQNkmQYro8waH7SGNRLShjHxWR5Zg8aysvBaIsiy91cFNWrJA1b
 9ZBV9/gJZj9VSEqAjTsXQ3DQjehy2AfoZgSYGUks7NL3G8V+P8XXrKHbD4wI+wrUbsgT
 mYDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=vUxJ9wYroSmT3LaDYRIni82gR/F/LwscVpaXjcN9BbQ=;
 fh=lQ2JeqdPLK5m79TkyaIfIjf4mxrp7E3SOgrqek3tz2k=;
 b=NteKTaOBTSTwv8uENjVhCm7jBQqndI0aXfHNIS/u/8VkqisTiQi+rCpBBO1Hsw9R1n
 dzdHNKJXI6IvX8QM2vPtknau2AauYTsFaCImIlOSwV3YO3i3eK5XZk+5ljWL8eTt72TH
 W/OxxQtFtleNyE6eeXBmqz1ScUMCo9JjfABEE2WemBjtiapyJLrVApcfdwdFn2mhPvaM
 Bks6Gus/GhjyXx7fQQn+nG7/AQERGf3j/umqoylk2JYIkFgHWSBL8n4hfE75dZ7dXdnF
 pvw85HUZ37w0ayHjb+03iQ9qXHY735XZ3HewVpU0Rs1gcEJy5G3PXzhjRF+4bPmvgrAT
 191g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782284242; x=1782889042; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vUxJ9wYroSmT3LaDYRIni82gR/F/LwscVpaXjcN9BbQ=;
 b=RXOAW5SK9uB4VpQot8LMr8RJHzfXx4PJLZ5kDdXWsbqGTCmrxyW4AT4KtwY4rPqsBH
 xP0FuyenbqEVCk29Hp0O50sM+jnFu7goG6DNk40wJ/WA9TMdOfVM6dyJU1k+toKK/cM7
 oTWbn7BOEOeXcnim2D4CL3l4EJSTq60LFvG4eLNTmMYsqmFAshtWhQruYGl0+h9U0OMp
 3J5ZSJmjUWEVUuk3ozq4WH3Urr1sLA+QlpTQ0HrJRBryeu6YIcasdX8LedOVpLE5ZeF/
 mIkvOTCh5v28ydrltnLtj9ynxiXwohr5o4FCIwxovf876qc2oHluXaT1wHzOC8JhM0Kl
 TQtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782284242; x=1782889042;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vUxJ9wYroSmT3LaDYRIni82gR/F/LwscVpaXjcN9BbQ=;
 b=dUiV7Bq2OFamwzDCZFEqO0lqmnH0iYKdlaYel/Niz7Noqfy78zE3R5SzyE3KR3oU+g
 s0Wr8PEEBBqjB/JRxne5PAwGmiLojf91lFY7H550Y5UIYyRbAzH9i2TZetgra+rSRuqk
 dt20qZUzi+yNrHVHonOAeYRuM0Xk41KOemZfIAHWkp9ErLWFCV/5O2WYG8UTNz+2qGpB
 V6k9nrimUC7uf4xSowxdhlacHX84+CXmHV9Ni8ItbsFB9MzrxkZ9aRcK6rMgmvm07YhT
 Nr1u95HuIoqwkb21bI+TyS+3OnjYZ3lEes0wmBlxzKH/0ZHcUpYMXyuiz2eoY69w+f7x
 SmXw==
X-Gm-Message-State: AOJu0YySXyaGqLp2xOQCijSmJARwNzWqbAp3HfdS8pnNqi4QmghIdB72
 7YKywcYf5QWgpr74WaXEqAyJ4TK0kiPcyAjG+wXLKO1AT80AVkJVWna3VEtuIhPlunMuzy/Ojck
 smOxKKcmUaBlhRulqRD+JusGNxSO8+yQ=
X-Gm-Gg: AfdE7cnL3bXZ8rvmsJ5P7YGftQCh/JXCHMp/N/txT/Xx9gIRu16w9rzP/m9U2KOxtJv
 /b0lHRVTWoB+xwhkuobjPC3JAW8QHyVbvvd4fTNvk5rAn/X9DdEKRNafD/wt02A12cF/PoVO4r7
 pFdwP5xHt8tzWtDPBq/iNXnp+KjYkfEMqJefwIt7XlkUQby/2uCqXJtjUeDlQaIlTDprb3ARMCA
 Ag7LZWjvbgpFuMfuePGkbCnVa5VtfOP3NTKJn87vzIDtwP+0f8jTbWrBDZAdo/RC1L4gCjVEp9/
 MT2e0xz/XpiEBwUh69+eG6myVmun9GM=
X-Received: by 2002:a05:690e:124d:b0:662:e26f:cd10 with SMTP id
 956f58d0204a3-6635a377cadmr5195466d50.51.1782284242140; Tue, 23 Jun 2026
 23:57:22 -0700 (PDT)
MIME-Version: 1.0
References: <CAFEAcA_UhmCxJc16CHE=4ZR1+PA0=4-29=fEe+d+iUmhLTzpuQ@mail.gmail.com>
In-Reply-To: <CAFEAcA_UhmCxJc16CHE=4ZR1+PA0=4-29=fEe+d+iUmhLTzpuQ@mail.gmail.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Wed, 24 Jun 2026 14:57:09 +0800
X-Gm-Features: AVVi8CeCah8jVATbzTJEbyhWUPILJzNjgqK42sE0xmNU9cDMbGV7J4ODCsUSxIY
Message-ID: <CAEUhbmW=02DNwVH7pLtuWBzEnEVJiJNrZVcys-pLY_cS0uro1Q@mail.gmail.com>
Subject: Re: QEMU net code and padding of short packets
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Jason Wang <jasowang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b134;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yx1-xb134.google.com
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

Hi Peter,

On Tue, Jun 23, 2026 at 6:56=E2=80=AFPM Peter Maydell <peter.maydell@linaro=
.org> wrote:
>
> What is the general design principle for QEMU's handling of "short"
> packets, which are less than the 60 byte ethernet frame minimum?
>
> In commit 969e50b61a285b0 ("net: Pad short frames to minimum size
> before sending from SLiRP/TAP") we made the slirp and tap backends
> add padding to short packets before feeding them into the net
> code via qemu_send_packet() and friends, with the idea that we could
> then remove (often buggy) code from network device emulation that
> tried to handle the short-packet in its receive path.
>
> In commit 79b6a985 we realized we also needed to do this for the vmnet
> backend. The issue https://gitlab.com/qemu-project/qemu/-/work_items/2362
> reports that we also need to do this for socket and dgram and similar
> backends.
>
> I'm trying to identify what the underlying logic here is. My current
> best guess is:
>  - we should always pad before feeding in a packet which is going
>    to be sent to an ethernet device model (unless that device model
>    has explicitly opted in via do_not_pad, e.g. because it really does
>    want to faithfully model the card's handling of short packets
>    and it's gone to the trouble of getting it right)
>  - we should not pad before feeding in a packet which is going to
>    be sent to a network backend (i.e. where the guest is sending out
>    to slirp/tap/etc)
>

Yes, your two bullets match the intent of the original series.

The do_not_pad flag was intended to describe a property of the
destination. Packets delivered to an Ethernet device model should
normally be padded, unless that model explicitly wants to handle short
frames itself. In the other direction, a backend should receive what
the device model actually transmitted, since TX padding behaviour is
part of the device being modelled.

> Could we do this by having qemu_send_packet() etc always pad, and
> have the slirp/tap/etc backends set the do_not_pad flag on their
> NetClientState structs to suppress this? Would that be better than
> having all the backends do "and pad this" for their sending code?
>

I agree that centralizing this in the net core is preferable to adding
padding separately to every backend. I would also consider making
do_not_pad the default for qemu_new_net_client() users, since those
are the backends and hub ports, while qemu_new_nic() users would
retain the default padding policy. That avoids repeating the same
omission for new backends.

> At the moment the only user of do_not_pad is the virtio-net device.
> commit d4c6293041 just says "there is no need to pad" and doesn't
> give rationale. Why is this particular network device a special case?
>

virtio-net was made an exception because it is a length-delimited
paravirtual interface rather than a physical MAC. Its receive path can
deliver a short Ethernet packet such as a 42-byte ARP packet directly
to the guest, so padding it is unnecessary and changes the packet
length visible to the guest.

> Are there any special cases where code calls qemu_send_packet
> or qemu_sendv_packet which aren't either "a network device"
> or "a backend"? There's net/hub.c -- I guess that should set
> do_not_pad for its inputs, so it faithfully passes through
> short packets and lets the destinations decide whether they want
> them padded or not. Anything else?
>

Yep, there are a few things to take care of:

* qemu_sendv_packet*() needs the same handling as qemu_send_packet*().
* qemu_receive_packet() bypasses the send path for device loopback.
Its current net_peer_needs_padding(nc) check would become wrong once
backends or hub ports set do_not_pad: the receiver there is nc itself,
not nc->peer.
* Hub ports should opt out on the ingress side, allowing each
destination to make its own padding decision.

Regards,
Bin

