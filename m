Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F046C55175
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Aug 2026 14:27:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wqX9W-0007If-Pe; Sun, 02 Aug 2026 10:26:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ankur98saini@gmail.com>)
 id 1wqX9V-0007IX-MX
 for qemu-devel@nongnu.org; Sun, 02 Aug 2026 10:26:57 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ankur98saini@gmail.com>)
 id 1wqX9T-0007rN-0o
 for qemu-devel@nongnu.org; Sun, 02 Aug 2026 10:26:57 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-6a0ed8a10ceso304074a12.3
 for <qemu-devel@nongnu.org>; Sun, 02 Aug 2026 07:26:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785680812; cv=none;
 d=google.com; s=arc-20260327;
 b=Qu4yav1zD59B7pQqWj1TzdkxtdJWNKWVjRDR3GE/F3IWBBlk46TTsUM7VEuzz33IuB
 9uWPFvpW9rTdilU9/m+O+Y16Z751jbfiyd/OdIoqNSRXR5xq5DpZ0G6mymYlTpaUP/RK
 2vzjF5tXzg8QT3+DjmiGxViUJxgnx7fB3DEegmnX5Yu9xLJCNKG9ksNgVo/sz93Pha6d
 niaHAFQdq0JlfXnyWK3XX5BLOOBpVsfFXSJ1jcjNMIlzXHm0th2XZ5Kecpdm9nVp/vwP
 QTtojjhgxqs6AllcHDhXwMz8BY64LRUPkiPspTRcnKU30RaCquZBtuuo02sCLQ4XXX8M
 q8ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=iASObsL9WvTulSTK4h47RVeUHNRU9Wxqgu3ptPbvQII=;
 fh=+hn2DS3rCNNQXErf5o66VVtjBBHnXgvd0Qv+7I9mBdI=;
 b=O6YhAUMl1zbcM/QGQfAAliKVLitx/oqRycdvXviBCMAp7bLNX3wZgsGBsVQmIuhvyM
 7JjuiSKPXxgO7FlBBqWYxWf1uJvJKws/TXrQvvnTw/MZkNDb2nf9bTS9aVMH0OlcNHxz
 OBQ6dEmxG2F6xngQYpbugSlDExWRVuVD2HiXW0X65zHt/L1RDMWfdx4my6lsLYpIbn/j
 VtldhIuOKIA4sFc6y+c5eVSZNQKE9x/p7CV3apinPKOW06EBq8sWyjLox3JVkIV3jfHR
 O1DwtqEa59F0/3pqCRY/YpIXfdE3irTLRyKyI8rjbv0KE84hfN/L+8L4hTJQ1hHKCbPh
 hJ+g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785680812; x=1786285612; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=iASObsL9WvTulSTK4h47RVeUHNRU9Wxqgu3ptPbvQII=;
 b=elWzKMuVhT6XTDUzFqkmCrReIkE/pqdZ/K0ZxGmfgY3KReOn6v+W2ecN2Nv64gzbC9
 r3VgqqvYI89Cell/AAu8K0J6UxSsYKEL7VCehdFWrDzsxMG6mKA9YMEQdm3UfwwcFej+
 GNq/f21s4LQ+gheOGb9ZxjXdoaYW9Q7ZJOnaZR/AhwLwlLQJExx1aQtGvVvtk9LRQbTw
 F/vIX6Dvmv3PCIt6h0EvD+xWtchRRqO60H7wel6lbdSwMYaqE/JRmZz7I2hHoKYW9PWW
 uA3n3J4objx77Lr8KJaoQkYY/TqQV3rW+ku6sKU5uiDEHrVZo+KGjImyhG4ygRqyPczV
 aUEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785680812; x=1786285612;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=iASObsL9WvTulSTK4h47RVeUHNRU9Wxqgu3ptPbvQII=;
 b=mr5YIoqzB3t/aL6j/IJTxb69+C3F7/vJlzI3IJ4bl+a4K4d3jXUOH1FPwkqnnIpZXE
 xq0c5qOHHASHtzGdLqo5tE0iIg4RpTidJeWeHZ7MKzXLe7biiJRSO5h2XvCwPqctXLZa
 WN1arJx3dmUHkN9rSW/fK2sx4WDz6TeGikJx9POi5qGrwR2P0iOl1OWb9dH6M8NzRNbQ
 EJXHw3yQoK5NvjtC7TW5DB3DDtBoswLCWILcR2EfoXwzm4YXM+bbtY04p5wkq/stcuQ8
 AxqRqOh/rzdPseNYy8zsZVgndXbqjk9ThnuWZHAmisLJ8du6cPNXuxfyEt+sUnFKnx7v
 5DBw==
X-Gm-Message-State: AOJu0YzVdekqH84u1wRAiIqa28r7gmafYIhKwq4bwlBIA/wMAZDnDkyO
 fZJYU4dRhb0SbI8QWzAj+qhtTeBTqnCDxCizREwW5jofKTgyK4HYDNa92wL+m8VWN+b1sJjy3R5
 lkqszeucmJUCKG81Np0OBBb6KtfJUT4U=
X-Gm-Gg: AR+sD10ul2yN9UYdGUHTw1zeFYPVZj1xHpSYtTqdz2l9zkIsB8jn9L4Txsg5RS8cnZ6
 8jU1/1GaNaiTqqjbLCEq2sEBa8ZM1DHP/U7M0LetEqFThZYcuSeWzWTuNvNhihv+OkDcD35ypAP
 JKPCQ7vfnx/2TlK5xh7m0p42Aors+WGVKyE5WBuybfSjD88suycEqeAqhqj/t3qpavLa0BOr0+x
 g+rdZfEQ56qsplJBoZmdrjan0RWT4dSEHryNZV1VKAv7Kbr2PJgMA+2d2MMIfi6BobiNTTc+iqF
 dEPXHF6TiXhPa49QIVCOLlvbkiN2ZFrfVD/9m9vr9B4gW28Tf316QMZK8943Jwa5HNFC12ym/ua
 kB6rPbPwlA4GI
X-Received: by 2002:a05:6402:530e:b0:69a:af38:2fc0 with SMTP id
 4fb4d7f45d1cf-6a0a7ce35c5mr4905483a12.20.1785680812119; Sun, 02 Aug 2026
 07:26:52 -0700 (PDT)
MIME-Version: 1.0
References: <20260729-virtio-gpu-short-header-v2-1-18036a97219a@gmail.com>
 <fca5a423-cba9-452f-86f5-c382524b7087@rsg.ci.i.u-tokyo.ac.jp>
 <CAE+rwOMBiusrWqbWFgA6Tqxi1pvE4KWEcJkmmw3+0RUYHNiGaQ@mail.gmail.com>
 <11151483-95e4-4e82-8664-5f61f4bf2cb6@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <11151483-95e4-4e82-8664-5f61f4bf2cb6@rsg.ci.i.u-tokyo.ac.jp>
From: Ankur Saini <ankur98saini@gmail.com>
Date: Sun, 2 Aug 2026 19:56:40 +0530
X-Gm-Features: AUfX_mzKZ7EMYKiow-wEUqgh3FDC7T55bDmj49v3fUn8i2J_ZqkiLDqS-ZBgk3o
Message-ID: <CAE+rwOMUgVPVLydyFPFyYvx6SOL2K1mHJuWDThzq_2iEt7XGgg@mail.gmail.com>
Subject: Re: [PATCH v2] virtio-gpu: reject requests with short/truncated
 control headers
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000007d19870658113695"
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=ankur98saini@gmail.com; helo=mail-ed1-x52d.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FREEMAIL_REPLY=1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
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

--0000000000007d19870658113695
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Rejecting it in the macros does sound better. For vhost-user-gpu we could
still need the patch in vg_handle_ctrl() though. I can send a v3 patch
based on this soon.

Thanks,
Ankur


On Sat, Aug 1, 2026 at 12:42=E2=80=AFPM Akihiko Odaki <odaki@rsg.ci.i.u-tok=
yo.ac.jp>
wrote:

> On 2026/07/29 16:28, Ankur Saini wrote:
> > Thanks. Just to clarify, the vhost-user-gpu check was already there and
> > compares the return value of iov_to_buf(), not iov_size(). !=3D and <
> > should be equivalent for vhost-user-gpu check so I left it unchanged.
>
> The fact that the checks compare different values made me look at how
> virtio-gpu copies commands.
>
> For commands with type-specific fields, processing copies the request
> in two stages:
>
> 1. Copy the common header to determine the command type.
> 2. Copy the complete type-specific command.
>
> vhost-user-gpu open-codes the first step in vg_handle_ctrl() and uses
> VUGPU_FILL_CMD() for the second. virtio-gpu uses VIRTIO_GPU_FILL_CMD()
> for both steps.
>
> Both fill macros already detect a short copy, but only log and return.
> They should instead complete the malformed request with
> ERR_INVALID_PARAMETER. For a common-header copy, the partially copied
> header must also be cleared before forming the response.
>
> Once VIRTIO_GPU_FILL_CMD() handles this failure, the new check in
> virtio_gpu_process_cmdq() will be unnecessary because the macro covers
> the first step. Fixing both macros will also reject truncated
> type-specific commands.
>
> Regards,
> Akihiko Odaki
>
> >
> > The new virtio-gpu check looks at the total iov size, which can be
> > larger than the header for valid commands, so it needs to use <. Would
> > you still prefer changing the vhost-user-gpu condition to < for
> consistency?
> >
> > Regards,
> > Ankur Saini
> >
> > On Wed, Jul 29, 2026 at 9:31=E2=80=AFAM Akihiko Odaki <odaki@rsg.ci.i.u=
-
> > tokyo.ac.jp <mailto:odaki@rsg.ci.i.u-tokyo.ac.jp>> wrote:
> >
> >     On 2026/07/29 5:44, Ankur Saini wrote:
> >      > A control request shorter than virtio_gpu_ctrl_hdr can leave
> cmd_hdr
> >      > partially initialized. If the supplied bytes set the fence flag,
> >     stale
> >      > fence metadata may later be returned to the guest.
> >      >
> >      > The vhost-user-gpu backend has the same issue: it logs a short
> header
> >      > copy but continues to process the partially initialized command.
> >      >
> >      > Validate the common header length before dispatch in both paths.
> >     Clear
> >      > cmd_hdr and complete malformed requests with
> ERR_INVALID_PARAMETER so
> >      > stale fields cannot reach the response.
> >
> >     vhost-user-gpu and virtio-gpu has slightly different conditions:
> >
> >     - vhost-user-gpu rejects: iov_size() !=3D sizeof(cmd->cmd_hdr)
> >     - virtio-gpu rejects: iov_size() < sizeof(cmd->cmd_hdr)
> >
> >     Ideally they should be consistent.
> >
> >     Regards,
> >     Akihiko Odaki
> >
> >      >
> >      > Fixes: CVE-2026-18054
> >      > Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4094
> >     <https://gitlab.com/qemu-project/qemu/-/work_items/4094>
> >      > Reported-by: Ankur Saini <ankur98saini@gmail.com
> >     <mailto:ankur98saini@gmail.com>>
> >      > Suggested-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp
> >     <mailto:odaki@rsg.ci.i.u-tokyo.ac.jp>>
> >      > Signed-off-by: Ankur Saini <ankur98saini@gmail.com
> >     <mailto:ankur98saini@gmail.com>>
> >      > ---
> >      > Changes in v2:
> >      > - Also reject short/truncated control headers in vhost-user-gpu.
> >      > - Expand the commit message to describe both affected paths.
> >      > - Link to v1: https://lore.kernel.org/qemu-devel/20260728-virtio=
-
> >     gpu-short-header-v1-1-af19a00b100d@gmail.com <https://
> >     lore.kernel.org/qemu-devel/20260728-virtio-gpu-short-header-v1-1-
> >     af19a00b100d@gmail.com>
> >      > ---
> >      >   contrib/vhost-user-gpu/vhost-user-gpu.c | 21
> ++++++++++++---------
> >      >   hw/display/virtio-gpu.c                 | 10 ++++++++--
> >      >   2 files changed, 20 insertions(+), 11 deletions(-)
> >      >
> >      > diff --git a/contrib/vhost-user-gpu/vhost-user-gpu.c b/contrib/
> >     vhost-user-gpu/vhost-user-gpu.c
> >      > index bb41758e34..8149834745 100644
> >      > --- a/contrib/vhost-user-gpu/vhost-user-gpu.c
> >      > +++ b/contrib/vhost-user-gpu/vhost-user-gpu.c
> >      > @@ -924,16 +924,19 @@ vg_handle_ctrl(VuDev *dev, int qidx)
> >      >           if (len !=3D sizeof(cmd->cmd_hdr)) {
> >      >               g_warning("%s: command size incorrect %zu vs %zu\n=
",
> >      >                         __func__, len, sizeof(cmd->cmd_hdr));
> >      > -        }
> >      > -
> >      > -        virtio_gpu_ctrl_hdr_bswap(&cmd->cmd_hdr);
> >      > -        g_debug("%d %s\n", cmd->cmd_hdr.type,
> >      > -                vg_cmd_to_string(cmd->cmd_hdr.type));
> >      > -
> >      > -        if (vg->virgl) {
> >      > -            vg_virgl_process_cmd(vg, cmd);
> >      > +            memset(&cmd->cmd_hdr, 0, sizeof(cmd->cmd_hdr));
> >      > +            vg_ctrl_response_nodata(
> >      > +                vg, cmd, VIRTIO_GPU_RESP_ERR_INVALID_PARAMETER)=
;
> >      >           } else {
> >      > -            vg_process_cmd(vg, cmd);
> >      > +            virtio_gpu_ctrl_hdr_bswap(&cmd->cmd_hdr);
> >      > +            g_debug("%d %s\n", cmd->cmd_hdr.type,
> >      > +                    vg_cmd_to_string(cmd->cmd_hdr.type));
> >      > +
> >      > +            if (vg->virgl) {
> >      > +                vg_virgl_process_cmd(vg, cmd);
> >      > +            } else {
> >      > +                vg_process_cmd(vg, cmd);
> >      > +            }
> >      >           }
> >      >
> >      >           if (cmd->state !=3D VG_CMD_STATE_FINISHED) {
> >      > diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
> >      > index 4d46a4eb10..15a845eff6 100644
> >      > --- a/hw/display/virtio-gpu.c
> >      > +++ b/hw/display/virtio-gpu.c
> >      > @@ -1105,8 +1105,14 @@ void virtio_gpu_process_cmdq(VirtIOGPU *g=
)
> >      >               break;
> >      >           }
> >      >
> >      > -        /* process command */
> >      > -        vgc->process_cmd(g, cmd);
> >      > +        if (unlikely(iov_size(cmd->elem.out_sg,
> cmd->elem.out_num) <
> >      > +                     sizeof(cmd->cmd_hdr))) {
> >      > +            memset(&cmd->cmd_hdr, 0, sizeof(cmd->cmd_hdr));
> >      > +            virtio_gpu_ctrl_response_nodata(
> >      > +                g, cmd, VIRTIO_GPU_RESP_ERR_INVALID_PARAMETER);
> >      > +        } else {
> >      > +            vgc->process_cmd(g, cmd);
> >      > +        }
> >      >
> >      >           /* command suspended */
> >      >           if (!cmd->finished && !(cmd->cmd_hdr.flags &
> >     VIRTIO_GPU_FLAG_FENCE)) {
> >      >
> >      > ---
> >      > base-commit: 299e7557ed15a9a325620698add379a3ce2d1d95
> >      > change-id: 20260728-virtio-gpu-short-header-476aa1dae4f7
> >      >
> >      > Best regards,
> >
>
>

--0000000000007d19870658113695
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Rejecting it in the macros does sound better. For vhost-us=
er-gpu we could still need the patch in vg_handle_ctrl() though. I can send=
 a v3 patch based on this soon.<div><br></div><div>Thanks,</div><div>Ankur<=
/div></div><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote"><div d=
ir=3D"ltr" class=3D"gmail_attr">On Sat, Aug 1, 2026 at 12:42=E2=80=AFPM Aki=
hiko Odaki &lt;<a href=3D"mailto:odaki@rsg.ci.i.u-tokyo.ac.jp" target=3D"_b=
lank">odaki@rsg.ci.i.u-tokyo.ac.jp</a>&gt; wrote:<br></div><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid r=
gb(204,204,204);padding-left:1ex">On 2026/07/29 16:28, Ankur Saini wrote:<b=
r>
&gt; Thanks. Just to clarify, the vhost-user-gpu check was already there an=
d <br>
&gt; compares the return value of iov_to_buf(), not iov_size(). !=3D and &l=
t; <br>
&gt; should be equivalent for vhost-user-gpu check so I left it unchanged.<=
br>
<br>
The fact that the checks compare different values made me look at how <br>
virtio-gpu copies commands.<br>
<br>
For commands with type-specific fields, processing copies the request<br>
in two stages:<br>
<br>
1. Copy the common header to determine the command type.<br>
2. Copy the complete type-specific command.<br>
<br>
vhost-user-gpu open-codes the first step in vg_handle_ctrl() and uses <br>
VUGPU_FILL_CMD() for the second. virtio-gpu uses VIRTIO_GPU_FILL_CMD() <br>
for both steps.<br>
<br>
Both fill macros already detect a short copy, but only log and return. <br>
They should instead complete the malformed request with <br>
ERR_INVALID_PARAMETER. For a common-header copy, the partially copied <br>
header must also be cleared before forming the response.<br>
<br>
Once VIRTIO_GPU_FILL_CMD() handles this failure, the new check in <br>
virtio_gpu_process_cmdq() will be unnecessary because the macro covers <br>
the first step. Fixing both macros will also reject truncated <br>
type-specific commands.<br>
<br>
Regards,<br>
Akihiko Odaki<br>
<br>
&gt; <br>
&gt; The new virtio-gpu check looks at the total iov size, which can be <br=
>
&gt; larger than the header for valid commands, so it needs to use &lt;. Wo=
uld <br>
&gt; you still prefer changing the vhost-user-gpu condition to &lt; for con=
sistency?<br>
&gt; <br>
&gt; Regards,<br>
&gt; Ankur Saini<br>
&gt; <br>
&gt; On Wed, Jul 29, 2026 at 9:31=E2=80=AFAM Akihiko Odaki &lt;odaki@rsg.ci=
.i.u- <br>
&gt; <a href=3D"http://tokyo.ac.jp" rel=3D"noreferrer" target=3D"_blank">to=
kyo.ac.jp</a> &lt;mailto:<a href=3D"mailto:odaki@rsg.ci.i.u-tokyo.ac.jp" ta=
rget=3D"_blank">odaki@rsg.ci.i.u-tokyo.ac.jp</a>&gt;&gt; wrote:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0On 2026/07/29 5:44, Ankur Saini wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; A control request shorter than virtio_gpu_ctr=
l_hdr can leave cmd_hdr<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; partially initialized. If the supplied bytes =
set the fence flag,<br>
&gt;=C2=A0 =C2=A0 =C2=A0stale<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; fence metadata may later be returned to the g=
uest.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; The vhost-user-gpu backend has the same issue=
: it logs a short header<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; copy but continues to process the partially i=
nitialized command.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; Validate the common header length before disp=
atch in both paths.<br>
&gt;=C2=A0 =C2=A0 =C2=A0Clear<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; cmd_hdr and complete malformed requests with =
ERR_INVALID_PARAMETER so<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; stale fields cannot reach the response.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0vhost-user-gpu and virtio-gpu has slightly differen=
t conditions:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0- vhost-user-gpu rejects: iov_size() !=3D sizeof(cm=
d-&gt;cmd_hdr)<br>
&gt;=C2=A0 =C2=A0 =C2=A0- virtio-gpu rejects: iov_size() &lt; sizeof(cmd-&g=
t;cmd_hdr)<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Ideally they should be consistent.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Regards,<br>
&gt;=C2=A0 =C2=A0 =C2=A0Akihiko Odaki<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; Fixes: CVE-2026-18054<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; Resolves: <a href=3D"https://gitlab.com/qemu-=
project/qemu/-/work_items/4094" rel=3D"noreferrer" target=3D"_blank">https:=
//gitlab.com/qemu-project/qemu/-/work_items/4094</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;<a href=3D"https://gitlab.com/qemu-project/qemu=
/-/work_items/4094" rel=3D"noreferrer" target=3D"_blank">https://gitlab.com=
/qemu-project/qemu/-/work_items/4094</a>&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; Reported-by: Ankur Saini &lt;<a href=3D"mailt=
o:ankur98saini@gmail.com" target=3D"_blank">ankur98saini@gmail.com</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:ankur98saini@gmail.com=
" target=3D"_blank">ankur98saini@gmail.com</a>&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; Suggested-by: Akihiko Odaki &lt;<a href=3D"ma=
ilto:odaki@rsg.ci.i.u-tokyo.ac.jp" target=3D"_blank">odaki@rsg.ci.i.u-tokyo=
.ac.jp</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:odaki@rsg.ci.i.u-tokyo=
.ac.jp" target=3D"_blank">odaki@rsg.ci.i.u-tokyo.ac.jp</a>&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; Signed-off-by: Ankur Saini &lt;<a href=3D"mai=
lto:ankur98saini@gmail.com" target=3D"_blank">ankur98saini@gmail.com</a><br=
>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:ankur98saini@gmail.com=
" target=3D"_blank">ankur98saini@gmail.com</a>&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; ---<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; Changes in v2:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; - Also reject short/truncated control headers=
 in vhost-user-gpu.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; - Expand the commit message to describe both =
affected paths.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; - Link to v1: <a href=3D"https://lore.kernel.=
org/qemu-devel/20260728-virtio-" rel=3D"noreferrer" target=3D"_blank">https=
://lore.kernel.org/qemu-devel/20260728-virtio-</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0<a href=3D"mailto:gpu-short-header-v1-1-af19a00b100=
d@gmail.com" target=3D"_blank">gpu-short-header-v1-1-af19a00b100d@gmail.com=
</a> &lt;https://<br>
&gt;=C2=A0 =C2=A0 =C2=A0<a href=3D"http://lore.kernel.org/qemu-devel/202607=
28-virtio-gpu-short-header-v1-1-" rel=3D"noreferrer" target=3D"_blank">lore=
.kernel.org/qemu-devel/20260728-virtio-gpu-short-header-v1-1-</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0<a href=3D"mailto:af19a00b100d@gmail.com" target=3D=
"_blank">af19a00b100d@gmail.com</a>&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; ---<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0contrib/vhost-user-gpu/vhost-user=
-gpu.c | 21 ++++++++++++---------<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0hw/display/virtio-gpu.c=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 10 ++++++++--<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A02 files changed, 20 insertions(+)=
, 11 deletions(-)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; diff --git a/contrib/vhost-user-gpu/vhost-use=
r-gpu.c b/contrib/<br>
&gt;=C2=A0 =C2=A0 =C2=A0vhost-user-gpu/vhost-user-gpu.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; index bb41758e34..8149834745 100644<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; --- a/contrib/vhost-user-gpu/vhost-user-gpu.c=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +++ b/contrib/vhost-user-gpu/vhost-user-gpu.c=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; @@ -924,16 +924,19 @@ vg_handle_ctrl(VuDev *d=
ev, int qidx)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (l=
en !=3D sizeof(cmd-&gt;cmd_hdr)) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0g_warning(&quot;%s: command size incorrect %zu vs %zu\n&quot;,<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0__func__, len, sizeof(cmd-&gt;=
cmd_hdr));<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; -<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 virtio_gpu_ctrl_=
hdr_bswap(&amp;cmd-&gt;cmd_hdr);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_debug(&quot;%d=
 %s\n&quot;, cmd-&gt;cmd_hdr.type,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 vg_cmd_to_string(cmd-&gt;cmd_hdr.type));<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; -<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (vg-&gt;virgl=
) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vg=
_virgl_process_cmd(vg, cmd);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 me=
mset(&amp;cmd-&gt;cmd_hdr, 0, sizeof(cmd-&gt;cmd_hdr));<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vg=
_ctrl_response_nodata(<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 vg, cmd, VIRTIO_GPU_RESP_ERR_INVALID_PARAMETER);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} els=
e {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vg=
_process_cmd(vg, cmd);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vi=
rtio_gpu_ctrl_hdr_bswap(&amp;cmd-&gt;cmd_hdr);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_=
debug(&quot;%d %s\n&quot;, cmd-&gt;cmd_hdr.type,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 vg_cmd_to_string(cmd-&gt;cmd_hdr.type));<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if=
 (vg-&gt;virgl) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 vg_virgl_process_cmd(vg, cmd);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } =
else {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 vg_process_cmd(vg, cmd);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (c=
md-&gt;state !=3D VG_CMD_STATE_FINISHED) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; diff --git a/hw/display/virtio-gpu.c b/hw/dis=
play/virtio-gpu.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; index 4d46a4eb10..15a845eff6 100644<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; --- a/hw/display/virtio-gpu.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +++ b/hw/display/virtio-gpu.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; @@ -1105,8 +1105,14 @@ void virtio_gpu_proces=
s_cmdq(VirtIOGPU *g)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0break;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* process comma=
nd */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 vgc-&gt;process_=
cmd(g, cmd);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (unlikely(iov=
_size(cmd-&gt;elem.out_sg, cmd-&gt;elem.out_num) &lt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sizeof(cmd-&gt;cmd_hdr))) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 me=
mset(&amp;cmd-&gt;cmd_hdr, 0, sizeof(cmd-&gt;cmd_hdr));<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vi=
rtio_gpu_ctrl_response_nodata(<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 g, cmd, VIRTIO_GPU_RESP_ERR_INVALID_PARAMETER);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vg=
c-&gt;process_cmd(g, cmd);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* co=
mmand suspended */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!=
cmd-&gt;finished &amp;&amp; !(cmd-&gt;cmd_hdr.flags &amp;<br>
&gt;=C2=A0 =C2=A0 =C2=A0VIRTIO_GPU_FLAG_FENCE)) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; ---<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; base-commit: 299e7557ed15a9a325620698add379a3=
ce2d1d95<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; change-id: 20260728-virtio-gpu-short-header-4=
76aa1dae4f7<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; Best regards,<br>
&gt; <br>
<br>
</blockquote></div>

--0000000000007d19870658113695--

