Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF637C25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2024 06:31:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCZIz-0005h5-Kh; Thu, 30 May 2024 02:30:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sCZIs-0005g3-9q
 for qemu-devel@nongnu.org; Thu, 30 May 2024 02:30:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sCZIp-00069G-3V
 for qemu-devel@nongnu.org; Thu, 30 May 2024 02:30:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717050618;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kXJsfhEkstTOCbv2ax01eKLPyF0+1i1kxbvZm3TO1b4=;
 b=jNV1mgQG79dWjTN7HNu3ikpdayzWexIY6Gz1ec3tovQlu1RL40o2dQ1UlbpGEvELZMCQ0Q
 SxRJejsL5F7MMLlMCIr54NT9CIRdExGPG4lJVSQPt8D02SNj6SP0ObprF6JEdTUMU72aIX
 6UyithjOb9d2fGtBnZeQPV/2iJn6eSk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-eHIaNq8JMnCJioQ-X8McGQ-1; Thu, 30 May 2024 02:30:16 -0400
X-MC-Unique: eHIaNq8JMnCJioQ-X8McGQ-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-35dcb9dcc3bso89271f8f.0
 for <qemu-devel@nongnu.org>; Wed, 29 May 2024 23:30:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717050615; x=1717655415;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kXJsfhEkstTOCbv2ax01eKLPyF0+1i1kxbvZm3TO1b4=;
 b=gfJdI11Smhcv34+fko9bDJLr2kygnDDWFwwn4LEHB2xPpmYXu8xGtl9N0Z3M6ppEsU
 u3aI6YKvLKmWZtSiEj0auaVGjjGUBik4WhvIPvMeOdsHWLsKlci2sjCbnUGdsygNVPTf
 ytFVq63Lib0iu/KpdKA464EXL/H43jOW4rxjFfC9wDBeX7NQ5tqMuaAkUtWgk2qOo1l2
 sqXfhnpGLZ9YOJASulOc99J5w4fNqeCaTyosMsGFEEOjNkTiHkaAezbgMKwTMZe97NEQ
 JE+FsuQ6ErnT4u6B6HwOjLfrBYRwcByt0/Ql3cNxao8+hCe1DNNZcE9NIGfisfxqvjhj
 xnpg==
X-Gm-Message-State: AOJu0Yz7kv/HQLQKdL1LCq9jqEoOTKhaR58r/BJefr+Hz52kISGuuJc5
 H2SOjq3EDl7qHRIrhSfXOie3Vg/jGR8dxwCnDLDEToeUNwRT4pJOVFyS0gxtCaQ5OdmOLfkBiXW
 mHNCbvIm4Yt0bcH5IqRrI6P6JJ5c9ovTvonejLqDHUwIbpXhQtk3d/DAZfqR71SKY64h8RJFPqv
 4WfJPBv6wKj4tzJENh/dsI1QSkqmM=
X-Received: by 2002:a5d:4dd0:0:b0:355:302:464d with SMTP id
 ffacd0b85a97d-35dc00348d2mr751436f8f.0.1717050615143; 
 Wed, 29 May 2024 23:30:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IECU+e+rmyVg+3c9eX2q70dXTEO/g/bjsWYNcawPKtieWAlqSofw3SDJMHk4lJQR6I+6t7zyUWdHOMvwkLIUG0=
X-Received: by 2002:a5d:4dd0:0:b0:355:302:464d with SMTP id
 ffacd0b85a97d-35dc00348d2mr751419f8f.0.1717050614744; Wed, 29 May 2024
 23:30:14 -0700 (PDT)
MIME-Version: 1.0
References: <20240516222047.1853459-1-pierrick.bouvier@linaro.org>
 <20240516222047.1853459-2-pierrick.bouvier@linaro.org>
In-Reply-To: <20240516222047.1853459-2-pierrick.bouvier@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 30 May 2024 08:30:02 +0200
Message-ID: <CABgObfaT-bj1=zVoWy8MqFPsBkAx27GiEjkVRx__7iJwdYCfEA@mail.gmail.com>
Subject: Re: [PATCH 1/5] sysemu: add set_virtual_time to accel ops
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, 
 Laurent Vivier <lvivier@redhat.com>, Mahmoud Mandour <ma.mandourr@gmail.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Alexandre Iooss <erdnaxe@crans.org>,
 Richard Henderson <richard.henderson@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.036,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Fri, May 17, 2024 at 12:21=E2=80=AFAM Pierrick Bouvier
<pierrick.bouvier@linaro.org> wrote:
> diff --git a/stubs/meson.build b/stubs/meson.build
> index 3b9d42023cb..672213b7482 100644
> --- a/stubs/meson.build
> +++ b/stubs/meson.build
> @@ -3,6 +3,11 @@
>  # below, so that it is clear who needs the stubbed functionality.
>
>  stub_ss.add(files('cpu-get-clock.c'))
> +stub_ss.add(files('cpus-virtual-clock.c'))
> +stub_ss.add(files('qemu-timer-notify-cb.c'))
> +stub_ss.add(files('icount.c'))
> +stub_ss.add(files('dump.c'))
> +stub_ss.add(files('error-printf.c'))

Was there a problem when rebasing?

Paolo

>  stub_ss.add(files('fdset.c'))
>  stub_ss.add(files('iothread-lock.c'))
>  stub_ss.add(files('is-daemonized.c'))
> @@ -28,7 +33,6 @@ endif
>  if have_block or have_ga
>    stub_ss.add(files('replay-tools.c'))
>    # stubs for hooks in util/main-loop.c, util/async.c etc.
> -  stub_ss.add(files('cpus-get-virtual-clock.c'))
>    stub_ss.add(files('icount.c'))
>    stub_ss.add(files('graph-lock.c'))
>    if linux_io_uring.found()
> --
> 2.39.2
>


