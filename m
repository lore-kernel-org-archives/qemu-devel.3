Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B483C67861
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 08:49:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtkgL-0006M1-P2; Mon, 08 Apr 2024 04:48:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rtkgG-0006KS-JN
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 04:48:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rtkgF-0004nQ-77
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 04:48:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712566120;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ND5FlI9fsQJwt0gFcEjJWaPw0D03XZ9yWL2s5mnYVPc=;
 b=hQUrLWsUTXNnmlCp7vf14cgvkGn4+LvwSUHLEdmQq9IVDS2sQbS/g9QfL2LGFEs/6oe4hQ
 IXIK8CQFmCggAR4TshJvCq6+cf6CujjTxr2kSj3DzzXHc32ioSinCfVGFq2HoaMkQpt2vD
 rvOFp6EK/oX/FuCPKx3vCCK1KogJWKM=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-557--tH6eMqSP4q1UOKV01-JDQ-1; Mon, 08 Apr 2024 04:48:39 -0400
X-MC-Unique: -tH6eMqSP4q1UOKV01-JDQ-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-516c2460d95so3301597e87.0
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 01:48:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712566118; x=1713170918;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ND5FlI9fsQJwt0gFcEjJWaPw0D03XZ9yWL2s5mnYVPc=;
 b=VfqaeyMXj4p6eiGPqFb3lHhfSFuQoVjIflIIvkwtTHY24jpbooJWon/Aaai2YBCc/S
 e9nlXcbCOYgEy0a4gtI7d1uFi5zVqP7h9/1vPiBj8QEsbodXh0QtoyslShMg1DlofPKZ
 CB9dPgyQY3nX/VjAc1rOnhZjqH4uuS+57oQ9wPhrT8jfFwwp32rmNTZAC8BVIJIRqEC1
 GR+7xwDVQNSfbAPtgW1hiGU+3eblmikhIWmD2JzCo8rdQoQs6W52QwtRSIG319OlfzHD
 f+kEKwuBYoU8XTBRZkAeKsdEMDbNbQBJouSpEUFbuVP0XRy9FyxT/AeA3I9ozsUKJxDJ
 /3/A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVwyoxsIerdtqkxttE9fbK4veduB6aChkIA/iu+K0ayufS4PAfHJuPNoX1gg5ElIHl/2VxhFvmlksIcNAfT1KuXozubZ/U=
X-Gm-Message-State: AOJu0YywTwNZc3WBb5rE8GyCWSg/SQaBXg+Dqzix09sIcVxg6duk1hc4
 GpQLbPctU/BQloBKtImRd9jQ+2AZlOB2pQCQZ4aDbS3FZM0s+LNL0vT8v2v1N08Lgt97EOWuC7u
 h0tS4Ge36uMBfhqY1O0L6AlIZ6byj7DoqBbEyH5waCwq8Yz7bOVfLb5J8W1waplnm9lM2hMtB2G
 R/vua2OBuwTWXsPL6GFk4ixvlpShg=
X-Received: by 2002:ac2:5e8d:0:b0:515:bb3a:116a with SMTP id
 b13-20020ac25e8d000000b00515bb3a116amr5610392lfq.41.1712566118224; 
 Mon, 08 Apr 2024 01:48:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF6cTVTiSnO/NFPZV6ZyIXXllOo3FDM72xKrYLQx8d3vKgzxEtF5lqgXwJcjyW+Hz+yangiH/gAzEqa6FJIaXM=
X-Received: by 2002:ac2:5e8d:0:b0:515:bb3a:116a with SMTP id
 b13-20020ac25e8d000000b00515bb3a116amr5610375lfq.41.1712566117894; Mon, 08
 Apr 2024 01:48:37 -0700 (PDT)
MIME-Version: 1.0
References: <20240404194757.9343-1-philmd@linaro.org>
 <20240404194757.9343-3-philmd@linaro.org>
In-Reply-To: <20240404194757.9343-3-philmd@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 8 Apr 2024 10:48:26 +0200
Message-ID: <CABgObfYXdZw_G5OrV2iAWbhtkL7QrG=1vN=G7CEvwU-NT5NpHA@mail.gmail.com>
Subject: Re: [PATCH-for-9.1 2/7] yank: Restrict to system emulation
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>,
 qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.355,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Apr 4, 2024 at 9:48=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 <philmd@=
linaro.org> wrote:
>
> The yank feature is not used in user emulation.

But it is used in block layer tools. The simplest thing here is
probably to move it under have_block instead.

Paolo

> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  util/meson.build | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/util/meson.build b/util/meson.build
> index 0ef9886be0..247f55a80d 100644
> --- a/util/meson.build
> +++ b/util/meson.build
> @@ -60,7 +60,6 @@ util_ss.add(files('stats64.c'))
>  util_ss.add(files('systemd.c'))
>  util_ss.add(files('transactions.c'))
>  util_ss.add(files('guest-random.c'))
> -util_ss.add(files('yank.c'))
>  util_ss.add(files('int128.c'))
>  util_ss.add(files('memalign.c'))
>  util_ss.add(files('interval-tree.c'))
> @@ -76,6 +75,7 @@ if have_system
>    if host_os =3D=3D 'linux'
>      util_ss.add(files('userfaultfd.c'))
>    endif
> +  util_ss.add(files('yank.c'))
>  endif
>
>  if have_block or have_ga
> --
> 2.41.0
>


