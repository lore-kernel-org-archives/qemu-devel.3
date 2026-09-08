Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1915AC79F99
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 20:32:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x42Ud-0004Fd-HK; Tue, 08 Sep 2026 16:32:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amanasrani1712@gmail.com>)
 id 1x42UN-0004Eh-S0
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 16:32:19 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <amanasrani1712@gmail.com>)
 id 1x42UL-0003wt-SC
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 16:32:19 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-c25420fe973so899059966b.0
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2026 13:32:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788899536; cv=none;
 d=google.com; s=arc-20260327;
 b=nGX6JQxYuUtaMxAZFKY48cC/CFiSGYvmhz1K9morSf7qZWmqQ6lCLWQ5aKzlMZ3fx1
 UF/BqVeoN2CqHXHSsGgpqJi1ab4F5kf5r7wPUp0u54EimpLF+RbJn2lo7MNX9Cjx/Rg/
 L99AOO9jH1Dx89VguY0mzsAzMfMH2gKMTtg1CfXHqZRBZCw5Rh0oWAlQuSzYOrFGRYZZ
 5uROQlLi23gAdVZqW5ZXGmlCRI+B1lwip261FMIz/a9eLOp5eP2D72F/aztn0RQ3l5ph
 JOEhc18PvSxy3fLbeBWXGN/R2C/c12FSF4tUByW/wHSiWM72zCz1z2o28E5oC3yhD2v1
 4cnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=BsVFwUedrlvIDFxNKc388Nh96M7fu3K7rkT6heFk8tI=;
 fh=vPii6Fro72GnsvsO8GqqWh2y2ZwYqRUMBEz7CK42yVY=;
 b=iVGkXOHLfFtJp4FoNxU1bzX4VsEbYWiXfYl7jsMxqDia+laMNOqvYqMCYaWyKsUG4s
 ZSAWGOyCXSjAUjXYcZlB2rdY/ctzAct8i7TX0FVB/v15KUkEy5VSu4LjwzDAawygeK25
 OdlS59Q3p32uOa3imulRNHfAA3oJIHRspF2X/D7cQY11oIraz0VZNWgRwUPLpIxjnJG3
 3GI4vlxAgH/pGPp3F7jqvHFB1pAP3GibN5wUbtxZpylzIOx8o9/D0CGr8vbIEKMlQX4u
 9+cZLEa/hLDbxSCH+FWC/RtiaqJsrbqZWACj6CE+H/kTcNUAZG4+c1Z2Wl8eTtS3Obpe
 CXiw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788899536; x=1789504336; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=BsVFwUedrlvIDFxNKc388Nh96M7fu3K7rkT6heFk8tI=;
 b=ePTSYng+PtP2uTctY4gSTSnnyvI4WTYPYmNY9iwMNUFA+Ti8gvx3POSg2hTgEw2A+V
 5s2K/OkN1oALwr3z6wWDtNi5LoA0nzd5LvCu/KYXXKNtQ+Tw2vBrqYpja1UpFnWnst9B
 kOuxqWZDuIqeN1Ti3HUJbhQYoCQEYWNrF9Lo0b+EueGtlGhxNTajHms3IUtLtxsL3Jcf
 ymtwuui2gNDCd4+KxHBwSbHd3KZogDIPPo8P6Q1RQ4hWbgzEZL9ypUkS+cpZEmAscty6
 NXlV5XuAmKJBEoxIr/U+ynQjeq176C9MEKrezYhPkW0DmnYvap6Fp3S7naNregt+wdZK
 wVPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788899536; x=1789504336;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=BsVFwUedrlvIDFxNKc388Nh96M7fu3K7rkT6heFk8tI=;
 b=QJ6JpW/8yJAcDNXXFDTyEzDSsby4aRDxNCOIMxt6F5+O3Lr5eK7hXgqammUvS4K+OU
 egkyHdUU6HEJmATaEbJ81yF+H+PZUd6ZsgzOQFFwk6HhWAD0B2Mq8mdXkUXP6BT7px9E
 1tHeRxXg+VITcH/aWsEu/j9uRGy9WR5Cv1x6/CwHAqQBxTv6CjBCo6eRtf8iU2AMv78N
 dP3Yj1qG4mpFC+qS1zlsN4IbDs7oyc1wHAc0P7QQFoBFajSFbCCCfNYCIVqrL1xTKPrg
 rajpVvX0iuNRJtnEotfvJd7YaYEW4YFuGALKELIomo6X4EUD+XHQFigGj1d7IK7qdtHh
 6xmg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxfy6IdTCoVfaP3dWOXyjLDNaUSVKdXFd2zOXpvTMswZ7fsYzVM6yGbaP03uBhBbw5sY7QrcFT1jGl/@nongnu.org
X-Gm-Message-State: AFuF++nIWeVmbY19niBB3KJfMvo25wfNWDoiRg7ysiMIh7acc4fbHSgW
 y7xC+BonAum9TG3OWS8STZFmjVjFlSiTr7w2bC3ysvDderI8MtDsBWTzJEhOaJuS/DS2uUwXEvB
 RyfcJ9n5S//f+FEWbxsqIxvXElmCzbzY=
X-Gm-Gg: AYBFou2UfmcB0eLmMFwNghja31bJLl22YWL8R7pSSv1spJNksyjW4d4EiQpR/Yn01u7
 RJGpY6HsQO3lQMWu6+I4INPDvRsFJ1mMQ4Q5OvAHFEmKSyCun9ToQM4aqH31VnpRv4mSd1ohmHg
 2Elqnd5DWUBLMZXCsRhTFD2Twd2QbMzuPg2oyacBVd9FP7/QrYiC5Fx7dVstQPAQePGMUPhGuG/
 tTYcPeePWBE0xE+0tjCJewIXBNUVwl//qAxFV+/4CdXet0TRL0ljkSLMN+yC3xdcHrto9Omg3El
 c6PBNfUdQV1SKb4sFTPGLQSiK38j+YONplWbQkYmXi3V
X-Received: by 2002:a17:906:c112:b0:c24:d6f0:2071 with SMTP id
 a640c23a62f3a-c260c987f76mr1327079866b.12.1788899535898; Tue, 08 Sep 2026
 13:32:15 -0700 (PDT)
MIME-Version: 1.0
References: <CADExdLCU82TQaQ8+Po1cJ4QVdeyvMJmnY+JmnJtQn_xgztdQRA@mail.gmail.com>
 <c8b5723a-a05e-41c2-9e1a-77719b598f6b@tls.msk.ru>
In-Reply-To: <c8b5723a-a05e-41c2-9e1a-77719b598f6b@tls.msk.ru>
From: Aman Asrani <amanasrani1712@gmail.com>
Date: Wed, 9 Sep 2026 02:02:04 +0530
X-Gm-Features: AcwNN1UA6wpedv4ZwSeWr94fGdWetMKpoD_Hya-0Pp7KJ5YunVIyUQ_uwmxmr8I
Message-ID: <CADExdLC9GPLLM1pU=U6+QEmi71u8bB_RvJoe2LHKarOp5AZBUQ@mail.gmail.com>
Subject: Re: [stable-8.2] Backport request: rbd: Fix .bdrv_get_specific_info
 implementation
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-stable@nongnu.org, qemu-devel@nongnu.org, kwolf@redhat.com
Content-Type: multipart/alternative; boundary="000000000000604a78065afea1ed"
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=amanasrani1712@gmail.com; helo=mail-ej1-x62f.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--000000000000604a78065afea1ed
Content-Type: text/plain; charset="UTF-8"

Hi Michael,

Thank you for the clarification and for the context regarding the status of
the 8.2 branch. I completely understand the situation and will proceed by
coordinating directly with the Ubuntu maintainers.

Thanks again for your time and for the work you do on QEMU.

Best regards,
Aman Asrani

On Tue, 8 Sept 2026 at 20:03, Michael Tokarev <mjt@tls.msk.ru> wrote:

> On 9/8/26 13:52, Aman Asrani wrote:
> > Hi,
> >
> > I would like to ask whether commit |4af976ef398e| ("rbd: Fix
> .bdrv_get_specific_info implementation") could be considered for a
> stable-8.2 release.
> >
> > This refers to the original upstream patch submission:
> > https://lists.gnu.org/archive/html/qemu-devel/2025-08/msg04048.html <
> https://lists.gnu.org/archive/html/qemu-devel/2025-08/msg04048.html>
> >
> > I am aware that stable-8.2 is closed, and that stable releases normally
> follow the currently maintained major release. I am therefore asking
> knowing
> > this is outside the normal stable policy, and I would completely
> understand if the answer is no.
>
> Yes, 8.2 is end-of-life for a long time.
>
> > The reason for asking is that Ubuntu 24.04 LTS ships QEMU
> |1:8.2.2+ds-0ubuntu1.16| and is supported until 2029. As a result,
> deployments using this
> > QEMU version with Ceph/RBD storage can remain affected for the remainder
> of the Ubuntu LTS support lifetime. The fix is present in newer maintained
> > QEMU branches but cannot reach 8.2 through an upstream stable release.
>
> Heh.
>
> The problem with ubuntu is like they don't know what they want.
>
> First, before closing 8.2.x line, I asked them if they want this
> line to be maintained for longer than usual.  They didn't answer,
> so I closed it.
>
> Later I talked to one of their qemu maintainers, and he asked me
> to resume that 8.2.x line, - he wanted to update qemu in ubuntu
> based on the upstream 8.2.x stable series.  I was like, meh, but
> we're quite behind already, it's been closed a couple months ago.
>
> So I went back and re-evaluated all updates happened during this
> time, and resumed 8.2.x line.  This went on for quite some time.
>
> Later, there were a few (ubuntu) users complaining some bugs were
> not fixed in 8.2.x stable line.  But I knew for sure I fixed them
> in subsequent 8.2.x, long ago already.  Meh.
>
> So I looked which version is available in ubuntu, and discovered
> they never, ever, updated their 8.2.2 (or .3?) in ubuntu 24.04
> since 24.04.  There were a few hand-applied updates which bothered
> their users, and that's it.  No single release I made for them were
> actually used, and their people complained to *me* that their version
> is buggy.
>
> So I asked them again what's going on, but never got a reply.
>
> So in the end I closed this line, now for good.  They're on their
> own, together with their users.  I don't care about ubuntu anymore,
> -- ubuntu is just a waste of resources and frustration, nothing more.
>
> Thanks,
>
> /mjt
>

--000000000000604a78065afea1ed
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div><div dir=3D"ltr">Hi Michael,<br><br>Thank you for the clarification an=
d for the context regarding the status of the 8.2 branch. I completely unde=
rstand the situation and will proceed by coordinating directly with the Ubu=
ntu maintainers.<br><br>Thanks again for your time and for the work you do =
on QEMU.<br><br>Best regards,<br>Aman Asrani</div></div><div><br><div class=
=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, 8 Sept 2026 =
at 20:03, Michael Tokarev &lt;<a href=3D"mailto:mjt@tls.msk.ru" target=3D"_=
blank">mjt@tls.msk.ru</a>&gt; wrote:<br></div><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,20=
4);padding-left:1ex">On 9/8/26 13:52, Aman Asrani wrote:<br>
&gt; Hi,<br>
&gt; <br>
&gt; I would like to ask whether commit |4af976ef398e| (&quot;rbd: Fix .bdr=
v_get_specific_info implementation&quot;) could be considered for a stable-=
8.2 release.<br>
&gt; <br>
&gt; This refers to the original upstream patch submission:<br>
&gt; <a href=3D"https://lists.gnu.org/archive/html/qemu-devel/2025-08/msg04=
048.html" rel=3D"noreferrer" target=3D"_blank">https://lists.gnu.org/archiv=
e/html/qemu-devel/2025-08/msg04048.html</a> &lt;<a href=3D"https://lists.gn=
u.org/archive/html/qemu-devel/2025-08/msg04048.html" rel=3D"noreferrer" tar=
get=3D"_blank">https://lists.gnu.org/archive/html/qemu-devel/2025-08/msg040=
48.html</a>&gt;<br>
&gt; <br>
&gt; I am aware that stable-8.2 is closed, and that stable releases normall=
y follow the currently maintained major release. I am therefore asking know=
ing <br>
&gt; this is outside the normal stable policy, and I would completely under=
stand if the answer is no.<br>
<br>
Yes, 8.2 is end-of-life for a long time.<br>
<br>
&gt; The reason for asking is that Ubuntu 24.04 LTS ships QEMU |1:8.2.2+ds-=
0ubuntu1.16| and is supported until 2029. As a result, deployments using th=
is <br>
&gt; QEMU version with Ceph/RBD storage can remain affected for the remaind=
er of the Ubuntu LTS support lifetime. The fix is present in newer maintain=
ed <br>
&gt; QEMU branches but cannot reach 8.2 through an upstream stable release.=
<br>
<br>
Heh.<br>
<br>
The problem with ubuntu is like they don&#39;t know what they want.<br>
<br>
First, before closing 8.2.x line, I asked them if they want this<br>
line to be maintained for longer than usual.=C2=A0 They didn&#39;t answer,<=
br>
so I closed it.<br>
<br>
Later I talked to one of their qemu maintainers, and he asked me<br>
to resume that 8.2.x line, - he wanted to update qemu in ubuntu<br>
based on the upstream 8.2.x stable series.=C2=A0 I was like, meh, but<br>
we&#39;re quite behind already, it&#39;s been closed a couple months ago.<b=
r>
<br>
So I went back and re-evaluated all updates happened during this<br>
time, and resumed 8.2.x line.=C2=A0 This went on for quite some time.<br>
<br>
Later, there were a few (ubuntu) users complaining some bugs were<br>
not fixed in 8.2.x stable line.=C2=A0 But I knew for sure I fixed them<br>
in subsequent 8.2.x, long ago already.=C2=A0 Meh.<br>
<br>
So I looked which version is available in ubuntu, and discovered<br>
they never, ever, updated their 8.2.2 (or .3?) in ubuntu 24.04<br>
since 24.04.=C2=A0 There were a few hand-applied updates which bothered<br>
their users, and that&#39;s it.=C2=A0 No single release I made for them wer=
e<br>
actually used, and their people complained to *me* that their version<br>
is buggy.<br>
<br>
So I asked them again what&#39;s going on, but never got a reply.<br>
<br>
So in the end I closed this line, now for good.=C2=A0 They&#39;re on their<=
br>
own, together with their users.=C2=A0 I don&#39;t care about ubuntu anymore=
,<br>
-- ubuntu is just a waste of resources and frustration, nothing more.<br>
<br>
Thanks,<br>
<br>
/mjt<br>
</blockquote></div>
</div>

--000000000000604a78065afea1ed--

