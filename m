Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D440CDE000
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 18:41:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcp0L-0003lO-OV; Thu, 25 Jun 2026 14:40:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wcp0K-0003l6-9D
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 14:40:48 -0400
Received: from mail-yx1-xb12a.google.com ([2607:f8b0:4864:20::b12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wcp0H-0005lW-Ue
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 14:40:48 -0400
Received: by mail-yx1-xb12a.google.com with SMTP id
 956f58d0204a3-662dc3879acso256208d50.0
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 11:40:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782412842; cv=none;
 d=google.com; s=arc-20260327;
 b=hUkHFsMi2Z0D/gYaSDrjkmqZQKlzQqVTqthsYrx+e2ObZ/LxeoXF1M7nJYHwJm3BSh
 9m690iywDZimsut9RSGYwVriIr8IGuUsIvN6UJQNhveOkU/xEuFHuZmkManjTso2O8F1
 f5RJdiKRkhY1QAON6HFqr4PUBE/0axTKyU50YyyAx6BX+LL+OMVvzefQub/hBRdFUHhP
 vW0MB5Vxuupz/MkOOhsGbFcaGMQZjwRSbsYbJh14ryK5125TGbdyAfhPBBzdvvtLZpl+
 ndH2LJ1cxt40yaj8Q29tH7oM8WfR8p+iy4zBDhuZFq+hIWgnzYehmkhJ9tUeQcoUiz5f
 HntQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=1//dkdkVyo3lk9F7xtNTKOwcUnSX+MrMrUozB81hdj8=;
 fh=etCOb0EekzzvmhoRDwbbrp0TOYTA7GRYpAcaG2etqiY=;
 b=IzOFVKv2pGJ45WF2QBKuawWlxjneH/dXaSd8RgaGKnkMpxr7pd1lZ/DQAKcrCwcKF8
 70IzZHA9f0on3oojnOTxyWwJwJLJhw12mbkvHC7k9IOk/j4n1iruVWWw6lg2JQPY5b2q
 IpYAIuHqy2Tm8KYgk/DdBAEQjmLt4ThtxtViw0aWffVOCGcHZXtGj7fwfuwLsaQNPAkL
 aIl7kaw896FrMiAHLhHMaZ5yrZROwoUEwRKBmqg5nX5NpJX7CaU14f/32NstvuADQXHE
 pTzhJgoH15uJomNAZC3pn8XGA5Yc4jKLVgjt1zenkkktUArofLvDQRaQFyNAZafchI6E
 FiVQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782412842; x=1783017642; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1//dkdkVyo3lk9F7xtNTKOwcUnSX+MrMrUozB81hdj8=;
 b=Vh6FzyGn0jhMag99f4QZsT5buhoAsX+8tClfCYY9C4yZfJNJW94td63AeSUQNUrpj+
 onH8MQ7Mn1iWrFIQg1eEQOsC3zJTwcBsPk79JP1EhoaUFkW4WI5R9OpHQLsvCln+tEIg
 hEwSbgIOMhJW1gmgqvl7/NRsxjkCocq3+kcpnhi6b8uNLEUiDjmj4ogggb5jmnkEe/M5
 4hVq4U8DjIXWryXJHfCLPGGOf9kKOMMwaSSyWTFUmGIQYgqOxL+ebvnB7kXUFYKC1/BJ
 o/hGo6fwASF0St9w4gvX0qYpVUeGEkdhoxMEClZxBN+YX+8Wet4TY44MsxROytPuioLA
 0Ppw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782412842; x=1783017642;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1//dkdkVyo3lk9F7xtNTKOwcUnSX+MrMrUozB81hdj8=;
 b=bBCORRpPaHWdG+pGucCeo2KihgJBWuDC8v/gAyjojoN2y8PYXkEGgwr5s/ndNwRlAB
 qn+skoTbkEiohP1SeGtiZusVYsOSi518tTLi5knNnPwpTbGmQKlR6bXnXTdD3a+TTtK1
 sulIKay38AHwtCsEYwlYZpU0QlyjCd1Ut3VZbUAo8qK05f82OHlq+p2efrQnF65CXZP0
 piEcGVsLNCXIsBK8+D72NRS7itHA7v9+ev22xFs/XdzYXuAFavOj8sJdnjWGfstPnRkR
 BLx/NeyZZSgjd1Q2YUKk3qzBg5OGscpIx3MbG+2bu3LsDRR5pjVz++tvbof2GmclW4t9
 gHXg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpEQ2I7Ow5ObArPHS4l+Nz1WL92SADhtS0TymJuvOpdhkErlhDXQOCkYvBQUzna8lQZARiR8QbofmTT@nongnu.org
X-Gm-Message-State: AOJu0YwpMjivk0cvc5LqbGsaBVIvx9k297KD9tM6RAZoSKairtsuJFtf
 jZyRwucrFuz6Jy/3SUMPWbO8+o7+3LZVb0RQnNnapU/1iJiWf5ffHLvW+5ruS63fh/lXFA7YHp6
 oyH2Z6w8fFdNXXDFlq4sOUyA43Zrn3CFeJGM4WbNzzw==
X-Gm-Gg: AfdE7cnmQBTxMWEK4DM6aJHDIGDmbzYJvzBzwj/ZiZL5UptAwxvfeDntCcY1fT2l6A2
 5eFJvmqpLK03GRt0DwX3NwbUmCwcsiBewXXK7vMg6xDHwY6bjoGmbl3vRB4HIcYQ0QcEQqxCSC/
 tfIUh7WYtzGQznbri1kYq3+hDpbzq9OoWRE6oF5SgHf9vsynfnFe7OCanYjNp8tXpy4c9iNx/Jc
 lxckpViilfXbSFRRLEieIBxMc3YID8jGI5wHxQAD/ggmSy/uCty9KHGuHTm5pV4PqMRFdOhvF1s
 8dU/yJSwDNk/o0v6/MTYUZ0/SighQQ4TB8LGQ/JuwnGprTLRt6RwiDEn
X-Received: by 2002:a05:690e:1c09:b0:662:e7e4:fe6f with SMTP id
 956f58d0204a3-66487e682edmr2718511d50.21.1782412841502; Thu, 25 Jun 2026
 11:40:41 -0700 (PDT)
MIME-Version: 1.0
References: <20260616052552.389021-1-gshan@redhat.com>
 <20260616052552.389021-2-gshan@redhat.com>
 <CAFEAcA-mf14=jpRFHarAbN6AbQwvW=Yu6WB1JiNMsECEdaxD3A@mail.gmail.com>
 <20260625070551-mutt-send-email-mst@kernel.org>
 <CAFEAcA8YJZq9TqrUd0zTnewAdVDm5y6UV7BJQZ0C60TZ=RT98Q@mail.gmail.com>
 <20260625091334-mutt-send-email-mst@kernel.org>
 <CAFEAcA8xK+t3-prEphtkq-o9UY2mgS6cowhs880GOaxL9dKSGw@mail.gmail.com>
 <20260625101817-mutt-send-email-mst@kernel.org>
 <CAFEAcA8-Un+Q1yBDqLWCLPRwtgTA_VhJqGobgZChrFhAeVfG8A@mail.gmail.com>
 <20260625123119-mutt-send-email-mst@kernel.org>
In-Reply-To: <20260625123119-mutt-send-email-mst@kernel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 25 Jun 2026 19:40:29 +0100
X-Gm-Features: AVVi8CcIN6O95iU7xBQuCQgAwOgN2fhwHOqWingqGxZG58bh6oBQyKNS2oH6J-4
Message-ID: <CAFEAcA8UjtXgmPC27fOKMwbaWs2piwGYudtwCNWQHuu3E_7A-A@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] system/memory: Use qemu_ram_{copy, move}() in ram
 device region accessors
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Gavin Shan <gshan@redhat.com>, qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 peterx@redhat.com, alex@shazbot.org, richard.henderson@linaro.org, 
 berrange@redhat.com, philmd@oss.qualcomm.com, philmd@mailo.com, 
 david@kernel.org, clg@redhat.com, pbonzini@redhat.com, phrdina@redhat.com, 
 jugraham@redhat.com, liugang24219@sangfor.com.cn, dinghui@sangfor.com.cn, 
 shan.gavin@gmail.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12a.google.com
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

On Thu, 25 Jun 2026 at 17:47, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Thu, Jun 25, 2026 at 04:23:47PM +0100, Peter Maydell wrote:
> > On Thu, 25 Jun 2026 at 15:52, Michael S. Tsirkin <mst@redhat.com> wrote:
> > > I think there is exactly 1 kinda reasonable case. A 2 byte read/write at
> > > offset 0x1 within a dword. This maps nicely to even classical PCI byte
> > > enable mechanism and so yes it works if your CPU can initiate these
> > > things, and it's atomic.
> > >
> > > I tried reading LEDCTL on e1000e:
> > >
> > >        byte  @ 0xe00: 0x64
> > >        byte  @ 0xe01: 0x2a
> > >        byte  @ 0xe02: 0x00
> > >        byte  @ 0xe03: 0x00
> > >        word  @ 0xe00: 0x2a64
> > >        word  @ 0xe01: 0x002a
> > >
> > > Works fine.
> >
> > The e1000e datasheet actually documents what it does in this
> > case (slightly surprising, since hardware engineers love to
> > leave this kind of corner case undocumented):
> >
> > # For registers that should be accessed as 32-bit double words,
> > # partial writes (less than a 32-bit double word) does not take
> > # effect (such as, the write is ignored).
> > # Partial reads
> > # return all 32 bits of data regardless of the byte enables.
> > #
> > # Note: Partial reads to clear-by-read registers (such as, ICR)
> > # can have unexpected results since all 32 bits are actually read
> > # regardless of the byte enables. Partial reads should not be done.
> >
> > So for this specific device that access is out-of-spec.
>
> You mean that access to clear by read should not be done, right?

The datasheet is ambiguous about whether "Partial reads should
not be done" is meant to apply generally or only to clear-by-read
registers.

> > I guess what I'm wondering is: can we just have code
> > that does an aligned exact-width access in the 1/2/4/8
> > byte aligned case, and the host's best approximation to
> > an unaligned exact-width access for the 2/4/8 byte
> > unaligned case?
>
> That's my idea, too.
>
> > (so on sparc you get multiple smaller
> > accesses, and on most archs including x86 and arm you
> > get an unaligned load).
>
> I thought unaligned load from uncacheable on arm is
> also a fault?

For Arm the distinction is not cacheable/uncacheable
but Normal vs Device. (Device is essentially for things
which are not RAM; Normal is for RAM and RAM-like things,
and includes all of Normal Non-cacheable, Normal WT-Cacheable
and Normal WB-Cacheable.) Things mapped as Normal memory
don't generate unaligned faults (unless the guest turned them
on deliberately). For Device memory, it is IMPLEMENTATION
DEFINED whether you get an alignment fault or not if you
map something as Device that could have handled unaligned
accesses if you had mapped it as Normal.

> > That would mean the guest could
> > potentially provoke a fault on the load/store on an
> > access to a passthrough device, but if you give the
> > guest passthrough access it can very likely provoke
> > a fault anyway, depending on exactly what the device is.
> >
> > I think the most likely reason for an unaligned access
> > in this codepath is "it's actually RAM, either really
> > host RAM or else something memory-like in a BAR", and
> > either way if the guest does a 4-byte unaligned access
> > then doing a 4-byte unaligned access seems better than
> > second-guessing it, even on non-x86.

> Right though remember: whether it's RAM doesn't matter. What matters is
> how we map it.  qemu might fault because it maps NC but guest maps
> cacheable and it's ok.

If QEMU and the guest disagree about the memory attributes
on Arm then we have already lost, because the architecture
says that memory attribute mismatches result in a variety of
undesirable effects including things like loss of cache coherency
(i.e. read and writes via QEMU's NC mapping disagree with ones
via the guest's cacheable mapping because the latter are hitting
in the cache and the former are bypassing it).

> But, all this in theory. At a high level, I personally think going with
> what you propose as a 1st approximation is entirely reasonable, except
> for one thing: we really should not crash qemu, since access can be from
> guest userspace.

You can't prevent faults entirely, though -- if the device
being mapped has e.g. behaviour that says "unaligned accesses
will fault" and then the x86 guest does an unaligned access,
then the device will trigger a fault, and the fault is what
you want because it's what the guest would see on real h/w.
Unfortunately we don't have a convenient way to feed the
fault back to the guest. At some level if you pass through
host hardware you're relying on the guest to not do totally
stupid things.

thanks
-- PMM

