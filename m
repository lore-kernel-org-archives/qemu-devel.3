Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DFB4CD6E4A
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2026 07:47:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUJpr-0005kL-UJ; Tue, 02 Jun 2026 03:46:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1wUJpn-0005k7-Lu
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 03:46:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1wUJpm-0004d1-3i
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 03:46:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780386403;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GnEDWNfuGivK+l/gcWshooRNmPhD8b7WChDPmUClXac=;
 b=USIaAQDhqFFpDZr71rlnmpXXwDcAU1cLfJ3tJB8q4Zk9ibKpE+4ajUPkUiFDUoHE6nJ09i
 z7xGHO/VNPgTYIuTfkz/J1e1pb2ha4ycJfEQUpop9km1dZBKVfLlgFuGS43zyTqnmDWyMf
 O0gdql4eF1C1a/G9m4OF7Si9Ck9JOp0=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-q59bmJPgMYSpc4czaYA5bQ-1; Tue, 02 Jun 2026 03:46:41 -0400
X-MC-Unique: q59bmJPgMYSpc4czaYA5bQ-1
X-Mimecast-MFC-AGG-ID: q59bmJPgMYSpc4czaYA5bQ_1780386401
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-c858e0cbca3so1384995a12.2
 for <qemu-devel@nongnu.org>; Tue, 02 Jun 2026 00:46:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780386401; cv=none;
 d=google.com; s=arc-20240605;
 b=LWtpGIG2zIAxMVpz1xGgba45qnCOtMk+MapkfyEI6ilDA92vOJecmLXlJCmkbsrNp2
 vtY3kQfSspz0VUmCafAzuzkr6zCcRg78+zXcaA/lh7hwGeARbMquRbPaEt8rJXUdVPo6
 rB0VfIPFG911A+57Oj6CMhmnFtpJ6P4BVhfsaLdmVxpo23S+Tf+SD/EbhOFq0Om/Qmq/
 Lfh+CXe4nWGMS3mwIPOWdf2Pbzh6IoiyEafNc52Io9EO2b1xZp2mFC8vh250r0JD6ze5
 yprEoxihvRMaFk6kUJSHnByeTRrpNJNR+NTRL7cD5F+Fuy6/g+NjDjWibyuPWmtOQkjB
 WTMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=GnEDWNfuGivK+l/gcWshooRNmPhD8b7WChDPmUClXac=;
 fh=LqpePVgselldIVeUkALIlKs781OoCu65m8aG+GccTF0=;
 b=LMjI59SIpwWL2o8/BxKy0/hJ7BUNfE4E1gGXu6aocWkkiKKq+UrvR7EcS8A07e7oyL
 +HG3sxYGz0kcqw7yfEKraSflgdD3FGJcNaNbYilILqk1z+JBLNZrWtwMQdijtlUD6IWj
 cpgmHppfXYWERsO5xFMnadK2BLNpUeV/emdEqme3JxSD4pMDllZK+N0lW8FzCZHvzeRw
 K+i+UUtTgAtw0A785yKMgQCw4DGJxwDsRLQHC9eQGVOKFJnl5K2ZY5IULm1nYkJ3dFTh
 kVtqdQGkl8N2BF9sVlUOGPS5IBhf4kHVuL8TNz5PAfY8czL8WTKTSXzT6LxgmbQuoaxN
 RbOw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1780386401; x=1780991201; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GnEDWNfuGivK+l/gcWshooRNmPhD8b7WChDPmUClXac=;
 b=Fo8dQGiCsoONCLYm/nTxiR/4te5h2RPCjpXUfvTSJhb1+W6NRedksjB4Jie4rC3DAG
 AWMgDbKntGF6BXC+wRCRHGYADDlpyjXhgKOghWNPPmb1S5FvNoQbkT3uoDdcOWdNotF/
 RWjs9N7w1x/igSTY3iPHfD4souFyRsGp73Mn0KiVJD6VjFRKIk3n40+UQ/agjrADdrQV
 GpMuSn+kvQn69XTkSnmcYP/ymKqt99QdYwxc/y1F77k+unxn0cLelxvC6MSjX54ilWbX
 EgyrkMqTv/CtccfX5i5cReQDgeaxhzpPm1AeFEBQc6j8taThQpJjUTXep4TsxzM6Y39A
 NKGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780386401; x=1780991201;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GnEDWNfuGivK+l/gcWshooRNmPhD8b7WChDPmUClXac=;
 b=K2Pp5L50nxVm0agL7RmqB+QVWp8GJDEf675dU1MuV36QwIY1zNKFzJWp8DLUKuhN8d
 72EcHuUchgainIIEv2cOMKE+BreoCsg6vxs7+cuf2py08dIL0121gBlDzFJUeMs9+gR8
 VJ3t9FnQnFRPITiRGVVaf/Yhkh0ZUWCdFOumwbDI8xz4mX0Q9MyAnmPWe66q+qI5Zq5z
 WHiLrQbBnOgKgVk8h0v3NAUJQW8QhIRS+LFvVDn+Rb9zf1KYSLD9+F/Tgxxwov3WCs/4
 TKDehNPik9yg4y8+lvNZW3bk8YjLyDPpU/KGrq3Dgo/zxFmqcf+xYa7m+wOgvg68XSNd
 g3gA==
X-Gm-Message-State: AOJu0YxsRss7jHXiurcfyF6vSht/CJ0jUj9s4eJog/iG/n6yVpQTVnKo
 i43vVEOC3DaAjn/IlGj3PVEbZrsuVr8zhpPD1TBknrnxHzVkvdmy3rgX/8Z4P2ss+VZhF0LdxsP
 +14eqQc0WFo/koJCmFdBPZY04qrxYFwyJlZfmplYey8TK6wOrvOANPhbWiIe8sydI39z033ekn/
 poRoQ4EBqUYp0xr+UCz/klg6ETjq8wG7MT15e7Q1jjI8Mn
X-Gm-Gg: Acq92OHnQ79Xd0MzKjPORmovp2sthvaGbjhf1TsZPsn4gTVQZibjWn8GQzNaazbeGgu
 VfxyCEMnJeQ41WU16ieQCAsMR/CWRM0Rn5Puu+ebV1mZ/KS0l0DtUhhGzN1idC/BytR0p3vMVyF
 vYPHwKnj5kZWVvZ7xCCx+Fw4lN1bUKnMqFlHT0deQ+Q2zcB3Noyekkb0FeDzCHuMj2Q+SSGSFrL
 gAjK+ZnKOf4nRbN+HPlEyNoDg6izyf3RxDQYDTCO0++5WBLBKyc/od/Fp0egHiP1erpqlZCc17A
 E1In+YJiMjDVC2okAakBZJr5+udwQ2bGaw==
X-Received: by 2002:a05:6a21:9207:b0:3b3:fc6:6226 with SMTP id
 adf61e73a8af0-3b4280696c4mr17600702637.24.1780386400566; 
 Tue, 02 Jun 2026 00:46:40 -0700 (PDT)
X-Received: by 2002:a05:6a21:9207:b0:3b3:fc6:6226 with SMTP id
 adf61e73a8af0-3b4280696c4mr17600664637.24.1780386400099; Tue, 02 Jun 2026
 00:46:40 -0700 (PDT)
MIME-Version: 1.0
References: <DU2PR04MB9018BB3650BA218438C01F2A83042@DU2PR04MB9018.eurprd04.prod.outlook.com>
In-Reply-To: <DU2PR04MB9018BB3650BA218438C01F2A83042@DU2PR04MB9018.eurprd04.prod.outlook.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Tue, 2 Jun 2026 11:46:27 +0400
X-Gm-Features: AVHnY4IQjkJh5jcvlCgyVDYsOIoiHukkS8hjq6zvVs_OX-6KdtXaG6pSfkuRack
Message-ID: <CAMxuvawfc1jqNHhf9fpmFQxuHQCw7+HPvRVQQJ5omVHL4tmFcg@mail.gmail.com>
Subject: Re: [PATCH] ui/sdl2: Set GL ES profile before creating initial GL
 context
To: Ryan Zhang <ryan.zhang@nxp.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, May 15, 2026 at 4:31=E2=80=AFPM Ryan Zhang <ryan.zhang@nxp.com> wro=
te:
>
> From abfc1a95936dd832fc2ad9d64d4e3f3880c697e1 Mon Sep 17 00:00:00 2001
> From: Ryan Zhang mailto:ryan.zhang@nxp.com
> Date: Fri, 15 May 2026 19:21:55 +0800
> Subject: [PATCH] ui/sdl2: Set GL ES profile before creating initial GL co=
ntext
>
> When the user selects GLES via '-display sdl,gl=3Des', we need to set
> SDL_GL_CONTEXT_PROFILE_MASK to SDL_GL_CONTEXT_PROFILE_ES before
> calling SDL_GL_CreateContext(). This ensures SDL_GL_LoadLibrary()
> loads the correct GLES driver instead of the desktop OpenGL driver.
>
> Fix the below issue: qemu-system-aarch64: /usr/src/debug/libepoxy
> /1.5.10/src/dispatch_common.c:872: epoxy_get_proc_address: Assertion
> `0 && "Couldn't find current GLX or EGL context.\n"' failed.
>
> sdl2_gl_create_context() already sets the profile mask correctly for
> ES mode, but the initial context created in sdl2_window_create() is
> missing the same treatment.
>
> Fixes:da3f7a3ab9ea0091955b58f8909dfcee01f4043e ("ui/sdl: try to instantia=
te the matching opengl renderer")
> Signed-off-by: Ryan Zhang mailto:ryan.zhang@nxp.com

lgtm,
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  ui/sdl2.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/ui/sdl2.c b/ui/sdl2.c
> index 4fcdbd79d3..9f826afefb 100644
> --- a/ui/sdl2.c
> +++ b/ui/sdl2.c
> @@ -113,6 +113,8 @@ void sdl2_window_create(struct sdl2_console *scon)
>
>          if (scon->opts->gl =3D=3D DISPLAY_GL_MODE_ES) {
>              driver =3D "opengles2";
> +            SDL_GL_SetAttribute(SDL_GL_CONTEXT_PROFILE_MASK,
> +                                SDL_GL_CONTEXT_PROFILE_ES);
>          }
>
>          SDL_SetHint(SDL_HINT_RENDER_DRIVER, driver);
> --
> 2.43.0
>


