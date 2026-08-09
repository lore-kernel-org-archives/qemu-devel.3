Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 925C5C5AC67
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Aug 2026 01:13:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wss5w-00077X-PN; Sat, 08 Aug 2026 21:12:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <connorkite@gmail.com>)
 id 1wss5p-00076g-6Y
 for qemu-devel@nongnu.org; Sat, 08 Aug 2026 21:12:49 -0400
Received: from mail-qv1-xf29.google.com ([2607:f8b0:4864:20::f29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <connorkite@gmail.com>)
 id 1wss5n-0007t1-1J
 for qemu-devel@nongnu.org; Sat, 08 Aug 2026 21:12:48 -0400
Received: by mail-qv1-xf29.google.com with SMTP id
 6a1803df08f44-8ef1dc934d1so6029936d6.0
 for <qemu-devel@nongnu.org>; Sat, 08 Aug 2026 18:12:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786237966; cv=none;
 d=google.com; s=arc-20260327;
 b=rkuIiv+wb99ZgTNXtX2no6lIazLzdFzXpqgRocoPtQgIxxk3jpxQhEtqpkvSobHzV/
 Q9lV67iZLfDrc5QH5HQQ5z2Sd2rqTDFNAbfkBDMsKOyb1LBzOi683AA1G4tOD5lGW7fC
 qXPVjfUD1n0V/TbPU7H+Vm5SKPd6qdsn/VWLX/uxMLh1N5AkFxvv7Dk4XAeXhMAdJ1H9
 5X39vlHxuoDUyE5c1U0KdAuBkKDek4ZaQdOk4Kp+lSCmtiiewKMBxLfW6En2uh2dEhhh
 9CchQncMvdVIPT7Bdltw01zxKdYK/eCqFYBe0ueKJfsugY1uWLY96oiRstuuFL9eS/O/
 pkeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=oeosGuK36+CiGElvgIGQyKSZr37C83sK8Cdq9TcGXmE=;
 fh=KDk387A1+PRrP73gRLCRtBl8PbehjOWW2KJG+BrFQO4=;
 b=GDSC5AE7UF0YscdRj8C1qWBZHUUpcTZDv2+HfeuJlTS6yDu+OF6U4Vfxm8DBcyFPaA
 ZXJF2rTcTyPVnweMHAcUJ8FLyVD6tBeVyVsOujRlnh2aacoT2AqWhDaEHVPDUuELUWiD
 cmJpsTShy1SN9azZtDaYpFHPc2j4kb/OfGjM7QK6SIl11P9Nls+Q2VvpgZNzUYZcWDhY
 VffOUxGPcPKn8SbLEAakCYe2kQM0jDzaUFL8i60wV897ItISXqLYYCrWG/Xx9XGtAncG
 xZgMKJcZGSJtbpepROmUnIC4LqCxtsoxrYGI/Ayotjir+kmDiWsbqQj9p8xyll9I0GxD
 Dthw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786237966; x=1786842766; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=oeosGuK36+CiGElvgIGQyKSZr37C83sK8Cdq9TcGXmE=;
 b=QyhqI0kOZZxIE7DrQVRSm4qHCGyrIj53IUd3ecyQdwrUDnwsjXW6ymixrBSIKPMzVM
 cVPJ1fb4OZ1gPYw9Dz20nN8abu0t3y9xGWzcU9iGD9n88kDSK1bH3qPoUf1IriUiZPW7
 KAlBRj1rzrT0mjvvZITqcmpuohH6OBX92rAOKqIErSxEvQqxmOEgxm8Cx7SneCKUqHHy
 F2MEoITan+xMPfSEopG+ESAalviNeD3eT7KNntRN40vQdbpDLxtbC+W/EvdgiJJBDKGo
 naTkdr1V7p1VV3qV3u2XyxBMPeDjKEkDawTs1e4KVOfEdUBcYkGw1C1grGRL0gS32OK+
 f2GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786237966; x=1786842766;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=oeosGuK36+CiGElvgIGQyKSZr37C83sK8Cdq9TcGXmE=;
 b=CZpecvOxYK1oRZt0O/zK+krGK8QH77gZQSKoSrSqwPgn8oDk3zQ9G6onxxN46sRj1d
 JNKsKbj5MhccfEdxRXelDee8+c7xnDIjszUFBYoNIzhqDoGbqif6HaYhtfikASV+kRoa
 MvL4Sm5BK4502u7bv11dTE8Q8MyNI2agaLVUWsmdfM75PdxjQrZLADuaE19E/HqEHdEb
 RVDktXOb4A4KYUWWiOmhvgk782a+G6WIbJWJJ6i9dRhcc4olK0PigqzF84HxUF7Nhyp5
 JQf+KgVRRYNMiiYj0Q7G6JH1cNHm3Zr6ifICmgIbElh5A+72S2+qWG6xpendOl4lUsui
 JXGA==
X-Gm-Message-State: AOJu0Yw1x6dWk4gWMNS5EpzAf3U/Xs3j6sP/2YEJ4LZirth3mm18KsIW
 zxMxQ51ZJoSlwFBsjQgK+iLOgSMwsQtsvFWrAojcinQvfxn+LU0OAE+MbsPxMBli30NaexVqO5F
 T0NlbHh/NMqJGdPwk+OYcRJ21yUPtf44=
X-Gm-Gg: AR+sD12IguaCXV4Lu39dy6x7h5OC/9oieDWwe8U6KHCJEMoWJQSxKrT1XF1B538pnzZ
 e3ruRpm9egidRFIbzQ3P/K/Q2FUBvZgrg64uuWYz/hEeeBAc5YajPXlge6Il2DA/Ug3ltii66q+
 U0oKCbenVfO6yrvjE0ZtabclXjAA2GoM5TlWDeUycx2YYrQ21x2/posrOwpk36Eby8b51MjnmOp
 AZzskY2HXf52ui2Sg4X9IyjT5fP/yUHEjB2JSlwnVMgMFuNjYzNAEDFkRM1NuiR71EaPNQcD1PH
 jpwcswjbNifi6lE1YyuTQkJSfYUtYWZqNKykzbdEu8OcuA8yY4FYZmvvBekquV6EyJT9JOjUKEl
 5odO2N0EapPVMTA==
X-Received: by 2002:a05:6214:cc2:b0:8ee:756a:bc32 with SMTP id
 6a1803df08f44-90a368a626emr96602356d6.15.1786237965759; Sat, 08 Aug 2026
 18:12:45 -0700 (PDT)
MIME-Version: 1.0
References: <20260723-vhost-user-isolated-memory-v1-0-6b97c439eb28@gmail.com>
 <20260723-vhost-user-isolated-memory-v1-11-6b97c439eb28@gmail.com>
 <20260728175931.GI371693@fedora>
 <CA+spn3qkZ-2=4q2nn_6-wp85U4Xv3oaDAmCHEP_yB=N4aZSceg@mail.gmail.com>
 <20260804181659.GB488200@fedora>
In-Reply-To: <20260804181659.GB488200@fedora>
From: Connor Kite <connorkite@gmail.com>
Date: Sat, 8 Aug 2026 18:12:34 -0700
X-Gm-Features: AUfX_myvKgdgkcyJlFGjsDxh9x8pv4UyzdubzO67GxszwLXORfVMql0EMYJiR1o
Message-ID: <CA+spn3rkBeV87Umb81cJyf6oMg7E=Z3SmOHvrqgm-nQC6yrvJA@mail.gmail.com>
Subject: Re: [PATCH RFC 11/15] hw/virtio/vhost-user: create isolation region
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::f29;
 envelope-from=connorkite@gmail.com; helo=mail-qv1-xf29.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, Aug 4, 2026 at 11:17=E2=80=AFAM Stefan Hajnoczi <stefanha@redhat.co=
m> wrote:
>
> On Mon, Aug 03, 2026 at 11:26:29AM -0700, Connor Kite wrote:
> > On Tue, Jul 28, 2026 at 10:59=E2=80=AFAM Stefan Hajnoczi <stefanha@redh=
at.com> wrote:
> > > >
> > > > +typedef struct IsolationRegion {
> > > > +    uint64_t base_addr;
> > > > +    uint64_t vring_base_addr;
> > > > +    uint64_t size;
> > > > +    int iso_fd;
> > > > +} IsolationRegion;
> > >
> > > The purpose of the base_addr and vring_base_addr fields is not obviou=
s.
> > > I suggest adjusting the types, names, and adding comments to make the
> > > purpose clearer:
> > >
> > >   typedef struct {
> > >       void *mem;           /* mapped shared memory */
> > >       size_t size;
> > >       uint64_t vring_iova;
> > >       int fd;              /* shared memory fd */
> > >   } IsolationRegion;
> > >
> >
> > Agreed on adding clarification.  Is there a reason to change from uint6=
4_t
> > to void * for referencing the shared memory region address?  Most uses =
of
> > that variable expect uint64_t currently.  Here's what I am currently th=
inking:
>
> The shared memory region address is a C pointer where the shared memory
> is mmapped and the type for an arbitrary C pointer is void *. The casts
> needed around qemu_memfd_alloc() and qemu_memfd_free() suggest that
> uint64_t is not the natural type for this.
>
> Keeping this as a C pointer helps differentiate the address from an
> IOVA, making the code clearer.
>
> Also, with the comments about base_addr below addressed, the
> hwaddr/uint64_t uses will be reduced.

Got it!  I will change here and plan to default to void * when representing=
 host
addresses going forward.

