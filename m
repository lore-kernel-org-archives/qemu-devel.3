Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FF48C88E75
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 11:26:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6RIn-0005nP-Tx; Tue, 15 Sep 2026 07:26:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1x6RIl-0005dN-Qo
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 07:26:16 -0400
Received: from mail-ed2-x10.google.com ([2a00:1450:4864:33::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1x6RIj-0002Jd-O1
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 07:26:15 -0400
Received: by mail-ed2-x10.google.com with SMTP id
 4fb4d7f45d1cf-6a6056c2064so262091a12.2
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 04:26:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789471572; cv=none;
 d=google.com; s=arc-20260327;
 b=NYzimDbocPjSBs8RiiyfA3axBqPToWOfae+g9KGx8ibXZh1Ly45cgyRGpEWlIyQsgQ
 JmLpUCEDROqC7ykjrAGRA0JeAZFCkQRL45+qTX0D8NghIifJVOE/CjqVC6lehwx+8MBp
 3rNYwCnZOqlCpr1jqGJwWfxUkb193zUive0xkINSWaJlrJKLYXd9vO7r33atiPVUQQit
 2UUxV+hZUbCeKox3CGK6udjKEmqqRpFIfyQ6jyHdlnbudiCoTA1oZB9z6RqiPAW4eJkq
 ot/KGMIGBFGeUQ9uaK6/hVCXfm0/j9Eua7gNEk1lCIlGPOpJf90vhUFYLGhjVu96Bgdv
 7msA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:reply-to:in-reply-to:references
 :mime-version:dkim-signature;
 bh=QoAUr7dH4x782a37oj+O51AbL1F7aY4b2VlFcQihDQc=;
 fh=1JHgCGjsjXKharBQYmNUy56N8E7qo/g8a1EIu3uoMfs=;
 b=dt2uPcOTXsqRAhlM6SOR6gK+TKwUpMhDp+xINUAH1XoywEcAtIE6NfjAZ7VQzV8KXy
 UuVTPi0iWrZ+X0/9BCsgZbe7EoO67gX6ZYLGxAMRKMKX566QboMEaffLAmgWPmQl8ohu
 tW01QFtvDRltUel535nFxWa0FmNs3/QJ3+gK9HMwwwGA8vl6QoUqqm6naBKd0zfAk5/Y
 HJeT73uXSNB8uVXNKqmI/GEKxuBFooZXqsHFSsI547Zm9m8Qp0lCnGTmsr2j4GGF9Bf2
 zYzaUHqhEJnszH7FNYbMQH+1BfxtRphPyrrcasSq1iBHNI3GnADPYIkJgdM19oz7912Z
 nw8g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789471572; x=1790076372; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:reply-to
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QoAUr7dH4x782a37oj+O51AbL1F7aY4b2VlFcQihDQc=;
 b=o5pp8ssrh1x0WUDcur8PvcEPG8jN7sqUeSx4VGFoTpefmy8J3JfoUF9TPh7RYdmKtq
 tnhDMT29lGcQqdwhw5XJO/AtiX95ZztVbdiIG+pctgSb7paPH6Q5dpjv/OFLMvX+UB4q
 iqEElki3pJVAJeqNqg3V4zdWCrYdp07rfJ5Jyo6K/wSIarphnzJuI2LhdVcWlcMTVA98
 /DZJELJpL0/wymA3+qKmDtS0CA1TJkHtLyjTBtT282KRVhJheITQVkCuqsQKwZP043Te
 1RVvVcrNp19qoBiytZsYOtPJZ3s8GbBORcYh5zavtMKtsgylcYS4IzllcGu81/Ie/gSQ
 Swsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789471572; x=1790076372;
 h=content-type:cc:to:subject:message-id:date:from:reply-to
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=QoAUr7dH4x782a37oj+O51AbL1F7aY4b2VlFcQihDQc=;
 b=OYPCzRCxznCWTfJ8UZNZ6ltsXCFkMiNdaQ43CeoVZrZWO+sIr0DDhFd58hrSbxP64g
 hsnnUPzIrMfakwyLVZhpR+AyCbK6PGIU8pqecUTeMaMGYUoFSFvXBO5RZbaaSxe7JTOv
 ncPr1peRWTsJ1YXp/H5L1K8zK2bEtPK2JKSq9ZX988vqhVZBLb7aKXCfkoPCnLIUOhg3
 Xb4xX3RkJjozY9tglAF5wWyXOxZwtH1QTMYeHtFe3bIID5IFXfv4jogyPvNdxH71irhP
 cOVW72LL9PgujyTKo73LHbSQVCJ1maxkykkrKi7sjelBXa2vap7lJXBdNjcS2juHLcXg
 Sgvg==
X-Gm-Message-State: AFuF++mtg8ufkDcR7+JKorNs+/2pisudyU77B5ooV1CKHcpZB8PPrEG6
 f+mBm9yrE7O5jJo4q6LubJLRmdvrCMFmkz8v99o3LuPmS1cEaqGkywlAy2Abvaml8cy9ijy1hKz
 pz5B1ZeujpjsOcpm5X+mMbrX5WlfwthOk+2Wf
X-Gm-Gg: AYBFou2WhTZtxMCqPwKaseHeIlzdZ7yB5uGWT1SyoXTOPMeve/neKjQ6D5Uf4zmwFJe
 YmdxvTDQoxLsXKJwC4/37TuQtQ8iRBwIoJJ3hR2DjgTq0dWIbvqr+HgI2g5zRmBUioEso9qR5By
 UOsa5wiIvFbFzAiPT3Kgl+lCaHz4mfEkIXGyOX5/Wce1uRbA+5akAoaWLwOQi0tlxJRqnlrOKHG
 e5zZ7HC4AhUkxfkfgLFwH/uKIDp2aRQa6xSllOqnzOhaT6IePrTrsAMP6jISJKuQ4f+ubW15ARD
 dz/E2hjlAaeyJPVPfzpS7/Djir9k5H4U5QeSE890uLAfSGRKo+4378k=
X-Received: by 2002:a05:6402:428b:b0:6a7:ee56:6168 with SMTP id
 4fb4d7f45d1cf-6aa12f2c341mr472135a12.42.1789471571667; Tue, 15 Sep 2026
 04:26:11 -0700 (PDT)
MIME-Version: 1.0
References: <CAE2XoE_=G5Ri9p23vJRX3iJMHSDH4Ec+0vWWbVNf4DksxtbG2A@mail.gmail.com>
 <57431f7c-fcdc-408e-b6a2-9a255315c882@redhat.com>
In-Reply-To: <57431f7c-fcdc-408e-b6a2-9a255315c882@redhat.com>
From: Yonggang Luo <luoyonggang@gmail.com>
Date: Tue, 15 Sep 2026 19:25:58 +0800
X-Gm-Features: AcwNN1XY3WqcOI5I9mvcQOGWAldL1bo629IboFqqq6pKaXEmx7v7qgYaGDHljFU
Message-ID: <CAE2XoE8Ue50M6TzdQ6zoNE5u1PsYz2_xwJYcnxRHGNyy9P2BLA@mail.gmail.com>
Subject: Re: The CPU_RESOLVING_TYPE is not fixed for x86_32 and x86_64. is
 that proper?
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-level <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="0000000000005d6e86065b83d1a5"
Received-SPF: pass client-ip=2a00:1450:4864:33::10;
 envelope-from=luoyonggang@gmail.com; helo=mail-ed2-x10.google.com
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
Reply-To: luoyonggang@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

--0000000000005d6e86065b83d1a5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 14, 2026 at 2:43=E2=80=AFPM Thomas Huth <thuth@redhat.com> wrot=
e:
>
> On 13/09/2026 07.45, Yonggang Luo wrote:
> > #define CPU_RESOLVING_TYPE TYPE_X86_CPU, and TYPE_X86_CPU is vary for
for
> > x86_32 and x86_64. can it define TYPE_X86_CPU to be a fixed 'x86-cpu'
like
> > other arches?
> TYPE_X86_CPU differs depending on whether you build the binary that
targets
> 64-bit guest CPUs (qemu-system-x86_64) or the binary that targets 32-bit
> guest CPUs (qemu-system-i386). You cannot easily change this without
> breaking migration from older QEMU versions.
>
> What's exactly the problem that you have run into that led to this
question?
>
> FWIW, I once proposed a patch series that allows to integrate both target
> types in one binary:
>
>
https://lore.kernel.org/qemu-devel/20260402095132.29245-1-thuth@redhat.com/
>
> ... however, I unfortunately failed to get the supporting attention of th=
e
> x86 maintainers, so this has never been merged.

Yeap, the same working on getting i386 to be in a single binary. We have
the same idea in some part.

>
>   Thomas
>


--
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--0000000000005d6e86065b83d1a5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><br>On Mon, Sep 14, 2026 at 2:43=E2=80=AFPM Thomas Hut=
h &lt;<a href=3D"mailto:thuth@redhat.com">thuth@redhat.com</a>&gt; wrote:<b=
r>&gt;<br>&gt; On 13/09/2026 07.45, Yonggang Luo wrote:<br>&gt; &gt; #defin=
e CPU_RESOLVING_TYPE TYPE_X86_CPU, and TYPE_X86_CPU is vary for for<br>&gt;=
 &gt; x86_32 and x86_64. can it define TYPE_X86_CPU to be a fixed &#39;x86-=
cpu&#39; like<br>&gt; &gt; other arches?<br>&gt; TYPE_X86_CPU differs depen=
ding on whether you build the binary that targets<br>&gt; 64-bit guest CPUs=
 (qemu-system-x86_64) or the binary that targets 32-bit<br>&gt; guest CPUs =
(qemu-system-i386). You cannot easily change this without<br>&gt; breaking =
migration from older QEMU versions.<br>&gt;<br>&gt; What&#39;s exactly the =
problem that you have run into that led to this question?<br>&gt;<br>&gt; F=
WIW, I once proposed a patch series that allows to integrate both target<br=
>&gt; types in one binary:<br>&gt;<br>&gt; =C2=A0 <a href=3D"https://lore.k=
ernel.org/qemu-devel/20260402095132.29245-1-thuth@redhat.com/">https://lore=
.kernel.org/qemu-devel/20260402095132.29245-1-thuth@redhat.com/</a><br>&gt;=
<br>&gt; ... however, I unfortunately failed to get the supporting attentio=
n of the<br>&gt; x86 maintainers, so this has never been merged.<div><br></=
div><div>Yeap, the same working on getting i386 to be in a single binary. W=
e have the same idea in some part.</div><div><br>&gt;<br>&gt; =C2=A0 Thomas=
<br>&gt;<br><br><br>--<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=E6=AD=A4=E8=87=
=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=A0 =C2=A0 s=
incerely,<br>Yonggang Luo</div></div>

--0000000000005d6e86065b83d1a5--

