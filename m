Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 447DAC87FCF
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Aug 2025 02:28:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ulIGK-0001L4-Hc; Sun, 10 Aug 2025 22:27:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1ulIGD-0001ID-QL
 for qemu-devel@nongnu.org; Sun, 10 Aug 2025 22:27:42 -0400
Received: from mail-oa1-x2f.google.com ([2001:4860:4864:20::2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1ulIGA-0003Xa-Sr
 for qemu-devel@nongnu.org; Sun, 10 Aug 2025 22:27:41 -0400
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-30c15376c70so1990817fac.3
 for <qemu-devel@nongnu.org>; Sun, 10 Aug 2025 19:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1754879256; x=1755484056;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4FFtL5AqjBg5FDx4SBRCYPPGuC8tABM8XJeZksZ+9Og=;
 b=LTYvfi7g+CBVNTIFHSsrBwXuxBgcMSn29Dhf5uDKZiUST/SacegUlgcccoAm0XxbpA
 qq8MqLOuHnS7/iwsMVXahaWgxty/PQSRXW3gj3Ah4C4gEUNNrGtoZlfRlsFnC4LywZz/
 of/4ISL1qpJJI7prwTSTMVnmAFsClb34fnIFgpcRFwlOkv0pKYs4JZkJd70A5G6r7ZKJ
 q3CeJljqZ6chcUbAQj/MSvvZcZLKhY+MIBk3MCfD3wZap3b2wgXelpstw3Td2HHRibYr
 9PEfujYVn2rKivKy2XS4M2rmvtkVg6qdZg7gkYCvltt+rvz6ko5OwmOPwYTgSvpxTjiE
 LKZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754879256; x=1755484056;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4FFtL5AqjBg5FDx4SBRCYPPGuC8tABM8XJeZksZ+9Og=;
 b=MaYnKgibn2VMXhqoaTan87hU7CrKW+933INXTb5Ocz7z5yC52isQ+R24tUve0Eeqfy
 1Hx3HWRDls6l0Zh+QdJ4CP5x6Bn3VTLDXSVX31w/08xklvQ0JOjhNb2JKC1kql+xQEkq
 XBzOFC0GJMttJ7oObGe9wSkWgguvD4Qd47hQLgc37M6OGy9MHSM74ztpNV75Wr3EtM2G
 kck6zRYPiJZviK0LCD8T0czemGIwknjUPMU3iGQQ1D6Ty73676kgYE4yBATndgXPauRw
 LndgQUdOAioVeclxL7T5QOMtvK84hN1va0kbJxdHJ9hWw8tbxbBP9uBRXyrT2+wqyAwR
 x8dg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWt0dvxas8uxXI1aNB5PijBCQjbLqgKkrbi/D8iyevnA2JuTzTllaTqBIrX1EoLYXAeuo7tHbwvfAW6@nongnu.org
X-Gm-Message-State: AOJu0YxNZDzS3h63v5+/BiQfjYMvcRdncLz9BmDe2muwW6J6hrI4OtVn
 FUDFxg2YTr9u7gczCSY66Zid6AqsRHi0P7hdb22l9XU/Bd2mHek+WLqEmSYwme/wE88qfbRVFa/
 e9H75KQEKkZsj4bC1ANnjLFS4f+hTKU0nBf38dGq96A==
X-Gm-Gg: ASbGncuX3eQ/HAZMdR2uahyEk/5Tn3ddZQm+4aPzl2Hue39XHA/ihIf3iIBbDZkVtCW
 Eo3HdpHqJzTZAiIq8yydoTVYzGTuA3n43i2kXkl4v0UvKzb/+y2XNKUyW8GiLhIW7MN6A9tQS34
 Zo4V22VoKZiU1PET3hW9tKKhAYolukS6H2nwsphMUNeDTpmFyLo1UUgammQbDlT+jLJQnF/poqJ
 xHQXHDDrwoIO5V2ENI=
X-Google-Smtp-Source: AGHT+IEVSWYL6ZQ2fk6EjQtKtowYKoAhijGq71tNIMOqqvKMiDekPZVA5mda/sGO9kQE0hu3L/bw6eowik81bS6NJLE=
X-Received: by 2002:a05:6870:a11e:b0:30b:b393:802e with SMTP id
 586e51a60fabf-30c20f2d947mr7070632fac.16.1754879255918; Sun, 10 Aug 2025
 19:27:35 -0700 (PDT)
MIME-Version: 1.0
References: <5512220e1005ae2bc7357b2def32639d164e84eb.1754534263.git.yong.huang@smartx.com>
 <20250807113639.66d1c5bf@penguin>
 <CAK9dgmZb=5uEwVq65Ygcza0+qtng+-5zmtQRdviX2npg_qhJRQ@mail.gmail.com>
 <20250808090054.13cb8342@penguin>
 <CAK9dgmbybw+WkC2C_qdZnwSYjGn3Q2Du4yjLOz+EmCx1po8YPg@mail.gmail.com>
 <87o6sp2a0i.fsf@suse.de>
In-Reply-To: <87o6sp2a0i.fsf@suse.de>
From: Yong Huang <yong.huang@smartx.com>
Date: Mon, 11 Aug 2025 10:27:17 +0800
X-Gm-Features: Ac12FXynZbnHX_mKMs3oNG6Y1PiNghS3E3YUewm24KPBFB0IlISeHV2BfHAkres
Message-ID: <CAK9dgmZ6r8x8g_JBurmVW95-PVGNgyecvJjb_4L_JzpysvQStQ@mail.gmail.com>
Subject: Re: [PATCH] multifd: Make the main thread yield periodically to the
 main loop
To: Fabiano Rosas <farosas@suse.de>
Cc: Lukas Straub <lukasstraub2@web.de>, qemu-devel@nongnu.org, 
 Peter Xu <peterx@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000ac4d02063c0daa09"
Received-SPF: pass client-ip=2001:4860:4864:20::2f;
 envelope-from=yong.huang@smartx.com; helo=mail-oa1-x2f.google.com
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

--000000000000ac4d02063c0daa09
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 8, 2025 at 9:55=E2=80=AFPM Fabiano Rosas <farosas@suse.de> wrot=
e:

> Yong Huang <yong.huang@smartx.com> writes:
>
> > On Fri, Aug 8, 2025 at 3:02=E2=80=AFPM Lukas Straub <lukasstraub2@web.d=
e> wrote:
> >
> >> On Fri, 8 Aug 2025 10:36:24 +0800
> >> Yong Huang <yong.huang@smartx.com> wrote:
> >>
> >> > On Thu, Aug 7, 2025 at 5:36=E2=80=AFPM Lukas Straub <lukasstraub2@we=
b.de>
> wrote:
> >> >
> >> > > On Thu,  7 Aug 2025 10:41:17 +0800
> >> > > yong.huang@smartx.com wrote:
> >> > >
> >> > > > From: Hyman Huang <yong.huang@smartx.com>
> >> > > >
> >> > > > When there are network issues like missing TCP ACKs on the send
> >> > > > side during the multifd live migration. At the send side, the
> error
> >> > > > "Connection timed out" is thrown out and source QEMU process sto=
p
> >> > > > sending data, at the receive side, The IO-channels may be blocke=
d
> >> > > > at recvmsg() and thus the main loop gets stuck and fails to
> respond
> >> > > > to QMP commands consequently.
> >> > > > ...
> >> > >
> >> > > Hi Hyman Huang,
> >> > >
> >> > > Have you tried the 'yank' command to shutdown the sockets? It
> exactly
> >> > > meant to recover from hangs and should solve your issue.
> >> > >
> >> > >
> >> https://www.qemu.org/docs/master/interop/qemu-qmp-ref.html#yank-featur=
e
> >> >
> >> >
> >> > Thanks for the comment and advice.
> >> >
> >> > Let me give more details about the migration state when the issue
> >> happens:
> >> >
> >> > On the source side, libvirt has already aborted the migration job:
> >> >
> >> > $ virsh domjobinfo fdecd242-f278-4308-8c3b-46e144e55f63
> >> > Job type:         Failed
> >> > Operation:        Outgoing migration
> >> >
> >> > QMP query-yank shows that there is no migration yank instance:
> >> >
> >> > $ virsh qemu-monitor-command fdecd242-f278-4308-8c3b-46e144e55f63
> >> > '{"execute":"query-yank"}' --pretty
> >> > {
> >> >   "return": [
> >> >     {
> >> >       "type": "chardev",
> >> >       "id": "charmonitor"
> >> >     },
> >> >     {
> >> >       "type": "chardev",
> >> >       "id": "charchannel0"
> >> >     },
> >> >     {
> >> >       "type": "chardev",
> >> >       "id": "libvirt-2-virtio-format"
> >> >     }
> >> >   ],
> >> >   "id": "libvirt-5217"
> >> > }
> >>
> >> You are supposed to run it on the destination side, there the migratio=
n
> >> yank instance should be present if qemu hangs in the migration code.
> >>
> >> Also, you need to execute it as an out-of-band command to bypass the
> >> main loop. Like this:
> >>
> >> '{"exec-oob": "yank", "id": "yank0", "arguments": {"instances": [
> {"type":
> >> "migration"} ] } }'
> >
> > In our case, Libvirt's operation about the VM on the destination side h=
as
> > been blocked
> > by Migration JOB:
> >
> > $ virsh qemu-monitor-command fdecd242-f278-4308-8c3b-46e144e55f63
> > '{"query-commands"}' --pretty
> > error: Timed out during operation: cannot acquire state change lock (he=
ld
> > by monitor=3DremoteDispatchDomainMigratePrepare3Params)
> > Using Libvirt to issue the yank command can not be taken into account.
> >
> >
> >>
> >>
> >> I'm not sure if libvirt can do that, maybe you need to add an
> >> additional qmp socket and do it outside of libvirt. Note that you need
> >> to enable the oob feature during qmp negotiation, like this:
> >>
> >> '{ "execute": "qmp_capabilities", "arguments": { "enable": [ "oob" ] }
> }'
> >
> >
> > No, I checked Libvirt's source code and figured out that when the QEMU
> > monitor is initialized, Libvirt by default disables the OOB.
> >
> > Therefore, perhaps we can first enable the OOB and add the yank
> capability
> > to Libvirt then adding the yank logic to the necessary path=E2=80=94in =
our
> > instance, the migration code:
> >
> > qemuMigrationDstFinish=EF=BC=9A
> >     if (retcode !=3D 0) {
> >         /* Check for a possible error on the monitor in case Finish was
> called
> >          * earlier than monitor EOF handler got a chance to process the
> error
> >          */
> >         qemuDomainCheckMonitor(driver, vm, QEMU_ASYNC_JOB_MIGRATION_IN)=
;
> >         goto endjob;
> >     }
> >
> >
> >
> >>
> >> Regards,
> >> Lukas Straub
> >>
> >> >
> >> > The libvirt migration job is stuck as the following backtrace shows;
> it
> >> > shows that migration is waiting for the "Finish" RPC on the
> destination
> >> > side to return.
> >> >
> >> > ...
> >> >
> >> > IMHO, the key reason for the issue is that QEMU fails to run the mai=
n
> >> loop
> >> > and fails to respond to QMP, which is not what we usually expected.
> >> >
> >> > Giving the Libvirt a window of time to issue a QMP and kill the VM i=
s
> the
> >> > ideal solution for this issue; this provides an automatic method.
> >> >
> >> > I do not dig the yank feature, perhaps it is helpful, but only
> manually?
> >> >
> >> > After all, these two options are not exclusive of one another,  I
> think.
> >> >
>
> Please work with Lukas to figure out whether yank can be used here. I
> think that's the correct approach. If the main loop is blocked, then
> some out-of-band cancellation routine is needed. migrate_cancel() could
> be it, but at the moment it's not. Yank is the second best thing.


Ok, get it.


>
>
> The need for a timeout is usually indicative of a design issue. In this
> case, the choice of a coroutine for the incoming side is the obvious
> one. Peter will tell you all about it! =3D)
>


--=20
Best regards

--000000000000ac4d02063c0daa09
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-family:&quot;comic sans ms&quot;,sans-serif"><br></div></div><br><div cla=
ss=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_at=
tr">On Fri, Aug 8, 2025 at 9:55=E2=80=AFPM Fabiano Rosas &lt;<a href=3D"mai=
lto:farosas@suse.de">farosas@suse.de</a>&gt; wrote:<br></div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px=
;border-left-style:solid;border-left-color:rgb(204,204,204);padding-left:1e=
x">Yong Huang &lt;<a href=3D"mailto:yong.huang@smartx.com" target=3D"_blank=
">yong.huang@smartx.com</a>&gt; writes:<br>
<br>
&gt; On Fri, Aug 8, 2025 at 3:02=E2=80=AFPM Lukas Straub &lt;<a href=3D"mai=
lto:lukasstraub2@web.de" target=3D"_blank">lukasstraub2@web.de</a>&gt; wrot=
e:<br>
&gt;<br>
&gt;&gt; On Fri, 8 Aug 2025 10:36:24 +0800<br>
&gt;&gt; Yong Huang &lt;<a href=3D"mailto:yong.huang@smartx.com" target=3D"=
_blank">yong.huang@smartx.com</a>&gt; wrote:<br>
&gt;&gt;<br>
&gt;&gt; &gt; On Thu, Aug 7, 2025 at 5:36=E2=80=AFPM Lukas Straub &lt;<a hr=
ef=3D"mailto:lukasstraub2@web.de" target=3D"_blank">lukasstraub2@web.de</a>=
&gt; wrote:<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; &gt; On Thu,=C2=A0 7 Aug 2025 10:41:17 +0800<br>
&gt;&gt; &gt; &gt; <a href=3D"mailto:yong.huang@smartx.com" target=3D"_blan=
k">yong.huang@smartx.com</a> wrote:<br>
&gt;&gt; &gt; &gt;<br>
&gt;&gt; &gt; &gt; &gt; From: Hyman Huang &lt;<a href=3D"mailto:yong.huang@=
smartx.com" target=3D"_blank">yong.huang@smartx.com</a>&gt;<br>
&gt;&gt; &gt; &gt; &gt;<br>
&gt;&gt; &gt; &gt; &gt; When there are network issues like missing TCP ACKs=
 on the send<br>
&gt;&gt; &gt; &gt; &gt; side during the multifd live migration. At the send=
 side, the error<br>
&gt;&gt; &gt; &gt; &gt; &quot;Connection timed out&quot; is thrown out and =
source QEMU process stop<br>
&gt;&gt; &gt; &gt; &gt; sending data, at the receive side, The IO-channels =
may be blocked<br>
&gt;&gt; &gt; &gt; &gt; at recvmsg() and thus the main loop gets stuck and =
fails to respond<br>
&gt;&gt; &gt; &gt; &gt; to QMP commands consequently.<br>
&gt;&gt; &gt; &gt; &gt; ...<br>
&gt;&gt; &gt; &gt;<br>
&gt;&gt; &gt; &gt; Hi Hyman Huang,<br>
&gt;&gt; &gt; &gt;<br>
&gt;&gt; &gt; &gt; Have you tried the &#39;yank&#39; command to shutdown th=
e sockets? It exactly<br>
&gt;&gt; &gt; &gt; meant to recover from hangs and should solve your issue.=
<br>
&gt;&gt; &gt; &gt;<br>
&gt;&gt; &gt; &gt;<br>
&gt;&gt; <a href=3D"https://www.qemu.org/docs/master/interop/qemu-qmp-ref.h=
tml#yank-feature" rel=3D"noreferrer" target=3D"_blank">https://www.qemu.org=
/docs/master/interop/qemu-qmp-ref.html#yank-feature</a><br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Thanks for the comment and advice.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Let me give more details about the migration state when the i=
ssue<br>
&gt;&gt; happens:<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; On the source side, libvirt has already aborted the migration=
 job:<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; $ virsh domjobinfo fdecd242-f278-4308-8c3b-46e144e55f63<br>
&gt;&gt; &gt; Job type:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Failed<br>
&gt;&gt; &gt; Operation:=C2=A0 =C2=A0 =C2=A0 =C2=A0 Outgoing migration<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; QMP query-yank shows that there is no migration yank instance=
:<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; $ virsh qemu-monitor-command fdecd242-f278-4308-8c3b-46e144e5=
5f63<br>
&gt;&gt; &gt; &#39;{&quot;execute&quot;:&quot;query-yank&quot;}&#39; --pret=
ty<br>
&gt;&gt; &gt; {<br>
&gt;&gt; &gt;=C2=A0 =C2=A0&quot;return&quot;: [<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0{<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;type&quot;: &quot;chardev&quo=
t;,<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;id&quot;: &quot;charmonitor&q=
uot;<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0},<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0{<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;type&quot;: &quot;chardev&quo=
t;,<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;id&quot;: &quot;charchannel0&=
quot;<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0},<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0{<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;type&quot;: &quot;chardev&quo=
t;,<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;id&quot;: &quot;libvirt-2-vir=
tio-format&quot;<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0}<br>
&gt;&gt; &gt;=C2=A0 =C2=A0],<br>
&gt;&gt; &gt;=C2=A0 =C2=A0&quot;id&quot;: &quot;libvirt-5217&quot;<br>
&gt;&gt; &gt; }<br>
&gt;&gt;<br>
&gt;&gt; You are supposed to run it on the destination side, there the migr=
ation<br>
&gt;&gt; yank instance should be present if qemu hangs in the migration cod=
e.<br>
&gt;&gt;<br>
&gt;&gt; Also, you need to execute it as an out-of-band command to bypass t=
he<br>
&gt;&gt; main loop. Like this:<br>
&gt;&gt;<br>
&gt;&gt; &#39;{&quot;exec-oob&quot;: &quot;yank&quot;, &quot;id&quot;: &quo=
t;yank0&quot;, &quot;arguments&quot;: {&quot;instances&quot;: [ {&quot;type=
&quot;:<br>
&gt;&gt; &quot;migration&quot;} ] } }&#39;<br>
&gt;<br>
&gt; In our case, Libvirt&#39;s operation about the VM on the destination s=
ide has<br>
&gt; been blocked<br>
&gt; by Migration JOB:<br>
&gt;<br>
&gt; $ virsh qemu-monitor-command fdecd242-f278-4308-8c3b-46e144e55f63<br>
&gt; &#39;{&quot;query-commands&quot;}&#39; --pretty<br>
&gt; error: Timed out during operation: cannot acquire state change lock (h=
eld<br>
&gt; by monitor=3DremoteDispatchDomainMigratePrepare3Params)<br>
&gt; Using Libvirt to issue the yank command can not be taken into account.=
<br>
&gt;<br>
&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; I&#39;m not sure if libvirt can do that, maybe you need to add an<=
br>
&gt;&gt; additional qmp socket and do it outside of libvirt. Note that you =
need<br>
&gt;&gt; to enable the oob feature during qmp negotiation, like this:<br>
&gt;&gt;<br>
&gt;&gt; &#39;{ &quot;execute&quot;: &quot;qmp_capabilities&quot;, &quot;ar=
guments&quot;: { &quot;enable&quot;: [ &quot;oob&quot; ] } }&#39;<br>
&gt;<br>
&gt;<br>
&gt; No, I checked Libvirt&#39;s source code and figured out that when the =
QEMU<br>
&gt; monitor is initialized, Libvirt by default disables the OOB.<br>
&gt;<br>
&gt; Therefore, perhaps we can first enable the OOB and add the yank capabi=
lity<br>
&gt; to Libvirt then adding the yank logic to the necessary path=E2=80=94in=
 our<br>
&gt; instance, the migration code:<br>
&gt;<br>
&gt; qemuMigrationDstFinish=EF=BC=9A<br>
&gt;=C2=A0 =C2=A0 =C2=A0if (retcode !=3D 0) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Check for a possible error on the =
monitor in case Finish was called<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * earlier than monitor EOF handler g=
ot a chance to process the error<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qemuDomainCheckMonitor(driver, vm, QE=
MU_ASYNC_JOB_MIGRATION_IN);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto endjob;<br>
&gt;=C2=A0 =C2=A0 =C2=A0}<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt;&gt;<br>
&gt;&gt; Regards,<br>
&gt;&gt; Lukas Straub<br>
&gt;&gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; The libvirt migration job is stuck as the following backtrace=
 shows; it<br>
&gt;&gt; &gt; shows that migration is waiting for the &quot;Finish&quot; RP=
C on the destination<br>
&gt;&gt; &gt; side to return.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; ...<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; IMHO, the key reason for the issue is that QEMU fails to run =
the main<br>
&gt;&gt; loop<br>
&gt;&gt; &gt; and fails to respond to QMP, which is not what we usually exp=
ected.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Giving the Libvirt a window of time to issue a QMP and kill t=
he VM is the<br>
&gt;&gt; &gt; ideal solution for this issue; this provides an automatic met=
hod.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; I do not dig the yank feature, perhaps it is helpful, but onl=
y manually?<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; After all, these two options are not exclusive of one another=
,=C2=A0 I think.<br>
&gt;&gt; &gt;<br>
<br>
Please work with Lukas to figure out whether yank can be used here. I<br>
think that&#39;s the correct approach. If the main loop is blocked, then<br=
>
some out-of-band cancellation routine is needed. migrate_cancel() could<br>
be it, but at the moment it&#39;s not. Yank is the second best thing.<span =
class=3D"gmail_default" style=3D"font-family:&quot;comic sans ms&quot;,sans=
-serif"></span></blockquote><div><br></div><div><div style=3D"font-family:&=
quot;comic sans ms&quot;,sans-serif" class=3D"gmail_default">Ok, get it.</d=
iv></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin=
:0px 0px 0px 0.8ex;border-left-width:1px;border-left-style:solid;border-lef=
t-color:rgb(204,204,204);padding-left:1ex"><br>
<br>
The need for a timeout is usually indicative of a design issue. In this<br>
case, the choice of a coroutine for the incoming side is the obvious<br>
one. Peter will tell you all about it! =3D)<br>
</blockquote></div><div><br clear=3D"all"></div><div><br></div><span class=
=3D"gmail_signature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_s=
ignature"><div dir=3D"ltr"><font face=3D"comic sans ms, sans-serif">Best re=
gards</font></div></div></div>

--000000000000ac4d02063c0daa09--

