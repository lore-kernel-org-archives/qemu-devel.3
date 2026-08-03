Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2E80C55196
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2026 19:33:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wqyOX-0007Mq-1I; Mon, 03 Aug 2026 15:32:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <connorkite@gmail.com>)
 id 1wqyO8-0007LY-Rf
 for qemu-devel@nongnu.org; Mon, 03 Aug 2026 15:31:59 -0400
Received: from mail-qt1-x834.google.com ([2607:f8b0:4864:20::834])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <connorkite@gmail.com>)
 id 1wqyO4-00043M-Md
 for qemu-devel@nongnu.org; Mon, 03 Aug 2026 15:31:51 -0400
Received: by mail-qt1-x834.google.com with SMTP id
 d75a77b69052e-527e352a167so24122221cf.1
 for <qemu-devel@nongnu.org>; Mon, 03 Aug 2026 12:31:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785785507; cv=none;
 d=google.com; s=arc-20260327;
 b=cKnYgpbfuDZeiJL2ZR7MCdPxIo9gWcab6JUrC2Izo5KLmgLurMz02dFIo23hm4I2jc
 cjCBtr4K4J4Rp3U8aIiHUsj2VugQqc4Vwonq8wIoUv5NFTNmtxnp9u4ahqHCnmIMUmUB
 CeUyLoou1QksPSG/FK9d7CTQ583meDq2nnLgIErzrysoNeIXhhY3KK7Xc8oFhrq9D74A
 KZqf4r8VvEnq5sFLmRKtulePtmjm/sEMxARvn0m76ahJ6VFNwOuP2LBbnc1j4fRGLaZC
 VHs6Z1k+SW2k8gaePKGG3IICRkbzqe63duTXXNjiwuSy3rYkOCz6o/iKQhmeIGNYzw22
 hQzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=reTpUjcJUOBcUsyKejOdhRFAmR5n8lMWUzjI4+Z01tU=;
 fh=azakwI4Xb9f6DnAcztET+ugSHXzSSw4voANLU4fk32Q=;
 b=WlLen0zrIvvL5NjlnGm4NyZvwJHbLfvqg+OY59F5GoQE3weitp1JGYphOZRT6LjMQQ
 4R98E6w8FoiluAh6b8VJX2fF4a9mNcX9UcS/ktwuwFc0aNXXU4YWiCN9yIdZJIIGwV/g
 1hPlAssl/tbq/DhNs+Ge6TpWQDAjwTEqm7uZI3hpq9X7PVpG1Ipvmx5rAJQ6bRuJf9UR
 61OdSN/uuOmW+hqof8AiQMspIMkOUviKTva56TxyAwDLk0BvEX6Z+2uMLUlYid5hPIFX
 Ewt/VOnAZfe48TW02/ZzlLAzRYWQv9/Kv5VXWcuK4hBbGlq4fzEVIZtWubxPc3QlPYk2
 aNuQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785785507; x=1786390307; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=reTpUjcJUOBcUsyKejOdhRFAmR5n8lMWUzjI4+Z01tU=;
 b=E4veXAWq5wHV6Ecgr+xi/h6DllOxHix5Yihv3orhwOOQm19a9JWlqVVe0kymsTdAP0
 7nCI6ONKRR4JFeJwffxcWT1M89TJlI95H8bdQonUSNK/eJWmCgBqpj44KAaPhugfjpFl
 ed3w+HBts6LWkNqaG54IFi5F1N5BXyUgbJVhraGLF17XVRTzrjv40HYOzGexqSqiYJ1w
 2DiZKjdpM0TMNpTKHP6b+lE5ob7iNSFZI2Bv7N/V3gedSNYxw8iKyCRjAMvXwmBo1DwQ
 DhQpJ457gV4FHWPKpnXqUxmzKpsMdiIXhb5yd58RlGvZVr4BSqfwAvO5qNSJh1OnERok
 JJ2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785785507; x=1786390307;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=reTpUjcJUOBcUsyKejOdhRFAmR5n8lMWUzjI4+Z01tU=;
 b=m+gAagXrXcctFFAOXJbPddjjfQ1pWsVLBJ7RAELq6drSGsGbbskWPialGhd2+7WOFO
 Aa9ZZ70ldwEfL0a66aXcyIGy8r1VNY7wqXAdz8A8w11aIVxbe25CJzMNV7MbXAciFLdP
 9eHlS8J2a+TNV+UEv85H6n/o8M8bu8uIIy2kjL9xRFedR/gkr074IBjtZzNK1RaBAYie
 2BXQiLi13bUSuoxxr2fEWNsJuPpf0Crdsg6iJ4eMeuiPq4eKP5ln+wDYBZlubZZ7dhbF
 VGrhM8F59T9++V+vPxvWqeKuq8Rz+ETcu75jIkEOAQvS1L88Kecqw0oWlnvt2VSjh9nW
 PZKg==
X-Gm-Message-State: AOJu0YzVtfW+qgpI8bwd6MHS7Qc0IdH9kDHeDNgiiMcMRkHla036akDw
 aq/G9zKW4nxk9xJ3eLVH9Ot/ugTWUQbFRTs/DGgV0ABdSFBKTb0SDmoNeHgqhRdBv0pK10xhpjC
 JWmg6boPRICGUl9ojM5Ctjrgo4aAOhcI=
X-Gm-Gg: AR+sD10FisnVjipQR4/SXqPfxlWzqmzHnX0Zz2Sr3WwBZNuIcShfQGcK55X8gSKk9SE
 kwVC2Iow9KeAk4AMAFVPb6xOChyBo/4awyHtmBeZ1PwKcxyT2rIhiGFFWm9iq3a16JcHCz0OWbP
 vyj2O+t+lH0RCa6yLE2JDgBg2jre2h314fIfJzcs5LGK1Vcq6f+tAOtzSoTrh0OqCS7Sydmgc03
 f5YukwcDHES95GmUtMQtEdk+js688U73AMA4IDt0gvpGS0kKH0kKWOfAxFrSn0XWrlg9lMX918x
 o1chGZx1F5aYFZno7OpssyxdfoyDtVtTQEwP23mYzqSqW3wgjEyUjhXErvE5iZXOWLwz7AvwOHQ
 y
X-Received: by 2002:ac8:5ad5:0:b0:51c:2554:a8f5 with SMTP id
 d75a77b69052e-52b56813005mr228935771cf.36.1785785506969; Mon, 03 Aug 2026
 12:31:46 -0700 (PDT)
MIME-Version: 1.0
References: <20260723-vhost-user-isolated-memory-v1-0-6b97c439eb28@gmail.com>
 <20260723-vhost-user-isolated-memory-v1-11-6b97c439eb28@gmail.com>
 <b6bc052c-1bf5-449b-85d0-e1c4624a5d99@redhat.com>
In-Reply-To: <b6bc052c-1bf5-449b-85d0-e1c4624a5d99@redhat.com>
From: Connor Kite <connorkite@gmail.com>
Date: Mon, 3 Aug 2026 12:31:35 -0700
X-Gm-Features: AUfX_mwStaeATOZ2UGNu4P-9Q3C3gPXR9qo0n3vpFD4fsPxrpxYjrIQqimituZo
Message-ID: <CA+spn3r9X4WST1c4LYS63xN0EFogkD1dJ6P4omk7ndMDeF9D5Q@mail.gmail.com>
Subject: Re: [PATCH RFC 11/15] hw/virtio/vhost-user: create isolation region
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Haixu Cui <quic_haixcui@quicinc.com>, 
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::834;
 envelope-from=connorkite@gmail.com; helo=mail-qt1-x834.google.com
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

On Mon, Aug 3, 2026 at 6:25=E2=80=AFAM Hanna Czenczek <hreitz@redhat.com> w=
rote:
>
> > +typedef struct IsolationRegion {
> > +    uint64_t base_addr;
> > +    uint64_t vring_base_addr;
> > +    uint64_t size;
> > +    int iso_fd;
> > +} IsolationRegion;
> > +
> Going beyond Stefan, I would say please document each field with a
> proper doc comment, and ideally the whole struct, too.
>

Roger.  I will comment all fields, except for perhaps size, which seems
self-explanatory.

...

> In general: Please put spaces after the leading /* and before the
> trailing */.
>

Roger!  I believe I have this in a few places and will correct.

...

>
> Patch 13 adds more variables to this, so I think it may make sense to
> have a dedicated struct for these fields.
>

I agree that some of these make sense to be consolidated. However,
I think I will keep the svq array outside of the struct as the svqs don't l=
ive
inside of the isolation region.

I guess the alternative would be to have an `isolation_mode_ctx`
type of struct to hold all of the above.

>
> As Akihiko said, the memset() should come after this, and also...
>
> > +        u->iso_memory.base_addr =3D 0;
>
> ...this is just a subset of the memset().
>

Yes, the cleanup was not fully baked ahead of the RFC post.
This is currently fixed on my end and will make it into the next
rev.

...

> > +    int num;
> > +    size_t desc_size;
> > +    size_t avail_size;
> > +    size_t driver_area_size;
> > +    size_t device_area_size;
> > +    size_t total_vring_size =3D 0;
> > +    size_t total_mmap_size;
>
> Please do not mix variable declarations and normal code (style.rst calls
> it =E2=80=9CMixed declarations=E2=80=9D).
>

Got it!  This will be fixed.

> > +
> > +    /* Get space required for all vrings */
> > +    for (int j =3D 0; j < dev->nvqs; j++) {
>
> Why j here and i above and below?
>

Most likely this was inside another loop on the initial implementation, and=
 the
iteration variable name was not changed when the outer loop was removed.
I will change this for next rev.

...

> > +
> > +    uint64_t last_addr =3D int128_get64(int128_add(u->iso_memory.base_=
addr,
> > +                                                 total_mmap_size - 1))=
;
>
> I would like a comment why you went for a 128-bit operation here. I
> assume it is because it checks for overflow, turning overflow into an
> assertion failure, and it can be assumed `qemu_memfd_alloc()` must
> naturally return a pointer such that adding the length of the allocated
> area to it (minus one) will never overflow?
>
> The question is, do we even need to check for overflow then. Not that I
> mind it, in principle, I just find it non-obvious. (The more obvious
> check (imho) would be to just do a 64-bit operation and then
> assert(last_addr >=3D u->iso_memory.base_addr).)
>

At the time I was concerned about potential overflow prior to application o=
f
the -1 operand in case the last memory location was at 0xFFFFFFFFFFFFFFFF.
However, in that case, the -1 would cause the value to wrap back around bef=
ore
any use of the value, so my concern was not needed.

There is a similar 128-bit op in the existing code in
vhost-shadow-virtqueue.c at
line 133.  To my eye, that might also be a good candidate for
simplification unless
I'm missing some other aspect of the use case.

...

> > +        map =3D &g_array_index(buffer_regions, DMAMap, i);
>
> God, I *really*, *really* hate this, and find it really disgusting that
> the documentation actually recommends doing this (`&g_array_index()`)
> instead of just offering a separate macro to get a reference.
>
> And existing qemu code does it all over the place, too.
>
> So I cannot really fault you for it.
>
> Still. Too ugly for me to keep completely silent about it.
>
> </rant>
>
> Hanna
>

Would you typically avoid using g_array / g_array_index?

Best,
Connor

