Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28C23FEA814
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2026 07:01:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5IEf-0003pO-7c; Wed, 25 Mar 2026 03:01:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w5IEe-0003pF-B4
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 03:01:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w5IEc-0008LO-NN
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 03:01:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774422056;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fDWdFYschMvZsV6n8P91xQQUzluThfHYeAs7SXI1FuM=;
 b=dziy2l2rPaFuRaaiAb0hAqQ+yD+jMcdLaK19+5zJdUww2Vx++EJeMVKTl9KWZtAvGJoUK6
 OPSOswj5qg702lYUXEcxtGgVyqUQRqKoBlBHOn1dm0JMTxjjnThAVwCm4fW5qnOFYxhQdc
 vIbgOwl4cZFsUmhBPlUMT4w+DQpBmvE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-64-Um3bhX5FOZ2EOT88FBUYHg-1; Wed, 25 Mar 2026 03:00:54 -0400
X-MC-Unique: Um3bhX5FOZ2EOT88FBUYHg-1
X-Mimecast-MFC-AGG-ID: Um3bhX5FOZ2EOT88FBUYHg_1774422053
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-439c112b1a4so2727246f8f.3
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2026 00:00:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774422053; cv=none;
 d=google.com; s=arc-20240605;
 b=Wl99Eyie3ZPzHYlcOpNeTIGJPvoY98N20uMLbyTMDdZLw/2hg6CN21nmL0NEEkznUl
 lxgP6qCqdezLMi/VFLeJOlqZGIChd+ShkQ7fyecUjDvIi03PIev4yJoVKjETcTMhatbQ
 zaOYeT78d6Pf6rpfdcD7rH1mSQBUO5GQt1sCRPuNCDzcD3qEGO2uE2cAF8It1lYGywb/
 7Ouct1Hl3ntJXUAL4F/s8KNNEFRBzgGkaJgCejU7MFoaKuF0ZgeEmYNfrJEiGu6/8utt
 sY1cxQByYSYe98S9yktcInOytXVRpTyY2oHzoYqPj9+0/OXZCmbBQGijP1GGOlPxA06y
 wH6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=fDWdFYschMvZsV6n8P91xQQUzluThfHYeAs7SXI1FuM=;
 fh=z5zLVx7biUVgmF8IXR4zlw3g/GraE2IcqOjlGjNrAIE=;
 b=QGxEyhPLDP4HsWFv1bwdDz5oXrDgeVS7Jhhgs18oL45ooCoSeTPwImSpd4Ch1vu785
 ngkVN51i/L7njQTYYFdf6nEh9iONSKY+9lLzCFVmt6+kov1NTbAKvZ3tMxooEt5rG6q8
 17UpFXYC41IF9pYk25Cak/kKVQF94s9dh3KpYYyoswdscl1cYhcF2haVTau2F8B/Hcli
 gTypRzkVTlJ+IgaaLZ53VczmlL5MUW/zd8erHd2XLdR3meNtwKtTcUJZAb/K1bdha4kH
 h0yfDEhfjNRy3l8OUzD7dHpNcYC3sIvKZpqKY/fplhSbsoYoHpFU9Hggv4w0tqLAY36F
 9upg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774422053; x=1775026853; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=fDWdFYschMvZsV6n8P91xQQUzluThfHYeAs7SXI1FuM=;
 b=h+VtpAZpFBFvJgBmVGvZgbILDjq3sTjxn8qPA9b810RGq1qh/ybjc54W67M/D7rOD1
 6gTh3L8syzGBJ7vXeoOoDSiQ77Wb6Wr6gvDj8g4G3L+l/k8rMARlq8/6dslqnM+rlZSV
 P5GBD5BMjl8VJvzxy913MahsP4LLJ7jRWOiiMLHvf4473JAkPOOQ1tJr/KXrRSO0C/ca
 MOkJ/U9KICiLUxsgNGjUcadoQj+o4aHWy31+bcvDmCPA3XzgwYb1FerFbun4/mbHloUy
 v2TOK78bbfCpwC+wk3XWW3gTlMxYWmG5hKAWS3n5mFIU2MWcemZ7ZhbrRF/JlGxmZFHf
 QPpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774422053; x=1775026853;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fDWdFYschMvZsV6n8P91xQQUzluThfHYeAs7SXI1FuM=;
 b=WARHkE3l2e7f9IVGeCEIM4CHU2I0mbHFxoAzxgv/9PaDgfXrClPtltV3DuFW0QOC06
 6SKD/velbc0jLiCD1o/ReKCbolqdS6o8Vo/YHfCuqq4eXc5l46iQpnV2OiL5AufUHz0C
 T/an3BlX68byTQ6oRY5P8cAP2xT71pfmffXFUFELz1keKA8hjVesCLs7gqI7gO7Wznl6
 4SUOhMnlQdViZu/9zbQOx2gI1st+IMToSf8rosZWbDQ46XKVIVzVtc3wW6Q7s2u3Kis+
 YBlSTihkQBOuvaimQ9E5bR4rfEk4A0bqN5vNlGZcq+fhFp6pzVqQO6LXIui6uiZcHBfu
 VFKQ==
X-Gm-Message-State: AOJu0Yx5p5Jrwi+XcCzzx3esfOc/9wL4R8s0URro5UH/exjKkNfvYQPw
 4oaDehW5Q5p85QOMb+YXqICdMfxWBgVhMw6zhaoS7WTfiQ+3KfTZHw2UojkoX9mBKungvxKxgRO
 yZIrj7E/8CkKFS9kY12HDOf/LoAEkBWiquPqwvoOxpECMmGLmX4gax+TY6vvTbW4YD4lYucjhHQ
 caglYSeUNWbryJdInwrJFtBpgnLgollI2WqMS3AMA=
X-Gm-Gg: ATEYQzwUJgS+l4pDK5jDteqfPn/aGaJ5XYWQ0G2LnL4c7MBZFStfuTU1e7tycD+yA9/
 zQjAdMtG1Li9qlNEumE7wnr4ACq3afNgnRYSSfI9baB2TcnA63avSaSivjiBMhWpwDD+RMAd1sh
 UvqdTh7RggIGJmlHwRph0kirxXp576e6FoSCM/L6DoF30Al0PiaipbntJwm1wGSx8U1E3HGsasZ
 hwYoxN9iSq5XUJqf7qJrudUvLI7GNtLODLbb02lHU+13mrjiP3hChPeR0NhOynVtFw7dW+B8GFB
 iTrf
X-Received: by 2002:a05:6000:208a:b0:432:5c34:fb32 with SMTP id
 ffacd0b85a97d-43b889bd8b5mr3323888f8f.23.1774422052278; 
 Wed, 25 Mar 2026 00:00:52 -0700 (PDT)
X-Received: by 2002:a05:6000:208a:b0:432:5c34:fb32 with SMTP id
 ffacd0b85a97d-43b889bd8b5mr3323781f8f.23.1774422051566; Wed, 25 Mar 2026
 00:00:51 -0700 (PDT)
MIME-Version: 1.0
References: <20260324165705.785605-1-pbonzini@redhat.com>
 <3768bc38-1231-4f62-9ac8-c27e8bb66e7b@linaro.org>
In-Reply-To: <3768bc38-1231-4f62-9ac8-c27e8bb66e7b@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 25 Mar 2026 08:00:00 +0100
X-Gm-Features: AQROBzBpG1fKeeT6xTheY31xdtcnuQMQk8Baa19x2TLpwulhvD6rtUVcAo0zOAc
Message-ID: <CABgObfZXP1XvFg_SNPJ=dP7gXix3g=ZTq-jnC71WTv+cCusVPA@mail.gmail.com>
Subject: Re: [PATCH] treewide: replace qemu_hw_version() with QEMU_HW_VERSION
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="00000000000010d05d064dd3d41d"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

--00000000000010d05d064dd3d41d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Il mar 24 mar 2026, 20:18 Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> h=
a
scritto:

> On 24/3/26 17:57, Paolo Bonzini wrote:
> > The version is never set on 2.5+ machine types, so qemu_hw_version() an=
d
> > qemu_set_hw_version() are not needed anymore.
> >
> > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > ---
> >   include/hw/core/boards.h  |  6 ------
> >   include/qemu/hw-version.h | 15 ---------------
> >   hw/ide/core.c             |  2 +-
> >   hw/scsi/megasas.c         |  2 +-
> >   hw/scsi/scsi-bus.c        |  2 +-
> >   hw/scsi/scsi-disk.c       |  2 +-
> >   system/vl.c               |  4 ----
> >   target/s390x/cpu_models.c |  2 +-
> >   util/osdep.c              | 12 ------------
> >   9 files changed, 5 insertions(+), 42 deletions(-)
>
>
> > diff --git a/include/qemu/hw-version.h b/include/qemu/hw-version.h
> > index 730a8c904d9..a40a6c204a6 100644
> > --- a/include/qemu/hw-version.h
> > +++ b/include/qemu/hw-version.h
> > @@ -7,21 +7,6 @@
> >   #ifndef QEMU_HW_VERSION_H
> >   #define QEMU_HW_VERSION_H
> >
> > -/*
> > - * Starting on QEMU 2.5, qemu_hw_version() returns "2.5+" by default
> > - * instead of QEMU_VERSION, so setting hw_version on MachineClass
> > - * is no longer mandatory.
> > - *
> > - * Do NOT change this string, or it will break compatibility on all
> > - * machine classes that don't set hw_version.
> > - */
> >   #define QEMU_HW_VERSION "2.5+"
>
> Maybe rename as QEMU_HW_VERSION_2_5P if we remove the "do not change
> this string" comment.
>

Maybe, on the other hand *which* version is used as the baseline (2.5+) is
an implementation detail. Even if we added QEMU_HW_VERSION_11_1+ tomorrow,
the baseline would stay the same. The comment is clear.

Paolo


> >
> > -/* QEMU "hardware version" setting. Used to replace code that exposed
> > - * QEMU_VERSION to guests in the past and need to keep compatibility.
> > - * Do not use qemu_hw_version() in new code.
> > - */
> > -void qemu_set_hw_version(const char *);
> > -const char *qemu_hw_version(void);
> > -
> >   #endif
>
>

--00000000000010d05d064dd3d41d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">Il mar 24 mar 2026, 20:18 Philip=
pe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@linaro.org">philmd@linar=
o.org</a>&gt; ha scritto:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">On 24/3/26 17:57, Paolo Bonzini wrote:<br>
&gt; The version is never set on 2.5+ machine types, so qemu_hw_version() a=
nd<br>
&gt; qemu_set_hw_version() are not needed anymore.<br>
&gt; <br>
&gt; Signed-off-by: Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com=
" target=3D"_blank" rel=3D"noreferrer">pbonzini@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0include/hw/core/boards.h=C2=A0 |=C2=A0 6 ------<br>
&gt;=C2=A0 =C2=A0include/qemu/hw-version.h | 15 ---------------<br>
&gt;=C2=A0 =C2=A0hw/ide/core.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0|=C2=A0 2 +-<br>
&gt;=C2=A0 =C2=A0hw/scsi/megasas.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0=
 2 +-<br>
&gt;=C2=A0 =C2=A0hw/scsi/scsi-bus.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 2 +-=
<br>
&gt;=C2=A0 =C2=A0hw/scsi/scsi-disk.c=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 2 +-=
<br>
&gt;=C2=A0 =C2=A0system/vl.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0|=C2=A0 4 ----<br>
&gt;=C2=A0 =C2=A0target/s390x/cpu_models.c |=C2=A0 2 +-<br>
&gt;=C2=A0 =C2=A0util/osdep.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 | 12 ------------<br>
&gt;=C2=A0 =C2=A09 files changed, 5 insertions(+), 42 deletions(-)<br>
<br>
<br>
&gt; diff --git a/include/qemu/hw-version.h b/include/qemu/hw-version.h<br>
&gt; index 730a8c904d9..a40a6c204a6 100644<br>
&gt; --- a/include/qemu/hw-version.h<br>
&gt; +++ b/include/qemu/hw-version.h<br>
&gt; @@ -7,21 +7,6 @@<br>
&gt;=C2=A0 =C2=A0#ifndef QEMU_HW_VERSION_H<br>
&gt;=C2=A0 =C2=A0#define QEMU_HW_VERSION_H<br>
&gt;=C2=A0 =C2=A0<br>
&gt; -/*<br>
&gt; - * Starting on QEMU 2.5, qemu_hw_version() returns &quot;2.5+&quot; b=
y default<br>
&gt; - * instead of QEMU_VERSION, so setting hw_version on MachineClass<br>
&gt; - * is no longer mandatory.<br>
&gt; - *<br>
&gt; - * Do NOT change this string, or it will break compatibility on all<b=
r>
&gt; - * machine classes that don&#39;t set hw_version.<br>
&gt; - */<br>
&gt;=C2=A0 =C2=A0#define QEMU_HW_VERSION &quot;2.5+&quot;<br>
<br>
Maybe rename as QEMU_HW_VERSION_2_5P if we remove the &quot;do not change<b=
r>
this string&quot; comment.<br></blockquote></div></div><div dir=3D"auto"><b=
r></div><div dir=3D"auto">Maybe, on the other hand *which* version is used =
as the baseline (2.5+) is an implementation detail. Even if we added QEMU_H=
W_VERSION_11_1+ tomorrow, the baseline would stay the same. The comment is =
clear.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Paolo</div><div d=
ir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote gmail_quo=
te_container"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px=
 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt;=C2=A0 =C2=A0<br>
&gt; -/* QEMU &quot;hardware version&quot; setting. Used to replace code th=
at exposed<br>
&gt; - * QEMU_VERSION to guests in the past and need to keep compatibility.=
<br>
&gt; - * Do not use qemu_hw_version() in new code.<br>
&gt; - */<br>
&gt; -void qemu_set_hw_version(const char *);<br>
&gt; -const char *qemu_hw_version(void);<br>
&gt; -<br>
&gt;=C2=A0 =C2=A0#endif<br>
<br>
</blockquote></div></div></div>

--00000000000010d05d064dd3d41d--


