Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E59D9C49EA1
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2024 13:42:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbKRt-0000Oj-Sk; Tue, 06 Aug 2024 09:42:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sbKRn-0008To-Cy
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 09:41:56 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sbKRj-0007Ri-OZ
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 09:41:54 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-36844375001so456314f8f.0
 for <qemu-devel@nongnu.org>; Tue, 06 Aug 2024 06:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722951693; x=1723556493; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=msZtnSmF3dWc09JBpAtd+cbSztTV+IpRRcfZ2D2fbPA=;
 b=CGXxG6qir1WgJUVeBZkboYYtYlis39IqDGRrJ/zLrxmlxhSMjgPI9fPjLX3YWxOG0Z
 33uvwNTy3UPD1wG6x/YonmcxABhSoClpE4mIEnDv6Dz39AIG+yEaMedLONQNf3GJhxHx
 NPTiP6WXmZ3+CDbDprhj9qK4mFmuxz0rJnivyca8NtjS4YqaYMC4ApD75TeiVQEqJFOM
 c5nQsakdXK2LTqN3w1XvnMLCm/AXB5YmiQT3dRAfXefTolB8NpQixUyMimoiJP+qYt0v
 7jZ3wvSZnKV5GG54kWm3QPwy3Wqp6TsNWv0mxF/jDNSQSCHe7N0Ms8JywcaKZ07gVevl
 DAnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722951693; x=1723556493;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=msZtnSmF3dWc09JBpAtd+cbSztTV+IpRRcfZ2D2fbPA=;
 b=fs/3vSrz6wlat090Aq2bRsHLiESMnjQ3MYJ3cg0sCsmGAvevYvuIJf0OMb2PovOst4
 K2o88XkEORYYR/rpYfjd5o/jOsjyA23N+F2NcoZ+5T4eky7PQIgBLhXyvuiiPihAZb7R
 u/as25p4Nkfm5wBw17AlxyclFfbuW1ie8r8YMJJinX3gJiC9wCkTB8Sg+qCx/b/M1Xmn
 LaS/2S+QAngt0WXajKhfA4PJ/hIQW/EHd9lJCEbs+2imQ0Ohwsbb0d/FTRxeieTgTfJW
 /8L+RJ5A9yz3AMI3/VNBbfgveOssRtK4kJKsQ8+nkNQmADCqHJFh70MDqT0paM78UD8i
 Gw2A==
X-Gm-Message-State: AOJu0Yy6jR1KGsXd71SoXOqSy6v9DvpuZjcMXI91IcvFCBTziMsAt8DN
 ur/FqhEy66ezV/bZfYZqgju9RUDihDSe1cEGqAog4+MxinHPxsLmrcQosTBR73s=
X-Google-Smtp-Source: AGHT+IGNZSDQqFwzp1/MNvGYPNvBVnCNYWhyMn5keuTR5PV8UtmrDOK8rgO5ogBHBOKLxNLZ8ymx5Q==
X-Received: by 2002:a5d:6d8a:0:b0:368:7943:146f with SMTP id
 ffacd0b85a97d-36bbc0e6aecmr13158774f8f.26.1722951692986; 
 Tue, 06 Aug 2024 06:41:32 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36bbd06d314sm13054207f8f.95.2024.08.06.06.41.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Aug 2024 06:41:32 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 7C2425F77B;
 Tue,  6 Aug 2024 14:41:31 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org,  "Michael S. Tsirkin" <mst@redhat.com>,  Paolo
 Bonzini <pbonzini@redhat.com>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>
Subject: Re: [PATCH 2/3] system/vl.c: Expand OpenGL related errors
In-Reply-To: <20240731154136.3494621-3-peter.maydell@linaro.org> (Peter
 Maydell's message of "Wed, 31 Jul 2024 16:41:35 +0100")
References: <20240731154136.3494621-1-peter.maydell@linaro.org>
 <20240731154136.3494621-3-peter.maydell@linaro.org>
Date: Tue, 06 Aug 2024 14:41:31 +0100
Message-ID: <871q31sr90.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Peter Maydell <peter.maydell@linaro.org> writes:

> Expand the OpenGL related error messages we produce for various
> "OpenGL not present/not supported" cases, to hopefully guide the
> user towards how to fix things.
>
> Now if the user tries to enable GL on a backend that doesn't
> support it the error message is a bit more precise:
>
> $ qemu-system-aarch64 -M virt -device virtio-gpu-gl -display curses,gl=3D=
on
> qemu-system-aarch64: OpenGL is not supported by display backend 'curses'
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  system/vl.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/system/vl.c b/system/vl.c
> index 9e8f16f1551..213ee6a6a92 100644
> --- a/system/vl.c
> +++ b/system/vl.c
> @@ -1973,9 +1973,10 @@ static void qemu_create_early_backends(void)
>=20=20
>      if (dpy.has_gl && dpy.gl !=3D DISPLAYGL_MODE_OFF && display_opengl =
=3D=3D 0) {
>  #if defined(CONFIG_OPENGL)
> -        error_report("OpenGL is not supported by the display");
> +        error_report("OpenGL is not supported by display backend '%s'",
> +                     DisplayType_str(dpy.type));
>  #else
> -        error_report("OpenGL support is disabled");
> +        error_report("OpenGL support was disabled when QEMU was
>      compiled");

Maybe "OpenGL support was not enabled in this build of QEMU"?

Anyway:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>



>  #endif
>          exit(1);
>      }

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

