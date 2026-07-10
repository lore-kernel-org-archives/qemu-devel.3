Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AB98C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 01:40:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi0Dx-0005RZ-Ol; Thu, 09 Jul 2026 21:40:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <physicalmtea@gmail.com>)
 id 1wi0Du-0005NC-R1
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 21:40:15 -0400
Received: from mail-qv1-xf2a.google.com ([2607:f8b0:4864:20::f2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <physicalmtea@gmail.com>)
 id 1wi0Ds-00077j-JO
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 21:40:14 -0400
Received: by mail-qv1-xf2a.google.com with SMTP id
 6a1803df08f44-8f032b47e3cso3860766d6.0
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 18:40:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783647611; cv=none;
 d=google.com; s=arc-20260327;
 b=WIwZY4US88cF7yLLeHja2YZpQ0zRDP8ALa7/I1g+7i5Thth064Bot1C6Ks1yap00tm
 IEfeR5VP1u4ZVy/uht6z0Mw9Gf+v70Vp/9IfWOUZlO6XMR8LpUBI7QR26XqxDkXDY0Xg
 brR894A7KD8ucpjbqY6mp+fyWcp+TgOLkPePWjC6szPv8iSHEtzj47MYfgywCcN/BjVE
 D2321fDwERGWXYfMGb4LK7Wgg2zJ2aeajjO9Ai/znXAhhT20XKWX30elFMkSXm7RoxFY
 GNtLxHrZw+2hEeynM9vnyXjzKvhNDjXJCZ/8YgIXwpqJlVRgmQx3szxZIQewgxG2525a
 Un7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=gRKSoxb60KlqvQZVr1TNztQezmKzzqyWPyZ+wxYDYxM=;
 fh=ADcTEHojmHORXZIkfs+AOIwJBI9GaRLJkR2K8KqS86E=;
 b=Ejn/MLo1QnGrCqIw/xfnn+sj9hjjAYBSAIcmkOxqEVb12kDsz+cPhVwxC54ly28EpX
 Wb9BUk9SPJqiHPbAlC/odt77JNdES2/UCUz6rPNTunRwHqYEkJVyexuh+CYYtM0IvwDS
 BYQtxJNqOlfeHeQMyNUtgNUAM4Z75KgnYeenmLKxKnp259225+32tSPn0w7emETzaWb9
 N5v4qOwi9Ytnf66eWud1Fd2SuiicU2guJYSjCRNEcZkrKR0Ja9yWQ1I2pcTVBPL+CH39
 UT4man12pNd2zk41PsbQUsu+S8cRtRlLiYjKXo9uRZXgvO5b5bebxnvysiqyIW5bGNI8
 kD/A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783647611; x=1784252411; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=gRKSoxb60KlqvQZVr1TNztQezmKzzqyWPyZ+wxYDYxM=;
 b=O8dQ9/H2kWhRZFUmm0YPD9LthQwxxivCEkQOZTP7smtvgGTdyw/IeyyJkSzZm/naAR
 BFmDdgE6lB7xNBiiHcqv9UuvSJv7ksa9rw/SkDLA2bRy/FDf83YaXN+RnfAWeDualLe1
 TMeBLYnbcj8tVMuZf0b4yCiWee65vpnUOsxpmNfiZyd6EfIesWvQg/lLmvs5IprD1dkz
 vAvFFwtmwrsJ5nnaAt9kvOfrL5oTK5EHIDrvR+VnFj6+JCNUmIHPsreKXWqPnRbaDLcI
 ZMXhR9Gu1UoG5ReahwuoNybRdMz8I626fMMhZ/PD3S/HGcPYFMpHuGUdDcR5dQZh82e5
 BUcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783647611; x=1784252411;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=gRKSoxb60KlqvQZVr1TNztQezmKzzqyWPyZ+wxYDYxM=;
 b=TAiDnNrBoNI/M2qFmejDfK/OiBSEurfNaL2wVOJwfR4uiU3IET5Tt8idgKuKje6xto
 Ge1A7gUFKvzH2BD0LXqjz8oTPvlZAJV8hLGREfdewYaB458WmXk+Kz9Z0h9zs3r7Ko3g
 N0QlI3Tr0tOyMV2JK9vLPfrPH9DgSMIpzxxK4cwZEsBP5iuaumVf/V2ZHb4p1Tvc/WAD
 X1RL5l2fXzXNEzxYyVracmCvVfJ1JDcgTOLSQ1HlMR2eS70mPtII08ahxozBHoUk9hik
 bXVNr2QcPn/3g1qabRaQchiJSowLGeYwZKTIeFXQmZsLgtVZCSARwY879uF1QWzlamfu
 jlqg==
X-Gm-Message-State: AOJu0YwnC9L60Z+6dI/KouK7Z2cVEgAdaOsfcdeaXVwK1olGltazSMWD
 ZHnjHJJ1+PkT8PuAvE3rz44CfwE7NyNSE+7UdeGu/dZ43k6XSXN5iKP7EBColk+7cFXS1aWXSJr
 gjqgAOSZ4NOTPieSl7gJAFbpU+t0bICc=
X-Gm-Gg: AfdE7cm2yqs4/Xops2BCA3c/F70LOWf69fF/rf5AULPsASQ9T4CBOGev+vu/m3Yg7vW
 PCUS91T31Crioc1dcud5K3IvzHiHrK4o2t/+qp6Xx/FyFbpW39RmwiwATs2bAijsOQPfsYrkO+T
 Prr+zVf161S/tfilg3y2azUK2RxzAMP1rQwp6s0TbEljVhRcNIw8ETAEhGFBF/FG4LhuiL2o5Iw
 mBjJ/2qwmZNDqSVCuNzKjhXaVYX7BKloLZmL+1yw1nxDmg3As2Toroha0RYbRV9XdSNS5E8
X-Received: by 2002:ad4:4eed:0:b0:8c4:edb4:a44a with SMTP id
 6a1803df08f44-8fec0eb607amr110943226d6.23.1783647611029; Thu, 09 Jul 2026
 18:40:11 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1783604079.git.qemu_oss@crudebyte.com>
 <a25a3dbb8581c265d5eed2298738c6bfedf9cc38.1783604079.git.qemu_oss@crudebyte.com>
 <3051985.e9J7NaK4W3@weasel>
In-Reply-To: <3051985.e9J7NaK4W3@weasel>
From: "m'te'a physical" <physicalmtea@gmail.com>
Date: Fri, 10 Jul 2026 09:39:34 +0800
X-Gm-Features: AVVi8Ccrgt18MaRmE3biaCUPJqvcDS8wFvzHvCveXDMGLQverEM5hFe9CL0bhzg
Message-ID: <CAJwVaMK62uWSAmZogKNoe=0VTE7rMkX6=AbAiM6+CaYdF4FqOA@mail.gmail.com>
Subject: Re: [PATCH 1/3] hw/9pfs/virtio: drain in-flight PDUs before virtio-9p
 unrealize
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org, Greg Kurz <groug@kaod.org>
Content-Type: multipart/alternative; boundary="000000000000428b2b065637d273"
Received-SPF: pass client-ip=2607:f8b0:4864:20::f2a;
 envelope-from=physicalmtea@gmail.com; helo=mail-qv1-xf2a.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

--000000000000428b2b065637d273
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

 Hi Christian,

 Sure, thanks for handling this.

 Please make me the author of patch 1/3, and feel free to add:

 Signed-off-by: Jia Jia <physicalmtea@gmail.com>

 on my behalf.

 Thanks,
 Jia

Christian Schoenebeck <qemu_oss@crudebyte.com> =E4=BA=8E2026=E5=B9=B47=E6=
=9C=889=E6=97=A5=E5=91=A8=E5=9B=9B 22:20=E5=86=99=E9=81=93=EF=BC=9A

> On Thursday, 9 July 2026 15:50:36 CEST Christian Schoenebeck wrote:
> > A guest can trigger a heap-use-after-free in the virtio transport
> > unrealize path by submitting a Treaddir request and immediately
> > ejecting the device via ACPI PCI hotplug. The unrealize path frees
> > struct LocalData while a worker thread still holds a reference
> > on it, causing a UAF in local_open_nofollow().
> >
> > Fix this by draining all in-flight 9p PDUs by calling v9fs_reset()
> > before final server cleanup. This ensures all coroutines completed,
> > all FIDs are closed, and no worker thread still holds references
> > on 9p server state when it is freed.
> >
> > Reported-by: Jia Jia <physicalmtea@gmail.com>
> > Suggested-by: Jia Jia <physicalmtea@gmail.com>
> > Fixes: 6cecf09373 ("virtio-9p-device: add minimal unrealize handler")
> > Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3937
> > Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
> > ---
>
> Jia, if desired, I can make you the official author of this patch. If
> that's
> what you want, then please reply-to-all to this message with the same
> email
> address that you used for your report already, and acknowledge that you
> would
> be fine that I add a:
>
> Signed-off-by: Jia Jia <physicalmtea@gmail.com>
>
> tag on behalf of you, for the reason described here:
>
> https://www.qemu.org/docs/master/devel/submitting-a-patch.html
>
> >  hw/9pfs/virtio-9p-device.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/hw/9pfs/virtio-9p-device.c b/hw/9pfs/virtio-9p-device.c
> > index 50dc93091d..1ec48fc9e0 100644
> > --- a/hw/9pfs/virtio-9p-device.c
> > +++ b/hw/9pfs/virtio-9p-device.c
> > @@ -243,6 +243,7 @@ static void virtio_9p_device_unrealize(DeviceState
> *dev)
> > V9fsVirtioState *v =3D VIRTIO_9P(dev);
> >      V9fsState *s =3D &v->state;
> >
> > +    v9fs_reset(s);
> >      virtio_delete_queue(v->vq);
> >      virtio_cleanup(vdev);
> >      v9fs_device_unrealize_common(s);
>
>
>

--000000000000428b2b065637d273
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">=C2=A0Hi Christian,<br><br>=C2=A0Sure, thanks for handling=
 this.<br><br>=C2=A0Please make me the author of patch 1/3, and feel free t=
o add:<br><br>=C2=A0Signed-off-by: Jia Jia &lt;<a href=3D"mailto:physicalmt=
ea@gmail.com">physicalmtea@gmail.com</a>&gt;<br><br>=C2=A0on my behalf.<br>=
<br>=C2=A0Thanks,<br>=C2=A0Jia</div><br><div class=3D"gmail_quote gmail_quo=
te_container"><div dir=3D"ltr" class=3D"gmail_attr">Christian Schoenebeck &=
lt;<a href=3D"mailto:qemu_oss@crudebyte.com">qemu_oss@crudebyte.com</a>&gt;=
 =E4=BA=8E2026=E5=B9=B47=E6=9C=889=E6=97=A5=E5=91=A8=E5=9B=9B 22:20=E5=86=
=99=E9=81=93=EF=BC=9A<br></div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex">On Thursday, 9 July 2026 15:50:36 CEST Christian Schoenebeck wrote:<b=
r>
&gt; A guest can trigger a heap-use-after-free in the virtio transport<br>
&gt; unrealize path by submitting a Treaddir request and immediately<br>
&gt; ejecting the device via ACPI PCI hotplug. The unrealize path frees<br>
&gt; struct LocalData while a worker thread still holds a reference<br>
&gt; on it, causing a UAF in local_open_nofollow().<br>
&gt; <br>
&gt; Fix this by draining all in-flight 9p PDUs by calling v9fs_reset()<br>
&gt; before final server cleanup. This ensures all coroutines completed,<br=
>
&gt; all FIDs are closed, and no worker thread still holds references<br>
&gt; on 9p server state when it is freed.<br>
&gt; <br>
&gt; Reported-by: Jia Jia &lt;<a href=3D"mailto:physicalmtea@gmail.com" tar=
get=3D"_blank">physicalmtea@gmail.com</a>&gt;<br>
&gt; Suggested-by: Jia Jia &lt;<a href=3D"mailto:physicalmtea@gmail.com" ta=
rget=3D"_blank">physicalmtea@gmail.com</a>&gt;<br>
&gt; Fixes: 6cecf09373 (&quot;virtio-9p-device: add minimal unrealize handl=
er&quot;)<br>
&gt; Resolves: <a href=3D"https://gitlab.com/qemu-project/qemu/-/work_items=
/3937" rel=3D"noreferrer" target=3D"_blank">https://gitlab.com/qemu-project=
/qemu/-/work_items/3937</a><br>
&gt; Signed-off-by: Christian Schoenebeck &lt;<a href=3D"mailto:qemu_oss@cr=
udebyte.com" target=3D"_blank">qemu_oss@crudebyte.com</a>&gt;<br>
&gt; ---<br>
<br>
Jia, if desired, I can make you the official author of this patch. If that&=
#39;s <br>
what you want, then please reply-to-all to this message with the same email=
 <br>
address that you used for your report already, and acknowledge that you wou=
ld <br>
be fine that I add a:<br>
<br>
Signed-off-by: Jia Jia &lt;<a href=3D"mailto:physicalmtea@gmail.com" target=
=3D"_blank">physicalmtea@gmail.com</a>&gt;<br>
<br>
tag on behalf of you, for the reason described here:<br>
<br>
<a href=3D"https://www.qemu.org/docs/master/devel/submitting-a-patch.html" =
rel=3D"noreferrer" target=3D"_blank">https://www.qemu.org/docs/master/devel=
/submitting-a-patch.html</a><br>
<br>
&gt;=C2=A0 hw/9pfs/virtio-9p-device.c | 1 +<br>
&gt;=C2=A0 1 file changed, 1 insertion(+)<br>
&gt; <br>
&gt; diff --git a/hw/9pfs/virtio-9p-device.c b/hw/9pfs/virtio-9p-device.c<b=
r>
&gt; index 50dc93091d..1ec48fc9e0 100644<br>
&gt; --- a/hw/9pfs/virtio-9p-device.c<br>
&gt; +++ b/hw/9pfs/virtio-9p-device.c<br>
&gt; @@ -243,6 +243,7 @@ static void virtio_9p_device_unrealize(DeviceState=
 *dev)<br>
&gt; V9fsVirtioState *v =3D VIRTIO_9P(dev);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 V9fsState *s =3D &amp;v-&gt;state;<br>
&gt; <br>
&gt; +=C2=A0 =C2=A0 v9fs_reset(s);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 virtio_delete_queue(v-&gt;vq);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 virtio_cleanup(vdev);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 v9fs_device_unrealize_common(s);<br>
<br>
<br>
</blockquote></div>

--000000000000428b2b065637d273--

