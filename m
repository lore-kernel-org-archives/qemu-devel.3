Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF090C5DF7D
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 10:00:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxM2h-0006G6-38; Fri, 21 Aug 2026 06:00:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wxM2e-0006Fc-FK
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 06:00:04 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wxM2c-00058F-Py
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 06:00:04 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-c15f020a223so121777666b.1
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2026 03:00:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787306401; cv=none;
 d=google.com; s=arc-20260327;
 b=Zlt8LBeypinI9VyAQ0ZIeMBQIpzPXYOuXwagJ+o3RVlUYswsLa5ONFSKvumL0yT6X/
 LgocpZMA8kL7jfTt7SiJkv5EnYHhMx/MQBwx5zSwWleKrpohLZN0ix3FYM/4iCDexPCz
 bhLCY4QzjchNyz7Fx3xOjtmOg1MviRXBQj1jF7JhpUeBqALmPgOeEJQMIgU4XxH5nBpp
 yuJJLC8qn0rUmLu3WMKFe/BDN9kTGcuEs7MVDyxEXM5iNORcBIEvUD9TdKoJkHIi8acA
 1WjwVOaxs4XAw48Np7z12CkIyiEu7Bn6HHsLgBqE4y7losAFdwLO410kmiRDK0M0g3jH
 vBiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=NLNUtHomHjuU8sla5Cg0ixnUibViM4iZdx40Y5ImEIw=;
 fh=oR6KT4T9R4DzEe393lAnUFWLAI2XD1MXqDS3E+1BJZc=;
 b=B/kNB5P4hqLvVhY53pZ8vqDzIcQcMg12IhS+hlqg5gcEUWJ0U8+lCvANgYyu4qUHSL
 LxBL0FdZQEddvzugriaZ8kYKzeZOymFWDaq7sTibVBxN3u99U4Xshu99nn5HG4/FzRWy
 /XjEapw0ZJJutIcCUAAiu6ErAt8HcjwjvEX6anB58NArc16rxK3P4ttTbKpe0Gw5kbF4
 +wQ8Qu2JRjazjdM+F9IVwdXl3VduFLNWQoYrLZ9+Hw6UlcHZsXqZwoneowNWwn3o3tDH
 VNgw5tOZQmdSy372/w+ccNyHpoS1khrCgdT5/3aASfv7eKxniN1BAbmfpHFHc2LhOnES
 w7mQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787306401; x=1787911201; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=NLNUtHomHjuU8sla5Cg0ixnUibViM4iZdx40Y5ImEIw=;
 b=J67bZdN/fpEvPe82liefb1kciqqq/kg4YBg42BhyvGpPAZULDBz6SWw7WlphDOmbfB
 QrnyyzU0xTXhQ13+rEOfo/PDLKJN0uCTjreNfhxhmW//HYORkyx9F7rpgURObRJA/dGD
 PIXYYJn5BmhxyW+trF/MO+nq1Pk3VA9zrHfwajqfhjE6IYIZPxXPgILTYziBmsLuVa3f
 hJ1LAFE4x3Qx3DtPRRi3+AixIQmjjFNwR+IxvXOVydXX4aUgAXvFcxhcSj3CEIfLZGKB
 jJ1AD+f58U3+YpUQlkSi7zZ9p8YPUupTgy98paLvytwGPcvO/1ELxN2I+llCmAC+A9e9
 YtOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787306401; x=1787911201;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=NLNUtHomHjuU8sla5Cg0ixnUibViM4iZdx40Y5ImEIw=;
 b=MMX0SBlRSRRarfqwpyEd3eWDrszTZZ0u1NzaDx//kQlPlRCUhWozD7DdvboS7u971l
 rrgcQPgW/7F52PYXJSygdkz1C5GSKXbamFTfMuRjcRrGsKoY5DCx8gsjHsSOXQl6NfoF
 zmuzrKWCZnEWvdhjbqA09xO0dxjRzclGXHSR/3gIWHX0HqNrwCIUghc9OJFB1yL3UlHe
 eLLbTmu41040aS5qK1uYPLDLKyXWNgbrO949SaY9exJmN0Fu3f6PWZ8p4To5dcbtj6V7
 izElUqepD03ih0xJxYCx7EeZ4WMH0ktqIvATA5ok21sZzgzW/QwYrW2Sv5iJhIsvDzS6
 pp9A==
X-Gm-Message-State: AFuF++lhMKgLJKHCViFx2/GTd7Ls301k/KkIjEjsk0PpSXzG15C2c1RL
 C9I8LiEyHFx69G8ACIML8TJ0gsb7iJ/Thx+2RTg5U3y4QcR2jNHeOU8ZTHxgE1OI9N5BpE+uvIN
 7FcWRROqn6gv8PJVlWxznnBLOjOKpYto=
X-Gm-Gg: AR+sD12PhC3LOXwb8JdrfBBeRDk/GtrXUKio/eFvcRU6WsW5VegDVnBUmsGOXQW+SN7
 IOBwfEPdu7sDyohskPkF/7HOcAjASgV1xqJJOaFYD1uLG7j/ZvlffOtPiY4P74OpHMaEFiEfZQz
 769bnFgOCNTJiWLpM6ABzToEJ3bgPqL4U8ya1aB6GmSp8C08XSVv9GTet3zFPuPAukGBnw07As6
 knLP/fv4Wnph+fZeH9raaf5LBirVirzkvT9IVTexEJMsTjiCM9IBFRG3e3e/gBrQt/BbvoMTNfz
 vpD80z1fsi3YY3TtXovNFKzODeLRipWIR62DsCZGsfI=
X-Received: by 2002:a17:907:e00c:20b0:c20:23f8:99a5 with SMTP id
 a640c23a62f3a-c246a6a402cmr392704666b.15.1787306400884; Fri, 21 Aug 2026
 03:00:00 -0700 (PDT)
MIME-Version: 1.0
References: <20260814174830.1691540-1-zhangckid@gmail.com>
 <20260814174830.1691540-6-zhangckid@gmail.com>
 <20260819183157.GD222512@fedora>
In-Reply-To: <20260819183157.GD222512@fedora>
From: Zhang Chen <zhangckid@gmail.com>
Date: Fri, 21 Aug 2026 17:59:23 +0800
X-Gm-Features: AcwNN1VvnXyy4YLboT107zzu91SsRA671XSD22LFX0bdEyNIyuYYv3dVY3mhEmI
Message-ID: <CAK3tnvK=yWL+uV=u2FCM6sg-QKOasQBeGAohq8Ahr9jysr0CyQ@mail.gmail.com>
Subject: Re: [PATCH V12 05/15] block/export: track IOThread references
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Jason Wang <jasowangio@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=zhangckid@gmail.com; helo=mail-ej1-x62b.google.com
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

On Thu, Aug 20, 2026 at 2:32=E2=80=AFAM Stefan Hajnoczi <stefanha@redhat.co=
m> wrote:
>
> On Sat, Aug 15, 2026 at 01:48:19AM +0800, Zhang Chen wrote:
> > @@ -139,7 +140,16 @@ BlockExport *blk_exp_add(BlockExportOptions *expor=
t, Error **errp)
> >              goto fail;
> >          }
> >
> > -        new_ctx =3D iothread_get_aio_context(iothread);
> > +        holder_id =3D export->id;
> > +        const IOThreadHolder holder =3D {
> > +            .type =3D IO_THREAD_HOLDER_KIND_BLOCK_EXPORT,
> > +            .u.block_export.export_id =3D holder_id,
> > +        };
> > +
> > +        new_ctx =3D iothread_ref_and_get_aio_context(iothread, &holder=
);
> > +        multithread_count =3D 1;
>
> This changes behavior in:
>
>   ret =3D drv->create(exp, export, multithread_ctxs, multithread_count, e=
rrp);
>
> Now export drivers will see drv->create(exp, export, NULL, 1, errp);
>                                                      ^^^^  ^
>
> Before it was drv->create(exp, export, NULL, 0, errp).
>
> fuse_export_create() has an assertion that fails now:
>
>   if (multithread) {
>       ...
>   } else {
>       /* Guaranteed by common export code */
>       assert(mt_count =3D=3D 0);
>       ...
>   }

Good catch, it looks like the multithread_count only designed for the
multi threads cases.
Will introduce a new iothread_count here.

Yes, iothread_holder_id is redundant because exp->id remains valid
until after the IOThread
references are released. I=E2=80=99ll remove it and use export->id before
BlockExport allocation and
exp->id afterwards.

Thanks
Chen

