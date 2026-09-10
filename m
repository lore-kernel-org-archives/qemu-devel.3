Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC9C2C79FB9
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 11:19:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4coU-0007D9-UK; Thu, 10 Sep 2026 07:19:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x4coS-0007CJ-IO
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 07:19:28 -0400
Received: from mail-yx2-x10.google.com ([2607:f8b0:4864:41::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x4coQ-0002ZZ-NW
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 07:19:28 -0400
Received: by mail-yx2-x10.google.com with SMTP id
 00721157ae682-85e68bdbcc1so10988167b3.2
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 04:19:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789039165; cv=none;
 d=google.com; s=arc-20260327;
 b=Rfo0Py7muigljHsCz8k1p02vdSbZ37Il3sIKvjnXnRmWOIbtCoKFSUYngJjMZ8jxNJ
 UzSLpYh7Z7ndTATwsIKipWbK4Yoonn8XxPAVsp1FmwpYuzeoFbixhuzifbDQ/vYBakXM
 TP3ictFOEHWKNiNJEerxVTARWm3+6jx48fQE3s3cZi098BFOx7oFUVK/kYJj+2Esvyg/
 ZrvDJKvvFTVy+2oiSdQ04ZH1GKoOJS5ci02t2Fghsn+5+z1z5JeipNKmXmvTDyIeCs/Z
 ZIjcWuKt9rq/0jsD/S9y58Bcjds7lXXS/yfF9EtjWcx2PIK6zMjfdSS22+fDL2jyr/+D
 K66Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=VSE6JoxsiukI+cHTJpgHApqZpmQT3W28PBGgShKCRkM=;
 fh=PFYX6U2FHRZr1gfgcCQLKcBI9fIgRHJN7OKNLlsWtbg=;
 b=BbUWeRSze7dxYXsZOLU8QGDEECibMp+hecVul8xwuF6TP7e2DR1aYx0Q3U0BY2vzFH
 wrBa+60I60qo1+NIeDQ1p7IxF9og7tmqYtn/OhdJ0Vps4TqSijnpM5bCttNmzhgE/VJ7
 mHSfbIy9jiFeMBNF28Tua79XNPObyOkZ6NKKW/AeCBu5iFUm+OyLVMmjRPltL2ut/XFT
 yjoRi2wttsqceOeGZDzt7Gd797P/TaqxteEw6fANFuIdFVZZEYZlQdV+k6V7FYGQr7HM
 dmOYp6JcoCf+0kVzaDE8oSspyZW7cFAh3Q12d1hZwwUtRy3uFll1F1khhdjGNoC6jYnM
 7VUQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789039165; x=1789643965; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=VSE6JoxsiukI+cHTJpgHApqZpmQT3W28PBGgShKCRkM=;
 b=AlGVLPnVbicBytZS0nNAKYHcQfLak5jlQx7esBgi0+ENuHqddfxSq/CUZyIUyQx4YI
 96OMYPM1Z+6J4n2GEzjSujz6aEmeqC/aVCzCfFTmyNiNMqyWzb0l/j04T1q/kGPYEp7A
 vLfTCMQ16ksDkVvaEGWqTvCRGcRiHvUK3I7+m8ayEdGUSd9tdYuNxH4+cKxzO4kXyGe5
 hj0U7K4sGm5Wnx9PjchVW9RB1TJJMXtmf5q7UeFTMOJMD5BoTdiYR9Cz/ibeVPsWBKyJ
 WKiMO0VhSEmewuwWtHWtElcXteaCoXNR8aVvYHlponbLEqPZ9p7o4RuD3JhcqYDK8kOT
 jlbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789039165; x=1789643965;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=VSE6JoxsiukI+cHTJpgHApqZpmQT3W28PBGgShKCRkM=;
 b=hVzegSKN8r0QT3YJ94Ep0AdVkk6mJ7I90BkI4K0N/xAv7Nequw1yOF29BaqO6alIsi
 xLEbkDgjJb6lKwNKqWcpPP+X1iBgz96B1kKf2HTXXS7KO/riTC9L5WnoSLJBIg2YO5A+
 CnWFjIZkEBJkbF66HPk1hlVKilVN4St8FIq8k86Sho+ZJnzdXHTE3gNh+7mmzt0q7FXH
 PMWXl5+W0n0/4YgVdDO83OPj1KmnnnVbUG/oN8vklKUL0NZvcFG22vZbDk1WxTO7cAqH
 rFKoGq5M+AGbganiWjFogAlQ2MftcjgPR82Hhec+VAeuu7rU9NGlPNY7CkT4pP4DNzBC
 oPGw==
X-Gm-Message-State: AFuF++mrGqD0ym3+NJiQmQbwxfWpPLMWOULHufAzfdBtK5Dv6wSwZZYi
 GV0YofHdPDzy304bZRFt7Du2LmkTX6DKfyTlH5QvzN+5Sk6PwVBqrJ4+7w8tvdAZvJRl6HOD9lo
 d5uo/KfjKHT3B479tCcjUjnQz5OiRbtKu9r+Z9phEgA==
X-Gm-Gg: AYBFou0tVpe621Ttc9oayiGMYP6E0MqSM14vMOympC8uMR6IlNKk/WRDrfVDkkQC9uz
 P99WYg4Gw3tVfj/uW6OgaCfzTg1YC/IsMPupcwA0+PnjuCaJRyqlCqiu2VBrTZT6Wdo9udDHOs8
 M9EntV64c2JgEjBpPUjApcADjKCJA2+JtTCujeIMQzBm1oAPL6beEKOWVmwj531jqHnIAwwiulo
 eJY+jRELldGWtdNiDEjNmzY2rP9ICbD8IQ/aam2tY1DaxuFWuMo3WS7T3jJunchIuirUkAovdCr
 Pr8yAyr8rxJhNCD4z9fUk9ulIY71o9cFUoUqVCDjk24jTgFUkf92rigrvUVxYJ5spsKBIXSIO6Y
 D6VhEKIl4xjkO2kw2ZWi7yAqmG0DeiZWkWtUNa3A=
X-Received: by 2002:a05:690c:c505:b0:871:bc3:9844 with SMTP id
 00721157ae682-88153e67badmr28287907b3.7.1789039160284; Thu, 10 Sep 2026
 04:19:20 -0700 (PDT)
MIME-Version: 1.0
References: <20260825-fixes-v1-0-c59e8a620836@redhat.com>
 <20260825-fixes-v1-5-c59e8a620836@redhat.com>
 <CAFEAcA-e1N+f2G+ah3=9OXD9oM85ZEzUD3-DuRyrRg8KoU3ZDw@mail.gmail.com>
 <CAJ+F1CLTQTvDty9i4H2YGU6pV91cO9EAVGJNxADEL3WvEyR0OA@mail.gmail.com>
In-Reply-To: <CAJ+F1CLTQTvDty9i4H2YGU6pV91cO9EAVGJNxADEL3WvEyR0OA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 10 Sep 2026 12:19:08 +0100
X-Gm-Features: AcwNN1VspN3nBJ-4ntmXjdCWfXcZBYhPnwg4k2huMy7FX4JkevjFDOQYmVVrgJA
Message-ID: <CAFEAcA9P+hBOKq1nziOsD-19oQzfkCYBsbcrkuDeRJJEU0w0Ug@mail.gmail.com>
Subject: Re: [GIT PULL 05/19] virtio-gpu: use g_try_malloc to avoid
 guest-triggered abort
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org, 
 "Michael S. Tsirkin" <mst@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:41::10;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx2-x10.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Thu, 3 Sept 2026 at 21:53, Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
>
> Hi
>
> On Thu, Sep 3, 2026 at 11:39=E2=80=AFPM Peter Maydell <peter.maydell@lina=
ro.org> wrote:
> >
> > On Tue, 25 Aug 2026 at 12:29, Marc-Andr=C3=A9 Lureau
> > <marcandre.lureau@redhat.com> wrote:
> > >
> > > Use g_try_malloc/g_try_new0 for guest-controlled allocation, so failu=
re
> > > returns an error to the guest rather than crashing the host (glib
> > > behaviour).
> > >
> > > Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3898
> > > Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> > > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > > Message-ID: <20260805130141.211398-1-marcandre.lureau@redhat.com>
> >
> > Hi; Coverity has some notes about this commit (CID 1685636,
> > 1685637, 1685638):
> >
> > > @@ -498,17 +498,22 @@ vg_create_mapping_iov(VuGpu *g,
> > >      }
> > >
> > >      esize =3D sizeof(*ents) * ab->nr_entries;
> > > -    ents =3D g_malloc(esize);
> > > +    ents =3D g_try_malloc(esize);
> > > +    if (!ents && esize) {
> > > +        return -1;
> > > +    }
> >
> > This means that if esize =3D=3D 0 we will continue even though
> > ents is NULL.
> >
> > >      s =3D iov_to_buf(cmd->elem.out_sg, cmd->elem.out_num,
> > >                     sizeof(*ab), ents, esize);
> >
> > Coverity complains because it thinks iov_to_buf() might
> > try to dereference a NULL ent. I think that's wrong (a
> > zero size makes iov_to_buf() never touch the buffer), but
> > it does raise the question -- do we really want to be
> > continuing ahead here with a zero size and NULL buffer pointer,
> > rather than handling zero sizes with some kind of early return?
> >
> > I think it's preferable to have the "allocation failure"
> > check be a plain "if (!ptr) { leave early }", because then
> > static analysis tools don't go down blind alleys assuming
> > that execution can run through all kinds of paths in the rest
> > of the function with a NULL pointer.
> >
> > This specific check is what is triggering CID 1685638.
>
> The previous code was accepting 0/NULL.. I agree it is questionable.
>
> There is nothing in vg_resource_attach_backing() that prevents 0/NULL.
> So unless we have a clear indication that this is invalid, I would
> rather not change it.
>
> I think we can silence those warnings for now, unless we have more
> evidence or clear argument. I am happy to fix it otherwise.

Nobody has come in to say anything eles here, so I've marked
the Coverity issues as false positives. I do think it would
be nicer to avoid the 0/NULL problem, but I don't feel strongly
enough about it to actually write patches myself :-)

-- PMM

