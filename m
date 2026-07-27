Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47BD3C531D0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 13:03:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woKyw-0004a3-2j; Mon, 27 Jul 2026 09:02:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <seungjung0711@gmail.com>)
 id 1woKyi-0004WX-FJ
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 09:02:51 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <seungjung0711@gmail.com>)
 id 1woKyZ-0006Gr-8N
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 09:02:41 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-38f620399a0so76630a91.2
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 06:02:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785157348; cv=none;
 d=google.com; s=arc-20260327;
 b=Vubnuf0LOt5ROW5ubbyRmu92SL21vPuV+NgQQ+c3DFNDe6eu6pxvkQXvO9Ytpf0obN
 SLoJlI3CkOdVC8wugP2Lk2xN26wnswN3bYcHtnpzF9DcBU43ffvbyjOsenHjfB1cQfck
 DhP9ZLBhewWzsyDKO8cZql6X/L4Duxrie2M/Lf3/VQdp+JUIU+5b1iomMzIOlrJ/3ox2
 7otOowRuYZFmY6bsytH9wV4xlvZbxeVFXM7P5Rc0gCS3zqPPFzBRSACsQCoTz33Sw2Fi
 JNp0lZlDwdYdlCdUbwi5EyNG2KbPXhSp0X8grcKHlOuE5zwDr/vklhG/b3SLx8bVNj9F
 L3xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :mime-version:references:in-reply-to:dkim-signature;
 bh=AxaoQSe+AwUTHHc/yHlckiBrig0PlNBV0mwrqjldczo=;
 fh=u4kMDEckmjXEfsC9G4Nhq/UICbPiej6RGwUXN65gJ0I=;
 b=lCwKWrqXPrKJSH6YAhyzBAUz6Y0Lr3KD8nBExQSUc1xdmdmqivzjhIgffEkOtQK18x
 EKEJhDxB3zATYPqzXbELDCKVdxRg43LQE0SytqOl3JnRajVS5sZxhf0hmazuR1P96yzv
 3GT/r7OrDjmadZyUrhpARTlS3nnSmDX/YRwYfhT0io98U3/wKjt1KmJnHAkND5RYiCFh
 T7PT/6KoliiKfNfWb+A5u88Pxo0wuxVkToNGRWBWcLGlgIGYBSR7jFlrAFH+FVolCyud
 Mgb64lbuqbHkRQCN+TybdFOTfFOKYwHMFrvESmwf94eTIjZEVjZAz+qi5HF/V0VDd6T3
 D5Ng==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785157348; x=1785762148; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:mime-version:references:in-reply-to:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=AxaoQSe+AwUTHHc/yHlckiBrig0PlNBV0mwrqjldczo=;
 b=JihRuGWQ5tPuBEFJaGEo3WzF4kZEHPgwyspGVQUDbWpddKj/tzp7iwseO6YZkmTpuj
 mwoAlFoeIU2Ys4I40RKc7BcVsNjv0Ud2q8Fa4UgXWyab9aj6gQNWp254NEF9Tp7zUTg2
 Wle8lc+YAuhryi8AnzwFwwpGQ2u0XNTACAjhK8cxspkuTWkQ6ls6wrRpSOw/a74A11GJ
 dIFxTVw7WzJ76nXASGTeAPxRPRkfPlXFdmAIK23XPxqSHpVKnHin+O2EUxIaUSMtiWS4
 1nHmYIhZiK0A9pBdGMONd6XfV02iXbIj0kwrv7sFN+FcjnRr67qcsfgQACQS/ORjWGAb
 6pSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785157348; x=1785762148;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:mime-version:references:in-reply-to:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=AxaoQSe+AwUTHHc/yHlckiBrig0PlNBV0mwrqjldczo=;
 b=ds3+u6UgLXfk3nlzEab7yEz3HyW3PPGvQDq0crAc6pDRZpaosEr5cQ74Epa/CfD382
 xwoHR/NItGBI4bmJokXkS7ZtYZ2XDYowjw/zo+1mwKQQRP1hAtljKIvoGaxcPdydfkN1
 L1yfe27BPVe5yQiOkY0D0ZU2EfOChuTgrsCr1MEJSyZd+gHrTWZjGsAg9ModE5e3SJgb
 VKtwr1ASQToUz3JiJ/tQaVxBr73ehkPdiyhjZ2gCBiHOCEhCp2Xi2cu+9oTUaIJ46ei2
 IMOo05FnjJ5Evq5GnQorgGQtkX89Bk8q41M3UAWfSPNvq6oa8BeNlDMDYOLO2FDZK+BL
 Ncog==
X-Gm-Message-State: AOJu0YzT3uWE4cMoQekiNQzGQEJ1CpCONJBGJtEAkajg6eK5l/br1BS3
 Vswf6NOoZahtP49MWiNLt/zB794POkOh5HorPsVyMqNblzEBoEXelBpK0yco3SxTRj511T+qcFL
 bJK2sxyTg14+3PHgArJswSNvW9zgpTNk=
X-Gm-Gg: AR+sD13nlopHfU/iA/e13Fs2L9P7ilVKwRBKcCY8oWgsArOJY7XMX4TSqFw4zsQlPyT
 AwlfKYBJNgm+Nbp1Ne5gLI63MmSUGR/3eR2s7IqLFHxToJedakpzJVCxzn9pUuEjXkETq9CcDQY
 4Mir92gY5sIY0hO+irnzdSTLUWzHPpwS/VBjfqjVp4/xC8eCBGi7XOrix49QB8IwUnfYdQBeEDc
 Xdae7KMYpBmwIxxOHOAAjbSs2FWtYz+L6Ictn0lfTg5uHWMRY9w08ABLGpbGpvJ96cYLWLtuBm4
 geHWq2IZCQpbB3dtGfg+RCDXzlc=
X-Received: by 2002:a17:90b:57ef:b0:38d:fda6:4873 with SMTP id
 98e67ed59e1d1-38f604aeb02mr774942a91.10.1785157347434; Mon, 27 Jul 2026
 06:02:27 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST; 
 Mon, 27 Jul 2026 06:02:26 -0700
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST; 
 Mon, 27 Jul 2026 06:02:26 -0700
In-Reply-To: <20260727084637-mutt-send-email-mst@kernel.org>
References: <CAHntc+O1jaJhj1_k6kTHDp7u_1DdPUCKZNA_AxWYh+SKraXS8A@mail.gmail.com>
 <20260727084637-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
From: =?UTF-8?B?6rmA7Iq57KSR?= <seungjung0711@gmail.com>
Date: Mon, 27 Jul 2026 06:02:26 -0700
X-Gm-Features: AUfX_myKKVKRvqPSjOBMNsJzNXOTzsrCR7Ro94uwlMAgGHos6f3CFUpEZYe4zUs
Message-ID: <CAHntc+OJ+KMaW_rxXCFn7RjHmBHnp7=q-9TiC_P1HbqfRBhtvA@mail.gmail.com>
Subject: Re: [PATCH] vhost: Reject oversized inflight migration buffers
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Stefano Garzarella <sgarzare@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Mauro Matteo Cascella <mcascell@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=seungjung0711@gmail.com; helo=mail-pj1-x1029.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

Thanks Michael. Understood.

The pre_load check was intended as an immediate mitigation, but I see
that it does not address the VMSTATE_VBUFFER_UINT64 type confusion in
the common load and save paths. I will defer to the generic vmstate
fix and will not resend this patch.

I included "Fixes: CVE-2026-6426" because Mauro requested that exact
trailer when the CVE was assigned. I understand that under the current
QEMU security policy, vhost-user-backend-originated issues are treated
as hardening bugs rather than security flaws.

Could you please retain the following credit on the final fix?

Reported-by: Seungjung Kim <seungjung0711@gmail.com>

Sorry about the unrelated whitespace change.

Thanks,
Seungjung


On Mon, 27 Jul 2026 08:48:56 -0400, "Michael S. Tsirkin" <mst@redhat.com> w=
rote:
> On Mon, Jul 27, 2026 at 05:45:47AM -0700, =EA=B9=80=EC=8A=B9=EC=A4=91 wro=
te:
> > The inflight buffer size is migrated as a uint64_t, but vmstate_size()
> > reads VMS_VBUFFER sizes as int32_t. Values above INT32_MAX therefore
> > become negative and are converted to a very large size_t while loading
> > the buffer, allowing writes beyond the smaller memfd-backed mapping.
> >
> > Reject sizes that cannot be represented by vmstate_size() before
> > allocating the destination buffer.
> >
> > Fixes: CVE-2026-6426
>
> This CVE really shouldn't be there.
>
> > Reported-by: Seungjung Kim <seungjung0711@gmail.com>
> > Signed-off-by: Seungjung Kim <seungjung0711@gmail.com>
>
> This doen't fix it properly, it only fixes values 2g to 4g, but above 4g
> is still wrong.
>
> A better fix here:
> https://lore.kernel.org/all/9e2d0b03a60642236e6df8edde7b3562f5f9849f.1785=
101237.git.mst@redhat.com/
>
> >
> > diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> > index af41841b52..82eb9407ae 100644
> > --- a/hw/virtio/vhost.c
> > +++ b/hw/virtio/vhost.c
> > @@ -2022,11 +2022,18 @@ void vhost_get_features_ex(struct vhost_dev *hd=
ev,
> > static bool vhost_inflight_buffer_pre_load(void *opaque, Error **errp)
> > {
> > struct vhost_inflight *inflight =3D opaque;
> > -
> > int fd =3D -1;
>
> pls don't make unrelated changes like this.
>
> > - void *addr =3D qemu_memfd_alloc("vhost-inflight", inflight->size,
> > - F_SEAL_GROW | F_SEAL_SHRINK | F_SEAL_SEAL,
> > - &fd, errp);
> > + void *addr;
> > +
> > + if (inflight->size > INT32_MAX) {
> > + error_setg(errp, "inflight buffer size %" PRIu64
> > + " exceeds maximum %d", inflight->size, INT32_MAX);
> > + return false;
> > + }
> > +
> > + addr =3D qemu_memfd_alloc("vhost-inflight", inflight->size,
> > + F_SEAL_GROW | F_SEAL_SHRINK | F_SEAL_SEAL,
> > + &fd, errp);
> > if (!addr) {
> > return false;
> > }
> > --
> > 2.50.1 (Apple Git-155)

