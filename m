Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F980C25B7C
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2024 18:17:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sD6o2-0005jY-9a; Fri, 31 May 2024 14:16:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmamfmgm@gmail.com>)
 id 1sD6nz-0005ix-Uy
 for qemu-devel@nongnu.org; Fri, 31 May 2024 14:16:44 -0400
Received: from mail-ot1-x32f.google.com ([2607:f8b0:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dmamfmgm@gmail.com>)
 id 1sD6nw-0004PN-DZ
 for qemu-devel@nongnu.org; Fri, 31 May 2024 14:16:43 -0400
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-6f8e9522bfaso1191427a34.0
 for <qemu-devel@nongnu.org>; Fri, 31 May 2024 11:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717179399; x=1717784199; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=43vda0f84hHFmHK/GkdrNA5j7hZLBg5aTJtysWCOO+U=;
 b=UZ08dh6ZGxq5oR5Rky7hLmuMe6eg0m3sRayKFZCPaexGfO3vU4b6s9blzAcnwhGBuM
 2DtNlg9amlNS9lBgYu7AewGNL2lg33/639XjRch/cZhAmlDpI5hOAZurXYkro1bB6ZoU
 g2jYub5RNfTvGx4eF3NcXZjgAw/+xelqBKSViIWnCsAjlxgs7DYzsewO1+leNI+zJywu
 IGIYkJQnaOcruagiv+CvKMtPo2pyzQ2TKyuoivr8Bw+R7D3sbWcK/0BgaaEmoqN+/qo4
 JngEAn64t/f5g5N85XfU7Usi2SCBRzPLITUaphw36UBBG/G2FukPcevjH8ock5WgXB5s
 5qvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717179399; x=1717784199;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=43vda0f84hHFmHK/GkdrNA5j7hZLBg5aTJtysWCOO+U=;
 b=TafCNpTWt4Iwf5Xsr3wM7chb53uYGLEbWNdal9B+S+1k4nZxgNPTFjLNPoktsyHKOM
 0lnaqwlP+wsDqrjD/gXoz9Lz8DIOlQVD55c97jfWlX9T2l2xhU+H0WJkg7GjDVVhoJjs
 0Q/UV99rAfSpMxC/utwXt9ihm7SJoa4Y9N+lgKJLPvz6qT2cZx4wvQ8Ay80d2vrh8ZnO
 4UCC7cubvjVNC3ezDnKyknTJgbnspKA2xSle9dXk6TF6dRHPKx1b0lVy0PM/WuDcK5fj
 9YfVtt1oB51Yz/Dq1znjFffsYWfGH0wQrEw8MhfJtqeDf44Xtmnn6FaGoDIYzuiWx5iA
 2SZg==
X-Gm-Message-State: AOJu0YztqGqtausUbL1erk/x2qefd5hJukl1BjOxFQlIvwxFvvLzTVjx
 mYSnSy0hx4xUc9pv5VXhuq9gOWzsdUmyZzCmks/pXvcyBTOiFkiMykb4NCgP/prnLVKa5KJ4xy1
 37oCGb5DOxf5CKK3pAmdeIfY4ICE=
X-Google-Smtp-Source: AGHT+IFZEg5FPCw2COTj9uET5DlnCggWTTZ/8v/rJo1ZpswFj6PDyFZTa/WU+/yLgjKHpTGDKMfnPZbWWosO3i9dKF4=
X-Received: by 2002:a05:6830:2713:b0:6ed:7c7e:1bce with SMTP id
 46e09a7af769-6f911f26f70mr4181904a34.3.1717179398715; Fri, 31 May 2024
 11:16:38 -0700 (PDT)
MIME-Version: 1.0
References: <20240520232634.317988-1-dmamfmgm@gmail.com>
 <CAFEAcA8JFMid+SeHWuoaK9meVWwgch9wwzKmT4SFUXz4U_iacw@mail.gmail.com>
In-Reply-To: <CAFEAcA8JFMid+SeHWuoaK9meVWwgch9wwzKmT4SFUXz4U_iacw@mail.gmail.com>
From: Cord Amfmgm <dmamfmgm@gmail.com>
Date: Fri, 31 May 2024 13:16:27 -0500
Message-ID: <CACBuX0RaZyXZtmdSsF279UZnw_St8mgX_U284zZ+o0o4ziHypw@mail.gmail.com>
Subject: Re: [PATCH] hw/usb/hcd-ohci: Fix ohci_service_td: accept valid TDs
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Philippe Mathieu-Daude <philmd@linaro.org>, 
 Michael Tokarev <mjt@tls.msk.ru>, Gerd Hoffmann <kraxel@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000137ea10619c3fc5d"
Received-SPF: pass client-ip=2607:f8b0:4864:20::32f;
 envelope-from=dmamfmgm@gmail.com; helo=mail-ot1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.006, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

--000000000000137ea10619c3fc5d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 31, 2024 at 9:03=E2=80=AFAM Peter Maydell <peter.maydell@linaro=
.org>
wrote:

> On Tue, 21 May 2024 at 00:26, David Hubbard <dmamfmgm@gmail.com> wrote:
> >
> > From: Cord Amfmgm <dmamfmgm@gmail.com>
> >
> > This changes the way the ohci emulation handles a Transfer Descriptor
> with
> > "Current Buffer Pointer" set to "Buffer End" + 1.
> >
> > The OHCI spec 4.3.1.2 Table 4-2 allows td.cbp to be one byte more than
> td.be
> > to signal the buffer has zero length. Currently qemu only accepts
> zero-length
> > Transfer Descriptors if the td.cbp is equal to 0, while actual OHCI
> hardware
> > accepts both cases.
> >
> > The qemu ohci emulation has a regression in ohci_service_td. Version 4.=
2
> > and earlier matched the spec. (I haven't taken the time to bisect exact=
ly
> > where the logic was changed.)
> >
> > With a tiny OS[1] that boots and executes a test, the issue can be seen=
:
> >
> > * OS that sends USB requests to a USB mass storage device
> >   but sends td.cbp =3D td.be + 1
> > * qemu 4.2
> > * qemu HEAD (4e66a0854)
> > * Actual OHCI controller (hardware)
> >
> > Command line:
> > qemu-system-x86_64 -m 20 \
> >  -device pci-ohci,id=3Dohci \
> >  -drive if=3Dnone,format=3Draw,id=3Dd,file=3Dtestmbr.raw \
> >  -device usb-storage,bus=3Dohci.0,drive=3Dd \
> >  --trace "usb_*" --trace "ohci_*" -D qemu.log
> >
> > Results are:
> >
> >  qemu 4.2   | qemu HEAD  | actual HW
> > ------------+------------+------------
> >  works fine | ohci_die() | works fine
> >
> > Tip: if the flags "-serial pty -serial stdio" are added to the command
> line
> > the test will output USB requests like this:
> >
> > Testing qemu HEAD:
> >
> > > Free mem 2M ohci port2 conn FS
> > > setup { 80 6 0 1 0 0 8 0 }
> > > ED info=3D80000 { mps=3D8 en=3D0 d=3D0 } tail=3Dc20920
> > >   td0 c20880 nxt=3Dc20960 f2000000 setup cbp=3Dc20900 be=3Dc20907
> > >   td1 c20960 nxt=3Dc20980 f3140000    in cbp=3Dc20908 be=3Dc2090f
> > >   td2 c20980 nxt=3Dc20920 f3080000   out cbp=3Dc20910 be=3Dc2090f ohc=
i20
> host err
> > > usb stopped
> >
> > And in qemu.log:
> >
> > usb_ohci_iso_td_bad_cc_overrun ISO_TD start_offset=3D0x00c20910 >
> next_offset=3D0x00c2090f
> >
> > Testing qemu 4.2:
> >
> > > Free mem 2M ohci port2 conn FS
> > > setup { 80 6 0 1 0 0 8 0 }
> > > ED info=3D80000 { mps=3D8 en=3D0 d=3D0 } tail=3D620920
> > >   td0 620880 nxt=3D620960 f2000000 setup cbp=3D620900 be=3D620907
>  cbp=3D0 be=3D620907
> > >   td1 620960 nxt=3D620980 f3140000    in cbp=3D620908 be=3D62090f
>  cbp=3D0 be=3D62090f
> > >   td2 620980 nxt=3D620920 f3080000   out cbp=3D620910 be=3D62090f
>  cbp=3D0 be=3D62090f
> > >    rx { 12 1 0 2 0 0 0 8 }
> > > setup { 0 5 1 0 0 0 0 0 } tx {}
> > > ED info=3D80000 { mps=3D8 en=3D0 d=3D0 } tail=3D620880
> > >   td0 620920 nxt=3D620960 f2000000 setup cbp=3D620900 be=3D620907
>  cbp=3D0 be=3D620907
> > >   td1 620960 nxt=3D620880 f3100000    in cbp=3D620908 be=3D620907
>  cbp=3D0 be=3D620907
> > > setup { 80 6 0 1 0 0 12 0 }
> > > ED info=3D80001 { mps=3D8 en=3D0 d=3D1 } tail=3D620960
> > >   td0 620880 nxt=3D6209c0 f2000000 setup cbp=3D620920 be=3D620927
>  cbp=3D0 be=3D620927
> > >   td1 6209c0 nxt=3D6209e0 f3140000    in cbp=3D620928 be=3D620939
>  cbp=3D0 be=3D620939
> > >   td2 6209e0 nxt=3D620960 f3080000   out cbp=3D62093a be=3D620939
>  cbp=3D0 be=3D620939
> > >    rx { 12 1 0 2 0 0 0 8 f4 46 1 0 0 0 1 2 3 1 }
> > > setup { 80 6 0 2 0 0 0 1 }
> > > ED info=3D80001 { mps=3D8 en=3D0 d=3D1 } tail=3D620880
> > >   td0 620960 nxt=3D6209a0 f2000000 setup cbp=3D620a20 be=3D620a27
>  cbp=3D0 be=3D620a27
> > >   td1 6209a0 nxt=3D6209c0 f3140004    in cbp=3D620a28 be=3D620b27
>  cbp=3D620a48 be=3D620b27
> > >   td2 6209c0 nxt=3D620880 f3080000   out cbp=3D620b28 be=3D620b27
>  cbp=3D0 be=3D620b27
> > >    rx { 9 2 20 0 1 1 4 c0 0 9 4 0 0 2 8 6 50 0 7 5 81 2 40 0 0 7 5 2 =
2
> 40 0 0 }
> > > setup { 0 9 1 0 0 0 0 0 } tx {}
> > > ED info=3D80001 { mps=3D8 en=3D0 d=3D1 } tail=3D620900
> > >   td0 620880 nxt=3D620940 f2000000 setup cbp=3D620a00 be=3D620a07
>  cbp=3D0 be=3D620a07
> > >   td1 620940 nxt=3D620900 f3100000    in cbp=3D620a08 be=3D620a07
>  cbp=3D0 be=3D620a07
> >
> > [1] The OS disk image has been emailed to philmd@linaro.org,
> mjt@tls.msk.ru,
> > and kraxel@redhat.com:
> >
> > * testCbpOffBy1.img.xz
> > * sha256:
> f87baddcb86de845de12f002c698670a426affb40946025cc32694f9daa3abed
> >
> > Signed-off-by: Cord Amfmgm <dmamfmgm@gmail.com>
> > ---
> >  hw/usb/hcd-ohci.c   | 4 ++--
> >  hw/usb/trace-events | 1 +
> >  2 files changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/hw/usb/hcd-ohci.c b/hw/usb/hcd-ohci.c
> > index acd6016980..71b54914d3 100644
> > --- a/hw/usb/hcd-ohci.c
> > +++ b/hw/usb/hcd-ohci.c
> > @@ -941,8 +941,8 @@ static int ohci_service_td(OHCIState *ohci, struct
> ohci_ed *ed)
> >          if ((td.cbp & 0xfffff000) !=3D (td.be & 0xfffff000)) {
> >              len =3D (td.be & 0xfff) + 0x1001 - (td.cbp & 0xfff);
> >          } else {
> > -            if (td.cbp > td.be) {
> > -                trace_usb_ohci_iso_td_bad_cc_overrun(td.cbp, td.be);
> > +            if (td.cbp - 1 > td.be) {  /* rely on td.cbp !=3D 0 */
> > +                trace_usb_ohci_td_bad_buf(td.cbp, td.be);
> >                  ohci_die(ohci);
> >                  return 1;
> >              }
>
> This patch seems to me to do what the commit message sets out to
> do, and it looks unlikely to have any unintended side effects
> because it turns a "USB controller flags an error" case into
> a "treat as zero length packet" case, and I have trouble
> imagining that any guest could be relying on looking for the
> controller error. On that basis I'm inclined to accept it.
>
> What I would like to see is what we could classify under
> "rationale", which is to say "what prompted us to make this
> change?". In my experience it's important to record this
> (including in the commit message). There are of course
> many cases in QEMU's git history where we failed to do that,
> but in general I think it's a good standard to meet. (I
> am also erring on the side of caution in reviewing this
> particular patch, because I don't know the relevant standards
> or this bit of the code very well.)
>
> Why do we care about the motivation for a patch?
>
> (1) In the present: it helps to raise confidence that the
> proposed new behaviour is right. This is good because QEMU's
> test suite is far from comprehensive, so in some sense any
> change to the codebase is a risk.
>
> For instance, if a change is being made because the QNX demo
> floppy doesn't run, then the fact that the change fixes that
> failure-to-run indicates that our interpretation of the
> meaning of the standard, or of what should happen in the
> grey areas that the documentation doesn't clearly describe,
> matches what the QNX driver author (an unrelated third party)
> thought and probably also what a lot of in-the-field hardware
> does (since QNX was no doubt tested on a lot of different PCs
> back in the day).
>
> On the other hand, if a change is proposed because it fixes
> booting with older Linux kernels prior to commit XYZ, and
> kernel commit XYZ turns out to be "make this device driver
> program the hardware according to the specification rather
> than relying on an accident of timing", then we might want
> to look at where we want to be in the tradeoff of "run older
> kernels" versus "put workaround for a guest software issue
> into QEMU". (Workarounds for guest software bugs are something
> I'm very reluctant to put into QEMU, because my experience
> is that once they're in the codebase we can essentially never
> remove them, because we don't know what guest code might
> be relying on them. But sometimes they're a necessary evil.)
>
> (2) In the future: if in a year's time or more, somebody
> reports that a particular commit has regressed some specific
> guest workload they have, knowing why we made the change in
> the first place is really useful in investigating the
> regression.
>
> If we need to change code that was initially added to solve
> a problem when running FreeBSD, we know we need to re-test
> with FreeBSD.
>
> If the change went in to fix a buffer overrun, we know we
> need to be careful and cross-check that we don't reintroduce
> the overrun in the course of fixing a regression.
>
> If a change is one that we made on the grounds of "reading
> the spec and the code, this looked like it was clearly wrong,
> but we don't have a definite repro case of it breaking a guest"
> then that might put "revert the change, we were mistaken" on
> the table as a response to a future regression report.
> And so on.
>
> thanks
> -- PMM
>

Thanks, in responding to that, I'm breaking down my responses into the
following answers:

Q1: (summarizing) What prompted us to make this change?

A1: I'm summarizing what I wrote in previous emails and the commit message =
-

* Bring qemu closer to actual hw with a neatly packaged test case to
demonstrate the behavior
* I interpret the spec (Table 4-2) as saying the "be =3D cbp - 1" is valid,
in addition to setting "cbp =3D 0"
* I interpret it that way due to a comment in an old linux kernel version
in the 2.x range, ohci-hcd.c file. It said (paraphrasing) some misbehaving
ohci controllers would fetch physical memory at 0 when cbp =3D 0 was in the
Transfer Descriptor

Q2: (summarizing) is the proposed new behaviour right?

A2: Like what Peter Maydell wrote, I believe this turns a "USB controller
flags an error" case into "USB controller treats it as a zero length
packet" case.

I came across this corner case as a result of that comment in an old 2.x
linux kernel. I am not an expert on computer history and old OSes that
might want this behavior.

Q3: (summarizing, take 1) if this patch is called up later and folks are
wondering if there are older OSes that need to be tested?

A3: I do not know of computer history and old OSes where this change is
needed.

qemu up until commit 1328fe0c32d54 ("hw: usb: hcd-ohci: check len and
frame_number variables") allowed this behavior, so it is possible that
older committers wanted "be =3D cbp - 1" to signify a zero length packet, o=
r
knew of some guest OS that relied on this behavior.

I think there is a non trivial chance some guest OS would rely on this
behavior because:

* using code like "be =3D cbp + len - 1" is *required* in every Transfer
Descriptor
* ohci Transfer Descriptors can be fragmented by the controller (e.g. if
the Info word sets Max Packet Size =3D 8)
* ohci Transfer Descriptors have physical memory 4K-page boundary
requirements
* ohci Transfer Descriptors for a zero-length packet are required to
complete certain USB1 transfers (such as the status transfer after an OUT,
or the empty packet during an IN)

in other words, there are just enough simultaneous requirements that a
guest OS might choose to lay out a string of Transfer Descriptors where the
guest OS uses this "be =3D cbp - 1" for a zero-length transfer.

But I only have a test case I created myself, and am not an expert on
computer history here. I think "be liberal in what you accept, by
conservative in what you send" applies when I don't know which historical
OSes, if any, need this behavior. I think the behavior of actual hardware
weighs more heavily since that *is* available and testable. Are there
additional checks that would expand on what's known about actual ohci hw?

Q3: (summarizing, take 2) if this patch is called up later and folks are
wondering whether it is correct?

A3: In my understanding of the discussion, this thread contains the most
significant discussion of the spec, the implementation and all the details.

In typical internet fashion, we're probably writing what future folks will
look at to answer that question.

In the future, actual hardware will become harder and harder to obtain.

It is not inconceivable that qemu will become the primary source of truth
for "what was ohci behavior?" to future folks.

In my understanding, behaving like actual hardware is a great way to
support the future folks looking for such info.

--000000000000137ea10619c3fc5d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Fri, May 31, 2024 at 9:03=E2=80=AF=
AM Peter Maydell &lt;<a href=3D"mailto:peter.maydell@linaro.org" target=3D"=
_blank">peter.maydell@linaro.org</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">On Tue, 21 May 2024 at 00:26, David Hubbar=
d &lt;<a href=3D"mailto:dmamfmgm@gmail.com" target=3D"_blank">dmamfmgm@gmai=
l.com</a>&gt; wrote:<br>
&gt;<br>
&gt; From: Cord Amfmgm &lt;<a href=3D"mailto:dmamfmgm@gmail.com" target=3D"=
_blank">dmamfmgm@gmail.com</a>&gt;<br>
&gt;<br>
&gt; This changes the way the ohci emulation handles a Transfer Descriptor =
with<br>
&gt; &quot;Current Buffer Pointer&quot; set to &quot;Buffer End&quot; + 1.<=
br>
&gt;<br>
&gt; The OHCI spec 4.3.1.2 Table 4-2 allows td.cbp to be one byte more than=
 <a href=3D"http://td.be" rel=3D"noreferrer" target=3D"_blank">td.be</a><br=
>
&gt; to signal the buffer has zero length. Currently qemu only accepts zero=
-length<br>
&gt; Transfer Descriptors if the td.cbp is equal to 0, while actual OHCI ha=
rdware<br>
&gt; accepts both cases.<br>
&gt;<br>
&gt; The qemu ohci emulation has a regression in ohci_service_td. Version 4=
.2<br>
&gt; and earlier matched the spec. (I haven&#39;t taken the time to bisect =
exactly<br>
&gt; where the logic was changed.)<br>
&gt;<br>
&gt; With a tiny OS[1] that boots and executes a test, the issue can be see=
n:<br>
&gt;<br>
&gt; * OS that sends USB requests to a USB mass storage device<br>
&gt;=C2=A0 =C2=A0but sends td.cbp =3D <a href=3D"http://td.be" rel=3D"noref=
errer" target=3D"_blank">td.be</a> + 1<br>
&gt; * qemu 4.2<br>
&gt; * qemu HEAD (4e66a0854)<br>
&gt; * Actual OHCI controller (hardware)<br>
&gt;<br>
&gt; Command line:<br>
&gt; qemu-system-x86_64 -m 20 \<br>
&gt;=C2=A0 -device pci-ohci,id=3Dohci \<br>
&gt;=C2=A0 -drive if=3Dnone,format=3Draw,id=3Dd,file=3Dtestmbr.raw \<br>
&gt;=C2=A0 -device usb-storage,bus=3Dohci.0,drive=3Dd \<br>
&gt;=C2=A0 --trace &quot;usb_*&quot; --trace &quot;ohci_*&quot; -D qemu.log=
<br>
&gt;<br>
&gt; Results are:<br>
&gt;<br>
&gt;=C2=A0 qemu 4.2=C2=A0 =C2=A0| qemu HEAD=C2=A0 | actual HW<br>
&gt; ------------+------------+------------<br>
&gt;=C2=A0 works fine | ohci_die() | works fine<br>
&gt;<br>
&gt; Tip: if the flags &quot;-serial pty -serial stdio&quot; are added to t=
he command line<br>
&gt; the test will output USB requests like this:<br>
&gt;<br>
&gt; Testing qemu HEAD:<br>
&gt;<br>
&gt; &gt; Free mem 2M ohci port2 conn FS<br>
&gt; &gt; setup { 80 6 0 1 0 0 8 0 }<br>
&gt; &gt; ED info=3D80000 { mps=3D8 en=3D0 d=3D0 } tail=3Dc20920<br>
&gt; &gt;=C2=A0 =C2=A0td0 c20880 nxt=3Dc20960 f2000000 setup cbp=3Dc20900 b=
e=3Dc20907<br>
&gt; &gt;=C2=A0 =C2=A0td1 c20960 nxt=3Dc20980 f3140000=C2=A0 =C2=A0 in cbp=
=3Dc20908 be=3Dc2090f<br>
&gt; &gt;=C2=A0 =C2=A0td2 c20980 nxt=3Dc20920 f3080000=C2=A0 =C2=A0out cbp=
=3Dc20910 be=3Dc2090f ohci20 host err<br>
&gt; &gt; usb stopped<br>
&gt;<br>
&gt; And in qemu.log:<br>
&gt;<br>
&gt; usb_ohci_iso_td_bad_cc_overrun ISO_TD start_offset=3D0x00c20910 &gt; n=
ext_offset=3D0x00c2090f<br>
&gt;<br>
&gt; Testing qemu 4.2:<br>
&gt;<br>
&gt; &gt; Free mem 2M ohci port2 conn FS<br>
&gt; &gt; setup { 80 6 0 1 0 0 8 0 }<br>
&gt; &gt; ED info=3D80000 { mps=3D8 en=3D0 d=3D0 } tail=3D620920<br>
&gt; &gt;=C2=A0 =C2=A0td0 620880 nxt=3D620960 f2000000 setup cbp=3D620900 b=
e=3D620907=C2=A0 =C2=A0 =C2=A0 =C2=A0cbp=3D0 be=3D620907<br>
&gt; &gt;=C2=A0 =C2=A0td1 620960 nxt=3D620980 f3140000=C2=A0 =C2=A0 in cbp=
=3D620908 be=3D62090f=C2=A0 =C2=A0 =C2=A0 =C2=A0cbp=3D0 be=3D62090f<br>
&gt; &gt;=C2=A0 =C2=A0td2 620980 nxt=3D620920 f3080000=C2=A0 =C2=A0out cbp=
=3D620910 be=3D62090f=C2=A0 =C2=A0 =C2=A0 =C2=A0cbp=3D0 be=3D62090f<br>
&gt; &gt;=C2=A0 =C2=A0 rx { 12 1 0 2 0 0 0 8 }<br>
&gt; &gt; setup { 0 5 1 0 0 0 0 0 } tx {}<br>
&gt; &gt; ED info=3D80000 { mps=3D8 en=3D0 d=3D0 } tail=3D620880<br>
&gt; &gt;=C2=A0 =C2=A0td0 620920 nxt=3D620960 f2000000 setup cbp=3D620900 b=
e=3D620907=C2=A0 =C2=A0 =C2=A0 =C2=A0cbp=3D0 be=3D620907<br>
&gt; &gt;=C2=A0 =C2=A0td1 620960 nxt=3D620880 f3100000=C2=A0 =C2=A0 in cbp=
=3D620908 be=3D620907=C2=A0 =C2=A0 =C2=A0 =C2=A0cbp=3D0 be=3D620907<br>
&gt; &gt; setup { 80 6 0 1 0 0 12 0 }<br>
&gt; &gt; ED info=3D80001 { mps=3D8 en=3D0 d=3D1 } tail=3D620960<br>
&gt; &gt;=C2=A0 =C2=A0td0 620880 nxt=3D6209c0 f2000000 setup cbp=3D620920 b=
e=3D620927=C2=A0 =C2=A0 =C2=A0 =C2=A0cbp=3D0 be=3D620927<br>
&gt; &gt;=C2=A0 =C2=A0td1 6209c0 nxt=3D6209e0 f3140000=C2=A0 =C2=A0 in cbp=
=3D620928 be=3D620939=C2=A0 =C2=A0 =C2=A0 =C2=A0cbp=3D0 be=3D620939<br>
&gt; &gt;=C2=A0 =C2=A0td2 6209e0 nxt=3D620960 f3080000=C2=A0 =C2=A0out cbp=
=3D62093a be=3D620939=C2=A0 =C2=A0 =C2=A0 =C2=A0cbp=3D0 be=3D620939<br>
&gt; &gt;=C2=A0 =C2=A0 rx { 12 1 0 2 0 0 0 8 f4 46 1 0 0 0 1 2 3 1 }<br>
&gt; &gt; setup { 80 6 0 2 0 0 0 1 }<br>
&gt; &gt; ED info=3D80001 { mps=3D8 en=3D0 d=3D1 } tail=3D620880<br>
&gt; &gt;=C2=A0 =C2=A0td0 620960 nxt=3D6209a0 f2000000 setup cbp=3D620a20 b=
e=3D620a27=C2=A0 =C2=A0 =C2=A0 =C2=A0cbp=3D0 be=3D620a27<br>
&gt; &gt;=C2=A0 =C2=A0td1 6209a0 nxt=3D6209c0 f3140004=C2=A0 =C2=A0 in cbp=
=3D620a28 be=3D620b27=C2=A0 =C2=A0 =C2=A0 =C2=A0cbp=3D620a48 be=3D620b27<br=
>
&gt; &gt;=C2=A0 =C2=A0td2 6209c0 nxt=3D620880 f3080000=C2=A0 =C2=A0out cbp=
=3D620b28 be=3D620b27=C2=A0 =C2=A0 =C2=A0 =C2=A0cbp=3D0 be=3D620b27<br>
&gt; &gt;=C2=A0 =C2=A0 rx { 9 2 20 0 1 1 4 c0 0 9 4 0 0 2 8 6 50 0 7 5 81 2=
 40 0 0 7 5 2 2 40 0 0 }<br>
&gt; &gt; setup { 0 9 1 0 0 0 0 0 } tx {}<br>
&gt; &gt; ED info=3D80001 { mps=3D8 en=3D0 d=3D1 } tail=3D620900<br>
&gt; &gt;=C2=A0 =C2=A0td0 620880 nxt=3D620940 f2000000 setup cbp=3D620a00 b=
e=3D620a07=C2=A0 =C2=A0 =C2=A0 =C2=A0cbp=3D0 be=3D620a07<br>
&gt; &gt;=C2=A0 =C2=A0td1 620940 nxt=3D620900 f3100000=C2=A0 =C2=A0 in cbp=
=3D620a08 be=3D620a07=C2=A0 =C2=A0 =C2=A0 =C2=A0cbp=3D0 be=3D620a07<br>
&gt;<br>
&gt; [1] The OS disk image has been emailed to <a href=3D"mailto:philmd@lin=
aro.org" target=3D"_blank">philmd@linaro.org</a>, <a href=3D"mailto:mjt@tls=
.msk.ru" target=3D"_blank">mjt@tls.msk.ru</a>,<br>
&gt; and <a href=3D"mailto:kraxel@redhat.com" target=3D"_blank">kraxel@redh=
at.com</a>:<br>
&gt;<br>
&gt; * testCbpOffBy1.img.xz<br>
&gt; * sha256: f87baddcb86de845de12f002c698670a426affb40946025cc32694f9daa3=
abed<br>
&gt;<br>
&gt; Signed-off-by: Cord Amfmgm &lt;<a href=3D"mailto:dmamfmgm@gmail.com" t=
arget=3D"_blank">dmamfmgm@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 hw/usb/hcd-ohci.c=C2=A0 =C2=A0| 4 ++--<br>
&gt;=C2=A0 hw/usb/trace-events | 1 +<br>
&gt;=C2=A0 2 files changed, 3 insertions(+), 2 deletions(-)<br>
&gt;<br>
&gt; diff --git a/hw/usb/hcd-ohci.c b/hw/usb/hcd-ohci.c<br>
&gt; index acd6016980..71b54914d3 100644<br>
&gt; --- a/hw/usb/hcd-ohci.c<br>
&gt; +++ b/hw/usb/hcd-ohci.c<br>
&gt; @@ -941,8 +941,8 @@ static int ohci_service_td(OHCIState *ohci, struct=
 ohci_ed *ed)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if ((td.cbp &amp; 0xfffff000) !=3D (=
<a href=3D"http://td.be" rel=3D"noreferrer" target=3D"_blank">td.be</a> &am=
p; 0xfffff000)) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 len =3D (<a href=3D"ht=
tp://td.be" rel=3D"noreferrer" target=3D"_blank">td.be</a> &amp; 0xfff) + 0=
x1001 - (td.cbp &amp; 0xfff);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (td.cbp &gt; <a href=3D"=
http://td.be" rel=3D"noreferrer" target=3D"_blank">td.be</a>) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 trace_usb_ohc=
i_iso_td_bad_cc_overrun(td.cbp, <a href=3D"http://td.be" rel=3D"noreferrer"=
 target=3D"_blank">td.be</a>);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (td.cbp - 1 &gt; <a href=
=3D"http://td.be" rel=3D"noreferrer" target=3D"_blank">td.be</a>) {=C2=A0 /=
* rely on td.cbp !=3D 0 */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 trace_usb_ohc=
i_td_bad_buf(td.cbp, <a href=3D"http://td.be" rel=3D"noreferrer" target=3D"=
_blank">td.be</a>);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ohci_die=
(ohci);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 1=
;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
This patch seems to me to do what the commit message sets out to<br>
do, and it looks unlikely to have any unintended side effects<br>
because it turns a &quot;USB controller flags an error&quot; case into<br>
a &quot;treat as zero length packet&quot; case, and I have trouble<br>
imagining that any guest could be relying on looking for the<br>
controller error. On that basis I&#39;m inclined to accept it.<br>
<br>
What I would like to see is what we could classify under<br>
&quot;rationale&quot;, which is to say &quot;what prompted us to make this<=
br>
change?&quot;. In my experience it&#39;s important to record this<br>
(including in the commit message). There are of course<br>
many cases in QEMU&#39;s git history where we failed to do that,<br>
but in general I think it&#39;s a good standard to meet. (I<br>
am also erring on the side of caution in reviewing this<br>
particular patch, because I don&#39;t know the relevant standards<br>
or this bit of the code very well.)<br>
<br>
Why do we care about the motivation for a patch?<br>
<br>
(1) In the present: it helps to raise confidence that the<br>
proposed new behaviour is right. This is good because QEMU&#39;s<br>
test suite is far from comprehensive, so in some sense any<br>
change to the codebase is a risk.<br>
<br>
For instance, if a change is being made because the QNX demo<br>
floppy doesn&#39;t run, then the fact that the change fixes that<br>
failure-to-run indicates that our interpretation of the<br>
meaning of the standard, or of what should happen in the<br>
grey areas that the documentation doesn&#39;t clearly describe,<br>
matches what the QNX driver author (an unrelated third party)<br>
thought and probably also what a lot of in-the-field hardware<br>
does (since QNX was no doubt tested on a lot of different PCs<br>
back in the day).<br>
<br>
On the other hand, if a change is proposed because it fixes<br>
booting with older Linux kernels prior to commit XYZ, and<br>
kernel commit XYZ turns out to be &quot;make this device driver<br>
program the hardware according to the specification rather<br>
than relying on an accident of timing&quot;, then we might want<br>
to look at where we want to be in the tradeoff of &quot;run older<br>
kernels&quot; versus &quot;put workaround for a guest software issue<br>
into QEMU&quot;. (Workarounds for guest software bugs are something<br>
I&#39;m very reluctant to put into QEMU, because my experience<br>
is that once they&#39;re in the codebase we can essentially never<br>
remove them, because we don&#39;t know what guest code might<br>
be relying on them. But sometimes they&#39;re a necessary evil.)<br>
<br>
(2) In the future: if in a year&#39;s time or more, somebody<br>
reports that a particular commit has regressed some specific<br>
guest workload they have, knowing why we made the change in<br>
the first place is really useful in investigating the<br>
regression.<br>
<br>
If we need to change code that was initially added to solve<br>
a problem when running FreeBSD, we know we need to re-test<br>
with FreeBSD.<br>
<br>
If the change went in to fix a buffer overrun, we know we<br>
need to be careful and cross-check that we don&#39;t reintroduce<br>
the overrun in the course of fixing a regression.<br>
<br>
If a change is one that we made on the grounds of &quot;reading<br>
the spec and the code, this looked like it was clearly wrong,<br>
but we don&#39;t have a definite repro case of it breaking a guest&quot;<br=
>
then that might put &quot;revert the change, we were mistaken&quot; on<br>
the table as a response to a future regression report.<br>
And so on.<br>
<br>
thanks<br>
-- PMM<br></blockquote><div><br></div><div>Thanks, in responding to that, I=
&#39;m breaking down my responses into the following answers:</div><div><br=
></div><div>Q1: (summarizing) What prompted us to make this change?</div><d=
iv><br></div><div>A1: I&#39;m summarizing what I wrote in previous emails a=
nd the commit message -</div><div><br></div><div>* Bring qemu closer to act=
ual hw with a neatly packaged test case to demonstrate the behavior</div><d=
iv>* I interpret the spec (Table 4-2) as saying the &quot;be =3D cbp - 1&qu=
ot; is valid, in addition to setting &quot;cbp =3D 0&quot;</div><div>* I in=
terpret it that way due to a comment in an old linux kernel version in the =
2.x range, ohci-hcd.c file. It said (paraphrasing) some misbehaving ohci co=
ntrollers would fetch physical memory at 0 when cbp =3D 0 was in the Transf=
er Descriptor</div><div><br></div><div>Q2: (summarizing) is the proposed ne=
w behaviour right?</div><div><br></div><div>A2: Like what Peter Maydell wro=
te, I believe this turns a &quot;USB controller flags an error&quot; case i=
nto &quot;USB controller treats it as a zero length packet&quot; case.</div=
><div><br></div><div>I came across this corner case as a result of that com=
ment in an old 2.x linux kernel. I am not an expert on computer history and=
 old OSes that might want this behavior.</div><div><br></div><div>Q3: (summ=
arizing, take 1) if this patch is called up later and folks are wondering=
=C2=A0if there are older OSes that need to be tested?</div><div><br></div><=
div>A3: I do not know of computer history and old OSes where this change is=
 needed.</div><div><br></div><div>qemu up until commit 1328fe0c32d54 (&quot=
;hw: usb: hcd-ohci: check len and frame_number variables&quot;) allowed thi=
s behavior, so it is possible that older committers wanted &quot;be =3D cbp=
 - 1&quot; to signify a zero length packet, or knew of some guest OS that r=
elied on this behavior.</div><div><br></div><div>I think there is a non tri=
vial chance some guest OS would rely on this behavior because:<br><br></div=
><div>* using code like &quot;be =3D cbp=C2=A0+ len - 1&quot; is *required*=
 in every Transfer Descriptor</div><div>* ohci Transfer Descriptors can be =
fragmented by the controller (e.g. if the Info word sets Max Packet Size =
=3D 8)</div><div>* ohci Transfer Descriptors have physical memory 4K-page b=
oundary requirements</div><div>* ohci Transfer Descriptors for a zero-lengt=
h packet are required to complete certain USB1 transfers (such as the statu=
s transfer after an OUT, or the empty packet during an IN)</div><div><br></=
div><div>in other words, there are just enough simultaneous requirements th=
at a guest OS might choose to lay out a string of Transfer Descriptors wher=
e the guest OS uses this &quot;be =3D cbp - 1&quot; for a zero-length trans=
fer.</div><div><br></div><div>But I only have a test case I created myself,=
 and am not an expert on computer history here. I think &quot;be liberal in=
 what you accept, by conservative in what you send&quot; applies when I don=
&#39;t know which historical OSes, if any, need this behavior. I think the =
behavior of actual hardware weighs more heavily since that *is* available a=
nd testable. Are there additional checks that would expand on what&#39;s kn=
own about actual ohci hw?</div><div><br></div><div>Q3: (summarizing, take 2=
) if this patch is called up later and folks are wondering whether it is co=
rrect?</div><div><br></div><div>A3: In my understanding of the discussion, =
this thread contains the most significant discussion of the spec, the imple=
mentation and all the details.</div><div><br></div><div>In typical internet=
 fashion, we&#39;re probably writing what future folks will look at to answ=
er that question.</div><div><br></div><div>In the future, actual hardware w=
ill become harder and harder to obtain.</div><div><br></div><div>It is not =
inconceivable that qemu will become the primary source of truth for &quot;w=
hat was ohci behavior?&quot; to future folks.</div><div><br></div><div>In m=
y understanding, behaving like actual hardware is a great way to support th=
e future folks looking for such info.</div></div></div>

--000000000000137ea10619c3fc5d--

