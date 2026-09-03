Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89E73C624DA
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 19:29:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2D7o-0006z0-UB; Thu, 03 Sep 2026 15:29:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1x2D7m-0006xi-Rj
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 15:29:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1x2D7l-0001ts-4n
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 15:29:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788463764;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Mcn+Xj3Zc77iKk5O16icCpApQkIaj/hbo6D6/ej7fA8=;
 b=DlM+qOu3z9/5ATvTox/JyDgUS9SQbCv86idH8qLW64DCyt1uU3g/KnYMZKBZH43Hemy4cw
 iiurq0CO6ecPtl5NVoDxUuD04hwGbAdBXEgphbca4BXNFsJZTL3rUXe8cyohP+JS8TWeYR
 10CtsgdS7NNlfWOYq5+a42YqBNQgRzg=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-97-CGaVDPfePLCPklHsyVJ4-w-1; Thu, 03 Sep 2026 15:29:22 -0400
X-MC-Unique: CGaVDPfePLCPklHsyVJ4-w-1
X-Mimecast-MFC-AGG-ID: CGaVDPfePLCPklHsyVJ4-w_1788463762
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-38f5ac7416eso175079a91.3
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 12:29:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788463761; cv=none;
 d=google.com; s=arc-20260327;
 b=gq+B8XgpktVhvOOnYvQEJuzZAUFf/MEq1yyoXUBg9nQx+9Asn20kTH/saNrSEVPUGO
 3JSldnWrf9q1B2e4k/uc3PET7HpTfHfjquUGIPp1zKq1/LTfIYx7Oi94qBdZmsRKTRYl
 oUqwekNh1EcsW+dur2ynJPWhaknAlDuJ8tdYqs7qX0b7jEY6o7vSP6kca0EPN7ynC116
 p9liY6IBLbM3T2v/2GYDIM/tSST1Ny3U1sPc+5oYYlf/EC0Wk6sN9n189oQPj8KPCrLu
 AliMrv6irvR4aTyrYRN1yPtl4vG5jw3dtnP+vwzq1r1LACIMzmK+twrKrEd6y6J5aOwE
 YYvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Mcn+Xj3Zc77iKk5O16icCpApQkIaj/hbo6D6/ej7fA8=;
 fh=gC6cEwCIoMqii6+cjmGB0+3fq9atRcrJzdCKulDoX84=;
 b=pBefz7l9AQu84Rl8RM2ZL6BJ2+4Znj/gGVK/S8p5NzxQeuG696+suGSfizqUJbxZl0
 GbRq4DMCqROH2y/JrlG/MIgn2liTNodN+R6/JDqnBejIxkWAFVQt6rJ7/xu2BmNgC1tb
 tpYiLI8i3OY6zR0Cnm07Q4fXn/QCCHHyFo2yTV8wydEVWqjaeZj0xgBOBQ9q2sd27PVu
 WOiFMZjTUGyTgxELKpl/Vwvtm6RXj6ViUVI1Ka6gOQ2f26ZHS6tLiDmM9GqYM1dNNTl/
 dzV/y/4p62seV8Qkv3GuDPzAWtMU66HToRrR4uRH2uGUu5NXHkI6iX8//MB/adml9FJt
 wDBQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788463761; x=1789068561; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Mcn+Xj3Zc77iKk5O16icCpApQkIaj/hbo6D6/ej7fA8=;
 b=QhE5CNyJmMyqPXa70Tkk8Qcy8sUNvg+PxbIR0YQ5ILrsrB5xV+mZNK+egjzOen0nru
 OyQgo/u14lItVDO0YlkjXTuFpNJehHnpv/kS+SwKGhE6KnfoxzMRmbdQJTaP/z1ZM6fP
 uSJwxHK7eHP1nIy4EnmzWhfTNBqn1Ukx9kgL0bVLkGJFdvq2DTSn9+VJGv+lECrtLEB2
 q2B4qvNSPoBVvway5MBj96tcn2OOhK9IbUXLYVGLIYMWcehIleAF0YFoFLpORNAxgeyr
 E+gSXKan5BwhL2MT0Jltl8VjMV2UIsws+e3Rknf0TYj2hGZrfP73CoEawjJ1ssUEVUKF
 8nIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788463761; x=1789068561;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Mcn+Xj3Zc77iKk5O16icCpApQkIaj/hbo6D6/ej7fA8=;
 b=Kr3u4cJU2/1pY9+oTmNNlZASIxDQ+1jAdw/IzXOt+lKbIgKELi89k6vcJp1hvPhPfB
 DWd1HFEee/17e17t5lsTTfQKz5stgUejT8adZ/Mw9uvH0s9fExOuZxP8UF6Ivp04fDsU
 BNZAPNJwH4BGZyHqD69o/ygkYyeaRrw+GeCr7CsF/LQBTJh5Rm5GjRZm1N3zrNlr2MXE
 521Efj2fK7/LbwG+oqMmv1wBcEcQuQkTaVZjOLIO4cyuEGFMJLwEjYB1Ep29Y1i/mO06
 gGU8TcGS0afGOzkb64UXV1lpUqRVcD7ps+DcCA+XQVmw9qHQGVBGMe88WAFEoq0bhLYi
 NJag==
X-Gm-Message-State: AFuF++mYpv36a1jWgCEwL1itlKQ78BFNDhejPUZzqMYc4fXUk7udLTcj
 fltCXTuotDANTmSq0AnotFBkiedBbmsG4ixLtLVSOh61EGoQErklTqxlx4DdqppLXS8OOEmcqbF
 XLmBYrQmzMdOjRl3JoRzOFWsSOclDfvnyV7l5I4vyib1dVzaX/sax9/8Eh0tDUo22dcgSJ/1bB3
 EOtEsTIQ4ljIxttDb2Cg2GPiRGyhc3jB0=
X-Gm-Gg: AYBFou1XcF2vQjt4S5MEAoLsW3uekQjo9R1id0hoZmsV2dXvv4Tl4qO92jL2bOf2QWz
 xuZ6uKN93laUWFnwlJWrVMeizONBPcpQJaG0sYKs9VpW5NKdfiIpa++jszTMEKX5YzAKU+brSFW
 aI/R/G2A+Vv3c+h8cwBGtiXSz4WDtHickHYopuLdBxEe02aIXlbsWns6HVvyhjkJPIPPXhbo1oa
 bnudylzq+sGqGvgCLBYDFu2RrXPV4+57xee3JdQZSa6UmWdWynNyZ6ar9J3imbuYtIiaWfwkFD2
 8w==
X-Received: by 2002:a17:90b:5346:b0:395:f0e8:9e13 with SMTP id
 98e67ed59e1d1-39b26190fd9mr1187590a91.7.1788463761325; 
 Thu, 03 Sep 2026 12:29:21 -0700 (PDT)
X-Received: by 2002:a17:90b:5346:b0:395:f0e8:9e13 with SMTP id
 98e67ed59e1d1-39b26190fd9mr1187502a91.7.1788463760767; Thu, 03 Sep 2026
 12:29:20 -0700 (PDT)
MIME-Version: 1.0
References: <20260903192647.2677279-1-den@openvz.org>
 <20260903192647.2677279-3-den@openvz.org>
In-Reply-To: <20260903192647.2677279-3-den@openvz.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Thu, 3 Sep 2026 23:29:09 +0400
X-Gm-Features: AcwNN1WyyzJFmmIiud6LKVn940o07o4pIwHN5C3hWE3x2z2Y_kFPFbQ0B3xDTlo
Message-ID: <CAMxuvawuHrQgQq19CQ4u0XKQBn9t-z4rkpLirXzMqWsrf-MhEQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] ui/cursor: make the cursor refcount atomic
To: "Denis V. Lunev" <den@openvz.org>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

On Thu, Sep 3, 2026 at 11:27=E2=80=AFPM Denis V. Lunev <den@openvz.org> wro=
te:
>
> From: Denis V. Lunev <den@openvz.org>
>
> A QEMUCursor outlives the call that publishes it and is shared between
> threads, but its refcount was a plain int with no single lock covering
> every user. qemu_console_set_cursor() takes and drops references from
> the main loop under the BQL alone, hw/display/qxl-render.c does so from
> the SPICE display worker thread, and ui/spice-display.c does so under
> SimpleSpiceDisplay::lock. ui/cocoa.m and ui/dbus-listener.c add two more
> threads.
>
> The pair that collides is qemu_spice_cursor_refresh_bh(), which drops
> ssd->lock before calling qemu_console_set_cursor(), and the worker
> refcounting the same cursor under that lock. A lost increment frees the
> cursor while the console still points at it, so the console's next unref
> decrements memory the allocator has already handed out again. Locking
> ssd.cursor is not enough on its own: with that done, this is the race
> that remains.
>
> Assert on the value the decrement observed while here. Dropping a
> reference that was never taken used to be silent, because the decrement
> lands in the allocator metadata of the freed chunk: nothing is logged,
> the object is not freed twice, and the process runs on until some later
> allocation walks the damaged free list and faults, arbitrarily far from
> the code that caused it.
>
> Fixes: 0b2824e5e48a ("spice: use bottom half instead of refresh timer for=
 cursor updates")
> Cc: qemu-stable@nongnu.org
> Cc: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Denis V. Lunev <den@openvz.org>

I suspected that, never had the time or motivation to find the arguments:
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

thanks

> ---
>  include/ui/console.h |  9 +++++++++
>  ui/cursor.c          | 17 +++++++++++------
>  2 files changed, 20 insertions(+), 6 deletions(-)
>
> diff --git a/include/ui/console.h b/include/ui/console.h
> index 29bf722888..3634956949 100644
> --- a/include/ui/console.h
> +++ b/include/ui/console.h
> @@ -126,6 +126,15 @@ typedef struct QEMUCursor {
>  } QEMUCursor;
>
>  QEMUCursor *cursor_alloc(uint16_t width, uint16_t height);
> +
> +/*
> + * A cursor may be shared between the main loop, a vCPU thread and a
> + * display backend's own thread, so the refcount is atomic and these two
> + * may be called from any of them.  The object itself is not otherwise
> + * thread-safe: take a reference before publishing the pointer anywhere
> + * another thread can reach it, and never dereference a cursor you do
> + * not hold a reference to.
> + */
>  QEMUCursor *cursor_ref(QEMUCursor *c);
>  void cursor_unref(QEMUCursor *c);
>  QEMUCursor *cursor_builtin_hidden(void);
> diff --git a/ui/cursor.c b/ui/cursor.c
> index 6e23244fbe..69d27d49a1 100644
> --- a/ui/cursor.c
> +++ b/ui/cursor.c
> @@ -1,4 +1,5 @@
>  #include "qemu/osdep.h"
> +#include "qemu/atomic.h"
>  #include "ui/console.h"
>
>  #include "cursor_hidden.xpm"
> @@ -103,24 +104,28 @@ QEMUCursor *cursor_alloc(uint16_t width, uint16_t h=
eight)
>      c =3D g_malloc0(sizeof(QEMUCursor) + datasize);
>      c->width  =3D width;
>      c->height =3D height;
> -    c->refcount =3D 1;
> +    qatomic_set(&c->refcount, 1);
>      return c;
>  }
>
>  QEMUCursor *cursor_ref(QEMUCursor *c)
>  {
> -    c->refcount++;
> +    qatomic_inc(&c->refcount);
>      return c;
>  }
>
>  void cursor_unref(QEMUCursor *c)
>  {
> +    int refcount;
> +
>      if (c =3D=3D NULL)
>          return;
> -    c->refcount--;
> -    if (c->refcount)
> -        return;
> -    g_free(c);
> +
> +    refcount =3D qatomic_fetch_dec(&c->refcount);
> +    assert(refcount > 0);
> +    if (refcount =3D=3D 1) {
> +        g_free(c);
> +    }
>  }
>
>  int cursor_get_mono_bpl(QEMUCursor *c)
> --
> 2.53.0
>


