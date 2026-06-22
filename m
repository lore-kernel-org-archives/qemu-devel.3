Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BDB8CDB466
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 20:01:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbkot-0008Md-Ht; Mon, 22 Jun 2026 16:00:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1wbkog-0008MD-4U
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 16:00:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1wbkoe-0000Ar-D6
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 16:00:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782158419;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aAS3SRJgEsG/sXLm+WPk6enBbGWkMZFXlLvUcIRtis8=;
 b=A81kJq4lpCCtXHDxAUCwW6a+BN0GFe2RdkLynfxxZwrJGgnTQF6wcu6RapCcWYe0ej2YAC
 oNTHjlxNXGZEZg/N8K0anAI1L/ejsSsS4SQoW3YhhuNZpJAJ0Uh6AfxDajSSvYn/mNiNgL
 8b795KPdeuIqLVZ07NBl66Q5lIn3kFU=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-47-jvKD_YpzOdm1VdxguxzmGg-1; Mon, 22 Jun 2026 16:00:17 -0400
X-MC-Unique: jvKD_YpzOdm1VdxguxzmGg-1
X-Mimecast-MFC-AGG-ID: jvKD_YpzOdm1VdxguxzmGg_1782158416
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2c6a9bbcc53so49963235ad.2
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 13:00:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782158416; cv=none;
 d=google.com; s=arc-20240605;
 b=aT6K+qU9W2ag9Rltuvfn2NfOuy9JFuQ8B7yXAOrp8heg2pAJRkrOa8l6Jv/rgSl3Vg
 bUjbhUKRIy15RGzIr4olzdUmsDpncFvViaxIfibQ8c5Y0pFdiRH8bw2PAwAd4F621Y54
 uGWXqb9ONE8JlKoM2C4ETclqfFuTkdC/T4jRYv17OI168/OT/PzUp6Oyp4gjT+tN8QoF
 5DYxcQpMpSuUZudYuF8ZjcnDJ0+W8+CKPUDt4dVx6szkXLOkyqO4rok191HZoKXhXtNX
 hmP3TDXl6emAHQmrL/JmJxolgwCvq1e/lpMIk5IXYQ/mA+0th8NLTpxLoTKCeHt1AZF1
 dXlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=aAS3SRJgEsG/sXLm+WPk6enBbGWkMZFXlLvUcIRtis8=;
 fh=x4FnHbQ5/QO5F4gZumj5fxJuOQf86UdD4oCcpQQyQ04=;
 b=KP0vZt949XtUWVyFWZWA06i6/Kz87aC+rl3PILo0hgFSkgUDoj1bPGulRZEDZ/Ibkr
 Ac8vIWxxdlMyIr5k2bM0WJjMQnm9xZf1bSTKOU1GxTPaUs8l6BkqpOl0Y/FnC/V69pnd
 OtnBUNqRM9GlrBWiFbqRu9lHJx2LFEX748MGiEEBmGYVhBMdUJXNIegjk5gxZC3+Aiss
 b2WR4SNu5BN33Pkaxe2LZa9tlG7E/mOzuG0JVzFoHspEYpp4iJdSFFTpT4UB3Dwnx6N1
 etdxLZrq5Wb6ZYYTazYjG4ncotzL+jjaQYA1vUEOcmez6w3sPyvWoPX6pzTc00tNX1po
 iQvg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782158416; x=1782763216; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aAS3SRJgEsG/sXLm+WPk6enBbGWkMZFXlLvUcIRtis8=;
 b=TgROXrC3ETNxB0M+AyuRwtXUA3C5jh2FfM7EEYgTUGd1SOlSDuAcOOzdh98L4Pe6nW
 anOeOzMi8/tRQnvX8/Am9c3iTSh/JtExEYDcXZoKao4gcYpAF6lFXw4+n+3Mfb2Y8HAL
 O5/d/W1aFVsePfxu/i7By2J3dpLs+eDDbva+kb3bLhFEE6ERFARehjW3AuwCsuLNoyFc
 juiMEMAfHUdmgefZkIMVRjp8yXmDnewwtAWpj9ZHR8sHGrL+Zg5jBuTRxwegwoTlybNS
 59vLyDCxSItz49nR65546lxBn5dW5uXGdkyIEnniE0/stA48V16c2uWUxh5yWwfx6/DR
 3g3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782158416; x=1782763216;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=aAS3SRJgEsG/sXLm+WPk6enBbGWkMZFXlLvUcIRtis8=;
 b=GdQ7niNl+GLx09JSufkKWQoT4w3J0h3QcOpWknNqgLtZ3NanMBRfBqSiOTAVd1NHvw
 wMxoDyAWng4j0xcPWzbpJmnqvkCjI3vu53ZtswEobVzCDplnfb98obWZCOUGMe2yR1XW
 F0iLDS0xe7Apgge27B9LmeW0XBLu+XGMOxqJdaypt/zM4np9xxzApD1chAC0F4cG2CMh
 VO12ifcJbgaU+oy1jm09BIykERfTFDixzFWx/rF7WLg6OPQOdGkp+TFF74gx8CwoRlCd
 Xgq6QxMH/adYzgd9do5ABI1VqkYMOAMEo/kLopcNH7URtMz/Xx4cnhbFNacJfDAMbkjT
 Q3eA==
X-Gm-Message-State: AOJu0YweM0F36TvM7xL+XMouqvgFvkO9C+XR5shCV6/IpMXccJG3rGg8
 nF51a167rwwqc+cuJVPuX2bW1DGMcJLbz4O1oVm4RTg4qY/vZdYVWiNnwmUsh5f4w3LC6kGUFH4
 i2UzRenAy7ApOH5LIL22gjUGfYTO4pw0yW1bGocNaHClOkG62ltvb+qz2ZAviMkrDaZZDZ10cGC
 jLpaPmrNMZJp/S7u9SeyyoMxSeSIMaRIE=
X-Gm-Gg: AfdE7ckfd9BmXbR9mDpm6bH+rcT2MpbLWDYnkm6cOutVJ55WnjpQCwJMF1f4yYLb/hW
 m1QX9GIZK3LLl9WilLVDwh+Urn1YmzHMF6HfYmF2dIEVk/xFfqwjlEtM04p25D4Gk8dpmfetTke
 xoAx73e90QSTJkbV0Jm0iBQWXrSRTA0OMaQe0v8TmZKxoQJZwnQj/KS/Pc9d/H1TjnMD6BjspZq
 UtnEESo2Ea7UC7jNWLyvzrlWGtrf+0EEVOjI328vk/6YVoBAMcXFH9j/qtW+C+ZW2SG5B73jq4g
 0fPanWGwwHW1
X-Received: by 2002:a17:902:d489:b0:2be:22cc:e227 with SMTP id
 d9443c01a7336-2c718c87b90mr172936525ad.4.1782158416336; 
 Mon, 22 Jun 2026 13:00:16 -0700 (PDT)
X-Received: by 2002:a17:902:d489:b0:2be:22cc:e227 with SMTP id
 d9443c01a7336-2c718c87b90mr172936045ad.4.1782158415799; Mon, 22 Jun 2026
 13:00:15 -0700 (PDT)
MIME-Version: 1.0
References: <20260604-rdm5-v5-0-5768e6a0943d@redhat.com>
 <CAJ+F1CKRvSWDOvKC98e_7uyjgJMuXfhOHP83H0s7a=+ZrYxA1g@mail.gmail.com>
 <ajVco512NDPKDPTr@x1.local>
 <CAMxuvazRnZw4PEsdKCEBD8X1ua5LMj5K-k+-oh-J_uvXm5vT1w@mail.gmail.com>
 <ajmMzMAXay65Sl7U@x1.local>
In-Reply-To: <ajmMzMAXay65Sl7U@x1.local>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Tue, 23 Jun 2026 00:00:04 +0400
X-Gm-Features: AVVi8CcALnaUygDfXipA9K5Q53AEsopz0M20qNoO-DAXE4d6r2kmvEKjyvCr0e4
Message-ID: <CAMxuvawvb-oueGsgXQsPzAtB8_ArAM+SOtpacrvOGq=4d1F2Bg@mail.gmail.com>
Subject: Re: [PATCH v5 00/12] Make RamDiscardManager work with multiple
 sources & virtio-mem
To: Peter Xu <peterx@redhat.com>, Zhenzhong Duan <zhenzhong.duan@intel.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 David Hildenbrand <david@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>, 
 qemu-rust@nongnu.org, Alex Williamson <alex@shazbot.org>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 Fabiano Rosas <farosas@suse.de>, 
 Mark Kanda <mark.kanda@oracle.com>, Ben Chaney <bchaney@akamai.com>, 
 Marcelo Tosatti <mtosatti@redhat.com>, kvm@vger.kernel.org, 
 "Dr. David Alan Gilbert" <dave@treblig.org>, Zhao Liu <zhao1.liu@intel.com>,
 Eric Blake <eblake@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, Xiaoyao Li <xiaoyao.li@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Peter

On Mon, Jun 22, 2026 at 11:28=E2=80=AFPM Peter Xu <peterx@redhat.com> wrote=
:
>
> On Mon, Jun 22, 2026 at 03:53:33PM +0400, Marc-Andr=C3=A9 Lureau wrote:
> > Hi Peter
> >
> > On Fri, Jun 19, 2026 at 7:13=E2=80=AFPM Peter Xu <peterx@redhat.com> wr=
ote:
> > >
> > > On Fri, Jun 19, 2026 at 12:11:48AM +0400, Marc-Andr=C3=A9 Lureau wrot=
e:
> > > > Hi
> > > >
> > > > On Thu, Jun 4, 2026 at 5:46=E2=80=AFPM Marc-Andr=C3=A9 Lureau
> > > > <marcandre.lureau@redhat.com> wrote:
> > > > >
> > > > > Hi,
> > > > >
> > > > > This is an attempt to fix the incompatibility of virtio-mem with =
confidential
> > > > > VMs. The solution implements what was discussed earlier with D. H=
ildenbrand:
> > > > > https://patchwork.ozlabs.org/project/qemu-devel/patch/20250407074=
939.18657-5-chenyi.qiang@intel.com/#3502238
> > > > >
> > > > > The first patches are misc cleanups. Then some code refactoring t=
o have split a
> > > > > manager/source. And finally, the manager learns to deal with mult=
iple sources.
> > > > >
> > > > > This has been tested together with the Linux kernel series from
> > > > > Zhenzhong Duan [1] for TDX guests.
> > > > >
> > > > > (help fix https://issues.redhat.com/browse/RHEL-131968)
> > > >
> > > > Can the patch 1-11 be queued or are we missing something?
> > > > (RFC patch 12 can be dropped for now)
> > >
> > > Likely yes.. one thing to double check with you before I do: We don't=
 need
> > > the kernel series, do we?  Since when unplug, I expect with the trunc=
ation
> > > approach that this series proposed, KVM will emit TDH.MEM.PAGE.REMOVE=
 then
> > > unaccept is done (?).
> >
> > > Say, what happens if we run QEMU with this series applied, but withou=
t the
> > > kernel series?
> >
> > The kernel series is needed at least for PAGE.ACCEPT. Without it, QEMU
> > will have KVM_RUN return EIO, and finish into assert (while tearing
> > down ioeventfd).
>
> Could you elaborate a bit more on why ACCEPT would fail?
>
> I used to ask the event flow here:
>
> https://lore.kernel.org/qemu-devel/agTjb3M8ElUAlfp1@x1.local/
>
> If AUG existed, then why ACCEPT would fail?
>
> PS: I didn't read a lot of what a Linux guest would do; I know there're
> some lazy accept approach, but IIUC it's only a matter of time to ACCEPT,
> not correctness.  My understanding is if we properly notify these new slo=
ts
> with AUG, then it should be able to ACCEPT?

Yes, it will, but it needs the kernel patches to do it (or virtio-mem
will let the guest access un-accepted pages and qemu will crash). I
submitted a few proposals before Zhenzhong Duan proposed the last
iteration.

> >
> > > What confused me a bit is the dependency of this series v.s. the kern=
el
> > > one.  It seems to use different approaches, but then I don't understa=
nd why
> > > this series was tested with the kernel change.
> >
> > My understanding is that the kernel may perform TDG.MEM.PAGE.RELEASE.
> > That depends on TDX config TDCS_CONFIG_PAGE_RELEASE which qemu/kvm
> > doesnt currently control. I don't know whether this is then
> > redundant/needless with qemu doing discard on the guest_memfd..
>
> The problem is if this series depends on the kernel series, should we the=
n
> wait for the kernel solution be accepted first in case it'll change?

I don't think qemu needs to wait for the kernel to be fixed.
Furthermore, this series is not tdx/sev/etc specific

>
> But obviously I still don't yet fully understand how this whole thing
> works.. :(

I am also slow, because I don't focus on this most of the time.
Someone with more experience and dedication would handle it better.


