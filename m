Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEC43C48BF8
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 01:31:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcExy-0007Xs-Rn; Mon, 19 Feb 2024 20:30:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rcExf-0007XX-Qh
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 20:30:20 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rcExc-0002db-2n
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 20:30:19 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1dc09556599so7878655ad.1
 for <qemu-devel@nongnu.org>; Mon, 19 Feb 2024 17:28:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1708392492; x=1708997292;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=65NQOeXj+tjx41JJsq6wDSMIF4zgf0qEFxd2JeYi3hI=;
 b=WYDptkIuz4P4BDtCJCbb4MGK6OB+EuO2CEgB4pQ4Gy5b/OTno3GUC2nZDjK6NpwU8y
 p6UDDEu+vegG8MTSm5MNmXCmge7c4ho+9NzbrHlbmASvSfR7Z55h2Qr+9CtkL2xyabLk
 QEj6OC37QhSa9rIDD1AISB2yJo6BO6aj5U9ZpmIhOR7AUxr9Ej/hvsrjrcRXjFEn1oP6
 cOXJlU5ky0GwQ5BOK86I507Vrbwc9+zp3zva4w2J1KwuELDSOd4jkB4DSwYeGEQy37j5
 Psnhzey99n7lUPxan1Ws87ZNxaYkWS8uoqj6GA95gwxDfTdznk1w9bUD/fwDuOBTrO00
 addw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708392492; x=1708997292;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=65NQOeXj+tjx41JJsq6wDSMIF4zgf0qEFxd2JeYi3hI=;
 b=A8Y03LOHMEcSVk61hpkV7Aa7dodtzwCjrppn7XXIlfNX4/hGQjz3sFpfkBIM1v7qqr
 7Rr6L5IFvhhwv9Co+05SynVwQ4rAgHQIJE7tIau9z1ig4heCNh9eM+fPszE8kYieKg7f
 XqC40y/6CkpaBvvT78GqSxTAMLFeYRA+4s3cvTgKoLqH7y6gzyI8GRSQAzthhjax9jF7
 iNFRFNiQlrqL8ge+4feOo0x8SxXJ29M1hDeRhngF8cSMOItcYIKFH4rcP/Zn+JBJoecH
 Haha9C2KEBj6ao4DwLQUL1H1rgwXgBsYcbsxNT3o1pTz+qc0EV8eUJW+aByQdY+R474B
 M/9g==
X-Gm-Message-State: AOJu0YyyfoA905ynE15cUgVl8nLPZk1wVfHcBonF/DnZ+DNakeFBjWAo
 k2HfbHUx+BdMHcpG6d2PVylp9UI2bHaSKiTHjKYTVAs4pO08ziQ4cjsHHDkrZpNkEIXngPdNoUp
 9RY4oTqR63ySZUlWxlyi/fzoudRsTKjmFjk3FPQ==
X-Google-Smtp-Source: AGHT+IFu5oWmklfciDaAMeQ8U5r0F7wIyTynWA75bzDZUDfK3B037d2U17VkKSaX+7BlGXZpfPevCZFDrpcCzLwAgac=
X-Received: by 2002:a17:902:7597:b0:1d9:bf6a:cffa with SMTP id
 j23-20020a170902759700b001d9bf6acffamr13412045pll.45.1708392490418; Mon, 19
 Feb 2024 17:28:10 -0800 (PST)
MIME-Version: 1.0
References: <cover.1706883915.git.yong.huang@smartx.com>
 <cde5e47e38e5e26390a6b0379092c197aaff9521.1706883915.git.yong.huang@smartx.com>
 <20240213052542-mutt-send-email-mst@kernel.org>
 <CAK9dgmYu04F37==Ye4VgtmZjzh8-YXQ61FygtG5o_f0E=e6cmg@mail.gmail.com>
 <87le7gii6b.fsf@pond.sub.org>
In-Reply-To: <87le7gii6b.fsf@pond.sub.org>
From: Yong Huang <yong.huang@smartx.com>
Date: Tue, 20 Feb 2024 09:27:52 +0800
Message-ID: <CAK9dgmZ8qrM6oxDiVqy7QEbsS+L1GSwsZOnnWeO12WUYjybhoA@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] qmp: Switch x-query-virtio-status back to numeric
 encoding
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000087581c0611c61f30"
Received-SPF: none client-ip=2607:f8b0:4864:20::635;
 envelope-from=yong.huang@smartx.com; helo=mail-pl1-x635.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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

--00000000000087581c0611c61f30
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 19, 2024 at 11:32=E2=80=AFPM Markus Armbruster <armbru@redhat.c=
om>
wrote:

> Yong Huang <yong.huang@smartx.com> writes:
>
> > On Tue, Feb 13, 2024 at 6:26=E2=80=AFPM Michael S. Tsirkin <mst@redhat.=
com>
> wrote:
> >
> >> On Fri, Feb 02, 2024 at 10:32:15PM +0800, Hyman Huang wrote:
> >> > x-query-virtio-status returns several sets of virtio feature and
> >> > status flags.  It goes back to v7.2.0.
> >> >
> >> > In the initial commit 90c066cd682 (qmp: add QMP command
> >> > x-query-virtio-status), we returned them as numbers, using virtio's
> >> > well-known binary encoding.
> >> >
> >> > The next commit f3034ad71fc (qmp: decode feature & status bits in
> >> > virtio-status) replaced the numbers by objects.  The objects represe=
nt
> >> > bits QEMU knows symbolically, and any unknown bits numerically just
> like
> >> > before.
> >> >
> >> > Commit 8a8287981d1 (hmp: add virtio commands) the matching HMP comma=
nd
> >> > "info virtio" (and a few more, which aren't relevant here).
> >> >
> >> > The symbolic representation uses lists of strings.  The string forma=
t
> is
> >> > undocumented.  The strings look like "WELL_KNOWN_SYMBOL: human
> readable
> >> > explanation".
> >> >
> >> > This symbolic representation is nice for humans.  Machines it can sa=
ve
> >> > the trouble of decoding virtio's well-known binary encoding.
> >> >
> >> > However, we sometimes want to compare features and status bits witho=
ut
> >> > caring for their exact meaning.  Say we want to verify the correctne=
ss
> >> > of the virtio negotiation between guest, QEMU, and OVS-DPDK.  We can
> use
> >> > QMP command x-query-virtio-status to retrieve vhost-user net device
> >> > features, and the "ovs-vsctl list interface" command to retrieve
> >> > interface features.  Without commit f3034ad71fc, we could then simpl=
y
> >> > compare the numbers.  With this commit, we first have to map from th=
e
> >> > strings back to the numeric encoding.
> >> >
> >> > Revert the decoding for QMP, but keep it for HMP.
> >>
> >> Is there a way to maybe have both decoded and numerical one?
> >
> > What if the next patch went back to this implementation in the followin=
g
> > patch? All you need to do is add a matching xxx_bits entry for each
> feature
> > and status.
> >
> >
> https://patchew.org/QEMU/cover.1700319559.git.yong.huang@smartx.com/3c716=
1a47b141af04b1f8272e8e24c5faa46ddb2.1700319559.git.yong.huang@smartx.com/
> >
> >
> > E.g. I mostly use QMP even when I read it myself.
> >>
> >
> > Thus, it is recommended that both numerical and decoded types be kept f=
or
> > QMP; this approach can be at odds with what was previously discussed.
> > What do you think about this, Markus?
>
> QMP is for machines.
>
> That said, I won't object to adding development & debugging aids meant
> for humans as long as
>
> 1. they're marked unstable, and
>
> 2. they either add only a modest amount of output, or the additional
>    output is off by default.
>
> What exactly is a "modest amount" depends on how machines use the
> command.  If they use it all the time, even going from 8KiB to 64KiB
> could be too much.  If they use it just once per guest, we can afford
> more waste.
>
> In this particular case, we could add an unstable member of type ['str']
> next to the int-valued bits.  For each set bit in the int, add a string
> to the list.  If QEMU knows the bit, use the well-known name.  I'd omit
> the common prefix, though: use "GUEST_ANNOUNCE" or "guest-announce"
> instead of "VIRTIO_NET_F_GUEST_ANNOUNCE".  If QEMU doesn't know the bit,
> you could use the bit's numeric value.
>
> Recommend a separate patch, to avoid delaying this series.
>
> Makes sense?
>
>
I agree,  and thanks for the comments.

Yong

--=20
Best regards

--00000000000087581c0611c61f30
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-family:&quot;comic sans ms&quot;,sans-serif"><br></div></div><br><div cla=
ss=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Feb 19, 20=
24 at 11:32=E2=80=AFPM Markus Armbruster &lt;<a href=3D"mailto:armbru@redha=
t.com">armbru@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail=
_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left=
-style:solid;border-left-color:rgb(204,204,204);padding-left:1ex">Yong Huan=
g &lt;<a href=3D"mailto:yong.huang@smartx.com" target=3D"_blank">yong.huang=
@smartx.com</a>&gt; writes:<br>
<br>
&gt; On Tue, Feb 13, 2024 at 6:26=E2=80=AFPM Michael S. Tsirkin &lt;<a href=
=3D"mailto:mst@redhat.com" target=3D"_blank">mst@redhat.com</a>&gt; wrote:<=
br>
&gt;<br>
&gt;&gt; On Fri, Feb 02, 2024 at 10:32:15PM +0800, Hyman Huang wrote:<br>
&gt;&gt; &gt; x-query-virtio-status returns several sets of virtio feature =
and<br>
&gt;&gt; &gt; status flags.=C2=A0 It goes back to v7.2.0.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; In the initial commit 90c066cd682 (qmp: add QMP command<br>
&gt;&gt; &gt; x-query-virtio-status), we returned them as numbers, using vi=
rtio&#39;s<br>
&gt;&gt; &gt; well-known binary encoding.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; The next commit f3034ad71fc (qmp: decode feature &amp; status=
 bits in<br>
&gt;&gt; &gt; virtio-status) replaced the numbers by objects.=C2=A0 The obj=
ects represent<br>
&gt;&gt; &gt; bits QEMU knows symbolically, and any unknown bits numericall=
y just like<br>
&gt;&gt; &gt; before.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Commit 8a8287981d1 (hmp: add virtio commands) the matching HM=
P command<br>
&gt;&gt; &gt; &quot;info virtio&quot; (and a few more, which aren&#39;t rel=
evant here).<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; The symbolic representation uses lists of strings.=C2=A0 The =
string format is<br>
&gt;&gt; &gt; undocumented.=C2=A0 The strings look like &quot;WELL_KNOWN_SY=
MBOL: human readable<br>
&gt;&gt; &gt; explanation&quot;.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; This symbolic representation is nice for humans.=C2=A0 Machin=
es it can save<br>
&gt;&gt; &gt; the trouble of decoding virtio&#39;s well-known binary encodi=
ng.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; However, we sometimes want to compare features and status bit=
s without<br>
&gt;&gt; &gt; caring for their exact meaning.=C2=A0 Say we want to verify t=
he correctness<br>
&gt;&gt; &gt; of the virtio negotiation between guest, QEMU, and OVS-DPDK.=
=C2=A0 We can use<br>
&gt;&gt; &gt; QMP command x-query-virtio-status to retrieve vhost-user net =
device<br>
&gt;&gt; &gt; features, and the &quot;ovs-vsctl list interface&quot; comman=
d to retrieve<br>
&gt;&gt; &gt; interface features.=C2=A0 Without commit f3034ad71fc, we coul=
d then simply<br>
&gt;&gt; &gt; compare the numbers.=C2=A0 With this commit, we first have to=
 map from the<br>
&gt;&gt; &gt; strings back to the numeric encoding.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Revert the decoding for QMP, but keep it for HMP.<br>
&gt;&gt;<br>
&gt;&gt; Is there a way to maybe have both decoded and numerical one?<br>
&gt;<br>
&gt; What if the next patch went back to this implementation in the followi=
ng<br>
&gt; patch? All you need to do is add a matching xxx_bits entry for each fe=
ature<br>
&gt; and status.<br>
&gt;<br>
&gt; <a href=3D"https://patchew.org/QEMU/cover.1700319559.git.yong.huang@sm=
artx.com/3c7161a47b141af04b1f8272e8e24c5faa46ddb2.1700319559.git.yong.huang=
@smartx.com/" rel=3D"noreferrer" target=3D"_blank">https://patchew.org/QEMU=
/cover.1700319559.git.yong.huang@smartx.com/3c7161a47b141af04b1f8272e8e24c5=
faa46ddb2.1700319559.git.yong.huang@smartx.com/</a><br>
&gt;<br>
&gt;<br>
&gt; E.g. I mostly use QMP even when I read it myself.<br>
&gt;&gt;<br>
&gt;<br>
&gt; Thus, it is recommended that both numerical and decoded types be kept =
for<br>
&gt; QMP; this approach can be at odds with what was previously discussed.<=
br>
&gt; What do you think about this, Markus?<br>
<br>
QMP is for machines.<br>
<br>
That said, I won&#39;t object to adding development &amp; debugging aids me=
ant<br>
for humans as long as<br>
<br>
1. they&#39;re marked unstable, and<br>
<br>
2. they either add only a modest amount of output, or the additional<br>
=C2=A0 =C2=A0output is off by default.<br>
<br>
What exactly is a &quot;modest amount&quot; depends on how machines use the=
<br>
command.=C2=A0 If they use it all the time, even going from 8KiB to 64KiB<b=
r>
could be too much.=C2=A0 If they use it just once per guest, we can afford<=
br>
more waste.<br>
<br>
In this particular case, we could add an unstable member of type [&#39;str&=
#39;]<br>
next to the int-valued bits.=C2=A0 For each set bit in the int, add a strin=
g<br>
to the list.=C2=A0 If QEMU knows the bit, use the well-known name.=C2=A0 I&=
#39;d omit<br>
the common prefix, though: use &quot;GUEST_ANNOUNCE&quot; or &quot;guest-an=
nounce&quot;<br>
instead of &quot;VIRTIO_NET_F_GUEST_ANNOUNCE&quot;.=C2=A0 If QEMU doesn&#39=
;t know the bit,<br>
you could use the bit&#39;s numeric value.<br>
<br>
Recommend a separate patch, to avoid delaying this series.<br>
<br>
Makes sense?<br>
<br>
</blockquote></div><div><br></div><div class=3D"gmail_default" style=3D"fon=
t-family:&quot;comic sans ms&quot;,sans-serif">I agree, =C2=A0and thanks fo=
r the comments.</div><div><br></div><div class=3D"gmail_default" style=3D"f=
ont-family:&quot;comic sans ms&quot;,sans-serif">Yong</div><div><br></div><=
span class=3D"gmail_signature_prefix">-- </span><br><div dir=3D"ltr" class=
=3D"gmail_signature"><div dir=3D"ltr"><font face=3D"comic sans ms, sans-ser=
if">Best regards</font></div></div></div>

--00000000000087581c0611c61f30--

