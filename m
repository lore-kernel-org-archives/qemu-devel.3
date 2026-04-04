Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09D86D7308D
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Apr 2026 14:01:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w91Ye-0002K8-TY; Sat, 04 Apr 2026 10:01:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1w91Yc-0002Ic-W1
 for qemu-devel@nongnu.org; Sat, 04 Apr 2026 10:01:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1w91Ya-0000nn-Ij
 for qemu-devel@nongnu.org; Sat, 04 Apr 2026 10:01:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775311257;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h1jXOVmA0PwK0EiBiZlyr25HR1QpK8gDV3TZSiSbfsI=;
 b=g9PBoCRU2SM6LD81KzJ3n7fzw/oFCmJCwT49pDuXuWld76f5//Yxz69zm0//gSXhXNYFfz
 hb7I/gcTE/PLxf+XXOrWEen029+NM+Zr3cvjaHLwb7q9RwcW+E97Ph1Qm0OJvLqvM8PKTN
 IRisf5wAUcgKVdX0Xwpl1PI2DAMzCjQ=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-106-C3PpNP1_Ogi0M6R6dhIkDw-1; Sat, 04 Apr 2026 10:00:55 -0400
X-MC-Unique: C3PpNP1_Ogi0M6R6dhIkDw-1
X-Mimecast-MFC-AGG-ID: C3PpNP1_Ogi0M6R6dhIkDw_1775311253
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-358e95e81aeso5682741a91.0
 for <qemu-devel@nongnu.org>; Sat, 04 Apr 2026 07:00:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775311253; cv=none;
 d=google.com; s=arc-20240605;
 b=VHXwHoK+eAR7Jwio0Xch4daODin96p4bSubej66gwjWHxj8eouvXXhHK+ao3Ql/8UV
 klHfqAuF6Y+wlOAPjPMhFJ0fB3oKb+MN375sfCr8E3lJzwc0OWLd8dmQxyJ2qIBObMmv
 RDf+5STQHynbVUcfabiHI0H/mC/daOWiFdJzYgU1ykrCIEttQgEsHDpQssIBuSTn5g7m
 ZOVWbhL7FJfoPQy0Xmgol9PQmdXqTm/w1NEQzBGZCLNgype2yT4YviYolhpyQ2VWZJ42
 4VLKZR/OVM1sntxhapgV3+0Y1xrHGC5wlHH7WjeblzYoJPxkJee+yU8UYp/hATkWV2FO
 ZTew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=h1jXOVmA0PwK0EiBiZlyr25HR1QpK8gDV3TZSiSbfsI=;
 fh=Qpl77bHkcE0bYSjiKXT9vs9obKUyn+uhBwvH7ERnfRM=;
 b=fmZxXSh5ZW5yfhGLxKXagZCKeL9oPvCGG6GJFVdyEs5t0S+I4SnzhtoIVmZUdyafM1
 tDL65LB1R0I1ylyMOn2IpXt9UIGDnWNudUY6Bmpc26ibvgJ7lhdPmLdzs15YVSHjnlVE
 AvEmPufelIdvxqK6DfW7f9OjCDv0zeyxSumQTRR0WsE+iWQMlul9Yg/RbqXucxlSKjs6
 v90NTJf7hb2QaZv516Wnd2AkEaEP7oowjQ8X8kRdpJiXmdUB3LH8/BIuNpG7BbkCG1vu
 UH5o8iC7EczVNWS0tWFlAaSwzNrLMJU2zZkJqpbpsb6rB5bkYUilbTCqwCVFycy/rtGh
 +Glg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1775311253; x=1775916053; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h1jXOVmA0PwK0EiBiZlyr25HR1QpK8gDV3TZSiSbfsI=;
 b=OwPypf1AiUu/3/V5r7V+xZPD+e5PGwc/Augb3kfauJuNCgm3PmGUa5RAsHaPbQuxA2
 8kBr0/E9EdS0Tjqc3/QSDRQLIdEAVOa3f0MDAVGVjVoz2WcEqcaJX/sqNGXdtc7Ifm1S
 hVIJOweCQ3jIhuvkYLessPwfYhklLNBFFPyfzSdFX+qKhNUQlYVvtOH+UzMFOL+8m/c3
 JUyBUD5W7gIJR5r5r6l5T5FzOuVD1UJGWD7mB9rKCsb382uZdj338b8O7myGojZ3QHji
 nSZN9dRIwTSm90G+SsQswiEd8VEIDJm4yZbOInmvEd1OQPOHLqoD4nClG4JTwjvj9SPF
 UQ2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775311253; x=1775916053;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=h1jXOVmA0PwK0EiBiZlyr25HR1QpK8gDV3TZSiSbfsI=;
 b=aevGK4sxvnhOWgaSBfDj/9BrA7PF/4O8vWPCa2WfJpuM8U4dotbppT5qfnnbMu06N1
 hqBitQyRBVPa+r3rYAj0spCGRlv9TuizX1o2wWZf+YJsoOgLNPmu0d2gv1SAitgiblui
 xRODAQlj23JbnJQGzITjCoc3bfZ2gCHJ+PH/jPkT9GzD/92EvnYAd0ljFzI69WBOk2Rq
 ByIdGAL5kkC1PNpb8aDyym1yrzFMPm9lg15RNWNX40EFTuAwBD+4b4Omo1Y1dCMZnIgR
 d4c5dSA40eQrWxXdiuQavjcNDvk0cZH0jvpdmDraCveyDPNj7tNcLsaCn6aHQtQOurEh
 OTMA==
X-Gm-Message-State: AOJu0YzBwcTUZ8Nn9JuSzjGg5iZev5B8wD973ZB7KND1d7Cf4OwZ5zk5
 E/1uh+HstdIQq07Jabwm44FAN/zrOzC7dGhpNAyKnLg29GJZ1hIV8dUIW+3ey1zoYDDoIa1C3A4
 UXG081Jth0Uz/ztGl8hFXinGBnYPQK0FYpaRm4YDDJQKapErecdW1Y0fNc4na20UZiZVeD3I9iV
 IbKLVo1Sonta+J+nXeYt90LjTMa6BYzbcHmJDiYMviMg==
X-Gm-Gg: AeBDiev70vMheQUvhYB2demronrf7ROnH3QU7gUiHLS5eDfU3rjUvSgS8nublaGFvM8
 fTo1EJ+noZMaYaH4ZYmAx4dGFMKhQod58t0+FkMSlkxk+1US4VtfySDwbkO6wwuitMiLRpUC1sq
 V4pehQJ4+o+6eCDTEgh7qkQTh9U6fh4Y/8UxmiTpN2zGhA95rgNEt5Ld6g8ZundytB3Dz2YMnc1
 ilVCESg5+wiYYuVDasu9nKEq0/Wzm3XeBkxdb3ruGhhVYiOrlWuOSxOQyB1ixgpWOU0wknaSUd7
 wIlEPH/C2v8py74hQBCnBYk=
X-Received: by 2002:a05:6a20:7d8a:b0:398:8f2a:5dd4 with SMTP id
 adf61e73a8af0-39f2ed97df6mr6610228637.8.1775311253118; 
 Sat, 04 Apr 2026 07:00:53 -0700 (PDT)
X-Received: by 2002:a05:6a20:7d8a:b0:398:8f2a:5dd4 with SMTP id
 adf61e73a8af0-39f2ed97df6mr6610181637.8.1775311252499; Sat, 04 Apr 2026
 07:00:52 -0700 (PDT)
MIME-Version: 1.0
References: <20260317-qemu-vnc-v1-0-48eb1dcf7b76@redhat.com>
 <20260317-qemu-vnc-v1-43-48eb1dcf7b76@redhat.com>
 <acKh84j4ANq-idUl@redhat.com>
In-Reply-To: <acKh84j4ANq-idUl@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Sat, 4 Apr 2026 18:00:40 +0400
X-Gm-Features: AQROBzBPt4Aty2mYsIay67TG-WjmNh0AJeNkWftdOiumHxgZb8smyZszTKV1twc
Message-ID: <CAMxuvaxcoD0tiNKtPDhZHebU5KDRGiEC+QRYkju1T-2FyoH+MQ@mail.gmail.com>
Subject: Re: [PATCH 43/60] ui/vnc: simplify vnc_init_func error handling
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Tue, Mar 24, 2026 at 6:38=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com> wrote:
>
> On Tue, Mar 17, 2026 at 12:50:57PM +0400, Marc-Andr=C3=A9 Lureau wrote:
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  ui/vnc.c | 12 +++++-------
> >  1 file changed, 5 insertions(+), 7 deletions(-)
>
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>
> >
> > diff --git a/ui/vnc.c b/ui/vnc.c
> > index 605e5117b7f..af5fb3c1551 100644
> > --- a/ui/vnc.c
> > +++ b/ui/vnc.c
> > @@ -4318,7 +4318,7 @@ void vnc_parse(const char *str)
> >
> >  int vnc_init_func(void *opaque, QemuOpts *opts, Error **errp)
> >  {
> > -    Error *local_err =3D NULL;
> > +    ERRP_GUARD();
> >      char *id =3D (char *)qemu_opts_id(opts);
> >
> >      if (!id) {
> > @@ -4326,14 +4326,12 @@ int vnc_init_func(void *opaque, QemuOpts *opts,=
 Error **errp)
> >          id =3D vnc_auto_assign_id(opts);
> >      }
> >
> > -    vnc_display_init(id, &local_err);
> > -    if (local_err) {
> > -        error_propagate(errp, local_err);
> > +    vnc_display_init(id, errp);
> > +    if (*errp) {
> >          return -1;
> >      }
> > -    vnc_display_open(id, &local_err);
> > -    if (local_err !=3D NULL) {
> > -        error_propagate(errp, local_err);
> > +    vnc_display_open(id, errp);
> > +    if (*errp) {
> >          return -1;
> >      }
> >      return 0;
>
> Unrelated to this patch, I'm wondering about possible bugs in these
> two init functions
> :
>
>   void vnc_display_init(const char *id, Error **errp)
>   {
>     VncDisplay *vd;
>
>     if (vnc_display_find(id) !=3D NULL) {
>         return;
>     }
>
> Why isn't a vnc_display_find failure a reportable error ? With this
> "return", the caller thinks we've successfully initialized the
> 'vc' struct but we haven't.

If "vnc_display_find(id) !=3D NULL", there is already a display
succesfully init/registered with this id.

>
> And
>
>
>   void vnc_display_open(const char *id, Error **errp)
>   {
>     VncDisplay *vd =3D vnc_display_find(id);
>     QemuOpts *opts =3D qemu_opts_find(&qemu_vnc_opts, id);
>
>     ...snip....
>
>     if (!opts) {
>         return;
>     }
>
>
> Shouldn't the failure to find 'opts' be an error, rather than an
> successful return ?

Yes, see the later patch, "ui/vnc: assert preconditions instead of
silently returning".

thanks

> With regards,
> Daniel
> --
> |: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
> |: https://libvirt.org          ~~          https://entangle-photo.org :|
> |: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|
>


