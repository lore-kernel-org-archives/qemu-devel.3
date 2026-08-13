Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC0C5C5CFCF
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2026 02:01:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuKjk-0003WO-42; Wed, 12 Aug 2026 22:00:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fritchleybohrer@gmail.com>)
 id 1wuKjj-0003Vv-0W
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 22:00:03 -0400
Received: from mail-lr2-x0b.google.com ([2a00:1450:4864:38::b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fritchleybohrer@gmail.com>)
 id 1wuKjg-0001wN-WF
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 22:00:02 -0400
Received: by mail-lr2-x0b.google.com with SMTP id
 38308e7fff4ca-39ef8d1da14so2408371fa.1
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 19:00:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786586399; cv=none;
 d=google.com; s=arc-20260327;
 b=eFMJfxIIw2np/uHl8HlgS8w8HEZhj614jtqEn+fOJF/yuIVvbbuW/Fwro5jcb0+Tab
 IVdSZbtZwtNssvQWq5Ay1EWdreykt7XH3Foa4QOQE8fJEos9sMUWZptXcFELjuc/tJIr
 rg6MI5/6CG9EsmqaPKZeXep3VZ51/Zm2U7g9HhIU0qqVnyCbsTrS138HbIjiZ4iRAR+l
 vBh7FnVjsrtwokPudyqsYgOP5iUla2ExZryi1WlgpZMPUJ+CT5UH3SsR0iCuEg3HaoBE
 YkJ68EwVLAlxjQEdoIHOvSWNSIzNAmtG5IgpJm/juP0RYpVrhW0yERxj7yXRoHpIueo4
 OO2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ewIXW3DQOyDEAWMQKdINf3zRTImEA9ixdsV1WKYCg+E=;
 fh=zlEW0wgFc4EkLABiavNu342ML4DLCeQAXjwWIv/Zh9I=;
 b=qEdphktIJ41NiMzYayb28uKD8GwsGCuM8MvIOrND0Ko7Ee7WqOjsi5wCIj0IDPejCx
 /8nqMvYRHoXrAkFxAIsT1W6kz4+r7Cy0791pMuj7jmxVLp61VYpWA4n+jxYRfuq7GC3c
 0x88XMVsAESNfKFnPMyQ3OsVt6wUvDeJigzrsgf9vzVaftZL6TBSOwjlnWKPFkdVJ3F7
 OE4dCDaLOENAeWvGcpm3Sj7jL8Wb0hStFc0gNeBpSYxKXlGU6GrMGioiZMfWOPlDSb/O
 tq2ZCYlIlcRo1gWh+iDLnERlPXv7OYmNCV5H+qoZc9gx8UGRoj9BWE9/f9QDlR3nr6hc
 pZag==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786586399; x=1787191199; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ewIXW3DQOyDEAWMQKdINf3zRTImEA9ixdsV1WKYCg+E=;
 b=fS3GLvP9WoJsv1e1aRb78Y4zLQRmrQ/RfF4LFeOHxUq1Ai9benzqhwkVidoX19ZJ78
 6+NIu9lgg3htxG5FkzhmY8oVh22ST8cRoWqMVw1v7GsNTcO2aR2QNXNwWQcrMn9mlURk
 lqsx84eGU535E+0zmWqeg0luedJz8fJFuawGh+6i8rZhY/XNI9tJ+2tTOh+M0zImvCpo
 OYifnR5ob4MgdCkq9EPaADMc6TPf4oBjtM+Ju+27SvxJfbnkkMhWozj8Rvs+xoNd7K1Q
 U5s6Gf+Lvr0vSK7dL/srcfRk14l8F7zIbOnG+jb6oR3VJfe/xyxD+ncX9L7T7wv9K8Ar
 yWug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786586399; x=1787191199;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ewIXW3DQOyDEAWMQKdINf3zRTImEA9ixdsV1WKYCg+E=;
 b=KRqUSayp5NtRr644JC+4w0gbU/NpLiHbDHd1+FceNxmWtvbN4eq5UE2TQq4P5dG7IM
 2Cs5ex8jMfUeUNZ/qILytRuOSAVsRH+sWlza3AJkv8oVZuTYbe26zi77K6TuALyOLAxG
 GsadFOBNeuLeMvX5tOKRX0ZQplxxnvhzNqRq2zZO2w8fx2a+I9E5MlTaJNy9p9BPInrg
 KLuUEbwZrunoDJZocJDH08R5Ol2C/PE9Jms/npdLAAo0NE744+PQtAQ4/jLA+61BT/eL
 J3IqpE8vn2Gc3JBIwsvWS7w6OZnFc7nTowwRfeD3NZ8nReI/PUj1sqS2WqKHgllps+Vm
 zYpA==
X-Gm-Message-State: AOJu0YznCG8GxLDXeoKJ2ke5XK4Ti5bZikNlCr/AXBtmZeNgZT/rYrVD
 p7AGux4mHxDBC7SNwqfC8YYl2KOYtfDTPvieNaUfVoTen5UmnAJPND1/jah3DMtJGjAVbl6wL2R
 HINlpq2vlgyXzY5ioC51j5gSKBjrk8uc=
X-Gm-Gg: AR+sD13FDeA1nv/10/kUlhl4CRk2cib9AdM+LvpxQRREL9ZN+3VEBBO46qFnSaKicL+
 epWnRkxN6V5Xm9Djo/NIULFPf0Nj3sjYv6SKaeOVLn5J/BKtuFKj7PhZNwafg8nH9hlgyUJjIYs
 c8vXHLO4ITPepn5lMywlV+5HT4oo7PRzEGhLzJ6dxzieMgQRGP436+MyzzOVbmOgAWv2MhcmEno
 Zv8vQ4JkizvaRBGBMygsDPVfXJAczKO2CWj00LXgUIqeASg3WH/NVePeBtVezPMCDq5+oR/oL1H
 vuiu4BDLxoaoiGPW5bs8gxbQL3oOG0CGQBnYOnQ3n+OouXWvcCvJ9DnT
X-Received: by 2002:a05:651c:553:b0:38a:5bf2:80d6 with SMTP id
 38308e7fff4ca-3a11c0b341cmr2599461fa.5.1786586398271; Wed, 12 Aug 2026
 18:59:58 -0700 (PDT)
MIME-Version: 1.0
References: <20260811025516.337888-1-fritchleybohrer@gmail.com>
 <anyNHaPM7jwM-a1w@sifive.com>
In-Reply-To: <anyNHaPM7jwM-a1w@sifive.com>
From: Zephyr Li <fritchleybohrer@gmail.com>
Date: Thu, 13 Aug 2026 09:59:46 +0800
X-Gm-Features: AUfX_mybhp4iqE-Xe6bNFzAlsLyP03kO5wq24G7daOZLZi99P6cBwy-yp6NRUp0
Message-ID: <CAN4PorXO69P4c4JYpqe6ZUNsch2ujTcyU73ocROxh9bTDsYGfw@mail.gmail.com>
Subject: Re: [PATCH v3] target/riscv: preserve vl on element-zero fault
To: Max Chou <max.chou@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, palmer@dabbelt.com, 
 alistair.francis@wdc.com, liwei1518@gmail.com, 
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com, 
 chao.liu@processmission.com
Content-Type: multipart/alternative; boundary="000000000000a12be40658e40f05"
Received-SPF: pass client-ip=2a00:1450:4864:38::b;
 envelope-from=fritchleybohrer@gmail.com; helo=mail-lr2-x0b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

--000000000000a12be40658e40f05
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks Max, that makes sense.

I'll update the root-cause description and the test comment accordingly.
The implementation itself will remain unchanged.

Thanks,
Zephyr

On Wed, Aug 12, 2026 at 11:13=E2=80=AFPM Max Chou <max.chou@sifive.com> wro=
te:

> On 2026-08-11 10:55, Zephyr Li wrote:
> > A unit-stride fault-only-first load must leave vl unchanged when elemen=
t
> > zero raises a synchronous exception. Keep the shortened value in a loca=
l
> > bound until all loads complete, and only then update the architectural
> vl.
> >
>
> The failing case is a corner case. When the element-0 faulting probe in
> vext_ldff() faults, it longjmps out of the helper, ProbeSuccess is never
> reached and env->vl is never touched -- that path was already correct.
>
> The broken path is element 0 in a mapped MMIO page: probe_access()
> succeeds there, but QEMU cannot know a device transaction will fail
> without issuing it that broken the assumption of the pre probe_access()
> checking.
>
> > --- /dev/null
> > +++ b/tests/tcg/riscv64/test-vle32ff.S
> ...
> > +     vsetvli t2, t1, e32, m1, ta, ma
> > +     li      t0, 0x18000000  /* Unmapped gap in the virt memory map.
> > */
>
> Actually it is not unmapped -- it is mapped as unassigned MMIO, and that
> is exactly why the bug reproduces: an unmapped address would make the
> element-0 probe fault and the test would pass even with the bug present.
>
>
> I think the fixed vext_ldff implementation is valid according to the
> RISC-V specification, considering the VL reduction rule and the
> non-idempotent constraint. Only the test case wording and the root
> cause explanation may need to be updated.
>
> As for the patch:
> Reviewed-by: Max Chou <max.chou@sifive.com>
>

--000000000000a12be40658e40f05
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Thanks Max, that makes sense.<br><br>I&#39;ll update the r=
oot-cause description and the test comment accordingly.<br>The implementati=
on itself will remain unchanged.<br><br>Thanks,<br>Zephyr</div><br><div cla=
ss=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_at=
tr">On Wed, Aug 12, 2026 at 11:13=E2=80=AFPM Max Chou &lt;<a href=3D"mailto=
:max.chou@sifive.com">max.chou@sifive.com</a>&gt; wrote:<br></div><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px =
solid rgb(204,204,204);padding-left:1ex">On 2026-08-11 10:55, Zephyr Li wro=
te:<br>
&gt; A unit-stride fault-only-first load must leave vl unchanged when eleme=
nt<br>
&gt; zero raises a synchronous exception. Keep the shortened value in a loc=
al<br>
&gt; bound until all loads complete, and only then update the architectural=
 vl.<br>
&gt; <br>
<br>
The failing case is a corner case. When the element-0 faulting probe in<br>
vext_ldff() faults, it longjmps out of the helper, ProbeSuccess is never<br=
>
reached and env-&gt;vl is never touched -- that path was already correct.<b=
r>
<br>
The broken path is element 0 in a mapped MMIO page: probe_access()<br>
succeeds there, but QEMU cannot know a device transaction will fail<br>
without issuing it that broken the assumption of the pre probe_access()<br>
checking.<br>
<br>
&gt; --- /dev/null<br>
&gt; +++ b/tests/tcg/riscv64/test-vle32ff.S<br>
...<br>
&gt; +=C2=A0 =C2=A0 =C2=A0vsetvli t2, t1, e32, m1, ta, ma<br>
&gt; +=C2=A0 =C2=A0 =C2=A0li=C2=A0 =C2=A0 =C2=A0 t0, 0x18000000=C2=A0 /* Un=
mapped gap in the virt memory map.<br>
&gt; */<br>
<br>
Actually it is not unmapped -- it is mapped as unassigned MMIO, and that<br=
>
is exactly why the bug reproduces: an unmapped address would make the<br>
element-0 probe fault and the test would pass even with the bug present.<br=
>
<br>
<br>
I think the fixed vext_ldff implementation is valid according to the<br>
RISC-V specification, considering the VL reduction rule and the<br>
non-idempotent constraint. Only the test case wording and the root<br>
cause explanation may need to be updated.<br>
<br>
As for the patch:<br>
Reviewed-by: Max Chou &lt;<a href=3D"mailto:max.chou@sifive.com" target=3D"=
_blank">max.chou@sifive.com</a>&gt;<br>
</blockquote></div>

--000000000000a12be40658e40f05--

