Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 855C6CA5FA2
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 18:35:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBGBb-0002My-Qh; Mon, 28 Sep 2026 14:34:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xBGBY-0002MB-Sc
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 14:34:44 -0400
Received: from mail-ed2-x29.google.com ([2a00:1450:4864:33::29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xBGBV-0006SY-Rp
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 14:34:44 -0400
Received: by mail-ed2-x29.google.com with SMTP id
 4fb4d7f45d1cf-6aa0ee64afdso3964223a12.0
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 11:34:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790620480; cv=none;
 d=google.com; s=arc-20260327;
 b=LTqn4xawuEyx4L4Os+yPAgMO9dYQFqpe0Ysi+Mr9wpQcnEQ9Cz6FsYvSDdeLV8k/dg
 ALf+ndoGZBX+KxTys1CHTir6k/nXaRElVjlhDdj79nEavL/YIXG0jOxxT5IInqAvfSEZ
 DoVR+DMrhuw6AwX5D+wGGBZvaD7tSN3ObPz3q6tH1rVTUkN/K0Uv2a9mYFKduwp5zhCK
 btV628MhjjMG6gfXVsloxNtQtXzTIxeaByrl/RcVkQvockzjW/V5k/ZY1P1HEAQJ9KER
 KZCXS3CGIycTEsJ3qvGaB0MqOrfL6jWBwOkQCSCdSz3vLnmSiHv7k1Hn+Or+P8yCx7SC
 bfbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:reply-to:in-reply-to:references
 :mime-version:dkim-signature;
 bh=5FFheZ5cQ9NK8d1jb2lLLTR7XGq7Hg+SNpJ+p6e3GbA=;
 fh=BFDiMxCEDXO+rU8dPS+9cFeEQESqamaauVkc3NvQsS0=;
 b=XHDPcj0gaxp8dlQgim12KY3uHn6cqkpbSqgMFjVABhXr0iByjtyQ/GLHgqyUzelpST
 8T0frr341jDhursp6q2+NuiLD9IUMMX1sEW4qIjdrb2Mk2JmsCL22CJf5O8fDgnb5lSu
 i4bAdxfD23i3iEbJu+eaPQzAcjYnX7SpbV5akVoA5ytRdTmgC58JK3y2P12Sc5HB9bRd
 lBCMf7JEuTnI6CzSQt8T7jsYLkLtxxg7euF0be5nW6LcgM7/7QhPoxj4Ak772btvqNeD
 UH75Lstu6GOsyyKicJkmAOf6EOQlw6UGfJNkF7N8pHizjvarXN0gQartHmkXmkmxe+qs
 T7zA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790620480; x=1791225280; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:reply-to
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5FFheZ5cQ9NK8d1jb2lLLTR7XGq7Hg+SNpJ+p6e3GbA=;
 b=EZkbuPFR+WsIv9SPMj3awAbDNe7g9E7jVO259OaL4bjIfsw2thbd0OcI46R8T1Ul/U
 qT2pNiJvodjJrS7NhdaaEuJvjYuTh4SuWTofkT7YKWT59Rkc9HboEXYXfEn0SDQm9Oua
 W3eY0wRGVId2gRvQ3f3R8pJW8IxrsLNXgJu2zFizy/be1tB8jQem9FK1sBKzXk3MXHtl
 IFRZfILe5c37/2WOFLeFE9FqS3IBb32Ga51WwOjnmiaN1vC8VKoXLwncr8O0Z99GydFW
 gSGtOd6sMXtYBqdRO0Kx7gVYy+Zy7cIoBOXaiEVJiGwE2Y/CZruxU3a1e/h24QltYxXT
 NGQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790620480; x=1791225280;
 h=content-type:cc:to:subject:message-id:date:from:reply-to
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=5FFheZ5cQ9NK8d1jb2lLLTR7XGq7Hg+SNpJ+p6e3GbA=;
 b=knMja+3zeKPq0ZEW4Or42cX5dl+pOdj35GvaCNvkPokmPVbug08CGzpLMa0eqNzmjU
 k2kB1c64CsKionwkeXPOpCBSBOYZKIss5AO0rjH47RiWPR8h7TffamPLxPBNvh9+whsy
 tyS8jLypl3IaMFK7dYtZ7IQtsqs36M0oLd+ELYLFYWIi1qWjH04ww8c+XJwFu2ldte4Q
 WvAke2L6vcaUJh6dxDnsBuEDKIqTTJQ/IN9O4h7cJZSpnZfHG80PnIrx70SOBM3kXVCp
 pCGbQUlElE5thQfvusipw1VKXGamTAdP9n7DUPnZGQbnGN2DiUaMjZypbIDz8/y5wk6d
 5x2w==
X-Forwarded-Encrypted: i=1;
 AKwUvBxe5egV6yBXTPlxhCPCUymoszGtdyinqkCzQIFNyCRg1zT/gUO6bH9PtpKl03SOa2tedtVTLFnCV97I@nongnu.org
X-Gm-Message-State: AFq9FYJ7L9MaY3NeF1GleZaq+vFz3gvzcbuekAqId3NdX+qXwxcNWw6B
 Fc/dz3/I3AB18ZSHr4Fr5H2eTe02jKE4xknaevW8fxRKlK8HepqMMz05TNoLgw9U62rSdNcnzqA
 pNcXY9HD/GoX7326uo0G2943yA6PUkaE=
X-Gm-Gg: AYBFou3eHvosFDlxuvdlz0jwyXZ4VcDRDWiQvuAO5OBNbzVftatlZwxxMOZDfIBL2zD
 kV06HlOIs2QYsrAIFh1q9RRmgWMcu58AOAGypO3NiKW6UDshpmjDYgEyOqlCwY0LfD0bKVqRIU6
 chVXrwDQO4UehXBhizHZ7HebCmCwpjxZZ59X62o5waHKTlLrhpmkL0vUxakVTN7ovj7OLplLs8Z
 z5+VgrgMk2IigQiir1ZXIvsZwe2jeDm+cQoBw235nzo7wW0lZWqhzZLh/Y5YXC6nTJ8+0/YNFgB
 xI2y+8IMb76nlnoYJJU6pL1fcaEL0SMZo/M7lr/2G5YB0twUqnP88fo=
X-Received: by 2002:a05:6402:4020:b0:6ac:26f0:15a4 with SMTP id
 4fb4d7f45d1cf-6ac26f01b6emr4739104a12.27.1790620479719; Mon, 28 Sep 2026
 11:34:39 -0700 (PDT)
MIME-Version: 1.0
References: <20260926070057.1234-1-luoyonggang@gmail.com>
 <20260926070057.1234-47-luoyonggang@gmail.com>
 <aro93NuZBXYGbD33@redhat.com>
 <87e7c5ae-c78c-4a47-b9ba-9851ce5757d9@oss.qualcomm.com>
In-Reply-To: <87e7c5ae-c78c-4a47-b9ba-9851ce5757d9@oss.qualcomm.com>
From: Yonggang Luo <luoyonggang@gmail.com>
Date: Tue, 29 Sep 2026 02:34:26 +0800
X-Gm-Features: AclHuK_IRArarHuG7tTpkILoxMmWpJtSVaUlI2r0XiP2bfhyfe8k076gzLlLeRk
Message-ID: <CAE2XoE8Fp8w4m0WBjEXF3LceFXUqKDcXhdSmhCThgkAM3wRVaQ@mail.gmail.com>
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
Content-Type: multipart/alternative; boundary="0000000000009f0f20065c8f515a"
Received-SPF: pass client-ip=2a00:1450:4864:33::29;
 envelope-from=luoyonggang@gmail.com; helo=mail-ed2-x29.google.com
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

--0000000000009f0f20065c8f515a
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
>
> See commit 0e2c5647d92 and surrounding for MicroBlaze for
> example.

Please take a look at
https://gitlab.com/lygstate-qemu/qemu/-/pipelines/2890507627

I do not have clue to fixes it properly



--
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--0000000000009f0f20065c8f515a
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
ns&#39;: &#39;QemuTargetInfo&#39; }<br>&gt; &gt;&gt; =C2=A0 <br>&gt; &gt;&g=
t; +##<br>&gt; &gt;&gt; +# @TargetMachines:<br>&gt; &gt;&gt; +#<br>&gt; &gt=
;&gt; +# One registered system target and the machines that can run on it.<=
br>&gt; &gt;&gt; +#<br>&gt; &gt;&gt; +# @arch: the target architecture<br>&=
gt; &gt;&gt; +#<br>&gt; &gt;&gt; +# @endianness: the target endianness<br>&=
gt; &gt;&gt; +#<br>&gt; &gt;&gt; +# @machines: machine type names, not alia=
ses<br>&gt; &gt;&gt; +#<br>&gt; &gt;&gt; +# Since: 11.2<br>&gt; &gt;&gt; +#=
#<br>&gt; &gt;&gt; +{ &#39;struct&#39;: &#39;TargetMachines&#39;,<br>&gt; &=
gt;&gt; + =C2=A0&#39;data&#39;: { &#39;arch&#39;: &#39;SysEmuTarget&#39;,<b=
r>&gt; &gt;&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;endianness&=
#39;: &#39;EndianMode&#39;,<br>&gt; &gt;&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0&#39;machines&#39;: [&#39;str&#39;] } }<br>&gt; &gt;<br>&gt; &=
gt; We already have =C2=A0&#39;QemuTargetInfo&#39; struct which is used<br>=
&gt; &gt; with &#39;query-target&#39;, that should also be used with the<br=
>&gt; &gt; new &#39;query-targets&#39; command.<br>&gt; &gt;<br>&gt; &gt; W=
e need to add the &#39;endianness&#39; field to QemuTargetInfo.<br>&gt;<br>=
&gt; Why do we want to expose endianness, and what endianness to<br>&gt; ex=
pose? Endianness is a runtime bit state of CPUs. Sometime<br>&gt; this bit =
is hardwired but that is an implementation detail.<br>&gt;<br>&gt; See comm=
it 0e2c5647d92 and surrounding for MicroBlaze for<br>&gt; example.<div><br>=
</div><div>Please take a look at</div><div><a href=3D"https://gitlab.com/ly=
gstate-qemu/qemu/-/pipelines/2890507627">https://gitlab.com/lygstate-qemu/q=
emu/-/pipelines/2890507627</a></div><div><br></div><div>I do not have clue =
to fixes it properly<br><br><br><br>--<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0=E6=AD=A4=E8=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br>Yours<=
br>=C2=A0 =C2=A0 sincerely,<br>Yonggang Luo</div></div>

--0000000000009f0f20065c8f515a--

