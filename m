Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BEFCC38150
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2024 06:27:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRQn3-0002JA-So; Wed, 10 Jul 2024 02:26:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1sRQmw-0002IY-3I
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 02:26:50 -0400
Received: from mail-oa1-x31.google.com ([2001:4860:4864:20::31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1sRQms-0000ft-J6
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 02:26:49 -0400
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-25e134abf00so2927215fac.1
 for <qemu-devel@nongnu.org>; Tue, 09 Jul 2024 23:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1720592804; x=1721197604;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qOBZRrVn+8LkDH1Zynl7yCXM2fTHcr/iOucOB9y9Bn8=;
 b=zK4iYaJ9drtvm6CjvbtywLh+UHbusNFqBko3npqcgAe19/GkHGSG995EclV3Hzsvy/
 bOzNMth66IPGKIOaCU2a8cM/MmAhTyhe0Fk8tRit6o7cY0dUeUnc82FvXALaQXgbIvGH
 iCowAzeQlDHkpKi2/MOrP2pQ2D3rEdBny8hFeqEaN8sa9wP8JG5Py04l58CzW+jb4tUu
 sT9qSfNcJF7KOLixEcBMn3F2t/SyPGAOIVpN9o/bUkUqjezQsSfe4SHviCI8nUPJe7EL
 tPHPSl7xFoOmInjknXQRWucGLpKWumo9WPs8rV4+lPTJXutsM0h+xR5hpOXdwS8nQO8d
 5bTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720592804; x=1721197604;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qOBZRrVn+8LkDH1Zynl7yCXM2fTHcr/iOucOB9y9Bn8=;
 b=WveK3ZiGsqeJuIBRNRQ2UcVa7YqOSldiy9c+d7s0Y8kLQOkDzUejjtgDy8F0r0rnqc
 Hg0z3/RSo+DyPEC+gS2pSpt0LB0vupOzR0nhkzfR2FzupbZg65A3nIjJs59srV/U3EGM
 mowpMfOhzcQ7YGjjbA6hXynCemNu4QrmS2sYPGieG74FONuhAQJxQL7L6TRISCl55sB8
 GVCdGE0HEEP6WDwsQmMLPXt5LmUf8w/XxIUVXDtikpdxBF1e0DcjqDx7WjG2XIUCE8Fo
 dj1avs4kVhj8zJqAQ4Rc1Y5NWHMq95+8y4fwmhfyrn7lFoX30LtAMRZhCmB4qNVoV3rr
 sPvQ==
X-Gm-Message-State: AOJu0YwM+BKyJ8RrWIr3uVG++UK1isca0nS5+mrgCbqcpVkdzvYQZIGk
 l5NLN7Q/DFVAIc811LP72BId37nKLoU3yuwL1hOGCA4PjfU5HOn0sQZqaZdKgVglPsJAdr/9SnG
 KSOz3k+szlp2pUsniDULPyX0xEfwDlrqSpfEQtg==
X-Google-Smtp-Source: AGHT+IHUq8mTGOUjHlpeLsxWLPN3zr7oIP7h0Q4P1O58UhnLnwf6+yLYdWDbV8jgUOXlYDVj1Zy0ZB3mgAYdSj+glk0=
X-Received: by 2002:a05:6871:73a2:b0:25e:e6d:5247 with SMTP id
 586e51a60fabf-25eae7b786dmr3961433fac.14.1720592802973; Tue, 09 Jul 2024
 23:26:42 -0700 (PDT)
MIME-Version: 1.0
References: <c7338afab65df208772f215567f323ae9b3c5910.1720210988.git.yong.huang@smartx.com>
 <CACGkMEuX+FxOtWD9YoMF-T_VsgMezCT5ff_5Wk5CwQ3kNu41Aw@mail.gmail.com>
 <CAK9dgmb0K_TfbUt-WsPubDVAA7tuJQkQtWaf95JOc0CYvgMQ8A@mail.gmail.com>
 <CACGkMEv23TZNexfKUJ8MMVeRz2+2g316UNAQvEK+91jo5PkpBw@mail.gmail.com>
 <CAK9dgmbqqD_LVWONdKm-Usj18cnxqbMo6VWpCAUqjS4VnTDxnw@mail.gmail.com>
 <CACGkMEt5bmg1eh8Tiurfzxb5a1GXECu_PmTQC5a_+sve2A2NUw@mail.gmail.com>
In-Reply-To: <CACGkMEt5bmg1eh8Tiurfzxb5a1GXECu_PmTQC5a_+sve2A2NUw@mail.gmail.com>
From: Yong Huang <yong.huang@smartx.com>
Date: Wed, 10 Jul 2024 14:26:26 +0800
Message-ID: <CAK9dgmaEs56fj4F_Bz+bBJNmoK4tXHd9WbmtHeeJj-Mu+kYtNQ@mail.gmail.com>
Subject: Re: [PATCH] e1000: Fix the unexpected assumption that the receive
 buffer is full
To: Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org, Dmitry Fleytman <dmitry.fleytman@gmail.com>, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
Content-Type: multipart/alternative; boundary="000000000000d324c4061cdebad3"
Received-SPF: pass client-ip=2001:4860:4864:20::31;
 envelope-from=yong.huang@smartx.com; helo=mail-oa1-x31.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--000000000000d324c4061cdebad3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 10, 2024 at 11:44=E2=80=AFAM Jason Wang <jasowang@redhat.com> w=
rote:

> On Tue, Jul 9, 2024 at 10:56=E2=80=AFAM Yong Huang <yong.huang@smartx.com=
> wrote:
> >
> >
> >
> > On Tue, Jul 9, 2024 at 10:41=E2=80=AFAM Jason Wang <jasowang@redhat.com=
> wrote:
> >>
> >> On Mon, Jul 8, 2024 at 1:17=E2=80=AFPM Yong Huang <yong.huang@smartx.c=
om>
> wrote:
> >> >
> >> >
> >> >
> >> > On Mon, Jul 8, 2024 at 11:21=E2=80=AFAM Jason Wang <jasowang@redhat.=
com>
> wrote:
> >> >>
> >> >> On Sat, Jul 6, 2024 at 4:30=E2=80=AFAM Hyman Huang <yong.huang@smar=
tx.com>
> wrote:
> >> >> >
> >> >> > Unexpected work by certain Windows guests equipped with the e1000
> >> >> > interface can cause the network to go down and never come back up
> >> >> > again unless the guest's interface is reset.
> >> >> >
> >> >> > To reproduce the failure:
> >> >> > 1. Set up two guests with a Windows 2016 or 2019 server operating
> >> >> >    system.
> >> >>
> >> >> I vaguely remember e1000 support for Windows has been deprecated fo=
r
> >> >> several years...
> >> >>
> >> >> That's why e1000e or igb is implemented in Qemu.
> >> >>
> >> >> > 2. Set up the e1000 interface for the guests.
> >> >> > 3. Pressurize the network slightly between two guests using the
> iPerf tool.
> >> >> >
> >> >> > The network goes down after a few days (2-5days), and the issue
> >> >> > is the result of not adhering to the e1000 specification. Refer
> >> >> > to the details of the specification at the following link:
> >> >> >
> https://www.intel.com/content/dam/doc/manual/pci-pci-x-family-gbe-control=
lers-software-dev-manual.pdf
> >> >> >
> >> >> > Chapter 3.2.6 describe the Receive Descriptor Tail register(RDT)
> >> >> > as following:
> >> >> > This register holds a value that is an offset from the base, and
> >> >> > identifies the location beyond the last descriptor hardware can
> >> >> > process. Note that tail should still point to an area in the
> >> >> > descriptor ring (somewhere between RDBA and RDBA + RDLEN).
> >> >> > This is because tail points to the location where software writes
> >> >> > the first new descriptor.
> >> >> >
> >> >> > This means that if the provider=E2=80=94in this case, QEMU=E2=80=
=94has not yet
> >> >> > loaded the packet,
> >> >>
> >> >> What do you mean by "load" here?
> >> >
> >> >
> >> > Sorry for failing to describe the details.
> >> >
> >> > The guest driver retrieves the packet from the receive ring buffer
> >> > after QEMU forwards it from the tun/tap interface in the e1000
> >> > emulation.
> >> >
> >> > I used "load" to express "putting packets into the receive ring
> buffer."
> >> >
> >> >>
> >> >>
> >> >> > RDT should never point to that place.
> >> >>
> >> >> And "that place"?
> >> >
> >> > If a descriptor in the receive ring buffer has not been filled with =
a
> >> > packet address by QEMU, the descriptor therefore doesn't have any
> >> > available packets. The location of the descriptor should not be
> referred
> >> > to by RDT because the location is in the range that "hardware"
> handles.
> >> >
> >> > "that place" means the location of the descriptor in the ring buffer
> >> > that QEMU hasn't set any available packets related to.
> >> >
> >> >>
> >> >>
> >> >> > When
> >> >> > implementing the emulation of the e1000 interface, QEMU evaluates
> >> >> > if the receive ring buffer is full once the RDT equals the RDH,
> >> >> > based on the assumption that guest drivers adhere to this
> >> >> > criterion strictly.
> >> >> >
> >> >> > We applied the following log patch to assist in analyzing the
> >> >> > issue and eventually obtained the unexpected information.
> >> >> >
> >> >> > Log patch:
> >> >> > -----------------------------------------------------------------
> >> >> > |--- a/hw/net/e1000.c
> >> >> > |+++ b/hw/net/e1000.c
> >> >> > |@@ -836,6 +836,9 @@ e1000_set_link_status(NetClientState *nc)
> >> >> > | static bool e1000_has_rxbufs(E1000State *s, size_t total_size)
> >> >> > | {
> >> >> > |     int bufs;
> >> >> > |+    DBGOUT(RX, "rxbuf_size =3D %u, s->mac_reg[RDLEN] =3D %u,
> s->mac_reg[RDH] =3D %u, s->mac_reg[RDT] =3D %u\n",
> >> >> > |+           s->rxbuf_size, s->mac_reg[RDLEN], s->mac_reg[RDH],
> s->mac_reg[RDT]);
> >> >> > |+
> >> >> > |     /* Fast-path short packets */
> >> >> > |     if (total_size <=3D s->rxbuf_size) {
> >> >> > |         if (s->mac_reg[RDH] =3D=3D s->mac_reg[RDT] &&
> s->last_overrun)
> >> >> > |@@ -1022,6 +1025,9 @@ e1000_receive_iov(NetClientState *nc, cons=
t
> struct iovec *iov, int iovcnt)
> >> >> > |         s->rxbuf_min_shift)
> >> >> > |         n |=3D E1000_ICS_RXDMT0;
> >> >> > |
> >> >> > |+    DBGOUT(RX, "rxbuf_size =3D %u, s->mac_reg[RDLEN] =3D %u,
> s->mac_reg[RDH] =3D %u, s->mac_reg[RDT] =3D %u\n",
> >> >> > |+           s->rxbuf_size, s->mac_reg[RDLEN], s->mac_reg[RDH],
> s->mac_reg[RDT]);
> >> >> > |+
> >> >> > -----------------------------------------------------------------
> >> >> >
> >> >> > The last few logs of information when the network is down:
> >> >> >
> >> >> > e1000: total_size =3D 1, rxbuf_size =3D 2048, s->mac_reg[RDLEN] =
=3D
> 16384, s->mac_reg[RDH] =3D 897, s->mac_reg[RDT] =3D 885
> >> >> > <- the receive ring buffer is checked for fullness in the
> >> >> > e1000_has_rxbufs function, not full.
> >> >> >
> >> >> > e1000: total_size =3D 64, rxbuf_size =3D 2048, s->mac_reg[RDLEN] =
=3D
> 16384, s->mac_reg[RDH] =3D 898, s->mac_reg[RDT] =3D 885
> >> >> > <- RDT stays the same, RDH updates to 898, and 1 descriptor
> >> >> > utilized after putting the packet to ring buffer.
> >> >> >
> >> >> > e1000: total_size =3D 1, rxbuf_size =3D 2048, s->mac_reg[RDLEN] =
=3D
> 16384, s->mac_reg[RDH] =3D 898, s->mac_reg[RDT] =3D 885
> >> >> > <- the receive ring buffer is checked for fullness in the
> >> >> > e1000_has_rxbufs function, not full.
> >> >> >
> >> >> > e1000: total_size =3D 64, rxbuf_size =3D 2048, s->mac_reg[RDLEN] =
=3D
> 16384, s->mac_reg[RDH] =3D 899, s->mac_reg[RDT] =3D 885
> >> >> > <- RDT stays the same, RDH updates to 899, and 1 descriptor
> >> >> > utilized after putting the packet to ring buffer.
> >> >> >
> >> >> > e1000: total_size =3D 1, rxbuf_size =3D 2048, s->mac_reg[RDLEN] =
=3D
> 16384, s->mac_reg[RDH] =3D 899, s->mac_reg[RDT] =3D 885
> >> >> > <- the receive ring buffer is checked for fullness in the
> >> >> > e1000_has_rxbufs function, not full.
> >> >> >
> >> >> > e1000: total_size =3D 64, rxbuf_size =3D 2048, s->mac_reg[RDLEN] =
=3D
> 16384, s->mac_reg[RDH] =3D 900, s->mac_reg[RDT] =3D 885
> >> >> > <- RDT stays the same, RDH updates to 900 , and 1 descriptor
> >> >> > utilized after putting the packet to ring buffer.
> >> >> >
> >> >> > e1000: total_size =3D 1, rxbuf_size =3D 2048, s->mac_reg[RDLEN] =
=3D
> 16384, s->mac_reg[RDH] =3D 900, s->mac_reg[RDT] =3D 900
> >> >> > <- The ring is full, according to e1000_has_rxbufs, because
> >> >> > of the RDT update to 900 and equals RDH !
> >> >>
> >> >> Just to make sure I understand this, RDT=3D=3DRDH means the ring is
> empty I think?
> >> >>
> >> >>
> >> >> See commit:
> >> >>
> >> >> commit e5b8b0d4ba29fe1268ba049519a1b0cf8552a21a
> >> >> Author: Dmitry Fleytman <dmitry@daynix.com>
> >> >> Date:   Fri Oct 19 07:56:55 2012 +0200
> >> >>
> >> >>     e1000: drop check_rxov, always treat RX ring with RDH =3D=3D RD=
T as
> empty
> >> >>
> >> >>     Real HW always treats RX ring with RDH =3D=3D RDT as empty.
> >> >>     Emulation is supposed to behave the same.
> >> >
> >> >
> >> > Indeed, I'm confused :(,  the description in the comment claims that
> RX
> >> > rings with RDH =3D=3D RDT as empty, but in implementation, it treats=
 that
> as
> >> > overrun.
> >> >
> >> > See the following 2 contexts:
> >> >
> >> > 1. e1000_can_receive:
> >> > static bool e1000_can_receive(NetClientState *nc)
> >> > {
> >> >     E1000State *s =3D qemu_get_nic_opaque(nc);
> >> >     // e1000_has_rxbufs return true means ring buffer has
> >> >     // available descriptors to use for QEMU.
> >> >     // false means ring buffer overrun and QEMU should queue the
> packet
> >> >     // and wait for the RDT update and available descriptors can be
> used.
> >> >
> >> >     return e1000x_rx_ready(&s->parent_obj, s->mac_reg) &&
> >> >         e1000_has_rxbufs(s, 1) &&
> !timer_pending(s->flush_queue_timer);
> >> > }
> >>
> >> Well we had in e1000_has_rx_bufs
> >>
> >>     if (total_size <=3D s->rxbuf_size) {
> >>         return s->mac_reg[RDH] !=3D s->mac_reg[RDT];
> >>     }
> >>
> >> RDT!=3DRDH means RX ring has available descriptors for hardware?
> >
> >
> > IMHO, Yes.
>
> Just to make sure we are on the same page, so
>
> RDT!=3DRDH, descriptors available for hardware
> RDT=3D=3DRDH, descriptor ring is empty for hardware


> That is currently what the code did. Seems nothing wrong, or anything
> I missed here?
>

There are two cases for RDT =3D=3D RDH.

1. Hardware has filled all available descriptors and overrun.
   In this case, hardware cannot add any new packets to the ring.

2. Software has consumed all descriptors, and all the descriptors
    on the ring can be used by hardware. (Let's name this case "empty.")
   In this case, hardware should keep putting new packets to the ring

But at the moment, the logic of e1000_has_rx_bufs acts exactly like it was
the first case, unable to differentiate between the two scenarios.


>
> Thanks
>
> >
> >>
> >> Adding more people.
> >>
> >> Thanks
> >>
> >
> >
> > --
> > Best regards
>
>
Yong

--=20
Best regards

--000000000000d324c4061cdebad3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-family:&quot;comic sans ms&quot;,sans-serif"><br></div></div><br><div cla=
ss=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Jul 10, 20=
24 at 11:44=E2=80=AFAM Jason Wang &lt;<a href=3D"mailto:jasowang@redhat.com=
">jasowang@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-st=
yle:solid;border-left-color:rgb(204,204,204);padding-left:1ex">On Tue, Jul =
9, 2024 at 10:56=E2=80=AFAM Yong Huang &lt;<a href=3D"mailto:yong.huang@sma=
rtx.com" target=3D"_blank">yong.huang@smartx.com</a>&gt; wrote:<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; On Tue, Jul 9, 2024 at 10:41=E2=80=AFAM Jason Wang &lt;<a href=3D"mail=
to:jasowang@redhat.com" target=3D"_blank">jasowang@redhat.com</a>&gt; wrote=
:<br>
&gt;&gt;<br>
&gt;&gt; On Mon, Jul 8, 2024 at 1:17=E2=80=AFPM Yong Huang &lt;<a href=3D"m=
ailto:yong.huang@smartx.com" target=3D"_blank">yong.huang@smartx.com</a>&gt=
; wrote:<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; On Mon, Jul 8, 2024 at 11:21=E2=80=AFAM Jason Wang &lt;<a hre=
f=3D"mailto:jasowang@redhat.com" target=3D"_blank">jasowang@redhat.com</a>&=
gt; wrote:<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; On Sat, Jul 6, 2024 at 4:30=E2=80=AFAM Hyman Huang &lt;<a=
 href=3D"mailto:yong.huang@smartx.com" target=3D"_blank">yong.huang@smartx.=
com</a>&gt; wrote:<br>
&gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt; Unexpected work by certain Windows guests equipped w=
ith the e1000<br>
&gt;&gt; &gt;&gt; &gt; interface can cause the network to go down and never=
 come back up<br>
&gt;&gt; &gt;&gt; &gt; again unless the guest&#39;s interface is reset.<br>
&gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt; To reproduce the failure:<br>
&gt;&gt; &gt;&gt; &gt; 1. Set up two guests with a Windows 2016 or 2019 ser=
ver operating<br>
&gt;&gt; &gt;&gt; &gt;=C2=A0 =C2=A0 system.<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; I vaguely remember e1000 support for Windows has been dep=
recated for<br>
&gt;&gt; &gt;&gt; several years...<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; That&#39;s why e1000e or igb is implemented in Qemu.<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; &gt; 2. Set up the e1000 interface for the guests.<br>
&gt;&gt; &gt;&gt; &gt; 3. Pressurize the network slightly between two guest=
s using the iPerf tool.<br>
&gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt; The network goes down after a few days (2-5days), an=
d the issue<br>
&gt;&gt; &gt;&gt; &gt; is the result of not adhering to the e1000 specifica=
tion. Refer<br>
&gt;&gt; &gt;&gt; &gt; to the details of the specification at the following=
 link:<br>
&gt;&gt; &gt;&gt; &gt; <a href=3D"https://www.intel.com/content/dam/doc/man=
ual/pci-pci-x-family-gbe-controllers-software-dev-manual.pdf" rel=3D"norefe=
rrer" target=3D"_blank">https://www.intel.com/content/dam/doc/manual/pci-pc=
i-x-family-gbe-controllers-software-dev-manual.pdf</a><br>
&gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt; Chapter 3.2.6 describe the Receive Descriptor Tail r=
egister(RDT)<br>
&gt;&gt; &gt;&gt; &gt; as following:<br>
&gt;&gt; &gt;&gt; &gt; This register holds a value that is an offset from t=
he base, and<br>
&gt;&gt; &gt;&gt; &gt; identifies the location beyond the last descriptor h=
ardware can<br>
&gt;&gt; &gt;&gt; &gt; process. Note that tail should still point to an are=
a in the<br>
&gt;&gt; &gt;&gt; &gt; descriptor ring (somewhere between RDBA and RDBA + R=
DLEN).<br>
&gt;&gt; &gt;&gt; &gt; This is because tail points to the location where so=
ftware writes<br>
&gt;&gt; &gt;&gt; &gt; the first new descriptor.<br>
&gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt; This means that if the provider=E2=80=94in this case=
, QEMU=E2=80=94has not yet<br>
&gt;&gt; &gt;&gt; &gt; loaded the packet,<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; What do you mean by &quot;load&quot; here?<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Sorry for failing to describe the details.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; The guest driver retrieves the packet from the receive ring b=
uffer<br>
&gt;&gt; &gt; after QEMU forwards it from the tun/tap interface in the e100=
0<br>
&gt;&gt; &gt; emulation.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; I used &quot;load&quot; to express &quot;putting packets into=
 the receive ring buffer.&quot;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; &gt; RDT should never point to that place.<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; And &quot;that place&quot;?<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; If a descriptor in the receive ring buffer has not been fille=
d with a<br>
&gt;&gt; &gt; packet address by QEMU, the descriptor therefore doesn&#39;t =
have any<br>
&gt;&gt; &gt; available packets. The location of the descriptor should not =
be referred<br>
&gt;&gt; &gt; to by RDT because the location is in the range that &quot;har=
dware&quot; handles.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; &quot;that place&quot; means the location of the descriptor i=
n the ring buffer<br>
&gt;&gt; &gt; that QEMU hasn&#39;t set any available packets related to.<br=
>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; &gt; When<br>
&gt;&gt; &gt;&gt; &gt; implementing the emulation of the e1000 interface, Q=
EMU evaluates<br>
&gt;&gt; &gt;&gt; &gt; if the receive ring buffer is full once the RDT equa=
ls the RDH,<br>
&gt;&gt; &gt;&gt; &gt; based on the assumption that guest drivers adhere to=
 this<br>
&gt;&gt; &gt;&gt; &gt; criterion strictly.<br>
&gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt; We applied the following log patch to assist in anal=
yzing the<br>
&gt;&gt; &gt;&gt; &gt; issue and eventually obtained the unexpected informa=
tion.<br>
&gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt; Log patch:<br>
&gt;&gt; &gt;&gt; &gt; ----------------------------------------------------=
-------------<br>
&gt;&gt; &gt;&gt; &gt; |--- a/hw/net/e1000.c<br>
&gt;&gt; &gt;&gt; &gt; |+++ b/hw/net/e1000.c<br>
&gt;&gt; &gt;&gt; &gt; |@@ -836,6 +836,9 @@ e1000_set_link_status(NetClient=
State *nc)<br>
&gt;&gt; &gt;&gt; &gt; | static bool e1000_has_rxbufs(E1000State *s, size_t=
 total_size)<br>
&gt;&gt; &gt;&gt; &gt; | {<br>
&gt;&gt; &gt;&gt; &gt; |=C2=A0 =C2=A0 =C2=A0int bufs;<br>
&gt;&gt; &gt;&gt; &gt; |+=C2=A0 =C2=A0 DBGOUT(RX, &quot;rxbuf_size =3D %u, =
s-&gt;mac_reg[RDLEN] =3D %u, s-&gt;mac_reg[RDH] =3D %u, s-&gt;mac_reg[RDT] =
=3D %u\n&quot;,<br>
&gt;&gt; &gt;&gt; &gt; |+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;rxb=
uf_size, s-&gt;mac_reg[RDLEN], s-&gt;mac_reg[RDH], s-&gt;mac_reg[RDT]);<br>
&gt;&gt; &gt;&gt; &gt; |+<br>
&gt;&gt; &gt;&gt; &gt; |=C2=A0 =C2=A0 =C2=A0/* Fast-path short packets */<b=
r>
&gt;&gt; &gt;&gt; &gt; |=C2=A0 =C2=A0 =C2=A0if (total_size &lt;=3D s-&gt;rx=
buf_size) {<br>
&gt;&gt; &gt;&gt; &gt; |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (s-&gt;mac_reg=
[RDH] =3D=3D s-&gt;mac_reg[RDT] &amp;&amp; s-&gt;last_overrun)<br>
&gt;&gt; &gt;&gt; &gt; |@@ -1022,6 +1025,9 @@ e1000_receive_iov(NetClientSt=
ate *nc, const struct iovec *iov, int iovcnt)<br>
&gt;&gt; &gt;&gt; &gt; |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;rxbuf_min_s=
hift)<br>
&gt;&gt; &gt;&gt; &gt; |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0n |=3D E1000_ICS_=
RXDMT0;<br>
&gt;&gt; &gt;&gt; &gt; |<br>
&gt;&gt; &gt;&gt; &gt; |+=C2=A0 =C2=A0 DBGOUT(RX, &quot;rxbuf_size =3D %u, =
s-&gt;mac_reg[RDLEN] =3D %u, s-&gt;mac_reg[RDH] =3D %u, s-&gt;mac_reg[RDT] =
=3D %u\n&quot;,<br>
&gt;&gt; &gt;&gt; &gt; |+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;rxb=
uf_size, s-&gt;mac_reg[RDLEN], s-&gt;mac_reg[RDH], s-&gt;mac_reg[RDT]);<br>
&gt;&gt; &gt;&gt; &gt; |+<br>
&gt;&gt; &gt;&gt; &gt; ----------------------------------------------------=
-------------<br>
&gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt; The last few logs of information when the network is=
 down:<br>
&gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt; e1000: total_size =3D 1, rxbuf_size =3D 2048, s-&gt;=
mac_reg[RDLEN] =3D 16384, s-&gt;mac_reg[RDH] =3D 897, s-&gt;mac_reg[RDT] =
=3D 885<br>
&gt;&gt; &gt;&gt; &gt; &lt;- the receive ring buffer is checked for fullnes=
s in the<br>
&gt;&gt; &gt;&gt; &gt; e1000_has_rxbufs function, not full.<br>
&gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt; e1000: total_size =3D 64, rxbuf_size =3D 2048, s-&gt=
;mac_reg[RDLEN] =3D 16384, s-&gt;mac_reg[RDH] =3D 898, s-&gt;mac_reg[RDT] =
=3D 885<br>
&gt;&gt; &gt;&gt; &gt; &lt;- RDT stays the same, RDH updates to 898, and 1 =
descriptor<br>
&gt;&gt; &gt;&gt; &gt; utilized after putting the packet to ring buffer.<br=
>
&gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt; e1000: total_size =3D 1, rxbuf_size =3D 2048, s-&gt;=
mac_reg[RDLEN] =3D 16384, s-&gt;mac_reg[RDH] =3D 898, s-&gt;mac_reg[RDT] =
=3D 885<br>
&gt;&gt; &gt;&gt; &gt; &lt;- the receive ring buffer is checked for fullnes=
s in the<br>
&gt;&gt; &gt;&gt; &gt; e1000_has_rxbufs function, not full.<br>
&gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt; e1000: total_size =3D 64, rxbuf_size =3D 2048, s-&gt=
;mac_reg[RDLEN] =3D 16384, s-&gt;mac_reg[RDH] =3D 899, s-&gt;mac_reg[RDT] =
=3D 885<br>
&gt;&gt; &gt;&gt; &gt; &lt;- RDT stays the same, RDH updates to 899, and 1 =
descriptor<br>
&gt;&gt; &gt;&gt; &gt; utilized after putting the packet to ring buffer.<br=
>
&gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt; e1000: total_size =3D 1, rxbuf_size =3D 2048, s-&gt;=
mac_reg[RDLEN] =3D 16384, s-&gt;mac_reg[RDH] =3D 899, s-&gt;mac_reg[RDT] =
=3D 885<br>
&gt;&gt; &gt;&gt; &gt; &lt;- the receive ring buffer is checked for fullnes=
s in the<br>
&gt;&gt; &gt;&gt; &gt; e1000_has_rxbufs function, not full.<br>
&gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt; e1000: total_size =3D 64, rxbuf_size =3D 2048, s-&gt=
;mac_reg[RDLEN] =3D 16384, s-&gt;mac_reg[RDH] =3D 900, s-&gt;mac_reg[RDT] =
=3D 885<br>
&gt;&gt; &gt;&gt; &gt; &lt;- RDT stays the same, RDH updates to 900 , and 1=
 descriptor<br>
&gt;&gt; &gt;&gt; &gt; utilized after putting the packet to ring buffer.<br=
>
&gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt; e1000: total_size =3D 1, rxbuf_size =3D 2048, s-&gt;=
mac_reg[RDLEN] =3D 16384, s-&gt;mac_reg[RDH] =3D 900, s-&gt;mac_reg[RDT] =
=3D 900<br>
&gt;&gt; &gt;&gt; &gt; &lt;- The ring is full, according to e1000_has_rxbuf=
s, because<br>
&gt;&gt; &gt;&gt; &gt; of the RDT update to 900 and equals RDH !<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; Just to make sure I understand this, RDT=3D=3DRDH means t=
he ring is empty I think?<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; See commit:<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; commit e5b8b0d4ba29fe1268ba049519a1b0cf8552a21a<br>
&gt;&gt; &gt;&gt; Author: Dmitry Fleytman &lt;<a href=3D"mailto:dmitry@dayn=
ix.com" target=3D"_blank">dmitry@daynix.com</a>&gt;<br>
&gt;&gt; &gt;&gt; Date:=C2=A0 =C2=A0Fri Oct 19 07:56:55 2012 +0200<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0e1000: drop check_rxov, always treat R=
X ring with RDH =3D=3D RDT as empty<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0Real HW always treats RX ring with RDH=
 =3D=3D RDT as empty.<br>
&gt;&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0Emulation is supposed to behave the sa=
me.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Indeed, I&#39;m confused :(,=C2=A0 the description in the com=
ment claims that RX<br>
&gt;&gt; &gt; rings with RDH =3D=3D RDT as empty, but in implementation, it=
 treats that as<br>
&gt;&gt; &gt; overrun.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; See the following 2 contexts:<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; 1. e1000_can_receive:<br>
&gt;&gt; &gt; static bool e1000_can_receive(NetClientState *nc)<br>
&gt;&gt; &gt; {<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0E1000State *s =3D qemu_get_nic_opaque(nc);=
<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0// e1000_has_rxbufs return true means ring=
 buffer has<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0// available descriptors to use for QEMU.<=
br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0// false means ring buffer overrun and QEM=
U should queue the packet<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0// and wait for the RDT update and availab=
le descriptors can be used.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0return e1000x_rx_ready(&amp;s-&gt;parent_o=
bj, s-&gt;mac_reg) &amp;&amp;<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0e1000_has_rxbufs(s, 1) &amp;=
&amp; !timer_pending(s-&gt;flush_queue_timer);<br>
&gt;&gt; &gt; }<br>
&gt;&gt;<br>
&gt;&gt; Well we had in e1000_has_rx_bufs<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0if (total_size &lt;=3D s-&gt;rxbuf_size) {<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return s-&gt;mac_reg[RDH] !=3D s-=
&gt;mac_reg[RDT];<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0}<br>
&gt;&gt;<br>
&gt;&gt; RDT!=3DRDH means RX ring has available descriptors for hardware?<b=
r>
&gt;<br>
&gt;<br>
&gt; IMHO, Yes.<br>
<br>
Just to make sure we are on the same page, so<br>
<br>
RDT!=3DRDH, descriptors available for hardware<br>
RDT=3D=3DRDH, descriptor ring is empty for hardware=C2=A0</blockquote><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-=
width:1px;border-left-style:solid;border-left-color:rgb(204,204,204);paddin=
g-left:1ex">
<br>
That is currently what the code did. Seems nothing wrong, or anything<br>
I missed here?<br></blockquote><div><div style=3D"font-family:&quot;comic s=
ans ms&quot;,sans-serif" class=3D"gmail_default"><br></div><div style=3D"fo=
nt-family:&quot;comic sans ms&quot;,sans-serif" class=3D"gmail_default">The=
re are two cases for RDT =3D=3D RDH.</div><div style=3D"font-family:&quot;c=
omic sans ms&quot;,sans-serif" class=3D"gmail_default"><br></div><div style=
=3D"font-family:&quot;comic sans ms&quot;,sans-serif" class=3D"gmail_defaul=
t">1. Hardware has filled all available descriptors and overrun.</div><div =
style=3D"font-family:&quot;comic sans ms&quot;,sans-serif" class=3D"gmail_d=
efault">=C2=A0 =C2=A0In this case, hardware cannot add any new packets to t=
he ring.=C2=A0</div><br></div><div><div style=3D"font-family:&quot;comic sa=
ns ms&quot;,sans-serif" class=3D"gmail_default">2. Software has consumed al=
l descriptors, and all the descriptors</div><div style=3D"font-family:&quot=
;comic sans ms&quot;,sans-serif" class=3D"gmail_default">=C2=A0 =C2=A0 on t=
he ring can be used by hardware. (Let&#39;s name this case &quot;empty.&quo=
t;)</div></div><font face=3D"comic sans ms, sans-serif"><div class=3D"gmail=
_quote"><span class=3D"gmail_default" style=3D"font-family:&quot;comic sans=
 ms&quot;,sans-serif"> =C2=A0 =C2=A0</span>In this case, hardware should ke=
ep putting new packets to the ring=C2=A0<br></div></font><div class=3D"gmai=
l_default"><font face=3D"comic sans ms, sans-serif">=C2=A0</font></div><div=
 class=3D"gmail_default"><font face=3D"comic sans ms, sans-serif">But at th=
e moment, the logic of e1000_has_rx_bufs acts exactly like it was</font></d=
iv><div class=3D"gmail_default"><font face=3D"comic sans ms, sans-serif">th=
e first case, unable to differentiate between the two scenarios.</font></di=
v><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0p=
x 0px 0.8ex;border-left-width:1px;border-left-style:solid;border-left-color=
:rgb(204,204,204);padding-left:1ex">
<br>
Thanks<br>
<br>
&gt;<br>
&gt;&gt;<br>
&gt;&gt; Adding more people.<br>
&gt;&gt;<br>
&gt;&gt; Thanks<br>
&gt;&gt;<br>
&gt;<br>
&gt;<br>
&gt; --<br>
&gt; Best regards<br>
<br>
</blockquote></div><br clear=3D"all"><div><div style=3D"font-family:&quot;c=
omic sans ms&quot;,sans-serif" class=3D"gmail_default">Yong</div></div><div=
><br></div><span class=3D"gmail_signature_prefix">-- </span><br><div dir=3D=
"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><font face=3D"comic sans m=
s, sans-serif">Best regards</font></div></div></div>

--000000000000d324c4061cdebad3--

