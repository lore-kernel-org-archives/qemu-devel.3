Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64A9BFD706B
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 10:35:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2Rlm-0007aY-8p; Tue, 17 Mar 2026 06:35:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1w2Rlf-0007YR-HY
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 06:35:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1w2RlY-0002Bj-LZ
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 06:35:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773743709;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hjb9NaIh1ulItL7NW2nICIJ/KmSmuJnbtua3PtF+CQI=;
 b=ZOKAOTdb/Euk6XYEekKwjh5foQVtXse8i5kBQWv7OYkLnoCzb778izBbBZF92uRXbYWWZA
 Km0kCMmrWKYrNJCV5dOrHGYra7JyP8DKTJTDiheIFvp3GJ19Qsh4nJgOxBY5jfueK3c++C
 QPVRH71nuUHSqVtWdyyhxKryuBuTcgQ=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-110-X4h_Q4BeMd6D7YO3K9r3wQ-1; Tue, 17 Mar 2026 06:35:07 -0400
X-MC-Unique: X4h_Q4BeMd6D7YO3K9r3wQ-1
X-Mimecast-MFC-AGG-ID: X4h_Q4BeMd6D7YO3K9r3wQ_1773743707
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-c6e7f45e2ddso27784415a12.1
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 03:35:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773743706; cv=none;
 d=google.com; s=arc-20240605;
 b=hMf0+K6xJcodit35/6ZkdaubCTgf84oKFaeRmYgEXpGUjaKPcW7cSWy8TvOv6benXK
 emBcPdKW7outvYVK/MhHfaWO0VAO0YbOj0MMfdXNoMh8iJh92NW3UzLtP+gqTjLoFd2f
 sKL0SzEbfAOMRKTAcPsfUaov/8XcRzZEyhFafrz1COFsusG0FfZOqhsga40GIq1uEsA4
 +BoIAbXUobdz/VmAihwNChZNCjZOuWOzSlfcSIcGv0gLpRTPCPxMZSg+7mWyy3dJRHJK
 6fVfuKZHnRCrwApMFXEZYibCgQbroTqtQZJ9N2oUXcgyfLNqSoCJpHohvowLqcuXQzPL
 +J/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=hjb9NaIh1ulItL7NW2nICIJ/KmSmuJnbtua3PtF+CQI=;
 fh=xxmH1e9fzC3zx/hB6A+qdA2khXaTomf55pAESi9ViMA=;
 b=TvCpO+x08hiNb0ADFXbFMKliRUAP32L593XACU1A7h0+sVWM4PHVZbydVX31d0xrG4
 9qz7YYDcsJeIkciUw8eqmuuTWm3UfkeCPJvk31mQJM8vSd5SGBTW2IyLPoMKfZ/+UquN
 892n+HPXeEZkM/7Qmw02d5vyJC6GRgz7WSib6ew6QgRDPbZZSi1ZxSr6CBVeqyeyWuc2
 XGnFJR3ryr6AQxhf0q+PXDXQW9idYLugITHB9QQZm8hoD4Q4wVkfQJf+mFS5LNEV8pTc
 icA6WC6BgVqnWDCgbBEEsy8mvCkHkiLIKByik6HOK2+ipfqNf9sbuwIdi1+IJk5JBiUV
 i6EA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773743706; x=1774348506; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hjb9NaIh1ulItL7NW2nICIJ/KmSmuJnbtua3PtF+CQI=;
 b=ZkwCcTxst7ECj56kTRcsJZgxt+JUFNcaa5L5yPmpxeq3rGR9WLLbP4g++sdZsZZVXX
 igww0FgGD+FpDHR6XikIpYKyoJ4snT6ZzrLHlwtbms21v+5Vr8OY1VrBqmF8zAA7MJs4
 pthEdD+dXOYnqs4Oar39rBLzWPFHS1+5UIHGxPc/vv0dOgXrX9uBRwRJAOeb+G392Ns7
 vZxs/5DwxW+g52gLl5rJiwzoPy8rtnRZzA8QEoATmSwB1YRKAs9Ieo3PCuMy7X7GOXwo
 L5Gsc77daCyA4eJ6yhysZwjglaH4Q19yxxAVRWeXZtz9d1XXnLi7FW0pY4Dn8snalgJs
 YoXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773743706; x=1774348506;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hjb9NaIh1ulItL7NW2nICIJ/KmSmuJnbtua3PtF+CQI=;
 b=SeJmB8A07u/r6/pcC8C52Bj4ylOpAz7/3mVSrrzm+6ch8GKZDeCNUllW9Gw65FH+xD
 MpVz5MeFB/9rUyRqc/ejE/3Jm93X0Co2rJCDAy5oELwtd12TeZOX9CGTVOwpePPwqE6Y
 gj3VqGkSxWVi0I5vLIZXZg+cFBaesIn4BXbL5kk/zNyHM/DK/2xZCoVISnQa/k4I0usW
 75JrK8M6/Rmq0QFyRRPPY516MB53qGuqeGZwTaayFTOw7kMh/noBmA9aLzNeCb9zqV5I
 0sx6WsQyi1dnR8A+Buu8JfXcthz8deSLOWB6Zm1inq2JLyYr6s+KlwjBzg3FV2g8U3Er
 bsMw==
X-Gm-Message-State: AOJu0YwE3UqRbBi20tCWRLikCKH0812NzTRGiDwPnSZjQr0WBxj8tezL
 Ct33P0uKhRIFCKrj+HIY98lBXFaojwH/EdjZBC2qLge7DaliYIsx2AT1kau6BRY34QEbhqOFhCS
 AmiRj93efYZjpRs3uXB6HXYYp/nCSudcoUlpGq8nJvNxwt7VjIxm5fOTxUK00m8Rt1/GhhROlUW
 J8ia/yMRaiKZwu2H2RF3FlxKni5Kbwce9S3zWt2+c=
X-Gm-Gg: ATEYQzz5jPe0V5V6ghoWwV8huoe7E8IZz29IUMPTNpD4DCuQhvh8FO99EI6bA+pa9rO
 vStj8LGZOEX7wnyxKJumDTIJpfvr0pu4iVy5yDAck88oi0+MWXFYH7QQtR1UYt0pAlr3n3PdA32
 A+E+oSwA4S7ic94XOhnTsofY2DZpxTgwJy934MDeG08dY3JcD7xbVODfUqPp74dvVsO7zRebTFf
 BKyqDshI+SyJl6YBISqz0N2UcgydNP/a9clAdpX/a5SrOqOVAyqonHm1DEeqBuPEeHDCWB+TmdC
 JulZL8nurZTU6wmvJqqBByk=
X-Received: by 2002:a05:6a21:481:b0:398:7d6e:27f4 with SMTP id
 adf61e73a8af0-398ec9bb79emr15876230637.1.1773743705903; 
 Tue, 17 Mar 2026 03:35:05 -0700 (PDT)
X-Received: by 2002:a05:6a21:481:b0:398:7d6e:27f4 with SMTP id
 adf61e73a8af0-398ec9bb79emr15876209637.1.1773743705514; Tue, 17 Mar 2026
 03:35:05 -0700 (PDT)
MIME-Version: 1.0
References: <20260211103305.3112657-1-marcandre.lureau@redhat.com>
In-Reply-To: <20260211103305.3112657-1-marcandre.lureau@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Tue, 17 Mar 2026 14:34:54 +0400
X-Gm-Features: AaiRm50e8SJtZc01yyclZeYIN5yLUJA6H_i2UTLtbVlAkkvPwQwlEauJ2duSOPA
Message-ID: <CAMxuvaxBZXO0V3cW0tNTpU44jbMsUroHQf=aSjgN8V6QbeATog@mail.gmail.com>
Subject: Re: [PATCH] build-sys: use the "run" variable
To: qemu-devel@nongnu.org, "P. Berrange, Daniel" <berrange@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Wed, Feb 11, 2026 at 2:33=E2=80=AFPM <marcandre.lureau@redhat.com> wrote=
:
>
> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> Avoid unused variables and hand-written path, this should also help meson
> to figure out the relation between the commands.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

ping

> ---
>  meson.build | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/meson.build b/meson.build
> index 38ad6820f3e..e2aa90a43de 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -3473,7 +3473,7 @@ run_config =3D configuration_data({'build_dir': mes=
on.current_build_dir()})
>  run =3D configure_file(input: 'run.in',
>                       output: 'run',
>                       configuration: run_config)
> -run_command('chmod', 'a+x', meson.current_build_dir() / 'run', check: tr=
ue)
> +run_command('chmod', 'a+x', run, check: true)
>
>  hxtool =3D find_program('scripts/hxtool')
>  shaderinclude =3D find_program('scripts/shaderinclude.py')
> --
> 2.52.0
>


