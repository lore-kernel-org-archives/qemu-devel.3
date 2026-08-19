Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FB2BC5B572
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 14:30:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwhIK-0001dm-M5; Wed, 19 Aug 2026 10:29:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wwhII-0001da-TJ
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 10:29:30 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wwhIH-0002Ej-AA
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 10:29:30 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-47ddf7b09e5so1098395f8f.1
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 07:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787149767; x=1787754567; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Jz2urDQupLP2gHwhwqjqXjL4ynoQvK67hQOGc7wyPIY=;
 b=T6BHaxBAHw/CL1b2rR/SZny59F0FlrjTnLr4g5wwVQUAjrXgkbuC7G28n0I9rU/zIJ
 axSE8bhLWSzxzrDl0zNfmzSgQLeH0PuRff7ticYMHijqGOGsknUABkJS0ANB6qqUpNVS
 XC75YyZ2CS2jYfzRQdS1I8plYNlUy/AA0h5xDyz+mS/svyIHJdUJB/coCP7+xKHn59te
 JotJjzQdZZlVrtQbMJvsmCySQDQK9VHzecUfPqmtlPAe+tKaTwZ+lMsssXGlYWVXaAgQ
 KbfjtD9u9yT2EhLMi8q29nhmUcr+rv+mr4qJtRDgaDL/5vZ4I7rtAchK3LmopTWX3NBW
 cT6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787149767; x=1787754567;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Jz2urDQupLP2gHwhwqjqXjL4ynoQvK67hQOGc7wyPIY=;
 b=i/Cm0Ta6utwH7d+ufvyxqrGKJP5sXi2OoWsraUEz5OZ8YhlN23cU0sWomYEBWOPpHg
 2HN8vdisvVzP6WfaQ7XXLWmHIaXbR4TrH3JW8cH9BTZ5WAQ9PrT9SWhhfFXMMCW5KGf+
 F/8OrtV6DQiTQyrm7M6GQYbmq5dxdY3X12vcPpYLNeB2Wu0aq3u3aWedh/joSVnChCEI
 NKHHWPTaZZ7qA3vERHup8oKStgz1jX9XqOcJWN8Wl/HEfWBNrXNsl0cNqKWFHqERo7pW
 vJjKlG8oLlfCC6sRxR0NT16beR4N72qvMaU8jo+uB8bAcEMY+4gNRJ5tB/fEA6pTgvFc
 jE9Q==
X-Gm-Message-State: AOJu0YwpK1pcILgx9mL8VKMHtUej5tGGCAfcnss5WVNv+Fj9VCIgeTxI
 Sm9zMXP0Kl7gFeVW9Wq4ZtS0HIJ6RfBNfI8SxNAH7dmMo4i8cE9bCAMXyBYd/RYaXQ0=
X-Gm-Gg: AR+sD12N1u5VIm/e1Zuy8Ux8c7prKetWTJ0XRKb3JZvlS1d2bWSJzVDYtKx46KDdBbR
 WnouYfio/4etBCQrS2PIZeSBXIwUNvcqP7tA137NAs5/B/Ey3DiEJM5TGc8Y87znIIljzJuW2QD
 bgNc221fz5kiG+3DPfOBrk/K7QKOO5PS0zE4PKElr9R6cVDqSBZR1sZCCs/58CKfvE7WA7lEBTr
 S8tjJYKiG1USxuSgRr5LjJ/X88jioWHeggcET3YNlqmXfTdzPRsL08eVzjW2O0/h57lq1n3EknH
 7llEwT6lG1ddYWeFsdSPC37SvclJJDs3/fKA7xQ68RGvLJ56gLu2/YOWfmpUu6i2N8p1IiK0Ow+
 uWBtwLfzGEQonoPo5BGVNUY8piCHoOdjGp+nSyDz69MdKdDxjrzqEHf2glN4uTf3vfTAdPYPz9G
 dnX5OL8VgUUm6HiZKP2pfCUZ98vFIUg3DHT53Esi9wWz0B6ne2/b0liEvQrtRg
X-Received: by 2002:a05:600c:19c7:b0:495:7a04:b006 with SMTP id
 5b1f17b1804b1-499aa192422mr76486855e9.8.1787149767233; 
 Wed, 19 Aug 2026 07:29:27 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499aa0fd7a9sm80746405e9.2.2026.08.19.07.29.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 07:29:25 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 231385F805;
 Wed, 19 Aug 2026 15:29:24 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org,  Thomas Huth <thuth@redhat.com>,  Laurent Vivier
 <laurent@vivier.eu>,  Richard Henderson <richard.henderson@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,  Helge
 Deller <deller@gmx.de>,  Paolo Bonzini <pbonzini@redhat.com>,  Brian Cain
 <brian.cain@oss.qualcomm.com>,  Manos Pitsidianakis
 <manos.pitsidianakis@linaro.org>,  Peter Maydell
 <peter.maydell@linaro.org>,  Ilya Leoshkevich <iii@linux.ibm.com>
Subject: Re: [PATCH v7 031/104] tests/tcg/meson.build: use full path for
 QEMU binary
In-Reply-To: <20260818192309.22169-32-pierrick.bouvier@oss.qualcomm.com>
 (Pierrick Bouvier's message of "Tue, 18 Aug 2026 19:21:55 +0000")
References: <20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com>
 <20260818192309.22169-32-pierrick.bouvier@oss.qualcomm.com>
User-Agent: mu4e 1.14.3; emacs 30.1
Date: Wed, 19 Aug 2026 15:29:24 +0100
Message-ID: <874igqqj3v.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42c.google.com
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

Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:

> On MacOS, meson does not find qemu binary. Use full path to fix it.
> Also, add qemu binary as dependency for the test, to ensure it's built
> automatically.
>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>  tests/tcg/meson.build | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
> index ea17a947628..fe382638297 100644
> --- a/tests/tcg/meson.build
> +++ b/tests/tcg/meson.build
> @@ -323,12 +323,13 @@ foreach target, plan: tcg_tests
>        endif
>=20=20
>        exe =3D built_tests[exe_name]
> -      cmd =3D [qemu, qemu_args, exe]
> +      test_depends +=3D qemu
> +      cmd =3D [qemu.full_path(), qemu_args, exe]
>=20=20
>        if 'gdb_test' in setup
>          cmd =3D [prog_gdb_test,
>                 '--gdb', gdb,
> -               '--qemu', qemu,
> +               '--qemu', qemu.full_path(),
>                 '--qargs', ' '.join(qemu_args),
>                 '--bin', exe,
>                 setup['gdb_test'],

I think I've mentioned this before but the setting of cmd and then
resetting it reads weirdly. Especially as later we do have cases of
prefacing cmd with more stuff.

Anyway:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

