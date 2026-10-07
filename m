Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63473CA5FFF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 08:11:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEMiO-00016a-EM; Wed, 07 Oct 2026 04:09:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gurchetan.singh.foss@gmail.com>)
 id 1xEGu1-0007sv-4X
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 21:57:12 -0400
Received: from mail-oo1-xc2e.google.com ([2607:f8b0:4864:20::c2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gurchetan.singh.foss@gmail.com>)
 id 1xEGtp-00039w-KD
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 21:56:57 -0400
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-6dd059478dcso777590eaf.0
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2026 18:53:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791338002; cv=none;
 d=google.com; s=arc-20260327;
 b=IKwv9E3+FeuAymOmDQKjKLCw3AEk8XrXxsbjGUyFd7Xtf+YlKwpk2/J5WNaymdaFsE
 ykWYwB/IlW8vMYjvXQqA/M0XP18l2dEFW7YxRRzvWQlZobpl2xiFc6XxSTTkX9OaMbpC
 W6tAd+QjaLhWfwFXqaaDlUb50KVfn7ytwBuidpwSpSR+61poInASXj+LGZUV8TsVssR5
 BiJ8639iOZQ9woNvYldwAAM1Fd3h8R7aupyabG2lGDbADgpGgA0/P1+bXBy2js39//8Q
 J4XV9bA6j3hVyl0DGcUfV8+rXt9ZArCBrfYHKhuUz2oO9BlFFC8nJ4b3xu31QwQgsdKW
 UJBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=F4lucnjwCxfqaVVCKtNlRKJQGtD5ZiYFzDMOWAzt6Ss=;
 fh=c1Utds+zz0DBjnUGk3nv1fd9mJxYfeSqyq0tD3pmGGU=;
 b=Fsx6dK/NmpKWtFkxZ367zNAPixP/Nj+NkD8m2RC+qOgscxyqGhLATsPlCC83akHt1M
 nzK4tDwaUYhVQDGCYa14oUS42bTzs4QbBiCLs1VfckupIgdOozQG3L8A/GUiNjZfG1B8
 F1djM6agdw8jh9wA7U6555zYi88PA/K9DK8l+eLd5hy8amPD3YajHqyIneG5upRpBKd9
 X3DWrm57hB8g61HT4oPNkKSdnEKwUMnN2PvDyTVmWHOJmvoWW/pxfZLW94PQ5D+/eVXI
 nQzWnul7n69bi3ihdRloUUaO1MSpzZ0FIV24sY3N15lqndhpz1PHs8cNfJCURoKEG4gz
 sudw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791338002; x=1791942802; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=F4lucnjwCxfqaVVCKtNlRKJQGtD5ZiYFzDMOWAzt6Ss=;
 b=L+Hq5jUoBP9UoFSmqSn4o9adRk8Xtg76d11NYRestn5HAyzBYmkUPLaY/4alyHQxQw
 q2/8VgdKYtwFVCjE/XvDbqFwJshQUSq/Iszi8PZ+Sp9MIX5wumbYqY767X0sfvWq+wZC
 90TDZLOOIQcdTzt8gYaxFs08Sa8LeQHRMbTAKvE+fLKN8LVS29DhumuI/2KK1goDKIcm
 YAHCHUjENixNJM5dteqqOdooaMbYWpO8K+ExBzHtPVON1JWHikD2Rm7BalFmdibmDhIp
 5xR7HNf4lOK2WS+Uy6p0yMwsoyhn24tb4+wOy2NUly1KXi7C3wb8z6FJTw5qzhnZLYs4
 3Vkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791338002; x=1791942802;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=F4lucnjwCxfqaVVCKtNlRKJQGtD5ZiYFzDMOWAzt6Ss=;
 b=Un39MZiaXwf72esFhYmWtFGCGWMwdGge8cEa/2wEiG0CbrtZ5wnhjFrknMG2NYih/k
 KnPvRTxbddV2cOZb2PC8XAYjaWWedR5Sdq2hqKu/tMxKSG8ezuym/pk/v0M7nCwoyvgR
 qdvWQTZkipLs9DdsYwHhtjQNRXfOEKumtak0MdNiv5Gr8SwCJb5lBDc3DwXldLrUJiqn
 K/9miGO9/1CfyoMzsiPH0Iso6I4wqjRoA1JPqKTaLQvUgyCHzxqVhVdf/CFTc75hCZa6
 kkn2mgKaNsxiWugAMR/hPBLbcP+9dSU/vJWP6qix/tMwodsGCqbB1DsT08LvrNCW/nSd
 hmJA==
X-Forwarded-Encrypted: i=1;
 AKwUvBy6UnM2GTYN7ud3PZ49oAARH6kk3EaIThyIqIPxsL7nrZEANuFGQKgR3ODIIKVzAKDFz5NRxSfU1TEv@nongnu.org
X-Gm-Message-State: AFuF++micta0BU6SpdsEytltMtBUYM8bHRAV3VQ7RznHT25zM5apxnEH
 47PkP4POHuiV8Lbdab01tWjdLSC2dxcPf8IZToK1dtk56Yqup/N2Or0vTTH3/UG/sr/WRPHv24C
 m4Tp8dUYMp6L+zE11dc1n7bpEpdhUJ+J8f//V
X-Gm-Gg: AYBFou2J+vassVLofKHNlqQec4df9wxgFLmFzWsSRzkJiOnX2iBiCcouCFSTL+gDIDj
 c9URqsbsq6e16vR1/mJdOtTyceEPmW1mMnHN6PXb/TWNrf3GljmEege4z7o/R6Qrs1x4ygFiVvb
 64c0kMynjojrRF66eP5nWjiY1Pe/naJR3cu5ceGfaX5nGusH3KxtCFcNtXI0qaemTzE6jOuNK0K
 nV1ME8mvBu9lOj3TLyGO1bxL5e1E1Fq4lZILESIR7tEuklGBUnArOvE6bEZLxgtcrGUMIUBZxOI
 jflp0+J3GKUDFzrjhRLZm5ClAO1mCXR6JPtGdmw+01m6ukaB1ORXF9R2
X-Received: by 2002:a05:6808:1825:b0:4f4:415:6f17 with SMTP id
 5614622812f47-4fc46471011mr1333418b6e.43.1791334331988; Tue, 06 Oct 2026
 17:52:11 -0700 (PDT)
MIME-Version: 1.0
References: <20261005174522.8663-1-gurchetan.singh.foss@gmail.com>
 <CAJ+F1C+zTWt878LjRHn7wXQWn3aW8UvWD=E15yBwc1DiGWSmUg@mail.gmail.com>
 <5f7a466d-3815-427e-98f7-94f48d8e9777@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <5f7a466d-3815-427e-98f7-94f48d8e9777@rsg.ci.i.u-tokyo.ac.jp>
From: Gurchetan Singh <gurchetan.singh.foss@gmail.com>
Date: Tue, 6 Oct 2026 17:51:59 -0700
X-Gm-Features: AclHuK-jsCj2G6-X4076QkCAuUOxmThgV0Y5wcm8GQO1nRY2KTn66PCWtYTEQ-4
Message-ID: <CAMW2r3KWeEURbq2FrQ7sn702-tVWZMruPU+mt+mqaEzXUucZag@mail.gmail.com>
Subject: Re: [PATCH] virtio-gpu-rutabaga: make sure ctx_ids match
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000883fe2065d358642"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2e;
 envelope-from=gurchetan.singh.foss@gmail.com; helo=mail-oo1-xc2e.google.com
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

--000000000000883fe2065d358642
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 6, 2026 at 3:50=E2=80=AFAM Akihiko Odaki <odaki@rsg.ci.i.u-toky=
o.ac.jp>
wrote:

> On 2026/10/06 4:22, Marc-Andr=C3=A9 Lureau wrote:
> > Hi
> >
> > On Mon, Oct 5, 2026 at 11:00=E2=80=AFPM Gurchetan Singh
> > <gurchetan.singh.foss@gmail.com> wrote:
> >>
> >> The ctx_ids need to match as well as the ring ids for
> >> proper signaling.
> >>
> >> Fixes: 1dcc6adbc168 ("gfxstream + rutabaga: add initial support for
> gfxstream")
> >> Signed-off-by: Gurchetan Singh <gurchetan.singh.foss@gmail.com>
> >> ---
> >>   hw/display/virtio-gpu-rutabaga.c | 3 ++-
> >>   1 file changed, 2 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/hw/display/virtio-gpu-rutabaga.c
> b/hw/display/virtio-gpu-rutabaga.c
> >> index 3aafa4dc66..edf7b62703 100644
> >> --- a/hw/display/virtio-gpu-rutabaga.c
> >> +++ b/hw/display/virtio-gpu-rutabaga.c
> >> @@ -902,7 +902,8 @@ virtio_gpu_rutabaga_aio_cb(void *opaque)
> >>           }
> >>
> >>           if (signaled_ctx_specific &&
> >> -           (cmd->cmd_hdr.ring_idx !=3D fence_data.ring_idx)) {
> >> +           ((cmd->cmd_hdr.ctx_id !=3D fence_data.ctx_id) ||
> >> +           (cmd->cmd_hdr.ring_idx !=3D fence_data.ring_idx))) {
> >>               continue;
> >>           }
> >
> > lgtm
> >
> > Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> >
> >
> > btw Gurchetan, do you remember why virtio-gpu-pci-rutabaga.c is using
> > raw TypeInfo, and not VirtioPCIDeviceTypeInfo? Is it just an
> > oversight? I can send a patch if it's the case
>

I don't remember, but probably a random oversight yes.  Feel free to send
the patch and I will test.


>
> It looks like an oversight to me as well.
>
> Earlier revisions of the patch used VirtioPCIDeviceTypeInfo [1]. In v12,
> the code was converted to use DEFINE_TYPES() [2], and
> VirtioPCIDeviceTypeInfo was replaced with TypeInfo at the same time.

[1]
>
> https://lore.kernel.org/qemu-devel/20230823012541.485-7-gurchetansingh@ch=
romium.org/
> [2]
>
> https://lore.kernel.org/qemu-devel/20230824234046.499-7-gurchetansingh@ch=
romium.org/
>
> Regards,
> Akihiko Odaki
>

--000000000000883fe2065d358642
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Oct 6, =
2026 at 3:50=E2=80=AFAM Akihiko Odaki &lt;<a href=3D"mailto:odaki@rsg.ci.i.=
u-tokyo.ac.jp">odaki@rsg.ci.i.u-tokyo.ac.jp</a>&gt; wrote:<br></div><blockq=
uote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1p=
x solid rgb(204,204,204);padding-left:1ex">On 2026/10/06 4:22, Marc-Andr=C3=
=A9 Lureau wrote:<br>
&gt; Hi<br>
&gt; <br>
&gt; On Mon, Oct 5, 2026 at 11:00=E2=80=AFPM Gurchetan Singh<br>
&gt; &lt;<a href=3D"mailto:gurchetan.singh.foss@gmail.com" target=3D"_blank=
">gurchetan.singh.foss@gmail.com</a>&gt; wrote:<br>
&gt;&gt;<br>
&gt;&gt; The ctx_ids need to match as well as the ring ids for<br>
&gt;&gt; proper signaling.<br>
&gt;&gt;<br>
&gt;&gt; Fixes: 1dcc6adbc168 (&quot;gfxstream + rutabaga: add initial suppo=
rt for gfxstream&quot;)<br>
&gt;&gt; Signed-off-by: Gurchetan Singh &lt;<a href=3D"mailto:gurchetan.sin=
gh.foss@gmail.com" target=3D"_blank">gurchetan.singh.foss@gmail.com</a>&gt;=
<br>
&gt;&gt; ---<br>
&gt;&gt;=C2=A0 =C2=A0hw/display/virtio-gpu-rutabaga.c | 3 ++-<br>
&gt;&gt;=C2=A0 =C2=A01 file changed, 2 insertions(+), 1 deletion(-)<br>
&gt;&gt;<br>
&gt;&gt; diff --git a/hw/display/virtio-gpu-rutabaga.c b/hw/display/virtio-=
gpu-rutabaga.c<br>
&gt;&gt; index 3aafa4dc66..edf7b62703 100644<br>
&gt;&gt; --- a/hw/display/virtio-gpu-rutabaga.c<br>
&gt;&gt; +++ b/hw/display/virtio-gpu-rutabaga.c<br>
&gt;&gt; @@ -902,7 +902,8 @@ virtio_gpu_rutabaga_aio_cb(void *opaque)<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (signaled_ctx_specific =
&amp;&amp;<br>
&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(cmd-&gt;cmd_hdr.ring_id=
x !=3D fence_data.ring_idx)) {<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0((cmd-&gt;cmd_hdr.ctx_id=
 !=3D fence_data.ctx_id) ||<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(cmd-&gt;cmd_hdr.ring_id=
x !=3D fence_data.ring_idx))) {<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0continue;<br=
>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; <br>
&gt; lgtm<br>
&gt; <br>
&gt; Reviewed-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lu=
reau@redhat.com" target=3D"_blank">marcandre.lureau@redhat.com</a>&gt;<br>
<br>
Reviewed-by: Akihiko Odaki &lt;<a href=3D"mailto:odaki@rsg.ci.i.u-tokyo.ac.=
jp" target=3D"_blank">odaki@rsg.ci.i.u-tokyo.ac.jp</a>&gt;<br>
&gt; <br>
&gt; <br>
&gt; btw Gurchetan, do you remember why virtio-gpu-pci-rutabaga.c is using<=
br>
&gt; raw TypeInfo, and not VirtioPCIDeviceTypeInfo? Is it just an<br>
&gt; oversight? I can send a patch if it&#39;s the case<br></blockquote><di=
v><br></div><div><div>I don&#39;t remember, but probably a random oversight=
 yes.=C2=A0 Feel free to send the patch and I will test.</div></div><div>=
=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
It looks like an oversight to me as well.<br>
<br>
Earlier revisions of the patch used VirtioPCIDeviceTypeInfo [1]. In v12, <b=
r>
the code was converted to use DEFINE_TYPES() [2], and <br>
VirtioPCIDeviceTypeInfo was replaced with TypeInfo at the same time.</block=
quote><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;b=
order-left:1px solid rgb(204,204,204);padding-left:1ex">
[1] <br>
<a href=3D"https://lore.kernel.org/qemu-devel/20230823012541.485-7-gurcheta=
nsingh@chromium.org/" rel=3D"noreferrer" target=3D"_blank">https://lore.ker=
nel.org/qemu-devel/20230823012541.485-7-gurchetansingh@chromium.org/</a><br=
>
[2] <br>
<a href=3D"https://lore.kernel.org/qemu-devel/20230824234046.499-7-gurcheta=
nsingh@chromium.org/" rel=3D"noreferrer" target=3D"_blank">https://lore.ker=
nel.org/qemu-devel/20230824234046.499-7-gurchetansingh@chromium.org/</a><br=
>
<br>
Regards,<br>
Akihiko Odaki<br>
</blockquote></div></div>

--000000000000883fe2065d358642--

