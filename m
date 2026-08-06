Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EA58C55ABA
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2026 02:51:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wroCL-0007P1-5H; Wed, 05 Aug 2026 22:51:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <connorkite@gmail.com>)
 id 1wroCI-0007Ol-Eg
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 22:51:06 -0400
Received: from mail-qt1-x833.google.com ([2607:f8b0:4864:20::833])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <connorkite@gmail.com>)
 id 1wroCG-00012I-Sb
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 22:51:06 -0400
Received: by mail-qt1-x833.google.com with SMTP id
 d75a77b69052e-527e352a167so10818681cf.1
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2026 19:51:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785984664; cv=none;
 d=google.com; s=arc-20260327;
 b=EX06lNKXa7hWFwm2r6kTzhNCPMmk8MHebt6K3WgAVB9Tozx85Nlq5S6SK4DeZXMA1F
 1J/6NlKt1gkuY9l/eg0vWIQnfVl7VWjr/BOq6d+PKcWfudr+6oLnRwLZCVZpmxSLOPAX
 SqDbxiL65mGGNaCzzxrHKL1w3bOkYrwh07/UHk5qK7jSkrUfjWp9S2ncno99SUQLNXqm
 p/aH8vU8wAUExAC0YbtTPuZMHg/n132MF1qGd54nIeopjSYz3oKJbOy0HV7d06HrsOOR
 F+SR6/xuYCFNlWgHtLUw8enh3SgBBSPHkNcdM/fPZq6ti1YzHQtTtvDkolNNecOVXnY6
 1olA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=y8B4/ecGO2Mq14LjwKIDLibLrauS6XdTr/m0chUgNdg=;
 fh=xsRg86ZwBm0LGRQZIEC1R+b8QTOodxCX7/oSmDWEnOY=;
 b=JwoxuWRmT2PoDQga7hFKgcRO0E+Kr/Xz62KyIXwWxnXQxtpVkhXL+FTzI3gIuG4HrG
 LMEpSpsI8wxyPlayymFN9x9TFmT6bHptKs4NqgT2y8kzNIHH9t5tkBBZ56Kj40Ym5zfx
 BGjI5k4OLzgtny59Kmv9KOjZ5D7syy6ax0PXPYYndId5DysiwtcZ/YtqMA6ea/POa0zT
 WNIp9pAdIjfyXy9ANwQMJx2n9Jh4K+o7AOMVUSp9E4Mp7a2bXaB8pUoOM/kLpUaPFao8
 Uhgp4RvPoltneMBcVGFGBej1lilrKpW8iS2XuSDy6trbqs029jtOLp1CldpshtEWcuxS
 aqjg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785984664; x=1786589464; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=y8B4/ecGO2Mq14LjwKIDLibLrauS6XdTr/m0chUgNdg=;
 b=XOmn3DIvJC9d1+gb2/9LgpnJFzChSFQJ49y/K4OrdSDBrPbGT7BmM2jGiZUinw92db
 uV/mOiIwsphBxA4p9Hhpxn5e57dq7KEz20T1txy15RCL7I/67WpUBk+WJaM2eepE6m/x
 ufJ0xY28sYRv3q/wlGnBKSHLc7mYG5sZoQ//hwOmafFtb6o5PFEbD0y8XzAoUp2vJWjR
 zFqODGd67o8MQTT4fBRmMxhOpoUtZo7N+/KMGm6eObf0IAfS37lfMMoEe7nqL6g1fn/P
 V0C6RgL6c1sVGwtqaAQMgKYqLtuOEp/9fkezDoo8QYaHPFFID5AOws3v5RnaXNPpRkiK
 XDnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785984664; x=1786589464;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=y8B4/ecGO2Mq14LjwKIDLibLrauS6XdTr/m0chUgNdg=;
 b=Bm4BxsY9fgcSeomsFeMh7ESnum4w8wH7iTreUH4SdcN9R+m0ZeA3t8LEyQ3ScROIwc
 NZwoRexSoIwlbiYCZJ88PABGaa0iXD0aSURqDM/a1sIx3tmrGFe2u/8UnfUCP/nKSGDM
 CrEmYd2a5GpJAQ/7sfJGmg3NCsuDjOQGo79OCO+XdfcBySseNMRfR6hW+kMgNQpVLu2c
 51+h+JiULXZ/RVGmyfGBfaWXzawExQNofGmyBrACNBXgTHizhYmdujBnN0yiTbQGLsAB
 T+7o4lUi12+JxrmR8+LDACDfnXiJrYcC7DDleFd7roDpDgWepAizsB+pDty8KwMb4/e+
 KhaQ==
X-Gm-Message-State: AOJu0Yx8CaWy+s+uN3UXWlWA/+fuv6zzVpgyJRGdhOBkJ5JIEgYCA36c
 F54YzVEmujxcPOW65FSCQ+ef58gdOlLnJrnLGTX5ZMBt3LQgX3pOIdrM2IazQbZ/JGOzVGmGC+N
 yciZCTrnTj88Pr63Suy7HbfuYfl24nHo=
X-Gm-Gg: AR+sD10UNPCwGia2KRL9CAeijXahbr78WCfAwUBR41ig3i8dujFcyINWNGGzaJUxDCu
 luYP6oUU5BM2M75PDjhox8pd9wlDzVKycpHY4I7tCI2q05zvgc9aHnqYnogefA9Ut5PxzSXp6T1
 zoYas43qsHU2CsQmEYbSsJ3Pn+x13IM0H0Thb9vkmj8o3GeSdADyQEeDjYeppRbwPWu4BPhbp7R
 YZXStvTdKtYKmDHUNlVRiyDgZnpvb+OOJZLwCVEYjQzEWSdldJBwRd895Vz6eA7RB4OdOpoJvL6
 6xt1OH/gLTqrZ34IqtBkylJ+vF+zRlOpok446ggscSjv0sIlag4vf+tp2gfa+qIUuO5reY3q+3X
 acw==
X-Received: by 2002:a05:622a:2307:b0:517:7e26:36a4 with SMTP id
 d75a77b69052e-52ce61df7dfmr124407901cf.34.1785984663704; Wed, 05 Aug 2026
 19:51:03 -0700 (PDT)
MIME-Version: 1.0
References: <20260723-vhost-user-isolated-memory-v1-0-6b97c439eb28@gmail.com>
 <20260723-vhost-user-isolated-memory-v1-8-6b97c439eb28@gmail.com>
 <39200a6f-8241-4033-ba7a-5c9bbbdc8ff1@redhat.com>
In-Reply-To: <39200a6f-8241-4033-ba7a-5c9bbbdc8ff1@redhat.com>
From: Connor Kite <connorkite@gmail.com>
Date: Wed, 5 Aug 2026 19:50:52 -0700
X-Gm-Features: AUfX_mwdgfZNtUVKN2fr62b4CYdJBKHGSJqFmOuYnQn3J4JowOt9nqgKAcaQl7Q
Message-ID: <CA+spn3p-Fc_uLO1bwSXC39kmQ-iR-OpB-a6cjMTphb-_Ant-_w@mail.gmail.com>
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::833;
 envelope-from=connorkite@gmail.com; helo=mail-qt1-x833.google.com
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

On Fri, Jul 24, 2026 at 4:29=E2=80=AFAM Akihiko Odaki
<odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
>
>
> The error of the handler that may have left elem stale is ignored here.
>
> Regards,
> Akihiko Odaki

I have now added in a check that returns on error without setting the guest
notifier.  So essentially the call is ignored.  Maybe this could be expande=
d
on to handle errors more gracefully depending on the error code.

On Tue, Jul 28, 2026 at 8:06=E2=80=AFAM Stefan Hajnoczi <stefanha@redhat.co=
m> wrote:
>
> >
> > +/**
> > + * Callback to handle a used buffer
> > + *
> > + * @svq: Shadow virtqueue
> > + * @elem: Element placed in the queue by the device
> > + * @vq_callback_opaque: Used to pass arguments to callback
> > + *
> > + * Returns 0 if the vq is running as expected
>
> The doc comment should mention what non-0 look like. Are errors reported
> as a negative errno?
>

Yes, a negative errno is expected on failure.  I have added clarification t=
o the
comment.

On Mon, Aug 3, 2026 at 5:42=E2=80=AFAM Hanna Czenczek <hreitz@redhat.com> w=
rote:
>
> On 24.07.26 00:30, Connor Kite wrote:
> > Adds a handler callback to shadow virtqueues in order to enable
> > non-default processing of used vring elements from the device.
> >
> > Signed-off-by: Connor Kite <connorkite@gmail.com>
> > ---
> >   hw/virtio/vhost-shadow-virtqueue.c |  4 ++++
> >   hw/virtio/vhost-shadow-virtqueue.h | 14 ++++++++++++++
> >   2 files changed, 18 insertions(+)
>
> The avail handler replaces `vhost_svq_add_element()`. I find it a bit
> unintuitive that this handler does not replace `virtqueue_fill()`, i.e.
> that it is not a =E2=80=9Cmirror=E2=80=9D of the avail handler; that the =
avail handler
> actually handles avail elements, whereas the used handler is =E2=80=9Cjus=
t=E2=80=9D a
> callback on each used element. Was that intentional? (If so, I think the
> comment should be explicit about this choice.)
>
> Hanna
>

I implemented it as a more narrowly-focused callback since virtqueue_fill
needs to be called regardless.  If I instead called virtqueue_fill
from the handler,
I would need to pass in the elem index and length via svq->ops_opaque,
which is a bit awkward as vhost_user defines ops_opaque when registering
the callback.  That's certainly not impossible to do, but this way felt cle=
aner.
For now, I will add a comment explaining that the callback should not be us=
ed
to add elements to the underlying vq's used ring.

