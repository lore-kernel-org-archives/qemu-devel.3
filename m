Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95D55C79FA0
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 08:32:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3rEi-0006TO-U1; Tue, 08 Sep 2026 04:31:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1x3rEg-0006TB-PX
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 04:31:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1x3rEe-0006dj-Rs
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 04:31:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788856278;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6S3WwBXAO3+K05ownmDV0Gb2hLBw2kuyviqC7B/n8Ck=;
 b=TQ5gVBE78ZYb66kc2IXI4pHEB74mhQZnXO9AQ3dIVqxF5Ql6wSRCbJCf52PKz/ncjyzViR
 +VN8v/Xeo8Zp4ha/dtSCaP6Kyijw56DYhNp1opIc0AS0zQRJyo7bb9cd7gq1O/7wNLdAfF
 d7pYNMqjYLwHVU8pgxg2XP3r3zsbJgM=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-190-17hvAqVxPduNY997a02Zlw-1; Tue, 08 Sep 2026 04:31:17 -0400
X-MC-Unique: 17hvAqVxPduNY997a02Zlw-1
X-Mimecast-MFC-AGG-ID: 17hvAqVxPduNY997a02Zlw_1788856276
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-396638f9a18so2933939a91.2
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2026 01:31:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788856276; cv=none;
 d=google.com; s=arc-20260327;
 b=OiOz/Tj4sMYdVBqL+0XWQlFXZJtG5pLU2NJk2MmZMU+ZU71PxSrFnGbfunQH1+mv4n
 f7NpLBOqc/YzWU2e7HUjiyn0YfTZXj+BpdDTeh8OdPuH1syq2y82pRv6KbttrxTD88Pw
 VKNX60XRzFzA1NWfSst+YpByeBJA5M0lqXmdofaXuShwe64FuD0yH5nFzAYsBZUbF33K
 n9RvlPlR4ORH83i9l3bFZ8DGvBfMN89w/Ec8+ika/l+6HbKcs+bTsi9lciI45kVXoo9G
 DuURZrPIZB6IxwvltV2JfAYf+R+t9ygKrFKHCLJoTd/lXhrJ1LC3Y9XUFQEu+kiiFi5E
 /ESg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=6S3WwBXAO3+K05ownmDV0Gb2hLBw2kuyviqC7B/n8Ck=;
 fh=W6CxA2oz1yGR/6IGrxMgKl47k/4n4yGwHaf3TFfFPco=;
 b=lgqyoMj2YmAOJOaL6Ps0/cAXL63GZQ6dBJgOtezjr4rHwOBMl2zrmZf4+Tjw4plImP
 WwGyVCcwWC4UKvRg/mfvn0A7PYR4jksyadanC9EjLr8uS+xFaFpeQZ2ACGQiEZkCANWd
 0CWqgLceBCMeLDd6P1mNbsXxqMTJ6gPaBAbBGfsieRmvvIYTKjQ+BuulDlUUnfEMhefs
 1muR1dz6VutrKhy+CIT1EvZZ5fSgcZ5StlMd8rTrn82dX1XKfsOdqBjYXdk32Doswjt4
 wmagwUWcTf5u8IKFm5JzPfsXJbg3zyb0cYz4u37VsvKrSmGK5hklYL91TUDufseADBlJ
 3UtA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788856276; x=1789461076; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=6S3WwBXAO3+K05ownmDV0Gb2hLBw2kuyviqC7B/n8Ck=;
 b=HH06uc/Ibg2XUq5rJ2P3HmLSRbhoYPo0Sj6qVAQy7xjyqA+TS7Q+8UMmz16TdWas1x
 Y7GvgMJrPni/lNAXSqI87/NnovzakMPKl9M6Bs8ktvqW/kYAdLCso3YAkqME5ISe5Typ
 CMe/txBxYrgTMJ8yGzSeRsqPOhVYDcXS+JqQqT8XJJ/Won7w3SJfUNEbj+dYwYRMGkPM
 TXhLgg3vnSOqsiHxofn1T1y7CSxgzPfFRwhWY3XsyyCB+EAwzmHWIeaTDmzT8Ne1uyWY
 VUhC0x7xrwwBCTGYChGLyO7+oW+WOiFYIAyAEfYFNZZhp+L8Tbt6+b0DNawrO4b6QJ/N
 /TqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788856276; x=1789461076;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6S3WwBXAO3+K05ownmDV0Gb2hLBw2kuyviqC7B/n8Ck=;
 b=kAypKjI3zqvD9H43Bl6UFSTZXr4DOSHVbW8dWnF+XTyFPtNCdjgsMq4xzIaXVOlaUB
 xlVa57AGlNEgFbpm5fdy0tYsUpK3CfY/w+5oAqiNYEQKrf5M9c1AHyZzRa/UOcmez94L
 RAZyxvK0FRG1sL8wJyn/ZWa7KehMOSPfnvCf8wsWNK9Y0FXfczYxY7HtUrZxT2TdfVo/
 qMI2F/oIU4oH9nDlh21BBxRazcNFRZ8uHek2E72O0HUEYGE2kxgpWVu8DH1GJeAruqAn
 ri5gttYcXe7Di4rLmWjiEsJJY7KmBckAQ6DVjtaEgtbxnckQaAuCgKO/r7rGCP0jj/qA
 2xzg==
X-Gm-Message-State: AFuF++lxmHc8g2YKBF/DRWIEBxCZ27idbmGP08NQIPV6qKKsdS9ixV2p
 qQncuTTW8oL6EjRGA2KaZu6wim4Y1cQwUnHNcVlD0Y9msIGT+FYXvMo/N5yXTLno5Q1j1qme0Xf
 0U9I5bkaSJjrNn20OgB1II4Wju0hCFRwLgEIsStTrlG6dX1M6GKed+oZEG7ejUaIk3APv/SpAbV
 GARGfq02p7zu7c0Ff/1dYYuQmJsPD33ic=
X-Gm-Gg: AYBFou0sXwJtaTesso1B6YhxjYZNf8p+AbBUGO9jZjE8N1xW7jw7pajXBTVXQzMN/qG
 vMfFrKbibqsJ1sC45i/3h6TsUj4xNucAcGwldS83OAQ5Ih7jNKVnO45xRHLhTwlWWkdP0yWRlly
 tskUWoD3xA9k/jVlM/NrtZbTk079osGgJETDrRh/0n1Mp8uFChNnR2gc6GoHDSfmJWuJl4UC5u1
 OzmmkcNuv9JPjg7Dq9hlPPd3O5p0YjKNA9fGBVkuf4yQKkybmiqBS7bh2DcLYAWCi/944aY6waI
 uA==
X-Received: by 2002:a17:90b:5844:b0:398:e436:370 with SMTP id
 98e67ed59e1d1-39b260ff0e9mr43930597a91.2.1788856276044; 
 Tue, 08 Sep 2026 01:31:16 -0700 (PDT)
X-Received: by 2002:a17:90b:5844:b0:398:e436:370 with SMTP id
 98e67ed59e1d1-39b260ff0e9mr43930517a91.2.1788856275281; Tue, 08 Sep 2026
 01:31:15 -0700 (PDT)
MIME-Version: 1.0
References: <20260907221838.519111-1-rtvernam@gmail.com>
In-Reply-To: <20260907221838.519111-1-rtvernam@gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Tue, 8 Sep 2026 12:31:03 +0400
X-Gm-Features: AcwNN1VNaOIeiYp74hi_hA5Wt0K9xnz4usjkVi011vvz5JP6mlgXbqonP7bQCPM
Message-ID: <CAMxuvaxP-4WhUtue3J9o946t_x308r09KtE82Wbdb2Kx_tZZMQ@mail.gmail.com>
Subject: Re: [PATCH] ui/dbus: skip GL scanout dispatch for placeholder surfaces
To: Rick Vernam <rtvernam@gmail.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Sep 8, 2026 at 2:18=E2=80=AFAM Rick Vernam <rtvernam@gmail.com> wro=
te:
>
> When using -display dbus,gl=3Don together with a virgl-capable video
> device (e.g. virtio-vga-gl), a guest-initiated reboot aborts QEMU
> with "dbus_scanout_texture: Assertion `tex_id' failed"

I do not observe such crash. How did you configure QEMU? Can you
provide a backtrace?

>
> virtio-gpu's device reset path blanks each console via
> qemu_console_set_surface(con, NULL), qemu_console_set_surface()
> in turn substitues a placeholder DisplaySurface.  The placeholder
> DisplaySurface does not have a GL texture.

Before calling gfx_switch(), it calls gfx_create_texture()

>
> Other GL-capable UI backends already guard against this: both
> sdl2_gl_switch() (ui/sdl2-gl.c) and the 2D SDL path (ui/sdl2-2d.c)
> check surface_is_placeholder() before touching GL-texture state.

Not for this reason though, afaict. (for secondary/disabled screens)

>
> This patch adds an equivalent check in
> ui/dbus-listener.c dbus_gl_gfx_switch().
>
> Signed-off-by: Rick Vernam <rtvernam@gmail.com>
> ---
>  ui/dbus-listener.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/ui/dbus-listener.c b/ui/dbus-listener.c
> index 2e2f6ba418..5f627f6acf 100644
> --- a/ui/dbus-listener.c
> +++ b/ui/dbus-listener.c
> @@ -861,6 +861,9 @@ static void dbus_gl_gfx_switch(DisplayChangeListener =
*dcl,
>      trace_dbus_gl_gfx_switch(new_surface);
>
>      ddl->ds =3D new_surface;
> +    if (surface_is_placeholder(new_surface)) {
> +        return;   /* nothing real to scan out; avoid dereferencing a non=
-GL surface */
> +    }
>      ddl->ds_share =3D SHARE_KIND_NONE;
>      if (ddl->ds) {
>          int width =3D surface_width(ddl->ds);
> --
> 2.55.0
>


