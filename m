Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 931A9C88E75
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 02:26:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6fL0-0007n1-FT; Tue, 15 Sep 2026 22:25:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1x6fKy-0007mh-3d
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 22:25:28 -0400
Received: from mail-ed2-x10.google.com ([2a00:1450:4864:33::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1x6fKw-0002uZ-Lp
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 22:25:27 -0400
Received: by mail-ed2-x10.google.com with SMTP id
 4fb4d7f45d1cf-6a9adea43b6so644314a12.0
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 19:25:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789525524; cv=none;
 d=google.com; s=arc-20260327;
 b=A9d8PvEUvKGkBRI41VsbWSUcp6Kn4JVmtW8ZyIi5FoQtVwet4vKymxQwgslFFBa9EP
 dp+dL28XoxIewCQZUCRF9k8MQMfLc4nUKVS0S/Y91svOuS2my1wARknM1/zA311nH6bh
 bMR/VORXSCz5pHIWFZ3C2tck2PKRL2q4tLxe8NhTYQqIesDiNyPV8GfIMQAup5RJ3wyZ
 XaMYDuJlyNASlVjaZWB86GD76ebuo8BrkEz/onpbcmfA20diHaMu9JOiAWltXhXELWNE
 y+1j66gJzsRcp28Nxg/vKUFqJZH8fzOrpQMJigPatzskzoU5rljh6q3Y/spy5KX0EewJ
 ByNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=+4RASN4GufKsVt7h4kNo+IZYFuJ/385dlWbfURbX/UM=;
 fh=wGZeUYt39FdrjiyDvngBMA/6KW8toEkLMWKs7FzaIuY=;
 b=pmDGMB+Ws/1dXX1DoNsym+CRV0sCrCovCqbRcBDVyEVjayooQ5qUyE2CIPEwyRshRY
 PLTN1ZaZg4R3DUwVt43GuMsFJaIW/v2c4DVRj6NyokmS5pU1yyQa7gILh9pePYzY68z+
 TLr8l57106VztOrkv31m65UJnpXW/s8ciVawodtDW6XXn43SlIY2MPeWgUP6Kep3aAaI
 tlWxAfZeZj0h5vUrgE0fAkAK2ZstCmpNzGH4lcuQ21I6e+bno0dOJSjGYatPBPdqrUta
 SoH4nhOnXS4R+G5an1+MW3IXDyFYqjocbHWQQ09kLVZkPX6wMivFl1CL0xTJ3Eis58P4
 qTFw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789525524; x=1790130324; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=+4RASN4GufKsVt7h4kNo+IZYFuJ/385dlWbfURbX/UM=;
 b=d9PPpQKlpqwcKZyTbCi16Ibl9bM/n3RD77tz+LK0GcEvEpkK/+GXcxNJOedrRFJEns
 Jsr9BUdfmns5Es86yfD+FIHGvRpjbbcCInvcEsgV0wL2dvMSAgzTiaQl0xRx1XZswweY
 tyBdCe4+drPPUA5CxXCnLtTjXJi3wXCPkS0d5lUP8goNXgcto1kmdm4L2digcXgFbUPi
 BFLoKFTNQh7xULlpQba9LrfKqly/oXZJckZLhlmtJmJLUxP83FPZjIKutwMKSEI5YElB
 s7Ird+hiFl842b/IbscbxGsUGsZ5MFW7WUGEa2E7xPJGbPgQeGWf6HN6RwpggO+ZXHQX
 oKuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789525524; x=1790130324;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+4RASN4GufKsVt7h4kNo+IZYFuJ/385dlWbfURbX/UM=;
 b=N0ITBJrLkV0NeRywdrO/SYcG4GUASxx6DN/uD42Fc5gnwogSDRARpwJXcTN0YDST0g
 Vd8THcScbvdSW0yqOakfp1Z6J32ko9Eq4X4+i1xdGVrRvaX14cX1knmSvzOLB4arafgt
 D+yLwS1ZMVblja/qOjFJUF2Lwgqle97i7p0rnJrK+gRVji/SR/1ooPvNxdp5E1qpeeFr
 zrT9112i3bkXlCWcM1bw0N0YKqAAvHJ9DZC0arEZaFZDPSgyDbk1sYNzj1VswL4mvvLx
 5cqdhJXIIAYLhBejdjGW3AE5x8y3OhmaJdQ9/XQHe6WWV1tr1hp3TKQcBvaCBU1wAnSx
 kQQQ==
X-Gm-Message-State: AFuF++k08yTXMY4PeUX659qSrLqv64KzKsCIFeZ9bgG8bd/s+No4LDYK
 ZhNZfasvHHnmh+Od0rNMQ0mo4AbV3QVq/t69uq+r8tEvSnC6drkkQrsrwhcDjJozJpt1mZ89FO+
 NNgSiWRJHaE1/Uyj0SquhYoZrSKbZ3hM=
X-Gm-Gg: AYBFou3FYeBWJy/bynTOrNc6RA1lYQ2yqBnMOif/3CSDxLHuVkIFHnay1gaqRWlW0Xs
 l8bDtaezk2spPptduK+jWuwm67mpa1AODWDEix7jJxURlVw+CrpDdwf7OqIoy7NKp+Ji4zFuUfp
 VIgofTyZYWIvFdSpv/E+sLoCOJec7y/8BnswNJCAEp2AUOeOi2n97HMcBw1Wv9Akz7ngosXmEv8
 ZG7WPuo34ssjVKMWXgSqH4tE2d0oNAJD236s5CK8fL6Na3oY6I5AaqX82OXU0ff73SV2xTNeY7z
 qStFgxmZ8MewqW3TP/0AIWZkdB2Gegsao7cb4b6x6RGp+qAVt1pQMaPnww==
X-Received: by 2002:a05:6402:4616:b0:6a7:ea54:38e with SMTP id
 4fb4d7f45d1cf-6aa224172a0mr426597a12.31.1789525524192; Tue, 15 Sep 2026
 19:25:24 -0700 (PDT)
MIME-Version: 1.0
References: <20260915101655.3216101-1-zhangckid@gmail.com>
 <20260915101655.3216101-13-zhangckid@gmail.com>
 <87bj9yrda8.fsf@pond.sub.org>
In-Reply-To: <87bj9yrda8.fsf@pond.sub.org>
From: Zhang Chen <zhangckid@gmail.com>
Date: Wed, 16 Sep 2026 10:24:47 +0800
X-Gm-Features: AcwNN1WeGBTmiyGJFaEIEo2-Kh9SR2aPvspHIEbMp-uNB2yCsz39C1bCHqu28Es
Message-ID: <CAK3tnvJa6rwyQWTYRQr3Zv7V95_PaY5Abi8_Ndwv4aw917USQw@mail.gmail.com>
Subject: Re: [PATCH V17 12/13] iothread: make legacy AioContext getter
 explicitly unsafe
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>, 
 "Michael S . Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Jason Wang <jasowangio@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:33::10;
 envelope-from=zhangckid@gmail.com; helo=mail-ed2-x10.google.com
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

On Tue, Sep 15, 2026 at 6:59=E2=80=AFPM Markus Armbruster <armbru@redhat.co=
m> wrote:
>
> Zhang Chen <zhangckid@gmail.com> writes:
>
> > Now that holder-aware callers have been converted, rename
> > iothread_get_aio_context() to iothread_unsafe_get_aio_context() and
> > update qmp_x_blockdev_set_iothread().
> >
> > The block graph retains only the AioContext, while detachment happens
> > outside qmp_x_blockdev_set_iothread(), so this call site cannot provide
> > a matching holder lifecycle. The new name makes its existing lifetime
> > assumption explicit.
>
> Suggest something like
>
>   The only remaining user is qmp_x_blockdev_set_iothread().  It cannot
>   use iothread_ref_and_get_aio_context() as is, because it ties the
>   AioContext to the block node, and iothread_unref_and_put_aio_context()
>   would have to be called when that tie is broken.

Looks better~
I'll use your wording in the next revision.

>
> > New code should use iothread_ref_and_get_aio_context().
> >
> > Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> > Signed-off-by: Zhang Chen <zhangckid@gmail.com>
>
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
>

If you have time, could you also take a look at the remaining patches
converting IOThread users to the holder-aware API? I'd appreciate your
feedback.

Thanks
Chen

