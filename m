Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 086C9C9833E
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 10:53:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xB8yW-00061a-Uf; Mon, 28 Sep 2026 06:52:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xB8xk-0005zN-RX
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 06:52:00 -0400
Received: from mail-ed2-x0e.google.com ([2a00:1450:4864:33::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xB8xh-0005oA-4t
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 06:51:58 -0400
Received: by mail-ed2-x0e.google.com with SMTP id
 4fb4d7f45d1cf-6aaf5e6878fso3566051a12.3
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 03:51:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790592715; cv=none;
 d=google.com; s=arc-20260327;
 b=HLxFiNRa0L6WoZpeztfioR2LO/YBq87naVX+d6nJans0RiAp5LWn2WcActkShHk0gX
 1l25mnPMtE7GmalRurbcTzZdHxaWiW+HsCdMtd75AR7NNlaRJPP0PRbTrFNVHz6OPmfW
 GC+yzi2UOLyJtdpjaZVJ9cTXyiHQ84AKZVWeYi7uZM3oz1CIalmY+WD3BCh5TdgO4g2L
 adE6vGbeOvvaDTusIz3hcP3lJMQ2YZsdDEwXn7IEOjzaQaMDMSFWHl1NF0gMbohcBZeK
 na86qY8q0C4z1ya2mGwJAcKCsqyIGTMOadCI4Jn42ppFYmuB7+pOzVg18vc0Fez/kSZS
 wQxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:reply-to:in-reply-to:references
 :mime-version:dkim-signature;
 bh=dkScZIslhglrv8pC/q+zW+v7BV22OaNiE1eeH22q0ZE=;
 fh=BSYjhzMm/AoKmImKM7uBH+TLDMqTHw4ZhKqxjidybNk=;
 b=VClaUUTwEhN2N/e1OVdS8zLnbfLsuwfTcAslSiootkQFKmvmyenVBUufCLBq4XxWUr
 XOJX2g39KyOkkbwNcoKC4U1Oabc1T/T63zcb94vRrPX2QzwrRktX41CFf2RZCIowVq//
 ih6HdJ/1hsseEl5E4I5v22MmPCUloInra12sv3fAXjlOu7urcuLCzPR7l7bo9vWkZndj
 nN6FtWYt0HBCIdz+KaV7Wyn0qM1xhRQ8ehDHINwWr8l7h5RiElLrkHdoNNFenUYdA088
 tC4Y1UABOcyVV9//n01ibpiOCO15SMPqPGanM1cYbq7u9BgWLPeDfxue0kanf1sJ7cJn
 agkQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790592715; x=1791197515; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:reply-to
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dkScZIslhglrv8pC/q+zW+v7BV22OaNiE1eeH22q0ZE=;
 b=czG5tbwjKS0KFTiIyCn2R8rNi3wmiuUojrjYxS+40Z1VBJ9NhAW2o7XNbxnV9gWYZh
 65BugwU/Wdh5cCKywBjCn5u/8LVli5mpbTXKdymA4b0biovKkw1lAk3lbk8eA7Vd47Mz
 DWnm4V3cuzICLUafXF79sd16dBSyXCmkdQzSCyu7Lz/CiF9B0kPT7lk2alueuaU/Q4G5
 8gidjFnQ6kc4t820CHS1nC5LJwV+TCpVO33YXin85P/Ix+PuQMhGIApvC1gQbBd5fath
 7MwBdp0L2lxf2f+V+CRIK3mVBSOcoCo212mlPFjiZSArGSqhI8qnfVF7vX0RgguIrVee
 1elg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790592715; x=1791197515;
 h=content-type:cc:to:subject:message-id:date:from:reply-to
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=dkScZIslhglrv8pC/q+zW+v7BV22OaNiE1eeH22q0ZE=;
 b=LduWrTfiHnwcoN5guxsFmY6Kl0qIPqaHxCo0D8/IM5fta531X2x2RMFwxRRfXmWBS5
 p16Je0NVg1EsfjVmuQ7Ui9gBxG7L63SKlrogbjllI6vcVum6vefnxXqHme3rguDW16Cy
 vzD04GDJj0NJdVNPRQFnM15+oiADHgUQGstT67KjIf6Qbn+ACZ3FW7xA+BYkQqAW1Iw6
 Pj6rjT7hjjWMcjK7pL1q808UKsMN/osfkwLj0iTM4H+yRBS1eSk39K2i78twjHdoHZrT
 SNGihIyi0mdwh2fa+LuuoIcZz4ovZ9msdGvSwmzFxJZmnLPrwfc1uV709rODiQxl+2PW
 YtTA==
X-Forwarded-Encrypted: i=1;
 AKwUvByT2vQ7N80eO+5Iyxw+cNYVTVRRqsyI6jMt9VoskzmoH3XpscLWXYaPEjockAbM/gzQMEn2vSoJ2XdR@nongnu.org
X-Gm-Message-State: AFq9FYIJNgwEaJaYt2inVbt/13L9/4ZDkMyQX00fWCiTFRpxUZNzL+KF
 1LvG1DgYJE5O2/mKDknAgsrnBlC9mTcaFT0u8pVLu4hrSNV+DzzW0e/HqGQi9z94w94YhYrLYOW
 5CZ37ZTfjPKEfZF2GMpqzMN+Uo/VdTEM=
X-Gm-Gg: AYBFou2IXXahoCUv5/SFpm+7xoRKC/Mk3xnNlYJqhKwh+pT5Y9BQappQ56z9Wch+nzJ
 i+2shC1tXi3MziK3YNha3jPoqI5plMqGY7aFr8zlP/hBlRWT5fWFRZivfURqi3/4KkFWxoUgdWg
 j6mDoro8+x1uBYw5mbXyMFHQdRTd3foIWfR9ZoaHwd1TEvJOkPQjk9bvVJRPai7mVFg9AxbTjOH
 KGCwJg4SaNIL5XMqbpgy7R6T8E9F01qrUVx0qU6NLxJCeju7mXmGYjyVWNlEvSsj8yJKU7UDgcr
 lLDEUZKxxtWwkjg1gBBUCzqy86CSuSaCBm/uLuX89Cf47EkXxZGawqM=
X-Received: by 2002:a05:6402:3509:b0:6aa:f74b:dc07 with SMTP id
 4fb4d7f45d1cf-6aaf74bddffmr6044537a12.17.1790592715205; Mon, 28 Sep 2026
 03:51:55 -0700 (PDT)
MIME-Version: 1.0
References: <20260926070057.1234-1-luoyonggang@gmail.com>
 <20260926070057.1234-47-luoyonggang@gmail.com>
 <aro93NuZBXYGbD33@redhat.com>
 <87e7c5ae-c78c-4a47-b9ba-9851ce5757d9@oss.qualcomm.com>
In-Reply-To: <87e7c5ae-c78c-4a47-b9ba-9851ce5757d9@oss.qualcomm.com>
From: Yonggang Luo <luoyonggang@gmail.com>
Date: Mon, 28 Sep 2026 18:51:41 +0800
X-Gm-Features: AclHuK_NzwBy9OUNy1ovaC1Is2WdhJLFhxg2al37b3kU6I6KtouPyZ1JuIut_-Y
Message-ID: <CAE2XoE9qsZZ+AnfGQ797SQj5yXP8SDOZyxYoKP=oh57UPFqq0Q@mail.gmail.com>
Subject: Re: [PATCH v4 46/55] qapi: add query-targets
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 qemu-arm@nongnu.org, kvm@vger.kernel.org, Thomas Huth <thuth@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000ba30fa065c88dae5"
Received-SPF: pass client-ip=2a00:1450:4864:33::e;
 envelope-from=luoyonggang@gmail.com; helo=mail-ed2-x0e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, SPF_HELO_NONE=0.001,
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
Reply-To: luoyonggang@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

--000000000000ba30fa065c88dae5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2026 at 6:39=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 <
philmd@oss.qualcomm.com> wrote:
>
> On 28/9/26 12:13, Daniel P. Berrang=C3=83=C2=A9 wrote:
> > On Sat, Sep 26, 2026 at 03:00:45PM +0800, Yonggang Luo wrote:
> >> query-targets lists each linked target, including none, with its
> >> arch, endianness, and the machines that target accepts.
> >>
> >> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> >> ---
> >>   hw/core/machine-qmp-cmds.c | 30 ++++++++++++++++++++++++++++++
> >>   qapi/machine.json          | 35 +++++++++++++++++++++++++++++++++++
> >>   2 files changed, 65 insertions(+)
> >
> >
> >> diff --git a/qapi/machine.json b/qapi/machine.json
> >> index 6aaa2af709a..d8cdea6203e 100644
> >> --- a/qapi/machine.json
> >> +++ b/qapi/machine.json
> >> @@ -307,6 +307,41 @@
> >>   ##
> >>   { 'command': 'query-target', 'returns': 'QemuTargetInfo' }
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
>
> Why do we want to expose endianness, and what endianness to
> expose? Endianness is a runtime bit state of CPUs. Sometime
> this bit is hardwired but that is an implementation detail.

For some targets it's, but for some targets it's not. for example

mips-softmmu.mak
mipsel-softmmu.mak
mips64el-softmmu.mak
mips64-softmmu.mak


mips64el-softmmu.mak
mips64-softmmu.mak
only differ the endianless

>
> See commit 0e2c5647d92 and surrounding for MicroBlaze for
> example.



--
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--000000000000ba30fa065c88dae5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><br>On Mon, Sep 28, 2026 at 6:39=E2=80=AFPM Philippe M=
athieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@oss.qualcomm.com">philmd@oss=
.qualcomm.com</a>&gt; wrote:<br>&gt;<br>&gt; On 28/9/26 12:13, Daniel P. Be=
rrang=C3=83=C2=A9 wrote:<br>&gt; &gt; On Sat, Sep 26, 2026 at 03:00:45PM +0=
800, Yonggang Luo wrote:<br>&gt; &gt;&gt; query-targets lists each linked t=
arget, including none, with its<br>&gt; &gt;&gt; arch, endianness, and the =
machines that target accepts.<br>&gt; &gt;&gt;<br>&gt; &gt;&gt; Signed-off-=
by: Yonggang Luo &lt;<a href=3D"mailto:luoyonggang@gmail.com">luoyonggang@g=
mail.com</a>&gt;<br>&gt; &gt;&gt; ---<br>&gt; &gt;&gt; =C2=A0 hw/core/machi=
ne-qmp-cmds.c | 30 ++++++++++++++++++++++++++++++<br>&gt; &gt;&gt; =C2=A0 q=
api/machine.json =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 35 +++++++++++++++++++=
++++++++++++++++<br>&gt; &gt;&gt; =C2=A0 2 files changed, 65 insertions(+)<=
br>&gt; &gt;<br>&gt; &gt;<br>&gt; &gt;&gt; diff --git a/qapi/machine.json b=
/qapi/machine.json<br>&gt; &gt;&gt; index 6aaa2af709a..d8cdea6203e 100644<b=
r>&gt; &gt;&gt; --- a/qapi/machine.json<br>&gt; &gt;&gt; +++ b/qapi/machine=
.json<br>&gt; &gt;&gt; @@ -307,6 +307,41 @@<br>&gt; &gt;&gt; =C2=A0 ##<br>&=
gt; &gt;&gt; =C2=A0 { &#39;command&#39;: &#39;query-target&#39;, &#39;retur=
ns&#39;: &#39;QemuTargetInfo&#39; }<br>&gt; &gt;&gt; =C2=A0<br>&gt; &gt;&gt=
; +##<br>&gt; &gt;&gt; +# @TargetMachines:<br>&gt; &gt;&gt; +#<br>&gt; &gt;=
&gt; +# One registered system target and the machines that can run on it.<b=
r>&gt; &gt;&gt; +#<br>&gt; &gt;&gt; +# @arch: the target architecture<br>&g=
t; &gt;&gt; +#<br>&gt; &gt;&gt; +# @endianness: the target endianness<br>&g=
t; &gt;&gt; +#<br>&gt; &gt;&gt; +# @machines: machine type names, not alias=
es<br>&gt; &gt;&gt; +#<br>&gt; &gt;&gt; +# Since: 11.2<br>&gt; &gt;&gt; +##=
<br>&gt; &gt;&gt; +{ &#39;struct&#39;: &#39;TargetMachines&#39;,<br>&gt; &g=
t;&gt; + =C2=A0&#39;data&#39;: { &#39;arch&#39;: &#39;SysEmuTarget&#39;,<br=
>&gt; &gt;&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;endianness&#=
39;: &#39;EndianMode&#39;,<br>&gt; &gt;&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0&#39;machines&#39;: [&#39;str&#39;] } }<br>&gt; &gt;<br>&gt; &=
gt; We already have =C2=A0&#39;QemuTargetInfo&#39; struct which is used<br>=
&gt; &gt; with &#39;query-target&#39;, that should also be used with the<br=
>&gt; &gt; new &#39;query-targets&#39; command.<br>&gt; &gt;<br>&gt; &gt; W=
e need to add the &#39;endianness&#39; field to QemuTargetInfo.<br>&gt;<br>=
&gt; Why do we want to expose endianness, and what endianness to<br>&gt; ex=
pose? Endianness is a runtime bit state of CPUs. Sometime<br>&gt; this bit =
is hardwired but that is an implementation detail.<br><br>For some targets =
it&#39;s, but for some targets it&#39;s not. for example <br><br>mips-softm=
mu.mak<br>mipsel-softmmu.mak<br>mips64el-softmmu.mak<br>mips64-softmmu.mak<=
br><br><br>mips64el-softmmu.mak<br>mips64-softmmu.mak<br>only differ the en=
dianless<div><br>&gt;<br>&gt; See commit 0e2c5647d92 and surrounding for Mi=
croBlaze for<br>&gt; example.<br><br><br><br>--<br>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0=E6=AD=A4=E8=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br=
>Yours<br>=C2=A0 =C2=A0 sincerely,<br>Yonggang Luo</div></div>

--000000000000ba30fa065c88dae5--

