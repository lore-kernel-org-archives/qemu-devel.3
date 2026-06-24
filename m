Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA56FCDB479
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 08:42:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcJB1-0002SM-O7; Wed, 24 Jun 2026 04:41:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wcJAx-0002Rt-VE
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 04:41:40 -0400
Received: from mail-yw1-x1133.google.com ([2607:f8b0:4864:20::1133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wcJAv-0004tS-QK
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 04:41:39 -0400
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-7fdb04d774aso9216727b3.2
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 01:41:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782290496; cv=none;
 d=google.com; s=arc-20240605;
 b=OhbQkRWBxSkjOo6UadgZk/MXRErxcY973QZnQgRBNCxIFFx5Ulg2FcNe0HBhkTS9jY
 o4rTYU94qh+GxS4JHo4/qaOD8jKu0dYWfkaC0Lk1CKOGe4jGFqzW/7U/K+FeF8wOteSv
 Uv2ro/W4iIJ+pO6hSpBG0cxXxlih68wLCcqcYiz28yMApouFemU1NB/uep4yS4RtusaY
 uT5gkS5J14qv2J+l1TccnNPmEfpT/8/Q9jo2DjQxwXcIjev4blfFS7l6tN7bmBhPd/Sr
 lcuFR+Th6qb9MXE/WHXVAXaJmHFxef39tYYq/VNjaB0URT3TRGl7LxNUZB/s6v9Am/0y
 VFmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ztlCBF7524asXYVOzcXhXp3HXE30vcSwBVoPXr2Exjs=;
 fh=Mwuq573iCp9M7/4LHhrrdtS1U7mxXVvI4mYPg/mZOH8=;
 b=knWDvrBBOt08FgRdC/LyyhZOhq4+ztc/noFhF24U0WZxdRu1SE20vzmEOhiRy3Z3V0
 D8Pn8GmL+TeXMCwSuxyqIEytpQE+j0woDAiEtb7Tdu0UsaWjY16rXxr1X2SbhNNpRS0A
 JRQZs4I2zCO80IByAmxR/Np7ehuIfd1TX7y+NhCkNfg5/M2VGdC++OxMRVi2Eckg+htC
 0Nwlckz0rPb9w23hr5jvkpb3d1n8Mivpsj5EiXiSgIoCvect9Df+SjrizAv4Fh7q50N2
 6muWlQwgYwI/LEk/nPA+1+Ykk70+4hmhTKYPmtmMgDmlEtMhMni9cnZz9rFIy81go1oN
 wEOw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782290496; x=1782895296; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ztlCBF7524asXYVOzcXhXp3HXE30vcSwBVoPXr2Exjs=;
 b=mLvSV4vCwjymcrgKMRlXAhIHg5bdKz4HD4NyszzIu6giWvvhiqeijx0BUIDxVZCLSq
 voBFFXmtG8jS2owUvlQO2lKNV4pjSv3EXoI0CcaTCtZNzH9LBn2P9E24H8msKKuYr95l
 J5Wx8o71AC2+BCiz5rXjx8sHOJkpQfj6dFOtFa32ByZNzY2OO6SU+jIerEOYYBF1IMWo
 3YX6M2HfVbA4W+5YQ3x1ZAJ+b+2pLzYC8MniZMuTNFJChAuIssCzJC1sr8nlty6nGni1
 oxVTHTdX4PK2DZWhLcXWj3INaT8mL67CdbWzpkwYQxKV/YHWrES13Dfyu829trSAlGL/
 z/Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782290496; x=1782895296;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ztlCBF7524asXYVOzcXhXp3HXE30vcSwBVoPXr2Exjs=;
 b=AgHYwpJU1xbeyYzp5vdx30KN3prcmzPUcS0RMTYPPEySBednz2FUIK8tS0TYWEtMaN
 JFmrh54wwrN6x8bK/jxhejihaa2qo688jR7TchhxVFo98nsj+GG7tkkBP1v/CwFD5vsV
 JNUySxiRSMxr+/gKus4OyLLgZigQ5MkROZjtOPT9W6atHh0Z1UVaqZGqs4racR9+uIXv
 nm9gqLpD7gJVIJKD3TCWa79S6HLdApUaG5QRqKHgp0daaY6UjbQBjOVGVnz7YOgbMI8D
 WdSWEap7J4mPcHaVj+rKpSCmcG0D6cuAngPNFjmVgFnO+L7oMqLnxzRTR/DeXDcivjNq
 /hyQ==
X-Gm-Message-State: AOJu0YyAP/XCrowst3wuRSlrcWWEAeq1rJNCLifgqPzlI6fIpbO7oHyK
 tcCZcH6s+3tOgmo7SYkCnOalocizYastHVR1J7ey7jsOveGL+0UJZeQY+vg7udf8eDJTFFEw2l+
 iMvQqDlRj4rLQZ0sdqMY8HRWPKyzMePNneI/j3nRDpw==
X-Gm-Gg: AfdE7cm4gWrSdv79C6uOGycXjjybKgh6AD0wCXmvzCfD08ORYfMyegE9jaMOPUyxseK
 l9g8xNW8qHYEFvtFXcw4Vf5vwDrMgh0x3XqTKYA5wsDCqgMBe9NXaXb0RzC34AjsalKRbd3O5TW
 h9segadb7MKjXUKo65UJaiRn68LvnPPJaNFHbXl00JQbeFEXyOjZEAqp5uX1/vygTW1dr5mPLYQ
 AEn75gNoTSr5oFKEDp5LfmMxw48KukBE7As87rnmfsxQ7nbhaFzaMym0ayd9zw3d5cQNF976Agq
 d2kdveORxe/J/5/bqWtsRGmbour6gg6kdrge39glKcLZikLK8nJUwjFx
X-Received: by 2002:a05:690e:4507:20b0:65e:1c98:83b3 with SMTP id
 956f58d0204a3-66312f7a144mr12771820d50.43.1782290496218; Wed, 24 Jun 2026
 01:41:36 -0700 (PDT)
MIME-Version: 1.0
References: <CAFEAcA_UhmCxJc16CHE=4ZR1+PA0=4-29=fEe+d+iUmhLTzpuQ@mail.gmail.com>
 <CAEUhbmW=02DNwVH7pLtuWBzEnEVJiJNrZVcys-pLY_cS0uro1Q@mail.gmail.com>
In-Reply-To: <CAEUhbmW=02DNwVH7pLtuWBzEnEVJiJNrZVcys-pLY_cS0uro1Q@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 24 Jun 2026 09:41:24 +0100
X-Gm-Features: AVVi8CeVpwVx0cKj_YNy5bLkwRd07DZJTKeGMSiwN4LGgoB0Ao31nfx4b7lVooQ
Message-ID: <CAFEAcA9DB+j3KJCM9yxVoSzQaXgx4uC_Bb7qm_p+OwS6EKn1fQ@mail.gmail.com>
Subject: Re: QEMU net code and padding of short packets
To: Bin Meng <bmeng.cn@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Jason Wang <jasowang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1133;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1133.google.com
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

On Wed, 24 Jun 2026 at 07:57, Bin Meng <bmeng.cn@gmail.com> wrote:
>
> Hi Peter,
>
> On Tue, Jun 23, 2026 at 6:56=E2=80=AFPM Peter Maydell <peter.maydell@lina=
ro.org> wrote:
> >
> > What is the general design principle for QEMU's handling of "short"
> > packets, which are less than the 60 byte ethernet frame minimum?
> >
> > In commit 969e50b61a285b0 ("net: Pad short frames to minimum size
> > before sending from SLiRP/TAP") we made the slirp and tap backends
> > add padding to short packets before feeding them into the net
> > code via qemu_send_packet() and friends, with the idea that we could
> > then remove (often buggy) code from network device emulation that
> > tried to handle the short-packet in its receive path.
> >
> > In commit 79b6a985 we realized we also needed to do this for the vmnet
> > backend. The issue https://gitlab.com/qemu-project/qemu/-/work_items/23=
62
> > reports that we also need to do this for socket and dgram and similar
> > backends.
> >
> > I'm trying to identify what the underlying logic here is. My current
> > best guess is:
> >  - we should always pad before feeding in a packet which is going
> >    to be sent to an ethernet device model (unless that device model
> >    has explicitly opted in via do_not_pad, e.g. because it really does
> >    want to faithfully model the card's handling of short packets
> >    and it's gone to the trouble of getting it right)
> >  - we should not pad before feeding in a packet which is going to
> >    be sent to a network backend (i.e. where the guest is sending out
> >    to slirp/tap/etc)
> >
>
> Yes, your two bullets match the intent of the original series.
>
> The do_not_pad flag was intended to describe a property of the
> destination. Packets delivered to an Ethernet device model should
> normally be padded, unless that model explicitly wants to handle short
> frames itself. In the other direction, a backend should receive what
> the device model actually transmitted, since TX padding behaviour is
> part of the device being modelled.

Mmm. Something I thought of yesterday after I sent it is that we're
kind of trying to do two things here, though:

(1) we would like to have network devices have to opt in to "I can
deal with processing short packets", for simplicity and to avoid
bugs

(2) some backends emit packets which are not actually off a
piece of ethernet and so nobody has padded them out to the
frame length

So even if a device wants to opt-in to handling short packets
so it can report to the guest "I received and discarded 42
short packets", backends like slirp and socket that aren't
getting real pre-padded ethernet packets still do need to
do the padding.

That seems to me to suggest that the source of a packet should
also have a say in whether or not it ought to be padded, not
just the destination.

I guess I'm not totally sure whether the length of a packet is
supposed to be its payload length, or the ethernet frame length.
(i.e. if you get a 40 byte packet from QEMU, are you supposed
to assume that it's actually a valid ethernet frame and should
be implicitly treated as if it were zero-padded?)

> > Could we do this by having qemu_send_packet() etc always pad, and
> > have the slirp/tap/etc backends set the do_not_pad flag on their
> > NetClientState structs to suppress this? Would that be better than
> > having all the backends do "and pad this" for their sending code?
> >
>
> I agree that centralizing this in the net core is preferable to adding
> padding separately to every backend. I would also consider making
> do_not_pad the default for qemu_new_net_client() users, since those
> are the backends and hub ports, while qemu_new_nic() users would
> retain the default padding policy. That avoids repeating the same
> omission for new backends.

That's basically the conclusion I came to (I have some draft
patches at https://gitlab.com/pm215/qemu/-/commits/short-packets
that do it that way).

> > At the moment the only user of do_not_pad is the virtio-net device.
> > commit d4c6293041 just says "there is no need to pad" and doesn't
> > give rationale. Why is this particular network device a special case?
> >
>
> virtio-net was made an exception because it is a length-delimited
> paravirtual interface rather than a physical MAC. Its receive path can
> deliver a short Ethernet packet such as a 42-byte ARP packet directly
> to the guest, so padding it is unnecessary and changes the packet
> length visible to the guest.
>
> > Are there any special cases where code calls qemu_send_packet
> > or qemu_sendv_packet which aren't either "a network device"
> > or "a backend"? There's net/hub.c -- I guess that should set
> > do_not_pad for its inputs, so it faithfully passes through
> > short packets and lets the destinations decide whether they want
> > them padded or not. Anything else?
> >
>
> Yep, there are a few things to take care of:
>
> * qemu_sendv_packet*() needs the same handling as qemu_send_packet*().
> * qemu_receive_packet() bypasses the send path for device loopback.
> Its current net_peer_needs_padding(nc) check would become wrong once
> backends or hub ports set do_not_pad: the receiver there is nc itself,
> not nc->peer.

Thanks -- I'll check this bit.

I think we also have some loopback implementations that don't
go via qemu_receive_packet(), but I forget the details.

> * Hub ports should opt out on the ingress side, allowing each
> destination to make its own padding decision.

Yep. The hub calls qeum_new_net_client() so this happens
automatically.

-- PMM

