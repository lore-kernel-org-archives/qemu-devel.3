Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DFFFC4450C
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2026 06:53:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjtUI-000398-Bh; Wed, 15 Jul 2026 02:53:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1wjtU0-00033G-B4
 for qemu-devel@nongnu.org; Wed, 15 Jul 2026 02:52:43 -0400
Received: from mail-oi1-x229.google.com ([2607:f8b0:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1wjtTy-0003vb-9C
 for qemu-devel@nongnu.org; Wed, 15 Jul 2026 02:52:40 -0400
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-4a483a552efso736155b6e.1
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 23:52:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784098356; cv=none;
 d=google.com; s=arc-20260327;
 b=EnCVUTuZwtQvod+tU7g0Wom78xPapD9YZdErFsKA0Z6Up0E6kEysOY2cVw0s3mPehZ
 8UKM2a3X+dCtWH+lxRcXwetWtjNwlhmS36U9co7prEa7FCEodVNuaIocZT7kO0ORj8Y5
 UT/r1FMCpRNRZqgky+UaSzeiTJee6kDYGRGZ1zz1tj33O+LjPHEyN5+WtsfUeaCj2kE1
 vzRvCtP8a/WLkA+8socglsjlYqum9kGC31ukg0T9AGOS5HP8cMKJjXiUz+Z0vMvtlUj9
 iA3qzqZ4fH0Dv1dhgmo4WwDmRnM20jfxE/l4UDX44CchqQIs8ldkGO/4+SyGy50mWzdY
 ksiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=q6cWf4EweFXjudZ/VN/mnjqbgLrEoJ8/wqa3jARsgEE=;
 fh=SSiYW59tA3elcoKRrATYrogtE12JoOKZ+DR/Vih8uk8=;
 b=FUCL+JO/0MTKgo2pW+pbaGFhopI5KnGo5BhDN06b0ONu+dDYn/T2MmN8av7iiucqya
 GVJM/ow+iKqOngy28wkc2JawePlYb5BynSpuogR9jc3oTCUXUCVmKufwYJfJOmebCO2q
 IVoeXphGXNvk2kHuVJF9w30rTLIMF7Ln7Yz84lgYieuaUtIDG+Z0t5X9Aek8uD87UCQi
 E3o7XqL7+2KoMdDc6qa37vlv1UdU9k/DFVGGPa9GeMUszh7dbSO2a9SndefjSOpltZD6
 Yn1kvYE8u57dlMbIFzeDRMyBmzR8MSn7Txtwf61QfafhFKkfK5s3uLfwoLoIYCZSZ5vo
 iadQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1784098356; x=1784703156; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=q6cWf4EweFXjudZ/VN/mnjqbgLrEoJ8/wqa3jARsgEE=;
 b=i2xu/u5oNCPyxwuAiZVTM2zy30wz7rpsQxiWQDZVz/PyljhCvUqBf4MhSGJwESypBO
 P3a6zhw+t0gizvrdPb9m/6M2oJ+F1YcRTUYpscpH2yqutw5/m03Wg2UbwoymDx6PCU1t
 m1MKuDXgEX7QShP9WdXxe12z0pOWkT3+eP6angdxiRBtPNZMP9kNZa/BtQFklXzr2RBG
 gF3IuET3tQVfl42cV8yn/8KK1ZJR8LpD1TdPuv10rYdhs8znk7LcSWCzG4nkUIxW8cDf
 mmolESP5JASVS32/YhDmhkPH36X1Qgzp+RcQaCJZHTl8ffsZzIgjWIG6QEXRWxIEjXwJ
 9ydw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784098356; x=1784703156;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=q6cWf4EweFXjudZ/VN/mnjqbgLrEoJ8/wqa3jARsgEE=;
 b=MlBgVaBxDofNWNKlPIeKE3glU/hmtWnTfT9WVlDNqwbMs2m5AbfExBJB8GCWMvSyyf
 7P0IQAgBl9NZ1A4+VTmIi7LgNvqXQ2KTadU3U9lkN2rGr/mYzHEbAF0rJbpDQlKrfOBJ
 3NefREIIPhbXQ5k4AH0lLMEW7Xpj46QWjTj25jGpR3ANGIYUIF59uS6IiPloe8C1P//r
 uQqQsrGMGklFpZYi8b/AHbhTQokUrRxGFKTequJYnKqq+GU/nnZJWdQOmtPN/k5ALH/y
 tNA+HMp8S1o0eb74HOI5yFYVKFFz6j6sAC32Rw/4Drp1huOw47RKEGOCuGQOb102op/s
 YhOw==
X-Forwarded-Encrypted: i=1;
 AHgh+RoRwOa/GbsfbHK8IbNhVWTgKX+rPth6jQMRfVRuuKkH3k4KseqHFT609UGTLrpFYcOY8L/vR8Qn8Urj@nongnu.org
X-Gm-Message-State: AOJu0YzfFiLyNl/gCpRpgs0sJeyffacZPqgVixEk2a46nFKPTxCh2eYG
 i3ABt1xGR86BQfNgbww5qYhNy+5LcWsE7yomUXBRbXeKF44Jzj8XYvdm6d9Yr4I4QwEDWQ5Lha/
 WkV/9GS5FBOQHx9KgtzfjLGHyCrSSuSPXwf2x3VcxGg==
X-Gm-Gg: AfdE7cnRHwW/Mym5l+BZRiDDVL4ldY3gSQkp59W7HzwAt4aziw6bSTwk8ZdHBP37dul
 v+BeU0N1E+1tKVHUOxbSbM8fpP0N+fackA8fzR3OgqK77PT+uDToxHwQyaXKkYxnX31nf+YWwzb
 +4dsuhdwsz/pefoPYPRwUT5/F9g+VRO6eA3ZE3NncL92xWrAeXCpui4evgRoCjf22heGSdK2aNM
 K8uGqs06mExoZm7iNv3XXGkJSHVxwxRMx/Jsm3lhSMLMALP48gkszrWRqKwFk8h9Qja0ImsG98=
X-Received: by 2002:a05:6808:220f:b0:4a0:93e4:e15b with SMTP id
 5614622812f47-4a4960a8b7cmr1160419b6e.24.1784098355822; Tue, 14 Jul 2026
 23:52:35 -0700 (PDT)
MIME-Version: 1.0
References: <20260209115846.2276651-1-jim.shu@sifive.com>
 <7be3b4f7-7516-40ab-8a95-b3b4a2aea095@linaro.org>
 <CALw707rbMvg1mf1S_3qiqDWbZ0qjzgx4UJ9pUGmQODKWttKFyQ@mail.gmail.com>
 <08c5f243-5aaa-4fe2-bc71-6a3fd9a1914e@linaro.org>
In-Reply-To: <08c5f243-5aaa-4fe2-bc71-6a3fd9a1914e@linaro.org>
From: Jim Shu <jim.shu@sifive.com>
Date: Wed, 15 Jul 2026 14:52:29 +0800
X-Gm-Features: AUfX_mz1B0iirBxI6JBe5hc4hQo4piKM7bI9LB4TXvos06vZem75J2er2pvZBYs
Message-ID: <CALw707pP_5a_EeUQLRw51nLCoFo4vKkKPGaVtJJdWEqR8K-u-A@mail.gmail.com>
Subject: Re: [PATCH] exec: Add RISC-V WorldGuard WID field to MemTxAttrs
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org, 
 qemu-riscv@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@kernel.org>, 
 =?UTF-8?Q?Cl=C3=A9ment_Mathieu=2D=2DDrif?= <clement.mathieu--drif@eviden.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Zhao Liu <zhao1.liu@intel.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?Q?Cl=C3=A9ment_Chigot?= <chigot@adacore.com>, 
 Frederic Konrad <konrad.frederic@yahoo.fr>
Content-Type: multipart/alternative; boundary="000000000000be66000656a0c4de"
Received-SPF: pass client-ip=2607:f8b0:4864:20::229;
 envelope-from=jim.shu@sifive.com; helo=mail-oi1-x229.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_KAM_HTML_FONT_INVALID=0.01 autolearn=ham autolearn_force=no
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

--000000000000be66000656a0c4de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi all,

I'd like to discuss this issue again.

On Wed, Mar 18, 2026 at 2:42=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 <philmd=
@linaro.org>
wrote:

> On 18/3/26 05:40, Jim Shu wrote:
> > On Tue, Feb 10, 2026 at 8:25=E2=80=AFAM Richard Henderson
> > <richard.henderson@linaro.org> wrote:
> > ...
> >> Hmm.  This really overlaps the secure and space fields from arm, and
> possibly some of the
> >> others as well (e.g. user, requester_id, pid).
> >>
> >> I don't really have a good suggestion for that right now, but it would
> be nice to not keep
> >> expanding the count of these sorts of fields that somehow specify the
> originator, but
> >> clearly cannot overlap.
> >>
> >> I'm reasonably sure we've had this discussion before, but nothing has
> come of it.
> >>
> >> Time to paint the bikeshed again?
>
> Last discussion IIRC:
>
> https://lore.kernel.org/qemu-devel/CAFEAcA8vKNkfKgp_Yymo9NA1=3DE2XJYXAMTg=
O3z6q6DHgqkAwRw@mail.gmail.com/
>

Follow the idea in the above thread. I'd plan to add the 'src_cpu_id' field
to 'MemTxAttr', so we can get the CPUState from MemTxAttr. Thus, we can
retrieve the RISC-V world_id from CPU and we don't need to add world_id to
'MemTxAttr'. If other security attributes are stored in CPU states, they
can also reuse this w/o adding more data to 'MemTxAttr'.

The whole plan is to add the following 2 fields
::
    unsigned int src_is_cpu:1;
    uint16_t src_cpu_id;

src_cpu_id is the CPU ID from 'CPUState->cpu_index'. src_is_cpu is a
boolean flag to check if the transaction is from CPU.

Moreover, I think this idea is extensible. DMA device transactions can also
have security attributes like world_id. We can also add src_device field to
'MemTxAttr' to store the 'DeviceState *', so we can get the DeviceState
from MemTxAttr to get security attributes. If 'DeviceState *' is too large
to add to 'MemTxAttr', re-use requester_id as DMA device ID is another
possible method to support this.
(p.s. DMA transactions world_id is NOT covered by my current patchset. I
just explain this concept for the discussion.)

Does anyone think it is an acceptable plan? Any feedback is welcome.

In the next series, I will implement this plan to add the cpu_id instead of
world_id if there is no problem about it.


Regards,
Jim



> (see also a suggestion in
> https://lore.kernel.org/qemu-devel/Z4+P3eHXqcU4Dqdx@intel.com/)
>
> >>
> >
> > I can union the 'secure' and 'world_id' fields, as they are not used
> together.
> > However, I have no idea about the 'space' fields.
> >
> > I have seen CPUTLBEntryFull has the extra union to support ARM-specific
> members.
> > Another idea is that also adding the extra union to MemTxAttrs to
> > place the RISC-V worid_id.
> > We can use this extra union to as SoC-specific signals in the bus,
> > like AXI AxUSER signal.
> > Do you think it is suitable?
> >
> >
> > Thanks,
> >
> > Jim
>
>

--000000000000be66000656a0c4de
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small">Hi all,<br><br>I&#39;d like to discuss this issue again.</div=
></div><br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr=
" class=3D"gmail_attr">On Wed, Mar 18, 2026 at 2:42=E2=80=AFPM Philippe Mat=
hieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@linaro.org">philmd@linaro.org<=
/a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">O=
n 18/3/26 05:40, Jim Shu wrote:<br>
&gt; On Tue, Feb 10, 2026 at 8:25=E2=80=AFAM Richard Henderson<br>
&gt; &lt;<a href=3D"mailto:richard.henderson@linaro.org" target=3D"_blank">=
richard.henderson@linaro.org</a>&gt; wrote:<br>
&gt; ...<br>
&gt;&gt; Hmm.=C2=A0 This really overlaps the secure and space fields from a=
rm, and possibly some of the<br>
&gt;&gt; others as well (e.g. user, requester_id, pid).<br>
&gt;&gt;<br>
&gt;&gt; I don&#39;t really have a good suggestion for that right now, but =
it would be nice to not keep<br>
&gt;&gt; expanding the count of these sorts of fields that somehow specify =
the originator, but<br>
&gt;&gt; clearly cannot overlap.<br>
&gt;&gt;<br>
&gt;&gt; I&#39;m reasonably sure we&#39;ve had this discussion before, but =
nothing has come of it.<br>
&gt;&gt;<br>
&gt;&gt; Time to paint the bikeshed again?<br>
<br>
Last discussion IIRC:<br>
<a href=3D"https://lore.kernel.org/qemu-devel/CAFEAcA8vKNkfKgp_Yymo9NA1=3DE=
2XJYXAMTgO3z6q6DHgqkAwRw@mail.gmail.com/" rel=3D"noreferrer" target=3D"_bla=
nk">https://lore.kernel.org/qemu-devel/CAFEAcA8vKNkfKgp_Yymo9NA1=3DE2XJYXAM=
TgO3z6q6DHgqkAwRw@mail.gmail.com/</a><br></blockquote><div><br></div><div><=
div class=3D"gmail_default" style=3D"font-size:small"><span style=3D"backgr=
ound-color:transparent">Follow the idea in the above thread. I&#39;d plan t=
o add the &#39;src_cpu_id&#39; field to &#39;MemTxAttr&#39;, so we can get =
the CPUState from MemTxAttr.=C2=A0</span><span style=3D"background-color:tr=
ansparent">Thus, we can retrieve the RISC-V world_id from CPU and we don&#3=
9;t need to add world_id to &#39;MemTxAttr&#39;.=C2=A0</span><span style=3D=
"background-color:transparent">If other secur</span>it<span style=3D"backgr=
ound-color:transparent">y attributes are stored in CPU states, they can als=
o reuse this w/o adding more data to &#39;MemTxAttr&#39;.=C2=A0</span></div=
><div class=3D"gmail_default" style=3D"font-size:small"><span style=3D"back=
ground-color:transparent"><br></span></div><div class=3D"gmail_default" sty=
le=3D"font-size:small">The whole plan is to add the following 2 fields</div=
><div class=3D"gmail_default" style=3D"font-size:small">::<br>=C2=A0 =C2=A0=
 unsigned int src_is_cpu:1;<br>=C2=A0 =C2=A0 uint16_t src_cpu_id;<span styl=
e=3D"background-color:transparent"></span></div><div class=3D"gmail_default=
" style=3D"font-size:small"><br></div><div class=3D"gmail_default" style=3D=
"font-size:small">src_cpu_id is the CPU ID from &#39;CPUState-&gt;cpu_index=
&#39;. src_is_cpu is a boolean flag to check if the transaction is from CPU=
.<br></div></div><div><br></div><div><span class=3D"gmail_default" style=3D=
"background-color:transparent">Moreover</span><span style=3D"background-col=
or:transparent">, I think this idea is extensible. DMA device transactions =
can also have security attributes like world_id.<span class=3D"gmail_defaul=
t" style=3D"font-size:small">=C2=A0</span></span><span style=3D"background-=
color:transparent">We can also add src_device field to &#39;MemTxAttr&#39; =
to store the &#39;DeviceState *&#39;, so we can get the DeviceState from Me=
mTxAttr to get security attributes.<span class=3D"gmail_default" style=3D"f=
ont-size:small">=C2=A0</span></span><span style=3D"background-color:transpa=
rent">If &#39;DeviceState *&#39; is too large to add to &#39;MemTxAttr&#39;=
, re-use requester_id as DMA device ID is another possible method to suppor=
t this.</span></div><div>(p.s. DMA transactions world_id is NOT covered by =
my current patchset. I just explain this concept for the discussion.)<br><b=
r><span style=3D"background-color:transparent">Does anyone think it is an a=
cceptable plan? Any feedback is welcome.</span></div><div><br></div><div>I<=
span class=3D"gmail_default" style=3D"font-size:small">n the next series, I=
=C2=A0</span>will implement this plan to add the cpu_id instead of world_id=
 if there is no problem about it.<br><br></div><div><br></div><div><div cla=
ss=3D"gmail_default" style=3D"font-size:small">Regards,<br>Jim</div><br></d=
iv><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0=
px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
(see also a suggestion in <br>
<a href=3D"https://lore.kernel.org/qemu-devel/Z4+P3eHXqcU4Dqdx@intel.com/" =
rel=3D"noreferrer" target=3D"_blank">https://lore.kernel.org/qemu-devel/Z4+=
P3eHXqcU4Dqdx@intel.com/</a>)<br>
<br>
&gt;&gt;<br>
&gt; <br>
&gt; I can union the &#39;secure&#39; and &#39;world_id&#39; fields, as the=
y are not used together.<br>
&gt; However, I have no idea about the &#39;space&#39; fields.<br>
&gt; <br>
&gt; I have seen CPUTLBEntryFull has the extra union to support ARM-specifi=
c members.<br>
&gt; Another idea is that also adding the extra union to MemTxAttrs to<br>
&gt; place the RISC-V worid_id.<br>
&gt; We can use this extra union to as SoC-specific signals in the bus,<br>
&gt; like AXI AxUSER signal.<br>
&gt; Do you think it is suitable?<br>
&gt; <br>
&gt; <br>
&gt; Thanks,<br>
&gt; <br>
&gt; Jim<br>
<br>
</blockquote></div></div>

--000000000000be66000656a0c4de--

