Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EA91C54F55
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2026 07:28:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woyig-0004v4-4y; Wed, 29 Jul 2026 03:28:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ankur98saini@gmail.com>)
 id 1woyid-0004ud-Ul
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 03:28:47 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ankur98saini@gmail.com>)
 id 1woyib-00068n-QI
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 03:28:47 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-698a9f11776so863799a12.1
 for <qemu-devel@nongnu.org>; Wed, 29 Jul 2026 00:28:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785310124; cv=none;
 d=google.com; s=arc-20260327;
 b=hOlkeJEPtjJurVB4uGU/MXIMRjifLw4F/R5CeQNcvMC4g4AKpL+vOMI3It2htV+FDq
 O1Gja+7ImSzltYvXa35yqQUGPMex+U0VjrDnPaaYMD5TocRq/zcDnW3HGKnQpQF4lOs0
 1ib8WHRpY5a1rC8sWRLRDwjootnl1C10tmB2AQVRC1nYywaHrYXggBZbrGfUN1rjodSk
 dTLmqoxaNcaXDn43KujAdTt3OSHqw8EyBuJjl+i8JQs5jnQntaTFD6mNvnaYFexAF0pR
 2bJUVUSb+i/qkw+B9nx1OCHtcTiBoihdp0YAPBCdYgWo79g/O7XpYZ0081pysfQQmmgE
 K1Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=2wxoQMm5u8MMPh0VfrclUUeiCTPgqSPYdkXWEdnFw/0=;
 fh=+hn2DS3rCNNQXErf5o66VVtjBBHnXgvd0Qv+7I9mBdI=;
 b=DxYv4QlIA2HajHnAfqYKJDwO4MQ0kEy5nx9AMNW5Tq3HGvDNyYF4EFhohR80cd83Fg
 2ZJ96N/OUOECnQkreoutogG97mIsk/EoCQJ8R0zBRFLKNexerj1o8kTUTFLv5CQErqWb
 K9OR3gP1JSM76YJ6hzu2ZxVMSkJd9bLmrW1/aVkoywtmkBG3fEy9B0WPMeZnuUiq752f
 d0u3xae73VMbl9FpVwq4YKDG90u/EvKN6FX9hD0dnYd2xPaWCcTo/Fitm7llb0pRni1i
 EXjbgraCAdjui8l/l9P1o6lxDuh4uKhbawEV0ENi09XaberSCny2ceQoypOJEM6iIjYx
 kaxA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785310124; x=1785914924; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=2wxoQMm5u8MMPh0VfrclUUeiCTPgqSPYdkXWEdnFw/0=;
 b=h/Enbm4EXbvba0eWY7hdlBJfbzjXLphPFzuBPfKg4L8NMT+VGg2nJLjcVZCBwM7Iqr
 6PkyGswCIktVnC3eVyDYsTs3yUkfQDAcz9O8iGVUxGMbvGNMGZVHMuJAFfCHdx7dfEi6
 pd1VsiaJ12HxByrVuI8rCqRoy1NNaQVdUmByE5egCruuQex1Q5NTyU4dIh13BApF1CTL
 lT3pzUnAdXkYfG6cVmyA0X9eOe60Bymh4cWdSydtMoly+FxLtN5xDjpO0hTeBAgs0kq1
 fHc6AoEWgzNPfpsOIczWBwHLg/1xNfOZQmNlhG6YAjaVSYusfgBs21Ad5hai0XzwP9GU
 DYNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785310124; x=1785914924;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=2wxoQMm5u8MMPh0VfrclUUeiCTPgqSPYdkXWEdnFw/0=;
 b=ErYwizE4lKJIRxjQVEi+XkPsyWcRoYKKbvQG6tXw5J6NI+SgeCNbC1H2mJLCVb2fZV
 YKvdV4nhyoan6SEseRr/oBsSpI4uYNytR8xASwSUHfVP3pZMO7acE/088D2wSa0mr7Ii
 7YIzIv4pi6o5bCY7GU/deTH+w2OVV8tO6pjzkODUgxs5mCg2XaqHTVIr45aOItb88YBT
 h+vkJnuRmXTEEVT78F0bwHuIN/FCRyRJ037FoubCDbgtwsex39stAqwthL9G8Exg4oRg
 fFT0OYOIaRg7mLMPC64Zg0A3VsAFleDSOe1uuO8Sw+hwzcZcTx4SFMJqm/RAbQM1y013
 fxfA==
X-Gm-Message-State: AOJu0YzpqZSP/s+rRTk2V/AyffLqHF+s6sNdOEvZVkk+5kCXgwbzMUGK
 7aHzJHCp0DNqp30ehDmRowppXMU/XtMhLDmz9pS+t6jRdsxOD6D2X/3Rg/M+/vxyfK1SKPp431E
 zpvI1Q6nYU1FGKpkYo+DsoeoAuqEPUtA=
X-Gm-Gg: AR+sD1308CMNvUovXIGvD7mmo1RfS87SRuxAS1XTm6JweahFteVAyxVlOuHF4NG8LII
 rjOq1iCHSH2Z+Nzci9QUnAc8aFq1tU0DeBGMhClZ/IIuIZkO4SkpPL+1cn1Ot4U8KqPUt0z4oGV
 4r7zvCQAv91jFh5rSrwdZSR2lM7hlJmDkCjqpsbCcP6pdQFUu6Byt3J9/ZZ2xHZ1yqfB6QJNxjd
 +ZWwsWUvNU8IwIorGNRKCuymZHX14GfhkLezGkFJI8Zeyx/IlMXPqOfbaNpdphf9Yewl/7Xk4HR
 jLLXjcqWd9d9D11MHJ/WAYGdTLnQMc2aP24OMWiiGhQFQ4pOuAC72ocfyD+UspkMGDIOlyzGqL8
 ihB4=
X-Received: by 2002:a05:6402:1f09:b0:69f:b347:a681 with SMTP id
 4fb4d7f45d1cf-6a0349dc5d4mr2818526a12.4.1785310123576; Wed, 29 Jul 2026
 00:28:43 -0700 (PDT)
MIME-Version: 1.0
References: <20260729-virtio-gpu-short-header-v2-1-18036a97219a@gmail.com>
 <fca5a423-cba9-452f-86f5-c382524b7087@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <fca5a423-cba9-452f-86f5-c382524b7087@rsg.ci.i.u-tokyo.ac.jp>
From: Ankur Saini <ankur98saini@gmail.com>
Date: Wed, 29 Jul 2026 12:58:33 +0530
X-Gm-Features: AUfX_mySbebGP5KklycbmP-1Qe3TxWgB2A_-7N2P3bUuxjK77Hak0w3Ly-pbjao
Message-ID: <CAE+rwOMBiusrWqbWFgA6Tqxi1pvE4KWEcJkmmw3+0RUYHNiGaQ@mail.gmail.com>
Subject: Re: [PATCH v2] virtio-gpu: reject requests with short/truncated
 control headers
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000bad07e0657bae72d"
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=ankur98saini@gmail.com; helo=mail-ed1-x534.google.com
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

--000000000000bad07e0657bae72d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks. Just to clarify, the vhost-user-gpu check was already there and
compares the return value of iov_to_buf(), not iov_size(). !=3D and < shoul=
d
be equivalent for vhost-user-gpu check so I left it unchanged.

The new virtio-gpu check looks at the total iov size, which can be larger
than the header for valid commands, so it needs to use <. Would you still
prefer changing the vhost-user-gpu condition to < for consistency?

Regards,
Ankur Saini

On Wed, Jul 29, 2026 at 9:31=E2=80=AFAM Akihiko Odaki <odaki@rsg.ci.i.u-tok=
yo.ac.jp>
wrote:

> On 2026/07/29 5:44, Ankur Saini wrote:
> > A control request shorter than virtio_gpu_ctrl_hdr can leave cmd_hdr
> > partially initialized. If the supplied bytes set the fence flag, stale
> > fence metadata may later be returned to the guest.
> >
> > The vhost-user-gpu backend has the same issue: it logs a short header
> > copy but continues to process the partially initialized command.
> >
> > Validate the common header length before dispatch in both paths. Clear
> > cmd_hdr and complete malformed requests with ERR_INVALID_PARAMETER so
> > stale fields cannot reach the response.
>
> vhost-user-gpu and virtio-gpu has slightly different conditions:
>
> - vhost-user-gpu rejects: iov_size() !=3D sizeof(cmd->cmd_hdr)
> - virtio-gpu rejects: iov_size() < sizeof(cmd->cmd_hdr)
>
> Ideally they should be consistent.
>
> Regards,
> Akihiko Odaki
>
> >
> > Fixes: CVE-2026-18054
> > Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4094
> > Reported-by: Ankur Saini <ankur98saini@gmail.com>
> > Suggested-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> > Signed-off-by: Ankur Saini <ankur98saini@gmail.com>
> > ---
> > Changes in v2:
> > - Also reject short/truncated control headers in vhost-user-gpu.
> > - Expand the commit message to describe both affected paths.
> > - Link to v1:
> https://lore.kernel.org/qemu-devel/20260728-virtio-gpu-short-header-v1-1-=
af19a00b100d@gmail.com
> > ---
> >   contrib/vhost-user-gpu/vhost-user-gpu.c | 21 ++++++++++++---------
> >   hw/display/virtio-gpu.c                 | 10 ++++++++--
> >   2 files changed, 20 insertions(+), 11 deletions(-)
> >
> > diff --git a/contrib/vhost-user-gpu/vhost-user-gpu.c
> b/contrib/vhost-user-gpu/vhost-user-gpu.c
> > index bb41758e34..8149834745 100644
> > --- a/contrib/vhost-user-gpu/vhost-user-gpu.c
> > +++ b/contrib/vhost-user-gpu/vhost-user-gpu.c
> > @@ -924,16 +924,19 @@ vg_handle_ctrl(VuDev *dev, int qidx)
> >           if (len !=3D sizeof(cmd->cmd_hdr)) {
> >               g_warning("%s: command size incorrect %zu vs %zu\n",
> >                         __func__, len, sizeof(cmd->cmd_hdr));
> > -        }
> > -
> > -        virtio_gpu_ctrl_hdr_bswap(&cmd->cmd_hdr);
> > -        g_debug("%d %s\n", cmd->cmd_hdr.type,
> > -                vg_cmd_to_string(cmd->cmd_hdr.type));
> > -
> > -        if (vg->virgl) {
> > -            vg_virgl_process_cmd(vg, cmd);
> > +            memset(&cmd->cmd_hdr, 0, sizeof(cmd->cmd_hdr));
> > +            vg_ctrl_response_nodata(
> > +                vg, cmd, VIRTIO_GPU_RESP_ERR_INVALID_PARAMETER);
> >           } else {
> > -            vg_process_cmd(vg, cmd);
> > +            virtio_gpu_ctrl_hdr_bswap(&cmd->cmd_hdr);
> > +            g_debug("%d %s\n", cmd->cmd_hdr.type,
> > +                    vg_cmd_to_string(cmd->cmd_hdr.type));
> > +
> > +            if (vg->virgl) {
> > +                vg_virgl_process_cmd(vg, cmd);
> > +            } else {
> > +                vg_process_cmd(vg, cmd);
> > +            }
> >           }
> >
> >           if (cmd->state !=3D VG_CMD_STATE_FINISHED) {
> > diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
> > index 4d46a4eb10..15a845eff6 100644
> > --- a/hw/display/virtio-gpu.c
> > +++ b/hw/display/virtio-gpu.c
> > @@ -1105,8 +1105,14 @@ void virtio_gpu_process_cmdq(VirtIOGPU *g)
> >               break;
> >           }
> >
> > -        /* process command */
> > -        vgc->process_cmd(g, cmd);
> > +        if (unlikely(iov_size(cmd->elem.out_sg, cmd->elem.out_num) <
> > +                     sizeof(cmd->cmd_hdr))) {
> > +            memset(&cmd->cmd_hdr, 0, sizeof(cmd->cmd_hdr));
> > +            virtio_gpu_ctrl_response_nodata(
> > +                g, cmd, VIRTIO_GPU_RESP_ERR_INVALID_PARAMETER);
> > +        } else {
> > +            vgc->process_cmd(g, cmd);
> > +        }
> >
> >           /* command suspended */
> >           if (!cmd->finished && !(cmd->cmd_hdr.flags &
> VIRTIO_GPU_FLAG_FENCE)) {
> >
> > ---
> > base-commit: 299e7557ed15a9a325620698add379a3ce2d1d95
> > change-id: 20260728-virtio-gpu-short-header-476aa1dae4f7
> >
> > Best regards,
>
>

--000000000000bad07e0657bae72d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Thanks. Just to clarify, the vhost-user-gpu check was alre=
ady there and compares the return value of iov_to_buf(), not iov_size(). !=
=3D and &lt; should be equivalent for vhost-user-gpu check so I left it unc=
hanged.<br><div><br></div><div>The new virtio-gpu check looks at the total =
iov size, which can be larger than the header for valid commands, so it nee=
ds to use &lt;. Would you still prefer changing the vhost-user-gpu conditio=
n to &lt; for consistency?<div><br></div><div>Regards,</div><div>Ankur Sain=
i</div></div></div><br><div class=3D"gmail_quote gmail_quote_container"><di=
v dir=3D"ltr" class=3D"gmail_attr">On Wed, Jul 29, 2026 at 9:31=E2=80=AFAM =
Akihiko Odaki &lt;<a href=3D"mailto:odaki@rsg.ci.i.u-tokyo.ac.jp">odaki@rsg=
.ci.i.u-tokyo.ac.jp</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex">On 2026/07/29 5:44, Ankur Saini wrote:<br>
&gt; A control request shorter than virtio_gpu_ctrl_hdr can leave cmd_hdr<b=
r>
&gt; partially initialized. If the supplied bytes set the fence flag, stale=
<br>
&gt; fence metadata may later be returned to the guest.<br>
&gt; <br>
&gt; The vhost-user-gpu backend has the same issue: it logs a short header<=
br>
&gt; copy but continues to process the partially initialized command.<br>
&gt; <br>
&gt; Validate the common header length before dispatch in both paths. Clear=
<br>
&gt; cmd_hdr and complete malformed requests with ERR_INVALID_PARAMETER so<=
br>
&gt; stale fields cannot reach the response.<br>
<br>
vhost-user-gpu and virtio-gpu has slightly different conditions:<br>
<br>
- vhost-user-gpu rejects: iov_size() !=3D sizeof(cmd-&gt;cmd_hdr)<br>
- virtio-gpu rejects: iov_size() &lt; sizeof(cmd-&gt;cmd_hdr)<br>
<br>
Ideally they should be consistent.<br>
<br>
Regards,<br>
Akihiko Odaki<br>
<br>
&gt; <br>
&gt; Fixes: CVE-2026-18054<br>
&gt; Resolves: <a href=3D"https://gitlab.com/qemu-project/qemu/-/work_items=
/4094" rel=3D"noreferrer" target=3D"_blank">https://gitlab.com/qemu-project=
/qemu/-/work_items/4094</a><br>
&gt; Reported-by: Ankur Saini &lt;<a href=3D"mailto:ankur98saini@gmail.com"=
 target=3D"_blank">ankur98saini@gmail.com</a>&gt;<br>
&gt; Suggested-by: Akihiko Odaki &lt;<a href=3D"mailto:odaki@rsg.ci.i.u-tok=
yo.ac.jp" target=3D"_blank">odaki@rsg.ci.i.u-tokyo.ac.jp</a>&gt;<br>
&gt; Signed-off-by: Ankur Saini &lt;<a href=3D"mailto:ankur98saini@gmail.co=
m" target=3D"_blank">ankur98saini@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt; Changes in v2:<br>
&gt; - Also reject short/truncated control headers in vhost-user-gpu.<br>
&gt; - Expand the commit message to describe both affected paths.<br>
&gt; - Link to v1: <a href=3D"https://lore.kernel.org/qemu-devel/20260728-v=
irtio-gpu-short-header-v1-1-af19a00b100d@gmail.com" rel=3D"noreferrer" targ=
et=3D"_blank">https://lore.kernel.org/qemu-devel/20260728-virtio-gpu-short-=
header-v1-1-af19a00b100d@gmail.com</a><br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0contrib/vhost-user-gpu/vhost-user-gpu.c | 21 ++++++++++++-=
--------<br>
&gt;=C2=A0 =C2=A0hw/display/virtio-gpu.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0| 10 ++++++++--<br>
&gt;=C2=A0 =C2=A02 files changed, 20 insertions(+), 11 deletions(-)<br>
&gt; <br>
&gt; diff --git a/contrib/vhost-user-gpu/vhost-user-gpu.c b/contrib/vhost-u=
ser-gpu/vhost-user-gpu.c<br>
&gt; index bb41758e34..8149834745 100644<br>
&gt; --- a/contrib/vhost-user-gpu/vhost-user-gpu.c<br>
&gt; +++ b/contrib/vhost-user-gpu/vhost-user-gpu.c<br>
&gt; @@ -924,16 +924,19 @@ vg_handle_ctrl(VuDev *dev, int qidx)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (len !=3D sizeof(cmd-&gt;cm=
d_hdr)) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0g_warning(&quot;=
%s: command size incorrect %zu vs %zu\n&quot;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0__func__, len, sizeof(cmd-&gt;cmd_hdr));<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 virtio_gpu_ctrl_hdr_bswap(&amp;cmd-&gt;cm=
d_hdr);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_debug(&quot;%d %s\n&quot;, cmd-&gt;cmd_=
hdr.type,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vg_cmd_to_str=
ing(cmd-&gt;cmd_hdr.type));<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (vg-&gt;virgl) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vg_virgl_process_cmd(vg, cm=
d);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 memset(&amp;cmd-&gt;cmd_hdr=
, 0, sizeof(cmd-&gt;cmd_hdr));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vg_ctrl_response_nodata(<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vg, cmd, VIRT=
IO_GPU_RESP_ERR_INVALID_PARAMETER);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vg_process_cmd(vg, cmd);<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 virtio_gpu_ctrl_hdr_bswap(&=
amp;cmd-&gt;cmd_hdr);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_debug(&quot;%d %s\n&quot;=
, cmd-&gt;cmd_hdr.type,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 vg_cmd_to_string(cmd-&gt;cmd_hdr.type));<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (vg-&gt;virgl) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vg_virgl_proc=
ess_cmd(vg, cmd);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vg_process_cm=
d(vg, cmd);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (cmd-&gt;state !=3D VG_CMD_=
STATE_FINISHED) {<br>
&gt; diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c<br>
&gt; index 4d46a4eb10..15a845eff6 100644<br>
&gt; --- a/hw/display/virtio-gpu.c<br>
&gt; +++ b/hw/display/virtio-gpu.c<br>
&gt; @@ -1105,8 +1105,14 @@ void virtio_gpu_process_cmdq(VirtIOGPU *g)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* process command */<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 vgc-&gt;process_cmd(g, cmd);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (unlikely(iov_size(cmd-&gt;elem.out_sg=
, cmd-&gt;elem.out_num) &lt;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0sizeof(cmd-&gt;cmd_hdr))) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 memset(&amp;cmd-&gt;cmd_hdr=
, 0, sizeof(cmd-&gt;cmd_hdr));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 virtio_gpu_ctrl_response_no=
data(<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g, cmd, VIRTI=
O_GPU_RESP_ERR_INVALID_PARAMETER);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vgc-&gt;process_cmd(g, cmd)=
;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* command suspended */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!cmd-&gt;finished &amp;&am=
p; !(cmd-&gt;cmd_hdr.flags &amp; VIRTIO_GPU_FLAG_FENCE)) {<br>
&gt; <br>
&gt; ---<br>
&gt; base-commit: 299e7557ed15a9a325620698add379a3ce2d1d95<br>
&gt; change-id: 20260728-virtio-gpu-short-header-476aa1dae4f7<br>
&gt; <br>
&gt; Best regards,<br>
<br>
</blockquote></div>

--000000000000bad07e0657bae72d--

