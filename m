Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 745CBD3942C
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2026 14:06:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8Ig1-00055p-G7; Thu, 02 Apr 2026 10:05:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1w8Ify-00055N-I0
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 10:05:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1w8Ifv-0005p2-DI
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 10:05:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775138734;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zZPRe1lzRek9mUSo2QWGZxdZ4+Jl5eG4SyNn32BK/xM=;
 b=Hxx2/Sbzk6K/9g1WTGA/mAPdvXq1mQledQCGARv3MUIKVsWkPW7hgQqDUQ740grgktLQGa
 3dXZTG1t2DmTF5z5vHVaRAOzwXtqJG7SRitNu6A0ePELHRTXA9sY1yPzxuqrDVMcUgLcYp
 CW5dme8/Ci+lZTerbdg9Q+dxMxwHHA8=
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-336-xFaoL4fuNyyrnZe8yaw42g-1; Thu, 02 Apr 2026 10:05:33 -0400
X-MC-Unique: xFaoL4fuNyyrnZe8yaw42g-1
X-Mimecast-MFC-AGG-ID: xFaoL4fuNyyrnZe8yaw42g_1775138732
Received: by mail-ua1-f70.google.com with SMTP id
 a1e0cc1a2514c-953b0e67a8bso197792241.2
 for <qemu-devel@nongnu.org>; Thu, 02 Apr 2026 07:05:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775138732; cv=none;
 d=google.com; s=arc-20240605;
 b=WnuW9ssuDy6TzE87rZwFDsOeYqRY3iENFNX6AHmsCtbnQu4mwwAe3nS/lG6RWANOXK
 wPOgCs2wZIMrTQ92P3KBCoDPHpCP5VIEFU7OevVnSDYoD816Kj4MGmz2GHw7kWGmeaDq
 RXVtICyusqYB3tyJP5Ra9TdnfW/dCl0+dj25EzgWr8exMY4u3eqQgCBSbO7YlNjzn4wP
 PWH+hYKQW4xCC7zwUcvb7I+WCp3l25K2CbO4saAHg9iuTCr4tIDQnVETNeacv+Rb2nIm
 Wr68cat/yE4WCRjPAgjY6fc18Qx8Ye/fR1zkZk9FzTvZneDWy9VmzUHOOvaTSpb9A9AB
 APhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=zZPRe1lzRek9mUSo2QWGZxdZ4+Jl5eG4SyNn32BK/xM=;
 fh=zpiKzW8LH3ELwKzluQ3AheUCgrr23INy4hQ6ZjBUBr4=;
 b=IQqsJp0NrKoFSqhwEC5g/AEsHd7OkstV3x0krcs6vDWZOUpvdUxAj7+4Mdnu8uaBjj
 3QkUb1I3JX2hHgdZ90v2ORdHYfMoZRQVcSAYtxVp+oTPMN8GSupGVC8qspFezVTIR06o
 VxXJswxp48pqcGaOKXWXJwZJay14PeGWQN7qnsd7KSEf+BC6hWLwlnqfCNQRZI6xbCxo
 z6SustD7QKz45giAaIm03GX0Y6e6IjtViekQ1iVBmg+EHrSdjycLR5HFlPCRPECbjK3N
 tHp4MQdXkmShQ3Wbfo5fGeyxZWKB+ZhKKBsmterdlHDTZBX6fE1Jzn2dLfvy3aSvVuuh
 UaZw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1775138732; x=1775743532; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zZPRe1lzRek9mUSo2QWGZxdZ4+Jl5eG4SyNn32BK/xM=;
 b=L7rv644xy775nG32/D8/AiwMuM1g6RbrixRKL/SXt/mHbbKEZajEzMrSxvBweBXzMq
 e78io4/HVYPOmTjU7KwReYWRIjRREukm8i8KzVN7YbJh+LHR6HPcLxCQipHNnmY23gtM
 ImdHDipOGqULiU8NsbIYDxkO5yzZQ6vD3N3X4p8I9VmzHgqoLLUGltAAqV4PniZSTF93
 miocsoXRBhzGHEIMkH6XKmAkWtMT86/DV3oP+3hPCD11vpqJAIkT8tFXxSlcR4pMmAtp
 OlDqrzMWdeKERJndirzsN1xz8Ueil8fWQQaahulVRLo2+cV/ALDKZm2eCGmRN5iUcSEP
 6xpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775138732; x=1775743532;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zZPRe1lzRek9mUSo2QWGZxdZ4+Jl5eG4SyNn32BK/xM=;
 b=XhyoZrWgIyttir0SHmSD7MieSRRDbsYOt0cwHbWZvBMm4JALdtvgPAC9LUio9CyDoE
 0YWy/RZARqBhiywJzqpZQ2P/9XTW0ntxRrbZhYxJsQEsDfThw4eWdU9h06uYErW0dlmo
 j+5mo7WI++L0oaK0ENGMSw/Cxh5f/0oPrPBpafVXqEMDFgum2McMklglJ7tOqT07kUMV
 yphbHXaV6h9wnoIUlE+TXvBZwmJuPPuE68nhv7QWNnUkbn7mey5szd+iw7lbhxJyZt0p
 g4xzDjMfW5v97jfiRLVK60k5n5E63t21kOQlmREBFbFhmsO2uIz29qmLimF6x/u9dpEM
 A2Ig==
X-Gm-Message-State: AOJu0Yws5ZzKRHdPkS1rUJ4uiOl6HUzTn4uC2JfvCJpA59dsdN8NHoAm
 UALWk35VEd999RmZhtAJZrEA1hWSKWqUb7adJP4fU6e2Qlgbqwcn6b42Y74j5fl71PGpTf3QXmf
 4UpJXHH2nfSuEfLUtu2UGxvO1bTXjoCAeX4t1A3RzySnED9Ly5QYFWCc2LbUkNZx/Yjjs5YAxvM
 P6pdYKCAt4MlOR79NW5QBDrH0bVB7KnhMWn5JMoww=
X-Gm-Gg: ATEYQzwUNcoJFSaGtsCbTjprAP46XBFjeSuzWh2o26g9mFnMA7jK9JVMVtIgsDKPjiy
 JqEayDiocPBqyZ5QEddVemOjUiL+cOCw/oHI/6NaBgW8wqF3yQJRGlP1CWJYGH3WUCfDM2fpLdH
 AzYk43Vo15hdz5005o0sd29GkiwtZHYsMdQmDHNZYOUWN5+hjo2u9mrlfsQMousVzUzSPvFSyd8
 5oThvuIzQZlG5AMmuW1k1UMsXTgZkTJ40fWHyeYlgV+oYVddpZXdC3hFKEhyTOgIcFDMe7JdqYE
 PVMXzgcDZQndOdS+GqD7eZw=
X-Received: by 2002:a05:6122:322c:b0:56b:f8e:6b2f with SMTP id
 71dfb90a1353d-56d8aae4ff0mr3470083e0c.16.1775138732049; 
 Thu, 02 Apr 2026 07:05:32 -0700 (PDT)
X-Received: by 2002:a05:6122:322c:b0:56b:f8e:6b2f with SMTP id
 71dfb90a1353d-56d8aae4ff0mr3470026e0c.16.1775138731475; Thu, 02 Apr 2026
 07:05:31 -0700 (PDT)
MIME-Version: 1.0
References: <20260317-qemu-vnc-v1-0-48eb1dcf7b76@redhat.com>
 <20260317-qemu-vnc-v1-36-48eb1dcf7b76@redhat.com>
 <13bfd7c0-d80c-4082-a6a6-085d463b40d9@linaro.org>
In-Reply-To: <13bfd7c0-d80c-4082-a6a6-085d463b40d9@linaro.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Thu, 2 Apr 2026 18:05:18 +0400
X-Gm-Features: AQROBzAHIX7nBLJuYn7r2VT3AQf8ud-4iz8voGCRSPGYV-9whxFg4OdQDqeBurQ
Message-ID: <CAMxuvaxHkrvW74hKgz6yu29K3kJOf-vgdNRPUSC_ogpg3T34zQ@mail.gmail.com>
Subject: Re: [PATCH 36/60] util: move datadir.c from system/
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.542,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi

On Wed, Apr 1, 2026 at 1:30=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 <philmd@=
linaro.org> wrote:
>
> On 17/3/26 09:50, Marc-Andr=C3=A9 Lureau wrote:
> > The datadir module provides general-purpose data file lookup
> > utilities that are not specific to system emulation. Move it
> > to util/ so it can be reused more broadly.
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >   {system =3D> util}/datadir.c | 0
> >   system/meson.build         | 1 -
> >   system/trace-events        | 1 -
> >   util/meson.build           | 1 +
> >   util/trace-events          | 3 +++
> >   5 files changed, 4 insertions(+), 2 deletions(-)
>
>
> > diff --git a/util/meson.build b/util/meson.build
> > index 33132c04ad6..cd56fe2ffe4 100644
> > --- a/util/meson.build
> > +++ b/util/meson.build
> > @@ -30,6 +30,7 @@ util_ss.add(when: linux_io_uring, if_true: files('fdm=
on-io_uring.c'))
> >   if glib_has_gslice
> >     util_ss.add(files('qtree.c'))
> >   endif
> > +util_ss.add(files('datadir.c'))
>
> Should we add under 'if have_system' or 'if not have_user'?

We could, it would need an extra condition for qemu-vnc.. but that
doesn't save us much.

There is probably room for improvement in util/ if we wanted to always
build strictly the minimum. But since those are small, generally
useful helpers, the linker will drop the unneeded parts..

> Otherwise:
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>


