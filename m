Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A032C5CFC1
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2026 23:07:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvNSn-0001xo-PL; Sat, 15 Aug 2026 19:06:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <connorkite@gmail.com>)
 id 1wvNSm-0001xY-SH
 for qemu-devel@nongnu.org; Sat, 15 Aug 2026 19:06:52 -0400
Received: from mail-qt1-x829.google.com ([2607:f8b0:4864:20::829])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <connorkite@gmail.com>)
 id 1wvNSl-0006Ee-1G
 for qemu-devel@nongnu.org; Sat, 15 Aug 2026 19:06:52 -0400
Received: by mail-qt1-x829.google.com with SMTP id
 d75a77b69052e-51c149c5722so14668611cf.0
 for <qemu-devel@nongnu.org>; Sat, 15 Aug 2026 16:06:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786835209; cv=none;
 d=google.com; s=arc-20260327;
 b=OGcrH3pikcDqTvnh0B8eqXXHnoqjfyGDefV6gTgfjAWywO/GV48wKiR1TnODIOCwiV
 j7TrRxUMY2yMkNVQxN/oLTDU/H+L57TW6pm9x6HTQAYiF2tt2Cfvh3suwuNHd/CsjKLQ
 b1yslq9eh/3I1pLH8vRyIV2MbUzikF0APxAwiTKpE6M/UU392h3NGYUap0xytRLMe0JZ
 veryqcCdzqykbjmZ13yhI43pPjzPqrsV1yPPoO4mOM9dj0jvJvJ+eRpi0K8FVsnMU5G5
 fgys4HVMcnol+dXmHfl9xh811GrgYjLTn72pqFgqCaHzcJXkaaa6zUm4nqRHpcmiuwy5
 aJuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ACamN608LlVcQYgc7KvwUxPHxL2uAxs3qXDqYIboXB4=;
 fh=xsRg86ZwBm0LGRQZIEC1R+b8QTOodxCX7/oSmDWEnOY=;
 b=Gk58P4jfJ3bm7gVux93V0DD8t9rH9d07ufacIwH4NKpJaBnuh101FQCWkJbrCJH5RI
 mLGNeRyeJ6tOUGR1muMFSIj3j0jbGhU2Nq+hp8vsooxuq5K0LKdAGMMkXpaB8qHZnfTq
 OwLhhNaW5W8p0hDf1ky++ZH61os3VJJRAp2/tX3r5Z3PCbbQJx2YuDjwS+bvb/V1BMw6
 F0VGWlkvB1Q236F4FWzv3pT05H/08367E4X7HBKou5jAmWHcsIhjBTamArCuHVOqTi8g
 lrvEHF9t92TzDVMFsYz6xxvUySLlpQDSwIRlnWRwDcnM5hPFYuBUkYRlwKcDadvgZGxC
 5j+A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786835209; x=1787440009; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ACamN608LlVcQYgc7KvwUxPHxL2uAxs3qXDqYIboXB4=;
 b=PQ6QfLnhuyiG8yjPMC3Gl3bGnkwkAq7oRPnhCFDJhhMl7BpXCeVp7OJRk3N1KBwFlB
 g27CBrcDXBxQnyfWNOklAqbJQGYVK/wXDAzBYybfB05bixcsvmkErxZFbPjn5jpMvRoW
 T83YJPrVBAs4GFxBazkRkT2TDXnQjsazK1kBXRuZvwGbF0MT+gaS3TiAWL2q0PoM5Y1j
 NKRz4dmufI5LauBDAfcI5ciKDwoIrvA9Mz1NiLfmp/LSj9SWnn/BGAy5mZVqUeMYLPqW
 8KQBi8zbbvPyenLnF3IXsM0LzilaE9IM2Wl9rg5zVAxeGLuTiFw5l4hFdG4UbFbHrHlG
 OeZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786835209; x=1787440009;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ACamN608LlVcQYgc7KvwUxPHxL2uAxs3qXDqYIboXB4=;
 b=Zd7m9Ko0GrkCuIpWeS5ZiB9BKnamd7czXrP5YrGf9xcd6Y1eqZQ0j6HYK2/r00zI0G
 I84I4nYFMq88f8oQ8xjWhaiZNskpMOKjoe8FC4fq+4J1XIbJnr0ThxumDbrIO8pnVkW3
 tGsDLCANtycDzj/RMIo+86VisQaNaAoUnqLbOEt7uYYaPCbBir9JSd54yp4NaeREq8YN
 PBnYYIU/NIHMcebIxXW79W0s9+n22j77zxNATvCtAeNmsuANsVNbUE6bH3boS9EokzgH
 DOfsUQ3ObYL9B3ZVr3j/un7I5JhmfkClp+6oCaxVvwjpLikKVKAhBfTjiElcMynKnNyb
 utrQ==
X-Gm-Message-State: AOJu0YxrtjxD+6YrJCF6ImJ24PUCrLG5KEA56x9uHCd8nz/Z8TIhzAEN
 4nCIbSbxex4MCXn4K1RXdPH3Ph4JtYTef6Ea/Spe0vVcA3srcHKGkD9KcIdTjhjw4bUqJhEEiSz
 wXFFjdhsTg7kYow0tEwXKJpTdEhRFcCc=
X-Gm-Gg: AR+sD13yE4/rAf2oBb9icEuKLIOQKDEbHUcfk3pgsx2tG2hu368eqiidRkcHfxpf8df
 z24oBTNV5BWIN+4IlOSuWJQs0Vu/DUC4pQJ5eY5xN6ZCDF2MkSVFAT3qlWsalsKlBpL60x2bA5A
 CvCHV6AIFqttcDKdns6RTrwGzxSqs0ek5LmBMAG+rc7ruQpv1u3p1M9q9GKRx1TibtGKZesZFTz
 8m8rH2K2XdjBpoNT4Knnqyp/Ie8Sin6IHFfpyVWkYyXouudM8FLZ9kTL9T7mCBMm08U7BkrWb4o
 ljH6Bd8OSMXVXNKE4zFVTTqRvkrdbDFwkJlxl/VqoLr/Qj/7RR0/12FYh94wZaS88k3pU45tkQ/
 xhZE=
X-Received: by 2002:a05:622a:5c08:b0:528:ce0:e9f8 with SMTP id
 d75a77b69052e-52d74a35420mr251080611cf.3.1786835209204; Sat, 15 Aug 2026
 16:06:49 -0700 (PDT)
MIME-Version: 1.0
References: <20260723-vhost-user-isolated-memory-v1-0-6b97c439eb28@gmail.com>
 <20260723-vhost-user-isolated-memory-v1-13-6b97c439eb28@gmail.com>
 <13594665-16ec-47e5-9075-f7bd5552b0a3@redhat.com>
 <CA+spn3r7+pEb7e6=8JixTpk7M3rNhWv=JkGZchj2-3FK9ZQGYQ@mail.gmail.com>
 <c549061c-8e9e-48a6-a149-2da743154c10@redhat.com>
In-Reply-To: <c549061c-8e9e-48a6-a149-2da743154c10@redhat.com>
From: Connor Kite <connorkite@gmail.com>
Date: Sat, 15 Aug 2026 16:06:37 -0700
X-Gm-Features: AUfX_mxgB49cuSbTwPK00Nmro3M7CZjdoHhWzzFGXSUGQymC0ePi45vIit5flQA
Message-ID: <CA+spn3rcK7c5xoCPP_t+M96UmZUWCaNDpNno-L6q9AoOoddw5w@mail.gmail.com>
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::829;
 envelope-from=connorkite@gmail.com; helo=mail-qt1-x829.google.com
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

On Tue, Aug 11, 2026 at 4:42=E2=80=AFAM Hanna Czenczek <hreitz@redhat.com> =
wrote:
>
> On 11.08.26 04:32, Connor Kite wrote:
> > On Mon, Aug 3, 2026 at 6:52=E2=80=AFAM Hanna Czenczek <hreitz@redhat.co=
m> wrote:
> >>> +    struct vhost_user *u =3D dev->opaque;
> >>> +    int svq_idx =3D file->index - dev->vq_index;
> >>> +    if (u->user->memory_isolation) {
> >>> +        VhostShadowVirtqueue *svq =3D g_ptr_array_index(u->shadow_vq=
s,
> >>> +                                                      svq_idx);
> >> Bounds checking via `vhost_user_get_vq_index()` would be nice. (Same b=
elow.)
> >>
> > Adding the bounds checking outside of the memory-isolation only code pa=
th, since
> > file->index wasn't being checked previously.
> >
> >>> +        if (svq->hdev_kick.initialized =3D=3D false) {
> >>> +            int r =3D event_notifier_init(&svq->hdev_kick, 0);
> >>> +            if (r) {
> >>> +                error_report("Failed to create kick event notifier")=
;
> >>> +                return r;
> >>> +            }
> >>> +        }
> >>> +
> >>> +        file->fd =3D event_notifier_get_fd(&svq->hdev_kick);
> >> What if `file->fd` was -1, i.e. `VHOST_FILE_UNBIND`? Should we put a
> >> real FD here then or just continue with -1?
> >>
> > Good point!  I think we need to propagate the -1 to the backend device,=
 and
> > run event_notifier_cleanup on the existing svq->hdev_kick.
> >
> > ...
> >
> >>> +
> >>> +        if (svq->hdev_call.initialized =3D=3D false) {
> >>> +            int r =3D event_notifier_init(&svq->hdev_call, 0);
> >> Do we need to check if the call event FD is already active?
> >>
> > Do you mean, do we need to call event_notifier_test_and_clear to see if=
 it's
> > been set and potentially run the call handler at this stage?
>
> Yes, that is what I=E2=80=99m wondering. `vhost_svq_set_svq_kick_fd()` ha=
s this
> comment:
>
>  > event_notifier_set_handler already checks for guest's notifications if
>  > they arrive at the new file descriptor in the switch, so there is no
>  > need to explicitly check for them.
>
> So it sounds like there is some mechanism that will ensure that when the
> kick FD is set on a shadow virtqueue, it is checked for activity
> (notification), and if it is active, this is=E2=80=A6 handled? Which I su=
ppose
> means the installed handler will be called.
>
> But it=E2=80=99s entirely possible I misunderstand something because the =
same
> code in `vhost_svq_set_svq_kick_fd()` also just calls
> `event_notifier_set(svq_kick)`, so=E2=80=A6 kinda always emulates a kick,=
 I assume?
>
> In any case, there seems to be worry about pending checking kicks from
> the guest in this switch, and so I wonder if the same needs to be done
> for the call FD.
>
> Hanna
>

I haven't noticed any difference from setting the notifier here, and
on further thought,
I think I know why.  I do not believe a call notifier FD is ever sent
to the back-end without
getting intercepted in vhost_user_set_vring_call, and once
svq->hdev_call is initialized,
it should never change unless the device is reset.  Since
svq->hdev_call is the only
notifier shared with the back-end, it should never miss notifications
from the device.

Connor

