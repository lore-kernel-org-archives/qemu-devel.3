Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65AD660A5BDF
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Nov 2026 15:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=KGiAl0aE;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=mAh089B/
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQnPK-000645-Jq; Tue, 10 Nov 2026 10:05:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1xQnP1-0005oX-Bo
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 10:04:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1xQnOz-0000AP-6t
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 10:04:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794323087;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=C3dTQBmQ7Ro/FRBuP6MEDULAZwn/rEe5iVobQPAYtrQ=;
 b=KGiAl0aESq6DmUs/vJylw/ldGxCY7T9Kczvq10U7goRH5Y3AG03NkkidJzWace6AWDnCyB
 dtGEm4d/A2Q0foZ25aVXEhn5sg7/xcnRmxZuFjq+caD64XjBJ2z9zoCNhBoB/jMsGipQHz
 cF8+BEmnAW1EOaiAvrSpX7eL4v0Xkdk=
Received: from mail-yx1-f70.google.com (mail-yx1-f70.google.com
 [74.125.224.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-353-MPrMmfKrNvSLEkhXyIcxqw-1; Tue, 10 Nov 2026 10:04:46 -0500
X-MC-Unique: MPrMmfKrNvSLEkhXyIcxqw-1
X-Mimecast-MFC-AGG-ID: MPrMmfKrNvSLEkhXyIcxqw_1794323085
Received: by mail-yx1-f70.google.com with SMTP id
 956f58d0204a3-67906c453b8so3270434d50.1
 for <qemu-devel@nongnu.org>; Tue, 10 Nov 2026 07:04:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794323085; cv=none;
 d=google.com; s=arc-20260327;
 b=c3D5NgMAfkpPQIOS3KEoMRk+GLBdUwVXsrHiyihOn5LU2NkXuXWCMOV/HzBJMAbzu8
 FNaw+ubrNHefk4vxhUfGEGBlxWO6awTk9e7QnC8eeEuqkk2RvocG2322D0GwD8bZ22M7
 xK9E4PAwixnB5fkFk9dtyYn4vLzmBvOfOyeDmNNzWvLTPW21SaBhd2pUt+phf/pokW8p
 0oTwKikpTiTN8eea5BzM0xlafOhqNU5c3MBtdJCXImlxjsnzxUBxbqusR8woqSz0YhFd
 c/JU+pbzFoGM+OlnEhGTqztxk7HlNN+lcOs6D3CpLodR+JtxxiFJKWbeRXDG2IMXXelD
 Jy9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=C3dTQBmQ7Ro/FRBuP6MEDULAZwn/rEe5iVobQPAYtrQ=;
 fh=a/2MN2uPyD2iObF5cScXxc/dBl2uEPRVKVdSTje4TOQ=;
 b=CMOGsmnnhzPDewFTd6nzejaSS1nOwbkl5qzvW/es5gvjKAqSjXGZQP5GigyaTCR6f6
 h6eksPxUYjADt9WVvCWPCH98iXW5bjPygCGAZo1pzvde+1g5JyWeRdk+LqYsfsZjVJcv
 aPnFFvJrbDjQKHstxiIMU3q/JFVF2XtAvDVEv+qXsD/5sxu/4LENEQ1IW79ui/2Lgbyx
 fXOArLZRcIngHauOj0IXYKSB8yFr8S1O3V6Nc1hCIq6Qre1M3Iu0j0YLq2qCVSx8xPHo
 FOVDjZ3Eu7sNMPGNt4U3C/w51MPmNgE9PCYa+qynn3Pp6XxpDEYxSOD/5wkRMVfdxfqR
 HZ4w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1794323085; x=1794927885; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=C3dTQBmQ7Ro/FRBuP6MEDULAZwn/rEe5iVobQPAYtrQ=;
 b=mAh089B/DJBx38o9mSVV2FzIz5NTBVUWnkfXNrkxXOpTBr9ZbbG+4CGovV7QciSF+o
 kXvRX7VTui5dO89d8DC+kyCV91f6R2zcEE6hBMKyknID7dqSg8nnX/xacBo+iGJn5S4m
 4DgLPYJE4cRboYnu1AaJvRlPPMb0SlZHNrJcqC+0iuagUAuxISNSUZY5mBrLzktI0bvL
 9NEaxspZsSKrvtHDJTjUJD+Fy8AINQ8ZLltGBcN79pJq77ftCv4D2p1xfRPlrir6P7k8
 51IsAZFBuxde7AVZ4Q2lVt3j/xWGnB0L54KxJMj28dPDRJqdAsXm6dd7f1zZK9BTCGts
 xbCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794323085; x=1794927885;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=C3dTQBmQ7Ro/FRBuP6MEDULAZwn/rEe5iVobQPAYtrQ=;
 b=XCAmrChikyFLE8/PMaqwacsoiq2zn030oVSlEL6sjnt36j7nZ6Wq+9ibkTeD65iXrE
 H9+4X0R0g0y8hWM5Nwy0pNtyMuxtPTzwBpeOP2i1lLf6BX57ONt/djon01b68UcLVPq6
 iEG2M10BVi1a0MJbO/jW7SH1JaArepkizZT5TmzL7qytjiCph6OMNiCX+onda4w9LICi
 6Pbbxcgk3KhldakTvIXEUXY+w3N+VDiNOxNKPy9PPB4nG78Z7PstAgz6gDy9a3ekCrI/
 athn32cSFWGSKW3pUNBq4hMlQ2D4IkzdXq1I5EQQNE/WSbsY2yy/I0Ei8SXbKc06pwGM
 toHQ==
X-Gm-Message-State: APuU4Z/a0OWjGPeVap2RwIsHlvT0acvI/zjR4cizq9baSBONGdLaksM1
 xX7Smana9RRSBlyVToU13YbadbgipfHCi9BLwjBcW+HbokZO3AitIxUasHXERkIBwJqup2dLLwu
 nvkc8ooX9X5ZQ35V5IwJgtdUILixwdanTmUGEfMqYlsBDE9LUEEEpVgScKGWfXl307ZCdcTIAXc
 g4maFscmSmN1D5fiFtGMe1w6MeReFW700=
X-Gm-Gg: AYBFou1ITPdX3IyULyZeQlubJfq72iAbkksthtnT+W1XH0kb1J+q7UxxNRN4kc6zxXH
 3YE2xOcoa3O7f+anBe8PJ+EWUm5pOy7P8hWneqaAY/tnLGrvXELA0JLmR/OIAnVDGanus+WSuec
 CCPDwPtmiVLxGTvVd6JxGECPQ4e2NmGvqbmwYxSsc4kQw1QP+KMB5arnDdgdKhP9ChiNxIt1g4j
 WrRitPbcUj5zNXZ
X-Received: by 2002:a05:690e:1445:b0:67c:2ae8:dc65 with SMTP id
 956f58d0204a3-67c571f47c4mr1777301d50.46.1794323085190; 
 Tue, 10 Nov 2026 07:04:45 -0800 (PST)
X-Received: by 2002:a05:690e:1445:b0:67c:2ae8:dc65 with SMTP id
 956f58d0204a3-67c571f47c4mr1777275d50.46.1794323084529; Tue, 10 Nov 2026
 07:04:44 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261109185907.3220584-1-jsnow@redhat.com>
 <20261109185907.3220584-2-jsnow@redhat.com>
 <avIfJqbcTHFAGvqf@redhat.com>
In-Reply-To: <avIfJqbcTHFAGvqf@redhat.com>
From: John Snow <jsnow@redhat.com>
Date: Tue, 10 Nov 2026 10:04:33 -0500
X-Gm-Features: AclHuK89ddUpEjdZmrDY9p7C0TaBdkuYPC7pwqYL_axC9xBTOSqnLEorhZ8PJuo
Message-ID: <CAFn=p-b4dE9=5NYuvK-4SXaiiCsDHszCiz_HzEtWREcAzdhaRg@mail.gmail.com>
Subject: Re: [PATCH 1/7] debug/mem: add utility to name anonymous memory
 mappings
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Marcelo Tosatti <mtosatti@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>, 
 Alistair Francis <alistair.francis@wdc.com>, Stefan Weil <sw@weilnetz.de>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 kvm@vger.kernel.org, Richard Henderson <richard.henderson@linaro.org>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 9, 2026 at 2:29=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@re=
dhat.com> wrote:
>
> On Mon, Nov 09, 2026 at 01:59:01PM -0500, John Snow wrote:
> > Add support to name mmap'd memory regions using
> > PR_SET_VMA_ANON_NAME. On supported platforms, the QEMU utility
> > functions are no-ops.
> >
> > This is useful primarily for debugging and profiling QEMU; beind able
> > to see and correlate each VMA segment with a specific use within QEMU.
> >
> > Signed-off-by: John Snow <jsnow@redhat.com>
> > ---
> >  include/qemu/mmap-vma.h | 18 +++++++++++
> >  util/mmap-vma.c         | 67 +++++++++++++++++++++++++++++++++++++++++
> >  util/meson.build        |  1 +
> >  3 files changed, 86 insertions(+)
> >  create mode 100644 include/qemu/mmap-vma.h
> >  create mode 100644 util/mmap-vma.c
> >
> > diff --git a/include/qemu/mmap-vma.h b/include/qemu/mmap-vma.h
> > new file mode 100644
> > index 00000000000..763ea5a5cab
> > --- /dev/null
> > +++ b/include/qemu/mmap-vma.h
> > @@ -0,0 +1,18 @@
> > +/*
> > + * Utility for naming VMA allocations in linux
> > + *
> > + * Copyright (c) Red Hat, Inc 2026
> > + *
> > + * SPDX-License-Identifier: LGPL-2.1-or-later
> > + */
> > +
> > +#ifndef __QEMU_MMAP_VMA_H
> > +#define __QEMU_MMAP_VMA_H
> > +
> > +#include <stddef.h>
> > +#include "osdep.h"
> > +
> > +int qemu_name_vma(void *ptr, size_t sz, const char *fmt, ...)
> > +    G_GNUC_PRINTF(3, 4);
> > +
> > +#endif
> > diff --git a/util/mmap-vma.c b/util/mmap-vma.c
> > new file mode 100644
> > index 00000000000..7dcef3b7455
> > --- /dev/null
> > +++ b/util/mmap-vma.c
> > @@ -0,0 +1,67 @@
> > +/*
> > + * Utility for naming VMA allocations in linux
> > + *
> > + * Copyright (c) Red Hat, Inc 2026
> > + *
> > + * SPDX-License-Identifier: LGPL-2.1-or-later
> > + */
> > +#include "qemu/mmap-vma.h"
> > +#include "qemu/osdep.h"
> > +
> > +#include <errno.h>
> > +#include <stddef.h>
> > +#include <stdio.h>
> > +
> > +#if defined(__linux__)
> > +#include <sys/prctl.h>
> > +#endif
> > +
> > +#define VMA_PREFIX " qemu: "
> > +#define VMA_MAXLEN 80
> > +
> > +/*
> > + * Give a human-readable name to a previously mmap'd memory segment.
> > + * This feature is only available on Linux >=3D 5.17, and only when th=
e
> > + * kernel was configured with CONFIG_ANON_VMA_NAME=3Dy.
> > + *
> > + * For systems without this option, prctl() will return -1 and set
> > + * errno to EINVAL, and can be safely ignored.
> > + *
> > + * For systems with this option, these human-readable names will be
> > + * visible in /proc/$pid/[s]maps, pmap output, etc.
> > + */
> > +G_GNUC_PRINTF(3, 0)
> > +static int qemu_vname_vma(void *ptr, size_t sz, const char *fmt, va_li=
st args)
> > +{
> > +    int rc =3D 0;
> > +
> > +#if defined(PR_SET_VMA_ANON_NAME)
> > +    char strbuf[VMA_MAXLEN];
> > +
> > +    assert(sizeof(VMA_PREFIX) < sizeof(strbuf));
> > +    strncpy(strbuf, VMA_PREFIX, sizeof(strbuf));
> > +    rc =3D vsnprintf(strbuf + sizeof(VMA_PREFIX),
> > +                   sizeof(strbuf) - sizeof(VMA_PREFIX), fmt, args);
> > +    if (rc < 0) {
> > +        return -errno;
> > +    } else if (rc >=3D (sizeof(strbuf) - sizeof(VMA_PREFIX))) {
> > +        sprintf(strbuf + sizeof(strbuf) - 4, "...");
> > +    }
> > +
> > +    rc =3D prctl(PR_SET_VMA, PR_SET_VMA_ANON_NAME, ptr, sz, strbuf);
> > +    if (rc) {
> > +        return -errno;
> > +    }
> > +#endif
> > +
> > +    return rc;
> > +}
> > +
> > +G_GNUC_PRINTF(3, 4)
> > +int qemu_name_vma(void *ptr, size_t sz, const char *fmt, ...)
> > +{
> > +    va_list args;
> > +
> > +    va_start(args, fmt);
> > +    return qemu_vname_vma(ptr, sz, fmt, args);
>
> We need a va_end here too.

Definitely spent too long in the python mines...

Thanks, and thanks for the pre-submission review as well. ... and
thanks for figuring out that the entire feature needed a configuration
variable, and thanks for proposing we enable that variable in our
Fedora debug builds. :)

It's been a *massive* help, even more than "massif" ;)

(Note to international audiences: effusive praise is typical for
Americans, they are just like this. If you should find yourself the
subject of overwhelming praise by an American, do not panic, they are
not likely to propose to you. They may just offer to buy you a drink
should you meet, or perhaps stand a little less than six feet apart
should you happen to be waiting for a bus/train together.)

>
> > +}
> > diff --git a/util/meson.build b/util/meson.build
> > index fa174c07a57..861ee228d5b 100644
> > --- a/util/meson.build
> > +++ b/util/meson.build
> > @@ -1,5 +1,6 @@
> >  util_ss.add(files('osdep.c', 'cutils.c', 'unicode.c', 'qemu-timer-comm=
on.c'))
> >  util_ss.add(files('thread-context.c'), numa)
> > +util_ss.add(files('mmap-vma.c'))
> >  if host_os !=3D 'windows'
> >    util_ss.add(files('aio-posix.c'))
> >    util_ss.add(files('fdmon-poll.c'))
> > --
> > 2.56.0
> >
>
> With regards,
> Daniel
> --
> |: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
> |: https://libvirt.org          ~~          https://entangle-photo.org :|
> |: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|
>


