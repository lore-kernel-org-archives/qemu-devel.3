Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D80BBC56207
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2026 15:06:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrzf5-0005hw-2y; Thu, 06 Aug 2026 11:05:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <connorkite@gmail.com>)
 id 1wrzey-0005ew-Bm
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 11:05:30 -0400
Received: from mail-qt1-x82b.google.com ([2607:f8b0:4864:20::82b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <connorkite@gmail.com>)
 id 1wrzet-0003MH-Eo
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 11:05:26 -0400
Received: by mail-qt1-x82b.google.com with SMTP id
 d75a77b69052e-51c2a449c57so13498081cf.1
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2026 08:05:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786028718; cv=none;
 d=google.com; s=arc-20260327;
 b=sc1atXH6JJLYN1shzUGE2u7IDue3sU51pK6LXoefpUdHDJaz7UNbTlzT5EK9EJdAqO
 u5ruHePcayoNphIPfcc3Z+eW8/jDxyzxoxaYNfimJR6H4aOSDUWPUw6h+6BiK1migB8M
 NwDcsd9Vp9/V9poIOvmiAMB+HEuauBvzKkRM/tkGjV2BguLkavTFVDAR8cpC80yat6zO
 qhqD7hp3xnraVlHJylF+5s2lFTDtZjZ8c6LXOVcU8y0V7ulbSXyx5YdXLAznvFvD363C
 YVZ/ii2/8GBV2t08T7yxZu8YJoIZGRIGETXsQfPzbb0kvKRkCbWLkLY+aL02IAHaDaA+
 TQGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=UoVEjTPysIjqpFcBarX63DcWmY2mFtjbnvx9aK51J8k=;
 fh=xsRg86ZwBm0LGRQZIEC1R+b8QTOodxCX7/oSmDWEnOY=;
 b=P1hDzCUlFOVRa4UdFKS+p3U2IrsO6HeIpF8BKEOQNhEfwDloNLJHCooxQCnTaPypxs
 r+ZfMGn2hpvS0rTfSqh34DD+07KybxTkvxq2KFdoK5OVmTVSuNkmnNF2CGUTgrpkDGQi
 v/2ou/WIxPbEeevNiPx65u0UoCZgqEeBs/PFOt493cKbMWcGz+uv4ZXHzv7u1fQbRMtc
 MW02Ysus7Ge8Ap67oe39hqEiW9NTOUQjEBN4ZZQtmAc+7kxENtQovKOjuZZOziimI/ar
 vXCmFpWS+0IEElOB1uA/ZlRnS+cd3Uw9N2Xsgz3KuzDM0xf0gKa2RblDZvwbPUx/aP69
 nh3g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786028718; x=1786633518; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=UoVEjTPysIjqpFcBarX63DcWmY2mFtjbnvx9aK51J8k=;
 b=Sa5B3TD7ogMT9p410rSeoT5OzRHVrlBRkQbSLwC4QD1oi9jcxqwC9gcM4jFkQbBOp9
 R2VZyvAeEN7SJf0yIhwTSdbl6kIEhQrFMtTEMXtAAVAJN9cdCAyCyvuJ5jjL31M/AYZQ
 Zp9CBjwJKpjhVsUMkpF+i0SxYEoV2zOZv2EpVVBTmY2PnzjD57VpwG5Q7g+CZEMbSskw
 K+AfGA2uj6grSz5cc8XPTs5JGKq7t/BkGPBvFjID3X6hs68SImhBZvA22A9q8PjkBhLx
 TYkxkcbbeCltwvRQ9R7qfVVNvjTJbeRXrOAn4Uy6531kVs42DXE/nxFoLpwT4HfXuOsD
 R8rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786028718; x=1786633518;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=UoVEjTPysIjqpFcBarX63DcWmY2mFtjbnvx9aK51J8k=;
 b=sGneMDWkU+R8Po6DhxVFyq/9UWjtvgD4tAqy2PQ+7m/KcVjV/8l3/nC39uB2n+T+VN
 mOEQHvcuw+LCu2CmnLhOUbfO7Qm6+1OU4KIyzROzXanoA6tqmSbAxZzVcmg6XTObHK/5
 NSGfVyERCFUNQ+cCVhke5My/TEaohokpYziFi+nihXYi8SAmwEuIP/8N3WMl/TriKhyL
 +FhON9no9cQkXAvMpf5m6quzZ35+MnQ68+hKnMfSdjwQ8dvb9oaTiPLwqQ0HNnEk5MT0
 uu5r/N+W5qlWY2Do0pFoJJA4Ttr2Py2OYW4cmkZUdlUFTv2UPMm2hDLUAeYM881oirDG
 iJgg==
X-Gm-Message-State: AOJu0Yyjt6KTia/J6yMk0uORIkt+E7fFyQrXIKc9XqmzZFfhH+zibn/w
 2MnHkmOZFB4LzPzwstQDZC0dfoXhsOLx2U9r1dCJfdrV+74q/RUggd3rIhTJvkfzbdBMLeRSkHC
 Yf0DGhPQTZngfMql2R91vVJUR6ZUUz8c=
X-Gm-Gg: AR+sD10DezGWx82x2T/xNRcPhOAqVlLciodO2xoOl0GY19U1HghBKGnCfgttE7XJQP8
 nJi9lH5V6gkm2SfSBA1UNnoIkK1iMM+/rVPiK/AGhQSMr9WPMM0uqUKKtJNDGODCh2xR7mLMhx0
 nrOt/YfUn0LS+uEBusx8ZF+eW4Bu0lb03gGHIw1PEmWBEGFgRh5kCoyAuge4NmyryLmW1clFGC3
 rHa8f3zcNpvjM8YwHQ2PuZnUg8oybH5mTUQEQ92TBZSV8PAbhsLlMQ1OyOYKLJ9NNbFNUQvqQiz
 b24s1Y9dt88m/nTeiC+1mrlQXIUX8MlioVJH/WOhYArRlvEXjFPv+mJLPAZuFAEDX0HVAt1CU9F
 Wv3Y=
X-Received: by 2002:a05:622a:593:b0:51c:21d1:3852 with SMTP id
 d75a77b69052e-52ce5f63740mr155904611cf.5.1786028717763; Thu, 06 Aug 2026
 08:05:17 -0700 (PDT)
MIME-Version: 1.0
References: <20260723-vhost-user-isolated-memory-v1-0-6b97c439eb28@gmail.com>
 <20260723-vhost-user-isolated-memory-v1-8-6b97c439eb28@gmail.com>
 <39200a6f-8241-4033-ba7a-5c9bbbdc8ff1@redhat.com>
 <CA+spn3p-Fc_uLO1bwSXC39kmQ-iR-OpB-a6cjMTphb-_Ant-_w@mail.gmail.com>
 <738737aa-64ed-479b-bba7-1b0326ef30c0@redhat.com>
In-Reply-To: <738737aa-64ed-479b-bba7-1b0326ef30c0@redhat.com>
From: Connor Kite <connorkite@gmail.com>
Date: Thu, 6 Aug 2026 08:05:05 -0700
X-Gm-Features: AUfX_mxzm5WICpzx40ztF5MASwM8FjGxd7FeJy4vhW-Atxrx6PYaQrlSWL3F2nQ
Message-ID: <CA+spn3rLetrq8w349DAcbVDQu7A3UNshfZK9ADzJm530r_EJJg@mail.gmail.com>
Subject: Re: [PATCH RFC 08/15] hw/virtio/vhost-shadow-virtqueue: used handler
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::82b;
 envelope-from=connorkite@gmail.com; helo=mail-qt1-x82b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Thu, Aug 6, 2026 at 3:28=E2=80=AFAM Hanna Czenczek <hreitz@redhat.com> w=
rote:
>
> On 06.08.26 04:50, Connor Kite wrote:
> > On Fri, Jul 24, 2026 at 4:29=E2=80=AFAM Akihiko Odaki
> > <odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
> >>
> >> The error of the handler that may have left elem stale is ignored here=
.
> >>
> >> Regards,
> >> Akihiko Odaki
> > I have now added in a check that returns on error without setting the g=
uest
> > notifier.  So essentially the call is ignored.  Maybe this could be exp=
anded
> > on to handle errors more gracefully depending on the error code.
> >
> > On Tue, Jul 28, 2026 at 8:06=E2=80=AFAM Stefan Hajnoczi <stefanha@redha=
t.com> wrote:
> >>> +/**
> >>> + * Callback to handle a used buffer
> >>> + *
> >>> + * @svq: Shadow virtqueue
> >>> + * @elem: Element placed in the queue by the device
> >>> + * @vq_callback_opaque: Used to pass arguments to callback
> >>> + *
> >>> + * Returns 0 if the vq is running as expected
> >> The doc comment should mention what non-0 look like. Are errors report=
ed
> >> as a negative errno?
> >>
> > Yes, a negative errno is expected on failure.  I have added clarificati=
on to the
> > comment.
> >
> > On Mon, Aug 3, 2026 at 5:42=E2=80=AFAM Hanna Czenczek <hreitz@redhat.co=
m> wrote:
> >> On 24.07.26 00:30, Connor Kite wrote:
> >>> Adds a handler callback to shadow virtqueues in order to enable
> >>> non-default processing of used vring elements from the device.
> >>>
> >>> Signed-off-by: Connor Kite <connorkite@gmail.com>
> >>> ---
> >>>    hw/virtio/vhost-shadow-virtqueue.c |  4 ++++
> >>>    hw/virtio/vhost-shadow-virtqueue.h | 14 ++++++++++++++
> >>>    2 files changed, 18 insertions(+)
> >> The avail handler replaces `vhost_svq_add_element()`. I find it a bit
> >> unintuitive that this handler does not replace `virtqueue_fill()`, i.e=
.
> >> that it is not a =E2=80=9Cmirror=E2=80=9D of the avail handler; that t=
he avail handler
> >> actually handles avail elements, whereas the used handler is =E2=80=9C=
just=E2=80=9D a
> >> callback on each used element. Was that intentional? (If so, I think t=
he
> >> comment should be explicit about this choice.)
> >>
> >> Hanna
> >>
> > I implemented it as a more narrowly-focused callback since virtqueue_fi=
ll
> > needs to be called regardless.  If I instead called virtqueue_fill
> > from the handler,
> > I would need to pass in the elem index and length via svq->ops_opaque,
> > which is a bit awkward as vhost_user defines ops_opaque when registerin=
g
> > the callback.  That's certainly not impossible to do, but this way felt=
 cleaner.
> > For now, I will add a comment explaining that the callback should not b=
e used
> > to add elements to the underlying vq's used ring.
>
> Then I personally wouldn=E2=80=99t call it a =E2=80=9Chandler=E2=80=9D if=
 it does not handle the
> element like the avail handler does. Maybe =E2=80=9Ccallback=E2=80=9D.
>
> Hanna
>

I see how that's more descriptive.  Updating the name.

