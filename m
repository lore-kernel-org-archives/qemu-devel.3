Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86F90C9833F
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 12:11:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBABN-0001Qa-4F; Mon, 28 Sep 2026 08:10:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xBAB4-0001Fm-5x
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 08:09:58 -0400
Received: from mail-ed2-x0e.google.com ([2a00:1450:4864:33::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xBAB1-00066Z-At
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 08:09:49 -0400
Received: by mail-ed2-x0e.google.com with SMTP id
 4fb4d7f45d1cf-6aaf8415866so3396670a12.0
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 05:09:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790597386; cv=none;
 d=google.com; s=arc-20260327;
 b=IhHXM30TfLzuQgEq5XBK+FUtR97uwvzTeVVZEmIUWqKUZ1DL/UFI3IJ23cJatL9l7v
 aUtfoY1ibuHhaIL5u9Y9yzF5pqyL6TorZa8SEgRXHRaaUXNuXxVqUoLhHcdqpFFJc5Oz
 yeuNopnlDRTDyekQRQW9j+NGdAwR/JN729hSgfyBrrZtMbvQkdcrTBseGnbf1xkrMMVu
 Z1dgkV867+tvkfYTYSgpH2aExyIykKtlpt7/jkSOo5faz1y9OV30D85exarxRn43L20d
 OwOWqflwU2CHof9cTbpQnVw4Tst5IG2iRKYJjTtgx3bQfdA46vB4Np8pFbq2vJG8jcNh
 COzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:reply-to:in-reply-to:references
 :mime-version:dkim-signature;
 bh=lv8eq6cC3RbKEeWLLOvdaQWkcywJQHl8hxwyo4VdTFo=;
 fh=6tgkav35jKpJLML6XO6h/q4D4j+WYCrszxnjN+2ni/I=;
 b=ithKOTJuUswDqN0B5mnn+4ij5luUqcrtLV5IOnEvd+0L0r1cjfCFjPYr6j/WgXB+da
 Za4vlVzUhfLCnz0HY32WH3LhjzXopdUwcwVdBFi63rGBeO1qS54sR5W63q2fMlo0wAts
 jXD6CMjjGXPj+kol7YcWlUl0TpbQAXbGb/Ye0yICZgWaFaPbtw6MTbyxuVq1K/1rZWai
 mXxVOvJ7PDB8KOyehQra4d9zmRDwmiGgHi4XHa46DMvV4WDzPtMXZBcrB/HNwVjVid9i
 PZJP+avgo9OPwdrCElDXp+407h34yDQyMsoqL8KHf+KGcQ5k/ZOkybaiSOZmDQkGEQ7s
 RvWg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790597386; x=1791202186; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:reply-to
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lv8eq6cC3RbKEeWLLOvdaQWkcywJQHl8hxwyo4VdTFo=;
 b=blimBIRnm9nymJGSyVW3l5c8/ID+7GCUARP0Mh+t5ZBQMCSx2qwCQeQvX3pWX4OJG5
 Kr0Ah52gcewN1fGTfuF2Vu4wSYYuwvA3Otl5LJzdSzAHpyOT2/LxXAtOYNmhqN/YUHAW
 nZQiA3qgyafaMWPTHfxrkeOFnmv1NTnzy9LGIto3xCZy4MFmroApGNnRfBkEeMGfN36A
 z5SAMVfJZEHcGHXOTuOMhcduVSIfz33y8XZsyJnU4gnAlxD+XGKy2Y7m0Y+laGFMO3NK
 cBKQh5yM9TAizsKc+1OuBEqmLopE1LNdx9LpbS+aopTQzPV9hDm4EWUqkg/ciXhleOIm
 x5oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790597386; x=1791202186;
 h=content-type:cc:to:subject:message-id:date:from:reply-to
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=lv8eq6cC3RbKEeWLLOvdaQWkcywJQHl8hxwyo4VdTFo=;
 b=aEE+HZDUyWXz/BWXLOxkWzzJcnuxTp6JSRDmKloD6Qpls5c8gD6Zf3wVP5oJHsyYLA
 9jfvp7cuxW6tdF5HfzfTEsAInSrSH8Y67aPNfqcRsqUI73Pkc53q70Kibq0A25CRjwtO
 pzCJFIDtG6TwELSn27sIzF+5NCVG2Vv2uOvFjCFs/Xx8M9XY8zfmi1E/aHkBDE4A1uGn
 w61iWhBMCwpUbOSC/ji4JdGZdGqnRWFO4/xjwNk2wP80iryMGAxEqcCQ59XC/hP34ufm
 0OD74OGNIQpLeNPYqWwuTvdTndrxXhroSgCs435CxlmqHOxhwp8iq15p6wFV2T/2hzly
 aVtw==
X-Forwarded-Encrypted: i=1;
 AKwUvByQ3AyWlv7XwHNqaSZ7mE7/qfyKtfFXM6GkStJxF8NiW1daKpxDNhDOyHahcURff1x/Ph8cIhT8KjlB@nongnu.org
X-Gm-Message-State: AFq9FYI9oUabctrsEby0YPYOgyhkeYlpW4Ww6nUNq753KdOy1VsdIaPH
 p8nSdQuSg0tXMaxd1NlrFhjCXcstGdhYNhNwlNxQd6LyInIPVsiS9/Wy/zMahudfMVqZw+j5BK1
 zcY2emn/2YWxFf2EcSWnC5kEdFqHFrLQ=
X-Gm-Gg: AYBFou02+73Whbc8ls7x/FfTjiAh+FF/TQ4xOcaziKF+ETt/nNjJsfu6rGMm9LH820H
 KFOikiwoOIoYBuUuaapaGo1qRJAxJgRdQw3tXO4FjfEibA84hR5JBO4i+kZNsQzH/j5WCmQR/86
 xxej0lEQ9nyRwsIV2GBgqTo0bUhkbfEj41ibQI92IovB59AQO0i6XvVTRH4yePL21qIhfKsQDvL
 Z76V4InJqbxtY+mRDnScGalulElp0HXV1G1pi/HILcBiYzi62j4y2gah9TMXYDO0TE6pNgDXo7x
 DDwcT5bqpcoxfcbQBYnCYBb9pgO7qNXcJVVx7Scvdi/5flgA2CUGo0oB
X-Received: by 2002:a05:6402:4408:b0:6ac:86e8:315c with SMTP id
 4fb4d7f45d1cf-6ac86e83e96mr1883116a12.7.1790597385619; Mon, 28 Sep 2026
 05:09:45 -0700 (PDT)
MIME-Version: 1.0
References: <20260926070057.1234-1-luoyonggang@gmail.com>
 <20260926070057.1234-47-luoyonggang@gmail.com>
 <aro93NuZBXYGbD33@redhat.com> <87se2tfurc.fsf@pond.sub.org>
In-Reply-To: <87se2tfurc.fsf@pond.sub.org>
From: Yonggang Luo <luoyonggang@gmail.com>
Date: Mon, 28 Sep 2026 20:09:32 +0800
X-Gm-Features: AclHuK-lr0CQJe9GVF2ohmIzHDDrJebrCQh-cB-uCrsgatVqXOlM4kwi_n6_KX0
Message-ID: <CAE2XoE9AdFG3htfw8Ften-R3nAz_RHFE1kZaA6nZUGX2WN8_3g@mail.gmail.com>
Subject: Re: [PATCH v4 46/55] qapi: add query-targets
To: Markus Armbruster <armbru@redhat.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 qemu-arm@nongnu.org, kvm@vger.kernel.org
Content-Type: multipart/alternative; boundary="0000000000001b122c065c89f10d"
Received-SPF: pass client-ip=2a00:1450:4864:33::e;
 envelope-from=luoyonggang@gmail.com; helo=mail-ed2-x0e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Reply-To: luoyonggang@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

--0000000000001b122c065c89f10d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2026 at 8:03=E2=80=AFPM Markus Armbruster <armbru@redhat.co=
m> wrote:
>
> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>
> > On Sat, Sep 26, 2026 at 03:00:45PM +0800, Yonggang Luo wrote:
> >> query-targets lists each linked target, including none, with its
> >> arch, endianness, and the machines that target accepts.
> >>
> >> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> >> ---
> >>  hw/core/machine-qmp-cmds.c | 30 ++++++++++++++++++++++++++++++
> >>  qapi/machine.json          | 35 +++++++++++++++++++++++++++++++++++
> >>  2 files changed, 65 insertions(+)
> >
> >
> >> diff --git a/qapi/machine.json b/qapi/machine.json
> >> index 6aaa2af709a..d8cdea6203e 100644
> >> --- a/qapi/machine.json
> >> +++ b/qapi/machine.json
> >> @@ -307,6 +307,41 @@
> >>  ##
> >>  { 'command': 'query-target', 'returns': 'QemuTargetInfo' }
> >>
> >> +##
> >> +# @TargetMachines:
> >> +#
> >> +# One registered system target and the machines that can run on it.
> >> +#
> >> +# @arch: the target architecture
> >> +#
> >> +# @endianness: the target endianness
> >> +#
> >> +# @machines: machine type names, not aliases
> >> +#
> >> +# Since: 11.2
> >> +##
> >> +{ 'struct': 'TargetMachines',
> >> +  'data': { 'arch': 'SysEmuTarget',
> >> +            'endianness': 'EndianMode',
> >> +            'machines': ['str'] } }
> >
> > We already have  'QemuTargetInfo' struct which is used
> > with 'query-target', that should also be used with the
> > new 'query-targets' command.
> >
> > We need to add the 'endianness' field to QemuTargetInfo.
> >
> > I don't think that we need to report machines though.
> > We already have 'query-machines' which gives much broader
> > information on the machines. "MachineInfo" needs to
> > gain
> >
> >    "targets": ["SysEmuTarget"]
> >
> > to list which target(s) a machine can be used with.
>
> Do we need query-targets at all?  What information does it provide that
> cannot easily be computed from query-machines once we add @target and
> @endiannes to MachineInfo?

It's a matrix by using different things as the primary key.
For query-machines, the machine name is the primary key.
For query-targets, the target name is the primary key. even though we can
compute
targets from query-machine, but that would be complicated. if query-targets
are really not wanted.
I'll drop it and rewrite tests with query-machine instead..


>
> >> +
> >> +##
> >> +# @query-targets:
> >> +#
> >> +# Return each target linked into this QEMU binary and the machines
> >> +# whose availability check accepts that target.
> >> +#
> >> +# Since: 11.2
> >> +#
> >> +# .. qmp-example::
> >> +#
> >> +#     -> { "execute": "query-targets" }
> >> +#     <- { "return": [ { "arch": "aarch64", "endianness": "little",
> >> +#                        "machines": [ "virt" ] } ] }
> >> +##
> >> +{ 'command': 'query-targets',
> >> +  'returns': ['TargetMachines'] }
> >
> >
> > With regards,
> > Daniel
>


--
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--0000000000001b122c065c89f10d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><br>On Mon, Sep 28, 2026 at 8:03=E2=80=AFPM Markus Arm=
bruster &lt;<a href=3D"mailto:armbru@redhat.com">armbru@redhat.com</a>&gt; =
wrote:<br>&gt;<br>&gt; Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berran=
ge@redhat.com">berrange@redhat.com</a>&gt; writes:<br>&gt;<br>&gt; &gt; On =
Sat, Sep 26, 2026 at 03:00:45PM +0800, Yonggang Luo wrote:<br>&gt; &gt;&gt;=
 query-targets lists each linked target, including none, with its<br>&gt; &=
gt;&gt; arch, endianness, and the machines that target accepts.<br>&gt; &gt=
;&gt;<br>&gt; &gt;&gt; Signed-off-by: Yonggang Luo &lt;<a href=3D"mailto:lu=
oyonggang@gmail.com">luoyonggang@gmail.com</a>&gt;<br>&gt; &gt;&gt; ---<br>=
&gt; &gt;&gt; =C2=A0hw/core/machine-qmp-cmds.c | 30 +++++++++++++++++++++++=
+++++++<br>&gt; &gt;&gt; =C2=A0qapi/machine.json =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0| 35 +++++++++++++++++++++++++++++++++++<br>&gt; &gt;&gt; =C2=A02=
 files changed, 65 insertions(+)<br>&gt; &gt;<br>&gt; &gt;<br>&gt; &gt;&gt;=
 diff --git a/qapi/machine.json b/qapi/machine.json<br>&gt; &gt;&gt; index =
6aaa2af709a..d8cdea6203e 100644<br>&gt; &gt;&gt; --- a/qapi/machine.json<br=
>&gt; &gt;&gt; +++ b/qapi/machine.json<br>&gt; &gt;&gt; @@ -307,6 +307,41 @=
@<br>&gt; &gt;&gt; =C2=A0##<br>&gt; &gt;&gt; =C2=A0{ &#39;command&#39;: &#3=
9;query-target&#39;, &#39;returns&#39;: &#39;QemuTargetInfo&#39; }<br>&gt; =
&gt;&gt;<br>&gt; &gt;&gt; +##<br>&gt; &gt;&gt; +# @TargetMachines:<br>&gt; =
&gt;&gt; +#<br>&gt; &gt;&gt; +# One registered system target and the machin=
es that can run on it.<br>&gt; &gt;&gt; +#<br>&gt; &gt;&gt; +# @arch: the t=
arget architecture<br>&gt; &gt;&gt; +#<br>&gt; &gt;&gt; +# @endianness: the=
 target endianness<br>&gt; &gt;&gt; +#<br>&gt; &gt;&gt; +# @machines: machi=
ne type names, not aliases<br>&gt; &gt;&gt; +#<br>&gt; &gt;&gt; +# Since: 1=
1.2<br>&gt; &gt;&gt; +##<br>&gt; &gt;&gt; +{ &#39;struct&#39;: &#39;TargetM=
achines&#39;,<br>&gt; &gt;&gt; + =C2=A0&#39;data&#39;: { &#39;arch&#39;: &#=
39;SysEmuTarget&#39;,<br>&gt; &gt;&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0&#39;endianness&#39;: &#39;EndianMode&#39;,<br>&gt; &gt;&gt; + =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;machines&#39;: [&#39;str&#39;] }=
 }<br>&gt; &gt;<br>&gt; &gt; We already have =C2=A0&#39;QemuTargetInfo&#39;=
 struct which is used<br>&gt; &gt; with &#39;query-target&#39;, that should=
 also be used with the<br>&gt; &gt; new &#39;query-targets&#39; command.<br=
>&gt; &gt;<br>&gt; &gt; We need to add the &#39;endianness&#39; field to Qe=
muTargetInfo.<br>&gt; &gt;<br>&gt; &gt; I don&#39;t think that we need to r=
eport machines though.<br>&gt; &gt; We already have &#39;query-machines&#39=
; which gives much broader<br>&gt; &gt; information on the machines. &quot;=
MachineInfo&quot; needs to<br>&gt; &gt; gain<br>&gt; &gt;<br>&gt; &gt; =C2=
=A0 =C2=A0&quot;targets&quot;: [&quot;SysEmuTarget&quot;]<br>&gt; &gt;<br>&=
gt; &gt; to list which target(s) a machine can be used with.<br>&gt;<br>&gt=
; Do we need query-targets at all?=C2=A0 What information does it provide t=
hat<br>&gt; cannot easily be computed from query-machines once we add @targ=
et and<br>&gt; @endiannes to MachineInfo?<br><br>It&#39;s a matrix by using=
 different things as the primary key.<br>For query-machines, the machine na=
me is the primary key.<br>For query-targets, the target name is the primary=
 key. even though we can compute<br>targets from query-machine, but that wo=
uld be complicated. if query-targets are really not wanted.<br>I&#39;ll dro=
p it and rewrite tests with query-machine instead..<br><br><br>&gt;<br>&gt;=
 &gt;&gt; +<br>&gt; &gt;&gt; +##<br>&gt; &gt;&gt; +# @query-targets:<br>&gt=
; &gt;&gt; +#<br>&gt; &gt;&gt; +# Return each target linked into this QEMU =
binary and the machines<br>&gt; &gt;&gt; +# whose availability check accept=
s that target.<br>&gt; &gt;&gt; +#<br>&gt; &gt;&gt; +# Since: 11.2<br>&gt; =
&gt;&gt; +#<br>&gt; &gt;&gt; +# .. qmp-example::<br>&gt; &gt;&gt; +#<br>&gt=
; &gt;&gt; +# =C2=A0 =C2=A0 -&gt; { &quot;execute&quot;: &quot;query-target=
s&quot; }<br>&gt; &gt;&gt; +# =C2=A0 =C2=A0 &lt;- { &quot;return&quot;: [ {=
 &quot;arch&quot;: &quot;aarch64&quot;, &quot;endianness&quot;: &quot;littl=
e&quot;,<br>&gt; &gt;&gt; +# =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;machines&quot;: [ &quot;virt&qu=
ot; ] } ] }<br>&gt; &gt;&gt; +##<br>&gt; &gt;&gt; +{ &#39;command&#39;: &#3=
9;query-targets&#39;,<br>&gt; &gt;&gt; + =C2=A0&#39;returns&#39;: [&#39;Tar=
getMachines&#39;] }<br>&gt; &gt;<br>&gt; &gt;<br>&gt; &gt; With regards,<br=
>&gt; &gt; Daniel<br>&gt;<br><br><br>--<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0=E6=AD=A4=E8=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br>Yours<=
br>=C2=A0 =C2=A0 sincerely,<br>Yonggang Luo</div>

--0000000000001b122c065c89f10d--

