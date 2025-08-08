Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 362CCC87FD3
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Aug 2025 08:03:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukI3h-00036H-F2; Fri, 08 Aug 2025 04:02:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1ukI3f-00035T-Av
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 04:02:35 -0400
Received: from mail-oo1-xc2a.google.com ([2607:f8b0:4864:20::c2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1ukI3c-0005v9-IE
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 04:02:35 -0400
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-61585dfc8f8so683972eaf.0
 for <qemu-devel@nongnu.org>; Fri, 08 Aug 2025 01:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1754640150; x=1755244950;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qleN2YGtFLlqFEXWcFjVKCgkGW61R+8Q3t+kD4Gufdo=;
 b=hoCopvkbAZHfsX2ZzOkUFHQfpP6A/E+lZ43YSDLkG8pEAZ7ij0MLJpFaiBDbAA0YAz
 txz2OPwvQ46TFz2WTONyy8oCxEgZQXVokTUlx0P7X4sMCeSDCT3qGQ/HUZJbKBNpK4f7
 jYwRUbjGaNfduomg5A9pr+ic4wf7WHYAUwA1Ufsc2p1zh6xDTvdAvjl11Piu3nBP1nG5
 hofzxnokKRknSd+Q4JI2EOGWXGCndr8P+YWbcDImi+V/Bduo7PX3n3xYnT7CocHHIByj
 kVUhh1brsXJ6JB7e5TjKx8P9Cvp5NC26b3SLn3m2xqmxxl9+PZxOgbBvzbtvN2kLQoGX
 z68A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754640150; x=1755244950;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qleN2YGtFLlqFEXWcFjVKCgkGW61R+8Q3t+kD4Gufdo=;
 b=TFbwGmuJmR9d3ef3JR36vAo+EPtJeC4OrW9qKfPhsHnCTAp1e81oadJCRd64NPeZfc
 JcjKIIP5j50sEFHB108wLPIl1kOAgrz+YNdhiFc5MIlnL1djm1vJM9+NLgSyTmtWJD70
 HD0OY7SwxYEfGmG1CuTeKNsbBlWI1SfJ1cinan++v4o7jVJaIXd0xY7+p4/XsHoAFtHI
 5sh1+cndm9r8jldm8mmvK8yT53BVty0xCHZdtdQog8nUpgxbECX+8bN0076kJ6OtJf85
 aHEqbXv81GOgkMhODMro2DuKpIszv7CXgxl11/aPc3r51elpt7KA0z912FrGdi5MDRdN
 oNwA==
X-Gm-Message-State: AOJu0Yy0J9sgx6OfIrS0dgdVJI297aKL9ekhZCm30tsVCxhMsIsR0N10
 KaAyJvqhzTf906Yq0wxLzW5vn3nb0OEHC2soMdltGj0ckL6Yy2GfPErcHUMqhRINEA2AF0BgBKQ
 v5GD/XgL0v5f1JKVdzw+zAammShHommDvoj1QpG4bTA==
X-Gm-Gg: ASbGncu2CoCv1QsmtKcql3T8fK7dv87V14PIthPLa6Ds55ZAWX5XivKg3SdbgifrAEB
 iwZqZoCic2RBKvod75Kt2OdO1//yJvfvWN6G8yGwxJUAOIH1w64pRDU9+xmLB2Z/TUGrzzIGKPn
 hfkkZUio1WtFMrLPP1jMn2jrC3T9yXslBTRkM0wSAEdHGvIrg7njP5RD0uWd5y/6ImiLh/5rgaV
 H3iGeNFjg==
X-Google-Smtp-Source: AGHT+IGifkuRPm0RX2ixI30bZA7Ln96Q2SLe2uNi59trhwq6eSzSaWyst8aiPZrVmYX5tCOcpFYPfmDlNjv53nGxFCg=
X-Received: by 2002:a05:6871:4149:b0:30b:cd02:297c with SMTP id
 586e51a60fabf-30c211eb4d2mr1479402fac.35.1754640150282; Fri, 08 Aug 2025
 01:02:30 -0700 (PDT)
MIME-Version: 1.0
References: <5512220e1005ae2bc7357b2def32639d164e84eb.1754534263.git.yong.huang@smartx.com>
 <20250807113639.66d1c5bf@penguin>
 <CAK9dgmZb=5uEwVq65Ygcza0+qtng+-5zmtQRdviX2npg_qhJRQ@mail.gmail.com>
 <20250808090054.13cb8342@penguin>
In-Reply-To: <20250808090054.13cb8342@penguin>
From: Yong Huang <yong.huang@smartx.com>
Date: Fri, 8 Aug 2025 16:02:13 +0800
X-Gm-Features: Ac12FXxSTJKP2_hauU7XpLAsHnVVSlc-9YwCQOyCcO04FvCAmxK3pIpKUaNIe8w
Message-ID: <CAK9dgmbybw+WkC2C_qdZnwSYjGn3Q2Du4yjLOz+EmCx1po8YPg@mail.gmail.com>
Subject: Re: [PATCH] multifd: Make the main thread yield periodically to the
 main loop
To: Lukas Straub <lukasstraub2@web.de>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>
Content-Type: multipart/alternative; boundary="000000000000ddd41c063bd5fefd"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2a;
 envelope-from=yong.huang@smartx.com; helo=mail-oo1-xc2a.google.com
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

--000000000000ddd41c063bd5fefd
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 8, 2025 at 3:02=E2=80=AFPM Lukas Straub <lukasstraub2@web.de> w=
rote:

> On Fri, 8 Aug 2025 10:36:24 +0800
> Yong Huang <yong.huang@smartx.com> wrote:
>
> > On Thu, Aug 7, 2025 at 5:36=E2=80=AFPM Lukas Straub <lukasstraub2@web.d=
e> wrote:
> >
> > > On Thu,  7 Aug 2025 10:41:17 +0800
> > > yong.huang@smartx.com wrote:
> > >
> > > > From: Hyman Huang <yong.huang@smartx.com>
> > > >
> > > > When there are network issues like missing TCP ACKs on the send
> > > > side during the multifd live migration. At the send side, the error
> > > > "Connection timed out" is thrown out and source QEMU process stop
> > > > sending data, at the receive side, The IO-channels may be blocked
> > > > at recvmsg() and thus the main loop gets stuck and fails to respond
> > > > to QMP commands consequently.
> > > > ...
> > >
> > > Hi Hyman Huang,
> > >
> > > Have you tried the 'yank' command to shutdown the sockets? It exactly
> > > meant to recover from hangs and should solve your issue.
> > >
> > >
> https://www.qemu.org/docs/master/interop/qemu-qmp-ref.html#yank-feature
> >
> >
> > Thanks for the comment and advice.
> >
> > Let me give more details about the migration state when the issue
> happens:
> >
> > On the source side, libvirt has already aborted the migration job:
> >
> > $ virsh domjobinfo fdecd242-f278-4308-8c3b-46e144e55f63
> > Job type:         Failed
> > Operation:        Outgoing migration
> >
> > QMP query-yank shows that there is no migration yank instance:
> >
> > $ virsh qemu-monitor-command fdecd242-f278-4308-8c3b-46e144e55f63
> > '{"execute":"query-yank"}' --pretty
> > {
> >   "return": [
> >     {
> >       "type": "chardev",
> >       "id": "charmonitor"
> >     },
> >     {
> >       "type": "chardev",
> >       "id": "charchannel0"
> >     },
> >     {
> >       "type": "chardev",
> >       "id": "libvirt-2-virtio-format"
> >     }
> >   ],
> >   "id": "libvirt-5217"
> > }
>
> You are supposed to run it on the destination side, there the migration
> yank instance should be present if qemu hangs in the migration code.
>
> Also, you need to execute it as an out-of-band command to bypass the
> main loop. Like this:
>
> '{"exec-oob": "yank", "id": "yank0", "arguments": {"instances": [ {"type"=
:
> "migration"} ] } }'

In our case, Libvirt's operation about the VM on the destination side has
been blocked
by Migration JOB:

$ virsh qemu-monitor-command fdecd242-f278-4308-8c3b-46e144e55f63
'{"query-commands"}' --pretty
error: Timed out during operation: cannot acquire state change lock (held
by monitor=3DremoteDispatchDomainMigratePrepare3Params)
Using Libvirt to issue the yank command can not be taken into account.


>
>
> I'm not sure if libvirt can do that, maybe you need to add an
> additional qmp socket and do it outside of libvirt. Note that you need
> to enable the oob feature during qmp negotiation, like this:
>
> '{ "execute": "qmp_capabilities", "arguments": { "enable": [ "oob" ] } }'


No, I checked Libvirt's source code and figured out that when the QEMU
monitor is initialized, Libvirt by default disables the OOB.

Therefore, perhaps we can first enable the OOB and add the yank capability
to Libvirt then adding the yank logic to the necessary path=E2=80=94in our
instance, the migration code:

qemuMigrationDstFinish=EF=BC=9A
    if (retcode !=3D 0) {
        /* Check for a possible error on the monitor in case Finish was cal=
led
         * earlier than monitor EOF handler got a chance to process the err=
or
         */
        qemuDomainCheckMonitor(driver, vm, QEMU_ASYNC_JOB_MIGRATION_IN);
        goto endjob;
    }



>
> Regards,
> Lukas Straub
>
> >
> > The libvirt migration job is stuck as the following backtrace shows; it
> > shows that migration is waiting for the "Finish" RPC on the destination
> > side to return.
> >
> > ...
> >
> > IMHO, the key reason for the issue is that QEMU fails to run the main
> loop
> > and fails to respond to QMP, which is not what we usually expected.
> >
> > Giving the Libvirt a window of time to issue a QMP and kill the VM is t=
he
> > ideal solution for this issue; this provides an automatic method.
> >
> > I do not dig the yank feature, perhaps it is helpful, but only manually=
?
> >
> > After all, these two options are not exclusive of one another,  I think=
.
> >
> >
> > >
> > > Best regards,
> > > Lukas Straub
> > >
> >
> > Thanks,
> > Yong
> >
>
>

--=20
Best regards

--000000000000ddd41c063bd5fefd
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-family:&quot;comic sans ms&quot;,sans-serif"><br></div></div><br><div cla=
ss=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_at=
tr">On Fri, Aug 8, 2025 at 3:02=E2=80=AFPM Lukas Straub &lt;<a href=3D"mail=
to:lukasstraub2@web.de">lukasstraub2@web.de</a>&gt; wrote:<br></div><blockq=
uote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-wi=
dth:1px;border-left-style:solid;border-left-color:rgb(204,204,204);padding-=
left:1ex">On Fri, 8 Aug 2025 10:36:24 +0800<br>
Yong Huang &lt;<a href=3D"mailto:yong.huang@smartx.com" target=3D"_blank">y=
ong.huang@smartx.com</a>&gt; wrote:<br>
<br>
&gt; On Thu, Aug 7, 2025 at 5:36=E2=80=AFPM Lukas Straub &lt;<a href=3D"mai=
lto:lukasstraub2@web.de" target=3D"_blank">lukasstraub2@web.de</a>&gt; wrot=
e:<br>
&gt; <br>
&gt; &gt; On Thu,=C2=A0 7 Aug 2025 10:41:17 +0800<br>
&gt; &gt; <a href=3D"mailto:yong.huang@smartx.com" target=3D"_blank">yong.h=
uang@smartx.com</a> wrote:<br>
&gt; &gt;=C2=A0 <br>
&gt; &gt; &gt; From: Hyman Huang &lt;<a href=3D"mailto:yong.huang@smartx.co=
m" target=3D"_blank">yong.huang@smartx.com</a>&gt;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; When there are network issues like missing TCP ACKs on the s=
end<br>
&gt; &gt; &gt; side during the multifd live migration. At the send side, th=
e error<br>
&gt; &gt; &gt; &quot;Connection timed out&quot; is thrown out and source QE=
MU process stop<br>
&gt; &gt; &gt; sending data, at the receive side, The IO-channels may be bl=
ocked<br>
&gt; &gt; &gt; at recvmsg() and thus the main loop gets stuck and fails to =
respond<br>
&gt; &gt; &gt; to QMP commands consequently.<br>
&gt; &gt; &gt; ...=C2=A0 <br>
&gt; &gt;<br>
&gt; &gt; Hi Hyman Huang,<br>
&gt; &gt;<br>
&gt; &gt; Have you tried the &#39;yank&#39; command to shutdown the sockets=
? It exactly<br>
&gt; &gt; meant to recover from hangs and should solve your issue.<br>
&gt; &gt;<br>
&gt; &gt; <a href=3D"https://www.qemu.org/docs/master/interop/qemu-qmp-ref.=
html#yank-feature" rel=3D"noreferrer" target=3D"_blank">https://www.qemu.or=
g/docs/master/interop/qemu-qmp-ref.html#yank-feature</a>=C2=A0 <br>
&gt; <br>
&gt; <br>
&gt; Thanks for the comment and advice.<br>
&gt; <br>
&gt; Let me give more details about the migration state when the issue happ=
ens:<br>
&gt; <br>
&gt; On the source side, libvirt has already aborted the migration job:<br>
&gt; <br>
&gt; $ virsh domjobinfo fdecd242-f278-4308-8c3b-46e144e55f63<br>
&gt; Job type:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Failed<br>
&gt; Operation:=C2=A0 =C2=A0 =C2=A0 =C2=A0 Outgoing migration<br>
&gt; <br>
&gt; QMP query-yank shows that there is no migration yank instance:<br>
&gt; <br>
&gt; $ virsh qemu-monitor-command fdecd242-f278-4308-8c3b-46e144e55f63<br>
&gt; &#39;{&quot;execute&quot;:&quot;query-yank&quot;}&#39; --pretty<br>
&gt; {<br>
&gt;=C2=A0 =C2=A0&quot;return&quot;: [<br>
&gt;=C2=A0 =C2=A0 =C2=A0{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;type&quot;: &quot;chardev&quot;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;id&quot;: &quot;charmonitor&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0},<br>
&gt;=C2=A0 =C2=A0 =C2=A0{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;type&quot;: &quot;chardev&quot;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;id&quot;: &quot;charchannel0&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0},<br>
&gt;=C2=A0 =C2=A0 =C2=A0{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;type&quot;: &quot;chardev&quot;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;id&quot;: &quot;libvirt-2-virtio-forma=
t&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0],<br>
&gt;=C2=A0 =C2=A0&quot;id&quot;: &quot;libvirt-5217&quot;<br>
&gt; }<br>
<br>
You are supposed to run it on the destination side, there the migration<br>
yank instance should be present if qemu hangs in the migration code.<br>
<br>
Also, you need to execute it as an out-of-band command to bypass the<br>
main loop. Like this:<br>
<br>
&#39;{&quot;exec-oob&quot;: &quot;yank&quot;, &quot;id&quot;: &quot;yank0&q=
uot;, &quot;arguments&quot;: {&quot;instances&quot;: [ {&quot;type&quot;: &=
quot;migration&quot;} ] } }&#39;<span class=3D"gmail_default" style=3D"font=
-family:&quot;comic sans ms&quot;,sans-serif"></span></blockquote><div><div=
 style=3D"font-family:&quot;comic sans ms&quot;,sans-serif" class=3D"gmail_=
default"></div><div style=3D"font-family:&quot;comic sans ms&quot;,sans-ser=
if" class=3D"gmail_default">In our case, Libvirt&#39;s operation about the =
VM on the destination side has been blocked</div><div style=3D"font-family:=
&quot;comic sans ms&quot;,sans-serif" class=3D"gmail_default">by Migration =
JOB:</div><div style=3D"font-family:&quot;comic sans ms&quot;,sans-serif" c=
lass=3D"gmail_default"><br></div><div style=3D"font-family:&quot;comic sans=
 ms&quot;,sans-serif" class=3D"gmail_default">$ virsh qemu-monitor-command =
fdecd242-f278-4308-8c3b-46e144e55f63 &#39;{&quot;query-commands&quot;}&#39;=
 --pretty<br>error: Timed out during operation: cannot acquire state change=
 lock (held by monitor=3DremoteDispatchDomainMigratePrepare3Params)<br></di=
v><div style=3D"font-family:&quot;comic sans ms&quot;,sans-serif" class=3D"=
gmail_default"></div><div style=3D"font-family:&quot;comic sans ms&quot;,sa=
ns-serif" class=3D"gmail_default">Using Libvirt to issue the yank command c=
an not be taken into account.</div></div><div>=C2=A0</div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;bo=
rder-left-style:solid;border-left-color:rgb(204,204,204);padding-left:1ex">=
<br>
<br>
I&#39;m not sure if libvirt can do that, maybe you need to add an<br>
additional qmp socket and do it outside of libvirt. Note that you need<br>
to enable the oob feature during qmp negotiation, like this:<br>
<br>
&#39;{ &quot;execute&quot;: &quot;qmp_capabilities&quot;, &quot;arguments&q=
uot;: { &quot;enable&quot;: [ &quot;oob&quot; ] } }&#39;<span class=3D"gmai=
l_default" style=3D"font-family:&quot;comic sans ms&quot;,sans-serif"></spa=
n>=C2=A0</blockquote><div><br></div><div style=3D"font-family:&quot;comic s=
ans ms&quot;,sans-serif" class=3D"gmail_default">No, I checked Libvirt&#39;=
s source code and figured out that when the QEMU monitor is initialized, Li=
bvirt by default disables the OOB.<br><br>Therefore, perhaps we can first e=
nable the OOB and add the yank capability to Libvirt then adding the yank l=
ogic to the necessary path=E2=80=94in our instance, the migration code:<br>=
</div><div style=3D"font-family:&quot;comic sans ms&quot;,sans-serif" class=
=3D"gmail_default"><br></div><div style=3D"font-family:&quot;comic sans ms&=
quot;,sans-serif" class=3D"gmail_default"><pre style=3D"box-sizing:border-b=
ox;font-size:13.6px;font-family:SFMono-Regular,Consolas,&quot;Liberation Mo=
no&quot;,Menlo,monospace;margin-top:0px;margin-bottom:16px;overflow:auto;pa=
dding:16px;line-height:1.45;background-color:rgb(246,248,250);border-radius=
:3px;color:rgb(36,41,46)"><code style=3D"box-sizing:border-box;font-size:12=
.92px;font-family:SFMono-Regular,Consolas,&quot;Liberation Mono&quot;,Menlo=
,monospace;padding:0px;margin:0px;border-radius:3px;background-image:none;b=
ackground-position:0% 0%;background-size:auto;background-repeat:repeat;back=
ground-origin:padding-box;background-clip:border-box;word-break:normal;bord=
er:0px;display:inline;overflow:visible;line-height:inherit;color:rgba(0,0,0=
,0.65)">qemuMigrationDstFinish=EF=BC=9A
    if (retcode !=3D 0) {
        /* Check for a possible error on the monitor in case Finish was cal=
led
         * earlier than monitor EOF handler got a chance to process the err=
or
         */
        qemuDomainCheckMonitor(driver, vm, QEMU_ASYNC_JOB_MIGRATION_IN);
        goto endjob;
    }</code></pre></div><div style=3D"font-family:&quot;comic sans ms&quot;=
,sans-serif" class=3D"gmail_default"><br></div><blockquote class=3D"gmail_q=
uote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-s=
tyle:solid;border-left-color:rgb(204,204,204);padding-left:1ex"><br>
<br>
Regards,<br>
Lukas Straub<br>
<br>
&gt; <br>
&gt; The libvirt migration job is stuck as the following backtrace shows; i=
t<br>
&gt; shows that migration is waiting for the &quot;Finish&quot; RPC on the =
destination<br>
&gt; side to return.<br>
&gt; <br>
&gt; ...<br>
&gt; <br>
&gt; IMHO, the key reason for the issue is that QEMU fails to run the main =
loop<br>
&gt; and fails to respond to QMP, which is not what we usually expected.<br=
>
&gt; <br>
&gt; Giving the Libvirt a window of time to issue a QMP and kill the VM is =
the<br>
&gt; ideal solution for this issue; this provides an automatic method.<br>
&gt; <br>
&gt; I do not dig the yank feature, perhaps it is helpful, but only manuall=
y?<br>
&gt; <br>
&gt; After all, these two options are not exclusive of one another,=C2=A0 I=
 think.<br>
&gt; <br>
&gt; <br>
&gt; &gt;<br>
&gt; &gt; Best regards,<br>
&gt; &gt; Lukas Straub<br>
&gt; &gt;=C2=A0 <br>
&gt; <br>
&gt; Thanks,<br>
&gt; Yong<br>
&gt; <br>
<br>
</blockquote></div><div><br clear=3D"all"></div><div><br></div><span class=
=3D"gmail_signature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_s=
ignature"><div dir=3D"ltr"><font face=3D"comic sans ms, sans-serif">Best re=
gards</font></div></div></div>

--000000000000ddd41c063bd5fefd--

