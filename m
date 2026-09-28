Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2489CA5FA2
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 12:06:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBA74-0000B0-62; Mon, 28 Sep 2026 08:05:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xBA6e-0008Qz-KU
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 08:05:17 -0400
Received: from mail-ed2-x0d.google.com ([2a00:1450:4864:33::d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xBA6c-0005PR-Hb
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 08:05:16 -0400
Received: by mail-ed2-x0d.google.com with SMTP id
 4fb4d7f45d1cf-6ab062a08f5so2553651a12.2
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 05:05:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790597113; cv=none;
 d=google.com; s=arc-20260327;
 b=G3PqUfGB4UfQgXUv90MpaSGpP641jpTSItwqlVlFLuCvsMbyLbLYR7jE+bddjyMe27
 5nqD09ZWRhCf7+4t25T4tkDJXGIKhbkvMs8CO53mT5vNscyJ2gKhxWGdjzptEx/H93MM
 lyfxRVAdvHg7j9vbpODGfnINRjMIdWkoTNOcGf/hM+ArutACnUzfUA0ZaKDL9xY68q9k
 gtsMxGgMDJDQK835tLzn2E9ISBDOGDxdSFkUMNaq0t1v7Z18oWVPOE8amMS9HElp1F8S
 aHh9qIwxJoU0n0ccIuDzmBxB4WstpXpUAf8Eeh5Wm152WSeYzDlYn7X9aifzrFasaoxB
 A4fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:reply-to:in-reply-to:references
 :mime-version:dkim-signature;
 bh=R7VUSa9F64Z/xfHrqT4Sj5uyWC0luEy9fz0lPA7veeM=;
 fh=6jdXT6b4cnfDza0iCJZs0pGSp8j3wtI2284GwcwH8j8=;
 b=KQZcQG/WpL9Il0kvN6Hy+K06IYPvECe/mq0jAwodndUl6fqbZTUI43IbWjpIA0cDf8
 yUGuXQqHFtmjHgy9iLBx34inqIEde67B0QsWM5Hij0KtGjmQaibclaKHF3a+HhY/6Oi/
 5b7PQsLH4hOs4GlxGVakqdiTcmmg7RxLw9P3SZAXAIYrpSJD3D5VWkMBtqNMPaGzTn6A
 QFOewlXQulgmWDiR/LW8BIG8q+tJgavKgKdFUnUMgxyMIGgXoYGiXgFnepfAVFDJf2Wy
 V20MsZY4OJXwXy9Q19fusbmfyXJ0pjDD2r1c+B0exF4wH1nwZiYkvG5H+R3NHB3U/gUY
 qQDQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790597113; x=1791201913; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:reply-to
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=R7VUSa9F64Z/xfHrqT4Sj5uyWC0luEy9fz0lPA7veeM=;
 b=LhSCZjk2EGxVtdrY7zlc4cn+epevFjZ3cgh+hhtsgG3P8zIjpCWAHVhuqVCA0L+/pi
 E2ov6RM1D5UBcNu3UwaZk0/ziU3yFgcHfLS2+IT6gzlm/as9jVzmTfEvMiSwLAtSwT5Q
 ZHVeKZ7B3Z9iCe3z7z4HsZkTq61EzwTUuExh+C+h+I2ymXx+ACjvGxoWmunsG3ZbjfyV
 Fk36Eql8eSxMaVH3IofwSnkwDym9JXKZHXRkmd2dZxnItKc3lwSDjy5NhNrqGW8Ek+zD
 fbnZYk9KP6wsZ8+4bAeZLGMeHpwEWkZE4nk5Ax4HIW6a3+P5+vZ1bjOgWiobRkLD/Rn6
 +TZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790597113; x=1791201913;
 h=content-type:cc:to:subject:message-id:date:from:reply-to
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=R7VUSa9F64Z/xfHrqT4Sj5uyWC0luEy9fz0lPA7veeM=;
 b=q7xlhaky+ZXo3nFJKRLsnHcUcSzi0NvL4/UK0zDM7DdWvEOBQmfYJU3MUHz2773dMD
 oO2b3aNpo4S2ZGLh7QsCWFCX/HgFkkJt53jkoipvrXPY9W5p5C9fOCdCpN3kQEjeWAF4
 nsV4k7r22eib+MX3BKSHV2AgVQhNwO306DlWzO6dTZ6Nh+Xgw6HBA6V08T1FyYwR453i
 3QaHwgvSnhzczK9c9Bi8Fj3+HUcDExjdv1veDESVhlyEGcm1fXcEhbk0sE9Xrya/2RSk
 6bEPJbxsWNTfiaRhv5EYUWG9+xBiRIYSJPoS4rSpxU6VnMkM9i6hpnfyVX18ocOPIPjq
 o2qA==
X-Gm-Message-State: AFq9FYIbEsSR/SKK/EW7cf3PM3iXZ2jI0NqapYMBHGUeMocIhbSIWiuN
 B1IbxMrX7Ls/cVCbvHoSovQEUgOgoJ1KJu14M4pUR+qfRsZk+7YJs3W5SoyOjCcYZDwg/378ZU1
 vn2nzTg5DPT02R3nXqHgDE8zpKpjyHXA=
X-Gm-Gg: AYBFou2XNIPVp3AfJi4hBE31apaBfHQHDaZdJYoCVg1wBgb42XWgGIsjna3TJuLrTVD
 x8kRfIHKEUb9b/0wA78V29aPUf1k4Dvxb2xLrdmB+caD0Rl+461gDnSDWaY5bxW+3H5addEQLs8
 xaU2+n45VXemt7J5BtjcJ9qt6KzmFuIR6SCCiHUnVktIOaxP4GQSpoqVsj4rOHnhf1liKTruuSc
 aSFPkds9Ddc5zd3CRIEtn85O6Q9m6g3ohll4QTdn79hlImZnUHna2kBv79vOigiKaQzI+j4f9oU
 dloGFOmGbC/axH5UYDgMLe8LwdT4zrqGy6wUOaa0AmylOp2m94W+6Zy/MKHP/5vlkA==
X-Received: by 2002:a05:6402:4552:b0:6ac:82f5:186a with SMTP id
 4fb4d7f45d1cf-6ac82f53743mr1350911a12.14.1790597112550; Mon, 28 Sep 2026
 05:05:12 -0700 (PDT)
MIME-Version: 1.0
References: <20260926070057.1234-1-luoyonggang@gmail.com>
 <20260926070057.1234-42-luoyonggang@gmail.com>
 <87zex1fvh4.fsf@pond.sub.org>
In-Reply-To: <87zex1fvh4.fsf@pond.sub.org>
From: Yonggang Luo <luoyonggang@gmail.com>
Date: Mon, 28 Sep 2026 20:04:59 +0800
X-Gm-Features: AclHuK_bTJqX2dS6--KlrYuc7-HJEiCMrp11FmWXb_ZL2L-oYL7VPaXGnGiL4WY
Message-ID: <CAE2XoE_QozVhBix251nyUQkFMi6p_4idGXpVOT0LSP7VYK8ddw@mail.gmail.com>
Subject: Re: [PATCH v4 41/55] target-info: add SysEmuTarget none
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 qemu-arm@nongnu.org, kvm@vger.kernel.org
Content-Type: multipart/alternative; boundary="000000000000d45aa2065c89e02d"
Received-SPF: pass client-ip=2a00:1450:4864:33::d;
 envelope-from=luoyonggang@gmail.com; helo=mail-ed2-x0d.google.com
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

--000000000000d45aa2065c89e02d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2026 at 7:48=E2=80=AFPM Markus Armbruster <armbru@redhat.co=
m> wrote:
>
> Yonggang Luo <luoyonggang@gmail.com> writes:
>
> > Add a none target for when no TargetInfo is selected. It is last
> > so existing SYS_EMU_TARGET_* values stay put, and it is not a
> > qemu-system- executable name. target_is_none() and target_none()
> > report that state.
>
> Why does it matter that existing SYS_EMU_TARGET_* stay put?

We need a state that not a real CPU target is selected( I called it none),
then we can use it to list all targets. for example, do query-targets.
query-machines(all machines for all targets).
Any better ways to handle it would be appreciated, I am not choosing to set
it to NULL because
that would cause too much NULL-check error, as the pre-existing code
presume there is always a
CPU target present.


>
> > Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
>
> [...]
>
> > diff --git a/qapi/machine.json b/qapi/machine.json
> > index b1be5608b61..6aaa2af709a 100644
> > --- a/qapi/machine.json
> > +++ b/qapi/machine.json
> > @@ -22,6 +22,10 @@
> >  # The individual target constants are not documented here, for the
> >  # time being.
> >  #
> > +# @none: no TargetInfo selected.
>
> Doc comments are reference documentation for users.  TargetInfo is an
> internal thing.  Please rephrase in terms that make sense to users.
>
> >                                    Not a qemu-system- executable name.
>
> This barely makes sense.  I recommend to leave documenting the
> qemu-system-T naming convention to the note below.
>
> > +#     Last enumerator so existing SYS_EMU_TARGET_* values stay put.
>
> Of no concern to users, therefore inappropriate for user documentation.
>
> > +#     (since 11.2)
> > +#
> >  # @rx: since 5.0
> >  #
> >  # @avr: since 5.1
> > @@ -30,9 +34,10 @@
> >  #
> >  # @hexagon: since 11.0
> >  #
> > -# .. note:: The resulting QMP strings can be appended to the
> > -#    "qemu-system-" prefix to produce the corresponding QEMU
> > -#    executable name.  This is true even for "qemu-system-x86_64".
> > +# .. note:: Except for ``none``, the resulting QMP strings can be
> > +#    appended to the "qemu-system-" prefix to produce the
> > +#    corresponding QEMU executable name.  This is true even for
> > +#    "qemu-system-x86_64".
>
> Not this patch's concern: I don't understand what's so special about
> x86_64.
>
> >  #
> >  # Since: 3.0
> >  ##
> > @@ -42,7 +47,7 @@
> >               'mips64el', 'mipsel', 'or1k', 'ppc',
> >               'ppc64', 'riscv32', 'riscv64', 'rx', 's390x', 'sh4',
> >               'sh4eb', 'sparc', 'sparc64', 'tricore',
> > -             'x86_64', 'xtensa', 'xtensaeb' ] }
> > +             'x86_64', 'xtensa', 'xtensaeb', 'none' ] }
> >
> >  ##
> >  # @S390CpuState:
>
> [...]
>


--
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--000000000000d45aa2065c89e02d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><br>On Mon, Sep 28, 2026 at 7:48=E2=80=AFPM Markus Arm=
bruster &lt;<a href=3D"mailto:armbru@redhat.com">armbru@redhat.com</a>&gt; =
wrote:<br>&gt;<br>&gt; Yonggang Luo &lt;<a href=3D"mailto:luoyonggang@gmail=
.com">luoyonggang@gmail.com</a>&gt; writes:<br>&gt;<br>&gt; &gt; Add a none=
 target for when no TargetInfo is selected. It is last<br>&gt; &gt; so exis=
ting SYS_EMU_TARGET_* values stay put, and it is not a<br>&gt; &gt; qemu-sy=
stem- executable name. target_is_none() and target_none()<br>&gt; &gt; repo=
rt that state.<br>&gt;<br>&gt; Why does it matter that existing SYS_EMU_TAR=
GET_* stay put?<br><br>We need a state that not a real CPU target is select=
ed( I called it none),<br>then we can use it to list all targets. for examp=
le, do query-targets.<br>query-machines(all machines for all targets).<br>A=
ny better ways to handle it would be appreciated, I am not choosing to set =
it to NULL because<br>that would cause too much NULL-check error, as the pr=
e-existing code presume there is always a<br>CPU target present.<br><br><br=
>&gt;<br>&gt; &gt; Signed-off-by: Yonggang Luo &lt;<a href=3D"mailto:luoyon=
ggang@gmail.com">luoyonggang@gmail.com</a>&gt;<br>&gt;<br>&gt; [...]<br>&gt=
;<br>&gt; &gt; diff --git a/qapi/machine.json b/qapi/machine.json<br>&gt; &=
gt; index b1be5608b61..6aaa2af709a 100644<br>&gt; &gt; --- a/qapi/machine.j=
son<br>&gt; &gt; +++ b/qapi/machine.json<br>&gt; &gt; @@ -22,6 +22,10 @@<br=
>&gt; &gt; =C2=A0# The individual target constants are not documented here,=
 for the<br>&gt; &gt; =C2=A0# time being.<br>&gt; &gt; =C2=A0#<br>&gt; &gt;=
 +# @none: no TargetInfo selected.<br>&gt;<br>&gt; Doc comments are referen=
ce documentation for users.=C2=A0 TargetInfo is an<br>&gt; internal thing.=
=C2=A0 Please rephrase in terms that make sense to users.<br>&gt;<br>&gt; &=
gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Not a qemu-system- e=
xecutable name.<br>&gt;<br>&gt; This barely makes sense.=C2=A0 I recommend =
to leave documenting the<br>&gt; qemu-system-T naming convention to the not=
e below.<br>&gt;<br>&gt; &gt; +# =C2=A0 =C2=A0 Last enumerator so existing =
SYS_EMU_TARGET_* values stay put.<br>&gt;<br>&gt; Of no concern to users, t=
herefore inappropriate for user documentation.<br>&gt;<br>&gt; &gt; +# =C2=
=A0 =C2=A0 (since 11.2)<br>&gt; &gt; +#<br>&gt; &gt; =C2=A0# @rx: since 5.0=
<br>&gt; &gt; =C2=A0#<br>&gt; &gt; =C2=A0# @avr: since 5.1<br>&gt; &gt; @@ =
-30,9 +34,10 @@<br>&gt; &gt; =C2=A0#<br>&gt; &gt; =C2=A0# @hexagon: since 1=
1.0<br>&gt; &gt; =C2=A0#<br>&gt; &gt; -# .. note:: The resulting QMP string=
s can be appended to the<br>&gt; &gt; -# =C2=A0 =C2=A0&quot;qemu-system-&qu=
ot; prefix to produce the corresponding QEMU<br>&gt; &gt; -# =C2=A0 =C2=A0e=
xecutable name.=C2=A0 This is true even for &quot;qemu-system-x86_64&quot;.=
<br>&gt; &gt; +# .. note:: Except for ``none``, the resulting QMP strings c=
an be<br>&gt; &gt; +# =C2=A0 =C2=A0appended to the &quot;qemu-system-&quot;=
 prefix to produce the<br>&gt; &gt; +# =C2=A0 =C2=A0corresponding QEMU exec=
utable name.=C2=A0 This is true even for<br>&gt; &gt; +# =C2=A0 =C2=A0&quot=
;qemu-system-x86_64&quot;.<br>&gt;<br>&gt; Not this patch&#39;s concern: I =
don&#39;t understand what&#39;s so special about<br>&gt; x86_64.<br>&gt;<br=
>&gt; &gt; =C2=A0#<br>&gt; &gt; =C2=A0# Since: 3.0<br>&gt; &gt; =C2=A0##<br=
>&gt; &gt; @@ -42,7 +47,7 @@<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 &#39;mips64el&#39;, &#39;mipsel&#39;, &#39;or1k&#39;, &#3=
9;ppc&#39;,<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &=
#39;ppc64&#39;, &#39;riscv32&#39;, &#39;riscv64&#39;, &#39;rx&#39;, &#39;s3=
90x&#39;, &#39;sh4&#39;,<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 &#39;sh4eb&#39;, &#39;sparc&#39;, &#39;sparc64&#39;, &#39;tri=
core&#39;,<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;x8=
6_64&#39;, &#39;xtensa&#39;, &#39;xtensaeb&#39; ] }<br>&gt; &gt; + =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;x86_64&#39;, &#39;xtensa&#39;, &#39=
;xtensaeb&#39;, &#39;none&#39; ] }<br>&gt; &gt;<br>&gt; &gt; =C2=A0##<br>&g=
t; &gt; =C2=A0# @S390CpuState:<br>&gt;<br>&gt; [...]<br>&gt;<br><br><br>--<=
br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=E6=AD=A4=E8=87=B4<br>=E7=A4=BC<br>=E7=
=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=A0 =C2=A0 sincerely,<br>Yonggang L=
uo</div>

--000000000000d45aa2065c89e02d--

