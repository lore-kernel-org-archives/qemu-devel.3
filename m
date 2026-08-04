Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7848BC5518F
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2026 07:29:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wr9aK-0005nr-Pv; Tue, 04 Aug 2026 03:29:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wr9aJ-0005nO-U6
 for qemu-devel@nongnu.org; Tue, 04 Aug 2026 03:29:11 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wr9aH-00022q-Sl
 for qemu-devel@nongnu.org; Tue, 04 Aug 2026 03:29:11 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-84862b0d5f8so3629582b3a.3
 for <qemu-devel@nongnu.org>; Tue, 04 Aug 2026 00:29:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785828548; cv=none;
 d=google.com; s=arc-20260327;
 b=Mk0mLYp9jyBlcFG/Ara/wF7ARBF8AVnHfPxB3K0xp8TU5TfohV5EDNkbPIH2gFZhTB
 V6TOhpSz0QygjVzqVQ9NTQINzpGARSghrfM2R32GmWJPhG78TFA8zcaf7IEBYLcYq4yz
 1s7kcMcb0WgZqreOMwuFtPCZIuLILGuc+hdbxQCWSUCsTReJZT0r4NB6Xv0GUjbT7p0X
 3YqC6SxQn1uAMuoYEoWbYdcyE8y88BDrUBd3vE7xcg4nLYaAxWb1fHSGkYKDyGcwiNFV
 go1+/72yTFI/MmydbdfthOR6oGK9bR1tg7r38td6o6QUy5EdhlSBqobG3VE+KAjRWFGk
 ez8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=V0DJXecxi3oQ3rey5GamuVRAfAYOv70e2YKWCtfrL4Y=;
 fh=lg/v0/3wnAa9ceqIkFU7669+4Dmh84nZtHnS4FvNR98=;
 b=HxrCUS1NsJ1qWuYnEOF+QMt7Ban+5wb8YaLx8fOTsz0sevbM7NhnLJ+PA1buyN86Yu
 TQ+j5mOKGc/LnZeHODhQPkS8XG70jdHNE4O55AEDt/L4k2NpfhBAJj0k4DcM8mWi3T4N
 TKYvWroLNVf4ZpuTeDh+aO7dU4efa5hGZXggtUv46ENzB7lZQ04a/DZ8d9UPBkty+1+v
 BAMAblC4UN7XhttV1CV0XTvAN4vQZgK25pO4Y+ONAVzOz/F+C3v2gmPmXhXyHrxpO6ks
 cWW2XYox2TS194qOIQmK1oOwgF1uKAM2oTbMFNvMAxLqvUF8HEwthcgBYi+5PYaSTH4t
 3rRA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785828548; x=1786433348; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=V0DJXecxi3oQ3rey5GamuVRAfAYOv70e2YKWCtfrL4Y=;
 b=OiUHHyK+SqQ6vikR7nZ4BabHhado3wximMSto2czv30B5lMEsIbyQLl9mMYtNTwrlX
 xjtGW5BX9b+Pd7v9Xn+25zvFKwkC+XP342oXfe1YGaabzJtQJ7/wdJYXWQtVaTpNrM5g
 yKqIrdu1xjlYEvUq9Q5PNim7lJtR4UeNvIy0AfczFRHZVtVBwZ2WU7z6iAR3cyk0UtfS
 41rsA77UZ0C+HCi9yzoTp8M45wwCE7iONHnlUhMVYaE032B3uve0ze6ChvcINm/8GPYd
 401Q381Fcv5wiwvMjC+8D2OhvkFFW5ib4Lwv9oWFqpuhBYJGvU3vewaybmBsfa5NRCCc
 eVCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785828548; x=1786433348;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=V0DJXecxi3oQ3rey5GamuVRAfAYOv70e2YKWCtfrL4Y=;
 b=T7VmU+8YZQ4X0UZqNblUb24FwfeCIzimbMP/KrLwnGv2hVJpqIz5w3bWCzYLmt/K5T
 P3XKrXeSvACCO3Gtg86NIfBfGVZjLL7ir8+1WdsieD549k09UbNqI9Q90HAJ3tplOJOe
 M8TwaB8d6ohq4BSrnC0oAerd6jtlXxobK6ylU6Amr3vv21QVTKlJGTCWztwjWBLpmnOC
 x0LBtmJHpoX2yK2w/9UelS+s5c3QVOrMwHuMyJgrEjH6e7ZaBWzqcHbKgGjFVqZm35fd
 alNFTJy//3e7zBcBoz9mpLevZmbUd11+8dYCV1a1ZbYVt8WZXQe93lRrMcEQ9yiQqvDm
 uNcA==
X-Forwarded-Encrypted: i=1;
 AHgh+RoMHuuNt98EdX1grd9ntFnIdZCyj1sC12bLuOGNRet+cUs3OWVY9+92O2SAqiEiATsol5jKe9+AAqP9@nongnu.org
X-Gm-Message-State: AOJu0YzVcLhG/QZRwasMiprPTYECgGahuNzGY6DVYNrVe3bN20CH0nN6
 6wRAzsXzEOiGY5tKH9s+rvOye3uJ8p1wt/BgEvDmtqSgSMXnsXUrtjDQ5rnKCNXOeJ/bEPKhw2p
 TsibbJTPU/s/linJ0NM8UtctRSGiSzB4=
X-Gm-Gg: AR+sD12rLqPx977/iE/HgRSevYTG7iEs7Tkb56jQ1b6WcJcinRCwcegUTnXqlYFvTMO
 Ml+n8i2YGlxMUBPxX+foZZDhaWZF7zgcRAVXTytyNJmhXkxQc9kjJU31tVHgbS/eMqQnRtx8v8h
 q4aj6HR8ct6qc4X2qZ7A3RLASOITm3TbE5wNasmBSTCyZy3QwNu/vWXttii9pRbUO8XebUK1pkW
 hCsmQgHV0b94eRlzmaiEFodcAhG1TqDeVsehQVzZ29ukdN+B84jri3Uv8HCHVVhj2EwRMXJyE51
 ZhdhagHqLnO+AymN3Ek4ThKvlnDZf/EOeJvWqjdaVXz3LxeZoWrAntIAtM0/tBAIsSEdpu+wjsP
 1
X-Received: by 2002:a05:6a20:9e0e:b0:3bf:6237:4d4a with SMTP id
 adf61e73a8af0-3c92a7fc9a4mr14056196637.24.1785828548333; Tue, 04 Aug 2026
 00:29:08 -0700 (PDT)
MIME-Version: 1.0
References: <20260803-virtio-gpu-short-header-v3-1-936c1daa8e61@gmail.com>
 <e4313c26-fff3-470b-ab9e-8b90cdc98a43@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <e4313c26-fff3-470b-ab9e-8b90cdc98a43@rsg.ci.i.u-tokyo.ac.jp>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Tue, 4 Aug 2026 11:28:55 +0400
X-Gm-Features: AUfX_mwq1tWUhVscYoPNw5vp5tKRoFZiru3WselZx-fWN36GS2GW20EIsZkb7S4
Message-ID: <CAJ+F1CK-cfC0zfZEEkdhuVdNwsuLQ9tLqAts-R9==voGVOyMBg@mail.gmail.com>
Subject: Re: [PATCH v3] virtio-gpu: reject requests with short/truncated
 control headers
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: Ankur Saini <ankur98saini@gmail.com>, qemu-devel@nongnu.org, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-pf1-x42f.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.248,
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

Hi

On Tue, Aug 4, 2026 at 9:59=E2=80=AFAM Akihiko Odaki
<odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
>
> On 2026/08/04 2:09, Ankur Saini wrote:
> > A short control request can leave command data partially initialized.
> > For the common header, guest-controlled flags can then cause stale fenc=
e
> > metadata to be returned to the guest.
> >
> > The command fill helpers detect a short copy but only log and return,
> > leaving the malformed request without an error or completion. Make
> > VIRTIO_GPU_FILL_CMD() clear the partially copied object and complete th=
e
> > request with ERR_INVALID_PARAMETER. Make VUGPU_FILL_CMD() report the sa=
me
> > error through the existing vhost-user-gpu dispatcher. This also rejects
> > truncated type-specific commands.
>
> One small correction: this says the malformed request is left without
> completion, but virtio_gpu_simple_process_cmd() and vg_process_cmd()
> actually complete them, though its response type is
> VIRTIO_GPU_RESP_OK_NODATA.
>
> With that addressed,
>
> Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

I queued this patch and updated the commit message
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

>
> Regards,
> Akihiko Odaki
>
> >
> > The vhost-user-gpu common header is copied outside VUGPU_FILL_CMD(), so
> > clear it and complete the request directly when that copy is short.
> >
> > Fixes: CVE-2026-18054
> > Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4094
> > Reported-by: Ankur Saini <ankur98saini@gmail.com>
> > Suggested-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> > Signed-off-by: Ankur Saini <ankur98saini@gmail.com>
> > ---
> > Changes in v3:
> > - Handle short copies in VIRTIO_GPU_FILL_CMD() and VUGPU_FILL_CMD(),
> >    also rejecting truncated type-specific commands.
> > - Clear partially copied QEMU command data before completing the error.
> > - Keep vhost-user-gpu's explicit common-header check and drop the
> >    redundant virtio_gpu_process_cmdq() check.
> > - Rebase onto current master.
> > - Link to v2: https://lore.kernel.org/qemu-devel/20260729-virtio-gpu-sh=
ort-header-v2-1-18036a97219a@gmail.com
> >
> > Changes in v2:
> > - Also reject short/truncated control headers in vhost-user-gpu.
> > - Expand the commit message to describe both affected paths.
> > - Link to v1: https://lore.kernel.org/qemu-devel/20260728-virtio-gpu-sh=
ort-header-v1-1-af19a00b100d@gmail.com
> > ---
> >   contrib/vhost-user-gpu/vhost-user-gpu.c | 21 ++++++++++++---------
> >   contrib/vhost-user-gpu/vugpu.h          |  1 +
> >   include/hw/virtio/virtio-gpu.h          |  3 +++
> >   3 files changed, 16 insertions(+), 9 deletions(-)
> >
> > diff --git a/contrib/vhost-user-gpu/vhost-user-gpu.c b/contrib/vhost-us=
er-gpu/vhost-user-gpu.c
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
> > diff --git a/contrib/vhost-user-gpu/vugpu.h b/contrib/vhost-user-gpu/vu=
gpu.h
> > index 2374eb90cb..aaf2870cb2 100644
> > --- a/contrib/vhost-user-gpu/vugpu.h
> > +++ b/contrib/vhost-user-gpu/vugpu.h
> > @@ -179,6 +179,7 @@ struct virtio_gpu_ctrl_command {
> >           if (vugpufillcmd_s_ !=3D sizeof(out)) {                   \
> >               g_critical("%s: command size incorrect %zu vs %zu", \
> >                          __func__, vugpufillcmd_s_, sizeof(out)); \
> > +            cmd->error =3D VIRTIO_GPU_RESP_ERR_INVALID_PARAMETER; \
> >               return;                                             \
> >           }                                                       \
> >       } while (0)
> > diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-=
gpu.h
> > index 2f60c72078..f965defa6b 100644
> > --- a/include/hw/virtio/virtio-gpu.h
> > +++ b/include/hw/virtio/virtio-gpu.h
> > @@ -315,6 +315,9 @@ struct VirtIOGPURutabaga {
> >               qemu_log_mask(LOG_GUEST_ERROR,                           =
   \
> >                             "%s: command size incorrect %zu vs %zu\n", =
   \
> >                             __func__, virtiogpufillcmd_s_, sizeof(out))=
;  \
> > +            memset(&out, 0, sizeof(out));                             =
  \
> > +            virtio_gpu_ctrl_response_nodata(                          =
  \
> > +                g, cmd, VIRTIO_GPU_RESP_ERR_INVALID_PARAMETER);       =
  \
> >               return;                                                  =
   \
> >           }                                                            =
   \
> >       } while (0)
> >
> > ---
> > base-commit: b428fe036233cbd15d37e3c027ab6ca4d3661a80
> > change-id: 20260728-virtio-gpu-short-header-476aa1dae4f7
> >
> > Best regards,
>
>

