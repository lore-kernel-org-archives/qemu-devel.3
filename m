Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1583C5B56A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 12:24:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu80I-0006ce-3G; Wed, 12 Aug 2026 08:24:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <munkhuu0825@gmail.com>)
 id 1wu805-0006ZA-Io
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 08:24:08 -0400
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <munkhuu0825@gmail.com>)
 id 1wu803-0001lp-Mj
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 08:24:05 -0400
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-5b0f19bea2fso1085146e87.1
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 05:24:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786537441; cv=none;
 d=google.com; s=arc-20260327;
 b=QRK0giEAgQuaanXMc+8EtQX4ZCcm4UYeGQroy02Ec0w9zCbBaEvDs6vRZK3hW68KaK
 hgx11/FmXqoNrmTKNcta0MPgXpOb4HFRFjcqFeywj1QaKGaKm54w2OitvSuHWkplQsp5
 +IvcJUVmuMDIT1pBWCPqVRA/KnX/yUQyCAGUZCV7Tgbka8HS+D4YvAge8xOe+gRXS4j5
 yU8pQqvVTb7tZarzHnt+UlNt6ShMAul1xM1momBI4WwEeNHpJEL9CwpiYLieJJglSOjT
 ksKX4SAWCw5kDI8wDsaJ/iFUZj/DsTuo8ypt10lFL7yWtOlRrRRa274b4lh1RnIkoq63
 9xrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=VGKpc5fs9CpN3O0XRdi3DPGwblHdhSHEqRf9oVAl/eA=;
 fh=eM91zeUFHDP1j5O68MwjI4XK2a+r++bKIUCOKXo7wm0=;
 b=jenV64/dRZVHBJu3fPc2NmXWytdX0/f0+4OcTEsKlJavdYKFQ7urSTsZkJpXNtCuo1
 ebj9M8qGCBCFrzk5F+vRSZWSbk+sMOEfWkOCJM001IZ/qC252d5CH+/n5Dgt5QhteQXR
 WqlKcajh+p6fXuVKdICmn/6sV+DVa57iWbe0FWTgqflcmCOAnwT5O6oUTGWPmph1d7Fq
 iiJ0UEHUn8Px1y7lvcUt1WHcCp2eq6WaxsFo6lkjGWQBdFUoze/Qifm39psjm4Tt8t63
 OXxt+Xcppr/OnYRiZbbZkbTFo3/+v3RYbQX4i8FBZaxXOei1J/sQlO4LTp48WBytp9Fd
 BqSw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786537441; x=1787142241; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=VGKpc5fs9CpN3O0XRdi3DPGwblHdhSHEqRf9oVAl/eA=;
 b=o/MRRk2wqu9ET86C2eZDtACzbOfR+bOlqCj4Hd7wETo1nOtYI3omCgcC1hdn6c3UnZ
 bAtnUVnh4EYVDdxhBmnnMulN+Ys35iCxQnt4nWQYBFSSDU96qRc58njBe2pYQHIimwu7
 ExNhPYkKgoWF46OSzLo0u9xXnU7hTRx7Hzzu3wvz7XLIIRZTe3wI246tuRMNFD0mumK9
 LRNMXmKic+2/jsHWE+umQRRqNotHJ5uTinZfTIm0T9E2bLNxsFZyyWXxkAu5694iESfJ
 kh/qbgYjkrTtHnVN6K6oFHceqhxst6icAIdw89Bdnc5YhgGBjv/9aHGEDctpeZUNCoDk
 D/mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786537441; x=1787142241;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=VGKpc5fs9CpN3O0XRdi3DPGwblHdhSHEqRf9oVAl/eA=;
 b=pwVXTT8RJw5QoUArNe4pi8RCEVAn5VGvfdcdCzNAB0YWC1m6K1i+8lM3h+lwFA2ejM
 fWeaspUOBgppoRcEcM/jqzWISrydOLr27wBVKMIBRhE0vSktYZRKnv46R6jwjwoP9+r9
 VTeN+OrVaUtntMdafjQot+SZ1SotnwfLDGAkeRM0CdwE52Kooa8vYq4q6ybwauoWrnqe
 1Kil4XEPnsfhS6INjdieD/7MxOVrbO6LbitNI1FbwMNQbsZ5shksESjg6bwWj8x1pYYr
 sfjwI448io6EWvs9t522X3phTXGT+2XfkNbUDlf0fLBEVxw6QW6YFCivbgZHUsoGC4yl
 ABJQ==
X-Gm-Message-State: AOJu0Yy/HygMjccavvfLR4IsOomOvJdEPaT+sNwCKi2CEJtchkFnmi1Z
 /5it5jsTvXULhR9Uquo15LQ+TiNxi4pRRIYeQ6/y1gCFANa6cfGXIVorCAuzkg0kUoVV/L40bRp
 q8vA/7npD+TnjKjiMVzK2sQpnH2YHbINypncP
X-Gm-Gg: AR+sD12dquj1vgaXIBRvYvJntrFMANFHWXUuSKYJwggrUYoZ1J5TH3oK87lRFuW1yeB
 f3HHrbrTDaUXJDLH8kKo6crtycCtMJKkQt6bNWWHaNmNNh2SZkkjDFKHRxytgKtHURHhMLOFRvg
 MkgYIqiwGDw1qtXFWAGAyy06sCpyejuhD2Mums3knvtm3gG/tOMIDL+1oMLspOnXyhlhWWbq4ZW
 f8CyiqnHJKI70xHDE2A9//qBR59URxNop4s86QzSMkDKIuZnrKlJMX5tZ12+Q98o/d7LqDW1tY7
 MqmgEhFxy7dXyEU7gk+Ct2IjQgUKyo+O1RD5/p1WljaX5c+HKJlbJbo=
X-Received: by 2002:ac2:48b9:0:b0:5b2:aaa2:1d8d with SMTP id
 2adb3069b0e04-5b44e2db449mr537458e87.2.1786537441000; Wed, 12 Aug 2026
 05:24:01 -0700 (PDT)
MIME-Version: 1.0
References: <20260507145100.4861-1-munkhuu0825@gmail.com>
 <3C7D6F09-F141-41F2-912B-E84C3A0887F2@gmail.com>
In-Reply-To: <3C7D6F09-F141-41F2-912B-E84C3A0887F2@gmail.com>
From: Munkhbaatar Enkhbaabar <munkhuu0825@gmail.com>
Date: Wed, 12 Aug 2026 20:23:49 +0800
X-Gm-Features: AUfX_mxgmUcFdhyxbgMhcRVIbHTwZDcE3F2oH5dHvq8npj-epWgsrUW-tKhy50o
Message-ID: <CA+0p-Wy7S1v85QPbDStssQjmyPyBKGX8OwE2zW6-kv9oJPJjHQ@mail.gmail.com>
Subject: Re: [PATCH] hw/virtio/virtio: Rebuild vring caches when packed ring
 changes
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, manos.pitsidianakis@linaro.org
Content-Type: multipart/alternative; boundary="0000000000008c850a0658d8a9f6"
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=munkhuu0825@gmail.com; helo=mail-lf1-x12e.google.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

--0000000000008c850a0658d8a9f6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Gentle ping on patch

On Tue, Jun 9, 2026, 11:47=E2=80=AFAM Munkhbaatar Enkhbaatar <munkhuu0825@g=
mail.com>
wrote:

> Hi,
>
> Just a gentle ping on this patch.
>
> It fixes a virtio-sound assertion with packed=3Don by rebuilding existing
> vring caches when VIRTIO_F_RING_PACKED changes. The issue is tracked here=
:
>
> https://gitlab.com/qemu-project/qemu/-/work_items/3466
>
> Please let me know if any changes are needed.
>
> Thanks,
> Munkhbaatar
>
> > On 7 May 2026, at 22:51, Munkhbaatar Enkhbaatar <munkhuu0825@gmail.com>
> wrote:
> >
> > A guest can enable a virtqueue before feature negotiation completes, so
> > virtio_queue_set_rings() creates caches before VIRTIO_F_RING_PACKED is
> > loaded into guest_features.
> > Packed rings need a writable descriptor cache because used descriptors
> are
> > written back into the descriptor ring. If the cache was created as a
> split
> > ring cache, this can later trigger an assertion.
> > Rebuild existing vring caches when VIRTIO_F_RING_PACKED changes, as
> already
> > done for VIRTIO_RING_F_EVENT_IDX.
> >
> > Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3466
> >
> > Signed-off-by: Munkhbaatar Enkhbaatar <munkhuu0825@gmail.com>
> > ---
> > hw/virtio/virtio.c | 3 ++-
> > 1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> > index 63e2faee99..14e7dd70be 100644
> > --- a/hw/virtio/virtio.c
> > +++ b/hw/virtio/virtio.c
> > @@ -3223,8 +3223,9 @@ int virtio_set_features_ex(VirtIODevice *vdev,
> const uint64_t *features)
> >     }
> >
> >     ret =3D virtio_set_features_nocheck(vdev, features);
> > -    if (virtio_vdev_has_feature(vdev, VIRTIO_RING_F_EVENT_IDX)) {
> > +    if (virtio_vdev_has_feature(vdev, VIRTIO_RING_F_EVENT_IDX) ||
> virtio_vdev_has_feature(vdev, VIRTIO_F_RING_PACKED)) {
> >         /* VIRTIO_RING_F_EVENT_IDX changes the size of the caches.  */
> > +        /* VIRTIO_F_RING_PACKED changes the cache->is_write value. */
> >         int i;
> >         for (i =3D 0; i < VIRTIO_QUEUE_MAX; i++) {
> >             if (vdev->vq[i].vring.num !=3D 0) {
> > --
> > 2.50.1 (Apple Git-155)
> >
>
>

--0000000000008c850a0658d8a9f6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Hi,<div dir=3D"auto"><br></div><div dir=3D"auto">Gentle p=
ing on patch</div></div><br><div class=3D"gmail_quote gmail_quote_container=
"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Jun 9, 2026, 11:47=E2=80=AF=
AM Munkhbaatar Enkhbaatar &lt;<a href=3D"mailto:munkhuu0825@gmail.com">munk=
huu0825@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote"=
 style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">Hi=
,<br>
<br>
Just a gentle ping on this patch.<br>
<br>
It fixes a virtio-sound assertion with packed=3Don by rebuilding existing<b=
r>
vring caches when VIRTIO_F_RING_PACKED changes. The issue is tracked here:<=
br>
<br>
<a href=3D"https://gitlab.com/qemu-project/qemu/-/work_items/3466" rel=3D"n=
oreferrer noreferrer" target=3D"_blank">https://gitlab.com/qemu-project/qem=
u/-/work_items/3466</a><br>
<br>
Please let me know if any changes are needed.<br>
<br>
Thanks,<br>
Munkhbaatar<br>
<br>
&gt; On 7 May 2026, at 22:51, Munkhbaatar Enkhbaatar &lt;<a href=3D"mailto:=
munkhuu0825@gmail.com" target=3D"_blank" rel=3D"noreferrer">munkhuu0825@gma=
il.com</a>&gt; wrote:<br>
&gt; <br>
&gt; A guest can enable a virtqueue before feature negotiation completes, s=
o<br>
&gt; virtio_queue_set_rings() creates caches before VIRTIO_F_RING_PACKED is=
<br>
&gt; loaded into guest_features.<br>
&gt; Packed rings need a writable descriptor cache because used descriptors=
 are<br>
&gt; written back into the descriptor ring. If the cache was created as a s=
plit<br>
&gt; ring cache, this can later trigger an assertion.<br>
&gt; Rebuild existing vring caches when VIRTIO_F_RING_PACKED changes, as al=
ready<br>
&gt; done for VIRTIO_RING_F_EVENT_IDX.<br>
&gt; <br>
&gt; Resolves: <a href=3D"https://gitlab.com/qemu-project/qemu/-/work_items=
/3466" rel=3D"noreferrer noreferrer" target=3D"_blank">https://gitlab.com/q=
emu-project/qemu/-/work_items/3466</a><br>
&gt; <br>
&gt; Signed-off-by: Munkhbaatar Enkhbaatar &lt;<a href=3D"mailto:munkhuu082=
5@gmail.com" target=3D"_blank" rel=3D"noreferrer">munkhuu0825@gmail.com</a>=
&gt;<br>
&gt; ---<br>
&gt; hw/virtio/virtio.c | 3 ++-<br>
&gt; 1 file changed, 2 insertions(+), 1 deletion(-)<br>
&gt; <br>
&gt; diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c<br>
&gt; index 63e2faee99..14e7dd70be 100644<br>
&gt; --- a/hw/virtio/virtio.c<br>
&gt; +++ b/hw/virtio/virtio.c<br>
&gt; @@ -3223,8 +3223,9 @@ int virtio_set_features_ex(VirtIODevice *vdev, c=
onst uint64_t *features)<br>
&gt;=C2=A0 =C2=A0 =C2=A0}<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0ret =3D virtio_set_features_nocheck(vdev, features)=
;<br>
&gt; -=C2=A0 =C2=A0 if (virtio_vdev_has_feature(vdev, VIRTIO_RING_F_EVENT_I=
DX)) {<br>
&gt; +=C2=A0 =C2=A0 if (virtio_vdev_has_feature(vdev, VIRTIO_RING_F_EVENT_I=
DX) || virtio_vdev_has_feature(vdev, VIRTIO_F_RING_PACKED)) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* VIRTIO_RING_F_EVENT_IDX changes th=
e size of the caches.=C2=A0 */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* VIRTIO_F_RING_PACKED changes the cache=
-&gt;is_write value. */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int i;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; VIRTIO_QUEUE_MAX=
; i++) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (vdev-&gt;vq[i].vrin=
g.num !=3D 0) {<br>
&gt; -- <br>
&gt; 2.50.1 (Apple Git-155)<br>
&gt; <br>
<br>
</blockquote></div>

--0000000000008c850a0658d8a9f6--

