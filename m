Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBF45C5AD7B
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2026 18:35:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtUpe-00044H-Re; Mon, 10 Aug 2026 14:34:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <connorkite@gmail.com>)
 id 1wtUpd-00043R-GW
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 14:34:41 -0400
Received: from mail-qt1-x831.google.com ([2607:f8b0:4864:20::831])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <connorkite@gmail.com>)
 id 1wtUpc-0006Ya-6j
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 14:34:41 -0400
Received: by mail-qt1-x831.google.com with SMTP id
 d75a77b69052e-527e352a167so13596071cf.1
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2026 11:34:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786386879; cv=none;
 d=google.com; s=arc-20260327;
 b=YXg+6/T13np4bAbj9vSk+TIaABu7PjKMTjBuBWDxBKP3yqGF5p6C11go2X3+/JDgpK
 PD5J0/FCkFOqlT+rDyo0z6QnHKtGm09DNyWC84ulYOOPpfNG3aS+EMu6MftpwkgX8O5P
 Nlhl4FhGwN5CIWGUT+Z5FAogbNZvEnXIu93oooURpI/tVKiRjRNesj9fMc8TOYICpVny
 hOkv0cO3VnfwCKZkBrr1Bh6SHpo8wcuIASMlfACNf7q4UjLvRdaZm6FyWTquigOnFdEj
 wtlO9ASG9nkvizRQ8xnZBB0CWgDEiVxyHg85pQ+X0eH4sCOrDoBPgrNREJzfXVJ/PEWj
 QLWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Hr6cihbYkqx29IWLF/1foWVc+mP+Em1bjQNfhGxCpaY=;
 fh=KDk387A1+PRrP73gRLCRtBl8PbehjOWW2KJG+BrFQO4=;
 b=hIbwYJxJozHaEiVd2fbZ2ggj9FLSZ6JO43UX7tmZMDoyHJXo7wk5gKCJy23rgp3FUK
 Hnr6b/qx21TNNmiHROIRdnFTg7Wo7xeFkUfIsfz499Z+3XaByB5ygueaCm+1afHjpo+/
 7Ai90xE7pcyeeyqD/lxg5Oiy5My5fudlaV6gp60d6rSu5Udnezm8ilZZiXz5Kadwdnlc
 B5nzPa5INwlt0FJcvRF2kfc6i1wAoQXHq+qJRSrOPj9TApyWx3qYDUa6gKdMFXEsCxNX
 um0OMC9G7BefsJrFMK9WBk0KgsxBORvwrHAokJV5IvD/Sfo1kfx2EX7656gBnX/eiT9P
 zSyg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786386879; x=1786991679; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Hr6cihbYkqx29IWLF/1foWVc+mP+Em1bjQNfhGxCpaY=;
 b=Z5sn/xgRv0JPstXq4QelcvcQCSrXPO8dFlDVMiCoF5BElvpbte6nD9BEKmDjtv97rk
 CZhEOqvipwPwglYLd2i0KPeGEbZUpfX75XdmQwTTASaLGZKpe+Bu9f4GhexeCpOHyNVE
 7mgQ09a2aCDWlMKjBJbX6SV0O0Yncvieo6V8I7uoAP+1/8fg39b/7x654UalUrrnoZ2z
 MLASH1YyOqpwg9W9pDc4BAHQl/W4nAf2uuGJOxy7yQX0vbwLutiygkf2Aw8wjLg2M5kc
 ArjTi7SWycalS3kbnPZqiZg0VnZ5M7SSZBnsyVhdIvRikO+T2wZQWFwCMLToS746rwhh
 PEEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786386879; x=1786991679;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Hr6cihbYkqx29IWLF/1foWVc+mP+Em1bjQNfhGxCpaY=;
 b=peRQPS/Cit5jU0YxzSmq7M+ikEICJUDuB/zJZup8EBKo3VnqAgrZ+TAREjirYEv1+7
 FZjBt/NKAiI+4aRzmvx+o7///UxwLoFOXZvQYahHwswaLPU1Dwf0RsQwzTpVvKfCBn5X
 8JtRVEDl43dWgqsDYIhGDkVHieQePj/gruzWaPDYrqZDDP4Z/inYwvkZAtlSlMjgKCFR
 n+ENn79vfUw5HFEsqDO5xgX2bsaV5qippPhEMinQQzbSPu/aN0pWs5pJS6z/d5kjw4uk
 PHNY6VAINgFUpCIj+rzgJtDJVNi1zr4srI7+hyuUl3JUboDShedVmnuYH4X08IUejuqi
 HGag==
X-Gm-Message-State: AOJu0YyJ8vMyKdJE5bQp879qxBXXAKKozGk3dO7ECT/Ya+T+xwIQs1ZO
 W4s7uHFu3TbZgbdaSFuEmAobj1PcNaMmJi14kPbwP+Iqsv62qeoJmiXDTzrvWiVUYVKUtBrut97
 g+Lqh5rCaqx+/3rsnb0zfa/q3DSRx7CI=
X-Gm-Gg: AR+sD10Jl/zy07y03UjU+mVZLOaZaAFF/fu7YNWou7zWFwccjM556VOvUbFjdwmkO59
 6Mae6E/LROknxc7Ma7IAHmllEVNQ07zycYdeJCK5m520NEn7zR7dCaWt9otP3A2fXPaEOh0k1ud
 P4F7DnidvLfrVzapBA3FgDklBpdcE5hkY4Pm+PPrSvKGevgLDYXJzDuI7TbBO9W2rOTkb4n0yUz
 eq33sX58g8ihpjymlZNWpWf7Pp9YxIQ0d/Ez87pfvaR8fUA0Lrnkz2T5WrMuga7gIWB9JIP5eSE
 WwXwdlTHSmAvxUYKTmph5+O6poRF8D4COl3FA4MwaR+2mFhvYkk3CeZoD6fLdXpAksuCn+rRutI
 P/2c=
X-Received: by 2002:ac8:7f41:0:b0:519:ef86:127d with SMTP id
 d75a77b69052e-52d4bb91b9fmr43999341cf.18.1786386878572; Mon, 10 Aug 2026
 11:34:38 -0700 (PDT)
MIME-Version: 1.0
References: <20260723-vhost-user-isolated-memory-v1-0-6b97c439eb28@gmail.com>
 <20260723-vhost-user-isolated-memory-v1-12-6b97c439eb28@gmail.com>
 <20260728191620.GJ371693@fedora>
In-Reply-To: <20260728191620.GJ371693@fedora>
From: Connor Kite <connorkite@gmail.com>
Date: Mon, 10 Aug 2026 11:34:27 -0700
X-Gm-Features: AUfX_mx13giUuvX-hbDhUA3IfZr33kHhSI6mODwDcXgUvbs8e9uPSKvTAI5Wv70
Message-ID: <CA+spn3q+mgPhnHYmge7BOoZYrKnBQk-fjOx-woF4LsNPy_70Qw@mail.gmail.com>
Subject: Re: [PATCH RFC 12/15] hw/virtio/vhost-user: send isolation regions to
 device
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Raphael Norwitz <rnorwitz@nvidia.com>, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>, 
 Milan Zamazal <mzamazal@redhat.com>,
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::831;
 envelope-from=connorkite@gmail.com; helo=mail-qt1-x831.google.com
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

On Tue, Jul 28, 2026 at 12:16=E2=80=AFPM Stefan Hajnoczi <stefanha@redhat.c=
om> wrote:
>
> >
> > -__attribute__((unused))
> > +struct iova_tree_traversal_args {
>
> QEMU coding style:
>
>   typedef struct {
>       ...
>   } IOVATreeTraversalArgs;
>

...

Got it!  This is now fixed.

> > +    VhostUserMsg *msg;
> > +    struct vhost_user *u;
> > +    int *fds;
> > +    size_t *fd_num;
>
> This field is also used to index into msg->payload.memory.regions[], so
> "fd_num" is a misnomer. I suggest something like "region_idx" or just
> "idx".
>

I'll rename it to idx since it acts as an index to multiple arrays.

> > +};
> > +
> > +static gboolean vhost_user_iova_tree_traverse_funct(gpointer key,
> > +                                                    gpointer value,
> > +                                                    gpointer data)
> > +{
> > +    struct iova_tree_traversal_args *args =3D data;
> > +    struct vhost_memory_region msg_region;
> > +    VhostUserMemoryRegion region_buffer;
> > +    DMAMap *map =3D key;
> > +    args->fds[*args->fd_num] =3D args->u->iso_memory.iso_fd;
> > +
> > +    msg_region.guest_phys_addr =3D map->iova;
> > +    msg_region.memory_size =3D map->size + 1;
> > +    msg_region.userspace_addr =3D map->iova;
> > +    vhost_user_fill_msg_region_iso(&region_buffer, args->u, &msg_regio=
n);
> > +    args->msg->payload.memory.regions[*args->fd_num] =3D region_buffer=
;
>
> I'm confused by this code. VhostUserMemoryRegion region_buffer is the
> vhost-user protocol struct that is being filled in, but there is also a
> struct vhost_memory_region msg_region from the Linux kernel headers?
>
> msg_region and vhost_user_fill_msg_region_iso() make it harder to see
> what is going on. Can you open code the region_buffer struct field
> assignments instead?
>

I've consolidated this code significantly now.  Will delete
vhost_user_fill_msg_region_iso as it's logic has been incorporated in
the traversal callback.

