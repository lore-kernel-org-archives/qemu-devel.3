Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 770BEC5AD7B
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 02:34:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtcIk-0007qm-9g; Mon, 10 Aug 2026 22:33:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <connorkite@gmail.com>)
 id 1wtcIi-0007qQ-SG
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 22:33:12 -0400
Received: from mail-qt1-x832.google.com ([2607:f8b0:4864:20::832])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <connorkite@gmail.com>)
 id 1wtcId-0006qE-27
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 22:33:12 -0400
Received: by mail-qt1-x832.google.com with SMTP id
 d75a77b69052e-517dc520840so19610041cf.3
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2026 19:33:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786415585; cv=none;
 d=google.com; s=arc-20260327;
 b=NK3EYaGAnzTis2gMK80cFVKdf+IKDsvDof+6gH/+cSprj7ClR2gLEv0ff5MVLV7gxc
 vxBGEOmcsy9a0Yucr9vu9cY0N9Uv974bjOw1Bpz9/yZQ1p8t9AY28cj36XmRHFv/G9t+
 edkQFQV6tvfn9HQ4VAqdQGiTn2qiR41oZaLc5tN++2y4TQwelCFn+sQNSk6rDQyUDAWT
 rB0o5i47+ko7DT51qqVCEG7oysJ7DnXFQnZx/fXIgxZQpzQ2bwjaVm/sumbjloVBgodN
 kmmZJyAUuu8XvD4CiWK2eeVdZp12yISkrmgCJ2ATpkkaym1h8A8NrRAMu6mrBmQs7rBM
 LuGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=l47ouiWxP5ccdaTdd4P/MDEyQu/nWl9Vr1nsGjRMchM=;
 fh=xsRg86ZwBm0LGRQZIEC1R+b8QTOodxCX7/oSmDWEnOY=;
 b=dYV5gTIjL7TbRMjso44pJu45jntE2MWoh2P48qufFTE85o0u6/0J84rCr7tkijVMaN
 8lJDOx04PxeQINOLw+58/Rk4TKiqfNNZZRL/+ATtieq8ka6lZynh4TH9tq4RroGsUht1
 vflzzz0uWyuosY976rF3JbP1psDSlg7/3eLWaZxkq7t3/KG9sYOotfsfiWr9FJKshd96
 VtGkcm9US+e4M/5QXnGY/3mfmh39JImuTZ9J7ehBZyo0y7JBDN1+zgm5qCF4WxfJsSPx
 pm5eiG7uaRAMpWOafVS7+0rSW9BcIszisba8VlblYsr+h2JwqZMt0HC8x26WHko7UBAl
 vY2w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786415585; x=1787020385; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=l47ouiWxP5ccdaTdd4P/MDEyQu/nWl9Vr1nsGjRMchM=;
 b=U4CRIW+vRtUAfoKM8KaCPqlhtd00nAi5cb+7dn9gXg6uPkcKZTFqwUmxF+SpbPUHsH
 21M8trCTTRtMN8uIyPX3G8FeeoT1v5+vnBCACe9wNqQa/SZLk2w7+tzJUWuZAmx92IjZ
 bEDGfuJ4EHvPc592m9nCHH8JN2XFiaR6T+lA4+VPBh15ZUCRfFaKsQoQNvNCIjWIQ4Ub
 Io6xG1roEGdVowzMIkQsLb9KUjyDM2LVkJojvlJBBbaSrk2xpxO4j3fqkPpLrzeLkpHD
 aDAgY3akzG2qvvml5nkcUQ3h/wX2Ln8UJ+2CEwd5ANmJvCJMFPZFA7LYIVJOQHIxeaE9
 MXPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786415585; x=1787020385;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=l47ouiWxP5ccdaTdd4P/MDEyQu/nWl9Vr1nsGjRMchM=;
 b=iwqdOUwvVkGu4cw9jbVloGwYFGsE69yCnLm8z4RKCwlFZLpcx37cuN4aETSpUmSdLu
 0jbFcQXQGsViO7fxLrPIt5eEyPQu4JPXP8z3QeX9NQx2jMRA+/qZjoUWKTx99YEbvsgR
 XPW/tDIyQXg6qPSyJS3EH52C3DTH3hKOm1jh7GiyZv7+hUofKlAErqtZlOM3xcf0oJgi
 hOkaidBxys9WjmUzOTxM+n8NLiZe6ha347iW2Rgmr4iVNaISR97c52pPh5R9saxTpyxp
 uMMpoDwd1Zintnea+JV466CHzMNw3wB4yxRDnK7BxLfYBZm8RrqV8Qhf/9aOxHd6G3yV
 gvMA==
X-Gm-Message-State: AOJu0Yw4xOFfOIF5vfYG5RkMhOx82fIDPztKcWeAE6r5BoHtsGxmIP67
 NRU94ATR/Myxde5zpx7pE4PgF0qqDU1b2VLwR+EHstByxfmv2/S80BgVrCMwokgpT43s+ofCfVG
 SXuFUYh43v8NiKmXFzYo0tzEYWbkBRLU=
X-Gm-Gg: AR+sD11gh6ItaXB03rg5Rzsqcol+O3GGhwsU0ZH6EfP+HUELd2NmbToTt0+1kXPeORC
 QAPylZ1IKzku3TEElGuU3Y+I5tKZH0nIbFftbGy/MrvBVeAb4PPiHfF+011MWOb9RHxkT7zgZaq
 IwooxB1otISIK5MsZkgwGg1B0d9AZMQt4wfuYgyr5tbEmc3asoDlmNk8K6J18gDNpNMDT8gUeb1
 I4gj6NZFHUy93m8DptILK8Nuzj5eTBkqP48PUYGrM0zDkdCQx2/xLlJ9FJsFJo89xdEKd/3BvS4
 BbLyU0NclB0/b0Mpot4n1+tHLhae1hi2hhigKaVx/yOcLF2yRp+oNXESnoY/TUcIUnT0qsHmzx3
 GP1A=
X-Received: by 2002:ac8:5d06:0:b0:51c:1ff:2512 with SMTP id
 d75a77b69052e-52d58670614mr1275201cf.33.1786415585557; Mon, 10 Aug 2026
 19:33:05 -0700 (PDT)
MIME-Version: 1.0
References: <20260723-vhost-user-isolated-memory-v1-0-6b97c439eb28@gmail.com>
 <20260723-vhost-user-isolated-memory-v1-13-6b97c439eb28@gmail.com>
 <13594665-16ec-47e5-9075-f7bd5552b0a3@redhat.com>
In-Reply-To: <13594665-16ec-47e5-9075-f7bd5552b0a3@redhat.com>
From: Connor Kite <connorkite@gmail.com>
Date: Mon, 10 Aug 2026 19:32:54 -0700
X-Gm-Features: AUfX_mwJzLB3L_tUMvJyoXZYiw6uHtEY3ibxhzMN-VRQUCLkfnI52lB5oLNIv00
Message-ID: <CA+spn3r7+pEb7e6=8JixTpk7M3rNhWv=JkGZchj2-3FK9ZQGYQ@mail.gmail.com>
Subject: Re: [PATCH RFC 13/15] hw/virtio/vhost-user: add shadow virtqueues and
 eventfd intercepts
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Raphael Norwitz <rnorwitz@nvidia.com>, Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Milan Zamazal <mzamazal@redhat.com>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, qemu-block@nongnu.org, 
 virtio-fs@lists.linux.dev, "Gonglei (Arei)" <arei.gonglei@huawei.com>, 
 zhenwei pi <zhenwei.pi@linux.dev>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Jason Wang <jasowangio@gmail.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Alyssa Ross <hi@alyssa.is>, Demi Marie Obenour <demiobenour@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::832;
 envelope-from=connorkite@gmail.com; helo=mail-qt1-x832.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Mon, Aug 3, 2026 at 6:52=E2=80=AFAM Hanna Czenczek <hreitz@redhat.com> w=
rote:
>
> > +    struct vhost_user *u =3D dev->opaque;
> > +    int svq_idx =3D file->index - dev->vq_index;
> > +    if (u->user->memory_isolation) {
> > +        VhostShadowVirtqueue *svq =3D g_ptr_array_index(u->shadow_vqs,
> > +                                                      svq_idx);
>
> Bounds checking via `vhost_user_get_vq_index()` would be nice. (Same belo=
w.)
>

Adding the bounds checking outside of the memory-isolation only code path, =
since
file->index wasn't being checked previously.

> > +        if (svq->hdev_kick.initialized =3D=3D false) {
> > +            int r =3D event_notifier_init(&svq->hdev_kick, 0);
> > +            if (r) {
> > +                error_report("Failed to create kick event notifier");
> > +                return r;
> > +            }
> > +        }
> > +
> > +        file->fd =3D event_notifier_get_fd(&svq->hdev_kick);
>
> What if `file->fd` was -1, i.e. `VHOST_FILE_UNBIND`? Should we put a
> real FD here then or just continue with -1?
>

Good point!  I think we need to propagate the -1 to the backend device, and
run event_notifier_cleanup on the existing svq->hdev_kick.

...

> > +
> > +        if (svq->hdev_call.initialized =3D=3D false) {
> > +            int r =3D event_notifier_init(&svq->hdev_call, 0);
>
> Do we need to check if the call event FD is already active?
>

Do you mean, do we need to call event_notifier_test_and_clear to see if it'=
s
been set and potentially run the call handler at this stage?

If so, this might be where some of the intricacies of when things happen in
vhost-user vs in vhost would require some extra care, unless isolation mode
implementation moved up into vhost.

...

> > +    /*Modified from vhost-vdpa*/
> > +    u->shadow_vqs =3D g_ptr_array_new_full(dev->nvqs, vhost_svq_free);
> > +    for (int i =3D 0; i < dev->nvqs; i++) {
> > +        VhostShadowVirtqueue *svq;
> > +        svq =3D vhost_svq_new(NULL, NULL);
>
> Patch 15 adds clean-up for this; I would squash it into here, as far as
> possible. Ideally, a patch series can be stopped at any step and not
> break anything, so if an allocation is added, the accompanying freeing
> should come with it.
>
> Hanna
>

In hindsight I shouldn't have considered cleanup a separate stage in the
development.  Too easy to introduce bugs that way.  I'll move cleanup up
and comment in the Patch 15 thread.

