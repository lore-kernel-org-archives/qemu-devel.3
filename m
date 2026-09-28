Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AABB0CA5FA2
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 11:39:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xB9gz-00083Y-MU; Mon, 28 Sep 2026 07:38:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xB9gx-00082y-BQ
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 07:38:43 -0400
Received: from mail-ed2-x0e.google.com ([2a00:1450:4864:33::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xB9gv-0002We-9R
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 07:38:43 -0400
Received: by mail-ed2-x0e.google.com with SMTP id
 4fb4d7f45d1cf-6aaea178c96so3302766a12.3
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 04:38:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790595519; cv=none;
 d=google.com; s=arc-20260327;
 b=F6K3+vYe31Q/ndZOqBtbHUl4qa6MI9MBJ0fR+NB0l41KpT9VFKgvWSFGcSjjfUpeyL
 sEuu7mirPvalgmsrig62wlpa+8+dkEazZfrr3YX7Qirm8ko11JDtEpsd8TLQSOA6udSh
 222Y4kYrIPSoq/JFajZxSUnD8gMHp2ygEREY+hT2OBTy0L8gaegZY/esBLIKR5Xo4K46
 21EQxXcT/ScOdgdObwPOhsj6vPXTiTWRNcjr6T8ajmsf2HLwUKwnOe7mz7UvW/FXBzvw
 AyVPX35QG7n5KCJv38GLgC6KF/ltKifpC+ar/Lnt0cUNlVW9OZ9MgJ1El6tH8YqNMfqD
 fbpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:reply-to:in-reply-to:references
 :mime-version:dkim-signature;
 bh=7qO7jEHwA4OUWrWsQdikFZSTfu7bq8bn+uja9uOUEk8=;
 fh=GMIWZosCq9PxmxiTrjBTw7+b3faBl9M8wEnYNiEOV0g=;
 b=sf8YtIuBSV/1N2vbjMPGxz98kkW64fFms60Y+ABsigg8o3DwKdaO1NFAK0wCT5jWRC
 BxhB3GtC0V3SRB8QVWAAJJIaWkmFoBNMSm4hPVoRc0OY74q9ItsefNf8lAAoyirx7/UY
 eBY50QZyZ9esg95HRdcUF2B+S0af88dxIObLTSMnVYjZxwEXP2H0ABTFAIxGmo9Bnbed
 oRRC08v7LDvXHnVGdp4p2+enykIDfbTeC9ovLs7xtF3JK/1Um4NFpu/hDMXzC6+MHxd2
 GAgyhHiFheBKK1BKnth1CTJ2WiIyorp0TOX3Xv5prLWN6vvIpTE8FDoFyddlMOUFbS1W
 mEWw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790595519; x=1791200319; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:reply-to
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7qO7jEHwA4OUWrWsQdikFZSTfu7bq8bn+uja9uOUEk8=;
 b=i3FWuAP/a0/2ItVygvRqd+LJFWkXSKpWqhDrIKGQFbEaPQC4NuYKh3J1HC46Zaepz/
 BtmL2hdnQQGLdvjBfONmJREE8NurLYSXmIiyjbMsvUOaWQ4z1heF9tyb/wXVPVVPP6lZ
 3CkIbOnn243RzLO/Z1as+YsyjV6CQ7GoCTgUBborIIgqU7nsAXRvDPP3iQO3ep8j99vj
 EdG+cu99gvWSjDLM6KSI8dyrqCpyYoYnkGA9qg2SY0fIuo/8K4cx9mh0oX/tjlSqjhFI
 9ge2kGH8kG1PoBarcxnd3xp4hf2QxNotZxzoQu+xRC+9ELlc82U9XrZudaIm6gzmMFU9
 zaQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790595519; x=1791200319;
 h=content-type:cc:to:subject:message-id:date:from:reply-to
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=7qO7jEHwA4OUWrWsQdikFZSTfu7bq8bn+uja9uOUEk8=;
 b=TxM0j2jsEH30GzfiBRTAhgO8cGa6aUTp6SaqnWelfnslYVkFrVuB//YHvY57lqG6WQ
 ap9CjznPxTWjRAY7PH4d+k0EpcUeVQYzbCR8m4+VwR3x+bZPVmJtnIkVMskBTlANyrDu
 r8JVYVBeq1/YdirRIUVr76ZBTp7MkhN/2ZgyNj2/q8XGHnUOSa/FKJavQX0+6adLGoUQ
 j6rOik1ZV9s7O6YrMhll01wlzsZyB2iWC9/bKvBTRpoA3n98yLrCrCGVQNa5v+DZmlbY
 LNPx8ICSbvxaqlEjSYew28ErrMI4ek5kCLJ7NwMWrSk+8Sp6lcksfKqIQh2++lxButkb
 XwcA==
X-Forwarded-Encrypted: i=1;
 AKwUvBw3wzy27OSvrmuaag6pL4ssD1A2Rqf+1c1hR3n8woVy7eSWqrWyC/AvY2M8YLpEXCfmjdO1JFQ6ViuU@nongnu.org
X-Gm-Message-State: AFq9FYJ53/gZqG9XGHkcZcnW9R7A2jjLHtZM6PDYmR8DLwSD0YVmvEws
 PonJKtzPZQQpSYuWpyLJdPDFBzTEjNqj1ZBYuR+i6N22cXBIcrqZOZanzXXexpvrBrwg0ZPNjRE
 CdtpiRbQcikMHjBZgWRa2uQciYhB74kc=
X-Gm-Gg: AYBFou3+sXrymViUAwNoFFOUOfTXwrNSwFw/YWk5z4kVPE20p7nnnnaQ7/bQQg4y1pf
 A3H4hH0QSMmRUPujNe08GidfwOzhrZA/y1cadnA96ruaLTQS7aDjwLLiRURnjovtyiF/w5SAkKU
 cvINUASNDIr6zOJu/XIrZKUwnPs2+TLqBA6zHW+0v4YIdDUIsBXAPOeyyxw73OLhfv5bDNLAt5l
 XawLSkRBFgNS9Uj+J6+19DI+srdvCUjNeL9/eCA+pwhF23T/Rs6DsjJAKs/6fANzB5PMOcljZwB
 /oFcWk9fYS2Xq7whElC4aPS5bLA+m/NC3U+CmTWvL7WeSKXHIksfrCI=
X-Received: by 2002:a05:6402:2318:b0:6aa:e729:423 with SMTP id
 4fb4d7f45d1cf-6aae7290ad1mr5016298a12.26.1790595518845; Mon, 28 Sep 2026
 04:38:38 -0700 (PDT)
MIME-Version: 1.0
References: <20260926070057.1234-1-luoyonggang@gmail.com>
 <20260926070057.1234-47-luoyonggang@gmail.com>
 <aro93NuZBXYGbD33@redhat.com>
 <87e7c5ae-c78c-4a47-b9ba-9851ce5757d9@oss.qualcomm.com>
 <CAE2XoE9qsZZ+AnfGQ797SQj5yXP8SDOZyxYoKP=oh57UPFqq0Q@mail.gmail.com>
 <a4b7056e-1651-4167-86e0-e7eaa3941d02@oss.qualcomm.com>
In-Reply-To: <a4b7056e-1651-4167-86e0-e7eaa3941d02@oss.qualcomm.com>
From: Yonggang Luo <luoyonggang@gmail.com>
Date: Mon, 28 Sep 2026 19:38:26 +0800
X-Gm-Features: AclHuK_XhGMu1KY8MUrPqLq8CsGd4GT9s4oLjix7cR9RGNVYEmbplzAsJP0a5Vs
Message-ID: <CAE2XoE8BD6V0jeAVWeZ4e_ftgqeKBsW4P5P_UX0T0AjA4MWP0Q@mail.gmail.com>
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
Content-Type: multipart/alternative; boundary="000000000000d657be065c898119"
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

--000000000000d657be065c898119
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2026 at 7:34=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 <
philmd@oss.qualcomm.com> wrote:
>
> On 28/9/26 12:51, Yonggang Luo wrote:
> > On Mon, Sep 28, 2026 at 6:39=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 <
> > philmd@oss.qualcomm.com> wrote:
> >>
> >> On 28/9/26 12:13, Daniel P. Berrang=C3=83=C2=A9 wrote:
> >>> On Sat, Sep 26, 2026 at 03:00:45PM +0800, Yonggang Luo wrote:
> >>>> query-targets lists each linked target, including none, with its
> >>>> arch, endianness, and the machines that target accepts.
> >>>>
> >>>> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> >>>> ---
> >>>>    hw/core/machine-qmp-cmds.c | 30 ++++++++++++++++++++++++++++++
> >>>>    qapi/machine.json          | 35
+++++++++++++++++++++++++++++++++++
> >>>>    2 files changed, 65 insertions(+)
> >>>
> >>>
> >>>> diff --git a/qapi/machine.json b/qapi/machine.json
> >>>> index 6aaa2af709a..d8cdea6203e 100644
> >>>> --- a/qapi/machine.json
> >>>> +++ b/qapi/machine.json
> >>>> @@ -307,6 +307,41 @@
> >>>>    ##
> >>>>    { 'command': 'query-target', 'returns': 'QemuTargetInfo' }
> >>>>
> >>>> +##
> >>>> +# @TargetMachines:
> >>>> +#
> >>>> +# One registered system target and the machines that can run on it.
> >>>> +#
> >>>> +# @arch: the target architecture
> >>>> +#
> >>>> +# @endianness: the target endianness
> >>>> +#
> >>>> +# @machines: machine type names, not aliases
> >>>> +#
> >>>> +# Since: 11.2
> >>>> +##
> >>>> +{ 'struct': 'TargetMachines',
> >>>> +  'data': { 'arch': 'SysEmuTarget',
> >>>> +            'endianness': 'EndianMode',
> >>>> +            'machines': ['str'] } }
> >>>
> >>> We already have  'QemuTargetInfo' struct which is used
> >>> with 'query-target', that should also be used with the
> >>> new 'query-targets' command.
> >>>
> >>> We need to add the 'endianness' field to QemuTargetInfo.
> >>
> >> Why do we want to expose endianness, and what endianness to
> >> expose? Endianness is a runtime bit state of CPUs. Sometime
> >> this bit is hardwired but that is an implementation detail.
> >
> > For some targets it's, but for some targets it's not. for example
> >
> > mips-softmmu.mak
> > mipsel-softmmu.mak
> > mips64el-softmmu.mak
> > mips64-softmmu.mak
> >
> >
> > mips64el-softmmu.mak
> > mips64-softmmu.mak
> > only differ the endianless
> If you look at git / mailing list history you'll see I spent more
> than a year unifying QEMU endianness. It was too much work for a
> single person so we decided to reduce the scope to ARM + MicroBlaze
> for single binary and we got MicroBlaze unified. We don't want
> an endianness-specific single binary. I'm not sure what you are
> trying to build, you didn't clearly explained what is your goal here.
>
> You can find series unifying endianness for MIPS, not merged because
> more things need to be addressed and not the priority.

It's only for testing. if we can not uniquely identify a target, then the
testing program won't work properly.
if  endianness  needs to be removed in future, let's defer that?



--
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--000000000000d657be065c898119
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><br>On Mon, Sep 28, 2026 at 7:34=E2=80=AFPM Philippe M=
athieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@oss.qualcomm.com">philmd@oss=
.qualcomm.com</a>&gt; wrote:<br>&gt;<br>&gt; On 28/9/26 12:51, Yonggang Luo=
 wrote:<br>&gt; &gt; On Mon, Sep 28, 2026 at 6:39=E2=80=AFPM Philippe Mathi=
eu-Daud=C3=A9 &lt;<br>&gt; &gt; <a href=3D"mailto:philmd@oss.qualcomm.com">=
philmd@oss.qualcomm.com</a>&gt; wrote:<br>&gt; &gt;&gt;<br>&gt; &gt;&gt; On=
 28/9/26 12:13, Daniel P. Berrang=C3=83=C2=A9 wrote:<br>&gt; &gt;&gt;&gt; O=
n Sat, Sep 26, 2026 at 03:00:45PM +0800, Yonggang Luo wrote:<br>&gt; &gt;&g=
t;&gt;&gt; query-targets lists each linked target, including none, with its=
<br>&gt; &gt;&gt;&gt;&gt; arch, endianness, and the machines that target ac=
cepts.<br>&gt; &gt;&gt;&gt;&gt;<br>&gt; &gt;&gt;&gt;&gt; Signed-off-by: Yon=
ggang Luo &lt;<a href=3D"mailto:luoyonggang@gmail.com">luoyonggang@gmail.co=
m</a>&gt;<br>&gt; &gt;&gt;&gt;&gt; ---<br>&gt; &gt;&gt;&gt;&gt; =C2=A0 =C2=
=A0hw/core/machine-qmp-cmds.c | 30 ++++++++++++++++++++++++++++++<br>&gt; &=
gt;&gt;&gt;&gt; =C2=A0 =C2=A0qapi/machine.json =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0| 35 +++++++++++++++++++++++++++++++++++<br>&gt; &gt;&gt;&gt;&gt; =C2=
=A0 =C2=A02 files changed, 65 insertions(+)<br>&gt; &gt;&gt;&gt;<br>&gt; &g=
t;&gt;&gt;<br>&gt; &gt;&gt;&gt;&gt; diff --git a/qapi/machine.json b/qapi/m=
achine.json<br>&gt; &gt;&gt;&gt;&gt; index 6aaa2af709a..d8cdea6203e 100644<=
br>&gt; &gt;&gt;&gt;&gt; --- a/qapi/machine.json<br>&gt; &gt;&gt;&gt;&gt; +=
++ b/qapi/machine.json<br>&gt; &gt;&gt;&gt;&gt; @@ -307,6 +307,41 @@<br>&gt=
; &gt;&gt;&gt;&gt; =C2=A0 =C2=A0##<br>&gt; &gt;&gt;&gt;&gt; =C2=A0 =C2=A0{ =
&#39;command&#39;: &#39;query-target&#39;, &#39;returns&#39;: &#39;QemuTarg=
etInfo&#39; }<br>&gt; &gt;&gt;&gt;&gt;<br>&gt; &gt;&gt;&gt;&gt; +##<br>&gt;=
 &gt;&gt;&gt;&gt; +# @TargetMachines:<br>&gt; &gt;&gt;&gt;&gt; +#<br>&gt; &=
gt;&gt;&gt;&gt; +# One registered system target and the machines that can r=
un on it.<br>&gt; &gt;&gt;&gt;&gt; +#<br>&gt; &gt;&gt;&gt;&gt; +# @arch: th=
e target architecture<br>&gt; &gt;&gt;&gt;&gt; +#<br>&gt; &gt;&gt;&gt;&gt; =
+# @endianness: the target endianness<br>&gt; &gt;&gt;&gt;&gt; +#<br>&gt; &=
gt;&gt;&gt;&gt; +# @machines: machine type names, not aliases<br>&gt; &gt;&=
gt;&gt;&gt; +#<br>&gt; &gt;&gt;&gt;&gt; +# Since: 11.2<br>&gt; &gt;&gt;&gt;=
&gt; +##<br>&gt; &gt;&gt;&gt;&gt; +{ &#39;struct&#39;: &#39;TargetMachines&=
#39;,<br>&gt; &gt;&gt;&gt;&gt; + =C2=A0&#39;data&#39;: { &#39;arch&#39;: &#=
39;SysEmuTarget&#39;,<br>&gt; &gt;&gt;&gt;&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0&#39;endianness&#39;: &#39;EndianMode&#39;,<br>&gt; &gt;&g=
t;&gt;&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;machines&#39;: [=
&#39;str&#39;] } }<br>&gt; &gt;&gt;&gt;<br>&gt; &gt;&gt;&gt; We already hav=
e =C2=A0&#39;QemuTargetInfo&#39; struct which is used<br>&gt; &gt;&gt;&gt; =
with &#39;query-target&#39;, that should also be used with the<br>&gt; &gt;=
&gt;&gt; new &#39;query-targets&#39; command.<br>&gt; &gt;&gt;&gt;<br>&gt; =
&gt;&gt;&gt; We need to add the &#39;endianness&#39; field to QemuTargetInf=
o.<br>&gt; &gt;&gt;<br>&gt; &gt;&gt; Why do we want to expose endianness, a=
nd what endianness to<br>&gt; &gt;&gt; expose? Endianness is a runtime bit =
state of CPUs. Sometime<br>&gt; &gt;&gt; this bit is hardwired but that is =
an implementation detail.<br>&gt; &gt;<br>&gt; &gt; For some targets it&#39=
;s, but for some targets it&#39;s not. for example<br>&gt; &gt;<br>&gt; &gt=
; mips-softmmu.mak<br>&gt; &gt; mipsel-softmmu.mak<br>&gt; &gt; mips64el-so=
ftmmu.mak<br>&gt; &gt; mips64-softmmu.mak<br>&gt; &gt;<br>&gt; &gt;<br>&gt;=
 &gt; mips64el-softmmu.mak<br>&gt; &gt; mips64-softmmu.mak<br>&gt; &gt; onl=
y differ the endianless<br>&gt; If you look at git / mailing list history y=
ou&#39;ll see I spent more<br>&gt; than a year unifying QEMU endianness. It=
 was too much work for a<br>&gt; single person so we decided to reduce the =
scope to ARM + MicroBlaze<br>&gt; for single binary and we got MicroBlaze u=
nified. We don&#39;t want<br>&gt; an endianness-specific single binary. I&#=
39;m not sure what you are<br>&gt; trying to build, you didn&#39;t clearly =
explained what is your goal here.<br>&gt;<br>&gt; You can find series unify=
ing endianness for MIPS, not merged because<br>&gt; more things need to be =
addressed and not the priority.<br><br>It&#39;s only for testing. if we can=
 not uniquely identify a target, then the testing program won&#39;t work pr=
operly.<br>if =C2=A0endianness =C2=A0needs to be removed in future, let&#39=
;s defer that?<br><br><br><br>--<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=E6=
=AD=A4=E8=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=
=A0 =C2=A0 sincerely,<br>Yonggang Luo</div>

--000000000000d657be065c898119--

