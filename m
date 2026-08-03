Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C3D6C55182
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2026 18:27:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wqxNH-0008NP-6H; Mon, 03 Aug 2026 14:26:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <connorkite@gmail.com>)
 id 1wqxN8-0008Mm-Da
 for qemu-devel@nongnu.org; Mon, 03 Aug 2026 14:26:46 -0400
Received: from mail-qt1-x82e.google.com ([2607:f8b0:4864:20::82e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <connorkite@gmail.com>)
 id 1wqxN5-0004gA-3g
 for qemu-devel@nongnu.org; Mon, 03 Aug 2026 14:26:45 -0400
Received: by mail-qt1-x82e.google.com with SMTP id
 d75a77b69052e-51bfa429aa6so1366081cf.0
 for <qemu-devel@nongnu.org>; Mon, 03 Aug 2026 11:26:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785781602; cv=none;
 d=google.com; s=arc-20260327;
 b=Z9pS7XfYUk2FhoPM+7S0D5WCtD/aJVaPJZgmrCV3U/7pAP1HSPbOeWMKb0ck20mKrL
 /dM+ghAE67DP+wR6MOzP5PgfW9ogpNunzJhjcJjKUzCOpcXSTfN6Rg1yQlomjQdX1aob
 xV+6BNalzbr7IAX8lgIbQfBNcyMrx59O38hj6kYnExG4Bj3B51IANALDM5vBCMYzn7lL
 5cSl5MVwGU6VIM4yl8P/95VfcEI9F7da+pn4POBI/IhXTDY5etEON4J0GSPklt2vEdbY
 /VwQB1uOB9EmFJCd0Bm6Mz1RAlreanQ6+0f8/TAm+fTJjOPKabnlGmCwbMn5z+2NKji3
 TZ5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=cU2cx1htDUJjTg39cgrGf62olsMzxqfpRXt77GHEV1A=;
 fh=5c2zzDCO3AarKeAiMGTbVWF3GfaVX9WQmTkvlSIBr/A=;
 b=T62IH3NM2CWPcD+CkKf9fA8k5emYkIlk0m37rQRvbH1yudYWzSpJvEouCcdufglOJd
 KCVBddrbr+qVenLczf4TEUX3akHqnD19KeGIIPdx1mUVBqYn03mg2gEHNLUI+bK19iEu
 qKXNXpsEsDlX5SM5wH5/rCSLtUx6SXnekRO8QsSXsS9EmmPyqaCWwaYYMlooo2MyfJnZ
 60+kctoTxzTWlhIPgDoFPd4daC9vVXetRvHN1biJqYrIHF2C31lcnfno2mBzuP1phcHL
 OBMxE/+wGkD8jp5UuYZNgBSZlUoHscha/mGj5H5N7xVflqjZTkpNeyB+mqVPxzZHHQSM
 IHGw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785781602; x=1786386402; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=cU2cx1htDUJjTg39cgrGf62olsMzxqfpRXt77GHEV1A=;
 b=kRoglRt9xKo93dzLU5dpt+9xFnj73pIN13QLMuowFuWEJrDopUeNk3xWF8qUHyJVyb
 rlySbb8fLpXzSBUBgLCAV2NRcHuz5WZdu15jUFjf/coF2IYufPvv1WtqzNDzD7CTX3JK
 lz0mnkEP2BIwN3xbQOcz/KTfX6fb31/4tw4mYC/tlATcIdhIjsSwbtc5UNU57udYb6kx
 4VZhJvo1L2edNpHQ6IeTueW2k4cUC56LWBOyrn6Xh91sI75mHZh33Kr/R9WI3mpXSOkX
 XGb4RNdtt+3wiWVpx1j17g7kRyD/eI/IxRkf6yToMtkCX62osMhfZs7GcbaDWrKq+eVL
 ZuLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785781602; x=1786386402;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=cU2cx1htDUJjTg39cgrGf62olsMzxqfpRXt77GHEV1A=;
 b=c4jzPCSZep87yYD1b6zBPsjdyCed6MgAOzuIm3tMtqBAd6uCSmxOLKRZK4fVCt5aM3
 o0+NcUvRTO7++NGbFsRoeFjVveRBWSOidmBiEMRFVj1K30ojnqMQH9plXkngXXmjUp3V
 pvTQNKGgLAXrVx7ygofVGhorWGtzHRvwZ/BlvSWgsyU+B2rIRM37dxcFp+MdB/GsW3FM
 QUEM4QVug20mAWom8thP0FyJolDvBlVF51uTZum5o19gDw9wrLcXa54ygfwgEp7VKi6C
 Up3UXqCvRlPY+5DXLWyOgbk5RXlDRAAmiVh9dER/HnhatWgt5h7kAYVEcwYnTn+ju27M
 cTrw==
X-Gm-Message-State: AOJu0YxUyAMPv9lX0HVCeMMfhAIhx6NkEXTowtts8wpUcCJ9CdbE06S5
 Ok0UQFuYXCmryXhNP5qrto6tS0djZZcigMW5MScotaykqkLHu2UdV/4+5sMShWgXiLnBn9/DXCB
 7tJfm9FHi413Fg6JC5SZYrMdOITG8Q4c=
X-Gm-Gg: AR+sD13uYeV46JDWrb0FnF696YLwICzQxOIGanrI1ogbXA5VEXK0SqB90DiLriJQEpM
 LKAjfyIzTFIMWewZyTVUjfH9Ag1kASX2a1kQu8/S48ri/O+PZ72Bxa1DfHlfYqXRXBlHqYxNXgR
 O9AjIAWORvISUXVARaPLd2KFwfiE/68BW8COshKZsJxNySMhL+4b6wflPUbOEGdV4L0Z5CcN8U1
 VcHX/Z5FwG9o4SPAY/NMF7LKk3GOSsuHnHt4J1EepIYOt7h7lo5uYfJPAdFf+P7ONFA6xKgtcvC
 HEKOcxt971QZnYH5ek//PpWL2jegD13COR9nz7ui6xNS6kND+teaGl9HsiZXF2o2WM44tBQTQ5o
 u
X-Received: by 2002:a05:622a:5a13:b0:517:146d:2cb5 with SMTP id
 d75a77b69052e-52cd35f7718mr14076591cf.20.1785781601773; Mon, 03 Aug 2026
 11:26:41 -0700 (PDT)
MIME-Version: 1.0
References: <20260723-vhost-user-isolated-memory-v1-0-6b97c439eb28@gmail.com>
 <20260723-vhost-user-isolated-memory-v1-11-6b97c439eb28@gmail.com>
 <20260728175931.GI371693@fedora>
In-Reply-To: <20260728175931.GI371693@fedora>
From: Connor Kite <connorkite@gmail.com>
Date: Mon, 3 Aug 2026 11:26:29 -0700
X-Gm-Features: AUfX_mw627TW1QIKX7ZVVWRqH-pVbRrnDnqjVkySiArQktWAgdvKFLa79MaLLGU
Message-ID: <CA+spn3qkZ-2=4q2nn_6-wp85U4Xv3oaDAmCHEP_yB=N4aZSceg@mail.gmail.com>
Subject: Re: [PATCH RFC 11/15] hw/virtio/vhost-user: create isolation region
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Haixu Cui <quic_haixcui@quicinc.com>, 
 Raphael Norwitz <rnorwitz@nvidia.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, 
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::82e;
 envelope-from=connorkite@gmail.com; helo=mail-qt1-x82e.google.com
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

On Tue, Jul 28, 2026 at 10:59=E2=80=AFAM Stefan Hajnoczi <stefanha@redhat.c=
om> wrote:
> >
> > +typedef struct IsolationRegion {
> > +    uint64_t base_addr;
> > +    uint64_t vring_base_addr;
> > +    uint64_t size;
> > +    int iso_fd;
> > +} IsolationRegion;
>
> The purpose of the base_addr and vring_base_addr fields is not obvious.
> I suggest adjusting the types, names, and adding comments to make the
> purpose clearer:
>
>   typedef struct {
>       void *mem;           /* mapped shared memory */
>       size_t size;
>       uint64_t vring_iova;
>       int fd;              /* shared memory fd */
>   } IsolationRegion;
>

Agreed on adding clarification.  Is there a reason to change from uint64_t
to void * for referencing the shared memory region address?  Most uses of
that variable expect uint64_t currently.  Here's what I am currently thinki=
ng:

typedef struct IsolationRegion {
    uint64_t shared_mem_addr; /* mapped shared memory */
    uint64_t vring_iova_addr; /* beginning of vring region in shared memory=
 */
    size_t size;
    int fd; /* shared memory iova */
} IsolationRegion;

...
> > +
> > +    /* Isolated memory data*/
> > +    struct IsolationRegion iso_memory;
>
> struct is not necessary since there is a typedef:
>
>   IsolationRegion iso_memory;
>

Agreed!  This will be fixed.

> > +    VhostIOVATree *iso_iova_tree;
>
> The IOVA tree seems to be closely used with IsolationRegion. Maybe this
> field should move into IsolationRegion?
>

Agreed.  Since the IOVA tree is basically tracking mappings to the
isolation regions, these can comfortably be grouped together.

...
>
> nregions is uint32_t, so i should also be uint32_t to avoid
> signed/unsigned comparisons.
>

Agreed.  Will fix this.

...

>
> Please avoid duplicating the memory layout calculations. When packed
> vring support is added to vhost-shadow-virtqueue.c this will become more
> complex and it should be done in a single place. vhost-shadow-virtque.c
> should expose an API for the size calculation.
>

I think I originally did this because the svqs weren't initialized yet
at this stage.
However, I can cut down on the duplication with a new function in
vhost-shadow-virtqueue that makes a dummy svq with the correct num value
and calls the existing functions to get device and driver area sizes.
...

> Please make the name unique (e.g. using dev->vdev->name).
>

I will do this by prepending "iso_mem_" to dev->vdev->name.

...

>
> Is it possible to use 0 as the IOVA base address so that QEMU's
> addresses aren't leaked to the vhost-user back-end? It's good security
> practice not to reveal memory addresses to the outside world because
> that information can be used to defeat address space randomization or
> infer memory addresses of other data structures.
>

That should be possible.

> > +
> > +    assert(&u->iso_memory.iso_fd >=3D 0);
>
> The dereference operator should not be used here, it's the iso_fd value
> that is being tested.
>

Got it.  This will be fixed.

> > +    DMAMap *map;
> > +    DMAMap vring_map =3D {
> > +        .perm =3D IOMMU_RW,
> > +        .size =3D total_vring_size - 1,
> > +        /*vrings are allocated on tree first, so will be assigned base=
 addr*/
> > +        .translated_addr =3D u->iso_memory.base_addr
>
> Why is this field assigned here, I think this field is used as the
> output of vhost_iova_tree_map_alloc() rather than an input (e.g. see
> vhost_vdpa_svq_map_rings())?
>

Yes, I suppose this doesn't need to be assigned here.  As it currently stan=
ds,
that value is just getting assigned back to itself in
vhost_iova_tree_map_alloc().  I'll fix this for the values in
`buffer_regions`, too

