Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39860FE51ED
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 08:58:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGCMZ-0005Gm-Tn; Fri, 24 Apr 2026 04:58:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wGCMS-0005Fd-1D
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 04:58:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wGCMJ-0004K4-KY
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 04:58:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777021048;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=CjBtANV5LJakafNPsRmDAUm6PVbNsA4rWkS1MCJQKBQ=;
 b=KIbr8M01hohJyRsMJ5ilBDXYKbFFtSPir52nEQ+AUECMrjQY8aVgKKY2aQY+5G+k6OrmYR
 lFgsabrB8SmhHGFyKsbZZBpARlP4waGzdYuazm26ZAjlZLgK08eC5p25mIQK71bjVyswZW
 yHkPQK+6EeQ5crpvMe0XSG/DEZSbogA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-533-1PyWoYLOMpS1pJflo3gk0Q-1; Fri, 24 Apr 2026 04:57:15 -0400
X-MC-Unique: 1PyWoYLOMpS1pJflo3gk0Q-1
X-Mimecast-MFC-AGG-ID: 1PyWoYLOMpS1pJflo3gk0Q_1777021034
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-43d1fec59c9so4782245f8f.0
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2026 01:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1777021034; x=1777625834; darn=nongnu.org;
 h=user-agent:in-reply-to:content-disposition:mime-version:references
 :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CjBtANV5LJakafNPsRmDAUm6PVbNsA4rWkS1MCJQKBQ=;
 b=pR41Gf0q68PI8mI1eKP55NhKEwiDpgsOwUQQxk+ERxEGESacw1mk0U0D+OiKdjZ4SZ
 ekRNY/Ji7W1Tuxyg7r/3Nc7RGoMTrnb8x68F+FK1w5PvDen7EKAKsfGxKbeoegexIgP1
 QiwcFOCTMX/bp+9SdYL/c84YAWBQFAY2q7FBNzBbCdHLpW0lhMKFN7+jWdvB+pBJfCIO
 uSnjVpTZ/nWpXrc83gCdI7gz/gtyUZUvA2oG2aLhBeX/Dv7YpAJuZFR0xje5dR6R6p9E
 5d/oKlFEnWoeyoEFoKGRerg9U7Wgq2UmA/ANGNFPM9rz2fyX7ZO1NRBjvT5wLpkw9rQB
 b/Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777021034; x=1777625834;
 h=user-agent:in-reply-to:content-disposition:mime-version:references
 :reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CjBtANV5LJakafNPsRmDAUm6PVbNsA4rWkS1MCJQKBQ=;
 b=I30FU7Mb13SBtEWyVvagSN47FwVpcbgjIhotzQ9VLzAzmjUtWHkBA6YAVMgXq47Jft
 uqX3lXgLWhdPQfcO7MsunLxCxXrm2X4d3ATrTCBFujEkSCTztNjHloh3aixHmEk6+/mY
 HouHFtNwobM6c5yHRN3ImjuZKquUSSPETSs7Fs+dAgfZdC5rbSOT6U8G9PyNfQ9DubhK
 zHSnyms6RxxqHqi5GyY6YNbGxpF8BIgDAIu48DXSmRANl6Us3mDBxJZZfng2iUieM+Oy
 ck0DUqNJF47SfwE8n1UbRq0iNjGouEN9cPXfH0fzYzNzGoPS6D0W+2UB2xWydYAjMCQC
 YQtQ==
X-Gm-Message-State: AOJu0YyfsWxtD/KuUpwFHgCUcMic+gFvqpTgHX/aKQUrobCZFOsdHEAj
 4oVIBumfNI+G/nmiSCVrM5MLvy3Zxfxra22SvNEy7NUgSXBQc3JBS1eOq8m4lKxamARYudk4j/c
 MVdHDeDPV1xt7Vz7pQCkaj497etwRjmFu4m3+pXbgd4oqorJCWsuflOp2
X-Gm-Gg: AeBDieuSFwrh3O7u0lh0CuvIG04HdfatDE32S3U7+jWliofCuDOWBh9R3IHxFRys54D
 g6EpC3jdqk9G3u0g1JdbhCv62sHBARjtMP07AfOc/bZSAFwaRi5xXvMCWQoBoE/M6G+USzGny+M
 sgCiWadYmPLmcoVaaEmVMDWJvHSEnzFEX36Y08SqnoCZB/GBRzL+XiaRPT1ixguKP40IUJqkZ5y
 gm7/8GivYlcv8NeGs4+ss9RcDPvHNG2K0iQ7MLDSWq6ldk7Fxaz73W10pd4FLiKQceaeYO0NIYl
 yJw7X7LaJ3DSYH0Wxkivhe0iEYIq9/TkJ+IrnCpCwjRsZn4FarmCr7SXYycJZiVvkQT4PHQvgzx
 efP2dFwYylS2ewiE92uVeLcxFiW33LA==
X-Received: by 2002:a05:6000:2505:b0:43d:1598:2d6e with SMTP id
 ffacd0b85a97d-43fe407c3camr47587600f8f.20.1777021034019; 
 Fri, 24 Apr 2026 01:57:14 -0700 (PDT)
X-Received: by 2002:a05:6000:2505:b0:43d:1598:2d6e with SMTP id
 ffacd0b85a97d-43fe407c3camr47587561f8f.20.1777021033516; 
 Fri, 24 Apr 2026 01:57:13 -0700 (PDT)
Received: from redhat.com ([2a02:8012:f011:0:f1ce:ac56:d2cd:7c2e])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4cb1176sm60118353f8f.3.2026.04.24.01.57.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Apr 2026 01:57:13 -0700 (PDT)
Date: Fri, 24 Apr 2026 09:57:11 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Elisey Konstantinov <elisey.konstantinov@gmail.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, marcandre.lureau@redhat.com,
 philmd@linaro.org
Subject: Re: [PATCH] build: prefer sigaltstack over ucontext on Linux
Message-ID: <aeswZxFn0zMj-3jb@redhat.com>
References: <616E96C0-F0A5-4A9E-A63B-3BC1B5F18094@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <616E96C0-F0A5-4A9E-A63B-3BC1B5F18094@gmail.com>
User-Agent: Mutt/2.3.1 (2026-03-20)
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Apr 24, 2026 at 11:19:39AM +0300, Elisey Konstantinov wrote:
> From 517099e65de1e2ad3d0f33d3c4a7a71f8728279c Mon Sep 17 00:00:00 2001
> From: Elisey <elisey.konstantinov@gmail.com>
> Date: Mon, 23 Mar 2026 16:02:45 +0100
> Subject: [PATCH] build: prefer sigaltstack over ucontext on Linux
> 
> sigaltstack coroutine backend is more stable on some Linux
> configurations, while ucontext causes boot failures for certain
> PPC Mac OS X guests (issue #3276).
> Select sigaltstack first when available, keeping ucontext as fallback
> until the underlying issue is resolved.

IMHO there needs to be a greater investigation in to why ucontext
would be demonstrating the failure. ucontext has been the default
on Linux for QEMU for decades without significant issues, so my
concern is that switching to sigaltstack is not fixing the root
cause of the bug you see, just masking it by luck.

The choice of coroutine backend can also be performance sensitive
and so changing it is something that would need to also bring
along performance benchmark data to illustrate the likely impact
of the change.

> 
> Signed-off-by: Elisey Konstantinov <elisey.konstantinov@gmail.com>
> ---
>  meson.build | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/meson.build b/meson.build
> index ab3e97eb9f..742655e007 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -505,10 +505,12 @@ if host_os == 'windows'
>  elif host_os == 'emscripten'
>    supported_backends += ['wasm']
>  else
> +  # FIXME: This is a temporary workaround!
> +  # SigAltStack is in higher priority to fix #3276
> +  supported_backends += ['sigaltstack']
>    if host_os != 'darwin' and cc.links(ucontext_probe)
>      supported_backends += ['ucontext']
>    endif
> -  supported_backends += ['sigaltstack']
>  endif
>  
>  if coroutine_backend == 'auto'
> -- 
> 2.50.1 (Apple Git-155)
> 


